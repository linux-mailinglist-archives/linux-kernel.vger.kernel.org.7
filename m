Return-Path: <linux-kernel+bounces-772824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34352B29802
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D975E2069
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541F52638AF;
	Mon, 18 Aug 2025 04:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LenEERFY"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE29264A74
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490365; cv=none; b=OevhvNyvqVwxt2p0xnVRO8nk6L3jP4wFSW/WEfKB5nkBihh2M9NZzXYLszDP8auazgyatjKZn5jQ1f2OHIUl+qAT0ezse7R+Mi1YTzqylV5KlEszc2nd9mR06sQxqamr72aZNWBIVmfU0CwmV5aYD+QvR2uw9FF+KhpfPPnbtPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490365; c=relaxed/simple;
	bh=DvHxs9+w7ltOfoA7/NhOym7TCg3DX9LBOV49nSbNPeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkltTlTbjMzguuZCvLS/BUfw9MPuVn4gmG7zM6vb3ehAKxcqwgDO/+ilNif1JylsFV5H8VDN6Oa+TbgCFBTx5mocQy+9NrIXi76cWOZzerYL31yRbPlMH3O7RMvvrNtIbvziUX0n/INlevXu5Be/I2t2V1JIklb6gUu7ciAJRzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=LenEERFY; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32326e7baa1so2885828a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490363; x=1756095163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puANNupOfTPwupiCwBFR/x6cxjL9cWmUBZsMBIE26AA=;
        b=LenEERFYzuQ5AG+K53/dPwiEgjuLOYkSiElCnF0TB+TQlB5vTL4ltKpBibzVDGdUWV
         M5/R4V4FUrhK0pj/WLx8eLFB+Td7E+KzODmb4+Zrqfrft0+G6b2mSuuTJrm64EoT5k/d
         fH9+R8XtyshqQCsZSNmdUAZDAQ5VkX6jLS2Ty7+8SchGmkP6rXDX9UOxARAuxJnoZvwy
         9EeTDXor0zxCVhPVMEfevZxDPGif/xHzIuAn5UGV5kWCSUzA3MKIUNem2xc+Of9CyEUC
         0IGK0XuXbcpm4TfCRHZoX2ih3vTs46ncySWAkPjhLdROL1APb8we4cKbvqcdM9/uTRqX
         Pa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490363; x=1756095163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puANNupOfTPwupiCwBFR/x6cxjL9cWmUBZsMBIE26AA=;
        b=UxbEPn0IFgdmn056N/CpKU914oRQFBeC93niVv79bq03I8E0fo4ONlq4CgSfHkTIil
         qYcBMinrWy+SDhpmW2rC8n7QR1aK3gs4DTmqkRtfCfgKRUcm2ZeAEocaL7ZiJgGlAsIj
         DCk/x3NkvtQTEQlGIYF69VzQFjpBd51NO5YH4wD2yAqf9gy8mzHzZVgaU920z8FUod9/
         KkrQ37O+hwXD1tJS55H3ywBzfnIgj712g85ArkzFR/wnLvXdTI14k+v4+kO3MYMxFnKL
         pUnhKhdDcR5vzoLvONe1ROcflLi1G4tcMk9OGi8bjYcdGwzFbV5SsQ3WMuuolQnKrVoh
         Hsbg==
X-Forwarded-Encrypted: i=1; AJvYcCUSTvAuAZ0RMy4UXIi6K92/MmYs9QNqL8gf+L5z4KRNqSj+hW/Gye2uAaq7/XjBelMUkznrGKbvuUjrtZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7AqPUbW8SjhDGyA550Juq2shh2vxpjy0wTnSrsTIauV8psCxR
	Gkx2FidYxeU4cpvgGBQNIS5j9flH3fumqZQ60v1YdqkMMb5bK082Yf7nA8uXYcyoFnY=
X-Gm-Gg: ASbGncvYmJx2nbrUidQPG/ftERqkivL1L0YkYF4lhEscEqAZJCDQw2emioJ/fzV6FsU
	jmxTqEjxcQ0aUzPDINLJgH3awd/hSRnSoFufQmrEjstAw1gGIretTtnvpZFFNpFOUQnSBtzMWuQ
	hB6j/+utfCMzRdl8L5gtN/eWDdYdVAf6hupvx18h3kvhv571rC3ZKqw9mU+dJhzmUKKoBtgkBtt
	X9ygNTmCZG5z/qE4WWwTKxaixNYn4R5P712iG1UwOQhoWUyz1SHy87lAAU1pTrKmRS9oghcti1k
	zRor5bkdtxtjIBwLXANJiK1dhte5C4QHmzeXrggKwVJ3Rl5PDJVV7f+K0ESliKcT8FfmjVkVdk6
	pLyMpmxFyqLOVoEOLO8BR+4i83Kitg1cOaIz7yOcMEjKeagFFS1dHJQ==
X-Google-Smtp-Source: AGHT+IEC3gS3fhyc6UCaYhWEA2S/aXsvy2asvBmFcLedoY4ZJ0Vv6Zyu/0geFA+k87d1XbbA1zhDRg==
X-Received: by 2002:a17:90b:52c6:b0:31c:15d9:8ae with SMTP id 98e67ed59e1d1-3234218df88mr16496712a91.33.1755490362422;
        Sun, 17 Aug 2025 21:12:42 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:12:41 -0700 (PDT)
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
Subject: [PATCH v10 19/24] ACPI: RISC-V: Add RPMI System MSI to GSI mapping
Date: Mon, 18 Aug 2025 09:39:15 +0530
Message-ID: <20250818040920.272664-20-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818040920.272664-1-apatel@ventanamicro.com>
References: <20250818040920.272664-1-apatel@ventanamicro.com>
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
index 7ec592fe430a..e29ded3416b4 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -32,6 +32,7 @@ enum riscv_irqchip_type {
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


