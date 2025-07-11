Return-Path: <linux-kernel+bounces-726841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E51B011D6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31B47625C7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 03:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6D81A23BD;
	Fri, 11 Jul 2025 03:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpwvT90u"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079201A0711;
	Fri, 11 Jul 2025 03:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752206351; cv=none; b=qmsbnzZLW61QIl5p54sLB0zDnvxmjHpLOY7urSF9a+YqUSjRD38ouaLQ+nh2Q9c/FPswLLNArLXemNxoc1U4/d21KLtD05f7noU2zQRkDiw+y91kNkbcahbI6QSxvMJvQceZfwnImtUuI6dta/DljgrulIe6S0/yguTlBvrt0NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752206351; c=relaxed/simple;
	bh=IVBiCayxxjuIoAWf7fWUyLznf6nyKVFK0/CzMq6+NGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJpK5M9IsrDOay0c/OlLlSuapCOBU5ejKx/6TBQZpr7m2Y3sQWRzAt3/AvVj/ruAG3HesrfO5dDI4v8c+o7Ae2EXo06+RFCFSVkYl8TcRmRLvQQmhrgRbXE8FIFOrgmZyJrpL0DD0MUBA8I2Lt9le8EJnZZqp3YIObR2MLfs0Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpwvT90u; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-558facbc19cso1386267e87.3;
        Thu, 10 Jul 2025 20:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752206348; x=1752811148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85nfx4ldL54wSVT5XtoQ/mvHVV77q6rK3dhp/Wa5E+U=;
        b=JpwvT90uqyA+JHdclMjZdyyjF8w2uNYeKl+HOewcUTACCSUvTiswH8tamvRbeWMa7S
         1IzE7PF6LrKiT/S0nxIqMId8PQEY+RsBIRP3l6v5h+ZZypu2Xefrz8+9CxBk5us2DK61
         tIXCip8dRrZGyQk8OU5khARCKMDqDt0sWLpi0JwLnB2a/vfjdpDpD+Ih2eaoUcZmUQjt
         ea9FOvFpU8GDIl3UIxbeI0+B4F5R/QkI3NNEj5YF+1zCg+twBso9OVmRLsvZKXGxXRn1
         Y79+1Um5WpHcPTX4IaSE4IM4IhBauFjxsGWTTOYn5xJG6MfL80Q3AF0X+E9/pDgRt1nm
         YtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752206348; x=1752811148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85nfx4ldL54wSVT5XtoQ/mvHVV77q6rK3dhp/Wa5E+U=;
        b=qXYdFOD8wtilTYBo3Iu4h2FU2iPDGBaeOUlehPxmcGL0vzI70UBRVN+SGgU2OOh9ou
         mfxcsS2m9UEjDmI2SS4wndXV7ZPXyVY+owEii8TysDfCogRnnygXOLx8LdNQRo3EZ8ih
         8H4VKr06fqtgHE1+e/AkPAEiiKPJiujWSjS2jbl8RGLlBWrPLJ9VpzwtXHYQcXxulqMH
         rGtJTWlypAdiIZQ8fI7pb6JTc+0F3dWeTsQtLNLQSGF3cmRJFzwj7JkaQBAiexIlMJRs
         3pGKhXGqDc0OL5oPglXE7AgulzEep0UACXW6U7/Ggd3uHmNS5Uy+Xd4GHOeiGwtcy7Cd
         5QLw==
X-Forwarded-Encrypted: i=1; AJvYcCUhbWwoHGGiWhHMoUCtoiUyvaqHQpIFyfYTlcJjij0OtfjrYDkwGXdBo2J+E4EpeqvR06TXRI4XQOMH@vger.kernel.org, AJvYcCX56wA4dSvHyeSbYc9FSe8tnXoiy/IUOJSTTjfmQo1E6plMkUgbfInwHX7pIwOOFWH4D/V/zjQ9yLFVRmcr@vger.kernel.org
X-Gm-Message-State: AOJu0YxjFg3jZVD6fXawsOhKJhs0cHvsXTq+lHNZt+6Ufng50v9IavP2
	1wY0VCF/+2ad6kWIJm1VPAzZxFFhV5RKU/Vqfu9REnp82gcwZ9jdEOpA
X-Gm-Gg: ASbGncuk79t9UjZLfbZWlZAhLX5WOxN5vB3Wq5KlNF1ze/Qx8q5THc8Iidz4fRQCs3U
	pycqlCLuIrxAXrDoVyNwLjqLRPOG3e24STzVe6Ym+EkUOaxiY8UwpGpggAX6I25yulEJcT2Z+TB
	a5Lz531tY3x6/nOAAjudhrrTS52VuuzbZd1tNXzBD3RBJAysMEfv4AIGKc9Q/3+m+Wn4gNQZvVJ
	EAcmNl9H4ZKVlIrIf634UJ0LIQdpSCoTVuJayz5npjkC/qGuxrAXhcAlU63Ft46dupycWOkHlrq
	T7+45m4JysiXlGKrc9N1uZ3r9GpXVDaRJYOK4PBW4t7wLUPcVRsTVmoggMxhTy7ZEsSY2qSt1Ns
	h2X+a9ycYt80=
X-Google-Smtp-Source: AGHT+IF2Vs2taWbckoiIUXDCtLJBtsJW8Ugy8fMUOW8WzA36Et0dLFCN8dorIxDAVjB7GGJ88bp0Fg==
X-Received: by 2002:a05:651c:555:b0:32b:7ddd:279e with SMTP id 38308e7fff4ca-330532dfb0emr4152281fa.14.1752206347958;
        Thu, 10 Jul 2025 20:59:07 -0700 (PDT)
Received: from junAIR ([212.192.12.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa2943d46sm4971191fa.40.2025.07.10.20.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 20:59:07 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.or>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v2 3/3] arm64: dts: allwinner: a523: enable Mali GPU for all boards
Date: Fri, 11 Jul 2025 11:57:29 +0800
Message-ID: <20250711035730.17507-4-iuncuim@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711035730.17507-1-iuncuim@gmail.com>
References: <20250711035730.17507-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

All devices based on the A523/A527/H728/T527 processors contain a G57 MC1 GPU.

Enable the DT nodes for this GPU and specify a regulator that supplies power
to the SoC's VDD_GPU pins. The other parameters are set in the SoC dtsi,
so are board independent.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts   | 5 +++++
 arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts    | 5 +++++
 arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts   | 5 +++++
 arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts | 5 +++++
 4 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
index 8bc0f2c72..553ad774e 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
@@ -66,6 +66,11 @@ &gmac0 {
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdc2>;
+	status = "okay";
+};
+
 &mdio0 {
 	ext_rgmii_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
diff --git a/arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts b/arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts
index 59db10354..a96927fbd 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts
@@ -54,6 +54,11 @@ &ehci1 {
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdc2>;
+	status = "okay";
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	cd-gpios = <&pio 5 6 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PF6 */
diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
index 142177c1f..b9eeb6753 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
@@ -76,6 +76,11 @@ &gmac0 {
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdc2>;
+	status = "okay";
+};
+
 &mdio0 {
 	ext_rgmii_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
index 5f97505ec..d07bb9193 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
@@ -95,6 +95,11 @@ &ehci1 {
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdc2>;
+	status = "okay";
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_cldo3>;
 	cd-gpios = <&pio 5 6 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PF6 */
-- 
2.50.0


