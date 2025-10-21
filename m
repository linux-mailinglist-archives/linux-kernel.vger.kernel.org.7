Return-Path: <linux-kernel+bounces-863200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C58CBF7397
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F1865354CD8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9652F342C94;
	Tue, 21 Oct 2025 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GY4ya/xq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7B034216A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058860; cv=none; b=NIYOaOcKs7PChF+WOj4TdNJm3GwQzUhlYBV8mhsGHHuCOvmdef+s+jPCdjIGeX3tSKv5mw7f5OPTMkHBC4pCHFhEV4bC6TaecXcFS3Si+QEiHHFAgIt9MM4jMNMomiR69yRVoBpmQuU/EhXHdLb8PQsVl/iFo5JeKQ7O8a7zUIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058860; c=relaxed/simple;
	bh=M5lxLyaImk2bhfcMBFEtiuK+oC5ouMs8qk21Px/eNQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0atpV/kGMMenZQdi0/lHTNI0PrpyCsZOjSpR+hutKKBflWQjq/oMhUWYXpQlI4QQB6gomLlyouonEVXHfY2BQl3o82QWgOlPB57Sd79Ehhj3F4Mv4BQ+b9D6rF8FzZgUGk/1EyJvzfKZT+bZBYhuV0g/YJvEM+d7mKapHG2j24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GY4ya/xq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761058857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+nGTOYp18iZpymN+wDfkqVo+fjPG/wcicD9l6wCBXUY=;
	b=GY4ya/xqkDIuPdRjcSboXFQWLJxweIyejU8vaZeMVbjQUzuWCqtt5ndHCu/H+jqMdxavAf
	GRNCRPq0XrWrCZDexuPTNE042p+z0gx3p87VLxqTzkwnSfHkhax8VIvYzv/TaAwZgZsCDw
	dR7E65VllborCpEW5H28uzOCbw4U790=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-xMpFe46mP7qXCPXvgD5WUQ-1; Tue, 21 Oct 2025 11:00:54 -0400
X-MC-Unique: xMpFe46mP7qXCPXvgD5WUQ-1
X-Mimecast-MFC-AGG-ID: xMpFe46mP7qXCPXvgD5WUQ_1761058853
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47111dc7bdbso46510565e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058853; x=1761663653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nGTOYp18iZpymN+wDfkqVo+fjPG/wcicD9l6wCBXUY=;
        b=n/at4t8YJjIHeExGZi3Ov8Dz+qJN4CMhJ98hoWViqAChoAxlUJWGcz4jklUTRK7nE+
         +KIdMjBVMznHIBaGDhXIOrURnlxAYpu/C96vZOJYlTFm0wPECBj0Fjqdb+7kzGNlBeY5
         QK42qxFfHYOe0WJqlkwmAIwn+O4WOuAdZ+Pu2Gtplj5UlMnpDuZzF+V2Ui5lbHB+epiC
         D9+0apu7nE5KEmRrndiAnYwA7aLoM9KCeblYG9fWWlsl/KsPrGfLvbwkBxhL7E4iHnHT
         BktLdrd5bVZC+kE2B5FMua3YTl2tTsI3+bPNwYCr33FCIWL05y/8Dsue0eELzGZKGLym
         XfRA==
X-Gm-Message-State: AOJu0Yz44R/Qn2+Y4z924Zy+696RyL50pKliRE0jOQ3ji1ocHFdalwPH
	C7yTMz8qu3i8VJO13f3LlR43unZSsUxRXhGTYXB2S7OBS2oCzTiIiI6qd8SXMel6k2+e6xELVI/
	M3WHGQRJIpr9g1zsej1vIpWMb2+GttD3gyp71+py6LpKM8lMPWLcDiVsa+Z9Jsf8CXJxxruZR7x
	LKjIZ3lgHktASTOJUVI+N8er+Ath54KDxTTJqXo4V+0ls2kw==
X-Gm-Gg: ASbGncvRN3/AopJMzPmd4e0wVAUq5bzUuf4WU1N+6M6uIIUxfGuhDWB4gNpAlhHS1Fh
	678/Ow/e4EzKiTJb9EX+JmmymcUKcKh3ZBw87AIwhayOzymgtEevhLHKsSt17UHSwUTVzqdbDXS
	wBm1psF2YoljgHKDHFpcB3Qd5DIucq73t4A0QBab7rmveKIERKeXoHSunojRy81uTUKMJtfn9oU
	zbHYR+bvbczCPaQhnAW/62ZXyItPykXGj39ovlv11NPaKFPJdSiUSaic5wnz8Nn78xERpX8c1Cf
	GpPD85X6U9txPwZzNZwuWJuzpEIZukvpq1QoL16ulPcFV5pvRbVijQX/Y4kGlm4tQ3HjZDBvFDC
	1znnBWYsEqXFMbYYJlocb2h+ReC92a8Tkl8YLhRoHWL8S+H9z+BqhiG0kmaYl
X-Received: by 2002:a05:600c:34d0:b0:46e:37af:f90e with SMTP id 5b1f17b1804b1-4711787441fmr139614855e9.6.1761058852857;
        Tue, 21 Oct 2025 08:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTTgiIrEFbqDE5HfZSqmV7pniP8CbdB50p8AOsZ6Nodq7CpyHUpLxK4mVvDoU4TDBZaM7d4Q==
X-Received: by 2002:a05:600c:34d0:b0:46e:37af:f90e with SMTP id 5b1f17b1804b1-4711787441fmr139613955e9.6.1761058852009;
        Tue, 21 Oct 2025 08:00:52 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4731c95efb9sm169884335e9.8.2025.10.21.08.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:00:51 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
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
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 21/23] mm: rename CONFIG_BALLOON_COMPACTION to CONFIG_BALLOON_MIGRATION
Date: Tue, 21 Oct 2025 17:00:38 +0200
Message-ID: <20251021150040.498160-5-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021150040.498160-1-david@redhat.com>
References: <20251021125929.377194-1-david@redhat.com>
 <20251021150040.498160-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While compaction depends on migration, the other direction is not the
case. So let's make it clearer that this is all about migration of
balloon pages.

Adjust all comments/docs in the core to talk about "migration" instead
of "compaction".

While at it add some "/* CONFIG_BALLOON_MIGRATION */".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/mm/memory-hotplug.rst |  8 ++++----
 arch/powerpc/platforms/pseries/cmm.c            |  8 ++++----
 drivers/misc/vmw_balloon.c                      |  8 ++++----
 drivers/virtio/virtio_balloon.c                 |  6 +++---
 include/linux/balloon.h                         |  2 +-
 include/linux/vm_event_item.h                   |  4 ++--
 mm/Kconfig                                      |  4 ++--
 mm/balloon.c                                    | 10 +++++-----
 mm/memory_hotplug.c                             |  4 ++--
 mm/migrate.c                                    |  2 +-
 mm/vmstat.c                                     |  4 ++--
 11 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index 33c886f3d1983..8d5f57d1ef48b 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -603,11 +603,11 @@ ZONE_MOVABLE, especially when fine-tuning zone ratios:
   memory for metadata and page tables in the direct map; having a lot of offline
   memory blocks is not a typical case, though.
 
-- Memory ballooning without balloon compaction is incompatible with
-  ZONE_MOVABLE. Only some implementations, such as virtio-balloon and
-  pseries CMM, fully support balloon compaction.
+- Memory ballooning without support for balloon memory migration is incompatible
+  with ZONE_MOVABLE. Only some implementations, such as virtio-balloon and
+  pseries CMM, fully support balloon memory migration.
 
-  Further, the CONFIG_BALLOON_COMPACTION kernel configuration option might be
+  Further, the CONFIG_BALLOON_MIGRATION kernel configuration option might be
   disabled. In that case, balloon inflation will only perform unmovable
   allocations and silently create a zone imbalance, usually triggered by
   inflation requests from the hypervisor.
diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index c5aee15e192ea..9278f6573e17b 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -494,7 +494,7 @@ static struct notifier_block cmm_mem_nb = {
 	.priority = CMM_MEM_HOTPLUG_PRI
 };
 
-#ifdef CONFIG_BALLOON_COMPACTION
+#ifdef CONFIG_BALLOON_MIGRATION
 static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 			   struct page *newpage, struct page *page,
 			   enum migrate_mode mode)
@@ -520,10 +520,10 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 	plpar_page_set_active(page);
 	return 0;
 }
-#else /* CONFIG_BALLOON_COMPACTION */
+#else /* CONFIG_BALLOON_MIGRATION */
 int cmm_migratepage(struct balloon_dev_info *b_dev_info, struct page *newpage,
 		    struct page *page, enum migrate_mode mode);
-#endif /* CONFIG_BALLOON_COMPACTION */
+#endif /* CONFIG_BALLOON_MIGRATION */
 
 /**
  * cmm_init - Module initialization
@@ -540,7 +540,7 @@ static int cmm_init(void)
 
 	balloon_devinfo_init(&b_dev_info);
 	b_dev_info.adjust_managed_page_count = true;
-	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
+	if (IS_ENABLED(CONFIG_BALLOON_MIGRATION))
 		b_dev_info.migratepage = cmm_migratepage;
 
 	rc = register_oom_notifier(&cmm_oom_nb);
diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 7fd3f709108c2..216a163959684 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1719,7 +1719,7 @@ static inline void vmballoon_debugfs_exit(struct vmballoon *b)
 #endif	/* CONFIG_DEBUG_FS */
 
 
-#ifdef CONFIG_BALLOON_COMPACTION
+#ifdef CONFIG_BALLOON_MIGRATION
 /**
  * vmballoon_migratepage() - migrates a balloon page.
  * @b_dev_info: balloon device information descriptor.
@@ -1803,11 +1803,11 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 	up_read(&b->conf_sem);
 	return ret;
 }
-#else /* CONFIG_BALLOON_COMPACTION */
+#else /* CONFIG_BALLOON_MIGRATION */
 int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 			  struct page *newpage, struct page *page,
 			  enum migrate_mode mode);
-#endif /* CONFIG_BALLOON_COMPACTION */
+#endif /* CONFIG_BALLOON_MIGRATION */
 
 static int __init vmballoon_init(void)
 {
@@ -1827,7 +1827,7 @@ static int __init vmballoon_init(void)
 		return error;
 
 	balloon_devinfo_init(&balloon.b_dev_info);
-	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
+	if (IS_ENABLED(CONFIG_BALLOON_MIGRATION))
 		balloon.b_dev_info.migratepage = vmballoon_migratepage;
 
 	INIT_LIST_HEAD(&balloon.huge_pages);
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 5434a7739d588..1a3001f35d3e6 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -802,7 +802,7 @@ static void report_free_page_func(struct work_struct *work)
 	}
 }
 
-#ifdef CONFIG_BALLOON_COMPACTION
+#ifdef CONFIG_BALLOON_MIGRATION
 /*
  * virtballoon_migratepage - perform the balloon page migration on behalf of
  *			     a compaction thread.     (called under page lock)
@@ -851,7 +851,7 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
 	mutex_unlock(&vb->balloon_lock);
 	return 0;
 }
-#endif /* CONFIG_BALLOON_COMPACTION */
+#endif /* CONFIG_BALLOON_MIGRATION */
 
 static unsigned long shrink_free_pages(struct virtio_balloon *vb,
 				       unsigned long pages_to_free)
@@ -948,7 +948,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
 
 	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
 		vb->vb_dev_info.adjust_managed_page_count = true;
-#ifdef CONFIG_BALLOON_COMPACTION
+#ifdef CONFIG_BALLOON_MIGRATION
 	vb->vb_dev_info.migratepage = virtballoon_migratepage;
 #endif
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
diff --git a/include/linux/balloon.h b/include/linux/balloon.h
index 82585542300d6..e8da95ca4ad48 100644
--- a/include/linux/balloon.h
+++ b/include/linux/balloon.h
@@ -45,7 +45,7 @@
 
 /*
  * Balloon device information descriptor.
- * This struct is used to allow the common balloon compaction interface
+ * This struct is used to allow the common balloon page migration interface
  * procedures to find the proper balloon device holding memory pages they'll
  * have to cope for page compaction / migration, as well as it serves the
  * balloon driver as a page book-keeper for its registered balloon devices.
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 92f80b4d69a6d..fca34d3473b6b 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -125,9 +125,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_MEMORY_BALLOON
 		BALLOON_INFLATE,
 		BALLOON_DEFLATE,
-#ifdef CONFIG_BALLOON_COMPACTION
+#ifdef CONFIG_BALLOON_MIGRATION
 		BALLOON_MIGRATE,
-#endif
+#endif /* CONFIG_BALLOON_MIGRATION */
 #endif
 #ifdef CONFIG_DEBUG_TLBFLUSH
 		NR_TLB_REMOTE_FLUSH,	/* cpu tried to flush others' tlbs */
diff --git a/mm/Kconfig b/mm/Kconfig
index 3aff4d05a2d8c..c058a65080d1e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -597,8 +597,8 @@ config MEMORY_BALLOON
 	bool
 
 #
-# support for memory balloon compaction
-config BALLOON_COMPACTION
+# support for memory balloon page migration
+config BALLOON_MIGRATION
 	bool "Allow for balloon memory migration"
 	default y
 	depends on MIGRATION && MEMORY_BALLOON
diff --git a/mm/balloon.c b/mm/balloon.c
index 5734dae81e318..8a21c6b9a7f0a 100644
--- a/mm/balloon.c
+++ b/mm/balloon.c
@@ -34,7 +34,7 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 {
 	lockdep_assert_held(&balloon_pages_lock);
 	__SetPageOffline(page);
-	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION)) {
+	if (IS_ENABLED(CONFIG_BALLOON_MIGRATION)) {
 		SetPageMovableOps(page);
 		set_page_private(page, (unsigned long)balloon);
 	}
@@ -51,7 +51,7 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 static inline void balloon_page_finalize(struct page *page)
 {
 	lockdep_assert_held(&balloon_pages_lock);
-	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
+	if (IS_ENABLED(CONFIG_BALLOON_MIGRATION))
 		set_page_private(page, 0);
 	/* PageOffline is sticky until the page is freed to the buddy. */
 }
@@ -153,7 +153,7 @@ struct page *balloon_page_alloc(void)
 {
 	gfp_t gfp_flags = __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
 
-	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
+	if (IS_ENABLED(CONFIG_BALLOON_MIGRATION))
 		gfp_flags |= GFP_HIGHUSER_MOVABLE;
 	else
 		gfp_flags |= GFP_HIGHUSER;
@@ -232,7 +232,7 @@ struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info)
 }
 EXPORT_SYMBOL_GPL(balloon_page_dequeue);
 
-#ifdef CONFIG_BALLOON_COMPACTION
+#ifdef CONFIG_BALLOON_MIGRATION
 
 static bool balloon_page_isolate(struct page *page, isolate_mode_t mode)
 
@@ -340,4 +340,4 @@ static int __init balloon_init(void)
 }
 core_initcall(balloon_init);
 
-#endif /* CONFIG_BALLOON_COMPACTION */
+#endif /* CONFIG_BALLOON_MIGRATION */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 94a8f6e8811ab..44bfac61139b7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -946,8 +946,8 @@ static struct zone *default_kernel_zone_for_pfn(int nid, unsigned long start_pfn
  * We rely on "present pages" instead of "managed pages", as the latter is
  * highly unreliable and dynamic in virtualized environments, and does not
  * consider boot time allocations. For example, memory ballooning adjusts the
- * managed pages when inflating/deflating the balloon, and balloon compaction
- * can even migrate inflated pages between zones.
+ * managed pages when inflating/deflating the balloon, and balloon page
+ * migration can even migrate inflated pages between zones.
  *
  * Using "present pages" is better but some things to keep in mind are:
  *
diff --git a/mm/migrate.c b/mm/migrate.c
index ceee354ef2152..cf5e9b13ff28d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -88,7 +88,7 @@ static const struct movable_operations *page_movable_ops(struct page *page)
 	 * back to the buddy.
 	 */
 	if (PageOffline(page))
-		/* Only balloon compaction sets PageOffline pages movable. */
+		/* Only balloon page migration sets PageOffline pages movable. */
 		return offline_movable_ops;
 	if (PageZsmalloc(page))
 		return zsmalloc_movable_ops;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 98855f31294dd..8843a8c4914c4 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1434,9 +1434,9 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_MEMORY_BALLOON
 	[I(BALLOON_INFLATE)]			= "balloon_inflate",
 	[I(BALLOON_DEFLATE)]			= "balloon_deflate",
-#ifdef CONFIG_BALLOON_COMPACTION
+#ifdef CONFIG_BALLOON_MIGRATION
 	[I(BALLOON_MIGRATE)]			= "balloon_migrate",
-#endif
+#endif /* CONFIG_BALLOON_MIGRATION */
 #endif /* CONFIG_MEMORY_BALLOON */
 #ifdef CONFIG_DEBUG_TLBFLUSH
 	[I(NR_TLB_REMOTE_FLUSH)]		= "nr_tlb_remote_flush",
-- 
2.51.0


