Return-Path: <linux-kernel+bounces-815849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9CCB56BD5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 21:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63FBB7A1FA1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0372E229F;
	Sun, 14 Sep 2025 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="rIc89o2u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RbV4Xuuj"
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD1D2E1754;
	Sun, 14 Sep 2025 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757878739; cv=none; b=ryc9RkdtzUezdXKZ3Mp+BXxIhi1tAMnU6P62wjgC+C+89gZCsLNjGDueKLVsFdrVlJOuFtJhR7dVf3p3bEHyWvNKOGjDgzlfrjOHEqtpbXwmcFM6/UzCpTU0j0/FSGNrPhmq7Ru7hWncGOMqXsea0HBOsC2rnXf0a5WzKBBu/y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757878739; c=relaxed/simple;
	bh=yAz8uxGOoeAELBwQQr/MUQrZttiky7faDv9NWAZtF4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9IAkAGrhjwyhIZEyQYU5oevrCx7Jt0NMymrxPxaJ4PW4vCc7vVRPysCa5hn2CdnbsCife/pFZ8i+n3a1Zf/gdZGSTkg3g4vASHJZuv9lgFvOE7eskTunq+WstETbRTZ2MtCezYdErkxAUiqmehFUQEJ/+7yc2x7GaUV6WWvx0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=rIc89o2u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RbV4Xuuj; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id BE00A1D000BD;
	Sun, 14 Sep 2025 15:38:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sun, 14 Sep 2025 15:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757878735;
	 x=1757965135; bh=ucEMkCrQGIdJ4Nevg1/Hu+/wNjfyLfIiVA+eKeRhwJg=; b=
	rIc89o2uVaJOm+ZYgrx/GrJQiamMCqQd0XMYNXzSywWf6221V046XGVOGXmPkYfK
	WAXO19Bzn/mNhZqOJ1qTTTiy3aqcsddRxzaQrCA301O1x75yZxcED5hErDF1OfEI
	wLovP5emG/IYpA9OYudC0/ZUUKO6gi9R8mH99flumNB6bYO/qKaYunArncVk0kjV
	FP/kkSpIU1zqorxI50hGmVr8IRGTZOAdMQIebcc+rVDO7dUOtXZ5Qi4Jcg1D1Yff
	Pt1Z0bjzgs395itrIgjYrgBepuerw4qcvtQFPN3IL/Ttvs4SDweTZsY0RICbyXSW
	A65H7g5m4xNFmTfumkJmSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757878735; x=
	1757965135; bh=ucEMkCrQGIdJ4Nevg1/Hu+/wNjfyLfIiVA+eKeRhwJg=; b=R
	bV4XuujsswLV1+C2zkSnLKqCRZsuP2jDcfXeAvjkaudZRwsNHN+cH0PNhMQqGkr9
	EsOZpbcmfQS96wX8GCFhsGBO2D+0MuISAZEa/gg8X+O2z+G2veiyCfgGJyRj7Jxf
	g/4ASo9P417pF3QJp1FruDt28evOtnDPVIXTUkhjYmH/Fdm4kM9aHBmXotpqXALH
	5fhPROGocn3Iw9sLoKJKiPn2UcS7rYF1wz2l8WySCyATRFuHYxldvf7DYycLV3Ww
	HQzWJKOO/RCK4rWPiquBGZLjnUhb9ig3i9vYd2Ll2kqpjpXMk07pQKXhtSE4tGF/
	zCq0KMZjlSGpUE/TFyerQ==
X-ME-Sender: <xms:zhnHaEjpsDHR4NcIsVTZrHlwbjmZNhHmN1EJEjhWhvgaig-LD4wQpw>
    <xme:zhnHaNKUBduGkNFvLx18XM25VzsugmQp5fuUkLQLKbg1LQetWAVUmdCCzW37PZ7ac
    41q5IR_XWIAnF5CyNY>
X-ME-Received: <xmr:zhnHaDge4hmjTcVONSwITglBXpWkImS_fKNaq0prLrDEEy9JrD8NANi0JeHDXQr8orSZV7pQe0Z8_CGQfEI8QpAtGZEexUtWowiXPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefheeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfgrnhhnvgcu
    ifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpeefhe
    ehieeludffheetiefhvddtleffuddtleduudeiudetvdefffehkeehgfettdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruh
    drnhgvthdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvrghlsehgohhmph
    grrdguvghvpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvghtpdhrtghpthhtoheprghs
    rghhiheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrh
    hmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthho
    pehmrgiisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiihihsiihtohhfrdhkoh
    iilhhofihskhhisehlihhnrghrohdrohhrghdprhgtphhtthhopehsvhgvnheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:zhnHaL3N00QCZPuX01YnvmVQt7cFmqU_jmG66W8I7xR80ksKr8P2yg>
    <xmx:zxnHaJiLqUSVfHtA1F7qtQfO2WB-_B_lT3Ys0jtXEzZInF3166544Q>
    <xmx:zxnHaM8E5qPDJL98IVtSwGJxODbEwSnm9aII9qGWAKrmdjsrJBRoiA>
    <xmx:zxnHaFJ5wJW5hWD5aoVh_R3Quiud8Uo1FAuzj6woNzaFtkKP6SCJFw>
    <xmx:zxnHaNzEoSnxmcj0K8p3Kw4UD_UxchKUqawnYu-owLFrlnfuBDRiR6EH>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 15:38:54 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Sun, 14 Sep 2025 21:38:44 +0200
Subject: [PATCH v2 1/6] dt-bindings: arm: apple: Add t6020x compatibles
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250914-dt-apple-t6020-v2-1-1a738a98bb43@jannau.net>
References: <20250914-dt-apple-t6020-v2-0-1a738a98bb43@jannau.net>
In-Reply-To: <20250914-dt-apple-t6020-v2-0-1a738a98bb43@jannau.net>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Marc Zyngier <maz@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3210; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=yAz8uxGOoeAELBwQQr/MUQrZttiky7faDv9NWAZtF4Y=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhozjkifDd0zgzHb7tFto9gSmK2dr3Sb0KxtzX+Mt7JO2+
 BLD1KXbUcrCIMbFICumyJKk/bKDYXWNYkztgzCYOaxMIEMYuDgFYCJPlzH8r1uTo7XifMDsf4dr
 V7co9vpdlNySt0E99/Vu78b/Hq+czjD8z7geuKJAgnO6wGaZ5FiVQ5ESp+0Xc9+Yr5n4S1YqNuE
 ANwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

This adds the following apple,t6020/t6021/t6022 platforms:

- apple,j414s - MacBook Pro (14-inch, M2 Pro, 2023)
- apple,j414c - MacBook Pro (14-inch, M2 Nax, 2023)
- apple,j416s - MacBook Pro (16-inch, M2 Pro, 2023)
- apple,j416c - MacBook Pro (16-inch, M2 Max, 2023)
- apple,j474s - Mac mini (M2 Pro, 2023)
- apple,j475c - Mac Studio (M2 Max, 2023)
- apple,j475d - Mac Studio (M2 Ultra, 2023)
- apple,j475d - Mac Pro (M2 Ultra, 2023)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/arm/apple.yaml | 39 +++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index 7073535b7c5b5ce885391699af56751241ddacb5..5c2629ec3d4cbcee49d3ff6a4db1cc8298e2a2e1 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -96,7 +96,7 @@ description: |
   - MacBook Pro (13-inch, M2, 2022)
   - Mac mini (M2, 2023)
 
-  And devices based on the "M1 Pro", "M1 Max" and "M1 Ultra" SoCs:
+  Devices based on the "M1 Pro", "M1 Max" and "M1 Ultra" SoCs:
 
   - MacBook Pro (14-inch, M1 Pro, 2021)
   - MacBook Pro (14-inch, M1 Max, 2021)
@@ -105,6 +105,17 @@ description: |
   - Mac Studio (M1 Max, 2022)
   - Mac Studio (M1 Ultra, 2022)
 
+  Devices based on the "M2 Pro", "M2 Max" and "M2 Ultra" SoCs:
+
+  - MacBook Pro (14-inch, M2 Pro, 2023)
+  - MacBook Pro (14-inch, M2 Max, 2023)
+  - MacBook Pro (16-inch, M2 Pro, 2023)
+  - MacBook Pro (16-inch, M2 Max, 2023)
+  - Mac mini (M2 Pro, 2023)
+  - Mac Studio (M2 Max, 2023)
+  - Mac Studio (M2 Ultra, 2023)
+  - Mac Pro (M2 Ultra, 2023)
+
   The compatible property should follow this format:
 
   compatible = "apple,<targettype>", "apple,<socid>", "apple,arm-platform";
@@ -310,6 +321,32 @@ properties:
           - const: apple,t6002
           - const: apple,arm-platform
 
+      - description: Apple M2 Pro SoC based platforms
+        items:
+          - enum:
+              - apple,j414s # MacBook Pro (14-inch, M2 Pro, 2023)
+              - apple,j416s # MacBook Pro (16-inch, M2 Pro, 2023)
+              - apple,j474s # Mac mini (M2 Pro, 2023)
+          - const: apple,t6020
+          - const: apple,arm-platform
+
+      - description: Apple M2 Max SoC based platforms
+        items:
+          - enum:
+              - apple,j414c # MacBook Pro (14-inch, M2 Max, 2023)
+              - apple,j416c # MacBook Pro (16-inch, M2 Max, 2023)
+              - apple,j475c # Mac Studio (M2 Max, 2023)
+          - const: apple,t6021
+          - const: apple,arm-platform
+
+      - description: Apple M2 Ultra SoC based platforms
+        items:
+          - enum:
+              - apple,j180d # Mac Pro (M2 Ultra, 2023)
+              - apple,j475d # Mac Studio (M2 Ultra, 2023)
+          - const: apple,t6022
+          - const: apple,arm-platform
+
 additionalProperties: true
 
 ...

-- 
2.51.0


