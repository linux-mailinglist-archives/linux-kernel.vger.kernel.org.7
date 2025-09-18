Return-Path: <linux-kernel+bounces-790995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D9BB3B0C7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 04:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746B53A4242
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A04219A67;
	Fri, 29 Aug 2025 02:14:50 +0000 (UTC)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597FE30CD84
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 02:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756433690; cv=none; b=LRpY9vpx96TXN9iL02h12TOVz/VbpCUVQS4CrEZHEN1l93m1tyzjB4EfaOcD2GLI0HK49QM8IZ39ku412FPvIUvpiJodstKluJ9qzx80Yvwk+ceSjqedCPfo9AxSAvymV4/ptDGknZKzvUbmmYqcxse7m9TDRpy6PPuKoHQ4WCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756433690; c=relaxed/simple;
	bh=jHPXfkFeIwjt4mfYaOe/rVaJ3mviT+kE7KTC7JsGT6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kRJX7Sak7g3J8ss7ugvoYq7kaIXv8NRzZxq8ktlV8prN0gs3EKuZj3ZNQT9naOS1iB3Bo6d/Z9QhldyX8MjjOh2kfj4PWziX4mq7f6sW66RXxGBtDjvKh+r5zHy+GTPEi5hnL5zmCDcCalozaweOFteuIrXDeNfO37LyHn3QTRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] tracing: fprobe: fix suspicious rcu usage in fprobe_entry
Date: Fri, 29 Aug 2025 10:14:36 +0800
Message-ID: <20250829021436.19982-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

rcu_read_lock() is not needed in fprobe_entry, but rcu_dereference_check()
is used in rhltable_lookup(), which causes suspicious RCU usage warning:

  WARNING: suspicious RCU usage
  6.17.0-rc1-00001-gdfe0d675df82 #1 Tainted: G S
  -----------------------------
  include/linux/rhashtable.h:602 suspicious rcu_dereference_check() usage!
  ......
  stack backtrace:
  CPU: 1 UID: 0 PID: 4652 Comm: ftracetest Tainted: G S
  Tainted: [S]=CPU_OUT_OF_SPEC, [I]=FIRMWARE_WORKAROUND
  Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
  Call Trace:
   <TASK>
   dump_stack_lvl+0x7c/0x90
   lockdep_rcu_suspicious+0x14f/0x1c0
   __rhashtable_lookup+0x1e0/0x260
   ? __pfx_kernel_clone+0x10/0x10
   fprobe_entry+0x9a/0x450
   ? __lock_acquire+0x6b0/0xca0
   ? find_held_lock+0x2b/0x80
   ? __pfx_fprobe_entry+0x10/0x10
   ? __pfx_kernel_clone+0x10/0x10
   ? lock_acquire+0x14c/0x2d0
   ? __might_fault+0x74/0xc0
   function_graph_enter_regs+0x2a0/0x550
   ? __do_sys_clone+0xb5/0x100
   ? __pfx_function_graph_enter_regs+0x10/0x10
   ? _copy_to_user+0x58/0x70
   ? __pfx_kernel_clone+0x10/0x10
   ? __x64_sys_rt_sigprocmask+0x114/0x180
   ? __pfx___x64_sys_rt_sigprocmask+0x10/0x10
   ? __pfx_kernel_clone+0x10/0x10
   ftrace_graph_func+0x87/0xb0

Fix this by using rcu_read_lock() for rhltable_lookup(). Alternatively, we
can use rcu_lock_acquire(&rcu_lock_map) here to obtain better performance.
However, it's not a common usage :/

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202508281655.54c87330-lkp@intel.com
Fixes: dfe0d675df82 ("tracing: fprobe: use rhltable for fprobe_ip_table")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/trace/fprobe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index fb127fa95f21..fece0f849c1c 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -269,7 +269,9 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 	if (WARN_ON_ONCE(!fregs))
 		return 0;
 
+	rcu_read_lock();
 	head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
+	rcu_read_unlock();
 	reserved_words = 0;
 	rhl_for_each_entry_rcu(node, pos, head, hlist) {
 		if (node->addr != func)
-- 
2.51.0


