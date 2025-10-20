Return-Path: <linux-kernel+bounces-860024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C76BEF272
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A0F44EB665
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EDF29CB57;
	Mon, 20 Oct 2025 03:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJR94W4W"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D3F283FFC
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760929894; cv=none; b=Kxfj3LG4jdAZLnXfTxHyEYQtEJCzZZBG8NAjhVimaOHslYKGD9EAMeToSuwZVN/ny16nf6mA3T7/egtSR0fP2jmRvqi6wchzHfXh+WcaYN1w4jb++py39cfrT5dG7XVTg7gX6MvBh0SAmDlRJ5EXAiMElMrF8Cxr/iyef0JuqZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760929894; c=relaxed/simple;
	bh=ru445dP8wX8xeVS/YTFwgQYUgOJSqNCeWR/H8JIL3F0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tGEEDo3uzlZGhCMFaCSAborGg7gsoftvez1Y5qHWjz9R7Y3O1I+nDHu8eu+oNm7o5BhdQ6J1GOtHDOaGf54cRqbaPlaN6pFlajI3qpQZ/AoX2bRwXlCjIoVeOqXs9e+FmpB+zFxlp/YQLqt0AGumAy2sLcliVHDhojZTr0X2feY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJR94W4W; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-781001e3846so3613166b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 20:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760929892; x=1761534692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcLsfJON0lJjNOupQsAXtJtd7DDEJTZNiP6jZEns7kk=;
        b=XJR94W4WvtxsAPA3JI7hKBHjmaqLhzzpBXswW0ms1NSSVkgOpWMsmISBjbV9+aI3K8
         UD5A5PoHrrOKyH+SIMRZq40kFhAIlFHecsX7hPfpQXyo1//bAlD/z/z6iFI1kyb6f7oi
         t+lydhgMgVwB25xaaVGrl6c1Y147mfFXgtVvsARqhHDuzHxu29tikus2BdsUZWeqd4vO
         fC8yKSU1aaI0zigh9nBliH96FXZ/NrAJzzQ1SF4dChPCsI3oz/uL77TGXNGtdLvrxlPW
         IUPFQv5nC+n6WdiJAJ+TfWp7rSA010BemowPK75Qm83hFv8zy3kcHrHgBoiYNrTrfLFt
         zJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760929892; x=1761534692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcLsfJON0lJjNOupQsAXtJtd7DDEJTZNiP6jZEns7kk=;
        b=WTNLrHRa0lwgRBpAP7G2Jyki33D9DCto2VqPIQXIO/U+Zra3EcXUT+P43Q9/nPpPYs
         V0EpIjFcIFhOSE0PdqidTHoF+e367HVaFCbrF5pHm5lHHjh4OdclfEdI4O38MbKy6Lef
         ovRPPsXscHCNVRC4BDDoYsXF0zM0iWQIDUuvgpP4lNV+eHGakkePAax9rpNY4QBzITAg
         3J29JFclwBkmVfZQc9tKlaYR+D1qWJk4Z+AWxsclBslYyKfnwCY6nt8Yse0lKuqGe8Xh
         SqpVNsjJu3m0zwQTlOKrbpYheo7Y6CQ9xN+MVOEyZCEGl+fOeOL+pvCfTybeM/aCdu1r
         Oobw==
X-Forwarded-Encrypted: i=1; AJvYcCXZeywTrg3Sc8LQIKjzPI55maZIB3497eKgTiktEbKjMVq5CAhihyPq9u0UrWC8linkV/MV/WgjHN5PKf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYGt4UIdDVviigpHmt9YHcUVXFaPgj0/JAsdmrNP7ZJRwLAUGj
	wle/I6dz7LYqN/r09/7uJm2ny7vvTfAzcenDdBiwPpk3LdCMx1nmSc3s
X-Gm-Gg: ASbGncvSrJTJuzqFpEEGMLUH1arEMUuclpLY+0FGzSiQiZT/UG6UwGbKFCxxU3610KR
	LDRJ+8YIxW+XHxyYC7YV3t37dMSDOLaETyNqw/tRY+1zldfvd976unI3JZzVBrflyIXzY2rmU3Q
	RYDaYllyc7gk06jZSBci2VDr9Tp/lW51v0YeseNYQW54sqT7jGgqpi5w+Yt6ITljfIcctdy5ifB
	bZufOk+dB172Gi7e18Bk3rPYFUsRVFXCYzafGFKbItQ3EoDUgDVaud1OLS89wrFBBIr1KIHvc+L
	p1VDOn/Apgw7am9xmJUWHIRSz6HpMSxMDkPCSrq3ksQtWS2myRjrnn+ra5rf5VuVAHvVPsPHW8/
	WNpATymN8AtiMfjkuTNPwts/wOMUFdJT1wYQNb3rmQljWw8FwM49y6cJVfns0cpYIvfnClxXF8+
	rr2uT9yBa+ezzhH6ObJjeFVUh+oZjio0vAnf0GqE1I
X-Google-Smtp-Source: AGHT+IFMHeuB2yTajHJ8tS5j2zdt34EIEn0u6ljuSzQNjGyzEgX3fDhahWmDGqGBC5JB3iyfLxZ55g==
X-Received: by 2002:a17:903:4405:b0:27e:ec72:f50 with SMTP id d9443c01a7336-290cba419bemr101429775ad.51.1760929892428;
        Sun, 19 Oct 2025 20:11:32 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1da1:a41d:2120:6ebb:ce22:6a12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5794sm66007245ad.53.2025.10.19.20.11.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 20:11:32 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	david@redhat.com,
	ziy@nvidia.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev,
	rdunlap@infradead.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Yang Shi <shy828301@gmail.com>
Subject: [PATCH v11 mm-new 01/10] mm: thp: remove vm_flags parameter from khugepaged_enter_vma()
Date: Mon, 20 Oct 2025 11:10:51 +0800
Message-Id: <20251020031100.49917-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20251020031100.49917-1-laoar.shao@gmail.com>
References: <20251020031100.49917-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The khugepaged_enter_vma() function requires handling in two specific
scenarios:
1. New VMA creation
  When a new VMA is created (for anon vma, it is deferred to pagefault), if
  vma->vm_mm is not present in khugepaged_mm_slot, it must be added. In
  this case, khugepaged_enter_vma() is called after vma->vm_flags have been
  set, allowing direct use of the VMA's flags.
2. VMA flag modification
  When vma->vm_flags are modified (particularly when VM_HUGEPAGE is set),
  the system must recheck whether to add vma->vm_mm to khugepaged_mm_slot.
  Currently, khugepaged_enter_vma() is called before the flag update, so
  the call must be relocated to occur after vma->vm_flags have been set.

In the VMA merging path, khugepaged_enter_vma() is also called. For this
case, since VMA merging only occurs when the vm_flags of both VMAs are
identical (excluding special flags like VM_SOFTDIRTY), we can safely use
target->vm_flags instead. (It is worth noting that khugepaged_enter_vma()
can be removed from the VMA merging path because the VMA has already been
added in the two aforementioned cases. We will address this cleanup in a
separate patch.)

After this change, we can further remove vm_flags parameter from
thp_vma_allowable_order(). That will be handled in a followup patch.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Usama Arif <usamaarif642@gmail.com>
---
 include/linux/khugepaged.h | 10 ++++++----
 mm/huge_memory.c           |  2 +-
 mm/khugepaged.c            | 27 ++++++++++++++-------------
 mm/madvise.c               |  7 +++++++
 mm/vma.c                   |  6 +++---
 5 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index eb1946a70cff..b30814d3d665 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -13,8 +13,8 @@ extern void khugepaged_destroy(void);
 extern int start_stop_khugepaged(void);
 extern void __khugepaged_enter(struct mm_struct *mm);
 extern void __khugepaged_exit(struct mm_struct *mm);
-extern void khugepaged_enter_vma(struct vm_area_struct *vma,
-				 vm_flags_t vm_flags);
+extern void khugepaged_enter_vma(struct vm_area_struct *vma);
+extern void khugepaged_enter_mm(struct mm_struct *mm);
 extern void khugepaged_min_free_kbytes_update(void);
 extern bool current_is_khugepaged(void);
 extern int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
@@ -38,8 +38,10 @@ static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm
 static inline void khugepaged_exit(struct mm_struct *mm)
 {
 }
-static inline void khugepaged_enter_vma(struct vm_area_struct *vma,
-					vm_flags_t vm_flags)
+static inline void khugepaged_enter_vma(struct vm_area_struct *vma)
+{
+}
+static inline void khugepaged_enter_mm(struct mm_struct *mm)
 {
 }
 static inline int collapse_pte_mapped_thp(struct mm_struct *mm,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bfb52c564fb3..ea3199ea98fc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1390,7 +1390,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	ret = vmf_anon_prepare(vmf);
 	if (ret)
 		return ret;
-	khugepaged_enter_vma(vma, vma->vm_flags);
+	khugepaged_enter_vma(vma);
 
 	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
 			!mm_forbids_zeropage(vma->vm_mm) &&
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e947b96e1443..c2c683f11251 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -353,12 +353,6 @@ int hugepage_madvise(struct vm_area_struct *vma,
 #endif
 		*vm_flags &= ~VM_NOHUGEPAGE;
 		*vm_flags |= VM_HUGEPAGE;
-		/*
-		 * If the vma become good for khugepaged to scan,
-		 * register it here without waiting a page fault that
-		 * may not happen any time soon.
-		 */
-		khugepaged_enter_vma(vma, *vm_flags);
 		break;
 	case MADV_NOHUGEPAGE:
 		*vm_flags &= ~VM_HUGEPAGE;
@@ -457,14 +451,21 @@ void __khugepaged_enter(struct mm_struct *mm)
 		wake_up_interruptible(&khugepaged_wait);
 }
 
-void khugepaged_enter_vma(struct vm_area_struct *vma,
-			  vm_flags_t vm_flags)
+void khugepaged_enter_mm(struct mm_struct *mm)
 {
-	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
-	    hugepage_pmd_enabled()) {
-		if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
-			__khugepaged_enter(vma->vm_mm);
-	}
+	if (mm_flags_test(MMF_VM_HUGEPAGE, mm))
+		return;
+	if (!hugepage_pmd_enabled())
+		return;
+
+	__khugepaged_enter(mm);
+}
+
+void khugepaged_enter_vma(struct vm_area_struct *vma)
+{
+	if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
+		return;
+	khugepaged_enter_mm(vma->vm_mm);
 }
 
 void __khugepaged_exit(struct mm_struct *mm)
diff --git a/mm/madvise.c b/mm/madvise.c
index fb1c86e630b6..8de7c39305dd 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1425,6 +1425,13 @@ static int madvise_vma_behavior(struct madvise_behavior *madv_behavior)
 	VM_WARN_ON_ONCE(madv_behavior->lock_mode != MADVISE_MMAP_WRITE_LOCK);
 
 	error = madvise_update_vma(new_flags, madv_behavior);
+	/*
+	 * If the vma become good for khugepaged to scan,
+	 * register it here without waiting a page fault that
+	 * may not happen any time soon.
+	 */
+	if (!error && new_flags & VM_HUGEPAGE)
+		khugepaged_enter_mm(vma->vm_mm);
 out:
 	/*
 	 * madvise() returns EAGAIN if kernel resources, such as
diff --git a/mm/vma.c b/mm/vma.c
index a2e1ae954662..64bf384fc325 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -973,7 +973,7 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (err || commit_merge(vmg))
 		goto abort;
 
-	khugepaged_enter_vma(vmg->target, vmg->vm_flags);
+	khugepaged_enter_vma(vmg->target);
 	vmg->state = VMA_MERGE_SUCCESS;
 	return vmg->target;
 
@@ -1093,7 +1093,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 	 * following VMA if we have VMAs on both sides.
 	 */
 	if (vmg->target && !vma_expand(vmg)) {
-		khugepaged_enter_vma(vmg->target, vmg->vm_flags);
+		khugepaged_enter_vma(vmg->target);
 		vmg->state = VMA_MERGE_SUCCESS;
 		return vmg->target;
 	}
@@ -2520,7 +2520,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	 * call covers the non-merge case.
 	 */
 	if (!vma_is_anonymous(vma))
-		khugepaged_enter_vma(vma, map->vm_flags);
+		khugepaged_enter_vma(vma);
 	*vmap = vma;
 	return 0;
 
-- 
2.47.3


