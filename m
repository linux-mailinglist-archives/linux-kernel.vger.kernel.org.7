Return-Path: <linux-kernel+bounces-812045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C688DB53234
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B4DA7B3441
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8484322C66;
	Thu, 11 Sep 2025 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m0aQaF3B"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350B1322A24
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757593766; cv=none; b=icgqxlUmYxgxbn60kRLnyMrHSzc8L5sLEKMo7MnK1I0x2UPolbbN0C3z6//HY+6hIUSxvdp7S39HO+sZSFY24tEXtcczaGDVxNgNL9imo+WKoAxnLI1QdputiwfNI11txZjMRtbHpEdN/v2ddalUeRJ6s6TWzWetTBDIGL+S2lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757593766; c=relaxed/simple;
	bh=VIaFKqE75CM+elK2XI4KYXHHvaxVuznQBropijUaKvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XB+CIdvFyuSFs6bWkm1KyzZcx8V0vYKy6dDvH2Adl1jJc3LQVj4w5Ga0ou5Iu4POe87dTlGYb9/Cm7eQzBjRmfvlXTl9ElE3jRkoCJySTq3bqX1ISsT/SrbBvwBFXQO6RYAAe11nrXiSPS3v3b2/KXd5ziEhg6IVmLpGMzUbLL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m0aQaF3B; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso585576f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 05:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757593763; x=1758198563; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYKFAdjOYASo/WjabAdPI3Sw4noi+10vn2fGFK6NGHo=;
        b=m0aQaF3BLAjPuFljvYviGv3JW/AMIEly9WA5rh+j98zrA4zQqrvoYg1hkaTOmQMzh4
         9FU4B6W8WjmIQgyrZyzeFfgJBGt0Z+vz7Sn0MhB3Yr1yyk+vkBrkg0ORuqKQqjkzrpBh
         bUVou+7L+xCGSfMuPORmYOMaIGv4T7g91Q3tVMuUvZyQg8onLbcki/LygQxQ1Z/FdLAV
         6vtZ0wGiyl3ubxOYCBpCZJKWE/ZFIdn74eXSssssw4YjJpKMz+4A4LbpCWf78eQ7dLf0
         xgaf/nxny8DhcwdcwnGG/gXMM0n3K5IevI+l+QRhQTNQujaDqBguoM6nmX6Tz/mCFQxY
         Ayyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757593763; x=1758198563;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYKFAdjOYASo/WjabAdPI3Sw4noi+10vn2fGFK6NGHo=;
        b=SjkQrkCgL28/5Jsx64qHqKv/DFcLXPO70OUHkbU6z4lKxN7ocIyAzTA/9MDGoFXM4d
         al3DkWXTdDh/K1Sj2KxGrpczCfYgiWZoKMLt7rQD8iSPmDCxJrtl4ET6VV1a9EqNPNzv
         0r75hGb6H8hGmCFbPA7itGIT9nEdeM/sqxtM2IsWbpK0CjE9RF4/80S7Z3JWoosajyVW
         AwEjIZz/JN2CQFx7HOzD4BqAYY4qUMDR0vimcvC6Hr8DeOW2w2OLbgR6s9FGTf8iXOx7
         n1UuJ/l+sRwBHKJ6KPjYxMUNvnB/jOtm1feDP66HF9YVfw81W1oS0Gjpbnn2FzAWVA0p
         jCtw==
X-Forwarded-Encrypted: i=1; AJvYcCWok/57gQ8dKQ3ysJjWOsVKhhEria8Z4Wu9z2qHiWJ0XgEctWPl1R4Q6zZ9tUJHg9HLQjv8U935Bs1io34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7P+M8Zo3d2NrV38W6/MtSqccOioPisGr+h4fvWceA9rj3B9NK
	VLpF1I+zHNNmskX6/+SDOyy6Zgtv/Y1oG3jH2FMGbdppLvkA27AKsY1VlJFYyg20O8E=
X-Gm-Gg: ASbGncuoMp64AKhXardbLuBEFtHVC9ZT0Ab+sZbS5r5eX33agWNZY9Ej0xWbqrHtXJu
	kMAt+XVhzD/s8qViiGBpX+XI+zll2Y+SrNj168pyfAth9CWNQe/62lhpseoNdM5pNctk/6if/tg
	wFfUpctvCx82B5+BEG+z5KJ5qluMD88njg+HRiZ+CNq95wZ98TrTkPUUKKGSiaQ1gDjQM59FNWV
	5xoJXVkalSDewUX9Qmfr8kHBh25TthzIKhXaPcxgkUftKLsoc415gbGTJiPsFNHz6QzMXggIxwm
	roYsJ91IGsJCYX+iuZnoph3oOG3oJ2QmwMpwW7+N0PwFCtk1iBoPumzCMIkxkwtiG8EJCTzE8q2
	0jKP7DBdhcrEls/LnOeUDBhN1PpHFXPBwUw==
X-Google-Smtp-Source: AGHT+IE4wZnmN0HF5vilM8y4TE0lu9yYsqD43OkvBy4fyb1qhM9Qox4fLexabkHws0JYYvrRpH+fmg==
X-Received: by 2002:a05:6000:3103:b0:3dc:2912:15c0 with SMTP id ffacd0b85a97d-3e636d8f8e9mr16633511f8f.1.1757593762609;
        Thu, 11 Sep 2025 05:29:22 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd424sm2230444f8f.36.2025.09.11.05.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 05:29:21 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 11 Sep 2025 15:28:51 +0300
Subject: [PATCH 4/6] drm/msm/mdss: Add Glymur device configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-glymur-display-v1-4-d391a343292e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=VIaFKqE75CM+elK2XI4KYXHHvaxVuznQBropijUaKvI=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBowsCUdGmh3ForSq9QMyjokksSbUSHlc5VCaSEp
 Z/TmI90GCWJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaMLAlAAKCRAbX0TJAJUV
 VqhRD/98jWD57j5rtDVLUAmyM7r+QH6yH7G4HtwgYCTfk4b9yqkUtRFB99WCwwyLcSIPW+5vWT3
 G/7lYSdK+6ZkOnVdQYfuzZqmVIgMU0nr8gB3LTHyUAsI3ssZP+0mLTJQxH/5OtiDbOoldMPDDri
 WmGQGY8ChrT+z9LFFdHnG3WytJE1RqkKTChVym0dUCmulLNjeiEOZZa5hXZs0vDeXVq0e/+ZxpN
 18XQXNojihi+l6o6Vom8r5GERiFnptA4aMMs1ksRJmewxwr5zDh3lrzdPsKTI4S5sKNoKCOFa44
 SBrHee4vRiqfhVXgmTNTQDOQl8UapqVlEjozHl8rA6nNspaFJeHT9cM6ZpQstSnQUnBMVW5LVUU
 VHFEM2KTUnG/gvgxjBfQbrTtgyu8VGrB9IVGfZxysai6mdioklApSIRaS1MMYKYMFHNUBDDu/Nv
 ZtgzjHw6HOAbuZtsEhqdJfvAzF1NLJaWLQrXAfTJt1W9QyjGBz/7+CYp9WgbkrRKANOQwL/rvAG
 vEzYT/JwTeusAn/XRifhUPHf2oxMCvGzfqITVgG1au/FJiUqutUn8XKtwNEdb3ATi3i0n+ehPta
 91zyKEzsYhb+dsLm8+d5w4Q8ZLhA6RZ1tnuiFrLH8X1+6xggAaWK9fIGS76n7A2bsKxZTB/tS2Q
 F+cXo1n16s7mPxg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add Mobile Display Subsystem (MDSS) support for the Glymur platform.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/gpu/drm/msm/msm_mdss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 2d0e3e784c044db8ac0c478446d211a982cf0350..60bd6af83a8846f2ad751ea625a20e419c80638b 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -553,6 +553,7 @@ static const struct msm_mdss_data data_153k6 = {
 
 static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,mdss", .data = &data_153k6 },
+	{ .compatible = "qcom,glymur-mdss", .data = &data_57k },
 	{ .compatible = "qcom,msm8998-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,qcm2290-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,sa8775p-mdss", .data = &data_74k },

-- 
2.45.2


