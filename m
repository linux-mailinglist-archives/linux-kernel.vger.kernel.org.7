Return-Path: <linux-kernel+bounces-898458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A87D4C55571
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D963034F24C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E212D94AA;
	Thu, 13 Nov 2025 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nXV6M/5G"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542882D4B6D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998429; cv=none; b=AFDWvl+cdFwYHETAfHRiREaoFgsRo87LNiyY1rvea5uUkYt9iZCqW2ZPXoP/Kdi7G6Rb1D2uRovh7J/BxGrchbzMiav2Akl4uHdV5mqSrhrSby+SdFYawOjTobR0HKgTCXJWwNnAOAiMmcC17K+N7fLOpfTSLB9dkmHT71kCqGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998429; c=relaxed/simple;
	bh=41A8tN6rl++qotcHaVWp474wXnOzdy2HP/mfIQAnWzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njAg2xa5NmuEgwZUL6dynpwF1xpXqU1rqQm85IbhhYR2fEpf1XykkB2LocRopCicEeKaRQ1gNmzE5TQXUd2idfMS7TNEbJOMRKKzY/tQW8ETuolca18DG7ElbhrnNy8oDhiTYgEGuHmUs+nG++58UzwBhGomfRKoKWGh+0iQeX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=nXV6M/5G; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29558061c68so3642325ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1762998427; x=1763603227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLUmTi++1HGkiLtqpPoIfkvNz5bT2yFaPhtAlSBbrkg=;
        b=nXV6M/5GiiTv/+TiOqJ0WSQwyw7vtitOEypvu5o/9/oOA+Lnedhdg7diU93xJZ5KtV
         9+zxCrmBdfMq6FioKn4gT5Ql3RkU9EUwXicLCADW6s/FIxqTu8k9gmV4LAA3F8Hf8TTf
         pJNNsTeH59vjvyJEfKWQLSL9uMYXfLYMHXUDaMiUUuLL3DoHSwKwwjqfX9lQjToS9uXV
         uE/lR5I3cvreYXG8sNDbsLZyZFa56miBYnN5fV6C5lJLZgOTwdnvNLmjzzRi5k7u9TvM
         lZBYsmCCTpvyG911gKuL9cbGBKHg0689k2k5aMWPNEfZinqAmJnmaG+P3WdchB2qv9B7
         LJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762998427; x=1763603227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VLUmTi++1HGkiLtqpPoIfkvNz5bT2yFaPhtAlSBbrkg=;
        b=Qmd5RUtaXooSJIc6/EDboOfzbHUk5U8UhuZMYOqjOu105ZC38ltDRXSRZOXxe0kMlw
         8lXm4IepuNzs+IaWy0zbWMFAMvjJ+KgO3Eyw/oNG15KAShiC/s837Z1ZnMpZWG6J6tjf
         AG5pGg4PRhog0Xttd6CoEz4PbtOMwi0+sQX5Qj6OsXDmhYXcp6e89RlqISwV8+k6Fm/v
         nF9yyDcsrYqRMMSb/nLi1LEnjqME+yKv7L0MG13s3MyhonjfcVAhJJnt6v3TeU21IcGf
         PZi69YKrEqTbewNnMr6iqTLI3yKCk1y4OLl1YtHIIoeTca/J+TD+0vgrnCoEuyvoQflQ
         P0kg==
X-Forwarded-Encrypted: i=1; AJvYcCWdipdEDjLGw2rodXbzvwhtGl/iMvfciCJd/5xJjve0dbhGSCS1Dg4RoiPS4o9GzBdFB5gtM43ayT2L9yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz27i8fga6glu9Z+Eo6RCT4vxcYpMqE50y+UBYvoyv/pBaXoI88
	AiVFnMNc1AUfX7vM/On/t9KMvhWazYCz1I9BKHvDRY4/DqL7+2ucmeb9WHsZvpwna1k=
X-Gm-Gg: ASbGnctx7IVc0M4Te6B5ayP+DS+EUe6uy+GWsRh/TcVzgie9MCRVhOUxNSRafdVbO4J
	CGCgwUoB7zDmuNBFqkzasPkB159YCWAUugv+5qhv+RBt/yOknWzGpPYnuwVZEXk7JlS62cIjEKm
	7AcDmDsGVoGyphCOIZaMcgdvlW8LLa0thw35KqqpYrIFo8VU/W95JjBX8LFJ6/SBgQaFKtxYlwK
	I4FCIyUIHkcC+HTLvQoIincgb59uR7JblMLpZfArXAYvyfzlj4VFIniqUex/edahb87krmprNOB
	K3Z+RrY0m5K3kCqpVS4u8CruKC2dV2PjubQsOVUeHcdWsoC8YUCVn3BkMbHB/2FX4WyDbonr7wV
	onbEUJuSX+MM4hBieztFcfVbFq+SGLYhTaXygpfAy4cfHZ+lJT6JOThe5l05FOfq7InZeK6UR9u
	Qpmxge6OPNiB1qVLzM91xJbQ==
X-Google-Smtp-Source: AGHT+IGHyS+mDyrQaZDGXxDAQVdZw9gnQRb0FUGE5S/L7D9yFzt8E/UzPtcwSd6KHOBX5fl5Cq42AQ==
X-Received: by 2002:a17:902:e5c3:b0:298:3545:81e2 with SMTP id d9443c01a7336-2984ed359e1mr63898395ad.22.1762998426605;
        Wed, 12 Nov 2025 17:47:06 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccae8sm4986485ad.98.2025.11.12.17.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 17:47:06 -0800 (PST)
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
Subject: [PATCH v3 05/22] mm: Move the fallback definitions of pXXp_get()
Date: Wed, 12 Nov 2025 17:45:18 -0800
Message-ID: <20251113014656.2605447-6-samuel.holland@sifive.com>
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

Some platforms need to fix up the values when reading or writing page
tables. Because of this, the accessors must always be used; it is not
valid to simply dereference a pXX_t pointer.

Move these definitions up by a few lines, so they will be in scope
everywhere that currently dereferences a pXX_t pointer.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

Changes in v2:
 - New patch for v2

 include/linux/pgtable.h | 70 ++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 32e8457ad535..ca8c99cdc1cc 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -90,6 +90,41 @@ static inline unsigned long pud_index(unsigned long address)
 #define pgd_index(a)  (((a) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
 #endif
 
+#ifndef ptep_get
+static inline pte_t ptep_get(pte_t *ptep)
+{
+	return READ_ONCE(*ptep);
+}
+#endif
+
+#ifndef pmdp_get
+static inline pmd_t pmdp_get(pmd_t *pmdp)
+{
+	return READ_ONCE(*pmdp);
+}
+#endif
+
+#ifndef pudp_get
+static inline pud_t pudp_get(pud_t *pudp)
+{
+	return READ_ONCE(*pudp);
+}
+#endif
+
+#ifndef p4dp_get
+static inline p4d_t p4dp_get(p4d_t *p4dp)
+{
+	return READ_ONCE(*p4dp);
+}
+#endif
+
+#ifndef pgdp_get
+static inline pgd_t pgdp_get(pgd_t *pgdp)
+{
+	return READ_ONCE(*pgdp);
+}
+#endif
+
 #ifndef kernel_pte_init
 static inline void kernel_pte_init(void *addr)
 {
@@ -334,41 +369,6 @@ static inline int pudp_set_access_flags(struct vm_area_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
 
-#ifndef ptep_get
-static inline pte_t ptep_get(pte_t *ptep)
-{
-	return READ_ONCE(*ptep);
-}
-#endif
-
-#ifndef pmdp_get
-static inline pmd_t pmdp_get(pmd_t *pmdp)
-{
-	return READ_ONCE(*pmdp);
-}
-#endif
-
-#ifndef pudp_get
-static inline pud_t pudp_get(pud_t *pudp)
-{
-	return READ_ONCE(*pudp);
-}
-#endif
-
-#ifndef p4dp_get
-static inline p4d_t p4dp_get(p4d_t *p4dp)
-{
-	return READ_ONCE(*p4dp);
-}
-#endif
-
-#ifndef pgdp_get
-static inline pgd_t pgdp_get(pgd_t *pgdp)
-{
-	return READ_ONCE(*pgdp);
-}
-#endif
-
 #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 					    unsigned long address,
-- 
2.47.2


