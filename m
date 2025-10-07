Return-Path: <linux-kernel+bounces-844347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9B6BC1A29
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10C21888009
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B762E22A3;
	Tue,  7 Oct 2025 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cG7mxxqy"
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E0B2D46DA
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845914; cv=none; b=lmzHgFwk/izSGrbCylgQPlco+UB5z4xbegdOXJ66Ae2CaOaFXuTi7tBzN4EOnEL9cfRIXcVM9tx+qc1p2Hsf/Amlti0ajbSytGZ1++EtooXxBTSjk49k/z/FeJ2VUYKAsP/No+7MXe5fH+PKF4pfQ0o6An7wtHBw1NU1SG1HEBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845914; c=relaxed/simple;
	bh=Qg0A7yrjSmTfEe16Vq+9wFnPNBtfh3eVH7u9xO09gLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IcWxMjw9md5Mjb+aF0uO1FzZuuz0GjphE620JfhBiaw9PMKJgLO3Vb5ktTkmbu7iNpuAq7kqHD2lQNBu8SKSU0HFTpgy2UtlicTrCderWClNbivjtDyl1aGvu0oHChPaRMTlZR1419VvO5JT5ORTqq2EKZDlPQ01QzWx6acMQ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cG7mxxqy; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-330631e534eso6913126a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 07:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759845912; x=1760450712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQDseboPoN7tnrpn/frcsPgqqEsYL+e4oPXMaYNhgu8=;
        b=rjA2xJnhHezdcUIxYb4ltTehVRmh1hpJj4B8CytnwBn2bg3xefzIHzWvcET/K1zUPz
         Onj73FA9AqBtbRlUnWlqxKNOhrsYQFxui9PahH5p5H8cXMYa7T9tnbkyxfge1CFvrXr6
         Tt6tK9/qhEALVwTvRFe5upIkwD4x8GdP8dbMdlijmKU8eLrP+yn7/U8PDql847FmCv1h
         GYjrII2dKW0mTHbhnuChr5xi3CztAbIuHC8d/4IfEpUPUD5ib8GYLZJLMojH/L3+3zgf
         WqBk1+3ZrGj/b/ZSuNMRleONIJcmEXgW526xYAI2Li+92bRwCD6Sp44DzDk9k2zsX6Od
         fAug==
X-Forwarded-Encrypted: i=1; AJvYcCUu0pZ43eHMwr7hCQuDtXuo2eoezPmeH2SpGYyM4bJmGDDWQUpUqML3wJ2RptBeEEixqHcdrl7R1Dpj3qE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLZQxR+k78TNoNjZRv8BCwVZkR27gSyHjsgXl4N4QQs+llPQkC
	l0ABkihH6ut6aOqJQZPbMcPk4SWV6K9jplHT1mJytOo9zBGyzswWLiTNoYKcgkrGfYX8eMIHyTj
	Pw8qi7O/tZqT+1hmNQBg070vIJaDFpx8TF8mkVHGLMMmZvkCGxpJmn+DcuC2vAwpRDE/HhZkCvi
	myWfixPfpe3YhXO77mDoz1ThaQYHubinrxG8ZlW++zY47mmwAhIwCd1eVynZGPFNs4mD2QggX9/
	gqT1mjpWUnN++vc
X-Gm-Gg: ASbGncvZjfM/NERS8cOrXzBa3oXn3fLGChlwkR7geOtpIY8rmP430poFJKBuKI0JOkb
	Z2abQKYGLGjfom1DU7/Fg6MT89AFaZyQ2IDPk6XJYMuCZEvSTNnoH8qYrkEvU1RIy0qH/D5L3s8
	RGJ6Z9+zP4KLYRK8tYWh2Jx+evJ/+R93V4i80zz3pcGlV3STuOZeuKTCKrOfxS6ew0U5oI3kdbA
	9zDHCQEwuiKlzm2dbGguq2CHHt/UW1A9c54/zTu5C9PVXlua1a3dKh5DhphqnACPNVRYQ69qoHR
	xDBbGpVerI734KLS2QpMTfZHUBpUxJCcyt9KwuBWuCo/CWE/K/J1lrRNCQ+SGhG0X7PPnPBiMLm
	LjGNemXf8evnAsaNz+WTIBkajMLp9c0LK5JYVRgZ23mqRHsh/E11D06rW4aWYBx8XGg6nsOFe81
	isSUH/
X-Google-Smtp-Source: AGHT+IGHccjgWx+sdMehsuXT7pAvSjH9c8wlsekHmYgy7LGRod2wjK8AJ6tYwkR9jBOfQDgB679VNY+te8kx
X-Received: by 2002:a17:90b:380a:b0:338:3221:9dc0 with SMTP id 98e67ed59e1d1-339c27d518cmr22527722a91.37.1759845911637;
        Tue, 07 Oct 2025 07:05:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-126.dlp.protect.broadcom.com. [144.49.247.126])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-339a6ea0d68sm1640418a91.1.2025.10.07.07.05.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2025 07:05:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-63541ee6187so8361075d50.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759845910; x=1760450710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQDseboPoN7tnrpn/frcsPgqqEsYL+e4oPXMaYNhgu8=;
        b=cG7mxxqyF4lIPqxiT+y7VPtcTZtY9aBQnFbN1XWLqCU6PqxavvCNy8SzrejLyu5Nc+
         b+iReiEcvl6zgn4ZeRChqIrZHsFr149G08x4zR4UfG1cBMx021c8/G72Ig5nYRvpPKRr
         v5+OB5cuGo1p0tgqAURZyY+RxQoTZnae6GyhY=
X-Forwarded-Encrypted: i=1; AJvYcCUT7SffbGKFZP8muB7UM3IfOd300ykiG+J82eLgCOOTFk9OdJRleO7pBnjfoJk6McfuY4tv/TIkAQ6AxZQ=@vger.kernel.org
X-Received: by 2002:a53:c056:0:20b0:629:9c6b:b3ab with SMTP id 956f58d0204a3-63b9a06436amr14591612d50.1.1759845909742;
        Tue, 07 Oct 2025 07:05:09 -0700 (PDT)
X-Received: by 2002:a53:c056:0:20b0:629:9c6b:b3ab with SMTP id 956f58d0204a3-63b9a06436amr14591546d50.1.1759845908938;
        Tue, 07 Oct 2025 07:05:08 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60b67sm142718956d6.9.2025.10.07.07.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 07:05:08 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: andersson@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH v2 5/5] mmc: brcmstb: save and restore registers during PM
Date: Tue,  7 Oct 2025 10:04:33 -0400
Message-Id: <20251007140434.606051-6-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251007140434.606051-1-kamal.dasu@broadcom.com>
References: <20251007140434.606051-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Added support to save and restore registers that are critical
during PM.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 112 +++++++++++++++++++++++++++++--
 1 file changed, 107 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 42709ca8111d..7de395c86f2f 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -38,28 +38,109 @@
 #define SDIO_CFG_OP_DLY_DEFAULT			0x80000003
 #define SDIO_CFG_CQ_CAPABILITY			0x4c
 #define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)
+#define SDIO_CFG_SD_PIN_SEL			0x44
+#define SDIO_CFG_V1_SD_PIN_SEL			0x54
+#define SDIO_CFG_PHY_SW_MODE_0_RX_CTRL		0x7C
 #define SDIO_CFG_MAX_50MHZ_MODE			0x1ac
 #define SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE	BIT(31)
 #define SDIO_CFG_MAX_50MHZ_MODE_ENABLE		BIT(0)
 
+#define SDIO_BOOT_MAIN_CTL			0x0
+
 #define MMC_CAP_HSE_MASK	(MMC_CAP2_HSX00_1_2V | MMC_CAP2_HSX00_1_8V)
 /* Select all SD UHS type I SDR speed above 50MB/s */
 #define MMC_CAP_UHS_I_SDR_MASK	(MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104)
 
-struct sdhci_brcmstb_priv {
-	void __iomem *cfg_regs;
-	unsigned int flags;
-	struct clk *base_clk;
-	u32 base_freq_hz;
+enum cfg_core_ver {
+	SDIO_CFG_CORE_V1 = 1,
+	SDIO_CFG_CORE_V2,
+};
+
+struct sdhci_brcmstb_saved_regs {
+	u32 sd_pin_sel;
+	u32 phy_sw_mode0_rxctrl;
+	u32 max_50mhz_mode;
+	u32 boot_main_ctl;
 };
 
 struct brcmstb_match_priv {
 	void (*cfginit)(struct sdhci_host *host);
 	void (*hs400es)(struct mmc_host *mmc, struct mmc_ios *ios);
+	void (*save_restore_regs)(struct mmc_host *mmc, int save);
 	struct sdhci_ops *ops;
 	const unsigned int flags;
 };
 
+struct sdhci_brcmstb_priv {
+	void __iomem *cfg_regs;
+	void __iomem *boot_regs;
+	struct sdhci_brcmstb_saved_regs saved_regs;
+	unsigned int flags;
+	struct clk *base_clk;
+	u32 base_freq_hz;
+	const struct brcmstb_match_priv *match_priv;
+};
+
+static void sdhci_brcmstb_save_regs(struct mmc_host *mmc, enum cfg_core_ver ver)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct sdhci_brcmstb_saved_regs *sr = &priv->saved_regs;
+	void __iomem *cr = priv->cfg_regs;
+	bool is_emmc = mmc->caps & MMC_CAP_NONREMOVABLE;
+
+	if (is_emmc && priv->boot_regs)
+		sr->boot_main_ctl = readl(priv->boot_regs + SDIO_BOOT_MAIN_CTL);
+
+	if (ver == SDIO_CFG_CORE_V1) {
+		sr->sd_pin_sel = readl(cr + SDIO_CFG_V1_SD_PIN_SEL);
+		return;
+	}
+
+	sr->sd_pin_sel = readl(cr + SDIO_CFG_SD_PIN_SEL);
+	sr->phy_sw_mode0_rxctrl = readl(cr + SDIO_CFG_PHY_SW_MODE_0_RX_CTRL);
+	sr->max_50mhz_mode = readl(cr + SDIO_CFG_MAX_50MHZ_MODE);
+}
+
+static void sdhci_brcmstb_restore_regs(struct mmc_host *mmc, enum cfg_core_ver ver)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct sdhci_brcmstb_saved_regs *sr = &priv->saved_regs;
+	void __iomem *cr = priv->cfg_regs;
+	bool is_emmc = mmc->caps & MMC_CAP_NONREMOVABLE;
+
+	if (is_emmc && priv->boot_regs)
+		writel(sr->boot_main_ctl, priv->boot_regs + SDIO_BOOT_MAIN_CTL);
+
+	if (ver == SDIO_CFG_CORE_V1) {
+		writel(sr->sd_pin_sel, cr + SDIO_CFG_SD_PIN_SEL);
+		return;
+	}
+
+	writel(sr->sd_pin_sel, cr + SDIO_CFG_SD_PIN_SEL);
+	writel(sr->phy_sw_mode0_rxctrl, cr + SDIO_CFG_PHY_SW_MODE_0_RX_CTRL);
+	writel(sr->max_50mhz_mode, cr + SDIO_CFG_MAX_50MHZ_MODE);
+}
+
+static void sdhci_brcmstb_save_restore_regs_v1(struct mmc_host *mmc, int save)
+{
+	if (save)
+		sdhci_brcmstb_save_regs(mmc, SDIO_CFG_CORE_V1);
+	else
+		sdhci_brcmstb_restore_regs(mmc, SDIO_CFG_CORE_V1);
+}
+
+static void sdhci_brcmstb_save_restore_regs_v2(struct mmc_host *mmc, int save)
+{
+	if (save)
+		sdhci_brcmstb_save_regs(mmc, SDIO_CFG_CORE_V2);
+	else
+		sdhci_brcmstb_restore_regs(mmc, SDIO_CFG_CORE_V2);
+}
+
 static inline void enable_clock_gating(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -306,22 +387,26 @@ static struct brcmstb_match_priv match_priv_74371 = {
 
 static struct brcmstb_match_priv match_priv_7445 = {
 	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
+	.save_restore_regs = sdhci_brcmstb_save_restore_regs_v1,
 	.ops = &sdhci_brcmstb_ops,
 };
 
 static struct brcmstb_match_priv match_priv_72116 = {
 	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
+	.save_restore_regs = sdhci_brcmstb_save_restore_regs_v1,
 	.ops = &sdhci_brcmstb_ops_72116,
 };
 
 static const struct brcmstb_match_priv match_priv_7216 = {
 	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
+	.save_restore_regs = sdhci_brcmstb_save_restore_regs_v2,
 	.hs400es = sdhci_brcmstb_hs400es,
 	.ops = &sdhci_brcmstb_ops_7216,
 };
 
 static struct brcmstb_match_priv match_priv_74165b0 = {
 	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
+	.save_restore_regs = sdhci_brcmstb_save_restore_regs_v2,
 	.hs400es = sdhci_brcmstb_hs400es,
 	.ops = &sdhci_brcmstb_ops_74165b0,
 };
@@ -429,6 +514,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 
 	pltfm_host = sdhci_priv(host);
 	priv = sdhci_pltfm_priv(pltfm_host);
+	priv->match_priv = match->data;
 	if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
 		priv->flags |= BRCMSTB_PRIV_FLAGS_HAS_CQE;
 		match_priv->ops->irq = sdhci_brcmstb_cqhci_irq;
@@ -446,6 +532,13 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	if (res)
 		goto err;
 
+	/* map non-standard BOOT registers if present */
+	if (host->mmc->caps & MMC_CAP_NONREMOVABLE) {
+		priv->boot_regs = devm_platform_get_and_ioremap_resource(pdev, 2, NULL);
+		if (IS_ERR(priv->boot_regs))
+			priv->boot_regs = NULL;
+	}
+
 	/*
 	 * Automatic clock gating does not work for SD cards that may
 	 * voltage switch so only enable it for non-removable devices.
@@ -536,8 +629,13 @@ static int sdhci_brcmstb_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	const struct brcmstb_match_priv *match_priv = priv->match_priv;
+
 	int ret;
 
+	if (match_priv->save_restore_regs)
+		match_priv->save_restore_regs(host->mmc, 1);
+
 	clk_disable_unprepare(priv->base_clk);
 	if (host->mmc->caps2 & MMC_CAP2_CQE) {
 		ret = cqhci_suspend(host->mmc);
@@ -553,6 +651,7 @@ static int sdhci_brcmstb_resume(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	const struct brcmstb_match_priv *match_priv = priv->match_priv;
 	int ret;
 
 	ret = sdhci_pltfm_resume(dev);
@@ -569,6 +668,9 @@ static int sdhci_brcmstb_resume(struct device *dev)
 			ret = clk_set_rate(priv->base_clk, priv->base_freq_hz);
 	}
 
+	if (match_priv->save_restore_regs)
+		match_priv->save_restore_regs(host->mmc, 0);
+
 	if (host->mmc->caps2 & MMC_CAP2_CQE)
 		ret = cqhci_resume(host->mmc);
 
-- 
2.34.1


