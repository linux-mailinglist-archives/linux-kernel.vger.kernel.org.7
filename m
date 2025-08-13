Return-Path: <linux-kernel+bounces-766968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A76CB24D22
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 096877B6A92
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309C1219E93;
	Wed, 13 Aug 2025 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y+zwFUq7"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E706F214A64
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098347; cv=none; b=QmNzVQUWgft7WNDSzwmh296TzkmDTjX9hVU2TLikOxFemwScI/j66Scfr1Md6Lb/HznvrEzd3kd8dwYQ4wqRFTRPOu8JR2dQY8xbjZlTA4bKPGY4pLA7Lmp6cs9wup7g/xYCIIlUK1StRyJRbCdgwRE4A/TzpikmafQSS7k5TQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098347; c=relaxed/simple;
	bh=ULR9D+i4gyr6OiyuO7/TljcVryBN5tAPzYQrkCBZFCc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aOYx6aNkaVeAJ1O1n+Y7OXgyl1kOYgW2I+CKGR+yhjL7WQVOwz70rBScPP9vM2mEPjRTxwvt9vBKLUSh4CBPpyD5UQfweJRdoWdrfTZUvssYNfzDFlObvgWiGVUN4uTrvwoJym3DAJBJx3n5Ys2cUdUNPYHygUKN9AMEbMAeL+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=y+zwFUq7; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DFIusq1675660;
	Wed, 13 Aug 2025 10:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755098336;
	bh=vQzK+UfTqB2GkcvmGhYUquHMHQUf67xT2hc+6Ve6v3I=;
	h=From:To:CC:Subject:Date;
	b=y+zwFUq7j4GYVGgvnePZPG8EWSmLpKlz4/3rtHPunWgLnHbNbFUaxfzWl4IftAC5/
	 uo7kH1y6RstuxsCCMM+0HHIKBSNFW+3pufB76wK5XhKj8VNqu/lBUya77ttVpQfIAY
	 C/OAgpu+L2vxC76mf4m5ekzCu/gxCbMeCv2dHHWY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DFIuUk1060991
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 10:18:56 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 10:18:56 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 10:18:56 -0500
Received: from lelvem-mr06.itg.ti.com ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DFItYn2190095;
	Wed, 13 Aug 2025 10:18:56 -0500
From: Andrew Davis <afd@ti.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt
	<palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH] riscv: sbi: Switch to new sys-off handler API
Date: Wed, 13 Aug 2025 10:18:55 -0500
Message-ID: <20250813151855.105237-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Kernel now supports chained power-off handlers. Use
register_platform_power_off() that registers a platform level power-off
handler. Legacy pm_power_off() will be removed once all drivers and archs
are converted to the new sys-off API.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/riscv/kernel/sbi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 53836a9235e32..5e8cde0552643 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -148,7 +148,7 @@ static int __sbi_rfence_v01(int fid, const struct cpumask *cpu_mask,
 
 static void sbi_set_power_off(void)
 {
-	pm_power_off = sbi_shutdown;
+	register_platform_power_off(sbi_shutdown);
 }
 #else
 static void __sbi_set_timer_v01(uint64_t stime_value)
@@ -682,7 +682,7 @@ void __init sbi_init(void)
 		if (sbi_spec_version >= sbi_mk_version(0, 3) &&
 		    sbi_probe_extension(SBI_EXT_SRST)) {
 			pr_info("SBI SRST extension detected\n");
-			pm_power_off = sbi_srst_power_off;
+			register_platform_power_off(sbi_srst_power_off);
 			sbi_srst_reboot_nb.notifier_call = sbi_srst_reboot;
 			sbi_srst_reboot_nb.priority = 192;
 			register_restart_handler(&sbi_srst_reboot_nb);
-- 
2.39.2


