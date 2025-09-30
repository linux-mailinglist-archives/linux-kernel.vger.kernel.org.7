Return-Path: <linux-kernel+bounces-837956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC21BAE1F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30D0188CCE2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E0030E0D3;
	Tue, 30 Sep 2025 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQPadHFh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F74830C117
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251687; cv=none; b=ehKxJjntxQjCo75Egao+xMcPkrv0rFUtNYpaEZyyDA6lXpfhNSwB+pTEAPbOmvhl8oOvuL05P77IYNWum8aUR92ibtSLptTdMsPYnlB6rvYogsovFWG1uwtFowOQDXmd4Oc6ibpanamNjsIAVXmfUVNYksg1bIl17uZQSIU2LdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251687; c=relaxed/simple;
	bh=fEgqTioolEbToOXjQJrRCpCLI4LQWJGUzbSrefxtzSA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fdMkD2HM86AZIVe5I8G3S1uQaMVoxwJ1+NNNi+d8zYS/8WUHMg+NrEUY1NLIt89O41bZFNT08EiAtRIm6s3qxm9qVIFQ9ey+AB0ZxdCV5Cf9gulirx/5Qfe1WMPoBBwd1wRE0ATumL5bV8DZNKuVoIrsMEpEQMinU1iGtY/A6YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQPadHFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BADC116C6;
	Tue, 30 Sep 2025 17:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759251686;
	bh=fEgqTioolEbToOXjQJrRCpCLI4LQWJGUzbSrefxtzSA=;
	h=Date:From:To:Cc:Subject:References:From;
	b=PQPadHFhMBXFKAf87cL/RsSQQ8IQ34NsH/LadOLHClSbsQef49+iuoKhw0S6Sv9R3
	 GZaNOmdKvjPgcedNcavW7Rnj7NLBydwkIaQS7axi+JjzlZBQWxlqsAHLHOA+gNht4O
	 FU6vv1bjhZ0/3RkyVdY9r7xkyfMJEaaseUFJX1UcAI0gFg0xuPGGKEy5i2JVP8pz6d
	 iQKQutVzfli2jCcjaOHA+evJzI8iPPSO7Y5KvQNweiQLzHG61iS98cytix73mykzIa
	 SVOPg62LOvYTEZjJUqkydjica9BZN0f+/HfXMYfSfw3d/oIUNr/cGOSEEGIVeOsS9V
	 bE4+V470gcOjg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v3dkl-0000000DIKJ-07Jd;
	Tue, 30 Sep 2025 13:03:03 -0400
Message-ID: <20250930170302.878862549@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 30 Sep 2025 13:01:45 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [for-next][PATCH 10/11] tracing: Ensure optimized hashing works
References: <20250930170135.285740909@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>

If ever PID_MAX_DEFAULT changes, it must be compatible with tracing
hashmaps assumptions.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250924113810.2433478-1-mkoutny@suse.com
Link: https://lore.kernel.org/r/20240409110126.651e94cb@gandalf.local.home/
Signed-off-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_sched_switch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index 518dfc74347a..c46d584ded3b 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -247,6 +247,8 @@ int trace_save_cmdline(struct task_struct *tsk)
 	if (!tsk->pid)
 		return 1;
 
+	BUILD_BUG_ON(!is_power_of_2(PID_MAX_DEFAULT));
+
 	tpid = tsk->pid & (PID_MAX_DEFAULT - 1);
 
 	/*
-- 
2.50.1



