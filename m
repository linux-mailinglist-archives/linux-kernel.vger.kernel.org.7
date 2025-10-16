Return-Path: <linux-kernel+bounces-856106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3900BE318B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B5058842E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA5631AF33;
	Thu, 16 Oct 2025 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="UJGB7Q6V"
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45672E1757
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614406; cv=none; b=Gi+cbupkd0rm0Hoech0cngXONxT9qrWYQXBj72HcRcxIPWYZOjqOenDNpRnsWghJ5TcFQ8XdKC4BqDblk7lrL/Y3OLKsqSHAUc/qGEXt7kb21FRN8tZft90pAsvX3OUNaB+m4o3s+qHv74U5gvRP05h5oDwM4RKWpiGlHmUjEHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614406; c=relaxed/simple;
	bh=z/fXEAubgTYKrlgzfCCiyHLHJ7sIVhdopZFD4jLbxV8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+o2GSKLwkvj7I/AvmhIoMiGrVFWUG9YjZO6jxh+DxrVugseKnGPm2rIFNLKlS4gd3l/5dI5xKzW782ItFvsLoMBNPdfQeHvvooaxGNHw9/tWOl3bSzpeloh4PE95qSw45Nz3pGsEK/feOtMq7yGbsMo4uIkDv6O0Pn8H7oHh5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=UJGB7Q6V; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Kl8wFEk1Rfimj4SuE/d+n0dMIexnSNg7hsR/i17e6MY=;
	b=UJGB7Q6ViWGahyodIiBXCAq88T0wmr6s2XW5a8KOiGY2DS43aoyAWx2GYUkD71tQE/3aypdjO
	L02ClGRAWAt0XtsJxALWDX3IfEDdg/P5w6r1gvbBzhE0cv1lFlr6Df+BVX7M8qA7vtcq6lPuOlQ
	MnmG8B5ppm70Ym2pVG5vDPc=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cnQmC5MPzz1T4GB;
	Thu, 16 Oct 2025 19:32:27 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id B884C140257;
	Thu, 16 Oct 2025 19:33:13 +0800 (CST)
Received: from huawei.com (10.50.87.63) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 16 Oct
 2025 19:33:12 +0800
From: Yin Tirui <yintirui@huawei.com>
To: <akpm@linux-foundation.org>, <david@redhat.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>, <ziy@nvidia.com>,
	<baolin.wang@linux.alibaba.com>, <npache@redhat.com>, <ryan.roberts@arm.com>,
	<dev.jain@arm.com>, <baohua@kernel.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <anshuman.khandual@arm.com>,
	<yangyicong@hisilicon.com>, <ardb@kernel.org>, <willy@infradead.org>,
	<apopple@nvidia.com>, <samuel.holland@sifive.com>,
	<luxu.kernel@bytedance.com>, <abrestic@rivosinc.com>,
	<yongxuan.wang@sifive.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>
CC: <wangkefeng.wang@huawei.com>, <chenjun102@huawei.com>,
	<yintirui@huawei.com>
Subject: [PATCH RFC 1/2] pgtable: add pte_clrhuge() implementation for arm64 and riscv
Date: Thu, 16 Oct 2025 19:27:03 +0800
Message-ID: <20251016112704.179280-2-yintirui@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016112704.179280-1-yintirui@huawei.com>
References: <20251016112704.179280-1-yintirui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500001.china.huawei.com (7.202.194.229)

Add pte_clrhuge() helper function for architectures that enable
ARCH_SUPPORTS_HUGE_PFNMAP to clear huge page attributes from PTE
entries.

This function provides the inverse operation of pte_mkhuge() and will
be needed for upcoming huge page splitting, where PTE entries derived
from huge page mappings need to have their huge page attributes cleared.

Future work will refactor pfn_pte() to automatically filter huge bits,
removing the need for pte_clrhuge() across all architectures.

Signed-off-by: Yin Tirui <yintirui@huawei.com>
---
 arch/arm64/include/asm/pgtable.h | 8 ++++++++
 arch/riscv/include/asm/pgtable.h | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index abd2dee416b3..244755bad46f 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -366,6 +366,14 @@ static inline pte_t pte_mkinvalid(pte_t pte)
 	return pte;
 }
 
+static inline pte_t pte_clrhuge(pte_t pte)
+{
+	pteval_t mask = PTE_TYPE_MASK & ~PTE_VALID;
+	pteval_t val = PTE_TYPE_PAGE & ~PTE_VALID;
+
+	return __pte((pte_val(pte) & ~mask) | val);
+}
+
 static inline pmd_t pmd_mkcont(pmd_t pmd)
 {
 	return __pmd(pmd_val(pmd) | PMD_SECT_CONT);
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 815067742939..b0a20ddf780a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -455,6 +455,11 @@ static inline pte_t pte_mkhuge(pte_t pte)
 	return pte;
 }
 
+static inline pte_t pte_clrhuge(pte_t pte)
+{
+	return pte;
+}
+
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
 #define pte_leaf_size(pte)	(pte_napot(pte) ?				\
 					napot_cont_size(napot_cont_order(pte)) :\
-- 
2.43.0


