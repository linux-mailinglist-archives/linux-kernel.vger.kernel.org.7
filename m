Return-Path: <linux-kernel+bounces-691802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E98ADE8F7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 12:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE7F3BBE6A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 10:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE832DE200;
	Wed, 18 Jun 2025 10:23:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA002253941;
	Wed, 18 Jun 2025 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750242190; cv=none; b=oFVB4L5surYQtOdJ++dp2u9nJFPFxg+2YowCmblRH5b2fuXgzV8oCiZeGAsKDQi3Jf5URqDNirV3+4g1m37vQzJRDP5gJWBE/tbONMZwwf5qc2ab+DEj4N7sjM7RYTKP6ctRcGXkJqJXP/xNWm+KIluZ2g9nhCF2U0N9CKDzvVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750242190; c=relaxed/simple;
	bh=XFETnRwJszuY33IPOx4LdCSnsksBJu52kllSSQvTpnE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G99zXebeySisrHaAdzQAKzhkXIhJvdmP7pt1iLdC8umGgyxpdmfiY1fCb+g0rNIezhj7nuTMq5BJCQ3EkJeBcLwezQ42HLORY6AG7f8p/unmieI9GkQa/FbiwZDHwUYETmysKigIrK9zTtq4lue40RxXkdkeilps0VI/JC8vFtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 418281BC0;
	Wed, 18 Jun 2025 03:22:47 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 78ADB3F66E;
	Wed, 18 Jun 2025 03:23:06 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: jarkko@kernel.org,
	sudeep.holla@arm.com,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	stuart.yoder@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v4 1/2] firmware: arm_ffa: Change initcall level of ffa_init() to rootfs_initcall
Date: Wed, 18 Jun 2025 11:23:01 +0100
Message-Id: <20250618102302.2379029-2-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250618102302.2379029-1-yeoreum.yun@arm.com>
References: <20250618102302.2379029-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Linux IMA (Integrity Measurement Architecture) subsystem used for secure
boot, file integrity, or remote attestation cannot be a loadable module
for few reasons listed below:

 o Boot-Time Integrity: IMA’s main role is to measure and appraise files
   before they are used. This includes measuring critical system files during
   early boot (e.g., init, init scripts, login binaries). If IMA were a module,
   it would be loaded too late to cover those.

 o TPM Dependency: IMA integrates tightly with the TPM to record measurements
   into PCRs. The TPM must be initialized early (ideally before init_ima()),
   which aligns with IMA being built-in.

 o Security Model: IMA is part of a Trusted Computing Base (TCB). Making it a
   module would weaken the security model, as a potentially compromised system
   could delay or tamper with its initialization.

IMA must be built-in to ensure it starts measuring from the earliest possible
point in boot which inturn implies TPM must be initialised and ready to use
before IMA.

To enable integration of tpm_event_log with the IMA subsystem, the TPM drivers
(tpm_crb and tpm_crb_ffa) also needs to be built-in. However with FF-A driver
also being initialised at device initcall level, it can lead to an
initialization order issue where:
 - crb_acpi_driver_init() may run before tpm_crb_ffa_driver()_init and ffa_init()
 - As a result, probing the TPM device via CRB over FFA is deferred
 - ima_init() (called as a late initcall) runs before deferred probe completes,
   IMA fails to find the TPM and logs the below error:

   |  ima: No TPM chip found, activating TPM-bypass!

Eventually it fails to generate boot_aggregate with PCR values.

Because of the above stated dependency, the ffa driver needs to initialised
before tpm_crb_ffa module to ensure IMA finds the TPM successfully when
present.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index fe55613a8ea9..1a690b8186df 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -2058,7 +2058,7 @@ static int __init ffa_init(void)
 	kfree(drv_info);
 	return ret;
 }
-module_init(ffa_init);
+rootfs_initcall(ffa_init);
 
 static void __exit ffa_exit(void)
 {
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


