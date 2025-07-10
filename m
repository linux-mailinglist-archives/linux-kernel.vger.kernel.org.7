Return-Path: <linux-kernel+bounces-724701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB0DAFF604
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46F63AD06A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFB114C588;
	Thu, 10 Jul 2025 00:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geXN9e01"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAF986328
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752107696; cv=none; b=PUUwlVOjT/yYi1/uWjLYeF+skbFaR5HeWTBEg4zNgqzM6OnXzp69XP+XfJXx2Mze09JiLRqT8PI6AyuuRQh/iH1MiRmxKUfQ6uteqRfrec3QOigeBkv10F6wOOdHLA5+m/sc05IX5TAvKR8u3f1xmLN4vzcNKdyqjXdhzgJKV+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752107696; c=relaxed/simple;
	bh=LDy4rQbF/dg/Lc+S/cwZMM1PY80bTeRovlJcPG1OAog=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=cSiaKKLvEyy61KUbKG5xeMHOUYsgPz6jcMmJMLnOCpQxDLJX3zA0D2fdw7rjlQastVf7l2Iju18fKMCj26H6gLuNoJsbOhat9t1xLhPDev9tY2C2Fkb394bsT7s75ju+wAZYRLa0IE7Cxz057CrvubuxIrWPMz2TBdusFLbabxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geXN9e01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C465C116D0;
	Thu, 10 Jul 2025 00:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752107696;
	bh=LDy4rQbF/dg/Lc+S/cwZMM1PY80bTeRovlJcPG1OAog=;
	h=Date:From:To:Cc:Subject:References:From;
	b=geXN9e01LUf37ziotaSATUzj89wHj0WWqxr6fFjkQGCLIalGvrEMD5KWNwhDuNa/g
	 B3SQH7OXPBPrXH6db2znZowFklZvurhCjFArzUMB1+Of6N9gvUh9ldyHJJ/+NagHSr
	 QO7YiOhGTj/CVG9Pgya0OpKDJOTiiwRaXGTicxYvVj0tL7dZVmMyrAFbfYcWIMqLM/
	 m5NPXf38NMJaO3Pge2gH+O3rk4NS5kMR+WXlnsH8NPCPfSfNOCOEqKBOkaCY4pEpD4
	 Y3lRuLCMpuZMBKDHCGy9BawxmWMtO8IotLQS1NMqPhPf2tz/GJuUlIMnpVWLSCJ26L
	 oU4oxfqLgTA3Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uZfFc-00000001Whv-3zO7;
	Wed, 09 Jul 2025 20:35:00 -0400
Message-ID: <20250710003500.802135331@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 09 Jul 2025 20:34:42 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 5/9] Documentation/rv: Prepare monitor synthesis document for LTL
 inclusion
References: <20250710003437.191509804@kernel.org>
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
index e80e0057feb4..8e411b76ec82 100644
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



