Return-Path: <linux-kernel+bounces-830103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC6CB98BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C285A7A6F94
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E61A28725F;
	Wed, 24 Sep 2025 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZZzmNbZ5"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC642820A9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701020; cv=none; b=XWgvta5edJn5ktFNpWVpi5tHhTs7gP/ZtMtfbzMMbOJe6gv3cOfkB6Ny6PpFbBO0zT3Lpkraf69KlTtD0khtW+eLxd5I+cOPaAmASUEDMxzhbyvR2pI5lwmtg67nCaCnn6DhBRbTwftuzk+ycJ3HxElP2eCrSam4w21UMJ9eSmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701020; c=relaxed/simple;
	bh=Dj4FbPOjKoUO9qwih+rRobi26gAuZf8/S5EDW1kka+0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ExaUCx2AyArbVcRf24aL9omP6iz/npXxybIuKfsdAs5oIi4+YPe80KFzGm5qYJTZsXsQQE6tPAr1vVAlvufwaPHQ8bskSorIW4Ymv0+mZamvWpEgyXbioNg6PPBsPz0rQIBfSXnL/0r6IpRpFKe2z52kvOr6pQxWewB0stJEOcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZZzmNbZ5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=YnHzCz426qXvrptuKmkHrLzo2jAir+fJiymh/WcGuO0=; b=ZZzmNbZ5vEEx2uCOyOop4cBBHH
	a8PDGT6WEK4GO+o9r6ymYx1kKecmqZieTyvRy4f7uHj1GqfqU4AnJcT6xGdgUZQpcwsyHsEVy8Fy3
	JjG7yK6feAzDZvRExAjRkyKFYi+ZXoxQFIatUOzKUDI4i3J0Wke4GNAoozzBlhpOMQ1kYfwGe/wmt
	uC+wTu3yutIbUYv09PN3+PkpJfTOVzSEE+H0D+ICetjjfdeQGx3TdUuSsdflqd8dMxXsBYafuOzQn
	GdCPFhNaJ43II2UgB7fhEO3dqjvclD2UKljqZCi1qwiheCivTkzP1DAacmy7AQtiQ9OPBku7F66U/
	IEfAUS5w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1KTO-0000000BeEL-2WWv;
	Wed, 24 Sep 2025 08:03:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 25CDE303005; Wed, 24 Sep 2025 10:03:33 +0200 (CEST)
Message-ID: <20250924080119.384384486@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 24 Sep 2025 09:59:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org,
 rostedt@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: [PATCH 09/12] unwind: Make unwind_task_info::unwind_mask consistent
References: <20250924075948.579302904@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

The unwind_task_info::unwind_mask was manipulated using a mixture of:

  regular store
  WRITE_ONCE()
  try_cmpxchg()
  set_bit()
  atomic_long_*()

Clean up and make it consistently atomic_long_t.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/unwind_deferred.h       |    4 ++--
 include/linux/unwind_deferred_types.h |    3 ++-
 kernel/unwind/deferred.c              |   17 +++++++++--------
 3 files changed, 13 insertions(+), 11 deletions(-)

--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -46,7 +46,7 @@ void unwind_deferred_task_exit(struct ta
 static __always_inline void unwind_reset_info(void)
 {
 	struct unwind_task_info *info = &current->unwind_info;
-	unsigned long bits = info->unwind_mask;
+	unsigned long bits = atomic_long_read(&info->unwind_mask);
 
 	/* Was there any unwinding? */
 	if (likely(!bits))
@@ -56,7 +56,7 @@ static __always_inline void unwind_reset
 		/* Is a task_work going to run again before going back */
 		if (bits & UNWIND_PENDING)
 			return;
-	} while (!try_cmpxchg(&info->unwind_mask, &bits, 0UL));
+	} while (!atomic_long_try_cmpxchg(&info->unwind_mask, &bits, 0UL));
 	current->unwind_info.id.id = 0;
 
 	if (unlikely(info->cache)) {
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -3,6 +3,7 @@
 #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 
 #include <linux/types.h>
+#include <linux/atomic.h>
 
 struct unwind_cache {
 	unsigned long		unwind_completed;
@@ -32,7 +33,7 @@ union unwind_task_id {
 };
 
 struct unwind_task_info {
-	unsigned long		unwind_mask;
+	atomic_long_t		unwind_mask;
 	struct unwind_cache	*cache;
 	struct callback_head	work;
 	union unwind_task_id	id;
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -53,7 +53,7 @@ DEFINE_STATIC_SRCU(unwind_srcu);
 
 static inline bool unwind_pending(struct unwind_task_info *info)
 {
-	return test_bit(UNWIND_PENDING_BIT, &info->unwind_mask);
+	return atomic_long_read(&info->unwind_mask) & UNWIND_USED;
 }
 
 /*
@@ -142,7 +142,7 @@ int unwind_user_faultable(struct unwind_
 	cache->nr_entries = trace->nr;
 
 	/* Clear nr_entries on way back to user space */
-	set_bit(UNWIND_USED_BIT, &info->unwind_mask);
+	atomic_long_or(UNWIND_USED, &info->unwind_mask);
 
 	return 0;
 }
@@ -160,7 +160,7 @@ static void process_unwind_deferred(stru
 
 	/* Clear pending bit but make sure to have the current bits */
 	bits = atomic_long_fetch_andnot(UNWIND_PENDING,
-				  (atomic_long_t *)&info->unwind_mask);
+					&info->unwind_mask);
 	/*
 	 * From here on out, the callback must always be called, even if it's
 	 * just an empty trace.
@@ -265,7 +265,7 @@ int unwind_deferred_request(struct unwin
 
 	*cookie = get_cookie(info);
 
-	old = READ_ONCE(info->unwind_mask);
+	old = atomic_long_read(&info->unwind_mask);
 
 	/* Is this already queued or executed */
 	if (old & bit)
@@ -278,7 +278,7 @@ int unwind_deferred_request(struct unwin
 	 * to have a callback.
 	 */
 	bits = UNWIND_PENDING | bit;
-	old = atomic_long_fetch_or(bits, (atomic_long_t *)&info->unwind_mask);
+	old = atomic_long_fetch_or(bits, &info->unwind_mask);
 	if (old & bits) {
 		/*
 		 * If the work's bit was set, whatever set it had better
@@ -292,7 +292,7 @@ int unwind_deferred_request(struct unwin
 	ret = task_work_add(current, &info->work, twa_mode);
 
 	if (WARN_ON_ONCE(ret))
-		WRITE_ONCE(info->unwind_mask, 0);
+		atomic_long_set(&info->unwind_mask, 0);
 
 	return ret;
 }
@@ -324,7 +324,8 @@ void unwind_deferred_cancel(struct unwin
 	guard(rcu)();
 	/* Clear this bit from all threads */
 	for_each_process_thread(g, t) {
-		clear_bit(bit, &t->unwind_info.unwind_mask);
+		atomic_long_andnot(UNWIND_USED,
+				   &t->unwind_info.unwind_mask);
 		if (t->unwind_info.cache)
 			clear_bit(bit, &t->unwind_info.cache->unwind_completed);
 	}
@@ -354,7 +355,7 @@ void unwind_task_init(struct task_struct
 
 	memset(info, 0, sizeof(*info));
 	init_task_work(&info->work, unwind_deferred_task_work);
-	info->unwind_mask = 0;
+	atomic_long_set(&info->unwind_mask, 0);
 }
 
 void unwind_task_free(struct task_struct *task)



