Return-Path: <linux-kernel+bounces-850325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CAEBD2843
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D333B5273
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D03D2FF16B;
	Mon, 13 Oct 2025 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajHd53Uu"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6432FF170
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760350674; cv=none; b=CZh+UkdnHlOTAN8M8gHllL/b9sKkw3l5McQuSDVpwk0x/8YrYIhBsWjwfFoK4OzmEIDyc8qH0dBVYYuWFircaQ2oMtKLHWGSicwVH9QpF5cTRFlslxDoOvBHvhxr1pABeFGky5/ZYmtosvsvVltfP2MGL3uHCzCdo75bmTAGnKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760350674; c=relaxed/simple;
	bh=gNh1Q25ZNGRtB3EJ1DwzkXZengb0FpJ74GxfaGXFVu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfmAXpH2uNt6CmOCCUGs5xtqRWuRdr09M4JRoVA0p70stNAH/1C+87ijGGr9ql93s7DQ2L9QJ+WvBkXEHSiwobQEKf7k2Rrh/r20K0E05UMFql6MIupmYsqMrJ7vXyxapip2u7XAOOFfS+MQGXH5Rqs68Rq2+36SekWE7gsmesU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajHd53Uu; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33082aed31dso4196200a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760350671; x=1760955471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19kHdtY5ZhpAxDQMVT/2nG/beuKDqoa8OjmMddMbQbE=;
        b=ajHd53UudJG9M7Br4Ob6S4j01SwITX8ETUlwysJE9vrgDAva67AoEdTzmOOyypBe4Z
         0500bfcaRTIOo5/VQ0h231a8WJZVJu1lrZOQ2uCEv07RQKH/fFkh2Se2ifBPDYGe42Qt
         GXDbCp4iJQbf9gePk2Lp9A/6/EljtPvW5iSBEvrSUwvl3t+AxujQ1Ox2TsS6LtkDqEeL
         uqAWH29HRRrB2sGVoQv0CLC10xr/4yq1UNa+7vEmu4oENc2q+NFKoaLFPt39FzIDx5ON
         T90TmL7kTXu4EuZ/Poy9LKfE2rXeK6XjC4O8THgAdcWaRKYIPpEzDX2iZ5H7F0ibIA4Z
         sWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760350671; x=1760955471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19kHdtY5ZhpAxDQMVT/2nG/beuKDqoa8OjmMddMbQbE=;
        b=ozvREOUeesseKH1/9BWvJ/SJ6ShVOx5Vs5PvTc+XcB9hSk80Uwuic4bZrBQ6hnRVrC
         raXqrJa0I8peGyncCfPjYJn0GkWPdOt+VgUZiXPA8BV8Az1ZARr5hMYi6zXrSQbnC218
         Orz1B7mgXDKC/5knZqmx32ME8e4jX50yIi8Ln5/ER89XVZ0H3aGxFBhQJr5J35QogPMZ
         3dqjFIdq6FKFOa4zicxsslzIgvj2QO7DRXFGXtdZmR+k67VlPsB/aPSiW2xlOZtbFAzV
         Kj1qGgZCRVEYYfyVOsphe6PsP+B9u6w+/1tENWRte4GguKS40zhWqnio3GAxwIAPiv1S
         8n/g==
X-Forwarded-Encrypted: i=1; AJvYcCViNOJV+6Do6oZFOtabOMhgapbf7lKaP9uTYpff7K3s/w0rxngxpUjB0Md5RT9ElXfN2tCtOgp4YgV/0Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/9cv1OaE5HSUKTscRnC9aKmuOlA15EYkVH9b9ChkYeeknIJMi
	3N8oXoSot+LvAnPS24neXpY8O4F1seGuPTGNSuK6Zp2z1BVIS7YSFn4aFB4MNhnM
X-Gm-Gg: ASbGncsxmr2bi1ZStiAvUHNL0OOp32FmawCrtk5hPIV3FsCIESHbdc4DfikrkeHLjzJ
	svhIH89I8el2AdiLuNg4ErCB/4NNC92x1F5tuDOzoB1e5+aF/bZA5q0KqTtD8B4+0zFWqSbRv1g
	WvgQpTt2oz+77WU5E3mzoHrpYiNHjVX3bTysnbhACBCkq2GaWDFg13agYO4Y6MMcCEwep1bXoB1
	VwDkIOqkyHf29Jf/J7oKhB5M5JwwEfuVQGN1RPVpuuZbAkUE3c9gj0Xrv2HWBzF7VEr4ea8qEAe
	NO5v7vd0siNBxua0SEYgwf4h1JnusLyhCMimbYcDeNZkwGW9jRlSQkRH5NEgwU3wSZsouzMmM8b
	0kNoX7ujFcfex7i7vQTCLQZys9aX6MWKxX7iiqFQZIAqgDsikfQ==
X-Google-Smtp-Source: AGHT+IEyZirSf3fnKNnVB5Ye7lidBycAPJF9I2FEB25F5npassyZdVGtvN5Z0VaAFP1R3FsWO44BJg==
X-Received: by 2002:a17:90b:4990:b0:338:3b73:39ce with SMTP id 98e67ed59e1d1-33b5138e3a7mr27708156a91.25.1760350671380;
        Mon, 13 Oct 2025 03:17:51 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b52a5656dsm7422864a91.11.2025.10.13.03.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:17:50 -0700 (PDT)
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
Subject: [RFC v1 2/2] PCI: j721e: Use inline reset GPIO assignment and drop local variable
Date: Mon, 13 Oct 2025 15:47:24 +0530
Message-ID: <20251013101727.129260-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251013101727.129260-1-linux.amoon@gmail.com>
References: <20251013101727.129260-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change removes the unnecessary local gpiod variable and assigns the result
of the devm_gpiod_get_optional() call directly to pcie->reset_gpio.
This makes the code more concise and readable without changing the
behavior.

Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index d6bbd04c615b..1ece4b183dfa 100644
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
@@ -615,9 +614,9 @@ static int j721e_pcie_probe(struct platform_device *pdev)
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


