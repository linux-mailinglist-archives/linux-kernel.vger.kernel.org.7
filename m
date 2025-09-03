Return-Path: <linux-kernel+bounces-798528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A9DB41F56
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75AB77B5437
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAA02FF678;
	Wed,  3 Sep 2025 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xlQm4THF"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E702FE586
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903083; cv=none; b=daDQZj17v78VuNhoOwGjyZ0Dqmw3xVUfzFbmtdelEyapvHBJzkiiHvAt5DM7I+d47I53ev9+/0QBTAPbH8kAQh5U1Y8yOkS8HVdOBC5t2sJowTougtnhf7Yvcnhc4puFC88fxADLYTE0XaURmVc5z4oFyIukwGhALRdHzxh4lzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903083; c=relaxed/simple;
	bh=W/NXOLTDQ5i+LA/X1CrjKyPkGzseqK8+KPCSGaDzeUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fj+poSky4vmhumUPf1ujJBktZR1Nmzx55VMaP97ViCVuK1if3a3aZhkD67LNA/fugixLAhfaDcDdPdMPIcANFe79ojwUWZPzvV6LH37Fq9n8s21904ZkjppLo5XwIu9Elo9vrcRS0RDovO9TK0WkN+270rPHPyP5b4dPZbsWDFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xlQm4THF; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3df2f4aecc7so306869f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 05:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756903078; x=1757507878; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxEjNld7tkDsnxguU4Fy7yBizLDnFCqErAh87yjOcjM=;
        b=xlQm4THFL1jj85p2LS/ZTJ4wKBeU/wdYRMc4RwV33dh2+OZqW321ucwj5ThjxQsIwz
         sn8uS6AnABhRSN0eS01MI/KM8766a2cW61SFeTW3wja7N3bwOJ8kEI4dnzYMrvDbFHq7
         ejUja9cIFhvgJaBMnow9RUaJq2wYv6bIQ+EdIsWpqlM37XzIxo/xxy7pyanCqHPy3ucP
         8H3fZy9MTkzDmOywgosen4pPc9ZWrzcBCFs66uDQQPbmTelbyCfAcA9F7WrEXlXizAaW
         j8EXn0j6ofU42xcEw9542Q560kjOIVVTeIldpH1Zfczm+oxHShPHOkM/UfUY6DV2iOBa
         6/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756903078; x=1757507878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxEjNld7tkDsnxguU4Fy7yBizLDnFCqErAh87yjOcjM=;
        b=h+e25spr5vsmRwaxfdtujMDb0dM9nKWxxZu1BCGs8SAxlMYP/P+p4+FO/P0Lg6BbQi
         2Mnnmd2LHc14M1gliuWSAKEmmg4hB8OZH06Vvo1zoDxpK3+mVaZD9oHoF+p3KRLmbd6R
         shE7d4ZkN69+lDMXaDNy5pfBvnR1ikH2leHt0ew40L4l2cvAc5JPTqV6UK9usVRMLf9n
         6TWYB7oLwdcya6HH94bG6cEHExn3mWF3QetoRxmizYepYuSeJJAMtd91hdo3xSQx26Oa
         rajHmI26yjD9Qe9ON5bJdAIsWklKs/2XOEEjjUtZ4PkaaA7YssCx8peU8DMY5/4k1NWy
         SGug==
X-Forwarded-Encrypted: i=1; AJvYcCU5GgCEY6avRMtJVIa/GTyBDJb9Lr2iBeQET1kMw1AYFdxJQLF1ulL0xRSAQHKifXgAWVWmHbJNleE39E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG4oQp50c4EG3qfBivw8Ca2Ve3TD9+z6s/IqKpZwwzvu690a0H
	b3TGnfK8M5WTBhskoIr5utdhSyWgzx++jAbk2EArMo9nKoEplZNka2L/lQhjdD7ulfzBi3U8gOL
	6TjHF
X-Gm-Gg: ASbGncvAt0dHJSnboDbUUeUZFIfz/P2IdlWdUA58F2StXquVFtkNo+h42g3jqjIUfhE
	i4xBuYd4t9QmJbrxUrx5JkEFpY4yiGwLvzoeFhHXp1DHkwpGYv8Onn02mQG4HbKE6uWfsRgxd58
	6uxIr96f2O2DSDY5VTV9R1nYsebtawR6IAWNogwDRXQ4+V0KzAFfnBoC2urYHYKA88JkhThUO9I
	FNFVRVNSyS7BCRjgZy9L29BrwYgU/EKXsmluSKfo+7GRTHFIi6a8ERxrFwaZsuYbJmjSXM8cTfz
	jZMAdIOwQmBI9xrz1ndzOIMUun8NZwdM6qhVWyxYhvV7mafWoSm788qNBMlmbnazCA8Pw5cAyuw
	tGhtywev6OYYCaEzM6iA9IW7b6VYygO3BZg==
X-Google-Smtp-Source: AGHT+IF3VBrAT1QQg52sUF1h09vHpYlVLhbGCZZAZG21uGR/y3qWcWfDyr0s1pG9A79U7fkwU65rXg==
X-Received: by 2002:a05:6000:2889:b0:3d1:61f0:d256 with SMTP id ffacd0b85a97d-3d1e01d549cmr12571537f8f.42.1756903077904;
        Wed, 03 Sep 2025 05:37:57 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d0a7691340sm22526782f8f.39.2025.09.03.05.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:37:57 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 03 Sep 2025 15:37:42 +0300
Subject: [PATCH v2 1/3] dt-bindings: phy: qcom-edp: Add missing clock for X
 Elite
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-phy-qcom-edp-add-missing-refclk-v2-1-d88c1b0cdc1b@linaro.org>
References: <20250903-phy-qcom-edp-add-missing-refclk-v2-0-d88c1b0cdc1b@linaro.org>
In-Reply-To: <20250903-phy-qcom-edp-add-missing-refclk-v2-0-d88c1b0cdc1b@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1643; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=W/NXOLTDQ5i+LA/X1CrjKyPkGzseqK8+KPCSGaDzeUc=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBouDae5lOFoFOFiQfJZUcJEqKJNj2HU9ow6hrgF
 douBegDLuqJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaLg2ngAKCRAbX0TJAJUV
 VsJTEAC8Pe8fW4MBjz20c3J0FL9zup4B3QFocDrzqg/QDAiASeErbVTOjFqgAFKbfQ1mZDXZNA6
 12KUjSvOiLzIwGJ4t1OTjz8YRvi+9Cwri3ovF7cDnt34w7iv/sfPhjcOpfPSJXzU/bZwkjThsEU
 3SPhenbhSCheqt/SGPPgJ6dlHu8j7Q5LWfM8clV1POJqS3p6DxSDH3yGgHjhO1dONLG+a+W6VUt
 PKiezLPflo11YL1/E7ZTWMToS31LmUIbuFVczDdHKXozk8f3j+kweW5+Rfz/1HwnkE9gWX7Q6Cs
 lCg1AzpGQdXOFjCi7QdY3GMatXv8Hl6uUCTbP1g0Zda3pV96AXgj/gpETAywDqa69N++ij9z5wI
 Pu/bcIFXqHc5wO02oWdEANIZ8PTHzQFB3krv+2w5kH/EMsOymQlDD7KfaaPGSUsrGPd8yDYBKpO
 HrgUUrpk4PRXtzma8hUKsFHp2uI1tyRbjw9R3JpdVhKiJA12cwdfZ8ktd5ftnK3AI1Qz//Jf+hm
 rcH0dD94vvKXi9KK2GHhkVnsxT4WAcCdG617QzbzMJeEmUZ2h1q5ACQrWJhaNK3A6OwtpEJlVyr
 3HY7DXO/M/+xVZEmD4v4ANMr9qBlcPaeJRf4gtk0dDESDhTHMqEpp80zEwJ2x/Dg8Eb5OIDhkdM
 0MZFA0VxE0u+KQQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

On X Elite platform, the eDP PHY uses one more clock called
refclk. Add it to the schema.

Cc: stable@vger.kernel.org # v6.10
Fixes: 5d5607861350 ("dt-bindings: phy: qcom-edp: Add X1E80100 PHY compatibles")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../devicetree/bindings/phy/qcom,edp-phy.yaml      | 28 +++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
index eb97181cbb9579893b4ee26a39c3559ad87b2fba..a8ba0aa9ff9d83f317bd897a7d564f7e13f6a1e2 100644
--- a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
@@ -37,12 +37,15 @@ properties:
       - description: PLL register block
 
   clocks:
-    maxItems: 2
+    minItems: 2
+    maxItems: 3
 
   clock-names:
+    minItems: 2
     items:
       - const: aux
       - const: cfg_ahb
+      - const: refclk
 
   "#clock-cells":
     const: 1
@@ -64,6 +67,29 @@ required:
   - "#clock-cells"
   - "#phy-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,x1e80100-dp-phy
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          minItems: 3
+          maxItems: 3
+    else:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          minItems: 2
+          maxItems: 2
+
 additionalProperties: false
 
 examples:

-- 
2.45.2


