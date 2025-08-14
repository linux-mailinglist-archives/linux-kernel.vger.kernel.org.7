Return-Path: <linux-kernel+bounces-769258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCECEB26C0F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FCF95821A4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C52F2FE061;
	Thu, 14 Aug 2025 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P9aCuss5"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DA22DC34B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187631; cv=none; b=A1H+kfKoD5GgXddREsAPrkv3QGdS15UmyEasBoyTlpUEeUtUdjGXC8fhbA6RdgvGlyooDQKcraQJegsBGXfDiv19IPmx69mWwHajmcY0rmX8MzdymFbBwF/SfLOQcEymSUMe7lneJLHg0QqIsqSKS6oA5zxgtxQHuqgrYn9uZMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187631; c=relaxed/simple;
	bh=bWgha+DV3Wa1id7olbSo3Evp0auMrFKcgECRKOQUQgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YT+edwnNoh4BzanVaVQYMrrzjrpWAbV8XaBWABJ6e26Cb34m7wAyyZ1qeJZn/e8FUk7lcmLHDA9P7sQ8CKnuZSN6mRvIdHMof/qSZq+nc6B8k4tmzbIsrRVR/S9Htn91HBbMejKHYCpLlakoYLYX5BluPD3q8ieIlxBbwuUV6XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P9aCuss5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b004954so7938335e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755187627; x=1755792427; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHOC2LGUA3QZ5xVo8Zfg2sW76sxCAGlwB+vvvOMaDRw=;
        b=P9aCuss5GWNAaIEB+fv6LqR/58JZdQZrv/nST6R96+8+k3wevXNIKvJgIyDQVODDin
         V0CFZo6tZIW5KjS7Y0z7VfnJ9YVTD4yC6hCxv0Qb6gP3ZvN0nqEA07nbr26CNHzyH0bT
         aFgWF/886mDUWG3qrswUlrSK/K07Cp7LlDMviRlirpSCiXYUAxBR+WX8npUn87Y944e/
         Nxbz3zl06AwMT4m2NejoBMV4mEDi32Z3VO/02neGg5i7ajZ23ccRJuDfNSX3E+ozaEnm
         nW0M+HHqrM5XpImSgC21o9judctusg16jYMqe/lhjNpdDlnJyimPpPlHLWMyirI902v1
         Lh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755187627; x=1755792427;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHOC2LGUA3QZ5xVo8Zfg2sW76sxCAGlwB+vvvOMaDRw=;
        b=AgOes59M3D80jAxsaxcl5DvZjBPMWEuw8MWdplXIXSVEOPww4I4NrNAnDlyUEPhDr6
         H8d4C0Qg4QD2S38kDDDnEzZ6PQmymPwf1hRpzA4ytOh03kw6oi+SX7zhv4uIYqflMql5
         esRDLkCevjUGbOs2tTwYiEJNxtVyox2txv5Tfiu3LgQxgGdCPOosLk9EN+SqY3tdft/7
         NWNHGL/mU6T82OnZaoMPTEVd1dBwS/mZO378kQMHuR51AE6vhMXKZc6qkvuI4J3FatmD
         Sw1xfS//1ob8H/7C+t32RqeFnDiDKb87DoT0Iwx6RRP9U2SFcXvi/h8/Vy759fFS+NlN
         HpNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk7ykL1iTBLmwuV1bn8o1d8IuCBI3UgZSxR0yk+vjwwhx4MpQNGV5aOjR7vzcLOoBB/mo+toqoUeclcAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbtoJ7RrMd/1+PD1XoZ86yv+Vxb7L82GKAFM30bLB/1AheHJIl
	22QJAHMY+ppdHR5XCJKcjk6lkjHJBvnqcgmYzdY8HJQOk9SPJiOBqgJNSM8TmhoVfZs=
X-Gm-Gg: ASbGncsquGNKpvrQ7FjdZVpWJNN9k+JLL+5SMQ8tYsg3G55EcVLV94eBM1p+nd6IHUe
	dKFgsszAkAT7PYTu9DK3bqPTlCzmddbJcTLi+iQRvFvsAE+bViPgOK1FD3+//g81vmWjmcem+xk
	8ldN781LA5+LFUhOFXVr+I/N+/uO0lUdAmjjf1kN/v+JUgQKdxn753mkRQi6rMx4YaIenDUGftH
	U+ZrLWkxB9pD5qa5ZevbmsCTWmSXMeqZTeEwzVlrkttZ1QfCREZTjUZCPNGxomRSZ6s3f/ej7cR
	wuDw5wWWDNS6z8FkMZ7b4No4MbICy/keH6J2Mz2Y6RAwHmw3wrdrflYdYqfnN/KL1MQJ6pxt7W0
	jJVKrf2t4kwd6frGl5cL4jpM4y1M4ZXg=
X-Google-Smtp-Source: AGHT+IEUHsQ0l/NtdaJERHq/WSd00uZIkZVtp4OgX2ON8GYUOwmRShR360uVb0ELZ0IKVWDhUp1roA==
X-Received: by 2002:a05:600c:4e88:b0:455:f59e:fd9b with SMTP id 5b1f17b1804b1-45a1b6707e4mr33074545e9.24.1755187627290;
        Thu, 14 Aug 2025 09:07:07 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bd172sm28363495e9.6.2025.08.14.09.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:07:06 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 17:06:45 +0100
Subject: [PATCH 05/13] spi: spi-fsl-lpspi: Enumerate all pin configuration
 definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-nxp-lpspi-v1-5-9586d7815d14@linaro.org>
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

Add all the possible options, use names more similar to the reference
manual and convert _OFFSET to _MASK so we can use FIELD_PREP() and
FIELD_FITS() macros etc.

This will make it slightly easier to add a DT property for this in the
next commit.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-lpspi.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 79b170426bee..816e48bbc810 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -69,7 +69,11 @@
 #define DER_RDDE	BIT(1)
 #define DER_TDDE	BIT(0)
 #define CFGR1_PCSCFG	BIT(27)
-#define CFGR1_PINCFG	(BIT(24)|BIT(25))
+#define CFGR1_PINCFG_MASK		GENMASK(25, 24)
+#define CFGR1_PINCFG_SIN_IN_SOUT_OUT	0
+#define CFGR1_PINCFG_SIN_ONLY		1
+#define CFGR1_PINCFG_SOUT_ONLY		2
+#define CFGR1_PINCFG_SOUT_IN_SIN_OUT	3
 #define CFGR1_PCSPOL_MASK	GENMASK(11, 8)
 #define CFGR1_NOSTALL	BIT(3)
 #define CFGR1_HOST	BIT(0)
@@ -411,8 +415,9 @@ static int fsl_lpspi_dma_configure(struct spi_controller *controller)
 
 static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
 {
-	u32 temp;
+	u32 temp = 0;
 	int ret;
+	u8 pincfg;
 
 	if (!fsl_lpspi->is_target) {
 		ret = fsl_lpspi_set_bitrate(fsl_lpspi);
@@ -422,10 +427,14 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
 
 	fsl_lpspi_set_watermark(fsl_lpspi);
 
-	if (!fsl_lpspi->is_target)
-		temp = CFGR1_HOST;
-	else
-		temp = CFGR1_PINCFG;
+	if (!fsl_lpspi->is_target) {
+		temp |= CFGR1_HOST;
+		pincfg = CFGR1_PINCFG_SIN_IN_SOUT_OUT;
+	} else {
+		pincfg = CFGR1_PINCFG_SOUT_IN_SIN_OUT;
+	}
+	temp |= FIELD_PREP(CFGR1_PINCFG_MASK, pincfg);
+
 	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
 		temp |= FIELD_PREP(CFGR1_PCSPOL_MASK,
 				   BIT(fsl_lpspi->config.chip_select));

-- 
2.34.1


