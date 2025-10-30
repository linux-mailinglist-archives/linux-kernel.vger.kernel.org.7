Return-Path: <linux-kernel+bounces-878435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD493C20965
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6328F34F2F6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C531A271464;
	Thu, 30 Oct 2025 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQaYTQsc"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386C326CE1A
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834529; cv=none; b=ER1K4rHjWOmaSxC6JhEk0Iwip25UomabqwCNL5pahAVT3oX4SX6SjEcW97mo+u3wpYIoV+PX52jgbk/ZijyDXkfLJYjZc25/L5kUngIRFC3yDNYG6n3SGQQYj3NIriHAW9USIkqVraX7peQdw2zkku2xCTZ/bIqrZi8TyJ3kU0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834529; c=relaxed/simple;
	bh=0oWG+qHo3Plj4txj6PI+E6VDdRLJWhl0rAGek1Lre2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r1iVAOeRK97/7TVKSD29tLy4AMvjWvsqupbpMKKcIeQKqZF9CgAn1V0f1rVe7ojOUZFWf0p95WdhFmE7bl4y044sJZ7hRLS0KMUWxewX7SJwUo6+URcbPkE/Jl8qlIvh8z4hh1e0gHgDeQ10KYsdQXZbSmEeMeJ1c47N365JUz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gQaYTQsc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47118259fd8so8542305e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761834526; x=1762439326; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzUB6K3HqPfS+X1e/axWNEiK+lQt69uG0iUUfrktjgc=;
        b=gQaYTQscwRPLatoH+nTHVPfNZD0s+d/BvUSWJootVDkW+2qk1lp74InCqQPo5/Kkl/
         z76owJfymZgQ0TSE2t/oaD0sEOGV7TxHraMbMMsmMqwmRpD/auyXuurOV+umnBQwFKx3
         HJmvZ2OEEdFPcNlLtFcina7EgRopGxMaiEq3fPH6Jk9inUC7cs7AIEj0YmN99/FsEe6s
         UZvBqAeHryjL38kY75olCV3ElVVpnQ8KD29qMb7IkQH4ZOZLbpQEVVf9mlarXjfgLL7P
         MflaDr5+t+HrAY+gcHtesL6YEQm/kbf4M2yw/UNLazBafYqBJLQXKCqi8J4StQuoj0/c
         KpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761834526; x=1762439326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzUB6K3HqPfS+X1e/axWNEiK+lQt69uG0iUUfrktjgc=;
        b=fVR1YLq31ESQeXQ+hkiA1OwnhLKaFmC5TxwE+VIjWMrAtCGmGU2WA0R4I1x9DKefxb
         XEwaRjnVa1idmknazaxqmtTrrv/yXi6OMua3nim/3fUwf3drGp2H4YWHbHQYkcjUU0Fg
         UWY74wQtYGzI+aLpZ1r3ib+aGltmzxR4Ne/r5Uv6EGSjpTMdwG052QT0os52CSLg3h3j
         85v7mlxuWBPmbBoxV8kzFC2MkKMxJX8RKxZS/N3KcFXTRJSajeINRCmYhp2Qq+P4QWU+
         XoEKterFrZ49ERYLNZ2nWBNnseuyLs17iWhK6Iy3RWGxzkj9OiKQ8GnbhBLDn19zxpdi
         Cbxw==
X-Forwarded-Encrypted: i=1; AJvYcCWpDs11r9MHNcaoNuvO6D+AwgotJAL3JY4jLE5KnMPg0S08enF7CjICII7PMaOglJT+E1RRwB5+j4sCQOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJCu2GcJfHGTh299M7WFQjVFOjH528itB6EfQX2+XahEdA8F4i
	87OOYE59hfK2qzhrdXOTZXLetk98vztZhU7XNBI8msFjCQ8t8q0Ebnnf+6gPE2k/SIw=
X-Gm-Gg: ASbGnctKJYsGokedr7xfRdmW3JEnoOAnfEdve6V/RZr45KOjrbTmuvjt+4NPVo3a4iy
	V8bmU/ugIvA3H+k24ug9qQpck6wx8M/QZTnocw9BOdrWFtUyE72hnr7H9kAivSetRCke3Edb8RZ
	vPbxbyISyuQpjayp07lJE+PmTmZEYRHkdMkaIA9dSFe22/3C8KFXf1FUiHHjwh1XtiCZG18h4CF
	xrIK2BIxAGnWHVATTUBY2N1e2qKBFsWcqWi4Ph1bGL+99ITgbpxgc9EHGQfSgK84UTdhUNAH9np
	BX0IS4n64FLDNLV3LAKhmBOCDYwglK3I1FIkd5ZG8pILrI6B/TpAI6cvq28sX0UAkxOwZxj/W+P
	h3OxKkCmN7kplu7LNnlPWVPoQ8dljU9gM9FXg3pnhERZE0fDgDIXwxoF0ayB6cjehnqpR2Z4U+0
	gYSmFukGG2Cfc3y5qKHUs=
X-Google-Smtp-Source: AGHT+IHDIcWOpb/AjtbKQqjQoELiWmkK+7m1rYGDSnOQyBbB8kU134OQtPTMF17uxocc9Ht6I/lvOQ==
X-Received: by 2002:a05:600c:5253:b0:471:d2f:7987 with SMTP id 5b1f17b1804b1-4772688c82dmr24022685e9.26.1761834525405;
        Thu, 30 Oct 2025 07:28:45 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772899fdfbsm42230475e9.4.2025.10.30.07.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 07:28:44 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 30 Oct 2025 16:28:29 +0200
Subject: [PATCH v5 1/3] dt-bindings: phy: qcom-edp: Add missing clock for X
 Elite
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-phy-qcom-edp-add-missing-refclk-v5-1-fce8c76f855a@linaro.org>
References: <20251030-phy-qcom-edp-add-missing-refclk-v5-0-fce8c76f855a@linaro.org>
In-Reply-To: <20251030-phy-qcom-edp-add-missing-refclk-v5-0-fce8c76f855a@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2124; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=0oWG+qHo3Plj4txj6PI+E6VDdRLJWhl0rAGek1Lre2Y=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpA3YVeRKmDq1ijkLKvUtCPBWbe/WxzMISYU7+9
 Jr4urXn8hiJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaQN2FQAKCRAbX0TJAJUV
 VrhYD/0ZHrUVpqqF7n05SDc4Uef6n6GNsYcIufBiLMZswz4FOs5rKfxc657UNdjMsyWNmPT78xV
 gH6f+t0EtSawar+qmS9MK/GuZsimyo7HHp2s21Qh/ERV3haD9q9hGSvwiVn/g62pUxExo0r+L+/
 QvagvukCv9kZyZe6P1USOEl+KM6u2S1X9q8v8at37G0sV2CQgD6GgfkuGV/EIQLNRgSgVed11OO
 IwZuTCWWghOpFPzwXERLGcScI4w4kGiqO/OYc3O7Bkuc8phNTm1BhLZ9KdesJuaoDRrMRnU+LWF
 E4iq3K05r4sM4uAa+eUINQ3nzZLgWMYIuZ2nwd5BII6zIokewiMa+hlIJfccYyA+YLWGAf4tj5I
 MWXaiwOIUT4SPnA7DhHKG23XLoY1P7KiCbsdBEfxNT/bb/oakzPk3K/RT9tVUEO8DYnwbS0Cuqh
 aPoZXyP2MW5pocy8DdpZItboh1Y/Nh5afV0rMQSIpOdJnhw5IDOK1bt3Aj3YZEiMQ+HM3r34TgC
 2Hu0Za/Epzum+wYyx1jsFuVwWPWAvUOkXyiVD8dUT1eFEFZBL1NrDZ4wTsbaoMjHUmQa5MH5CvZ
 kVq9n3+xSjP45yxH5TtKr4xPwNfxfuU1ALtPNMZfW7Iv/pn3YDSOBiez0Zv7/LoE476NUllHcz1
 hpp//4UHxmmctvA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

On X Elite platform, the eDP PHY uses one more clock called ref.

The current X Elite devices supported upstream work fine without this
clock, because the boot firmware leaves this clock enabled. But we should
not rely on that. Also, even though this change breaks the ABI, it is
needed in order to make the driver disables this clock along with the
other ones, for a proper bring-down of the entire PHY.

So attach the this ref clock to the PHY.

Cc: stable@vger.kernel.org # v6.10
Fixes: 5d5607861350 ("dt-bindings: phy: qcom-edp: Add X1E80100 PHY compatibles")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../devicetree/bindings/phy/qcom,edp-phy.yaml      | 28 +++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
index eb97181cbb9579893b4ee26a39c3559ad87b2fba..bfc4d75f50ff9e31981fe602478f28320545e52b 100644
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
+      - const: ref
 
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
2.48.1


