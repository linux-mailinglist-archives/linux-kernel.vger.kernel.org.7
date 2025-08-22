Return-Path: <linux-kernel+bounces-782098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDA3B31B05
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33ACC16052E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A172FDC31;
	Fri, 22 Aug 2025 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="guVmW8Ao";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DU3RvPP6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA87305044
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871963; cv=none; b=gUDs5nPyBfkgWWuKkZVScNYA35WLNpVe7BhpAoddWJ6csRMpL3mNnwenWBC6ArpBW5Pq/rp8q0GsK9NsVjJrYy7wlbenXjDkqR0OFx20iGmLDpKLByjq8jtsXXl9T1CuHEVaxy813a16Q3IllZeMi9wbfY8vb5m5Z1OMee8ieWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871963; c=relaxed/simple;
	bh=H95vp4MfAQXB7bSHS8XL8SYVinnSgBBkXY8ras7FbSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5zeWMDPZxHU1Jz+jTrrfVPzQ//hZ6EaqOab7BAbLzW5oTQk3/pa8pK0hGwosHdFu7hZ78QnQaQymqlurXP0B+lBVFBTzVK4yQlso6ttpx47A1N678KfkxEgAaCKPutmYGvmaZNMEwdr00m+8UUD2V42WTceUp976XSwZsjuuWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=guVmW8Ao; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DU3RvPP6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Aug 2025 16:12:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755871959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bAQdGe767WDBTybeykhPZeWedB1d1YwoZ4Ay4neJaZY=;
	b=guVmW8AoYzayGb4qs8tIOqwNcr0By5UWWgh19uoFc4xARskKxGfccfmRR+jwo/fVLdJ0A2
	hktbVBiVK/K1KxSTnC+bICIpP5zgsQM6D0KVCROFSURfQvVHg95rwbP5t+snhsUo00z9pT
	iKygMaqOcc3Tqyhr4ZJVgX/1TFDubjDOyRcTnIMcaluoiXjvw48zUhLscMMuui8kYjelM4
	WrGwYspaP3nqZuWHlAmrOYuZe4Blfoql/J2ChYxCLRhjW6sRWgsZBFSEd1fY2sQ1xBdChp
	ulJeEtnhnZJnU/zlFhASaGoOJOi/nRTMemYfYl1zqcLXyS9XRVu21SAx5i/A+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755871959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bAQdGe767WDBTybeykhPZeWedB1d1YwoZ4Ay4neJaZY=;
	b=DU3RvPP69QQ+CyoLmg+iIoGw77g0YZmyGvuK5Ag9V9clGddjEYDx2VWNI9SDatcTUpiKF8
	+/BJI6liiDrC4iDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] futex: Move futex_hash_free() back to __mmput()
Message-ID: <20250822141238.PfnkTjFb@linutronix.de>
References: <20250809180207.GAaJeNHymvt6gaR5nY@fat_crate.local>
 <CAHk-=wi+X2A6K839AxrRvaCDCakya-2B68NTkYP5YGfi-h5EuQ@mail.gmail.com>
 <20250822105712.CRp0on1Y@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250822105712.CRp0on1Y@linutronix.de>

To avoid a memory leak via mm_alloc() + mmdrop() the futex cleanup code
has been moved to __mmdrop(). This resulted in a warnings if the futex
hash table has been allocated via vmalloc() the mmdrop() was invoked
from atomic context.
The free path must stay in __mmput() to ensure it is invoked from
preemptible context.

In order to avoid the memory leak, delay the allocation of
mm_struct::mm->futex_ref to futex_hash_allocate(). This works because
neither the per-CPU counter nor the private hash has been allocated and
therefore
- futex_private_hash() callers (such as exit_pi_state_list()) don't
  acquire reference if there is no private hash yet. There is also no
  reference put.

- Regular callers (futex_hash()) fallback to global hash. No reference
  counting here.

The futex_ref member can be allocated in futex_hash_allocate() before
the private hash itself is allocated. This happens either while the
first thread is created or on request. In both cases the process has
just a single thread so there can be either futex operation in progress
or the request to create a private hash.

Move futex_hash_free() back to __mmput();
Move the allocation of mm_struct::futex_ref to futex_hash_allocate().

Fixes:  e703b7e247503 ("futex: Move futex cleanup to __mmdrop()")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/all/20250821102721.6deae493@kernel.org/
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/fork.c       |  2 +-
 kernel/futex/core.c | 15 +++++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index af673856499dc..c4ada32598bd5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -689,7 +689,6 @@ void __mmdrop(struct mm_struct *mm)
 	mm_pasid_drop(mm);
 	mm_destroy_cid(mm);
 	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
-	futex_hash_free(mm);
 
 	free_mm(mm);
 }
@@ -1138,6 +1137,7 @@ static inline void __mmput(struct mm_struct *mm)
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
 	lru_gen_del_mm(mm);
+	futex_hash_free(mm);
 	mmdrop(mm);
 }
 
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index d9bb5567af0c5..fb63c13aa66fc 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1724,10 +1724,6 @@ int futex_mm_init(struct mm_struct *mm)
 	/* futex-ref */
 	atomic_long_set(&mm->futex_atomic, 0);
 	mm->futex_batches = get_state_synchronize_rcu();
-	mm->futex_ref = alloc_percpu(unsigned int);
-	if (!mm->futex_ref)
-		return -ENOMEM;
-	this_cpu_inc(*mm->futex_ref); /* 0 -> 1 */
 	return 0;
 }
 
@@ -1801,6 +1797,17 @@ static int futex_hash_allocate(unsigned int hash_slots, unsigned int flags)
 		}
 	}
 
+	if (!mm->futex_ref) {
+		/*
+		 * This will always be allocated by the first thread and
+		 * therefore requires no locking.
+		 */
+		mm->futex_ref = alloc_percpu(unsigned int);
+		if (!mm->futex_ref)
+			return -ENOMEM;
+		this_cpu_inc(*mm->futex_ref); /* 0 -> 1 */
+	}
+
 	fph = kvzalloc(struct_size(fph, queues, hash_slots),
 		       GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (!fph)
-- 
2.50.1


