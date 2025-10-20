Return-Path: <linux-kernel+bounces-860033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C384BEF2B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19DDC4E9C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133D729BD90;
	Mon, 20 Oct 2025 03:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOc1vDfJ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9DC26CE05
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760930232; cv=none; b=fo/ESN04UB+q1Sdznj/j/IP7DKNZepZmNaEbji18ebsBLM5Q8tpXEQ0TioRVc72J0Qf2G9xUyt4ZWtFUEKl9YED1s/Z43ytG76fGFRH1x92GFFvKp+uZxO8beyIpOIRpNvqsf0lSPeikN1En3DGQV8sM2iY3tK01G8uqxLtaMq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760930232; c=relaxed/simple;
	bh=Qv1HG9au83J7guckWop8/cgavdJDTQcWIQGKLivyPZg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DRh8d02uNLouuIZbj6peZ76JY3QmDmBN2Tprcn9C7VSL7X7LiUrVXYfACShiq4ROYy+Lr9S1+X/9zbvfHycs5l89waym2OYqruU03dnUSkg11noYl1mlZfLOYKTlFmNlqPS90FnJlP3xpNHNnKUdmQZGB7pQerb7bYbAJ02N9mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOc1vDfJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-269639879c3so37820785ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 20:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760930230; x=1761535030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kGks2sOnnpNLPiQkQk5TdavZHCtfoEFSojg02a8VBgI=;
        b=BOc1vDfJwcdTWnQSl8wErjdt58QEu9d4A4uuWo+Yj9/iecarzaTVNQxe/TSfIk4JX+
         Mk90NQ9WHNRtHT+JYsKxeF6YaKhH0YVOW+o/DIRRAMqwYocl8fBdbaUtSMm0tKmUVS7K
         PV9/XDO+Ac0F8UrdEzAaw5l9ZAnfgs8hkwBlsj/ifiXEAMUe/F8gS/RZdj99qbQD60S2
         bLXFFn6vKRMA59T/b5BQb9s/hTzMzxTZKNY0c1irKjiyXQ4JeN6/9bouexEh4M2+no0j
         Lp96QaVg6dgGHwHRMyF7gB0g96WVcsKyk+gZaptHfOL4TceHZ4Hg40CuqgmxcenhI7Tc
         sSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760930230; x=1761535030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGks2sOnnpNLPiQkQk5TdavZHCtfoEFSojg02a8VBgI=;
        b=H53Z/zb+ptV0DGn8217Ca2fF5vKMqsFHg332pW+WDJaPCN4mSbZM0RnKCjMqQNRUAE
         1dDkVhBTWMWbJ/I+nNUwg6cnfyBfQ8Ed6E0EPvibJLBkOCmgyAYAROjkTIejvLZ6nnl5
         +7BgrdgW9M9HVuUhiWLTDqJlbtcFJvL9MjHyQirayaV0rRiVQlhNiR4Jzp+tRx+EyXM4
         CteMvFivubHcErB9X+9A+3kQ8rB+bqfAG0tb4XwJ9YtuP8/6fMmKO92m9BlJDA1s9ZQc
         hZ1FsoWedDW8sleQ+JMLFcbfnPvc5VfsxDdGjMXI0BozUe7qcxQCf/8XrJITcxG5jfR5
         Pfvw==
X-Forwarded-Encrypted: i=1; AJvYcCUxQr3WFRz+cLTZmg/hwrwuE11A4YBb1fHWv8VHMqTjaDsqWHV5m6D6JFQwUcdFH5oSZTLls11/NVpATCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb9HjlXjuBXRrIluZn8F+UlgIxXmCn73+KoU7lqgYPf+ZB7X3P
	NUCAFirF5DCzw/fqkP6W4ulAGNP7NTYgYfdETNFjqnu8AVRkKo83AWP/
X-Gm-Gg: ASbGncs+XIVJCYpteY0rArg3bhiqT2sxaAEtusKlaBi56dTXOZ6KrimcLaMlL6cJ3dn
	g5uNSzkg39AbujX1kyQTrKjadof399Kcj6uLmSPyrUEjh1+qAMF1U2GMOv8gUgmHURXcDyE+IH3
	6TROvN7Kjcc4dvZ9ipYlsXqilcC1OtsyiLB1/aaPyjeoBuG1OfEu8cXvYmuuPSsz3iKifr+jXnn
	j9TpQfs4IHSQCGE0kDObqpvoB3X0xVOEUTQZEgb2g1ltv6ixMfeK/m3+TfrkNwHA0Y37Hmn4Ql8
	Bo8LBx1hwrOdhrPdu3v6jbB5f0STAC7s8H6woPvMNwmQU0azNwtxX4i2cGSNv0/TyWdOEV7J0j8
	4xGu6ktrnnhSinUxMEx61gPLDduhWVE3J66aYAiAEZY0jXFp3ypyTm269tu1F2WS7athnrMP7zk
	in9TkM7XA9AfKbIRP/6Cvxr+M9HXZ6mGNG137hVlt9RIpTnQ==
X-Google-Smtp-Source: AGHT+IHgkWxUzoUUp0gWSk3OAPdv3h9UX6IroOzlUnb1eY2K5j3hSN09VNabSt60qr2F5Tmrcms9KQ==
X-Received: by 2002:a17:903:41c6:b0:25d:37fc:32df with SMTP id d9443c01a7336-290cb65c914mr164540365ad.47.1760930230150;
        Sun, 19 Oct 2025 20:17:10 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1da1:a41d:3815:5989:6e28:9b6d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fddfesm66373435ad.88.2025.10.19.20.17.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 20:17:09 -0700 (PDT)
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
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v11 mm-new 05/10] mm: thp: enable THP allocation exclusively through khugepaged
Date: Mon, 20 Oct 2025 11:16:50 +0800
Message-Id: <20251020031655.1093-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
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
index e105604868a5..45d13c798525 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1390,7 +1390,6 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	ret = vmf_anon_prepare(vmf);
 	if (ret)
 		return ret;
-	khugepaged_enter_vma(vma);
 
 	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
 			!mm_forbids_zeropage(vma->vm_mm) &&
diff --git a/mm/memory.c b/mm/memory.c
index 7a242cb07d56..5007f7526694 100644
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


