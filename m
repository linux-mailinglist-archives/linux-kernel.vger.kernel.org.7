Return-Path: <linux-kernel+bounces-746336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8741B1259C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2AFA7BC6F4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E09F2620C3;
	Fri, 25 Jul 2025 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLAmlDpl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACCA25BEE8
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475659; cv=none; b=UR861iOgoczi5ZfKwq7YKIkvljdbt+HMFrF21wgJmvF9zUEmfO9emvSXbNlKbtyiEuyw9QWRz3gv5JSHzFHfh0Hnwy2C+iX0PG3ktQip+qv/fJ3a1PmXShkyRoxyf8PDTxBu8Hkqv8if+9mL+rpaZSpC6eGcT0iouE+1BkxZeyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475659; c=relaxed/simple;
	bh=NzQcSoVc4SoQj1qhynNfoGMUtUUgH4vBZODSdQ15mPg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Q9hrdQj1WyJACMdQfQHjlQ5xHS10T/HT3jIvm5b9D5aID7S8ENkd+YYt6F49Yfw9GBbPnROMOHz7nDw5OkLiJsWV2xNu7njKgYqF+3pIGsblLPYdYAhoJFyNK5f7cLieJPNEQtbbH8VtW7NAg+fcLpWX0+fQkQ8KODLP74ZOTcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLAmlDpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492E3C4CEF9;
	Fri, 25 Jul 2025 20:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753475659;
	bh=NzQcSoVc4SoQj1qhynNfoGMUtUUgH4vBZODSdQ15mPg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=dLAmlDplLEkF5plS1ML2W0c6Y99DwxOD+tbu11kAMsi3tfraGzQrmnwRU+c9aTdP7
	 +414UImKvdrkjqAJHm+6W1USB8+0EhdREjrR/uZg0WiMXeICK0CFG50eOIdCnik5pL
	 XBeNVMHcD6QgWFgswWMvdob8A001RTWGjfCZxAAzlyo13ND/WZDYn9bGSQAJKLGImE
	 rLGQz8Qgj/If0cituNP2irkbxAK4QLDFuwQEGLGjBs4Fdgtv6hFfVXIFLbIQzIRP5h
	 UI6Tj/phQuBVM/+lBU6txFFXcEzlbIuny41MNSsqihqXHiQ69tptjgH/dyfxz9l3Jm
	 bf1gervQVsaqw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufP7Z-00000001Qfo-1lPj;
	Fri, 25 Jul 2025 16:34:25 -0400
Message-ID: <20250725203425.275466334@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 16:34:05 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 08/25] Documentation/rv: Prepare monitor synthesis document for LTL
 inclusion
References: <20250725203357.087558746@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

Monitor synthesis from deterministic automaton and linear temporal logic
have a lot in common. Therefore a single document should describe both.

Change da_monitor_synthesis.rst to monitor_synthesis.rst. LTL monitor
synthesis will be added to this file by a follow-up commit.

This makes the diff far easier to read. If renaming and adding LTL info is
done in a single commit, git wouldn't recognize it as a rename, but a file
removal and a file addition.

While at it, correct the old dot2k commands to the new rvgen commands.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/d91c6e4600287f4732d68a014219e576a75ce6dc.1751634289.git.namcao@linutronix.de
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/rv/index.rst              |  2 +-
 ...or_synthesis.rst => monitor_synthesis.rst} | 20 +++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)
 rename Documentation/trace/rv/{da_monitor_synthesis.rst => monitor_synthesis.rst} (92%)

diff --git a/Documentation/trace/rv/index.rst b/Documentation/trace/rv/index.rst
index 26042dff70bb..9a2342bd20ca 100644
--- a/Documentation/trace/rv/index.rst
+++ b/Documentation/trace/rv/index.rst
@@ -8,7 +8,7 @@ Runtime Verification
 
    runtime-verification.rst
    deterministic_automata.rst
-   da_monitor_synthesis.rst
+   monitor_synthesis.rst
    da_monitor_instrumentation.rst
    monitor_wip.rst
    monitor_wwnr.rst
diff --git a/Documentation/trace/rv/da_monitor_synthesis.rst b/Documentation/trace/rv/monitor_synthesis.rst
similarity index 92%
rename from Documentation/trace/rv/da_monitor_synthesis.rst
rename to Documentation/trace/rv/monitor_synthesis.rst
index 0a92729c8a9b..85624062073b 100644
--- a/Documentation/trace/rv/da_monitor_synthesis.rst
+++ b/Documentation/trace/rv/monitor_synthesis.rst
@@ -1,5 +1,5 @@
-Deterministic Automata Monitor Synthesis
-========================================
+Runtime Verification Monitor Synthesis
+======================================
 
 The starting point for the application of runtime verification (RV) techniques
 is the *specification* or *modeling* of the desired (or undesired) behavior
@@ -36,24 +36,24 @@ below::
                                   |  +----> panic ?
                                   +-------> <user-specified>
 
-DA monitor synthesis
+RV monitor synthesis
 --------------------
 
 The synthesis of automata-based models into the Linux *RV monitor* abstraction
-is automated by the dot2k tool and the rv/da_monitor.h header file that
+is automated by the rvgen tool and the rv/da_monitor.h header file that
 contains a set of macros that automatically generate the monitor's code.
 
-dot2k
+rvgen
 -----
 
-The dot2k utility leverages dot2c by converting an automaton model in
+The rvgen utility leverages dot2c by converting an automaton model in
 the DOT format into the C representation [1] and creating the skeleton of
 a kernel monitor in C.
 
 For example, it is possible to transform the wip.dot model present in
 [1] into a per-cpu monitor with the following command::
 
-  $ dot2k -d wip.dot -t per_cpu
+  $ rvgen monitor -c da -s wip.dot -t per_cpu
 
 This will create a directory named wip/ with the following files:
 
@@ -87,7 +87,7 @@ the second for monitors with per-cpu instances, and the third with per-task
 instances.
 
 In all cases, the 'name' argument is a string that identifies the monitor, and
-the 'type' argument is the data type used by dot2k on the representation of
+the 'type' argument is the data type used by rvgen on the representation of
 the model in C.
 
 For example, the wip model with two states and three events can be
@@ -134,7 +134,7 @@ Final remarks
 -------------
 
 With the monitor synthesis in place using the rv/da_monitor.h and
-dot2k, the developer's work should be limited to the instrumentation
+rvgen, the developer's work should be limited to the instrumentation
 of the system, increasing the confidence in the overall approach.
 
 [1] For details about deterministic automata format and the translation
@@ -142,6 +142,6 @@ from one representation to another, see::
 
   Documentation/trace/rv/deterministic_automata.rst
 
-[2] dot2k appends the monitor's name suffix to the events enums to
+[2] rvgen appends the monitor's name suffix to the events enums to
 avoid conflicting variables when exporting the global vmlinux.h
 use by BPF programs.
-- 
2.47.2



