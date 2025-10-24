Return-Path: <linux-kernel+bounces-868705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE14C05E99
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F673B5B64
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C71F3164B0;
	Fri, 24 Oct 2025 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLr7sj5f"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E59359700
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303463; cv=none; b=jyA8AAg/Psczf54QDgWS8XRjofRfwB/BnxvGnPJ3Qbt4WaynUx8jpC4q4f/nYENPIjSXx33mLkP7YMuo4BopGMlkU9kB/cQ7zW4JvCb4IIgKl2e7r4jxS6cK+AkS/zuNbYqyhDORdd4bLRS73Hgv/T75k3jw6VMaSKftjIYqsiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303463; c=relaxed/simple;
	bh=7feswa3GRHqUfcbWHAfsnWtSXtDiRE9nClVCJljxFI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eCJYAMbfkXZvXoaumj7rOGnyP3JZL2mwAUxe5Or8eRhizOcTpT7UQoEiwajn4F1kmHjaD11nS2OL/wD60BsasjRXPso5/uh3dLSa7htTf241U0R9s+3JQOmju0Z1QkF/l38wpZzoRKcl/pk+EwEM03ISEUN6Gx6hPQk032LQ5g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLr7sj5f; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-592f1988a2dso2695303e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761303460; x=1761908260; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDFcFZ4pKJmDfhD5kcDZS16NPNGgQ/ZBppEJ8jHXnMM=;
        b=gLr7sj5fjPdJo0+gk/v7P09+PVeCi6Xa+kpovK+PfzUezkXO18FwnsRyrG0HCgiknl
         ufbFb8S3GKrffvThDOSIVOAYBNckjJYkqV13yBs5++KWtbOvo7awaCiwTMk7lQm+YOd9
         CavLiZCoH8rqdRdPlJ68qlknsMdpW/c/Bj5fZZQe/k5oDQDIbnJ4VSckUyeEQAO6YxSp
         KY3fW4fKoCN1hTIokHXVJAObAwFohd5LJ4vPtBEoINa8rAan0k3ei6H/M9A1rzuPL5ZG
         UmHCLbCqaFyW4qcli7kRxKPsNkntZsj8iN24gtD5XcLs6WTOhtvh4KLZI1cYxea0YWRE
         eMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761303460; x=1761908260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDFcFZ4pKJmDfhD5kcDZS16NPNGgQ/ZBppEJ8jHXnMM=;
        b=WWcQLNfa58e6d5Wb7RDaQCjfDURXec+LsF+G1Zay5CW9du6x802a5aSLwl3+TBT1Kd
         uJ/RaKrFrhLfniHj5Q+IQi6TP49TBh+fvKsjLE8KWZ/Je5T5/GWrpZ7/UB5BkigzfPK8
         XlgpX1zTJi5c9bTQ7hGghX6mkJccrHwC+9TMJtZAcUuMMp6g9lCbyrRLxwZ1+jp26V4R
         u+aUg0UYmaOFcGu6tkJa8NZxtt1ysonHjIQaBf72awUXAj8h1VJCudhHn7rngol/VTXw
         MxlsIi6X6VCLlHnvfMr3gMOvvsg9U+wMyW20kBLsSAMksnqhby7zD61Tklt+nGDYdCnL
         pFBw==
X-Forwarded-Encrypted: i=1; AJvYcCUWBduUeq3BozgHEJmBqmXZcE0X4fK39HKl2qT3ptJxJB/uCqvg//hv6SoloPHoxYmTXhCkJlNVsEZjTIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+sdVD/5yeivs8lmnwDJzc1im9TWnUlYSRtgYcSWfMf8Xl76BT
	IA2XsKjIHZVnEKyVgSlO5uoqsredMkeDJd2KFiw4TE2VQ7iF7lPkfeRH
X-Gm-Gg: ASbGncuzUoZ/SMQr4u55es4RlACT5IFIsLtxMYlw1OHMPI6QCh0fZoGpiy/0AwLWc74
	3FZ9iOr8t4xWxcBRvjNU50X5bUwTPZPyUSFmgDclqs7Pb93FkLX4Racet4fXwJy+p9bXKtCn7Ru
	ZB9mE75Je+u9RUtQnqDFcsmnooMgLQb95GD3rUbdGMvybHutzp4JiFy5k8mn3PWRXir/cavPJkw
	w1XLsJuuCtR+afAirWL5ifS3GrnQGjGy0VGju4+YhsYYgmVuPO95c/TT+SrcWK024PRG9jCsnBE
	jTMg7Dfcb4wa2gvD0iDrQwAkTyY1vyvYekzxmGZvqn5OTFY2dmhnWw55Dj1UMSGbVnrXSh9eoxA
	hFm6ALtZVydspk+fEo0lm5EFL+10U1PWivMZVsJdmSMtjn2Vj1lITOuyX77JJVaLyU9BTgFmwQq
	a0BlcCcIZsKeWaqOcwMBiDdOYHaToEsb/ncBnBdRU/0/QuUoa5488Ke+Q=
X-Google-Smtp-Source: AGHT+IHBsVvWVKQ86dEKY3E3M3AXOOif5v9cuxp+oStRr36ZtlDghWUb6DPUD58X7KnPc9ZQ7pVRlA==
X-Received: by 2002:a2e:b8cb:0:b0:373:c272:d986 with SMTP id 38308e7fff4ca-378e3e7c25bmr7492661fa.17.1761303459507;
        Fri, 24 Oct 2025 03:57:39 -0700 (PDT)
Received: from [192.168.1.168] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378d67db8fesm10375671fa.38.2025.10.24.03.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 03:57:38 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Fri, 24 Oct 2025 12:56:57 +0200
Subject: [PATCH 6/6] drm/sitronix/st7571-spi: add support for SPI interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-st7571-split-v1-6-d3092b98130f@gmail.com>
References: <20251024-st7571-split-v1-0-d3092b98130f@gmail.com>
In-Reply-To: <20251024-st7571-split-v1-0-d3092b98130f@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4561;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=7feswa3GRHqUfcbWHAfsnWtSXtDiRE9nClVCJljxFI0=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBo+1uVUCBLRQNNTmG1F55tPUeRPIkdcXShQe5yA
 U7bl1NGzVyJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaPtblQAKCRCIgE5vWV1S
 MqukEACsvh+7rxk0IfAOpFbQpi7ZsmHteCI5k4fodn6kDt7bv77+NACPto26wmUA8xw9vK4yxSM
 WGjV6aanOK3hDUD4+TdIbDS5PLwD0BrPRm98l8hUjIjQ4MujVgnV6qdMnOhK1Xl5RoXpbvikiKt
 yH9h05/mG+qpKG7OV1LCLMXoEEYLR7BERpRKNdothud7u1WxKZ7JP7H1VLju7rkhBeZijvDvlgk
 Wkx3ifWNofA1aO4dOZCBvPPKZbBrfxBkwpi9AchazxAmYBYBmSRApveKn5kzZ9Gq5ppDnJ67jbA
 /sZbXfKldiM0RvK0UkQGz1y+0wCh7fGJg184/yXlFgvklTLJrAWAA5APTqYWiHW3/D/VOfzYGG8
 5/ioqcx5Kzlm6UOO+8zr8CaYp6i739l48UcXUI/nYKsz+AOZ9mQ+h6YBg4qfMoqCUQhebjThQMd
 85c7v4iZLZlRGn9cJ4V3dXiSYJxVEOtqvCHbFSLqAc3v3punSobLF+wDcTJRnWGJ4jCHV/Sa/xJ
 ZLe0o11vGUQlWVISynPuj7/p3lX4nlQh+jwDnD159xEXRYYHHWkjpDhKYW+kpMKqnxIVgFFf7c9
 oK6fvC4WyRctODKbPjzt6jKd2TYceZPB2pcSER8WvclSVj9nadqtiiAelYnLeBDEbBPJCb4+zMN
 wGkCfwfOCTjrrhQ==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Add support for ST7561/ST7571 connected to SPI bus.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 MAINTAINERS                           |  1 +
 drivers/gpu/drm/sitronix/Kconfig      | 12 ++++++
 drivers/gpu/drm/sitronix/Makefile     |  1 +
 drivers/gpu/drm/sitronix/st7571-spi.c | 75 +++++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 66e9ffb757c8bb19dbb894eb51f88f589ee83af6..c89e521cafa1d50fd94bfe7a6868c531aec1f494 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8083,6 +8083,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/sitronix,st7567.yaml
 F:	Documentation/devicetree/bindings/display/sitronix,st7571.yaml
 F:	drivers/gpu/drm/sitronix/st7571-i2c.c
+F:	drivers/gpu/drm/sitronix/st7571-spi.c
 F:	drivers/gpu/drm/sitronix/st7571.c
 F:	drivers/gpu/drm/sitronix/st7571.h
 
diff --git a/drivers/gpu/drm/sitronix/Kconfig b/drivers/gpu/drm/sitronix/Kconfig
index 0676a86661caa4ab81f226ff2e990a3e2526f74d..2204250ab4136ac2d3f18f295dc7413a6e17ed45 100644
--- a/drivers/gpu/drm/sitronix/Kconfig
+++ b/drivers/gpu/drm/sitronix/Kconfig
@@ -27,6 +27,18 @@ config DRM_ST7571_I2C
 
 	  if M is selected the module will be called st7571-i2c.
 
+config DRM_ST7571_SPI
+	tristate "DRM support for Sitronix ST7567/ST7571 display panels (SPI)"
+	depends on DRM_ST7571 && SPI
+	select REGMAP_SPI
+	help
+	  Sitronix ST7571 is a driver and controller for 4-level gray
+	  scale and monochrome dot matrix LCD panels.
+
+	  DRM driver for Sitronix ST7565/ST7571 panels connected via SPI bus.
+
+	  if M is selected the module will be called st7571-spi.
+
 config DRM_ST7586
 	tristate "DRM support for Sitronix ST7586 display panels"
 	depends on DRM && SPI
diff --git a/drivers/gpu/drm/sitronix/Makefile b/drivers/gpu/drm/sitronix/Makefile
index 8073bb776ff94de750f350b636fd9db3d54fdd46..c631e3359c3dc21ab8522b8f0cfe6e9bf0dbc011 100644
--- a/drivers/gpu/drm/sitronix/Makefile
+++ b/drivers/gpu/drm/sitronix/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_DRM_ST7571)		+= st7571.o
 obj-$(CONFIG_DRM_ST7571_I2C)		+= st7571-i2c.o
+obj-$(CONFIG_DRM_ST7571_SPI)		+= st7571-spi.o
 obj-$(CONFIG_DRM_ST7586)		+= st7586.o
 obj-$(CONFIG_DRM_ST7735R)		+= st7735r.o
diff --git a/drivers/gpu/drm/sitronix/st7571-spi.c b/drivers/gpu/drm/sitronix/st7571-spi.c
new file mode 100644
index 0000000000000000000000000000000000000000..104737ca860ce44ff411dbdd36c3a7b32a81733f
--- /dev/null
+++ b/drivers/gpu/drm/sitronix/st7571-spi.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Sitronix ST7571 connected via SPI bus.
+ *
+ * Copyright (C) 2025 Marcus Folkesson <marcus.folkesson@gmail.com>
+ */
+
+#include <linux/spi/spi.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "st7571.h"
+
+static const struct regmap_config st7571_spi_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.can_multi_write = true,
+};
+
+static int st7571_spi_probe(struct spi_device *spi)
+{
+	struct st7571_device *st7571;
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_spi(spi, &st7571_spi_regmap_config);
+	if (IS_ERR(regmap)) {
+		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
+				     "Failed to initialize regmap\n");
+	}
+
+	st7571 = st7571_probe(&spi->dev, regmap);
+	if (IS_ERR(st7571))
+		return dev_err_probe(&spi->dev, PTR_ERR(st7571),
+				     "Failed to initialize regmap\n");
+
+	spi_set_drvdata(spi, st7571);
+	return 0;
+}
+
+static void st7571_spi_remove(struct spi_device *spi)
+{
+	struct st7571_device *st7571 = spi_get_drvdata(spi);
+
+	st7571_remove(st7571);
+}
+
+static const struct of_device_id st7571_of_match[] = {
+	{ .compatible = "sitronix,st7567", .data = &st7567_config },
+	{ .compatible = "sitronix,st7571", .data = &st7571_config },
+	{},
+};
+MODULE_DEVICE_TABLE(of, st7571_of_match);
+
+static const struct spi_device_id st7571_spi_id[] = {
+	{ "st7567", 0 },
+	{ "st7571", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, st7571_spi_id);
+
+static struct spi_driver st7571_spi_driver = {
+	.driver = {
+		.name = "st7571-spi",
+		.of_match_table = st7571_of_match,
+	},
+	.probe = st7571_spi_probe,
+	.remove = st7571_spi_remove,
+	.id_table = st7571_spi_id,
+};
+
+module_spi_driver(st7571_spi_driver);
+
+MODULE_AUTHOR("Marcus Folkesson <marcus.folkesson@gmail.com>");
+MODULE_DESCRIPTION("DRM Driver for Sitronix ST7571 LCD controller (SPI)");
+MODULE_LICENSE("GPL");

-- 
2.50.1


