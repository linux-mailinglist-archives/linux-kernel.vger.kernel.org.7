Return-Path: <linux-kernel+bounces-831018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E77CEB9B299
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D0E1B28031
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045DE237713;
	Wed, 24 Sep 2025 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLkA7KXO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539C821B9CD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737016; cv=none; b=XE55VAVkRUNPxzeBgO02seDPgpVB3rHh3vlbYNNJe5l2ihZ1KtmyofzCq1nXWAqSvlnE1RWojclFuU66A7EWSCRTiHXqDMNPYb04808epdiNqTlGe3Ut1bgbf+9CkOjzJ8Kxb3aYUFaiKv9sbmpd7PS/QKL7L38GdUz+8W04/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737016; c=relaxed/simple;
	bh=1EO9tcG9ijQpMygIESd/nn6nObEjJ91JKxTKFOK2bOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a2pRycgED4V0Q7a00M0jWh4LQaS7smAApfjsElryTgQUZySuv82cKOptjZvWBgYUU4l3xaGyIgoqgRFekcSXE5nyY6lKzEBFtcpV/t8jO3DJ8O68g8tI7lhqt+Tw7fXnsg1QAlowQ5Nl2I/4k+lsjLEDuBzBLd/Ux/xzh7NSliw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLkA7KXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EB6C4CEE7;
	Wed, 24 Sep 2025 18:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737015;
	bh=1EO9tcG9ijQpMygIESd/nn6nObEjJ91JKxTKFOK2bOU=;
	h=From:Date:Subject:To:Cc:From;
	b=VLkA7KXOFzg7fuaKggJj7Tk/PvoHr5RisY7P+e2NATN53JvAM8OHSmrdjF9G2NF+A
	 NgfrzxvQLdr1UHqVmtucBcSS/UG548oI0gw5IFPftxn5XBZfU4fq6UDW8u6Kbea/rL
	 N7uFmUDbDdJY/bf8w1S8UezyY1SBW6o7M0ziRI9d1PIGoYaxtxy/1WsJ9Cc9utDNGT
	 fSKL0cKTOG27hdVXPzZlmnwoAyY0K39fUp2Jo7zybrcdD6A2Aky/C02p1IE3KzaO7r
	 WFAEJJVOF8Kenrmh89xmiWAsfVs4RFZ8KVQGn0i+1dDVHFphVdGBFqVjbRepHNRTHU
	 YAXMIELUuu73Q==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 25 Sep 2025 03:03:23 +0900
Subject: [PATCH v2] locking/local_lock: s/l/__l/ and s/tl/__tl/ to reduce
 risk of shadowing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-local_lock_internal_fix_shadow-v2-1-d3b85ee775a4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGoy1GgC/42O3Q6CMAyFX4X02imMH4Ur38MQMqFCA2y6TdQQ3
 t0KL2CaNPnannM6g0NL6KAIZrA4kSOjGeQugLpTukVBDTPIUKZhLmMxmFoNFfe+Iu3RaqYbvSv
 Xqca8hESpZIJ5iscM2ORukbdrwKXc2OLjyTl+G8JVORS1GUfyRWAstaQPo3JsDT9BR84b+1kfn
 KJV8e8vUyS4EoyjuD6dVJKde77BYW9sC+WyLF8Ywv8r/gAAAA==
X-Change-ID: 20250923-local_lock_internal_fix_shadow-2e2a24e95e76
To: Vlastimil Babka <vbabka@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4569; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=1EO9tcG9ijQpMygIESd/nn6nObEjJ91JKxTKFOK2bOU=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBlXjIoNnnctP3e+IEjD4GOG6aYtkYs7KlUnrna9+vtB2
 3w7Pve2jlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABNZeovhN5ue4JMc1xaVe1/y
 +l78um+++pvPUjtP6dvadzr+2P7gEWL4H+WSqTZ7g9oSgQkHOs3s49/ZOFjlf/t0/PSJyJ6/uY5
 bWAA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

The Linux kernel coding style [1] advises to avoid common variable
names in function-like macros to reduce the risk of collisions.

Throughout local_lock_internal.h, several macros use the rather common
variable names 'l' and 'tl'. This already resulted in an actual
collision: the __local_lock_acquire() function like macro is currently
shadowing the parameter 'l' of the:

  class_##_name##_t class_##_name##_constructor(_type *l)

function factory from linux/cleanup.h.

Rename the variable 'l' to '__l' and the variable 'tl' to '__tl'
throughout the file to fix the current name collision and to prevent
future ones.

[1] https://www.kernel.org/doc/html/latest/process/coding-style.html#macros-enums-and-rtl

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changes in v2:

  - __lock conflicted with an existing definition in lockdep.c. Use
    instead __l (and also, to keep things consistent, use __tl instead
    of tl for the trylock).

  - Apply the renaming to the entire file and not just to
    __local_lock_acquire().

  - Rewrite the patch description accordingly.

Link to v1: https://lore.kernel.org/r/20250923-local_lock_internal_fix_shadow-v1-1-14e313c88a46@kernel.org
---
 include/linux/local_lock_internal.h | 56 ++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index d80b5306a2c0ccf95a3405b6b947b5f1f9a3bd38..a80b3fd7552376cd926aeaac8f53bcc44c8d2173 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -96,18 +96,18 @@ do {								\
 
 #define __local_lock_acquire(lock)					\
 	do {								\
-		local_trylock_t *tl;					\
-		local_lock_t *l;					\
+		local_trylock_t *__tl;					\
+		local_lock_t *__l;					\
 									\
-		l = (local_lock_t *)(lock);				\
-		tl = (local_trylock_t *)l;				\
+		__l = (local_lock_t *)(lock);				\
+		__tl = (local_trylock_t *)__l;				\
 		_Generic((lock),					\
 			local_trylock_t *: ({				\
-				lockdep_assert(tl->acquired == 0);	\
-				WRITE_ONCE(tl->acquired, 1);		\
+				lockdep_assert(__tl->acquired == 0);	\
+				WRITE_ONCE(__tl->acquired, 1);		\
 			}),						\
 			local_lock_t *: (void)0);			\
-		local_lock_acquire(l);					\
+		local_lock_acquire(__l);				\
 	} while (0)
 
 #define __local_lock(lock)					\
@@ -130,50 +130,50 @@ do {								\
 
 #define __local_trylock(lock)					\
 	({							\
-		local_trylock_t *tl;				\
+		local_trylock_t *__tl;				\
 								\
 		preempt_disable();				\
-		tl = (lock);					\
-		if (READ_ONCE(tl->acquired)) {			\
+		__tl = (lock);					\
+		if (READ_ONCE(__tl->acquired)) {		\
 			preempt_enable();			\
-			tl = NULL;				\
+			__tl = NULL;				\
 		} else {					\
-			WRITE_ONCE(tl->acquired, 1);		\
+			WRITE_ONCE(__tl->acquired, 1);		\
 			local_trylock_acquire(			\
-				(local_lock_t *)tl);		\
+				(local_lock_t *)__tl);		\
 		}						\
-		!!tl;						\
+		!!__tl;						\
 	})
 
 #define __local_trylock_irqsave(lock, flags)			\
 	({							\
-		local_trylock_t *tl;				\
+		local_trylock_t *__tl;				\
 								\
 		local_irq_save(flags);				\
-		tl = (lock);					\
-		if (READ_ONCE(tl->acquired)) {			\
+		__tl = (lock);					\
+		if (READ_ONCE(__tl->acquired)) {		\
 			local_irq_restore(flags);		\
-			tl = NULL;				\
+			__tl = NULL;				\
 		} else {					\
-			WRITE_ONCE(tl->acquired, 1);		\
+			WRITE_ONCE(__tl->acquired, 1);		\
 			local_trylock_acquire(			\
-				(local_lock_t *)tl);		\
+				(local_lock_t *)__tl);		\
 		}						\
-		!!tl;						\
+		!!__tl;						\
 	})
 
 #define __local_lock_release(lock)					\
 	do {								\
-		local_trylock_t *tl;					\
-		local_lock_t *l;					\
+		local_trylock_t *__tl;					\
+		local_lock_t *__l;					\
 									\
-		l = (local_lock_t *)(lock);				\
-		tl = (local_trylock_t *)l;				\
-		local_lock_release(l);					\
+		__l = (local_lock_t *)(lock);				\
+		__tl = (local_trylock_t *)__l;				\
+		local_lock_release(__l);				\
 		_Generic((lock),					\
 			local_trylock_t *: ({				\
-				lockdep_assert(tl->acquired == 1);	\
-				WRITE_ONCE(tl->acquired, 0);		\
+				lockdep_assert(__tl->acquired == 1);	\
+				WRITE_ONCE(__tl->acquired, 0);		\
 			}),						\
 			local_lock_t *: (void)0);			\
 	} while (0)

---
base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
change-id: 20250923-local_lock_internal_fix_shadow-2e2a24e95e76

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


