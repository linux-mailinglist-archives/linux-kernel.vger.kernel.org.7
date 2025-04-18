Return-Path: <linux-kernel+bounces-610077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33ED8A93003
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 04:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870E58A4AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 02:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95510267B07;
	Fri, 18 Apr 2025 02:33:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA824B26;
	Fri, 18 Apr 2025 02:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744943606; cv=none; b=qlMl/uUiXV/hgTuNl0S0lquVblonJC6yvITKZSKSBVQCOj2LwL/d0C29AKDbrJvgSQaUYbqBqhsZB9ffPa9BKw/wqSRx3lhA+hJ8glo6UUPW0mbbWG66M87YKAcvsG0rw5+GvgkBJqdyLKOuUU+40ihdfEL5fkt6lPu85mRWJTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744943606; c=relaxed/simple;
	bh=vdoD8mAekMk2DLn46rTvueCQQJNuDdSYh73OMRSjfTU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=thINpu4TgCHp+SGUoV0dCE7u5sWIHTA6vIdjjRaMk495A6N23rHcHKnfvhd5DM9/P/UVYrnCJGIurrzKgyUQiepgK5EXgHHm7smI2duWJgBigY5OBeu/fbRGKHJBBLyKuVlDYwIJl54Xg6T4NmMzKGRrYSyCT9G19MZumDkrYhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73717C4CEE4;
	Fri, 18 Apr 2025 02:33:24 +0000 (UTC)
Date: Thu, 17 Apr 2025 22:33:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kselftest@vger.kernel.org
Subject: [PATCH] tracing: selftests: Add testing a user string to filters
Message-ID: <20250417223323.3edb4f6c@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

Running the following commands was broken:

  # cd /sys/kernel/tracing
  # echo "filename.ustring ~ \"/proc*\"" > events/syscalls/sys_enter_openat/filter
  # echo 1 > events/syscalls/sys_enter_openat/enable
  # ls /proc/$$/maps
  # cat trace

And would produce nothing when it should have produced something like:

      ls-1192    [007] .....  8169.828333: sys_openat(dfd: ffffffffffffff9c, filename: 7efc18359904, flags: 80000, mode: 0)

Add a test to check this case so that it will be caught if it breaks
again.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Shuah, I'm Cc'ing you on this for your information, but I'll take it
through my tree as it will be attached with the fix, as it will fail
without it.

 .../test.d/filter/event-filter-function.tc    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc b/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
index 118247b8dd84..ab449a2cea8c 100644
--- a/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
+++ b/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
@@ -80,6 +80,25 @@ if [ $misscnt -gt 0 ]; then
 	exit_fail
 fi
 
+# Check strings too
+if [ -f events/syscalls/sys_enter_openat/filter ]; then
+	echo "filename.ustring ~ \"*test.d*\"" > events/syscalls/sys_enter_openat/filter
+	echo 1 > events/syscalls/sys_enter_openat/enable
+	echo 1 > tracing_on
+	ls /bin/sh
+	nocnt=`grep openat trace | wc -l`
+	ls $TEST_DIR
+	echo 0 > tracing_on
+	hitcnt=`grep openat trace | wc -l`;
+	echo 0 > events/syscalls/sys_enter_openat/enable
+	if [ $nocnt -gt 0 ]; then
+		exit_fail
+	fi
+	if [ $hitcnt -eq 0 ]; then
+		exit_fail
+	fi
+fi
+
 reset_events_filter
 
 exit 0
-- 
2.47.2


