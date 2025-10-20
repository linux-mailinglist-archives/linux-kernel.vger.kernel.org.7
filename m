Return-Path: <linux-kernel+bounces-860378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A13DBEFFFA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0506189EAD3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46B42EC0B6;
	Mon, 20 Oct 2025 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGd/5LmW"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574BE2EC54B
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760949596; cv=none; b=JYCCRVIy3fFP7zdOhbrQWGqBSyLuIAdXky/0XuL7u7qL0LNTDiDsaHzdKfBRClCWTAhNTopXK81y8yjjobN2Vov1QJDSCjIPp0IgNvtdiN6RQikvxfjCDagdoR6FQ6RNeKzFjkmw7/pELa5HRM7rLeUTTZaGkuqeKP7TXmfW36s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760949596; c=relaxed/simple;
	bh=g2wucMqTimj4B/Ivo20ub1OfTsfZvS3GyFBla5SPJKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c50h60DA7BNqcjz7Dhn/KEAeJcTERN5awx2mNNxMGq4iRLAJTTqXwPAK1yGMp29zXIaQL2Id+DlAzi5wAVfbbJgIhC80h4KYjgmja666JHiAPY/MoJtN+4BO20LD44EwwNmWt74Zrb6j/McIUmSaWo8sNgRA9/1YcAYVhUADlLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGd/5LmW; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so3306304b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 01:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760949594; x=1761554394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Der7FNf7I/75zOWZ+nH7KDaewc2YUf74Wn4YmPEFp9w=;
        b=SGd/5LmWKnxyAmD20X5V+6DGASvrbcOzNqyWDsT1DmmUisPmrDuNZqngAh2mFG3smy
         N6rhgBCS21isEAaWNMK/UYLIcSZiFpZr4hJHcaCyNQBQaZyCHK77q79P2+xao3LbjL4H
         FwhM6GlS4XkRErUxrzVTYMDLIQ+VmXTFpdoyDMqfU4Han4DSGVQDeIRO4FcrR8geBFjY
         5RliSelGsOYMPNVWN/gMtoxXO2WH5N4xDoQKfjJ07vfuSWwSp6GdDxFXBRa4bMY9UOJ0
         P+5RdMElE1m/6CwK8DEYI4wxYo2/9Sf7T4MpjsNd2Ia3mZDYpOmYPDukoS0/Ggp3iwvr
         epjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760949594; x=1761554394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Der7FNf7I/75zOWZ+nH7KDaewc2YUf74Wn4YmPEFp9w=;
        b=U7eA8jIiJBxsHbW+lJ+WydtLeWhrwHEvhmNINxPWddyGkAGAACGJ9DFvrb09KtuQFg
         +sl81od7x45tPVAhHy5iHpKxEc4DBHW3ntzbjqEqkuZMk9Cp73itBT1cN2OP0+dLFK2D
         Z8+zFCxirDvzvkZ4FtfbPX1xLeE1JSGHjnaHtLXwCSBKK58cAnpYkIIzjd6gevnVGF42
         OxV3pEpMbS92TUVWuUyL0TcthgZ4leyQ5kVUiLRLCsVFYxuMqNtflGZcvCvyhfqmuap5
         7zxwi/l46Y9BcSx1bL/cFtTsDh2g4DHlVjKrAdOlrOQkDgFTGxwMNppUsmnXTzEvOB68
         Rnng==
X-Forwarded-Encrypted: i=1; AJvYcCWCmqLhndGAzQWT1P5oWMmHVJ73B7f2sqgyTFHEm7xIaVNekIMrrIX/1etzSXh34VErzuKQ3H5RqaZpL/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0r+1kAxmLHdvXMjIqRYjqUOSruIcHYvJ/5q92ghME1cwjlIM2
	klUfZgaWY1yOJ6PY/WZ4pcCUoiaGR+cn6QLOnh799aiGteklTRnLYlBg
X-Gm-Gg: ASbGncux88xiYcZOyhcL73Az53ULq9CLy1mZYS7gegt4TQsW/voi+lxGCuChKvMBdEg
	23dXVo8Q5+KkqWV1K7S6nIhlJlgPqjzdapNNZznFENJus3IA6mYUtif1QwAEz1hbK35rqOxaFp4
	FQ6bWUIifVoGrDrbR9MFQFIjNt1M7Bud8fK1vzXxrFNaXbEbbmXRirvjWEBp4gYNwNWH2YETVs8
	anM2emgTYRwu6aMVElh3OjvD57Jks7pnTdhAk4grcW3d36MP/8roIWupNKmIO1chfg7A/oi8njp
	rNMPogQ2WD0DMz9gsgKLATFfEsFcsIB3FYch8ba3UBTWI4j6LVAy/mjtEbmG/e0xUMgFVZCiGU6
	O6gPuj5f9iANkhn5jNXyuqSGbOgXM+NgX2YuZsa3r8IvzdnNcnmO6If+S23aqzvBcmdHeUanY+I
	iajwc1JX5t041VQzi1
X-Google-Smtp-Source: AGHT+IH5hJNrWZcw8SGaOXSO92jouYGCNb4bb6h9USPjEKev2+BmrDNRUvPUZjLgcO+zgva54ShEvw==
X-Received: by 2002:a05:6a20:a11e:b0:334:8d0b:6639 with SMTP id adf61e73a8af0-334a8522be5mr16850362637.10.1760949593658;
        Mon, 20 Oct 2025 01:39:53 -0700 (PDT)
Received: from localhost.localdomain ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b5d0b4sm7062386a12.29.2025.10.20.01.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 01:39:53 -0700 (PDT)
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
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Ze Huang <huangze@whut.edu.cn>
Cc: Longbin Li <looong.bin@gmail.com>,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 3/3] riscv: dts: sophgo: Add USB support for cv18xx
Date: Mon, 20 Oct 2025 16:38:33 +0800
Message-ID: <20251020083838.67522-4-looong.bin@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251020083838.67522-1-looong.bin@gmail.com>
References: <20251020083838.67522-1-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add USB controller node for cv18xx and enable it for Huashan Pi, milkv-duo.

Co-authored-by: Inochi Amaoto <inochiama@gmail.com>
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

