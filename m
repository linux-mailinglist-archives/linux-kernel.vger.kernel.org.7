Return-Path: <linux-kernel+bounces-769259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9743DB26C23
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2363A6D70
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889102FF67E;
	Thu, 14 Aug 2025 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMxQyEBl"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3242FA0C9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187632; cv=none; b=Cr68DjWBcEc5RWUPMLHTWVbtnKhDjHdXXisSezsXgYO5e5G+iRZL6KIAclzl6s80OFpWIEs4pS7urjIjJM0+Kg3bxGGZeRARbjI0gM6CDzzytwG465EtLFCsaasnQsMpOJ79SoRYitx0JGRWkw9iDq5LWt0iy/iPZxOy7ae4+Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187632; c=relaxed/simple;
	bh=kHiusdNohinSSATnpMTFXT3o3848Vs6qfqTYwtpUuZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mfogZnBlrcwOCZqq5JdBCmf0OJsv0h49dWIkIPqsgTfCGab+UDYrOgiZTo0RJgrI3bpMHsybBJaERwk2JZOKL7jKAr8lIcMRaE6NlLkgzVlYKqoVdIjfH9c6OrqpNM2/GDeayQ+WsHW6gXv3xLxd9JGS7TJLYyzUthLbPECMeIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tMxQyEBl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1b00797dso7437355e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755187628; x=1755792428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zzgs94UaPpR4eiZY/A2IoO5J4EqrnU9/y/7GbaVqos4=;
        b=tMxQyEBljJ6iv+qkYnJwWRCswdSmtozB1tmA4qO5t9fQJ1Hoy3h7qszUgy1Z7fJjOf
         tJTFT/AXknaI3oPjChYmPkM2D8PRn5xGmmgLRFA4CHSe0RIfi1jaK8M40IKrdy14b8Gn
         UQ/yseuFnDsI8bKodnNqjGqs2HomARI5nGW46hNFqmL6PfzcgFZc9foG2GiOBR57+bbI
         U5++GTPVTnpaFSEEDpJCERMlKSp/kyLDYO9HY9CHtLLOojh8Vi86AzJGLAlWF9R8zsSk
         7jtRP+KiVxiUPyWd4wVkrZv4ZgfFdKDc+fHMfbAktH5f7kk1kAgwwAV29V4co2Ag42XL
         iCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755187628; x=1755792428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zzgs94UaPpR4eiZY/A2IoO5J4EqrnU9/y/7GbaVqos4=;
        b=GPLXgNxLgVDHER9GYLFXw475a/nXKvfUNit55/eosbClQwXtZlOIeIgCx/JFjBgBEu
         QqcnIJGo6vMW7BLueUBscnYpxxlh4I4rPzxsEFiUDv/XojBFRWp5pKx6wSeUhrl/tcU0
         RDzofYVR24wZ3AlGJK96emTif6lNnwOSVx8Ghc9aruJN83oBThAKMeJv+qFsmxnFsdyi
         SXJKCC+18qR9xwIuGDwTWQ8bjgfuX2gigZ4GVloAiI6Tr88md/Nlex8DeRSsJw4vbosd
         Ee+TvG573NWkgtn2ow95YXZOPNgmSFKs9w9jeD56OOHvuNQhxrTD1VEH2H0CkoSsw4Cf
         wRgw==
X-Forwarded-Encrypted: i=1; AJvYcCUAMc2XLwxq/B4/DUi7uev8+sFRrmbV6FRf1GskrhOYy5LKIwxKcZqk8KxS2onzwNm5bCalsDg4HZma8nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKb/zhboUJSGADQU+TXUngqEVTyZXLMZqeYzk+GEad92M968C3
	s4HUNI6AKJ/8Zqg2tjKdi6WdBJ169I67rcRP8NJ0EI0KaUvIbM9Rrj7LaTMIkf4Ea6o=
X-Gm-Gg: ASbGnctjc+QvLVUObASlESnj2+Du4D9ddfbg50L2QpBIiRI/zwqd1GKOzqix/3/CDKk
	T1VAhSunIDE6SXBwOfjrjtxDLrqHV3D/wMW4+x5qVXmcFvCuV6h5unMQHnTMja5WkA9crGpmFLP
	tmVjDNvyXhbKunVTp7+OBC5JIUG0DLz4KWjjMn3niKtsZvZkUgzsOcPT+b9zcVWNCMc89UNgG/G
	FHsoIRaw71gxeCMT6yxYkSZtxoY0z4/Vactyji7ETB/CSrUEaEmEdgjwHndQGCqLz9n/9LSFyF4
	2yZVw3yd7D0WV1GhZ5vfkwu69eao8ufXI5rS1EWQhWwxkCwb21Bhgb71W50PgjPxrz/rrI1WBtm
	Yj4KWuslNIzouQu/a9nfIPScDwNZL5HRs01wfWRK/XQ==
X-Google-Smtp-Source: AGHT+IGktcl8YaEWCqH4pc5f5bXMJs47KV7sRjWfK4gjUNrG3xeCwFQRXRTrSkxb2XHOnppAWphUiQ==
X-Received: by 2002:a05:600c:1c1b:b0:459:ddd6:1ca3 with SMTP id 5b1f17b1804b1-45a1b5a2033mr33274125e9.0.1755187628364;
        Thu, 14 Aug 2025 09:07:08 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bd172sm28363495e9.6.2025.08.14.09.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:07:08 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 17:06:46 +0100
Subject: [PATCH 06/13] spi: spi-fsl-lpspi: Add DT property to override
 default pin config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-nxp-lpspi-v1-6-9586d7815d14@linaro.org>
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

This allows the SIN and SOUT pins to be flipped. Use an enum instead of
a bool even though we only support 2 modes so that the other two half
duplex modes can also be used in the future, if the driver ever supports
them.

If no property is specified, continue with the old defaults.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-lpspi.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 816e48bbc810..98da6a5d7013 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -88,6 +88,13 @@
 
 #define SR_CLEAR_MASK	GENMASK(13, 8)
 
+static const char * const pincfgs[] = {
+	[CFGR1_PINCFG_SIN_IN_SOUT_OUT] = "sin-in-sout-out",
+	[CFGR1_PINCFG_SIN_ONLY] = "sin-only",
+	[CFGR1_PINCFG_SOUT_ONLY] = "sout-only",
+	[CFGR1_PINCFG_SOUT_IN_SIN_OUT] = "sout-in-sin-out",
+};
+
 struct fsl_lpspi_devtype_data {
 	u8 prescale_max;
 };
@@ -417,18 +424,27 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u32 temp = 0;
 	int ret;
+	const char *pincfg_str;
 	u8 pincfg;
 
 	if (!fsl_lpspi->is_target) {
 		ret = fsl_lpspi_set_bitrate(fsl_lpspi);
 		if (ret)
 			return ret;
+
+		temp |= CFGR1_HOST;
 	}
 
 	fsl_lpspi_set_watermark(fsl_lpspi);
 
-	if (!fsl_lpspi->is_target) {
-		temp |= CFGR1_HOST;
+	if (!of_property_read_string(fsl_lpspi->dev->of_node,
+				     "nxp,lpspi-pincfg", &pincfg_str)) {
+		pincfg = match_string(pincfgs, ARRAY_SIZE(pincfgs), pincfg_str);
+
+		if (pincfg < 0 || pincfg == CFGR1_PINCFG_SOUT_ONLY ||
+		    pincfg == CFGR1_PINCFG_SIN_ONLY)
+			return -EINVAL;
+	} else if (!fsl_lpspi->is_target) {
 		pincfg = CFGR1_PINCFG_SIN_IN_SOUT_OUT;
 	} else {
 		pincfg = CFGR1_PINCFG_SOUT_IN_SIN_OUT;

-- 
2.34.1


