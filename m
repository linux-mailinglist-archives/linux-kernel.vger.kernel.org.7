Return-Path: <linux-kernel+bounces-582254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B95A76B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 17:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096BF188511A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 15:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BF821C17B;
	Mon, 31 Mar 2025 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgfba1kX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36611DF748;
	Mon, 31 Mar 2025 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743435383; cv=none; b=Dd9x6nKnivkH06ujaehOFuQxDjL5TDIGEaI851pFmWcliYNPbCNTCcaGGvujwE0dHvgFTEbfb2fJc59DGF943xdMSKtpjMNF00KUXwomBGNkxrqwJV0OoQ8Kjw1apndm86lqFcO7cMnp1l1M4bbKS4kEM4+l4jxb1v6yAhXmKPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743435383; c=relaxed/simple;
	bh=YlR+7DZPYbjUOS68Y1FmZfuh7SzIWDUt5/smSPPrkbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zu7iuYtRcik24f4UaF4ANdfERnam9bFDcOMk4GN2J3/5nSFphAnFVBJUbMCEbEzXYqWnNBvNiW5ehDRzDRuNZ5ktAayTL0KKmOErkI2jAZ35po2znyDUIHM2O4H/Kh4e7v7CSaJfRItKEIhOTBZvv1B4Jlb6AxdcnjdFoc3iC7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgfba1kX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D39C4CEE3;
	Mon, 31 Mar 2025 15:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743435383;
	bh=YlR+7DZPYbjUOS68Y1FmZfuh7SzIWDUt5/smSPPrkbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hgfba1kXskvXFnp87he1dhBAHazzlNMOo8pjN27LI15oQqBt0W6cMPxYQml/RI/dj
	 NJLhSCv9Pa+V3nwFsqz3rcIgJLDto8D6jNQ6N67dJIpIjKADPD2Yg5ZDwrKkYx3hYN
	 E+3POKRe+Q1LG4/GA3sgXOHrWadx3BPsJNSABC3GJgUFu0hwd7cwApHUsoAyzkpriS
	 1/vp+Zcjz0959cAo8wkwIa6uup296IutA2WP4mf8nKJE6ZbkDdFf7MoH53GAkZ8gFb
	 arQogX6keGH2TaR2SD4aAjVUVEEKl2DwYIcdLepE2E1h6z0yuNN+/jbbKKGdBWy5bX
	 o1vCgFfw1lSYQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] selftests: tracing: Enable fprobe events before checking enable_functions
Date: Tue,  1 Apr 2025 00:36:20 +0900
Message-ID: <174343538009.843280.6583146613234713007.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <174343532655.843280.15317319860632975273.stgit@devnote2>
References: <174343532655.843280.15317319860632975273.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since the fprobe is not registered before enabling the fprobe events,
enable_functions is also empty before enabling it. Thus the tests
which checking enable_functions must ensure the event is enabled before
testing the enable_functions.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |   30 +++++++++++++-------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
index 73f6c6fcecab..2506f464811b 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
@@ -16,6 +16,18 @@ ocnt=`cat enabled_functions | wc -l`
 
 echo "f:myevent1 $PLACE" >> dynamic_events
 
+echo "f:myevent2 $PLACE%return" >> dynamic_events
+
+# add another event
+echo "f:myevent3 $PLACE2" >> dynamic_events
+
+grep -q myevent1 dynamic_events
+grep -q myevent2 dynamic_events
+grep -q myevent3 dynamic_events
+test -d events/fprobes/myevent1
+test -d events/fprobes/myevent2
+
+echo 1 > events/fprobes/myevent1/enable
 # Make sure the event is attached and is the only one
 grep -q $PLACE enabled_functions
 cnt=`cat enabled_functions | wc -l`
@@ -23,29 +35,22 @@ if [ $cnt -ne $((ocnt + 1)) ]; then
 	exit_fail
 fi
 
-echo "f:myevent2 $PLACE%return" >> dynamic_events
-
+echo 1 > events/fprobes/myevent2/enable
 # It should till be the only attached function
 cnt=`cat enabled_functions | wc -l`
 if [ $cnt -ne $((ocnt + 1)) ]; then
 	exit_fail
 fi
 
-# add another event
-echo "f:myevent3 $PLACE2" >> dynamic_events
-
+echo 1 > events/fprobes/myevent3/enable
+# If the function is different, the attached function should be increased
 grep -q $PLACE2 enabled_functions
 cnt=`cat enabled_functions | wc -l`
 if [ $cnt -ne $((ocnt + 2)) ]; then
 	exit_fail
 fi
 
-grep -q myevent1 dynamic_events
-grep -q myevent2 dynamic_events
-grep -q myevent3 dynamic_events
-test -d events/fprobes/myevent1
-test -d events/fprobes/myevent2
-
+echo 0 > events/fprobes/myevent2/enable
 echo "-:myevent2" >> dynamic_events
 
 grep -q myevent1 dynamic_events
@@ -57,6 +62,7 @@ if [ $cnt -ne $((ocnt + 2)) ]; then
 	exit_fail
 fi
 
+echo 0 > events/fprobes/enable
 echo > dynamic_events
 
 # Should have none left
@@ -67,12 +73,14 @@ fi
 
 echo "f:myevent4 $PLACE" >> dynamic_events
 
+echo 1 > events/fprobes/myevent4/enable
 # Should only have one enabled
 cnt=`cat enabled_functions | wc -l`
 if [ $cnt -ne $((ocnt + 1)) ]; then
 	exit_fail
 fi
 
+echo 0 > events/fprobes/enable
 echo > dynamic_events
 
 # Should have none left


