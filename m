Return-Path: <linux-kernel+bounces-829011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E45AAB9609A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D90F483972
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120BE327A13;
	Tue, 23 Sep 2025 13:37:31 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928883277A4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634650; cv=none; b=KSptOs58flboEV5EneygdxR7FhvlDsmiKRQfGwf+GMvxtCSie2rsFiZdNjiwRiVlr8b+Ixn0hBs7fbMpDjCwCM7ine2VgHprpbJB/9y2Egid3SUlnFVpPzAbXR/yGD2A/viJIGtJc0rivpHtYIGpZuE78zGyx0Oa+BkjFBI3MWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634650; c=relaxed/simple;
	bh=eqzEHZfabQiKgWz4qHSzmGcrn4JLoFV6zcVR1K3BDmM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxOD6Mu6qCoYRNgiEVawgFZbFORhYmnsOi6oCFDJYYnM8YQAHyvJA1z91xVQ85CrNEB9eG2GUFOQsp0jGP9HGiZ2ihCbD+D9Y46GEKNBzp3rTPh6gy+//WxTRmK8+mMuaIkz0TN6E3l7yX/UO9AdO2JduaoiArwXstOm29CIOSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cWLWg3pB3zddT4;
	Tue, 23 Sep 2025 21:32:47 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id E43701800B1;
	Tue, 23 Sep 2025 21:37:25 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 23 Sep
 2025 21:37:24 +0800
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
Date: Tue, 23 Sep 2025 21:31:03 +0800
Message-ID: <20250923133104.926672-2-yintirui@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923133104.926672-1-yintirui@huawei.com>
References: <20250923133104.926672-1-yintirui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500001.china.huawei.com (7.202.194.229)

Add pte_clrhuge() helper function for architectures that enable
ARCH_SUPPORTS_HUGE_PFNMAP to clear huge page attributes from PTE
entries.

This function provides the inverse operation of pte_mkhuge() and will
be needed for upcoming huge page splitting, where PTE entries derived
from huge page mappings need to have their huge page attributes cleared.

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
index 91697fbf1f90..125b241e6d2c 100644
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


