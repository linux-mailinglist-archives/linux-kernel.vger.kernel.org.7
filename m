Return-Path: <linux-kernel+bounces-852465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E42BD90DB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23601924647
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A3D30FF00;
	Tue, 14 Oct 2025 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccpaD//s"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F39F30F81C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441578; cv=none; b=nl435Vfcz9rTNh3zb3KtNgWAd7WbblGbVQwph/rd+58G8lgrLhNE6BBODv6wA/KwCV6ZQ+umXsj/ZUUJF9Z/uUXV1TZailKgs8Fykjhi8NDf5izWyVy008ohGvtxFwI6rDP4sUp4gh7u+V0EnB+k3lw0N6ig/JTduyUu6m3OROc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441578; c=relaxed/simple;
	bh=PoKOs9TgSjfkqiMX2+2Ly0Vb1OFpd3epTvsXddSqn5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ojaLN1aN0hLo/yPuKVsv3BLgKS3lK43WsMz2iJfVFtzBUQUmLS/uE2Wt/tOM6KGYhkkgRUx6ptJ6j/D2zqA+kwTWuTFYk2iXzuAyGG+c/99kA+slIKbtHopsCbyZ1Z3yJiv7F+M+gIjJyfGuSWqkZjeFATIvsCToPJerj5n0cBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccpaD//s; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso482464b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441576; x=1761046376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7UerwX9ObkYiq6vERvNVgcsL6sbi2km2IZoP2hNgnA=;
        b=ccpaD//spzzaSxtfpn3a98ddUjjV4cDzVLsd6W4R+fWzJVH62b33RPfUti9wtAaMQ7
         qbe560HBwhjH4dJLIZmhmErnseh4HF1OtaoPuw//OFfhUD+ciFhLPIHrny/6qhTYKEv9
         LVvJcqFHWqG37vPIBWYgtU6awZE3g4whDYHnswG5xbI0XOo/NVDxp36m3APC2nq6ElOy
         eAkCG/m2qDjNckqrJ3A3M2KpcSf8FNMySAe8gNopyGWEzqhEq2srdvy6aYUgREiFEBkU
         XStKv/DCCCTnJUEO90DJH+znobht6GOC6v9MXKsVK3/fQxl7OS/OEpB14gLC+ld0XPnW
         i2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441576; x=1761046376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7UerwX9ObkYiq6vERvNVgcsL6sbi2km2IZoP2hNgnA=;
        b=WRYvfpCk09VLD9lbDy+GH9XUy1tJG5rdT2FRc409hHyPEeGRunmRM+b9VtK/xwgRZn
         cjSswu284J2gSs9wJJw7w5B628/EPazcwDraLrCgOdzjOZH8gcF6KoYHPzEaurR5ygy0
         aeHtFG6P4FXbAPC0AubJdVwqxDUcYyeWLkHVUC2jirMEf9CNx7nCRBDi1BeuQQEaH1mC
         KxXzOWy4FpcLStJxW4vzqn2OVm8jFHQL/dgxaE2h3H6PK6S+4KEaD3638EbnRfLS1esf
         vujdSAvUgMOnXWgwEKHVWxgllk0pePq2MppqZ5/4iRikt6BTJnnAoaF4KVy1KvDdTv4N
         FjgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIoaarImFRWR2GhBlKUH+V7EX1vLNUFG/rIxyf14qawWu4w0/X9zcbz5ZofVaMtBGsh8zNQyPPnPpTSww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf461euZKhtz7sii4gNmQPpjIJpHSWEUS9fr7nRwGDJCcN5g+7
	uZInKQY3nK28ZW1FQ4c7HO7q3j2wglNiIv9/lXOq0nZArRee/zEQiHH3
X-Gm-Gg: ASbGncvM6e28k0B1wI6oU6f11pbSJqr1KsFSfbW/vH7DC6/XLm2i9iaO1tnxBLTAhU0
	muPmeX19MG3vtYRUntQF63/aNo5U8Qw8jW05jKNouR7kdT5DsS7d33TLMAfUGiZIiZ/z56wCtRC
	+T8FyIShftaOc/0SC/9OOGwKmzuvbWiZ8vpYgNNAQGDTy9deyiPVcf2SviyaZ1VDpTEWjyaHc7i
	kpXwJyoGVVvNAf6wKUBHAUif3nnTjrBsfccj7WJT7KHB+oTSDQj9kGciFRlASdTjPXB4EgjmEri
	2DETpw71sldHMuSLzxDxQVuTQLguwh3zYpUGXTEEPacT461LavF5xVsbpcThSa3YsPCI6JBBQxi
	NGwYhskln3fhQuvo4rzpk6dJCM2t6c+tugA8Vj1305nQ7eui0RA==
X-Google-Smtp-Source: AGHT+IFL/A1wjKWekovh/oihjR4JIjfCM839DB7WtztyHa+NpAIMVWIzCgumtsxtL4h7BgUTWYN4Fw==
X-Received: by 2002:a05:6a00:182a:b0:781:275a:29d9 with SMTP id d2e1a72fcca58-7938742c7aemr32083308b3a.18.1760441575343;
        Tue, 14 Oct 2025 04:32:55 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0965c3sm14871383b3a.52.2025.10.14.04.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:32:54 -0700 (PDT)
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
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 2/3] PCI: j721e: Use devm_clk_get_optional_enabled() to get the clock
Date: Tue, 14 Oct 2025 17:02:28 +0530
Message-ID: <20251014113234.44418-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251014113234.44418-1-linux.amoon@gmail.com>
References: <20251014113234.44418-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use devm_clk_get_optional_enabled() helper instead of calling
devm_clk_get_optional() and then clk_prepare_enable(). It simplifies
the error handling and makes the code more compact. This changes removes
the unnecessary clk variable and assigns the result of the
devm_clk_get_optional_enabled() call directly to pcie->refclk.
This makes the code more concise and readable without changing the
behavior.

Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v1: Drop explicit clk_disable_unprepare — handled by devm_clk_get_optional_enabled
    Since devm_clk_get_optional_enabled internally manages clk_prepare_enable and
    clk_disable_unprepare as part of its lifecycle, the explicit call to
    clk_disable_unprepare is redundant and can be safely removed.
---
 drivers/pci/controller/cadence/pci-j721e.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 9c7bfa77a66e..ed8e182f0772 100644
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
@@ -603,18 +602,11 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 			goto err_get_sync;
 		}
 
-		clk = devm_clk_get_optional(dev, "pcie_refclk");
-		if (IS_ERR(clk)) {
-			ret = dev_err_probe(dev, PTR_ERR(clk), "failed to get pcie_refclk\n");
-			goto err_pcie_setup;
-		}
-
-		ret = clk_prepare_enable(clk);
-		if (ret) {
+		pcie->refclk = devm_clk_get_optional_enabled(dev, "pcie_refclk");
+		if (IS_ERR(pcie->refclk)) {
 			ret = dev_err_probe(dev, ret, "failed to enable pcie_refclk\n");
 			goto err_pcie_setup;
 		}
-		pcie->refclk = clk;
 
 		/*
 		 * Section 2.2 of the PCI Express Card Electromechanical
@@ -630,7 +622,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 		ret = cdns_pcie_host_setup(rc);
 		if (ret < 0) {
-			clk_disable_unprepare(pcie->refclk);
 			goto err_pcie_setup;
 		}
 
@@ -679,7 +670,6 @@ static void j721e_pcie_remove(struct platform_device *pdev)
 
 	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
 
-	clk_disable_unprepare(pcie->refclk);
 	cdns_pcie_disable_phy(cdns_pcie);
 	j721e_pcie_disable_link_irq(pcie);
 	pm_runtime_put(dev);
-- 
2.50.1


