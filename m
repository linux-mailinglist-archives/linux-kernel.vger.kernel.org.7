Return-Path: <linux-kernel+bounces-852589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9EABD9683
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20C2A35435D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27489313E15;
	Tue, 14 Oct 2025 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UsluscN8"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE1314A97
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445604; cv=none; b=LRsSEy5QrzDhEqL5DDDEQumb5q0UHXjzplp2apQP5dbEDzkcbNcFHde0hU6hCEz4tJYsO4ssqbrRzcbY8GzLQAXwypIhkkkfw5QmrT23OmTR+WDKHA9Y54vB62GkwxYjVDjOeyqqmLROu9oo9XDVY9AA11t1mro8qLl2tcUnhRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445604; c=relaxed/simple;
	bh=BDhxfQSATkvz5PZ4qM3SXapXE8VjPOJ1bFOc4+xtjJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HjVnXDAc+55oi4wauwB4b4QaZm/bJ0qaaRGIseMC7IFADCqT5HLcNUw3Cuf6Ytda4bnxo4U88cTyIiYr5jvKTuTzwjX97NKD+TEot38t7rENZd3y1k4l8kxFIyg5L7PSDm6lX68Zo6KpMLTArNrNTaohhlrV5I0hgfI5FNipCr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UsluscN8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e34052bb7so62704825e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760445601; x=1761050401; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxgfIdENtrsIjMM2UdQCTeBKGZOKjcZiEo3cUFxAXcY=;
        b=UsluscN8nca5PWMZKPSBJX5xayf7fO1urvPU6QQGhbEXz04aDLWiA0YgEaMe9aS+yJ
         wB+V3VJNtQk1LIlWItaFdSdDCr2wzH9j4je4QFA6GwotIj4+7lxihcuglNSp2SRa/twX
         avXtIoqjaXIQBAT2/Qts6RiPvlQ6o3YMx+sfeATmzKcfbS7T0BzEvNuBRSJ/ellUEJeU
         uRzw5+xkLSI1Xsby0TonhqoUPlDZQga0nZ0iVOtuCZ0NADP4HGv69gC0gOJDAQ4SLulP
         j0qR3kTpRl7QlbAUUUly9yFIFF4AuDS0dexW7A0s9IZ5M+hThcQcq9PHYfMvHipLaJD9
         jTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760445601; x=1761050401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxgfIdENtrsIjMM2UdQCTeBKGZOKjcZiEo3cUFxAXcY=;
        b=lUlyeltTgeGHhZEhaw3fzjHmVvRPcwRNZklD62gZoSpMw514qVQFq5fBHxaDpRtzIF
         evPRkcPa/zcpqJbJzI7NXfZjZriVxD4bv57xeBFZZtEaEjNSP75DpGzxOlR5iADhi3sL
         Rdk3Drs4VIL7kg2k9mT8HjlElVg/zZGeuw/xQD8XtkQOfrdhtqz5iiI92MHCbeJrBwd1
         3QYzmSSvvW4bpzDrE2h48kHqubDbsEIrhm9RKdvc6W7a4LV8zqBee5u3pWALtMIXS4By
         tzbOIbmmG2byNQ+YFvwPiLVoPahOBIVKvvoES5zlaQFRACQwBwvXfswzi3lOF1y3iIr3
         nNog==
X-Forwarded-Encrypted: i=1; AJvYcCViMNxvf7x4rlYOSjAdwexpW/6AmyuCTezHhnhODQw9mzL472eVmxQdQxo3AaF/lc2z5HyT6RukMXoLoaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqHBvHSCVtxvcXhboFS+UzGZRKwzj0mUNm+H1du7veZwHsfBVC
	UfEtrHeyhJmUNONRnFRhMbOB2ayoMeIuGTXCSD1HnohG62ECSKSbw1jiiAx8uGF/0vQ=
X-Gm-Gg: ASbGnctqdJiVt3f0Zo6bdcsj30Qv1NwwwvfAuzsPEHFAaFs/T2idpHB870xajODWy1d
	hW3ZZFjrCWkdqTrCO5TDIKw6dJvivPwXC71gDWn7W0GsKYQFFXnyLUWkF+HITnrNGEaZ2Bvc5bO
	nCSfY3IlkgJw+lrqlF+Y1atrvEZUrWS0DlYCjr0uOOENN0WPL0q4XS7Zq3t8+1R/heFnB27+H12
	O5e+cEW6repPBfqaRJmE+ECeYBp6WG9OmoutPYNOPStbWeTEzgRgVOffLBPeicMSNFaMlL1uXmB
	ek6/MCYZqwb/whg6g8wJ91myZh0p0ss5LawN9AiZovkaAuMhKDq0qLUuZ7V1jBsQWHmiXa+gN0z
	6YYQjDOH5tv1MVxlYF7ElgIGm3WZ/HD3tsWwzC/XBhTuA54Aeyis2kw==
X-Google-Smtp-Source: AGHT+IH024kthWWng9VVuStRjupMvWSg7lIHOdFe/7RjnG2kPxkkxrcaV4rPLSgdMQ/hfIsogbXDew==
X-Received: by 2002:a05:600c:c4a4:b0:46e:1d01:11dd with SMTP id 5b1f17b1804b1-46fa9a89444mr163805485e9.2.1760445600684;
        Tue, 14 Oct 2025 05:40:00 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482b9easm245813815e9.1.2025.10.14.05.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:39:58 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 14 Oct 2025 15:38:31 +0300
Subject: [PATCH v2 6/7] drm/msm/dp: Add support for Glymur
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-glymur-display-v2-6-ff935e2f88c5@linaro.org>
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
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1827; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=BDhxfQSATkvz5PZ4qM3SXapXE8VjPOJ1bFOc4+xtjJc=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBo7kSIX67Zq3tsYRsWCfhopNDqKPVvETlIfD1W6
 4ePvOkV2P2JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaO5EiAAKCRAbX0TJAJUV
 VoSsD/9c8jG5AXRyE0vUUUPGQ7sK6F5ou4qaOoBv3ATYVnIwMEgjUdvv2gLOt2eMHIJ+gemHKSp
 gp78ksd0knDi5n+aT3m74sVTvm3NIzu8Mefer8b0KzmXvMtf/inL1CwLo3VIxgzUHzsNVl0ltEv
 SLw/G9zaj43iCqw/hgpuGOlpkONE9mktmkGKUHqDZvclAmmjxi3nzL2uDfdfL2g8Bim9P0Dr9cd
 V+iGCOogdKRPg/n/ZgViXWKAqXDX+ISYo8S7BA5yXOF/9ALDaKrbUzXZ0u8Q7VqRWO/cMhPMcHy
 JSW1TcaWQOZF8FX3H8QojPdtPcBbwUyavynx8GXuTBOtGJRJ4R0i4lR1poz0NMuZPoSxOC3wDzt
 PyEnCa1ZIE4MKbcLEj481EOBBbA++T/xyrWhlVIJCz+MEVMl0MXsaPSapnNF9oFce3alzL1EEvs
 UVqFRDYMturZ3Dw7RI1esR1vQIFdRIIKllez86KG/16sID3j6zejfjWV1uMidqxdeUWroO0jri8
 SVy/c6GBMZ0DkPsS8HpEmzu1kKHd76rQdYaTxYYzVyKjwoYz+zi3iDiGrsxdN9KXpvtBlNnN22I
 gJ1FpIS/8X4qXCu8G2ebruZHlkSBfRwkg6TmXcMjrVEMe8WgzohKzpBl1p2qKuyr8XscVb6k7hy
 nJ2w2fq0zH47GzA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The Qualcomm Glymur platform comes with 4 DisplayPort controllers, which
have a different core revision compared to all previous platforms.

Describe them and add the compatible.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index d87d47cc7ec3eb757ac192c411000bc50b824c59..9bd9cd5c1e03cc17598b222177b6682bbcd89f0c 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -130,6 +130,14 @@ struct msm_dp_desc {
 	bool wide_bus_supported;
 };
 
+static const struct msm_dp_desc msm_dp_desc_glymur[] = {
+	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
+	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
+	{ .io_start = 0x0af64000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
+	{ .io_start = 0x0af6c000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
+	{}
+};
+
 static const struct msm_dp_desc msm_dp_desc_sa8775p[] = {
 	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
 	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
@@ -187,6 +195,7 @@ static const struct msm_dp_desc msm_dp_desc_x1e80100[] = {
 };
 
 static const struct of_device_id msm_dp_dt_match[] = {
+	{ .compatible = "qcom,glymur-dp", .data = &msm_dp_desc_glymur },
 	{ .compatible = "qcom,sa8775p-dp", .data = &msm_dp_desc_sa8775p },
 	{ .compatible = "qcom,sc7180-dp", .data = &msm_dp_desc_sc7180 },
 	{ .compatible = "qcom,sc7280-dp", .data = &msm_dp_desc_sc7280 },

-- 
2.48.1


