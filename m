Return-Path: <linux-kernel+bounces-877034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56A9C1D060
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A3F405B04
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBE7359700;
	Wed, 29 Oct 2025 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gSE+PdzV"
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B3F3590D8
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766590; cv=none; b=PgCNlUz/w7ib/85WlWDA6//t9nTvvQ40JQEK75d6Al2vGR/iJZiWuLnb7BimdSSbt9G+y8VwsbbcJwwNVZtIFu7hk/45YyzME24lVxA9PL3bHthozfY2ovKkiIpyvRwRQWCGoPaf50YTVQ/qyJ2eVvUuQzJW0TyxlpSlpDDGyrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766590; c=relaxed/simple;
	bh=FWnj7yWKTeYmwhieu9s9nCgdzdSjmS2ZaFuRcyk9uxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X5dLArfFlIshVe3R9jO6APhtHEJMNoBGvjttMdJHiWIRFoYE9RqrQ1VWFoIBqXmQG0BgkLVnB5BjK76ua0udHWaMLXIOBwGWaPaktAaSi90YxwkeQGQP3knVvtddcVeX5YukF6jm+ZbWqR+PI3LYszQPX2yLBBzbHMlufoCRLaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gSE+PdzV; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-63e336b1ac4so553927d50.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761766588; x=1762371388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qs94W/XWkVsQM8QXT0wY5HKWqWEfFFstbFkTTTBpc24=;
        b=c9sHgMGDOKByvFC6KjJkas5ep7TnPkygt35DccFWUyNvYL0ySvTDCgzAXqhEi7ilYW
         BYXfy/H4A/IDCoNidBsTzrGL9wUh89CD5jFgQ6rAH4r/7WZPJMCNkBo17D8jWfgZvso8
         gjA7r+KB53+jjbZ44oYZBVkHAmAqtyln5iz8ljfoeE8+YNodGzsQ/EiW2Rm7vmWdS1yG
         RnFqAXwKVFIzQPKauv8ZpOMVuvgIayw94uM7/Tf1PENe9PTqrxMuXWQfP+qD5Xk2Zp6S
         ThC5/TKwN9UMWtsBcpImrs4sht2hzlemHZrEQlMW/OmrezzkbNamV/LzsXq6UYdEw3cJ
         ZfIw==
X-Forwarded-Encrypted: i=1; AJvYcCWwjvb+93lPXlgpqRMs1qB44Mml8cLnLUGJS6cbPlNOkPhfwqZEK0KuMUugij+YLD0KI8TQ43PMYWSzVoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq2cX3LKJfub8ze20r2j52HlNQ7IokiLheSarznTasW7eNbALJ
	HdgN65tf1vuiXO6eLSNb26AYEvbrrDsMPaegF8VhU5RIEHrEzmu2YZUKnd5M7V/MtKgpvK5bh5C
	GDUBnY1yERh/qqhuE+mReRkdO5ou8ti64rj1pVbtjQgd0KFuO/SvzP3wnRzF4BPWiU3G6wVOjbY
	k0JrFD42eHbETz80rkAxAsaSJkpgBWkH5SOVlTk54o88NoXoIbVxykaayVE3Lh6eNFHfwgF9V5p
	UfYwZiO3KTJ7OGtg1UF
X-Gm-Gg: ASbGnctWBQlFXYkQ/a6+wkakJYtMH+6+wEEWo8AM4XsiZ2QbdVN5QdkT6uGDjVPAGE0
	AZdKClyzJE9IRGKXMvvzzSiLisQt3waXkwGuqF4fOjkGnqmpfzzMJxRVQwH7kmtZPOQL+jtARqW
	4RcrEzbVu5X8hXn5CAUh4Hy0xEWiJFae39RhGK2QJ/mbEH5UZ3wxeiSID6ptlEJLnaYUCRsGsPw
	+VQ9gLTL6Ora4OHc5DeJhPm+EXeOzt6KsJrWYh1tji2mLzgKloG+evi+zu20H0NL4q+G54JMKCq
	Dgfmm0KmfC1BMnPr9ZdaUW+YStLxYrGkRDXJ5g2LTLL9ZbHRkn72wNpvuq2ubO/tjyXSaWorI6r
	3tjL+Avm9kwZtKnvVbYigh2a8p23H5WvCZ0aL/nk6IhAEAbY85hrgXbedhSvOOMv8xUzGeVMCSB
	DmpRJYYeAriKOcVBxFEq8vKa7dxWYfY9Cc2zg=
X-Google-Smtp-Source: AGHT+IH++fvnaUy73vIiQjdh5qPFe5uI2f0sqI3vL0vWp/kewXdjzZSpVYWrWwslq9nRcHUsYL5X3zincZSA
X-Received: by 2002:a53:acd2:0:20b0:63d:314d:23d3 with SMTP id 956f58d0204a3-63f828e81b5mr594624d50.3.1761766587913;
        Wed, 29 Oct 2025 12:36:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-63f4c3be96csm1129228d50.3.2025.10.29.12.36.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2025 12:36:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-79e43c51e6fso167195b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761766587; x=1762371387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qs94W/XWkVsQM8QXT0wY5HKWqWEfFFstbFkTTTBpc24=;
        b=gSE+PdzVu5cA6cwDbldBlwGADWwIGBjsU0Cx8Z/qFI9nCIVurWf59m2T5IreSENTtq
         /IAVr+PDDvYM3k9Y4AFA5qBZHYia7Q9PTkxvDqXnvusxii8LWhwBazN7qHiXqeWQeLRN
         E7DgFEeHciZP/Ouw66PhWXwgS757WrAmU9WwE=
X-Forwarded-Encrypted: i=1; AJvYcCVY4AW4XlFvDm3pZZLg3weMxbN7uqLriSeV/0C79RhGbPJT91HN7G5SVcNezHYEcJKmsgLhY1B0Tk9zeTo=@vger.kernel.org
X-Received: by 2002:a05:6a00:12d0:b0:77d:98ee:e1c5 with SMTP id d2e1a72fcca58-7a615f6d321mr755382b3a.15.1761766586599;
        Wed, 29 Oct 2025 12:36:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:12d0:b0:77d:98ee:e1c5 with SMTP id d2e1a72fcca58-7a615f6d321mr755353b3a.15.1761766586139;
        Wed, 29 Oct 2025 12:36:26 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140a0d47sm15895260b3a.73.2025.10.29.12.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 12:36:25 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/2] PCI: brcmstb: Add panic/die handler to driver
Date: Wed, 29 Oct 2025 15:36:15 -0400
Message-Id: <20251029193616.3670003-3-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029193616.3670003-1-james.quinlan@broadcom.com>
References: <20251029193616.3670003-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Whereas most PCIe HW returns 0xffffffff on illegal accesses and the like,
by default Broadcom's STB PCIe controller effects an abort.  Some SoCs --
7216 and its descendants -- have new HW that identifies error details.

This simple handler determines if the PCIe controller was the cause of the
abort and if so, prints out diagnostic info.  Unfortunately, an abort still
occurs.

Care is taken to read the error registers only when the PCIe bridge is
active and the PCIe registers are acceptable.  Otherwise, a "die" event
caused by something other than the PCIe could cause an abort if the PCIe
"die" handler tried to access registers when the bridge is off.

Example error output:
  brcm-pcie 8b20000.pcie: Error: Mem Acc: 32bit, read, @0x38000000
  brcm-pcie 8b20000.pcie:  Type: TO=0 Abt=0 UnspReq=1 AccDsble=0 BadAddr=0

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 160 +++++++++++++++++++++++++-
 1 file changed, 158 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 9f1f746091be..67e73607f0ed 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -14,15 +14,18 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
+#include <linux/kdebug.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/msi.h>
+#include <linux/notifier.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
+#include <linux/panic_notifier.h>
 #include <linux/pci.h>
 #include <linux/pci-ecam.h>
 #include <linux/printk.h>
@@ -32,6 +35,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/types.h>
 
 #include "../pci.h"
@@ -156,8 +160,40 @@
 #define  MSI_INT_MASK_SET		0x10
 #define  MSI_INT_MASK_CLR		0x14
 
+/* Error report registers */
+#define PCIE_OUTB_ERR_TREAT				0x6000
+#define  PCIE_OUTB_ERR_TREAT_CONFIG		0x1
+#define  PCIE_OUTB_ERR_TREAT_MEM			0x2
+#define PCIE_OUTB_ERR_VALID				0x6004
+#define PCIE_OUTB_ERR_CLEAR				0x6008
+#define PCIE_OUTB_ERR_ACC_INFO				0x600c
+#define  PCIE_OUTB_ERR_ACC_INFO_CFG_ERR			BIT(0)
+#define  PCIE_OUTB_ERR_ACC_INFO_MEM_ERR			BIT(1)
+#define  PCIE_OUTB_ERR_ACC_INFO_TYPE_64			BIT(2)
+#define  PCIE_OUTB_ERR_ACC_INFO_DIR_WRITE		BIT(4)
+#define  PCIE_OUTB_ERR_ACC_INFO_BYTE_LANES		0xff00
+#define PCIE_OUTB_ERR_ACC_ADDR				0x6010
+#define PCIE_OUTB_ERR_ACC_ADDR_BUS			0xff00000
+#define PCIE_OUTB_ERR_ACC_ADDR_DEV			0xf8000
+#define PCIE_OUTB_ERR_ACC_ADDR_FUNC			0x7000
+#define PCIE_OUTB_ERR_ACC_ADDR_REG			0xfff
+#define PCIE_OUTB_ERR_CFG_CAUSE				0x6014
+#define  PCIE_OUTB_ERR_CFG_CAUSE_TIMEOUT		BIT(6)
+#define  PCIE_OUTB_ERR_CFG_CAUSE_ABORT			BIT(5)
+#define  PCIE_OUTB_ERR_CFG_CAUSE_UNSUPP_REQ		BIT(4)
+#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_TIMEOUT		BIT(2)
+#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_DISABLED		BIT(1)
+#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_64BIT		BIT(0)
+#define PCIE_OUTB_ERR_MEM_ADDR_LO			0x6018
+#define PCIE_OUTB_ERR_MEM_ADDR_HI			0x601c
+#define PCIE_OUTB_ERR_MEM_CAUSE				0x6020
+#define  PCIE_OUTB_ERR_MEM_CAUSE_TIMEOUT		BIT(6)
+#define  PCIE_OUTB_ERR_MEM_CAUSE_ABORT			BIT(5)
+#define  PCIE_OUTB_ERR_MEM_CAUSE_UNSUPP_REQ		BIT(4)
+#define  PCIE_OUTB_ERR_MEM_CAUSE_ACC_DISABLED		BIT(1)
+#define  PCIE_OUTB_ERR_MEM_CAUSE_BAD_ADDR		BIT(0)
+
 #define  PCIE_RGR1_SW_INIT_1_PERST_MASK			0x1
-#define  PCIE_RGR1_SW_INIT_1_PERST_SHIFT		0x0
 
 #define RGR1_SW_INIT_1_INIT_GENERIC_MASK		0x2
 #define RGR1_SW_INIT_1_INIT_GENERIC_SHIFT		0x1
@@ -306,6 +342,8 @@ struct brcm_pcie {
 	bool			ep_wakeup_capable;
 	const struct pcie_cfg_data	*cfg;
 	bool			bridge_in_reset;
+	struct notifier_block	die_notifier;
+	struct notifier_block	panic_notifier;
 	spinlock_t		bridge_lock;
 };
 
@@ -1731,6 +1769,118 @@ static int brcm_pcie_resume_noirq(struct device *dev)
 	return ret;
 }
 
+/* Dump out PCIe errors on die or panic */
+static int brcm_pcie_dump_err(struct brcm_pcie *pcie,
+			       const char *type)
+{
+	void __iomem *base = pcie->base;
+	int i, is_cfg_err, is_mem_err, lanes;
+	const char *width_str, *direction_str;
+	u32 info, cfg_addr, cfg_cause, mem_cause, lo, hi;
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+	unsigned long flags;
+	char lanes_str[9];
+
+	spin_lock_irqsave(&pcie->bridge_lock, flags);
+	/* Don't access registers when the bridge is off */
+	if (pcie->bridge_in_reset || readl(base + PCIE_OUTB_ERR_VALID) == 0) {
+		spin_unlock_irqrestore(&pcie->bridge_lock, flags);
+		return NOTIFY_DONE;
+	}
+
+	/* Read all necessary registers so we can release the spinlock ASAP */
+	info = readl(base + PCIE_OUTB_ERR_ACC_INFO);
+	is_cfg_err = !!(info & PCIE_OUTB_ERR_ACC_INFO_CFG_ERR);
+	is_mem_err = !!(info & PCIE_OUTB_ERR_ACC_INFO_MEM_ERR);
+	if (is_cfg_err) {
+		cfg_addr = readl(base + PCIE_OUTB_ERR_ACC_ADDR);
+		cfg_cause = readl(base + PCIE_OUTB_ERR_CFG_CAUSE);
+	}
+	if (is_mem_err) {
+		mem_cause = readl(base + PCIE_OUTB_ERR_MEM_CAUSE);
+		lo = readl(base + PCIE_OUTB_ERR_MEM_ADDR_LO);
+		hi = readl(base + PCIE_OUTB_ERR_MEM_ADDR_HI);
+	}
+	/* We've got all of the info, clear the error */
+	writel(1, base + PCIE_OUTB_ERR_CLEAR);
+	spin_unlock_irqrestore(&pcie->bridge_lock, flags);
+
+	dev_err(pcie->dev, "reporting PCIe info which may be related to %s error\n", type);
+	width_str = (info & PCIE_OUTB_ERR_ACC_INFO_TYPE_64) ? "64bit" : "32bit";
+	direction_str = str_read_write(!(info & PCIE_OUTB_ERR_ACC_INFO_DIR_WRITE));
+	lanes = FIELD_GET(PCIE_OUTB_ERR_ACC_INFO_BYTE_LANES, info);
+	for (i = 0, lanes_str[8] = 0; i < 8; i++)
+		lanes_str[i] = (lanes & (1 << i)) ? '1' : '0';
+
+	if (is_cfg_err) {
+		int bus = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_BUS, cfg_addr);
+		int dev = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_DEV, cfg_addr);
+		int func = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_FUNC, cfg_addr);
+		int reg = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_REG, cfg_addr);
+
+		dev_err(pcie->dev, "Error: CFG Acc, %s, %s (%04x:%02x:%02x.%d) reg=0x%x, lanes=%s\n",
+			width_str, direction_str, bridge->domain_nr, bus, dev, func,
+			reg, lanes_str);
+		dev_err(pcie->dev, " Type: TO=%d Abt=%d UnsupReq=%d AccTO=%d AccDsbld=%d Acc64bit=%d\n",
+			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_TIMEOUT),
+			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ABORT),
+			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_UNSUPP_REQ),
+			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_TIMEOUT),
+			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_DISABLED),
+			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_64BIT));
+	}
+
+	if (is_mem_err) {
+		u64 addr = ((u64)hi << 32) | (u64)lo;
+
+		dev_err(pcie->dev, "Error: Mem Acc, %s, %s, @0x%llx, lanes=%s\n",
+			width_str, direction_str, addr, lanes_str);
+		dev_err(pcie->dev, " Type: TO=%d Abt=%d UnsupReq=%d AccDsble=%d BadAddr=%d\n",
+			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_TIMEOUT),
+			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_ABORT),
+			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_UNSUPP_REQ),
+			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_ACC_DISABLED),
+			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_BAD_ADDR));
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int brcm_pcie_die_notify_cb(struct notifier_block *self,
+				   unsigned long v, void *p)
+{
+	struct brcm_pcie *pcie =
+		container_of(self, struct brcm_pcie, die_notifier);
+
+	return brcm_pcie_dump_err(pcie, "Die");
+}
+
+static int brcm_pcie_panic_notify_cb(struct notifier_block *self,
+				     unsigned long v, void *p)
+{
+	struct brcm_pcie *pcie =
+		container_of(self, struct brcm_pcie, panic_notifier);
+
+	return brcm_pcie_dump_err(pcie, "Panic");
+}
+
+static void brcm_register_die_notifiers(struct brcm_pcie *pcie)
+{
+	pcie->panic_notifier.notifier_call = brcm_pcie_panic_notify_cb;
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &pcie->panic_notifier);
+
+	pcie->die_notifier.notifier_call = brcm_pcie_die_notify_cb;
+	register_die_notifier(&pcie->die_notifier);
+}
+
+static void brcm_unregister_die_notifiers(struct brcm_pcie *pcie)
+{
+	unregister_die_notifier(&pcie->die_notifier);
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &pcie->panic_notifier);
+}
+
 static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 {
 	brcm_msi_remove(pcie);
@@ -1749,6 +1899,9 @@ static void brcm_pcie_remove(struct platform_device *pdev)
 
 	pci_stop_root_bus(bridge->bus);
 	pci_remove_root_bus(bridge->bus);
+	if (pcie->cfg->has_err_report)
+		brcm_unregister_die_notifiers(pcie);
+
 	__brcm_pcie_remove(pcie);
 }
 
@@ -1849,6 +2002,7 @@ static const struct pcie_cfg_data bcm7216_cfg = {
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
 	.has_phy	= true,
 	.num_inbound_wins = 3,
+	.has_err_report = true,
 };
 
 static const struct pcie_cfg_data bcm7712_cfg = {
@@ -2023,8 +2177,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (pcie->cfg->has_err_report)
+	if (pcie->cfg->has_err_report) {
 		spin_lock_init(&pcie->bridge_lock);
+		brcm_register_die_notifiers(pcie);
+	}
 
 	return 0;
 
-- 
2.34.1


