Return-Path: <linux-kernel+bounces-862946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 141D6BF69D0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630C14862E3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25E6333754;
	Tue, 21 Oct 2025 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDtJZytk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A2C333741
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051586; cv=none; b=hP8jz3+I7wzZeSNyZU5RmlLhNkgVCX0lK+X6AXdhcMwsKFoxcJxt2vlK2UwF0CvvtAajxl+o2srK1lYHO0ZgbTyUKrIWA+bp3lga1j1sopDJJHUXFFI1d/h72+ypYouVSXGWM9YgGxeVeHVsyak3OwdDEtgl0ZiO+INPqwzV2yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051586; c=relaxed/simple;
	bh=+G948wZk/sZ2ZS5JlV+CYOIOv8Wk7p2Ix55iud5nl50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ar3YPI9hwQ1GWpLt/zNlG3LynYKCz49L+grTxzZny9bdQHCqO1EdmYnZ76icm62G5b7BETDzUkgirffbxDgQoCQIgiCVuIjz/GG1VZ7KnLOn805BrwueJWmabyumAqHLcNy0Ej6H6l7OjBymgtVv/zKFR1AN7RRUfAXaYHayFJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DDtJZytk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P14fEtg6A4OumBhlVUt/bQLfxRXlwvUBKmtTUWPdWKk=;
	b=DDtJZytkKoDF4+vWy799M/C552dSkeGHbmn4Ns29wz31mU6QVur3O6vkQx2X4ab6BW0O6N
	NIzwxIG89RgxZ/W3EnlShnTk1J2dyP/85qiCOSdmiKCWzT0Jc5grHTS6geUDcNIaWHdsEh
	grF+sIXFe674SJw+hyaPb5mv+VHxjJw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-RsL58PyVNP6HzmYB7ND2aw-1; Tue, 21 Oct 2025 08:59:42 -0400
X-MC-Unique: RsL58PyVNP6HzmYB7ND2aw-1
X-Mimecast-MFC-AGG-ID: RsL58PyVNP6HzmYB7ND2aw_1761051581
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-471001b980eso34244885e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051581; x=1761656381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P14fEtg6A4OumBhlVUt/bQLfxRXlwvUBKmtTUWPdWKk=;
        b=E5V3HJbCwW06EVwmhU1KDweFnmLm9Ss9OzuVAqQIBfbYJyfpDK9FrnNngT5C42eZGb
         5PlA0tiNrEXqU5WZeZJZ4FSwD/NdANZC3s9i0TQg9xm5YkVsuhH7ZthPc6Q4Lt2Y2d9j
         vRCo97XcIaS7IT7XFdRIrKC7i4sQfcWq5NFbIzcrSAgY3OCr2na718eg4EUg31908lVo
         5W4qyCvVfjBhJJUytgJzP+WMld6NCbGYRI8ACtAj26qekxNrm69XlLw1Lup0usf4QWf3
         4NZUa6VhPQ7BTNwzV+PnYquhV4eyqdQYlrrp+qC3FIuXvJJyjc7S9WkOjWgIoQIHp1Pd
         KAcQ==
X-Gm-Message-State: AOJu0YxoDYgLI8hiblg/I+8Mvyi1aFVvp3d8C41eP/fDBvkhw6qHj0pC
	4bYLj4/hKCaRpam9qAabXsSgDFtKiL1xgKB9xpkIEfdPCNvmpLGKYRN/jw6KgtVuD0YvbglxKur
	76JZR6sRuBHlP3VUY3NYg9omxNnodo34LAJ4a1mU+ryIKgHoOLVdhMREV97GgF9suvYzE2n6F4L
	Q7MgMEMOTBeJ2Nd918aRC7cNpK288L8yH27YYYky5EMD04hg==
X-Gm-Gg: ASbGncvYVkxHBBv6A+j+sNQ7sXIY2tefJuwJvYP6DtV/BXnMfEp9pDWo9wer4jSq1ge
	zxgdABIlkHTFWY/d0iMrneJOJLWBkTb8fGUYoBTy93OfememhL58O+vQVqjTe0YeUloewLH5acU
	fzc9doeWfjSk7PMkW+fRqjdvtur2gBchFh7MLJSx+SIWZyZc15lacIW5rmq2/0hHs7Lmg/nbi/O
	K5Fh001Howc0eF1I+LrngcAte8iV7N1rRZmXxpw059FjaBLwlFVhMDfkvQ0rxmTggJe0G8lEgyC
	DnETzS52k1KmmsHckaAzCFg8vxo1PqsFbWwo3wpRkoyKXI3fQveB+otstBOrFTlk/AUAgQbrmDc
	Q3Vn/W4TYap59sDQloCzHc7mSFoAhUgZM33LTUdl5gbl8kEAZT7RS3h+4OVzq
X-Received: by 2002:a05:600c:1988:b0:471:1387:376a with SMTP id 5b1f17b1804b1-4711791c661mr133821955e9.28.1761051581336;
        Tue, 21 Oct 2025 05:59:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcapACDzzVAi+UFv8YmL677aUf6eV6ZNfonjpRp41+s2WgUXfVDbrd4RA2JmDz7jP4+SdmlQ==
X-Received: by 2002:a05:600c:1988:b0:471:1387:376a with SMTP id 5b1f17b1804b1-4711791c661mr133821385e9.28.1761051580770;
        Tue, 21 Oct 2025 05:59:40 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4715520d747sm220307515e9.14.2025.10.21.05.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:59:40 -0700 (PDT)
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
Subject: [PATCH v1 04/23] mm/balloon_compaction: centralize basic page migration handling
Date: Tue, 21 Oct 2025 14:59:09 +0200
Message-ID: <20251021125929.377194-5-david@redhat.com>
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

Let's update the balloon page references, the balloon page list, the
BALLOON_MIGRATE counter and the isolated-pages counter in
balloon_page_migrate(), after letting the balloon->migratepage()
callback deal with the actual inflation+deflation.

Note that we now perform the balloon list modifications outside of any
implementation-specific locks: which is fine, there is nothing special
about these page actions that the lock would be protecting.

The old page is already no longer in the list (isolated) and the new page
is not yet in the list.

Let's use -ENOENT to communicate the special "inflation of new page
failed after already deflating the old page" to balloon_page_migrate() so
it can handle it accordingly.

While at it, rename balloon->b_dev_info to make it mach the other
functions. Also, drop the comment above balloon_page_migrate(), which
seems unnecessary.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/pseries/cmm.c | 16 ---------
 drivers/misc/vmw_balloon.c           | 49 +++++-----------------------
 drivers/virtio/virtio_balloon.c      | 12 -------
 mm/balloon_compaction.c              | 37 ++++++++++++++++++---
 4 files changed, 41 insertions(+), 73 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 67c7309c36147..07b21d2bc8a78 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -501,8 +501,6 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 			   struct page *newpage, struct page *page,
 			   enum migrate_mode mode)
 {
-	unsigned long flags;
-
 	/*
 	 * loan/"inflate" the newpage first.
 	 *
@@ -517,9 +515,6 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 		return -EBUSY;
 	}
 
-	/* balloon page list reference */
-	get_page(newpage);
-
 	/*
 	 * When we migrate a page to a different zone, we have to fixup the
 	 * count of both involved zones as we adjusted the managed page count
@@ -530,22 +525,11 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 		adjust_managed_page_count(newpage, -1);
 	}
 
-	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
-	balloon_page_insert(b_dev_info, newpage);
-	__count_vm_event(BALLOON_MIGRATE);
-	b_dev_info->isolated_pages--;
-	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
-
 	/*
 	 * activate/"deflate" the old page. We ignore any errors just like the
 	 * other callers.
 	 */
 	plpar_page_set_active(page);
-
-	balloon_page_finalize(page);
-	/* balloon page list reference */
-	put_page(page);
-
 	return 0;
 }
 #else /* CONFIG_BALLOON_COMPACTION */
diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 07e60a4b846aa..52b8c0f1eead7 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1724,18 +1724,17 @@ static inline void vmballoon_debugfs_exit(struct vmballoon *b)
  * @page: a ballooned page that should be migrated.
  * @mode: migration mode, ignored.
  *
- * This function is really open-coded, but that is according to the interface
- * that balloon_compaction provides.
- *
  * Return: zero on success, -EAGAIN when migration cannot be performed
- *	   momentarily, and -EBUSY if migration failed and should be retried
- *	   with that specific page.
+ *	   momentarily, -EBUSY if migration failed and should be retried
+ *	   with that specific page, and -ENOENT when deflating @page
+ *	   succeeded but inflating @newpage failed, effectively deflating
+ *	   the balloon.
  */
 static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 				 struct page *newpage, struct page *page,
 				 enum migrate_mode mode)
 {
-	unsigned long status, flags;
+	unsigned long status;
 	struct vmballoon *b;
 	int ret = 0;
 
@@ -1773,14 +1772,6 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 		goto out_unlock;
 	}
 
-	/*
-	 * The page is isolated, so it is safe to delete it without holding
-	 * @pages_lock . We keep holding @comm_lock since we will need it in a
-	 * second.
-	 */
-	balloon_page_finalize(page);
-	put_page(page);
-
 	/* Inflate */
 	vmballoon_add_page(b, 0, newpage);
 	status = vmballoon_lock_op(b, 1, VMW_BALLOON_4K_PAGE,
@@ -1799,36 +1790,12 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 		 * change.
 		 */
 		atomic64_dec(&b->size);
-	} else {
 		/*
-		 * Success. Take a reference for the page, and we will add it to
-		 * the list after acquiring the lock.
+		 * Tell the core that we're deflating the old page and don't
+		 * need the new page.
 		 */
-		get_page(newpage);
-	}
-
-	/* Update the balloon list under the @pages_lock */
-	spin_lock_irqsave(&b->b_dev_info.pages_lock, flags);
-
-	/*
-	 * On inflation success, we already took a reference for the @newpage.
-	 * If we succeed just insert it to the list and update the statistics
-	 * under the lock.
-	 */
-	if (status == VMW_BALLOON_SUCCESS) {
-		balloon_page_insert(&b->b_dev_info, newpage);
-		__count_vm_event(BALLOON_MIGRATE);
-	} else {
-		__count_vm_event(BALLOON_DEFLATE);
+		ret = -ENOENT;
 	}
-
-	/*
-	 * We deflated successfully, so regardless to the inflation success, we
-	 * need to reduce the number of isolated_pages.
-	 */
-	b->b_dev_info.isolated_pages--;
-	spin_unlock_irqrestore(&b->b_dev_info.pages_lock, flags);
-
 out_unlock:
 	up_read(&b->conf_sem);
 	return ret;
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1b93d8c643612..8969271581bca 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -827,7 +827,6 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
 {
 	struct virtio_balloon *vb = container_of(vb_dev_info,
 			struct virtio_balloon, vb_dev_info);
-	unsigned long flags;
 
 	/*
 	 * In order to avoid lock contention while migrating pages concurrently
@@ -840,8 +839,6 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
 	if (!mutex_trylock(&vb->balloon_lock))
 		return -EAGAIN;
 
-	get_page(newpage); /* balloon reference */
-
 	/*
 	  * When we migrate a page to a different zone and adjusted the
 	  * managed page count when inflating, we have to fixup the count of
@@ -854,11 +851,6 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
 	}
 
 	/* balloon's page migration 1st step  -- inflate "newpage" */
-	spin_lock_irqsave(&vb_dev_info->pages_lock, flags);
-	balloon_page_insert(vb_dev_info, newpage);
-	vb_dev_info->isolated_pages--;
-	__count_vm_event(BALLOON_MIGRATE);
-	spin_unlock_irqrestore(&vb_dev_info->pages_lock, flags);
 	vb->num_pfns = VIRTIO_BALLOON_PAGES_PER_PAGE;
 	set_page_pfns(vb, vb->pfns, newpage);
 	tell_host(vb, vb->inflate_vq);
@@ -869,10 +861,6 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
 	tell_host(vb, vb->deflate_vq);
 
 	mutex_unlock(&vb->balloon_lock);
-
-	balloon_page_finalize(page);
-	put_page(page); /* balloon reference */
-
 	return 0;
 }
 #endif /* CONFIG_BALLOON_COMPACTION */
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 03c5dbabb1565..5444c61bb9e76 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -232,20 +232,49 @@ static void balloon_page_putback(struct page *page)
 	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
 }
 
-/* move_to_new_page() counterpart for a ballooned page */
 static int balloon_page_migrate(struct page *newpage, struct page *page,
 		enum migrate_mode mode)
 {
-	struct balloon_dev_info *balloon = balloon_page_device(page);
+	struct balloon_dev_info *b_dev_info = balloon_page_device(page);
+	unsigned long flags;
+	int rc;
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
 
 	/* Isolated balloon pages cannot get deflated. */
-	if (WARN_ON_ONCE(!balloon))
+	if (WARN_ON_ONCE(!b_dev_info))
 		return -EAGAIN;
 
-	return balloon->migratepage(balloon, newpage, page, mode);
+	rc = b_dev_info->migratepage(b_dev_info, newpage, page, mode);
+	switch (rc) {
+	case 0:
+		spin_lock_irqsave(&b_dev_info->pages_lock, flags);
+
+		/* Insert the new page into the balloon list. */
+		get_page(newpage);
+
+		balloon_page_insert(b_dev_info, newpage);
+		__count_vm_event(BALLOON_MIGRATE);
+		break;
+	case -ENOENT:
+		spin_lock_irqsave(&b_dev_info->pages_lock, flags);
+
+		/* Old page was deflated but new page not inflated. */
+		__count_vm_event(BALLOON_DEFLATE);
+		break;
+	default:
+		return rc;
+	}
+
+	b_dev_info->isolated_pages--;
+	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
+
+	/* Free the now-deflated page we isolated in balloon_page_isolate(). */
+	balloon_page_finalize(page);
+	put_page(page);
+
+	return 0;
 }
 
 const struct movable_operations balloon_mops = {
-- 
2.51.0


