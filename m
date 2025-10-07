Return-Path: <linux-kernel+bounces-844236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DBDBC15AC
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE8A188C9E5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025D32E03F3;
	Tue,  7 Oct 2025 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mn1LkJR6"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703C72DF3F9
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839649; cv=none; b=myIj2qyN0rEetzne1EXcr5cX0theQbWVTfx61hrD515u9/9RPPO5JeTbjWi/xc/fgqc5kGS7MMmBM0mk8GvzEL5cERpkNNDNDUzudMC+uIPphLeJ/Um5b14lWb3HM8GqKompirS0wOI/ZnHTg4OxWGw3uarVifBa9VF0vYFuBnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839649; c=relaxed/simple;
	bh=ZVp9FIATnWymDAEfVzq5zKbM1xcp8hPB8sUKQ+bCiCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRk07TXN4mDLHDCF7NOzTb0j0ugMeNpTnxirrCYArvx/omPKEDAC3wpS+dBsfLaOrh8G73o1zIlPwTykaK9sr2JH4/OoANBTucKomqnB+GygWp1ce/2Z+XMjTE3+D1SbweUeiCcFKxQJawR4mdyD3f4i8TM+BLvh0fk7J0I4f7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mn1LkJR6; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57ea78e0618so7029910e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759839644; x=1760444444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yCAVXUd+Xggdo34An12Zy3AWPX111PHofILGlMoG8c=;
        b=mn1LkJR6sY3BipjTjaA5486qpOSWPy5SOjuLO4xTyMqYniDuFAfUdNDGd6ST3RMn5p
         34mgkAv1QRVweggoxeJ+vfbdEdQYOa6oszNbVTJFUZGzAgza4THs7Vg0uy2gDdoihSIE
         vuLdWZ6YYxX7rN0WRm1P/AIz7gYd3FT1ioPVoWxziJHnez611JBKSuEl57Gp8qhP9H/z
         0JdNlhzUNVANYbmGC30dLaKQZav38wQDW7/qd76aq8YELVx5ZBPd0fL3dNZRZfGPO9bl
         rTudJRcwVVGyaUuLEAsSrcVxx+WkHYMwD3RaLMBvIg4H15LJGCn7UL7+1kFMWy6WXe8k
         QsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759839644; x=1760444444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yCAVXUd+Xggdo34An12Zy3AWPX111PHofILGlMoG8c=;
        b=t3QvvF+t2GYzPLuARjhf389Yj0zxgKdTCM+7Lec9/3++Jonzm9amqYCuZ0RQc4nsDJ
         FzFC+D92lIdUw1HxoFpm78E+eOkaO23i1OM7STJGk1kC035ozPulkfYf1pn6ZQlSFS92
         75xoQQbSvyJEKAwpBLEiLK/tncxczmP0qj4kGqACJTnuKxbp3WH/ZqcKzmQgUaBWeqXj
         xCJnL2+//3XJcmOUf/zdPs9yerm3is8PFNlZnGqePJBQe5R114RCtNLw5lmSxf+w0nlR
         /KHMoOBMn+3F+9MDxHehEkdIQkVCHgtRZZ+PEM+ILGsW91VwiUO0yXS+J75m0T7fZ/Nb
         6N6w==
X-Forwarded-Encrypted: i=1; AJvYcCV9RjOgpXnZdtd4UaaZlhReWJEDHX7dErq2sEMtdk/JAQ++WQ6mANnI2ekETSGPug7OcVOzCZ7+igUpxTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2BtbdNFA6TpvtIf/fn7+mHWq+bMhS1xznVO2OAeUnYSFbxbJt
	Ouu8tkJ7HB7U6zqmXIGceQQzqJxzsYnClGX+w69r6Db1IuyuOoZO3oi2
X-Gm-Gg: ASbGncsKWc8sVxQIRxRc7uzXzMsZ0hOTl8cciE5DXZzYYAmkisNBhYMhgHMZDfaxjTR
	zpcgCS0ZoBERyesVGt/tFOH6QaNX5luHToi8cJaebLmPuqyydHB+QAjIDZPUtW2ICEBLef+Bgat
	nRAX2WLJYFjxu4usRjcjLyUsm/sz3f1qCvyShhQ4GXHIw+RQsC92GuAldEFWyNwLcdChsBgh0P4
	2oOkputDE2f3WzaEcJqtE5nQY0osEWXe3FtT+ufCAr6a84rabfMjQBJWJrfXQJtdSaOR3KFDU0G
	DDuQSk7Z/eZ+NiSUoI4SfkwHzVARpEnn7EnMqoHHHgSQ6wKdgviruUKuGCvg7Ycu4bimr5H6yLv
	jfy9TElE2H8HbktS1B2dCcwPL7ePjrRyDNYypi3Ce
X-Google-Smtp-Source: AGHT+IHVrpI0gb3Ds4p1Dqen/CPZgYTHQ0n/2z/TsuCGFbcUs5DU+g0Ae0H7GTXue/O7cP3eNfdbhg==
X-Received: by 2002:a05:6512:12c2:b0:57e:3217:61db with SMTP id 2adb3069b0e04-58cb96629e2mr4506999e87.1.1759839644325;
        Tue, 07 Oct 2025 05:20:44 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01141151sm6061947e87.59.2025.10.07.05.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:20:43 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v4 05/10] mm/vmalloc: Handle non-blocking GFP in __vmalloc_area_node()
Date: Tue,  7 Oct 2025 14:20:30 +0200
Message-ID: <20251007122035.56347-6-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007122035.56347-1-urezki@gmail.com>
References: <20251007122035.56347-1-urezki@gmail.com>
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
Reviewed-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/vmalloc.h |  2 ++
 mm/vmalloc.c            | 52 +++++++++++++++++++++++++++++++++--------
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 1e43181369f1..e8e94f90d686 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -332,4 +332,6 @@ bool vmalloc_dump_obj(void *object);
 static inline bool vmalloc_dump_obj(void *object) { return false; }
 #endif
 
+unsigned int memalloc_apply_gfp_scope(gfp_t gfp_mask);
+void memalloc_restore_scope(unsigned int flags);
 #endif /* _LINUX_VMALLOC_H */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 9e29dd767c41..d8bcd87239b5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3716,6 +3716,42 @@ static void defer_vm_area_cleanup(struct vm_struct *area)
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
@@ -3732,6 +3768,10 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 
 	array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
 
+	/* __GFP_NOFAIL and "noblock" flags are mutually exclusive. */
+	if (!gfpflags_allow_blocking(gfp_mask))
+		nofail = false;
+
 	if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
 		gfp_mask |= __GFP_HIGHMEM;
 
@@ -3797,22 +3837,14 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
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


