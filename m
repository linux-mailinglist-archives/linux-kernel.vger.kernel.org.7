Return-Path: <linux-kernel+bounces-830757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1024B9A6FB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6861B25331
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311F53115A1;
	Wed, 24 Sep 2025 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xtau7mql"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5035930FF25
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726025; cv=none; b=dUvJzVetjJ3QqptdcTamglTPGAPzuQ6rdCSrjwUoQ5PTUuZympnkmWW49FvXqitaQhbH0oKeDgiYbFNeALJY/fS0Mr+oHddS0JMOZGLcy0MnDN2jU89fO54J3hh5BDPTz+TcttgJJjzu1YCROuxUEB20ZKrEiZcnrJXuKrhV3Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726025; c=relaxed/simple;
	bh=BlPWJVLTizBu3rBmLZteoElQSh8cUGz0SgfTUTNxP+U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aRYJrWawqcvmmrtBvdQzoOmXe3BnfBEPWc9rOXM/YZ00AJdkNlLaHF1Ad/PAkFG8qzEB60Jpew/f7an+o/wSKxICRRkP32AQNUfh+bQhoGplOieGEKsZmq6JdWsI113Xd/4eSy2YcNSppArirRc5rXYa5jS05p4t2XS/LPLmX4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xtau7mql; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so65918275e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758726022; x=1759330822; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dzh5+kDID1KhkCxx5TAU7iczEzF1E7tPp3j9MouQ4wI=;
        b=Xtau7mql6ix214wG0kWx5jZUnNgUoqpyTDkjFKKMMT0VJPqVA4+le3UpDtiBKuJjRE
         Ndmk9St9VNV/bXUgx1eALzppooG3r/izYY/8PumXqoad8AuTDCROMSAzIV+sUNWZZr7g
         Uvc3HlL7Dhk1PI7r+aVGrW6+vwj98+HMrJZyGGT7E1xpkiz29oaxBmHcLv3hIxrWzl9X
         1RnopMwjX+gZ/9o+ozNbFA8cLdN70TSn7tuC4Q7brFKc5lSzRb4LdtJfOV8LPs8X8Vwt
         1F3mizOhKxR7EHAxLquO7KxyKLQI8ju1Pjn8UK29t7RZ1KYITMtWCizzXWQBdxGNMSZl
         Hk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726022; x=1759330822;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dzh5+kDID1KhkCxx5TAU7iczEzF1E7tPp3j9MouQ4wI=;
        b=uoepEC8WSStPLRQs41IOhDvjTNQbS8/nm2R5DPqlkbh/TQFQKAyyXwLIDFdj+1IIIU
         XS5Lsk9qvytXldm8lbXa+6pho/qS/ZMuXLrzwO0JbbVMqlzBtuN2YGEc0jJcqJr5vQvm
         2KsYgGFiNxLz+7II+O1FsnVZjkVLYG8VI9jWLsn2FifbQ+qKgVEUqeX0fxRzHD00jCDE
         RpFIxDL43um6pdV5OrN/7ztoJ5itJluQdP7+fxabxdNLfrCliF9PWOOgUcR/N2bA6KB2
         jYYzMo5n4yPbAJ3Lhdc02RBVpdkSTHEIDlbVjYFIc+lgbwwtTmmQfatvM/bxXORz4UFq
         9A8A==
X-Forwarded-Encrypted: i=1; AJvYcCXUtOztPd/5EZf0UH5dvjajFfcJmvU4TS7p+v9pJ6SveVhL9CHq83SF8BaZey0PAMo626nX/R/m4K0sU3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNU6/LwkqSwZfBZK96eAsr8q34buRyHTpO2cCmJdpt1tm/kloS
	P6hUk/nxcSZnF7y8qfbzzLfsdwbnBB2j08KAAx213bOhp6nAQKjr/o8LOULl1pa6XjemEvRI+ha
	Udq/WJYJtOzzklQ==
X-Google-Smtp-Source: AGHT+IEsHROXBlX8gPQ5wff3adn8/PrmanibVw/L6EsgdA0zSkoUR9p6G5MTbXSwhHIl6BOnzg1VAmDD3yV6Wg==
X-Received: from wmbeu9.prod.google.com ([2002:a05:600c:81c9:b0:45f:2859:5428])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:608c:b0:46e:2f74:2b9a with SMTP id 5b1f17b1804b1-46e32a1a097mr1793855e9.30.1758726021991;
 Wed, 24 Sep 2025 08:00:21 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:59:49 +0000
In-Reply-To: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250924-b4-asi-page-alloc-v1-14-2d861768041f@google.com>
Subject: [PATCH 14/21] x86/mm/pat: introduce cpa_fault option
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
	yosry.ahmed@linux.dev
Content-Type: text/plain; charset="utf-8"

Different usecases for the CPA code have different needs for the
behaviour when encountering an unmapped address.

Currently this is encoded by using the presence of the .pgd as a
side-channel. Subsequent ASI changes won't get the correct behaviour
based on this side-channel, so add an explicit enum to request the
different behaviours that might be needed.

Note this is now making explicit a couple of causes that populate the
pagetables when encountering holes, until now this was implicit:

1. kernel_unmap_pages_in_pgd()

   Calling this function without a corresponding
   kernel_map_pages_in_pgd() seems like a bug, so the "correct"
   behaviour here might actually be CPA_FAULT_ERROR.

2. Ditto for __set_memory_enc_pgtable().

It seems the comment in __cpa_process_fault() (deleted in this patch)
may have been stale with regard to the coco usecases here (including
point 2).

Anyway, if these need to be updated that will be a separate patch, no
functional change is intended with this one.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/mm/pat/set_memory.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 53c3ac0ba55d6b6992db6f6761ffdfbd52bf3688..2a50844515e81913fed32d5b6d1ec19e8e249533 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -36,6 +36,16 @@
 
 #include "../mm_internal.h"
 
+/* What should CPA do if encountering an unmapped address? */
+enum cpa_fault {
+	/* Default depending on address. */
+	CPA_FAULT_DEFAULT = 0,
+	/* Populate cpa_data.pgd using cpa_data.pfn. */
+	CPA_FAULT_POPULATE,
+	/* Warn and return an error. */
+	CPA_FAULT_ERROR,
+};
+
 /*
  * The current flushing context - we pass it instead of 5 arguments:
  */
@@ -51,6 +61,7 @@ struct cpa_data {
 	unsigned int	force_split		: 1,
 			force_static_prot	: 1,
 			force_flush_all		: 1;
+	enum cpa_fault	on_fault		: 2;
 	struct page	**pages;
 };
 
@@ -1790,14 +1801,13 @@ static inline bool is_direct_map(unsigned long vaddr)
 static int __cpa_process_fault(struct cpa_data *cpa, unsigned long vaddr,
 			       int primary)
 {
-	if (cpa->pgd) {
-		/*
-		 * Right now, we only execute this code path when mapping
-		 * the EFI virtual memory map regions, no other users
-		 * provide a ->pgd value. This may change in the future.
-		 */
+	if (cpa->on_fault == CPA_FAULT_POPULATE)
 		return populate_pgd(cpa, vaddr);
-	}
+
+	if (WARN_ON(cpa->on_fault == CPA_FAULT_ERROR))
+		return -EFAULT;
+
+	/* CPA_FAULT_DEFAULT: */
 
 	/*
 	 * Ignore all non primary paths.
@@ -2417,6 +2427,7 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	cpa.mask_set = enc ? pgprot_encrypted(empty) : pgprot_decrypted(empty);
 	cpa.mask_clr = enc ? pgprot_decrypted(empty) : pgprot_encrypted(empty);
 	cpa.pgd = init_mm.pgd;
+	cpa.on_fault = CPA_FAULT_POPULATE;
 
 	/* Must avoid aliasing mappings in the highmem code */
 	kmap_flush_unused();
@@ -2743,6 +2754,7 @@ int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
 		.mask_set = __pgprot(0),
 		.mask_clr = __pgprot(~page_flags & (_PAGE_NX|_PAGE_RW|_PAGE_DIRTY)),
 		.flags = CPA_NO_CHECK_ALIAS,
+		.on_fault = CPA_FAULT_POPULATE,
 	};
 
 	WARN_ONCE(num_online_cpus() > 1, "Don't call after initializing SMP");
@@ -2786,6 +2798,7 @@ int __init kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
 		.mask_set	= __pgprot(0),
 		.mask_clr	= __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY),
 		.flags		= CPA_NO_CHECK_ALIAS,
+		.on_fault	= CPA_FAULT_POPULATE,
 	};
 
 	WARN_ONCE(num_online_cpus() > 1, "Don't call after initializing SMP");

-- 
2.50.1


