Return-Path: <linux-kernel+bounces-643142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 153F6AB28AE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 May 2025 15:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6D51898A2E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 May 2025 13:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8380525744D;
	Sun, 11 May 2025 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DxjQgJFg"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147AC1B6CE3
	for <linux-kernel@vger.kernel.org>; Sun, 11 May 2025 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746970892; cv=none; b=IR5p/wiMo9f/+lkym1biVkpIpJu9vIMS3ofV9IqNU5/2T66oCjVdl41NGXwvldOMW2s+k4xT7Vqqo3gnYsaE97JAG5mypiRBpWazlr4RdwZkUVRcWq2KZCkt2qRWlBo5MSdH+RhfcsGAXjDJCCAgotIRUL4DLifZzWl6APFJJww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746970892; c=relaxed/simple;
	bh=3SPPaYrLKcr73CK5Qr9hSJJ/+eg1olahd+LlUPsqdX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OblazPP9X5WoK4xHxWdmAC9WBOpfIBRp/cvi70Qku9/2p3fxNd+wIpK3yui8UV5nOWxNCDYuPGn3hH2XH77wuMBKQSzZPicTA2DZfYwEKKVRI8FpnCvZ5lnE/9gJIIen9i/yrIESiov9a+W7HB6mAFhZybMZhzpO9NSaAWjgJ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DxjQgJFg; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22fa414c497so42031155ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 May 2025 06:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1746970889; x=1747575689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSgUBDUo/3qj9rGB/Khx2Tn6406r9S9uEgGwvvDm/0I=;
        b=DxjQgJFgbU5d/ITv82oYi+DidDrJLdVFpRpBzKmmkT3upUeuWI3N6PGCnfujd532q2
         pSBbUfT6ZKi4jWLkIaiR8Tzzk58H88UdodG6MAPQNprXw+u15GV79aJ5TYxJtf8773w6
         URuK+JGhHm3tLGgNGiV9/4V7OTDZpn3FuQNiTqWWsG6IkLXoo9OXsXeAoOLqhmL7dkUB
         kI9HIEMMYq7oCrGGQXVYFjaL+ZOkEU+ormXtlsUHW2jNbi+lWgQ0hDRlx8nLsY9y2f2+
         QtHuPze9U0YHNVasmQ7gn4uHqeopsrR/HetWQIhIMJy2qn+SBnbVgbCkbAJtqxNl6AdG
         jUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746970889; x=1747575689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSgUBDUo/3qj9rGB/Khx2Tn6406r9S9uEgGwvvDm/0I=;
        b=IA6pYvUJ9fpQNKQvUx7M5pG6itvVTtvYoq2xeQx5UqlwKROzvVV03T77PbWzYHWF+E
         iJZ7o8gLfBKbq6sPtLbYfD+XobOLbOpn8cBBL2yo4CMq3oq+aPGqvJ/TAa7sxjxn/F4k
         4MopVxrlsx5CX88658XZ4g0bGHlBxJwJAn26EcL3ha2wsq+bxja2Mk0Yx/2Q+MnYqwDV
         zAW47KNateAK48irSgqqWpDCP/BoIfxpDQoVKXjjAZc1/K8nhHoQ7BwUnd6HOBGxp5IO
         5rQRHAKjYmikjiQ4PUvOKpaMhUQO6Ws3U3XcBZ9cOiu99JxehB57GLojdnkmjyH7vlb8
         125A==
X-Forwarded-Encrypted: i=1; AJvYcCWp0+FCVKXFmPXsGoFedp+rdKMGNmQoPjWiCQ3kipTmg+SC8nVBib3YpBsFRqGQ/8GJlQLBnR6Q04WsQGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhqhZmufOI7LrDzKi4oBBdf5HTClKPVxpow7BkRIl9zIgm1/FE
	aqzLmOPf7XRKTuNQkanASHlaXx1QlPH8ujON9aRGhIE10rGpkBpLexxmJFj6xSQ=
X-Gm-Gg: ASbGncvyT8ACEJKdbUPnihMkK7xNyeB0hNq28/ak1MxTxN0w5Ua5d+1WAtS6a6tUHg+
	wr1sZ+rpRHgH4t2jREEqBdCnT6KmNWOUuKC2TVfxyT0t2GTsAiqt5Wavm5Jyf7reBVOKtIYo0Zh
	O2n3V+VXqh/VYYDoOF3G3RaPs4ZVvdNiV+lIi/LNx3CrS7euwo8ED8GPsdp65wrl3PBGzDKKmRP
	elC32XetZt66+U0upPx473cygnBJbeot6S3cf1O6fbbfH507UYZF3Y9sdrLBYCtudYbJ8tgheJc
	NyR5s2QMbbrirBpXNDnvJr3mfP7EdrDqm8l4E0ynWGxmLCJwky/vQIx4ukTM48Lohn1CfaUz75F
	WAxihrHb6Ydkq/A==
X-Google-Smtp-Source: AGHT+IGRVVY+xhwMFSnU6WeDrHdFqUpiTc9xkmGi0LrOy3mT9PQlW5b2MKbYlk0pS9wjCAqq1ZYWiQ==
X-Received: by 2002:a17:902:d581:b0:224:5a8:ba29 with SMTP id d9443c01a7336-22fc91a7375mr161991195ad.43.1746970889144;
        Sun, 11 May 2025 06:41:29 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([122.171.17.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc754785bsm46665805ad.20.2025.05.11.06.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 06:41:28 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v3 10/23] clk: Add clock driver for the RISC-V RPMI clock service group
Date: Sun, 11 May 2025 19:09:26 +0530
Message-ID: <20250511133939.801777-11-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511133939.801777-1-apatel@ventanamicro.com>
References: <20250511133939.801777-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rahul Pathak <rpathak@ventanamicro.com>

The RPMI specification defines a clock service group which can be
accessed via SBI MPXY extension or dedicated S-mode RPMI transport.

Add mailbox client based clock driver for the RISC-V RPMI clock
service group.

Co-developed-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Rahul Pathak <rpathak@ventanamicro.com>
---
 drivers/clk/Kconfig                        |   8 +
 drivers/clk/Makefile                       |   1 +
 drivers/clk/clk-rpmi.c                     | 601 +++++++++++++++++++++
 include/linux/mailbox/riscv-rpmi-message.h |  16 +
 4 files changed, 626 insertions(+)
 create mode 100644 drivers/clk/clk-rpmi.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 713573b6c86c..d89308c7f75c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -493,6 +493,14 @@ config COMMON_CLK_SP7021
 	  Not all features of the PLL are currently supported
 	  by the driver.
 
+config COMMON_CLK_RPMI
+	tristate "Clock driver based on RISC-V RPMI"
+	depends on MAILBOX
+	default RISCV
+	help
+	  Support for clocks based on the clock service group defined by
+	  the RISC-V platform management interface (RPMI) specification.
+
 source "drivers/clk/actions/Kconfig"
 source "drivers/clk/analogbits/Kconfig"
 source "drivers/clk/baikal-t1/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index bf4bd45adc3a..b8588ab789c3 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_CLK_LS1028A_PLLDIG)	+= clk-plldig.o
 obj-$(CONFIG_COMMON_CLK_PWM)		+= clk-pwm.o
 obj-$(CONFIG_CLK_QORIQ)			+= clk-qoriq.o
 obj-$(CONFIG_COMMON_CLK_RK808)		+= clk-rk808.o
+obj-$(CONFIG_COMMON_CLK_RPMI)		+= clk-rpmi.o
 obj-$(CONFIG_COMMON_CLK_HI655X)		+= clk-hi655x.o
 obj-$(CONFIG_COMMON_CLK_S2MPS11)	+= clk-s2mps11.o
 obj-$(CONFIG_COMMON_CLK_SCMI)           += clk-scmi.o
diff --git a/drivers/clk/clk-rpmi.c b/drivers/clk/clk-rpmi.c
new file mode 100644
index 000000000000..671464f35c6d
--- /dev/null
+++ b/drivers/clk/clk-rpmi.c
@@ -0,0 +1,601 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RISC-V MPXY Based Clock Driver
+ *
+ * Copyright (C) 2025 Ventana Micro Systems Ltd.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/mailbox/riscv-rpmi-message.h>
+
+#define RPMI_CLK_DISCRETE_MAX_NUM_RATES		16
+#define RPMI_CLK_NAME_LEN			16
+
+#define GET_RATE_U64(hi_u32, lo_u32)	((u64)(hi_u32) << 32 | (lo_u32))
+
+enum rpmi_clk_config {
+	RPMI_CLK_DISABLE = 0,
+	RPMI_CLK_ENABLE = 1,
+};
+
+enum rpmi_clk_type {
+	RPMI_CLK_DISCRETE = 0,
+	RPMI_CLK_LINEAR = 1,
+	RPMI_CLK_TYPE_MAX_IDX,
+};
+
+struct rpmi_clk_context {
+	struct device *dev;
+	struct mbox_chan *chan;
+	struct mbox_client client;
+	u32 max_msg_data_size;
+};
+
+union rpmi_clk_rates {
+	u64 discrete[RPMI_CLK_DISCRETE_MAX_NUM_RATES];
+	struct {
+		u64 min;
+		u64 max;
+		u64 step;
+	} linear;
+};
+
+struct rpmi_clk {
+	struct rpmi_clk_context *context;
+	u32 id;
+	u32 num_rates;
+	u32 transition_latency;
+	enum rpmi_clk_type type;
+	union rpmi_clk_rates *rates;
+	char name[RPMI_CLK_NAME_LEN];
+	struct clk_hw hw;
+};
+
+#define to_rpmi_clk(clk)	container_of(clk, struct rpmi_clk, hw)
+
+struct rpmi_get_num_clocks_rx {
+	s32 status;
+	u32 num_clocks;
+};
+
+struct rpmi_get_attrs_tx {
+	__le32 clkid;
+};
+
+struct rpmi_get_attrs_rx {
+	s32 status;
+	u32 flags;
+	u32 num_rates;
+	u32 transition_latency;
+	char name[RPMI_CLK_NAME_LEN];
+};
+
+struct rpmi_get_supp_rates_tx {
+	__le32 clkid;
+	__le32 clk_rate_idx;
+};
+
+struct rpmi_clk_rate_discrete {
+	u32 lo;
+	u32 hi;
+};
+
+struct rpmi_clk_rate_linear {
+	u32 min_lo;
+	u32 min_hi;
+	u32 max_lo;
+	u32 max_hi;
+	u32 step_lo;
+	u32 step_hi;
+};
+
+struct rpmi_get_supp_rates_rx {
+	u32 status;
+	u32 flags;
+	u32 remaining;
+	u32 returned;
+	u32 rates[];
+};
+
+struct rpmi_get_rate_tx {
+	__le32 clkid;
+};
+
+struct rpmi_get_rate_rx {
+	u32 status;
+	u32 lo;
+	u32 hi;
+};
+
+struct rpmi_set_rate_tx {
+	__le32 clkid;
+	__le32 flags;
+	__le32 lo;
+	__le32 hi;
+};
+
+struct rpmi_set_rate_rx {
+	u32 status;
+};
+
+struct rpmi_set_config_tx {
+	__le32 clkid;
+	__le32 config;
+};
+
+struct rpmi_set_config_rx {
+	u32 status;
+};
+
+static int rpmi_clk_get_num_clocks(struct rpmi_clk_context *context)
+{
+	struct rpmi_get_num_clocks_rx rx;
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_CLK_SRV_GET_NUM_CLOCKS,
+					  NULL, 0, &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret)
+		return ret;
+	if (rx.status)
+		return rpmi_to_linux_error(rx.status);
+
+	return rx.num_clocks;
+}
+
+static int rpmi_clk_get_attrs(u32 clkid, struct rpmi_clk *rpmi_clk)
+{
+	struct rpmi_clk_context *context = rpmi_clk->context;
+	struct rpmi_mbox_message msg;
+	struct rpmi_get_attrs_tx tx;
+	struct rpmi_get_attrs_rx rx;
+	u8 format;
+	int ret;
+
+	tx.clkid = cpu_to_le32(clkid);
+	rpmi_mbox_init_send_with_response(&msg, RPMI_CLK_SRV_GET_ATTRIBUTES,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret)
+		return ret;
+	if (rx.status)
+		return rpmi_to_linux_error(rx.status);
+
+	rpmi_clk->id = clkid;
+	rpmi_clk->num_rates = rx.num_rates;
+	rpmi_clk->transition_latency = rx.transition_latency;
+	strscpy(rpmi_clk->name, rx.name, RPMI_CLK_NAME_LEN);
+
+	format = rx.flags & 3U;
+	if (format >= RPMI_CLK_TYPE_MAX_IDX)
+		return -EINVAL;
+
+	rpmi_clk->type = format;
+
+	return 0;
+}
+
+static int rpmi_clk_get_supported_rates(u32 clkid, struct rpmi_clk *rpmi_clk)
+{
+	struct rpmi_clk_context *context = rpmi_clk->context;
+	struct rpmi_clk_rate_discrete *rate_discrete;
+	struct rpmi_clk_rate_linear *rate_linear;
+	struct rpmi_get_supp_rates_rx *rx;
+	struct rpmi_get_supp_rates_tx tx;
+	struct rpmi_mbox_message msg;
+	size_t clk_rate_idx = 0;
+	int ret, rateidx, j;
+
+	tx.clkid = cpu_to_le32(clkid);
+	tx.clk_rate_idx = 0;
+
+	/*
+	 * Make sure we allocate rx buffer sufficient to be accommodate all
+	 * the rates sent in one RPMI message.
+	 */
+	rx = devm_kzalloc(context->dev, context->max_msg_data_size, GFP_KERNEL);
+	if (!rx)
+		return -ENOMEM;
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_CLK_SRV_GET_SUPPORTED_RATES,
+					  &tx, sizeof(tx), rx, context->max_msg_data_size);
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret)
+		return ret;
+	if (rx->status)
+		return rpmi_to_linux_error(rx->status);
+	if (!rx->returned)
+		return -EINVAL;
+
+	if (rpmi_clk->type == RPMI_CLK_DISCRETE) {
+		rate_discrete = (struct rpmi_clk_rate_discrete *)rx->rates;
+
+		for (rateidx = 0; rateidx < rx->returned; rateidx++) {
+			rpmi_clk->rates->discrete[rateidx] =
+					GET_RATE_U64(rate_discrete[rateidx].hi,
+						     rate_discrete[rateidx].lo);
+		}
+
+		/*
+		 * Keep sending the request message until all
+		 * the rates are received.
+		 */
+		while (rx->remaining) {
+			clk_rate_idx += rx->returned;
+			tx.clk_rate_idx = cpu_to_le32(clk_rate_idx);
+
+			rpmi_mbox_init_send_with_response(&msg,
+							  RPMI_CLK_SRV_GET_SUPPORTED_RATES,
+							  &tx, sizeof(tx),
+							  rx, context->max_msg_data_size);
+			ret = rpmi_mbox_send_message(context->chan, &msg);
+			if (ret)
+				return ret;
+			if (rx->status)
+				return rpmi_to_linux_error(rx->status);
+			if (!rx->returned)
+				return -EINVAL;
+
+			for (j = 0; j < rx->returned; j++) {
+				if (rateidx >= (clk_rate_idx + rx->returned))
+					break;
+				rpmi_clk->rates->discrete[rateidx++] =
+					GET_RATE_U64(rate_discrete[j].hi,
+						     rate_discrete[j].lo);
+			}
+		}
+	} else if (rpmi_clk->type == RPMI_CLK_LINEAR) {
+		rate_linear = (struct rpmi_clk_rate_linear *)rx->rates;
+
+		rpmi_clk->rates->linear.min =
+				GET_RATE_U64(rate_linear->min_hi,
+					     rate_linear->min_lo);
+		rpmi_clk->rates->linear.max =
+				GET_RATE_U64(rate_linear->max_hi,
+					     rate_linear->max_lo);
+		rpmi_clk->rates->linear.step =
+				GET_RATE_U64(rate_linear->step_hi,
+					     rate_linear->step_lo);
+	}
+
+	devm_kfree(context->dev, rx);
+	return 0;
+}
+
+static unsigned long rpmi_clk_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	struct rpmi_clk *rpmi_clk = to_rpmi_clk(hw);
+	struct rpmi_clk_context *context = rpmi_clk->context;
+	struct rpmi_mbox_message msg;
+	struct rpmi_get_rate_tx tx;
+	struct rpmi_get_rate_rx rx;
+	int ret;
+
+	tx.clkid = cpu_to_le32(rpmi_clk->id);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_CLK_SRV_GET_RATE,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret)
+		return ret;
+	if (rx.status)
+		return rx.status;
+
+	return GET_RATE_U64(rx.hi, rx.lo);
+}
+
+static int rpmi_clk_determine_rate(struct clk_hw *hw,
+				   struct clk_rate_request *req)
+{
+	struct rpmi_clk *rpmi_clk = to_rpmi_clk(hw);
+	u64 fmin, fmax, ftmp;
+
+	/* Keep the requested rate if the clock format
+	 * is of discrete type. Let the platform which
+	 * is actually controlling the clock handle that.
+	 */
+	if (rpmi_clk->type == RPMI_CLK_DISCRETE)
+		goto out;
+
+	fmin = rpmi_clk->rates->linear.min;
+	fmax = rpmi_clk->rates->linear.max;
+
+	if (req->rate <= fmin) {
+		req->rate = fmin;
+		goto out;
+	} else if (req->rate >= fmax) {
+		req->rate = fmax;
+		goto out;
+	}
+
+	ftmp = req->rate - fmin;
+	ftmp += rpmi_clk->rates->linear.step - 1;
+	do_div(ftmp, rpmi_clk->rates->linear.step);
+
+	req->rate = ftmp * rpmi_clk->rates->linear.step + fmin;
+out:
+	return 0;
+}
+
+static int rpmi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long parent_rate)
+{
+	struct rpmi_clk *rpmi_clk = to_rpmi_clk(hw);
+	struct rpmi_clk_context *context = rpmi_clk->context;
+	struct rpmi_mbox_message msg;
+	struct rpmi_set_rate_tx tx;
+	struct rpmi_set_rate_rx rx;
+	int ret;
+
+	tx.clkid = cpu_to_le32(rpmi_clk->id);
+	tx.lo = cpu_to_le32(lower_32_bits(rate));
+	tx.hi = cpu_to_le32(upper_32_bits(rate));
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_CLK_SRV_SET_RATE,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret)
+		return ret;
+	if (rx.status)
+		return rpmi_to_linux_error(rx.status);
+
+	return 0;
+}
+
+static int rpmi_clk_enable(struct clk_hw *hw)
+{
+	struct rpmi_clk *rpmi_clk = to_rpmi_clk(hw);
+	struct rpmi_clk_context *context = rpmi_clk->context;
+	struct rpmi_mbox_message msg;
+	struct rpmi_set_config_tx tx;
+	struct rpmi_set_config_rx rx;
+	int ret;
+
+	tx.config = cpu_to_le32(RPMI_CLK_ENABLE);
+	tx.clkid = cpu_to_le32(rpmi_clk->id);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_CLK_SRV_SET_CONFIG,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret)
+		return ret;
+	if (rx.status)
+		return rpmi_to_linux_error(rx.status);
+
+	return 0;
+}
+
+static void rpmi_clk_disable(struct clk_hw *hw)
+{
+	struct rpmi_clk *rpmi_clk = to_rpmi_clk(hw);
+	struct rpmi_clk_context *context = rpmi_clk->context;
+	struct rpmi_mbox_message msg;
+	struct rpmi_set_config_tx tx;
+	struct rpmi_set_config_rx rx;
+	int ret;
+
+	tx.config = cpu_to_le32(RPMI_CLK_DISABLE);
+	tx.clkid = cpu_to_le32(rpmi_clk->id);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_CLK_SRV_SET_CONFIG,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret || rx.status)
+		pr_err("Failed to disable clk-%u\n", rpmi_clk->id);
+}
+
+static const struct clk_ops rpmi_clk_ops = {
+	.recalc_rate = rpmi_clk_recalc_rate,
+	.determine_rate = rpmi_clk_determine_rate,
+	.set_rate = rpmi_clk_set_rate,
+	.prepare = rpmi_clk_enable,
+	.unprepare = rpmi_clk_disable,
+};
+
+static struct clk_hw *rpmi_clk_enumerate(struct rpmi_clk_context *context, u32 clkid)
+{
+	struct device *dev = context->dev;
+	unsigned long min_rate, max_rate;
+	union rpmi_clk_rates *rates;
+	struct rpmi_clk *rpmi_clk;
+	struct clk_init_data init = {};
+	struct clk_hw *clk_hw;
+	int ret;
+
+	rates = devm_kzalloc(dev, sizeof(union rpmi_clk_rates), GFP_KERNEL);
+	if (!rates)
+		return ERR_PTR(-ENOMEM);
+
+	rpmi_clk = devm_kzalloc(dev, sizeof(struct rpmi_clk), GFP_KERNEL);
+	if (!rpmi_clk)
+		return ERR_PTR(-ENOMEM);
+
+	rpmi_clk->context = context;
+	rpmi_clk->rates = rates;
+
+	ret = rpmi_clk_get_attrs(clkid, rpmi_clk);
+	if (ret)
+		return dev_err_ptr_probe(dev, ret,
+			"Failed to get clk-%u attributes, %d\n", clkid, ret);
+
+	ret = rpmi_clk_get_supported_rates(clkid, rpmi_clk);
+	if (ret)
+		return dev_err_ptr_probe(dev, ret,
+			"Get supported rates failed for clk-%u, %d\n", clkid, ret);
+
+	init.flags = CLK_GET_RATE_NOCACHE;
+	init.num_parents = 0;
+	init.ops = &rpmi_clk_ops;
+	init.name = rpmi_clk->name;
+	clk_hw = &rpmi_clk->hw;
+	clk_hw->init = &init;
+
+	ret = devm_clk_hw_register(dev, clk_hw);
+	if (ret)
+		return dev_err_ptr_probe(dev, ret, "Unable to register clk-%u\n", clkid);
+
+	if (rpmi_clk->type == RPMI_CLK_DISCRETE) {
+		min_rate = rpmi_clk->rates->discrete[0];
+		max_rate = rpmi_clk->rates->discrete[rpmi_clk->num_rates -  1];
+	} else {
+		min_rate = rpmi_clk->rates->linear.min;
+		max_rate = rpmi_clk->rates->linear.max;
+	}
+
+	clk_hw_set_rate_range(clk_hw, min_rate, max_rate);
+
+	return clk_hw;
+}
+
+static int rpmi_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct clk_hw_onecell_data *clk_data;
+	struct rpmi_clk_context *context;
+	struct rpmi_mbox_message msg;
+	int ret, num_clocks, i;
+	struct clk_hw *hw_ptr;
+
+	/* Allocate RPMI clock context */
+	context = devm_kzalloc(dev, sizeof(*context), GFP_KERNEL);
+	if (!context)
+		return -ENOMEM;
+	context->dev = dev;
+	platform_set_drvdata(pdev, context);
+
+	/* Setup mailbox client */
+	context->client.dev		= context->dev;
+	context->client.rx_callback	= NULL;
+	context->client.tx_block	= false;
+	context->client.knows_txdone	= true;
+	context->client.tx_tout		= 0;
+
+	/* Request mailbox channel */
+	context->chan = mbox_request_channel(&context->client, 0);
+	if (IS_ERR(context->chan))
+		return PTR_ERR(context->chan);
+
+	/* Validate RPMI specification version */
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_SPEC_VERSION);
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to get spec version\n");
+		goto fail_free_channel;
+	}
+	if (msg.attr.value < RPMI_MKVER(1, 0)) {
+		ret = dev_err_probe(dev, -EINVAL,
+				    "msg protocol version mismatch, expected 0x%x, found 0x%x\n",
+				    RPMI_MKVER(1, 0), msg.attr.value);
+		goto fail_free_channel;
+	}
+
+	/* Validate clock service group ID */
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_SERVICEGROUP_ID);
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to get service group ID\n");
+		goto fail_free_channel;
+	}
+	if (msg.attr.value != RPMI_SRVGRP_CLOCK) {
+		ret = dev_err_probe(dev, -EINVAL,
+				    "service group match failed, expected 0x%x, found 0x%x\n",
+				    RPMI_SRVGRP_CLOCK, msg.attr.value);
+		goto fail_free_channel;
+	}
+
+	/* Validate clock service group version */
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_SERVICEGROUP_VERSION);
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to get service group version\n");
+		goto fail_free_channel;
+	}
+	if (msg.attr.value < RPMI_MKVER(1, 0)) {
+		ret = dev_err_probe(dev, -EINVAL,
+				    "service group version failed, expected 0x%x, found 0x%x\n",
+				    RPMI_MKVER(1, 0), msg.attr.value);
+		goto fail_free_channel;
+	}
+
+	/* Save the maximum message data size of mailbox channel */
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_MAX_MSG_DATA_SIZE);
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to get max message data size\n");
+		goto fail_free_channel;
+	}
+	context->max_msg_data_size = msg.attr.value;
+
+	/* Find-out number of clocks */
+	num_clocks = rpmi_clk_get_num_clocks(context);
+	if (num_clocks < 1) {
+		ret = dev_err_probe(dev, -ENODEV, "No clocks found\n");
+		goto fail_free_channel;
+	}
+
+	/* Allocate clock data */
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, num_clocks),
+				GFP_KERNEL);
+	if (!clk_data) {
+		ret = -ENOMEM;
+		goto fail_free_channel;
+	}
+	clk_data->num = num_clocks;
+
+	/* Setup clock data */
+	for (i = 0; i < clk_data->num; i++) {
+		hw_ptr = rpmi_clk_enumerate(context, i);
+		if (IS_ERR(hw_ptr)) {
+			ret = dev_err_probe(dev, PTR_ERR(hw_ptr),
+					    "failed to register clk-%d\n", i);
+			goto fail_free_channel;
+		}
+		clk_data->hws[i] = hw_ptr;
+	}
+
+	/* Register clock HW provider */
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to register clock HW provider\n");
+		goto fail_free_channel;
+	}
+
+	return 0;
+
+fail_free_channel:
+	mbox_free_channel(context->chan);
+	return ret;
+}
+
+static void rpmi_clk_remove(struct platform_device *pdev)
+{
+	struct rpmi_clk_context *context = platform_get_drvdata(pdev);
+
+	mbox_free_channel(context->chan);
+}
+
+static const struct of_device_id rpmi_clk_of_match[] = {
+	{ .compatible = "riscv,rpmi-clock" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rpmi_clk_of_match);
+
+static struct platform_driver rpmi_clk_driver = {
+	.driver = {
+		.name = "riscv-rpmi-clock",
+		.of_match_table = rpmi_clk_of_match,
+	},
+	.probe = rpmi_clk_probe,
+	.remove = rpmi_clk_remove,
+};
+module_platform_driver(rpmi_clk_driver);
+
+MODULE_AUTHOR("Rahul Pathak <rpathak@ventanamicro.com>");
+MODULE_DESCRIPTION("Clock Driver based on RPMI message protocol");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mailbox/riscv-rpmi-message.h b/include/linux/mailbox/riscv-rpmi-message.h
index 77e1edc569ac..dfffe4804ec7 100644
--- a/include/linux/mailbox/riscv-rpmi-message.h
+++ b/include/linux/mailbox/riscv-rpmi-message.h
@@ -89,6 +89,22 @@ static inline int rpmi_to_linux_error(int rpmi_error)
 	}
 }
 
+/** RPMI service group IDs */
+#define RPMI_SRVGRP_CLOCK		0x00008
+
+/** RPMI clock service IDs */
+enum rpmi_clock_service_id {
+	RPMI_CLK_SRV_ENABLE_NOTIFICATION = 0x01,
+	RPMI_CLK_SRV_GET_NUM_CLOCKS = 0x02,
+	RPMI_CLK_SRV_GET_ATTRIBUTES = 0x03,
+	RPMI_CLK_SRV_GET_SUPPORTED_RATES = 0x04,
+	RPMI_CLK_SRV_SET_CONFIG = 0x05,
+	RPMI_CLK_SRV_GET_CONFIG = 0x06,
+	RPMI_CLK_SRV_SET_RATE = 0x07,
+	RPMI_CLK_SRV_GET_RATE = 0x08,
+	RPMI_CLK_SRV_ID_MAX_COUNT,
+};
+
 /** RPMI linux mailbox attribute IDs */
 enum rpmi_mbox_attribute_id {
 	RPMI_MBOX_ATTR_SPEC_VERSION = 0,
-- 
2.43.0


