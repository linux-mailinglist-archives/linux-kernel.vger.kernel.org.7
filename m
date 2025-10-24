Return-Path: <linux-kernel+bounces-868915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E43C067C3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 561694FF439
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7142331D726;
	Fri, 24 Oct 2025 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZsEUDcL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFB831D38A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312355; cv=none; b=twbPVgxfNqV1M5gysmvV2mxyF9TjRXEnpafoz16neBIAhTuA9yIXJTPRMMs4F6jFNeo2mHvUKgbieNJwH9/cXCAaB4NkZLTOEXi4Hq8bzEVuYYLihsG/uP9tEwzjCaSJwTT/dCKtDc2jZpsgVWxScGudPoT/3+HXpwpkgVtIhBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312355; c=relaxed/simple;
	bh=uJxdgCSnMHyfpl5uMBt8V/1GCH9ZP0OmTlB+dP0I8kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxVrBuMnH07KE/AwA2qYOrEDfAA0plJcOFuVsU73ftTDVHcUFkLLcUlS/ALTsaBUaDeTpurAW1KnVnnVaVQGQsMhjjwfNZzToeSe3VEfyi+YEVBuLYtHx4IBBwWsnqRvbLu1kPQl1sT8mIXrJrmDh4sp289VVZep/pWUSjCP4m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZsEUDcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB10C4CEFF;
	Fri, 24 Oct 2025 13:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761312355;
	bh=uJxdgCSnMHyfpl5uMBt8V/1GCH9ZP0OmTlB+dP0I8kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZsEUDcLn2pExYlovMDAwTy/Wp0Af+/RrOcnjdVBtikpjBve5mNYsPMA/VWxEMxDB
	 GjDGtZl+1rY8t9IIWac2P18kUqK7+gr6pvOptLsT2EdrozJm8sR7J5bNTn00KsAz69
	 V7aPwp5KmoNMP6WKCUy5dxTV1diTTy8+RlezyLm24S4EI/qvSJhVA1ONcfv0cgci7h
	 8ZQYgaKD21lWF0ZRrDPaMCFGhoxYtU0HgZ/PuundHHF0yAaaqwqVjGkctimaNZhpyM
	 E7vc3osgxv5W3+kiQhgBuRCjKQL/eUxmSSF19RDPU4MxRl0WNU435xwNF0UPAC0luw
	 aborjEyRtST7A==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 2/6] timers/migration: Remove locking on group connection
Date: Fri, 24 Oct 2025 15:25:32 +0200
Message-ID: <20251024132536.39841-3-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024132536.39841-1-frederic@kernel.org>
References: <20251024132536.39841-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initializing the tmc's group, the group's number of children and the
group's parent can all be done without locking because:

1) Reading the group's parent and its groupmask is done locklessly.

2) The connections prepared for a given CPU hierarchy are visible to the
   target CPU once online, thanks to the CPU hotplug enforced memory
   ordering.

3) In case of a newly created upper level, the new root and its
   connections/initializations are made visible by the CPU which made
   the connections. When that CPUs goes idle in the future, the new link
   is published by tmigr_inactive_up() through the atomic RmW on
   ->migr_state.

4) If CPUs were still walking up the active hierarchy, they could observe
   the new root earlier. In this case the ordering is enforced by an
   early initialization of the group mask and by barriers that maintain
   address dependency as explained in:

    b729cc1ec21a ("timers/migration: Fix another race between hotplug and idle entry/exit")
	de3ced72a792 ("timers/migration: Enforce group initialization visibility to tree walkers")

5) Timers are propagated by a chain of group locking from the bottom to
   the top. And while doing so, the tree also propagates groups links
   and initializations. Therefore remote expiration, which also relies
   on group locking, will observe those links and initialization while
   holding the root lock before walking the tree remotely and update
   remote timers. This is especially important for migrators in the
   active hierarchy that may observe the new root early.

Therefore the locking is unecesserary at initialization. If anything,
it just brings confusion. Remove it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer_migration.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 1e371f1fdc86..5f8aef94ca0f 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1573,9 +1573,6 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 {
 	struct tmigr_walk data;
 
-	raw_spin_lock_irq(&child->lock);
-	raw_spin_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
-
 	if (activate) {
 		/*
 		 * @child is the old top and @parent the new one. In this
@@ -1596,9 +1593,6 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	 */
 	smp_store_release(&child->parent, parent);
 
-	raw_spin_unlock(&parent->lock);
-	raw_spin_unlock_irq(&child->lock);
-
 	trace_tmigr_connect_child_parent(child);
 
 	if (!activate)
@@ -1695,13 +1689,9 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 		if (i == 0) {
 			struct tmigr_cpu *tmc = per_cpu_ptr(&tmigr_cpu, cpu);
 
-			raw_spin_lock_irq(&group->lock);
-
 			tmc->tmgroup = group;
 			tmc->groupmask = BIT(group->num_children++);
 
-			raw_spin_unlock_irq(&group->lock);
-
 			trace_tmigr_connect_cpu_parent(tmc);
 
 			/* There are no children that need to be connected */
-- 
2.51.0


