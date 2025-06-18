Return-Path: <linux-kernel+bounces-692308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C974ADEFB9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 16:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407A016954B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 14:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637782EF9B4;
	Wed, 18 Jun 2025 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="haHeYsWA"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF8A2EF64E
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257226; cv=none; b=eE7VLhMMEIUXgs88IH8MwDPBstUoncBU37vDr44/Tv72X24NSBreYjIO5PiW0Fuza0Y8m/Ut6Eaw15rfuKCtJw/4VyyL2NLf/0j9tOwhhzAbzVKTEcjbdKh24VyddEODtJEf+xNPacFesltOSrC0gldXdK0iVAkVcCNIEU0zotQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257226; c=relaxed/simple;
	bh=nJt4ADbxIA14pqN4XsVTOJSsLTO3c7LveRnmHeFCRAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CuKt9lVOlP7wLBvwoPxag5UVybgg8UmkM/5HqfOuYYu953WA/Y8MtZlQhJSbmQRvbCl6vSIzF0gAXYURxqAyP2B5Mewf9gKcyWnFMyWouAe1Gnf3OJ36vZH1DsHEYzYukuDc3iM2yoSWWAIChP2RoPGjv+Zqyp2PH+FIa76Lcic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=haHeYsWA; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad89c10dfabso200233866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 07:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750257223; x=1750862023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qlA118QQRrQcU4/5ozkHrMeNhT8icrM9d6BUqE0LJLY=;
        b=haHeYsWATlB4LvbhO3VbHYW7v2W54VpQn+JeETOGxK+HCCsdIe9CbPjVRf+m/ZZl4W
         p5UZRs72NknPKWj9qXgeiwaIwT1GoQp0TWNX7PGWUGhmsgqWTGkJyja7YMKaMlQbEeVF
         keScT4wYY/qrhnJ9hUcR/Ag4BxNdS44f0QRTeaLIxdTxalVaPz1NP3357yBBPUOjWjKR
         zwTUQwtjGXaUa6AIdPcaN2C5sZkwrdTENqMSHhqqAvrEbaeo81qMcZyHRv78nDBN3NPs
         KX+OVPgdE4UcZS4QHqow/FaOwcs4DN66J2Jyy87PZ6zsMDHkaSjOVB+4yZNEdN5MS8CB
         PP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750257223; x=1750862023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlA118QQRrQcU4/5ozkHrMeNhT8icrM9d6BUqE0LJLY=;
        b=aQpI0xafzA/x2EfoBG0GZYsHBwyxmDB1DJUsQirY5CvT6ieSE8ZAP3tuY8FY5U1Pcz
         YLNfPaNlE7CSbFGy21nEXtOgX9Ub8t+YLWzl7lOMrIiDG2XQ/si9GL1KH+KkiDV+LrqH
         Nfw/5SCHWJKrSN1zD8o5M23m99gVNy3WUdlHoOcEJow6lIUsS/R8hRQCGZF062UoLoRQ
         n17k2/Js1BQ7FUokGXTsovIwSGUaEWVC1DUwSuZPQCwe2aNvwsrlhgb8DqMOiS3SC452
         thr6oJJWMd8z+lTElVesr25I1VBXkVNdV1cUHH7Ea+3uJf+q57wHaVIKJFoO0SBvuF1A
         B5FA==
X-Forwarded-Encrypted: i=1; AJvYcCW1gotrOCq8AypESs3zLP1DMpAHfxaLGuKwAJMBiRh59mP7PU8pl7H6xttjOEuQiDlXvf1w6QIAtJ14bHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc3v7u4ngLyupbezhlvzAKX/sKZdi0cWjVpflpumMqjpsG28DS
	J5idGprWa7UdQY27ar8MFQlg77mVKsZcRrQQeS1s3vuU+OYQGvt74slTcPEE1uduhis=
X-Gm-Gg: ASbGncuDZ1D2hUhex82P05y/qLtUOUFlNdls+zZKz1AwiaqXlXPm+zRBB0yEHKodvGy
	9ORifevCjVSr0fHgEgi5TRjHYUf7qD0zaKX9hFjZRoxWRdfXAML/oY8ICgPrQ250zHc8ps1dI38
	WRRvph3YzZ6wbrVa8X4wyoF7vS3edhdTfxJHN3jg6yxsLXjostF0x0apmyMWD3Bo0Gr/0UfHqhT
	TzOLgdqKMQ1kWgAN+9AzNm2FPYERbCq/yUiMWVZHN3TeLFIR+Nk6fM7Sze8yJDsgVcpatkn1GoD
	WsnSmmAx9rthxwXCi0EapPxiYNCGwoKk6xXIJkdNLlUDGKTcOxwWKg9qeycu3wXhF6H8oFgUWlU
	X67sMv98=
X-Google-Smtp-Source: AGHT+IEqWhfZvPBu5eHGUGg8Iwx5XpXuwaeur8bLnZ0cMet2VQIyHL3CTFNYuJDKV/kCjrV7fPGopg==
X-Received: by 2002:a17:907:e2dc:b0:ae0:1fdf:ea43 with SMTP id a640c23a62f3a-ae01fdfeca3mr99043266b.2.1750257222936;
        Wed, 18 Jun 2025 07:33:42 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81c0135sm1052257566b.47.2025.06.18.07.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 07:33:42 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 18 Jun 2025 16:32:42 +0200
Subject: [PATCH v7 13/13] drm/msm/mdss: Add support for SM8750
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-b4-sm8750-display-v7-13-a591c609743d@linaro.org>
References: <20250618-b4-sm8750-display-v7-0-a591c609743d@linaro.org>
In-Reply-To: <20250618-b4-sm8750-display-v7-0-a591c609743d@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-clk@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3191;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=nJt4ADbxIA14pqN4XsVTOJSsLTO3c7LveRnmHeFCRAk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoUs4lO0igoNoiH6lYl9w0oC7YRM14FNNM6kLoi
 l6a8zSzTTSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaFLOJQAKCRDBN2bmhouD
 14hcD/4qDWghYkiFT0CiyrIzz3YMUrhIppIA4jAgI4Rtzuks02Liq1Ri1cWOFhXvDzJyLNjK3K1
 3l89O7kPLQ0cn7X02DEWwWra6i2MTHy0qZjt7UCwRkU37jRNomF3xCbx6rkZTgUEXuvu+MumLNi
 32FRBCTSi35Q52GUqnsgfHZxnb8+7jtX04T5/HPOYZXw57GY0xJ31O0Yy/vlv17qkERjh67z5WC
 WXcrk/tV1kDx3tKAgpqNsO6L+MZcQg72bvi3lhBn/1kc15Aha5GjCEKUEVheu83M3wHkqHgoxBK
 LPudwd4yjqTqID0RenCdjBLJC/i52qaYvIVENqtMaby2dsDw2qPScEX0QE2ONetT2lVUIvVH0Zv
 12bKSbtW9Anvug7Va6+/+sI9Spl+rq1EA6ywxwXy7de96e8g8NHD3LkvEEeYKAdrCMJaxYXcddr
 16ClEV2Op04mCLo2WtmgrG045lTq5Tnp3yarphaN98+t1sGae7tkIX7pJxwIWYHjHC6C1KTYC0P
 Iuo6q7j4L1PHKVgUSstV9T3514uzJf37ejRpWcfg0f+c0UFOC9ZrmTDqS4Qaa9YT8GNsulHYcdq
 v7A01L78rBKRTD301acm2fVGyqAPlcSgnQqDsu83BpTKfjhaqybwLy8WZ7JeHmuk2YTKJtiXtln
 8UxcfxWh+DnTRTA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add support for the Qualcomm SM8750 platform.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/msm/msm_mdss.c | 33 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_mdss.h |  1 +
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 709979fcfab6062c0f316f7655823e888638bfea..422da5ebf802676afbfc5f242a5a84e6d488dda1 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -222,6 +222,24 @@ static void msm_mdss_setup_ubwc_dec_40(struct msm_mdss *msm_mdss)
 	}
 }
 
+static void msm_mdss_setup_ubwc_dec_50(struct msm_mdss *msm_mdss)
+{
+	const struct msm_mdss_data *data = msm_mdss->mdss_data;
+	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle) |
+		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit);
+
+	if (data->ubwc_bank_spread)
+		value |= MDSS_UBWC_STATIC_UBWC_BANK_SPREAD;
+
+	if (data->macrotile_mode)
+		value |= MDSS_UBWC_STATIC_MACROTILE_MODE;
+
+	writel_relaxed(value, msm_mdss->mmio + REG_MDSS_UBWC_STATIC);
+
+	writel_relaxed(4, msm_mdss->mmio + REG_MDSS_UBWC_CTRL_2);
+	writel_relaxed(1, msm_mdss->mmio + REG_MDSS_UBWC_PREDICTION_MODE);
+}
+
 #define MDSS_HW_MAJ_MIN		\
 	(MDSS_HW_VERSION_MAJOR__MASK | MDSS_HW_VERSION_MINOR__MASK)
 
@@ -339,6 +357,9 @@ static int msm_mdss_enable(struct msm_mdss *msm_mdss)
 	case UBWC_4_3:
 		msm_mdss_setup_ubwc_dec_40(msm_mdss);
 		break;
+	case UBWC_5_0:
+		msm_mdss_setup_ubwc_dec_50(msm_mdss);
+		break;
 	default:
 		dev_err(msm_mdss->dev, "Unsupported UBWC decoder version %x\n",
 			msm_mdss->mdss_data->ubwc_dec_version);
@@ -732,6 +753,17 @@ static const struct msm_mdss_data sm8550_data = {
 	.reg_bus_bw = 57000,
 };
 
+static const struct msm_mdss_data sm8750_data = {
+	.ubwc_enc_version = UBWC_5_0,
+	.ubwc_dec_version = UBWC_5_0,
+	.ubwc_swizzle = 6,
+	.ubwc_bank_spread = true,
+	/* TODO: highest_bank_bit = 2 for LP_DDR4 */
+	.highest_bank_bit = 3,
+	.macrotile_mode = true,
+	.reg_bus_bw = 57000,
+};
+
 static const struct msm_mdss_data x1e80100_data = {
 	.ubwc_enc_version = UBWC_4_0,
 	.ubwc_dec_version = UBWC_4_3,
@@ -767,6 +799,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,sm8450-mdss", .data = &sm8350_data },
 	{ .compatible = "qcom,sm8550-mdss", .data = &sm8550_data },
 	{ .compatible = "qcom,sm8650-mdss", .data = &sm8550_data},
+	{ .compatible = "qcom,sm8750-mdss", .data = &sm8750_data},
 	{ .compatible = "qcom,x1e80100-mdss", .data = &x1e80100_data},
 	{}
 };
diff --git a/drivers/gpu/drm/msm/msm_mdss.h b/drivers/gpu/drm/msm/msm_mdss.h
index 14dc53704314558841ee1fe08d93309fd2233812..dd0160c6ba1a297cea5b87cd8b03895b2aa08213 100644
--- a/drivers/gpu/drm/msm/msm_mdss.h
+++ b/drivers/gpu/drm/msm/msm_mdss.h
@@ -22,6 +22,7 @@ struct msm_mdss_data {
 #define UBWC_3_0 0x30000000
 #define UBWC_4_0 0x40000000
 #define UBWC_4_3 0x40030000
+#define UBWC_5_0 0x50000000
 
 const struct msm_mdss_data *msm_mdss_get_mdss_data(struct device *dev);
 

-- 
2.45.2


