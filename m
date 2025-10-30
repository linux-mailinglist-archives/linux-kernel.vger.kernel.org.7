Return-Path: <linux-kernel+bounces-878436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3460FC2096E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583123A7179
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA15274FDB;
	Thu, 30 Oct 2025 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MXENT0Il"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC24270EA5
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834532; cv=none; b=mXmZDRXOMtoW7zCK7fOPj8VAvlzuKVpQDsOuk3OuvvDO8gbHmacqGPFtEkIfJ2L0fnOb3PtpDaPZDy+7fxyXgRlemfWnx9HjBYITapNsj6tV4Udfgqd48IT4efxYZcghrnaof4DbdwdRKQjso5Wn9+AkJZEW+wzVMZ+Qn1Nku0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834532; c=relaxed/simple;
	bh=xPbBKFvyY3b0q44Ov1uGneaLSn235ugr8EcPIsxzZCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nlgNehH82mqKYkPhPrGCW8QKlsum6tIDbsvg5r0HkF7D/oFpCqlydGFDzhpWTheJYNemZvufIjjX17tnbICfzZZOLASgB0baezPFj+cHr5EbZjU33b9KIr0YMcHcJho0ch20NOqjfqdJsmwFQoa65R+MSBenBuUyLmjrxY2UyFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MXENT0Il; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47719ad0c7dso10608345e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761834529; x=1762439329; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMpLeMNH7sSwMA33xyRkgoL+sxT741zRGSIt87PkKn4=;
        b=MXENT0Il/tEXUBz/wM0v81XOnTThwKpFIj7WOYwqKe4h7usbDJ7RKx98krsKPkYtnJ
         XhQppG3L0UaJW++3f9cO11X0+a0oGRXi4kUXTBLds03YS9StVG3tBmhZXnt/ztGJIsgh
         nnIa4qcXC2RtehhwqcU1yPzs6X0Z8tX3ZTxcKu6dDP8mRiQJpoM50s208Y8bN6FHIKBK
         yECDZscrNmmR+Imp+IPuvYdMRlDT3NZRtLeP4Quiw1Dawg/FGun0G+BEFAXbtzhXMc/G
         hzmh5vPOLSc4OLpR6l7+ApN98PQ+YWYTwbf8hJWeAtBTxaYvnL3OG58lFVXE1cccCMxN
         pWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761834529; x=1762439329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMpLeMNH7sSwMA33xyRkgoL+sxT741zRGSIt87PkKn4=;
        b=ApFupQTp1YlyO83WS4ze44Eoyr5v1SesI/nigGK5Bbs0krqYPgfptM17tE28NEVhdB
         Jb/0/WWypfWZGVbBL3YELxkWXVbUm66K9kjoB1mO28A4szZLPgljFw6qvsxPcERG0HSY
         O9cYPYH2m3CxXFX0G4ISRFg35qwHrdF0dkr8CKmYm3NwnrJokwQI+ZHyWHluqZujNPJr
         Otxt7RTDtxoKMlOm/D0ShU/F0hpbS9iB/qgt774l1SkGiS9fpQ4qs0xcy7AUMUe9/vSP
         /eJEnPDJA2F3Fzy2E3Kwb8/yI+12SnSSGTunC/KIKUFoatRJcperz1cZxQ7l00sukqsi
         1bKw==
X-Forwarded-Encrypted: i=1; AJvYcCXLiisE1o5dFtO7v/cnHLGxBIrjvjm+rLBBPdaa8y1uLg2dobfCWMyv+/Z8PMSeKO0dmSyVxzpcOG4ZgvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqidZhezhIJFAFMjDnJXVcGKfFTL8DIAJpzg2w3gw+kzJAo1/B
	SzEalqqaADfBqNsw11BMI0HWvOnAoh3DjUSoaY/7vzzhTE5CZZ5PmP3y8/AyoQsFB0U=
X-Gm-Gg: ASbGncuzEZtLKyeJQQ6ctSsQvLZq7j1QIicEoVaODb1GCG/SJXJucG9ExY7qel7E3QD
	2B6MAWyFxQEdclnM3jA7W73tAvFHZrvRXZkdVnqinK4uZwZU44513EHpoAqCn8SyrrG1LNzvPC0
	Bh3a5STVKFOUMAuTQZn4PnkafBpB5KxclUEjKFP6HoZXjyY5tcI1isqn2DETJW5WTiAgRd8fswe
	ojKJZvT2KO6rKBeVbnQwXq44xOScuPC6V+qv+MGKZXV1943lh+pUDXvcGyTpynbuoO6B/WOG+HY
	GJDVeoQtd9BXeMp9LHTGVLKOGwlpUEQSvZztqKw2+dHFVd/e8DHP00XZvFOmVJUPPACmgCBfyrb
	rF6MjlDhDkZaUM5whbg0TrOlG7nOV7WEHXxai0HBpNoRj8rNGIMSEUP8W4q1SpC0HpFWUc9acTw
	==
X-Google-Smtp-Source: AGHT+IFvUUgJt/pBfFCRkI2lUvJeGd8kmVonHz+bVaufzA3NwxMJQo/JOQuLIQsN42Yu8n2Wf5HTQA==
X-Received: by 2002:a05:600c:1c16:b0:46d:cfc9:1d0f with SMTP id 5b1f17b1804b1-477267cd090mr38409765e9.19.1761834528540;
        Thu, 30 Oct 2025 07:28:48 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772899fdfbsm42230475e9.4.2025.10.30.07.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 07:28:47 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 30 Oct 2025 16:28:30 +0200
Subject: [PATCH v5 2/3] phy: qcom: edp: Make the number of clocks flexible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-phy-qcom-edp-add-missing-refclk-v5-2-fce8c76f855a@linaro.org>
References: <20251030-phy-qcom-edp-add-missing-refclk-v5-0-fce8c76f855a@linaro.org>
In-Reply-To: <20251030-phy-qcom-edp-add-missing-refclk-v5-0-fce8c76f855a@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2651; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=xPbBKFvyY3b0q44Ov1uGneaLSn235ugr8EcPIsxzZCg=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpA3YXRyxMK4aGRKojtn6QDRiXbclf012HYvT25
 WCOAI+j3N+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaQN2FwAKCRAbX0TJAJUV
 VndFD/9OiCZq77cCkVqe2W7G0bhgx/Uo0ZtvIaadCqV1cMiOII57s9coJL9BN7vciu8wT8fYxol
 FDH11MlZSzdlGwritI3qsHNIYNa4osm37yz2zZKyo+Z6fh4JyRUePDyA2BJh7aoadejJ2FEKi43
 zAhK8h17ZT5jI5aT4NiMNifKQxNfM6AruXrl5XFAvj54dWwkaz78OdMySQG7vCbiV/qwkzW/Lhy
 EO/s0ZgrB568VC3W7dGbuU/ukD+JQctfBZ9Dbidtx9gLQP1kEuuOllR/CIYG52i08MmF/VqXDGz
 /SlEDzNzb3YSRmShPNfKyuvelvfE5rukVuF1KGqc1uiDrkTJLqaObruS/6CzVVwZ2AVbTQ722bz
 pIW9fRmxSGH6uzTvu8NmlGjx4E+kf66PElme/UCN20YtZ0/vbh5h5hJeQHUmNr1UWGxY1QqY4/X
 wNDLYM7ULoRJCb6klpgRXqwz8JKQqxH1By+EdC8WuB1YQf8ncL1puOzvLQ9EGCyv6OOJsGQeKFv
 Rt07HO9IyFrxTQ7YLiju3sLta8XoEbNJr3tD8ncfVCsaYOs3JyqcfP+mhe+LZ4hBRgmXOEna3CN
 UQQJd9hjzTM1N8siWbx6okvkneoaLQIKVoAFLgjb6ceZ92QU8PGVug2/Z322G4lC2RVJXKmKgsp
 2rby0e1q4ve453Q==
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index f1b51018683d51df064f60440864c6031638670c..06a08c9ea0f709106ceafa7b5f8c8c6856786a48 100644
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
+		return dev_err_probe(dev, edp->num_clks, "failed to get clocks\n");
 
 	edp->supplies[0].supply = "vdda-phy";
 	edp->supplies[1].supply = "vdda-pll";

-- 
2.48.1


