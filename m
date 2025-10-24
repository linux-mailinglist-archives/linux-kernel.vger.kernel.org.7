Return-Path: <linux-kernel+bounces-868043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55108C0437F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B5B1894D72
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B9926FD8E;
	Fri, 24 Oct 2025 03:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4ErUz7c"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC2526D4DD
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761275184; cv=none; b=Ken1DodnL/98ih687VMyubWfx2jgMvQVfh+c7qLGfjtQO4ZhNvTaSAZSobZ9KnODpw3ylg9qYs2ojSYiGZoh4+JSFcTKCbpCMiJ5oli6PCmUxgypGt8l0AzGurekq4o6KqvOel6uUd1VOTxRT3NC2YHuvkdvKj8clYylYvu4+xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761275184; c=relaxed/simple;
	bh=Wr7LJ8peoDW/jo3pY5MeceHU7Si+wM9BWcaylcwONyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QqAuY75zE+rN5RLatCijpyvnIca/zA+xRR1PTgs5jb/hlXH8wUhG9iIjHxxcVU8Bx2IWHSFr2X5mbHQ2V9B/2dkjXPMohtKslnHNNeKZGSkxBpnLJYXuUpGqxQTMT2/G3u5eYXrP3Z9uhU/bbh5j8hOHkk0ULxEmVQAhUCkkos4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4ErUz7c; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a2754a7f6aso1909346b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761275182; x=1761879982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gK6/9/Nd88Q9gusSePNbcMpaVCV2+VwX5wGIqW+nXzI=;
        b=U4ErUz7cyL4GlXXUhtYD0xP0OsOYQDUf2Fxad1N3ybfYL5z/I+rKecKQv7FMo8xDcE
         Zv3O36mVPtlVr7aSt2HyMnFFySxgnZeYZHd0dtoG1VDmk8skcxkzytDQcibJe+BxS9hr
         dUvxDeO2Zsy4BOgOKkPiIZbqEGGW1WOn8gd8H8vHkkVadcHmJ1Vq2Q8j3BZjzHTQRwTq
         /9GHz1orllvX40wHJzStHGAMWB9KtC+HRVgU4P/ob7LJgPMRmWDZ2D29qgMKrDzGWaqq
         PUFfokThAHpeKOSDC/2lrepUZlxQYCc7O5hkmrU7UE6Bw1CkbNm7Cr22l7UBhJI/+Gc9
         Q76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761275182; x=1761879982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gK6/9/Nd88Q9gusSePNbcMpaVCV2+VwX5wGIqW+nXzI=;
        b=sjSCrB8tTFnwDjE5eG6AAGzq8la7uxS2UfRkQHG53qKfvkeCm6nMra3f8hZ8vOhCzu
         UYAnvtRiCdIFrBRmQyQDq/6zDj0Z5muiMH+LgLAnh3QygpUNLDGgUDfExQdlUkrU6dmL
         TBIu6KI+hri18wo4ilipqoVPBkQSu1yDjS/kX09U1rT/nXCGVtMma35Pvt0Ddh7aZr2Q
         YNujdK43swp1sDtCqAFPcGWKoYzSP+Lzk6CabkYU8Ad6LrU8l1szDDFZYlvIKGgNNMrL
         7wPiQsIJOhBwd520WiWc8rK3IBEGPziBzKH07yzv/fuo/LRp77foVSAqZduULwRwjY7d
         PiFA==
X-Forwarded-Encrypted: i=1; AJvYcCVIR5jKWrXGY+EIXhNZyEu0rkBLIsvYJgdeS0iMDKMHo111UAv/BXwMYrMR3Y9Q9gGaqRFzrXDprnbVpgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy97771E/UsSk5yUJ1TaMhwL0RZ9jnEijlRZeFZLZz4/Fod+ZaT
	au0ycePwyfxRjYdCSeqXraVjXJdUDJ6j5+OimPTZGHrYUFLMZH4J62Vw
X-Gm-Gg: ASbGncvHl0WUZsEOHHqXRmMB3eTHxOypC06FmHnH6R48sB2id1mGJN3dmAW+zrT6SN6
	d6/zVfaLFdgmGG+ciRCthXn0V7H827x0I6YFxjy++MRWtkH0dBVmoPewMgwiki2hqySU47HkjC1
	eKBPHJ0sF1rlvY4BGfGVZX+oOCyT7cgNL2lhT4BILpkT4efY4J7+IBgj7hKJ9hS2SfNX2K//Ayw
	Eqvc4LU8xqA3kPB7PCDy3Z1U61R1N+ezu3n95ZGHZ8iUvoo0FpG8eJLXKrnYZcNAj+763E1vN9u
	0IChvD3DpmMevTRf8/NyP0KNRaaiAteYvltnQvcAhNjnYL0kaHswSiPrHJ4XMFbm5rF6nfV+gXM
	XzfSItJInVxSEh3sx2JDvhhvpMcHDEOKLvAePG1ebqg0KWTEoyJOaxB1fqonED21FdzoqrZTAwI
	I6zqdLNaO+TcwVUhtM6/N4H7QJ1Sc=
X-Google-Smtp-Source: AGHT+IExJ6H9VPiKo4oFXupf4Hq1rvYGBs9i2gm80xYGGd1NKgjymGlzndYHMYAVYcF8kMC8+cCiAw==
X-Received: by 2002:a05:6a21:3287:b0:32d:80ab:6d12 with SMTP id adf61e73a8af0-334a86372dfmr37551806637.40.1761275182290;
        Thu, 23 Oct 2025 20:06:22 -0700 (PDT)
Received: from localhost.localdomain ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4bb86cbsm3574172a12.7.2025.10.23.20.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 20:06:21 -0700 (PDT)
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
	Yu Yuan <yu.yuan@sjtu.edu.cn>,
	Ze Huang <huangze@whut.edu.cn>
Cc: Longbin Li <looong.bin@gmail.com>,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v4 3/3] riscv: dts: sophgo: Add USB support for cv18xx
Date: Fri, 24 Oct 2025 11:05:16 +0800
Message-ID: <20251024030528.25511-4-looong.bin@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251024030528.25511-1-looong.bin@gmail.com>
References: <20251024030528.25511-1-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add USB controller node for cv18xx and enable it for Huashan Pi, milkv-duo.

Co-developed-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Longbin Li <looong.bin@gmail.com>
Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
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

