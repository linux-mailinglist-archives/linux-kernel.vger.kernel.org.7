Return-Path: <linux-kernel+bounces-792074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92708B3BFED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D4F585A52
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1B8341ABA;
	Fri, 29 Aug 2025 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwfEcOVn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26321341AA8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482565; cv=none; b=NsT/POogReyDkoPIKkfDSw6BfN9BouXCiCsjRhMB+rQj382hX0WmHmbLl/arWQ0/o6UI8jZbCX4jYBD2olXxypmqjfLopfSf40NuYNUzhqQXIS8mVVkDl32/tUASzz4CAPV/KTh7uGXZgtNsJBEh1l+h43SlWGGwtK3e12UJVGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482565; c=relaxed/simple;
	bh=pzOS1AH2wHJHSLxWx9UNzEZr4fjsciwBuMuPCFGnunY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHwZxqWdVVwosFgwkf73QKFhHEiCV9hWU8ZCIztuinvFuG9yYsy64INSGTeCP11k1AnbrGDmmrKZCTeF9xO7gbCubDyZTOZnLclLUEgCOaESp4+wbL2Uiye2sK/ZQJ4JtCfRRG3k36RJ0XuLfcqjVp6stdrjbtfLBfaWC2Mm2Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwfEcOVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36433C4CEF0;
	Fri, 29 Aug 2025 15:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482565;
	bh=pzOS1AH2wHJHSLxWx9UNzEZr4fjsciwBuMuPCFGnunY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GwfEcOVnU5K1ePkPkZNrBJExeBPZm13MFUtGD95UkVYALYTUCQareaXWecuhS2nUh
	 AaSByZV0BSJmnCh8ib5VYI79e0/poO1RruOKSbL8HmSE7GOIxamTZTUHgD/SLagCnM
	 oysQK1EpwszXiQKMZ2IE6AXMiRjyZG1JCU3VvAY76laKCerAi4iZSx4O8ibg4gMW8d
	 sujoJv9wntizKz0l5Wg1N0OPQaGINLPrgfu5oKQy2oMSBf3GloJB1pBZrH8OhdxIBe
	 bqKY6bkcpuAbKBrcFl3X1Y4gVucz8qDpTHsM1x8x86COKNhmyPtFQ6QNUGeelclpiE
	 XE/bTqouuRUPQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 23/33] kthread: Include kthreadd to the managed affinity list
Date: Fri, 29 Aug 2025 17:48:04 +0200
Message-ID: <20250829154814.47015-24-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829154814.47015-1-frederic@kernel.org>
References: <20250829154814.47015-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The unbound kthreads affinity management performed by cpuset is going to
be imported to the kthread core code for consolidation purposes.

Treat kthreadd just like any other kthread.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/kthread.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index cba3d297f267..cb0be05d6091 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -820,12 +820,13 @@ int kthreadd(void *unused)
 	/* Setup a clean context for our children to inherit. */
 	set_task_comm(tsk, comm);
 	ignore_signals(tsk);
-	set_cpus_allowed_ptr(tsk, housekeeping_cpumask(HK_TYPE_KTHREAD));
 	set_mems_allowed(node_states[N_MEMORY]);
 
 	current->flags |= PF_NOFREEZE;
 	cgroup_init_kthreadd();
 
+	kthread_affine_node();
+
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (list_empty(&kthread_create_list))
-- 
2.51.0


