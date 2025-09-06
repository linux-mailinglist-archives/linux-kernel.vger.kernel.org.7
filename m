Return-Path: <linux-kernel+bounces-804193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F71B46C69
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F8984E01CC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E50228A73F;
	Sat,  6 Sep 2025 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGBpaqrd"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365622874F7;
	Sat,  6 Sep 2025 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757160502; cv=none; b=njlcMYqjtldfVc8CpiRVCU+AyWf1W4MOPiqi6aY8AIWb4h3nlG5bPorOoasLmIw3vRTqh99K27bFO7C5H8azn8d5hitP7tb615y8FJozuI3JrfKmWE22sepFX0ouH8ENt3HJPAvl6d7RNNBwoDIRJwfKnsk03nowoO6725rtXLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757160502; c=relaxed/simple;
	bh=kiREiALNVCXeHsvYcmUgMwS7AgmlKMuziJEQPVRygmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D/b4lUdDIKRXMX6xeyc4KeswU85Vw/JaOS5yNQcocz5VyReP3MnUSTXn8QjXDx1Vs3BKRLXN99xZkaro46gvq7eO7ho0K+qN9m3UeseFjG8CPb2IYXbJP8yFGXspdqO4PgzpDuX1iqpVj08zAwsyJeQgk/sdbOVvJEQQsv22oKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGBpaqrd; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3df15fdf0caso2386644f8f.0;
        Sat, 06 Sep 2025 05:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757160499; x=1757765299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMJiDJbKP/etSvCuwnuuixi3lvLXAUo5LVfiKg0BtMM=;
        b=KGBpaqrd+W4lau51xIZgZatNxb/brJu21eZlXbwqYLdIop1yNkwf5Qnv3Vq4iqggQX
         MjGkcyPZu3rZgleOVbsj93HvDIZr73E0dydGdT2KvKf+y5foIeJSXd9hKTl02BilJd+I
         UcVBKUaz6ot2i7waMwV/3nMtFklMFo1dk8vlt+j/o3IwaIBybiQWkXCJQTtSLfNSDEnG
         EPcIs5d2qrs+3kYBHqlTaHfzQfLObtaUEBpDMSHrLNSXRJtzwLrac2V0zlC+XiTOtNPS
         CFSCnkLkAPHIgIMf5eEgpT8SssOZxCZhtLkA5Bx7XI8E9igaRTVb/RdPr2dzGpJQEkvF
         XVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757160499; x=1757765299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMJiDJbKP/etSvCuwnuuixi3lvLXAUo5LVfiKg0BtMM=;
        b=oltiP26XLin1VdpOtQhmivt3A9HYGEuX9hFFaWkXt4m8y8c/4A9qOlQUywRP8oRBEW
         F6W1B57wiGEw8R+vK6+gYu36h8yHcqyUk6tVazI8oDMchQcYSusWYnt7VtgxnFB08CPo
         gVQ1cUr7ObkK7GT1ZLUvCjMx93kSBJKY2zxeCVKXm/PPjVzpiVILKhwDOtYU5D9eBSlJ
         TDD0Wx0EeguV3dYMnfaUJf0CInUEtrg21cbH8Z3Ufp5RXl3E3IRs6wxwy8AeOrcVSOHH
         VuQwe85eLVTTvhMO/v6CpajKqZA20Ey3cizTEhYSIlaJfaaiSEM7BT8x3dBVbuoYSNU3
         Kmcw==
X-Forwarded-Encrypted: i=1; AJvYcCUuZcXtxBRY0bv6G15EQdS/pQnNW1xJwNnYK/laWQRe3TM5tHnx6F4Czo/6RqHIAXhKWF8VGBynRYQ889kN@vger.kernel.org, AJvYcCVpIfOlcj6NVpVEbvtRsKkCSKmX0N7dE1EmTmRFQlqwH5KG0+8/jvWVDC5NtXhix8wJeYBXZLv9CG2X@vger.kernel.org
X-Gm-Message-State: AOJu0Yws4AxHZB76ss9NooD2QcsaiC8umMxjzZO8CuU046+vzmctGI81
	QA0mqwSuYY3qTYRY/FdDpyhn8XVTC6LgYWNiNOa/9jmoKzDrJvVuFI3p
X-Gm-Gg: ASbGncvOtorei8y6u650wgd4BsYW2LoRBk6AcEmoyt89R6ItIdMg1+hZCsosuX475i7
	/upzERb689lFv6PIvgw3dO1YR4H9boQlvU7x8iwQ94wvHv3wWUNhuBibxeBsNR9yN9dUgcMj/uO
	Ni4Lw2bkh9L/k72Zs31KplijxAq+Pj4UZlXUMPKJWNpzaHT5S5mNjD+6Ug70bTgt39p1o244xYR
	qCfGuO0O/K3Az0bjn28pGnvN/G8vyLjT9eTNUbzWRK3M7uFTe+Z9QK8GDPhT/S/E/KceU+TiVTr
	cUZXJMm7GbCuy7r+15HDxQ1RQHW2b7f6LLJWBga6wg6zS2/XSuuhNadsOdqilcH0E2c5YkpMQOQ
	HaSEF2JZEXZzt7F1TYWeirRSsONg=
X-Google-Smtp-Source: AGHT+IHBJYiQh+I1y35iAqJpgfRb8U4m0E/9PkidxB03WfHyJamTMIisTixcjF4m3yIucg+v2jdCiA==
X-Received: by 2002:a05:6000:2005:b0:3e4:f71e:2d7e with SMTP id ffacd0b85a97d-3e64317ccb9mr1420659f8f.23.1757160499394;
        Sat, 06 Sep 2025 05:08:19 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd058ed5esm60978455e9.1.2025.09.06.05.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 05:08:19 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 2/2] arm64: dts: rockchip: enable the Mali GPU on RK3328 boards
Date: Sat,  6 Sep 2025 12:08:10 +0000
Message-Id: <20250906120810.1833016-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250906120810.1833016-1-christianshewitt@gmail.com>
References: <20250906120810.1833016-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Bee <knaerzche@gmail.com>

Add a gpu node to the rock64 board to enable the Mali GPU and
move the existing node from roc-pc to the shared roc dtsi to
enable it also for the roc-cc board.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
Changes since v2:
- No changes
Changes since v1:
- No changes

 arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts | 4 ----
 arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi   | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 4 ++++
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts
index 329d03172433..c0b7b98ff788 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts
@@ -44,10 +44,6 @@ &codec {
 	mute-gpios = <&grf_gpio 0 GPIO_ACTIVE_LOW>;
 };
 
-&gpu {
-	mali-supply = <&vdd_logic>;
-};
-
 &pinctrl {
 	ir {
 		ir_int: ir-int {
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
index b5bd5e7d5748..7eef6f7f108f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
@@ -160,6 +160,10 @@ &gmac2io {
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_logic>;
+};
+
 &hdmi {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 5367e5fa9232..592fd8ca21df 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -152,6 +152,10 @@ &gmac2io {
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_logic>;
+};
+
 &hdmi {
 	avdd-0v9-supply = <&vdd_10>;
 	avdd-1v8-supply = <&vcc_18>;
-- 
2.34.1


