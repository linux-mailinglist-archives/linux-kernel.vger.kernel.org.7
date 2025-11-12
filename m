Return-Path: <linux-kernel+bounces-897447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B342BC52FF1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A73804FDB66
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF7A33F372;
	Wed, 12 Nov 2025 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJqh7Tzi"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719042C0273
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958530; cv=none; b=MHbVyKVM+Q8hbXLleVEvR2eMmUCx4RDsCguTWy9DRdPYmQ0vaKzBnkHSw1McNypEBDuogJpoKvbEc9bBl6QhsO/4T6LeBPCXAQGb0/VXbjT4PeV0dEd9ZJVm0y9InqL3SW559Is/uT+0C3jIfJOJ5MAV/KkntO/bNkh2LdZe2DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958530; c=relaxed/simple;
	bh=82XTjjSHShPDBuv5ewTva+T1nGonEhZqWcuzr/UnA34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=paaNO+iIexo9i9yF6T1LqRjDmuOefr/yTE+hbaCH4Eh80pdR56DIPJqG0BvLP3TkNsvl47n3kyuAtO2gwsjy9wcEpp7GJEAeJzZ1cQ49eOKhMOAotySa5QJqrocQNmz0C16/zm14NzzcXZIUNTJOFp2vn5K6nPshm76zfDs6UmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJqh7Tzi; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso1290886a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762958525; x=1763563325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E6N2LkhR7aeG78fCFoaE5f7J6Vqh6iLlOX4wNPsAzjs=;
        b=FJqh7Tzi2NZeeQDnKBlIHkUb41vUttUkFkJPrP5EJTRYNECRW0rdR1Ds9sXury7tXF
         r6rS64n0UuAaO/lUr0HIaieCMS2+nK7OBsg3PiTe+o0xjBbPh+vOC+UlMqLf1g+dzIW6
         R1kBgjKjQQ8hWL2vRy4LfG9T6O43aM2+WClgdL4dmiOAOvAPdswaiyiW9N+gMnnIHYzo
         KJGCINJ/eteobm+X6I5tUiZAVfPGGkBieN5AfTyEVC61EP6YqOYhOGFLx/jejQwrs9NS
         lgVPuim0IAyLR1teR6r99IS4FhXdk5hsmlZTcw+u9/3TI/xeAbE4sEDmWskCRalGlHsf
         /hYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762958525; x=1763563325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6N2LkhR7aeG78fCFoaE5f7J6Vqh6iLlOX4wNPsAzjs=;
        b=XdF/3xZVdRgex8gGrGlWrqh3xkeV2dDKuFbz6ch0OJDaNgxZ3niBM6pZBK6nJQMy6z
         vldj+lBa/1ZoQIBjt3nf09cnjPYM7GGRFyUBLpfk0SrPLo6F20JZNABKfum/x+EZPADX
         kUT45zqZGHy5otEEJMhWzv2fbxiQZ6g12r+H/I4OMiVBPe0KDJBrOrI2EnKSQKNl4gud
         MYQmgTphoGKqAR73PYEa1J9sXvnnJavAsrKxjIURrz57QJ10wvxmZcF7uhmsWOB0bnDp
         mW/DsmFNHq+mXQ6DfGN/FkydcS46kekl3oRyiSnqJWj2zcsKPN2A8K3hEg1FLsbJTNRJ
         H4pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnbNZy4uSCZV5NSG+yA5CE6vZ2WvpTpauTG6bdyAFtw3LDtcIbYnfOKL3R8Y+9cBQqmqhaAXe4ChXRoM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8YKp6w9PFJUecB0b0nc6Q6gFDRQZKbJ/AVlhJUbYzIi16HmNn
	EmidXRa0ntDlzDAxmRxZoc6U6XHaiwtAfetJuQSNimdeEjKC8ygS44B7
X-Gm-Gg: ASbGnculnCI5QtuCMXwtL/yzAqMxQu9UkxocftokY+V7TBobeyqo7TfoYLCInGK5Owj
	RASPlpxVvfblm3J4LZhXdBFSqnUSd6dOVLCD5MfwLER7SNKQ13ItkhXH06lQch6HiEa8UqrcZuT
	1m9P/KQlw8xBp+r6fHFJDAH5EEA3t2jrDyJc1EoE1/aNiML60Q/Sfsga02Nom9wDRT/SMJV0QgA
	mqwIr7tgZ99VdyhWrSY9QORefH9VfZ+IrPd509ItcLB/X0agkKMd+6BGrRdNQ/wFFs3SU/0x48s
	FaVKdkkOO2jm91WparAhusCIxCaj+OIPjKDhwIOHVk2LHc0xXgxSDJ+MNfis4Lm+VmL4m6xjmFm
	6CUE8IINS7ibCbH7KpdvTWSAvbhDddtNl2wGWsTQwOaDujv7/CFXxdSqEM3gZJxZpt42NhX2KZT
	z/DInxBLuGpALH2FDfLog1fcjS1A0=
X-Google-Smtp-Source: AGHT+IFTNGoT4aTk5EceAUoALwAHvKb+bdrKgtaYUbE8eWmnwtKSrKlBlBHMiZPM5J2J25G44v5DFQ==
X-Received: by 2002:a05:6402:13c1:b0:640:528c:7d49 with SMTP id 4fb4d7f45d1cf-6431a57e4d4mr3033556a12.38.1762958524375;
        Wed, 12 Nov 2025 06:42:04 -0800 (PST)
Received: from SMW024614.wbi.nxp.com ([128.77.115.158])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64183bc4533sm8411180a12.4.2025.11.12.06.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:42:04 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: imx9: use SCMI API for LM management
Date: Wed, 12 Nov 2025 06:41:24 -0800
Message-ID: <20251112144124.680-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Linux supports NXP's LMM SCMI protocol so switch to using the appropriate
API. The SIPs were intended to act as placeholders until the support for
said protocol was upstreamed.

The underlying CPU protocol command from IMX_SIP_SRC_M_RESET_ADDR_SET is
replaced by a LMM protocol command with the same effect (i.e. setting the
boot address) since using the CPU protocol would require additional
permissions (which TF-A already had). Apart from this, the SIPs are
replaced by their equivalent Linux LMM commands.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 sound/soc/sof/imx/imx9.c | 36 ++++++++----------------------------
 1 file changed, 8 insertions(+), 28 deletions(-)

diff --git a/sound/soc/sof/imx/imx9.c b/sound/soc/sof/imx/imx9.c
index 853155d5990a..e56e8a1c8022 100644
--- a/sound/soc/sof/imx/imx9.c
+++ b/sound/soc/sof/imx/imx9.c
@@ -3,19 +3,11 @@
  * Copyright 2025 NXP
  */
 
-#include <linux/arm-smccc.h>
+#include <linux/firmware/imx/sm.h>
 
 #include "imx-common.h"
 
-#define IMX_SIP_SRC 0xC2000005
-#define IMX_SIP_SRC_M_RESET_ADDR_SET 0x03
-
-#define IMX95_CPU_VEC_FLAGS_BOOT BIT(29)
-
-#define IMX_SIP_LMM 0xC200000F
-#define IMX_SIP_LMM_BOOT 0x0
-#define IMX_SIP_LMM_SHUTDOWN 0x1
-
+#define IMX95_M7_CPU_ID 0x1
 #define IMX95_M7_LM_ID 0x1
 
 static struct snd_soc_dai_driver imx95_dai[] = {
@@ -38,7 +30,6 @@ static int imx95_ops_init(struct snd_sof_dev *sdev)
 
 static int imx95_chip_probe(struct snd_sof_dev *sdev)
 {
-	struct arm_smccc_res smc_res;
 	struct platform_device *pdev;
 	struct resource *res;
 
@@ -49,31 +40,20 @@ static int imx95_chip_probe(struct snd_sof_dev *sdev)
 		return dev_err_probe(sdev->dev, -ENODEV,
 				     "failed to fetch SRAM region\n");
 
-	/* set core boot reset address */
-	arm_smccc_smc(IMX_SIP_SRC, IMX_SIP_SRC_M_RESET_ADDR_SET, res->start,
-		      IMX95_CPU_VEC_FLAGS_BOOT, 0, 0, 0, 0, &smc_res);
-
-	return smc_res.a0;
+	return scmi_imx_lmm_reset_vector_set(IMX95_M7_LM_ID, IMX95_M7_CPU_ID,
+					     0, res->start);
 }
 
 static int imx95_core_kick(struct snd_sof_dev *sdev)
 {
-	struct arm_smccc_res smc_res;
-
-	arm_smccc_smc(IMX_SIP_LMM, IMX_SIP_LMM_BOOT,
-		      IMX95_M7_LM_ID, 0, 0, 0, 0, 0, &smc_res);
-
-	return smc_res.a0;
+	return scmi_imx_lmm_operation(IMX95_M7_LM_ID, SCMI_IMX_LMM_BOOT, 0);
 }
 
 static int imx95_core_shutdown(struct snd_sof_dev *sdev)
 {
-	struct arm_smccc_res smc_res;
-
-	arm_smccc_smc(IMX_SIP_LMM, IMX_SIP_LMM_SHUTDOWN,
-		      IMX95_M7_LM_ID, 0, 0, 0, 0, 0, &smc_res);
-
-	return smc_res.a0;
+	return scmi_imx_lmm_operation(IMX95_M7_LM_ID,
+				      SCMI_IMX_LMM_SHUTDOWN,
+				      SCMI_IMX_LMM_OP_FORCEFUL);
 }
 
 static const struct imx_chip_ops imx95_chip_ops = {
-- 
2.43.0


