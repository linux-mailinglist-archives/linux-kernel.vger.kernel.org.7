Return-Path: <linux-kernel+bounces-862947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F39D0BF69AF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C13704FE3F0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EC533769C;
	Tue, 21 Oct 2025 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hktEL/Yj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B440433710B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051592; cv=none; b=DCTkw9Dce6ZgHDDyV3+QsFToBu5Q9WJTH8qhsHGfU0bEakLgs5xiuzrpCBYHalR/hNHvtkH2hlb8G04ZmRnZFY953ZB0zau7aC1k89DLvVpi821NHCp3ClcCedGtCj11hWsw344mH8/RgqAtEjc8u0BBlw4PxHPdksFu350zujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051592; c=relaxed/simple;
	bh=YLWsOT/fjbA9n4u49rmVT4FCqZV2WT6/mBViN35ADWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDRVQFzUo7dVh6iAXxxwlal0cs43WzoWdZVouNnsShTNQPj8Wikl0D/kTgkWOLgc3HB7BzVjOjysZx72mng7MfEyJ5LlEO3xhilTRY5no5UiU7rdAUo6AWiPHyvtgqzsXQjjn5ARSlSoY+hr0080OgvxXcdgQNAzo0O/+Q1bw+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hktEL/Yj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cxQnhgSm0DzB03k3ShvGshMJPsSCnBiKfz0W3WaQRCE=;
	b=hktEL/YjZlC/ejiQIRZ3/VqhLnF06lZ8gPZe9Y1FEJ894j9aSKRvvj0P0bVXv7XW7kZnoX
	yhCN+jJLBVMooUedn90moprNjBC4ylyPJL8Ldb2T8h754u/Z1gQv+IKEBy0oRUWgevsPNM
	SHdAXfEoGQTd3oHKMxCPhN4s0p8p/j0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-WWkizDutMyu54n3s1qcEEQ-1; Tue, 21 Oct 2025 08:59:47 -0400
X-MC-Unique: WWkizDutMyu54n3s1qcEEQ-1
X-Mimecast-MFC-AGG-ID: WWkizDutMyu54n3s1qcEEQ_1761051586
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4256fae4b46so4171106f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051586; x=1761656386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxQnhgSm0DzB03k3ShvGshMJPsSCnBiKfz0W3WaQRCE=;
        b=fIm+3xwm0wSyAt+mb9kuIQ4zOHTwNuZR86PQU4PhqlnDcOkv6UBTsDcaBJsX0DRkiD
         paT8Z+awhHsMDJUY7sXsJCIqqxEAszIawJpgH43d1TJmIU8uANHrtQhrfvAS9FKMnj70
         FQfQyUsIlontyIRXdT99m8tKGunQAB+3wcqaJ8cPpWalH7z6556nk1S7WOlJ8MQa5gFd
         oUISIx91ldDOvUJ1qh+JjbiKcc+DOnwxc1j7yh3RkFKBvFEockoyLgUl8V7Ng3ZTswmC
         /HQU7bljBjWMisR66aYqIVlbLzV5BzMUidZWhHu+8AQBo7aP5iNlBwErhsw+TJ8c9D4F
         o2Yw==
X-Gm-Message-State: AOJu0Yxt89mEwdI1JYVIATXFI6hcHjTMU5cPS4vYyGEWn2rTl0xuUpfr
	jwAm6c/XSENarVudyh1S5hQiubU3Rp3OgoSyFWBP7t99Tik6TDgIYM9UjNsSbput0sjSzwSu5Qz
	QlipTO1fPKmWawR/PmdQqr7/RJwhchIfLDkUXiF2ubZ2HDZNVqvFiPQx6u/2G1MD7MXZXm8J8qh
	By+Uy0iNIwYOxNGnsgrFg2/bnmrnm9tpz4/4M+x4K5Tp/F0A==
X-Gm-Gg: ASbGncsrpL7OykdwkKnzAOXe3N9HvLEPbcmSdpi1hzVUNqIt4qkf3Ee/Q7RGlE0OHBo
	Q+J9IMXG/UjeHUiTjui3Y/UAUyXxrKH7iK5dRU+e+PxoajzhT4jWG5RH/z4kYlemwCwmXVM76eC
	4zSbfhnoo9SlE+i7wEQvM4V0+/N/xDztsuQGYVsXfBPRuQ87j16/2KZex1vxk5NZJmePJh/NmId
	D4k/ZW4d0Cu6A/a4yxRkRGEs/TauD4J73bYfVjLCHUc6HuqrNi0BgtjBnNgzNyPetgtbSAnxUP6
	ZXjlQ29Qgdgx0TLqFJmzcn0hwg6WITMrCGjGlLK7B/ZRe3hYIcapz5FsuDSWM7pIRzdrkjRYfqT
	JaPR1qEAz2rYL1I+R030R9GY69XO9tKIPabXITCdItqETen2vgs1XEQw5bKSV
X-Received: by 2002:a05:6000:26d1:b0:408:d453:e40c with SMTP id ffacd0b85a97d-42704d8efa0mr12411538f8f.25.1761051585939;
        Tue, 21 Oct 2025 05:59:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEOtDIfhDIzkXczwnOUGV3QbWhaE/6kTj9DtjKKHbsfSDizDdGlR5kALx8VAPeRCrHUv5bhA==
X-Received: by 2002:a05:6000:26d1:b0:408:d453:e40c with SMTP id ffacd0b85a97d-42704d8efa0mr12411489f8f.25.1761051585441;
        Tue, 21 Oct 2025 05:59:45 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f00ba070sm20517572f8f.42.2025.10.21.05.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:59:44 -0700 (PDT)
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
Subject: [PATCH v1 06/23] vmw_balloon: stop using the balloon_dev_info lock
Date: Tue, 21 Oct 2025 14:59:11 +0200
Message-ID: <20251021125929.377194-7-david@redhat.com>
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

Let's not piggy-back on the existing lock and use a separate lock for the
huge page list.

This is a preparation for changing the locking used to protect
balloon_dev_info.

While at it, talk about "page migration" instead of "page compaction".
We'll change that in core code soon as well.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/misc/vmw_balloon.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 52b8c0f1eead7..53e9335b6718c 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -354,10 +354,15 @@ struct vmballoon {
 	/**
 	 * @huge_pages - list of the inflated 2MB pages.
 	 *
-	 * Protected by @b_dev_info.pages_lock .
+	 * Protected by @huge_pages_lock.
 	 */
 	struct list_head huge_pages;
 
+	/**
+	 * @huge_pages_lock: lock for the list of inflated 2MB pages.
+	 */
+	spinlock_t huge_pages_lock;
+
 	/**
 	 * @vmci_doorbell.
 	 *
@@ -987,7 +992,6 @@ static void vmballoon_enqueue_page_list(struct vmballoon *b,
 					unsigned int *n_pages,
 					enum vmballoon_page_size_type page_size)
 {
-	unsigned long flags;
 	struct page *page;
 
 	if (page_size == VMW_BALLOON_4K_PAGE) {
@@ -995,9 +999,9 @@ static void vmballoon_enqueue_page_list(struct vmballoon *b,
 	} else {
 		/*
 		 * Keep the huge pages in a local list which is not available
-		 * for the balloon compaction mechanism.
+		 * for the balloon page migration.
 		 */
-		spin_lock_irqsave(&b->b_dev_info.pages_lock, flags);
+		spin_lock(&b->huge_pages_lock);
 
 		list_for_each_entry(page, pages, lru) {
 			vmballoon_mark_page_offline(page, VMW_BALLOON_2M_PAGE);
@@ -1006,7 +1010,7 @@ static void vmballoon_enqueue_page_list(struct vmballoon *b,
 		list_splice_init(pages, &b->huge_pages);
 		__count_vm_events(BALLOON_INFLATE, *n_pages *
 				  vmballoon_page_in_frames(VMW_BALLOON_2M_PAGE));
-		spin_unlock_irqrestore(&b->b_dev_info.pages_lock, flags);
+		spin_unlock(&b->huge_pages_lock);
 	}
 
 	*n_pages = 0;
@@ -1033,7 +1037,6 @@ static void vmballoon_dequeue_page_list(struct vmballoon *b,
 {
 	struct page *page, *tmp;
 	unsigned int i = 0;
-	unsigned long flags;
 
 	/* In the case of 4k pages, use the compaction infrastructure */
 	if (page_size == VMW_BALLOON_4K_PAGE) {
@@ -1043,7 +1046,7 @@ static void vmballoon_dequeue_page_list(struct vmballoon *b,
 	}
 
 	/* 2MB pages */
-	spin_lock_irqsave(&b->b_dev_info.pages_lock, flags);
+	spin_lock(&b->huge_pages_lock);
 	list_for_each_entry_safe(page, tmp, &b->huge_pages, lru) {
 		vmballoon_mark_page_online(page, VMW_BALLOON_2M_PAGE);
 
@@ -1054,7 +1057,7 @@ static void vmballoon_dequeue_page_list(struct vmballoon *b,
 
 	__count_vm_events(BALLOON_DEFLATE,
 			  i * vmballoon_page_in_frames(VMW_BALLOON_2M_PAGE));
-	spin_unlock_irqrestore(&b->b_dev_info.pages_lock, flags);
+	spin_unlock(&b->huge_pages_lock);
 	*n_pages = i;
 }
 
@@ -1828,6 +1831,7 @@ static int __init vmballoon_init(void)
 		balloon.b_dev_info.migratepage = vmballoon_migratepage;
 
 	INIT_LIST_HEAD(&balloon.huge_pages);
+	spin_lock_init(&balloon.huge_pages_lock);
 	spin_lock_init(&balloon.comm_lock);
 	init_rwsem(&balloon.conf_sem);
 	balloon.vmci_doorbell = VMCI_INVALID_HANDLE;
-- 
2.51.0


