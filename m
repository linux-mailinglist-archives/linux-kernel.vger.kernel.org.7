Return-Path: <linux-kernel+bounces-812047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF90DB53239
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DD35A1802
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D1C32142E;
	Thu, 11 Sep 2025 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vWH7+33c"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8F7322DB8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757593770; cv=none; b=CZHbvj2+ttESO6s7Om78w5yxPu79YbFC6q9WkmpUygYdIYnAGVmwF/gjGs9oXIDbOAh+3ts02iY5QKgEHLEi/HQxoJK3nlOpN3GtEXz0WVpa0D2FEF7aaTJFzkljFG0J6j/cxpjDvg8/jAot76Sq0/E5ErHuljXgXoVIy+J615k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757593770; c=relaxed/simple;
	bh=yTtr23lhqbScJlmUZX3cbsRwsRc0pG1apQVh15j5H+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TH/v9QhvgEpB23rbQbvq5x1yjhfs32nud4aENR0iR1po5Q9WsPmHLel2srctXM29cpsOXxbJ2WJO09EHxJo7RohbRSA3+S80tSY9z1vhSgAL7PHQjkpVFCzY+0JUUvxi3ubkUIXI3gRD4D+2036DBtxSxM3eCxvhRTOVh+Jqne4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vWH7+33c; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3df15fdf0caso572906f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 05:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757593767; x=1758198567; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rK5gauka6WJHEkf+0ee8itGvW8sd0sVeeoCYGXwGtNQ=;
        b=vWH7+33c7KtphKaMW8IVPywUaC5ZvEo0f6xwejVSWeNl4254CZRaQ5f0FztvD7k44f
         ailXFHqsmFVkQ+wzcTjP46Yw0DvFAmYpVT+7FqoVGVlwsAzGJAcGmEDP2yEVJXf2gdEo
         BPhAD/yFxCxid1lZ3p//A6TCFjOXX7d2mvdRLS83tWkV8fc5cXJrU2ExLTv05NGG4COi
         qn2c9zPJsIx+63WsKIJyZn3bf8JGp/N7nGIdcngesKd2nB6CyAEH04Yflxk6NeEkMrSD
         AK7OLCxfh62+B/LXdZINK+kqhblLPqbcY7MWbU9bmZpyRjEkGyNAGpX4M4JWI8+ThvPC
         Jw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757593767; x=1758198567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rK5gauka6WJHEkf+0ee8itGvW8sd0sVeeoCYGXwGtNQ=;
        b=CXBa9aJYVe8xTau5BklfZ4/scWpzlp3qkkDSwVhHaIhzGTgXfV4Fu0oiSKFCTQ1xUX
         5qbuYHJiVQVIIvtzL/NF4lZnobb8G/KElqR73omWiqErFBePnc8206lYAHZSd2fJJCMM
         0EpvgiiZcqi5sbsQjGbwQq6rdALavoosjazHASV6i5C/Dh1ukRsVNEStR6DNcVUpknaB
         Zq/Dne1kbfGLQG7h2fFNHeLcVcmjNt+sj3/y9guj0Ig8nw+Iqvy3JJLaXb7QlaT+X70S
         C3kXeIb+BBjB00fGmWf/IfPcYgFIG8HfjAeZw5EYeSzx0hUPEXYwXmhA3x5XxpIAFhGl
         zPlg==
X-Forwarded-Encrypted: i=1; AJvYcCW78DzB923ZcLZq6jW1j91UGsnXr0DO0hPMnV5bEMgaLJtCUZNhepSGavuxyGo3nIlsT3dzPYxe54SI2Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMH9Qo7MqKo1foDL3l/Jr+Vm1Vz7XHo6tuiOvd0zdortKJRU0R
	0rRk5NNLPECFDNIZot6NdQQdMuf0d3PlthLc3NNRLxsTy3LZrynaJZUBZcSqGPn3zYY=
X-Gm-Gg: ASbGncu6B34o/HlKVPBHeQUY5H5Xq72gkdCXzUJ1EztxRnhhO0WIBsQxLVnA9Jdg8zB
	G1Gx/GQxELhdtBA5g/CZySNAPpB77aVmw9P7uLThFXSMRFFiBUE41gHXEIBUNibRvLGJTuFMO/S
	dFgHBnNRQqm+k/VjMlWpTWAlCYpDH4OzbLus9Qw6mpAZajjlams/WTIzVz8FoowN3Q3PP7l83D+
	SKiqFuDnSi01JacU4lnjF1OcLOaReuyBCOm0uRS8riN1X8fIqV3sA/bhsamtfvJW9xOZaZkYyiO
	Vr2ASF9gUkfEU/8zeUeXrZXU5SzYXu5YCvcGO8FOzzV2CLWcBcCVE4s1FEaVfS8oocL2umQZZr7
	2vx9U5+OhmXbBKF2NqsOxuAjhAWHH2xZ7kQ==
X-Google-Smtp-Source: AGHT+IE1cC/g8IOGUUpBkwH6C0EwoEtNLSlV22sbFAF6cIH/wjd9irgm7/iYj5aVuHtsstJb9iHmsw==
X-Received: by 2002:a05:6000:2c0f:b0:3cf:3f1:acc3 with SMTP id ffacd0b85a97d-3e64d03a044mr16590630f8f.60.1757593766805;
        Thu, 11 Sep 2025 05:29:26 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd424sm2230444f8f.36.2025.09.11.05.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 05:29:26 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 11 Sep 2025 15:28:53 +0300
Subject: [PATCH 6/6] drm/msm/dp: Add support for Glymur
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-glymur-display-v1-6-d391a343292e@linaro.org>
References: <20250911-glymur-display-v1-0-d391a343292e@linaro.org>
In-Reply-To: <20250911-glymur-display-v1-0-d391a343292e@linaro.org>
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
 Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1743; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=yTtr23lhqbScJlmUZX3cbsRwsRc0pG1apQVh15j5H+4=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBowsCXXllfZnncjUx401LCYZHaYbpDX3c6m2/21
 U0nyQGiUlSJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaMLAlwAKCRAbX0TJAJUV
 Vm9kEACp8OBToeqBuXF1mK1YJ1FPkcHUkIU+HxqB9KpAvinTrIYTMv5IZa/QZCD3k68DovOSoMC
 208JSw/Y4yFqgt6VaoEe036pfLuNh0xDjutfo1XNXGW5favOIO2TIZemDdvn+SNzwfPwP8qiLw4
 xby9+umqV7Ndxk/+7THWqvfSow6FWT9AQ2roJ5QPT9Z74UmRsonZgL3t8wNdTzxWWW/x6gOY4B+
 TI2YjWXpr8TxIiB/Z74+p7A9iCFD505EUbLCo/gCx8U0P7X6SVwOXJCdvzCz+wGZo2koxXnvXbO
 22TTZZBoG+p4KQKFeYRreXlvu/JozLoIQ70S7mR3FyX/09SXinLfV/nXmP2Zrs2R1gxgDfM6Gkd
 KOC4dctiBsQPXYXGGNQvDhM06Y7nYBkNZXnADL/snmfWRBMpDnu+cDqfVeAW2PBMsldotiVGgu8
 5YGfGeAvCKPHB93n3lyYmvoYlTITv2CN8RtUDhkYDx8krwVy4HONBjoBKFH3qjn2ShFLKD14w40
 0FqpHbzkJvvlFN4VQt7kZr0Rx6Et+/NbYJxxYgxQLG4ifQzj4Tfp+IzbtKtyo2GWrvSsJHMOtSO
 OkfpAV742Cbv1ukc5QbbGXowNlgIDi+FuZuRJFmoxyjqkHXf2v1dahCAP6ZGbxuGn2NeILwr1nb
 U8YXvWMFTS8AUeQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The Qualcomm Glymur platform comes with 4 DisplayPort controllers, which
have different offsets than all previous platforms. Describe them and add
the compatible.

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
2.45.2


