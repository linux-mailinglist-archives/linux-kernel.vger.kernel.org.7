Return-Path: <linux-kernel+bounces-830750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9970BB9A725
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12AAC4C51EA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A743093BF;
	Wed, 24 Sep 2025 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SMla2dgR"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0200630C620
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726019; cv=none; b=r7rNPyZ5ze8J+zdpqXocY5cZmrV4DLhfhtYGmQKzpH8uK9dk7KLMrpujLZadvpi7svB8p7ITHt7SluapNfusJQ1reyFDsLkWnShyTrH3zALasFFRVnxkjaKYlPIngTPLelBZK+QLnj7e0krhzAglhz4/n2iGt+Tg7zI5TGqBPKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726019; c=relaxed/simple;
	bh=WAlqU5MUhsOddpJHILI64wsY53VfyKgPLsAmAN+Sb+U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NrPB9WG5ramvjWIIrfGB0gLHjdcq2iqdAQN0ANsXp0nDpCBVngG2u0dqXFStlL75TZOgTVwBnpMpmOZRu4M3fIRVR5CsFUFDwA3q5wD7E+uUqLQZdX4T+VMALvXCtDVoabM2lGqG7hpKY5qHB+h/0lKW+MAdB7KL5d8YSOdGZXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SMla2dgR; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45f2a1660fcso54922485e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758726015; x=1759330815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WTuaOxSTe3tk5TxQgOGSdVxjdMn4okuwwVefzm7d4xQ=;
        b=SMla2dgRZNa4sEWqHj8dm9tnFVf8J+ZiJGa3iGcCMSyPQgq3TBtiEtJhgk2SLhpFqM
         utLlGXSMdx0NjSX0R+gCwY8gODVcqRDz73+vWaFluczNGJpKHls+NdQ+yZHw4VKjYyHO
         3RydyaajLnegbB0nR0WiZAP5ClFfTP3CgPGF4MZ7Ds/h8tZdTXui4/ugf8CkmMfPrb+m
         Z+TEsxExrWDLAe91Meeur7630VZ/HLKfqh91gp3wK26cxRjl4tns2uSOOdi5FzlwsopJ
         cgv7w7auUURspndp9WXDGf9xc8yiT9vmuZjc/TMZfrt/ILIuS0xHK2C/TUMnl/NoSYXZ
         igbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726015; x=1759330815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTuaOxSTe3tk5TxQgOGSdVxjdMn4okuwwVefzm7d4xQ=;
        b=UIFn2/GducBpyejgoYkAOK0DaJKLYnqyQeDEe6U8Q24c2WGLtE1buMRFAKwmp55CrQ
         YYN14Mj3QvtBPPq2hAbbMXxCfhCTWTfObHjRfd2in20QeOKT5KwWEsOTDU62K9DsahJf
         Vs9TMo81mR/NjXgLE6ArKjvGW73gOIgnD17MyrspTAcRNkckOqi07FqtwAwJJw9Jf5lo
         n8fgoPh/i/BzVYs4nGqR4DA10uxzj8rjGWdYjjKIciZV53zh+xiWSm6rHbsJeiX6DzSJ
         ryyF0AKykm+mmNs71fUBi5ix/hhJeZJdGb/rF+i14z5AdBE6Puvf+gu2bJGTT+Lyn85T
         GeNw==
X-Forwarded-Encrypted: i=1; AJvYcCVisTX+ysWazmmKRv3JTudtYa7NjzTACLEIt1As8++Z2Dw1L7Y0+12q2ppw1N5abSTiBF/Esr27NB25rOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN6zVTyznyisdgSSyI1Eg1Wbr6Z1Q7ImAWNeV7gkZw4CcVQzD3
	uU/iUzT1XhmZY+UrJktLcOAyHDBAQwXK86jAt0HphKMjUYKTzopp8jjojPoO63J53L7/yRuylsb
	JwFX19nKkYCVUkw==
X-Google-Smtp-Source: AGHT+IGt9WJr9xVKvOK+GVvGrHodYbNw3zG+dtfOGTSv7cY+ZO1ThruN4S0CmXEkR5GVWAqvIrk4jx4s1l+ufA==
X-Received: from wrvw4.prod.google.com ([2002:a5d:5444:0:b0:3eb:7d34:3d1d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5d07:0:b0:3fe:1d64:1871 with SMTP id ffacd0b85a97d-40e4911408fmr239735f8f.43.1758726014660;
 Wed, 24 Sep 2025 08:00:14 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:59:42 +0000
In-Reply-To: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250924-b4-asi-page-alloc-v1-7-2d861768041f@google.com>
Subject: [PATCH 07/21] mm: introduce for_each_free_list()
From: Brendan Jackman <jackmanb@google.com>
To: jackmanb@google.com, Andy Lutomirski <luto@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	mingo@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org, 
	david@redhat.com, derkling@google.com, junaids@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, reijiw@google.com, 
	rientjes@google.com, rppt@kernel.org, vbabka@suse.cz, x86@kernel.org, 
	yosry.ahmed@linux.dev
Content-Type: text/plain; charset="utf-8"

Later patches will rearrange the free areas, but there are a couple of
places that iterate over them with the assumption that they have the
current structure.

It seems ideally, code outside of mm should not be directly aware of
struct free_area in the first place, but that awareness seems relatively
harmless so just make the minimal change.

Now instead of letting users manually iterate over the free lists, just
provide a macro to do that. Then adopt that macro in a couple of places.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/linux/mmzone.h  |  9 ++++++---
 kernel/power/snapshot.c |  7 +++----
 mm/mm_init.c            | 11 +++++++----
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 7fb7331c57250782a464a9583c6ea4867f4ffdab..02f5e8cc40c78ac8b81bb5c6f9af8718b1ffb316 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -123,9 +123,12 @@ static inline bool migratetype_is_mergeable(int mt)
 	return mt < MIGRATE_PCPTYPES;
 }
 
-#define for_each_migratetype_order(order, type) \
-	for (order = 0; order < NR_PAGE_ORDERS; order++) \
-		for (type = 0; type < MIGRATE_TYPES; type++)
+#define for_each_free_list(list, zone) \
+	for (unsigned int order = 0; order < NR_PAGE_ORDERS; order++) \
+		for (unsigned int type = 0; \
+		     list = &zone->free_area[order].free_list[type], \
+		     type < MIGRATE_TYPES; \
+		     type++) \
 
 extern int page_group_by_mobility_disabled;
 
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 645f42e404789286ffa751f083e97e52a4e4cf7e..40a7064eb6b247f47ca02211f8347cbd605af590 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1244,8 +1244,8 @@ unsigned int snapshot_additional_pages(struct zone *zone)
 static void mark_free_pages(struct zone *zone)
 {
 	unsigned long pfn, max_zone_pfn, page_count = WD_PAGE_COUNT;
+	struct list_head *free_list;
 	unsigned long flags;
-	unsigned int order, t;
 	struct page *page;
 
 	if (zone_is_empty(zone))
@@ -1269,9 +1269,8 @@ static void mark_free_pages(struct zone *zone)
 			swsusp_unset_page_free(page);
 	}
 
-	for_each_migratetype_order(order, t) {
-		list_for_each_entry(page,
-				&zone->free_area[order].free_list[t], buddy_list) {
+	for_each_free_list(free_list, zone) {
+		list_for_each_entry(page, free_list, buddy_list) {
 			unsigned long i;
 
 			pfn = page_to_pfn(page);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 3db2dea7db4c57c81f3fc3b71f0867025edda655..9554b79d0946a4a1a2ac5c934c1f80d2dc91b087 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1435,11 +1435,14 @@ static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx,
 
 static void __meminit zone_init_free_lists(struct zone *zone)
 {
-	unsigned int order, t;
-	for_each_migratetype_order(order, t) {
-		INIT_LIST_HEAD(&zone->free_area[order].free_list[t]);
+	struct list_head *list;
+	unsigned int order;
+
+	for_each_free_list(list, zone)
+		INIT_LIST_HEAD(list);
+
+	for (order = 0; order < NR_PAGE_ORDERS; order++)
 		zone->free_area[order].nr_free = 0;
-	}
 
 #ifdef CONFIG_UNACCEPTED_MEMORY
 	INIT_LIST_HEAD(&zone->unaccepted_pages);

-- 
2.50.1


