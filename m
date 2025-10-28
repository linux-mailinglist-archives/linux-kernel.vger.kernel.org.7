Return-Path: <linux-kernel+bounces-874125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB0CC15982
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827374024C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E6822A4F8;
	Tue, 28 Oct 2025 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxJjBx8r"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EF533DEFF
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666167; cv=none; b=tHydyIE9vXelk8+D3daatS4xDMpDwqUcqXyVhAYzkDQX2MdsnRICZfYOw0sk36WdCgxChDyx+sSmEPGlZ+PyPpT0EfHR3EmffZW0ummd/L9qXlPnLUan1RA6LMNI/z+5SwSr00pEA+fzUZsUZ/O5p/mRxFrbXo3YDUldnNJxnmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666167; c=relaxed/simple;
	bh=SRGxbsGV3MJee1qdQ/T8atB44Y+1gaZj7JGcpj8g8m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvnjLNf0IyacVjtB1wm4/UmpajiySf6nMlILE672gAxFQj4WlZ8VsfVKCZGQHe3TaQpAvB/gwWtmnbtl1J6PcF9uEO+PCzxi5G1UBAIWMGI6MYxlp1rkG7Jo0qKFf2D7Hx4ag/G/au681vAVtSgzXpw3pPmUHju/PBgVOouIbUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxJjBx8r; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27ee41e074dso64290875ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761666165; x=1762270965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ATRw3tFFmEK1zPWNKP140zh9kBKwr+zrf40M6SOBpU=;
        b=LxJjBx8r/n5BnwpBeOrRrd+RdhA8sFNosGaPFphB/B7SMf92Cgxp6v2ck3MicJUhIW
         mR8YFkF+doM7kJmKEKfM8ggJR1pGe5d2SFWsYUKZUpnWx9o6H25EGhCOWzaUOtpTh3lA
         Uy5uEpohIrprib3l2KtYCNQuHMhdmmUDHVoAnLFbuFVDgVYAwHrA1sKtD7rptACXRzMA
         iwCOj+I4AgG8sQU/ql68sqvSXPXr+AH9LwnXwDkdU4UaeYaoh4+gU/REmwSxhIue7fWD
         Puyq4FyEk5bPIK7GXmuRCAR1BmwclZFKvUvPLxPFtfuCLzRIgEJ6sBEMsqD/m0/1axmS
         ODaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666165; x=1762270965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ATRw3tFFmEK1zPWNKP140zh9kBKwr+zrf40M6SOBpU=;
        b=i/EBAKWShHE4YXItVH9/peiT4CETAFXEIXUGRJbL2VgoCAnCxxCLbEWblbPy0Cujab
         ijPTXk9w/IavluebKOF+04fey8E74dMU74h2fQTwoLfph6+A77/qphheQPqVov8313Yx
         bwAHWh8crX5zqL/jAyy4Ia5Z55f2pq9WpTfYP/0qPbuhDEEXi8Z7hFHFshCp9brNwYt1
         6AYrhzNduyRpzGh6BoNPV7enRQixI/FIhqGi+tZFlOJ7TAN+3pve10Vw9mZUiviN76ei
         S1U2I7BKg0zYlPkUHhfr5T8cZO6ih3JpcHLhxuMHxNYi+qmLhVEBTNNMskezWAZjuWr8
         uLRA==
X-Forwarded-Encrypted: i=1; AJvYcCWoSNy9pUTC4hlShnNhoHN2lIb5M8ZG5mtsA8ffqkLkK+MetPQ/D4mFiORJozuGT6+qM12gIHFgkqPajpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkclgfaJN2Qo668dKmecGtwsOS28MA+ikzlhS6WqjKAMDsEMHv
	FqE1AqC+FQKAFK2EzKySl7gULasEylUdHyDLfWjS/A+UjO+j/lFT6T6B
X-Gm-Gg: ASbGncsy/1kR3Ob4SitsFAlb8Eb2Zeo7L0ZNoe6TmL4YTIBgccqwFoG8QrFRmB0NY2g
	QFHbw6ib6t/6gIuu0RTRBjy7/GzT7emMAibuG+igN8B6yfANaDMbNe3qpipCIoi0rhelDPTbFbK
	QrgxRoxq4bsDuh8OAYkQGNojHzXMdmkPB/kS4t8zhmGxRkYAF3tI2nBoGKR9IrJ+agP6jkvV7bf
	kS7pKeVAIaH9hW4IWSmhBCzLnvKfiE9ESC8fZAM/kCqJ6qTCbBY3bakzfmXms008yB7fwlpqx4N
	7JyV15tjip/ncibZDYn/1WehVcYmctqhl4rjNHN29MJgkOFIrocHNRATBTUabh2gLPE0z9GnIwF
	mZuEmc6XoMwlhh5AcJg/SqHr9C+/Fdbdhw/5GXZe+07jKI89WvY2Dv6rdKvGvGhxWGtbM9Tjg3w
	==
X-Google-Smtp-Source: AGHT+IFX1XKPhnz3Nfvrc+6BGz+aJT/D7E5JuxSlko5PpiJVk9W0Dbe0cl4ODkgGZEnXaVBp1Weykg==
X-Received: by 2002:a17:903:2348:b0:24c:cca1:7cfc with SMTP id d9443c01a7336-294cb6756bdmr53895455ad.59.1761666164805;
        Tue, 28 Oct 2025 08:42:44 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0a4d9sm119815145ad.37.2025.10.28.08.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:42:44 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-omap@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v3 1/2] PCI: j721e: Use devm_clk_get_optional_enabled() to get the clock
Date: Tue, 28 Oct 2025 21:12:23 +0530
Message-ID: <20251028154229.6774-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028154229.6774-1-linux.amoon@gmail.com>
References: <20251028154229.6774-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_clk_get_optional_enabled() helper instead of calling
devm_clk_get_optional() and then clk_prepare_enable(). It simplifies
the clk_prepare_enable() and clk_disable_unprepare() with proper error
handling and makes the code more compact.
The result of devm_clk_get_optional_enabled() is now assigned directly
to pcie->refclk. This removes a superfluous local clk variable,
improving code readability and compactness. The functionality
remains unchanged, but the code is now more streamlined.

Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v4: Add Rb Siddharth
---
 drivers/pci/controller/cadence/pci-j721e.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 5bc5ab20aa6d..a88b2e52fd78 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -479,7 +479,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	struct cdns_pcie_ep *ep = NULL;
 	struct gpio_desc *gpiod;
 	void __iomem *base;
-	struct clk *clk;
 	u32 num_lanes;
 	u32 mode;
 	int ret;
@@ -603,19 +602,13 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 			goto err_get_sync;
 		}
 
-		clk = devm_clk_get_optional(dev, "pcie_refclk");
-		if (IS_ERR(clk)) {
-			ret = dev_err_probe(dev, PTR_ERR(clk), "failed to get pcie_refclk\n");
+		pcie->refclk = devm_clk_get_optional_enabled(dev, "pcie_refclk");
+		if (IS_ERR(pcie->refclk)) {
+			ret = dev_err_probe(dev, PTR_ERR(pcie->refclk),
+					    "failed to enable pcie_refclk\n");
 			goto err_pcie_setup;
 		}
 
-		ret = clk_prepare_enable(clk);
-		if (ret) {
-			dev_err_probe(dev, ret, "failed to enable pcie_refclk\n");
-			goto err_pcie_setup;
-		}
-		pcie->refclk = clk;
-
 		/*
 		 * Section 2.2 of the PCI Express Card Electromechanical
 		 * Specification (Revision 5.1) mandates that the deassertion
@@ -629,10 +622,8 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		}
 
 		ret = cdns_pcie_host_setup(rc);
-		if (ret < 0) {
-			clk_disable_unprepare(pcie->refclk);
+		if (ret < 0)
 			goto err_pcie_setup;
-		}
 
 		break;
 	case PCI_MODE_EP:
@@ -679,7 +670,6 @@ static void j721e_pcie_remove(struct platform_device *pdev)
 
 	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
 
-	clk_disable_unprepare(pcie->refclk);
 	cdns_pcie_disable_phy(cdns_pcie);
 	j721e_pcie_disable_link_irq(pcie);
 	pm_runtime_put(dev);
-- 
2.50.1


