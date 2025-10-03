Return-Path: <linux-kernel+bounces-841552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7894BB7A1F
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0502A4E534B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8EF2D7DE1;
	Fri,  3 Oct 2025 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RWf8JYRA"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8C42D7386
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510643; cv=none; b=A1Vm4QmpeKgU1sHE0CD+Qr4897y9lc+YbAuxduFcoQaH4Gj4ZaQgbFC9zsDf04kdmYdfIMD7R77HgOeKQ3CRoOReKkm/glAkgi34kQRKRGGShcFPoV4qq0YdAGKCXNq3sB1QrFCX+I1SoVUgkIjLg1H6UAgHpkWu7R/Ih1HXh9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510643; c=relaxed/simple;
	bh=iwF20Q3n5gWfKvZw+yxcidb9rw0+Vy6cxDpSQ1KXsdM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cVcClniS4kjjXvVOYp3AdLofprrvmz7cOoBae08qLwdZnhpDviQ/WLDt1IVH2z6dsLBh8ckmuIqL0TnlixLl9xlP7ahscYa1MRqkBRey93zyHGinsZrJEYUbdX7ONjVMjVjUBTGcZkybJSzM51TMwDuLDRaiCds1q0dASY96D4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RWf8JYRA; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b3d6645acd3so264733466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759510640; x=1760115440; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uY9OoKCgL0HKzC+Mz4yXU5nEOOMNzqgQrUAEjtqlCW4=;
        b=RWf8JYRANqEnwIhkSimEW4u4jC0MqBOGWjfoQTH/BYQdBA3hkwvT3fcsVMLcaSwxa3
         vmTQMgZSOxr7DzXq2rIrhk7cAicP+BCMYnCLvMA+MgN39asLPqvjpmeaOfI4p26zW3Xi
         9mar4H9GmF+EODmzl2yaQvXIm4OM5ffY0Gs6vsxC+b1o8ydEvdxVvub/4WqrONHr7/3D
         SNi1C1iHHOTlwi/qyV10EMZZ5Bf5BNCYvyRPX8/XjAF3EH32jASFAMV1BBwvXc29wZcI
         X4VRcd7pddFq3FHGzThM6c6NnOfokNRecPDfs9G2yeYzPkwh3UXoqgip0jR6Mp/2l4Yk
         pgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759510640; x=1760115440;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uY9OoKCgL0HKzC+Mz4yXU5nEOOMNzqgQrUAEjtqlCW4=;
        b=tMkRXFd7tRX4X5N9bkhnwHkt7zriLutZ7lBtcrGwhXHEo4QT8Bazr9M+94rYDrYeO9
         d1xI3htj8BejPeYQ+zAYO3zZisA+L/m47psMK/zvS5OdNC4jUzy0eEtSks5EzfQVQR2e
         ROW6IMj17hPWom+1HEBb2xnI801kRByNkaxWkOWf/cpeqkBH4TC0MGQ8y4Ecd2ktVeTS
         nWVBDQrAPmjFK+bf3NkrA0KN6G/YZFboUvrtej3c/bgvluBX73GWWAx8yocKH3sMrvrC
         GzOHeUmpDpf0Wwa7zUMGAy7Ksd5hcYgu7lu2YYiX4B15PIow0iB46w3FmTlAr7Bdz2eP
         qUKA==
X-Gm-Message-State: AOJu0YxXQEzqV5FPF2a4LzRUmSJp7KWzBsGfWMAXl2b53UoiXdpA6aCi
	3X2g8HY5zB38mW3Pb12En30w0dIR8MhXoAclMVndpSckqFbo0QyJOMhnYoX9O4hSTMENcuGB8ea
	lclUy+HZtF1ljRw==
X-Google-Smtp-Source: AGHT+IF6gfrsvSosFMZycjEWJHffey2Umhtr/SVmyNL/o+NI6aEx1UuKGHUlS4COg8E+nOyjoDlRKa48QSWYSw==
X-Received: from ejxa6.prod.google.com ([2002:a17:906:80c6:b0:b3e:c30f:fe0d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:f597:b0:b40:51c0:b2d2 with SMTP id a640c23a62f3a-b49c4393c4emr487983666b.63.1759510639323;
 Fri, 03 Oct 2025 09:57:19 -0700 (PDT)
Date: Fri, 03 Oct 2025 16:56:43 +0000
In-Reply-To: <20251003-x86-init-cleanup-v1-0-f2b7994c2ad6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003-x86-init-cleanup-v1-0-f2b7994c2ad6@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251003-x86-init-cleanup-v1-3-f2b7994c2ad6@google.com>
Subject: [PATCH 3/4] x86/mm: drop unused return from pgtable setup functions
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

These functions return the last physical address that they mapped, but
none of their callers look at this value. Drop it.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/include/asm/pgtable.h |  3 +--
 arch/x86/mm/init.c             | 16 +++++++---------
 arch/x86/mm/init_64.c          |  7 +++----
 arch/x86/mm/mm_internal.h      |  5 ++---
 4 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index e33df3da698043aaa275f3f875bbf97ea8db5703..6fd789831b40dd7881a038589f5f898629b8c239 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1177,8 +1177,7 @@ extern int direct_gbpages;
 void init_mem_mapping(void);
 void early_alloc_pgt_buf(void);
 void __init poking_init(void);
-unsigned long init_memory_mapping(unsigned long start,
-				  unsigned long end, pgprot_t prot);
+void init_memory_mapping(unsigned long start, unsigned long end, pgprot_t prot);
 
 #ifdef CONFIG_X86_64
 extern pgd_t trampoline_pgd_entry;
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index bb57e93b4caf16e4ceb4797bb6d5ecd2b38de7e6..d97e8407989c536078ee4419bbb94c21bc6abf4c 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -531,11 +531,11 @@ bool pfn_range_is_mapped(unsigned long start_pfn, unsigned long end_pfn)
  * This runs before bootmem is initialized and gets pages directly from
  * the physical memory. To access them they are temporarily mapped.
  */
-unsigned long __ref init_memory_mapping(unsigned long start,
-					unsigned long end, pgprot_t prot)
+void __ref init_memory_mapping(unsigned long start,
+			       unsigned long end, pgprot_t prot)
 {
 	struct map_range mr[NR_RANGE_MR];
-	unsigned long ret = 0;
+	unsigned long paddr_last = 0;
 	int nr_range, i;
 
 	pr_debug("init_memory_mapping: [mem %#010lx-%#010lx]\n",
@@ -545,13 +545,11 @@ unsigned long __ref init_memory_mapping(unsigned long start,
 	nr_range = split_mem_range(mr, 0, start, end);
 
 	for (i = 0; i < nr_range; i++)
-		ret = kernel_physical_mapping_init(mr[i].start, mr[i].end,
-						   mr[i].page_size_mask,
-						   prot);
+		paddr_last = kernel_physical_mapping_init(mr[i].start, mr[i].end,
+							  mr[i].page_size_mask,
+							  prot);
 
-	add_pfn_range_mapped(start >> PAGE_SHIFT, ret >> PAGE_SHIFT);
-
-	return ret >> PAGE_SHIFT;
+	add_pfn_range_mapped(start >> PAGE_SHIFT, paddr_last >> PAGE_SHIFT);
 }
 
 /*
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 968a5092dbd7ee3e7007fa0c769eff7d7ecb0ba3..7462f813052ccd45f0199b98bd0ad6499a164f6f 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -810,14 +810,13 @@ kernel_physical_mapping_init(unsigned long paddr_start,
  * when updating the mapping. The caller is responsible to flush the TLBs after
  * the function returns.
  */
-unsigned long __meminit
+void __meminit
 kernel_physical_mapping_change(unsigned long paddr_start,
 			       unsigned long paddr_end,
 			       unsigned long page_size_mask)
 {
-	return __kernel_physical_mapping_init(paddr_start, paddr_end,
-					      page_size_mask, PAGE_KERNEL,
-					      false);
+	__kernel_physical_mapping_init(paddr_start, paddr_end,
+				       page_size_mask, PAGE_KERNEL, false);
 }
 
 #ifndef CONFIG_NUMA
diff --git a/arch/x86/mm/mm_internal.h b/arch/x86/mm/mm_internal.h
index 097aadc250f7442986cde998b17bab5bada85e3e..436396936dfbe5d48b46872628d25de317ae6ced 100644
--- a/arch/x86/mm/mm_internal.h
+++ b/arch/x86/mm/mm_internal.h
@@ -14,9 +14,8 @@ unsigned long kernel_physical_mapping_init(unsigned long start,
 					     unsigned long end,
 					     unsigned long page_size_mask,
 					     pgprot_t prot);
-unsigned long kernel_physical_mapping_change(unsigned long start,
-					     unsigned long end,
-					     unsigned long page_size_mask);
+void kernel_physical_mapping_change(unsigned long start, unsigned long end,
+				    unsigned long page_size_mask);
 void zone_sizes_init(void);
 
 extern int after_bootmem;

-- 
2.50.1


