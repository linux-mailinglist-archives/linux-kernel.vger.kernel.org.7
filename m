Return-Path: <linux-kernel+bounces-805903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9C2B48F17
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1AEF3BA3BC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EE530B52E;
	Mon,  8 Sep 2025 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ByGNdKfX"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA0E30AD0F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337184; cv=none; b=agoyDbdiG9ik/86NGj9wOOq0Do166JBaD/7BIVNWcrx1L1GEB0ytjgEKwxnYAPoQPVHk+pgTTMy4aXJNeCfmpDgvO7fykSilk3tDETzfnYZqSEUzonQv9jwDi9Fp5VIGZbWcGuNdbclX3StH+P27Un0TLAOAUnG7x/3IVDRtdss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337184; c=relaxed/simple;
	bh=WEYCc0m08cozmqjakGvBtMPbDEIfLlrQSlYRfrXgnOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lHI8DmaqZSZ1MVJlCZddRobm5zhszSe9KOwWsF6dcHBrn1SPj7F25qmvGU8+Bdee8XwABeSvxHgh8sVGqYVeEPEWQtygeaYha+ikYYHTP2H37XGpYTn+Zele+6kTMx2n8hAI2BglKuj/nbHtu7NMqCzrsoyKd9ushYJUvJdcyps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ByGNdKfX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45de6490e74so9025375e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 06:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757337181; x=1757941981; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axRyto/ISVMntXEL3ZXAISR7Gp0i8a/1nJ0/ZHfbjHA=;
        b=ByGNdKfXgtDkG0zJ8yQPHzOlSjpTRpP13jULcOhsqoRRYfSDQKRCy9J3TfzxX0uKZX
         8QtJ6W89cJqey3Vsfd/dAQMnNnAcfm8PAx4YnzyflL+g0BMjHnvcKOCAnhDTImLHed8j
         pNPg5E/VO4jM52ZrS0YxZo0pIzCFJIenQOC5o4FH7KMqGkHza/8pjVip2143kZz+O8kh
         EIvpqRtC+AYAhMydil7+uWGGAekJNuoLu+31h39zB2WM6IUHG5TtJ4uk72+OuK91T/vS
         wPkfkRlLVJb5wz9Fx6XuYfolWmp1sU0ajfn0oMf5XLvGXyhvoOU0MPRg/8869hmzdz0E
         0D4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757337181; x=1757941981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axRyto/ISVMntXEL3ZXAISR7Gp0i8a/1nJ0/ZHfbjHA=;
        b=R68k8yyW3gkEsh4ZNY/xEkVHdF9EDLSQ3Xuy/yAwAZW6zqY/H4BhQm47GqCqa6FtWP
         ZbOeavpAqKE++2Awvd6l4/G3H4TswRwOCbsmRqsT4SMWm5RK/FYyQ31xc+Wi47WC76AW
         QvSyqpjLewCjUGBdRAvQE6w/EYiv8tk7BKQ4ELePC+J0vbd8Fb6v0J5N33W7c2THVMFn
         yhUHpixPD7X0mWxHgDG+qWirn6wU9C5uLPIAmmGX+uU8xTNtMd+C4JC2hFGc52wAKVT/
         estu87KRrvcJgsaMpDHs/OsKOUKld2ZfbV3il4OgAGiSP6iLt+c8CWprLpcP4CRRi+x7
         SiVQ==
X-Gm-Message-State: AOJu0YyH8isGntF4s3vdCGQ90f/SqiqTD5FV/HrmfxBlpn3so/Px23L2
	Solq+8rS6Ob1OUVTOyrmK6TqUQlVw8WttrdBiAf7/Nxhxo0sfHb+aQArsf9xNbHeRN4=
X-Gm-Gg: ASbGncvcIp6GZ6B//diu2Fka3w+cit2T83r3tNlydEJD1xwOi+JAPNQLeVc4987KMlm
	IoVzfESDvsJGhu6rAN3ZWs1vfgPlgYxLEu2IJ62ykMy/giA0qERUEE70K5GTO5r/rz8unXWtbkZ
	SkKdayrnRtZERe4ipf4Ee4wF4GfT0VsfYBo93nmLscVLgUPZRW8K7VQuCzkcZLxOMVqtWMuUqWv
	B+at1d8Jmhljgrq/aEPbfKBOLRaOMCyyaWhwGCnjNuphKxMytGiX7WYDprRPjVEya2Io/5yJah1
	wSgkIpB/q9jLD3wBeUuwt35vD2FKAYjISZmgooGJamstLw24Ob7BKIkdD1P3H48LcXomwr9ceOu
	fz51FJNtrlJYfWzWgtMTRHpAraTXdH00qQmtRTwOyju+IUuSycU8uZdSQV2m/LgKAgDWLQu6240
	YFpA+s5IjHXcd2
X-Google-Smtp-Source: AGHT+IGwIG5gbqEOa/X2dR0JZvfb5YQB2PpmEsolXTUv2RvpCoxPAS94Oqup7vYXB9W/8UsdI1FEOQ==
X-Received: by 2002:a05:600c:1390:b0:45d:da7c:b36 with SMTP id 5b1f17b1804b1-45ddded7614mr64813635e9.19.1757337180651;
        Mon, 08 Sep 2025 06:13:00 -0700 (PDT)
Received: from ta2.c.googlers.com (219.43.233.35.bc.googleusercontent.com. [35.233.43.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb9dbfsm41650181f8f.43.2025.09.08.06.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 06:13:00 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 08 Sep 2025 13:12:43 +0000
Subject: [PATCH v4 2/5] firmware: exynos-acpm: add DVFS protocol
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-acpm-clk-v4-2-633350c0c0b1@linaro.org>
References: <20250908-acpm-clk-v4-0-633350c0c0b1@linaro.org>
In-Reply-To: <20250908-acpm-clk-v4-0-633350c0c0b1@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757337178; l=6599;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=WEYCc0m08cozmqjakGvBtMPbDEIfLlrQSlYRfrXgnOA=;
 b=IEHGUjctdjN/UA7r9A7/JSWgbrBpcnXg/M4EDFmiviwzFAkzy2IwstmPk9jHaEZ002lkTifxM
 LS63Zr3LLjUBR3cFHkPES+5ETiie9FZsaF2sD6M7cTD/QP//jbcxPp3
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add ACPM DVFS protocol handler. It constructs DVFS messages that
the APM firmware can understand.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/Makefile                  |  4 +-
 drivers/firmware/samsung/exynos-acpm-dvfs.c        | 83 ++++++++++++++++++++++
 drivers/firmware/samsung/exynos-acpm-dvfs.h        | 21 ++++++
 drivers/firmware/samsung/exynos-acpm.c             |  5 ++
 .../linux/firmware/samsung/exynos-acpm-protocol.h  | 10 +++
 5 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/samsung/Makefile b/drivers/firmware/samsung/Makefile
index 7b4c9f6f34f54fd731886d97a615fe1aa97ba9a0..80d4f89b33a9558b68c9083da675c70ec3d05f19 100644
--- a/drivers/firmware/samsung/Makefile
+++ b/drivers/firmware/samsung/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-acpm-protocol-objs			:= exynos-acpm.o exynos-acpm-pmic.o
+acpm-protocol-objs			:= exynos-acpm.o
+acpm-protocol-objs			+= exynos-acpm-pmic.o
+acpm-protocol-objs			+= exynos-acpm-dvfs.o
 obj-$(CONFIG_EXYNOS_ACPM_PROTOCOL)	+= acpm-protocol.o
diff --git a/drivers/firmware/samsung/exynos-acpm-dvfs.c b/drivers/firmware/samsung/exynos-acpm-dvfs.c
new file mode 100644
index 0000000000000000000000000000000000000000..a8763bf9374d41952a8d26124cc77baae0f1c723
--- /dev/null
+++ b/drivers/firmware/samsung/exynos-acpm-dvfs.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2020 Samsung Electronics Co., Ltd.
+ * Copyright 2020 Google LLC.
+ * Copyright 2025 Linaro Ltd.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/firmware/samsung/exynos-acpm-protocol.h>
+#include <linux/ktime.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include "exynos-acpm.h"
+#include "exynos-acpm-dvfs.h"
+
+#define ACPM_DVFS_ID			GENMASK(11, 0)
+#define ACPM_DVFS_REQ_TYPE		GENMASK(15, 0)
+
+#define ACPM_DVFS_FREQ_REQ		0
+#define ACPM_DVFS_FREQ_GET		1
+
+static void acpm_dvfs_set_xfer(struct acpm_xfer *xfer, u32 *cmd, size_t cmdlen,
+			       unsigned int acpm_chan_id, bool response)
+{
+	xfer->acpm_chan_id = acpm_chan_id;
+	xfer->txd = cmd;
+	xfer->txlen = cmdlen;
+
+	if (response) {
+		xfer->rxd = cmd;
+		xfer->rxlen = cmdlen;
+	}
+}
+
+static void acpm_dvfs_init_set_rate_cmd(u32 cmd[4], unsigned int clk_id,
+					unsigned long rate)
+{
+	cmd[0] = FIELD_PREP(ACPM_DVFS_ID, clk_id);
+	cmd[1] = rate / HZ_PER_KHZ;
+	cmd[2] = FIELD_PREP(ACPM_DVFS_REQ_TYPE, ACPM_DVFS_FREQ_REQ);
+	cmd[3] = ktime_to_ms(ktime_get());
+}
+
+int acpm_dvfs_set_rate(const struct acpm_handle *handle,
+		       unsigned int acpm_chan_id, unsigned int clk_id,
+		       unsigned long rate)
+{
+	struct acpm_xfer xfer = {0};
+	u32 cmd[4];
+
+	acpm_dvfs_init_set_rate_cmd(cmd, clk_id, rate);
+	acpm_dvfs_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id, false);
+
+	return acpm_do_xfer(handle, &xfer);
+}
+
+static void acpm_dvfs_init_get_rate_cmd(u32 cmd[4], unsigned int clk_id,
+					u32 dbg_val)
+{
+	cmd[0] = FIELD_PREP(ACPM_DVFS_ID, clk_id);
+	cmd[1] = dbg_val;
+	cmd[2] = FIELD_PREP(ACPM_DVFS_REQ_TYPE, ACPM_DVFS_FREQ_GET);
+	cmd[3] = ktime_to_ms(ktime_get());
+}
+
+unsigned long acpm_dvfs_get_rate(const struct acpm_handle *handle,
+				 unsigned int acpm_chan_id, unsigned int clk_id,
+				 u32 dbg_val)
+{
+	struct acpm_xfer xfer;
+	unsigned int cmd[4];
+	int ret;
+
+	acpm_dvfs_init_get_rate_cmd(cmd, clk_id, dbg_val);
+	acpm_dvfs_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id, true);
+
+	ret = acpm_do_xfer(handle, &xfer);
+	if (ret)
+		return 0;
+
+	return xfer.rxd[1] * HZ_PER_KHZ;
+}
diff --git a/drivers/firmware/samsung/exynos-acpm-dvfs.h b/drivers/firmware/samsung/exynos-acpm-dvfs.h
new file mode 100644
index 0000000000000000000000000000000000000000..85a10bd535d118f2f36e9888e41b9b705b08ea59
--- /dev/null
+++ b/drivers/firmware/samsung/exynos-acpm-dvfs.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2020 Samsung Electronics Co., Ltd.
+ * Copyright 2020 Google LLC.
+ * Copyright 2025 Linaro Ltd.
+ */
+#ifndef __EXYNOS_ACPM_DVFS_H__
+#define __EXYNOS_ACPM_DVFS_H__
+
+#include <linux/types.h>
+
+struct acpm_handle;
+
+int acpm_dvfs_set_rate(const struct acpm_handle *handle,
+		       unsigned int acpm_chan_id, unsigned int id,
+		       unsigned long rate);
+unsigned long acpm_dvfs_get_rate(const struct acpm_handle *handle,
+				 unsigned int acpm_chan_id, unsigned int clk_id,
+				 u32 dbg_val);
+
+#endif /* __EXYNOS_ACPM_DVFS_H__ */
diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 3a69fe3234c75e0b5a93cbea6bb210dc6f69d2a6..9fa0335ccf5db32892fdf09e8d4b0a885a8f8fb5 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -29,6 +29,7 @@
 #include <linux/types.h>
 
 #include "exynos-acpm.h"
+#include "exynos-acpm-dvfs.h"
 #include "exynos-acpm-pmic.h"
 
 #define ACPM_PROTOCOL_SEQNUM		GENMASK(21, 16)
@@ -590,8 +591,12 @@ static int acpm_channels_init(struct acpm_info *acpm)
  */
 static void acpm_setup_ops(struct acpm_info *acpm)
 {
+	struct acpm_dvfs_ops *dvfs_ops = &acpm->handle.ops.dvfs_ops;
 	struct acpm_pmic_ops *pmic_ops = &acpm->handle.ops.pmic_ops;
 
+	dvfs_ops->set_rate = acpm_dvfs_set_rate;
+	dvfs_ops->get_rate = acpm_dvfs_get_rate;
+
 	pmic_ops->read_reg = acpm_pmic_read_reg;
 	pmic_ops->bulk_read = acpm_pmic_bulk_read;
 	pmic_ops->write_reg = acpm_pmic_write_reg;
diff --git a/include/linux/firmware/samsung/exynos-acpm-protocol.h b/include/linux/firmware/samsung/exynos-acpm-protocol.h
index f628bf1862c25fa018a2fe5e7e123bf05c5254b9..e41055316bb578bb8250a1b1177f1059eeeb2611 100644
--- a/include/linux/firmware/samsung/exynos-acpm-protocol.h
+++ b/include/linux/firmware/samsung/exynos-acpm-protocol.h
@@ -13,6 +13,15 @@
 struct acpm_handle;
 struct device_node;
 
+struct acpm_dvfs_ops {
+	int (*set_rate)(const struct acpm_handle *handle,
+			unsigned int acpm_chan_id, unsigned int clk_id,
+			unsigned long rate);
+	unsigned long (*get_rate)(const struct acpm_handle *handle,
+				  unsigned int acpm_chan_id,
+				  unsigned int clk_id, u32 dbg_val);
+};
+
 struct acpm_pmic_ops {
 	int (*read_reg)(const struct acpm_handle *handle,
 			unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
@@ -32,6 +41,7 @@ struct acpm_pmic_ops {
 };
 
 struct acpm_ops {
+	struct acpm_dvfs_ops dvfs_ops;
 	struct acpm_pmic_ops pmic_ops;
 };
 

-- 
2.51.0.355.g5224444f11-goog


