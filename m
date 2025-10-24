Return-Path: <linux-kernel+bounces-869435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F4FC07DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0727D4EC29F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9E72877EE;
	Fri, 24 Oct 2025 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="24um7Qmg"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ACD36B996
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333368; cv=none; b=Qzrgiize5uCQlcQVC6+YGafwcaSGQe/NwMfzZTQAygTmtMmcmc0ZBJwDPxi3cgd1MKz4S4kz20FD5zTkW/O0gpk85eW2IAheSF3enRky8fbIEQRa7iX+vXpKYACeRLW+y5qZIG7a9qvvF0IPuiObXkYtSayiY4zIlNtqIY5megc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333368; c=relaxed/simple;
	bh=BzKRuhxyonoQsuopPQdi/8jOGmwxXgdxHX/BXxXKdik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mB2m8N6pQVCalScTTxuYep1NGedW9N7mFq/i6eKO6yAlflFVjnkOdkNin+aJJW3TWzVKadW4EYvv9p9DNIHNxd4yt60nWIhz8U3Lb0ho4RbG4M02Guz0Y+EeCBMIuf+CTMNDIMag6OonTZZJEScZpZuVIwWCUjX7uh7vkWm+kxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=24um7Qmg; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-430ab5ee3afso22587905ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761333364; x=1761938164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdMeTbCiZFImBLpdSseleACrRi7JJpgsujeJgyCXmeA=;
        b=24um7Qmg2nxiYWlMR8xIJb0z6Z75ImokSNSFUIVGvAgXpmRX/jwFnIOR52dnexIbX/
         PGNL2eb2EyqCynmDktxH8xmYDnzruesk6eXOgGs5NSryaH+3ymajb0im7WTdM0ZuCDfU
         HF2d4e6ulGrdA0F699PeAuZ4fea3QDldiEC9gPleizqbtrLAY0Z8sqjKZShPWi3e82k9
         LxLE+rnJoHC/26Zwa7QQSXNahrrO9py0XdHr8RCrf/bUAyFTDSq7ajgG0SW23vIdWNXJ
         8D69PjJciApI4WzqObCyW3ems8mcgD+ynocfuP9KiFHGsp5YLfp6aCB62ruXuEe6Ug1G
         ly6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333364; x=1761938164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdMeTbCiZFImBLpdSseleACrRi7JJpgsujeJgyCXmeA=;
        b=jBMnu+wN3FXLbhaCJ2PEK15ry6Z4Hm8SFLsREzgaD3TTBldEmmbVrk6hmiUjhbmZNi
         OMs+ndc4xKqc6H4ov2dUTGNXiRc7xfFOMZoHteLMYXFSmUPeajDvPunPnU5BiMiyT9Rq
         vbSncP8jMIkr2/mOZSNu3vEvWEgo07W0jC//Kb8SCtNB/7GQf+l/3fjkTN6W9LIIH2yy
         +Wlug1EytxZlJ5n95R3cbJOonyir5SbSdkR8R5c+Jrp65XuNpPKa7hsbu4yRANitRIWX
         cWqakQNNdtHzXGMESEsXnAQ3AGZy8E0k85du7ctjWGj6poBPn6xGkaA/Af6l7F8xLX3z
         whBw==
X-Forwarded-Encrypted: i=1; AJvYcCUyhVt0f/F1EYaJemVcxpplonk1QmVlFA6qbT2g6gbfnCCrr4NO4EQXQdYKp9424xQZ+A3d6A2sJVuhckI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNgQ+Q541nHaffKJgO19wiDyvl1STZedg9H/Yew3r1DHG4ePZl
	6cSqwUAudSwe6vcRklY2udMSZERLT5QtXZ1gTeA1YVvAK5zUXNRoETuWmr4fxvKmisc=
X-Gm-Gg: ASbGncv0/czZnifF9G62dOW2l0RpFNqOKdFAc/AfYGY29pDyHnkqq7/iPwa4z7FEFnv
	6C4MaE9T61JfKslaiiendkg+qmAbEf2Q2iI4FpCXdzKWGol/OSqwttn7TKExs70rxLI6WFVbirV
	jH9yWzyEgS2VqkYxBD3okj7JsdrGE5mlHvh511pRE3/vLbuoYi9iLXd20BlgVi8IaUrKHDYUwba
	Bs5SVBs+k3oQXl2Z5ntrazb3+Ih2/05hsKEAQAoRffEKVNsdNGPRo+4IFZKfjroIU+Ysxj8iQYD
	WouaIGTJiy+VvdRohxODet/8JbUHYyOmLryfeXlaacZsRNSx/HkQ9KO0JouyXPx9w/n8XlQfJx8
	i0s7xjD9Q0TkqcJ1+QyRp4vYvLG/KGDHCJvynzIokeFNvw6W1lJMTYbpjkrJQjfH92QCLivuk7l
	pVTZ6v+zH+IdbyEJ8/XfD4nrL5AQDCKiaMkO+zxIyvuMo=
X-Google-Smtp-Source: AGHT+IHdac+yNZmM0pe7fb5MedOFJ085tc7Rho0L92xEnV6VaHpJ93hLc5aHoV4AFkJA7fa9m7wHzA==
X-Received: by 2002:a05:6e02:348f:b0:430:b290:b6c5 with SMTP id e9e14a558f8ab-431ebf86403mr45545195ab.30.1761333363919;
        Fri, 24 Oct 2025 12:16:03 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb7fdb7c7sm2427824173.44.2025.10.24.12.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:16:03 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: dlan@gentoo.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: Frank.li@nxp.com,
	guodong@riscstar.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	devicetree@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/9] riscv: dts: spacemit: enable K1 SoC QSPI on BPI-F3
Date: Fri, 24 Oct 2025 14:15:48 -0500
Message-ID: <20251024191550.194946-9-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251024191550.194946-1-elder@riscstar.com>
References: <20251024191550.194946-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define DTS nodes to enable support for QSPI on the K1 SoC, including the
pin control configuration used.  Enable QSPI on the Banana Pi BPI-F3 board.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  6 ++++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 21 +++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 16 ++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 33ca816bfd4b3..02f218a16318e 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -113,6 +113,12 @@ &pdma {
 	status = "okay";
 };
 
+&qspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&qspi_cfg>;
+	status = "okay";
+};
+
 &i2c2 {
 	pinctrl-0 = <&i2c2_0_cfg>;
 	pinctrl-names = "default";
diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
index 4eef81d583f3d..e922e05ff856d 100644
--- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
@@ -73,6 +73,27 @@ i2c8-0-pins {
 		};
 	};
 
+	qspi_cfg: qspi-cfg {
+		qspi-pins {
+			pinmux = <K1_PADCONF(98, 0)>,    /* QSPI_DATA3 */
+				 <K1_PADCONF(99, 0)>,    /* QSPI_DATA2 */
+				 <K1_PADCONF(100, 0)>,   /* QSPI_DATA1 */
+				 <K1_PADCONF(101, 0)>,   /* QSPI_DATA0 */
+				 <K1_PADCONF(102, 0)>;   /* QSPI_CLK */
+
+			bias-disable;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+
+		qspi-cs1-pins {
+			pinmux = <K1_PADCONF(103, 0)>;   /* QSPI_CS1 */
+			bias-pull-up = <0>;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+	};
+
 	/omit-if-no-ref/
 	uart0_0_cfg: uart0-0-cfg {
 		uart0-0-pins {
diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index af35f9cd64351..47f97105bff0b 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -823,6 +823,22 @@ uart9: serial@d4017800 {
 				status = "disabled";
 			};
 
+			qspi: spi@d420c000 {
+				compatible = "spacemit,k1-qspi";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x0 0xd420c000 0x0 0x1000>,
+				      <0x0 0xb8000000 0x0 0xc00000>;
+				reg-names = "QuadSPI", "QuadSPI-memory";
+				clocks = <&syscon_apmu CLK_QSPI_BUS>,
+					 <&syscon_apmu CLK_QSPI>;
+				clock-names = "qspi_en", "qspi";
+				resets = <&syscon_apmu RESET_QSPI>,
+					 <&syscon_apmu RESET_QSPI_BUS>;
+				interrupts = <117>;
+				status = "disabled";
+			};
+
 			/* sec_uart1: 0xf0612000, not available from Linux */
 		};
 
-- 
2.48.1


