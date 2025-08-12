Return-Path: <linux-kernel+bounces-765558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF6CB239FC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587EB1A287A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8252D5A10;
	Tue, 12 Aug 2025 20:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMnuNlWS"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A6B2D0603;
	Tue, 12 Aug 2025 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755030633; cv=none; b=Sorx7HobV7Rhj2vRdtXgw8O1KU55aSokW34b9YOgSbx603A/D+d7lFovO5dkFrxNi5QArtwP/+muwI0IxakrpvHgMhc9MRfA/2cNFrLf4vnFTWc14Y0rFgVx6UwuF/1dKiLqFj/tlKHHsz35CWxY0HV0sCAdhupTEXc6qIj7Pvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755030633; c=relaxed/simple;
	bh=5E+fde8ovzmzTUceBtn7CI+O9TOIbKRLOSEfBeB3oUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OaILQmFK5RDw4LUgwdxUCxKCTXh+/UyP97FU9GhW/+qJyD5hP8UnT0ORYRT/+EofRnr+0pW/dpwBOHv3VJkjBh+l1X3BLZOIF7uqUFM/dtUAEygIvvy+moQrZnf7G2kgoJitVojVrax0Uz7bxVM+TQ0YBpBTygZbEas05JcCKSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMnuNlWS; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-af95d5c0736so918667366b.2;
        Tue, 12 Aug 2025 13:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755030630; x=1755635430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQxP4ZxPVh/0zmN8q+FGcllVOnKIVVQ6evAwUcgKqFw=;
        b=ZMnuNlWShbmSvwzR5zX/vJtlOGp9lPAZEc3kWWQd4U1aIv3h68e/f4RQFJKiy9+4xM
         lRqleTQkiClqw+7op7goIdltKjD9gja1Tw9HbtibB0dNAfEo3zbqSSAmQRXIQiXHgaX6
         ccnr0izuFZVXO72AEuZis9F8QzBgOGgxnjIbyIDqot/bX9Vz02zt2bt0GsrwDoBLvhjM
         LnT8I2e8VdwbtDWcJTJFup2F6/kMK5kqXORhLWzeR81F2rlVBNSdM6lkoq5J+IL2xCL7
         3X37YLXnlNJklDhNbXM76H7cb5omfdjTKP7+74ytuQY772B3W6nIHWJFCdXUB5NPjywC
         IjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755030630; x=1755635430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQxP4ZxPVh/0zmN8q+FGcllVOnKIVVQ6evAwUcgKqFw=;
        b=fXsoOwAqxp94pxwFerhGfMjd7j5S8u96Y9AMzGjG7IJHRn/e8V/1n9/qrsF0p6NPCQ
         3T4PLqstIK18xUBzc9ksDE4G7PJWQSusXH9zpsjbw06UG1GKlRwucxSJSg/ZXNiw0/vu
         FzvrKUYaqTm8/QAPxK4lhrAKPLvqi//lo8BZfNDoguu1cKY2ugccIIjjFlX3FLJgWDG5
         d0Y+rc4uE7P8KsdsQ+uqDw/be2pegxyCoWTk0fs73eyjMEq/wl1d65c0SbFFJmVegR2C
         ptX7tCC5rDUzTMltpHLa29NsUmtdLJkHcQE7Tv5T2jCvVdzUZIenx7yVIKN2AI3C2ilx
         +yOg==
X-Forwarded-Encrypted: i=1; AJvYcCVFgXUSXGC6I+8z8ujLuQwsnzt5vHqIO50kDJ9HBgSyIkpezJtZ8Ax4mp0c4rEu9kM7SOlhC0zCRvimZi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ZGnDT6M+G8Gd2qN7iVP8XS31r0VepsTOK0FXZjC1HH+9Xnc+
	OuWqVOusNCW6jXA0wCIl2IWYcxgwYH87pa+o+HbDDt+ZzhsbaOp937Oo
X-Gm-Gg: ASbGnctMXaDEsahVpOV+jkv9JqzEPPwl8oCw9oy3ygBLpyO1gpnuM7BRsSapJmdKV11
	DhrqUvjqzTq9hBQUKbZnTY18O6LOeu7OldOFMWev0t79zr9f1UJe9fRZGW7EpRKPWLLgS5fXhy6
	Luv6V8Ys5voV92qHMHdduMw3GWZGHICxOiPbnGZ7nc8mFsrPD+j4wJ0RydR140wcMAAY2f5sqxI
	aZD6QD3OoNOMPpF4yHu76lcjMqQR9Gkd1rq4kTBiGQ3C0PHAvmg4hHLlro/zyJAEC8jBeW9fyUu
	bJeC3iUT5uOvVL535Z711rkvT0/3OdJ5FIUS29IKJY4RR/5o58SYWqQr6qitFSeZ2UzZFcpIYwn
	0MBJkjjYmcb5mCDFOUo1Np+vYziuPVLImQbZ+hZiD
X-Google-Smtp-Source: AGHT+IGha4sQDhBjwAomOdfxTOZUbG5FQlqdvkbkrooNysCTtFOhxRuOvRoX/lUuqT8RtD0v7pbAgA==
X-Received: by 2002:a17:907:3e82:b0:ae0:ce90:4b6c with SMTP id a640c23a62f3a-afca4e94064mr55627166b.49.1755030630283;
        Tue, 12 Aug 2025 13:30:30 -0700 (PDT)
Received: from alchark-surface.localdomain ([185.213.155.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3b58sm2266073166b.58.2025.08.12.13.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 13:30:29 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 13 Aug 2025 00:30:23 +0400
Subject: [PATCH 1/3] arm64: dts: rockchip: Add RTC on rk3576-evb1-v10
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-evb1-rtcwifibt-v1-1-d13c83422971@gmail.com>
References: <20250813-evb1-rtcwifibt-v1-0-d13c83422971@gmail.com>
In-Reply-To: <20250813-evb1-rtcwifibt-v1-0-d13c83422971@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Pavel Zhovner <pavel@flipperdevices.com>, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755030626; l=1495;
 i=alchark@gmail.com; s=20250416; h=from:subject:message-id;
 bh=5E+fde8ovzmzTUceBtn7CI+O9TOIbKRLOSEfBeB3oUM=;
 b=4GfNGPMEuHD+WSnU0tE0dxfJvOveME+1Z720RhoesCNNM2yy2dYLpgN5ExP+nx6CMs4TxIGOX
 eNd/ZdrbhqAA8yX4giSRlbTIOJovEnIOfIil+HFpMrw9U07Wm99r4A5
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=ltKbQzKLTJPiDgPtcHxdo+dzFthCCMtC3V9qf7+0rkc=

Add the I2C connected RTC chip to the Rockchip RK3576 EVB1 board.

Apart from the realtime clock functionality, it also provides a 32 kHz
clock source for the onboard WiFi chip.

Tested-by: Pavel Zhovner <pavel@flipperdevices.com>
Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
index 56527c56830e3fd81855652f7bcc31215c771c0a..bfefd37a1ab8c67a17aba0cdb80980102d66bb76 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
@@ -680,6 +680,22 @@ regulator-state-mem {
 	};
 };
 
+&i2c2 {
+	status = "okay";
+
+	hym8563: rtc@51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		clock-output-names = "hym8563";
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA0 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&rtc_int>;
+		wakeup-source;
+		#clock-cells = <0>;
+	};
+};
+
 &mdio0 {
 	rgmii_phy0: phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
@@ -708,6 +724,12 @@ &pcie1 {
 };
 
 &pinctrl {
+	hym8563 {
+		rtc_int: rtc-int {
+			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	usb {
 		usb_host_pwren: usb-host-pwren {
 			rockchip,pins = <0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;

-- 
2.49.1


