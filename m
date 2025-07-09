Return-Path: <linux-kernel+bounces-723286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6585AAFE573
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E03C3A63D1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F34228C2D0;
	Wed,  9 Jul 2025 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TWg55c0C"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9D028BAA4
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055796; cv=none; b=JqlBi7MxNovYCMxlkK+Nih/SqMErAEHqdnPDiCABm16xVoHRxj0RKmU+xdMk5oOv1g5pFIY1sEsShkbpcl7mz3pIC9ioN87tbAdrcnfWaIV8+faIvWt/t5pdIvfHezHHExROqTFlvsuVui238CkudhmjuNK8/HcoZPNcna4vSzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055796; c=relaxed/simple;
	bh=oHtxKLb95kWtO1ABeXnwkyA2GtGWv8G/qQ04XDDzKoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C2IfFHYLMu1KX4UrLXSPQtoKHZGbjBEdA/4neSWrlnBKPa/Nlqmqd4Zw4TxgttVPIsY9hfGMYGitGbSTPFaO4zDciIY5zfFuNg7NzYrpFsR+PTfl+yvrhhDal7yhLenaVkSSdEYTtT+K8y3s4AotfuTT5xr9ZMhviF93uMToeCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TWg55c0C; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so487927f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 03:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752055793; x=1752660593; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6HxvD09F6nT+66ixpsjcoirCJ37IebWgFlBepGL5ug8=;
        b=TWg55c0Ce6UX+XBe4R+NVyUUzcZglTFolRq9nhSSuxSyHHGlbsI5LMdEmF5+r2G2Ee
         mW0UwkzcsA0if2hMAXRfRe48+jUd2i+b9AGh7YZtusQ0px5bwhWPNjVeUuyA/uTGRGjc
         cJE4EZ72MTm7QiSwP3jzAcvRBTLy/6MOS/vsR3MGhK3U8nJXQVpvezdheRG7qhF8ulL8
         ZTFhipAIPZ+sNWCRpRVz/S4UVZSyOU+elNzq1KwEQ/DU7qSfvMW/bQKELsWryEB+WPgi
         Y9T2emXolOMAw1w/zetrR+XcocR1OfPv16K7ZL9L7ger7P0L/3SkndHiX2RLx8vqf9Zl
         644w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752055793; x=1752660593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HxvD09F6nT+66ixpsjcoirCJ37IebWgFlBepGL5ug8=;
        b=Evg4aoLyECgYM1P/K7Oe1/Lp8d8fpSA+pxu4YG+BaQF7rbcZilqxRD5bJq4fiAB4yk
         ebzMv3t6M7krf+11A4/gFcSRoo4Vd/R+1B2JFHXrkMaA0rwzDBjDy57rEBBocicax/yl
         hNPDqN+88XbDM8DVf936/8BOROe02r6N3YETGt5DXaVZvmaVTJd8S8VUq7e64MdrgQa7
         LAaY/NtbhRA4d721YmbAa8y9S3xdnav4++dQKIZDLdYT8CiznVEmy8C182dw/TLqduKx
         GAB0Bv0rsWycMBLDA1/yW4Cu8weaPMTWind2G14PGLQS8Z2p3YbkUX8f4toR/aY+p9fA
         cKNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUixT+R0MmBjD6FVM4Up8dx/24pwg6UyupYQJLZhnX98vTzIBky+AVhlfyRkOePkuhsVYuH7Z4omYI343w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbBz1sZMJS5eHnBBG6cmKaBdAj5E3qCexU5SOMow22ORr1VM4p
	aP2/NLHJ4hdq16c7eWdeh7lnWEIV5hyFss8zuPRxB72uofuShq1FOHs0hJI8EkZooG8=
X-Gm-Gg: ASbGnctCLv5hCeux1ERng4IPmfhv7TC6w7O1uTF3nn3Dkj2cFxKwp6FynSBGoiud7Ko
	uffJhhUjq0luI7YknDP/95RbAPpHvjBKQOy7NitVTbzT0iDYeFDlZMgHBGOmJxz2uakRQm9Cs6V
	KdMdsu52p5nd2qhnpTP3Edh4dIRr1gsok/ZiblbouaJ12Cy255P+WuxQI7pZqeNYdeIGIQvBJ2K
	qfrYFTQ3at/8+APzE1azz6RqbF6TmWSDoYejBXQwfAnWeajE6fUDqmAfANeIQc99QJqDjLlOAqx
	uXUH1GYJOrm7zQRjWqpR1QRMwhEGktiQ9oOLE/QhV8d2hVCH1iVkQtnA+MKC3EMcy+9ifD+Bncl
	G+Q==
X-Google-Smtp-Source: AGHT+IGePVRa5c41YQYZ/2B1kylc5GX/RflEeqWBX0hcc0fLez3e7u4p1eY6s1aZVrZhJaHTwFshVQ==
X-Received: by 2002:a5d:5f8d:0:b0:3a4:d9d3:b7cc with SMTP id ffacd0b85a97d-3b5de03575cmr4975600f8f.28.1752055792512;
        Wed, 09 Jul 2025 03:09:52 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:d3be:a88a:dbb9:f905])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5032997sm18342105e9.7.2025.07.09.03.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 03:09:52 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 09 Jul 2025 12:08:55 +0200
Subject: [PATCH v2 3/6] clk: qcom: videocc-sm8550: Add separate frequency
 tables for X1E80100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-x1e-videocc-v2-3-ad1acf5674b4@linaro.org>
References: <20250709-x1e-videocc-v2-0-ad1acf5674b4@linaro.org>
In-Reply-To: <20250709-x1e-videocc-v2-0-ad1acf5674b4@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Johan Hovold <johan@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Stefan Schmidt <stefan.schmidt@linaro.org>, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

X1E80100 videocc is identical to the one in SM8550, aside from slightly
different recommended PLL frequencies. Add the separate frequency tables
for that and apply them if the qcom,x1e80100-videocc compatible is used.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/clk/qcom/Kconfig          |  2 +-
 drivers/clk/qcom/videocc-sm8550.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 26752bd79f508612347ce79fd3693359d4dd656d..53bbdbe0725bd1b37ecd4c6b15b0d31676d9f548 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -1394,7 +1394,7 @@ config SM_VIDEOCC_8550
 	select QCOM_GDSC
 	help
 	  Support for the video clock controller on Qualcomm Technologies, Inc.
-	  SM8550 or SM8650 devices.
+	  SM8550 or SM8650 or X1E80100 devices.
 	  Say Y if you want to support video devices and functionality such as
 	  video encode/decode.
 
diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
index 3e5891b43ee404edc6c99bbf8f2583cb44df9e37..32a6505abe265472de4059c4a048f731fdbf1dfe 100644
--- a/drivers/clk/qcom/videocc-sm8550.c
+++ b/drivers/clk/qcom/videocc-sm8550.c
@@ -145,6 +145,16 @@ static const struct freq_tbl ftbl_video_cc_mvs0_clk_src_sm8650[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_video_cc_mvs0_clk_src_x1e80100[] = {
+	F(576000000, P_VIDEO_CC_PLL0_OUT_MAIN, 1, 0, 0),
+	F(720000000, P_VIDEO_CC_PLL0_OUT_MAIN, 1, 0, 0),
+	F(1014000000, P_VIDEO_CC_PLL0_OUT_MAIN, 1, 0, 0),
+	F(1098000000, P_VIDEO_CC_PLL0_OUT_MAIN, 1, 0, 0),
+	F(1332000000, P_VIDEO_CC_PLL0_OUT_MAIN, 1, 0, 0),
+	F(1443000000, P_VIDEO_CC_PLL0_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
 static struct clk_rcg2 video_cc_mvs0_clk_src = {
 	.cmd_rcgr = 0x8000,
 	.mnd_width = 0,
@@ -177,6 +187,15 @@ static const struct freq_tbl ftbl_video_cc_mvs1_clk_src_sm8650[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_video_cc_mvs1_clk_src_x1e80100[] = {
+	F(840000000, P_VIDEO_CC_PLL1_OUT_MAIN, 1, 0, 0),
+	F(1050000000, P_VIDEO_CC_PLL1_OUT_MAIN, 1, 0, 0),
+	F(1350000000, P_VIDEO_CC_PLL1_OUT_MAIN, 1, 0, 0),
+	F(1500000000, P_VIDEO_CC_PLL1_OUT_MAIN, 1, 0, 0),
+	F(1650000000, P_VIDEO_CC_PLL1_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
 static struct clk_rcg2 video_cc_mvs1_clk_src = {
 	.cmd_rcgr = 0x8018,
 	.mnd_width = 0,
@@ -559,12 +578,22 @@ static const struct qcom_cc_desc video_cc_sm8550_desc = {
 static const struct of_device_id video_cc_sm8550_match_table[] = {
 	{ .compatible = "qcom,sm8550-videocc" },
 	{ .compatible = "qcom,sm8650-videocc" },
+	{ .compatible = "qcom,x1e80100-videocc" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, video_cc_sm8550_match_table);
 
 static int video_cc_sm8550_probe(struct platform_device *pdev)
 {
+	if (of_device_is_compatible(pdev->dev.of_node, "qcom,x1e80100-videocc")) {
+		video_cc_pll0_config.l = 0x1e;
+		video_cc_pll0_config.alpha = 0x0000;
+		video_cc_pll1_config.l = 0x2b;
+		video_cc_pll1_config.alpha = 0xc000;
+		video_cc_mvs0_clk_src.freq_tbl = ftbl_video_cc_mvs0_clk_src_x1e80100;
+		video_cc_mvs1_clk_src.freq_tbl = ftbl_video_cc_mvs1_clk_src_x1e80100;
+	}
+
 	if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8650-videocc")) {
 		video_cc_pll0_config.l = 0x1e;
 		video_cc_pll0_config.alpha = 0xa000;

-- 
2.49.0


