Return-Path: <linux-kernel+bounces-846145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D399ABC7271
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED0F3E5CAE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 01:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6441DE89A;
	Thu,  9 Oct 2025 01:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aZ/d4XlC"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8152E19E967
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975133; cv=none; b=hMXVpy/znTNibit6wyshaUfPxKCDucx7jCV8qvWwoC3oJEaHC3NtLPE+W22th8io9bix4okF1dkxiARH3jjw0PRpWl33k14u6gCE/gVMlu5M0jKPVsin/pqMHrJflmG7sAFT66dRls1YVlWpOqUn/8jYuUPzqHNZUZNUOn2zuzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975133; c=relaxed/simple;
	bh=IqUA0dv+AH6dHyrRvZgGbgT7I6zVi/nodo8FrJqLt3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvpwRf2PxbdvTv78FPmtHrlOZNqYoWgbGOjAcu2oASfn6r2l/wW0reC8BsVlJckKV7mO59RsJpHpnGW+yoMfM9cDkNn24OCbO/N94oU4Yp7rvXvxhzMjz+93OFr2yEUtDenmDX0b88LkC+IiqM0u3foRDiW6x7DHj0IJoIA9Ll8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=aZ/d4XlC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27d3540a43fso4217045ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1759975127; x=1760579927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lp2v9w2qTrkESoVDLPmv+GpD3nzqMphlK45S5OJoAnI=;
        b=aZ/d4XlCK3S3gjAVMIDj21Vyr8OO1/0MsQ509KBmUJFecwBNY87YtD9vOLYz2+SLYK
         mi+sW3ibbSqkV8JH+aUh5xFPzu9V5Pvb1T8SBi3iEcIX09+4wxOJ98+aOgVV5A6Pn4tE
         eKsMqHB5S/inPEQU1qnPwrhLXbV8I+AjAJSQm2437jpgMLmo91fH+ANHb7LGKYTkvcZD
         gNeEgd2D9Z5qMArC1tVG6JUFXgseLDW1TFsoLalzZeZcmir4mIwQvi1tHxBMMXPzacbZ
         7/AYI5UPAr5JtmcpvvWAt6fhGCepTIZ1HkxYmDMlNIRbq08OSxD7kdK6iXiyxbvg6/MG
         7aPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759975127; x=1760579927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lp2v9w2qTrkESoVDLPmv+GpD3nzqMphlK45S5OJoAnI=;
        b=bafBdHDUrp7V+EN6UXXU9BWKJjPJuk1I6le78F7REinuz2Ka/jmeqSrwbmlT6NC7mb
         h5rSYk+Zm6OrhY5vPD0IYylIOXhKs2aM2a9r6NmIsUjEMQch/4ZBwqk0D8sqdsNMsf+x
         c0q+e2LMrzAjPwWvPTT2oM66xxb7mew7slmFRaL66DY/9WadjBch6PxgGgSlaAzShIzc
         Fe2knjjR8gtQzN3bbXPaFiMtRYnKu4zEcZo6sdu2K1rch3g86qSC4IVvQPHGm/hy+fhi
         1hy4VrnhL9n5lqF/G4uvb0PCxTxJecsPWjq97pykbGGpoKfOax8HbHjwA6qUFIWDyB1l
         nEOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9S593xiiij7HbdJClhK3jtSAXnfyjvYaocV0O1I8GxFvUOpkRDoR2+HGp2PEz19/oz16/D3+yQu2l58k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZQFwxHLLEfy4MNbsBHoWz+wOsJvDEpB9Bn1ZveJQw0Q0QTUsm
	cFcB9uzV5y36fvLXRsJFrXlJ6JHNoTL3+67tMV2llQdNBLWDSQ0Tdm9pRaOP2PtQZ6s=
X-Gm-Gg: ASbGncsMmpE/G+uMcZZTqKUw10p93nKRZnizvmbIpi4q7qo6lbVBCI6DsSGSUX09ZK/
	9q0MjQkBPVgjRRu0XsmSRf5MVro/5qct6f9C4fOeOkDYTOtZDsOc4gCxSwryuzddmLe45SCU0i5
	SwSItmz5Nkb9EjHtfRZBwgg2ah6/FH0pPAUEAcY93lcYNzEwfu6fepaOU8v9mBdDXJuYS36nGOo
	Genvu4MkzanzhAhsSSX3WHQVLozIAutrmIxIcJ6FXwfPKDqnx1Cre6J7NfVr8Emu4MG4+E0dbUa
	8QjaemiE0BsvXtBeVaqS1XeXhmx5B7B3I4c7I5sL2fyBgJ45u0+/EELl1JFucA/vKSR9Ap8IlKP
	sGDRbVcJ0g8O+WhMTtYFgXX+YXHqBcj6yAqODiF1BB+B30qoHH20bZq8GmLoqL4PJ/zQCoCt9J0
	5OV9c=
X-Google-Smtp-Source: AGHT+IE+agqXEhLEONLyA5d2qyFrvAw1S+1pygAwMmWTwUwpcKU01+ZnN2Cp743AX1wJ7euQQmxe/A==
X-Received: by 2002:a17:903:2292:b0:24c:bc02:788b with SMTP id d9443c01a7336-290272e3debmr85255285ad.44.1759975127215;
        Wed, 08 Oct 2025 18:58:47 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de53f9sm11033585ad.14.2025.10.08.18.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 18:58:46 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Conor Dooley <conor@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 05/18] mm: Allow page table accessors to be non-idempotent
Date: Wed,  8 Oct 2025 18:57:41 -0700
Message-ID: <20251009015839.3460231-6-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251009015839.3460231-1-samuel.holland@sifive.com>
References: <20251009015839.3460231-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, some functions such as pte_offset_map() are passed both
pointers to hardware page tables, and pointers to previously-read PMD
entries on the stack. To ensure correctness in the first case, these
functions must use the page table accessor function (pmdp_get()) to
dereference the supplied pointer. However, this means pmdp_get() is
called twice in the second case. This double call must be avoided if
pmdp_get() applies some non-idempotent transformation to the value.

Avoid the double transformation by calling set_pmd() on the stack
variables where necessary to keep set_pmd()/pmdp_get() calls balanced.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - New patch for v2

 kernel/events/core.c  | 2 ++
 mm/gup.c              | 3 +++
 mm/khugepaged.c       | 6 ++++--
 mm/page_table_check.c | 3 +++
 mm/pgtable-generic.c  | 2 ++
 5 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 952ba4e3d8815..d75be3d9e0405 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8142,6 +8142,8 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 	if (pmd_leaf(pmd))
 		return pmd_leaf_size(pmd);
 
+	/* transform pmd as if &pmd pointed to a hardware page table */
+	set_pmd(&pmd, pmd);
 	ptep = pte_offset_map(&pmd, addr);
 	if (!ptep)
 		goto again;
diff --git a/mm/gup.c b/mm/gup.c
index f5676a3aa525d..34d1b59bd59c1 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2865,7 +2865,10 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 	int ret = 0;
 	pte_t *ptep, *ptem;
 
+	/* transform pmd as if &pmd pointed to a hardware page table */
+	set_pmd(&pmd, pmd);
 	ptem = ptep = pte_offset_map(&pmd, addr);
+	pmd = pmdp_get(&pmd);
 	if (!ptep)
 		return 0;
 	do {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index acc620158696e..d8c22ef8406bd 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1731,7 +1731,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		struct mmu_notifier_range range;
 		struct mm_struct *mm;
 		unsigned long addr;
-		pmd_t *pmd, pgt_pmd;
+		pmd_t *pmd, pgt_pmd, pmdval;
 		spinlock_t *pml;
 		spinlock_t *ptl;
 		bool success = false;
@@ -1784,7 +1784,9 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		 */
 		if (check_pmd_state(pmd) != SCAN_SUCCEED)
 			goto drop_pml;
-		ptl = pte_lockptr(mm, pmd);
+		/* pte_lockptr() needs a value, not a pointer to a page table */
+		pmdval = pmdp_get(pmd);
+		ptl = pte_lockptr(mm, &pmdval);
 		if (ptl != pml)
 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
 
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 31f4c39d20ef9..77d6688db0de9 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -260,7 +260,10 @@ void __page_table_check_pte_clear_range(struct mm_struct *mm,
 		return;
 
 	if (!pmd_bad(pmd) && !pmd_leaf(pmd)) {
+		/* transform pmd as if &pmd pointed to a hardware page table */
+		set_pmd(&pmd, pmd);
 		pte_t *ptep = pte_offset_map(&pmd, addr);
+		pmd = pmdp_get(&pmd);
 		unsigned long i;
 
 		if (WARN_ON(!ptep))
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 63a573306bfa2..6602deb002f10 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -299,6 +299,8 @@ pte_t *___pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 		pmd_clear_bad(pmd);
 		goto nomap;
 	}
+	/* transform pmdval as if &pmdval pointed to a hardware page table */
+	set_pmd(&pmdval, pmdval);
 	return __pte_map(&pmdval, addr);
 nomap:
 	rcu_read_unlock();
-- 
2.47.2


