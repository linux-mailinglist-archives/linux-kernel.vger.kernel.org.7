Return-Path: <linux-kernel+bounces-746770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FA0B12AE9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 16:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40931895EB0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 14:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D13128643A;
	Sat, 26 Jul 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbrzOLVd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17F51A08BC
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753539402; cv=none; b=COjaNnb3y/9jwqrm6GqbnBrCMv9iokVDlGpz4AiLjNcznGH8DBlaEyRXiqZv923iNIL4TtHX09miOMVl75pvz8b+q6PlWPH/0eXRD9tr8ajUzguAlMQR6ce3oijMxQcT2clzYB63f/DGQfMOELhfqvMrlEVRK4rE/N7IP2J2NIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753539402; c=relaxed/simple;
	bh=BTiroDLBuUdWZ4laorRZVY6/GMhlNlfnmXzLqTtAYCE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=asPees4KMmsZPuPbzpB1+v00gvkPZJptBgZxXRbug+CN1holtQsi9DaLrvIv73Np9RjnMDQoN6BGjD7LBOftoO6mHhjIlX9zUs3H7TrjmDk3Jk2czD72lmnHJs9wcehewG7XCBREorE2KeJtXnELEBeJs1x60dWZqioeR5sCKN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbrzOLVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A47EC4CEF4;
	Sat, 26 Jul 2025 14:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753539402;
	bh=BTiroDLBuUdWZ4laorRZVY6/GMhlNlfnmXzLqTtAYCE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=qbrzOLVdv5e/wbyGZpLm64LVXcq6AFdKWShu+jvxFbH0e7xuCgDBeKmDAVqzMgzk8
	 AtTEy/TWndLeYkkn0oULD5dL2TzKyagsR6h15gQ60svD7XvPbsn6QWKNV467QvCV+q
	 HHlcTs1D2PXYM4p5Vx8D5RDawdS7Qm6tyjeajb3qJmjRWGcNCSICoEfnNkAYE4aVPC
	 wjTxAUbezxNinCE70gfrlVaHlejg/G+W7Dp4Yu8IxVpWKWh9mYC1joAcZgeXMB8Y2R
	 fZxvbJb6362d3X4WGCeGcfm4eCpxsRqQHBnv17+UaCtpmhWRq8FyoCe3boJ6J1TtIZ
	 G+d+95mGLGPzw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uffhh-00000001stZ-3tkD;
	Sat, 26 Jul 2025 10:16:49 -0400
Message-ID: <20250726141649.786599126@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 26 Jul 2025 10:16:06 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [for-next][PATCH 2/2] tracing: sched: Hide numa events under CONFIG_NUMA_BALANCING
References: <20250726141604.934070855@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The events sched_move_numa, sched_stick_numa and sched_swap_numa are only
called when CONFIG_NUMA_BALANCING is configured. As each event can take up
to 5K of memory in text and meta data regardless if they are used or not,
they should not be defined when unused.

Move the #ifdef CONFIG_NUMA_BALANCING to hide these events as well.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/20250612100552.39672cf9@batman.local.home
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 4e6b2910cec3..0243f32e068a 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -628,6 +628,7 @@ TRACE_EVENT(sched_process_hang,
 );
 #endif /* CONFIG_DETECT_HUNG_TASK */
 
+#ifdef CONFIG_NUMA_BALANCING
 /*
  * Tracks migration of tasks from one runqueue to another. Can be used to
  * detect if automatic NUMA balancing is bouncing between nodes.
@@ -720,7 +721,6 @@ DEFINE_EVENT(sched_numa_pair_template, sched_swap_numa,
 	TP_ARGS(src_tsk, src_cpu, dst_tsk, dst_cpu)
 );
 
-#ifdef CONFIG_NUMA_BALANCING
 #define NUMAB_SKIP_REASON					\
 	EM( NUMAB_SKIP_UNSUITABLE,		"unsuitable" )	\
 	EM( NUMAB_SKIP_SHARED_RO,		"shared_ro" )	\
-- 
2.47.2



