Return-Path: <linux-kernel+bounces-744898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EA4B11248
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73955A7579
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2841F265CA0;
	Thu, 24 Jul 2025 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ADsMoe9B"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A938B246BA1
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388729; cv=none; b=e1Sc58+gO5tbYjKXwbFOANszxe6ryqjuVEpNFJL5L0ADLV3YijbLbbt0rXNxvrxNm1pf88dk6o5XNcKbJ/x1LhzFiA6xwLhsKdXLubRgzrD9rBOEfxAl4/06ji+mIVlzZZAShI9dHMdssHHXllq8WuXNBRUkU48iv+qHgMaQuFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388729; c=relaxed/simple;
	bh=MXcjaXpjv7EjaAY7kMP4uQh7uHeIBr5NeRkMjZEmHFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOvK3sIFsbzGj/XfIL41U5MSwBK0kjogRLNVbSK0dQUcrnKD9GooB6hbevz1+WYYo569nG/hugGRKXdID5PAzjW6MxJ6cBsFa2lE9ChJRiyU+gkNJTBADkmJwZ+hgc5zw5qulGsAQ1nfNw2lFQNLFa8DLHHSt24WQTyYcG3F4hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ADsMoe9B; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-87c0bb1ee4eso36944039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1753388727; x=1753993527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZU8vkaDk2qb4Gs1NhAs//+b9ebi++Ho3LYwlzWZCXY=;
        b=ADsMoe9Bf+nSQNW1jrgtHmKCBg76PqfVI7D39/S/Cery5pwaQ+Cwmpq1L5aHsB9lMS
         vG0R8G90JCvJIKfBWAxehBNuCoOYimdxouTy+t4yt8J45dSCFveh45xHSYnSs7XT5aVc
         Xx7QW4X02BRqkSXz3wZ0johLBHch5zCsjLbnEPSYRaFhEmb20qYxSK/R04OZHSgwiMEh
         JC11u1TF8ScfmfDnolzf4QDBs7bGZlUFsd+5jBeUfA//UedoMywRas0VKOysWN95i/p7
         m+7uCp9sEbVo6hg9f5Zaa3sN4QDnzhHibyZX0Jo1uQBRwN9rc5m8bibi7/f0ZYJH4k1b
         4BFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753388727; x=1753993527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZU8vkaDk2qb4Gs1NhAs//+b9ebi++Ho3LYwlzWZCXY=;
        b=o4Zu+UqhJtaZW9bubjbZCNf7gjaiDp5hK/TxMoqKJ7BSKIa9L7HxlN9FghjOYAQUGj
         6prXXE0cCa7cbUEc99CKBeJSrsp8TnVhis2Fu+aRy29u0z6UGoj2vMXrQCwpALuGCRzb
         5UWcnHqRxSgI4Jtbti01xZK3QgpcgRxb1Jxc6zozJ5B39xRc2QMnmw/pX1IziytBtcyg
         As4+PcUy6zee0aSHXu1T0ihroeZ2xUXWz1yJNDH+FA5VjowpocXP/b1NxY4MPP7d32dK
         FNmhNRmbK7oa2U25C0aG3ZrMs5tnVknKL6GDFeJuIBoUrcU+9npJm1HXZhhQtK9ydx+G
         4buA==
X-Forwarded-Encrypted: i=1; AJvYcCUf4Q0Nfk/PFidoJimInj+DOVimOFjaFlTi2qBhqYXvITkkscQVJjGmqx1kHTFE5VUGw/S/2jTnwjcuDpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx86kDonrBG0sIIfLvMs1GIIRGJ+uaPmc6qey9fUPX+VF8918ag
	guMocqOQ+GTYBsqASU9u4hcf7PeYh+N7hvrFcjunwv9qGZ55cRZmOl0TTQK9uTizloQ=
X-Gm-Gg: ASbGnctUYixGQvdzM7Rhrk9ju3P7znpVPGRRdr8fUaGPfpQa8wxsPGPjwwKjPQWtKju
	jc6Za2VF2lZ5u6UQJxnJ/Yheg2NKs/o6trU32M0owPNxXBe/hvuDGfm5SYbDPK8zxPCqLJP/HtD
	TKCy1W0MH2P/+Z/JOtzXbXRDLpGOCna0uUKQM9yoDEvjE8uX8exX5oDacLYXL4P1MqlDuq07XxQ
	gF1R/UFOAnTpgusQPntG2L6047XKksbE0zmFHLJ8jMSWMlUp5CC+iXbWCLOWICXhYgA4Aq9tLhN
	SpbABtG6lHT+n2O28zN8mg7jMxgDYRUJPm24q+/1opPzKkT/3WxVGA6az87gL0uyXatVDji4pQK
	1teiXMhjk8jasHdW/X4V35mmQYgF5jsC7OkifyKtC7UoLrL/QbdE=
X-Google-Smtp-Source: AGHT+IGsD3HwADo3Oj0KCwtP/jsKopOJoqzhN2wHyyLonxBBo4A1qnAS9cZXjozcGyBbHnw7RWwe/A==
X-Received: by 2002:a05:6602:358f:b0:87c:d3b:a358 with SMTP id ca18e2360f4ac-87c64fdc182mr1615756739f.8.1753388726816;
        Thu, 24 Jul 2025 13:25:26 -0700 (PDT)
Received: from zoltan.localdomain ([199.59.116.160])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-87c74316a3bsm63080239f.23.2025.07.24.13.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 13:25:26 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: lee@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mat.jonczyk@o2.pl,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux.amoon@gmail.com,
	troymitchell988@gmail.com,
	guodong@riscstar.com,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 6/8] riscv: dts: spacemit: enable the i2c8 adapter
Date: Thu, 24 Jul 2025 15:25:07 -0500
Message-ID: <20250724202511.499288-7-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724202511.499288-1-elder@riscstar.com>
References: <20250724202511.499288-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define properties for the I2C adapter that provides access to the
SpacemiT P1 PMIC.  Enable this adapter on the Banana Pi BPI-F3.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 15 +++++++++++++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi    |  7 +++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi            | 11 +++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index fe22c747c5012..7c9f91c88e01a 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -40,6 +40,21 @@ &emmc {
 	status = "okay";
 };
 
+&i2c8 {
+	pinctrl-0 = <&i2c8_cfg>;
+	pinctrl-names = "default";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	pmic@41 {
+		compatible = "spacemit,p1";
+		reg = <0x41>;
+		interrupts = <64>;
+		status = "okay";
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_2_cfg>;
diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
index 3810557374228..96d7a46d4bf77 100644
--- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
@@ -11,6 +11,13 @@
 #define K1_GPIO(x)	(x / 32) (x % 32)
 
 &pinctrl {
+	i2c8_cfg: i2c8-cfg {
+		i2c8-0-pins {
+			pinmux = <K1_PADCONF(93, 0)>,	/* PWR_SCL */
+				 <K1_PADCONF(94, 0)>;	/* PWR_SDA */
+		};
+	};
+
 	uart0_2_cfg: uart0-2-cfg {
 		uart0-2-pins {
 			pinmux = <K1_PADCONF(68, 2)>,
diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index abde8bb07c95c..2a5a132d5a774 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -459,6 +459,17 @@ pwm7: pwm@d401bc00 {
 			status = "disabled";
 		};
 
+		i2c8: i2c@d401d800 {
+			compatible = "spacemit,k1-i2c";
+			reg = <0x0 0xd401d800 0x0 0x38>;
+			interrupts = <19>;
+			clocks = <&syscon_apbc CLK_TWSI8>,
+				 <&syscon_apbc CLK_TWSI8_BUS>;
+			clock-names = "func", "bus";
+			clock-frequency = <400000>;
+			status = "disabled";
+		};
+
 		pinctrl: pinctrl@d401e000 {
 			compatible = "spacemit,k1-pinctrl";
 			reg = <0x0 0xd401e000 0x0 0x400>;
-- 
2.43.0


