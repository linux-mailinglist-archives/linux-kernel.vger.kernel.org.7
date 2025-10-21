Return-Path: <linux-kernel+bounces-862953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FEFBF6A39
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DFBE542CE0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2C4339B36;
	Tue, 21 Oct 2025 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJZe6GGr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9C833970C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051605; cv=none; b=HDXQXk4nsmSWpiDSUYiOeRpxBPb8mWE3xCLsYGms4TSSEX67tMkEk1Hi+3UB006dgChehGx6iaUDQT083JZJjBFNK5aVyvZEFA+MuXB3Oax5OxMzudy4M08WgUGTBFpNlkdLokaENQAnoqoyFTu2XmB6pvRf2U/i2nv4HgTbljg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051605; c=relaxed/simple;
	bh=p9NQaEnTQkjOvytztuGwrp0tPWZa+D35cuLh/W8irHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/V64HWoDbW6nYbOHN6bBt5yJP3QEUGMotPnG0BXm7EWn6Lt9IEIsRhANbAyvINpvy5sISZ//O86P9Hqu4dg2mwU6z7HpvolpVdbqzs2CwHxy09Xf006I0Js2lD3Esj4FfYGHuI/kmai76377+V8zRTs3en6n37mW5IwzZsYC4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJZe6GGr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7dmjAOzzOKe+PWzSzDnov13uhbtuxj7aSoteYm9r0kM=;
	b=VJZe6GGrlBbN4TUWDsIKDX5xNdDwDrf0lwwh1wIJ1IVJDjNVRN5yhHUzN6pJhV8Xsrd5jV
	IdQ9R1x4lX7K2eSuwjvxtJFEYCrUxQA6PmOmRX8OlYiTooFjgBZbcypHahPG0fNCBXHjP2
	wh79ZbWCy8AxJmjsjIBtIPCvCziqnwM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-_mLPlig9OY64liH6lXlt3w-1; Tue, 21 Oct 2025 09:00:01 -0400
X-MC-Unique: _mLPlig9OY64liH6lXlt3w-1
X-Mimecast-MFC-AGG-ID: _mLPlig9OY64liH6lXlt3w_1761051600
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-426ce339084so4908461f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051600; x=1761656400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dmjAOzzOKe+PWzSzDnov13uhbtuxj7aSoteYm9r0kM=;
        b=fpT9xu46p0eHXzeLDOzRf60WcmETvKxQqJSXOXMYJjSkRgAk7NNqO4BH735gg1s+84
         nUvaLGXH+E0pZ3NxFTVqTHJPGioVNXIkIPPr0uv/qdGTmH9T0x1rAF4+oBkIEcJkuxve
         R2JNrEG53A9oWWqM48kebHXIswePg6oT+8/6PG35AqbZFUh1FCK4Q5ltg1dw143Pq+cT
         nOUKhX7d/uusr12G+TNOejAUBvIkBhFM8SHpbWI0pqPv0niPTXRTyUypRCSjrlprdAeo
         bLmUE6DV4yQrLnFJIzU+3KqNinnCI09VuPCqZXRzCqNVt+sbFARa3ME3f5uAkTpN2twh
         YLiQ==
X-Gm-Message-State: AOJu0YzbBUnLvw5uNtBAFXnjIO86oE2YlKCGYy75S3Y0L8QN27z0yh9/
	M6dLwz8SIVjRk/0XhEpNHWph9xo9bmC6DVyF25YEbgQwVokfQtOxfvMcF34K5zKxbT8ycOv7rUP
	TUAudNGY4zPtkFHqXguQc6b9YoZi6o8ybVfAkAgU7qFZeMF+6GhErYDxBxHrKBKA9Eqe3+502A6
	v1dDkkqXjPP9dqiLxZxAqDoPZJfZPlnKGResmPJlEG/m9a5g==
X-Gm-Gg: ASbGncvh3gl441KsH7E756m2xsajpA2DkOmRGrCRXOiDNLm43FFpRQoqN9rTLBphy50
	mndkTMEHHhupllzGDZOVr5+Rk434P5Ku1DmRy0/UhWZUf0YAE4ILfCTES2nR8jbTnEQjLENvmBO
	a8HL1OXfKL7pIUIugg0LQyJRLWiyNCr46VQadiKNipXNwp6ltnF6VIHAaYpo9gl6mXBNvV7q0B/
	Ug0BlSWYdr6tGDQJpS924I5K89g7DKw21X3bxdmo8H8r3GcQyEQq5KZ1Dprsk48arQi6NygtVNz
	a/cclHAt/zj83V7NxNN+JKxUWCngFMwAWmSTpztKzBB2JB1hjlFmGuqoqeKdQOLaH3IxVhDCe28
	owd2hzrxqTsgwfvzGK380yh77KWVJDd+q8xcWOxrVezAXcsG0zMGQhY4fenMw
X-Received: by 2002:a05:6000:2503:b0:425:825d:2c64 with SMTP id ffacd0b85a97d-42704d6c822mr11792000f8f.17.1761051599945;
        Tue, 21 Oct 2025 05:59:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfxO1MIMIHuEAyS8Hvj/zoSDSKI4v296mvX+6V2esc8bVwH2VAjXdgu+NOffYas4k+6n6n6g==
X-Received: by 2002:a05:6000:2503:b0:425:825d:2c64 with SMTP id ffacd0b85a97d-42704d6c822mr11791940f8f.17.1761051599346;
        Tue, 21 Oct 2025 05:59:59 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f00cdf6csm20134215f8f.43.2025.10.21.05.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:59:58 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v1 12/23] mm/balloon_compaction: remove balloon_page_push/pop()
Date: Tue, 21 Oct 2025 14:59:17 +0200
Message-ID: <20251021125929.377194-13-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021125929.377194-1-david@redhat.com>
References: <20251021125929.377194-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's remove these helpers as they are unused now.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h | 30 ------------------------------
 mm/balloon_compaction.c            |  5 ++---
 2 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 1452ea0635245..e5451cf1f6589 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -126,34 +126,4 @@ static inline void balloon_page_finalize(struct page *page)
 		set_page_private(page, 0);
 	/* PageOffline is sticky until the page is freed to the buddy. */
 }
-
-/*
- * balloon_page_push - insert a page into a page list.
- * @head : pointer to list
- * @page : page to be added
- *
- * Caller must ensure the page is private and protect the list.
- */
-static inline void balloon_page_push(struct list_head *pages, struct page *page)
-{
-	list_add(&page->lru, pages);
-}
-
-/*
- * balloon_page_pop - remove a page from a page list.
- * @head : pointer to list
- * @page : page to be added
- *
- * Caller must ensure the page is private and protect the list.
- */
-static inline struct page *balloon_page_pop(struct list_head *pages)
-{
-	struct page *page = list_first_entry_or_null(pages, struct page, lru);
-
-	if (!page)
-		return NULL;
-
-	list_del(&page->lru);
-	return page;
-}
 #endif /* _LINUX_BALLOON_COMPACTION_H */
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index c44e0b62203cc..90b2d61a593b7 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -128,9 +128,8 @@ EXPORT_SYMBOL_GPL(balloon_page_alloc);
  * Drivers must call this function to properly enqueue a new allocated balloon
  * page before definitively removing the page from the guest system.
  *
- * Drivers must not call balloon_page_enqueue on pages that have been pushed to
- * a list with balloon_page_push before removing them with balloon_page_pop. To
- * enqueue a list of pages, use balloon_page_list_enqueue instead.
+ * Drivers must not enqueue pages while page->lru is still in
+ * use, and must not use page->lru until a page was unqueued again.
  */
 void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
 			  struct page *page)
-- 
2.51.0


