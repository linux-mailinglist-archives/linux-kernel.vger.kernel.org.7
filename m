Return-Path: <linux-kernel+bounces-772869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D32EB298AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCC42025B2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9FD26A1AD;
	Mon, 18 Aug 2025 04:58:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A748268C42
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755493098; cv=none; b=PqNmAUyX8ITci/bkeBmKs9LOmUFga++xLqqZ0C+zEDbBECY82XZTBhKGn7G5GryIGKs68+QVcFdYg+2vvsMplD6UOooHYQJoc8Hwuexzhfh6ENKn0hHQxUJy78RaJqUFRwHkCFSzdkfJNlGrRx69acIgZhL7scavIA/pwn1MemI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755493098; c=relaxed/simple;
	bh=+ZAomHC0EeizW3/iczkaqcDPujZyt42UesNjmJgW+as=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fgmyQvckvsdZF3/uzyLxxI6FPah2drpfn37k1GWUYdtn1sEeWIDDaglJewuyDHz2j3aik3PV35DE2i1oFN7oFut8juLW6D9OJ8fPdW8c+4zAornXzJmt7BroTB1r5z1CpwVEEMyrSuDChz17oQ5LsKDC4Rim/EEzwkse5bPzo24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96C631762;
	Sun, 17 Aug 2025 21:58:01 -0700 (PDT)
Received: from a076716.blr.arm.com (a076716.blr.arm.com [10.164.21.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E67E13F58B;
	Sun, 17 Aug 2025 21:58:06 -0700 (PDT)
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
Subject: [PATCH 0/4] arm64/sysreg: Clean up TCR_XXX field macros
Date: Mon, 18 Aug 2025 10:27:55 +0530
Message-Id: <20250818045759.672408-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently [V]TCR[1|2]_EL[1|2] sysreg field macros are sprinkled across the
arm64 platform code including KVM implementation. Clean these up via adding
required register filed definitions in tools sysreg format and subsequently
doing all necessary replacements. The cleanup does not cause any functional
change.

This applies on v6.17-rc2

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Mark Brown <broonie@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: kvmarm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Anshuman Khandual (4):
  arm64/sysreg: Update TCR_EL1 register
  arm64/sysreg: Replace TCR_EL1 field macros
  arm64/sysreg: Add TCR_EL2 register
  arm64/sysreg: Add VTCR_EL2 register

 arch/arm64/include/asm/assembler.h         |   6 +-
 arch/arm64/include/asm/cputype.h           |   2 +-
 arch/arm64/include/asm/kvm_arm.h           |  45 +-----
 arch/arm64/include/asm/kvm_nested.h        |   6 +-
 arch/arm64/include/asm/mmu_context.h       |   4 +-
 arch/arm64/include/asm/pgtable-hwdef.h     | 107 ++------------
 arch/arm64/include/asm/pgtable-prot.h      |   2 +-
 arch/arm64/include/asm/sysreg.h            |   4 -
 arch/arm64/kernel/cpufeature.c             |   4 +-
 arch/arm64/kernel/pi/map_kernel.c          |   8 +-
 arch/arm64/kernel/vmcore_info.c            |   2 +-
 arch/arm64/kvm/arm.c                       |   6 +-
 arch/arm64/kvm/at.c                        |  48 +++----
 arch/arm64/kvm/hyp/include/hyp/switch.h    |   2 +-
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h |   2 +-
 arch/arm64/kvm/hyp/nvhe/switch.c           |   2 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c              |   2 +-
 arch/arm64/kvm/hyp/pgtable.c               |   6 +-
 arch/arm64/kvm/hyp/vhe/tlb.c               |   2 +-
 arch/arm64/kvm/nested.c                    |  10 +-
 arch/arm64/kvm/pauth.c                     |  12 +-
 arch/arm64/mm/proc.S                       |  29 ++--
 arch/arm64/tools/sysreg                    | 153 +++++++++++++++++++--
 tools/arch/arm64/include/asm/cputype.h     |   2 +-
 24 files changed, 241 insertions(+), 225 deletions(-)

-- 
2.25.1


