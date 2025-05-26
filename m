Return-Path: <linux-kernel+bounces-662614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A05E2AC3D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 11:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63F267A8C5A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 09:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C441F428C;
	Mon, 26 May 2025 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kluBaCCM"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ACD1DF73A
	for <linux-kernel@vger.kernel.org>; Mon, 26 May 2025 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748252834; cv=none; b=BlnQkklEZW76UHtmYVHtcKo9om/APgNSL+IsEoIdPuZf4xfQZIYmUAVTR4DGq7y/uGcF9MHhvNXmEx1oRW/FhAVisx9qbou5nUKdpp9ovqTGtr61tG3JYWxzQe6qWi1Oq3KglN5nAI3XeD/3jMxlhoaE8YB7mWoJCJIO8jDKhRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748252834; c=relaxed/simple;
	bh=yW+lzGrBHFbCZuynhHylQaKFrss+eF7xeqrzeY4Gh7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aIKv/RA7OJna8mkFeOUuHwYMlpyOtr8lOMXbMZmmR49Pu/BZtBThulr6piT1eHV/iS71dmVTE7KEqwl36ffY1FBjveF4YB0PyWncMA/m+XljaSCxnpwW69u+V7xSdF3cer/Yp15r7MpFkbBEm7cvmw4TUB+2pY2/Tnzsuo34mY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kluBaCCM; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5fa828b4836so314592a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 May 2025 02:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748252831; x=1748857631; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fAZVyD8nLejv+dB2iGsn12fr15PTc/vSHjJT53bWPAM=;
        b=kluBaCCMak3UcFbm9dxrzkyZmOGiFuIQiN4A3nRYE5Wo4DUcaAgI7hzSQ3TBHfMwCA
         sEpzfJyamUfoewwtnVtVYMn2mdq+b2OBmDrb4H7q4DLJVsBJFkIokgm71I7vSrdtUCei
         Yf7epeu3Z7ckEVA9G/oTsbn6khCjcmpz9OTqXdhHq54dk/ATPF6/yzq/IPNrDrB7UBuf
         NsQtMS4O9B4ughUc2kqhheUi+9dIPSQ8gD/FBBcy9mEnhKhVyxKsOHRm7anEtp/1BcpZ
         0CqVbRrEjHd4iYojCJbBzTNWquuBlrry9ueGWr/+3UX4nI9TlUxcFdoFVFWd9XKfNJTo
         xMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748252831; x=1748857631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAZVyD8nLejv+dB2iGsn12fr15PTc/vSHjJT53bWPAM=;
        b=pCHPfAshkRGtnxC20Pmfclb7QEg08rrvdaFOWkkPs4EX5KNBTf6TDSJSN3rUSzD/CW
         R7QFm+I4dcd9fXiZqp1c+Mm+Bzde7h8INwcIwz6hr9INxrBRz5ZqF+fwpnJwaXkWq3qV
         odrUfFN2mpToLgQMDbPlc0m/vEpyyS9neWbGJ9R1yWk1z9+poUYMkDWdAcEo5rWWr6+s
         NJtO2H4P5R/9AeHn6b/m2KfkJ7VEY0PESmmxyZaOSRJTf9IyfaalbkMqh4cxovpUlpjv
         7s2wWhnT2+dBakwWLt8bp5sxjCI9cA7eyx0Bu9XkOAB0f2hnW1fDFmF6hNIfWy4sdvh0
         vlsw==
X-Forwarded-Encrypted: i=1; AJvYcCV6I4/djqZFSpPjo4JMtKvG08/osUZ9JrMzCLUWBYW29P9Ap9inv99b3jIEsSagQ6wprJRQPr95HavR1TA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyQPylnjBoF+GESpxZEdAo6xF/GwjIBl1iwfr25uysP54D29sP
	QXBeGGsSJc820mTbP3p1NG8+F7zEhOnGYSFHI+q4cQB1N/Oy+a8n3BnakBrmPHpJlEo=
X-Gm-Gg: ASbGncvb7/L4vDrHXZvsCq9CDxvb/PEDjYCScwHGYQZGAio8Aal5h5bnI7tGbOVVLbp
	6IHcuzJ8GMTcHA0avdDCKyeJXL9AKf/p3IMCWSJtM1YtCt5dki1JEt09KkLRUVK1Su3GRtqApiF
	vIlL/gKLKMRo43pbJuQAR6QsLcCk18LAZ9U0lNp6+ycOXqhdErwcsBNI+u6VolVEGB8buV1Nh22
	xFtAcCQDhwuyxPJZ2sR7MrHLtKdsAVDZmgfFweNcWmmFpSAb2+I8LIYcZGjRwdjkkqguWlAk2Mm
	KykQOQIYwSaDDJA4uCRfbECwqqOvwahTTMSrsYsMmHILOo3m80/QxzF0tdM1UygOMzA6IrU=
X-Google-Smtp-Source: AGHT+IE08nBeINi9bzH0RFLrXFLcP2pZ6ple+DY12qw1tSMqI7k7yqjWGEAFPZqPtJ0gqM/FV3JHwA==
X-Received: by 2002:a05:6402:354f:b0:5f6:c5e3:faa0 with SMTP id 4fb4d7f45d1cf-602db3b4ebdmr2818936a12.10.1748252831299;
        Mon, 26 May 2025 02:47:11 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6049d482cc7sm1486427a12.19.2025.05.26.02.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 02:47:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 26 May 2025 11:47:01 +0200
Subject: [PATCH 1/3] ASoC: codecs: wcd9335: Fix missing free of regulator
 supplies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-b4-b4-asoc-wcd9395-vdd-px-fixes-v1-1-0b8a2993b7d3@linaro.org>
References: <20250526-b4-b4-asoc-wcd9395-vdd-px-fixes-v1-0-0b8a2993b7d3@linaro.org>
In-Reply-To: <20250526-b4-b4-asoc-wcd9395-vdd-px-fixes-v1-0-0b8a2993b7d3@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Vinod Koul <vkoul@kernel.org>, Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2678;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=yW+lzGrBHFbCZuynhHylQaKFrss+eF7xeqrzeY4Gh7w=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoNDiZVUjOu00z65ZdGdWgoOvgj6MWG6QuPFcRI
 uoGQ61XyjeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaDQ4mQAKCRDBN2bmhouD
 11PDD/4hHos24HAAdgoQUdwzReUuAHWBaP6+UBZHkLMxHIf0Iy3EhDSZAuyoz2/YyBwgD+7DZoY
 oI+Bv0N/XfBHGlpaBauERGcubz3iPud4RfdPI+IgUnbE5nVgZFdmbauTOphrVBHGs6IsZfpvxx2
 NnQ8LAOKWj32tFfFgA74egDTzcqW5AuzyyYmRwhV39nEhnh3XT3iOeO4/TNvShGYYAEhcHn0DeA
 A5ebV3FXEKrpahdxw/woyqJPH/j7cOW2GVzI8Z4ERfSUSEhOECEl/H06RNU3upPNAu0WR/EAR17
 6tOV9d5TEAGwkP/YljJfjKTDmD6mZEe0BS0Z1VaWczIuJm9kl2LHKwk2yj912vCzbFcdkhio20c
 y2phNAjT3c4mmnsQqjGaZjljkMjFy6t1amcwkfFGs46CRz4ui6WUtU9J6FlVglGCgx9prHo8C18
 f40tTh6GeHSBfihEL5HyZbN2VVRc748DdKVQcdnRsphK9uF1IidyLseZpDCLwisQbPD7pNCoQy5
 j8c2P5+0XxzvlgALq/XrBD//sFyXtMc99pau9wO1RovJwnuWpxOYJLay3Rk6Pm5FOQ7DEhdXJ/t
 osuxTMVX14+yfGXx1HKplVUI4BjTdOfHgddZlpQFrYbtsfmLSE2CwHAzCJuu0faVr9ZaWMDu/XA
 HNjoOOxq1DcKatQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver gets and enables all regulator supplies in probe path
(wcd9335_parse_dt() and wcd9335_power_on_reset()), but does not cleanup
in final error paths and in unbind (missing remove() callback).  This
leads to leaked memory and unbalanced regulator enable count during
probe errors or unbind.

Fix this by converting entire code into devm_regulator_bulk_get_enable()
which also greatly simplifies the code.

Fixes: 20aedafdf492 ("ASoC: wcd9335: add support to wcd9335 codec")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd9335.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 8ee4360aff9293178e338e3ef300c37f6f2ac809..5e19e813748dfa0d065287494240007d60478dea 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -332,7 +332,6 @@ struct wcd9335_codec {
 
 	int intr1;
 	struct gpio_desc *reset_gpio;
-	struct regulator_bulk_data supplies[WCD9335_MAX_SUPPLY];
 
 	unsigned int rx_port_value[WCD9335_RX_MAX];
 	unsigned int tx_port_value[WCD9335_TX_MAX];
@@ -355,6 +354,10 @@ struct wcd9335_irq {
 	char *name;
 };
 
+static const char * const wcd9335_supplies[] = {
+	"vdd-buck", "vdd-buck-sido", "vdd-tx", "vdd-rx", "vdd-io",
+};
+
 static const struct wcd9335_slim_ch wcd9335_tx_chs[WCD9335_TX_MAX] = {
 	WCD9335_SLIM_TX_CH(0),
 	WCD9335_SLIM_TX_CH(1),
@@ -4989,30 +4992,16 @@ static int wcd9335_parse_dt(struct wcd9335_codec *wcd)
 	if (IS_ERR(wcd->native_clk))
 		return dev_err_probe(dev, PTR_ERR(wcd->native_clk), "slimbus clock not found\n");
 
-	wcd->supplies[0].supply = "vdd-buck";
-	wcd->supplies[1].supply = "vdd-buck-sido";
-	wcd->supplies[2].supply = "vdd-tx";
-	wcd->supplies[3].supply = "vdd-rx";
-	wcd->supplies[4].supply = "vdd-io";
-
-	ret = regulator_bulk_get(dev, WCD9335_MAX_SUPPLY, wcd->supplies);
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(wcd9335_supplies),
+					     wcd9335_supplies);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to get supplies\n");
+		return dev_err_probe(dev, ret, "Failed to get and enable supplies\n");
 
 	return 0;
 }
 
 static int wcd9335_power_on_reset(struct wcd9335_codec *wcd)
 {
-	struct device *dev = wcd->dev;
-	int ret;
-
-	ret = regulator_bulk_enable(WCD9335_MAX_SUPPLY, wcd->supplies);
-	if (ret) {
-		dev_err(dev, "Failed to get supplies: err = %d\n", ret);
-		return ret;
-	}
-
 	/*
 	 * For WCD9335, it takes about 600us for the Vout_A and
 	 * Vout_D to be ready after BUCK_SIDO is powered up.

-- 
2.45.2


