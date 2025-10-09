Return-Path: <linux-kernel+bounces-846142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD9BBC7240
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 03:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF4619E2CBF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 01:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B101922FD;
	Thu,  9 Oct 2025 01:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Q21gbFYb"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E924F1A9F8E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975130; cv=none; b=LkTBtJvW4TPjsyYWIe/vQTt9cK41GLVDQLct6AfMnhZ3puumF2jSLFZnYdui164/HoQJ4Qirgc2WDmUVFJRAhG6/nlEolSklJJcMtOS7wHGLr/OdddbiGsBiDX/nevRtbKDMSVW2zU/rwCtaMuITbO7+3ISp9vHnbf/0q4t6oM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975130; c=relaxed/simple;
	bh=IuzWaZaq52AseT76aIk2++sO7Nvet3qY616LVEnMRL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngEMd5VQM3ZffM4WSwFzPkw41qX4swmflATboO/GCr3L4EjwGuFGhPHkGr4fh/4B6+MQeLXkHsAgbhA+g9kA3mLBBBeP+0kQC5q4MO5mo8xvkb8Lp4SyrxRQI4uG1oEc44LAHOnZVOZOGARJs2e+g7kmK1luxoZBlW2fVVmsGdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Q21gbFYb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so6245115ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1759975123; x=1760579923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdiVfcIiYEtPdSKu0CqenqZ/5C3LyfHi/KY36+7mBoA=;
        b=Q21gbFYby36TOYfFh7lINpJ8iWH7CHwNdfVwWA6bEJJrseu8Ej27JBu/K2PxOAv3pc
         J7TRnUYp8wH1LyH9brorXwrljspCNWk42SPagoD4xg1KzioebSCXobZAv/K4eEyGTqCb
         jDBAjYRJOh1cTKE/wD+Yqr8/9uWl8o5V2M1PZpDPMee7bdjQeAkqykrD3z1vA8hX2KOp
         rXUNQo7wHmkXD5UUlkWXc5VrKIbObb+C9PAjqcGa+TQ1Xpc2MXwzkhVv6W4E7sEv5bS/
         ZfTV7jpYnmLP97VYv/D4RwKF+J6Qf+hRuky0uWd/ELotLqa3sSTWCRniSRFYS5AwZDmP
         TbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759975123; x=1760579923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdiVfcIiYEtPdSKu0CqenqZ/5C3LyfHi/KY36+7mBoA=;
        b=jDxKtzeNYCxmXde+htXzRwUiya9d9VrPs+xh/5qfuX338FQQ+0qx5DLcCj85MmYAqy
         QrQqU3tuhInPlkoadzgQQ0RHQGb8TutuMcgDP/Nrjk7P/4baxRgG8lKMVYdiIqewS/6o
         izwHZGL37mgtAHGz2o0w+OAw5oZOpK9lkHBkAdUmews0H8vLr+eJqy1LHgy9hRkHjPNi
         L8MArpWY0GiJWMsrRj4aJHcphde89Aoc9Nt3Ftv4v7OI/Exb0C2KVnWkFuIkTgRvJWYI
         xbrDZyoP0lJF3RKOUm7WEtS9ytQh5iPO9EXwkmAXX0vyUD0HRBKRE9XrHuMUAVxY1vGu
         a7dA==
X-Forwarded-Encrypted: i=1; AJvYcCVPrbiEWRbJPGRcxaPUvL/zBisBgU75E0BnWXwcvJksVjR1iGEZIGg7bgtNE8kG0yIrjKCtO3wU0iUO4dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCDyE+Eh1w5MwPPvzKzhnUR9rG/9eT31+/Tlq+Gnb4KFH7I/cY
	90EiNAUOqXy1M8NqwQiURbPeLOYBn3mECnG4QvK/3aiYX1aG+xHsPPYBidVDrdjNIm0=
X-Gm-Gg: ASbGnct6K9kpZyfBBKE8IDtdma+2P4C3LMfqS3iB9hqa/cOKqYGYno4g40fH0MwJhAq
	XEoHvY1qXNcIdq0p9hQsvatUhr9dUjX1GwyO51jMKksbF0PteQsgMcUHZj1Bw99mDsiZbWiTk1j
	L3i0Zxaipois2rOQcVu38N/8UryXYdUzLU4ZHtPonYAonMc6p5/dr2A5ZtDdAc87QlI22gwdzgj
	om4fhKDdS9HIBCen15Yi6E2JdVYIzMII3J8lLrsL2CpNmemgf49dMs4/Uivq8z1Bj+w+TiDBNGE
	uacR3vWp8EHLRNxN5Er9EeEXZV2s3sp3gTopcl8xP4dAP0wCfVflpSapH2U5pTCU6pJJieGCMhr
	SFfOb2WCgRYsdiLWLFTrFifza1hBztG8rpo86sYnlO+SjcxtL0r5eBYyJTNNJhJlja9jM31KCDm
	ygsU4=
X-Google-Smtp-Source: AGHT+IEAHeuoGA0XLStPTncgvhvYEundXEr0shvSlmxf+pcjXId4G/S6mKP+GMbaTviYedqoip+3mg==
X-Received: by 2002:a17:903:b4f:b0:288:e2ec:edfd with SMTP id d9443c01a7336-290272154a4mr64152045ad.10.1759975123319;
        Wed, 08 Oct 2025 18:58:43 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de53f9sm11033585ad.14.2025.10.08.18.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 18:58:43 -0700 (PDT)
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
Subject: [PATCH v2 02/18] perf/core: Replace READ_ONCE() with standard page table accessors
Date: Wed,  8 Oct 2025 18:57:38 -0700
Message-ID: <20251009015839.3460231-3-samuel.holland@sifive.com>
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

Replace READ_ONCE() with standard page table accessors, i.e. pXXp_get(),
which have a default implementation of READ_ONCE() if the architecture
does not override them.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - New patch for v2

 kernel/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 820127536e62b..952ba4e3d8815 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8110,7 +8110,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 	pte_t *ptep, pte;
 
 	pgdp = pgd_offset(mm, addr);
-	pgd = READ_ONCE(*pgdp);
+	pgd = pgdp_get(pgdp);
 	if (pgd_none(pgd))
 		return 0;
 
@@ -8118,7 +8118,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 		return pgd_leaf_size(pgd);
 
 	p4dp = p4d_offset_lockless(pgdp, pgd, addr);
-	p4d = READ_ONCE(*p4dp);
+	p4d = p4dp_get(p4dp);
 	if (!p4d_present(p4d))
 		return 0;
 
@@ -8126,7 +8126,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 		return p4d_leaf_size(p4d);
 
 	pudp = pud_offset_lockless(p4dp, p4d, addr);
-	pud = READ_ONCE(*pudp);
+	pud = pudp_get(pudp);
 	if (!pud_present(pud))
 		return 0;
 
-- 
2.47.2


