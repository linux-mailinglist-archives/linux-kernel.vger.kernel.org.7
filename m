Return-Path: <linux-kernel+bounces-817072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45250B57DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA04166EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E03C32143D;
	Mon, 15 Sep 2025 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlAV7SCG"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C2A31CA68
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943652; cv=none; b=SLvqybnEdoGUa9rjGlO/9FBF/elOB5Xna65QzCVMSvTBwfi1mJYMwOf+WGED7I3DdZngI8z/6F7eLWgF9k0PfnoALhVtGg13gm54/UF11DpSiRxqljqpz3XYVHcIbTs29LfVCsgpFlBG5A6JoKlS+oP+ucWeRN8nEjNMrITFY7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943652; c=relaxed/simple;
	bh=hzKRFCzFO3pghIGRyfnPUXUgalcXoKh8Z5rKsazA2mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exBQ7uXqt0yhKz4zdgdu6CyJnOw5Yw9QEQDhMi5PKbRaGvKLqpy3nUZOEcALZiAxdg8wMqejQVqckG7NZkCAmq5bgHKTq43aRxX8/IaAjmOHbc0mVq4hf4Br22AfJlSEapyr6kwsmUDGZItM68XLtokeO+1s9mD8L1COmQCeu3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlAV7SCG; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-571a58b385aso3211823e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757943648; x=1758548448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/izOwppE0n2NGxkx7H9WLO0rOAXG+swxzYlRgFxl2qA=;
        b=VlAV7SCGb1dr3sWo0yI8pb/2/Hgg2/xAKk2ScMhkP1MEu8Rc/Is8+7ooy6PwrE6JOm
         uzgToBG9EjLXh5qjLmLHpfoU2GbA8Hm7fY/NgI+uafzkBuhGllnoUn0l/Yx0K1s+ZdMa
         2YCOwUpqfYWSlX94jM8B8bC9P1bnFRulnAcLOH2EwYyhyR3QGB1H/KZrAyfcqBNTg2WX
         rb+V6UkinQ9DHv8fnePi43/U39G/YRTd/UK8mnRKNQPw59PZcN1dy9219muX2t3T0HBN
         Mk01awx52Pjr8HAlT8oR5staiz0mAgxSzXywI+jt5qYwNcGwDvnwKRxfuH4HWOmU1NEC
         IBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757943648; x=1758548448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/izOwppE0n2NGxkx7H9WLO0rOAXG+swxzYlRgFxl2qA=;
        b=I22+4cJ584NanUbRQdrG/ssE5MtVNruG80V91S4vY62wPNpQwynvkMrQS3eKbPtHoM
         MC2/mY4OKdJ2VF77EMztZgr0Z94lgHSrLkOYhQYIMJRIUTPOeOaEX0GXT6qcmS+XZus0
         RU+qbDvhK3nAislfbdKuut+LkpbgN7ijTVTszgsp+gqzxg1aHpSipqk8yLxyLHweibjk
         V4FYOzzn/1svjed/fRr+IVdrQGz0E54VSQHL8HsAUC0ztlBQK2MtRIoxK1TaDn3p/5Ak
         2JZmyhoX0RfUVEvWQnn5B7lqHap6jbW2Mse+ybnmgPk2G/xGXWnjm4Jjet2hvpyAZFOA
         IF8g==
X-Forwarded-Encrypted: i=1; AJvYcCUlyrQVGIjHDE7WGflcc9kmWFPDCH9q/RAGAVy5xXeD3VhdxWNwgcTom0etmGJ+Ib/57kcOV4p5M7Obdog=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkeZAgzspgtDf8j76D1x++7rnRCgOc20HbhmcfDew0WIB7u00/
	skKRnx6u7LtEiIFg8lnPIuG5Ptde8CfiW9Fyyh6Jnjy2GFoxWPVwDoX9
X-Gm-Gg: ASbGncuwmiG4RKglobC2WG5NtFGKwAgLLGSpvGLPG6eJOg1naFRcY20OuKcLf02jQOT
	oPcaKJ6kcgI1n329sKh1HRu+dBPk+gdJhc45wyZL0Cxbmx1VPQx53Bh+8jd1AEQZnORZDtHdpSy
	wcxOJ55noPynwS3SBURe7NtbxUxOvHhZDnBUmUTnhE0VNZPSW+/b5H/TnM7g74OG7pIXpXuXJYR
	xzQwOAc1DV87qQO8r1le9CkJComtrOhz3CN4Xhzq9hx1kdNTXkAjP+jdnkWkgbi9nN6d3a9qIjk
	m2bQu/n+c58Bs0L/pi/o032a+JyUOpo1waeCGG1x4+6AKjlrer4k2L3ZXjnazGxMIcFLBIj4J6g
	W5GhV9VDg6sNsm4MM
X-Google-Smtp-Source: AGHT+IENNg57J50ZrYXCeFafqm5XRGYYIfDpp9Jex3+zwIfjPbel+BSgSSthUwdFCiApyxIO38UV3w==
X-Received: by 2002:a05:6512:141c:b0:572:7e6e:d31a with SMTP id 2adb3069b0e04-5727e6ed4e0mr2026472e87.26.1757943648235;
        Mon, 15 Sep 2025 06:40:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-573c8330e54sm1150719e87.63.2025.09.15.06.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 06:40:47 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2 06/10] mm/vmalloc: Handle non-blocking GFP in __vmalloc_area_node()
Date: Mon, 15 Sep 2025 15:40:36 +0200
Message-ID: <20250915134041.151462-7-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915134041.151462-1-urezki@gmail.com>
References: <20250915134041.151462-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make __vmalloc_area_node() respect non-blocking GFP masks such
as GFP_ATOMIC and GFP_NOWAIT.

- Add memalloc_apply_gfp_scope()/memalloc_restore_scope()
  helpers to apply a proper scope.
- Apply memalloc_apply_gfp_scope()/memalloc_restore_scope()
  around vmap_pages_range() for page table setup.
- Set "nofail" to false if a non-blocking mask is used, as
  they are mutually exclusive.

This is particularly important for page table allocations that
internally use GFP_PGTABLE_KERNEL, which may sleep unless such
scope restrictions are applied. For example:

<snip>
__pte_alloc_kernel()
  pte_alloc_one_kernel(&init_mm);
    pagetable_alloc_noprof(GFP_PGTABLE_KERNEL & ~__GFP_HIGHMEM, 0);
<snip>

Note: in most cases, PTE entries are established only up to the
level required by current vmap space usage, meaning the page tables
are typically fully populated during the mapping process.

Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/vmalloc.h |  2 ++
 mm/vmalloc.c            | 52 +++++++++++++++++++++++++++++++++--------
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 97252078a3dc..dcbcbfa842ae 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -326,4 +326,6 @@ bool vmalloc_dump_obj(void *object);
 static inline bool vmalloc_dump_obj(void *object) { return false; }
 #endif
 
+unsigned int memalloc_apply_gfp_scope(gfp_t gfp_mask);
+void memalloc_restore_scope(unsigned int flags);
 #endif /* _LINUX_VMALLOC_H */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e61e62872372..5e01c6ac4aca 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3715,6 +3715,42 @@ static void defer_vm_area_cleanup(struct vm_struct *area)
 		schedule_work(&cleanup_vm_area);
 }
 
+/*
+ * Page tables allocations ignore external GFP. Enforces it by
+ * the memalloc scope API. It is used by vmalloc internals and
+ * KASAN shadow population only.
+ *
+ * GFP to scope mapping:
+ *
+ * non-blocking (no __GFP_DIRECT_RECLAIM) - memalloc_noreclaim_save()
+ * GFP_NOFS - memalloc_nofs_save()
+ * GFP_NOIO - memalloc_noio_save()
+ *
+ * Returns a flag cookie to pair with restore.
+ */
+unsigned int
+memalloc_apply_gfp_scope(gfp_t gfp_mask)
+{
+	unsigned int flags = 0;
+
+	if (!gfpflags_allow_blocking(gfp_mask))
+		flags = memalloc_noreclaim_save();
+	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
+		flags = memalloc_nofs_save();
+	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
+		flags = memalloc_noio_save();
+
+	/* 0 - no scope applied. */
+	return flags;
+}
+
+void
+memalloc_restore_scope(unsigned int flags)
+{
+	if (flags)
+		memalloc_flags_restore(flags);
+}
+
 static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 				 pgprot_t prot, unsigned int page_shift,
 				 int node)
@@ -3731,6 +3767,10 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 
 	array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
 
+	/* __GFP_NOFAIL and "noblock" flags are mutually exclusive. */
+	if (!gfpflags_allow_blocking(gfp_mask))
+		nofail = false;
+
 	if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
 		gfp_mask |= __GFP_HIGHMEM;
 
@@ -3796,22 +3836,14 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	 * page tables allocations ignore external gfp mask, enforce it
 	 * by the scope API
 	 */
-	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
-		flags = memalloc_nofs_save();
-	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
-		flags = memalloc_noio_save();
-
+	flags = memalloc_apply_gfp_scope(gfp_mask);
 	do {
 		ret = vmap_pages_range(addr, addr + size, prot, area->pages,
 			page_shift);
 		if (nofail && (ret < 0))
 			schedule_timeout_uninterruptible(1);
 	} while (nofail && (ret < 0));
-
-	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
-		memalloc_nofs_restore(flags);
-	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
-		memalloc_noio_restore(flags);
+	memalloc_restore_scope(flags);
 
 	if (ret < 0) {
 		warn_alloc(gfp_mask, NULL,
-- 
2.47.3


