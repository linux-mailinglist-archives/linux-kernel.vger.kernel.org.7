Return-Path: <linux-kernel+bounces-837172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF819BAB9CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF36174E30
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441C0285C8D;
	Tue, 30 Sep 2025 05:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYKPgaf2"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B35F27B354
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211978; cv=none; b=CkxhqhB5SZdpCL3dh+BRAP1ExeV/2s2bpdMIjK7451o7tBoqXqkV/rgWtOE051itMNC3mfocQ7/GQ2ro39fWDcBXvUh6H6NywewW9vWztHjIF8xyRJOQaX3GOfeIHRr0gFw9HBUpGR4efDpPHiq37FQdQasrbLYaKQ6LJI7IgxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211978; c=relaxed/simple;
	bh=PdHzrFnTfY/BX2nYC+VH4KXSooOxeg+vmzUyNWX3Omw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h4Q+YW0GxlCaP+oqNyh6ThCfjfxQk6L4vGvAbPh2AfSDDtoaVZ4CqHnG598Pa56NYoMMEfws5ks+Anlos+W/LugFntweXbtBFhMoS17q6pihGdZOJ6t8dUIVUiOmfM23dgjMdknioqU8IAFOer/g8/IVwNneIg7IAIY8hZ5KuVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYKPgaf2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27eec33b737so57290725ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759211976; x=1759816776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tfnp2VgNI7X5NDB06OaZAZrurrAWQnxjDDxodnKF9g=;
        b=kYKPgaf2hBEEypXtFPz9ODbbwNAaKfrhTifLbPD/njZ1sgZk7+QkgHPfOxfUw/jmp9
         oxjW1Qv5aJ5zhXL6YTHzztPeWBLMGp6xvNtz8kDtALGI3YrzKUeVKLoVlW9pFWfFVTTL
         3TuCsb+6FGBOkPXHvu9hs/jXLVWy1+BqINpx33ua2bqLO8khlHNmmU0nt28coa5NrVeF
         Y9ciSUgrcx2WNa9usTbTc5sC+8MFE5MSADp5pyaxvqgk9GomMRuG1RAl8jXhqAEPFuug
         uZYVb/ILW+koYQxEWb2piECDxcVFFZVeQSOgrIHkqXkeg0po+z6bH3Ba1JlsH9xN2kJ7
         Hqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759211976; x=1759816776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tfnp2VgNI7X5NDB06OaZAZrurrAWQnxjDDxodnKF9g=;
        b=EF9vnDsqtLjEOYgbnPhJ+XjveS+Ltc0MLjJIqHvlciQq63nNdb7vm5yszKZHntzrwq
         CoWgbAzkgYB2LJZf3oDQ1P09QVhEVo6SdQgf20v9gX+sETz/jOENaI4ePT+8qECpqZSc
         oHcAhcbsHmWpElskvyXVX1lS/iQmIEeH3MBWW/wqeKOkTdwJ6YkNN2yoHYBlY8FiRbJU
         kT2JnzzPkeRtR3kIWcy1eZlmrxw0DKU6kd+SNLVBb5Vu3MnayvmV4LXfsPLRZkV6Vr+E
         IhQ/D7K+bBZOrXMT5rAJuHoNtY+NBxzn6fAu283Zl3ys3ur7p9E8GL01npzxJfRjon7M
         YzyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs4VWrVot81o+2N4e0zg7SNUHBCw+0oyZt9GZNg/KyLdKpz1CCDNcIRZG/8Mu4jb804ut623X+8GK4kuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIeqvFAjhoOV5sicFuTDN8UFD0A1eLHXRxSATIfFiQYC3s5ncC
	OPkQu+rQ10Z8iCNiquuj1c1K8Csd7IP4e14uSbp6swM+P53cU8Dld1cC
X-Gm-Gg: ASbGnctkxBqc/hmV4fadw8koKdmW1+Gku3Zs5bcsbVa5RCjGeXk4jkwVz9P6VY89cNc
	qs3xf8i7hBkhWdIAWpoeLMdp75bxYTWhLTIqwhU2OlxGCkMYW9JIY9XCldzYDBZ6A0Wg7fHbbxz
	DC8ZsH5DGsQayVFJxep3C6FqxCyLKAw4ALTEPUr+TNjzIKpN0n0R3cp5H0ytQAguLpzPRPQifuj
	n4u2EhrvqIuxQvVquxnwUu7uZGB0veh58+ThRXmPqS6HiBHKI7pkhtjfJ3PjxoYm2UObDVnbn+T
	l32HNP4b/LspvajDwPAW9VUUpaqqx7R1VBIaJYox52eIRejzMYzWITpiRMlDEg06EGFvPzWKDKp
	/z+b6DVbRBdhi8MKan2Jc/HewJdI/BDQdsBI/3m8OE9jGd9cE5cAN4gyAoZTfYgRM1L4UM3H0vs
	IEZIV+tGwVpvvfunnL9thAlz0M79IDEYvZ18MySQ==
X-Google-Smtp-Source: AGHT+IHzK9X+Xf+bVu8Rrmbp78/kS7yuMf0wwgc2gHprT/HrnmCmly3PRVr5PnyZFdbWTIQHPwUiwA==
X-Received: by 2002:a17:903:3d0e:b0:250:bd52:4cdb with SMTP id d9443c01a7336-27ed4a3d9f5mr206668205ad.32.1759211976345;
        Mon, 29 Sep 2025 22:59:36 -0700 (PDT)
Received: from localhost.localdomain ([61.171.228.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d43b8sm148834065ad.9.2025.09.29.22.59.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Sep 2025 22:59:35 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
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
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v9 mm-new 05/11] mm: thp: enable THP allocation exclusively through khugepaged
Date: Tue, 30 Sep 2025 13:58:20 +0800
Message-Id: <20250930055826.9810-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250930055826.9810-1-laoar.shao@gmail.com>
References: <20250930055826.9810-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

khugepaged_enter_vma() ultimately invokes any attached BPF function with
the TVA_KHUGEPAGED flag set when determining whether or not to enable
khugepaged THP for a freshly faulted in VMA.

Currently, on fault, we invoke this in do_huge_pmd_anonymous_page(), as
invoked by create_huge_pmd() and only when we have already checked to
see if an allowable TVA_PAGEFAULT order is specified.

Since we might want to disallow THP on fault-in but allow it via
khugepaged, we move things around so we always attempt to enter
khugepaged upon fault.

This change is safe because:
- khugepaged operates at the MM level rather than per-VMA. The THP
  allocation might fail during page faults due to transient conditions
  (e.g., memory pressure), it is safe to add this MM to khugepaged for
  subsequent defragmentation.
- If __thp_vma_allowable_orders(TVA_PAGEFAULT) returns 0, then
  __thp_vma_allowable_orders(TVA_KHUGEPAGED) will also return 0.

While we could also extend prctl() to utilize this new policy, such a
change would require a uAPI modification to PR_SET_THP_DISABLE.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Lance Yang <lance.yang@linux.dev>
Cc: Usama Arif <usamaarif642@gmail.com>
---
 mm/huge_memory.c |  1 -
 mm/memory.c      | 13 ++++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 08372dfcb41a..2b155a734c78 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1346,7 +1346,6 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	ret = vmf_anon_prepare(vmf);
 	if (ret)
 		return ret;
-	khugepaged_enter_vma(vma);
 
 	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
 			!mm_forbids_zeropage(vma->vm_mm) &&
diff --git a/mm/memory.c b/mm/memory.c
index 58ea0f93f79e..64f91191ffff 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6327,11 +6327,14 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	if (pud_trans_unstable(vmf.pud))
 		goto retry_pud;
 
-	if (pmd_none(*vmf.pmd) &&
-	    thp_vma_allowable_order(vma, TVA_PAGEFAULT, PMD_ORDER)) {
-		ret = create_huge_pmd(&vmf);
-		if (!(ret & VM_FAULT_FALLBACK))
-			return ret;
+	if (pmd_none(*vmf.pmd)) {
+		if (vma_is_anonymous(vma))
+			khugepaged_enter_vma(vma);
+		if (thp_vma_allowable_order(vma, TVA_PAGEFAULT, PMD_ORDER)) {
+			ret = create_huge_pmd(&vmf);
+			if (!(ret & VM_FAULT_FALLBACK))
+				return ret;
+		}
 	} else {
 		vmf.orig_pmd = pmdp_get_lockless(vmf.pmd);
 
-- 
2.47.3


