Return-Path: <linux-kernel+bounces-747781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C58CB1382E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7813A4FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4B92652A9;
	Mon, 28 Jul 2025 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Q7E0l9qj"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4412641F9
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695847; cv=none; b=u5aVz+7SaVA5cp9zsTQ4urjTM/0CucGEan9anAFQK1g09sEnVQzxSiR5BEXvxGL38gk0vHIm3EQp+TlG0Yk2fP3JzaoRxGqvCnINeAnGgbBWrmNunNA/xFleX/rvLcao+AIr8Pc6ZEMMkFf+59+8cFBHr2cM/6+ZoG5xcicJMB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695847; c=relaxed/simple;
	bh=HmUGIQxKVHOETiXQmbQMVfvnbNgiP89D8IFlOG4Z2e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCRRs/FWiHOImVFvplbf7XfIClXywd/oNrsC9yVE0b+kRsBGiGMtJuw52O7N4Lvc9XsVqAZB6QiDQ/d4ucf3mF0lLnsto7d92T6wmG0BTzrKhFPolisa4/hx5Uw1OEoZ4i5CuqTvw91QscN0ykqKrX/YUwaRBJYprK7OkIvLUuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Q7E0l9qj; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-31f02b6cd37so415132a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753695845; x=1754300645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+ya0GtiFk/8ci1A3C7Dw+WSyLS2yytdeeB0s74FDG4=;
        b=Q7E0l9qj8Rtmp8vavpQiUhcqpOSoqPcb0AD3+cZ0E2+mMXcToKKAAD14bdd/DSEPw6
         j7TI5g3ke3kq2Vbvr6XO5Tt72t1ZfophnmIz8vQGWI8oaSlbZgcEk+E4bm67vb7rnHt+
         UXLUC03wfR0TTXOaIXsJpYAKwbJCA4ucuFd7ueaqJ4V0nDvGe6JPTAOFTXdoXNA/jOYn
         nMnrONiJtWYJ0rp+k2E8sPrfWE9L3nsrhKEz7cVLFE7ESuYjephrRkRWYTk6qX7Z9qT4
         IQMKfqtxugRAfxt9RITo7pPaQ9GO0aiJyL4uYvfRF9Epba8OXLu+aqXx1nTb6FMC1kiX
         x8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695845; x=1754300645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+ya0GtiFk/8ci1A3C7Dw+WSyLS2yytdeeB0s74FDG4=;
        b=vYqs9dCn240dfdgWBWaTH/5dWMS4LgzRUBhcfDQM+aa/zEKd8YJQ63TYoymvlILNa5
         ul51WXvFBSltXsfRw4MRwG2ZcUZOQjinI7fYmGJgGvtxaxw+pcDbDdu092I58a65rFsI
         0jbTZxvVgV1QeLtVkiCkWbst8AtiTUxxKG31+oNlkKXHFsRBnzI1RDlqIV012tsfmqVP
         cktIP2lt6TgPZ6Zx9d2q8xAO0A1/Ru2OKJI4jtnEx1uvXsPc/p48Tb8N6lQGpleEeLrh
         jvb1HkbwGxcyUnEYz9gNENs8jcv8KdhHQPRYczgvlEcZC3hwpes63q6JHwTeJfPTyZNM
         s7PA==
X-Forwarded-Encrypted: i=1; AJvYcCWvRDAXdhvQ2TDf4x+sTDp1hfWJ85M3sgz4Ob6PhSHuKBy52uVLH+I60z4YEqz9Lu0vC7edPRkoQvqU9z4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8V+tn9Lg+nXuz/vsWaMOfGnSOxFRpwpNO3pgDLNzNsQID5MOC
	yMopoZy/4KR4/RBxRX2XcqJeOU5Fkd6FcfbvEIH7HPSBoqSusLm2LzgOCPdlPtraI34=
X-Gm-Gg: ASbGncsZZIO8rTzN+SBmWlbn86fsQj5aFMEzGA2WTFSOa0llyYpJHvpRmJ4NUfYCSFi
	2/R/Bci1Ibyms1XSWg3+r8TqIbKok5J8bwk7J+NK8iREbKJ2Bw8iKp0tkCdljxsy1XOSK5uTrAW
	FB03dUtrW/CYA+9P7mIfKzN0UXKUNIsNMS9Mm6LHIIvqi70yzzcLA+CA9Xn2E+xLBBdWGcs9MqG
	4RKKBZcpq8Js48VHG3GasmTxdvMTDft+fGQHOCchXPkUkRlRAIOZMJRlo/fHnt8IGe5r+d3rLaN
	u+4j4+p3ktp0T5bohsCGbMlvlTI4fMJeqt6aXcFqitT8ptd5dZdEH81hvpQ1X8BiGEAo5dOou13
	5C4jmLmFjMPyTVMwpzRQCC9nOtqHGi/5FU+aYrKKXNp02LhSVwPm9mO5CndQ9IwQhPgxesLQ=
X-Google-Smtp-Source: AGHT+IE4g5l7pfzIpeMkicrYGgtf68TEV55Fd+qHkkxzNZ7lt9wZcfCKxLtocnW3t1JCAeR3r08rOw==
X-Received: by 2002:a17:90a:ec8f:b0:31e:424e:5303 with SMTP id 98e67ed59e1d1-31e77b1f040mr13775831a91.34.1753695844469;
        Mon, 28 Jul 2025 02:44:04 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([122.171.19.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832fbf99sm5396230a91.1.2025.07.28.02.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:44:03 -0700 (PDT)
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
	Alexandre Ghiti <alex@ghiti.fr>,
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
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v9 19/24] ACPI: RISC-V: Add RPMI System MSI to GSI mapping
Date: Mon, 28 Jul 2025 15:10:27 +0530
Message-ID: <20250728094032.63545-20-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728094032.63545-1-apatel@ventanamicro.com>
References: <20250728094032.63545-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sunil V L <sunilvl@ventanamicro.com>

The RPMI System MSI device will provide GSIs to downstream devices
(such as GED) so add it to the RISC-V GSI to fwnode mapping.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/irq.h |  1 +
 drivers/acpi/riscv/irq.c     | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 2caf049f09c8..9c9d22f5165e 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -30,6 +30,7 @@ enum riscv_irqchip_type {
 	ACPI_RISCV_IRQCHIP_IMSIC	= 0x01,
 	ACPI_RISCV_IRQCHIP_PLIC		= 0x02,
 	ACPI_RISCV_IRQCHIP_APLIC	= 0x03,
+	ACPI_RISCV_IRQCHIP_SMSI		= 0x04,
 };
 
 int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index cc1928422418..d9a2154d6c6a 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -168,6 +168,33 @@ static int __init riscv_acpi_register_ext_intc(u32 gsi_base, u32 nr_irqs, u32 nr
 	return 0;
 }
 
+static acpi_status __init riscv_acpi_create_gsi_map_smsi(acpi_handle handle, u32 level,
+							 void *context, void **return_value)
+{
+	acpi_status status;
+	u64 gbase;
+
+	if (!acpi_has_method(handle, "_GSB")) {
+		acpi_handle_err(handle, "_GSB method not found\n");
+		return AE_ERROR;
+	}
+
+	status = acpi_evaluate_integer(handle, "_GSB", NULL, &gbase);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_err(handle, "failed to evaluate _GSB method\n");
+		return status;
+	}
+
+	riscv_acpi_register_ext_intc(gbase, 0, 0, 0, ACPI_RISCV_IRQCHIP_SMSI);
+	status = riscv_acpi_update_gsi_handle((u32)gbase, handle);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_err(handle, "failed to find the GSI mapping entry\n");
+		return status;
+	}
+
+	return AE_OK;
+}
+
 static acpi_status __init riscv_acpi_create_gsi_map(acpi_handle handle, u32 level,
 						    void *context, void **return_value)
 {
@@ -222,6 +249,9 @@ void __init riscv_acpi_init_gsi_mapping(void)
 
 	if (acpi_table_parse_madt(ACPI_MADT_TYPE_APLIC, riscv_acpi_aplic_parse_madt, 0) > 0)
 		acpi_get_devices("RSCV0002", riscv_acpi_create_gsi_map, NULL, NULL);
+
+	/* Unlike PLIC/APLIC, SYSMSI doesn't have MADT */
+	acpi_get_devices("RSCV0006", riscv_acpi_create_gsi_map_smsi, NULL, NULL);
 }
 
 static acpi_handle riscv_acpi_get_gsi_handle(u32 gsi)
-- 
2.43.0


