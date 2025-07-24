Return-Path: <linux-kernel+bounces-744562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422F1B10E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F2456029F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015372EAD0E;
	Thu, 24 Jul 2025 15:23:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E702EAB96
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370580; cv=none; b=tPVcXYpIZm98hGhKRvjmV43/XoPTCnCO+Qc3xeoSPUM4AuJNvBCgIRj+UW9e/bB3XaKvztN4m92MxEjvJSGuz9HAKQdZC1HTv8695leuTumTuxj5QNfCa7mGyq5QZDoY6XrZ8kY7OvcBQFThSreaGKmTBV5LNijZMzy2ve0RFpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370580; c=relaxed/simple;
	bh=SOd+bsf7hMVcCUmeLT4KAslQFLvGQkjMTC+j12Rh6Pw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dGZMHKQXtysBn7nvxEkWNreucRwPkEVJHh4N5GQiQo9kUNxMcClKU7+R0nT//Xtc1YCiz25GBJfxSh1I6pIUQ0Z4A7p+Vn/VD1RlhH7Oaz+Ajgnp1Pl7Jfp2In7fQQJRuBDsCYfAaBijx+sRSEqOpMrpomLMSfYCbf06oh3GC24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B3931A00;
	Thu, 24 Jul 2025 08:22:52 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 596D73F6A8;
	Thu, 24 Jul 2025 08:22:57 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 24 Jul 2025 16:22:36 +0100
Subject: [PATCH v5 06/10] coresight: Avoid enable programming clock
 duplicately
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-arm_cs_fix_clock_v4-v5-6-63f648dae021@arm.com>
References: <20250724-arm_cs_fix_clock_v4-v5-0-63f648dae021@arm.com>
In-Reply-To: <20250724-arm_cs_fix_clock_v4-v5-0-63f648dae021@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753370566; l=1821;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=SOd+bsf7hMVcCUmeLT4KAslQFLvGQkjMTC+j12Rh6Pw=;
 b=bWDvomzKm9CDbXtyShqYvi01iaqLv5wFh0N7rASfVBQEJn6PmFjrgw2WObYLhrr/P527xl1qD
 k1r6Z3kOQyaDnb/Xeolz8RnSBdb/b/9UrLNNzv1sSKCYBetyMOjrbNh
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
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 include/linux/coresight.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index c6eb35cc25397656b52eb142f3f2eb5bf5dd4b69..4eada894c08293f36056483a8b5a038b26c387df 100644
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
 
-	pclk = devm_clk_get_enabled(dev, "apb_pclk");
-	if (IS_ERR(pclk))
-		pclk = devm_clk_get_enabled(dev, "apb");
+	if (!dev_is_amba(dev)) {
+		pclk = devm_clk_get_enabled(dev, "apb_pclk");
+		if (IS_ERR(pclk))
+			pclk = devm_clk_get_enabled(dev, "apb");
+	}
 
 	return pclk;
 }

-- 
2.34.1


