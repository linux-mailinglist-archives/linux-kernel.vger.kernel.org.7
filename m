Return-Path: <linux-kernel+bounces-822435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35039B83E25
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3A4F7B83DD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1174828489B;
	Thu, 18 Sep 2025 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAZq6h5X"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE0B284688
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188625; cv=none; b=mtq9g8hMMaa0FLMgJcc8vElBCw7NBI4v8jNiJGAJjobtxDujpKYBrvjSNs3ciMk2uwG+sgUK8lsDhIc+Y38ozbw4wxRZn4pvy1aYIUDkYXZgs0AMBIE1KgNjwe28rIpEA2jPVZGgdr99Tb+dGNo6tBUg9LJe5X1CtJYf/Lz3YQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188625; c=relaxed/simple;
	bh=nVDRdbCkjgVW2Hem9dJFdrSJ8lRD2Z2Fl11Ez5/qXTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iZ5XJoPJaUHOsWcww2VM6mbNRzrPS6olqhX9dO2taayzxaP7v/dmWBP4T6WNpGQrAqR26GiAYvdb7PVUVk2mtr6YqZ3IIorSWVlmVhsbr2Qc5gShzit/TC4XyVgTwnBwJnJ4N46x0sTnU1nk8n9yBvi++5UZAQ8DCAB6kUjfPIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAZq6h5X; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32ed19ce5a3so555115a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758188623; x=1758793423; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kk2Hrw+IHUis21BiwjLiEv7+4Iu+IibQiFHb8JNRLIM=;
        b=CAZq6h5XSuUQXePYMbyb123UdBdVdAEcateXVkE+od0Ab0yqP7yLKZ6NjYi4o37efG
         NMA3NMP+5I9Jl0WtuZAcj77tZWr+MCZBhY1ktC8HFBn2QRKnKRgdut6eVkHx41DP1ilg
         h7PEFWLbd8Sv97MoxcIDmfQJGvzPZ5fX9kCfOLhi4NfGeykgnhGugAqQysyWWvlAFfcN
         IrepRVkZaGGHZETVDJ5PEpONKJM8bIErSAeRnKfS66Mv+hWy2HPd+BAIE3n7Ri8hjXAP
         JX9GlFZchE4YGp5PzJi0xOWGimYHrKomyQiCzwmFJo8df81TVwOe8YyoZ/ovASZhQI46
         jwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758188623; x=1758793423;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kk2Hrw+IHUis21BiwjLiEv7+4Iu+IibQiFHb8JNRLIM=;
        b=dK3wliQ76CA/9Ps+80dFZ72Sb8bc0rsQg/55jgZFjhj98uMEObIKudsaC+S1ZqsIAv
         m3n/3tlQukoAVwF4HZMcAtfnRQw7s9xIGM1O7bcLX3Soy9JOEhx+z7QkQND1cVpbIJDJ
         E+eLLbidmfD2u+DkzMwOXfnxRzN4gf93m/o17G9vugUZymhPRaEYgplXofeLT197JbGY
         kUWlrt5DV3g5L0xzZxgqgRDYI2HAQyBs4uLymULfQRD/+MKhEvQlYV2P5DX0zEudGfF+
         HxPiO0LYo7AsAKhvxCqdMxyvgdcM//VN1ugNjdKZ2fKH5oEdWNAkyl2TJrfGRV3y5dOl
         BHbA==
X-Forwarded-Encrypted: i=1; AJvYcCWoCfDWWf3wItXlumn8qWczkIGmfmJl62BYJKck98t7G7AglBwb7KKpPlIDHTUtpDSF7Bdn3OJEOUHmXL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCoLL9MyrffTetQ2p+CMZaLjXxsbESqYJ/lOLtDDNFLXy6qXFK
	o48LZQ/3zE4/nKm/VWguG7oW6CAnJb2SOGEOcVDoTZbZqpq3bdt9ct0M
X-Gm-Gg: ASbGncv9Y/0RrQV7eWAEf1HXgD9oDpMOyl1Qdn4DbYQ5Jwh3RwYoBZGIn5u/NeXUwlD
	n5prX2x2OEjqcr9eLQh53CGEqPzXxoGDlJZjl7ZLz1yejCNA5Wmdq26d3ieQBDK8ozC0KqReXsW
	ORqy7InoFecsDuAOeE18iVaCeF/9tM2mJJmxrJFeh/2DBcofPVS8jcgG5a9dAH/+oyojYAVgP0T
	cuhpUERUurD/AFFir6rNW0W0k4NJGG4vpiScfrIBzhSrqf28te/UhTDbViK+YlpYqgYLYHlwHs8
	DM3b81nYHHksf9W7xAe0iwo9sE9Le5ToNSrRMaZr+ODuL9kn9CGSr0XRpc8dzU+iYY1xMtunGfn
	RJNDigdJ7jiWHvJHnKop/tl2K5nVvYfb73xQ5vVHbA/lrx4Nrpv8/Gl6U6eVfqDctkDpVRI8Sjn
	MceA==
X-Google-Smtp-Source: AGHT+IEgGE0BeH1F+4LDtstgR4GzT3dQ/vnKSyQ7aIVQt/aTAyZb2ZsVJWml9L1MieY7rFzbad5a2A==
X-Received: by 2002:a17:90b:4c12:b0:32e:5b07:15dd with SMTP id 98e67ed59e1d1-32ee3ec22b6mr6516497a91.1.1758188623083;
        Thu, 18 Sep 2025 02:43:43 -0700 (PDT)
Received: from [172.17.0.3] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed276d2f8sm4886810a91.24.2025.09.18.02.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:43:42 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
Date: Thu, 18 Sep 2025 17:43:06 +0800
Subject: [PATCH] ARM: dts: aspeed: clemente: add MCTP over I2C support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-leo-dts-transceiver-v1-1-3e2580325edc@gmail.com>
X-B4-Tracking: v=1; b=H4sIACnUy2gC/x3MQQqEMAxG4atI1gZsZWD0KuKitL8zAamSiAjSu
 1tcfov3bjKowGhsblKcYrLlCtc2FP8h/8CSqsl3/tMN7ssrNk6H8aEhW4ScUEaKvUMfvQsL1XJ
 XLHK912ku5QHFt0+wZQAAAA==
X-Change-ID: 20250918-leo-dts-transceiver-edc31e3c21af
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, bruce.jy.hung@fii-foxconn.com, 
 leo.jt.wang@fii-foxconn.com, Leo Wang <leo.jt.wang@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758188620; l=2154;
 i=leo.jt.wang@gmail.com; s=20250618; h=from:subject:message-id;
 bh=nVDRdbCkjgVW2Hem9dJFdrSJ8lRD2Z2Fl11Ez5/qXTc=;
 b=gGwy/tJbdh92kaL3iGxdJ0l55f8lVj/pdra8VUU6oBnNsmqeDhiUPxiVekZn/UwIGlSAduWaT
 s65s9f5gLsNBz2gYwdLOzqRJ9FmS9d3xS2QLQLwQXoz1a7on5CCimYt
X-Developer-Key: i=leo.jt.wang@gmail.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

Enable MCTP communication on the Meta Clemente BMC board:

- Add an MCTP I2C controller node at address 0x10 on I2C0
- Mark selected I2C mux channels as MCTP controllers
- Remove unused "i2c-mux-idle-disconnect" properties

This allows MCTP devices to be discovered and used for
management communication on the Clemente platform.

Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
index a614f947dafc9a6628c3f3d45b62ff3ca9d2b618..a2f0ed6e7bbefbdcec33f7ddebdf2de62adec164 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -269,18 +269,23 @@ &gpio1 {
 
 &i2c0 {
 	status = "okay";
+	multi-master;
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
 
 	i2c-mux@71 {
 		compatible = "nxp,pca9546";
 		reg = <0x71>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
 
 		i2c0mux0ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
 		};
 
 		i2c0mux0ch1: i2c@1 {
@@ -332,6 +337,7 @@ i2c0mux0ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
 		};
 
 		i2c0mux0ch3: i2c@3 {
@@ -457,12 +463,12 @@ i2c-mux@75 {
 		reg = <0x75>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
 
 		i2c0mux3ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
 		};
 
 		i2c0mux3ch1: i2c@1 {
@@ -514,6 +520,7 @@ i2c0mux3ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
 		};
 
 		i2c0mux3ch3: i2c@3 {

---
base-commit: c65261717599d419e9c683d85f515d3ca2261549
change-id: 20250918-leo-dts-transceiver-edc31e3c21af

Best regards,
-- 
Leo Wang <leo.jt.wang@gmail.com>


