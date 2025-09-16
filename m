Return-Path: <linux-kernel+bounces-818084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 459F9B58C71
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9F827A1C7A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4632B248F4E;
	Tue, 16 Sep 2025 03:39:20 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239851991B6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757993959; cv=none; b=nwbTDMIRoGuQ+E8l1bFJ/3f1iKrA4JW4fAc2Q+mOj0gR8J+MrYFmUqTY/N+vaPdAKIlkQSE4SpTRgyciGbg6D6jIX8srRqkVRnbzgfuVSgVBWdmVJG1TqTY2eABUBWr4hhDiSWaCCKqHdfyt1os43Oe9CUA0fBEjxAfjR/Vtl14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757993959; c=relaxed/simple;
	bh=MZdN0kleD+FahyHOnpWTRNVtqzTdWRIS/fR34Lrxtfo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dj/9KxxHmAbN6dXdOi+tok9iNZ0u3tNGnkoTOVQN+iPnCSDtDiQ6XkYmtSz3VvZULsTzqXQw/asVQ4bvOJQpU9GqVAKeoU+wbxHHPkJ0AUVXAt1QLFMMfgqeWjyYYRTvT+h7h908i0Bm6MzezTisoBDoL0IpCChJM26rDVhP7ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b38cb98c92ae11f0b29709d653e92f7d-20250916
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:3604f999-9808-48df-b45d-3a85549b45f7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:c5e6077d98a1bf41d9fdb17f68eb76d9,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b38cb98c92ae11f0b29709d653e92f7d-20250916
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1502857968; Tue, 16 Sep 2025 11:39:08 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 189E4E009009;
	Tue, 16 Sep 2025 11:39:08 +0800 (CST)
X-ns-mid: postfix-68C8DBDB-949057308
Received: from localhost.localdomain (unknown [10.42.20.31])
	by mail.kylinos.cn (NSMail) with ESMTPA id 135FEE009008;
	Tue, 16 Sep 2025 11:39:07 +0800 (CST)
From: pengyu <pengyu@kylinos.cn>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Cc: longman@redhat.com,
	linux-kernel@vger.kernel.org,
	Yu Peng <pengyu@kylinos.cn>
Subject: [PATCH] locking/qspinlock: use xchg with _mb in slowpath for arm64
Date: Tue, 16 Sep 2025 11:39:03 +0800
Message-Id: <20250916033903.3374794-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Yu Peng <pengyu@kylinos.cn>

A hardlock detected on arm64: rq->lock was released, but a CPU
blocked at mcs_node->locked and timed out.

We found xchg_tail and atomic_try_cmpxchg_relaxed used _relaxed
versions without memory barriers. Suspected insufficient coherence
guarantees on some arm64 microarchitectures, potentially leading to
the following issues occurred:

CPU0:                                           CPU1:
// Set tail to CPU0
old =3D xchg_tail(lock, tail);

//CPU0 read tail is itself
if ((val & _Q_TAIL_MASK) =3D=3D tail)
                                                // CPU1 exchanges the tai=
l
                                                old =3D xchg_tail(lock, t=
ail)
//assuming CPU0 not see tail change
atomic_try_cmpxchg_relaxed(
	  &lock->val, &val, _Q_LOCKED_VAL)
//released without notifying CPU1
goto release;
                                                //hardlock detected
                                                arch_mcs_spin_lock_conten=
ded(
                                                      &node->locked)

Therefore, xchg_tail and atomic_try_cmpxchg using _mb to replace _relaxed=
.

Signed-off-by: pengyu <pengyu@kylinos.cn>
---
 kernel/locking/qspinlock.c | 4 ++++
 kernel/locking/qspinlock.h | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index af8d122bb649..5e0c489d0d81 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -350,7 +350,11 @@ void __lockfunc queued_spin_lock_slowpath(struct qsp=
inlock *lock, u32 val)
 	 *       PENDING will make the uncontended transition fail.
 	 */
 	if ((val & _Q_TAIL_MASK) =3D=3D tail) {
+#if defined(CONFIG_ARM64)
+		if (atomic_try_cmpxchg(&lock->val, &val, _Q_LOCKED_VAL))
+#else
 		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
+#endif
 			goto release; /* No contention */
 	}

diff --git a/kernel/locking/qspinlock.h b/kernel/locking/qspinlock.h
index d69958a844f7..c89a6877b96b 100644
--- a/kernel/locking/qspinlock.h
+++ b/kernel/locking/qspinlock.h
@@ -113,12 +113,17 @@ static __always_inline void clear_pending_set_locke=
d(struct qspinlock *lock)
  */
 static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 {
+#if defined(CONFIG_ARM64)
+	return (u32)xchg(&lock->tail,
+				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
+#else
 	/*
 	 * We can use relaxed semantics since the caller ensures that the
 	 * MCS node is properly initialized before updating the tail.
 	 */
 	return (u32)xchg_relaxed(&lock->tail,
 				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
+#endif
 }

 #else /* _Q_PENDING_BITS =3D=3D 8 */

2.25.1


