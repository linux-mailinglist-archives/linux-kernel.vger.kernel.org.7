Return-Path: <linux-kernel+bounces-882285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F11C2A0FA
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 06:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD75A3B1E68
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 05:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA41241CA2;
	Mon,  3 Nov 2025 05:26:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CF6AD5A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 05:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762147589; cv=none; b=NfXKpG2QW8+6vXuYbHw2yW0O4/gQAzTYqTdyV7w8lxZFmCueXWWZtK7RyoF1KAeAmnnvFUsCnX+iVYOeG1o3fayLSwCQMDzJmA8O+f4bjoIWlkeqytfilgFEKt9H8KN032xsrtb1T12BU+eXxFeHAbXMZ4bi6i7mOA7bRWb+K/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762147589; c=relaxed/simple;
	bh=gFPo64RoDkj+0GGxzf0Sm6Dm4IFppInwjAd0zpRuf0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zz3sa1mTHVAI90iuNT/NhkaP6sF7ZDM/WuSMTkzfJwVpIj/zF/T4wGaAe7HoNGngJW2bXfMhUqezdYfzGfus+84QiLerFu6b8ULbQUGl7fmhIgsSSvR02yZF1WqCrl+8H3mRMKdACLeKFPzPW7qDiRbtcohcPBAIKTdy8qRKzFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4613028FA;
	Sun,  2 Nov 2025 21:26:18 -0800 (PST)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BA0523F63F;
	Sun,  2 Nov 2025 21:26:24 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] arm64/mm: TTBRx_EL1 related changes
Date: Mon,  3 Nov 2025 05:26:12 +0000
Message-Id: <20251103052618.586763-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains some TTBRx_EL1 related changes, aimed at standardizing
TTBRx_EL1 register field accesses via tools sysreg format and also explains
52 PA specific handling methods via a new macro along with in code comments

This series applies on v6.18-rc4

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (6):
  arm64/mm: Directly use TTBRx_EL1_ASID_MASK
  arm64/mm: Directly use TTBRx_EL1_CnP
  arm64/mm: Represent TTBR_BADDR_MASK_52 with TTBRx_EL1_BADDR_MASK
  arm64/mm: Ensure correct 48 bit PA gets into TTBRx_EL1
  arm64/mm: Describe 52 PA folding into TTBRx_EL1
  arm64/mm: Describe TTBR1_BADDR_4852_OFFSET

 arch/arm64/include/asm/asm-uaccess.h   |  2 +-
 arch/arm64/include/asm/assembler.h     |  3 ++-
 arch/arm64/include/asm/mmu_context.h   |  2 +-
 arch/arm64/include/asm/pgtable-hwdef.h | 23 ++++++++++++++++++++---
 arch/arm64/include/asm/pgtable.h       |  5 +++--
 arch/arm64/include/asm/uaccess.h       |  6 +++---
 arch/arm64/kernel/entry.S              |  2 +-
 arch/arm64/kernel/mte.c                |  4 ++--
 arch/arm64/mm/context.c                |  8 ++++----
 arch/arm64/mm/mmu.c                    |  2 +-
 10 files changed, 38 insertions(+), 19 deletions(-)

-- 
2.30.2


