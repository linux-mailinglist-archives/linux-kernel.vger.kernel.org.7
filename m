Return-Path: <linux-kernel+bounces-777912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363C8B2DF10
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C67F166665
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E3E2749C6;
	Wed, 20 Aug 2025 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M8iRmPd9"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5A72749D6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699476; cv=none; b=fRniP8z6jBwzAOkuy5WiBQI93DHAKuXSXtyz/9Q8QB3IGaSDn+2ACTdmz4D6GzjJXCb+BgfVrHi6xLPJVHRH/E4j3zsCNBa3TVIknjkBALKstITuHu8jV3O7h6WbTfEuHFZuMdDNZfV2eZBIshowuaYACvm9IPm2Z1nVsQnJqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699476; c=relaxed/simple;
	bh=/izB6gBIA3K/m3qcFUJBSak3FLjzHZUWp+/J02pD0ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aGF3LSR3xNkrXkSB2MPUVTRe1ehGZ0JRyYeOF+Xl96oGktFVkp84XMGKvQBPBUZBl2z7vC+iPnTHwp4SF0KF1zzAOjt4Sp0SdmpKUm/ZAxm0knbhy+M18DeLPpss3h4vXSc6AITFCHSauo7mGa3OAJUJfzX47K1iqhzZddZxcbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M8iRmPd9; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-618adbeff22so713264a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755699472; x=1756304272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URpbi4pDupU0ar37Ye27L+XUpBCcJFcEEzJPkVZbTwU=;
        b=M8iRmPd9XszNlUoEXrBZVD41GxSBPYo79ra6ztA3dHWLh37GQl6wxsciITtLCV8VdA
         SbDBG6J6mSBXLky/TfKlEPQdof8yk6cYC3WO0emBBC1aEUwaun8S00Tn5i+6EMb4NjY/
         s4qAFtyp0VcCcMNePIFmuP58TAPKjMgBLKVkrqhDzZduR8qbdzM1Ns+AJMYlwANqwb7D
         jGzI7rOBvtNGSoXXEWo9J1BSfC+n86MN1uLOQp3lscz77iusXQaSkEPzfYfnEKiMrQky
         sPR670NLV32wC8eBq+4NVYoIdFZ8h9173vANg3eB9L6NkYNytmv0QF/QUbz39k70cdQt
         ZSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755699472; x=1756304272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URpbi4pDupU0ar37Ye27L+XUpBCcJFcEEzJPkVZbTwU=;
        b=hdBYY3bOJJWR6PXYEFYhGZVcFBgQM0HWoUgWYLpeKd7ShzdrVFC4z7czInlbpRDR44
         P8Y4P7PxCb7+bOMxE/7DcvIHPrVn8WWtUUUvPfvLantt2WO4gdrs6g2OUuv+dhq1HDXl
         tFW7MihUm07c18PM8pLIwq68vZ925LSREVxe7i8oqaYHOe/88S/v3nn5hOXjvn1aEy7U
         H/S0AZXlfHY2eEVVFJxNtdz0dcnOrg0hjqc41DH64ejSv+osPWZylV8Ym3TrlukEJBQA
         Wv05/J0AojWKHl0MilaX9jLTjDLQwOGLfm+p/EOqEvf/GSknYjCzqzBZXgw7BtY2QlRD
         gvag==
X-Forwarded-Encrypted: i=1; AJvYcCUai/dQfpu/8eyj+a0BJUkeff5XPTbuH97LcWEqLADYJ5BJszOIiXVmxo3PQ9Dy6e5lC9l66fQ3s8ag68A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3NxXLMN2ohpXEXP9dHAhDHLtmtKJz012pJcMx1SkjwWkkBMML
	H7Kvnd6yizP/fAzYclFilLdZVdKAcg5TQoLj2kS5O654kPfZ7ze5JVL6Ca/xLY0o7ZRkMqQY4RP
	5o1DW
X-Gm-Gg: ASbGncvvIl9aGhbIQdauQkAj/CQ1PmkFFfiLq2SW6ub/5TfrqeACjkYowFZrerBNHAg
	rRH2Ttcjr19L2IhemtTjbRrm3AzzKjvLxYjdROTMa4Ki0QM4+Pb8Xidzo9giFxY2/o0AHAXUDxX
	ukMivZUvdCt97whXn3aw1guEjV7wOvdCrB8RC29KnCd/tYMeQYdJRXEoOi8ecxFRto+/ewfL5mJ
	o4U7iDbPYo3g6V1JClNoFvr+Z9Y+ZSzkbdn5V5fIzwolun4rFRRkD2fheL8iNfvzz9FbV73+Lvc
	n2TtGBZeSTcs2LVaiM83YVZAb1Ht4AzLqQbh8vY1d8YjnBx777pFCT71HR9Lo1zAX5yAXlTrvGK
	+gCTem9wuybSGLpJouRAURRMG4H1Dpi7beVCbPpU=
X-Google-Smtp-Source: AGHT+IES/Jpr2bblhYPYlVvqT4FUQdP5A1r73/aT+walwE4It2pGENTB8ZRS/pZIeQZcjJUqlIBmrw==
X-Received: by 2002:a05:6402:3553:b0:618:227b:8848 with SMTP id 4fb4d7f45d1cf-61a978521f9mr1217721a12.7.1755699472423;
        Wed, 20 Aug 2025 07:17:52 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded4796f3sm186541066b.61.2025.08.20.07.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 07:17:51 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 20 Aug 2025 16:17:38 +0200
Subject: [PATCH v2 3/3] dt-bindings: display: rockchip,dw-mipi-dsi: Narrow
 clocks for rockchip,rk3288-mipi-dsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-dt-bindings-display-v2-3-91e2ccba3d4e@linaro.org>
References: <20250820-dt-bindings-display-v2-0-91e2ccba3d4e@linaro.org>
In-Reply-To: <20250820-dt-bindings-display-v2-0-91e2ccba3d4e@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 "H. Nikolaus Schaller" <hns@goldelico.com>, Arnaud Vrac <avrac@freebox.fr>, 
 Pierre-Hugues Husson <phhusson@freebox.fr>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=/izB6gBIA3K/m3qcFUJBSak3FLjzHZUWp+/J02pD0ac=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopdkHcAbOwcQtqQgqj7ZYeVzJwPpe0IzMwnRAd
 uYCfwZnO0CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKXZBwAKCRDBN2bmhouD
 1wg0D/9GLhAD7MQiXQ7UofV+rdMNcDfh8bSRGHzYgh0CW1ZfMD8B+RvKKD4E95jNLL9hAuECz0v
 ovPUq9BoXz/WW6WfgIobTk3angg8dY30rG59XdQGmsdxouZ8s7Hbn94Or3nan3LLC0CChJqBAPA
 5fSzIQMsm1rZ6cfIP/ZF22ZEHF11eMcK/bRE3Jg6+6aZbFhVQ94X0AWHhY3OezSwClM148lwnLW
 oiPop0xxBGVJqNegBJFeL3HbnVHj47geT53xq5Cg5FW7wD18sjwX1r4RutWrR2rs1E+W2W93L8P
 6zlsOQBGAG2dH4kd2NkeVGbnembzaE9TAe9eb5p3QhEafEJVo8N3E29cGqQMtr1+cu2NWckPgVq
 HuLtBwuUaYsrSKbbPc8yrLiJPcvuSKycZtoI8EoH45A/slz+8NYm+K14kDejdLFt7vRC6Y4z8yG
 Ef59nXFgGEj1IssG80ofef1C2dm8c7i6WfQvH7pMj6oiBuqGfsu7yoPTw8TIStF6jGTJMYfVc8r
 6bzMS5NlISJSmvIbMphzbZ6Rs3n6ZqyMKZzOglCbIxEYm1h1DlGO10auQm10ib6/zVrfA/pfSIa
 w1yzKXXO8Syn+jtNF1y5a44WKVMe+xSKydRTpiFZP+1+J+nToDDVLKFJwR9J8Qzh+s5FQhs9Nwl
 veFTqiQi3OAnk7Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The binding allows in top-level from one to four clocks and each variant
narrows the choice, but rockchip,rk3288-mipi-dsi missed the minItems.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Fix subject typo
2. Rb tag
---
 .../devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
index 0881e82deb1105e4f92843380c0183569f688f08..c59df3c1a3f78ae0d345dc725f4dfb3eedb3de22 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
@@ -97,9 +97,11 @@ allOf:
     then:
       properties:
         clocks:
+          minItems: 2
           maxItems: 2
 
         clock-names:
+          minItems: 2
           maxItems: 2
 
   - if:

-- 
2.48.1


