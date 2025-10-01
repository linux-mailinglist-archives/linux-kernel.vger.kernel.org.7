Return-Path: <linux-kernel+bounces-839423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203F6BB1974
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63FF2A6E7C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA882D6E6F;
	Wed,  1 Oct 2025 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMYDDm8j"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1F52EACF8
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346817; cv=none; b=VDcCYbpUgJeu+WfipeedzgZiuuZZRpd4xnxDi+wS0AP7gaHC6oq0mfzxXNX5xSscoL1CFkPSJEkUcC/YRFw/j6ZnaKYHtET5tIGGiCU7UuhlbdiOJDaV0ksETzSwXo78+NIkNvUlKbA9c13sgfWpZXuXwAviS7KFX8MHmszDiJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346817; c=relaxed/simple;
	bh=ZVp9FIATnWymDAEfVzq5zKbM1xcp8hPB8sUKQ+bCiCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0cizFT8+ypkmV0TRQqyVle3W7neLe8I8TiiW1wqmN4L9AtA9B3N8Iel7+F6uBmXC+vCLNjwd7zxjbc6A4M782+r1SVcfccYxsDZSb0ec6+Eec6qqIIKLCRCUqNjB4eiZ6bi0zB54pU7HPdrZ/j7R9FilPt7M2i4PEyOEslJXYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMYDDm8j; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-579d7104c37so242541e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759346813; x=1759951613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yCAVXUd+Xggdo34An12Zy3AWPX111PHofILGlMoG8c=;
        b=aMYDDm8jnCat9++0cksdn4Umvyzopri3Dx0APAZN0O7sM4nQ+ENRpTfB3nMGhOx9Qq
         /MWMh3YVNZZ5G8YpkVApZYb+ENHoPYAvAMkLvShXM11MYij18k1TTBtrKRzR80yhPh1Y
         IRvWdp9OeHyB2JnAUkLcRpjOSG8nSytF0RrK6rscDeAxL+YWusAGwRLiSdLbIgo/Ty5c
         qAtbwAshnR+/WvDuCQr8iqnUYeRG6XWNaf53ygi/Orq+XqLgWFwsmxaZOX/Lrud62Wjp
         2tSHhmWXTY5frAYj2U+qFvr2k7R3zSJCsTPhU6gjAsGtP8WqjQZOdkNA+r9u+CD86bfa
         y7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759346813; x=1759951613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yCAVXUd+Xggdo34An12Zy3AWPX111PHofILGlMoG8c=;
        b=dOZE8E3R3vdSltgOB1YxgnlVUbFAfJ5pF3/FKb077UNyQPfT9G0aDQ0MWLD+hEFup4
         pzXRNqh8wgAIoT8pL9zC6Ykw7zsQ/ytUh2VXC7lRr7bLdjZ4z5YgTa69+NJxB4aAs5Ps
         Ot1vwIs84roaI8FBm0C+sFnenLi7N1lExFe2TKyuUNLlZ6Cbe+hA0Pl6wWATt4JRJ7Gf
         vQb42/r0rk2hVjC1sf3dQfjfRITIU87vK1gS5ZdozlBVcuN1R/4Pixc2u1R3dkv3Dfod
         SdrE+U9oY2fZw+k5Z3YvTKNR2iG+E1CG+d+OXGP/xSnJ33AJvLadKshKiL2I+d11nVAI
         Byzw==
X-Forwarded-Encrypted: i=1; AJvYcCU2bOvSDqpqB5tTg0C10gR+VqtPiU850UY9gJ8IWEAB05L0UWJlYpb5y1k35bpZX6cDYT/6GdR9Zxh7RtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXo2O6gG2wUdd6fjm1FxVFw5On9ps1JiW+AAO2/ooF5DoMIekN
	noFyuh0Vu5GoMATLAV/C5Kw7NBU9dc1rs5IfMylYqmMp+W+gy/YnMKMb
X-Gm-Gg: ASbGncuICK00bSIrCzxaFn7hGbf7CIgAlk7MpBVJp1oPQ6FucfAtukUjLjo/Rlc6s0D
	mz47/v6SynSNVfFhO/dGyqPY+y9/5/plFTu4Gdoz83MEnuV35cIfFnQsLyqs7ucQcIn25Hsspxa
	pQ+ChKRfzi2eeF4acT0W7jPccQ3q1ykmgI6BeF7gOK9Zz/nX/85kZD0H5KlHiffc+E1cJuATTAB
	vpox7c7cs8QPoJNBLYwg6+WoF0RL/VhMkDOhxn3wuc+zyPUSuN5AdGQqb3yz4MKewE++exS/PIK
	FSKKEpbsu3Ku5IqDnBFGH/0gWEbhn+6z6m2GYZPNhJFsTdE1w/k/b6QLDZ4n2gVPafKtmTEay+P
	v1RX5YkoUwtnQgE8sU4sIEkMiByccSD2u4dbu7Niq8iZxHVC7I3g=
X-Google-Smtp-Source: AGHT+IF5fzKNeL87En2CtBg9XIbVfY39t145FRGMU6tdsljRKNoG0mSUH5/2UDHarr9y/rtlcz5Xkw==
X-Received: by 2002:a05:6512:23a9:b0:57b:8a82:1e27 with SMTP id 2adb3069b0e04-58af9f0d388mr1273724e87.13.1759346813320;
        Wed, 01 Oct 2025 12:26:53 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0112414fsm136627e87.28.2025.10.01.12.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 12:26:52 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3 05/10] mm/vmalloc: Handle non-blocking GFP in __vmalloc_area_node()
Date: Wed,  1 Oct 2025 21:26:41 +0200
Message-ID: <20251001192647.195204-6-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001192647.195204-1-urezki@gmail.com>
References: <20251001192647.195204-1-urezki@gmail.com>
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


