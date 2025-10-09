Return-Path: <linux-kernel+bounces-846144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E217FBC7247
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 03:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B62734CE60
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 01:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119E11DED4C;
	Thu,  9 Oct 2025 01:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="l+05RqgV"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A9A1C84AE
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975133; cv=none; b=XV9PFkEgGved/iPCGTUFAL4GCiKNU7LkFZVQpFvAEScACdJAepVKxqc4XzmNGDGfvrWe2ic/nb3SNjDio8DvPnlUQ6CKmrWM8tXO+upuNC3iwRirGGRaqZWb6cyVGsyosIG2ebBG4z57xsBCHhJk9ChnTXjqLkzjazoNmbwaUOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975133; c=relaxed/simple;
	bh=JToLDcRZxGaoKV6Cshpomz9lhG2Xncz3Z1ANpC9FVg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4q6TEo7wmwsiyteMcmGp//5KaseBpJ6OL0LzBq9WlJ4fccK+1fstazmBGI6aUv4CfoZgXInkMvWC0Xv8kFrBAxLEDGSDU5FR+eKu8IiWtQc33GHxVLtU+lZYm31DO5M06ICjnMSKVlQI43HKgMo87lHQqe9mw0FgX1ycdlFcgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=l+05RqgV; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b60971c17acso336524a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1759975128; x=1760579928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Q8oT6hoS6cxQomKzX1vfx1V3ZAPioXY327lRhg5E1A=;
        b=l+05RqgVIwIXv+OUSag/0TRBfDG2yYKZ3XHL1eg4seC/XgfS4J+gsJ0OcI8VJwjTsi
         uqa+reGh9TWXfq0Hq1UF/5bXpzuIrHV6d7n1SHw2ozkfR6W4MUW99e2O0AAYColoTjYy
         /T5rW6bm9EHyBg76iCw3lr/ngf2c7nk0qgTXqlDmQlmgHeAxyx8EEk6jEsOiRyN6aimI
         dk4VVjg++bymaroZiXPrcYkJNjutdCbKyrMGyAQGiKLgekIV55OQQg7PyRczalXcYSaV
         DeHK9q2eftatI+LM5PEVZxnx+b4kPom2hT2kgl6pSzCWhebHUuOO8eNZRwwFS5sm3SwF
         mc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759975128; x=1760579928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Q8oT6hoS6cxQomKzX1vfx1V3ZAPioXY327lRhg5E1A=;
        b=vRc63oAo9hrA1iro6Qq1S3/lkM5sqqxNHyQU46wFzuhiTOVgGSfpW4ioY7KG26iUD1
         0LjmXIQp0Fow7w9mk/h8ITPVkzIgqi3h6/edLfUjSdIOoKLiiG1sOZUGBBAsv5ecPHnZ
         k3dJlRV+Th9aeW/7GeUewHZP2g3iZWJiiYaH8cmVtPR/Z8xCLo0MyK4tG07NG0uqVOK9
         MSYUseYy2OJor257lxJU7+XGGrDifyNACf4tKl6q+zUwH3P+soIq4LqevO1bGf9k1ASh
         +uz5p5q2AiEvnudyJN/+6EQJ6rB/rNCzVL0ui7m2J5iSSwaRdGZ+u2MKVu8APS3zhRyX
         KB5A==
X-Forwarded-Encrypted: i=1; AJvYcCU3XXA5kxDo3S25QTrJ+Ty5A22SaNbWUONYRqTgXZ3xLhCttaR1A0/G8yOXRzuPV4qxVG4cAljmDmLWC6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSSJzn/QKtYR3a0BeFRNbS1Ugd8DwOp+ZRSHAoOwmT/D7GYmk6
	aUb/OLWUOWb4Age3OLJQI1pQ6PlOnZeD2DA9g8fWkG9Mwnhht92fAUE7aqb4AB30ChI=
X-Gm-Gg: ASbGncvSS0bSSCL/ejYAf/Y8MeIb8jTBTfHu7qpXfCeWUGWB9xTOyWB4j8Y282JFEDu
	8GcYjb5rIZnlWn8mNM/l2VZcM5dknQh61T955vkG6a9GpLhMNijjRWScCQAvwbAahf7BcTe6qR1
	Zoaqw0A9S7H0eeDQXveLzHMjax3HZ9U48zwVi1rqUxVsiNp1h3KsKkKm3N/PIM2j/1plr3qeTxh
	g0tSkRcF6DocyO5aeEoo9+aZV0C2y5YeXzdZzzRflO66dq2viSIeTfTX/cui43A8lMl6Fl+dh3N
	02fVROrak6vbvwwfRSr+GqBgIhec9A8aAZMPT2Ch1MOV4YQtlkARVHaYC/NL272m7GETXecZRDd
	gvPXO6x3cb21sCUbqS1ubaOqsQXQNd4VWmB9soiOY6S3/+ZpBixmiNbhg+oJpNgwgk5qbclg2yU
	LCiYE=
X-Google-Smtp-Source: AGHT+IHLtMfpsASWG7S0cjFNRLXUMrAvJHuz2m4ALPRQp+i8q8lJn/YDkN/bQbSK1wXLrkajg3vnmg==
X-Received: by 2002:a17:903:11cf:b0:269:63ea:6d4e with SMTP id d9443c01a7336-290272c1aa5mr61891525ad.37.1759975128385;
        Wed, 08 Oct 2025 18:58:48 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de53f9sm11033585ad.14.2025.10.08.18.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 18:58:48 -0700 (PDT)
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
Subject: [PATCH v2 06/18] riscv: hibernate: Replace open-coded pXXp_get()
Date: Wed,  8 Oct 2025 18:57:42 -0700
Message-ID: <20251009015839.3460231-7-samuel.holland@sifive.com>
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

Use the semantically appropriate accessor function instead of open
coding the implementation. This will become important once these
functions start transforming the PTE value on some platforms.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - New patch for v2

 arch/riscv/kernel/hibernate.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hibernate.c
index 671b686c01587..2a9bc9d9e776e 100644
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


