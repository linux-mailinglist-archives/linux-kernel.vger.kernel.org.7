Return-Path: <linux-kernel+bounces-870284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FFAC0A607
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 11:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 358FE4E504B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 10:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FE06FC3;
	Sun, 26 Oct 2025 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nn/AIRt/"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCB12F4A
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761473871; cv=none; b=PZ/SY4+bvzZm/yqYccKxlP1fynV4wwlIcqpfRAwLIUWN+nCDzk7rMrskjE9bq91qudxmOthr6x40C4o3Lh3eiOs723J0kFMIlACaJzXp96SMxseXYP48DYqkn30pLGaTTDyN3c5PiVT/J6o0Xayo05W4KJSiUwuYrlsGbZAt+fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761473871; c=relaxed/simple;
	bh=4eLCy6jFlv6ArS0sNZED+k9sPfJdSXkKtHIG4LleXkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DMxem9mZGzc4SUwjoTn3TXDQnFUTYWdhm6jJpDncqrbGZes5dWg8QaYAZBTM2MOU1g0ctmWguptIXXCc73iRyu5FdwDK0oRWxxSZ2WyHVDdElztp2b/PttNj8XjAGbRYbgy3J5pa0qEs+KjhVzwkpaglv0Qgc0LnCCgDkUq03c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nn/AIRt/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4271234b49cso572944f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 03:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761473867; x=1762078667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IZq/s0DjJJahu5RTJBwLJxq2XEK/C2uaMOs7qh3NCts=;
        b=nn/AIRt/HzybdUwLneYA3E0SbMyk3OQ2GdNs7s7OdHrp3gjg/wahGNS0nRNqdFyn4k
         7qZ5JJDVO8PskDV2YMYe9PNmw01dZrgY3l0fSDxodWtxDatYLKk7mUlmEzzv89uiYrhR
         JxZ4maY41/mYwsIZ3mfbHoyicBOldP2RmB7IA2YWF8IWZDHvwO4+SDLEiF0oYpMK1KAE
         9GvzhKVsXuqAW0QkX720CYPBaQPK051MtaE5E4CNvI65tEJpOnNLHyHY4kBitLb9t+uL
         K/TjRW8rA+usIqNiLj8hvUiYcJYg8E2aGmzrLPtuHpBR0Zeya7PbOgQ3ctAmtXmLB2tR
         0/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761473867; x=1762078667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZq/s0DjJJahu5RTJBwLJxq2XEK/C2uaMOs7qh3NCts=;
        b=mxdBcBulxcodbsWda5bUla9OKD0V69wCtVtI6gcj71dIeFkMhO9nhO2Swr5S3AKNVM
         MuDhYhdD6evvSgYMqHClARhANt6Gw2+QBAFiaMemjzt2gZpOXoNvi67+HfjAmJTmiSs1
         6DGjZKR9eH2blsJI80D2KRL3UIlUN3p5pK9SQB6AqIY3yFsVu5+dU6Jw66UCtsopbmKW
         5N59cMeYebqHX3t11mHurrMTeSoTZ19Oq/1QRlCXTk1OelrohTEAX5UCmSBp9C1WYqw/
         Jo/JmJztSJyQVK6ctUXt5AFfCBW5aXLLKsLsz9rpCDsFvStrsJZefJHzMTP0VuAljoCH
         nCAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi3qNYzMxusaniENM5c+Km30q1sjkTh/skrbnh8VeIQb69gLECeRV+dWRsvTHjhYYJrkh/HAnMEnTtFkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRbpqddZF0dhUKtkGRUssUqdGxeyiK2Jx2rqSOM4110OgRtJRG
	2k4Prd+5tHkDiX5b3zeTV+yqvEDLIVKATUcHass2eNomXG3ZOtypZlMc8YtGEFdkQOM=
X-Gm-Gg: ASbGnctJNfIHns1dlfLxn0u5vW3KypW8dvRKPGc5lQ4tXGE02Wm/hFpygpmT1M4wNW7
	xvRxc35WgUv5d2MNNdD4URGDqKE+RU3Sou+CIP20FgV4r5KtkiYaA7p0ApMhdYZvNm3TXOBmJ6r
	cdysiDG3TpzkdhUm+7kyFTCS4zLuiJMFjtg/y4cBNTUOn2351wI2gTsM4TWcTn8G7iWrIFAcCTK
	mQlWH4GK3Sp1fMg7HIVwhl8yg3Gds9yd1m6mk/Jm+76Utx/mtrddXdpf3GovwsagJfHpRjRbi2n
	ZHzRN6nXQKIpIyOYSfu8v94E2K3w6M0DvadIi67f5Dl664oaCEEYPrBVbpN9z42mKeWWZJAOeTE
	iPDJVolXyPxlaHIOzcEiKEqNeXmsZZh/ZckAoDjVPZZc3b8NTLUOaLKZGVudJYDPW6FoH3TkirZ
	+jBVnMlz0YRbA=
X-Google-Smtp-Source: AGHT+IFLV+eNu2OSqeI3IjKQUumE2rjQrLB05yL6GBy5AvpUTXb5dLnZv8q1GKaxjIshEGpVcuT/KQ==
X-Received: by 2002:a05:6000:220b:b0:429:8d46:fc5e with SMTP id ffacd0b85a97d-4298d46fdffmr4538761f8f.4.1761473866761;
        Sun, 26 Oct 2025 03:17:46 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952db9d1sm7966166f8f.35.2025.10.26.03.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 03:17:46 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net v2] dt-bindings: net: sparx5: Narrow properly LAN969x register space windows
Date: Sun, 26 Oct 2025 11:17:42 +0100
Message-ID: <20251026101741.20507-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 267bca002c50 ("dt-bindings: net: sparx5: correct LAN969x register
space windows") said that LAN969x has exactly two address spaces ("reg"
property) but implemented it as 2 or more.  Narrow the constraint to
properly express that only two items are allowed, which also matches
Linux driver.

Fixes: 267bca002c50 ("dt-bindings: net: sparx5: correct LAN969x register space windows")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

No in-kernel DTS using it.

Changes in v2:
1. Fix typo in commit msg.
---
 .../devicetree/bindings/net/microchip,sparx5-switch.yaml      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
index 5caa3779660d..5491d0775ede 100644
--- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
@@ -180,9 +180,9 @@ allOf:
     then:
       properties:
         reg:
-          minItems: 2
+          maxItems: 2
         reg-names:
-          minItems: 2
+          maxItems: 2
     else:
       properties:
         reg:
-- 
2.48.1


