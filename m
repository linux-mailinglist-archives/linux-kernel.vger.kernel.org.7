Return-Path: <linux-kernel+bounces-769264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37374B26C39
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B458D62259C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DB6302CBD;
	Thu, 14 Aug 2025 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OpxXIH6W"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59D73002BE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187636; cv=none; b=HWz53jUrrnLya3eY2ltsbsnkGnwB2rh8jZoLAEGBoE3ktL8U4kTBe0qZxbQLIDr1mgpEGI7/GGQJfEEfDtC+nb65V7tFCxObHvb+RYj++j2QuXgomrcHbzpBApiyaicZkkvUNEqkq0OQD7c9km5j50C7s13ACCVmO8niLE6BTCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187636; c=relaxed/simple;
	bh=nLKgSvSgI7gDUsnC9ALIo8slGJAiPfy5nla9VR+CXBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q0AzwSYEAv46d4vOKiVpXxcabgIlcTFSsbjUsokwUsPhIpQCRfaoLEXn42bkzg8Zv8mFrpskf05uqyy0sZ7JUkUAPfZn+5eQ9EE1P8z8YBrlVRmAXWCvOluUwE1/8dMDbNIcULfAKcIEuqo8mgRCXmCkImxPpmsmNSEK1Ze+khQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OpxXIH6W; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b0cbbbaso7685325e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755187632; x=1755792432; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4uUiAWgIv/rr4bdczjmXB0zM0zB+f4UfZqA/MDFkyEc=;
        b=OpxXIH6WnOgr9w2Rx+EIqSUiQTFtBf17ypM/jrVrZLCfamNvsf5mLZB9E3i9bGkUXy
         FZU97LRnAnJ6DbtOjjqW+hjq1D8a1qlCJStxsngTISkQJboYcY6lYoMOfVBi0dMVrR/o
         dYFXU+LNZMBDf7RH2F5ZjjLiGVyg3YWLgnEejCaG1Ewa1Y0cK18I34Jml5r5kXVISgTp
         v6kXwt6l64/2l5zilVq5nADsP1yR8BES5Ch027v+j+r7dgrvv+uDckfvSXBrWp1xM/RY
         Ido3qNvhqJrpbRcug3VZPm2kYV4Sbta6c7c/kCGPWqK8Zmmk6q+bIhuS1KUmoTCaVRji
         E8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755187632; x=1755792432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uUiAWgIv/rr4bdczjmXB0zM0zB+f4UfZqA/MDFkyEc=;
        b=GbU1rK/y0+7ys7y0pSM0MC/Rsuzu8uyWglhVsqf+OL7x5nC4ufI8RD4KpGbVOzpXQS
         5PJqGQTh6n8HKZLgnn6NAaPWDrY30MDlEFM8ybzdhaYcW0grhugjUT+22WBMjnj3Vz39
         QZ376LQPzDE/WZxs8UqUktBtxYW44E5CgbliZlL2dZQk4eCRhDzfpfbCDjF5LGwYl3wk
         FhyJROFC2cq3LcColRYHIZHC6oaQPPlWlvZLQnuKkv4VOXpCHSju1H5+cWxgxhqiwIpD
         eFaE9Yk9to6Jsldg9aHoo8EgxY/n6cN23EJd3Jh+LZGa26sdWPEdc2rwP557kcDHKG80
         hHVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwOR6qhG/TCIcqqiz9pjoFTpF2ZAIvbi2slZsBQw+YyreoW/GmPM/aDNmYzdT1EEDuC9oUxt1+ElKid2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPeICNqDXSqcKHHuxwB8uhnxHEvS5GYLGOKdRLGnPB7UPQTrCb
	DtHIbg7rcPn62KdY8gT5IpsWePK8/D0oLggDKSFChjf+K7O1XuxA8Wm+6nLVOq8dvXg=
X-Gm-Gg: ASbGncuKpYIWojZ2nV5PgjXLtxK7mEJ9QMFFCaqHxfiMH2QYwy9GxCNPsWTh28hiazJ
	PLrLerQ9GwFrt1C9fKPMKd8nHz6kICPiyBVG2edRXvBxeyPUX8kSql6o8KmSfbdr28wxgb/KrKv
	ZKJgi/YbUovYTpVAmWhapEr+AA7lKMMtRfzXvz2dRrMph3I3X/0u1rLSWZjCHZXLcYDn07w88xz
	wiRIGF5qG2a8MFZ0xujYgS30JU0osvfluPFLYycbDh/VBNBas7uXBvt4/BZ7lkdA5VR7AqhDsMw
	wBzdIWLEOkH1KosHkRGR/PPRqqY0eWUhXIUgB5NsscKWGWXwP8D4RAzQzPSWO7hPWaTbo8wzSGq
	kgGDEfOwUaWLuiF4O1zR9x51KoKdJB6o=
X-Google-Smtp-Source: AGHT+IFZZ/SClwkyS/5PD0FX0+0seHog/otwGwC9/uLDftMPrJiGWVG1n+A33cLiR0ff/m9sgu3Qog==
X-Received: by 2002:a05:600c:35d3:b0:459:da76:d7aa with SMTP id 5b1f17b1804b1-45a1b6758a4mr27865565e9.25.1755187631973;
        Thu, 14 Aug 2025 09:07:11 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bd172sm28363495e9.6.2025.08.14.09.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:07:11 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 17:06:49 +0100
Subject: [PATCH 09/13] spi: spi-fsl-lpspi: Parameterize reading num-cs from
 hardware
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-nxp-lpspi-v1-9-9586d7815d14@linaro.org>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
In-Reply-To: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Clark Wang <xiaoning.wang@nxp.com>, Fugang Duan <B38611@freescale.com>, 
 Gao Pan <pandy.gao@nxp.com>, Fugang Duan <fugang.duan@nxp.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
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

To avoid adding more string matching here for every new device, move
this property into devtype data.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-lpspi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 1013d5c994e9..6d0138b27785 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -97,6 +97,7 @@ static const char * const pincfgs[] = {
 
 struct fsl_lpspi_devtype_data {
 	bool prescale_err : 1;
+	bool query_hw_for_num_cs : 1;
 };
 
 struct lpspi_config {
@@ -150,10 +151,12 @@ struct fsl_lpspi_data {
  */
 static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
 	.prescale_err = true,
+	.query_hw_for_num_cs = true,
 };
 
 static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
 	.prescale_err = false,
+	.query_hw_for_num_cs = false,
 };
 
 static const struct of_device_id fsl_lpspi_dt_ids[] = {
@@ -960,7 +963,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	fsl_lpspi->rxfifosize = 1 << ((temp >> 8) & 0x0f);
 	if (of_property_read_u32((&pdev->dev)->of_node, "num-cs",
 				 &num_cs)) {
-		if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx93-spi"))
+		if (devtype_data->query_hw_for_num_cs)
 			num_cs = ((temp >> 16) & 0xf);
 		else
 			num_cs = 1;

-- 
2.34.1


