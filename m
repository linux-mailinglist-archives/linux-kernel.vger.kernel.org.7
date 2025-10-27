Return-Path: <linux-kernel+bounces-872010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886F5C0F19E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F24403DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA543164B8;
	Mon, 27 Oct 2025 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bmKNVYYq"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE354314D11
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579915; cv=none; b=YSm6E4wInF798sK2evEWPWAKFDaH3OU2ctahDwZirAQaWGZD77FWXvARjXioWfVSF+FN3x62dVLETMCZwudzyZjkMZsSvHU4/cCW/CO0l/3THWcVINiKNIMizRyjB+4AnB9sMZDP0BGhhb3s33T1HIjbelprG6nGJ6mIQfiOIF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579915; c=relaxed/simple;
	bh=vqAQ6/vT/bVKVkAXMLO9ry32/KCXXrRCURyvHpvIC8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QnMePLmuiH8xPESQxK1K1hZlINucU26mwcAaHOgKTcx9UIgDLu9Q02LYJumVLtv+IUm2r64/nzsv9pWXEPZj6JX+yXFgPa8Cjj8sHU78nOOWO2DvumziQFlu1Rm6ZcoKwYWHX8UiqqVe3sLdpNCN04xPc4L41ulfbT8sSghXN4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bmKNVYYq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4711810948aso35215735e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761579911; x=1762184711; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gbnM+7JUoQu99psJVRjfGTzLa9V8XPsbrju+vMCFuVM=;
        b=bmKNVYYqXkj6qVSCHMSmKyUZfaEqZS65CQJ7SgjTmJkaixG7Gfz8Sn2cSxP6JDu991
         VA6EwdEN06gbS+DQcm+Hku9Dt2GM4p9qanMcqEpREFLC3pcV9YWy1sPy9yGBXiqxWv16
         FdAnvt/pD+3o/2B0bsrtaP2bWS4e/2hNRvgTQ+g3WIwFF9UJs7a161HgUvXNi7sYsqMv
         CxU0XQRXeFB18jEhIFYiLKZjs8XsCGwxvm8Laj62hNuTv/kGofw5HYhmBsAElW8dz7uC
         kOX20ekywTvFRsbHCGu/mX2i8nZ89uKo/uZstTDDESE7hUP9nXyoW/0M5VpYZfCbCJv7
         nouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761579911; x=1762184711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbnM+7JUoQu99psJVRjfGTzLa9V8XPsbrju+vMCFuVM=;
        b=CmzayCt67X3sVxglx82aHZHZ0ZJqyOvHziQybgPphUWhOW6RY4GYdNeKDBvdIMv/Rf
         vnc/CjuuMbLq2wGqHsPNkCRp7vCgMsy0StL1omRIPDRL9bDkUJSYg/TlLuRYjq1O7OTm
         BOHdn2fBwx0BLE7XUCkuiSy9nqvVvCUXtLetJ2m25toBC0eGmrJZh0qHMT1dPWyvL2I6
         /9+osfxkeGhWxwf9aAOrZwgBmgO5jWrD1TDO8TbIGgD/o32mBhcj/Q/6VrCEBQFm46PP
         RbMZENc2UFdwDXfLJVKDNhFPtzao5RXAx7IzBfHe0E7zhFxA0TZPHLm5QCONe39dhe1D
         c5Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWDSRO7XH+a+Wkajppg5XbiYKqOznTi+7KNJ9nOSKixEpPutqctBpULiRTRv92CEXlOlanyfvkyFjUMhWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye3YMAOpA7ziTr2RATXVBmirqb/goJWeSLXu1uBdn86alnAwEe
	AtfyZAcn76IKcVOebNWAwZxhC5HbyWR0y8kSWnFnthOEdu8yXSb/0AjnoJW3qGMUetI=
X-Gm-Gg: ASbGncuY6Tl0hXCvMQvi6xR5GeF4K9cD0wE0mEKWU7CbTYoAe1r3KO7d+jLTy4vHrHP
	MgUj45eCgVe0TkReHtM1/KIziX7Ir+gnOlDDewsCW7a0ltr4u59megBMA+Kriqt9CHFZ1fn4Jcn
	B2H26Qnv9fytdv+Esre9COQu638YqAsiCvQiYZaYqggtVwScoVXEtpQtgjiWM+tbx0SeKqOB21t
	bO05QfCzeC7gnJSIOBSJiFB5HbD1B8cPGpiJHzStQgypVeczXkTsFQ7N70w01aOxmDjMNhwL/to
	ZZ1H4lBbc1yI0PSANS/oBu0z0D5+MEWRFVBiBrkDIHwiUR60mJAvLhbQWi1SEAf3fqX/5bN6XGd
	JZgUE7aL4D8kkfbVAhxrsFRgU2Zmw4FSy6ASxdywJcplpDs30CwQuYsA3SgUTPunYLwN3zT5Aig
	6NUJapiQ==
X-Google-Smtp-Source: AGHT+IGvMG3wu3r+IbbZg/5/7mILxDWAzW1LalNld5Mwz0HOjM2EkN8wK4I3r8TzG4x6hIzWvNeibA==
X-Received: by 2002:a05:600c:3154:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-47717def755mr1118575e9.5.1761579910577;
        Mon, 27 Oct 2025 08:45:10 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:c1c6:7dde:fe94:6881])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd477d0esm138708045e9.0.2025.10.27.08.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 08:45:09 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 27 Oct 2025 16:44:53 +0100
Subject: [PATCH v3 5/8] net: stmmac: qcom-ethqos: split power management
 fields into a separate structure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-qcom-sa8255p-emac-v3-5-75767b9230ab@linaro.org>
References: <20251027-qcom-sa8255p-emac-v3-0-75767b9230ab@linaro.org>
In-Reply-To: <20251027-qcom-sa8255p-emac-v3-0-75767b9230ab@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3440;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=EQbFLUJhBusR5R/WLS2zY6u2a3Qrdavc6CuZtxM8a7Y=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo/5N732qdepXwjTMMy3gsuitEVbWcrcVZjQoR7
 Zsfgri/RgSJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaP+TewAKCRARpy6gFHHX
 ckPzD/4iZm89XdVS11zAr9khaNEvnEltpu59g4ozId5XbAMVxDZglviYveiLmqycpJ4ruDOay49
 QW1IHD1qaIiGbhzj398upRiUvk9h/6XjjVtjFG8h/iRWzkg/sduilnVGPPUsHDqZq5Fehm2XRNJ
 +HgergEpmyi871x5T4LIKxW13HzuAECg2FMLBAoNR8hRvM34p/DC5+pdOQeQJj+kJxWrzbeF5Sl
 Qt38NSuIlBYV0vWL9ALsuipnZIMVDXp3eGMjhoAeoFjJJckDGV45yqFswWYUQ9B7C2D4wpCfhGY
 ZIpFGiDQiXFw5LPO+6HxTzXEdPf83Yz9SUwNkld9kCx4+rBCbiTdkTapduBAlehxo0VtIC/DYKl
 WLlXvRpr8IFaKzRidwPY8RLhWPhdZUZtLWno2DWzcbtRDbN8KWVAInmJPv6Hx9EsBjKwUXD0Ts3
 3moUpB+I6nWUjWebMCedX0U/T7KpoehAJyeHSjDOAOSs9vs94pLqQvObv1iUJUpLgks+Vg9y4lB
 GrTebcmkkjB0L7yJEpEsHAJrPI0EKTTWnzowh8DbHTP5+THcTfcEeAEpzM/7OTM8UV+AOeCUfcs
 shy3tH23ZNwVhY/ycIRVx2l7pLj0uuZLC3EbnnRGUcC+eDoXhViB0YFdmI0b/x1IJ/j7JJivvAm
 wxZsoJrM/fwHA3g==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Now that we have a separate wrapper for device match data, let's extend
this structure with a pointer to the structure containing fields related
to power-management only. This is done because a device may have the
same device settings but different power management mode (e.g.: firmware
vs manual).

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c   | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 2739bc00e7525a5913bd3a5d28d9c9a8871fb7cf..7ed07142f67c931cb2c2c0e8806f5a7fbd68945d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -95,14 +95,18 @@ struct ethqos_emac_driver_data {
 	unsigned int num_por;
 	bool rgmii_config_loopback_en;
 	bool has_emac_ge_3;
-	const char *link_clk_name;
 	u32 dma_addr_width;
 	struct dwmac4_addrs dwmac4_addrs;
 	bool needs_sgmii_loopback;
 };
 
+struct ethqos_emac_pm_data {
+	const char *link_clk_name;
+};
+
 struct ethqos_emac_match_data {
 	const struct ethqos_emac_driver_data *drv_data;
+	const struct ethqos_emac_pm_data *pm_data;
 };
 
 struct qcom_ethqos {
@@ -296,7 +300,6 @@ static const struct ethqos_emac_driver_data emac_v4_0_0_data = {
 	.num_por = ARRAY_SIZE(emac_v4_0_0_por),
 	.rgmii_config_loopback_en = false,
 	.has_emac_ge_3 = true,
-	.link_clk_name = "phyaux",
 	.needs_sgmii_loopback = true,
 	.dma_addr_width = 36,
 	.dwmac4_addrs = {
@@ -317,8 +320,13 @@ static const struct ethqos_emac_driver_data emac_v4_0_0_data = {
 	},
 };
 
+static const struct ethqos_emac_pm_data emac_sa8775p_pm_data = {
+	.link_clk_name = "phyaux",
+};
+
 static const struct ethqos_emac_match_data emac_sa8775p_data = {
 	.drv_data = &emac_v4_0_0_data,
+	.pm_data = &emac_sa8775p_pm_data,
 };
 
 static int ethqos_dll_configure(struct qcom_ethqos *ethqos)
@@ -785,11 +793,13 @@ static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)
 static int qcom_ethqos_probe(struct platform_device *pdev)
 {
 	const struct ethqos_emac_driver_data *drv_data;
+	const struct ethqos_emac_pm_data *pm_data;
 	const struct ethqos_emac_match_data *data;
 	struct plat_stmmacenet_data *plat_dat;
 	struct stmmac_resources stmmac_res;
 	struct device *dev = &pdev->dev;
 	struct qcom_ethqos *ethqos;
+	const char *clk_name;
 	int ret, i;
 
 	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
@@ -837,6 +847,9 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 
 	data = device_get_match_data(dev);
 	drv_data = data->drv_data;
+	pm_data = data->pm_data;
+	clk_name = pm_data && pm_data->link_clk_name ?
+				pm_data->link_clk_name : "rgmii";
 
 	ethqos->por = drv_data->por;
 	ethqos->num_por = drv_data->num_por;
@@ -844,7 +857,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	ethqos->has_emac_ge_3 = drv_data->has_emac_ge_3;
 	ethqos->needs_sgmii_loopback = drv_data->needs_sgmii_loopback;
 
-	ethqos->link_clk = devm_clk_get(dev, drv_data->link_clk_name ?: "rgmii");
+	ethqos->link_clk = devm_clk_get(dev, clk_name);
 	if (IS_ERR(ethqos->link_clk))
 		return dev_err_probe(dev, PTR_ERR(ethqos->link_clk),
 				     "Failed to get link_clk\n");

-- 
2.48.1


