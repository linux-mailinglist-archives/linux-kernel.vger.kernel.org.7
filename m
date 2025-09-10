Return-Path: <linux-kernel+bounces-809684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA315B510D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA51A1666B5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E333148C3;
	Wed, 10 Sep 2025 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="emN3K6w/"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37460313E2F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491685; cv=none; b=h8pHrqba54ClJvC74djfIzx4DGCqivqUx2nwT06YGIqdvaTnw+akQm9lE5oxhJnbzDDZHrvifyhHQP0vY7LYvupKDVh55VuBs7LkZxwX8kgdU679B4boVhzBIJ2DBVlFaL3U9Xvwar/LKnXhDoA1WQFYkI08iNCVwBqGSRmzXAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491685; c=relaxed/simple;
	bh=XIlqJOjcxzT3WhouCo/+UR8137UrPJNI5EXcordY0iE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O5jB5fspJ6xu9XUWZRL7s4q9sqi0OOGOwXp+QipAiEyecHYw+wd2C0JxEXUqEu50lsFtjhRTIkagEvFjqxWEzMBIvhlkGcOpy3fBCDD5GJ9KeQGp6rsdgjsqlFpm4oQF6KZc+jKfqkv00Z4Wi3JO9M63k5UwjWfkL29l9ulD40M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=emN3K6w/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso40167045e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757491681; x=1758096481; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vSLcjrovVRdefyPQB8K8T5zFHjp8pcBoDKJgvNVhJg=;
        b=emN3K6w/kGw0qh7G5ZYSFTN8kAEFNDf8d1ze1E1EBH0VMCwiMVsyduMe3KY3tYQuWc
         qMlUe6oVUXYRuudPM38TFj8ICATYT0gkUFV7Tz6rarZOdg5FLTmJnJ4oM2guJilzhosh
         u5F0GsThJKOCkQ+1bvmVn1WC+gMWEhDZrzx2Qz6ulLUbwd6soNU10k7F2fEsBF3hmR1g
         4ppunFQ7+FZO/bZ/MgE1s1VuLUpjSFHws/WXhgDjoqovrfgNBJj6J2Y5YVZ6Ri7wCvZT
         fPZ6r1i29o94nDw0tFmPnb+JJsbPrRxKKQ8OLVU6cfDQPOwx/b/fdp6B3aebgM9O0AyN
         wk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757491681; x=1758096481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vSLcjrovVRdefyPQB8K8T5zFHjp8pcBoDKJgvNVhJg=;
        b=n/qxcVbCP8XpiuqBWhPNO+IiMPbI15VYRla2aP5Mc2vu7uEyi5GmoGoaS9uLuO+6u5
         sROGIQsoyNMaRUZANkMzxn+3CZQlV8rybgcdoDKX674oHkBHayC9+aGInLHbUqbFMx2b
         AaNVzmF5AgH0xztY7FGiHjclgYJSTC2IrBDN/gHinTOsixzLuZsP+8/KbM+UKJWfrNNZ
         jOF8IOvDLsnsCgzW3e/9UoGyTKQy7ESWGMlZ4THwVL1B3M15wzetoHvzq3fa5LxiCCl1
         RBQ6xU6jEduc2cQxDDonmWTGiE+9NU5RuV91dWZfK5VP6Ve112IXU+235ZWBGGuC9vDt
         51rg==
X-Forwarded-Encrypted: i=1; AJvYcCWDxgzl8Fh1q2mwGEj/fw8VNbmaktgWBJ6fKEN4qvtwduzym1KLvc18N44w9lLHIxc7uU5zDgVsE3N2Goc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI7Rv/rATU9U5CdF5Aa7YlF3BtgCHCj/CucNoM6K9ndTqV0Wnf
	iDE87QgRicKQPn2G2wwTV6dUJS9e04jARTrY7k5RA6QVVXiNpfxs//ChtfrjsRLlvPU=
X-Gm-Gg: ASbGncvq7Fc6dyRR1vsWU3DAslhR2+sXN5WItP+OQfkg1GkUj/FdlsYxkD8ESkgQKJX
	7YKAEPOWTxXzJ0aQyorggylN4DsO4QhmjBvrcBVNG084Q43wlZmNEWXLAntltMglGhoQkli3lap
	9MJ+VbEMyfSPaNaCuPr2B0854GxD2gkLlhOlkeitejfhlnXbb6j1CjidMBr0x51JmuY98VmWl23
	eksIIxDvDAm5xVQevVkOD+vQ4UEs3WjFPxv6/V2Lbr9ogrC1X5oFdYfrsrt5hMcpW3e26f5Z5B3
	/IVfJ8p2Sh8tVqNo/dEVqZO17QCwgGo7ezqhRuKrhI9Hr2ws3242ydEPx6bFINH+cW9eciZT6lJ
	5ha1bsb7RirZq6esnuBXgm96p+wyX
X-Google-Smtp-Source: AGHT+IGtTZTBxDp6rKWXdB/VBpkJj6AncbJgtDSJtbOLi94Ze8GYVYUd/pOcMlolezAIYylFkwVcfA==
X-Received: by 2002:a05:600c:468e:b0:45d:da4a:8dd0 with SMTP id 5b1f17b1804b1-45de6b386abmr80521435e9.27.1757491681543;
        Wed, 10 Sep 2025 01:08:01 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3936:709a:82c4:3e38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df8247cc6sm17813605e9.12.2025.09.10.01.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:07:59 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 10 Sep 2025 10:07:44 +0200
Subject: [PATCH 7/9] net: stmmac: qcom-ethqos: split power management
 context into a separate struct
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-qcom-sa8255p-emac-v1-7-32a79cf1e668@linaro.org>
References: <20250910-qcom-sa8255p-emac-v1-0-32a79cf1e668@linaro.org>
In-Reply-To: <20250910-qcom-sa8255p-emac-v1-0-32a79cf1e668@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Vinod Koul <vkoul@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4943;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=72Rcv9lcaIE/fmtmW9sA3UZwGSkP3ncYbbWtrZ8FIEk=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBowTHOuZe0uiqQW2Zgiw87pkQviYLugbHl4HVm6
 6cuWdNFuamJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaMExzgAKCRARpy6gFHHX
 cqWbD/9JjExtcSAoeJytoBguDSVFDiLWEedYT2wU6Ln/fpgS+pWlLnROCIZr5W2/sroazOl/Gly
 2zfKHYub9rpzVyhcc/FhCHxfsL45TQTo9lzyDYf7wMn7c9FFuqFczU5BhUrGETPCPmw4J9cjDE9
 wk9Xvw2ZBMINtzeCxXB00eUKFHsooYoWFE4G00dncC7b94/ReUz/Xh0P48j+JScRp1FvbAh+t3O
 M62lArrEcvAFTnLEHjYPPLHGMkwfWFf6Y9XirwTNCPnfzeOKZ33dtXcJE3MSDFcHDU86zIfhrHw
 i5bN9PRG2zW19Ac3lt+PQ/2PJdT1aut82NNcRkmY4seswW4ku65ND7HcwlDIX3V6eMupGvfirkc
 8JT9Owbqf0L7w5smgcEbwVTTyTVtnEcLAPt1nxehJTciHnwbLjrQJSYodZZaCSOjUr6YOKSb5zn
 AXPaWrBfjEqTRVxLDnvig+YAGYr634Zo64oAQbEXWPVc5XVg0TFA4zCHE0wTkNUdHL7sP6ggnWg
 ofhmSHgl7z+l4kBeCROm98rH0FOxivvc8+yDt7uQ+MOBmG2PG2HXtYYCtU2Zdp4GLFMwhmxLjgm
 6vHdDKKL7MD9TBzPng07OuRZFv1d5Sf9ujrLI6myzQhfonZTTKydGAO9KgO4f0uxjO7XenKJ409
 lYurxGnOOatO3dw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With match data split into general and power-management sections, let's
now do the same with runtime device data.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 46 ++++++++++++----------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index d4ddf1c5c1bca2ae1fc5ec38a4ac244e1677482e..1fec3aa62f0f01b29cdbc4a5887dbaa0c3c60fcd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -110,17 +110,21 @@ struct ethqos_emac_match_data {
 	const struct ethqos_emac_pm_data *pm_data;
 };
 
+struct ethqos_emac_pm_ctx {
+	struct clk *link_clk;
+	unsigned int link_clk_rate;
+	struct phy *serdes_phy;
+};
+
 struct qcom_ethqos {
 	struct platform_device *pdev;
 	void __iomem *rgmii_base;
 	void __iomem *mac_base;
 	int (*configure_func)(struct qcom_ethqos *ethqos, int speed);
 
-	unsigned int link_clk_rate;
-	struct clk *link_clk;
-	struct phy *serdes_phy;
-	int serdes_speed;
+	struct ethqos_emac_pm_ctx pm;
 	phy_interface_t phy_mode;
+	int serdes_speed;
 
 	const struct ethqos_emac_por *por;
 	unsigned int num_por;
@@ -186,9 +190,9 @@ ethqos_update_link_clk(struct qcom_ethqos *ethqos, int speed)
 
 	rate = rgmii_clock(speed);
 	if (rate > 0)
-		ethqos->link_clk_rate = rate * 2;
+		ethqos->pm.link_clk_rate = rate * 2;
 
-	clk_set_rate(ethqos->link_clk, ethqos->link_clk_rate);
+	clk_set_rate(ethqos->pm.link_clk, ethqos->pm.link_clk_rate);
 }
 
 static void
@@ -645,7 +649,7 @@ static int ethqos_configure_rgmii(struct qcom_ethqos *ethqos, int speed)
 static void ethqos_set_serdes_speed(struct qcom_ethqos *ethqos, int speed)
 {
 	if (ethqos->serdes_speed != speed) {
-		phy_set_speed(ethqos->serdes_phy, speed);
+		phy_set_speed(ethqos->pm.serdes_phy, speed);
 		ethqos->serdes_speed = speed;
 	}
 }
@@ -724,23 +728,23 @@ static int qcom_ethqos_serdes_powerup(struct net_device *ndev, void *priv)
 	struct qcom_ethqos *ethqos = priv;
 	int ret;
 
-	ret = phy_init(ethqos->serdes_phy);
+	ret = phy_init(ethqos->pm.serdes_phy);
 	if (ret)
 		return ret;
 
-	ret = phy_power_on(ethqos->serdes_phy);
+	ret = phy_power_on(ethqos->pm.serdes_phy);
 	if (ret)
 		return ret;
 
-	return phy_set_speed(ethqos->serdes_phy, ethqos->serdes_speed);
+	return phy_set_speed(ethqos->pm.serdes_phy, ethqos->serdes_speed);
 }
 
 static void qcom_ethqos_serdes_powerdown(struct net_device *ndev, void *priv)
 {
 	struct qcom_ethqos *ethqos = priv;
 
-	phy_power_off(ethqos->serdes_phy);
-	phy_exit(ethqos->serdes_phy);
+	phy_power_off(ethqos->pm.serdes_phy);
+	phy_exit(ethqos->pm.serdes_phy);
 }
 
 static int ethqos_clks_config(void *priv, bool enabled)
@@ -749,7 +753,7 @@ static int ethqos_clks_config(void *priv, bool enabled)
 	int ret = 0;
 
 	if (enabled) {
-		ret = clk_prepare_enable(ethqos->link_clk);
+		ret = clk_prepare_enable(ethqos->pm.link_clk);
 		if (ret) {
 			dev_err(&ethqos->pdev->dev, "link_clk enable failed\n");
 			return ret;
@@ -762,7 +766,7 @@ static int ethqos_clks_config(void *priv, bool enabled)
 		 */
 		ethqos_set_func_clk_en(ethqos);
 	} else {
-		clk_disable_unprepare(ethqos->link_clk);
+		clk_disable_unprepare(ethqos->pm.link_clk);
 	}
 
 	return ret;
@@ -859,9 +863,9 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	ethqos->has_emac_ge_3 = drv_data->has_emac_ge_3;
 	ethqos->needs_sgmii_loopback = drv_data->needs_sgmii_loopback;
 
-	ethqos->link_clk = devm_clk_get(dev, clk_name);
-	if (IS_ERR(ethqos->link_clk))
-		return dev_err_probe(dev, PTR_ERR(ethqos->link_clk),
+	ethqos->pm.link_clk = devm_clk_get(dev, clk_name);
+	if (IS_ERR(ethqos->pm.link_clk))
+		return dev_err_probe(dev, PTR_ERR(ethqos->pm.link_clk),
 				     "Failed to get link_clk\n");
 
 	ret = ethqos_clks_config(ethqos, true);
@@ -872,9 +876,9 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ethqos->serdes_phy = devm_phy_optional_get(dev, "serdes");
-	if (IS_ERR(ethqos->serdes_phy))
-		return dev_err_probe(dev, PTR_ERR(ethqos->serdes_phy),
+	ethqos->pm.serdes_phy = devm_phy_optional_get(dev, "serdes");
+	if (IS_ERR(ethqos->pm.serdes_phy))
+		return dev_err_probe(dev, PTR_ERR(ethqos->pm.serdes_phy),
 				     "Failed to get serdes phy\n");
 
 	ethqos->serdes_speed = SPEED_1000;
@@ -898,7 +902,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	if (drv_data->dma_addr_width)
 		plat_dat->host_dma_width = drv_data->dma_addr_width;
 
-	if (ethqos->serdes_phy) {
+	if (ethqos->pm.serdes_phy) {
 		plat_dat->serdes_powerup = qcom_ethqos_serdes_powerup;
 		plat_dat->serdes_powerdown  = qcom_ethqos_serdes_powerdown;
 	}

-- 
2.48.1


