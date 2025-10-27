Return-Path: <linux-kernel+bounces-871901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88307C0EB67
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F938188C514
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9542130ACE3;
	Mon, 27 Oct 2025 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmEOFQfM"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475E2309DDB
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576990; cv=none; b=VVu4YbEhWn6SwOlPfY4jEMl89QUR+4LeAaptZqPzM0oExH65j+E7l3xbb/0H4YNHPnXRrzp13/yqIVpv2/pyj/pKPC1VLKTEOSQiCK3HLzgOCWp+YUEZVtrH9obAujghlbwrzhqebjeS1y48zlsv0zXCcvOCvYLbLmF/OXqD3mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576990; c=relaxed/simple;
	bh=ZMvU9vgiZOue6RqoRRXtEPG2qKfvC9tNvt6emuXOSvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qg23lWEZO6uItP7DZ0o7wYsqV/CH4b1SGOMG7T73nd8FF24TVKXB3Db17Ew+hgcSkyedsLP+02gjVlvaqtPIQBIr3Ky/l0VlFzCk7o7ykMy5SMp+c47JCyHAI3bp/pWWtqd2daD0kq9I6M31LyQMKZUoBK13Gh2lwnue2h/gUk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmEOFQfM; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4597007b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761576988; x=1762181788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJHpdmr2NXtFEk3A9X9aIw2etVmtC3q73hrlmlo4/OE=;
        b=NmEOFQfMVTuQ5SdLyCnWxz4r93dcYCWzXQ69xihuCmAcHq/tr2HcfKs8f1IhJ01rhA
         +t0cVxiyBebVtD75t0odqyGcIbJS6Dy+ri1BJn3KBEkHP7V3BVP5AMQ7tAiZZ+b2KmrZ
         d6o5Nkz2Ik9R5Ldc3VfyMMFu2RLeqctFOOOLjG35YSnXpprt63LDSCFUAhg9JrmRAHx/
         1f0KTBZSoDo07aQkQIYsulmAIv1/ZlE7+fnh8bw2SXKpWIAJA+7avBz/4h6CfpGKJY3O
         UlOqzSzz9IPL/PXP93edmU83xUgkmarcAcsc/IZsgBsZvfkTKCYCD9nczFtVb3vnam7U
         1F7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761576988; x=1762181788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJHpdmr2NXtFEk3A9X9aIw2etVmtC3q73hrlmlo4/OE=;
        b=Lg5JvSn8Ls+0ek1sO6kUVlCvwJTwd5xcqzn3p/jffotf06Czs54V8nuop/tKX3fVXI
         sBeBhm85jufXYVOZDIe0Hk34uiSnQmvGiXvwU0TgO7aN9FLj113gIn4RhRP4WHASttYU
         Z4/aTEu5BUspE/pj3cZpFW6Xag1zGZBCV5UERJtzpoCWWBWhKYT3ZEbdviL4W0s68Eqn
         AHEa8ifedHhRDF2hXPbBgUxBoki+0eXYtbkYzq9luoCy9E4kz462/zdwhd3fXLU5jy2j
         MGxguXe9ccZ028nbXAiHAVg4GXHsiPFovaq5/D03JpvXEn24CbRf3ULjfBSgGZBjHlEa
         koTg==
X-Forwarded-Encrypted: i=1; AJvYcCVxEnBwRgTBE/PB11a45vIVR/lFxyTLJ3zyFsG8xgaS0qv1Cj/tQHIsgBN0FQTNpAmZS9Tq39FJrrF/8FY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9PxQyu3anmCQLNF0j/8yQiLKIzLWArW4VLghx4DdmZ0uUzKl+
	suKOze/C40F0dRFIG3QyPipOJy7gZIybTnWS/AtEOoF8i3/N6DbKhQ0V
X-Gm-Gg: ASbGnculu01OBTkjbfkLhnvH1MI5Pdq2VairCVUM0fh3Ay/nxPrpoyAkVLPEn4StLmd
	Xb12iR3tWGK8qlYUe9Y+WvRqDl0709MBWn/68Z0a53Xd8bNzUd/32bFOaVMjTyWwCQydkuoxPu6
	pJOQdyuwqQCfWjMORHT3+DBmBP1SQMsR/RHrbgnxt3xxj6im1LfjlsFhqnBvhpJ02WDxrXOl1Ev
	eaH2zzueRp+F/dkVXDC+hAYhf6qTe3hISHGvrYeiaPwhotUJSQg+h9g/PxBgm5A3sMhlTTSi2lT
	Vv+2/peDJgUhnLWaUTZTnkAh5zDLCADVgicGehat4MCkeZfQM8q98sHoyZH9eyA+aYb5FXkBBh7
	+veH1ev3Md6frGx783DaOsyGD9mUUNstvBtVal/6XZAU3UXuxFwIbKLhz2RibFGvJhWXYHD27SQ
	==
X-Google-Smtp-Source: AGHT+IFpo+vKMKtPf87tmaXVzNFkUX+AxdjSTgekyu9iCoaPZB3m/DdveKL6EgBsKmZAINobovUjew==
X-Received: by 2002:a05:6a00:6d48:10b0:76b:ecf2:7ece with SMTP id d2e1a72fcca58-7a284df06aamr11245249b3a.12.1761576987961;
        Mon, 27 Oct 2025 07:56:27 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012b19sm8373372b3a.12.2025.10.27.07.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:56:27 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Hans Zhang <18255117159@163.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 2/2] PCI: dw-rockchip: Add runtime PM support to Rockchip PCIe driver
Date: Mon, 27 Oct 2025 20:25:30 +0530
Message-ID: <20251027145602.199154-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251027145602.199154-1-linux.amoon@gmail.com>
References: <20251027145602.199154-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add runtime power management support to the Rockchip DesignWare PCIe
controller driver by enabling devm_pm_runtime() in the probe function.
These changes allow the PCIe controller to suspend and resume dynamically,
improving power efficiency on supported platforms.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index b878ae8e2b3e..5026598d09f8 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -20,6 +20,7 @@
 #include <linux/of_irq.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
@@ -690,6 +691,20 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto deinit_phy;
 
+	ret = pm_runtime_set_suspended(dev);
+	if (ret)
+		goto disable_pm_runtime;
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret) {
+		ret = dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
+		goto deinit_clk;
+	}
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		goto disable_pm_runtime;
+
 	switch (data->mode) {
 	case DW_PCIE_RC_TYPE:
 		ret = rockchip_pcie_configure_rc(pdev, rockchip);
@@ -709,7 +724,10 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	return 0;
 
+disable_pm_runtime:
+	pm_runtime_disable(dev);
 deinit_clk:
+	pm_runtime_no_callbacks(dev);
 	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
 deinit_phy:
 	rockchip_pcie_phy_deinit(rockchip);
@@ -725,6 +743,9 @@ static void rockchip_pcie_remove(struct platform_device *pdev)
 	/* Perform other cleanups as necessary */
 	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
 	rockchip_pcie_phy_deinit(rockchip);
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+	pm_runtime_no_callbacks(dev);
 }
 
 static const struct rockchip_pcie_of_data rockchip_pcie_rc_of_data_rk3568 = {
-- 
2.50.1


