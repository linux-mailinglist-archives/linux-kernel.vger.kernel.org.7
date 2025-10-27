Return-Path: <linux-kernel+bounces-871172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5333C0C911
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6E8188562D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A4E7263B;
	Mon, 27 Oct 2025 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMV1rXdU"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0602F9DAA
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555814; cv=none; b=UKIi6Ny0uZV1Q0cU++RoSh/kMFIDFs4ofuDEZ/LxhzokjGII1YIuTct8h1t2fZf/4VACHd9LrAYZwz4g6J/Cpwb2dX8pJnqHRcSwi53U4siAK+u3mrCArWWYUMDDkmMkmOo1xIhFcBqNs/TRM3OpQr8mbrVyY9+INsdN4tkJ130=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555814; c=relaxed/simple;
	bh=OvUDbo5pGuUu7qotyzejFUWD0f6M8h+6eVPsJH2aFMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxYfWRtkx1oGLKoCbjp2wNB3OwzAz2yfM9wcNH4/5WIIiA0+wkQawgQDHYg0rifCa49+sXKBB3YclY3tVDjFVwmsc0WsHFWdAdtW1WkZaH8DCNbZz/R0lnja9LlR7WqyFBvSdC/J4ZJBF194H/Hop35w8QJl52D+bZl9/1aQIZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMV1rXdU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-28a5b8b12a1so44679285ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761555812; x=1762160612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoTpyL8LPqpthgwVzy0CiG0xAa+lw5VtWyKYbKOT8QE=;
        b=dMV1rXdUJDSL7ZIEqmUbuTc4SonyFxw7qN50GjxH3wPhCs8Sv8qiPUZ1azC+us72AI
         FOnyGPVBRD1T9VQxK0Z8G971Hrn/Q1NsDXCPLovscO1GEn5/V46aaiBtQJ4lWLYtaaCZ
         adDgsxrjKq6tPoJQoDK6ng6WZYHZgIDfmUK3vcyqKjpRgmd7ra3EUu28jyXTP+GDf5Kh
         IPEMYq2mX2x9XMiPtMuI+Jg94aBUu0ui9LGLtvx2f8FSEPYzWGh5tr9kYlzrbw5TSQdt
         /cizUhs7mo7MLLayxQt8GnyRmEN8l2GfC41DfIezpWurU+yrUTnesMbpf+zYLOMphrv8
         slVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761555812; x=1762160612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoTpyL8LPqpthgwVzy0CiG0xAa+lw5VtWyKYbKOT8QE=;
        b=o/AAEKzkWWmNROcvuV9nRj7wmuYrkDn728W7PUlzjdR+gVB3Db/C146gGm5PT2y3Fm
         9JhPGICalbTD3wmtS3AtEiw4a3ipqY4mg9Yw0pz6zappC1TRODK/sUGWNHYooDm5uRBG
         NciE7fYAohw7QZWnarxuMhqCgQvnvLyv/nV2nReRjzK6OFWoSHMTXrBIG67e2nv19Lc1
         n13XtRrK1/6rkGeWTZ3azc611fzTyszHwAT2OEqnbkoaZr67MhvDvzCf69ZiBVA3H80b
         QeQ7gRAwFX0KTcW2lqCI1jnsP3vaa4gK/KFd9fFiA6COFp/vnXs8RPsHJZEn3l0VbTMm
         Hswg==
X-Forwarded-Encrypted: i=1; AJvYcCW86dEvNCSADLiamHAmsiE1hayZRk5CWQC2N2FlEFibnp6MA1QflRBoMO/tGfy1xzM/iovox+v8B9GCWik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc/0NKESlMkEzqbmC78sSDmhgsuA7cvglE5ODFsVd0aIfSgB0X
	hc6jx0UDbtnHVjEyOEv2Ox0MSV3baJY+z4tqitrTB96zFoiqgO/xq6dm
X-Gm-Gg: ASbGnctmSsyEt+kVbUI3q8o296HkQ22RGJir1DYp6QXvirmLDOY69HV3mFCm1nKePLZ
	bmYKnEtB4sG09jL0/al8vhRQDH5mPjG3k7MqHEUcpMy9IvYptLmxlJ2gknVBQnpwdLDdxhbXW16
	J1S6zHJ7/9wateMAI/zgFc6rjS7d5uOV1PxUJ1JTEPCrq6dQxBt5HbkKvbsin16wFboDWaobdkh
	d8UZzOpm62y38M0z7LnLLI0rLzNDQHWn4Kgx4SvjtBmm/qep/e5oTbW0GiBWYfj+quiNnilnJZQ
	woehfdypPTgIAkmQzMMNnkPf4Hg4YFTDyX6tWEctCiRKlCAu2SixFeLkiAOFIk4UZQM+zUI3+w9
	GSpzGStxvwG9EMjgqnz8SGol+6GXKcBrPtDSguf6LSUDFuXvvh7uFC8UARwXqK6RS0/G+njuXzC
	KtqRivy6HF/WNi81ioSA4=
X-Google-Smtp-Source: AGHT+IGXwneCAjsjJPL0hWiNqGqUVbp6EE3p4IZGCMQRdN0SZJ+QzldDOpFCpQQntrr/66rhZtbW2Q==
X-Received: by 2002:a17:902:e944:b0:290:b14c:4f36 with SMTP id d9443c01a7336-290cba4edaemr464679185ad.31.1761555812013;
        Mon, 27 Oct 2025 02:03:32 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3433sm73881335ad.21.2025.10.27.02.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:03:31 -0700 (PDT)
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
Subject: [PATCH v3 2/2] PCI: j721e: Use inline reset GPIO assignment and drop local variable
Date: Mon, 27 Oct 2025 14:33:06 +0530
Message-ID: <20251027090310.38999-3-linux.amoon@gmail.com>
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

The result of devm_gpiod_get_optional() is now assigned directly
assigned to pcie->reset_gpio. This removes a superfluous local gpiod
variable, improving code readability and compactness. The functionality
remains unchanged, but the code is now more streamlined

Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index a88b2e52fd78..ecd1b0312400 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -477,7 +477,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	struct j721e_pcie *pcie;
 	struct cdns_pcie_rc *rc = NULL;
 	struct cdns_pcie_ep *ep = NULL;
-	struct gpio_desc *gpiod;
 	void __iomem *base;
 	u32 num_lanes;
 	u32 mode;
@@ -589,12 +588,12 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 	switch (mode) {
 	case PCI_MODE_RC:
-		gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
-		if (IS_ERR(gpiod)) {
-			ret = dev_err_probe(dev, PTR_ERR(gpiod), "Failed to get reset GPIO\n");
+		pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+		if (IS_ERR(pcie->reset_gpio)) {
+			ret = dev_err_probe(dev, PTR_ERR(pcie->reset_gpio),
+					    "Failed to get reset GPIO\n");
 			goto err_get_sync;
 		}
-		pcie->reset_gpio = gpiod;
 
 		ret = cdns_pcie_init_phy(dev, cdns_pcie);
 		if (ret) {
@@ -616,9 +615,9 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		 * This shall ensure that the power and the reference clock
 		 * are stable.
 		 */
-		if (gpiod) {
+		if (pcie->reset_gpio) {
 			msleep(PCIE_T_PVPERL_MS);
-			gpiod_set_value_cansleep(gpiod, 1);
+			gpiod_set_value_cansleep(pcie->reset_gpio, 1);
 		}
 
 		ret = cdns_pcie_host_setup(rc);
-- 
2.50.1


