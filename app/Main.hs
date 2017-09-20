{-# LANGUAGE OverloadedStrings #-}
module Main where

import Network.Google
import Network.Google.Gmail
import Network.Google.Resource.Gmail.Users.Messages.List
import Control.Lens           ((.~), (<&>))
import Data.Text              (Text)
import System.IO              (stdout)

main :: IO ()
main = do
    emails <- emailList
    print emails

emailList :: IO (Rs UsersMessagesGet)
emailList = do
    lgr <- newLogger Debug stdout
    env <- newEnv <&> (envLogger .~ lgr) . (envScopes .~ mailGoogleComScope)
    runResourceT . runGoogle env $
        send (usersMessagesGet "15e9d5f2383de07f")
