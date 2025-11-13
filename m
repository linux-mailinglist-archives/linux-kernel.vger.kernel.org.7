Return-Path: <linux-kernel+bounces-898454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6155CC55517
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08503B3564
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752C3298CD5;
	Thu, 13 Nov 2025 01:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="m2cOb9ge"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4AF3D544
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998422; cv=none; b=jJziWrTUwxPq9GEXnPnfLJSVmiovcp9IdtZquYaE3fnWqxUf/AVB+f/4kTUvnNLTxuzrjrsvlwnuI/DgznzoSjwcxDOaUdnuU8YuaPRNNV9rLCUBLRFFsK418hKRJfkQz+pKUu8ti8Z9Bsn5tvz/We9N2+Bkg1QXPWjTHJ0uhYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998422; c=relaxed/simple;
	bh=1EDzMrT2p5RjNDiZ7EGuCfhBKoian8SUlheWdpdCA0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAlUEKZr+mgCwL3jS0AP6YPx9slBWSQfroerH4wq0Au0mXzJR+eF3EiOgj+icpUJacsvM972k8s6OPK8X+XiXQoFXiRjJuqnsPhlAsLPQanam49EPlpUrONZiO54o4zreIqWSjonr1ly7ZOoGOrS7Ei4hbjv+++aWfk+pxf676Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=m2cOb9ge; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-298144fb9bcso2807785ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1762998420; x=1763603220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdtMIGVZlv4MisNDb9tnVG+/irsKPLGgILycxKzmm5k=;
        b=m2cOb9gewcYeRe0uSWNX8VnNbQwSoYr2Vu+NjMWOCbHdhApXR8kNsQ93P9BR6I0OtP
         +HSZnsXUGClf/ze19w1y0BT7pdeFhS855REK1RJOZX9EPtPS7RiOZuMu11YFM6TTbXUW
         5Xb020+nO5doMsVt51Kp0vPw0PoIQ+3KNDmghP+9/EJNHEvtgkd40ljJ0Sx1RfFZUe+b
         c2EmRDPshXKSCNLN2OKmHwOTvcTXYd5GaJ+Sa2itSk5dDcjJJP97o6tYInOzLwsg6MqF
         mG49GN3hIouo6UtnuVWjO/HupFnx+rPandxe+0MKR7V6iLpxv30BWmeTWVRd0LLj7jkN
         54VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762998420; x=1763603220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YdtMIGVZlv4MisNDb9tnVG+/irsKPLGgILycxKzmm5k=;
        b=SQ0K9z3s11PrpXK8KAcQ5/nvXwWBbFpPoWOY3c+IC6lHtyT/SNF9kLhLzsP3Ke5/3h
         B9XuBVs8y50kABXm/Yn7/be6gqVCjvI2eE3B2XXd+u+6P7Y25R+xdFSXaD5l/aqK6Lhp
         30qgURdETSQkGYPtNw8ots39KG/cYTG5dFb6Pfs8+8zHrGvdOSn1OSI26ypQgRAUvUzo
         mddBMwNdx0nu71Lb4W6tDfw9JMpTVaC9jav3Y+48hA7DgAV082OHdllKsK1X6p/SiVH0
         Ba/Yd9ES0WvPF/Tf/E+EKZrdiggcZczxJL1LXVL7KzgkQp1wycxtznP5zv47TH0uhc3U
         IZOg==
X-Forwarded-Encrypted: i=1; AJvYcCUjSvDfUUul1UaTCnZ1S9CxG6dqe9oMshutN30rCMQ0VlfFsA13FcxTfLfRUamugiNL3M4ORfXCytH6hb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW+crrZ0lgNTExTxmppOyEdenaSAKOgNnh2nEBupeWEAfjrLtW
	Otoh6IgyTx2CzE8WFCNwR3MLj/ptcO+1UeMLmAR2MH+7FbJm76MR929VYJFjpN/1aSM=
X-Gm-Gg: ASbGncuy+vxojEY5L9AcAU/p+xPh+86r7vE9FQbeBf4vpAa8jzmMKkdPTQwi9SGqczP
	m1XSL4CEz769NpWVnlzno0ylZrJQvTh0GnMEzrXb2zF2wnSPvB1+NXll46q71Et5aD/ZWjfmU5B
	5+kyPgljsr+HDPhta7EDvDbm5uYCqyYi6mP/6wPPwCVFGqtspYO5I21trE8c+c4SX/9AQqv0aC0
	cHV2qg2dK9ZpeYhQDI2a9WUlVFR4EoAhEr3bpxn64BNv3idnaTvVMlRLBV7TID3CiY/tt8Q+8xL
	3Ca7cD68jmkEt1xzHTnCIYFSLKBswyXay6vCJ/+yK8OdS/VsEDKOUFTdXqPxuq+uaNGmAK2Zz4m
	rUJbAuH7eyG8ej1sKSYPG7YhZ3gS82mqFpIu06RgdOalyz1TRiPRh/JDmHSG/0Y2BcsxytaTYSW
	T+GwhbYl3Ad7OlJQh7eSGz8w==
X-Google-Smtp-Source: AGHT+IFYjWF2Je2zdGG5G71XUhLWD4KFs37feNtxzRSLtVmw8LZxUlSD+Pjrpw1Q7n3dWJ2wHP2y9w==
X-Received: by 2002:a17:903:3c64:b0:295:3e80:9aa4 with SMTP id d9443c01a7336-2984ed46fcamr62445305ad.22.1762998420290;
        Wed, 12 Nov 2025 17:47:00 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccae8sm4986485ad.98.2025.11.12.17.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 17:47:00 -0800 (PST)
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
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 01/22] mm/ptdump: replace READ_ONCE() with standard page table accessors
Date: Wed, 12 Nov 2025 17:45:14 -0800
Message-ID: <20251113014656.2605447-2-samuel.holland@sifive.com>
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

From: Anshuman Khandual <anshuman.khandual@arm.com>

Replace READ_ONCE() with standard page table accessors i.e pxdp_get()
which anyways default into READ_ONCE() in cases where platform does not
override.  Also convert ptep_get_lockless() into ptep_get() as well.

Link: https://lkml.kernel.org/r/20251001042502.1400726-1-anshuman.khandual@arm.com
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Acked-by: Lance Yang <lance.yang@linux.dev>
Acked-by: SeongJae Park <sj@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v3:
 - Replace patch with cherry-pick from linux-next

Changes in v2:
 - New patch for v2 (taken from LKML)

 mm/ptdump.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/ptdump.c b/mm/ptdump.c
index b600c7f864b8..973020000096 100644
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


