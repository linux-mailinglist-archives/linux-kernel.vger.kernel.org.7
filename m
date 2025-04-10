Return-Path: <linux-kernel+bounces-598321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAD4A844C4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 15:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 340767A9F45
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 13:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CABE2857FF;
	Thu, 10 Apr 2025 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eQhHKe6s"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFBC42AA3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291738; cv=none; b=hGFfJhZT1ERjkI2RH0lDidWICtAl/VjWKXw9yluQiOCGnR6PymrEBqL6KW/ZuYDgEbORAegTXsaLDbxyna9c0DIcYd8OzMkcrqU6FOUGaJyJoIvCDDwQ4liLcqhjG1HMsJIv2z072D7lmigTCRzwMdjrK6Tm+cLlaLlYif/OQSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291738; c=relaxed/simple;
	bh=C8c/5h00VNf73qWbummLMf0CGChlKbIF8uEpD6iaxoY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jG77S0r6s0XhMrXg7J4l00vC+ZLMqayN2sw5USlIMvylbLuOqL8SlcprajZMQRnDgNoBNDGYYzJqj7hKalVp9KwDaVgQaZPv1pXRcw/X8Dj2z2LSauxrm1jeLU5xVcgOOcz7V87n1Hcq0ltTQLp18muNo20wkLsdyb3TujYW56M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eQhHKe6s; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d08915f61so4844685e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 06:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744291735; x=1744896535; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SS5Sb1QiEJlBf4gnyxvUbwQU6CF/Mt8Qf5/ZSXRB/sE=;
        b=eQhHKe6sX33UvLf1AEB6B1MbCZ38ZWed9nnmwQj9AN+h6RHq6EHZaAayNhAJRmL9YJ
         VJo8z66aqkiLswVklypMlcEWMAeqo9UubTkFcmPeRN60IlVwCGZyYj59DuQQuHlPhI1N
         DNdc7C4QrC/cEokZi9y73fh0Xd2+uhgouKlg+LftPaGWJEjsX7bJHTJ/CvIuTwU6o6Zq
         bsy5h21iQqSK8x4Xcs1q9+rvv5n8vuDALbuc1ejkIhkdbDA8pOxTbnXwA7KthLMxLVkB
         6DXCheO07Pghx5B6TZ1XpHVuoyv2Thco2bIMdjDjyIlyarT4drfMTLdOWWCW6rbmRT81
         /xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744291735; x=1744896535;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SS5Sb1QiEJlBf4gnyxvUbwQU6CF/Mt8Qf5/ZSXRB/sE=;
        b=cs5G9i+nKfCwmxVi0bRYIhzqzHCuCwnQhBHzZTZKkgts3ioQ4d9is5T4+2WNeQvzbe
         mxGa5ssf9xASQemVlDt5xgdyE8v+DaahqFG4TN8LxhSEKaJdERyEs5owKYWBHIYSOVHA
         HtS8WIcsMSEUBhYPgoCQXsvgU45zfNL0X0T12OAbLwPJZpPLdMSNzm3y9Xgmx61z83Kl
         0XPQFdOZYGUzkgn+ZSZ6cTjNNIUgObPLusMju5ruBQnYMWl6gfF4o00QermiDEd5bV75
         M3eYt9okvXpAwfQg/rZOu7fQiBJbTz3M1bqlmRb5tw9HxlOBsHb+OrjzWRUKyZ4LmgCA
         ltbA==
X-Forwarded-Encrypted: i=1; AJvYcCUlx/bgUZMg7nipF/+NyXcXA6g4m0KybxAkDU0Z5JkRYu9s8vB8gcJIRz7/hFXFJ2mrgk6XWIQP0AEfCi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw47C+WYosGbZZvIX6xra5OfCMCZh1MUTfrmqZ+8evLFA+hW73
	3KLXy6wUZhUbZZALka4HbVZ67LRfCA9m0HpmnRvZyYF/aVLeM/esDJUBQ++AVJM4JfcLxg==
X-Google-Smtp-Source: AGHT+IEqA9UEaF4ovqknxeoCna5e+h2A9LJb/CATGs/nfpQpZnxXMAv/pjBpPSrEELNjCWQnGZi85feW
X-Received: from wmbz25.prod.google.com ([2002:a05:600c:c099:b0:43c:f6b3:fa10])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1911:b0:43d:82c:2b11
 with SMTP id 5b1f17b1804b1-43f2ff9b203mr17956385e9.23.1744291735014; Thu, 10
 Apr 2025 06:28:55 -0700 (PDT)
Date: Thu, 10 Apr 2025 15:28:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4666; i=ardb@kernel.org;
 h=from:subject; bh=Th5F1nSY0iulqmnlKz0W9Dv7fXivwlI/yQUmNM3/K/g=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf378ck7fnsfvpf9XbU66UeIPdcnLRaVDLfdqd5eaY0XZ
 vAtb+jvKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABO5+4rhn4GGqOqihbOiGHuM
 fSYsNQ1wP/1RdHHpyzB7lpeWbKm9uxj+2R5pLz6qb1mXVOViJ7kos3vPttj9jwr+bW84/4r9Ras jLwA=
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250410132850.3708703-2-ardb+git@google.com>
Subject: [PATCH v3] x86/boot/sev: Avoid shared GHCB page for early memory acceptance
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Borislav Petkov <bp@alien8.de>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Communicating with the hypervisor using the shared GHCB page requires
clearing the C bit in the mapping of that page. When executing in the
context of the EFI boot services, the page tables are owned by the
firmware, and this manipulation is not possible.

So switch to a different API for accepting memory in SEV-SNP guests, one
which is actually supported at the point during boot where the EFI stub
may need to accept memory, but the SEV-SNP init code has not executed
yet.

For simplicity, also switch the memory acceptance carried out by the
decompressor when not booting via EFI - this only involves the
allocation for the decompressed kernel, and is generally only called
after kexec, as normal boot will jump straight into the kernel from the
EFI stub.

Cc: Tom Lendacky <thomas.lendacky@amd.com>,
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>,
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>,
Cc: Kevin Loughlin <kevinloughlin@google.com>
Co-developed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
Changes since v2 [0]:
- avoid two separate acceptance APIs; instead, use MSR based page-by-page
  acceptance for the decompressor as well

[0] https://lore.kernel.org/all/20250404082921.2767593-8-ardb+git@google.com/T/#m38389f607accd0cfa83c41c3bd0d410514b023c6

 arch/x86/boot/compressed/sev.c | 67 +++++---------------
 1 file changed, 15 insertions(+), 52 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index bb55934c1cee..89ba168f4f0f 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -164,10 +164,7 @@ bool sev_snp_enabled(void)
 
 static void __page_state_change(unsigned long paddr, enum psc_op op)
 {
-	u64 val;
-
-	if (!sev_snp_enabled())
-		return;
+	u64 val, msr;
 
 	/*
 	 * If private -> shared then invalidate the page before requesting the
@@ -176,6 +173,9 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	if (op == SNP_PAGE_STATE_SHARED)
 		pvalidate_4k_page(paddr, paddr, false);
 
+	/* Save the current GHCB MSR value */
+	msr = sev_es_rd_ghcb_msr();
+
 	/* Issue VMGEXIT to change the page state in RMP table. */
 	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
 	VMGEXIT();
@@ -185,6 +185,9 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	if ((GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(val))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
 
+	/* Restore the GHCB MSR value */
+	sev_es_wr_ghcb_msr(msr);
+
 	/*
 	 * Now that page state is changed in the RMP table, validate it so that it is
 	 * consistent with the RMP entry.
@@ -195,11 +198,17 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 
 void snp_set_page_private(unsigned long paddr)
 {
+	if (!sev_snp_enabled())
+		return;
+
 	__page_state_change(paddr, SNP_PAGE_STATE_PRIVATE);
 }
 
 void snp_set_page_shared(unsigned long paddr)
 {
+	if (!sev_snp_enabled())
+		return;
+
 	__page_state_change(paddr, SNP_PAGE_STATE_SHARED);
 }
 
@@ -223,56 +232,10 @@ static bool early_setup_ghcb(void)
 	return true;
 }
 
-static phys_addr_t __snp_accept_memory(struct snp_psc_desc *desc,
-				       phys_addr_t pa, phys_addr_t pa_end)
-{
-	struct psc_hdr *hdr;
-	struct psc_entry *e;
-	unsigned int i;
-
-	hdr = &desc->hdr;
-	memset(hdr, 0, sizeof(*hdr));
-
-	e = desc->entries;
-
-	i = 0;
-	while (pa < pa_end && i < VMGEXIT_PSC_MAX_ENTRY) {
-		hdr->end_entry = i;
-
-		e->gfn = pa >> PAGE_SHIFT;
-		e->operation = SNP_PAGE_STATE_PRIVATE;
-		if (IS_ALIGNED(pa, PMD_SIZE) && (pa_end - pa) >= PMD_SIZE) {
-			e->pagesize = RMP_PG_SIZE_2M;
-			pa += PMD_SIZE;
-		} else {
-			e->pagesize = RMP_PG_SIZE_4K;
-			pa += PAGE_SIZE;
-		}
-
-		e++;
-		i++;
-	}
-
-	if (vmgexit_psc(boot_ghcb, desc))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
-
-	pvalidate_pages(desc);
-
-	return pa;
-}
-
 void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 {
-	struct snp_psc_desc desc = {};
-	unsigned int i;
-	phys_addr_t pa;
-
-	if (!boot_ghcb && !early_setup_ghcb())
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
-
-	pa = start;
-	while (pa < end)
-		pa = __snp_accept_memory(&desc, pa, end);
+	for (phys_addr_t pa = start; pa < end; pa += PAGE_SIZE)
+		__page_state_change(pa, SNP_PAGE_STATE_PRIVATE);
 }
 
 void sev_es_shutdown_ghcb(void)
-- 
2.49.0.504.g3bcea36a83-goog


