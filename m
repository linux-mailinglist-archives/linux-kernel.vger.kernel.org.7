Return-Path: <linux-kernel+bounces-772823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB5FB297FE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E725E0759
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2330266B6C;
	Mon, 18 Aug 2025 04:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Pdr6TOrF"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72415264636
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490357; cv=none; b=TILkULZNAJJo49lNpMEMxJJNitKf4bZRX5frJkwBMpzk01XlQzfEjd71zd2tD5EIBh7sfad8DayG0odiFhDKzBu2gmX3/sERCbuGHEdEt3bHnDEGqcv/KpxH2ayBKQCCVBVOj2hUAlsLSAS+dAMKZnlV10zs2+ZzsBZO5X5FWbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490357; c=relaxed/simple;
	bh=8PBH/s43jAVAa2oz786iS6gjTCS87UYBg/ty1MD+TGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqJ266MpHkiKgy6M/PowWMaWRJj93l8oWOk5iwNH0zARAsvAxOGmRp1TQmh8piBCjZyXBeYHKccZasp3ioFrUIQ16rVrpdO+Mq1wn4QPkMHDguS1DnpkrRVsgxcb9y/Kx9MR08WD6gPuk05qARkwPaULAohm1rbF9HseOkWZigQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Pdr6TOrF; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-323266cdf64so2754237a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490355; x=1756095155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yWqS/B4+C2GeeCl07+fnbYmzaV3u99GO7HLw3KmW+Q=;
        b=Pdr6TOrFaP2mUwzzLsEJ+Kde69d+lN8Ni6sL1DE0YWt4edhpt0rw9WusPYZUns2wDN
         doFRFGvwRzzK6h5BDkUGr6/lfONHcHpFPJXttPoevD0vZLfzpFf7z97XWDuvnvK2oQAh
         JFYffK2K/SztSpiDkXOiuxc2NrqisvXBlyK2Kyz7UY95cREiGX9pC0zuqkaMbbMuAJF8
         wI/kZtV6i6Or/pKr+fu+lZZcYqSxyuPQNd13Repizk9epBdB4a/qB9PEwTc/7tb+uVoA
         XytorI55C/45Iep1Vf42PGV9mCY5LnN4Y5g1vxZL1QMogG9PHzCHFJ5zOD0LkBOcFjUh
         7ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490355; x=1756095155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yWqS/B4+C2GeeCl07+fnbYmzaV3u99GO7HLw3KmW+Q=;
        b=Xpn0RtQamAwr/EA49NPR4c4FKDiliPrHkVhi5Nz2hF/9uQ6M0tqR9vf+8NUwCVBAgX
         cLYLiO3xDULADkQkyAElWHrPL33y3tSc2NV3T8ZSioZY9aP0njchb79aCsvHMChGoY8v
         PcK/8/wJHHN6+CSPK1Rl8qfveG4TFy7ubFYq8h/yJvbmfzvpnUduTWRTOWtT54Q42FU8
         gsExDfdNGFb/2N4obkdF1uFjlTVTXeGBxZmBcBRZVvdF2A23C7QeBGrgcDtQzrqlomS3
         noMK9/yZ7fxwC4/S2O1WwU1jCkG+gAR4eF474jYwvCXp4mST+ehHAeiT1nzFXdW+wRPo
         GblA==
X-Forwarded-Encrypted: i=1; AJvYcCXpHybcrEUOuqwKdIL54GW9YIVQDYUYnKg4tCKGq0QVDy7thUIyqd8asKZby2T2aGSVAUILVjhWNPyqS8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLlPZLmegnT4PyuQoMKK+R2SavGsKHof+k/CI23TwhtdMcyjDa
	NG7UdgsJSWZJ7PhhW2wSScG5Ldaff3eaQ6v+jwn9raL5I9DF6I/oJmdtplXtec5gl9M=
X-Gm-Gg: ASbGncvR8kUJ+wres+2iyMRaYQI2W0KTdQwplM1FWeH7VjmvfXp35j1A2vCMy/Ic4tw
	oJZiir73As1Ni6nu0e04d+Xhcb5V3MFdm/tnAiMYEOT9qP/GgxzmnWYM+O3qRuykSVWwB9c+ZJ5
	TYFkoe1+bHOarlTst/4Ld7VIo3nnl5O6rOUgfNy8KDKERl/aJMGa3JUnsqtEAgrmpEQ83a+3WYT
	+0Kx5sVfP2sU8wA//In1gtCaLNf2DeQOSAvhOiBAIR0uyD2eR4+tzGAMa4UFF72e3OHiVYJbmpU
	iJycO76D3XTZfzbSDJkK0fvPEeKSxolizoUO4MCDl5ad3pJF0/9X0O39XehVI7yDKWFFgRP6Xcw
	DdoEHlwwmXoXzIlk7285UgrPcO/bZ6QWaLCCyOYGtLJmxnji8its+zg==
X-Google-Smtp-Source: AGHT+IEsDmj77mUvgdQimMi0uVp5iehZpP28fFtyXe2C6DL2NiDYzgOPGr8ykLq5LaUBARt9lXtGMA==
X-Received: by 2002:a17:90b:3949:b0:321:4760:c65a with SMTP id 98e67ed59e1d1-32341fff339mr14481306a91.27.1755490354531;
        Sun, 17 Aug 2025 21:12:34 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:12:34 -0700 (PDT)
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
Subject: [PATCH v10 18/24] ACPI: RISC-V: Add support to update gsi range
Date: Mon, 18 Aug 2025 09:39:14 +0530
Message-ID: <20250818040920.272664-19-apatel@ventanamicro.com>
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

Some RISC-V interrupt controllers like RPMI based system MSI interrupt
controllers do not have MADT entry defined. These interrupt controllers
exist only in the namespace. ACPI spec defines _GSB method to get the
GSI base of the interrupt controller, However, there is no such standard
method to get the GSI range. To support such interrupt controllers, set
the GSI range of such interrupt controllers to non-overlapping range and
provide API for interrupt controller driver to update it with proper
value.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/irq.h |  5 +++++
 drivers/acpi/riscv/irq.c     | 38 ++++++++++++++++++++++++++++++++++--
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 59c975f750c9..7ec592fe430a 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -42,6 +42,7 @@ unsigned long acpi_rintc_ext_parent_to_hartid(unsigned int plic_id, unsigned int
 unsigned int acpi_rintc_get_plic_nr_contexts(unsigned int plic_id);
 unsigned int acpi_rintc_get_plic_context(unsigned int plic_id, unsigned int ctxt_idx);
 int __init acpi_rintc_get_imsic_mmio_info(u32 index, struct resource *res);
+int riscv_acpi_update_gsi_range(u32 gsi_base, u32 nr_irqs);
 
 #else
 static inline int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
@@ -76,6 +77,10 @@ static inline int __init acpi_rintc_get_imsic_mmio_info(u32 index, struct resour
 	return 0;
 }
 
+static inline int riscv_acpi_update_gsi_range(u32 gsi_base, u32 nr_irqs)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_ACPI */
 
 #endif /* _ASM_RISCV_IRQ_H */
diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index 33c073e2e71d..cc1928422418 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -10,6 +10,8 @@
 
 #include "init.h"
 
+#define RISCV_ACPI_INTC_FLAG_PENDING BIT(0)
+
 struct riscv_ext_intc_list {
 	acpi_handle		handle;
 	u32			gsi_base;
@@ -17,6 +19,7 @@ struct riscv_ext_intc_list {
 	u32			nr_idcs;
 	u32			id;
 	u32			type;
+	u32			flag;
 	struct list_head	list;
 };
 
@@ -69,6 +72,22 @@ static acpi_status riscv_acpi_update_gsi_handle(u32 gsi_base, acpi_handle handle
 	return AE_NOT_FOUND;
 }
 
+int riscv_acpi_update_gsi_range(u32 gsi_base, u32 nr_irqs)
+{
+	struct riscv_ext_intc_list *ext_intc_element;
+
+	list_for_each_entry(ext_intc_element, &ext_intc_list, list) {
+		if (gsi_base == ext_intc_element->gsi_base &&
+		    (ext_intc_element->flag & RISCV_ACPI_INTC_FLAG_PENDING)) {
+			ext_intc_element->nr_irqs = nr_irqs;
+			ext_intc_element->flag &= ~RISCV_ACPI_INTC_FLAG_PENDING;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
 int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
 			    u32 *id, u32 *nr_irqs, u32 *nr_idcs)
 {
@@ -115,14 +134,22 @@ struct fwnode_handle *riscv_acpi_get_gsi_domain_id(u32 gsi)
 static int __init riscv_acpi_register_ext_intc(u32 gsi_base, u32 nr_irqs, u32 nr_idcs,
 					       u32 id, u32 type)
 {
-	struct riscv_ext_intc_list *ext_intc_element, *node;
+	struct riscv_ext_intc_list *ext_intc_element, *node, *prev;
 
 	ext_intc_element = kzalloc(sizeof(*ext_intc_element), GFP_KERNEL);
 	if (!ext_intc_element)
 		return -ENOMEM;
 
 	ext_intc_element->gsi_base = gsi_base;
-	ext_intc_element->nr_irqs = nr_irqs;
+
+	/* If nr_irqs is zero, indicate it in flag and set to max range possible */
+	if (nr_irqs) {
+		ext_intc_element->nr_irqs = nr_irqs;
+	} else {
+		ext_intc_element->flag |= RISCV_ACPI_INTC_FLAG_PENDING;
+		ext_intc_element->nr_irqs = U32_MAX - ext_intc_element->gsi_base;
+	}
+
 	ext_intc_element->nr_idcs = nr_idcs;
 	ext_intc_element->id = id;
 	list_for_each_entry(node, &ext_intc_list, list) {
@@ -130,6 +157,13 @@ static int __init riscv_acpi_register_ext_intc(u32 gsi_base, u32 nr_irqs, u32 nr
 			break;
 	}
 
+	/* Adjust the previous node's GSI range if that has pending registration */
+	prev = list_prev_entry(node, list);
+	if (!list_entry_is_head(prev, &ext_intc_list, list)) {
+		if (prev->flag & RISCV_ACPI_INTC_FLAG_PENDING)
+			prev->nr_irqs = ext_intc_element->gsi_base - prev->gsi_base;
+	}
+
 	list_add_tail(&ext_intc_element->list, &node->list);
 	return 0;
 }
-- 
2.43.0


