Return-Path: <linux-kernel+bounces-849357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB04FBCFEAA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 04:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4E994E281C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 02:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A3D1DB375;
	Sun, 12 Oct 2025 02:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2L1oUqF"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABDA1DE3B5
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 02:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760235988; cv=none; b=b+sBqPiCQUZoisGRakQ0iMnONJK2iMiOX4onR9qqHQ8qadATUTp5QMr8XDrg47DPemENFxjTFoALGkW7w6i9q9ZjqWZ+UlcI9d+zFq5fAbLQF1u3f5FsWTTHzaLKFsSb3SsBWXpcbTHrDvw7r87Jd2RPLFJHMo36bgInFmblhmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760235988; c=relaxed/simple;
	bh=PFIur9yyt6yU7rC5ueBW+ZogapM3+73LNvnZQ9/MQtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mmyh1C4SqVkQrRoSCO7S9cwxO8P+90nNLSKimhzS8KIsTBCQeCTXl3YlIk4T4/mInk0BX74YVj+vY21qr9xNJHG8fQwwSeFUHj3lAM8VdoCU3QjpgPEpRx3h9Z6e5GaIaSBED6hSg4Lyo0ajwWQRICDbfNRy3PfLwPgO7NqeycI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2L1oUqF; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f5d497692so4045303b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 19:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760235986; x=1760840786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oeNoAqAwXapHedMDzgCFy5RYkdc7bA8wxszUU7mEjE=;
        b=Y2L1oUqF0hrF0PPkuwMLN5/KqhvftGm9tPfiNSYPdxh0jBX4cFb25UP/06d6FmD6lw
         tqCNlMJNoKuI89Ko6/1YpVPlXUHzWWai6i93dnlRRSf5tBOzpR9mxT7lTCQEWlifXfRR
         QcNBkjeKmeNXM5+dLzIyQ65dEEVqdyI8CoBiA3R6xQ0DZwTCjlfu/Da8jVeD2ydBzhJD
         wVYG1CqfFMpB0dmNPmpxRj8WYQGXBlwcjA8Ol4UZC2ukyuzgA0sk27smVIBsC8nJik5a
         ZrsbYFzLGhM6mrJnA4SZ3seiWd5hlNjIEF28wPH2GkhsDE3fT80/Lk4mMYX3JZfhXfYw
         sQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760235986; x=1760840786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oeNoAqAwXapHedMDzgCFy5RYkdc7bA8wxszUU7mEjE=;
        b=P5y9MH8UFfoYtDCnyFj6QqPbkb2ykpQ1PesvDAhy+d1fKVU5Y0Bn77TWbHwpFi2Zgl
         /EJ1iK3HF01hnAVYaJtjP5Lonc/BvqQ/OWzQ8BF9rMyEc3S0SMC3ZJRSxaIKQluEjng7
         hMSY7VEDTGbH/oG+isFbGpKG1DyOsKMXJUmo1qWUCdyv2O6xJXtGPpphWZrbp1Ur85ih
         gmZj7WL28ZMHKwWHWVQRohuCxFWnzcOFfMBkJYZTtARLiSjjiU+mqMktBFsG8DNO1dCm
         qhd6XlBip1EsWtTN7usdtIGtLVKsPIuKP58GA6uSEg5mBh8sbh3ZPMbgklnU1dDnlyi7
         cw4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVedXbQtckwdPGDtkypbZsykJmSO7JLCp6QkC8Oan0a/Ub3WN/TUaeQoTK69EEl+tlgmvqZjjS+bd/MCkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHQKVEWqWFMkdPBVi41uBQSKBEDNYLr1CQs1nC2vtdcQBKeLoQ
	L+hUrqtqg0RXg9hYnK+XBRjlYbYmoEgwkQX7pEiooi5v3u8IX0CQzoyI
X-Gm-Gg: ASbGncsi4jiXKQ1bsU8SKEgVoE3VgNIc+Cjujj+7kvQBHDJ/q2KtHb1ox/1fXOyoP/a
	QMzxD709a3z+r0Dkp/l1cb9tsq3Ui429NWbak/4u0b7NfcJ79fHjxBZAm52RDMOWJk88nwzOjZe
	/Zma+fYrhKASH6JOoSBjC315DNfp/BG8kKYr4jbrO3g0mTGfUQJvXCi3cZn2z09O1QvYV2OhF75
	njapg53BB1llvyAS2IlnfM1iJjhIMPXdYx2uW9gAMsB4LZI3RFC6BVC/mAUFiirLiCIDz9ljFAb
	fB4/HLFmF8J+7SvH/7gZ7nYfQu/czn0SNUg0e9Hgl9IePjRAKGTyOrrMdQOfI87Y/rD3dm8FP08
	nOhfLmh0oBRriS5QtGfmZS0St3Iln+bJHouazOXWm3HHPJn4fyE3wdnQ0wA==
X-Google-Smtp-Source: AGHT+IE2GiIjqdXwdPD/DjVNY5FvlpNDYD6mAOE9DF+isXGRIky0pgWxkfR4Ic5vWRPwpbzzqM4c1A==
X-Received: by 2002:aa7:8892:0:b0:771:e4c6:10cc with SMTP id d2e1a72fcca58-79385324d9bmr21779339b3a.6.1760235986084;
        Sat, 11 Oct 2025 19:26:26 -0700 (PDT)
Received: from localhost.localdomain ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d9992ddsm7180489b3a.80.2025.10.11.19.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 19:26:25 -0700 (PDT)
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
Subject: [PATCH v1 2/3] riscv: dts: sophgo: Add syscon node for cv18xx
Date: Sun, 12 Oct 2025 10:25:53 +0800
Message-ID: <20251012022555.6240-3-looong.bin@gmail.com>
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

Add top syscon node and all subdevice nodes for cv18xx series SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Longbin Li <looong.bin@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv180x.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
index ccdb45498653..42303acb2b39 100644
--- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
@@ -25,6 +25,32 @@ soc {
 		#size-cells = <1>;
 		ranges;

+		syscon: syscon@3000000 {
+			compatible = "sophgo,cv1800b-top-syscon",
+				     "syscon", "simple-mfd";
+			reg = <0x03000000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			usbphy: phy@48 {
+				compatible = "sophgo,cv1800b-usb2-phy";
+				reg = <0x48 0x4>;
+				#phy-cells = <0>;
+				clocks = <&clk CLK_USB_125M>,
+					 <&clk CLK_USB_33K>,
+					 <&clk CLK_USB_12M>;
+				clock-names = "app", "stb", "lpm";
+				resets = <&rst RST_COMBO_PHY0>;
+			};
+
+			dmamux: dma-router@154 {
+				compatible = "sophgo,cv1800b-dmamux";
+				reg = <0x154 0x8>, <0x298 0x4>;
+				#dma-cells = <2>;
+				dma-masters = <&dmac>;
+			};
+		};
+
 		rst: reset-controller@3003000 {
 			compatible = "sophgo,cv1800b-reset";
 			reg = <0x3003000 0x1000>;
--
2.51.0

