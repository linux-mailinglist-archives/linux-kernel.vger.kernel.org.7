Return-Path: <linux-kernel+bounces-861371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 981FCBF28E0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC1B74F8CC1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAAA3314C8;
	Mon, 20 Oct 2025 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o66pUiPP"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BE0330B39
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979158; cv=none; b=Wv9OUrAXDket5RyQFYA8yCqyq+Xl0GVkrjGOTxwP+1e1/bTy9zn974ICj5HLJQKUGCLl/rnWJg31c178CBjK93J4MbNZQF2wFR2gI922qI6aAKACguwIy3fE0QWHB0bxxRUzfPIVeaMxUGQblGIBx7m9yypGnI0jDlxfoKXju3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979158; c=relaxed/simple;
	bh=WV3J3Sb8RrX8e2Hd8SGcSuELHFxUU+MYrkFn/KmEcFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dEwIscUDorAp+qq2rGCDwAIj1+nI5EUYdgHeWicnRAriZdSh20XL7xh7XV9OxDp4XaVckRQ0+7pIeDP6bq90aak7SNkd9ZKeizsihJSIOzSbngu1cF7tJCDi7u/3frXpeidvh4zyt3VSno1gzkZhdVUrBFoQkrZ1U/S8JWdFl4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o66pUiPP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4271234b49cso409461f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760979154; x=1761583954; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnU84aG5AA7OlaDbC8ewfHpg+G11vcSgzAUdP3VTwAQ=;
        b=o66pUiPPZkSK94MNWruRqkhkpyi0cvt9Fy51ds2cmHWNFcwYpVb6PwYo7IfDPZ4Qc0
         66A7NN7C5Gd4wKgAFCxbY0S3vkSlKibBJTs7GwYXACef1sCnh+z11U+9KbWsCULaNJBy
         eAQnexGGPLNGD1Sl3YHOmAz8gH5UzH58+4PRLY0NPg4gx4/cgHxMJ+Gbe1prNb80/1Ht
         pjnG2PORNhbNM53DlRt7StjYOmglT930wydXlbl4fUuCeIClaPJUQe0w5nNWDQn3OlHe
         W6tQxqwScQgtrUG/Kk4SGK0NKkPqc3W7EX4W0ucVSkj8T0JbrkuIrbNOC2HTmlGWfYNw
         SI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979154; x=1761583954;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnU84aG5AA7OlaDbC8ewfHpg+G11vcSgzAUdP3VTwAQ=;
        b=u7Ebv+Y0b76KPr7dK+vbrpa5bFyaV9Bo3CIf2pDqmKh+tQ+tg9ZQgnSyCATOzTADp6
         UJZ3wSgvUHfpEapP69aoX/GLX+PDPOn26P3K0ee4QfoYwZ4gZElJuFnInRdMF5BsN/r6
         Y6MCF48uI2nus8Der3zZ/nv99OdCUbjilajD4GIpX77DCJZxhh9uoPNNcGiL5e2q1fVK
         pxTATCmEUnFsiW4KqxdMl0/UeJ9iPrvIAmInswyhMd9rtrzIUAR3ferI9cLpCqgpqPzw
         X/8FkPDER5mdcEcuU03CeeA6yA+KI/up5PrF0e3l7QlZo+5A80coPInHIyBieEu9M/OW
         nYRA==
X-Forwarded-Encrypted: i=1; AJvYcCWd2OJRza6vm+6JTN+Rzv+Mo7syHNECl6f+VzBVQl+Fre/IS56ZoEf5p5boR4qS8jg3kNzkStBn6+Fm12g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkpw8OBiWvHXMlcEgiHhEkpGhYt/XlfT/u6wwPnB7se0Ftb8/2
	EpkW7PZxkx4wdoZ7aamn2VOAjNm256FuJ3M/lqjCGsSM5D3awSjXsuwHztc2WinjOYo=
X-Gm-Gg: ASbGncvqjlNaCsJtqxpTevNWbnJuEjnmJV4aM559NzAGIJuMJn0SYiZkO9JlrmMz9ep
	7ALIt987yLmKzeKQIMUZPGU5Bmzl/ebrpC6/JlOjgegT2+PGTLpWPsPgpy098IQrU/oWGvcxZDR
	dqizb6LZCfqs8YSJtZX12+3TEa4Ld5MDARXgha98gX/X50HI7B6vasDF819KHJHDJ24KUCkFcNm
	rOLB5hf4F1jncimEvKPSY5bQBbv3W0U/TwEsfARi6/i9RXyBQ+MrB7NUPl9E3PNYLAsnODu2rtu
	Emrr2vopzru8889qCCga24OsPXpTFxBZyEAwJJDE1MTeKWH0iegEHCjrC3EAL+k7coUtsp9G9T4
	VMJAKT78L0ROw0tBUX1oboocO1Sq3WIiNaHtegu/G8SVYxM4nud9Qkas9wpExbs0d+Tc3ozOIxW
	yz4oCdKw+5hkdsAqcx
X-Google-Smtp-Source: AGHT+IF+PYBZwEZy8pbZN8kRsdKZQq2AcpQfnMVlCxQFPlEkzb/myAUyLd2oWEemkGVrfgYsbSowoQ==
X-Received: by 2002:a05:600c:4fcb:b0:471:c4c:5ef with SMTP id 5b1f17b1804b1-4749437b584mr1865315e9.4.1760979154529;
        Mon, 20 Oct 2025 09:52:34 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c82c9sm238324695e9.14.2025.10.20.09.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:52:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 20 Oct 2025 18:52:22 +0200
Subject: [PATCH 3/3] dt-bindings: mfd: rohm,bd96801-pmic: Correct
 timeout-sec length and reference watchdog schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-dt-bindings-watchdog-timeout-v1-3-d0f3235eb327@linaro.org>
References: <20251020-dt-bindings-watchdog-timeout-v1-0-d0f3235eb327@linaro.org>
In-Reply-To: <20251020-dt-bindings-watchdog-timeout-v1-0-d0f3235eb327@linaro.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Timothy Pearson <tpearson@raptorengineering.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1261;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=WV3J3Sb8RrX8e2Hd8SGcSuELHFxUU+MYrkFn/KmEcFc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBo9mjL3LkGaBxEvHYAXDvaeJbqP5XIgRGfzHbA7
 IQHAsPDzsSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaPZoywAKCRDBN2bmhouD
 1x11EACVw+bJXMZS0LEH2JcYcGdH/0utiWamyWWmZSP1oFAGZ/h6iDr4dMoPJf7hhE0jxp7cQF5
 YSGB3Ob8o2+LwOjYTdSqyUitEC8TopdYh+K8QtLhrJs6hTjNILM9Qc+oufmHqk78jDp5qYCqtyC
 YoMJcJeRIi/6sF+0lyvDosG5B5hTvM32i1PnFwZTv/EL9v/b+x+pFaIYkL8/ac63oqDshPbaFSx
 IZzpue4l9Ph2aWQm/dRiUjjA1j+kxPG8+cxhHbnXXG/8adnsYajuulAMiVhbfwuHcHfLfCJsagX
 NCN8HZXTNBuuS/26I1OlmoBPRfGJ5Yq2w70YiOiruJ46bSDMM2GM/rrWDafKIi4my3+8u/SK6Oz
 CfMnaaU0WX7n3/lbz2kEEIzrMg2AiT6OhffFb/ViE/RaoWjXpdcdPFGiW55N0Rf3A2clnMKXebO
 JjlI98ni0THoZdVrFbfZjcL8+Ez+N0mkwDzla9Tk2nZQ/X4xwgTRxsy8uUwMG+6k0EJ61rYsyD4
 To++LZTBB/p1+rKJgpAAkaXV7Z9TIOr4LL7k1HWiJYFlTziLg0xWk9COA/0ki2mVpc0WNVo4arX
 x0s6zovbCAPh+D5SJOKRtAHb3xRgWPBZAhamr1DPTkDbNQuRSqyUWrpk5rpZl3Xy7Qo5ZRzZxmK
 Py6jWnzSf1vk0JQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The parent node of ROHM BD96801 PMIC is also holding properties for the
watchdog, thus it should reference watchdog.yaml schema.  OTOH, the
timeout-sec property is used only as one number.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This depends on previous watchdog patch.  I propose to take entire set
via watchdog tree, with Lee's acks.
---
 Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml
index 0e06570483ae..adb491bcc8dc 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml
@@ -57,8 +57,7 @@ properties:
       - prstb
       - intb-only
 
-  timeout-sec:
-    maxItems: 2
+  timeout-sec: true
 
   regulators:
     $ref: /schemas/regulator/rohm,bd96801-regulator.yaml
@@ -72,7 +71,10 @@ required:
   - interrupt-names
   - regulators
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/watchdog/watchdog.yaml
+
+unevaluatedProperties: false
 
 examples:
   - |

-- 
2.48.1


