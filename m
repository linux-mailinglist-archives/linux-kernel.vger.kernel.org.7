Return-Path: <linux-kernel+bounces-870588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B12C0B326
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 21:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56523AA1E1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 20:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6F12FF66F;
	Sun, 26 Oct 2025 20:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W0yuZLMx"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B992FDC5D
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510984; cv=none; b=dQIvCgvWHIiXj4LBo1U6wAQFC0Cl0VV+dhdCJziMt+lvOQ4zUYwcWvznZ5di7qqgBKcJQ+gAPstHgQDkOa6P9vVPV/qIx/jVH1xdBSQgt8W1rq/tmwZm3bW0LJwaipdfM4KMgCl4t6xX/c3lW1/Ch8Jb+X8nwNTiFADQul11uEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510984; c=relaxed/simple;
	bh=QuxbnIJY4zttbFleGXLAX5MQ12fDQs4gIZS1TSv63Bk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G+ynWD94EL0gkKLj3IKa6XL4lMuhRYvqpIUGNjMfbwvDmX8thx61MUiWA1UsqY8lZw999OYevaZ37ddy6vAtgmSnquVtbOtEISGG+ra6Uxj0cUjm7Dkye/kgK+D2343i+pu4N0vxa4Rd2BwqFZiDYfe49E/li/hoDoYZ+WZxjpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W0yuZLMx; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-78484596ea3so47147807b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 13:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761510980; x=1762115780; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IMCyHr31TLzATbQuHg3ruEQF/2874D74tyKjOOWzy0s=;
        b=W0yuZLMxinVLKW1xISBfd9Vp0yxe4XroEJ5JAXOtme969TKaGeGJ2GktG7X2qogoKW
         mgBTAonZFO1uYsUCsDETNfvr3hNipazOVbXNojkQRMArY+hHs/iMXgxUubdxItfZxeTr
         2L9o3zOVuPPsplWPNspXDYQ8rntZGs6S74F8rUDQAjodP0jEsY6vVeK2HMENZyb8HVJz
         uCOROT0hNQiBbD+50VPh/NPSHecMwVLY1wZI6ponRgK/peVLE0jCFFRSh3zVZbzSqnLQ
         939LLxl1mNaq6rWFlP8V31lXwnF8KdIVFH2jFbDN6UXsa+QO1SQ6+hrvHNfvRKCL/acS
         6EPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761510980; x=1762115780;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMCyHr31TLzATbQuHg3ruEQF/2874D74tyKjOOWzy0s=;
        b=iWoskHD3yNV3M6+/CRykA7D30ez8UhNSzH8bjc8Jn2YNTTgH84k6Pgom/wDcZRymED
         Nl8iAuiBUZo5+VxFSECjpIPrZ/CuIGZedQeW47/41ETwetI51igdVoOkkS7F5RGbgzOt
         ON9ynPJp+J5xIUtU2zk+uzPCUVXwaBj5Sbthppm6j7buOSwVGdNcn8/HnQy7qlslrENe
         p+XuB9tYT+bgblfbyhR6SBYWI6jIBLC2LwliLKeB3EBxdcyr1zXS64FE9OgMz0ucGbis
         3xnJKO7pJNh7A3jNjtKfGXxjcjHR8s586bztM9abdspjicgFTLp1Iq4Kupr9CCxjlw4q
         OVFw==
X-Forwarded-Encrypted: i=1; AJvYcCXp0GdiIpQ+bazRSZa6DmPPC1uzhoksBeIeRDOTcaoSGo76psO34Wzt3DfYLAypcXPU4PsNnOI93uA91n0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7y5u+CkoJtKbRXp5poPwczsI2rsqWRmnwdCFGCfOE6dijZFIu
	jzFg9qwugih0nqcnnS7xRcOmQLiORvh/IJkyRjseoexA68Jc80x5GWq5NRJtONmto05FgjZkmjf
	2BsjMcA==
X-Google-Smtp-Source: AGHT+IHpMr9cFr0H62WPICb/ViZzGU3rsCsk6GeJaW1ZdGu5t8yZ0ftElBAnf4rqpT99zJhDJFFFka8CTI4=
X-Received: from ywa1.prod.google.com ([2002:a05:690c:9401:b0:785:bb80:f2f5])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:f88:b0:784:9419:2787
 with SMTP id 00721157ae682-78494193880mr250052107b3.69.1761510979847; Sun, 26
 Oct 2025 13:36:19 -0700 (PDT)
Date: Sun, 26 Oct 2025 13:36:05 -0700
In-Reply-To: <20251026203611.1608903-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251026203611.1608903-1-surenb@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251026203611.1608903-3-surenb@google.com>
Subject: [PATCH v2 2/8] mm/cleancache: add cleancache LRU for folio aging
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, alexandru.elisei@arm.com, peterx@redhat.com, sj@kernel.org, 
	rppt@kernel.org, mhocko@suse.com, corbet@lwn.net, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, jack@suse.cz, 
	willy@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	hannes@cmpxchg.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	minchan@kernel.org, surenb@google.com, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"

Once all folios in the cleancache are used to store data from previously
evicted folios, no more data can be stored there. To avoid that situation
we can drop older data and make space for new one.
Add an LRU for cleancache folios to reclaim the oldest folio when
cleancache is full and we need to store a new folio.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Minchan Kim <minchan@google.com>
---
 mm/cleancache.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/mm/cleancache.c b/mm/cleancache.c
index 26fb91b987b7..3acf46c0cdd1 100644
--- a/mm/cleancache.c
+++ b/mm/cleancache.c
@@ -18,6 +18,13 @@
  *
  *	ccinode->folios.xa_lock
  *		pool->lock
+ *
+ *	ccinode->folios.xa_lock
+ *		lru_lock
+ *
+ *	ccinode->folios.xa_lock
+ *		lru_lock
+ *			pool->lock
  */
 
 #define INODE_HASH_BITS		6
@@ -58,6 +65,8 @@ static struct kmem_cache *slab_inode; /* cleancache_inode slab */
 static struct cleancache_pool pools[CLEANCACHE_MAX_POOLS];
 static atomic_t nr_pools = ATOMIC_INIT(0);
 static DEFINE_SPINLOCK(pools_lock); /* protects pools */
+static LIST_HEAD(cleancache_lru);
+static DEFINE_SPINLOCK(lru_lock); /* protects cleancache_lru */
 
 static inline void init_cleancache_folio(struct folio *folio, int pool_id)
 {
@@ -73,6 +82,7 @@ static inline void clear_cleancache_folio(struct folio *folio)
 {
 	/* Folio must be detached and not in the pool. No locking is needed. */
 	VM_BUG_ON(folio->cc_inode);
+	VM_BUG_ON(!list_empty(&folio->lru));
 
 	folio->cc_pool_id = -1;
 }
@@ -123,6 +133,7 @@ static inline bool is_folio_attached(struct folio *folio)
 /*
  * Folio pool helpers.
  *	Only detached folios are stored in the pool->folio_list.
+ *	Once a folio gets attached, it's placed on the cleancache LRU list.
  *
  * Locking:
  *	pool->folio_list is accessed under pool->lock.
@@ -174,6 +185,32 @@ static struct folio *pick_folio_from_any_pool(void)
 	return folio;
 }
 
+/* Folio LRU helpers. Only attached folios are stored in the cleancache_lru. */
+static void add_folio_to_lru(struct folio *folio)
+{
+	VM_BUG_ON(!list_empty(&folio->lru));
+
+	spin_lock(&lru_lock);
+	list_add(&folio->lru, &cleancache_lru);
+	spin_unlock(&lru_lock);
+}
+
+static void rotate_lru_folio(struct folio *folio)
+{
+	spin_lock(&lru_lock);
+	if (!list_empty(&folio->lru))
+		list_move(&folio->lru, &cleancache_lru);
+	spin_unlock(&lru_lock);
+}
+
+static void delete_folio_from_lru(struct folio *folio)
+{
+	spin_lock(&lru_lock);
+	if (!list_empty(&folio->lru))
+		list_del_init(&folio->lru);
+	spin_unlock(&lru_lock);
+}
+
 /* FS helpers */
 static struct cleancache_fs *get_fs(int fs_id)
 {
@@ -306,6 +343,7 @@ static void erase_folio_from_inode(struct cleancache_inode *ccinode,
 
 	removed = __xa_erase(&ccinode->folios, offset);
 	VM_BUG_ON(!removed);
+	delete_folio_from_lru(folio);
 	remove_inode_if_empty(ccinode);
 }
 
@@ -403,6 +441,48 @@ static struct cleancache_inode *add_and_get_inode(struct cleancache_fs *fs,
 	return ccinode;
 }
 
+static struct folio *reclaim_folio_from_lru(void)
+{
+	struct cleancache_inode *ccinode;
+	struct folio *folio;
+	pgoff_t offset;
+
+again:
+	spin_lock(&lru_lock);
+	if (list_empty(&cleancache_lru)) {
+		spin_unlock(&lru_lock);
+		return NULL;
+	}
+	ccinode = NULL;
+	/* Get the ccinode of the folio at the LRU tail */
+	list_for_each_entry_reverse(folio, &cleancache_lru, lru) {
+		struct cleancache_pool *pool = folio_pool(folio);
+
+		/* Find and get ccinode */
+		spin_lock(&pool->lock);
+		folio_attachment(folio, &ccinode, &offset);
+		if (ccinode && !get_inode(ccinode))
+			ccinode = NULL;
+		spin_unlock(&pool->lock);
+		if (ccinode)
+			break;
+	}
+	spin_unlock(&lru_lock);
+
+	if (!ccinode)
+		return NULL; /* No ccinode to reclaim */
+
+	if (!isolate_folio_from_inode(ccinode, offset, folio)) {
+		/* Retry if the folio got erased from the ccinode */
+		put_inode(ccinode);
+		goto again;
+	}
+
+	put_inode(ccinode);
+
+	return folio;
+}
+
 static void copy_folio_content(struct folio *from, struct folio *to)
 {
 	void *src = kmap_local_folio(from, 0);
@@ -458,14 +538,19 @@ static bool store_into_inode(struct cleancache_fs *fs,
 			move_folio_from_inode_to_pool(ccinode, offset, stored_folio);
 			goto out_unlock;
 		}
+		rotate_lru_folio(stored_folio);
 	} else {
 		if (!workingset)
 			goto out_unlock;
 
 		stored_folio = pick_folio_from_any_pool();
 		if (!stored_folio) {
-			/* No free folios, TODO: try reclaiming */
-			goto out_unlock;
+			/* No free folios, try reclaiming */
+			xa_unlock(&ccinode->folios);
+			stored_folio = reclaim_folio_from_lru();
+			xa_lock(&ccinode->folios);
+			if (!stored_folio)
+				goto out_unlock;
 		}
 
 		if (!store_folio_in_inode(ccinode, offset, stored_folio)) {
@@ -477,6 +562,7 @@ static bool store_into_inode(struct cleancache_fs *fs,
 			spin_unlock(&pool->lock);
 			goto out_unlock;
 		}
+		add_folio_to_lru(stored_folio);
 	}
 	copy_folio_content(folio, stored_folio);
 
@@ -506,6 +592,7 @@ static bool load_from_inode(struct cleancache_fs *fs,
 	xa_lock(&ccinode->folios);
 	stored_folio = xa_load(&ccinode->folios, offset);
 	if (stored_folio) {
+		rotate_lru_folio(stored_folio);
 		copy_folio_content(stored_folio, folio);
 		ret = true;
 	}
-- 
2.51.1.851.g4ebd6896fd-goog


