Return-Path: <linux-kernel+bounces-768765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A879B26536
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1593B7BED9B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542882FD1C5;
	Thu, 14 Aug 2025 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ilCN0iHd"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3AD2FCBEB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755173759; cv=none; b=T3trGFe7/7G0RyFolRZnVTJkhruh3l3yjqJzOcaUEE1ftFbLibFWPUNbBTgDc4Nkcm6q7NGtDbJA/LH4szC9ghLYdCKA5ss7eP+ygsNcGMterOw6T+KiFdIjS1J6NevwKT5IEP0wya33MRJ9KRs/fKSNcgAnq/S15ji/LFQ2XQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755173759; c=relaxed/simple;
	bh=ynSr0E47HmXYcUmddedDfIO1NaYKsuWB4E2xbZAmQgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fSkpew1PkH2I9h/UWt7RQEvtVM94lrAtT0PlAAFGEadYemYMW8hSaBZR83D9ATR9RtuVyXgvkWrPBAeh4NbLb9w/W7EYZHnnNc58eOARDzsH+2fPU1UPObXMH0k1ay9svX8qCFn+vfhusIdPj0A6u0fA164hnCR26J/Dj/UxmcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ilCN0iHd; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755173745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0ZjbPBfh7ujlNLzE0h5ffJa8LoQU/WhI2aIAZlbPDio=;
	b=ilCN0iHdM5/+X1oXmtFfbHqTsQxh4P2A1hnbK4M+0T3Jqdwoqs9CIsPYsn5pRDSrNF+UVR
	09bqkF36bhYOUxNLMNZboon6nwyTCxPlzlbcpHugtr+bruU0r64TbjlO5f8bDcY+EwMQQF
	VdaYL6tk72VrrSDIHEQ1CQnAcsd8wz0=
From: Tao Chen <chen.dylane@linux.dev>
To: song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH v3 bpf-next] bpf: Remove migrate_disable in kprobe_multi_link_prog_run
Date: Thu, 14 Aug 2025 20:14:29 +0800
Message-ID: <20250814121430.2347454-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Graph tracer framework ensures we won't migrate, kprobe_multi_link_prog_run
called all the way from graph tracer, which disables preemption in
function_graph_enter_regs, as Jiri and Yonghong suggested, there is no
need to use migrate_disable. As a result, some overhead may will be reduced.
And add cant_sleep check for __this_cpu_inc_return.

Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Change list:
 v1 -> v2:
  - s/called the way/called all the way/.(Jiri)
 v1: https://lore.kernel.org/bpf/f7acfd22-bcf3-4dff-9a87-7c1e6f84ce9c@linux.dev

 v2 -> v3:
  - add cant_sleep for __this_cpu_inc_return.(Andrii)
  - shorten comments.(Andrii)
 v2: https://lore.kernel.org/bpf/20250805162732.1896687-1-chen.dylane@linux.dev

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3ae52978cae..606007c387c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2728,20 +2728,25 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 	struct pt_regs *regs;
 	int err;
 
+	/*
+	 * graph tracer framework ensures we won't migrate, so there is no need
+	 * to use migrate_disable for bpf_prog_run again. The check here just for
+	 * __this_cpu_inc_return.
+	 */
+	cant_sleep();
+
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
 		bpf_prog_inc_misses_counter(link->link.prog);
 		err = 1;
 		goto out;
 	}
 
-	migrate_disable();
 	rcu_read_lock();
 	regs = ftrace_partial_regs(fregs, bpf_kprobe_multi_pt_regs_ptr());
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
 	rcu_read_unlock();
-	migrate_enable();
 
  out:
 	__this_cpu_dec(bpf_prog_active);
-- 
2.48.1


