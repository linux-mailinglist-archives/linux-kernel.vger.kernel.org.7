Return-Path: <linux-kernel+bounces-871688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D658AC0E164
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806D73AE929
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50726223DF6;
	Mon, 27 Oct 2025 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="z4+gpifF"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57617302774
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571832; cv=none; b=rEigDE9TV1EapPCpWsQAtY0IIr0V8tpw5Uk5EfEJyUdz6zPKVLIHLbrqBnBXx+ibZaIwUJZcCK0KF4J6++dTf1vbJzps5f7rOwwsjbvzT94B1+bDBZND6JleyKT5IOzACuHOzBdy8jxtpzf6cwSa3AZuKYj68t9DA7uo8Fr2RQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571832; c=relaxed/simple;
	bh=BzKRuhxyonoQsuopPQdi/8jOGmwxXgdxHX/BXxXKdik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVUmYZlfOANGCy73foeK7vKBG5jrjtkllHPpDd6NVRyX6QAfuueO1UwCl1lfpV2zEOEkBRK/7xjQp58ZC7c88llfupNjSsWkwcwwqog1Eg/pQKqfXfue0MWihovRHvYE/dPjNrQFsK/2OP2uzjinuwpq5cJld0jdwYOe2D1ZcwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=z4+gpifF; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-430b45ba0e4so23180895ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761571828; x=1762176628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdMeTbCiZFImBLpdSseleACrRi7JJpgsujeJgyCXmeA=;
        b=z4+gpifFgUssu0G78T2IwiQuCWFQh5h9c3Z8vV/6Z0mKiJCRPSHGohgbW3ceDatwmg
         DfmkGXRD0Qa7fEfS4rMRcp/iLWVZa3AqsxuNMB4iRLd8g7DIYjLBMSmmk4r8BjyTIuJ8
         B0ECj2snNu5fFNfSYunhcu9PHZI//smk3ZJIOpU+vlQbn+rJr6+fyimmItUyBXJs2BXg
         V+/vK12KhNmxVQo4BJeVqhzcWhEDpWot6G9QygkTZf86O8KjYIRAEQXECGL3GKSvQLY6
         0fVdWss83m89ukv5sv55WDv963NIPQpWp0aMUfueDlG3MQ3KjzkNiDpR4Qv5Cv9Kd8hD
         v8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571828; x=1762176628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdMeTbCiZFImBLpdSseleACrRi7JJpgsujeJgyCXmeA=;
        b=tzUl/1Zx++WrkjAPzq4XJWb/OrGxCpho78jXicpDpi9fIbhuYuBvUPWMSep1y/Npw2
         DkabXyYYPhkWq+MHzfZWs+W8oHE5gKRbKZ7Vu26SJIm9YoXBzsFVQeiLKbGSID0LOgHQ
         nGdCVbmZSWl8Xk3vPasY+MsVF+8/WE8AmozZr0JRrlm2MhcrHVIjlUNegF70BECjy7G7
         YkTaFXLLZocvl4Ku3YafDsjMCmbtAP36eJb5dqlzbO43rA3RqEdDt0BHukW+vD1PHQCO
         b/Ao87iMQeDCj35GHP89lWaQtSXg+HwqWTeYzXM24JcJACZVfiyiRLJcH6StY5fy3+ld
         RkqA==
X-Forwarded-Encrypted: i=1; AJvYcCVbN0yHa4vWDypHMmzQAwr3fcpChZbb1dxxF3PVwjnXGB7kIF35dIoz/rMCIhUcAw/J8YI5KO7lM9rvN5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCcVgc7wsRYA/LWSa4As2FFbiY7TfoiQztJJaK13bKMFA7frOE
	dcKeOY/ykMA00p9hRkMhLO7VtNyU8givs43b10MU7ArrlC9SCx37WX5jq66k0tdPmCI=
X-Gm-Gg: ASbGncsf3/2v2gm2LbSuiv+mga5PWIrdysj7PEXHpi8+/TP/UPYGeGIPNCw66fOuZQP
	hfDy34dvn8VtH7Qk1AophPoR9OORJvc1GbJ56Wljf/dbEzVUUkcVht5krgkenFZHiKE/8tgLMs3
	c2RlUT8ODkl2gKwdacJlh/kdQpbAQ0Isy6NUv+qe/7H+QTmZX/6LPG4ugUb0jmqodztpW/0MVh8
	bWJ4YOihJKGp7g5KNBOlrSWVvRzNccnJteFbrqBYqGO/Y8UwIcBWuBaEmNMcBIPrrLtEsuwYDxA
	/EAaULfOpxHf4UNDZssV0rhKAUs8jrAIIHJ6JOAviaFLIMuVoOmNHwFZVgBLRfnd5v9s1aVpgsL
	JW2tPdZuN/udeHxAa3k8DxbiIBwPqBQPeyMbMp0Kg/xo8kZtJ0ni2uzIpkO9iMkRLeat9LNDmvw
	cjzcWWtzRax39eD5AR73vt/FDV9ah73hPuGW8roABiN4A=
X-Google-Smtp-Source: AGHT+IEwi0+D29qzwfaIeFc/gnHZPerYoM3xz0awvDXq4gN/Y7hOOLjB+JgF5YW9xp73OHzxinZJ2g==
X-Received: by 2002:a05:6e02:1848:b0:42f:9847:15bd with SMTP id e9e14a558f8ab-4320f860164mr590635ab.26.1761571828284;
        Mon, 27 Oct 2025 06:30:28 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea78e2fd4sm3093057173.26.2025.10.27.06.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:30:27 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: dlan@gentoo.org,
	broonie@kernel.org,
	han.xu@nxp.com
Cc: Frank.li@nxp.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/9] riscv: dts: spacemit: enable K1 SoC QSPI on BPI-F3
Date: Mon, 27 Oct 2025 08:30:06 -0500
Message-ID: <20251027133008.360237-9-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251027133008.360237-1-elder@riscstar.com>
References: <20251027133008.360237-1-elder@riscstar.com>
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


