Return-Path: <linux-kernel+bounces-752089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5881B17120
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26F01C224F8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7412C158D;
	Thu, 31 Jul 2025 12:24:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32822D1301
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964645; cv=none; b=Su4dLxKkOg5dXQPp1mIzH2qkfTNb+Ke6akAQuvc22p0+TNLk7JAGiJIRVdxvWQlUo0Rh7UAaleA0z+QYpyhvq2BlXjZKe5ADEOuwoNJCWQdkXOtkQLq1JkC0tG1C9ImEBtb909wLJ3CnIzlERSXrCEtb4+Mm2vn7lIdv7dwBdGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964645; c=relaxed/simple;
	bh=38H7dCopCsqbVOeBAjaWZpO84P++J5KiCuiuzTpRiGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sOJLWXlkpA/WfHAlQRKsy6rU97XI3xpzhM4Zw29yzgIayeDjrjRV3npFl+AIYqHivLJJLxH036h4o2sQH4baljh3ZdjjlMuylMQj6M58Gtf3RpBhOJii0CujeG2iJNj5lHfDVPSLZDHvUu2U+q8ij8crKj6z/SpOprYKtWkb3EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3B7B2BC3;
	Thu, 31 Jul 2025 05:23:55 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F80A3F673;
	Thu, 31 Jul 2025 05:24:02 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 31 Jul 2025 13:23:42 +0100
Subject: [PATCH v6 06/10] coresight: Avoid enable programming clock
 duplicately
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-arm_cs_fix_clock_v4-v6-6-1dfe10bb3f6f@arm.com>
References: <20250731-arm_cs_fix_clock_v4-v6-0-1dfe10bb3f6f@arm.com>
In-Reply-To: <20250731-arm_cs_fix_clock_v4-v6-0-1dfe10bb3f6f@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Mark Brown <broonie@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753964630; l=1892;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=38H7dCopCsqbVOeBAjaWZpO84P++J5KiCuiuzTpRiGw=;
 b=bMKPPEEZO1nT1ovOhcXzLBiq11G1K/Uwm0SL3OHms6TIHAB9LL89HzjKq/87zz9d3KashoTlR
 obKtz820yq1B76yPLtrftKqimn52RikaTcjvmjCm+1ZHot6KQL3j0AO
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The programming clock is enabled by AMBA bus driver before a dynamic
probe. As a result, a CoreSight driver may redundantly enable the same
clock.

To avoid this, add a check for device type and skip enabling the
programming clock for AMBA devices. The returned NULL pointer will be
tolerated by the drivers.

Fixes: 73d779a03a76 ("coresight: etm4x: Change etm4_platform_driver driver for MMIO devices")
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 include/linux/coresight.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 1e652e157841955864a4bce00b2285efcad327aa..bb49080ec8f96bb23cab2efa23eb026646a3c4f4 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -481,20 +481,23 @@ static inline bool is_coresight_device(void __iomem *base)
  * Returns:
  *
  * clk   - Clock is found and enabled
- * NULL  - Clock is controlled by firmware (ACPI device only)
+ * NULL  - Clock is controlled by firmware (ACPI device only) or when managed
+ *	   by the AMBA bus driver instead
  * ERROR - Clock is found but failed to enable
  */
 static inline struct clk *coresight_get_enable_apb_pclk(struct device *dev)
 {
-	struct clk *pclk;
+	struct clk *pclk = NULL;
 
 	/* Firmware controls clocks for an ACPI device. */
 	if (has_acpi_companion(dev))
 		return NULL;
 
-	pclk = devm_clk_get_optional_enabled(dev, "apb_pclk");
-	if (!pclk)
-		pclk = devm_clk_get_optional_enabled(dev, "apb");
+	if (!dev_is_amba(dev)) {
+		pclk = devm_clk_get_optional_enabled(dev, "apb_pclk");
+		if (!pclk)
+			pclk = devm_clk_get_optional_enabled(dev, "apb");
+	}
 
 	return pclk;
 }

-- 
2.34.1


