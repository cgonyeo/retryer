import System.Process
import System.Environment
import Options.Applicative
import Data.Monoid
import System.Exit
import Control.Concurrent

data Flags = Flags { tries :: Int
                   , delay :: Double
                   , command :: [String]
                   } deriving(Show,Eq)

flgparse :: Parser Flags
flgparse = Flags
    <$> option auto
        (  long "tries"
        <> short 't'
        <> metavar "<int>"
        <> help "Number of times to retry the command. <= 0 disables."
        )
    <*> option auto
        (  long "delay"
        <> short 'd'
        <> metavar "<double>"
        <> help "Seconds to wait before retrying the command. <= 0 disables."
        )
    <*> some (argument str (metavar "-- Command"))

main :: IO ()
main = execParser opts >>= run
    where opts = info (helper <*> flgparse) mempty

run :: Flags -> IO ()
run (Flags t d (c:a)) = do
        exit <- waitForProcess =<< (runCommand $ foldl ((++).(++ " ")) c a)
        case exit of
            ExitSuccess   -> exitSuccess
            ExitFailure _ -> do threadDelay (truncate $ 10^6 * d)
                                if t == 1
                                    then exitFailure
                                    else run (Flags (t-1) d (c:a))
