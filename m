Return-Path: <linux-kernel+bounces-591830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFE9A7E5BC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 18:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CBBD444E54
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 16:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DC9205E11;
	Mon,  7 Apr 2025 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4ec82Xb6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ehBqtjsJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5368207DE0
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041481; cv=none; b=uQdxgbgl1svfoMuXy508ZvOctWzkrzyC5p+EHAZAon6Nsi6nBNSl/yUmcpJVHggqI38ZgDwekDnAiEQ3mDbQ7XXN0EYfyFYUWPAL+6TnQ2+G2W3u2vqQo1upjJz9PRURcegXDkNkgS3kEpmr8mXNZlQqkKhCTHe7Q/AxSEEAJU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041481; c=relaxed/simple;
	bh=pIndLKzebnUP3ODsp0I+7Tu3RMNKx0QH3ChxE3RDwos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1ttWaGDd1GmiTpJgrrkTlhovmvMx6D34XpVxI62feUnM9KdxlqgpNFNqakuCkhhSpWxGABgwAISrpoCAMd/w24xiuIW++5y0irhRtQhIRPhNerOuH52OXpvHtuwIWpzqZGKED9WW1Wo9SvMyWp88r6NoCA9E1cz6RMqvUwpmuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4ec82Xb6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ehBqtjsJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744041473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9XbgHWbOAgHW1o4gwB+l0IjnozyUAWxbDLxKCrwikqo=;
	b=4ec82Xb6g5K7aQRFd4T+RO5KPNcmuvRqK60hMDO3U06+F6cLP6VOEtkoyd+oy6yZVmLToj
	zCnX5oncrUtDRS9qDGhnXncSDQ3skOPiHyozdkX+HambGFnSUnldMkjKGbsZxGvJVPdkZl
	NeLcjXjnYa+oiXbQwpw1xxVLIv9Giomc8PCkfjM4TnPp++l5sH7u2njzn+qbFCJJmJXtPy
	PaqiTyA3AP4VEMVIUOzwvoKwWObsYjxGUzI1pO+MIjX75Ba+egg8duQuRFGPHOY9XgG1PA
	BKeImqhMDgWFClzabXi4phAjEuZMIvJWu7SqmNg9gj617usxyxalhwAE5B1dpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744041473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9XbgHWbOAgHW1o4gwB+l0IjnozyUAWxbDLxKCrwikqo=;
	b=ehBqtjsJlv6CAPjjLjPsVxg7ccB5ySV66HW1QAOYcbpq7OHBL5ILLEZZYSJ2Zqt88Quh5s
	xQeMSY2M6FsU5HBg==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v11 16/19] futex: Implement FUTEX2_MPOL
Date: Mon,  7 Apr 2025 17:57:39 +0200
Message-ID: <20250407155742.968816-17-bigeasy@linutronix.de>
In-Reply-To: <20250407155742.968816-1-bigeasy@linutronix.de>
References: <20250407155742.968816-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Zijlstra <peterz@infradead.org>

Extend the futex2 interface to be aware of mempolicy.

When FUTEX2_MPOL is specified and there is a MPOL_PREFERRED or
home_node specified covering the futex address, use that hash-map.

Notably, in this case the futex will go to the global node hashtable,
even if it is a PRIVATE futex.

When FUTEX2_NUMA|FUTEX2_MPOL is specified and the user specified node
value is FUTEX_NO_NODE, the MPOL lookup (as described above) will be
tried first before reverting to setting node to the local node.

[bigeasy: add CONFIG_FUTEX_MPOL ]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/mmap_lock.h  |   4 ++
 include/uapi/linux/futex.h |   2 +-
 init/Kconfig               |   5 ++
 kernel/futex/core.c        | 112 +++++++++++++++++++++++++++++++------
 kernel/futex/futex.h       |   4 ++
 5 files changed, 108 insertions(+), 19 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 4706c67699027..e0eddfd306ef3 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -7,6 +7,7 @@
 #include <linux/rwsem.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/types.h>
+#include <linux/cleanup.h>
=20
 #define MMAP_LOCK_INITIALIZER(name) \
 	.mmap_lock =3D __RWSEM_INITIALIZER((name).mmap_lock),
@@ -211,6 +212,9 @@ static inline void mmap_read_unlock(struct mm_struct *m=
m)
 	up_read(&mm->mmap_lock);
 }
=20
+DEFINE_GUARD(mmap_read_lock, struct mm_struct *,
+	     mmap_read_lock(_T), mmap_read_unlock(_T))
+
 static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
 {
 	__mmap_lock_trace_released(mm, false);
diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index 0435025beaae8..247c425e175ef 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -63,7 +63,7 @@
 #define FUTEX2_SIZE_U32		0x02
 #define FUTEX2_SIZE_U64		0x03
 #define FUTEX2_NUMA		0x04
-			/*	0x08 */
+#define FUTEX2_MPOL		0x08
 			/*	0x10 */
 			/*	0x20 */
 			/*	0x40 */
diff --git a/init/Kconfig b/init/Kconfig
index b308b98d79347..174633bc9810b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1704,6 +1704,11 @@ config FUTEX_PRIVATE_HASH
 	depends on FUTEX && !BASE_SMALL && MMU
 	default y
=20
+config FUTEX_MPOL
+	bool
+	depends on FUTEX && NUMA
+	default y
+
 config EPOLL
 	bool "Enable eventpoll support" if EXPERT
 	default y
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 5ab2713ac906f..5b8609c8729e7 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -43,6 +43,8 @@
 #include <linux/slab.h>
 #include <linux/prctl.h>
 #include <linux/rcuref.h>
+#include <linux/mempolicy.h>
+#include <linux/mmap_lock.h>
=20
 #include "futex.h"
 #include "../locking/rtmutex_common.h"
@@ -321,6 +323,73 @@ struct futex_hash_bucket *futex_hash(union futex_key *=
key)
=20
 #endif /* CONFIG_FUTEX_PRIVATE_HASH */
=20
+#ifdef CONFIG_FUTEX_MPOL
+static int __futex_key_to_node(struct mm_struct *mm, unsigned long addr)
+{
+	struct vm_area_struct *vma =3D vma_lookup(mm, addr);
+	struct mempolicy *mpol;
+	int node =3D FUTEX_NO_NODE;
+
+	if (!vma)
+		return FUTEX_NO_NODE;
+
+	mpol =3D vma_policy(vma);
+	if (!mpol)
+		return FUTEX_NO_NODE;
+
+	switch (mpol->mode) {
+	case MPOL_PREFERRED:
+		node =3D first_node(mpol->nodes);
+		break;
+	case MPOL_PREFERRED_MANY:
+	case MPOL_BIND:
+		if (mpol->home_node !=3D NUMA_NO_NODE)
+			node =3D mpol->home_node;
+		break;
+	default:
+		break;
+	}
+
+	return node;
+}
+
+static int futex_key_to_node_opt(struct mm_struct *mm, unsigned long addr)
+{
+	int seq, node;
+
+	guard(rcu)();
+
+	if (!mmap_lock_speculate_try_begin(mm, &seq))
+		return -EBUSY;
+
+	node =3D __futex_key_to_node(mm, addr);
+
+	if (mmap_lock_speculate_retry(mm, seq))
+		return -EAGAIN;
+
+	return node;
+}
+
+static int futex_mpol(struct mm_struct *mm, unsigned long addr)
+{
+	int node;
+
+	node =3D futex_key_to_node_opt(mm, addr);
+	if (node >=3D FUTEX_NO_NODE)
+		return node;
+
+	guard(mmap_read_lock)(mm);
+	return __futex_key_to_node(mm, addr);
+}
+#else /* !CONFIG_FUTEX_MPOL */
+
+static int futex_mpol(struct mm_struct *mm, unsigned long addr)
+{
+	return FUTEX_NO_NODE;
+}
+
+#endif /* CONFIG_FUTEX_MPOL */
+
 /**
  * __futex_hash - Return the hash bucket
  * @key:	Pointer to the futex key for which the hash is calculated
@@ -335,18 +404,20 @@ struct futex_hash_bucket *futex_hash(union futex_key =
*key)
 static struct futex_hash_bucket *
 __futex_hash(union futex_key *key, struct futex_private_hash *fph)
 {
-	struct futex_hash_bucket *hb;
+	int node =3D key->both.node;
 	u32 hash;
-	int node;
=20
-	hb =3D __futex_hash_private(key, fph);
-	if (hb)
-		return hb;
+	if (node =3D=3D FUTEX_NO_NODE) {
+		struct futex_hash_bucket *hb;
+
+		hb =3D __futex_hash_private(key, fph);
+		if (hb)
+			return hb;
+	}
=20
 	hash =3D jhash2((u32 *)key,
 		      offsetof(typeof(*key), both.offset) / sizeof(u32),
 		      key->both.offset);
-	node =3D key->both.node;
=20
 	if (node =3D=3D FUTEX_NO_NODE) {
 		/*
@@ -494,27 +565,32 @@ int get_futex_key(u32 __user *uaddr, unsigned int fla=
gs, union futex_key *key,
 	if (unlikely(should_fail_futex(fshared)))
 		return -EFAULT;
=20
+	node =3D FUTEX_NO_NODE;
+
 	if (flags & FLAGS_NUMA) {
 		u32 __user *naddr =3D uaddr + size / 2;
=20
 		if (futex_get_value(&node, naddr))
 			return -EFAULT;
=20
-		if (node =3D=3D FUTEX_NO_NODE) {
-			node =3D numa_node_id();
-			if (futex_put_value(node, naddr))
-				return -EFAULT;
-
-		} else if (node >=3D MAX_NUMNODES || !node_possible(node)) {
+		if (node >=3D MAX_NUMNODES || !node_possible(node))
 			return -EINVAL;
-		}
-
-		key->both.node =3D node;
-
-	} else {
-		key->both.node =3D FUTEX_NO_NODE;
 	}
=20
+	if (node =3D=3D FUTEX_NO_NODE && (flags & FLAGS_MPOL))
+		node =3D futex_mpol(mm, address);
+
+	if (flags & FLAGS_NUMA) {
+		u32 __user *naddr =3D uaddr + size / 2;
+
+		if (node =3D=3D FUTEX_NO_NODE)
+			node =3D numa_node_id();
+		if (futex_put_value(node, naddr))
+			return -EFAULT;
+	}
+
+	key->both.node =3D node;
+
 	/*
 	 * PROCESS_PRIVATE futexes are fast.
 	 * As the mm cannot disappear under us and the 'key' only needs
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index acc7953678898..004e4dbee4f93 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -39,6 +39,7 @@
 #define FLAGS_HAS_TIMEOUT	0x0040
 #define FLAGS_NUMA		0x0080
 #define FLAGS_STRICT		0x0100
+#define FLAGS_MPOL		0x0200
=20
 /* FUTEX_ to FLAGS_ */
 static inline unsigned int futex_to_flags(unsigned int op)
@@ -67,6 +68,9 @@ static inline unsigned int futex2_to_flags(unsigned int f=
lags2)
 	if (flags2 & FUTEX2_NUMA)
 		flags |=3D FLAGS_NUMA;
=20
+	if (flags2 & FUTEX2_MPOL)
+		flags |=3D FLAGS_MPOL;
+
 	return flags;
 }
=20
--=20
2.49.0


