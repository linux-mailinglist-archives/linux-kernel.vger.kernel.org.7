Return-Path: <linux-kernel+bounces-789707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5334B3996C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028031C26C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814BE30DD32;
	Thu, 28 Aug 2025 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CAE90OZ3"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F2F30C636
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376142; cv=none; b=XjvG5RAvJ9VtgLqfTZfTjrjQZMvlrAwe8g4KpCSGdmsbU8pWDfUf8QxS2EVndMOho8TkEi7pcX6/f9seuiSAnPIFJNuQYx7qAsl2MQ75gezMN+1idCDBxTcR3Z4xXUlDBVONKbFwYYisoNeSdy7Coxh07XUty36GfcP+stzOQVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376142; c=relaxed/simple;
	bh=+vua32+ZisCIKoZtgwxULPWaV1MKJPVYFqaHRCFc2jA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uv0h3hvq5f9qZ9B354BUW3sjSTD9Q21F0/j7a7dEYIq+3eOBBsgOLL18lYCQ5/P1HmzkV73ud3hXVkuPK9G6qFh5Is4QM8pApbh4IHTAfDgJlRMhT2RQwAe/zKm+B/4LsyyZfEuKmajQGPf3DEjvz5OVcxkhXzFfvQryZzDtzv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CAE90OZ3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3cbe70a7923so663837f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756376139; x=1756980939; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yp6uP3SnVVC8UtclhAtZ36zVvCvjaZ1bDiL+uis450g=;
        b=CAE90OZ3Qzj/FsXu8/0AiTYsX3CWwXbGh8fdvH6Khzz0an2MHTDVVg9D2Cg1y8GO54
         LP5qRnN+Uqd5aoAO9WVroxXPsuOc4/XmdV6d5oL0nle2/8CGYMg9adhk5fb9UcsizpoH
         Tc1QAsgTDyBRdnvMIEA3hjQRH3+zemfQeUjSPxSKiY8O12wEbzuG0xiRhRiCo6PI8zFd
         BhShIKUwI/kX4QpTvYYmBaGO9+kpgqp6awbS/vgaNnnaYgzEuGFrnvB9+mjR3TBFIQeN
         zOMxRqaoKT81c37Ydh3bFFR2kbp3mWPxHlcYfnex5Z7U7A0zQq/GmsCNNyas6gWIPnTq
         59aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376139; x=1756980939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yp6uP3SnVVC8UtclhAtZ36zVvCvjaZ1bDiL+uis450g=;
        b=wfZig9CFe1eac51InBk3kBgmrOhGMs1g1QUGqF9oSISqDipVTAVVctw3wbUAa1fm9/
         gACMfXS2+WhxyqlkYLvlzsTK1Ru4mp4qFJuRCY+jNbmUKuo55TP5xF9Jw2EOr6ax6atK
         8sD/no7pwGW+i2AZLFgPYZUulRgw3Vk0bqeiW/cIjuiaMa76G+Jua9HrUyA/3Vd/k6w6
         e+z+i5MPaNH9WoC/eJTeZeOmcA8pLhdFlEzIN+rF6y199N5Tumd4JAOtUtw7OJfnytKy
         2/94HYpk0cxH1LJClMGVZRyDJrOc51RCr9asc4LhKob6ypWteVOpWkBAQFWIQc569KyA
         o0aw==
X-Forwarded-Encrypted: i=1; AJvYcCVrF8PT01CsbQ1ld28jcSHfuCmGv0evzzb4ArNZ0maL8+QVSSSXykn3LNfiQ918BrWk8GTAZm8bVmgaWmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhllwz+hgYfd8qRPoKlYi6Q4XfZd3xkG4+43OO5U67pQZE9u2j
	FZSNPEVpTlRd3Vxm67njlbzR+l0oxAhiFOtY95fL9uiZUPoS9hF/tt388OETLsHWBd4=
X-Gm-Gg: ASbGncsFzyk5hdc0MW93ATW1FiNg5B3Yhv6OBN3l3un3nLCma5KZ68CdEmDpQ5LrDlo
	pRBe6mQH1XE/F+0zjidKh12V6xLxJvL9HMXxC2rlSSEcUXuqtnn3MOuKto9DcqHxiBOqKXNDNJ2
	w7OSNA5uppm9RBkyiEhm3RLxmSTEVpJ5ufVo+fDj5Tg3sZvCvssmvVgUlgIiHzuAqZZpOLmbRBO
	NDhsnitON94MZv5SOXFvTeVRJS+ZlwTxCRMiFqm66Gmf7QChNG1L/gXgBVeoDcoE6IuqwjsNnXt
	A/44ubil0KD28Wr2/5vzx0/dxD0Thon9ZWU5UdjMvRGSbNxGMBFpnbmuBkhkd8wnrUVEpH4Y4Dw
	dam91IKog2S2afctL7hWwBPZwQXXujlxo4wlnj3aPtg==
X-Google-Smtp-Source: AGHT+IHt/hz7pSxKUT3aLdo/Gb/ZNoVM9J+1IsQAvEnajR37wO8sFmm+lOvT+aASpbunKjjiXbYm8Q==
X-Received: by 2002:a5d:5887:0:b0:3c4:2005:fb9d with SMTP id ffacd0b85a97d-3c5dcdfd700mr17926935f8f.31.1756376138965;
        Thu, 28 Aug 2025 03:15:38 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66f2041fsm49976305e9.5.2025.08.28.03.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:15:38 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 28 Aug 2025 11:14:48 +0100
Subject: [PATCH v2 9/9] spi: spi-fsl-lpspi: Add compatible for S32G
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-james-nxp-lpspi-v2-9-6262b9aa9be4@linaro.org>
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

S32G doesn't have the max prescale erratum (default) and it can query
the max number of CS from hardware, so add those settings.

Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-lpspi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index ce347cdbb009..431439d4cdda 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -145,9 +145,14 @@ static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
 	/* All defaults */
 };
 
+static const struct fsl_lpspi_devtype_data s32g_lpspi_devtype_data = {
+	.query_hw_for_num_cs = true,
+};
+
 static const struct of_device_id fsl_lpspi_dt_ids[] = {
 	{ .compatible = "fsl,imx7ulp-spi", .data = &imx7ulp_lpspi_devtype_data,},
 	{ .compatible = "fsl,imx93-spi", .data = &imx93_lpspi_devtype_data,},
+	{ .compatible = "nxp,s32g2-lpspi", .data = &s32g_lpspi_devtype_data,},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_lpspi_dt_ids);

-- 
2.34.1


