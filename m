Return-Path: <linux-kernel+bounces-861366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4796BF28D7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF75646060C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B257A3321B2;
	Mon, 20 Oct 2025 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="1gcssCO8"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C892331A59
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979129; cv=none; b=pD696aN686jdSviG5RXthO5uN1mb7IyUZV9oj/SFfdH9Kob+lHq8dhAlvi89ymIje8qGE6vGdzeCrZ7ZLsxPqKzMnS08rh6UjgqQcnL7goZh01b5DtAfCWMGvDTCPRLn2eyhYS3PAno3x3Hoq5UimKXoF0qf9EbJVrzFtxOYw0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979129; c=relaxed/simple;
	bh=wy1ICIdGX60YDFSfUgR2rdxBjAGUo3dI3PFdtxnHMOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQGG8lHtDJvRl9kYeipUFuw86tEuwgiweHdTt7QSR5TSNA0PqXnhN+JO0U3zIsiK4OZiV8F6ucF3NsMrTIl0Zx0SOF66125KAsJ4Vfu4/Uv3b3v38ve7kdsRdkLJnSjltfZSzSjoCRVBfUxwOW/C1DHCfeTudS75CMqOjaWz9/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=1gcssCO8; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-938bf212b72so189179639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760979126; x=1761583926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ME7tN0yU+7BkLvgNaV8YZoYvs3CU33grIokhdTXS5MI=;
        b=1gcssCO836I7YzjmPM6B9QCTpuHhh0Z0Y2aZYQJN4yx413g/2SJ7IHJO3DazythDoH
         cx2Bsk8RrTiBkn0cgr77LVQpc4IQnU92E5wcOaocBQ8l2gELhbB2zySqg4Ojw4BlugGZ
         vSJcaQJp0E/NdQ+cx8g4bXGR3z6tnlzVHombfQ4z55j6ge2F+k9s4O6PqSG8kvASOADQ
         ZtcwvTIAFylsOWYhQPPvHbMOoBJWJd5obfMnXoy0VnDG6dRRD98txMv4e+47gMJ2xUyM
         lVoRKVHuaH52eNtJyf6K+Sdko7tnG54NNGkAh5yYPm2dtwEiqkj2ry/lBE5uvNnm7xYW
         jU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979126; x=1761583926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ME7tN0yU+7BkLvgNaV8YZoYvs3CU33grIokhdTXS5MI=;
        b=NwvQ705u+NEP8DsUR5j3bISSzRzMBISjf3KHFXuJVwoA7YP9J94Qk+kfu4LIpzP5GO
         N+aOinZ1MdO5rOlCMVxAyHcyMpYBKecZ4VB2QT+5v+ajhcWs7jNjtPMMLBBnBE8i0p3a
         vx9p/wKxVQz4/Q52BbUxkx/f+jhc+oUXyld/Oq96Ra5GSjmWldarT7BA0+3hTER9UHHa
         6AH5sk2pjBkbiRvL4Jey/GBVFTP49kUHsXuZPGpJFQXGadNgEqCocdYS25RBE6ksCz+Q
         r1QpyJgN8lDJ/UwCG2PctAaFpOG78dQ/FMVkg/zWZ4/ozxZnZoeBcIlFpjSbR4tMceAd
         D59Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1HsIqGPCZ+g8kIWdwgM80u4P3mjKPBGIistv+MlugREAOSf7QQhkdNafA2X6LtTl9DPbNun6M0s9tdwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIvaO1phfb+QnsCOPlHIErk3pcm8zBPw2otSMj4FXuG7Mbpzf8
	MdljV2uaKIm7VbAGsm2u932FfV/oi+3YtlfaVgnQ1svOYYphdRRAHlc8qAIPLJUCXKs=
X-Gm-Gg: ASbGnctuLXrOWZ4v5uIL2AYJ8QXcofFAhWCW8BSoyD7LgM13vZdBfnwmNg20+pM4C8q
	5+dVxlHDfNW3nmFRcqusNoBK2b1/dQYmA9+vNRkWvAGC1cAQ/nNwSOzMdwiLWKWm0PxqRt+ATPx
	GW1FglMSceHK+5g05QC1DTbo8zdAGbZWFq3tC1M4UTz8Ky8M19lw7t6NfWTcpkOnVBhzz7ChrTo
	lRpA4JW8Bnkck0Y6QZiLWHHZixpoNCYRJ47WTYptY/aocRfW6HYmQB9/ttvmdbQlftYEChtruAB
	lOHZPebS1oDy17kLwGfdDrJZzMfd8nHBaZn/QB4efJdutyxAIb5m/So2KfVpP8cQz0b5pzqW4LR
	Ufz33EcqyETdmON+8V79Xl1uXrkvolEmRFVK102asYRFMHlyAhmlMj12GSFws9j+8w8NyD5UOwM
	NZSPGwnud045LH6tkkbpsbAnYui2NF3eY5ZilqJYgLhvhECJ35cgInFsATgBgpiOnd
X-Google-Smtp-Source: AGHT+IH2irmcbwMULie9OSrSx0zC1Cu9OY8pd1/5qlpoxwTt5tQIMKxjTuK3uX5gEo7j5Pm6IgtfPg==
X-Received: by 2002:a05:6e02:2301:b0:424:7ef5:aeb with SMTP id e9e14a558f8ab-430c526b27fmr218824855ab.17.1760979126308;
        Mon, 20 Oct 2025 09:52:06 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9799428sm3116783173.63.2025.10.20.09.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:52:05 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlan@gentoo.org
Cc: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	guodong@riscstar.com,
	devicetree@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] riscv: dts: spacemit: enable K1 SoC QSPI on BPI-F3
Date: Mon, 20 Oct 2025 11:51:50 -0500
Message-ID: <20251020165152.666221-8-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251020165152.666221-1-elder@riscstar.com>
References: <20251020165152.666221-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define DTS nodes to enable support for QSPI on the K1 SoC, including
the pin control configuration used.  Enable QSPI on the Banana Pi
BPI-F3 board.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  6 ++++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 21 +++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 16 ++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 33ca816bfd4b3..2f3750f7fd6f3 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -258,6 +258,12 @@ dldo7 {
 	};
 };
 
+&qspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&qspi_cfg>;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_2_cfg>;
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


