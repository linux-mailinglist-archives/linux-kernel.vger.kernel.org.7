Return-Path: <linux-kernel+bounces-783675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4655B3310D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 17:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7551889602
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 15:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1962D949B;
	Sun, 24 Aug 2025 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfN+BdqE"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9486915B971
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756047575; cv=none; b=u/ukXvMSG4q5VILItPcfQ/87UzQhKXLuINMWNJnbJD0kWvniZvQQMNvfN4YhIYBNSMwzrb+2HOYpW8ANSjzJPQ8W4Xh9HlGo7REq6Nse6w77CIZxlBVQKKupk55EpJkUB7d9sc1fjPegaTSr+Vgvlvk+yu5iicGPQtkzsWgeIpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756047575; c=relaxed/simple;
	bh=tCrEZFQIDYPlYFnnFk50Mlhqs/Xchi0kp6QtgT2cu/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a46CDIHOEJ0/NmRtlZBRGOnO06R2rtFXHu69T6p3mn1no0oXI5eMNYC/pTqMC4dtkPTJS4WiUyA+S0lV4vgKLhdHv2m5jjsHcNlp/1dwh320krPrTyeQLwyeUHEfNMbH2VkCnaCL+6bSEL6/y64oXfwqAL2UG9nsvpZnYdLvPN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfN+BdqE; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70d9a65c356so19945816d6.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 07:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756047572; x=1756652372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rnSjySc6sr/GcMl6WZdws9iNHYbtGeaN6kDGRl7xn5k=;
        b=jfN+BdqEqzcm1+BW3PTaDcYIYOKtX/uc4Dr8MuukP/KJVOwNlnUdMqy6qIWvg1uHVi
         6Af//Xh8/FEqr6yLpjH2d5zA6W/z2pNP5KHSbJwGSvLx/hV5MndblsGI/puVeFdMwFDQ
         j10aGPrGKr4jTTEz38lowT3txuJ+MP/+vClkdaQjc2/iP3LbYbEmeMnbPz90ZmpchPGx
         QSkpU/ksjxTGJC2zKZLvo6SHRFWGT2VOTBJ6MQU/7nvaNLliy8QeKaZV6xPFBrkxuwWI
         1DH4piGQfm3JObRyqDxtajB9cM6UU61tLjvLBllaIREe6jXIEGNipo3KrNWYuDR+Hc2M
         eicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756047572; x=1756652372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnSjySc6sr/GcMl6WZdws9iNHYbtGeaN6kDGRl7xn5k=;
        b=V8HftmxKTdtu0R0s30VWP2kkeIGAygWLKGpLXAAUCzUifMDYPhfHg3uZg7x9ldIwlY
         RUTXhU58KpuOZUNpZNLT+FN9U/BuFtngT33nw2pBOYJBUZskjFufqSF8piHJt5nCR3nN
         1PwS0+VJUHFCO7u6TIx9kT54fHWmMRqfG+CwkVdO2VFV6u32eUuH0FJSbuIQ78WgS+Yk
         OUe8xjLJHJ5gNXwqbI/raStsJC/iUfJv7dqKXEv9KeZ+c1w+PvJFY52UnMLlHqkPViig
         yzLQeDnjCC9Y9WthD5UM5roE4OrD2WWefjatRAe8RtamzALY0Z2I60fEMs7L0Afzt/dT
         nd2A==
X-Forwarded-Encrypted: i=1; AJvYcCW4IQPrqc4pqRh4KZ7G/1Oh+F1Uxznonu5w2ULHg0/uoQK41NgL03CT2uiHVhGFuJiONKIkWcJjE9/rYd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwn0//ASM3JtyFDMcS1Kk/TaylLpzRMIr6LqFXt1h+CLJyibpI
	LCvxkvP91Kq7hgeq2RyRg08QQ4CgewAYml6alAJ0qpcynjtcv2Q1wtJK
X-Gm-Gg: ASbGncuE9l2oqj+82Berqhrcz8DmHpsssVcMbc/k6lo3w66Wauk3oH6f2V8ab9VRNJy
	nTwc9oiujyivHBVW6ZB467xZ+tzSdRG99QskfTYM0bhObbkp/QaCr3hV5zYc77G4cVJ4uYnKPA8
	N/9Ecl5z6uSTlcxg75fYhzz7AthOGXGRY1gelN+pVnJLWzi5zrba2CDD45RckJZ/Vmm/jHyZu/t
	19L+JaJ84/gCUKofb2hUgEY14Bj9AA8neeIVWnheN5vkaTlz+d7hUoJJA2C1iDWo9513T/n9Ib1
	3y3IUyQ9R9W+1MJS2mGHQnbmbPm2kzdcNtS8z4h0fCYFbcAFaVVpGVUFudYpggndIWX/k8Hsjqs
	wCAnHns23BUQdlHyhGP25rilBRhNHWvrafaTomy+0/l5+XAuk31hDy5Mt/Q==
X-Google-Smtp-Source: AGHT+IHWS0giv/9NAXCJiSUax4+HqnfYikUftbaRG3vmR36f0UjrIE81WEpy8zXfpOKsVdxIivhzAA==
X-Received: by 2002:a05:6214:a54:b0:707:56dc:178d with SMTP id 6a1803df08f44-70d971e9166mr73587496d6.37.1756047572303;
        Sun, 24 Aug 2025 07:59:32 -0700 (PDT)
Received: from cr-x-redhat96-nsd-2.fyre.ibm.com ([129.41.87.0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da7145ec7sm29210466d6.15.2025.08.24.07.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 07:59:31 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: ogabbay@kernel.org,
	yaron.avizrat@intel.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH] accel: habanalabs: Use string choices helpers
Date: Sun, 24 Aug 2025 07:59:13 -0700
Message-ID: <20250824145913.2386190-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use string_choices.h helpers instead of hard-coded strings.

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
 drivers/accel/habanalabs/common/firmware_if.c      | 14 +++++++-------
 drivers/accel/habanalabs/gaudi/gaudi_coresight.c   |  9 +++++----
 drivers/accel/habanalabs/gaudi2/gaudi2_coresight.c |  9 +++++----
 drivers/accel/habanalabs/goya/goya.c               |  3 ++-
 drivers/accel/habanalabs/goya/goya_coresight.c     |  9 +++++----
 5 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/accel/habanalabs/common/firmware_if.c b/drivers/accel/habanalabs/common/firmware_if.c
index eeb6b2a80fc7..cef53a3fd839 100644
--- a/drivers/accel/habanalabs/common/firmware_if.c
+++ b/drivers/accel/habanalabs/common/firmware_if.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/ctype.h>
 #include <linux/vmalloc.h>
+#include <linux/string_choices.h>
 
 #include <trace/events/habanalabs.h>
 
@@ -1705,13 +1706,13 @@ static void hl_fw_preboot_update_state(struct hl_device *hdev)
 							cpu_boot_dev_sts1);
 
 	dev_dbg(hdev->dev, "Firmware preboot hard-reset is %s\n",
-			prop->hard_reset_done_by_fw ? "enabled" : "disabled");
+			str_enabled_disabled(prop->hard_reset_done_by_fw));
 
 	dev_dbg(hdev->dev, "firmware-level security is %s\n",
-			prop->fw_security_enabled ? "enabled" : "disabled");
+			str_enabled_disabled(prop->fw_security_enabled));
 
 	dev_dbg(hdev->dev, "GIC controller is %s\n",
-			prop->gic_interrupts_enable ? "enabled" : "disabled");
+			str_enabled_disabled(prop->gic_interrupts_enable));
 }
 
 static int hl_fw_static_read_preboot_status(struct hl_device *hdev)
@@ -2455,7 +2456,7 @@ static void hl_fw_boot_fit_update_state(struct hl_device *hdev,
 	}
 
 	dev_dbg(hdev->dev, "Firmware boot CPU hard-reset is %s\n",
-			prop->hard_reset_done_by_fw ? "enabled" : "disabled");
+			str_enabled_disabled(prop->hard_reset_done_by_fw));
 }
 
 static void hl_fw_dynamic_update_linux_interrupt_if(struct hl_device *hdev)
@@ -2647,8 +2648,7 @@ static void hl_fw_linux_update_state(struct hl_device *hdev,
 			prop->fw_app_cpu_boot_dev_sts0);
 
 		dev_dbg(hdev->dev, "GIC controller is %s\n",
-				prop->gic_interrupts_enable ?
-						"enabled" : "disabled");
+				str_enabled_disabled(prop->gic_interrupts_enable));
 	}
 
 	if (prop->fw_cpu_boot_dev_sts1_valid) {
@@ -2660,7 +2660,7 @@ static void hl_fw_linux_update_state(struct hl_device *hdev,
 	}
 
 	dev_dbg(hdev->dev, "Firmware application CPU hard-reset is %s\n",
-			prop->hard_reset_done_by_fw ? "enabled" : "disabled");
+			str_enabled_disabled(prop->hard_reset_done_by_fw));
 
 	dev_info(hdev->dev, "Successfully loaded firmware to device\n");
 }
diff --git a/drivers/accel/habanalabs/gaudi/gaudi_coresight.c b/drivers/accel/habanalabs/gaudi/gaudi_coresight.c
index 1168fefa33f4..3900a7727f4c 100644
--- a/drivers/accel/habanalabs/gaudi/gaudi_coresight.c
+++ b/drivers/accel/habanalabs/gaudi/gaudi_coresight.c
@@ -12,6 +12,7 @@
 #include "../include/gaudi/gaudi_reg_map.h"
 
 #include <uapi/drm/habanalabs_accel.h>
+#include <linux/string_choices.h>
 
 #define SPMU_SECTION_SIZE		MME0_ACC_SPMU_MAX_OFFSET
 #define SPMU_EVENT_TYPES_OFFSET		0x400
@@ -497,7 +498,7 @@ static int gaudi_config_etf(struct hl_device *hdev,
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to %s ETF on timeout, error %d\n",
-				params->enable ? "enable" : "disable", rc);
+				str_enable_disable(params->enable), rc);
 		return rc;
 	}
 
@@ -505,7 +506,7 @@ static int gaudi_config_etf(struct hl_device *hdev,
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to %s ETF on timeout, error %d\n",
-				params->enable ? "enable" : "disable", rc);
+				str_enable_disable(params->enable), rc);
 		return rc;
 	}
 
@@ -601,14 +602,14 @@ static int gaudi_config_etr(struct hl_device *hdev,
 	rc = gaudi_coresight_timeout(hdev, mmPSOC_ETR_FFCR, 6, false);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to %s ETR on timeout, error %d\n",
-				params->enable ? "enable" : "disable", rc);
+				str_enable_disable(params->enable), rc);
 		return rc;
 	}
 
 	rc = gaudi_coresight_timeout(hdev, mmPSOC_ETR_STS, 2, true);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to %s ETR on timeout, error %d\n",
-				params->enable ? "enable" : "disable", rc);
+				str_enable_disable(params->enable), rc);
 		return rc;
 	}
 
diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2_coresight.c b/drivers/accel/habanalabs/gaudi2/gaudi2_coresight.c
index 2423620ff358..f35a024ad532 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2_coresight.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2_coresight.c
@@ -6,6 +6,7 @@
  */
 #include "gaudi2_coresight_regs.h"
 #include <uapi/drm/habanalabs_accel.h>
+#include <linux/string_choices.h>
 
 #define GAUDI2_PLDM_CORESIGHT_TIMEOUT_USEC	(CORESIGHT_TIMEOUT_USEC * 2000)
 #define SPMU_MAX_COUNTERS			6
@@ -2106,14 +2107,14 @@ static int gaudi2_config_etf(struct hl_device *hdev, struct hl_debug_params *par
 	rc = gaudi2_coresight_timeout(hdev, base_reg + mmETF_FFCR_OFFSET, 6, false);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to %s ETF on timeout, error %d\n",
-			params->enable ? "enable" : "disable", rc);
+			str_enable_disable(params->enable), rc);
 		return rc;
 	}
 
 	rc = gaudi2_coresight_timeout(hdev, base_reg + mmETF_STS_OFFSET, 2, true);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to %s ETF on timeout, error %d\n",
-			params->enable ? "enable" : "disable", rc);
+			str_enable_disable(params->enable), rc);
 		return rc;
 	}
 
@@ -2215,14 +2216,14 @@ static int gaudi2_config_etr(struct hl_device *hdev, struct hl_ctx *ctx,
 	rc = gaudi2_coresight_timeout(hdev, mmPSOC_ETR_FFCR, 6, false);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to %s ETR on timeout, error %d\n",
-				params->enable ? "enable" : "disable", rc);
+				str_enable_disable(params->enable), rc);
 		return rc;
 	}
 
 	rc = gaudi2_coresight_timeout(hdev, mmPSOC_ETR_STS, 2, true);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to %s ETR on timeout, error %d\n",
-				params->enable ? "enable" : "disable", rc);
+				str_enable_disable(params->enable), rc);
 		return rc;
 	}
 
diff --git a/drivers/accel/habanalabs/goya/goya.c b/drivers/accel/habanalabs/goya/goya.c
index 84768e306269..cca904a21392 100644
--- a/drivers/accel/habanalabs/goya/goya.c
+++ b/drivers/accel/habanalabs/goya/goya.c
@@ -15,6 +15,7 @@
 #include <linux/hwmon.h>
 #include <linux/iommu.h>
 #include <linux/seq_file.h>
+#include <linux/string_choices.h>
 
 /*
  * GOYA security scheme:
@@ -820,7 +821,7 @@ int goya_set_frequency(struct hl_device *hdev, enum hl_pll_frequency freq)
 		return 0;
 
 	dev_dbg(hdev->dev, "Changing device frequency to %s\n",
-		freq == PLL_HIGH ? "high" : "low");
+		str_high_low(freq == PLL_HIGH));
 
 	goya_set_pll_profile(hdev, freq);
 
diff --git a/drivers/accel/habanalabs/goya/goya_coresight.c b/drivers/accel/habanalabs/goya/goya_coresight.c
index 3827ea4c02f7..f65c9a802444 100644
--- a/drivers/accel/habanalabs/goya/goya_coresight.c
+++ b/drivers/accel/habanalabs/goya/goya_coresight.c
@@ -11,6 +11,7 @@
 #include "../include/goya/asic_reg/goya_masks.h"
 
 #include <uapi/drm/habanalabs_accel.h>
+#include <linux/string_choices.h>
 
 #define GOYA_PLDM_CORESIGHT_TIMEOUT_USEC	(CORESIGHT_TIMEOUT_USEC * 100)
 
@@ -330,7 +331,7 @@ static int goya_config_etf(struct hl_device *hdev,
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to %s ETF on timeout, error %d\n",
-				params->enable ? "enable" : "disable", rc);
+				str_enable_disable(params->enable), rc);
 		return rc;
 	}
 
@@ -338,7 +339,7 @@ static int goya_config_etf(struct hl_device *hdev,
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to %s ETF on timeout, error %d\n",
-				params->enable ? "enable" : "disable", rc);
+				str_enable_disable(params->enable), rc);
 		return rc;
 	}
 
@@ -405,14 +406,14 @@ static int goya_config_etr(struct hl_device *hdev,
 	rc = goya_coresight_timeout(hdev, mmPSOC_ETR_FFCR, 6, false);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to %s ETR on timeout, error %d\n",
-				params->enable ? "enable" : "disable", rc);
+				str_enable_disable(params->enable), rc);
 		return rc;
 	}
 
 	rc = goya_coresight_timeout(hdev, mmPSOC_ETR_STS, 2, true);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to %s ETR on timeout, error %d\n",
-				params->enable ? "enable" : "disable", rc);
+				str_enable_disable(params->enable), rc);
 		return rc;
 	}
 
-- 
2.47.3


