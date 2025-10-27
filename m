Return-Path: <linux-kernel+bounces-871641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8266AC0DFB5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9649C4F7863
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499EC258ED7;
	Mon, 27 Oct 2025 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7LUIYPJ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878CC2472BA
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570597; cv=none; b=rPhTuvlWjJ8fdNdKINgt6Br2X3EGgCzoaKmyaBZgHfLhHEciK2Tf18ksWklhDGMDFYB8molkm+XxfJBLgYKsopYQr21wNaRyTDMtJBKsjAFzKuK1nts55Kz+zrU1OmjU8IOhDVyN1w1mfAKiZVSITVjOnGxw+rAUqZguBvLPG3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570597; c=relaxed/simple;
	bh=0MHhWYGX/kbhklk4DTUuJkE6nUV8ISJicJLum5nXkNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Hn1+SC/Ijqh/6yn3gSP4HOKw7Yp0qGFMul1q+W2TYmOM38432b72B++NJFVZoB0lUXUo0RIdh+VVYz9o5AWYOu62e1AuSs9idwm1/bZYY2NYWtKlCd+D+a3zh8P6T/nD7p0N4k68qGWE7cZmwulLn2bDG4vXw2Wwjt9m3ltJnf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u7LUIYPJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so28742125e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761570593; x=1762175393; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7xHqscrzYkhG2lIf/Jsl1phTlISUiUsYRQ5MheVDiOs=;
        b=u7LUIYPJO82/I5EmqpDjDziEcBmymwusS862CivjrnGiE95VQxN7MyOmVpUTTcRV5l
         JzQRz38mrhPVixqoK3ghrtoBf5WDz0APtPvfOIAQTCwWKpfz6Z6j4K+l0bOYxstndIrY
         MN2Cafxm2Q/i4LEngYmBOnadSwNtg5hmMriB+NFW50rSEaZ3zYeXxGrFx8/r2UpwrpOX
         os8mDkEYvI63LABo9W9d+fFRqkbCh7/NjRb8aj1ye3KAlttsKuoBogUmcYPPUtHsJH9x
         vIiY8iJRvUJEKDtlRoJr/qFAioAsbkLSAgge2+4rPrpo6PLDAOrZEEXCuIekZraESB7v
         4jmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761570593; x=1762175393;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xHqscrzYkhG2lIf/Jsl1phTlISUiUsYRQ5MheVDiOs=;
        b=abYh9YoFsLbP9MxYY5pWf6KAxosqBAMk+EfSZe0XSNHSgSvwz3iwmHWHQLW2zFu4RD
         gvmeVT1KE8yzGD+eBRMfr7x4/atuDM3lZ6IVvHSCU56cpXmm91cZEt/CV0PvFrsiXZx4
         W+KS+gpn13OIzgdFsVf2OxdY3h1GXM01v7621S3FYW22E0PSZ68i8+2VcCjoYxXc/V+S
         7kc3+8c5NwKnIMGrYiNmRgRPCxR6LUlUGJLi7Es+tIJ+7BhP9Lr0s8RVxIyBXqRmXFfq
         nQnHsDQ/GZV51usEwuRcLY9RvXtg59+wDDiFCWhVT/acVHrHSJv7f+mKXVSoFEYEtubw
         Cfdg==
X-Forwarded-Encrypted: i=1; AJvYcCWNBwA7xWF6fTxPhOUd8w4vSUF6jmxeBQQlKR9rDgvEsrXongzHKFR+E76C5BiMWgx0UhEoFm12ETAUj6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHs0acm1nf3+hbOd7QewThz7YsflOog9bdf1gn5eapn9TQMBGQ
	Hc8XTz+VvucNuf2Ia1VbfyJ4N837okCNAlcUqhGqsMExWJpEdSAIOp0vB1IktbfBXaa9rnpKm5s
	xMspM
X-Gm-Gg: ASbGncuK9S+Jdzb8c6LeuxS9hckau34Q17GHFD12eK4cMGJotirFoNWYQ/r0o6cUdqW
	F7j68yyX15Z7BaK4biscdMfiwWaGWxOouiLusxKPlB88opvG4INnhEmmm4v1y12JFH7OTseIeKQ
	/aZRV1BuaHpcBrOzd379PRG+vCSEprTrcYefBIOjysuHo6iM+jvgY+EyL++mQIFalP4wdlVwnHw
	0FQElWqXaig/g4hzg3a/XVcV3Yshjs9ZG4X3ubfldsbHc9nugcijFeMv9FzekPXG6h6AhegF2v4
	Cy+ANb1p+nMgWmAMVOqw9pmsPTeXndc1y4OQnovBSVRZDSFyg1HINngsBS5yI7MHeJhKNZ6n4P/
	tOE2njIpv0fy7bSY1BmmF+MBBYbTR8EeT/HrxETksIDKqDFfRX75BkjnljlPJMIoYT1YL+pXQtR
	BukMSYkfV41twEPmWsbDKb
X-Google-Smtp-Source: AGHT+IES8xCzwpBsCQMT7GZryto4tnTz3LOicS2l1sLDuWYyCwc2CWGgf/Z8oXRtYtgEbL2ufaMPZg==
X-Received: by 2002:a05:600c:1f96:b0:46e:37af:f90e with SMTP id 5b1f17b1804b1-475caf933dfmr109940175e9.6.1761570592580;
        Mon, 27 Oct 2025 06:09:52 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd02cbc6sm139149285e9.1.2025.10.27.06.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:09:52 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 27 Oct 2025 14:09:48 +0100
Subject: [PATCH] drm/msm: dsi: fix PLL init in bonded mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-topic-sm8x50-fix-dsi-bonded-v1-1-a477cd3f907d@linaro.org>
X-B4-Tracking: v=1; b=H4sIABtv/2gC/x3MwQrDIAyA4VcpOTeQCmVhrzJ2sJq2OUzFjFEQ3
 72y4wc/fwOTqmLwnBpU+alpTgPLPEE4fToENQ6DI7cu5B74zUUD2oevlXDXC6MpbjlFiRiYd2b
 ywZOHcShVRvG/v9693wp7roxtAAAA
X-Change-ID: 20251027-topic-sm8x50-fix-dsi-bonded-c88f880aca0a
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5010;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=0MHhWYGX/kbhklk4DTUuJkE6nUV8ISJicJLum5nXkNU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo/28fcTyjsx9+jqX/RPpQrS3hH4JRvm2XTgGFUHBT
 3aFNE+6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaP9vHwAKCRB33NvayMhJ0XBpD/
 9kiq1CGfJJbbh6rIVJ9bniOAQCW8pruCTIMe1D4yZfxSqJAaYrzZvR89iEBfajyJvrFiEGNg1dfGAH
 9LeIYJOV+gX3gJCk+SGZwVtdn+3bAcp4tStw3twUpVFhoZzbw0MQJjmW5zSb6NnhIxUx40A9WE6PpI
 AgI3pCr5vsT85jofDyet7G0ODbyCMru+wRxfgb7XtF6ZZIv9rJfhmFUkNKcTsGyGUsmg4F/vCRbrj6
 bO3sWb68alm2oyd9MeafibQzE4B6QBA0SADlZUIZ4zoW6Mecr0hNxdtbtcZZFe2E7FyZgargV5AgOv
 oDPWdTyVoZIMRUJVwOwtU/DQoe1JU1BRzIJFLyXNjI0PmsjEf4JhKpzcM1Zlkq1Ko7zqN3U+9XgyZt
 2gBhZWEWfIce6HWEpPXDyk7Ihd23JEKLbBpR9G6rrdgmArUPErY17O8yGiyqF2wGIoOXc23IV/KQUg
 qOuGCdx65bSimelkoG054sv2igele2nlxr66kIxLe+VXw9yEOtiGfDMTPAX5s79vDIHOUCi4w/9lJ3
 qtCSgkgka15Dmo91Bn5jxYEvCtA0djtn16j7wsiijMTU0/W1fT7r3jzgInEqaKUnBS3b2wqvRV8IrA
 uVPGOnU3zRpYjKVXEIIMfAPFcF/YjLErCo1J3cgR96GfwKC82C3p/M5Atn0Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

When in bonded DSI mode, only one PLL in one DSI PHY is used for both
DSI PHYs, meaning that parents of the secondary DSI PHY will use the
primary DSI PHY PLL as parent.

In this case the primary DSI PHY PLL will be set even if the primary
DSI PHY is not yet enabled. The DSI PHY code has support for this
particular use-case and will handle the fact the PLL was already
set when initializing the primary DSI PHY.

By introducing a protected variable pll_enable_cnt in the commit
cb55f39bf7b1 ("drm/msm/dsi/phy: Fix reading zero as PLL rates when unprepared"),
this variable is only initially set to 1 when the DSI PHY is initialized
making it impossible to set the PLL before, breaking the bonded DSI
use case by returning 0 when setting the PLL from the secondary DSI
PHY driver and skipping the correct clocks initialization.

But since it was already possible to set the PLL without enabling
the DSI PHY, just drop the pll_enable_cnt setting from the PHY
enable/disable and simply increment/decrement the pll_enable_cnt
variable from the dsi_pll_enable/disable_pll_bias to make sure any
PLL operation is done with the PLL BIAS enabled.

Fixes: cb55f39bf7b1 ("drm/msm/dsi/phy: Fix reading zero as PLL rates when unprepared")
Closes: https://lore.kernel.org/all/50a49d72-2b1e-471d-b0c4-d5a0b38b2a21@linaro.org/
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h     |  1 -
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 18 ++----------------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
index e391505fdaf0..3cbf08231492 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
@@ -109,7 +109,6 @@ struct msm_dsi_phy {
 	struct msm_dsi_dphy_timing timing;
 	const struct msm_dsi_phy_cfg *cfg;
 	void *tuning_cfg;
-	void *pll_data;
 
 	enum msm_dsi_phy_usecase usecase;
 	bool regulator_ldo_mode;
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
index 32f06edd21a9..c5e1d2016bcc 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
@@ -426,11 +426,8 @@ static void dsi_pll_enable_pll_bias(struct dsi_pll_7nm *pll)
 	u32 data;
 
 	spin_lock_irqsave(&pll->pll_enable_lock, flags);
-	if (pll->pll_enable_cnt++) {
-		spin_unlock_irqrestore(&pll->pll_enable_lock, flags);
-		WARN_ON(pll->pll_enable_cnt == INT_MAX);
-		return;
-	}
+	pll->pll_enable_cnt++;
+	WARN_ON(pll->pll_enable_cnt == INT_MAX);
 
 	data = readl(pll->phy->base + REG_DSI_7nm_PHY_CMN_CTRL_0);
 	data |= DSI_7nm_PHY_CMN_CTRL_0_PLL_SHUTDOWNB;
@@ -876,7 +873,6 @@ static int dsi_pll_7nm_init(struct msm_dsi_phy *phy)
 	spin_lock_init(&pll_7nm->pll_enable_lock);
 
 	pll_7nm->phy = phy;
-	phy->pll_data = pll_7nm;
 
 	ret = pll_7nm_register(pll_7nm, phy->provided_clocks->hws);
 	if (ret) {
@@ -965,10 +961,8 @@ static int dsi_7nm_phy_enable(struct msm_dsi_phy *phy,
 	u32 const delay_us = 5;
 	u32 const timeout_us = 1000;
 	struct msm_dsi_dphy_timing *timing = &phy->timing;
-	struct dsi_pll_7nm *pll = phy->pll_data;
 	void __iomem *base = phy->base;
 	bool less_than_1500_mhz;
-	unsigned long flags;
 	u32 vreg_ctrl_0, vreg_ctrl_1, lane_ctrl0;
 	u32 glbl_pemph_ctrl_0;
 	u32 glbl_str_swi_cal_sel_ctrl, glbl_hstx_str_ctrl_0;
@@ -1090,13 +1084,10 @@ static int dsi_7nm_phy_enable(struct msm_dsi_phy *phy,
 		glbl_rescode_bot_ctrl = 0x3c;
 	}
 
-	spin_lock_irqsave(&pll->pll_enable_lock, flags);
-	pll->pll_enable_cnt = 1;
 	/* de-assert digital and pll power down */
 	data = DSI_7nm_PHY_CMN_CTRL_0_DIGTOP_PWRDN_B |
 	       DSI_7nm_PHY_CMN_CTRL_0_PLL_SHUTDOWNB;
 	writel(data, base + REG_DSI_7nm_PHY_CMN_CTRL_0);
-	spin_unlock_irqrestore(&pll->pll_enable_lock, flags);
 
 	/* Assert PLL core reset */
 	writel(0x00, base + REG_DSI_7nm_PHY_CMN_PLL_CNTRL);
@@ -1209,9 +1200,7 @@ static bool dsi_7nm_set_continuous_clock(struct msm_dsi_phy *phy, bool enable)
 
 static void dsi_7nm_phy_disable(struct msm_dsi_phy *phy)
 {
-	struct dsi_pll_7nm *pll = phy->pll_data;
 	void __iomem *base = phy->base;
-	unsigned long flags;
 	u32 data;
 
 	DBG("");
@@ -1238,11 +1227,8 @@ static void dsi_7nm_phy_disable(struct msm_dsi_phy *phy)
 	writel(data, base + REG_DSI_7nm_PHY_CMN_CTRL_0);
 	writel(0, base + REG_DSI_7nm_PHY_CMN_LANE_CTRL0);
 
-	spin_lock_irqsave(&pll->pll_enable_lock, flags);
-	pll->pll_enable_cnt = 0;
 	/* Turn off all PHY blocks */
 	writel(0x00, base + REG_DSI_7nm_PHY_CMN_CTRL_0);
-	spin_unlock_irqrestore(&pll->pll_enable_lock, flags);
 
 	/* make sure phy is turned off */
 	wmb();

---
base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
change-id: 20251027-topic-sm8x50-fix-dsi-bonded-c88f880aca0a

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


