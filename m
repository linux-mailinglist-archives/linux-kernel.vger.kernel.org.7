Return-Path: <linux-kernel+bounces-805869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BDEB48E9B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C771B26A74
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA0130BB9A;
	Mon,  8 Sep 2025 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XHmaNLhz"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CCA30ACED
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336671; cv=none; b=cK8mnsFyjpMvfkFhx5nq+5BC9vBtRMdnprqK7+47NkWbus+r85rUwfwHjJplt1w3IGb6cUiWKBxJp40uk+Dz7NTTrwPIXGY2j4YZh+C315z/Xj1MtqfukL933PUvxR99LUSnoBgIOJQBQT0dUkF551f5EVVjOA+O4GEFxxMEt1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336671; c=relaxed/simple;
	bh=l4jGjPnr6kkCLH/MgyK2xCnnHwY9L5KdNaTbIaLUKls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jzUTmKUnLeEch8zFfjlzLE2sgSxnpzPPDxT6cRqZoxZTK3pjd1Yz5G6wkAkN5WLsizeuDhpCIrPYEbFoZ0b0TCCMCYPhpoybXeK8xO7Wm/HDbD0+zQFpVJEzq8vNuE6oz1XLaeL58wmHWmzMzCmv16mAcWxbtA4N0ok0n68H3Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XHmaNLhz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45de287cc11so6357355e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 06:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757336668; x=1757941468; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3lH/JWdCi466yT+Udujas8igi6yje6X10bcnQeYQ7U=;
        b=XHmaNLhzPH5wA2iONOJPrMN0Ojd25JBC8LMiitfMj+xo5jU6j4UhMXcTxqcYINmzYS
         hN8FJOGQyhVcG7MdK+fQbQMe4tTQFTHXCZW7xs8rxMy6YWtH0eTwQ8SjHw16qKzjxPSQ
         jsLsSU2JKlObioa2fcH7eW1mcbS3bhhRlOQZcXO78EbBKdv7zqVp0vxeH/NYmiLyuyRm
         j1xjmQTdQXED4Jhk+3AAW9K/uN/kUpJI2ovB79s0jr5OvsblMVK/o/8AHJyoQyJoobMV
         6V4k3I5iBrv86Q4iJx6NQ4CFeKtH1/lDFtCDBgIJ0Y+ZOucWPb+UiX3E2fImYeMnfgjw
         EWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757336668; x=1757941468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3lH/JWdCi466yT+Udujas8igi6yje6X10bcnQeYQ7U=;
        b=XdwbxRh9wsI6mwkK11twrESWu+ZOKgeHGK7yUWFwGGWu4sHqCx+hWVrZp19+w6aUA2
         h0d4xm2um1bsrGW1scFzJIxcxBDi3MkNpXZbEF6xlkk3fBqM8hk3KBtxxSP3XtdEL2YA
         MaSEKwnm5l9aizIARV2mGLNtLf/0pRHMoQi282FAC7XG0NhhJi1wKsYNUEmG7UW3XAuo
         wOW06oIypQI7rujDFBEi5WLaSKL2O6+ps9CTW0aDttxGsQRKvFqacPNqXglORa96DT4x
         phxosTp9J3I2LLJ/v++GzIv+Q+kWFSr0hs+0BZ7TK/sHdCNqlrNYTPugmn73mMQQPgMG
         EqCw==
X-Forwarded-Encrypted: i=1; AJvYcCVAjiMH7FnNi6K3ApmlgGLcoqdTz1trL81wFO6gDMsuo485Dwn/XlWadhe8jmh9JVYUC329eN/J0yWOxqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytGA6mm5H+VqO41zSwlyZw+sKNXgG4oDSwd6fBQaA3ZQzbR88p
	SHL1Dh0pE99K1tGloB9MmeCF5KYZCS3Vd/4pCqtnUSL4a0958Oz2NHeIqrqy5D/KWx8=
X-Gm-Gg: ASbGncuFuU+AUawtJ7nunV/W9K5GAK/dk0ASPPcDGsuR+BuzbmS1OqEDYE18Ux0pijI
	WFQnA306o9V9AbaoAmZvwt19DWuWhYGqZu6WuMMSwJth6P7JJz0lln/WH24h9kfsYnY1tcpjvXM
	xcSVApH6cbg6k4WKzViWFygk+PNv4sX1DPrgldj8OLTbLwTWVJFfZiac+Xj0bOrHF3eJ35JLV8o
	GT3Wf5J45h8zQsPv7u32gJOoSLBEkY1vCcTx8wFPTmcXwVPVG59UU78WCj+7hKFJYk4a7aq+que
	fYyoHzwE3R0w04FC1vL3RksCVS1gDqdhdUakrlVzYAMsScpD5+UcGPDQzQnOzGozlvS7552TWoj
	tVKTzRmNHz/wHesqa7OuGY6l9LUBtnVvv/bRbLFPeLAVW8fsUeq5VwA==
X-Google-Smtp-Source: AGHT+IEoCJMvrySbDq5jyk5RqjV0NPwALftNDE3q+qWzdFdOy/QBMsqqG1w+PllPiaKresF5LY8s5A==
X-Received: by 2002:a5d:5f42:0:b0:3bd:13d6:6c21 with SMTP id ffacd0b85a97d-3e2fa64c720mr11205775f8f.0.1757336667919;
        Mon, 08 Sep 2025 06:04:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd6891d23sm145632475e9.4.2025.09.08.06.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 06:04:27 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 08 Sep 2025 15:04:20 +0200
Subject: [PATCH v3 3/5] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy:
 Document lanes mapping when not using in USB-C complex
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-topic-x1e80100-hdmi-v3-3-c53b0f2bc2fb@linaro.org>
References: <20250908-topic-x1e80100-hdmi-v3-0-c53b0f2bc2fb@linaro.org>
In-Reply-To: <20250908-topic-x1e80100-hdmi-v3-0-c53b0f2bc2fb@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3818;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=l4jGjPnr6kkCLH/MgyK2xCnnHwY9L5KdNaTbIaLUKls=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBovtRWHuZlAgozjbJFii6xfRJsDGdI6qiUd5eBIkOO
 gHg1sbqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaL7UVgAKCRB33NvayMhJ0VO0D/
 wN1IoFM+6iDMczeX69C67hBvvLtrQstZFRcQP2yOXqNzF+BNoOKcHNvVJwlesJ/bhhkmogtc/gYBG5
 4XN3Nh8lpDkzzH0uHemVY143GefTfB9r2huYqAUa9QQS+PHrWvDRPrsZnTlkqgim9ETpSWSY5XaaY3
 H75bzT+NVggBudkNCaMUgqU5MTzpuftNb3q80bQDgNCuzrKdNCwqtGGQ+4GGBKYJvXI/TMHT9tb88A
 zk9Qg7hq0kDunLwjNODM8+iMRPqDsi9VenmJUejjO/4Qv0Id4+4c8SXMx7xNDCGcdmy4X2PhUD+/vZ
 tuBuhdooBoUTXuL1IsBaqtg40K9EUY+pwAlTGfZr4WROgsgdmJ8o+VMsdj8bC3fGxTSAo7d/0H1gpG
 fI9wHZbMZkgvxbFhCWedjMDD0lRymsX9FR6z67Kg24aW7df04l62Sinpn7G+v9f7CwdtqY2z3RruP2
 prGrPv1UHPtK0RYzkdBO8ZNpO82TRCla3tvI79pzi4BQLnM+BkqLiz9IL2/phpG6YpG+GDThG3E4EI
 bUnLnZdlap7QuzJ8beN0t3zc5VHCQo/FN0qn0pJpBow49cDWzRVgbHrJr5i52VwvkUhge/6+4782Nk
 Mrd94O2dUWbZKQtUnToaTfid3nnf2bZZOL0lei1dE1+cP+ZQaM7bYHHRczxg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
of a combo glue to route either lanes to the 4 shared physical lanes.

The routing of the lanes can be:
- 2 DP + 2 USB3
- 4 DP
- 2 USB3

The layout of the lanes was designed to be mapped and swapped
related to the USB-C Power Delivery negociation, so it supports
a finite set of mappings inherited by the USB-C Altmode layouts.

Nevertheless those QMP Comby PHY can be used to drive a DisplayPort
connector, DP->HDMI bridge, USB3 A Connector, etc... without
an USB-C connector and no PD events.

Document the data-lanes on numbered port@0 out endpoints,
allowing us to document the lanes mapping to DisplayPort
and/or USB3 connectors/peripherals.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         | 59 +++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
index 5005514d7c3a1e4a8893883497fd204bc04e12be..51e0d0983091af0b8a5170ac34a05ab0acc435a3 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
@@ -81,10 +81,67 @@ properties:
 
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
+
     properties:
       port@0:
-        $ref: /schemas/graph.yaml#/properties/port
+        $ref: /schemas/graph.yaml#/$defs/port-base
         description: Output endpoint of the PHY
+        unevaluatedProperties: false
+
+        properties:
+          endpoint:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            unevaluatedProperties: false
+
+          endpoint@0:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            description: Display Port Output lanes of the PHY when used with static mapping
+            unevaluatedProperties: false
+
+            properties:
+              data-lanes:
+                $ref: /schemas/types.yaml#/definitions/uint32-array
+                minItems: 2
+                maxItems: 4
+                oneOf:
+                  - items: # DisplayPort 2 lanes, normal orientation
+                      - const: 0
+                      - const: 1
+                  - items: # DisplayPort 2 lanes, flipped orientation
+                      - const: 3
+                      - const: 2
+                  - items: # DisplayPort 4 lanes, normal orientation
+                      - const: 0
+                      - const: 1
+                      - const: 2
+                      - const: 3
+                  - items: # DisplayPort 4 lanes, flipped orientation
+                      - const: 3
+                      - const: 2
+                      - const: 1
+                      - const: 0
+            required:
+              - data-lanes
+
+          endpoint@1:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            description: USB Output lanes of the PHY when used with static mapping
+            unevaluatedProperties: false
+
+            properties:
+              data-lanes:
+                $ref: /schemas/types.yaml#/definitions/uint32-array
+                minItems: 2
+                oneOf:
+                  - items: # USB3, normal orientation
+                      - const: 1
+                      - const: 0
+                  - items: # USB3, flipped orientation
+                      - const: 2
+                      - const: 3
+
+            required:
+              - data-lanes
 
       port@1:
         $ref: /schemas/graph.yaml#/properties/port

-- 
2.34.1


