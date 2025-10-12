Return-Path: <linux-kernel+bounces-849358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C078BCFEAD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 04:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EBB44E32D2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 02:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A741DF252;
	Sun, 12 Oct 2025 02:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5XhThr1"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396ED1DE4DC
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 02:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760235996; cv=none; b=D9Pg3xeIbWM4GvJstb/dN62CP10vqbEq+lWTDswctS3R3qUFMZIixCxIubyFlDGNo1KdJeY/0tn8+EKknws7xJra33Mn46OQ/NH8f70K6TNeo2hdXLC/0rrxIeUE0AenjGP3NpSsys9WKc06OfoPDLt6j3AfeVrl82eb1gz700k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760235996; c=relaxed/simple;
	bh=T3O+FvgSCE0ciL32Lxybza6PkMpzWQQ+tRJLN6YZEiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSooNQ/uMBn/e2jtg8R5Ww72G6ImgvQQSA/UkI39os7pnu3pQFWtO0vN9bkemMF9sRrBALgccQ0o46qYYkv9MT1tux64fblAcUML9lklOyXmXaxrvbEC9i8+G0uObEnzFbQZRZPsksm7XDdgYaE8To17x9ifuQT+gDFB33tD9pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5XhThr1; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77f343231fcso2034407b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 19:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760235994; x=1760840794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfXUkC2C3C9BwOnkDvFBK7i0+SebLg1iuS2buoBW7lc=;
        b=C5XhThr1mOJC0GQC/cJMyFMx+BHLe9/A7TVcKprt7jZ446mkihD8o1Y+iP4Xy5H/H3
         +0EN8uc94dc7s2ZJDHj6V9PVHmvEMnhG73fXBNJs8m9iOufCkeLkYzWJHy8ir3Q4efDk
         5JqS9UubY36AO2Af3YKquvLBKO84twNxKqmVnxyuDFIVJhiMYv8pJhIHY+zNiOKhKP+X
         8hW0Ma3InuDNje6Ork5YhsOgVdlz/SsLOMrOftnv6SYTMzDHixhRaIVF6ya6qPVQXprm
         yDa92bsbqQdm4+IUNF5YwEkZv0IIa70Zlu26HKwitwb76XqysI5TfWLIJt/Z19UeGD4i
         g9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760235994; x=1760840794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfXUkC2C3C9BwOnkDvFBK7i0+SebLg1iuS2buoBW7lc=;
        b=iT0RsLnYGIIbiKsJzjKIXUGvdzhLirEgKBgfqDB+UE1QygdeFQx/G5lmJpvps/OcH1
         JDyHmEhlhIcRuNToNYkUgg7QlRFyf/5SMIcwFXJjl+5KJbeEZmy+8uNqTpB8Y6RnVoSX
         FVZYjmEoC8nDnAmj+IZs7WhnHaytiQ92XsWGOfezqVr63jpXyEfaHtE3zTOeY89YmiQy
         aA3kI8P/5gZyLCfZEWvBPeUZpoAmdMK07v3yk/WPgDLeIQUm45dHZtVvmCcuvH2q2rVO
         6Jb0Ememy+UDC9fb/k3FEK8SX4qnSKmsfXeC7eaiGoaPuyJoTqitOaYoNuB5yiIbIDMQ
         ui6A==
X-Forwarded-Encrypted: i=1; AJvYcCV3m3jh+nmaSqL5wbJx8xl6q0qBlU9JgebXtdkbS+Akh9Bfdt30RFZbTEI6lTK/QWRt1klloieFfLl0p2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI99CxADwxL4L63kcBMs644+D4gnlGgTIi0pROpUKpuu57UpbV
	BsgCz87kCkRBaoSquOPQjAQyTGmkXb3al4WLbIj6FhTx/9rkHnjXKphg
X-Gm-Gg: ASbGncuW9wQvv8XzeR37sU9fl4xwVZu78zKYcOLFuUSdoCFamXjeqtl94Nh/JDBvSBF
	w+XlLRfQLuU+gfoKV/6Q1qBEd/F8o2h21xsNqx/hbs9aSg2CfR/DbrzZrPx7AjwQiZZWJHl+xcF
	SKgBeq6R1C9gydtcPEtO4kBIeCnFZCR4/ohEPN+BwCQQd4J1q8E02ZJzcl370xanzMYMh9p3ueM
	MsYcoA0OyPf/uHILGaQGclhgVPO4YUdRbnq+3O9dsG68AXhvB+p62vIK9M2osIYSfk8QASY6CEF
	FmE5J3UZherQ0IHPUawwpNS5BnjKaUBcEUh/SRi8XEjWjHHdaS7kMkbl4T7KNQoFLOaFiLXcaFN
	5BRSJsQkt4MqiJBwGK80rminYhNzoEey2lKJ+2X+IWwwdI6gkzmNeAn65I4k00XYq4K5g
X-Google-Smtp-Source: AGHT+IHZ9NyGaDIFzKfo3jw9RHib9r8nk9b6aSs/8IZVATsbwnwanfHCirNVwYIHZT/pMIdteZPgFw==
X-Received: by 2002:a05:6a00:391a:b0:77e:8130:fda with SMTP id d2e1a72fcca58-79385ddc9f9mr22273636b3a.13.1760235994437;
        Sat, 11 Oct 2025 19:26:34 -0700 (PDT)
Received: from localhost.localdomain ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d9992ddsm7180489b3a.80.2025.10.11.19.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 19:26:33 -0700 (PDT)
From: Longbin Li <looong.bin@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Longbin Li <looong.bin@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Yixun Lan <dlan@gentoo.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Ze Huang <huangze@whut.edu.cn>
Cc: devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v1 3/3] riscv: dts: sophgo: Add USB support for cv18xx
Date: Sun, 12 Oct 2025 10:25:54 +0800
Message-ID: <20251012022555.6240-4-looong.bin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012022555.6240-1-looong.bin@gmail.com>
References: <20251012022555.6240-1-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add USB controller node for cv18xx and enable it for Huashan Pi, milkv-duo.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Longbin Li <looong.bin@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts |  5 +++++
 arch/riscv/boot/dts/sophgo/cv180x.dtsi           | 16 ++++++++++++++++
 .../riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts |  5 +++++
 .../boot/dts/sophgo/sg2002-licheerv-nano-b.dts   |  5 +++++
 4 files changed, 31 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
index 9feb520eaec4..0e6d79e6e3a4 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
+++ b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
@@ -100,3 +100,8 @@ &uart0 {
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&usb {
+	dr_mode = "host";
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
index 42303acb2b39..1b2b1969a648 100644
--- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
@@ -432,6 +432,22 @@ dmac: dma-controller@4330000 {
 			status = "disabled";
 		};

+		usb: usb@4340000 {
+			compatible = "sophgo,cv1800b-usb";
+			reg = <0x04340000 0x10000>;
+			clocks = <&clk CLK_AXI4_USB>, <&clk CLK_APB_USB>;
+			clock-names = "otg", "utmi";
+			g-np-tx-fifo-size = <32>;
+			g-rx-fifo-size = <536>;
+			g-tx-fifo-size = <768 512 512 384 128 128>;
+			interrupts = <SOC_PERIPHERAL_IRQ(14) IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usbphy>;
+			phy-names = "usb2-phy";
+			resets = <&rst RST_USB>;
+			reset-names = "dwc2";
+			status = "disabled";
+		};
+
 		rtc@5025000 {
 			compatible = "sophgo,cv1800b-rtc", "syscon";
 			reg = <0x5025000 0x2000>;
diff --git a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
index 4a5835fa9e96..aedf79f47407 100644
--- a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
+++ b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
@@ -86,3 +86,8 @@ &sdhci1 {
 &uart0 {
 	status = "okay";
 };
+
+&usb {
+	dr_mode = "host";
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/sophgo/sg2002-licheerv-nano-b.dts b/arch/riscv/boot/dts/sophgo/sg2002-licheerv-nano-b.dts
index 86a712b953a5..b1853770d017 100644
--- a/arch/riscv/boot/dts/sophgo/sg2002-licheerv-nano-b.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2002-licheerv-nano-b.dts
@@ -93,3 +93,8 @@ &uart0 {
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&usb {
+	dr_mode = "host";
+	status = "okay";
+};
--
2.51.0

