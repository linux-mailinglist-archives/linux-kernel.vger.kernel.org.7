Return-Path: <linux-kernel+bounces-846143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFEEBC7252
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 03:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34F4B4F0C69
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 01:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29331DE3DC;
	Thu,  9 Oct 2025 01:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="axp07W5U"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA95119922D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975131; cv=none; b=HsnUqX8nFvq9/i0tYQHh6/tqk2eWBJXJY8aQtVcAueEc/t2Sdv0NVPzJKnp79rUY17goph0lRGDLkjPjHQK6f4mrGxBqeDWQAQgVJsbSUDgEE2W6UGxMk4t+9Kw5d6tCBulktYDmGWBOcc9YMoOhMqJtyrWDUCE3yrb6XCrURMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975131; c=relaxed/simple;
	bh=dnp0XWypO1Jm0LkDyhIDPv0l8JLiriuPVPkLklG6MQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrZeu1EkWkgc73+SP8e2S7efuHchBn68cX3UGUdDtmh/DOVlsRWiduT2JkWPHaSsUYUc70tXkfBeb5k74ST/dmIo/ZxAUQQqM+S9AxnVbz77UgtmPCOlvPh9eF+53A3jILiUZcJ/0pYHA82vL185K1X374aaQuhSzzhujUeGDJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=axp07W5U; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2680cf68265so3279655ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1759975124; x=1760579924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuPyEQssKNBDDveegAkkBylsREkSVusKsPA4YXKPGPk=;
        b=axp07W5Ukzs4+Fnkb87WtayJUzpFF1dtxIU8fBV1VpmfiTJHznbxWu10LDBEc+JniS
         PwTZ2cjNsSaunGs/+Fx2FIC5PliEjIN04Be1VZF58J1INejBPAXXZhMUC+X0zUy1CEXm
         sDDcRvBant3MsDcpNk+wydfVCew8b77oFEXV/+tXOaRSTpz42hDC+6seDp1/VcdEHmQo
         a2Jozg/cbtmXpzV1oehv9FtkjGGeOAjVxoUABjDPS+WjuiI0yGanwwTRqPM7C0Sr30PU
         g0BKEUsKZkn1OeyNxLZBQQ4FESZabMRx6MFZLelWJjnB3HPXmoniIyE2BDicTdEtB1hj
         gXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759975124; x=1760579924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuPyEQssKNBDDveegAkkBylsREkSVusKsPA4YXKPGPk=;
        b=jHgGwLW8ImqeaDvvrxCoUzll85c7kk8nq567E8Tg2NzctvJPT1pXj+EBMKzB+fykuJ
         0yTS4NrvPuqWWwWY5y7usVFwksDkag//Y2XcJXyi+BgLteEN2lJoHJfSkvAnp+CLbLjq
         qxtBw0y7lfGD2aOJVLmsEQoxrWtQ/KK9GlVbQl60ewULSgcyYYSOVuDlu3/oB69SN5h+
         f3QgLj8sV/xeGI6QxCGXYYZP2oP67o4JvD5INTPiZ9b+xdWMc1UHQ4nfrVRbS/RTjuOW
         cfooUd1MF0SoI25toVhTEFqWvuVpfjdruZhl0Fl5IFh1AjhVSF4sKanOJhv8nMAjx6LL
         taSg==
X-Forwarded-Encrypted: i=1; AJvYcCUbY+iwvY5kcc9wc37S74KjFyQ3Cg1+az3Jx1OtGZHFXU9tlpAO0u5yUfIdakyN0dnRSgqNCNuS50DEz3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy88M2Fi1SqG7ykfslkJM3Hf9CZSvig0Qav1DI+6wxazoZlpLZP
	SjheLqzVPFxA47dht2fzpO11uq1P1oSeNxy2mxWknXnhMkzpLMAOMxAm3h+kfWbkJdY=
X-Gm-Gg: ASbGnctNfY5VCFnTlYeCOZrcl9X9h4dF4POXq3ezwwx1521NVQ5WkOZHVuLQ+sy5k1y
	f+smGnnpLwBpctApTCgePtk0D49W3hgAnNSFi3ixzLXfVYJ0w8PMt+f+6cDSkpUC60SD8MSBBxl
	6UwaMF7VYqnsb4VGnj77kZtlo30nkQPi0LjF7vNntxFvtmIAPa603PBJEzs3WmqPHgWyazQvH0e
	E8y0wkMqu0x3T9GAJYpWMeVZWLLWjj5Scz5vaUgBDXRqG+O4BEhsMybE/PbiJ7CzbpNcGny42C1
	t37drbjUOABCro3g8nZ3tuIxAzHp96HvmL56MJtdnrpfQVohX+0Cn4UAjs46reJEYh7AqC4M+z6
	GQ4U3g+gi6tlflA+25OZsyrWXH984//gwQc8pGJRB3KbxCwPrvcvB1iaYIbhz7wou6vzg
X-Google-Smtp-Source: AGHT+IGRcheU2fSpI6wPrIrcXh76/ZT2qeR3VE5CvtyhdddJOl/Ib5LW5D+YkzJh3O0sYVd9k5LTng==
X-Received: by 2002:a17:903:4b2f:b0:24c:cc32:788b with SMTP id d9443c01a7336-29027216103mr72693895ad.3.1759975124530;
        Wed, 08 Oct 2025 18:58:44 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de53f9sm11033585ad.14.2025.10.08.18.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 18:58:44 -0700 (PDT)
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
Subject: [PATCH v2 03/18] mm: Move the fallback definitions of pXXp_get()
Date: Wed,  8 Oct 2025 18:57:39 -0700
Message-ID: <20251009015839.3460231-4-samuel.holland@sifive.com>
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

Some platforms need to fix up the values when reading or writing page
tables. Because of this, the accessors must always be used; it is not
valid to simply dereference a pXX_t pointer.

Move these definitions up by a few lines, so they will be in scope
everywhere that currently dereferences a pXX_t pointer.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - New patch for v2

 include/linux/pgtable.h | 70 ++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 25a7257052ff9..50286763b652f 100644
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


