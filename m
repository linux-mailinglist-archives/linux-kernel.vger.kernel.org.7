Return-Path: <linux-kernel+bounces-804664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 460B8B47B57
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 14:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32B1189DB7B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 12:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7934D270568;
	Sun,  7 Sep 2025 12:30:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCB2212FAA
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757248222; cv=none; b=Mwpm8RxZrL6fnJGEhxvo/HOm148sEddVaabj9+cM0Bkzv35gisDYuF2jF0zF2o2J0abX+GW+Mhi+YHuMb3AbZmHgQjA7HOYVOWul9FdooNx6kQyWXjdzMzxYj6ncR3IJvGLvyp9cJAKt+ebMmc3KVH+8f68tSi4fQPWuIhqo4GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757248222; c=relaxed/simple;
	bh=6ngY9jGjNxJlhyF0z0SRDwKzgFJUjPOIImYsZeif86o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PwHAb4UT42iQZpcOR4hAjZ5R1iptRSI0PyoIoVaJWuRyZW1nbGPXIYPZdSbe/82ldeX29qCsWgSs/AAHjt14JT6ifhrEYBtQBQJzjUU4BjfnCIEbO+F7zu0j6PHUYwVCz7RbIicz3rcGJouZQHBunCio3KuGx4M22+8Hp4DVHoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC430169E;
	Sun,  7 Sep 2025 05:30:09 -0700 (PDT)
Received: from a076716.blr.arm.com (a076716.blr.arm.com [10.164.21.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 001B23F694;
	Sun,  7 Sep 2025 05:30:13 -0700 (PDT)
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
Subject: [PATCH V4 1/2] arm64/sysreg: Update TCR_EL1 register
Date: Sun,  7 Sep 2025 17:59:59 +0530
Message-Id: <20250907123000.414181-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250907123000.414181-1-anshuman.khandual@arm.com>
References: <20250907123000.414181-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update TCR_EL1 register fields as per latest ARM ARM DDI 0487 L.B and while
here drop an explicit sysreg definition SYS_TCR_EL1 from sysreg.h, which is
now redundant.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
The updated TCR_EL1 fields also matches with latest released TCR_EL1 layout.

https://developer.arm.com/documentation/ddi0601/2025-06/AArch64-Registers/TCR-EL1--Translation-Control-Register--EL1-?lang=en

 arch/arm64/include/asm/sysreg.h |  2 --
 arch/arm64/tools/sysreg         | 52 ++++++++++++++++++++++++++++-----
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6604fd6f33f4..71febc944adb 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -281,8 +281,6 @@
 #define SYS_RGSR_EL1			sys_reg(3, 0, 1, 0, 5)
 #define SYS_GCR_EL1			sys_reg(3, 0, 1, 0, 6)
 
-#define SYS_TCR_EL1			sys_reg(3, 0, 2, 0, 2)
-
 #define SYS_APIAKEYLO_EL1		sys_reg(3, 0, 2, 1, 0)
 #define SYS_APIAKEYHI_EL1		sys_reg(3, 0, 2, 1, 1)
 #define SYS_APIBKEYLO_EL1		sys_reg(3, 0, 2, 1, 2)
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 696ab1f32a67..85da09795527 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -4756,17 +4756,53 @@ Field   37      TBI0
 Field   36      AS
 Res0    35
 Field   34:32   IPS
-Field   31:30   TG1
-Field   29:28   SH1
-Field   27:26   ORGN1
-Field   25:24   IRGN1
+Enum	31:30   TG1
+	0b01	16K
+	0b10	4K
+	0b11	64K
+EndEnum
+Enum	29:28   SH1
+	0b00	NONE
+	0b10	OUTER
+	0b11	INNER
+EndEnum
+Enum	27:26  ORGN1
+	0b00	NC
+	0b01	WBWA
+	0b10	WT
+	0b11	WBnWA
+EndEnum
+Enum	25:24   IRGN1
+	0b00	NC
+	0b01	WBWA
+	0b10	WT
+	0b11	WBnWA
+EndEnum
 Field   23      EPD1
 Field   22      A1
 Field   21:16   T1SZ
-Field   15:14   TG0
-Field   13:12   SH0
-Field   11:10   ORGN0
-Field   9:8     IRGN0
+Enum	15:14   TG0
+	0b00	4K
+	0b01	64K
+	0b10	16K
+EndEnum
+Enum	13:12   SH0
+	0b00	NONE
+	0b10	OUTER
+	0b11	INNER
+EndEnum
+Enum	11:10  ORGN0
+	0b00	NC
+	0b01	WBWA
+	0b10	WT
+	0b11	WBnWA
+EndEnum
+Enum	9:8   IRGN0
+	0b00	NC
+	0b01	WBWA
+	0b10	WT
+	0b11	WBnWA
+EndEnum
 Field   7       EPD0
 Res0    6
 Field   5:0     T0SZ
-- 
2.25.1


