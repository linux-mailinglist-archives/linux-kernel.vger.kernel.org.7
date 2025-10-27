Return-Path: <linux-kernel+bounces-871171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC08EC0C920
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 622454F90A8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1D62F7AC3;
	Mon, 27 Oct 2025 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0t1wjFz"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D780B2F7471
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555809; cv=none; b=u/UReO05XbIaT+MPV9jn7DtGgVPHGb5H/sMpn+YQMwOhIIGKAFOlEtcKjYoKeLroCgg0uhW6dAWpYKfk9a2yrabmxrQoDqbB8G/oOlr8JiSLZuF64DG/cn0H0yuWqzq6XYfrQM/kOb+vC3h36Bb5ja/7z96xzyWxFeEfakHO06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555809; c=relaxed/simple;
	bh=eogBR5sxD05fZ6c/zTfkTbZBgKCFI/Gyw8bMtmzrf/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyvJjUH8ciTixcStJbhg62eZ8KkRhs8iw/KoE7AN8II3jCdT4iDMSXRCucUSybsUOGPuolaDgOx62hW5ZGh8xK9yysoamew7RTqY7zzihuJ5Smg7ZssLQvipaYupWd2uIcMImOT+nIahe4og8bvbaUdkzq+BuYzpkGAEplu2DKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0t1wjFz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-269af38418aso50250055ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761555806; x=1762160606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDCevJO/jn4uxha5g3iGQ0Gi4sz+BoDakhPsr84awrg=;
        b=P0t1wjFzzv8xKGXVHp5WRpuE+lUaI+Z7UVZ47m56PohjaWjv2M3CYbUvshRfsrF7tw
         BTyHijKitPi2zRGmHL9SADRQr3CBGAlbgNuT58FAtDVD2F3ywc844KtX7MsyFaamynL5
         XGQyPIS/nfjhiTcMdtO5r0NehjmnebDUOYnZbL1fBkW639zW8ihbP6HbcRKOUtTF2SqW
         pkMmsQkCDABRqrQ0lPSzJNlmshzaqSMqohmpUB3u291GjR71qsMqP9cGicDN55MYVdgM
         eHHr4JGG/m8rb7Mtz2uiA4wIWxlqvTsJz9Zf57sQ3eqUN05UQe12B/fLed1DvGb8CetI
         +wFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761555806; x=1762160606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDCevJO/jn4uxha5g3iGQ0Gi4sz+BoDakhPsr84awrg=;
        b=JuiXlzGn53qvWOhdyEPcsErbeeuHrZg3XMGlXmrTE8VXeTau4MFHjyxShO6a2CBCxE
         LlOTxkj3oEIru4DTfQmhm8nbMhnLX2HkE5IV7YkhHkhD0ktaBeCKukY+ZrefhUzI3mI7
         bUFvVE5dxQYbCxoObY3oBgbeUrt1e92vdbVDugUib/Gbu0sEW358Vqk7IULHrzBpsfAW
         PlolMtPEt9hhsbekRRHA1BGOJO1TIqJQR+kFtsw6voUN1hdT/97hU/eeFxEZxmXprYb6
         atcjRghEewKtIrmd6jrdPpnqp2ysdSn1OgciSr2KzpFhsMsem1Jj+M+6AglOujCc8tiU
         AsoA==
X-Forwarded-Encrypted: i=1; AJvYcCWvSz0tJQls3Q7xQMH8uVY8OrMir5QCIULua7n0drz6GUzdzVQJuxtDsE0BQq4rzuOPuOgKeZEjKBt0TIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4nTxqtE3GebE3jWtIzXJi8/tXKA8J4SmrEhZVOW6Wh2ry01rk
	f0zAeT+NYuENVzu7tkuZh0B5bs5VeZilXi4X30Ji2A2MtZRorWm/DeOu
X-Gm-Gg: ASbGncu1L1shBQc2pSSG/xqQbG4yDWZloXyehHI9Vmorfh5zly6Y921p9UY6cz2CFy1
	TVW6asnVwBaZM8t79nekAZO5dYKK6knvn2fGaYLqwvYG4Fcls/fTnd2aAJhP14/ZWbGOHBG1S0F
	19F12MEPZNhHQgQWkab8zHj9+43TLJdalA7MgG5ATnHWSJM5QnF9LHbhUGD19v1V2qLEUyF9Hq2
	4MdQSaFyBDxOXnZX0VlKKdjeIs5GcHL+w/lx/3OD7p/IkncEz0Gwa3BLCBl63jGa7tUm1r17DOf
	fo8kYsV6nSQ72x4rBCoeLqD+EdamGB53z368PNaSGREQr0XO2CKhGLLD5e02stU+fmWl0kwOjtM
	IU2N/t/4kT3Mmvebzv+BZ4wkpOsGVqduG/FhB4OR97au4rk2XwM66OZyTIqKZusYRalkQsKGEEC
	n+jQDs6tCbPuiyJFK6O2Y=
X-Google-Smtp-Source: AGHT+IHmIUD2h1GuwjjhJJdGb/O47J3PxX86EGpWbLGZgnTd2IndPXIXzCHY76GqEBfYMKQNDQz7ww==
X-Received: by 2002:a17:902:e84b:b0:290:c0ed:de42 with SMTP id d9443c01a7336-290caf8582emr559508755ad.36.1761555806053;
        Mon, 27 Oct 2025 02:03:26 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3433sm73881335ad.21.2025.10.27.02.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:03:25 -0700 (PDT)
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
Date: Mon, 27 Oct 2025 14:33:05 +0530
Message-ID: <20251027090310.38999-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251027090310.38999-1-linux.amoon@gmail.com>
References: <20251027090310.38999-1-linux.amoon@gmail.com>
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
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: Clock needs to be disabled on Suspend and enabled on Resume.
v2: Rephase the commit message and use proper error pointer
    PTR_ERR(pcie->refclk) to return error.
v1: Drop explicit clk_disable_unprepare as it handled by
    devm_clk_get_optional_enabled, Since devm_clk_get_optional_enabled
    internally manages clk_prepare_enable and clk_disable_unprepare
    as part of its lifecycle, the explicit call to clk_disable_unprepare
    is redundant and can be safely removed.
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


