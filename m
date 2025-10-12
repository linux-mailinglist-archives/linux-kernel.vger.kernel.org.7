Return-Path: <linux-kernel+bounces-849751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 299D6BD0CAA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 23:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A067E3BF20D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84822475CB;
	Sun, 12 Oct 2025 21:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CLnPvS/x"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01095235063
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 21:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760304271; cv=none; b=niVHM8E8FEKp/6sMd8V6YPOOyCQYq2we11sEKwG+rYdTDDGNu0S/h/I5W8xF3QJFAAHvqlADNSFE8Ew255ETOrRA0tKbU4TNWLqmnweDU/JwkAkjVeQKGzJI345WcWNOlhS70fropPv5LT8t31HA12N8RxPecXK9oEYlp4U49Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760304271; c=relaxed/simple;
	bh=5Aab4a69dI91R6PuKaJ9VuWaPXFyB6Ov8v4M3CyBg2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8qVhqEEIiMp0Onz7ypX1BahjXwQtWhHP9qlTzsV53KqJTqV2UN1CqnMOkCfzBL03YeqgqK7wKMO5y+bTUISN94z2FEi59NqrRWXt3dqHR+I4wMT5E/KdJ8u68atzHivAB95314sLRCXx9Z1mZoBclGZj7ngPT7rXOiRMy8CJmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CLnPvS/x; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760304267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5l/Nb9kVvBLievHWD8SolIsSd40A68uARxnurr3QvOA=;
	b=CLnPvS/xiPfXZlMj7iW1BS00IcDFqkerG/04r0bRkQNl0VZ+VyygBiuK8IjYuD9rVEsJ9a
	wLKYlphKRxm9J+cIvG5FRNXUwZ4KPFpXJELRKbEa+uXh526OQrb+dixFhaIYHiES2J6aBx
	sGKaNqg5vSXRtTOOFhWTo7Wig3zoA9k=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v2 4/8] closures: kill closure.closure_get_happened
Date: Sun, 12 Oct 2025 17:24:07 -0400
Message-ID: <20251012212414.3225948-5-kent.overstreet@linux.dev>
In-Reply-To: <20251012212414.3225948-1-kent.overstreet@linux.dev>
References: <20251012212414.3225948-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

With closure_put() now using cmpxchg, this is no longer needed.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/alloc_foreground.h |  2 +-
 fs/bcachefs/fs-io-direct.c     |  1 -
 include/linux/closure.h        | 15 ++-------------
 lib/closure.c                  |  2 --
 4 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/fs/bcachefs/alloc_foreground.h b/fs/bcachefs/alloc_foreground.h
index 1b3fc8460096..5a6f0dfe3df5 100644
--- a/fs/bcachefs/alloc_foreground.h
+++ b/fs/bcachefs/alloc_foreground.h
@@ -311,7 +311,7 @@ void bch2_dev_alloc_debug_to_text(struct printbuf *, struct bch_dev *);
 void __bch2_wait_on_allocator(struct bch_fs *, struct closure *);
 static inline void bch2_wait_on_allocator(struct bch_fs *c, struct closure *cl)
 {
-	if (cl->closure_get_happened)
+	if (closure_nr_remaining(cl) > 1)
 		__bch2_wait_on_allocator(c, cl);
 }
 
diff --git a/fs/bcachefs/fs-io-direct.c b/fs/bcachefs/fs-io-direct.c
index 1f5154d9676b..e306eba734a1 100644
--- a/fs/bcachefs/fs-io-direct.c
+++ b/fs/bcachefs/fs-io-direct.c
@@ -117,7 +117,6 @@ static int bch2_direct_IO_read(struct kiocb *req, struct iov_iter *iter)
 	} else {
 		atomic_set(&dio->cl.remaining,
 			   CLOSURE_REMAINING_INITIALIZER + 1);
-		dio->cl.closure_get_happened = true;
 	}
 
 	dio->req	= req;
diff --git a/include/linux/closure.h b/include/linux/closure.h
index d0195570514a..83a0dde389bc 100644
--- a/include/linux/closure.h
+++ b/include/linux/closure.h
@@ -155,7 +155,6 @@ struct closure {
 	struct closure		*parent;
 
 	atomic_t		remaining;
-	bool			closure_get_happened;
 
 #ifdef CONFIG_DEBUG_CLOSURES
 #define CLOSURE_MAGIC_DEAD	0xc054dead
@@ -195,11 +194,7 @@ static inline unsigned closure_nr_remaining(struct closure *cl)
  */
 static inline void closure_sync(struct closure *cl)
 {
-#ifdef CONFIG_DEBUG_CLOSURES
-	BUG_ON(closure_nr_remaining(cl) != 1 && !cl->closure_get_happened);
-#endif
-
-	if (cl->closure_get_happened)
+	if (closure_nr_remaining(cl) > 1)
 		__closure_sync(cl);
 }
 
@@ -207,10 +202,7 @@ int __closure_sync_timeout(struct closure *cl, unsigned long timeout);
 
 static inline int closure_sync_timeout(struct closure *cl, unsigned long timeout)
 {
-#ifdef CONFIG_DEBUG_CLOSURES
-	BUG_ON(closure_nr_remaining(cl) != 1 && !cl->closure_get_happened);
-#endif
-	return cl->closure_get_happened
+	return closure_nr_remaining(cl) > 1
 		? __closure_sync_timeout(cl, timeout)
 		: 0;
 }
@@ -283,8 +275,6 @@ static inline void closure_queue(struct closure *cl)
  */
 static inline void closure_get(struct closure *cl)
 {
-	cl->closure_get_happened = true;
-
 #ifdef CONFIG_DEBUG_CLOSURES
 	BUG_ON((atomic_inc_return(&cl->remaining) &
 		CLOSURE_REMAINING_MASK) <= 1);
@@ -322,7 +312,6 @@ static inline void closure_init(struct closure *cl, struct closure *parent)
 		closure_get(parent);
 
 	atomic_set(&cl->remaining, CLOSURE_REMAINING_INITIALIZER);
-	cl->closure_get_happened = false;
 
 	closure_debug_create(cl);
 	closure_set_ip(cl);
diff --git a/lib/closure.c b/lib/closure.c
index c49d49916788..f1b4a797c9db 100644
--- a/lib/closure.c
+++ b/lib/closure.c
@@ -75,7 +75,6 @@ void closure_sub(struct closure *cl, int v)
 	}
 
 	if (s == CLOSURE_requeue) {
-		cl->closure_get_happened = false;
 		closure_queue(cl);
 	} else {
 		struct closure *parent = cl->parent;
@@ -126,7 +125,6 @@ bool closure_wait(struct closure_waitlist *waitlist, struct closure *cl)
 	if (atomic_read(&cl->remaining) & CLOSURE_WAITING)
 		return false;
 
-	cl->closure_get_happened = true;
 	closure_set_waiting(cl, _RET_IP_);
 	unsigned r = atomic_add_return(CLOSURE_WAITING + 1, &cl->remaining);
 	closure_val_checks(cl, r, CLOSURE_WAITING + 1);
-- 
2.51.0


