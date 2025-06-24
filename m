Return-Path: <linux-kernel+bounces-700745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675B0AE6C35
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 18:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E273AFC44
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 16:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB872E2EF9;
	Tue, 24 Jun 2025 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cg4Od1RI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEB828A703;
	Tue, 24 Jun 2025 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781643; cv=none; b=fl/b7PszH8oFWWyyz5x9wPSHNGu4BTqmOaeclP8ZMuoh4AsNkzRrysYp79DZdaDZIyl3mIawhEuq9Piv1eVsjX2wfs5XE1NPw403SpVyuB5l5Thqu3QC2jlkQiPYl+olpmm0eY9G86cE7SA8CyNejqVa81NgiyuDwK0tp/ak298=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781643; c=relaxed/simple;
	bh=r1n5OG46xNHcBMpmukg6Wmdn3rQnUElhsHxXLiSPcds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jW/HCXg9PAH+kuzTP/UyB9OAUofWSx4/R1FQMoBzrj1qSp+HnmNSYwSwl8K07i2IERJWXgxJ531/Q31E/Oy84K4DrFvWsJcwo6IzaPZpjaeYqRQUrwd2yjouVIqrv9hZ79YTf1xncoYmUllLS+M+jq8Dxtf9j5JyU8moA4xCDcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cg4Od1RI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFE8C4CEF4;
	Tue, 24 Jun 2025 16:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750781643;
	bh=r1n5OG46xNHcBMpmukg6Wmdn3rQnUElhsHxXLiSPcds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cg4Od1RIy6klZiLWD3j1SGKK/8mEkuSYCUxcpi4oaY9sL9kqyI9xk/XZ7h/TA8HtE
	 teOBpvJxedcodYmLVgQnIEmZkFoBnZDkIRPcycGVGG4vdVadZEekaCspLI6Lj5/uzT
	 +S9UTMU+bJxJ6wRTnwn6izeLePvg+nAjGY66UcaAaKe2v0ZQTFCMt3j1KxfjVlw6N1
	 qnaEfO3NB/OzP95+cJCKjZp+RUI1Z9KU+SX3YX6ekRgqP330Dx/atPGsNLGFi7yu96
	 l0tuCj5LLbGIfDvngsdTrv/eRAAYGwDksJiTrJ+kFiI14qvWyMQ66AWh/9h2GSXebj
	 d4JPLMFvAVlvA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 88C04CE0C3C; Tue, 24 Jun 2025 09:14:01 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 4/5] srcu: Remove SRCU-lite implementation
Date: Tue, 24 Jun 2025 09:13:59 -0700
Message-Id: <20250624161400.867880-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e5dd6af2-fdbf-4773-9732-13b84ca13a12@paulmck-laptop>
References: <e5dd6af2-fdbf-4773-9732-13b84ca13a12@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit removes the SRCU-lite implementation, which has been replaced
by SRCU-fast.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcu.h     | 47 ++--------------------------------------
 include/linux/srcutiny.h |  3 ---
 include/linux/srcutree.h | 38 --------------------------------
 3 files changed, 2 insertions(+), 86 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index c20dacb563e55..cf711a0f440b2 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -46,11 +46,11 @@ int init_srcu_struct(struct srcu_struct *ssp);
 /* Values for SRCU Tree srcu_data ->srcu_reader_flavor, but also used by rcutorture. */
 #define SRCU_READ_FLAVOR_NORMAL	0x1		// srcu_read_lock().
 #define SRCU_READ_FLAVOR_NMI	0x2		// srcu_read_lock_nmisafe().
-#define SRCU_READ_FLAVOR_LITE	0x4		// srcu_read_lock_lite().
+//				0x4		// SRCU-lite is no longer with us.
 #define SRCU_READ_FLAVOR_FAST	0x8		// srcu_read_lock_fast().
 #define SRCU_READ_FLAVOR_ALL   (SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_NMI | \
 				SRCU_READ_FLAVOR_FAST) // All of the above.
-#define SRCU_READ_FLAVOR_SLOWGP	(SRCU_READ_FLAVOR_LITE | SRCU_READ_FLAVOR_FAST)
+#define SRCU_READ_FLAVOR_SLOWGP	SRCU_READ_FLAVOR_FAST
 						// Flavors requiring synchronize_rcu()
 						// instead of smp_mb().
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
@@ -299,33 +299,6 @@ static inline struct srcu_ctr __percpu *srcu_down_read_fast(struct srcu_struct *
 	return __srcu_read_lock_fast(ssp);
 }
 
-/**
- * srcu_read_lock_lite - register a new reader for an SRCU-protected structure.
- * @ssp: srcu_struct in which to register the new reader.
- *
- * Enter an SRCU read-side critical section, but for a light-weight
- * smp_mb()-free reader.  See srcu_read_lock() for more information.
- *
- * If srcu_read_lock_lite() is ever used on an srcu_struct structure,
- * then none of the other flavors may be used, whether before, during,
- * or after.  Note that grace-period auto-expediting is disabled for _lite
- * srcu_struct structures because auto-expedited grace periods invoke
- * synchronize_rcu_expedited(), IPIs and all.
- *
- * Note that srcu_read_lock_lite() can be invoked only from those contexts
- * where RCU is watching, that is, from contexts where it would be legal
- * to invoke rcu_read_lock().  Otherwise, lockdep will complain.
- */
-static inline int srcu_read_lock_lite(struct srcu_struct *ssp) __acquires(ssp)
-{
-	int retval;
-
-	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_LITE);
-	retval = __srcu_read_lock_lite(ssp);
-	rcu_try_lock_acquire(&ssp->dep_map);
-	return retval;
-}
-
 /**
  * srcu_read_lock_nmisafe - register a new reader for an SRCU-protected structure.
  * @ssp: srcu_struct in which to register the new reader.
@@ -434,22 +407,6 @@ static inline void srcu_up_read_fast(struct srcu_struct *ssp, struct srcu_ctr __
 	__srcu_read_unlock_fast(ssp, scp);
 }
 
-/**
- * srcu_read_unlock_lite - unregister a old reader from an SRCU-protected structure.
- * @ssp: srcu_struct in which to unregister the old reader.
- * @idx: return value from corresponding srcu_read_lock_lite().
- *
- * Exit a light-weight SRCU read-side critical section.
- */
-static inline void srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
-	__releases(ssp)
-{
-	WARN_ON_ONCE(idx & ~0x1);
-	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_LITE);
-	srcu_lock_release(&ssp->dep_map);
-	__srcu_read_unlock_lite(ssp, idx);
-}
-
 /**
  * srcu_read_unlock_nmisafe - unregister a old reader from an SRCU-protected structure.
  * @ssp: srcu_struct in which to unregister the old reader.
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 380260317d98b..51ce25f07930e 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -93,9 +93,6 @@ static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_
 	__srcu_read_unlock(ssp, __srcu_ptr_to_ctr(ssp, scp));
 }
 
-#define __srcu_read_lock_lite __srcu_read_lock
-#define __srcu_read_unlock_lite __srcu_read_unlock
-
 static inline void synchronize_srcu_expedited(struct srcu_struct *ssp)
 {
 	synchronize_srcu(ssp);
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 8bed7e6cc4c1f..bf44d8d1e69ea 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -278,44 +278,6 @@ static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_fast().");
 }
 
-/*
- * Counts the new reader in the appropriate per-CPU element of the
- * srcu_struct.  Returns an index that must be passed to the matching
- * srcu_read_unlock_lite().
- *
- * Note that this_cpu_inc() is an RCU read-side critical section either
- * because it disables interrupts, because it is a single instruction,
- * or because it is a read-modify-write atomic operation, depending on
- * the whims of the architecture.
- */
-static inline int __srcu_read_lock_lite(struct srcu_struct *ssp)
-{
-	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
-
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_lite().");
-	this_cpu_inc(scp->srcu_locks.counter); /* Y */
-	barrier(); /* Avoid leaking the critical section. */
-	return __srcu_ptr_to_ctr(ssp, scp);
-}
-
-/*
- * Removes the count for the old reader from the appropriate
- * per-CPU element of the srcu_struct.  Note that this may well be a
- * different CPU than that which was incremented by the corresponding
- * srcu_read_lock_lite(), but it must be within the same task.
- *
- * Note that this_cpu_inc() is an RCU read-side critical section either
- * because it disables interrupts, because it is a single instruction,
- * or because it is a read-modify-write atomic operation, depending on
- * the whims of the architecture.
- */
-static inline void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
-{
-	barrier();  /* Avoid leaking the critical section. */
-	this_cpu_inc(__srcu_ctr_to_ptr(ssp, idx)->srcu_unlocks.counter);  /* Z */
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_lite().");
-}
-
 void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
 
 // Record reader usage even for CONFIG_PROVE_RCU=n kernels.  This is
-- 
2.40.1


