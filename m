Return-Path: <linux-kernel+bounces-797106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359CBB40BE4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401BB487B57
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF28340DBD;
	Tue,  2 Sep 2025 17:21:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2462FC03C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833660; cv=none; b=U74S6VXFgfxKtErCYMgq6mjNtzP75UGQBzKRctCejTkwVLeKWFMxmHcuEl8MdLAthYU1Mhg73XxmTdGTyWPmjQBqAQG6pFxou1mBh8gd4ZH4uYl2xeccfP7/yiHhSxd/zjV7wmKm6KxClKDCUeYbL3u1h12hw09za+ZDpiNCoD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833660; c=relaxed/simple;
	bh=nyVNSDKGds0U6EyNYp4/CfE4iaqo0jw2jvkX51ycseo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qBwDUCFoNGgx/TeEUK8ipS7+ukW8nRFek8qo+mZzTSImcDudkVfQuRLfnXZ+DeVnekYGwj7hlgt479lEGtrNiCNyTBi/0rFbUb9qjoSyIGapLpZEwoZxGHMpZoQvnCbxP2+OkDxfEaN8vP2sO9wR/iXwv4IpqxPs1ics2vaAjvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE81A2720;
	Tue,  2 Sep 2025 10:20:49 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.33.8.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32B4B3F694;
	Tue,  2 Sep 2025 10:20:57 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>
Cc: Paul Benoit <paul@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: smccc: Fix Arm SMCCC SOC_ID name call
Date: Tue,  2 Sep 2025 18:20:53 +0100
Message-Id: <20250902172053.304911-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5f9c23abc477 ("firmware: smccc: Support optional Arm SMCCC SOC_ID
name") introduced the SOC_ID name string call, which reports a human
readable string describing the SoC, as returned by firmware.
The SMCCC spec v1.6 describes this feature as AArch64 only, since we rely
on 8 characters to be transmitted per register. Consequently the SMCCC
call must use the AArch64 calling convention, which requires bit 30 of
the FID to be set. The spec is a bit confusing here, since it mentions
that in the parameter description ("2: SoC name (optionally implemented for
SMC64 calls, ..."), but still prints the FID explicitly as 0x80000002.
But as this FID is using the SMC32 calling convention (correct for the
other two calls), it will not match what mainline TF-A is expecting, so
any call would return NOT_SUPPORTED.

Add a 64-bit version of the ARCH_SOC_ID FID macro, and use that for the
SoC name version of the call.

Fixes: 5f9c23abc477 ("firmware: smccc: Support optional Arm SMCCC SOC_ID name")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Hi,

as somewhat expected, this now fails on an Ampere machine, which
reported a string in /sys/devices/soc0/machine before, but is now missing
this file.
Any idea what's the best way to handle this? Let the code try the 32-bit
FID, when the 64-bit one fails? Or handle this as some kind of erratum?

Cheers,
Andre

 drivers/firmware/smccc/soc_id.c | 2 +-
 include/linux/arm-smccc.h       | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/smccc/soc_id.c b/drivers/firmware/smccc/soc_id.c
index c24b3fca1cfe3..8f556df34fc42 100644
--- a/drivers/firmware/smccc/soc_id.c
+++ b/drivers/firmware/smccc/soc_id.c
@@ -60,7 +60,7 @@ static char __init *smccc_soc_name_init(void)
 	 * to the ARM_SMCCC_ARCH_SOC_ID function.  Fetch it if
 	 * available.
 	 */
-	args.a0 = ARM_SMCCC_ARCH_SOC_ID;
+	args.a0 = ARM_SMCCC_ARCH_SOC_ID64;
 	args.a1 = 2;    /* SOC_ID name */
 	arm_smccc_1_2_invoke(&args, &res);
 
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 50b47eba7d015..976c5f8001ff2 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -90,6 +90,11 @@
 			   ARM_SMCCC_SMC_32,				\
 			   0, 2)
 
+#define ARM_SMCCC_ARCH_SOC_ID64						\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_64,				\
+			   0, 2)
+
 #define ARM_SMCCC_ARCH_WORKAROUND_1					\
 	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
 			   ARM_SMCCC_SMC_32,				\
-- 
2.25.1


