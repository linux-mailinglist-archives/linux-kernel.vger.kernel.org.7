Return-Path: <linux-kernel+bounces-756375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D144B1B33E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D033B515B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B700213E02D;
	Tue,  5 Aug 2025 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uSmESP7A"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C07424E4B4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754396623; cv=none; b=k/aHXIGZBZcmOC3WfYrUzfWyZrYXPns+OSwVgoxsplRhQBxjKfQ+IVoZRunSIGT8rdj87tLxj8xRQgj9XVwFkELuLlG3ly5j0gOeYHPoShUapFOyGYetWixMaAq8Sh+VZiBtnjWXUosfsdRJ6+a2W58ovo/jj/KhGxMtTL9M67Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754396623; c=relaxed/simple;
	bh=xFnGQAK+SCGpQM5L461SVbPvgeMBSoj1Z0emM/2Xm3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=clCdCVrl3e04oM62qhc3XnmAUMr1NxE0ra+BUvNqpBZ6RIm9uojxnL4QLNZ7U1zV6/ciIAO2gt546JWc/x04g1XC04EvhhW+WNQPzFL+0ZtXzx1b4+DOLCPBLi17/14gu9wemDYzy4DhcIuw4qxo1Z8Fh5V4HRHuqUe9eU7nZwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uSmESP7A; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754396608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Fnd61Z9ADig6IYqnJnuJZzpg/ZV/PVSlvhbbeJhiw5U=;
	b=uSmESP7A11Q8dLzDlEkGxgxwqM5Lt4O0TrpSTubFDOCdSgWNT5U1pJjsNqWazpiMW3bPyS
	IRj+z05WLaa+ZVPZnQYpRQFf7OXWXIQXiSIR3HYGcDtc1BeobT8A7Uvgn8yzcRCJTPlQTE
	vr2pdoYWhKZ6v9QNJrwIkHdomxEOOtY=
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
Subject: [PATCH bpf-next] bpf: Remove migrate_disable in kprobe_multi_link_prog_run
Date: Tue,  5 Aug 2025 20:23:12 +0800
Message-ID: <20250805122312.1890951-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

bpf program should run under migration disabled, kprobe_multi_link_prog_run
called the way from graph tracer, which disables preemption in
function_graph_enter_regs, as Jiri and Yonghong suggested, there is no
need to use migrate_disable. As a result, some overhead maybe will be
reduced.

Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3ae52978cae..1993fc62539 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2734,14 +2734,19 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 		goto out;
 	}
 
-	migrate_disable();
+	/*
+	 * bpf program should run under migration disabled, kprobe_multi_link_prog_run
+	 * called the way from graph tracer, which disables preemption in
+	 * function_graph_enter_regs, so there is no need to use migrate_disable.
+	 * Accessing the above percpu data bpf_prog_active is also safe for the same
+	 * reason.
+	 */
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


