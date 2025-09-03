Return-Path: <linux-kernel+bounces-798877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD4FB42424
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5F9916CF76
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5333831A071;
	Wed,  3 Sep 2025 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="rJs54jCP"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBFE31A06F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911259; cv=none; b=kU4BMvVVp7c/B2M/ks3BMX+EPep2P077LZkVUKnlbB9HMmwxz7nsaTKX4CvdCIw/qsyECo96Pm7nPoIGdJ8xJZnBYOHJd3qLQvlZgewQ8pMPUUvBgXrhw8oSg7dY5vEcevWKVjI31fKx9SQv+WyybWng4zn5sV4x6RMKIA/PM+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911259; c=relaxed/simple;
	bh=KpHOj0mNA4+e9kUqlWS2RJgWfZkd6/Eg0O9escihThQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yjg+VDm3CtvgJmR5sXtWJ5bmYUlRTUX55Qpk3icWOzQkQGjqIYRp4QBhuvW3wTQdraPAu4CBTYcxmUK/VXPs8vSwvMtmtFptNdXTfghj6PkydDis1yruLnDA7rKfhWsq7Tb38hKwoF7zMk3/emn5HMrWJlpl9zn6MyHSFBaA/6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=rJs54jCP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3d118d8fa91so283427f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1756911254; x=1757516054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KfRoqQl7bTrgAdolwwez1LaewcASB4l+oYGwiyVhGj4=;
        b=rJs54jCP70fD74UKZO5ubYeUtJ8SM4L4T1Z3vgE+LBRGFbNMSSbQG7p9y8vo8NZvZg
         k3eZZTd609zGNPV7rymGvawjRGEQ5At+clvcDgSTWnkU+4Wr0mQ7utyPxb+EkTFc5SF8
         Y19ypw5qbGDKCWr2FyL83ZlFictZKM4HwrmZ4ghVXK7iixncFbYHKmXk8YHZbSvhvK7q
         BJ2IJMieTGeQt4rYDxBp1OTNMj9ELhg+ccbwgXhwK4d+RsCFxJib82H6LUXHSJDFcwbO
         1ArPK4chQWx3bsYvUAAr8tDM4ZkBDWbyscAq5cHK4YEDkoCfCApy5pIpvAudBZ/7qmni
         7HrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756911254; x=1757516054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KfRoqQl7bTrgAdolwwez1LaewcASB4l+oYGwiyVhGj4=;
        b=HeOHWdjaKBkj+L8z7zi8nPKBel4ON24zxZSNC/00iWIcuzWhaU5ddhvOtOG9K0JQLw
         te4pWtop3/hrcUeVJwRmYtSKaQPGHeN71v9DVDpSs1kAT0Ys0i56IG3zSNk0f7eSb+qD
         bK8SZs0fyjvI6T98juCEMvTxjLbjJs75CS1Xv9wafgJAimqxPC3TM4+Q7Hlw9ea6q2vY
         7gt3qIWrCz8gvwVYePSxfVtwY0+Ydoj1Dn3e/MSK3W1Q6VKhMVdSe3uX6F6OByaHWbza
         2zIXGtu1LQfGrgrcFzmji2tHBfkqOkV7gNnn2AYlI+fl2aSNWsDrHP/wW8W0PdfCziiV
         T2LA==
X-Forwarded-Encrypted: i=1; AJvYcCXouVapStbH07UpfUyAThVmdGww2cDTRfqtRWc9LR+45hFeztHkA2l1EUlhLmnoYfF42+CoRdHTL++uOKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxXfllUZkmoLFT8cWAeuzby6DxIQK6znnqxJqsXKycnmt3Ae3h
	z8FHfTq1Di+ibFDLo2+joUNea0SiYEJo6qXYAaF3nTnl26PGBSUd0M0z7KuAzDKHcjA=
X-Gm-Gg: ASbGncvbSvv22FNsrZfoVYreU/GPlMk0hih1m+IJsDDZvijEGEtWCJCNv3v41BK8/jU
	FE9RN6f2L9szgGszHXTZk8QtXo76xvqvGKGdh84dHOEaHC7kpyhcjLavYwp499RWp7l2kLFATmp
	St+A4+PZ/gHDxy8OhTe6cfiflajoSPGQd0r0+QzLZQl1lwp8eUBTXaxm4Tc9oArZ6cFN0HNuZpp
	irfxxXWpat/d+P/hkN2Tni0XrudeVwhxwsk0o4npUJFxSBows0bUfjY66t838c54WaxK2o+bHQK
	e/1iAK5e2ZzXlkDbmVFf9JAxU5Zpe0hYfAnG2Suw+Cxo1vqC/H30S+9LfZNpRy5Umsv/pioyRty
	43L8ZlAiazpQtYqnZWc/VHSyIPV9ed8JoQ9W27FlkAzMxbV68eGYOujH3mNNXizMg64e2tg==
X-Google-Smtp-Source: AGHT+IFKlUEKzOojQldM0O3QUhp1WqFQrJMW4YyIwO+SE1fmwBD/U9KH7gat3RRaNFqT/jHFuMp31A==
X-Received: by 2002:a05:6000:1ac8:b0:3c7:244:a4be with SMTP id ffacd0b85a97d-3d1dd04e24bmr13949477f8f.10.1756911254206;
        Wed, 03 Sep 2025 07:54:14 -0700 (PDT)
Received: from pop-os.telenet.be ([2a02:1807:2a00:3400:7e45:593:64fd:6612])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3dc1cd4a7d2sm4087175f8f.33.2025.09.03.07.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:54:13 -0700 (PDT)
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
To: dlan@gentoo.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Subject: [PATCH] riscv: dts: spacemit: add UART pinctrl combinations
Date: Wed,  3 Sep 2025 16:53:34 +0200
Message-ID: <20250903145334.425633-1-hendrik.hamerlinck@hammernet.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds UART pinctrl configurations based on the SoC datasheet and the
downstream Bianbu Linux tree. The drive strength values were taken from
the downstream implementation, which uses medium drive strength.

For convenience, the board DTS files have been updated to include all
UART instances with their possible pinmux options in a disabled state.

Tested this locally on both Orange Pi RV2 and Banana Pi BPI-F3 boards. 

Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
---
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  18 ++
 .../boot/dts/spacemit/k1-orangepi-rv2.dts     |  18 ++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 276 +++++++++++++++++-
 3 files changed, 309 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 6013be258542..661d47d1ce9e 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -49,3 +49,21 @@ &uart0 {
 	pinctrl-0 = <&uart0_2_cfg>;
 	status = "okay";
 };
+
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart5_3_cfg>;
+	status = "disabled";
+};
+
+&uart8 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart8_2_cfg>;
+	status = "disabled";
+};
+
+&uart9 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart9_2_cfg>;
+	status = "disabled";
+};
diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
index 337240ebb7b7..dc45b75b1ad4 100644
--- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
@@ -38,3 +38,21 @@ &uart0 {
 	pinctrl-0 = <&uart0_2_cfg>;
 	status = "okay";
 };
+
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart5_3_cfg>;
+	status = "disabled";
+};
+
+&uart8 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart8_2_cfg>;
+	status = "disabled";
+};
+
+&uart9 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart9_2_cfg>;
+	status = "disabled";
+};
diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
index 381055737422..43425530b5bf 100644
--- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
@@ -11,12 +11,282 @@
 #define K1_GPIO(x)	(x / 32) (x % 32)
 
 &pinctrl {
+	uart0_0_cfg: uart0-0-cfg {
+		uart0-0-pins {
+			pinmux = <K1_PADCONF(104, 3)>,	/* uart0_txd */
+				 <K1_PADCONF(105, 3)>;	/* uart0_rxd */
+			power-source = <3300>;
+			bias-pull-up;
+			drive-strength = <19>;
+		};
+	};
+
+	uart0_1_cfg: uart0-1-cfg {
+		uart0-1-pins {
+			pinmux = <K1_PADCONF(108, 1)>,	/* uart0_txd */
+				 <K1_PADCONF(80, 3)>;	/* uart0_rxd */
+			power-source = <3300>;
+			bias-pull-up;
+			drive-strength = <19>;
+		};
+	};
+
 	uart0_2_cfg: uart0-2-cfg {
 		uart0-2-pins {
-			pinmux = <K1_PADCONF(68, 2)>,
-				 <K1_PADCONF(69, 2)>;
+			pinmux = <K1_PADCONF(68, 2)>,	/* uart0_txd */
+				 <K1_PADCONF(69, 2)>;	/* uart0_rxd */
+			bias-pull-up;
+			drive-strength = <32>;
+		};
+	};
 
-			bias-pull-up = <0>;
+	uart2_0_cfg: uart2-0-cfg {
+		uart2-0-pins {
+			pinmux = <K1_PADCONF(21, 1)>,	/* uart2_txd */
+				 <K1_PADCONF(22, 1)>,	/* uart2_rxd */
+				 <K1_PADCONF(23, 1)>,	/* uart2_cts */
+				 <K1_PADCONF(24, 1)>;	/* uart2_rts */
+			bias-pull-up;
+			drive-strength = <32>;
+		};
+	};
+
+	uart3_0_cfg: uart3-0-cfg {
+		uart3-0-pins {
+			pinmux = <K1_PADCONF(81, 2)>,	/* uart3_txd */
+				 <K1_PADCONF(82, 2)>,	/* uart3_rxd */
+				 <K1_PADCONF(83, 2)>,	/* uart3_cts */
+				 <K1_PADCONF(84, 2)>;	/* uart3_rts */
+			bias-pull-up;
+			drive-strength = <32>;
+		};
+	};
+
+	uart3_1_cfg: uart3-1-cfg {
+		uart3-1-pins {
+			pinmux = <K1_PADCONF(18, 2)>,	/* uart3_txd */
+				 <K1_PADCONF(19, 2)>,	/* uart3_rxd */
+				 <K1_PADCONF(20, 2)>,	/* uart3_cts */
+				 <K1_PADCONF(21, 2)>;	/* uart3_rts */
+			bias-pull-up;
+			drive-strength = <32>;
+		};
+	};
+
+	uart3_2_cfg: uart3-2-cfg {
+		uart3-2-pins {
+			pinmux = <K1_PADCONF(53, 4)>,	/* uart3_txd */
+				 <K1_PADCONF(54, 4)>,	/* uart3_rxd */
+				 <K1_PADCONF(55, 4)>,	/* uart3_cts */
+				 <K1_PADCONF(56, 4)>;	/* uart3_rts */
+			bias-pull-up;
+			drive-strength = <32>;
+		};
+	};
+
+	uart4_0_cfg: uart4-0-cfg {
+		uart4-0-pins {
+			pinmux = <K1_PADCONF(100, 4)>,	/* uart4_txd */
+				 <K1_PADCONF(101, 4)>;	/* uart4_rxd */
+			power-source = <3300>;
+			bias-pull-up;
+			drive-strength = <19>;
+		};
+	};
+
+	uart4_1_cfg: uart4-1-cfg {
+		uart4-1-pins {
+			pinmux = <K1_PADCONF(81, 3)>,	/* uart4_cts */
+				 <K1_PADCONF(82, 3)>,	/* uart4_rts */
+				 <K1_PADCONF(83, 3)>,	/* uart4_txd */
+				 <K1_PADCONF(84, 3)>;	/* uart4_rxd */
+			bias-pull-up;
+			drive-strength = <32>;
+		};
+	};
+
+	uart4_2_cfg: uart4-2-cfg {
+		uart4-2-pins {
+			pinmux = <K1_PADCONF(23, 2)>,	/* uart4_txd */
+				 <K1_PADCONF(24, 2)>;	/* uart4_rxd */
+			bias-pull-up;
+			drive-strength = <32>;
+		};
+	};
+
+	uart4_3_cfg: uart4-3-cfg {
+		uart4-3-pins {
+			pinmux = <K1_PADCONF(33, 2)>,	/* uart4_txd */
+				 <K1_PADCONF(34, 2)>,	/* uart4_rxd */
+				 <K1_PADCONF(35, 2)>,	/* uart4_cts */
+				 <K1_PADCONF(36, 2)>;	/* uart4_rts */
+			bias-pull-up;
+			drive-strength = <32>;
+		};
+	};
+
+	uart4_4_cfg: uart4-4-cfg {
+		uart4-4-pins {
+			pinmux = <K1_PADCONF(111, 4)>,	/* uart4_txd */
+				 <K1_PADCONF(112, 4)>,	/* uart4_rxd */
+				 <K1_PADCONF(113, 4)>,	/* uart4_cts */
+				 <K1_PADCONF(114, 4)>;	/* uart4_rts */
+			bias-pull-up;
+			drive-strength = <32>;
+		};
+	};
+
+	uart5_0_cfg: uart5-0-cfg {
+		uart5-0-pins {
+			pinmux = <K1_PADCONF(102, 3)>,	/* uart5_txd */
+				 <K1_PADCONF(103, 3)>;	/* uart5_rxd */
+			power-source = <3300>;
+			bias-pull-up;
+			drive-strength = <19>;
+		};
+	};
+
+	uart5_1_cfg: uart5-1-cfg {
+		uart5-1-pins {
+			pinmux = <K1_PADCONF(25, 2)>,	/* uart5_txd */
+				 <K1_PADCONF(26, 2)>,	/* uart5_rxd */
+				 <K1_PADCONF(27, 2)>,	/* uart5_cts */
+				 <K1_PADCONF(28, 2)>;	/* uart5_rts */
+			bias-pull-up;
+			drive-strength = <32>;
+		};
+	};
+
+	uart5_2_cfg: uart5-2-cfg {
+		uart5-2-pins {
+			pinmux = <K1_PADCONF(42, 2)>,	/* uart5_txd */
+				 <K1_PADCONF(43, 2)>,	/* uart5_rxd */
+				 <K1_PADCONF(44, 2)>,	/* uart5_cts */
+				 <K1_PADCONF(45, 2)>;	/* uart5_rts */
+			bias-pull-up;
+			drive-strength = <32>;
+		};
+	};
+
+	uart5_3_cfg: uart5-3-cfg {
+		uart5-3-pins {
+			pinmux = <K1_PADCONF(70, 4)>,	/* uart5_txd */
+				 <K1_PADCONF(71, 4)>,	/* uart5_rxd */
+				 <K1_PADCONF(72, 4)>,	/* uart5_cts */
+				 <K1_PADCONF(73, 4)>;	/* uart5_rts */
+			bias-pull-up;
+			drive-strength = <32>;
+		};
+	};
+
+	uart6_0_cfg: uart6-0-cfg {
+		uart6-0-pins {
+			pinmux = <K1_PADCONF(85, 2)>,	/* uart6_cts */
+				 <K1_PADCONF(86, 2)>,	/* uart6_txd */
+				 <K1_PADCONF(87, 2)>,	/* uart6_rxd */
+				 <K1_PADCONF(90, 2)>;	/* uart6_rts */
+			bias-pull-up;
+			drive-strength = <32>;
+		};
+	};
+
+	uart6_1_cfg: uart6-1-cfg {
+		uart6-1-pins {
+			pinmux = <K1_PADCONF(0, 2)>,	/* uart6_txd */
+				 <K1_PADCONF(1, 2)>,	/* uart6_rxd */
+				 <K1_PADCONF(2, 2)>,	/* uart6_cts */
+				 <K1_PADCONF(3, 2)>;	/* uart6_rts */
+			bias-pull-up;
+			drive-strength = <32>;
+		};
+	};
+
+	uart6_2_cfg: uart6-2-cfg {
+		uart6-2-pins {
+			pinmux = <K1_PADCONF(56, 2)>,	/* uart6_txd */
+				 <K1_PADCONF(57, 2)>;	/* uart6_rxd */
+			bias-pull-up;
+			drive-strength = <32>;
+		};
+	};
+
+	uart7_0_cfg: uart7-0-cfg {
+		uart7-0-pins {
+			pinmux = <K1_PADCONF(88, 2)>,	/* uart7_txd */
+				 <K1_PADCONF(89, 2)>;	/* uart7_rxd */
+			bias-pull-up;
+			drive-strength = <32>;
+		};
+	};
+
+	uart7_1_cfg: uart7-1-cfg {
+		uart7-1-pins {
+			pinmux = <K1_PADCONF(4, 2)>,	/* uart7_txd */
+				 <K1_PADCONF(5, 2)>,	/* uart7_rxd */
+				 <K1_PADCONF(6, 2)>,	/* uart7_cts */
+				 <K1_PADCONF(7, 2)>;	/* uart7_rts */
+			bias-pull-up;
+			drive-strength = <32>;
+		};
+	};
+
+	uart8_0_cfg: uart8-0-cfg {
+		uart8-0-pins {
+			pinmux = <K1_PADCONF(82, 4)>,	/* uart8_txd */
+				 <K1_PADCONF(83, 4)>;	/* uart8_rxd */
+			bias-pull-up;
+			drive-strength = <32>;
+		};
+	};
+
+	uart8_1_cfg: uart8-1-cfg {
+		uart8-1-pins {
+			pinmux = <K1_PADCONF(8, 2)>,	/* uart8_txd */
+				 <K1_PADCONF(9, 2)>,	/* uart8_rxd */
+				 <K1_PADCONF(10, 2)>,	/* uart8_cts */
+				 <K1_PADCONF(11, 2)>;	/* uart8_rts */
+			bias-pull-up;
+			drive-strength = <32>;
+		};
+	};
+
+	uart8_2_cfg: uart8-2-cfg {
+		uart8-2-pins {
+			pinmux = <K1_PADCONF(75, 4)>,	/* uart8_txd */
+				 <K1_PADCONF(76, 4)>,	/* uart8_rxd */
+				 <K1_PADCONF(77, 4)>,	/* uart8_cts */
+				 <K1_PADCONF(78, 4)>;	/* uart8_rts */
+			power-source = <3300>;
+			bias-pull-up;
+			drive-strength = <19>;
+		};
+	};
+
+	uart9_0_cfg: uart9-0-cfg {
+		uart9-0-pins {
+			pinmux = <K1_PADCONF(12, 2)>,	/* uart9_txd */
+				 <K1_PADCONF(13, 2)>;	/* uart9_rxd */
+			bias-pull-up;
+			drive-strength = <32>;
+		};
+	};
+
+	uart9_1_cfg: uart9-1-cfg {
+		uart9-1-pins {
+			pinmux = <K1_PADCONF(110, 3)>,	/* uart9_cts */
+				 <K1_PADCONF(115, 3)>,	/* uart9_rts */
+				 <K1_PADCONF(116, 3)>,	/* uart9_txd */
+				 <K1_PADCONF(117, 3)>;	/* uart9_rxd */
+			bias-pull-up;
+			drive-strength = <32>;
+		};
+	};
+
+	uart9_2_cfg: uart9-2-cfg {
+		uart9-2-pins {
+			pinmux = <K1_PADCONF(72, 2)>,	/* uart9_txd */
+				 <K1_PADCONF(73, 2)>;	/* uart9_rxd */
+			bias-pull-up;
 			drive-strength = <32>;
 		};
 	};
-- 
2.43.0


