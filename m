Return-Path: <linux-kernel+bounces-630575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C93AA7C01
	for <lists+linux-kernel@lfdr.de>; Sat,  3 May 2025 00:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680C43BEBA8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 22:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93236221287;
	Fri,  2 May 2025 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6abRlPm"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218C921D3D0;
	Fri,  2 May 2025 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746223498; cv=none; b=f1pcLbr3nGvs72xvFf7UByaoEXEYWhZ9jHdB8M0zqOzrSCZlmLVhcn2x4m8ZktOUJovrL6fDV06GhF/NaGgbzAr1MMk5V8ICGDrnAX062QgkCnhssZfvOcPn83YwmxCcsf0sdvtzKGg/doUF15of/I2nhIFb9o7JnOYayhd9deA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746223498; c=relaxed/simple;
	bh=2eWns/mvd2DOjO4WQsDwacWvY07f8ZzkBblZGzu9jjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i7sYETv9KCtVIJJGzZxeYuyNIXwoX6jXZfOp86fW6Ch03v5G/XNaeR3oU3+YCm6O3sLM0xioHM3DBm3IkNgGqOfn2ulb7mhL+iuFlGRO5fNuq3SNJzKnYG250OD8vrkh8Ylg+xdT7W+iHob9dMz5qEbNwygJ0hlHyTCKZt66ZcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6abRlPm; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73712952e1cso2769780b3a.1;
        Fri, 02 May 2025 15:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746223496; x=1746828296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LqT9icyH5L3HVEZ++wzzfeTDQafQM9FU6JdKrhZWgZg=;
        b=O6abRlPmkwyQTMcPxDdIx2gt3NuIw+ws/gF5B86DGOfQj8W6ul3VMCQCLUA2vN+VQj
         RLBARQCq4K75MwsZ3/N/NvySaSe0sb51j/EbkkjCXLXhwqfUqjymPYpMsqHLJP69viwe
         ThlMk2NTKZLorUBP/iwpBrJQ27ePhD8hNhgvbGVsu+jdiI3IYy8GooYtB2kNMXTO4mh8
         njC+Q+tBBDoYP+F/sNtMdEqdIq32h8eCOMYUqLLVrLIeO796GICB1RPjCjphdRjUK+ld
         rwTZzboB7HOXUzcB9mLSahi3OhW306lOuVdtWmzY9GfpPHPa5fABIO28skYjclcyUHDB
         zd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746223496; x=1746828296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqT9icyH5L3HVEZ++wzzfeTDQafQM9FU6JdKrhZWgZg=;
        b=U4q7MwSVOwqlo6Cc/xTl/pcFynyWEh79nHfAK26hiH+Fh2weqSrRxfTBf7nwXLq8Ir
         q9ZC/G/eofPDTJYrKUdKdwJk1q8AlMS+rUhRGaLa76LHvd73ucA4mxc2QAb39V/3Krcw
         zYCFf4+Y5TxfdS8X21Mhx6353Z/N1PGwPMc29+NCQ9Od1xgBOJ23hR7lDEzQYCInHlQl
         PlBtMLBjtTKXX386551320wIysJdhfhWoLaZIep9SVNUhZMbh56c5yhmDs8IikozuwS7
         ylj+LuXhqPewujx4tgIGGzMx1eFJNka58gfXZB2coFN9ACdlD9WukRxA0/xRVJ+abR5D
         1qeg==
X-Forwarded-Encrypted: i=1; AJvYcCX89u9WmgGVweZgLdme+DpZLusuiOpdggnD5PF87cTcXRyew6Enx8+hrfszUCVcoPkY524D+zozK+4Fo1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqotm5zWo+iuD211nDgtZsPI2G07qu8+Q/SHYwoOITEDRqno2y
	61QmUnbvroJ9l97t23Tjfwu7jvPZXgKV9fz9SuVkxafGcx/IPkeX
X-Gm-Gg: ASbGnctA2kE9rboSfx0WZrR+svXIHHw0f1izp9051Iok4zv/mlk7BO6KOg3htRo+3lb
	uQ5fRu6UY0mGHacL3GD7QFbZQpHplt60m/a7dpN0iIcL0s1fXoiePWb9sEf2TM66lxCpG7k8i8Y
	gw0zsdOXl6V4tbHwR8F3lAdnEFu0cEALTG/xmtXYO+hWbKMjklw8y0YRu8ztoGEZeXkRcHTYPu5
	LogL3NssT9bzt4zJd4+SHd6y7Sngi7iUV33EV3My5ZADN9/mfoIV5KawPaWL5v7k72jdujPyE5c
	VQSrN8vbjBRMQGbcslzVYsTDj+/tep8nZhhxot0d3zr0stYCwJUW
X-Google-Smtp-Source: AGHT+IFrsZgXwTb+o3P5NX+EcspzU3ZXTnhUP6GZ8J8b0ioO7HZutoa08ad7NnCqnvC4OrqAm97JVw==
X-Received: by 2002:a05:6a20:ce44:b0:1f5:8179:4f47 with SMTP id adf61e73a8af0-20cdef3aa2cmr6376196637.20.1746223496252;
        Fri, 02 May 2025 15:04:56 -0700 (PDT)
Received: from NB-GIGA003.letovo.school ([5.194.95.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3c48ac4sm1301153a12.55.2025.05.02.15.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 15:04:55 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Sat, 03 May 2025 02:04:24 +0400
Subject: [PATCH v2 2/3] soc: Add VIA/WonderMedia SoC identification driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250503-wmt-soc-driver-v2-2-8c774ad84d47@gmail.com>
References: <20250503-wmt-soc-driver-v2-0-8c774ad84d47@gmail.com>
In-Reply-To: <20250503-wmt-soc-driver-v2-0-8c774ad84d47@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746223484; l=6618;
 i=alchark@gmail.com; s=20250416; h=from:subject:message-id;
 bh=2eWns/mvd2DOjO4WQsDwacWvY07f8ZzkBblZGzu9jjc=;
 b=Bnp6OOMBfrpLigSGh22fhgwfwPkaSR7MmvfXDPmHB6JuD+mXwQurmZO4vWH3p0k1JpTRP5FEf
 NjSqzmg4TSHD6W/oXQjy49ZTh5uz6uHwtHRPNtDuUdGkTEVVG/Ay4RT
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=ltKbQzKLTJPiDgPtcHxdo+dzFthCCMtC3V9qf7+0rkc=

Add a small SOC bus driver to parse the chip ID and revision made
available on VIA/WonderMedia SoCs via their system configuration
controller's SCC_ID register.

This is intended to select appropriate sets of on-chip device quirks
at runtime, as it has been found that even within the same SoC
version there can be register-incompatible differences, such as
with the SDMMC controller on WM8505 rev. A0-A1 vs. rev. A2.

The list of SoC versions is compiled from various vendor source dumps
and not all of them have corresponding mainline driver support.
Some of them also have been seen with varying on-chip markings while
sharing the same hardware chip ID's (as is the case with e.g. WM8850
vs. WM8950). In such cases the selection of names to use here among
those seen in various source dumps and chip markings was arbitrary.

Suggested by Krzysztof at [1] - thanks a lot!

[1] https://lore.kernel.org/all/14de236b-e2a7-4bde-986d-1e5ffddd01b4@kernel.org/

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 drivers/soc/Kconfig              |   1 +
 drivers/soc/Makefile             |   1 +
 drivers/soc/vt8500/Kconfig       |  20 +++++++
 drivers/soc/vt8500/Makefile      |   2 +
 drivers/soc/vt8500/wmt-socinfo.c | 125 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 149 insertions(+)

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 6a8daeb8c4b96cd29d56343b338a423140b89896..37ca3f094f8994c7e9c7c99c3ba47d168d41ce30 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -28,6 +28,7 @@ source "drivers/soc/tegra/Kconfig"
 source "drivers/soc/ti/Kconfig"
 source "drivers/soc/ux500/Kconfig"
 source "drivers/soc/versatile/Kconfig"
+source "drivers/soc/vt8500/Kconfig"
 source "drivers/soc/xilinx/Kconfig"
 
 endmenu
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 2037a8695cb2898659a434803dcdfa2d95b1dbd6..777255401252eab554f56bded7ff8ea5611704bf 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -34,4 +34,5 @@ obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-y				+= ti/
 obj-$(CONFIG_ARCH_U8500)	+= ux500/
 obj-y				+= versatile/
+obj-y				+= vt8500/
 obj-y				+= xilinx/
diff --git a/drivers/soc/vt8500/Kconfig b/drivers/soc/vt8500/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..2b2350678c3f70297c51f94eb77674c01be773d8
--- /dev/null
+++ b/drivers/soc/vt8500/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+if ARCH_VT8500 || COMPILE_TEST
+
+menu "VIA/WonderMedia SoC drivers"
+
+config WMT_SOCINFO
+	bool "VIA/WonderMedia SoC Information driver"
+	default ARCH_VT8500
+	select SOC_BUS
+	default ARCH_VT8500
+	help
+	  Say yes to support decoding of VIA/WonderMedia system configuration
+	  register information. This currently includes just the chip ID register
+	  which helps identify the exact hardware revision of the SoC the kernel
+	  is running on (to know if any revision-specific quirks are required)
+
+endmenu
+
+endif
diff --git a/drivers/soc/vt8500/Makefile b/drivers/soc/vt8500/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..05964c5f2890989c1d794af4f5af10f849a497bc
--- /dev/null
+++ b/drivers/soc/vt8500/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_WMT_SOCINFO)	+= wmt-socinfo.o
diff --git a/drivers/soc/vt8500/wmt-socinfo.c b/drivers/soc/vt8500/wmt-socinfo.c
new file mode 100644
index 0000000000000000000000000000000000000000..461f8c1ae56ee367dc2c84a58ff8fada0dfdaed0
--- /dev/null
+++ b/drivers/soc/vt8500/wmt-socinfo.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2025 Alexey Charkov <alchark@gmail.com>
+ * Based on aspeed-socinfo.c
+ */
+
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/sys_soc.h>
+
+static const struct {
+	const char *name;
+	const u32 id;
+} chip_id_table[] = {
+	/* VIA */
+	{ "VT8420", 0x3300 },
+	{ "VT8430", 0x3357 },
+	{ "VT8500", 0x3400 },
+
+	/* WonderMedia */
+	{ "WM8425", 0x3429 },
+	{ "WM8435", 0x3437 },
+	{ "WM8440", 0x3451 },
+	{ "WM8505", 0x3426 },
+	{ "WM8650", 0x3465 },
+	{ "WM8750", 0x3445 },
+	{ "WM8850", 0x3481 },
+	{ "WM8880", 0x3498 },
+};
+
+static const char *sccid_to_name(u32 sccid)
+{
+	u32 id = sccid >> 16;
+	unsigned int i;
+
+	for (i = 0 ; i < ARRAY_SIZE(chip_id_table) ; ++i) {
+		if (chip_id_table[i].id == id)
+			return chip_id_table[i].name;
+	}
+
+	return "Unknown";
+}
+
+static int wmt_socinfo_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct soc_device_attribute *attrs;
+	struct soc_device *soc_dev;
+	char letter, digit;
+	void __iomem *reg;
+	u32 sccid;
+
+	reg = devm_of_iomap(&pdev->dev, np, 0, NULL);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	sccid = readl(reg);
+
+	attrs = devm_kzalloc(&pdev->dev, sizeof(*attrs), GFP_KERNEL);
+	if (!attrs)
+		return -ENOMEM;
+
+	/*
+	 * Machine: VIA APC Rock
+	 * Family: WM8850
+	 * Revision: A2
+	 * SoC ID: raw silicon revision id (34810103 in hexadecimal)
+	 */
+
+	attrs->family = sccid_to_name(sccid);
+
+	letter = (sccid >> 8) & 0xf;
+	letter = (letter - 1) + 'A';
+	digit = sccid & 0xff;
+	digit = (digit - 1) + '0';
+	attrs->revision = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+					 "%c%c", letter, digit);
+
+	attrs->soc_id = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%08x", sccid);
+
+	if (!attrs->revision || !attrs->soc_id)
+		return -ENOMEM;
+
+	soc_dev = soc_device_register(attrs);
+	if (IS_ERR(soc_dev))
+		return PTR_ERR(soc_dev);
+
+	dev_info(&pdev->dev,
+		 "VIA/WonderMedia %s rev %s (%s)\n",
+		 attrs->family,
+		 attrs->revision,
+		 attrs->soc_id);
+
+	platform_set_drvdata(pdev, soc_dev);
+	return 0;
+}
+
+static void wmt_socinfo_remove(struct platform_device *pdev)
+{
+	struct soc_device *soc_dev = platform_get_drvdata(pdev);
+
+	soc_device_unregister(soc_dev);
+}
+
+static const struct of_device_id wmt_socinfo_ids[] = {
+	{ .compatible = "via,vt8500-scc-id" },
+	{ /* Sentinel */ },
+};
+
+static struct platform_driver wmt_socinfo = {
+	.probe = wmt_socinfo_probe,
+	.remove = wmt_socinfo_remove,
+	.driver = {
+		.name = "wmt-socinfo",
+		.of_match_table = wmt_socinfo_ids,
+	},
+};
+module_platform_driver(wmt_socinfo);
+
+MODULE_AUTHOR("Alexey Charkov <alchark@gmail.com>");
+MODULE_DESCRIPTION("VIA/WonderMedia socinfo driver");
+MODULE_LICENSE("GPL");

-- 
2.49.0


