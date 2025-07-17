Return-Path: <linux-kernel+bounces-735420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B51EB08F16
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11520A628A9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390DF2F85D0;
	Thu, 17 Jul 2025 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xlsaWxi9"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D086C2F85C3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762158; cv=none; b=UcsBM2YLdx2hCwPWG6PguFlvLHjuqE4QnTGhatNVnGyw1qRFMreqWYM9TUuc7/gJVHQyC5nkZ89m3vPL4dnKJc77zuPPMl1Gsi/9BMrGGH2qT8bFP8u499isRicUNf6diSi5gZaXCuVT3uxJa68GuXziv2SRME6P3uMo+KktX7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762158; c=relaxed/simple;
	bh=OH4wrDfav89XkdNsE1p0BQDzGHuGj2x+JYSvAAX8m3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RvSCUytt6qpKeCkceo4sQjEXlUrYiMcgbxUHGAY21uyUeHUVJX3rzxO4/8/FOUdT7Nt6R5XbGsMrE2K2ucroB7pe4db1F0hYrM1ArD2IzDhvIbgV3G1rJQapFHH9uSAEv09WSPyZ0vRUt92lG3C0E7NQ717n3KVBaqqg6w5yYuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xlsaWxi9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae3a4b3fa38so19358266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752762155; x=1753366955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzNSUPnzBkKdR3mW5wA88jSoaUKRv7J/6KX45+OJCEo=;
        b=xlsaWxi9O8W8k51M3yMHxlN9ZQAx3290Ehzb64ILx+L/VnQi2t/uBABmARvXYcu6NM
         QIgsswDQ/KQYpicVmNLRdHRm5GOSSh2SRaXI0jdUPdf4uLxL4In04RxmA0OnNb7gYAs/
         7lKmOjHed2PcQ0pJ8/4YmYRDb85IIsfrW1P0h5x+zNjatpaYQLc5Z3M5B1jpHje7+/KH
         Pc2ExdUGuJofu6WFzk7zf6UpbsZDN7aVjehseVgzy9mAJIkX5+bbRgm69P6dy600aeZM
         NCijeNyHYO0mPcKtgP+5pc0g6qqmQdKQQrR5trgWLHdAItjNPt5zWUC9ajP6KTIQNsTK
         o63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762155; x=1753366955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZzNSUPnzBkKdR3mW5wA88jSoaUKRv7J/6KX45+OJCEo=;
        b=dmXQvtny9bkIpCFQMq1bOPtDnH2hTdo88bFBTFYIRbjTTHsJE4e1nsuSeGrJF9spl7
         1mSTSndOdiGdEqiGas6MHUA56NCChnGR43WqvMDmgrmMowKhlGvq6itVKR3ohu49fjft
         Wvt2t91TkgdGVKzPAW9NPlZ2sbWsGC7ZkKhjzTAmwnNp/ef7xFJozBtlYLBUlPIbdtFU
         eUaPIys6he2roB852iR072ONlwxGgZkTF8yJ0pOmJM+aPXgqSat5+Gr4ZrshW3Oolb2h
         7Fc1g5zMapQ9WjRSGW/8XMUNk71SyhFcKFNtmUXb3WJncC6aWqeDwqhxa0wsSbWM/cgO
         1Dwg==
X-Forwarded-Encrypted: i=1; AJvYcCXi8lYYVEBcaFYUBHI/YYDU6piXCL5yh6yp8P9scFm9DHT8COhMwQ/cJm6NRgBopuTrhFQVRt7XjH0tR9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYCbDGoXCrqGJG55+Mo5Vf/otPhlbO0wdFj2uzLT+QonGj+fEG
	7zn2L7B15rlBrlr31g8epZGta/ofIU88wTmKi1orE6n6qtN5MQPFtbSXIPAza4Hmqyo=
X-Gm-Gg: ASbGnct1O9M6XSXIqgkjsgXztH6xg5DHjgy7spN3Rn6kFmPEx5pxb90o7wZkl6/FeII
	hpzU08oiAKi3IOlVnw9g/rybIdPy2tPp2U3/QabOAjlRXGX1uzoyq33zvk0Nwcj11F/Uo6M7EeX
	9aIPu/YCY/9BaPjs62u8LZkduKicoRDglWVRo7jpLO5XkO8SIR5EcecYBqAdW77BdT3BA5QVIz/
	fyv27icOwT4KoJ+fPvIoB4s5TqAd0364nio9wKGPbUxd6O9AufIj/c3PD1rJtGYIPtuauZMLdDq
	ocqm+kw6N1k1O9Z8gP3qa4S8FTXW/DnGlJ0rEULCnIAzYhUvC7UuGM9E4BIpptspBVJYvJVM7Eq
	YghFMaHuVtggYZxIF79rfUN5plzZ6e5Zw
X-Google-Smtp-Source: AGHT+IG1+74iXCF3EHn6v+R1gCnqSq7/v8FseRyLjKbV9H4v/JXHyiAaJgnSRbcKuMka+iOoDn2N6w==
X-Received: by 2002:a17:907:72c8:b0:ad8:9207:b436 with SMTP id a640c23a62f3a-ae9c99a0f28mr261270566b.5.1752762154888;
        Thu, 17 Jul 2025 07:22:34 -0700 (PDT)
Received: from kuoka.. ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82e3a8csm1379333266b.154.2025.07.17.07.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:22:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Tony Lindgren <tony@atomide.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: ti: omap4: Use generic "ethernet" as node name
Date: Thu, 17 Jul 2025 16:22:13 +0200
Message-ID: <20250717142212.92333-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1385; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=OH4wrDfav89XkdNsE1p0BQDzGHuGj2x+JYSvAAX8m3o=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoeQcU4/pS61bv71IWPMnOqEVyfmAQdhNqJGsd1
 Xeya8hli1uJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHkHFAAKCRDBN2bmhouD
 19IjD/9qbG1sGKejcxxyfQtCjdj7pECUhqmNjsxjo05Sb57GTglnGbl8sd5s45fF6LXh7/FYn8L
 6bnTv/xa70PBMtvfjmvBCJwp5ipAptLRXCW9oG5gEP/KWqnZhkclU4Nv1euWv0P9M9T7cvZlMng
 cIVqMV67MaYVKIUHxEcZFAl3mVw1gnZQUlie0iaVoKgh5mi8MriaZkP7wnrKkzG42gtT66LT+gB
 6JNkbUMWm2CschRyB0tN82rBuE0buJFlICyZhbZCp2I7qMUAgRCsxwTl1yb0T6kKnW+5ZnjmehX
 dbvCWjy5J07YuUYPgnhrKkkoxamE98iK4gTdIsqrxK/L1m2mKztSz1bHdah3ipcHgiTKx+8R6J+
 OlGD6+xJFBWGi5J6emkPNrqLIf0a1n5/PYrwbVqHY2loEFeND8KkFAVkaG85meogz4Qg9+zAQaw
 mCY4EL8gRcekWxxitpBhQLjsq/Pk+U0jnG3akQsR5qsPKnNjlGlS0WAVdNW49I44xSQ6Gf9Mmfj
 GFzqwK7Ooq/3rt+ieNGiG/nhkvPacZf02SY0iRsBV2O902Lprvg+CE+OF9sVyxsUaT93w37q/2J
 LCAKmIiD/FCXB12uoWms7wL5AqJePnsi9y4yUxEIvA7ZXnB1dgp7vrsoyWuLRKiY1vncdQ5UT/X JjPkCR07dI3rK5A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Common name for Ethernet controllers is "ethernet", not "eth", also
recommended by Devicetree specification in "Generic Names
Recommendation".  Verified lack of impact using dtx_diff.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/ti/omap/omap4-sdp.dts                  | 2 +-
 arch/arm/boot/dts/ti/omap/omap4-var-om44customboard.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap4-sdp.dts b/arch/arm/boot/dts/ti/omap/omap4-sdp.dts
index b535d24c6140..b550105585a1 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-sdp.dts
+++ b/arch/arm/boot/dts/ti/omap/omap4-sdp.dts
@@ -467,7 +467,7 @@ &mcspi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcspi1_pins>;
 
-	eth@0 {
+	ethernet@0 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&ks8851_pins>;
 
diff --git a/arch/arm/boot/dts/ti/omap/omap4-var-om44customboard.dtsi b/arch/arm/boot/dts/ti/omap/omap4-var-om44customboard.dtsi
index cadc7e02592b..80e89a2f8be1 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-var-om44customboard.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap4-var-om44customboard.dtsi
@@ -194,7 +194,7 @@ &mcspi1 {
 	pinctrl-0 = <&mcspi1_pins>;
 	status = "okay";
 
-	eth@0 {
+	ethernet@0 {
 		compatible = "ks8851";
 		pinctrl-names = "default";
 		pinctrl-0 = <&ks8851_irq_pins>;
-- 
2.48.1


