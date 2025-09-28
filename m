Return-Path: <linux-kernel+bounces-835372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 587BDBA6EBD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 12:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6323BD184
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 10:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FAB2DC33F;
	Sun, 28 Sep 2025 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xn5uDOPF"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB4F2D9EE3
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759054182; cv=none; b=QUurTzpRuTsfPFqoTk8OdfkRjvpjd0yZmv2+USOV95OBTXi6TMwkblr/EYlbFibzf/EDv9dVSc1BYKTpMFoYqVTpP6Pdy4ED6+aJ/zrOPYQgkcih2ZQYMY5i2BETgf09y7czL6wWU9k1pjQDsJplRY2sYTBHHAKAxTj6xWhobsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759054182; c=relaxed/simple;
	bh=S528ed603Na9//RdBtdQJmNS/xN0stJjC9pAXnzei94=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=MN8C+uGU4TbTNgGK+7etChHGMiX9+Uumn5VwyMlZ9Xykg+sMihp3Ovs06tyQ65gQBE0ml9hvs6ndsDg3XuKoat+jd/Z0f/45iNa5e2IOqTFeuNmO9TUJqh+foa/Z8u329HC4rdoBJ17+/Ds/nBUzBOCl6SgZttNTLWYLPURuovM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xn5uDOPF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e29d65728so24170595e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 03:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759054178; x=1759658978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O7VH5GloSW9zlV5MKDiGfn6qUlpNBb/HaUQn6uAJYa0=;
        b=Xn5uDOPFKA6piUEanK357UNLj5UVlezdNh4STZ21ONDJWp5Bfzt3P0F3xOmTvgJq33
         fvTm2aLq4Qa9nQfpvbbmx9mKVvHdEmnoTTsjW12Q9qB6aVRV3fhcY1QZwO7wODI5UC2v
         OXKuk6CRBlALRFr+Cfutdvu6laSu2xAPx9Y3mRfdzMhlfOqzAYnGTqeQE3mSAGsWtZXS
         xgc8p+M7nYFjFNNmBfVK33WSDyIbvdoT4WfPXRYWCCx0HL0MmcU1X5dlLP/1vHOdAnrk
         wdkhSGYCY/w+4+uETkS5pgZrQC4w+1lh+GpMgYdWGWrDWPzPdgIjDlzdA3r8BMV8H/KN
         EVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759054178; x=1759658978;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7VH5GloSW9zlV5MKDiGfn6qUlpNBb/HaUQn6uAJYa0=;
        b=KFwC+k89ME7OZxLjc4/xTLsWxBAnUEbBtV/tIFOhakHzlvMLHJwPhQ+2T2HuECaFvd
         BlPuJ9zXnbzWq29J0B0FmOnW2ldXC/vEqqunP7v5xj8RF4mEWIkN7CH2yG3Q/qKeUhDn
         2vefaYll9fG3yKwkuI5nDeN9b99lMPjTdDVi1Vp931uMDMrtyJQI8T45LIOJjo9ouXJD
         J+XoWcj2YRZS9XS9MyV/L0lGIOGqPmJoM/sY9ey12L01k2/DG1kT8Fde8Sdr1LvqZutl
         8HB8RFJWkPy2n6IfwrqSQ443LIWfM0hK+2cV+XxZRpaMHlvqzsmBUXtzWacWUSJvvVin
         0lIg==
X-Forwarded-Encrypted: i=1; AJvYcCUneG9R6Fm/VHydAzwxbJcvxZbJ8YW6k/oboBaTWGKO3CsMyVUZQfqt4MdAeL1aQokFntQwmY9yMGyP6+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6nFu34THaw0RT7CXO330cQuhNJWc6QcdVhbY/mNWAL2f5PAns
	DGTPhOmwMGXoED56sw1Oeu1MH2ZVQ4r89XMah5poCZn+nf+0A+E/HNlh
X-Gm-Gg: ASbGncueqGjY0gEoYP4km3sn3XNbHiNgsRz4+S4BFFy+QEHw/eiM2AK4k/I1lvF8goD
	GnBi5/PdHelC/bvMV0XOSKp0su5zkawmX9n0K6Bl3iVD9Rn7TNGnFa9YOPBv0m3bZCrD0Tz85bL
	g7EhDDPpF+C0FG5pS4ee+X4t4y4sGG9S/t6TOGraZzAtWRjDGME5pd44gvm01g/EECzM2UytHG/
	vDIzQ6xGd2UnBwMkqrYEGh+AJiDOJR2/TncM4zdP5jDZ2s7gcKZzGqKg7fw7A0Ea8VMIcvC3c4C
	+LjpUqpjKfhAKjZnmZ4r3dHKDMEO4GWULq92gjMd78i40PXDIUDFwZCnctKcHstLZEKaUPedG9J
	1XbXstuxU2X80uVnSQ/h/L2fFkvvk0hkqvlrBeOEC+8sJcnyyR7TPnZ6ej6a6l2an58/421eHy/
	KqyEA=
X-Google-Smtp-Source: AGHT+IEqCtc23uR91vJX1oENcguv3h+oXK5yd4n5mW5QIEhXCja0/eHYFgJA/f94YSrqA0IKGpmApQ==
X-Received: by 2002:a05:600c:1508:b0:458:c094:8ba5 with SMTP id 5b1f17b1804b1-46e329b62bcmr82520475e9.12.1759054178464;
        Sun, 28 Sep 2025 03:09:38 -0700 (PDT)
Received: from deskilmich.example.net (host-79-36-214-146.retail.telecomitalia.it. [79.36.214.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996bf1sm185811095e9.1.2025.09.28.03.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 03:09:38 -0700 (PDT)
Date: Sun, 28 Sep 2025 12:07:49 +0200
From: Michele Zuccala <ardutu@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Alex
 Bee <knaerzche@gmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: add hdmi simple-audio-card for RK322x
Message-ID: <20250928120749.36df6a8c@deskilmich.example.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Add "simple-audio-card" definition for hdmi-sound. While at
that also add the missing #sound-dai-cells for i2s0 and hdmi nodes.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Signed-off-by: Michele Zuccala <ardutu@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk322x.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk322x.dtsi
b/arch/arm/boot/dts/rockchip/rk322x.dtsi index
cd11a018105b..a6b3c934c8ab 100644 ---
a/arch/arm/boot/dts/rockchip/rk322x.dtsi +++
b/arch/arm/boot/dts/rockchip/rk322x.dtsi @@ -108,6 +108,22 @@ arm-pmu {
 		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>,
<&cpu3>; };
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,name = "HDMI";
+		status = "disabled";
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s0>;
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
@@ -156,6 +172,7 @@ i2s0: i2s0@100c0000 {
 		clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S0_8CH>;
 		dmas = <&pdma 11>, <&pdma 12>;
 		dma-names = "tx", "rx";
+		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
 
@@ -732,6 +749,7 @@ hdmi: hdmi@200a0000 {
 		phys = <&hdmi_phy>;
 		phy-names = "hdmi";
 		rockchip,grf = <&grf>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 
 		ports {
-- 
2.51.0



