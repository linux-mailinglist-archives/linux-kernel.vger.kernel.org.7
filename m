Return-Path: <linux-kernel+bounces-897702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC09C536AB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6716B5830DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7290C342CB2;
	Wed, 12 Nov 2025 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pa0tCjjK"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B4E342144
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963577; cv=none; b=nGYKDsxTEYM+izWf8Dq08k+JTGOuelYJomVb/pyCLTHMsUqoA3fQu4HoZKFoUmn6U2EaTOyW9MxtiFCnajKtQP4NiBOIXtxTC7CNhP7iKBXr14wTMCwv+m19ww5oBmcJjO0Sj3kPqG2njXBzujjDzJsP0WyyGFuJtPNLb94TNnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963577; c=relaxed/simple;
	bh=ZkTyvzs3kiErZLDD09beyCa4zgS6txIDoNMnbc53+tY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=abEErPJs2M/Huz5D+HKoC+z7Xdbj6MNW1+o3Hdw1nMb7y9rVhv9S0bXby7kSbwREpdCw84CIh3ft5aa5ExUSIFRgIe3bO/FuHyvlfLrsgsdB840lzaEmIDlJK20j6JHI5+ZnGVi4iJHpFrONR9IW7iGPr+KUKkvs6e91EvWsI+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pa0tCjjK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so5924785e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762963574; x=1763568374; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zf+/GCTzFTCgE5kx1XIhvvkdps3fbhzPkXxT6Wkygo=;
        b=pa0tCjjKXqACtrBqr5dx+p8vfCVKh5uN6HVEZ5m6e2f9tEgpxc/Q2oTMefkJGKHhwx
         bz3F+PauqH3TASKJYsj6NQXGnbyITzAEXwLmKDNOShtx7uYNs4UdpsSa0+6yyBPkBXGE
         sEaPlFotOGGHox8/UQxmxfcWCsUaLekdKgtB28b+ga0bsbEUOmVs+xgxtdkNz1LZfkqf
         yekoBDvxjRFLESCq3GsZRXpSne8HLrTKCwqIqbWgqq/whIjgrOoyBitXshcVTiK7ojRu
         LV/CkwFUMJHHNUyVqze2MJWOhLOGlYxZDQLfMUXJ+0OK/GxW9xV1VH+gK4LoTe8u1sHp
         SdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762963574; x=1763568374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3zf+/GCTzFTCgE5kx1XIhvvkdps3fbhzPkXxT6Wkygo=;
        b=e32BBXCXSv0SE6k78w9Tked7myDI1agHZRGYgcodQsE8Nw84Cb3/KzlKi/seQBG7KC
         cTQfyaFS9M95RwnBAMLJ5q1tiuzUMbVBUu0ox8rJs37RhjNDTYOdIIg/DOZs7KQbTZGS
         mnhlHs5ZYA3z9ZvHpWdcc+HdMpBNfFRSHAck+qLTUx9zziuere3ay6lRZeyPV75y55Gu
         EYfJwGep0m4FagqE98DlFlgfKD7PsrkMN3UgrkkPZBm+S5Tm2zu9S2mhHboOx8YruInC
         Ao8SgEq2bi92kibjlzSbWhImZwdWXCmvuYou6fOhsuZfWpnxlri+KyWaQRZk3mnTgobL
         HpBw==
X-Forwarded-Encrypted: i=1; AJvYcCXf1HSM6Ocj1kxauZhSbAtaUbUIl/O5QPxZHJeVy4/IisLJQDc98OByk19y+UHozinsulV+GajKTUwEY0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv7HqUcqN5cVApz4M2lcxAKcF6S93nCDTfpZJhX0SmYh4FwX3L
	nZuOZDwSJzop7SOonb96ZKfCmCZG3dl+ZYHTmQ0kCmsCPSv6s9ClhYob39OgMTWf/pw=
X-Gm-Gg: ASbGncviuGaZoH2uyAxaZ8jVaaQ3l7ZvAjU/R1QormR6a0zXbDeodhmT8CTS5vNqOA0
	6Q5JW849u94m4MmDS+LBuaURuRH1dTqOeFESYGtRxAlQWGS9QYL0+BFLStjC2b9ZWE4US9w4HUe
	Y/NUkdIh0rHPOghaXnhiZxIdDbuSIbVtsWlLGk5WUakIz687zA1D8VLTbaIrIZkV6FRZ3163uOa
	6MYFRkao7ZrILSib1HV2f0ONfdRq4DaNNMeglhnjr3q4evnW2nX+cNirmxfzgG62hTcxh6wgLPG
	dYoj83qEya7uMN34Bbmpy90OrwktJx8ZOBUxf++Y7WMuU4JxIYOFEpeCV/lKr9HhWmiFLNwYgrj
	vbHmUBtctBHiHUBfVo9FWilXyzYQsnSYJGmF0r7rI50vosERnzyGxjelSdJdxKyP4d+mM0wMutW
	ItshnoZ1bEVeddUdH1RTmTr8pAMZBH6cY=
X-Google-Smtp-Source: AGHT+IHiaKZmZrjnhNB9UXe3SWbVn8TpxZC874yLcY0BEDx+PEA7lwZU5QXdSyubK/n5Rdplb1Qhow==
X-Received: by 2002:a05:600c:1794:b0:477:8aae:1454 with SMTP id 5b1f17b1804b1-4778aae1559mr7994195e9.39.1762963574015;
        Wed, 12 Nov 2025 08:06:14 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([145.224.66.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e95327sm41226855e9.12.2025.11.12.08.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 08:06:13 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 12 Nov 2025 16:05:59 +0000
Subject: [PATCH v4 2/2] phy: samsung: gs101-ufs: Add .notify_phystate() &
 hibern8 enter/exit values
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-phy-notify-pmstate-v4-2-717d78009d15@linaro.org>
References: <20251112-phy-notify-pmstate-v4-0-717d78009d15@linaro.org>
In-Reply-To: <20251112-phy-notify-pmstate-v4-0-717d78009d15@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 kernel-team@android.com, William Mcvicker <willmcvicker@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, neil.armstrong@linaro.org, 
 Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5855;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=ZkTyvzs3kiErZLDD09beyCa4zgS6txIDoNMnbc53+tY=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBpFLBw//aPmWQatQ5PqM4z3B8KMgeCVaO0T+wVp
 rUg2TUK3BqJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaRSwcAAKCRDO6LjWAjRy
 uqsjD/9LQR01a5YzYdae2h+woWETx4VJc/v4AvOe66gui5WuewQd09JWyHQMw1YuXyN9XY+r8U/
 jgS8DwYaTDi3NgeKoIUrnYjKwMvAeE5PsnhfytlmRpcolEQhwUhoL6YZ+Ri1x4mJSm+SPzN/jKk
 cwTe/PSwsKqgitP2hHPOL0WT+vnFCEu2hhfQRIdlgkeBrBJtG826sXowiPTcYhRuw3vdXL9jeKy
 +fUZUZTn3OIitQHW0zxbLLeTFGKBNSEMcbrtF50WBsR3Iz7HakqlkB+MarSuDkU+FR46m/Ty0cI
 deifqFuWfaAG2fXVvluiJkt89Me8yunRiU/20N/0lxILwIfJDaN4n9W8KkZsRLg4r5caHnFrV9T
 OZyqJ30kxfi4opAUrFkKcyeoHyOSAxc+UZwgrgFhd5Ws0hDj3lR5tRPoMfjdY4ueLx4RyCKtdZ/
 5ogqWycfwI/GBUlAWYIlzzhWlV6rpJ9AoF+6D/SnrodeNcAIMXr5Qxv/AeMHxo7RRlnEWlIJU2q
 sYgBogeakA2K2bldQcDBj2awL/5GlPAxKKDXZCPJNZhk3nuXjP6veY8aDbJJvfys5roCOfpySfF
 Z6ksZXAp53hABtjdFsQ2dElA6zE+vZ91Aezs3UNVkUWfiur0ccBZC50p27UL7Mgn5xlwSLyil/W
 2hS72c6ixu7C3kw==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

Implement the .notify_phystate() callback and provide the gs101 specific
phy values that need to be programmed when entering and exiting the hibern8
state.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
Changes in v4
 - Resolve Intel 0-day warning
---
 drivers/phy/samsung/phy-gs101-ufs.c   | 28 ++++++++++++++++++++++++
 drivers/phy/samsung/phy-samsung-ufs.c | 40 +++++++++++++++++++++++++++++++++++
 drivers/phy/samsung/phy-samsung-ufs.h |  7 ++++++
 3 files changed, 75 insertions(+)

diff --git a/drivers/phy/samsung/phy-gs101-ufs.c b/drivers/phy/samsung/phy-gs101-ufs.c
index 17b798da5b5761f8e367599517d2d97bf0bb6b74..a15e1f453f7f3cecd6d3aa75217633ac4b6085d0 100644
--- a/drivers/phy/samsung/phy-gs101-ufs.c
+++ b/drivers/phy/samsung/phy-gs101-ufs.c
@@ -108,12 +108,39 @@ static const struct samsung_ufs_phy_cfg tensor_gs101_post_pwr_hs_config[] = {
 	END_UFS_PHY_CFG,
 };
 
+static const struct samsung_ufs_phy_cfg tensor_gs101_post_h8_enter[] = {
+	PHY_TRSV_REG_CFG_GS101(0x262, 0x08, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x265, 0x0A, PWR_MODE_ANY),
+	PHY_COMN_REG_CFG(0x1, 0x8,  PWR_MODE_ANY),
+	PHY_COMN_REG_CFG(0x0, 0x86,  PWR_MODE_ANY),
+	PHY_COMN_REG_CFG(0x8, 0x60,  PWR_MODE_HS_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x222, 0x08, PWR_MODE_HS_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x246, 0x01, PWR_MODE_HS_ANY),
+	END_UFS_PHY_CFG,
+};
+
+static const struct samsung_ufs_phy_cfg tensor_gs101_pre_h8_exit[] = {
+	PHY_COMN_REG_CFG(0x0, 0xC6,  PWR_MODE_ANY),
+	PHY_COMN_REG_CFG(0x1, 0x0C,  PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x262, 0x00, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x265, 0x00, PWR_MODE_ANY),
+	PHY_COMN_REG_CFG(0x8, 0xE0,  PWR_MODE_HS_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x246, 0x03, PWR_MODE_HS_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x222, 0x18, PWR_MODE_HS_ANY),
+	END_UFS_PHY_CFG,
+};
+
 static const struct samsung_ufs_phy_cfg *tensor_gs101_ufs_phy_cfgs[CFG_TAG_MAX] = {
 	[CFG_PRE_INIT]		= tensor_gs101_pre_init_cfg,
 	[CFG_PRE_PWR_HS]	= tensor_gs101_pre_pwr_hs_config,
 	[CFG_POST_PWR_HS]	= tensor_gs101_post_pwr_hs_config,
 };
 
+static const struct samsung_ufs_phy_cfg *tensor_gs101_hibern8_cfgs[] = {
+	[CFG_POST_HIBERN8_ENTER]	= tensor_gs101_post_h8_enter,
+	[CFG_PRE_HIBERN8_EXIT]		= tensor_gs101_pre_h8_exit,
+};
+
 static const char * const tensor_gs101_ufs_phy_clks[] = {
 	"ref_clk",
 };
@@ -170,6 +197,7 @@ static int gs101_phy_wait_for_cdr_lock(struct phy *phy, u8 lane)
 
 const struct samsung_ufs_phy_drvdata tensor_gs101_ufs_phy = {
 	.cfgs = tensor_gs101_ufs_phy_cfgs,
+	.cfgs_hibern8 = tensor_gs101_hibern8_cfgs,
 	.isol = {
 		.offset = TENSOR_GS101_PHY_CTRL,
 		.mask = TENSOR_GS101_PHY_CTRL_MASK,
diff --git a/drivers/phy/samsung/phy-samsung-ufs.c b/drivers/phy/samsung/phy-samsung-ufs.c
index f3cbe6b17b235bb181b3fae628d75822f0c9183a..ee665f26c2361ff9c3933b10ac713bbd9085b459 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.c
+++ b/drivers/phy/samsung/phy-samsung-ufs.c
@@ -217,6 +217,44 @@ static int samsung_ufs_phy_set_mode(struct phy *generic_phy,
 	return 0;
 }
 
+static int samsung_ufs_phy_notify_state(struct phy *phy,
+					union phy_notify state)
+{
+	struct samsung_ufs_phy *ufs_phy = get_samsung_ufs_phy(phy);
+	const struct samsung_ufs_phy_cfg *cfg;
+	int i, err = -EINVAL;
+
+	if (!ufs_phy->cfgs_hibern8)
+		return 0;
+
+	if (state.ufs_state == PHY_UFS_HIBERN8_ENTER)
+		cfg = ufs_phy->cfgs_hibern8[CFG_POST_HIBERN8_ENTER];
+	else if (state.ufs_state == PHY_UFS_HIBERN8_EXIT)
+		cfg = ufs_phy->cfgs_hibern8[CFG_PRE_HIBERN8_EXIT];
+	else
+		goto err_out;
+
+	for_each_phy_cfg(cfg) {
+		for_each_phy_lane(ufs_phy, i) {
+			samsung_ufs_phy_config(ufs_phy, cfg, i);
+		}
+	}
+
+	if (state.ufs_state == PHY_UFS_HIBERN8_EXIT) {
+		for_each_phy_lane(ufs_phy, i) {
+			if (ufs_phy->drvdata->wait_for_cdr) {
+				err = ufs_phy->drvdata->wait_for_cdr(phy, i);
+				if (err)
+					goto err_out;
+			}
+		}
+	}
+
+	return 0;
+err_out:
+	return err;
+}
+
 static int samsung_ufs_phy_exit(struct phy *phy)
 {
 	struct samsung_ufs_phy *ss_phy = get_samsung_ufs_phy(phy);
@@ -233,6 +271,7 @@ static const struct phy_ops samsung_ufs_phy_ops = {
 	.power_off	= samsung_ufs_phy_power_off,
 	.calibrate	= samsung_ufs_phy_calibrate,
 	.set_mode	= samsung_ufs_phy_set_mode,
+	.notify_phystate = samsung_ufs_phy_notify_state,
 	.owner          = THIS_MODULE,
 };
 
@@ -287,6 +326,7 @@ static int samsung_ufs_phy_probe(struct platform_device *pdev)
 	phy->dev = dev;
 	phy->drvdata = drvdata;
 	phy->cfgs = drvdata->cfgs;
+	phy->cfgs_hibern8 = drvdata->cfgs_hibern8;
 	memcpy(&phy->isol, &drvdata->isol, sizeof(phy->isol));
 
 	if (!of_property_read_u32_index(dev->of_node, "samsung,pmu-syscon", 1,
diff --git a/drivers/phy/samsung/phy-samsung-ufs.h b/drivers/phy/samsung/phy-samsung-ufs.h
index a28f148081d168344b47f2798b00cb098f0a8574..f2c2e744e5bae87c9cfcaa17f4a09456f134966a 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.h
+++ b/drivers/phy/samsung/phy-samsung-ufs.h
@@ -92,6 +92,11 @@ enum {
 	CFG_TAG_MAX,
 };
 
+enum {
+	CFG_POST_HIBERN8_ENTER,
+	CFG_PRE_HIBERN8_EXIT,
+};
+
 struct samsung_ufs_phy_cfg {
 	u32 off_0;
 	u32 off_1;
@@ -108,6 +113,7 @@ struct samsung_ufs_phy_pmu_isol {
 
 struct samsung_ufs_phy_drvdata {
 	const struct samsung_ufs_phy_cfg **cfgs;
+	const struct samsung_ufs_phy_cfg **cfgs_hibern8;
 	struct samsung_ufs_phy_pmu_isol isol;
 	const char * const *clk_list;
 	int num_clks;
@@ -124,6 +130,7 @@ struct samsung_ufs_phy {
 	struct clk_bulk_data *clks;
 	const struct samsung_ufs_phy_drvdata *drvdata;
 	const struct samsung_ufs_phy_cfg * const *cfgs;
+	const struct samsung_ufs_phy_cfg * const *cfgs_hibern8;
 	struct samsung_ufs_phy_pmu_isol isol;
 	u8 lane_cnt;
 	int ufs_phy_state;

-- 
2.51.2.1041.gc1ab5b90ca-goog


