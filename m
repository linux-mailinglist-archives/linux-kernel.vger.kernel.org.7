Return-Path: <linux-kernel+bounces-846141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33300BC724F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 03:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF30D3E51C8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 01:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A144D1A9FBA;
	Thu,  9 Oct 2025 01:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PBnqgHKP"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038D513774D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975127; cv=none; b=VVaupfa/Lw0BPXjj8cbamwDyBFvb6pEJ3F1UGXGmBLkJOjZUKk2MJMDKfLIi0rUeRx6a9TAFFxOLLrabAJoQG1PncJjXS9J1v5KfTSJaBJYb0hl3AqBuoFlbcr2oCgeuOSl3MI/ZG4lYjNoqZCBUPLxh7Fm7A+kU8q3dWHIbkTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975127; c=relaxed/simple;
	bh=oJglb5F/DlqFnrzmYPs/4r/Iba0m9SkApy4w7J1Wklw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOaArghlLs0CtDhbyoxCL7pw7HQHA+vkJPHg4Q/mPOFA2GfU2RMJpdp7sQd0xYEh08mtG3KF4xD+m8wfz/3EB0oIobHEPg4puJ9ia79xTEMefHO9faUm6QZweYnWDTt71tGvqnaRzfTEoJJ/KxEfR4+g50JNCczDttyaynztKL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=PBnqgHKP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-271d1305ad7so7149835ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1759975122; x=1760579922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAFzin3ivjrQZj/QpZ54jF9jkkD8Fld75BEMN783hL8=;
        b=PBnqgHKPH/f+ABxinMMoGGVpjW39IFlsyAhMzrbEoy+rGzWARpwCG8Q2o5udjERFC0
         G/Nvjed0ypLzcXtcUK4kwRmmBSiQFN7iWPgTS2rIXmgP3neOr3Sg1Uz1xmsZRjyuAWs+
         WyG00GW4ERNbDQY7gLD0rpRvRnyy7jz3oKWVG4uoL0U4pFLf9OgJSm5QheU+6U+H/4iV
         sWgKv3IboK7RpZrqebO5vlfqQW2ADc4BCvGr3TuNnT1ZoGgATBYl4JPEt9fq/KjkJ1QH
         vAQzyiSlULoS/lnaXDtW1kjRXTbe/+NsY+jp3o++ZEtTa4i2K+v/woZaFvkYJo52zuIe
         axKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759975122; x=1760579922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAFzin3ivjrQZj/QpZ54jF9jkkD8Fld75BEMN783hL8=;
        b=KVYAwy0QDfqachjxAT+Q1vmuh8NJMfjFfTyAUbb4P4d+EvZR1GMKuIK063abOMmzOq
         4bV4NqkEqHzGdkgJbWD1tgDxZm+bkWZ6xa+h3r5EysCPWKMFQXp16ITKMi2Mkc8BeLcK
         HQhRxlRr7A5bbqVYU2WYXIxBDDx8RPNSpICuV5jZ5bNyYYhHIJCJZtfup8S6VWdbMRUU
         bPts0rJA1k5qk2jv3Z05H746kTkCOXLFupdNBbvDkvE8FiVM6JcPRzQ5mGqSsqfSr56a
         CHO05omWJhk0klKSukNVytsVs/71rDtIr0wwXHIAbptWBBT/hN/LXt5W93i1W4o8M9PT
         Sckw==
X-Forwarded-Encrypted: i=1; AJvYcCXRaZ2A33Ts8Ph/ojDym+g/MSzqFJdv82RmqAs59xCsZYAyU9P7VO5Wjvjx50pXQ920tG9Baj28hYpu574=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcPF23usmE+BUaR6pE/bPieUhz9S5yegwqH9t9r3u+2zE49if5
	Ri6KekwWvZuIcSh9tTaZyYXdt40sRxWo+/doe3YP8RecwjktgIEXongP6wEtw+3lrTE=
X-Gm-Gg: ASbGncsbQMGAI50vbeV39KXLR6Kjw4oYpN9jc6OnO9WgwiL/ZFCn0ICt00EL6a1nkZK
	qvUw9xJgvf8J6ZGAEEZ84rSmuseotEOYD51veTkLcGhG82Cidiknj7/nA9pDhtaP8hANhFVz1py
	P1WZ1Xxp7ljwE4z/TSsoY67PleNYhGbrih+/2JTnfAfKFOLjdmZXolHnfbamSVKo5ZCieeKCMVe
	ZizXX4IMgj2WiRLSp1EGDg2WiMthkroHOd+Pg+2OtJuuXdxaRN3tj2mPn6174p+jnmWdOGvPxfZ
	tXoSCMMinHkqfTiX8haQljxOi/gqDBaZ41smgnqSBgRorXjRBObOi2X5avtv9y9eqs8qui3Mdp+
	JX2+jefrIj1TVY8PkMLyJeqvT3KyaeUGF0TkEakROvNLpzpYhaYgDD39QXwhOmEqFJlMKh1sYdU
	CV730=
X-Google-Smtp-Source: AGHT+IG2D+B4sYEjYqHTfYtptXhLnt1g1J3431Y1pnRWZqcWdGLQKwHj4/A4KlwSUJg/qQlrRp74lA==
X-Received: by 2002:a17:902:d58d:b0:28a:2e51:9272 with SMTP id d9443c01a7336-290273ffcd2mr61826225ad.48.1759975122096;
        Wed, 08 Oct 2025 18:58:42 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de53f9sm11033585ad.14.2025.10.08.18.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 18:58:41 -0700 (PDT)
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
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 01/18] mm/ptdump: Replace READ_ONCE() with standard page table accessors
Date: Wed,  8 Oct 2025 18:57:37 -0700
Message-ID: <20251009015839.3460231-2-samuel.holland@sifive.com>
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

From: Anshuman Khandual <anshuman.khandual@arm.com>

Replace READ_ONCE() with standard page table accessors i.e pxdp_get() which
anyways default into READ_ONCE() in cases where platform does not override.
Also convert ptep_get_lockless() into ptep_get() as well.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Dev Jain <dev.jain@arm.com>
Acked-by: Lance Yang <lance.yang@linux.dev>
Acked-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20251001042502.1400726-1-anshuman.khandual@arm.com/
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - New patch for v2 (taken from LKML)

 mm/ptdump.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/ptdump.c b/mm/ptdump.c
index b600c7f864b8b..973020000096c 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -31,7 +31,7 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
 			    unsigned long next, struct mm_walk *walk)
 {
 	struct ptdump_state *st = walk->private;
-	pgd_t val = READ_ONCE(*pgd);
+	pgd_t val = pgdp_get(pgd);
 
 #if CONFIG_PGTABLE_LEVELS > 4 && \
 		(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
@@ -54,7 +54,7 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long addr,
 			    unsigned long next, struct mm_walk *walk)
 {
 	struct ptdump_state *st = walk->private;
-	p4d_t val = READ_ONCE(*p4d);
+	p4d_t val = p4dp_get(p4d);
 
 #if CONFIG_PGTABLE_LEVELS > 3 && \
 		(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
@@ -77,7 +77,7 @@ static int ptdump_pud_entry(pud_t *pud, unsigned long addr,
 			    unsigned long next, struct mm_walk *walk)
 {
 	struct ptdump_state *st = walk->private;
-	pud_t val = READ_ONCE(*pud);
+	pud_t val = pudp_get(pud);
 
 #if CONFIG_PGTABLE_LEVELS > 2 && \
 		(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
@@ -100,7 +100,7 @@ static int ptdump_pmd_entry(pmd_t *pmd, unsigned long addr,
 			    unsigned long next, struct mm_walk *walk)
 {
 	struct ptdump_state *st = walk->private;
-	pmd_t val = READ_ONCE(*pmd);
+	pmd_t val = pmdp_get(pmd);
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	if (pmd_page(val) == virt_to_page(lm_alias(kasan_early_shadow_pte)))
@@ -121,7 +121,7 @@ static int ptdump_pte_entry(pte_t *pte, unsigned long addr,
 			    unsigned long next, struct mm_walk *walk)
 {
 	struct ptdump_state *st = walk->private;
-	pte_t val = ptep_get_lockless(pte);
+	pte_t val = ptep_get(pte);
 
 	if (st->effective_prot_pte)
 		st->effective_prot_pte(st, val);
-- 
2.47.2


