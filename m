Return-Path: <linux-kernel+bounces-739968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C85E0B0CD9C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3A8173CAF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF47256C8D;
	Mon, 21 Jul 2025 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDR3vlsF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1971246765
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139512; cv=none; b=b8DFE+O7ms+/YeOf1H3c8X16NyvMyH+CQ2u4emCuZk+z+I6sny5fgtl2YMtSqMh2Pqr2ryRi+Yr3V+kzgplqRL5RQyN03FQeRzR8nRMxLHUWg/7FEld/y/mh80XkHylnAcgJCdCIcfoT1uH1N3Lms16XDTKB9Pemc4SGRGEGkJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139512; c=relaxed/simple;
	bh=2pvlYDJEhHosA2vowv9pF0qgZPub8/fruDvRAfVsBDc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hDqq2u4sHlxbEPXgRLhWj/Ii3uguwgxODnnftSJ7cc6/b/VDbarZiMd4pfFWCoSYvXQvUGZB7/brotiIg2MSqWis4zMNHMU65dff1bxjG/VAO9oW2vHRvdB7TqANvWgGwpSFKJSCK/6U1gEsKICbxLovlzegbNmMMXvpjj9kwqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDR3vlsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E938C4CEED;
	Mon, 21 Jul 2025 23:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753139512;
	bh=2pvlYDJEhHosA2vowv9pF0qgZPub8/fruDvRAfVsBDc=;
	h=Date:From:To:Cc:Subject:References:From;
	b=MDR3vlsFKBdMMFkYGCXVF6viTh44M5mKLAt9tckSdYc6NGFFSxH+XD1vtgh/4TBXy
	 MPrLLsduKAQeum7P6psXqaT5q9eAaN5U4TuN09dB9eLsL8WNO++s0f6RdcnGYAiNYs
	 93Aiz1+HhZEU8znQBfdNDFoe8OKPpORIuNJyxg1wAcXpG9wxuaVgH574rPzPtommqO
	 8cA7U18HTUrbXMR1MUalV33/ALoXmw9N7Dg46gQMYM1d231/ly5RP/5EekfO1kqkfr
	 HPKtQeGw//mdC3KKvOtTtLoCrrFWx58bSnRoEVwc4ePLQuJTQfkTPY/hvVt5CYYYol
	 6WvZS58b3ELWQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1udzgF-00000009vLK-3H9c;
	Mon, 21 Jul 2025 19:12:23 -0400
Message-ID: <20250721231223.629654352@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 21 Jul 2025 19:12:13 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Chang Yin <cyin@redhat.com>,
 Costa Shulyupin <costa.shul@redhat.com>,
 Crystal Wood <crwood@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 9/9] Documentation/rtla: Add actions feature
References: <20250721231204.100737734@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

Document both --on-threshold and --on-end, with examples.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Chang Yin <cyin@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lore.kernel.org/20250626123405.1496931-10-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../tools/rtla/common_timerlat_options.rst    | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.rst
index 10dc802f8d65..7854368f1827 100644
--- a/Documentation/tools/rtla/common_timerlat_options.rst
+++ b/Documentation/tools/rtla/common_timerlat_options.rst
@@ -55,3 +55,67 @@
         Set timerlat to run without workload, waiting for the user to dispatch a per-cpu
         task that waits for a new period on the tracing/osnoise/per_cpu/cpu$ID/timerlat_fd.
         See linux/tools/rtla/sample/timerlat_load.py for an example of user-load code.
+
+**--on-threshold** *action*
+
+        Defines an action to be executed when tracing is stopped on a latency threshold
+        specified by **-i/--irq** or **-T/--thread**.
+
+        Multiple --on-threshold actions may be specified, and they will be executed in
+        the order they are provided. If any action fails, subsequent actions in the list
+        will not be executed.
+
+        Supported actions are:
+
+        - *trace[,file=<filename>]*
+
+          Saves trace output, optionally taking a filename. Alternative to -t/--trace.
+          Note that nlike -t/--trace, specifying this multiple times will result in
+          the trace being saved multiple times.
+
+        - *signal,num=<sig>,pid=<pid>*
+
+          Sends signal to process. "parent" might be specified in place of pid to target
+          the parent process of rtla.
+
+        - *shell,command=<command>*
+
+          Execute shell command.
+
+        - *continue*
+
+          Continue tracing after actions are executed instead of stopping.
+
+        Example:
+
+        $ rtla timerlat -T 20 --on-threshold trace
+        --on-threshold shell,command="grep ipi_send timerlat_trace.txt"
+        --on-threshold signal,num=2,pid=parent
+
+        This will save a trace with the default filename "timerlat_trace.txt", print its
+        lines that contain the text "ipi_send" on standard output, and send signal 2
+        (SIGINT) to the parent process.
+
+        Performance Considerations:
+
+        For time-sensitive actions, it is recommended to run **rtla timerlat** with BPF
+        support and RT priority. Note that due to implementational limitations, actions
+        might be delayed up to one second after tracing is stopped if BPF mode is not
+        available or disabled.
+
+**--on-end** *action*
+
+        Defines an action to be executed at the end of **rtla timerlat** tracing.
+
+        Multiple --on-end actions can be specified, and they will be executed in the order
+        they are provided. If any action fails, subsequent actions in the list will not be
+        executed.
+
+        See the documentation for **--on-threshold** for the list of supported actions, with
+        the exception that *continue* has no effect.
+
+        Example:
+
+        $ rtla timerlat -d 5s --on-end trace
+
+        This runs rtla timerlat with default options and save trace output at the end.
-- 
2.47.2



