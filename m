Return-Path: <linux-kernel+bounces-750681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB46B15FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D29C1890EF0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C35A298CD7;
	Wed, 30 Jul 2025 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vh9y/B6u"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C83F296163
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753876033; cv=none; b=AIZYQ16NdfMgnYrNEsFceev0n6sC/ebJKyI7g0HTcEx3PFvHIglbSV3l1tyQE22VZOJ8dfWsuDV1mLDwojWYRH5y8AfTNp9z0MNTyq9u6FXwaj4No4eIhapXFymMHV6iDeLbDP6tfHATtrQVUjWYvLp6zJk3e91hSYve89fji2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753876033; c=relaxed/simple;
	bh=TgBYRJy76udBMDySYWNWrLvaijcn07Ed0RCtJm+44cE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=McCLmsfHnPTEurxDOSETA5d8G/HEbE7iUa4AueBSPLdVzAPhD/VkrsepHprcroHnuHPYpc3znVOceqC+8ZBlYhx8mlozINnJ6OwZ+7d3ScAzWrad+FUWuwjoZFhj1XNKvlzq8caFf7l0V1DzuVOLN7oCQ8JY8TozMT1OF6CrQZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vh9y/B6u; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b783d851e6so3593772f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753876030; x=1754480830; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFnYn+gQt6+MG5K/TVuKXMgEtgBw3Z9XRwFVYYsDrdI=;
        b=vh9y/B6uwBwIwmL5Ft+EbO8NmelOGt+zoHs2g3uDX1JwK0TKdwLiSoXx6mBKYQ7Crw
         rJBek38bH2YMHS1ul1eHhjhs/JKW0QYo4y3ZNja+Gi1afu7ZALH2OsUlYaR3JRoNW3+U
         6jpqBPO4igR4CnlFLvfzbjv8GmmsroPTz9z8qGfVyu+hlwy602o2Nda+sMbWVtSyRjWi
         EtHMRNm88VHeQmpGAesnfVJ/kE44sQLQ7WdmkUuM70WFdPtETFVSyQ3JG+dybq39TGMc
         NIRzaW3gj0W9EZAIWRO/sU/MRFi7Sl3ROOhjlmaQT8vkZjIcmeGXSpuh+CD0+GC310N6
         0AGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753876030; x=1754480830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFnYn+gQt6+MG5K/TVuKXMgEtgBw3Z9XRwFVYYsDrdI=;
        b=lOlC4TC0GcPh2CYpPn6Ulp9bubPY+hvjz5OQH7qFHfOlCLhliWJ10fXe4osAazdeQY
         9JTaM8zdrAsnDujEBK/r3R1BmIzu6nqWXnmzZv919nHR+iYsBL0fEuBpW14WQlTS65Hj
         DLK340M+n+T28pYYp2Y9itFaI6kKp6kpNwCmOrTK84ALv0JetdyUJC+Q8RhYh0fvjEH0
         qIBoEoyg9VstFsMyHqhJsFvLrmMLdQdZsBkaxNStrKPdog6OIqCiQKPMEc2qEFv0EVIv
         Q82Mv6qmcd3OdeMpzOeoLocsibxfvMxkRI1+x5sr51UEACY/3QDWSBFx2kE48rXP2JJx
         IcAg==
X-Forwarded-Encrypted: i=1; AJvYcCUgHe1rc8Mo2tW2AZwYFcBEhK9ItQNJL9uLPIrkhf37vT2urNKHQ29wC4+l0uxysskLyh59aTN+yvtkZGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy11bw5wp/nZzkP3S86Vli2p0BLb0GCd8RePAZW3BMUaJ975c8V
	fbqnBW5rZvw6lW3P81jJ8tBxNAiFSWEM0MFcdJMoW/z37B+IFjSrApIcJ14E4/v4Bko=
X-Gm-Gg: ASbGncvgSjwPKvDZpOCsWlB2TcX5/rZcS3AAKNzbU+RuOvLolmL4lADxOGJ2ku2GyjZ
	p33mR05ZAegeLjnAr+n0L4ApKtpR24r2AJRmXk1HNoepuIdhSDEsin2lfXKXSWqhr/9MEh+OCRy
	56QtGRWX64KScFdzdyaq/fDBh+qSjWTL55hzkKLUDopsQbzE6Q8dyYDX2vCsI9F/ozZT9W+Oqon
	2rDZGdO6e5HukfKDr5+5V/FzjiCo1+UFFR9trI0a9TWx6PGyoxkbW83cE0O3hw04i7k1ZDvZ76y
	T8zZYFnBjpNhDxl2X/uqsl3ixDd7SNn1yga+BhFDijc21kPhQdR+LmdljjHAOH3bzUOBjfkBjv+
	i0neDRI4lgBvziv430Xbv
X-Google-Smtp-Source: AGHT+IFMji6om7tlTNWa3TC7JHM7L0ptnzBOJ1YCf2Ql8mWH/oJ5ojl7gyzzXBirrKhH28LDNZgVEQ==
X-Received: by 2002:a05:6000:2210:b0:3b7:8a03:4b6f with SMTP id ffacd0b85a97d-3b794ffe6cemr2315812f8f.29.1753876029714;
        Wed, 30 Jul 2025 04:47:09 -0700 (PDT)
Received: from [127.0.1.1] ([82.79.186.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953eaeeesm24503235e9.25.2025.07.30.04.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 04:47:08 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 30 Jul 2025 14:46:49 +0300
Subject: [PATCH 2/3] phy: qcom: edp: Add missing refclk for X1E80100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-phy-qcom-edp-add-missing-refclk-v1-2-6f78afeadbcf@linaro.org>
References: <20250730-phy-qcom-edp-add-missing-refclk-v1-0-6f78afeadbcf@linaro.org>
In-Reply-To: <20250730-phy-qcom-edp-add-missing-refclk-v1-0-6f78afeadbcf@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4867; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=TgBYRJy76udBMDySYWNWrLvaijcn07Ed0RCtJm+44cE=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBoigY1doaswV8VD2318yl/LfkNsEW+6sNCWpajc
 PSF0sKaLCuJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaIoGNQAKCRAbX0TJAJUV
 VhAjD/4+VMHhxoeu9h/2nzfsGIvYgKCWkQF9w9Zox7i91PDgwD+pH1RVv3v/lXQGM2dVSKHI9Kf
 mmkrqJdeU7kxdBFkZ6LJGpfYJYAAL0A4RMa6L7ps1O9482bcpNuilxc3UtZBzbmmsWMZtmqz1BM
 XbWtZ9iGEjelgUF4bsxMLNgwM/vvPjPofwhlvLqU4Wf2vnpONd7ydb1rwaBGd3KIPZvOPPgOIjm
 Lvfew11goRPnEkxsLZiX8Psn+lq/PF2RiGROg8E3ASS35Vvm7s/TBCyZ+U7gBZov1As3Lp8z6bK
 kHHC+iWVRtqlDq2wM1WmfQ4Ptc3dCNy/YObXZnLfDSGyMC4n44yKCAK0s60UEd57iqUfPTitoOD
 8t6lIkuEGUJdNZ1MJ+gcEiiBy3Ffa/b/jcdyQQ5AbypZMiC7nH7VqWu8By2SiKNYnhQrirFK5lU
 UMA19UqdID9N4ws5zjpV78tKEZdtqk+wyJqz/jYIt4XE28VN4Lu7ZHOpH4rtS4uvxPic11m3vb0
 V3Ywg3dSKTv0dOdIwa+vmqh2sM1wVCKmJeouRJLHVUONKJ+GCC2IPOyCkFd1RvRtH9j78NlBuA2
 +I5XKn39dNIngtJ7LAYXrCSiR/2flI1Xc33ak6fpDCER9506M2Lx/nHvwnATGDe4xP7RExP/Xg3
 8pMWty4e+D7rQUA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

On X Elite, the DP PHY needs another clock called refclk.
Rework the match data to allow passing different number of clocks and
add the refclk to the X1E80100 config data.

Cc: stable@vger.kernel.org # v6.10
Fixes: db83c107dc29 ("phy: qcom: edp: Add v6 specific ops and X1E80100 platform support")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 43 +++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index f1b51018683d51df064f60440864c6031638670c..785de5bc6d1a8b11bd4cb87d8fa52dc2baa56646 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -85,6 +85,8 @@ struct qcom_edp_phy_cfg {
 	const u8 *aux_cfg;
 	const struct qcom_edp_swing_pre_emph_cfg *swing_pre_emph_cfg;
 	const struct phy_ver_ops *ver_ops;
+	const char * const *clks;
+	int num_clks;
 };
 
 struct qcom_edp {
@@ -103,9 +105,11 @@ struct qcom_edp {
 
 	struct phy_configure_opts_dp dp_opts;
 
-	struct clk_bulk_data clks[2];
 	struct regulator_bulk_data supplies[2];
 
+	struct clk_bulk_data *clks;
+	int num_clks;
+
 	bool is_edp;
 };
 
@@ -218,7 +222,7 @@ static int qcom_edp_phy_init(struct phy *phy)
 	if (ret)
 		return ret;
 
-	ret = clk_bulk_prepare_enable(ARRAY_SIZE(edp->clks), edp->clks);
+	ret = clk_bulk_prepare_enable(edp->num_clks, edp->clks);
 	if (ret)
 		goto out_disable_supplies;
 
@@ -524,6 +528,10 @@ static int qcom_edp_com_configure_pll_v4(const struct qcom_edp *edp)
 	return 0;
 }
 
+static const char * const qcom_edp_clks_v4[] = {
+	"aux", "cfg_ahb",
+};
+
 static const struct phy_ver_ops qcom_edp_phy_ops_v4 = {
 	.com_power_on		= qcom_edp_phy_power_on_v4,
 	.com_resetsm_cntrl	= qcom_edp_phy_com_resetsm_cntrl_v4,
@@ -537,17 +545,23 @@ static const struct qcom_edp_phy_cfg sa8775p_dp_phy_cfg = {
 	.aux_cfg = edp_phy_aux_cfg_v5,
 	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg_v5,
 	.ver_ops = &qcom_edp_phy_ops_v4,
+	.clks = qcom_edp_clks_v4,
+	.num_clks = ARRAY_SIZE(qcom_edp_clks_v4),
 };
 
 static const struct qcom_edp_phy_cfg sc7280_dp_phy_cfg = {
 	.aux_cfg = edp_phy_aux_cfg_v4,
 	.ver_ops = &qcom_edp_phy_ops_v4,
+	.clks = qcom_edp_clks_v4,
+	.num_clks = ARRAY_SIZE(qcom_edp_clks_v4),
 };
 
 static const struct qcom_edp_phy_cfg sc8280xp_dp_phy_cfg = {
 	.aux_cfg = edp_phy_aux_cfg_v4,
 	.swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v4,
+	.clks = qcom_edp_clks_v4,
+	.num_clks = ARRAY_SIZE(qcom_edp_clks_v4),
 };
 
 static const struct qcom_edp_phy_cfg sc8280xp_edp_phy_cfg = {
@@ -555,6 +569,8 @@ static const struct qcom_edp_phy_cfg sc8280xp_edp_phy_cfg = {
 	.aux_cfg = edp_phy_aux_cfg_v4,
 	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v4,
+	.clks = qcom_edp_clks_v4,
+	.num_clks = ARRAY_SIZE(qcom_edp_clks_v4),
 };
 
 static int qcom_edp_phy_power_on_v6(const struct qcom_edp *edp)
@@ -730,10 +746,16 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v6 = {
 	.com_configure_ssc	= qcom_edp_com_configure_ssc_v6,
 };
 
+static const char * const qcom_edp_clks_v6[] = {
+	"aux", "cfg_ahb", "refclk",
+};
+
 static struct qcom_edp_phy_cfg x1e80100_phy_cfg = {
 	.aux_cfg = edp_phy_aux_cfg_v4,
 	.swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v6,
+	.clks = qcom_edp_clks_v6,
+	.num_clks = ARRAY_SIZE(qcom_edp_clks_v6),
 };
 
 static int qcom_edp_phy_power_on(struct phy *phy)
@@ -885,7 +907,7 @@ static int qcom_edp_phy_exit(struct phy *phy)
 {
 	struct qcom_edp *edp = phy_get_drvdata(phy);
 
-	clk_bulk_disable_unprepare(ARRAY_SIZE(edp->clks), edp->clks);
+	clk_bulk_disable_unprepare(edp->num_clks, edp->clks);
 	regulator_bulk_disable(ARRAY_SIZE(edp->supplies), edp->supplies);
 
 	return 0;
@@ -1066,7 +1088,7 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
 	struct qcom_edp *edp;
-	int ret;
+	int ret, i;
 
 	edp = devm_kzalloc(dev, sizeof(*edp), GFP_KERNEL);
 	if (!edp)
@@ -1092,9 +1114,16 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(edp->pll))
 		return PTR_ERR(edp->pll);
 
-	edp->clks[0].id = "aux";
-	edp->clks[1].id = "cfg_ahb";
-	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(edp->clks), edp->clks);
+	edp->clks = devm_kcalloc(dev, edp->cfg->num_clks, sizeof(*edp->clks), GFP_KERNEL);
+	if (IS_ERR(edp->clks))
+		return PTR_ERR(edp->clks);
+
+	for (i = 0; i < edp->cfg->num_clks; i++)
+		edp->clks[i].id = edp->cfg->clks[i];
+
+	edp->num_clks = edp->cfg->num_clks;
+
+	ret = devm_clk_bulk_get(dev, edp->num_clks, edp->clks);
 	if (ret)
 		return ret;
 

-- 
2.34.1


