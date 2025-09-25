Return-Path: <linux-kernel+bounces-832385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21280B9F32C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A03A188E2E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BA630C615;
	Thu, 25 Sep 2025 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="DJvGluNB"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017E030BB8B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802648; cv=none; b=WDv1euIW5ea2xIQuTkgZNr2GrA2KahNyZak3Tb+NAyzHi3YB6aNXo+Iyq7q68DwmdYqQCrwc+lG5vw4g51QVnqWY9ig4uuGblMiL1M6Ag0tVOtyJv5sFwP5HWWNVS4QEY9jbWQhH6gV4cizwPRxiIVEtUuCkxlNN9/M1giVPeB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802648; c=relaxed/simple;
	bh=QkyaeYYrIMyMEzp2LNwQWfpvfE7ML4Lbu0zpaLJziR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkKltJ61pms2/Oa0uZr/IoBxyaB5Qnji5l3XbBxwVNafxCmPaLhY7QSVttFHKnyLgoR6yafjDrvo19Etz0VTU5FhdqZ28FRARdCyWQlKYiV/Z/eQxilsPMGA7Yx5V+G/hcU1cp6CTO0NfjCCk+N/9ELszwPb8HW8Hwtl/VZZh1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=DJvGluNB; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8876de33c86so84026839f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758802645; x=1759407445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aUdb5J2bZ3LCDFWJY9eLS9X+bRVmSq7qRBdOrt16bI=;
        b=DJvGluNBIkCVi74t23rc2biG4a7m3v4lQiYah7pOb3b8L9hVU06Q+NjqIXviDdsSgX
         nzTpu0Lx8IJ+gUcKIF+yy0LK+VDQ5/anhKIFjLeKgBnpPAo3PQrU/FUncE4uK+3aMbfr
         vO6bSczTJ7aGZHbm0DrU6lUAehYnKKia14MdiJxpJvsK7tDpIRrG1ZueyfVIkCcKj5vC
         dKXg0WbumqcCC+UrCmG9UNT4KEdhddTE3P4Dvv7ayD+D6PIdIfuNrWrtfsbNXPEx95e0
         0WHc2AheQ0vgNoEiNm18QkQ5QKz7bc7jkn0HLhig1Sk5eWB17CINSWdG304X2BI2hLUa
         qr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758802645; x=1759407445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aUdb5J2bZ3LCDFWJY9eLS9X+bRVmSq7qRBdOrt16bI=;
        b=o2KGqEZ9I+r7Zp8b+pgI4XLV/joBuRT4jd53wUw50eCEAHL1WagzruYSuEuF+yKNl/
         M5cMY5B0N3BAFSB6rD9ivdtrQu3qo4w78gDYCpjZCim3yWwePMq0P4OUvU3jUur2Ovvu
         EIWqjgncs/gz8KYHRANbCI57ITpxQU3ykXrjOmfAVKKDczHiFQLnQAfeEnJ1i/3Psm/5
         Bthz2CAK9Y3D+mYMhX4cXRTWyb2ZGz62EyIL17LUKDATlLKsY+59Tb+9mnSxkZBClb3E
         ZaZ32b5t3FbRGEffAPOy7jcIpVtZ21w3xoqHKt3+pjArfdeEkDnOQOVxnjy5cifowMOr
         KNVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz/vOvic3qpS4JLK8gytu1Cd3eTaOVUjxYl607rgvhRi0FsV3NGamB8vfbtz3c8rpN0KICyA0fU0FPDX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsAc5uhh4DDxy3eXJZuf51QpumDmefyNeIIDFe9asg2jmn3AAr
	WTuYXlvL8BCT6EZ1lh920MQAYEKcGfmAUCqKnj1fC+yjKwdvMZOgCGZG5PXwUX8/Xx8=
X-Gm-Gg: ASbGncvw63zcx8MoDTCRAGgx0Uvp4Gv26l6JyXhbSHXbxedtFp3be18jZYIe7Hiuz/l
	2EJIo+8vjl4pmgravKCtdIS2TqCgujKAbYVx9jwFm/yP7fr0MuYfK7rrG8Y2TsrvUhVUwCKXU4D
	Zd13AVWEY7fLMeZVDvmo1p3FuO8jW6FQ8wfJbb7HZQZQiXvCadjzquIrEpM8SNwkZSa/8EhM+6Q
	+cycj8P1MCCDQLUy/Q2sN1wIJ4wV+yqc5o4zje9c5r7Xnt4fRYCyG51XvwXFTvi15A0l+OxhqV9
	1TMA/iOTFwFh7+EH+TDWxqWKLfezl4RRxBMkbOB77nvyOg2yEPDz/UNB9nGunK+QuQgzSAoJ0m8
	WcI7pHcTXQnEYMRVqRL6z+oUi5ZuO9Zt9cu/w7ZyDfayrJDQimR1r94yfNWrBANHUEw==
X-Google-Smtp-Source: AGHT+IEjFx3AHkVzoNPeHiWmx7pPFWYjcoRPK4j3eY6oFpbVIi6PpgfcNkjAzfPEtCd6T08qkTPNsw==
X-Received: by 2002:a05:6602:3cf:b0:8fc:4226:5d2a with SMTP id ca18e2360f4ac-90152604875mr506586639f.5.1758802645032;
        Thu, 25 Sep 2025 05:17:25 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-9040c57fa59sm66918439f.16.2025.09.25.05.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 05:17:24 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlan@gentoo.org,
	ziyao@disroot.org,
	junhui.liu@pigmoral.tech,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] riscv: dts: spacemit: define a SPI controller node
Date: Thu, 25 Sep 2025 07:17:13 -0500
Message-ID: <20250925121714.2514932-4-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250925121714.2514932-1-elder@riscstar.com>
References: <20250925121714.2514932-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a node for the fourth SoC SPI controller (number 3) on
the SpacemiT K1 SoC.

Enable it on the Banana Pi BPI-F3 board, which exposes this feature
via its GPIO block:
  GPIO PIN 19:  MOSI
  GPIO PIN 21:  MISO
  GPIO PIN 23:  SCLK
  GPIO PIN 24:  SS (inverted)

Define pincontrol configurations for the pins as used on that board.

(This was tested using a GigaDevice GD25Q64E SPI NOR chip.)

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v4: - Formatted dmas and dma-names properties on one line
    - Renamed a pinctrl node

 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  7 +++++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 20 +++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 15 ++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 2aaaff77831e1..d9d865fbe320e 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -14,6 +14,7 @@ aliases {
 		ethernet0 = &eth0;
 		ethernet1 = &eth1;
 		serial0 = &uart0;
+		spi3 = &spi3;
 	};
 
 	chosen {
@@ -92,6 +93,12 @@ &pdma {
 	status = "okay";
 };
 
+&spi3 {
+	pinctrl-0 = <&ssp3_0_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_2_cfg>;
diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
index aff19c86d5ff3..6ce56584ff473 100644
--- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
@@ -76,4 +76,24 @@ pwm14-1-pins {
 			drive-strength = <32>;
 		};
 	};
+
+	ssp3_0_cfg: ssp3-0-cfg {
+		ssp3-0-pins {
+			pinmux = <K1_PADCONF(75, 2)>,	/* SCLK */
+				 <K1_PADCONF(77, 2)>,	/* MOSI  */
+				 <K1_PADCONF(78, 2)>;	/* MISO */
+
+			bias-disable;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+
+		ssp3-0-frm-pins {
+			pinmux = <K1_PADCONF(76, 2)>;	/* FRM (frame) */
+
+			bias-pull-up = <0>;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+	};
 };
diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index 6cdcd80a7c83b..ce55897d34fac 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -797,6 +797,21 @@ uart9: serial@d4017800 {
 				status = "disabled";
 			};
 
+			spi3: spi@d401c000 {
+				compatible = "spacemit,k1-spi";
+				reg = <0x0 0xd401c000 0x0 0x30>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&syscon_apbc CLK_SSP3>,
+					 <&syscon_apbc CLK_SSP3_BUS>;
+				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_SSP3>;
+				interrupts = <55>;
+				dmas = <&pdma 20>, <&pdma 19>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
 			/* sec_uart1: 0xf0612000, not available from Linux */
 		};
 
-- 
2.48.1


