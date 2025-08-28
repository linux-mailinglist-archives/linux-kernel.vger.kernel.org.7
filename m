Return-Path: <linux-kernel+bounces-789701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB1FB39958
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8671C21254
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD72D30BB81;
	Thu, 28 Aug 2025 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FSb9LhC7"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D71130AD0E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376134; cv=none; b=ftE/6aSqV057x1aX8LAibHaRquGU3l7gyTtvCA7URD099JBmRFFTBYDe6pIZmdxabsKUY5l8aKiN8w8Ip5JFo9uPBROLkfDW3bpmgF+jD0iERLGlurobGZxlS+vq7ufrD6RSG8JKf2biHYI2PzZ3yGSAYWfmTGtFZXEPvlwn05w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376134; c=relaxed/simple;
	bh=fm/irSgzzRUae8EgpEM+Pogy/qYxrilpCYg6GpKRXl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jfrXO6/q18lg2+J3ICB3wGsAMWNElHbZZx5Jx+TgQ98D0qWQ75lBgNSJwAL57xyM2sfkI3Q0SIAdryLh3/WCMHezwhQokvw6q3nNkVV4M20xiKlofP1Po5sGNHl+Z18Qsy93aOer2mntvnff1FnZqSvaAoJMddks1hTYBzOilrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FSb9LhC7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3cbe70a7923so663709f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756376130; x=1756980930; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XiQVBV7G4LRmwXHt7vlktdEd7OWZj1eSrzy2LZFlNd0=;
        b=FSb9LhC78QdRuo5WHbka62WOQQWZdfTK6w/rFBC1vPf0xeJkpKDDn8AA+7CSDWeSeK
         Uti494v7VSkSsmRXPDTOdHt5o0lDM+iq5TyvdXdrS8X9h94soUPE0bigDfXOGb3V83zt
         uDssx0NJJs83RJ4DQm5PsNoOV+tI7XAQTZzZRhA6NP+nG/Z0s+7jiXRDbOYmycPWrf37
         s1U3c34hnisavAz8VFogHlbenuncGO+i9QNRZuTa4z4fwSZGwrl+dVUuB+40nTiMBctU
         yHDOSNaFwABv4joEY3VxNdLrFRGH3318ph7sPo5yqux5NVOjuwnhJxA+FemNUifM4WBQ
         qeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376130; x=1756980930;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiQVBV7G4LRmwXHt7vlktdEd7OWZj1eSrzy2LZFlNd0=;
        b=FHdosxE3ydp/QRECI6MDDgYIN7+fiW+WiDpffRt5OZowMW/8NTROr/0jWc93Yboym9
         7NBLRVskveND3OsP3Dg4XN4yb+ZbMTh2LJtyB3yEtI1TACMDQBupvbH+jsFVSwzZjIp6
         wlyznMekrZAzEhhwQ3Ax5rDpaEj+BbVSccnok3zmBRg/WD6HVDQBKoiRrGCoFMg6DhjT
         SMy13UI3Csg1t4oIbLb7O9QLm3hs1TKq7SDosypp4AaxXis3dmwJ0c9InB198Dv0OFl5
         uGcqsb9IpTVzr6TWYBM8HwErbdZMhhmU8p7y9VRd4j7ttv4JrS6BE9U+00JWPghs8N30
         OxbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP5esmgYGr+2NX0F52/LHvvcpCRuoV9wdGTkiDeKFtsJPbGL5CIa22OMskGJNZnZoZa9t6Ub/LAnnHARU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMUoNbsbmoyXIce5XcWiaZOT2nBtVjr51dpVAgcz8xF4WJclLl
	WjHREwCQgv5MUAReCXXo8VnLtDzo1oexWwHkkouBMCBWGnEl6CKzt8C5X8jjGHrkHgM=
X-Gm-Gg: ASbGnctwH8Wb8/Cr2L4ziDlKByedw/7ilFVuVCNy5e+E6tzJoGjmO3UkN6D9MeS+x3w
	Bl9/antwfoxJMOmXX+lGHF66LSZ3zcgNOPDzDfBGRibcJnDNbKSOLEkvJavRfl6O3GRUBRjcC8r
	2S9OvkOVRlr0GtYPF+dRoPEBGcpHUp3LPHGUWOUgPw4EEzyarPFwWVqj8STApbH5wUWPrynML9M
	dW8hPi6qAO9YV7p+iLt7K3x2U6KV9BUvztfx8CE2ytqw8AvTIVQRJq/M5cwuhejTPpRh42amoiS
	tUmAhdj5Evxy9kJERJ/VYWHJmbB4ORHzZ45FcwPOTk0Ky1T4XPF1qvrzLZXI4vK/PTl0H/i49DP
	NB88m4Q1HhekmpUl9/K2+U3qIaMYywIy4YN5zxa5OdOSxjctc73GG
X-Google-Smtp-Source: AGHT+IGuIIt2MipEGX75tHuVYdu+fYH1fy/yLSbgALOvLFpEQrFBLgKzzW8donfheTWMs1EJa6U4aA==
X-Received: by 2002:a05:6000:200e:b0:3c8:5b40:dea2 with SMTP id ffacd0b85a97d-3c85b40e7f4mr12640141f8f.44.1756376130407;
        Thu, 28 Aug 2025 03:15:30 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66f2041fsm49976305e9.5.2025.08.28.03.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:15:30 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 28 Aug 2025 11:14:43 +0100
Subject: [PATCH v2 4/9] spi: spi-fsl-lpspi: Clear status register after
 disabling the module
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-james-nxp-lpspi-v2-4-6262b9aa9be4@linaro.org>
References: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
In-Reply-To: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Clark Wang <xiaoning.wang@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Larisa Grigore <larisa.grigore@oss.nxp.com>, 
 Larisa Grigore <larisa.grigore@nxp.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>, 
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com
Cc: James Clark <james.clark@linaro.org>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.0

From: Larisa Grigore <larisa.grigore@nxp.com>

Clear the error flags after disabling the module to avoid the case when
a flag is set again between flag clear and module disable. And use
SR_CLEAR_MASK to replace hardcoded value for improved readability.

Although fsl_lpspi_reset() was only introduced in commit a15dc3d657fa
("spi: lpspi: Fix CLK pin becomes low before one transfer"), the
original driver only reset SR in the interrupt handler, making it
vulnerable to the same issue. Therefore the fixes commit is set at the
introduction of the driver.

Fixes: 5314987de5e5 ("spi: imx: add lpspi bus driver")
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-lpspi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index e50261e9a1fa..fc4d49f0717e 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -83,6 +83,8 @@
 #define TCR_RXMSK	BIT(19)
 #define TCR_TXMSK	BIT(18)
 
+#define SR_CLEAR_MASK	GENMASK(13, 8)
+
 struct fsl_lpspi_devtype_data {
 	u8 prescale_max;
 };
@@ -535,14 +537,13 @@ static int fsl_lpspi_reset(struct fsl_lpspi_data *fsl_lpspi)
 		fsl_lpspi_intctrl(fsl_lpspi, 0);
 	}
 
-	/* W1C for all flags in SR */
-	temp = 0x3F << 8;
-	writel(temp, fsl_lpspi->base + IMX7ULP_SR);
-
 	/* Clear FIFO and disable module */
 	temp = CR_RRF | CR_RTF;
 	writel(temp, fsl_lpspi->base + IMX7ULP_CR);
 
+	/* W1C for all flags in SR */
+	writel(SR_CLEAR_MASK, fsl_lpspi->base + IMX7ULP_SR);
+
 	return 0;
 }
 

-- 
2.34.1


