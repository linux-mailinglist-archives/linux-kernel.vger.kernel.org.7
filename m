Return-Path: <linux-kernel+bounces-844345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13084BC1A44
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B03C4F791C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247AA2E1F06;
	Tue,  7 Oct 2025 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GUvzSFsz"
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62CE2E1C7B
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845907; cv=none; b=N8nMBRveylgjsZJbf09qQEPPH9wXW1BsTG20nuhl+aFAKH4fZ6dr3AN9xCvJTaa0lOR2cCe/y46Ya0/6WALKAEDRk+4HhY+KfQWQxvENCsnvz2YlPDUohcmmjKw1RiFEjCGt00qGTk6PnuKaPMGKrB1+D+8t7mKJwR7T/nrcRSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845907; c=relaxed/simple;
	bh=1i3B2dKT5sbTWo1nJf5tI4NTlUOkK2mEIdt9GtsoDag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pvX5mY1ZHoJXX2NhQA2NUj6VK5K2SyMa4kQfFvX1NYO0SAX6m39DZbKOABi+HlekHj7REuAn3ejiFkaIu/S+uj3/fo9IwiP0dfrCGDEyHuMFkaGNjKkXjyVb/9JEgLjuVhU4i4T6Cy9ybYDVHELa0E7iGNnjrs8/JcgQA8Issio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GUvzSFsz; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-394587df7c4so3135376fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 07:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759845905; x=1760450705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEmNG5dHeCrJHUC2bFy2N+BBQV+BhaaczeWYkzApDTU=;
        b=mgUKdmmJX7qLH0DCuHfELxww8nZh/51HNIzUTXG3GHspXjRDdnvhqtsVmi97MHnlad
         s30zVAgJeJ3fgcTm1ewlyWGwtUII3VAgGu+7dE24vH8zqWRPBP1pVU1PLzuj5NeR58/K
         uctc53QI5FziXMy3Hlo3ILkNqegTi5DStK1JBPTKifnTCKOCPDyYJA7/aD1rBH+NcbHU
         erRflOfmBvjPRe5bOE3zuL3y9qg2f3z1y4ActeipDYcb1PmmOjPXjoz0tEwzPOOqdK1f
         v27re65fk9ajghHL4VqnBHr/HxufgWgPVokaMg8YEkEOVf018LNbN/4UreEbtt20JbRH
         zQWw==
X-Forwarded-Encrypted: i=1; AJvYcCV5q6Di3waREllOLhELM4OzkK+c6IS+ZFX4aWjCMF+h20lvMZ3SK03WuFDK2wzDahcjp5Rob8pt37U5iLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbUxAtdEWDUV+RM/5xfJ6B2l8JG1UtYkDrljBt3Z9Giq3AOO/D
	3tUkWvaGfvtpCEI4d7TocDpC7kjAnPaIb7xlUNJXqz07l6TwfCFf1UAao4fjZDl5PMxBlZpJHHR
	Ta3z6OYJSI27ql1S0ZzJLzHVvwUxcok2X58nu4+6IvzrwnytlIDXpbLRArc+u8a4qY+3sVBFGBS
	p14+lqFDvc/3eSWnWSSL4PL79iYZb1ULLHyvLRa5BNpGSVaqTd7gQ7S1Ibtg0wRd/qEgmVrReer
	k9vRhjgajBdAZR6
X-Gm-Gg: ASbGncureVpvDZZbsstR/fOyvpXQ6++rE9KEYyvCT5FX+zOX8jTPbUecm5Lp4usiEek
	rseH0m7zGDS8bCnVf7Z4aj8wu7MNiqg84y/FManHYtNwTUGhnKihfX0rNtcMGgZBDXjSWpgxW4L
	wWTEkJIUdRCGrAxSqXBm389m95NkRGGXwNNxl4CKiFS/j4F+6OzronNK+2D0pf6nS/4oMq9wT6O
	1azavrJ0QU3401wmfytxv9Ty88BovsCH+0wxQnOGZlUMuCpxwX7/zG3mPsRe0nXJUKWLbXbevf4
	HQJpr564BEi9UN1ZRkTgqQtqxQg9y61A52c22LOq8yK4KI7pLlNHMJ/Ur+dAlsoIsN6JYD3IClO
	/PEdY89vbcbnce2tQ1DQmSK6KglbfLRZCRPQZvA7xSUJyXl+UvDQ3jZZb6CFejwxafwhlj7jSe3
	HIU6jz
X-Google-Smtp-Source: AGHT+IHa5OGWgTynauHp7mleJAzHKoDAPckClzpKnNfUyUl9SnPofYbFoyb2bKUla3Wv4tk9okOkCY7gEdqu
X-Received: by 2002:a05:6870:e254:b0:380:527e:50b2 with SMTP id 586e51a60fabf-3b0fd1ceaf6mr6898213fac.18.1759845904502;
        Tue, 07 Oct 2025 07:05:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3ab94d987e1sm1346179fac.18.2025.10.07.07.05.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2025 07:05:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87a0e9be970so12606716d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 07:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759845903; x=1760450703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEmNG5dHeCrJHUC2bFy2N+BBQV+BhaaczeWYkzApDTU=;
        b=GUvzSFsz3t7AFWVp10npn4zrQGybHAYgVQVwGHdChjeDs6I/3Ex+i/iW+M+BZLnHmn
         DiAulHzbq7gj/FYSHJKD2QTCs3Q4T10wNIL+nX8YIXR1BgRDs0iO3L+Emk6T15svIwmn
         9nySPWIWAkOONec6Gf5YStrksf9AY5++zLZyE=
X-Forwarded-Encrypted: i=1; AJvYcCUpppi3CpFDqWmTHanhiYoosNWL5+Bap2TDMdyqjBKlnTXbZJV/Rpl09zXl7t35v22EaLa1zedk7RXh99c=@vger.kernel.org
X-Received: by 2002:a05:6214:4113:b0:818:f4ef:daab with SMTP id 6a1803df08f44-879dc7c243bmr192632026d6.26.1759845902167;
        Tue, 07 Oct 2025 07:05:02 -0700 (PDT)
X-Received: by 2002:a05:6214:4113:b0:818:f4ef:daab with SMTP id 6a1803df08f44-879dc7c243bmr192630956d6.26.1759845901002;
        Tue, 07 Oct 2025 07:05:01 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60b67sm142718956d6.9.2025.10.07.07.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 07:05:00 -0700 (PDT)
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
Subject: [PATCH v2 3/5] mmc: sdhci-brcmstb: clear CFG_OP_DLY when using HS200
Date: Tue,  7 Oct 2025 10:04:31 -0400
Message-Id: <20251007140434.606051-4-kamal.dasu@broadcom.com>
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

Clear SDIO_1_CFG_OP_DLY register when using HS200 mode to be
compliant with timing spec.  We only need this for on BCM72116
SoCs.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index f81cc1889ac9..d25bf71d79f4 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -34,6 +34,8 @@
 #define SDIO_CFG_CTRL				0x0
 #define SDIO_CFG_CTRL_SDCD_N_TEST_EN		BIT(31)
 #define SDIO_CFG_CTRL_SDCD_N_TEST_LEV		BIT(30)
+#define SDIO_CFG_OP_DLY				0x34
+#define SDIO_CFG_OP_DLY_DEFAULT			0x80000003
 #define SDIO_CFG_CQ_CAPABILITY			0x4c
 #define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)
 #define SDIO_CFG_MAX_50MHZ_MODE			0x1ac
@@ -210,6 +212,21 @@ static void sdhci_brcmstb_cfginit_2712(struct sdhci_host *host)
 	}
 }
 
+static void sdhci_brcmstb_set_72116_uhs_signaling(struct sdhci_host *host, unsigned int timing)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u32 reg;
+
+	/* no change to SDIO_CFG_OP_DLY_DEFAULT when using preset clk rate */
+	if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
+		return;
+
+	reg = (timing == MMC_TIMING_MMC_HS200) ? 0 : SDIO_CFG_OP_DLY_DEFAULT;
+	writel(reg, priv->cfg_regs + SDIO_CFG_OP_DLY);
+	sdhci_set_uhs_signaling(host, timing);
+}
+
 static void sdhci_brcmstb_dumpregs(struct mmc_host *mmc)
 {
 	sdhci_dumpregs(mmc_priv(mmc));
@@ -250,6 +267,13 @@ static struct sdhci_ops sdhci_brcmstb_ops_2712 = {
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
+static struct sdhci_ops sdhci_brcmstb_ops_72116 = {
+	.set_clock = sdhci_set_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_brcmstb_set_72116_uhs_signaling,
+};
+
 static struct sdhci_ops sdhci_brcmstb_ops_7216 = {
 	.set_clock = sdhci_brcmstb_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -280,6 +304,11 @@ static struct brcmstb_match_priv match_priv_7445 = {
 	.ops = &sdhci_brcmstb_ops,
 };
 
+static struct brcmstb_match_priv match_priv_72116 = {
+	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
+	.ops = &sdhci_brcmstb_ops_72116,
+};
+
 static const struct brcmstb_match_priv match_priv_7216 = {
 	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
 	.hs400es = sdhci_brcmstb_hs400es,
@@ -296,6 +325,7 @@ static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
 	{ .compatible = "brcm,bcm2712-sdhci", .data = &match_priv_2712 },
 	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
 	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
+	{ .compatible = "brcm,bcm72116-sdhci", .data = &match_priv_72116 },
 	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
 	{ .compatible = "brcm,bcm74165b0-sdhci", .data = &match_priv_74165b0 },
 	{},
-- 
2.34.1


