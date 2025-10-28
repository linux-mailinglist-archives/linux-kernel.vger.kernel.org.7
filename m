Return-Path: <linux-kernel+bounces-874126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5001BC1594C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184951AA3075
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B99343D89;
	Tue, 28 Oct 2025 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrI2aTcl"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C46342CAE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666173; cv=none; b=pUqcssiIFz/hSRDJePyHB6jKu38EOjk6L2K/6KbdvnTc+bvMrc8o1U23wzzTGRwmynjPEYY9YPsT5JSs/Xkwya9FDiMZ9IEysUp/g45KvT7+M1ldk2gzmep9sgjaUN6OL8Xc6+2k/Ljuh4yYq+93+3tQl+RTXrXHPy4TMV3CI0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666173; c=relaxed/simple;
	bh=OI3lu8B52L8q6L1vFOQdjWWy8M0I5zST9cEyiMD60xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNhRs2jterYB4xzHPcmo40N2ZPtpCHPjrPXtcuAMfgxRAFwUmPkIcptzH/tlcVOwaFLY/6h8NVn20KWyr6MZJtoeBXwZ4/hcLnGNAz5E7ZgJY0QA3KkEjg8Ldqq+15C5Kvvkp7K3nZfXd9tiy6X+slOZMLLrWQjtjNRnVtmbL88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrI2aTcl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27d3540a43fso65035035ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761666171; x=1762270971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLSaa6PcadKxSJGpM5AYmWJ5bCIVBLv3q1JgPY8IHz0=;
        b=QrI2aTclbYq0rfsjN9ycJmngTtFlr0AradMDCAKvIVjxw2AaOVeBt3jmOYpq2axXxx
         K1c6uUyyXfbrQj0YWiZI/0DbD2pVpHkwGytyNb1pRGTm9SzvPViA0TMMGrdMjggGOLPz
         Y5UZNwWpHMXKRlRWz78I9CSxvIXuOi7ts/oBGhW9ue5jvJNdoFZLr5kZy+wHG+Ft6t0S
         6kHCBDATWCXXXvAaNSa+w1AKB1hjF+hoWZlD0pMYV43HkmHbrQVj1F2/UoVg1bMgIk1d
         Ep5eibff3VSADIv88mZCJ2Om9YwaR6QilSJr3yVNT7RcvRtj4jOyKU187qTQ8dRag5Mt
         0CzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666171; x=1762270971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLSaa6PcadKxSJGpM5AYmWJ5bCIVBLv3q1JgPY8IHz0=;
        b=lETnyT4Jzj296yVfsTMJqz0LOFwjR6PCAZ97viq1m8ekZHek+6eOorjrhZtvPeRsjO
         SQwkfjat/vMxURAxtwO859yJblrgZajtpTxKeEyCBLJtphoFoY/bSX3FlZ83nkqw07vL
         R052AdlEMXs07tsj62xiDqNfQ9aV5WjifVMTwvRDZqBZRefCH3POwgh9Q5pd5CVWl7BL
         l22+ZiPFW4rhNdRgMYo/B8DQsmejfWiHXD3V5OAJdsptLrkbl30AJ0vgOSAELw45j0dM
         pE7mblDAb/WX/c5Bmxb5bl/3eza9FE2tHR4hdm4AGviKaHYgDGbOvCr4MzOXJrDRKPpl
         ArYw==
X-Forwarded-Encrypted: i=1; AJvYcCUSN4Tf02FUsG4D4fl9sm7l7Sa0sqIz7Ei8J/1OOiL2DFWYbqpUHNeREWj8jQMs9X49+w5LPufRQ6/iw/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSNS68uQb3ziRXx1KqEzXdzyNKYPvKWH5VvIGz/+MmYcmx/4vA
	QWqheop2YXnBa1cvN8adFl1DsgjbVpIUq3sW9HM6YDflRanR6Q3hvle9
X-Gm-Gg: ASbGncvAXoVFoNDKZ3MfOfVbNy59BAg8gQ4cji0GeQ66pQt6KoAhTVkmS70zMVXpUV6
	iEaBgvsQ1DOWkOs564fm71Ss+pd2oiK2Bnj9TYzog2iwHdyTcqwzUJwWOP3pq68LXfqHjk7nfRV
	6PVVlYxlSSOJEVPKPa1HEEE2ldK61ZBo9i5CMK7DtHlvb58bSIog49Et+hFD0AMvQcTOoobbaLg
	KYaifm1YyUSaIE6AwQfrh0Ye9MxW2qc0vyxat1cGAmnarCXUCGAH2kOA5nhzSwnt/mbs6WzvrjV
	dKj2T3acQgCgOYcn346sBa1EfNwk5G/XfCkRbWONT2nZyWunTwOyy7dXed2OJYtX8j9VVfIFZRY
	Mixv+ag04ty7syyIb/s6j9aCgMch4IQCLf+DHOd8KESbEuBgm0DHZZzhrOCSNQyYPqpby0He5JR
	QI1KfFpBVh
X-Google-Smtp-Source: AGHT+IFtaSkAiKKcd2pcmpO8llRHe3kknOAIp2k2H7U83BZTPQHu+FuTy+qLrHQP9UKuG8qf//3qLQ==
X-Received: by 2002:a17:902:da8f:b0:26d:353c:75cd with SMTP id d9443c01a7336-294cb381901mr58454085ad.21.1761666170702;
        Tue, 28 Oct 2025 08:42:50 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0a4d9sm119815145ad.37.2025.10.28.08.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:42:50 -0700 (PDT)
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
Date: Tue, 28 Oct 2025 21:12:24 +0530
Message-ID: <20251028154229.6774-3-linux.amoon@gmail.com>
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

Assign the result of devm_gpiod_get_optional() directly to pcie->reset_gpio.
Thus removes a superfluous local variable, which simplifies control flow
and improves code clarity without affecting functional behavior.

Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v4: Improve the commit message
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


