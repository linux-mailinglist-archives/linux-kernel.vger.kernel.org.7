Return-Path: <linux-kernel+bounces-791169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C5FB3B2D7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88051BA3D25
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9CC221F15;
	Fri, 29 Aug 2025 06:02:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3802D7404E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 06:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756447349; cv=none; b=bOpYRr3mdW7BXlTkLF8vHjrA9O8PdBO9Azu3YMSFMxR9Hna7Z6DAKkrm5MUp5kue3U3/wUUNExztNhASBdljw/GKHIxq+vuQS2tV28T1b1IIKGSiiWGWlwm4Ju3RrTOtdRIB4EOM7R9UQnLMdepicmmp3Z1XsMH9wGSlH6Hihbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756447349; c=relaxed/simple;
	bh=fkxELPNjdvOxdImKn5EW2lD4Dj7mmwIUhBj3BasDsIU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CeusfmUVGcyoABQPQJnGlXzrVaNcZHeuLz+z4Q9v3n1K7oof96YgOWV27flfd9SZ9Ni3mVJ+buJvG0AvJnnWqad99GZNJ4jdKcigkoKNO8QL30LYmW3OPrJ0GGo55LXHGqrQSNOHOovpjnQ9km7Jv2RvD/fKR4xPZ4S/v5dZoO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2880B1758;
	Thu, 28 Aug 2025 23:02:18 -0700 (PDT)
Received: from a076716.blr.arm.com (a076716.blr.arm.com [10.164.21.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5494B3F63F;
	Thu, 28 Aug 2025 23:02:23 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Mark Brown <broonie@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/2] arm64/sysreg: Clean up TCR_EL1 field macros
Date: Fri, 29 Aug 2025 11:32:13 +0530
Message-Id: <20250829060215.1086792-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently TCR_EL1 field macros are sprinkled across the arm64 platform code
including KVM implementation. Clean these up via updating required register
filed definitions in tools sysreg format and then subsequently doing all
necessary replacements. TCR_XXX macros are moved from (asm/pgtable-hwdef.h)
into KVM header (asm/kvm_arm.h) for their continued usage in KVM.

The cleanup does not cause any functional change.

This applies on v6.17-rc3

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Mark Brown <broonie@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: kvmarm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Changes in V2:

- Fixed ARM ARM version from 7.B to L.B
- Changed UnsignedEnum into Enum per Mark
- Dropped all TCR_EL1 replacements from KVM code
- Moved existing TCR_XXX macros from (asm/pgtable-hwdef.h) into KVM header
  (asm/kvm_arm.h) for their continued usage
- Dropped patches 3 and 4 which could be done subsequently

Changes in V1:

https://lore.kernel.org/linux-arm-kernel/20250818045759.672408-1-anshuman.khandual@arm.com/

Anshuman Khandual (2):
  arm64/sysreg: Update TCR_EL1 register
  arm64/sysreg: Replace TCR_EL1 field macros

 arch/arm64/include/asm/assembler.h     |   6 +-
 arch/arm64/include/asm/cputype.h       |   2 +-
 arch/arm64/include/asm/kvm_arm.h       |  92 +++++++++++++++++++++++
 arch/arm64/include/asm/mmu_context.h   |   4 +-
 arch/arm64/include/asm/pgtable-hwdef.h | 100 +------------------------
 arch/arm64/include/asm/pgtable-prot.h  |   2 +-
 arch/arm64/include/asm/sysreg.h        |   2 -
 arch/arm64/kernel/cpufeature.c         |   4 +-
 arch/arm64/kernel/pi/map_kernel.c      |   8 +-
 arch/arm64/kernel/vmcore_info.c        |   2 +-
 arch/arm64/mm/proc.S                   |  36 +++++----
 arch/arm64/tools/sysreg                |  52 +++++++++++--
 tools/arch/arm64/include/asm/cputype.h |   2 +-
 13 files changed, 178 insertions(+), 134 deletions(-)

-- 
2.25.1


