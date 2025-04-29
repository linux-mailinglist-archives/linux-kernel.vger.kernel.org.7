Return-Path: <linux-kernel+bounces-625162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9E3AA0DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 15:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7C0189FF8D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 13:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2232D1915;
	Tue, 29 Apr 2025 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGs5eYE/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0222D29B9;
	Tue, 29 Apr 2025 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745934196; cv=none; b=WPAlT2eUPc/wcgHtcMzbsZvCytezBqiyRH16VAqCHmZ/mHU9mew5TkE8AAmGRwHuYhurqosjp3uPqIbI1/Gqr9jzxgbBJTHhDqqTsqktydFJtI1Jbt0q2hHoB9YCW1RtHnaEXy1MdCx4XNUZ4KLztvMlKRUlYbnr9VLUsnnAw1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745934196; c=relaxed/simple;
	bh=jT+JCug3rY6Eclx9wz6YCHHOuZE/75MafzqB5rX/F6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3zHbyi/hNo3C2+U8V06XMoCgn8k0U8UUWebd7Bzb6/WUDteqhU7wCsL7f7buu1H5SYHxFzrychVfA+z+QDm16PYt2ycMHgzcMaCoLqq23flP+s+kDzjSs8cCpF/DReryNARcYwT1ZHi3xKeMMpn/65g3c2LtJHns3NCGEqQ/OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGs5eYE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDC8C4CEEB;
	Tue, 29 Apr 2025 13:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745934196;
	bh=jT+JCug3rY6Eclx9wz6YCHHOuZE/75MafzqB5rX/F6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TGs5eYE/zJt3gO/xiEsdExNC96ap/UtpBhYV2Lncl2gYiQwpU2O596rQembt2CkNm
	 Sgtsti/vvGMGpeIek4lNmGLmgmoxpCT+sCS6szayOKcrFo+/KWnzlf9iDGV7AyLgu5
	 3TfXaQLU3jk355dSne9r3QrqXv+ZyeaFX/MO+rdxjPX18H9HTzfNj/D8/XSZ0MxmK0
	 VhZPW0KJQuSppDcsbz0t6doBNQrz071nKP6PxOrP75TioeGG8Lo1N5vEgJRBVxAlpb
	 HKbkfkPDIRKNK/Op30A5Va2vlVnfLqbiwt8xcbvsbUBvzDmFF0ZNckeJP065aoYjwn
	 CeytYZsKGojCw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 2/5] rcu/exp: Remove confusing needless full barrier on task unblock
Date: Tue, 29 Apr 2025 15:43:01 +0200
Message-ID: <20250429134304.3824863-3-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429134304.3824863-1-frederic@kernel.org>
References: <20250429134304.3824863-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A full memory barrier in the RCU-PREEMPT task unblock path advertizes
to order the context switch (or rather the accesses prior to
rcu_read_unlock()) with the expedited grace period fastpath.

However the grace period can not complete without the rnp calling into
rcu_report_exp_rnp() with the node locked. This reports the quiescent
state in a fully ordered fashion against updater's accesses thanks to:

1) The READ-SIDE smp_mb__after_unlock_lock() barrier accross nodes
   locking while propagating QS up to the root.

2) The UPDATE-SIDE smp_mb__after_unlock_lock() barrier while holding the
   the root rnp to wait/check for the GP completion.

3) The (perhaps redundant given step 1) and 2)) smp_mb() in rcu_seq_end()
   before the grace period completes.

This makes the explicit barrier in this place superflous. Therefore
remove it as it is confusing.

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_plugin.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3c0bbbbb686f..d51cc7a5dfc7 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -534,7 +534,6 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		WARN_ON_ONCE(rnp->completedqs == rnp->gp_seq &&
 			     (!empty_norm || rnp->qsmask));
 		empty_exp = sync_rcu_exp_done(rnp);
-		smp_mb(); /* ensure expedited fastpath sees end of RCU c-s. */
 		np = rcu_next_node_entry(t, rnp);
 		list_del_init(&t->rcu_node_entry);
 		t->rcu_blocked_node = NULL;
-- 
2.48.1


