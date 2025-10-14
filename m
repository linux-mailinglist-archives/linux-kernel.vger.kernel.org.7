Return-Path: <linux-kernel+bounces-852591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1EDBD9692
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 608E23A597F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35498314D0D;
	Tue, 14 Oct 2025 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OtiKkKAT"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A9314B71
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445607; cv=none; b=SOzwKO1o3aJuM+NZMtMXpTz53Mc1jLd5qcD98FSdlw7X0TmtSGkIOzhyUlnO+hDu5ym4RXGPMfjmnMv92WLxHfG4ikSZUsgWpb9hEa8VLfk6wSnJx6e7E6R74dsWE6e0FR15aupu0jt1Q8Nbu5KQXOSt0KGbegFIEJeuwh6tWZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445607; c=relaxed/simple;
	bh=mQsq9Lyl9Xj4ieWxCs4ifLYeBM7hE4agqANYBsIaYvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d3CS55zb9P2nwcFEjLGR3cErxhSihqaL7wP5jF69z3OtOESiJW5U96Lq00cg/ELm9qQykd1BDaW82jC/oUYvq24vFsTocqsk4OyDa4g/3CPpq6GkmwokuL+16GPJwR15U8yInR+HusXabSFLDyinPl0D4SIFLumaAHFrjT6j/kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OtiKkKAT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e4f2696bdso53373975e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760445604; x=1761050404; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1RYyzsf7oZTpApmmhnHm39MnizxtLSKAObcAdZ76I/g=;
        b=OtiKkKATctyk+AcZxVZ2GjGR2kA3nRYxwqmAMXyLtoARxWbyko+6Iu/s2dwNHCtDIC
         3lAIe3odM4tHy/AaHCvdI0k8UMftkmQqxTyA4ylMO82SVUSb2hPQk5B8vDANxBUmIxbU
         rnWOKcy16FZPIEmKY+IjxXCF85DgCMr8b7wBsXGAACfyjZjTQOdvTGTzM2pv6qlBZtPc
         nCLYdRD0GKwwWzBJvpTgE/Rr9Cyh15oJzcT+EHjDjE6cz4OVso3+rxblWVQ4Ej6cuY+s
         iSKj7yAHRWK04uqcaX/TVPtdt9MI9taOgX+poKHBot/jRkVb5CaBJga2DtrUh+M9YJbe
         AO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760445604; x=1761050404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RYyzsf7oZTpApmmhnHm39MnizxtLSKAObcAdZ76I/g=;
        b=E0YFKw11gSrZFbtoJrJiywIBZ7WOoBZaok/N+JD73cfGw7yOozeo9jvCsQiHP5jKE6
         fov22kNwdDGNMoJOULGInydhvv+24er8d1M0GbFoWwRWbl00MF43JKVfhI3XvsclgVzc
         c9L9dlgbCg2+l1LxdSJrFBAuFhN6IlirhLTklkfkaOoQiJpBeAcqMJWfMDP2ePK+KmDU
         p0BnhDh/or+VSiZZjEizQcoWiRqmSDEXKxhBoQ5B6+PWa4YjacSc4YFNHevsCVJZ5U32
         EA3Vh3vjbRshQScPaKM8aJ1FmQpB2jPNEk+Z68au3iZOqW/wLLSR8yR74LLUYLooHX2P
         PVoA==
X-Forwarded-Encrypted: i=1; AJvYcCX7mSmz9e25dEXTHyr9R1Cu5Q6o0CHtQm1tfMVY+2ETkr2tWd2s+02h+D/uutpJZN15NI6pDg1jDwGsjYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtgxMqm2i90bWeSLFVVIPJDzTvEujcpP8JLtv6VRRG3DbzhieR
	TlZiFNwRLKoU9/GLI9J6eagdXA45rwzZ597sHwRFzsYGz3ZiYSRHYPn8Fbp/V8l9XQc=
X-Gm-Gg: ASbGncuvuaJUP6WPFVfyc6eTfO2G/7+vzgi6xfedlTADSzHYuXNuNT6obTjd3AGv3N9
	eIP55EvGPY1628wY2yuGjOThuQVbybDo/oyg4pnY3YIYz3pfbQPj0NGbifnL7JNzgqOg2r27kO9
	e6Xii+Z/hC0VRucTCua3VOGcu9/XMb3gNrXpJMM/++sBb7jp0iGJPbQpdQQ9faATyJenv/aaNMb
	Iajs8N+5A0D2Y0U0KjXvZ56WGpwhVLmO8C2LtIMhW9MzIuf7P9kB5G67D04rP4o8p1xoG/016Zs
	PTrO+wn7YjMGk5VLpf5bScAcaRBaO3RnMZNb4On1+2DcgmNxbhhMgjh3qJj5mHlpVIO8rDvx6HB
	ChxExzRUaVMhp7qrtsyEk7qbvuyFSLWpB4flGulveGKnRhnzx3FpVk5N21rh+R3Ew
X-Google-Smtp-Source: AGHT+IEf7Z8/P3u133rQ5LFYuWk/L8zLU2JN4M/uTzSeOh4jfJpa55YeNQBn0KZm+7kKT+tReAAC5Q==
X-Received: by 2002:a05:600c:a402:b0:46e:4705:4958 with SMTP id 5b1f17b1804b1-46fa9b9a362mr150432245e9.30.1760445603208;
        Tue, 14 Oct 2025 05:40:03 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482b9easm245813815e9.1.2025.10.14.05.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:40:02 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 14 Oct 2025 15:38:32 +0300
Subject: [PATCH v2 7/7] soc: qcom: ubwc: Add configuration Glymur platform
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-glymur-display-v2-7-ff935e2f88c5@linaro.org>
References: <20251014-glymur-display-v2-0-ff935e2f88c5@linaro.org>
In-Reply-To: <20251014-glymur-display-v2-0-ff935e2f88c5@linaro.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=mQsq9Lyl9Xj4ieWxCs4ifLYeBM7hE4agqANYBsIaYvs=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBo7kSLNYRKifdBgcF3xKNW0WLXs4gtszg2kFZsA
 pL/BdVpBNaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaO5EiwAKCRAbX0TJAJUV
 VvKnD/sFavrflS06oimK1daRufz4+wRv0bIIBt/XB5fqDqKLrMdYTIA7A5Fsj7R08LRp5BTAcrp
 BJm0xLXVWeimbSlBheggj6qzBsm49RkBN4ZnBmdBPhiLMmzhydaU1Je7u8JUl7SoMX/AWYqBi0a
 uesyngx3xE97NQlls+wJmmzieK/dsUGa5VBFLlqh0OSNfX7cOCAWbYCePIb6bG9pWQuEH9beBBL
 p3n/QtpliEJl2jHk25LUUD41u8jOk+CV59HQdrnZpdMjSXV36M2sZfGpmOcHESc+mYACbCaQPZt
 TUC14Oy+kID1GoFwiPSlZsDx1u1dwfpJ/qjBtlP1Wbg8izyPK0tISJDXjDpJuw4hv1pG0f+w21t
 SPRTSVVHbBTDDgFAkuHREGYJnJJtmj5R+5OrYeW5ovdMYO6bYwbw/4eARHLDEHLjJ9N4ODcwm6F
 FGDbeAzXZGGpLN6oR7ZYAE2p41SYzHOy3YvTOHXIhp2S2PxUqw3xFPiuOXWtv9hmh/D2MkUBb2O
 55CEQyxkyQ6eTLUZeni7/5amUjQVto2+Ll2kZ5pINNLSzcJcR4SDFJvRh8mz9bqKNjtvq8W7Z0m
 KrBE/UfUAoDweX0ZAdmEiBfuJ4i2uLRPvCwxwpmr94rCTlZehiCcj/iXvvRPyEZ9bjGHVyIIwLe
 Uu9CvVduMzdmKSg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Describe the Universal Bandwidth Compression (UBWC) configuration
for the new Glymur platform.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/soc/qcom/ubwc_config.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 15d373bff231d770e00fe0aee1b5a95c7b8a6305..7cca2afb68e3e9d33f3066f1deb3b9fcc01641a1 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -218,11 +218,23 @@ static const struct qcom_ubwc_cfg_data x1e80100_data = {
 	.macrotile_mode = true,
 };
 
+static const struct qcom_ubwc_cfg_data glymur_data = {
+	.ubwc_enc_version = UBWC_5_0,
+	.ubwc_dec_version = UBWC_5_0,
+	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
+			UBWC_SWIZZLE_ENABLE_LVL3,
+	.ubwc_bank_spread = true,
+	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
+	.highest_bank_bit = 16,
+	.macrotile_mode = true,
+};
+
 static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 	{ .compatible = "qcom,apq8016", .data = &no_ubwc_data },
 	{ .compatible = "qcom,apq8026", .data = &no_ubwc_data },
 	{ .compatible = "qcom,apq8074", .data = &no_ubwc_data },
 	{ .compatible = "qcom,apq8096", .data = &msm8998_data },
+	{ .compatible = "qcom,glymur", .data = &glymur_data},
 	{ .compatible = "qcom,msm8226", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8916", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8917", .data = &no_ubwc_data },

-- 
2.48.1


