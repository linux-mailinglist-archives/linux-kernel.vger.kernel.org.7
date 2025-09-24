Return-Path: <linux-kernel+bounces-830749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F3FB9A71C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4133B380E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B43130CB20;
	Wed, 24 Sep 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YL2r0N9D"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5C430BF7D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726016; cv=none; b=gRvKKHzpnwnk7AThQHmfEMluvIKJ8aisXaKtFv8NWLN/IdBiAAMTJuwM7v0M/xR9ip54aMiDvcCzBGSPXvWZplaA4YVe5Cx2/lrQvueGKGbpBYNg+Af8Vau8JF3qhgyx3RQvWvPQGlc0NnzUH/id/so+5/WGqFUBl5IWuXkuRXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726016; c=relaxed/simple;
	bh=DcKwexSwfJbBE/7qSmcz3XCIn9Hk5DZnrMstN2LvKSA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XiMU4Ih1YKC6O7cqQQtIoUvKiCJKiHai5yP+CG4GE77T2MTAf8bfdvzH+duaLRzi1rkhxx3kznOg1sTifycc3+i4En8K8l0teXlPxo2jboNk1xC8AX9J011fQk0SJKZqs1Xy2/rvXBtNTWvRxV07H8EFF2FVnW73h10YBe1+ogQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YL2r0N9D; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46d8ef3526dso21388745e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758726013; x=1759330813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2K58t/vrOefSYqdR7POZfHM/E5LlRhe2fvwwEfqIfU=;
        b=YL2r0N9DtZ3IWR5HSqH7mZ/KwJWoOWN+Qh0H7gfr4kwacukGaKoWh6F391EXMfUQj/
         4JtiApQMlxM35VkzYPRr/QCAw85/UlihBiOKWdgNmJ8jLaZoivsGrvzB3VpQMfWHWHb8
         fKIb28r/UfUVCHZk9uesxPyT3BgF621BGQ2mLRugM1rYqjkSsudtI0W2MuL62kIcikCt
         DrgGh5tjxYKkB0Tw6q6Wzpzadc6PFZSbYZoC0D00fFSswXEagiNynx7fGuhxAibXOAar
         eD+Yy/Z+JWrg63TEHImWve2odTW1DLLiYbFMhhjg0/WhEOM3N3odt+5iIpNNLhwqJAPu
         kHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726013; x=1759330813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2K58t/vrOefSYqdR7POZfHM/E5LlRhe2fvwwEfqIfU=;
        b=Q4/8xEY0pzIXOGqBlwvOcjG87BpueOuBeC2ixw9xmDNzvzXQ28fCX0wZ3yZ1iAmGpi
         f4uO7tVQyVTQHZu+ZBpkZDsMHqUGWnqeX4ZnwfOz8mrqrDS7AOcCEhda6W8y+82dw0z1
         vziXlqgUn2BpGUbJ/+Bv/GQhcDQVt3H8DrAWAHgiS6vDwgy7tsj0w0cX3jE6Q8LcJ8eE
         FUA+xdNxGKOhLOGQk1zD/j2Ka0a/pCbU09weshFAcz6qpHpOXY6QrMXd6RsF9tqcPnmi
         2xfeongRUWb7Ets9ZbHg9zvrEJsaMTOKFIdpYetEso1F2cGt47EjWP0oKJDI3vwGvu9Y
         CijQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcVPurjqx7CpFHzwNWZQajRBv0dk0K3nJzL3PJLkNk0oKQKI4e6BNqdnFMiCfXBeHi/ohm+bzOFvsh/a0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgOY6vufRc5pw/gXF8W1F/vDijwOLBTgiTUzlD7yVpL2VR9ykG
	FYVrRyHZKL0gjYJdE7NY5NSj+6EodwiLDOrrSbvmB8o1RKhkUaZl8tHO/+vtWNMBbs0jySZNANH
	JH71WWA5FZgMmbw==
X-Google-Smtp-Source: AGHT+IFLbqLP4y9VzvHzeY0NK/ko0qJcgJDnQDoVhaZ1NLWwdjq/QRcEPRrnluk2M64Siud++fEyGmKNZKOPkA==
X-Received: from wmqb8.prod.google.com ([2002:a05:600c:4e08:b0:45d:d60a:8d7e])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:609b:b0:45d:e4ff:b642 with SMTP id 5b1f17b1804b1-46e32a04a4emr1138645e9.25.1758726012269;
 Wed, 24 Sep 2025 08:00:12 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:59:40 +0000
In-Reply-To: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250924-b4-asi-page-alloc-v1-5-2d861768041f@google.com>
Subject: [PATCH 05/21] x86/mm/pat: mirror direct map changes to ASI
From: Brendan Jackman <jackmanb@google.com>
To: jackmanb@google.com, Andy Lutomirski <luto@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	mingo@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org, 
	david@redhat.com, derkling@google.com, junaids@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, reijiw@google.com, 
	rientjes@google.com, rppt@kernel.org, vbabka@suse.cz, x86@kernel.org, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

ASI has a separate PGD for the physmap, which needs to be kept in sync
with the unrestricted physmap with respect to permissions.

Since only the direct map is currently populated in that address space,
just ignore everything else. Handling of holes in that map is left
behaving the same as the unrestricted pagetables.

Co-developed-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/mm/pat/set_memory.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index d2d54b8c4dbb04cf276d074ddee3ffde2f48e381..53c3ac0ba55d6b6992db6f6761ffdfbd52bf3688 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -3,6 +3,7 @@
  * Copyright 2002 Andi Kleen, SuSE Labs.
  * Thanks to Ben LaHaise for precious feedback.
  */
+#include <linux/asi.h>
 #include <linux/highmem.h>
 #include <linux/memblock.h>
 #include <linux/sched.h>
@@ -1780,6 +1781,11 @@ static int populate_pgd(struct cpa_data *cpa, unsigned long addr)
 	cpa->numpages = ret;
 	return 0;
 }
+static inline bool is_direct_map(unsigned long vaddr)
+{
+	return within(vaddr, PAGE_OFFSET,
+		      PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT));
+}
 
 static int __cpa_process_fault(struct cpa_data *cpa, unsigned long vaddr,
 			       int primary)
@@ -1808,8 +1814,7 @@ static int __cpa_process_fault(struct cpa_data *cpa, unsigned long vaddr,
 	 * one virtual address page and its pfn. TBD: numpages can be set based
 	 * on the initial value and the level returned by lookup_address().
 	 */
-	if (within(vaddr, PAGE_OFFSET,
-		   PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT))) {
+	if (is_direct_map(vaddr)) {
 		cpa->numpages = 1;
 		cpa->pfn = __pa(vaddr) >> PAGE_SHIFT;
 		return 0;
@@ -1981,6 +1986,27 @@ static int cpa_process_alias(struct cpa_data *cpa)
 	return 0;
 }
 
+/*
+ * Having updated the unrestricted PGD, reflect this change in the ASI
+ * restricted address space too.
+ */
+static inline int mirror_asi_direct_map(struct cpa_data *cpa, int primary)
+{
+	struct cpa_data asi_cpa = *cpa;
+
+	if (!asi_enabled_static())
+		return 0;
+
+	/* Only need to do this for the real unrestricted direct map. */
+	if ((cpa->pgd && cpa->pgd != init_mm.pgd) || !is_direct_map(*cpa->vaddr))
+		return 0;
+	VM_WARN_ON_ONCE(!is_direct_map(*cpa->vaddr + (cpa->numpages * PAGE_SIZE)));
+
+	asi_cpa.pgd = asi_nonsensitive_pgd;
+	asi_cpa.curpage = 0;
+	return __change_page_attr(cpa, primary);
+}
+
 static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary)
 {
 	unsigned long numpages = cpa->numpages;
@@ -2007,6 +2033,8 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary)
 		if (!debug_pagealloc_enabled())
 			spin_lock(&cpa_lock);
 		ret = __change_page_attr(cpa, primary);
+		if (!ret)
+			ret = mirror_asi_direct_map(cpa, primary);
 		if (!debug_pagealloc_enabled())
 			spin_unlock(&cpa_lock);
 		if (ret)

-- 
2.50.1


