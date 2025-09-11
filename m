Return-Path: <linux-kernel+bounces-812043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4D8B5322C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE595A0B57
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8815322A08;
	Thu, 11 Sep 2025 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mVE4cGqg"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F0B321F4D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757593762; cv=none; b=gn8KAGZiKklV/RsJwNA7q3JCFlWIoHKr64AC8QaXuxpNcrBS+/YkbGAyvgw7Y9GeREjCTrBRi7gGgptRD5jGqQxy7fOsRU4oBkF6OdcbykgT+Q46EaA0WgTjhKso29dTcdOxHnH3FjJtiEte+jDSERfgTs8mNg6gm3mSfak9zic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757593762; c=relaxed/simple;
	bh=AnOXO7m0V2+5EV8Mv50wScBsDq9l11L/Vhh0fgbgYEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zzk7e7TUT5A16rOFccCyY0meUW1NfllkSVm9xaB7g2ot7uOE5Ck6uRQ2/e0XCScMIZYoUv97OIr7AqF3Y7oKZjDszf035xFeRhD//Sdj/JwidGl0OZTMOuUwFFqS9WwE0lHAv0rzy8YSPWIZeYstoxSi9XbQC9KOcRUs35OUryo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mVE4cGqg; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3e46fac8421so655878f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 05:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757593758; x=1758198558; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iU5qxqQ3QlAqV/z++RFsbMDTEhPRXVKvJSuYqKmt2lo=;
        b=mVE4cGqgm2tA+14B5FaZ0pixUqx2YS3RT7zmy+bleHHPCcYmwDllZFDcxTwKVgGvG4
         JPUtkM8YEzqWQKfqicOLixw/CODjQFAudFJGV0ktojNUiz8mZ9NsYWRdo5sf5mm8lcZT
         pdZUNCAW4zxpz4wmloeHC4gV0urcJx+T7RgdgTQ5m6IBeLw1IwUawUCaxTRQiHPCi6YK
         NbAsMetfpvth6Oc31DBAJDtC0jzUU7xsh3ROtzRSsvWuwQvTWAqhUuQycvqtN4sRDeXz
         2siHc0M2tjcmtuJDero5W5hXAuiFt0ZvZ3Dp2l4c6PmymdDMQroIGcQDag+Tx+kdOrbe
         z3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757593758; x=1758198558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iU5qxqQ3QlAqV/z++RFsbMDTEhPRXVKvJSuYqKmt2lo=;
        b=p8CXjHKDWWv1m5Yvjpf4nLOUPC5FP4UXnsxhA/+itXVCN/JUOJrNRkwm1Og2cQvxYn
         PGKamHTpCQGT92IVh8lR8P5Cp2pJV25AhFBNn/0+k+FBOMHMS0n1Ja73BQ75a7YOvNot
         E7w/3DlLQAoZQHYaQ/0cKf1KFv3zG7T8aMn9ENfZhy2JK+WvR3cLZ2VZOLcfiVH35feM
         T5QjK/BjYSeYvvdC502vLNvnCVapNkNWM0HhujOihVUW8O5qzAQBiSDOzvGrVZptAYT+
         wek0W/3ZuOw9/mMQSK+7sIcPo071T068iOFhqd0PL+h2oriuzvBjPTB3CAQLl1hEdsoQ
         mjEA==
X-Forwarded-Encrypted: i=1; AJvYcCVItloYbSEgIi8LTfqJZVwphfhuKPPXQqobWyd8JiSgwNr2vPRhXH89BSfMymw3SW3eLeuDqYavfdMyNcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybwmYH1giqqufV/N1m2eUaedC7gozDtPAm3HrOosO/XUlKqLd0
	65yVWpP6VDPq3qWL3YO3LqnYYPM7H71g66A/EpoSxV3bJZ3tqVzKXcfziOJ8ifKM8KY=
X-Gm-Gg: ASbGnctr8nfeP6v3wtypaMRrmvGlcrhR6OGlP2IwxvjyK3r1kyBk5qaLEX5e2ti+OGw
	U57d5awdGbA37SXESBf/XuKBFAFw9xuMa+w/+ZtDC6KVe5K29281LVMgBzGbNz1irSK01QbEeZA
	gLUJiPMQSPmzdMPQ4yfrUQxPBR/PaTkXFA99vJNQ3lSMbgMz4HX/gC0N3PIwreXYysTb4/PFI2H
	krIyFq7LCXs0TGlK1U9xh9f6aZxSRQDOsIzSqUCcRhJuINZK9EGnDm9GrlyJHAnCfiXCQQRewNb
	eRXIhlkWQKn4oGtN7lWETM8sLAW749MG2hw/tYfvDmp7oWIQiR0UYQqlfprV7Ko+QN/onrlwMOu
	yMohyLmRUteftbaQLRCoKNu6WxltHy+uN/A==
X-Google-Smtp-Source: AGHT+IFWZTWiXMDADOt1G4QAp/SFmNA4LJ7kToOBm61D0izqVFxvUQDX8KXFSUag/JDhBo37YTQjjw==
X-Received: by 2002:a05:6000:2502:b0:3e7:4835:8ea7 with SMTP id ffacd0b85a97d-3e748359441mr10681959f8f.8.1757593758409;
        Thu, 11 Sep 2025 05:29:18 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd424sm2230444f8f.36.2025.09.11.05.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 05:29:17 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 11 Sep 2025 15:28:49 +0300
Subject: [PATCH 2/6] dt-bindings: display: msm: Document the Glymur Display
 Processing Unit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-glymur-display-v1-2-d391a343292e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=906; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=AnOXO7m0V2+5EV8Mv50wScBsDq9l11L/Vhh0fgbgYEQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBowsCRIB7YzDXcPBwww3XfuZwJ96qdhgZxW+R9+
 CJm7Erg+b6JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaMLAkQAKCRAbX0TJAJUV
 VueyD/4vMtmE+QKJqal9APF+kXMGk4ZAPOWfXP3dl0dBg+0h0tdInJRu/Do4YH125zjiG5dBK7u
 +HWqfLrlaWCCFKoTSyJ5cwIQPjz1uNHUKADtGkgTS/35F5q6VQucEthCeqiAPzdHN41oGG+AGBB
 VMvPgvrAITIVenCzY+QHi1urWXtgkQhdazYZf0xpH4S54w2s97CAhnHOd5lOCfHeifAESXdlsWt
 ponTQTcqvzEH3zXsm2rWfOghtc0STMzVNqafxZZL+o4MgghO/D6G4uN4oqbKwLOVf4SCw9vAlF8
 7AX9jZ49eK/+nC4An08NNEka0KepmWEmv0AWuNkMv7PS0Y2kOYo9tRMizkv47I/9gUbnfVEjmZs
 SoMzlBKNMDjIqa+yK9/lbuzij/tgObP8qFtkbxjD1fdgSunKi61ldchgvC1/855LP5Rlpjwf4v2
 1f+IRct9ASrlOdUpUIkMX2AFfZPyLxqTSKfjy0+F0z7VlAHFpiyVVFRNjBbawkwmudOIasgH1N4
 Ln7qYqSejvwnLyCmTK2Xi2xSRZxT/lGgxV8mpdz7FMQ0nIUQ62cX5lwljAGpyUO3lcnFGgozpbx
 KCyz+KBDTK1WbH1hdhXBf7Kxva2WOrCawj578XSp6vEaRRfAzBXV9uCer5NORaIeKZNaBr/RWyh
 Ys0TT+ArWe7Uq1Q==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add DPU for Qualcomm Glymur SoC which has very few changes compared
to SM8750, just enough to make them incompatible.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
index 0a46120dd8680371ed031f7773859716f49c3aa1..feb1b8030ae0e381118a9482252a915199e19383 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
@@ -14,6 +14,7 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 properties:
   compatible:
     enum:
+      - qcom,glymur-dpu
       - qcom,sa8775p-dpu
       - qcom,sm8650-dpu
       - qcom,sm8750-dpu

-- 
2.45.2


