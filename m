Return-Path: <linux-kernel+bounces-837171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C128BAB9C3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B833A6473
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12940283680;
	Tue, 30 Sep 2025 05:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lst4y7dB"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D242E27FB3E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211968; cv=none; b=eAf1tBpwegmlhTiK7eNUSsdLuAjSFz2CzMRIbWVdQ2zKbjvNOtrk3aVIJFEFqSIanARorNQjlkcA1bDszcX7IiZ9jQUWD8uup3fFhHwDJuueIfzWa0xPSCOJEfq/MoSfi2HP0aMuOJQIhLtOggVV3SRCWuyxRNKSgYLjA7gdKTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211968; c=relaxed/simple;
	bh=4VkQKrS6FikymCfZ1+5puhT+uYYqYYXhQgE3Hi/wt0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbjsBILYdq13lz2BpkJocpALlciLTndfF5LRWoHUtjt5JHJgyKEbqtZrsmoXObFfbcwDm/3Y9jys9u8MGk/Ln5z0Ukg4x3ZCtFRzx8FiPEb45YDr1M/3Uw8W+ZU1I2C8IC5I4m8kA/7NbV/SDM2oaE+eRLwIt/6IOX9nE1ewSi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lst4y7dB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2681660d604so52256985ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759211966; x=1759816766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bj30sQDVRkZpxPh0yEwciSjpXqkKKqMqk3AWrRPDElU=;
        b=Lst4y7dBYV6F49SB2gq8lqFojT9lOwA0/hTZKSmEvuQxysLhsV87b7g4LJefLfElOB
         sfhPeAqdMCa1mim0Pfbs57Tk1l7c/VUSNt6X7NoAAPi5IIeqQXjfLk3w+ae4psFPhEGc
         7fEDbFZMOUoUE1TNywu5tJ3vHacVJLuQ/2K/2fLOgTY+fbx4zEr4mEiU3zie2+h6UPB7
         JdQk4E1JmNrQaFaRWjvljdbEhFHg/0cXIzzAuRfz3RVSka5W3bjfvHKfwzJPRiw3iXga
         gkcaWuah+0QBWekZGSJu9z11IsewWc1eWQ5f8tAfE7wjkVwoKxFwOjskdL4mAMqN1jlF
         djVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759211966; x=1759816766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bj30sQDVRkZpxPh0yEwciSjpXqkKKqMqk3AWrRPDElU=;
        b=iC6v/Jz4nnHZzGM/+79OscqwoI2/N4KN0ZAQBfmudU5rxm/aHIiry0k4QGdDqUh0cZ
         T3tcs3ZzZb7beP4YUtvBo0ZtHupGgA6bw8AToYaz7qMv0Hoo3lgVqXwJgqe8Vha/swsX
         Y8kF75aEBhhGD+CFs4hrUVnGsDhJ+obgJyO3XL0HaF5uKSC1uNF8kzmMLzmvWN6OJWg9
         O/fSEx5p9FgqxhoRkFQhSCwtQzLdH+VAGs6IpMjCP6cGDGLyfuUTwMohT12rxMQL72iN
         JliT5MH30MGnWZkKURtEz7VhVtOWBTI1gSBBa9/vyG9FCsI8NOMjgO+jIDq0xmAeQnTO
         Z8NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ1/ACfl4ogRsoCOnIlXKSVWBTBGvGc5MQED7bVPk2RKUurwwUn5RcCYZzPl7Oy90mKC9vi0kkE7yfhHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2M9uE78eMulnUzSjcmP0wgmYBjcg5F5HTKmTtXMaijxl2LBp3
	dANHBqLbzhSnOtJSWS5voRSqKI8VLGUlLJpG/Z8Ji8HyJixPgnFV/0so
X-Gm-Gg: ASbGnctT+v14wPFhIhaL5OM/I97Ss45cZwUEpg44leHD1gUnTOQHNpAvRy5PcL74HwC
	iuaYT9r2yD8FsNgWt7/LHPs4lRDAFHQMknASamksaY7XETF+DEq5FWXiXpviP1LxcUx9uVxKdXo
	X0JJRFMQqFH/7nKvgFPMW6oWMkPFIaGUjwDWXwiRhXXsBJEH0zxqaghJ8qx7Z8lFSvgJIjohLAU
	V3w0qCU5xK5+NGn6/7D25p9ecwMSp0UlLWFwY1o3txPECe0nriYdaR0LWtzPRXlktAGGdqbJe3y
	YdhTzQPgcsoI3cjLlunC5DERWiE9zLhinPfVaoDbFnEVhZjauO07yLDIUYBag2xLSpi4ttgsGc1
	a5qHydPgcKGvqop67pAWyM+3F+fIs2of5uY8ZPd459zKB0zGg2YtWI5sZ1eV8q0332eHMhyHkMd
	YLIGwaek+ByV+MZ8c1SUFt42byYqIEJItOJ+9tcw==
X-Google-Smtp-Source: AGHT+IEmo2u/7V63Fa+4aKjEO7zXO6V10zopA5XEUoYxrgliFdmiMUfOOebvAfkXMDqtGOOwYbddwQ==
X-Received: by 2002:a17:902:fc86:b0:269:8407:5ae3 with SMTP id d9443c01a7336-27ed4a60923mr250920865ad.54.1759211966029;
        Mon, 29 Sep 2025 22:59:26 -0700 (PDT)
Received: from localhost.localdomain ([61.171.228.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d43b8sm148834065ad.9.2025.09.29.22.59.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Sep 2025 22:59:25 -0700 (PDT)
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
Subject: [PATCH v9 mm-new 04/11] mm: thp: decouple THP allocation between swap and page fault paths
Date: Tue, 30 Sep 2025 13:58:19 +0800
Message-Id: <20250930055826.9810-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250930055826.9810-1-laoar.shao@gmail.com>
References: <20250930055826.9810-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The new BPF capability enables finer-grained THP policy decisions by
introducing separate handling for swap faults versus normal page faults.

As highlighted by Barry:

  We’ve observed that swapping in large folios can lead to more
  swap thrashing for some workloads- e.g. kernel build. Consequently,
  some workloads might prefer swapping in smaller folios than those
  allocated by alloc_anon_folio().

While prtcl() could potentially be extended to leverage this new policy,
doing so would require modifications to the uAPI.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Usama Arif <usamaarif642@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>
---
 include/linux/huge_mm.h | 3 ++-
 mm/huge_memory.c        | 2 +-
 mm/memory.c             | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 02055cc93bfe..9b9dfe646daa 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -97,9 +97,10 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
 
 enum tva_type {
 	TVA_SMAPS,		/* Exposing "THPeligible:" in smaps. */
-	TVA_PAGEFAULT,		/* Serving a page fault. */
+	TVA_PAGEFAULT,		/* Serving a non-swap page fault. */
 	TVA_KHUGEPAGED,		/* Khugepaged collapse. */
 	TVA_FORCED_COLLAPSE,	/* Forced collapse (e.g. MADV_COLLAPSE). */
+	TVA_SWAP_PAGEFAULT,	/* serving a swap page fault. */
 };
 
 #define thp_vma_allowable_order(vma, type, order) \
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1ac476fe6dc5..08372dfcb41a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -102,7 +102,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 unsigned long orders)
 {
 	const bool smaps = type == TVA_SMAPS;
-	const bool in_pf = type == TVA_PAGEFAULT;
+	const bool in_pf = (type == TVA_PAGEFAULT || type == TVA_SWAP_PAGEFAULT);
 	const bool forced_collapse = type == TVA_FORCED_COLLAPSE;
 	unsigned long supported_orders;
 	vm_flags_t vm_flags = vma->vm_flags;
diff --git a/mm/memory.c b/mm/memory.c
index cd04e4894725..58ea0f93f79e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4558,7 +4558,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
 	 * and suitable for swapping THP.
 	 */
-	orders = thp_vma_allowable_orders(vma, TVA_PAGEFAULT,
+	orders = thp_vma_allowable_orders(vma, TVA_SWAP_PAGEFAULT,
 					  BIT(PMD_ORDER) - 1);
 	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
 	orders = thp_swap_suitable_orders(swp_offset(entry),
-- 
2.47.3


