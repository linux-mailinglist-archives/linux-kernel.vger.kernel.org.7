Return-Path: <linux-kernel+bounces-837281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B725BABDB0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1AA3B609C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F072BE7DC;
	Tue, 30 Sep 2025 07:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gwKX/Q5m"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F57258ED8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759217996; cv=none; b=UCDVHLwEzTa8e/2mGJEp31T/43rp2sRkW2lFy/dML5YsQlzDz0to81w/ZUV72qjShmW3C2XX+gqa2I3Vod/8nOPzke97E+VWagMJIwhr/FMwynXy+PHWRtKGZX0Qyl1tJFhX5KPCSKZvnMUlVCGPfRRT7p9U0jG8te1qn+KwXo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759217996; c=relaxed/simple;
	bh=FkhxJ0co19Kqoym1h5+3BxapnZugQIYyqqBK98X5Rdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vg03vxRL2iNontaMMHkJvattKx2zhjV3+10+O/HDvQ6pjHbh9BcYxHUNevw60xtv5Fnr1JSDq66BdQgVxaYBLea6kWSSzRDWRX4zTicnPb+SOcKjYErXjfD1B5KlRyV7BnVyYMHchgXnFcpHfFf12NCGl49rNmfS1kTwMjYAafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gwKX/Q5m; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3fa528f127fso4340508f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759217993; x=1759822793; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bevp5VT/TRtlfJiqdXPbMhIkDrQAiY44tOo/FEhYED4=;
        b=gwKX/Q5m31b4l2pfBxAZFo90uJ2Xk8S2d96JHa8f2pEa6z94j9tbKrVEz/UC9dCwmL
         2U47+yv1/in5Zo3J7pakW15ZwrBR+LdngD0n+F+L3fnUu9X/iOfu/iKEwlwTb8dGjZwl
         n0DKpIXlMtcE65Jik4KaV5GqAWlpuw+0aGrAnDc0HE5JXNXS0ME8I+SkPSQuGzAeran7
         WjZkLFtpzHJTgAWZcJAfi0KbKVW9KwO1r38M2cQA6KtFfOu2xPc214Z3LOBJVTf8+0qi
         r1jdbnQLbUEQ/YWiFu4mMxRHBIbML1M6IDv/e1NmkAds40bB/bDuuG2xOFs5JtBsttGh
         9Oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759217993; x=1759822793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bevp5VT/TRtlfJiqdXPbMhIkDrQAiY44tOo/FEhYED4=;
        b=d15gHDfOTTuDqV7c+kaBp6+8uU1beSSdstCNlggD/DVtNDx/GUc0E270asvlpr3LaA
         LWv0G2+tpGDMvG8I2nO2tIL0GbVsYwP1D9EARcDjC9v0pLSoTBu7rp4TOd1k0zuSDTi+
         Cv1ytFjvd2CcScGrUdgkQmTUvtZwFA8x5fdkok+ElBi1LafWPj6fqSlSm1RCaJo4s3NW
         Y/USqfLQHPIET/4kHaYtn24G/47TV9f94VAPd9aICrTZ+J885lsorZfr0QwNDEMa7TAZ
         yB+xU6T3HS4OzoqCCcMkMx9P3WX75MMZzPpZoH1cpkUg6UKVzkixvtx55qFHlu5HLc8a
         eAqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXksGEEzsKUKIYvcYIydWK73GqH7D32frPXPm9RSEWQK9fMQGpz9Tzd0SpdALQKutchHpQgKO7uNpLb7Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUSOpdbhfhoiaUKWlCE4uMZUfFNr0A9q3hwaRHINJEpqqbFQUA
	c4SojyUNdFUMhox7PcRzJ8TZEMfJ4bVXtHG8eMyIfpnFQg6kC4UOQyN24Etle598gQk=
X-Gm-Gg: ASbGncsWUACuZXozIwCKrgmNB5Z/Mz2MizFINZRJ4w2pMEdIb7popNV3bAUzaKQtHiF
	BE2h0dTaIFyDgwllv2M4ZT3qEpBuu2mq6CoDNTfbnAFFSvoOiKDFsl/aK13f1JwvueKR11qozbT
	fq7weSmKxi4tOtvzYxekSlquUxddFSOENZNVtyZ8gl+rv/xKJNQYGEYwku1owIkjPswAPRRz9VS
	pxonb5jciiS0sdoohmToq06T/b9A+1txHkvEe6ZKrHqt6rsN4oq1kGqfQeieRfW0FrLUy5P3LM/
	7BKJGrUq9KyZfrHoh5VUwD8RgqsyzM5zhYt2ucAGAOPzhIYOPG+YNJu3SFnS3ReAwuUj21xiFTn
	MTbitTNbo+uOYntRrJ+oZ0aXleN1jKENevOuegq9q9LhiZJ91f7XairuWA6y3GX+vkDE=
X-Google-Smtp-Source: AGHT+IE7hIk0wvVkAHlNIuDFtcjEsBPWJOnmAhnOqI3tMojyJ8Y37GTaD7IqC3smkjWIgPnmjHUK2Q==
X-Received: by 2002:a05:6000:200e:b0:3ec:dfe5:17e8 with SMTP id ffacd0b85a97d-4240f261a60mr2762483f8f.6.1759217993068;
        Tue, 30 Sep 2025 00:39:53 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5707c1e7sm44021125e9.21.2025.09.30.00.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:39:52 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 30 Sep 2025 09:39:47 +0200
Subject: [PATCH v4 1/3] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy:
 Document lanes mapping when not using in USB-C complex
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-topic-x1e80100-hdmi-v4-1-86a14e8a34ac@linaro.org>
References: <20250930-topic-x1e80100-hdmi-v4-0-86a14e8a34ac@linaro.org>
In-Reply-To: <20250930-topic-x1e80100-hdmi-v4-0-86a14e8a34ac@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4284;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=FkhxJ0co19Kqoym1h5+3BxapnZugQIYyqqBK98X5Rdk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo24lGLsSZyGGb5W8YJGfg2/QqMxhY23dJb2LoEJ1e
 w2+0S1WJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaNuJRgAKCRB33NvayMhJ0cBFEA
 CPjn5+pwXIaZ9w2EM5eYffs0aL8n2Kk2kmge3sdfDzpy8mcRX7rE8T23AZiLAudCVDLIKxoZ7SsGtg
 FOAU78mvgSA4M7wtED4zVKZTu9Ytj2w0bbB+0ti+mcX8e/TJcPuitJ5ryzFEE00pB9rc+2zGaDhzOc
 Ce06/GOp4aDIo5zLu3rr9yjkH5ok9D+LSPX6i4i0lX55LN0BqO43Tq+d8WOaxRhDzzEUneUsZG9SJP
 T2LXBddf6ut3MFJzrTHjNyOnQ9bUaOjt0Ctp+X22ytlEG5RFWU4W0inBm1D9vDVBhdMuZA69mSWAWN
 JI0/r4lpWYXZDqgN4AstVC5F0mQV5HmJFi1ussMP040phXUOtaiMVzO+QQpSLnZN0aHqQwGKPyMy0l
 8onKaypSr6wxGGmhNdizB9/p34ir6q+8AiHeEt5/BixB//hr5/DeYhhUWVtwoHZUs5tU5jJ/STY1pg
 kJ3O+DYD70TXUePPZ7iLoFyxceB6bL5w+Xt1MMdovI2USqDe3GpYOFSXBLAyWXwDDq2BnKL8OVQDtt
 xZfqr744C94O3MZDzUz+z0Kl4ThhPgAZAYYpvRBqqxOpubOFokhhfDhRSyvfSVdbcwxlM70NYtuQXU
 518xOIlrKcIvYlBRsvVt+mJwvn0jUEkPSX7KCSMhXsjn949ot2DGQdxGYr4g==
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
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         | 67 +++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
index 5005514d7c3a1e4a8893883497fd204bc04e12be..ac9a307675bc4e86f7693ba260c75b7b88d992ec 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
@@ -81,10 +81,75 @@ properties:
 
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
+            description: Display Port Output lanes of the PHY when used with static mapping,
+			 The entry index is the DP lanes index, and the number is the PHY
+			 signal in the order RX0, TX0, TX1, RX1.
+            unevaluatedProperties: false
+
+            properties:
+              data-lanes:
+                $ref: /schemas/types.yaml#/definitions/uint32-array
+                minItems: 2
+                maxItems: 4
+                oneOf:
+                  - items: # DisplayPort 1 lane, normal orientation
+                      - const: 3
+                  - items: # DisplayPort 1 lane, flipped orientation
+                      - const: 0
+                  - items: # DisplayPort 2 lanes, normal orientation
+                      - const: 3
+                      - const: 2
+                  - items: # DisplayPort 2 lanes, flipped orientation
+                      - const: 0
+                      - const: 1
+                  - items: # DisplayPort 4 lanes, normal orientation
+                      - const: 3
+                      - const: 2
+                      - const: 1
+                      - const: 0
+                  - items: # DisplayPort 4 lanes, flipped orientation
+                      - const: 0
+                      - const: 1
+                      - const: 2
+                      - const: 3
+            required:
+              - data-lanes
+
+          endpoint@1:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            description: USB Output lanes of the PHY when used with static mapping.
+			 The entry index is the USB3 lane in the order TX then RX, and the
+			 number is the PHY signal in the order RX0, TX0, TX1, RX1.
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


