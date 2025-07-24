Return-Path: <linux-kernel+bounces-744341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C346B10B53
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8F05809CF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A1D2D8370;
	Thu, 24 Jul 2025 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Md/xGQE+"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4922D6605
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363484; cv=none; b=TVQVUQOxXt5Q52uUc+eWFF9g17MuQDXx66a8QqO/EAn+Kbj0Y59lq4dhpRFvUu/SteJJtGBJDBJcrkrzNKcvQEMty1pdBg8aLAcnzEpEVhoU4oiDt9xkIIoGrb0NmibDbPZHYxaX8nMSaepU1/jbIYrDlIshukw/830WPBLMsPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363484; c=relaxed/simple;
	bh=p+yyDfpaikIlbQ0RIIFLKKIRFzhOXHswHzQuMkK5ycM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uucSSWSb1JqvwWdpSpCyOxaGZvWLYFRp7rB2ze5oalZg1BGzU24/0G/Rpkjk7nmsBP5rO0hOdwy/6A4EYVhFy8GMS4FhKWfZzfEW9QcJB+E4wykVYlULIkfxi22ojR2xv1O6QX3AVHeTcrCcEFsSh9UI0vyUVXNngEve0o22pSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Md/xGQE+; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-606aadc1433so197237a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753363481; x=1753968281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XQadbJY1gERxsaDeJ9P0/TAd0HoKQzKFQkKIHzndF68=;
        b=Md/xGQE+6ZsPYH3pblmW0arkKDb8w/z7REgWRQOuNbOb4dtDYbKhnZctmdWOCzpdlr
         djRgEsxZD9DxWXWpZJBIAIw7H5KDH9/dh8f605H3vfcJN8CMtVfXMz8ps4saVo1as3Mj
         NA1GpQJVC+mbjdfVL+817+MUJA0q/UGQFdbUjyYyjkk2HtrJV/W5N8K4JRnWdeqX1F9q
         SUPZZW/tbA4lT/TbU/13kXLzKt/wGnmb3oM3NPbDkJisZeWSUa4aMz9P1gHIWZJVK6vV
         6334fW9wpqUjKuwHH+2xWcWnjmPNueZ5mPRl3ebUK2l/8PeZBgCqeTFRAu/LNKun894W
         x5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753363481; x=1753968281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQadbJY1gERxsaDeJ9P0/TAd0HoKQzKFQkKIHzndF68=;
        b=feRddMebcuszcLpClOo1TzDoVBF1ar31szUdpTSh/SQafmM+lAxMGDCwVteQHmCqii
         PVl1narsLVLbeRwy9pnY8A33bO+EFCvWUVH8Daf38FWVh5MJJIwBFUHLyszoyfm9D7Wq
         FeipBXrqJ9l+dKsYHMoPksaMzPSSnTTn8nsdMlPUyoItEbvje1Ow1lFHIZn96OsBAT+V
         dY5zoJY4yXdWy2JGOi2+RSZnbX55b7gdW/VlO2YVgtN6DMRrLS8UWxHGoB68zWhz455F
         mZIp9NrSyqmTbosf6zfjKdlfUOSai6I59DM4hh45KoAprZAyRfwFRFRogi6j1rKej2GK
         9lNw==
X-Forwarded-Encrypted: i=1; AJvYcCV/kVYJ7wOrOumpQYhL0cG94R3moY+wWl6sN9WzjqaO2nL1/iJALjgU4BXRbZJrt6xuJqYkddWo54OzZFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeLLy0eY1Qjp4/xQSbDv/6FFhl7KE5YJMOHTbmFMPHToDbF81i
	kvcVgQc6iG2b/LeXHG8sTWWy/EO5gIqRWN6DRGf8f/SQzSdc9AvGYJ8erBt/P2qLquo=
X-Gm-Gg: ASbGncvT8+DSn/FQirxZ1aE4tvHKGSnyUzn91KlQwl1TKP47dvdbxmk0Z/7frTPXohu
	D9vYj78sk13vxFTg3XYI1SFfwJrkQ0UX5jsbOVSgWAiec9/kNhGFGGMlp3x+hCnhq7e52/AyRdV
	4AyMkxXrCeJo+eUl3y9b0Z2Go26G/Wycmk8q+SpVOcNdEa0TsTPlgVLQ8L+ZD+jqw3FA7HuS5jt
	uOZYDZXLjuBvQOGuNfKM9z7lKrMH9PW324vSjDE4L6c3Oo76OgJI/opBy+h3w81r40/le3cGMKu
	J9rwijXrE4WskCAE9wCNIg7e3jQg/V8a5gVjW/tvpP6UasG1I3NOOKrYrMcIDttis0qh7lP2pmW
	e0N05ZpZr85t6N6VArfzIyKMQskbEoMtz
X-Google-Smtp-Source: AGHT+IFcqBkCDJgImtGkfeJcJyLjABWRXv6ytc+F4wW968BqqxretSPGh9NNBLe7GYV9vJCCbgUNIQ==
X-Received: by 2002:a17:907:7e82:b0:ae0:1fdf:ea43 with SMTP id a640c23a62f3a-af2f66c63c9mr266600966b.2.1753363481046;
        Thu, 24 Jul 2025 06:24:41 -0700 (PDT)
Received: from kuoka.. ([178.197.203.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cc6cd6csm113077166b.43.2025.07.24.06.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:24:40 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: arm: qcom: Drop redundant free-form SoC list
Date: Thu, 24 Jul 2025 15:24:37 +0200
Message-ID: <20250724132436.77160-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2998; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=p+yyDfpaikIlbQ0RIIFLKKIRFzhOXHswHzQuMkK5ycM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBogjQUsNc7ZyFMLMTlPc7kPuk7BJcf6rmVZb6v0
 Jibcr5s39GJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaII0FAAKCRDBN2bmhouD
 1yBqD/0a39vQj1ryMxUxe+GQs86YATCmrS+dpNwn4KSCtump1IBC4ylxKA0p3lXubCFOtnC3u+u
 0mSE40ORmW99gsTew0Q97OsZZbzPgmBpeiaacXunB8ftG1DBS7KQ9oAZFVLrxVZFj+Kl9+VTRXK
 VVevVQ4gDswyXtydUSrFKWhxa+6fe9m8G+nKmrR9gVNDivVZ1IIpiWqNlsX39y72yDdiBcI/ete
 lcMGYUUlw0y0T9mSQhcF/6MpvU19+5RWQLfgDq9oaiUCv+B/7e11HQYWUBVACVPZvgrxNsIR2Xd
 kf/7zC92Ep+gG0/t6zXbRV2A/rD0xOhDSOYEoUjFK/Gug8MSgPGT8sEnNwmjzsfwkNaUP32Azt5
 tqga4e3lVUuIInZouwQxzhb0djUIUXvf64KZX8Lm7AzmJgYXLXFtKWseNCv3Bgw3Ivd/1erF9wE
 Hp4SLchD9cnZF5TpFUp++QDpbYBcBeOCFbIGv0aw5Jdnf5StT8DCNZRkqMNvVApunEP9r+W0Qxp
 uB285IUWLQNbc3iaNdt+YqSMP9SyGgIbPyh+mw5S1xxg1+TPWgd6YkQQLoDIvul515IzBtNGMZU
 kHPSzSzDin22IsEfPdjka3FkSArMrH2AfPqQ1TuUPOEwVpMowmd4zZyOsXcCr6dYkG9aUY9unpv /GJv3dDqRO+6c3g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The schema and Devicetree specification defines how list of top-level
compatibles should be created, thus first paragraph explaining this is
completely redundant.

The list of SoCs is redundant as well, because the schema lists them.
On the other hand, Linux kernel should not be place to store marketing
names of some company products, so such list is irrelevant here.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/arm/qcom.yaml         | 94 -------------------
 1 file changed, 94 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index ae43b3556580..9598cbe29cef 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -10,100 +10,6 @@ maintainers:
   - Bjorn Andersson <bjorn.andersson@linaro.org>
 
 description: |
-  For devices using the Qualcomm SoC the "compatible" properties consists of
-  one or several "manufacturer,model" strings, describing the device itself,
-  followed by one or several "qcom,<SoC>" strings, describing the SoC used in
-  the device.
-
-  The 'SoC' element must be one of the following strings:
-
-        apq8016
-        apq8026
-        apq8064
-        apq8074
-        apq8084
-        apq8094
-        apq8096
-        ipq4018
-        ipq4019
-        ipq5018
-        ipq5332
-        ipq5424
-        ipq6018
-        ipq8064
-        ipq8074
-        ipq9574
-        mdm9615
-        msm8226
-        msm8660
-        msm8916
-        msm8917
-        msm8926
-        msm8929
-        msm8939
-        msm8953
-        msm8956
-        msm8960
-        msm8974
-        msm8974pro
-        msm8976
-        msm8992
-        msm8994
-        msm8996
-        msm8996pro
-        msm8998
-        qcs404
-        qcs615
-        qcs8300
-        qcs8550
-        qcm2290
-        qcm6490
-        qcs9100
-        qdu1000
-        qrb2210
-        qrb4210
-        qru1000
-        sa8155p
-        sa8540p
-        sa8775p
-        sar2130p
-        sc7180
-        sc7280
-        sc8180x
-        sc8280xp
-        sda660
-        sdm450
-        sdm630
-        sdm632
-        sdm636
-        sdm660
-        sdm670
-        sdm845
-        sdx55
-        sdx65
-        sdx75
-        sm4250
-        sm4450
-        sm6115
-        sm6115p
-        sm6125
-        sm6350
-        sm6375
-        sm7125
-        sm7150
-        sm7225
-        sm7325
-        sm8150
-        sm8250
-        sm8350
-        sm8450
-        sm8550
-        sm8650
-        sm8750
-        x1e78100
-        x1e80100
-        x1p42100
-
   There are many devices in the list below that run the standard ChromeOS
   bootloader setup and use the open source depthcharge bootloader to boot the
   OS. These devices use the bootflow explained at
-- 
2.48.1


