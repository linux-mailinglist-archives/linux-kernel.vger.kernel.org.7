Return-Path: <linux-kernel+bounces-898462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDA9C55544
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12EFA3AEB61
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21932E2825;
	Thu, 13 Nov 2025 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LFP/Xo9j"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DECB2DE715
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998435; cv=none; b=OIl+2KtzlhMdwBE81S+L8CIBQIMAQcgFUlH9NSeM00lF3iJLKRWQt2mjJByYrIyOfio3Ied2ha7tDsRUKC4se5V1v0A/N50UKtz5hdurhvhiZ3ufNDbFHkDIFZc85SxnNsJg8RETzUri59ZJgep97eLkubhmctMUVTWpITHsy5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998435; c=relaxed/simple;
	bh=gTvtvYKDEfGV0F0vdSkFMjg0H8V74zQ4iEre+dvdH9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyriL0O/swUK3NONQPuMwneHyhGUTO5Iv92hBmbpkM0iN0Vzvd5bnvkVi9OOxTqL3zFp1Rb0h6O5O74wIwM4MEDtLquqYPz/NDBXmzL+pMAHn9GFI6nDLbhr6Biz3nbvuU/tIolhTBcnAeVLZqyIgiZZuBYXkVQAl/hl9oaOZ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=LFP/Xo9j; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b18c6cc278so315409b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1762998433; x=1763603233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZA59qppRNlQ/gH4ZwlxZVtJjkZuT0TezTthNgG0I08=;
        b=LFP/Xo9jV2BPmMa1u4Yj/sisH2pM7mF3IoPo0pV7BIQ/+mASz4aNMPeeOwAECTqHPQ
         6zRf3+bJ24Pu8+c9AXlVbDZ7D+djFEIaTRIAt0fHxPN49v5Zpv8tMWJivg5pzVTKRAjc
         9Q5cZcNWGrpacLUrSWqSZgy7YJ0lXTHpTJ7rjF0qaIkNQAXyVTxLnCVXk5yp+VGdBpfx
         rdRyH6xNREkiPHo8b+SFSoBzHliyeSV52FFY59ScFApq8bw9C4Wkikv0d2HxSJoY6yzA
         YuPuAk+XPHUuBhy6MiRTJyfiW4iHuXhVS8WiVeiuZKqNpVMta27kkoAWNHB4yitVZM4u
         TcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762998433; x=1763603233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ZA59qppRNlQ/gH4ZwlxZVtJjkZuT0TezTthNgG0I08=;
        b=OXpPWPVc31hylfLTvBBNeg8uXFDxORzVLJtEOW9OHLYHn65/ODorspmcJWbEi171zT
         xERDZC0frT9rAjL+GWEN6drbGi0WY2EOKPPIttYv5F9W6WagsgkRkjpWGfSe41SF4yn2
         iLNcB0vEJ3nDxaECVzRSXubUdPdaEC/6PCC4nSOrOxRZRh04JDKlymdCOKdXzfWqwBSH
         T3Rb2b0B8jXGdFpBtEECtGfE8OwhzZrSeDG3D+bmvloNPHXaF3yw5A3fW1F2iCAlYUuH
         RcqH+oP4NaTi9S00gtoZiDYSd4zcwvd4JHMngMSYw9xMyvafbQN6P48K2RU25i1AmZJA
         3hGA==
X-Forwarded-Encrypted: i=1; AJvYcCWYEm0h4paB+4HfQgw7XRmxpS695MwmPbXatoxX7ZxUGnwwLZh2HdwX8MLkYe08Z9lCrzSzWrIy8RT9vdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyHTNwBifqtSTQj/DhCJ9KM7yzFRYfmV2BkfMVjC5GZ9rNMNOu
	UM04GdIfxIa4cJltlrwGSKR+vlqQqBfylN02X9nNGKqhg5oHssyCO3n1+BroN0t04OU=
X-Gm-Gg: ASbGnctgfC3vKcNJFVCtaC6BZt6jSW/54miHFInl2oLpBDoRO25nfInhVogfYmppsgk
	SKKt1uW3KTfl9E2YTD350YMBetcdigxB0KKQMBjEHGhVr/Wf8ubPo1dhG4qGjK15MdxTmIgyQN3
	gA/VI7wd3+UBoXXfNMdvfSunCzOKY2GGqEtDy2Pwg7N8VCZ99UFkQC16loJcykdd6jx28CrKiue
	sBJy4JNHnPRXe1pOp49CNOvpym3FujznW4/dBPNJxDihsKqdRQapBMo/C0/G7CLiKPqeIfkp5VD
	blYvmVYTwEVXXy4TKfmmbsMZmlgldLkFKsM8m+cD344D7W6Dx/cEu0o3Q3QIZ9rF7WhlAbEoL+C
	M2q4kLmfDkoGFnIdUyLQ7DBCtDOumr8BVG4lt0dq2Be/IoxU9JBxBqwHgIQHL1S2gQUrTJHKk5S
	pKPBPceZr22UfLenJNTbC76BBlC3GCjiB7
X-Google-Smtp-Source: AGHT+IEls7n+vPL3afsY1HaiLuKxeTZ1hxOSzGPwxU5ZDyX/ao4U4NfMKSzGsMG6BjM8vErLRKhy9g==
X-Received: by 2002:a17:902:ccd1:b0:295:7806:1d7b with SMTP id d9443c01a7336-2984eddee65mr65789335ad.45.1762998432890;
        Wed, 12 Nov 2025 17:47:12 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccae8sm4986485ad.98.2025.11.12.17.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 17:47:12 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Cc: devicetree@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Conor Dooley <conor@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 09/22] riscv: hibernate: Replace open-coded pXXp_get()
Date: Wed, 12 Nov 2025 17:45:22 -0800
Message-ID: <20251113014656.2605447-10-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251113014656.2605447-1-samuel.holland@sifive.com>
References: <20251113014656.2605447-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the semantically appropriate accessor function instead of open
coding the implementation. This will become important once these
functions start transforming the PTE value on some platforms.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

Changes in v2:
 - New patch for v2

 arch/riscv/kernel/hibernate.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hibernate.c
index 671b686c0158..2a9bc9d9e776 100644
--- a/arch/riscv/kernel/hibernate.c
+++ b/arch/riscv/kernel/hibernate.c
@@ -171,7 +171,7 @@ static int temp_pgtable_map_pte(pmd_t *dst_pmdp, pmd_t *src_pmdp, unsigned long
 	pte_t *src_ptep;
 	pte_t *dst_ptep;
 
-	if (pmd_none(READ_ONCE(*dst_pmdp))) {
+	if (pmd_none(pmdp_get(dst_pmdp))) {
 		dst_ptep = (pte_t *)get_safe_page(GFP_ATOMIC);
 		if (!dst_ptep)
 			return -ENOMEM;
@@ -183,7 +183,7 @@ static int temp_pgtable_map_pte(pmd_t *dst_pmdp, pmd_t *src_pmdp, unsigned long
 	src_ptep = pte_offset_kernel(src_pmdp, start);
 
 	do {
-		pte_t pte = READ_ONCE(*src_ptep);
+		pte_t pte = ptep_get(src_ptep);
 
 		if (pte_present(pte))
 			set_pte(dst_ptep, __pte(pte_val(pte) | pgprot_val(prot)));
@@ -200,7 +200,7 @@ static int temp_pgtable_map_pmd(pud_t *dst_pudp, pud_t *src_pudp, unsigned long
 	pmd_t *src_pmdp;
 	pmd_t *dst_pmdp;
 
-	if (pud_none(READ_ONCE(*dst_pudp))) {
+	if (pud_none(pudp_get(dst_pudp))) {
 		dst_pmdp = (pmd_t *)get_safe_page(GFP_ATOMIC);
 		if (!dst_pmdp)
 			return -ENOMEM;
@@ -212,7 +212,7 @@ static int temp_pgtable_map_pmd(pud_t *dst_pudp, pud_t *src_pudp, unsigned long
 	src_pmdp = pmd_offset(src_pudp, start);
 
 	do {
-		pmd_t pmd = READ_ONCE(*src_pmdp);
+		pmd_t pmd = pmdp_get(src_pmdp);
 
 		next = pmd_addr_end(start, end);
 
@@ -239,7 +239,7 @@ static int temp_pgtable_map_pud(p4d_t *dst_p4dp, p4d_t *src_p4dp, unsigned long
 	pud_t *dst_pudp;
 	pud_t *src_pudp;
 
-	if (p4d_none(READ_ONCE(*dst_p4dp))) {
+	if (p4d_none(p4dp_get(dst_p4dp))) {
 		dst_pudp = (pud_t *)get_safe_page(GFP_ATOMIC);
 		if (!dst_pudp)
 			return -ENOMEM;
@@ -251,7 +251,7 @@ static int temp_pgtable_map_pud(p4d_t *dst_p4dp, p4d_t *src_p4dp, unsigned long
 	src_pudp = pud_offset(src_p4dp, start);
 
 	do {
-		pud_t pud = READ_ONCE(*src_pudp);
+		pud_t pud = pudp_get(src_pudp);
 
 		next = pud_addr_end(start, end);
 
@@ -278,7 +278,7 @@ static int temp_pgtable_map_p4d(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long
 	p4d_t *dst_p4dp;
 	p4d_t *src_p4dp;
 
-	if (pgd_none(READ_ONCE(*dst_pgdp))) {
+	if (pgd_none(pgdp_get(dst_pgdp))) {
 		dst_p4dp = (p4d_t *)get_safe_page(GFP_ATOMIC);
 		if (!dst_p4dp)
 			return -ENOMEM;
@@ -290,7 +290,7 @@ static int temp_pgtable_map_p4d(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long
 	src_p4dp = p4d_offset(src_pgdp, start);
 
 	do {
-		p4d_t p4d = READ_ONCE(*src_p4dp);
+		p4d_t p4d = p4dp_get(src_p4dp);
 
 		next = p4d_addr_end(start, end);
 
@@ -317,7 +317,7 @@ static int temp_pgtable_mapping(pgd_t *pgdp, unsigned long start, unsigned long
 	unsigned long ret;
 
 	do {
-		pgd_t pgd = READ_ONCE(*src_pgdp);
+		pgd_t pgd = pgdp_get(src_pgdp);
 
 		next = pgd_addr_end(start, end);
 
-- 
2.47.2


