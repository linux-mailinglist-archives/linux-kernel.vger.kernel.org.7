Return-Path: <linux-kernel+bounces-655235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96029ABD2B4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 11:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390784A6A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 09:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123E325E46A;
	Tue, 20 May 2025 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xZQ+Xdtt"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB882609F7
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747732069; cv=none; b=Le+FBKRmBZzFfRRUKSSRLCNoOp1qKeI0cJ96H+Q3OcBxHoXcrtL9De+I6DLO79ZkS/HwdZn+Opodo2ryjLcopaiBeADtjMBzDRPwWtX1e+BhH8FasNJDhEwNx/b1G/t5ZRbk4egIIGdb9QWak5coFrSkzxGbBhb4GNzZ9m5oQ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747732069; c=relaxed/simple;
	bh=N9ujteMhCBKejVu/8USvsZhZkHo/Zouv/RmtPEYjTDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S7eEvVSG8sHnXtaEovY5eLZj58XgHrqTkWaDd+nykGNwVPif7nB0qdGEqaUwVI9GLCnVbBAaD6aASctLwLOpAD4rd2Wbhsgqkgyhf86LIWn8hGiZPlUH1Nsin7HLBy9pGMFLyWBmdtc4WPnSSK3tagmeF5FQJu51w3nxB+J5fgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xZQ+Xdtt; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5fb55d8671dso1080009a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 02:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747732066; x=1748336866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TWIMZcWXWHJPpBFkj5suhON9ygcNcJxNJCQlC1Ja84g=;
        b=xZQ+XdttxSjfiyJwR5szmCMjDPGrybM93RESEYn9B454EyiPNb1+2zvhhlLqEC7Oog
         g9jxYYoQJNahhDL+zPIz/9ZuWTOncZbFTao/XsvsHl17eON+ajIR3g4DDQsm6/5uTstj
         wST+9gJhLqgkX47mq8Fy37vfb2EGQtVEqWINDIsCyku/z5VOiYsMGBqokVGg1gSw52BY
         NxTl0+9FcP3cAwmfY01QR0xNAbnMPkHKd3WeNSnCGcSxzQGZ0834SWe9bEb8o4OOZTmV
         YT20Ctbamns3etZFgpCG83UOVQX1kHeUtIed8810khPAJRNrviLE49fWts4ntSGoV0Sc
         n5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747732066; x=1748336866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWIMZcWXWHJPpBFkj5suhON9ygcNcJxNJCQlC1Ja84g=;
        b=EOLqmjGQO2O7QTHgmn0G+uy9CcCX7MhTck2dZkLzWLehhiKiPkqNx6YzIu9Gb1/xWc
         LqeSt/O7FqO8gz9oIzr1TORgeRXkQu2K+bGk9UujdArzIrdFzllm2iPQkI9ex5GU5upB
         bkS7kO3C5hZUEJMDDeMpuCaYUv6yX3XxPnsEFOlt+XxXAVtm32TO0c+SzdqxI3dFOAOf
         ZUdVIEH44BIMfJEGgBq/utWASzY78FAgPjAnTSBi6N7Fi2k4xVI4wU1BqnAPEFUFUPjc
         dYywUQpbSGTswo8tgF8rGQpB8lZLR5VJj2p9eMYtD2/5TUVoJYINMsxbeGri7aVmvWYq
         +eWg==
X-Forwarded-Encrypted: i=1; AJvYcCXr/wzXsYSU8O0aZIY8sdS+8YrLhYqhMeC/9dLCIfI3HnVPUUkzWMIAjdkoDoUeOw5xmGLvaZPxWrNl/Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx47hXOfXdgAALIUzDwand+kv0dht/nq4AcdvZTCJZ29OHjuOEj
	F3Q0kYLmqbKXnv8okRvtG1pX9iNReyAYbopUjXjxCoPyZTSgypQQo+kI0s5heOMW/5o=
X-Gm-Gg: ASbGncuhXRz4XdHxuhHIgXK7cco8jrawUv1Ag7TuRW6nnNkLJDWStutKsRbbuoxaWlr
	eCWU2zEv+RsqAy+CGkB7s8zFPPnuow60wHtmMPD1Rclan0iYf5c6CMiFRlC0bOlV/6CQA7WA+Re
	BUWnHFaW0F2lwKXPvMfexuir5LHgCXZtDDtlXzd6Wmes/Z7hgEBJ+TGaD2V11izFagAxLACAxAt
	9oO/JEGNuq8kIdqsla8cHXXiRFM8kcKu1v8JXH9w5nlncv60TM2T+YINqDDUFngdwVfCf+DFjk7
	tv70dQoJ5TduOh1a/TsJOltm8OMy2ddT+nffAB3PYX0zbyqLRYaTlQdjhrdrXw==
X-Google-Smtp-Source: AGHT+IFDWKtjf+GIZ+hmqdWusENVFWvkwZw0IaHDDGHBg4cVXUO+3LikDLu2ftoBC/yId8PIRHI1tQ==
X-Received: by 2002:a05:6402:50cf:b0:5f4:d131:dbef with SMTP id 4fb4d7f45d1cf-6009013eb1fmr5183896a12.8.1747732065651;
        Tue, 20 May 2025 02:07:45 -0700 (PDT)
Received: from kuoka.. ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6004d501f0dsm6944875a12.21.2025.05.20.02.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 02:07:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Subject: [PATCH v6] clk: qcom: dispcc-sm8750: Fix setting rate byte and pixel clocks
Date: Tue, 20 May 2025 11:07:42 +0200
Message-ID: <20250520090741.45820-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2997; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=N9ujteMhCBKejVu/8USvsZhZkHo/Zouv/RmtPEYjTDA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoLEZdW9vZjhTlxiVJQUjnkfg0QHRUFDmTGntZM
 74WyCS4AZyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaCxGXQAKCRDBN2bmhouD
 1/IZEACINMCMKaTwiOSimXOh8GaE6v0tAFFTzOHWlL0jwRm7bUvELVemxFp8ZvEje41v+YJsZY1
 aNWedMVSL1zAa4P9K0/ItTVtH3n5JMMIEcqRBd4fVQfVOcL0UD/jGvva0PPftkzF7lfUqHMUZOv
 B6BQp2X2VArvpweJ5tvL7HC78L03rsNjlGUJKKx2dDjSvwMIZVrNcmkFgtYZkeiF8MRaLgPC+hf
 EulVGG4/MoECuVWPbXIR+qKBexXGaDPFbf+hfKodLGGjH717WNZ0sfAr0fAPHWeKizKlGzdcYLa
 0VLCKjJXz9+QMgBvEcAD0l5kwD4nbAGYZjW1e2jaDOZedKQqtCq9CDBHhnrkE+pujWE5j9SiElj
 zXuUj/FLuHyRjQrsGufCg/uBRgAR6ANjbkj9HJHwxC10mqKenJ7Sh+F6wLwVkoORdSnTDQ3lWMJ
 kXcNgE0zJM14Ku7FI5bFeJS7e4z3fRXT3nfKnSU4N1KCgCYLEk/fumUIpNc9Z0BayHiIqlQ+5UK
 +gv6eUlc40zi5c2kiJpqKYYM+KlOmuSj8wWCJYWhb8Bke8u0VjbmRbj5+07ISgM3q7PMTtjgA9R
 OblsU6pU44zHv0j6T/5BZDRO5hyS16SUbUoN7PXnQcKUvyarM3h1PEyPAlqc2cxHLsx/b9bTUPI tnOOZhUNsie9Vzw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

On SM8750 the setting rate of pixel and byte clocks, while the parent
DSI PHY PLL, fails with:

  disp_cc_mdss_byte0_clk_src: rcg didn't update its configuration.

DSI PHY PLL has to be unprepared and its "PLL Power Down" bits in
CMN_CTRL_0 asserted.

Mark these clocks with CLK_OPS_PARENT_ENABLE to ensure the parent is
enabled during rate changes.

Cc: <stable@vger.kernel.org>
Fixes: f1080d8dab0f ("clk: qcom: dispcc-sm8750: Add SM8750 Display clock controller")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v6:
1. Add CLK_OPS_PARENT_ENABLE also to pclk1, pclk2 and byte1.
2. Add Fixes tag and cc-stable

Previously part of v5 (thus b4 diff might not work nice here):
https://lore.kernel.org/r/20250430-b4-sm8750-display-v5-6-8cab30c3e4df@linaro.org/

Changes in v5:
1. New patch in above patchset.

Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>
---
 drivers/clk/qcom/dispcc-sm8750.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-sm8750.c b/drivers/clk/qcom/dispcc-sm8750.c
index 877b40d50e6f..ca09da111a50 100644
--- a/drivers/clk/qcom/dispcc-sm8750.c
+++ b/drivers/clk/qcom/dispcc-sm8750.c
@@ -393,7 +393,7 @@ static struct clk_rcg2 disp_cc_mdss_byte0_clk_src = {
 		.name = "disp_cc_mdss_byte0_clk_src",
 		.parent_data = disp_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_byte2_ops,
 	},
 };
@@ -408,7 +408,7 @@ static struct clk_rcg2 disp_cc_mdss_byte1_clk_src = {
 		.name = "disp_cc_mdss_byte1_clk_src",
 		.parent_data = disp_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_byte2_ops,
 	},
 };
@@ -712,7 +712,7 @@ static struct clk_rcg2 disp_cc_mdss_pclk0_clk_src = {
 		.name = "disp_cc_mdss_pclk0_clk_src",
 		.parent_data = disp_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_pixel_ops,
 	},
 };
@@ -727,7 +727,7 @@ static struct clk_rcg2 disp_cc_mdss_pclk1_clk_src = {
 		.name = "disp_cc_mdss_pclk1_clk_src",
 		.parent_data = disp_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_pixel_ops,
 	},
 };
@@ -742,7 +742,7 @@ static struct clk_rcg2 disp_cc_mdss_pclk2_clk_src = {
 		.name = "disp_cc_mdss_pclk2_clk_src",
 		.parent_data = disp_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_pixel_ops,
 	},
 };
-- 
2.45.2


