Return-Path: <linux-kernel+bounces-771932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5656B28D00
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CEB91CC7F35
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F08828F51E;
	Sat, 16 Aug 2025 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BqVGZzgr"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8804928D8E7
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755341235; cv=none; b=J6RK8lbMNKk1ncliGrZ38befb6XDRVf/Tb24p7plfmvI7Q+tevwQ2S8OGtJShD8vpXb4/279jw2D89howAz7HDDA4aeC6DcGvOyK9eF6LXGQPYskgiNXprRS8fe095UB6YEeMUHD6l0IDj01b37xIKITxx7qNJkCN/AZwhaMeaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755341235; c=relaxed/simple;
	bh=tWyAd0cZ03IZEBAuNWRUIKux4ADyQl9LjF6AgtlSFUc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsdZLyH+vZ3nvKrqO263iDrWbSXzw1P7LAgtYE9c5PoTUpapgtu/UgsxBe+vYssC6hBgPIFdWqyWn3OlOUCSfAU4x5nEFH6Ad5ciqwE/pcfMEYkgsstFEtqXETTcZzEHpXWXy9Dn9v9734j6nCCBR2jirN0NBVOkyqebul+bJj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BqVGZzgr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b0c52f3so12484075e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 03:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755341232; x=1755946032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O0EsZbS7Pdfu11/9br7WdLrAZUIPhOlPEij0j0r+2yA=;
        b=BqVGZzgrvFqSCCad0OMBbJxdAGI32Ik6d/6Yg7cOytunXsW+mBsl+uop9DrIGe24uM
         N25PuS4kICvQq8V0cOaNVcbtKf3YjUHu9TrjfjCMvwt4ktHDMHg7OaPwz1PqFS2e8X/N
         zGrW3IG5QT8R+1slGEyO2l/pugLxT9jqodRhyUd9z8prFaBjfi+dDM6TIWSVNiaWN/5X
         3vgNSMF7/ycTs3xK2q193LaXil2K+M2P3SeWsDMhF0O4RuoWMm7UPMOledxtNq0oXXC7
         2pOPVs4qc07rrxW3rAnSEyRYpdhgYz3f7TLzG0V7ELNihq9UbEypPBMioVrHMFKwhkVl
         gH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755341232; x=1755946032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0EsZbS7Pdfu11/9br7WdLrAZUIPhOlPEij0j0r+2yA=;
        b=c+9vAfhXnslvsZu+FMwW3WUJyp7DSX/eIXEiUp7+SiqUvmkCE4M861vRcJSvNiEfve
         NeAIrTV7pu3mwcQDA31I7bUsnYGZTxI06WM0PsKs9e76lY2ybPn6UKzyrBwvnnpq28BS
         NhbyAfHRHBcVPSyBVmUQEFEPQTOC7bg6X8cxmAUAJR7kZ/LgA17ZJsyFQ8JkuXfHhPgZ
         ijDjSWijkf7skPeuBHaML18pIAEP5obq54s/i8u/k8pKAfjpTNfEMJIIW0K/TIShLX6U
         lJ8a+JM/H60OwKxAeQCv7JpGn823orTQgoS25x9J2lGBq5V+j+HVhnDhlSAozUuf2gqm
         sPWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUieB7IoT9ORaal9BREVasc82uVvm+/h/sKuRwvNFTjfb0MFBnx2Wd3xx5KGgXPNYYQ1F2/aUqModiiVkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgBh8z6Odtb+2oNhWicup15pp0fi8C4DV+RhCIV5frIMJxXXp0
	NMI3tMJk4ElWXPpLDj6WP7BHrmwvUpi+EvwIYErlAT+yT8BezjTPSBvylr64ExdN5TAloWAetwL
	aPkVT
X-Gm-Gg: ASbGncs7L9bDizSLfr/EqlezjFh/GChc55fffjo5GTgV1byI440iovsBabQPhp6KnzY
	NFbIYYb6JKpgVRCehDqaS9L5W/f1VtbhH9zk83JanS3iJlSyE8EIv5q8L7oIE6wnrtn0iE+bxaJ
	+bjmzcvrQIoX13bFPs41xuXxPdATFdD6xqSFMmmXkqPkAlHpc2/vLO+VnudFsQjzTw8nNKUzWbv
	edbO/yc9JYJt70Fu1exoVxZy3gguoTxXNLA7jb6LGi41hHQ33s0TvKc4y9WhTTVy5tyAh643c5o
	fERTNRai6H3V2mgM3WcEqaiMzYxwXwb7hAvMfuQGVwWi1UkYOgFGhSvsRqbKflvZ4+eaqbXofi6
	VevxwjJg5PgT9Mk9sTYJ4Fnt+tfbXZsImmdK2fHtulYW9J8HF
X-Google-Smtp-Source: AGHT+IGOMpu4wUjkEx3XshxL9BZQiBE5SLRdLrL5tK7/TsE3Z1G3PwjF5NCTsizktKsog+IO8+bE2A==
X-Received: by 2002:a05:600c:8010:b0:459:d616:25c5 with SMTP id 5b1f17b1804b1-45a267496cbmr19101085e9.12.1755341231825;
        Sat, 16 Aug 2025 03:47:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a25c13696sm32275975e9.25.2025.08.16.03.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 03:47:11 -0700 (PDT)
From: Ciprian Costea <dan.carpenter@linaro.org>
X-Google-Original-From: Ciprian Costea <ciprianmarian.costea@nxp.com>
Date: Sat, 16 Aug 2025 13:47:08 +0300
To: Srinivas Kandagatla <srini@kernel.org>
Cc: linaro-s32@linaro.org, NXP S32 Linux Team <s32@nxp.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] nvmem: s32g-ocotp: Add driver for S32G OCOTP
Message-ID: <7e1f16bf09e77afef4cc5fa609a6c3ad820bb14c.1755341000.git.dan.carpenter@linaro.org>
References: <cover.1755341000.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755341000.git.dan.carpenter@linaro.org>

Provide access to the On Chip One-Time Programmable Controller (OCOTP)
pages on the NXP S32G platform.

Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
Co-developed-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/nvmem/Kconfig            |  10 ++
 drivers/nvmem/Makefile           |   2 +
 drivers/nvmem/s32g-ocotp-nvmem.c | 171 +++++++++++++++++++++++++++++++
 3 files changed, 183 insertions(+)
 create mode 100644 drivers/nvmem/s32g-ocotp-nvmem.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index edd811444ce5..6a1cafa74e36 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -314,6 +314,16 @@ config NVMEM_ROCKCHIP_OTP
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem_rockchip_otp.
 
+config NVMEM_S32G_OCOTP
+	tristate "S32G SoC OCOTP support"
+	depends on ARCH_S32
+	help
+	  This is a driver for the On Chip One-Time Programmable controller
+	  (OCOTP) available on S32G platforms.
+
+	  If you say Y here, you will get support for the One Time
+	  Programmable memory pages.
+
 config NVMEM_SC27XX_EFUSE
 	tristate "Spreadtrum SC27XX eFuse Support"
 	depends on MFD_SC27XX_PMIC || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 2021d59688db..b7bfa78af8f3 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -64,6 +64,8 @@ obj-$(CONFIG_NVMEM_ROCKCHIP_EFUSE)	+= nvmem_rockchip_efuse.o
 nvmem_rockchip_efuse-y			:= rockchip-efuse.o
 obj-$(CONFIG_NVMEM_ROCKCHIP_OTP)	+= nvmem-rockchip-otp.o
 nvmem-rockchip-otp-y			:= rockchip-otp.o
+obj-$(CONFIG_NVMEM_S32G_OCOTP)		+= nvmem-s32g-ocotp-nvmem.o
+nvmem-s32g-ocotp-nvmem-y		:= s32g-ocotp-nvmem.o
 obj-$(CONFIG_NVMEM_SC27XX_EFUSE)	+= nvmem-sc27xx-efuse.o
 nvmem-sc27xx-efuse-y			:= sc27xx-efuse.o
 obj-$(CONFIG_NVMEM_SNVS_LPGPR)		+= nvmem_snvs_lpgpr.o
diff --git a/drivers/nvmem/s32g-ocotp-nvmem.c b/drivers/nvmem/s32g-ocotp-nvmem.c
new file mode 100644
index 000000000000..37355bd83b17
--- /dev/null
+++ b/drivers/nvmem/s32g-ocotp-nvmem.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023-2025 NXP
+ */
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#define S32G_OCOTP_BANK_OFFSET	512u
+#define S32G_OCOTP_BANK_SIZE	32u
+#define S32G_OCOTP_WORD_SIZE	4u
+
+struct s32g_fuse {
+	u8 bank;
+	u8 words_mask;
+};
+
+struct s32g_fuse_map {
+	const struct s32g_fuse *map;
+	size_t n_entries;
+};
+
+struct s32g_ocotp_priv {
+	struct device *dev;
+	void __iomem *base;
+	const struct s32g_fuse_map *fuse;
+};
+
+static const struct s32g_fuse s32g_map[] = {
+	{ .bank = 0,  .words_mask = GENMASK(6, 2) },
+	{ .bank = 1,  .words_mask = GENMASK(7, 5) },
+	{ .bank = 2,  .words_mask = GENMASK(1, 0) },
+	{ .bank = 2,  .words_mask = GENMASK(4, 2) },
+	{ .bank = 4,  .words_mask = BIT(6) },
+	{ .bank = 5,  .words_mask = BIT(1) },
+	{ .bank = 5,  .words_mask = BIT(2) },
+	{ .bank = 6,  .words_mask = BIT(7) },
+	{ .bank = 7,  .words_mask = GENMASK(1, 0) },
+	{ .bank = 11, .words_mask = GENMASK(5, 0) },
+	{ .bank = 11, .words_mask = GENMASK(7, 6) },
+	{ .bank = 12, .words_mask = GENMASK(2, 0) },
+	{ .bank = 12, .words_mask = BIT(7) },
+	{ .bank = 13, .words_mask = GENMASK(4, 2) },
+	{ .bank = 14, .words_mask = BIT(1) | BIT(4) | BIT(5) },
+	{ .bank = 15, .words_mask = GENMASK(7, 5) },
+};
+
+static const struct s32g_fuse_map s32g_fuse_map = {
+	.map = s32g_map,
+	.n_entries = ARRAY_SIZE(s32g_map),
+};
+
+static const struct of_device_id ocotp_of_match[] = {
+	{ .compatible = "nxp,s32g2-ocotp", .data = &s32g_fuse_map},
+	{ /* sentinel */ }
+};
+
+static u32 get_bank_index(unsigned int offset)
+{
+	return (offset - S32G_OCOTP_BANK_OFFSET) / S32G_OCOTP_BANK_SIZE;
+}
+
+static u32 get_word_index(unsigned int offset)
+{
+	return offset % S32G_OCOTP_BANK_SIZE / S32G_OCOTP_WORD_SIZE;
+}
+
+static bool is_valid_word(struct s32g_ocotp_priv *s32g_data,
+			  unsigned int offset, int bytes)
+{
+	const struct s32g_fuse_map *fuse = s32g_data->fuse;
+	u32 bank, word;
+	size_t i;
+
+	if (offset < S32G_OCOTP_BANK_OFFSET)
+		return false;
+
+	if (bytes != S32G_OCOTP_WORD_SIZE)
+		return false;
+
+	bank = get_bank_index(offset);
+	word = get_word_index(offset);
+	if (bank >= fuse->n_entries)
+		return false;
+
+	for (i = 0; i < fuse->n_entries; i++) {
+		if (fuse->map[i].bank == bank &&
+		    fuse->map[i].words_mask & BIT(word))
+			return true;
+	}
+	return false;
+}
+
+static int s32g_ocotp_read(void *context, unsigned int offset,
+			    void *val, size_t bytes)
+{
+	struct s32g_ocotp_priv *s32g_data = context;
+
+	if (!is_valid_word(s32g_data, offset, bytes))
+		return -EINVAL;
+
+	/* Read from Fuse OCOTP Shadow registers */
+	*(u32 *)val = ioread32(s32g_data->base + offset);
+
+	return 0;
+}
+
+static struct nvmem_config s32g_ocotp_nvmem_config = {
+	.name = "s32g-ocotp",
+	.add_legacy_fixed_of_cells = true,
+	.read_only = true,
+	.word_size = S32G_OCOTP_WORD_SIZE,
+	.reg_read = s32g_ocotp_read,
+};
+
+static int s32g_ocotp_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *of_matched_dt_id;
+	struct s32g_ocotp_priv *s32g_data;
+	struct device *dev = &pdev->dev;
+	struct nvmem_device *nvmem;
+	struct resource *res;
+
+	of_matched_dt_id = of_match_device(ocotp_of_match, dev);
+	if (!of_matched_dt_id) {
+		dev_err(dev, "Unable to find driver data.\n");
+		return -ENODEV;
+	}
+
+	s32g_data = devm_kzalloc(dev, sizeof(*s32g_data), GFP_KERNEL);
+	if (!s32g_data)
+		return -ENOMEM;
+
+	s32g_data->fuse = of_device_get_match_data(dev);
+	if (!s32g_data->fuse) {
+		dev_err(dev, "Cannot find platform device data.\n");
+		return -ENODEV;
+	}
+
+	s32g_data->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(s32g_data->base)) {
+		dev_err(dev, "Cannot map OCOTP device.\n");
+		return PTR_ERR(s32g_data->base);
+	}
+
+	s32g_data->dev = dev;
+	s32g_ocotp_nvmem_config.dev = dev;
+	s32g_ocotp_nvmem_config.priv = s32g_data;
+	s32g_ocotp_nvmem_config.size = resource_size(res);
+
+	nvmem = devm_nvmem_register(dev, &s32g_ocotp_nvmem_config);
+
+	return PTR_ERR_OR_ZERO(nvmem);
+}
+
+static struct platform_driver s32g_ocotp_driver = {
+	.probe = s32g_ocotp_probe,
+	.driver = {
+		.name = "s32g-ocotp",
+		.of_match_table = ocotp_of_match,
+	},
+};
+module_platform_driver(s32g_ocotp_driver);
+MODULE_AUTHOR("NXP");
+MODULE_DESCRIPTION("S32G OCOTP driver");
+MODULE_LICENSE("GPL");
-- 
2.47.2


