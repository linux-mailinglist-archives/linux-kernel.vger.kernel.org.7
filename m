Return-Path: <linux-kernel+bounces-769263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FC9B26C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95CA3AA8221
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B982301497;
	Thu, 14 Aug 2025 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vHJ2mU7G"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06442FE07C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187634; cv=none; b=cQF7vFGEVPKuQg7+PSS0XPdmpo51fTgIj4XQ3pGhvNOKYsKPZQnMvIxNCxlcvU5hDON8rI+/m93bqAsQWaBwPEelmRCdLqy+4JnEkPcGl/iT8nrtuAPXl+SzD2xUHXjXsK4Rkr82vDp93aRS1VBEUB6+2zgAgUcfSFBs7zWhuw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187634; c=relaxed/simple;
	bh=ZiCKUtZKTqw9rKZf/7+lmX/pnv0/DEYvxI7bYI1KMjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZYB0Dpy6xnadyiFMYpRVoqNCqWzPn/dofOycKMvUTzpScO4ZO486EXDmQ/XBs7PwlDrBbOv5hbFMuANXqqc7EIxzjlPyE2Z1FBd0UxcsQSdK2sBufwN1e+etV3Sd5JCo5tjFWLnwOy8ZV92AS+WUhQeUI6R/Hl46Da+SxGwMB9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vHJ2mU7G; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b9d41d2a5cso870385f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755187631; x=1755792431; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+xkEKCXMOBI9HGuIfKoOfST0QQ0+/qYTKxEDH2g02Q=;
        b=vHJ2mU7GwvoQlMlpsbPU6Vv6TNT4Y/lPihzUyFjol9FtByqq42MxA5ofW2rlNYGE4Y
         9pHF9x/P9kVPpe7GLCMaOUGW9UdT2T5DtXMPAvcUZ1lW4nMnNx2NHUrs48/bmsRM+eEE
         arRAA8y2gaoDzbUKWpA8jWNSffEpmjpfEACh+ezW9/2u8MaNhrppxI+qUkx2gWDyQnu6
         VIXHlxi60+UYxtczXWKtNDXRC0oY45kdUpJKh4dRHZvV6kmUEY+Ok2zuQnUCyT57OKYA
         hf3KFKpiLs5NeHZJ9hNypm8fB5y/Ga3myhx982E2ov/6W2SOzoxsSFZUP/Vp1iKqHAeA
         fcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755187631; x=1755792431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+xkEKCXMOBI9HGuIfKoOfST0QQ0+/qYTKxEDH2g02Q=;
        b=Utfyx/ga96CTI7++fZOc2SRD3tUsgXNE5feHxR142L3yvu8WWKvopW39Xa5wlLlaB/
         K6zalRWOxD47fMs+O3ZTZCt5oQuYYoMB1StwvXY1KK5jEz6Mz7UHkGM+BaSEq/ad7Mh5
         dXP1uKFESFhBDWyZWuvzvH3hyTfIJrxFE4IAoAV7z7MKaZw/UYHTVGFWhHrD/dIHuLbI
         LwFTMyECxN2JENxSVn1n4ntTFtaifp+TIGxWyyRYJwwOecyBt9kihhP4F2a+uYEEc/QV
         RzabWxI4+Oea8FLJijNVOA1meirUr+CIFgN/B03GtRIzAlBruu7wy4XINkCtwRmQxAss
         EztA==
X-Forwarded-Encrypted: i=1; AJvYcCU+uqjL/ItbJjkgycjP6P0YfbgfekQHtAstT4Rbqah+vmkPXdPojz6mYtGJZynZdkfkKVOmJ4svH1CPau0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWWCI2kBxT+WkgWgkeePPlYFnVDbtOUs5oyfADpAHnJsFogYZn
	EHG3J1yBHUFTFGcg+ehCDNaxqZpF0AsFmlYPUJzdzuXKB3Ity3l7pcC/sSeospxqbTw=
X-Gm-Gg: ASbGncsvdVGL4opV7SVQI2a87vAzNX+iOtiOSk+tI0DnVa3JDlt8atK6JDG8pz8LvFn
	0KFOrDNdC79jlYthY5W1yNEbPMo/QU4r712ZySBlwSW5YAKgftGmeU1nMBsZChAMhXCRatBqvdm
	vhLN/kbVkGJXg0XuzPtUrl3rGJhVUx4gs+lyhTalty9Ic6ULXBl/as4GuPWg9ko6L6Hsv3n0jHT
	W72WJ+E2X7C3ufQehkCu7B89wTt0uia6EMYilv7hU2Eu+92PLGsufSe/cR6hKDUdM3ilPRdgoyw
	bfTkSRJy7np7J1s68X7CznrAZ5WFvT5Icqs/iL44aLmy9n2U7mHLTc89jRG7KGQa/vxZU+BRwY+
	QQYW+VUHdg8wRlBgBg4iyR1quZe8f//k=
X-Google-Smtp-Source: AGHT+IHnPTemnQhlu4YOUH9ujk8ivLrojbab2xEKJpPhGixHfcJ0gQI64MgagrxrAFS1KKMyz+LVmw==
X-Received: by 2002:a05:6000:22c1:b0:3a4:bfda:1e9 with SMTP id ffacd0b85a97d-3b9edfe4a34mr3391077f8f.46.1755187630845;
        Thu, 14 Aug 2025 09:07:10 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bd172sm28363495e9.6.2025.08.14.09.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:07:10 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 17:06:48 +0100
Subject: [PATCH 08/13] spi: spi-fsl-lpspi: Make prescale erratum a bool
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-nxp-lpspi-v1-8-9586d7815d14@linaro.org>
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

This erratum only ever results in a max value of 1, otherwise the full 3
bits are available. To avoid repeating the same prescale values for
every new device's devdata, make it a bool.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-lpspi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 332a852b746f..1013d5c994e9 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -96,7 +96,7 @@ static const char * const pincfgs[] = {
 };
 
 struct fsl_lpspi_devtype_data {
-	u8 prescale_max;
+	bool prescale_err : 1;
 };
 
 struct lpspi_config {
@@ -144,13 +144,16 @@ struct fsl_lpspi_data {
 /*
  * ERR051608 fixed or not:
  * https://www.nxp.com/docs/en/errata/i.MX93_1P87f.pdf
+ *
+ * Devices with ERR051608 have a max TCR_PRESCALE value of 1, otherwise the full
+ * 3 bits are available (0-7).
  */
 static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
-	.prescale_max = 1,
+	.prescale_err = true,
 };
 
 static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
-	.prescale_max = 7,
+	.prescale_err = false,
 };
 
 static const struct of_device_id fsl_lpspi_dt_ids[] = {
@@ -329,12 +332,11 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 {
 	struct lpspi_config config = fsl_lpspi->config;
 	unsigned int perclk_rate, div;
-	u8 prescale_max;
+	u8 prescale_max = fsl_lpspi->devtype_data->prescale_err ? 1 : 7;
 	u8 prescale;
 	int scldiv;
 
 	perclk_rate = clk_get_rate(fsl_lpspi->clk_per);
-	prescale_max = fsl_lpspi->devtype_data->prescale_max;
 
 	if (!config.speed_hz) {
 		dev_err(fsl_lpspi->dev,

-- 
2.34.1


