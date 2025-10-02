Return-Path: <linux-kernel+bounces-840797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EA1BB5747
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 23:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ACD54A5479
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 21:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124A0278E67;
	Thu,  2 Oct 2025 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Lla/DPB3"
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C42C8C1F
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759439101; cv=none; b=EfGAtji5P1Xk2f5I4IZpcEAsOSsPz10zvVsMEIHpZE+e/9YH7VgCYzT+zQYdqZE6XuoWnFjsc8c31kfz/lDeX8FaB5dExqjFeji+m7PLFKS0zJ1bRI7kPLoh7UvUv7zdKSmrr05t6W4CiAsGEtmVgA15Fy4IxdLh9RmzYoHEDIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759439101; c=relaxed/simple;
	bh=6TAVlTK+sXTzkna2XCGhzK3JAQmXwZYk58u9/NK5elY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Koz7D8W2OTdJeEJ82PJJqGG5rBtHNHEWKjRaM1IJUmfncTDqofarqSASoQoVX/CR+TL1MujfttJZp4aRI9qnclJ/3oap2ahyyotpcgRJGF1LyVub8jGjZyIxBC8eou/V9uFmr9nRfdgyEZdHoZKhStF9q1HZm1JAjD1d3ai1Ku4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Lla/DPB3; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-7f7835f4478so11880096d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759439098; x=1760043898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cwbGC/K9B4U3uycXerXPSUMJfx+iuM+3b1WmPO2FpvA=;
        b=wXqd8yoDTlpOwgHm9Td7dEQxckjXm+ml4LudJO/ydFsumbimazYyZOfGK06wFbbpmU
         g06GEYvZccCSifQwjSxkMRA/q/tUbA3DWb0K83Wz5lvstMVI0Head2TqCfeKcA98odaQ
         mhroizLnHLjLPWvJuf8vTg44nBEWy6aAPaeokgmXw1Vu6xqPpYQowe6aOb1XfRlke78B
         YNKh2xtE8lowbgX5SBILeDCSeYO+SBywarwmPh0CufXxkEx0riCMp9UlXtil3LxKaC6h
         2T1VTk8+aLmnYf4m388DObN7LixFxlT6e1RpFMTeh/kJyUyStC0/bu2OitwkkYbbdzAQ
         iriA==
X-Forwarded-Encrypted: i=1; AJvYcCUuGd1FkrHxZnqrSsy9T0w9QFPPMNvzbrDVt23GkSK0OWmC0ea+BrfDqIE2pvmlGAqj9GJ/gfuHSakR0a4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQOIznfcox4Qw959qnErTs/+X7CQ8ptLnY0UNTlx57B+Ehr2PO
	It2jkp6xTRM0JoMjBOgQQ0/hzxUQBhxua5w4TddKDDE1OBELJci5OB4JH7lhenkhrutwTKix6Qj
	GWjoar6/3Qxcm8zm62xFiiPns7ZYKbZmWkLlK0FHTNtHIyTphAYimb4DHdmXLD5mBOZVx2XWCHm
	M0RvOS3sK2tiv6uD5Ku46MalhXmRo3leUYbQ4sQnTGQvpBzvi5GfpXYcPP+3SrSD3pR8rgRswNL
	9zL8fYmUKxQrwYS
X-Gm-Gg: ASbGncvwdEhcp/rA6N7E39SAjACVBmFLZtqTYT6CTdgfg6xeZwuduL73Jdnt8kMwZBj
	xLdSAieRCdCHONXS08g3jNjkMpRkcRNz7uqr/SmTLUa//9y/jUWIsCbWFGFVx4Sm0DheVeLCnSz
	8Czu+9FFr3Fr3eTl8TWAGRCjd6iOqEU7NqLvLQAZFJpiXOpsO9wPJkiJYM+0+rhyCTvF5LJG31y
	F8fDYD2IIyEXsyNMYrN3hnscI4cQ9TeVVKRTPX8MsIZgN+yWPQ2Kl2tAz03ksSP2p6S5ojzXX3I
	mKQUmmAmvZjJ6xVBeWSltTAdc3hOCWBE/3jQbYfyHEb6gdYnF2cW+dLmQGt/+LUXQe8mWHntORs
	ReRMYn8p0hbPbTzulB3onqnY3hCXHNrP+3je1VJJ7MsVW4IALygZyDgYxikdbINverFjwhBQLf3
	xWLpU3
X-Google-Smtp-Source: AGHT+IEsvUaq2TEyEddJdX+v+8qY140QT9ScCkLHnR7snSPcRwaAtAiqtQYmkys93BrI70eXSS8fl9B+VXiJ
X-Received: by 2002:a05:6214:300b:b0:803:ebdc:58 with SMTP id 6a1803df08f44-879dc7e61a2mr10362716d6.24.1759439098131;
        Thu, 02 Oct 2025 14:04:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-878be71f54fsm2106576d6.38.2025.10.02.14.04.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Oct 2025 14:04:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e2c11b94cso8158055e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759439096; x=1760043896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwbGC/K9B4U3uycXerXPSUMJfx+iuM+3b1WmPO2FpvA=;
        b=Lla/DPB3WmnBpFo58glyl4E1EX6loBo97OZDqbimiK2yb+184P1kmNfbe/ttz7DQIU
         dYWeo1bUOoQV6YnXIy045g4h3YXEYUUskeexlto/34/ObsXE+2AfmGGuHZijUNDkOtmt
         tGD1bpDtn2tUC/d2he9dbo726UHcR0fduO9BU=
X-Forwarded-Encrypted: i=1; AJvYcCWRQ1QxLWOoVSnMqS3b15rwiEOayKa/3lfahAUhyxtqvxF8IlSmGH1cWXVn4lVzU6Fb1ULBrD3RxzijoX4=@vger.kernel.org
X-Received: by 2002:a05:600c:8b22:b0:45b:4a98:91cf with SMTP id 5b1f17b1804b1-46e71102657mr4393345e9.15.1759439096532;
        Thu, 02 Oct 2025 14:04:56 -0700 (PDT)
X-Received: by 2002:a05:600c:8b22:b0:45b:4a98:91cf with SMTP id 5b1f17b1804b1-46e71102657mr4393165e9.15.1759439096023;
        Thu, 02 Oct 2025 14:04:56 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5c4c0321sm61711295e9.8.2025.10.02.14.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:04:55 -0700 (PDT)
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
Subject: [PATCH 3/3] mmc: brcmstb: save and restore registers during PM
Date: Thu,  2 Oct 2025 17:04:26 -0400
Message-Id: <20251002210426.2490368-4-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251002210426.2490368-1-kamal.dasu@broadcom.com>
References: <20251002210426.2490368-1-kamal.dasu@broadcom.com>
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
 drivers/mmc/host/sdhci-brcmstb.c | 124 +++++++++++++++++++++++++++++--
 1 file changed, 119 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 0905b316a24b..ffa602a99ab7 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -24,7 +24,9 @@
 #define BRCMSTB_MATCH_FLAGS_NO_64BIT		BIT(0)
 #define BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT	BIT(1)
 #define BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE	BIT(2)
-#define BRCMSTB_MATCH_FLAGS_USE_CARD_BUSY	BIT(4)
+#define BRCMSTB_MATCH_FLAGS_HAS_CFG_V1		BIT(3)
+#define BRCMSTB_MATCH_FLAGS_HAS_CFG_V2		BIT(4)
+#define BRCMSTB_MATCH_FLAGS_USE_CARD_BUSY	BIT(5)
 
 #define BRCMSTB_PRIV_FLAGS_HAS_CQE		BIT(0)
 #define BRCMSTB_PRIV_FLAGS_GATE_CLOCK		BIT(1)
@@ -38,19 +40,39 @@
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
+};
+
 struct sdhci_brcmstb_priv {
 	void __iomem *cfg_regs;
+	void __iomem *boot_regs;
+	struct sdhci_brcmstb_saved_regs saved_regs;
 	unsigned int flags;
 	struct clk *base_clk;
 	u32 base_freq_hz;
+	void (*save_restore_regs)(struct mmc_host *mmc, int save);
 };
 
 struct brcmstb_match_priv {
@@ -60,6 +82,69 @@ struct brcmstb_match_priv {
 	const unsigned int flags;
 };
 
+static void sdhci_brcmstb_save_regs(struct mmc_host *mmc, enum cfg_core_ver ver)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct sdhci_brcmstb_saved_regs *sr = &priv->saved_regs;
+	void __iomem *cr = priv->cfg_regs;
+	bool is_emmc = mmc->caps & MMC_CAP_NONREMOVABLE;
+
+	/* save  */
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
+static void sdhci_brcmstb_restore_regs(struct mmc_host *mmc,
+						enum cfg_core_ver ver)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct sdhci_brcmstb_saved_regs *sr = &priv->saved_regs;
+	void __iomem *cr = priv->cfg_regs;
+	bool is_emmc = mmc->caps & MMC_CAP_NONREMOVABLE;
+
+	/* restore */
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
@@ -300,24 +385,33 @@ static struct brcmstb_match_priv match_priv_7425 = {
 	.ops = &sdhci_brcmstb_ops,
 };
 
-static struct brcmstb_match_priv match_priv_7445 = {
+static struct brcmstb_match_priv match_priv_74371 = {
 	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
 	.ops = &sdhci_brcmstb_ops,
 };
 
+static struct brcmstb_match_priv match_priv_7445 = {
+	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT |
+			BRCMSTB_MATCH_FLAGS_HAS_CFG_V1,
+	.ops = &sdhci_brcmstb_ops,
+};
+
 static struct brcmstb_match_priv match_priv_72116 = {
-	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
+	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT |
+			BRCMSTB_MATCH_FLAGS_HAS_CFG_V1,
 	.ops = &sdhci_brcmstb_ops_72116,
 };
 
 static const struct brcmstb_match_priv match_priv_7216 = {
-	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
+	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE |
+			BRCMSTB_MATCH_FLAGS_HAS_CFG_V2,
 	.hs400es = sdhci_brcmstb_hs400es,
 	.ops = &sdhci_brcmstb_ops_7216,
 };
 
 static struct brcmstb_match_priv match_priv_74165b0 = {
-	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
+	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE |
+			BRCMSTB_MATCH_FLAGS_HAS_CFG_V2,
 	.hs400es = sdhci_brcmstb_hs400es,
 	.ops = &sdhci_brcmstb_ops_74165b0,
 };
@@ -325,6 +419,7 @@ static struct brcmstb_match_priv match_priv_74165b0 = {
 static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
 	{ .compatible = "brcm,bcm2712-sdhci", .data = &match_priv_2712 },
 	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
+	{ .compatible = "brcm,bcm74371-sdhci", .data = &match_priv_74371 },
 	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
 	{ .compatible = "brcm,bcm72116-sdhci", .data = &match_priv_72116 },
 	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
@@ -441,6 +536,19 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	if (res)
 		goto err;
 
+	/* map non-standard BOOT registers if present */
+	if (host->mmc->caps & MMC_CAP_NONREMOVABLE) {
+		priv->boot_regs = devm_platform_get_and_ioremap_resource(pdev, 2, NULL);
+		if (IS_ERR(priv->boot_regs))
+			priv->boot_regs = NULL;
+	}
+
+	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_HAS_CFG_V1)
+		priv->save_restore_regs = sdhci_brcmstb_save_restore_regs_v1;
+
+	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_HAS_CFG_V2)
+		priv->save_restore_regs = sdhci_brcmstb_save_restore_regs_v2;
+
 	/*
 	 * Automatic clock gating does not work for SD cards that may
 	 * voltage switch so only enable it for non-removable devices.
@@ -533,6 +641,9 @@ static int sdhci_brcmstb_suspend(struct device *dev)
 	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
+	if (priv->save_restore_regs)
+		priv->save_restore_regs(host->mmc, 1);
+
 	clk_disable_unprepare(priv->base_clk);
 	if (host->mmc->caps2 & MMC_CAP2_CQE) {
 		ret = cqhci_suspend(host->mmc);
@@ -564,6 +675,9 @@ static int sdhci_brcmstb_resume(struct device *dev)
 			ret = clk_set_rate(priv->base_clk, priv->base_freq_hz);
 	}
 
+	if (priv->save_restore_regs)
+		priv->save_restore_regs(host->mmc, 0);
+
 	if (host->mmc->caps2 & MMC_CAP2_CQE)
 		ret = cqhci_resume(host->mmc);
 
-- 
2.34.1


