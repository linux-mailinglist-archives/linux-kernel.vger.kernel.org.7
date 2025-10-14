Return-Path: <linux-kernel+bounces-852256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1965BD88B0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 704FA352174
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEF0308F1E;
	Tue, 14 Oct 2025 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lcTUX/ej"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CC22F90CE
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435198; cv=none; b=h07Qq8dBEpKFZMMTwvoyAoUCOLpOEjPZ5uy3JupoALuH5jcyMxTEYe1z171YJbl7CAXtcl5NkHXCOzKtPwEZUaeAF5iqOMW4kYbN5Q7CHih0JNuzot1SpI8DQMjQs3R1iAH9kLeKAevRbaGIVrcXd1mm/a9//6q9f1rTYwKhtCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435198; c=relaxed/simple;
	bh=Zz2R5WmG71VGhvfhWPgwTOijPEaexpycDrO5L76SRq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=byy9/ZL9MRcNgLk4NO6TvVjj2XaLfa8ASy5PgQEnj4ikn2nJlOKJj1lq0dR4BTkMB9FiAPzePY/bQKsAK5Q541bc4Cgg4nkgFwX8CBgpRvNiJ2WK3Vln+KR+3ctYufDLhsP43um9Ld/qMBDYpCDZCfoGef5FvuMMBLXmLiLAUkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lcTUX/ej; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42420c7de22so2316377f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760435195; x=1761039995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bzu7zb69wVj+tqTtPM7cxHp0BkBV/6RIMLEciU347jg=;
        b=lcTUX/ejkRbzORzr9IPK9zhFnjyNhudJmksebExeKVirj4jbMtYllsoK1erLiuI4xb
         IiyfsmCc95W/xCu5HaWZjmvqWPvj3TpEs8j/R0S0dR4DtS+/VlKHVsJuyMAYHhPzcu1B
         Um9W0uX5NZwp7cJJo5J5QQeYL1CEqMdrkCDr9BhR6/sWaZsJvSNZmM7RtML5Dql/nJ4n
         MSwLladLX2cDgM9/CqkaAaiohAyG+VjaeY28L4qYkZxuZVtgG1RXhNbNNpxhF7jCaEGG
         857mWTmgcaleZjcVlXbWiemRx9Uxa0bFP9EPw7c/a6UVdmnZHksSQbnwI7e09Vs16e3x
         44Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760435195; x=1761039995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bzu7zb69wVj+tqTtPM7cxHp0BkBV/6RIMLEciU347jg=;
        b=CYDGmrP4h1q+uN0OuusabRBlrc+f00NrxU/hV2K6q1XNVqHcTIPGOhdM76/jTp2WuZ
         2JQrk14fE5NmF3u05bcR2Rz57GIwj3Z6DOVYsTAC+ps18+vWML6kKw+cNp/cXKEWZ5ud
         k+fL8ic4xTxT+BpqQELEdOpzbVLhq2fB2v4ta5mOzHtRQV8k0wy1CK8Vb3tPzhWeZxGV
         MLsv5O0wkkJjoSmes/tUslPE9yE0W+rGMUR942QOS87f1A2G0K3meVDIQC2thUuYoJqY
         yXGDwYR7gz9j85G52GEGTwKCO4smoMaCEVl3XGXiWze7AlKR79gD8e36qqR8QDUKoO78
         uMig==
X-Forwarded-Encrypted: i=1; AJvYcCWib+7oyoJ7YGxoIRIYAt6JLLMtAcH9aMKT6gVshK56AOgzXQbXJIAEvDgfp3Gp5DHL1JDdDLx0pdrMQTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc1e8/go3Vk1/WYj1iPd2I+ByZP+8jrO2GeV9k+dGTQyPHKvFN
	78A9SuCKDJDCSHHfVHQJQp2XTOun3hNMvublv//wxSHfcNkNhgn9PbeQV9PFK6xEieg=
X-Gm-Gg: ASbGncu0oEH1z29KRjtoFjclur9VDAo2k0Rj5+0qEF+w5dvR0ezqjkGn2c9AdJBxtOp
	sQe4gJzZ1qJBjZ450s21vHFEC/A6RzLT5yhG8gh4u6Qsmk/gr/eOM5p9XN5ui8HsqF3xka5Q5ZE
	oDvPLI/4HxLNkUbR2KD78/ODCtDF8icfNdz5iGfKcdQ0kIuvoZpQ2W4uJUwUtB0/k9EPO7nZKv3
	oTdRP/ivGwcTn2f8zNHWwPuylqgGESLpK4jOlbGPg4kNh7yFT6VEgikgODsJzBwDig8Msj53HIO
	HOoHYe1zb/NSvBW5aJugtQJZ+firfl41XokpioHZ3L/+MtEMdyA/FeFm1XyqOqa2NOqAVlLpUNO
	3c5LR6Y+m6vKMvdGEwgoOTlER3DYlacN1btGUAvLax4gtLVlLY8oYAg==
X-Google-Smtp-Source: AGHT+IHta3Li5X7p3tARLTwnX8shVwR39qDFoRnhPiY5/C8uOkis2kRSCCn/31skW47G6N/ubp5QbA==
X-Received: by 2002:a5d:588b:0:b0:3ee:1368:a8e9 with SMTP id ffacd0b85a97d-4266e7befe4mr16005800f8f.17.1760435194566;
        Tue, 14 Oct 2025 02:46:34 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e8b31sm22866442f8f.54.2025.10.14.02.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:46:30 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 14 Oct 2025 12:46:04 +0300
Subject: [PATCH RESEND v3 2/3] phy: qcom: edp: Make the number of clocks
 flexible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-phy-qcom-edp-add-missing-refclk-v3-2-078be041d06f@linaro.org>
References: <20251014-phy-qcom-edp-add-missing-refclk-v3-0-078be041d06f@linaro.org>
In-Reply-To: <20251014-phy-qcom-edp-add-missing-refclk-v3-0-078be041d06f@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2533; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Zz2R5WmG71VGhvfhWPgwTOijPEaexpycDrO5L76SRq4=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBo7hvmyWGvBIBA0KnfwUuTkQ5O0N0SRXHZ6M32u
 nJXVV82Xw6JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaO4b5gAKCRAbX0TJAJUV
 VkUYD/9DaysPmn6S1AiyoZDFnE8K6Uq7dCgppMiJv/5PDo08uGa+LB9OXUIhAa5VwHmc+pkqnkE
 Fcs1rasiDm6daGLMXF3XC+wPXg+fo1JG4IctnzOytQADR6S4SwMvAlghYl4AZus2Xc/NVQis1FM
 Q1LpvniFsJgNxi+x4V1t8eBdIkMOy/AMDpjx5YQYGDIaZ2rgBY9pLop3DxTHtGrx9Mgzi5vYxq9
 RpHH5ng32pUTq0HEYjgutCJoodn1guq6DbcKbs6H6aHyHQutpKdcE7JwzF3k0uArkjptOnJoWy7
 RwF0zXo+2UafhKxZhyEZxfYg35HyngzCmsWpxRP/fE2lmThXkDXL+8v0c3JmAsaG2PXNyn6JfNI
 OhaX4MJ/jzdqM1u4KgkWm8/v/f6x/q+ztig+BSoYQGCu8ByCWXAm9sO4wq7GS0YIVgqXdck7B5d
 41ziXNZoJb9zvesAj8MapR6Vszx9hn5Cyo62oM6+H3nH24KwCtmZY9h3WwZ/fPTGNV2VskzoeNp
 jvy8NLxN6ylWBbnU46PFIa0iB11iEPhGSfsQwWclkBk8Avm6X1NZdIUjK7IY28y0KVH3Y4lOdBu
 ioGUW6qPbhDa/D3bfxiz54FAGMLXRSUz0BDRVhUHQL4iI3g6CrHIWa0GZbh+NmLm5OhIJ8DEZbn
 4mf3n6OXXA5iSCQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

On X Elite, the DP PHY needs another clock called ref, while all other
platforms do not.

The current X Elite devices supported upstream work fine without this
clock, because the boot firmware leaves this clock enabled. But we should
not rely on that. Also, even though this change breaks the ABI, it is
needed in order to make the driver disables this clock along with the
other ones, for a proper bring-down of the entire PHY.

So in order to handle these clocks on different platforms, make the driver
get all the clocks regardless of how many there are provided.

Cc: stable@vger.kernel.org # v6.10
Fixes: db83c107dc29 ("phy: qcom: edp: Add v6 specific ops and X1E80100 platform support")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index f1b51018683d51df064f60440864c6031638670c..ca9bb9d70e29e1a132bd499fb9f74b5837acf45b 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -103,7 +103,9 @@ struct qcom_edp {
 
 	struct phy_configure_opts_dp dp_opts;
 
-	struct clk_bulk_data clks[2];
+	struct clk_bulk_data *clks;
+	int num_clks;
+
 	struct regulator_bulk_data supplies[2];
 
 	bool is_edp;
@@ -218,7 +220,7 @@ static int qcom_edp_phy_init(struct phy *phy)
 	if (ret)
 		return ret;
 
-	ret = clk_bulk_prepare_enable(ARRAY_SIZE(edp->clks), edp->clks);
+	ret = clk_bulk_prepare_enable(edp->num_clks, edp->clks);
 	if (ret)
 		goto out_disable_supplies;
 
@@ -885,7 +887,7 @@ static int qcom_edp_phy_exit(struct phy *phy)
 {
 	struct qcom_edp *edp = phy_get_drvdata(phy);
 
-	clk_bulk_disable_unprepare(ARRAY_SIZE(edp->clks), edp->clks);
+	clk_bulk_disable_unprepare(edp->num_clks, edp->clks);
 	regulator_bulk_disable(ARRAY_SIZE(edp->supplies), edp->supplies);
 
 	return 0;
@@ -1092,11 +1094,9 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(edp->pll))
 		return PTR_ERR(edp->pll);
 
-	edp->clks[0].id = "aux";
-	edp->clks[1].id = "cfg_ahb";
-	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(edp->clks), edp->clks);
-	if (ret)
-		return ret;
+	edp->num_clks = devm_clk_bulk_get_all(dev, &edp->clks);
+	if (edp->num_clks < 0)
+		return dev_err_probe(dev, edp->num_clks, "failed to parse clocks\n");
 
 	edp->supplies[0].supply = "vdda-phy";
 	edp->supplies[1].supply = "vdda-pll";

-- 
2.48.1


