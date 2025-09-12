Return-Path: <linux-kernel+bounces-814164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B373B5501D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 093A87A7C94
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C663E30E82A;
	Fri, 12 Sep 2025 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLoJd9jn"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7935B3019B4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685350; cv=none; b=nCfGS8qiyXmO6pvz74p+qvi6mpP1LYtxEorDKvzT7wZUTTHOMM20/Orb4GlUFjlqhg56ZUrCuGg8TandPeTRjv9oOP9fg3wRvQmfcqBIHcUqx1eRyEQBWzFgcjvIT6AhhT3HckuIwoX23KyQwCeDfYoqjj1rvwHrtpqPynubeUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685350; c=relaxed/simple;
	bh=KwL0wr2TdyQBP/wwcu7B9kkFFfn9dWMchl1rMGVyGII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W9Vjp1LKXpt9gZNjYZnb+6ToKQZ2vLxs7Tt6NgCWpmb0EV4fmDMgEyQVBAlz07ZeOLVa/0rdSbZEeyIkNJ44dflwv7MhIFgWfFG9YmNWG8vm94ZJmVI+1VK2pQaDoCZXKCKnt2fkN6nyX146Zy5lhi/vkE6fv0r8nLgiSSV8/ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLoJd9jn; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b043a33b060so290681666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757685347; x=1758290147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GFs/yrlv3BxwsD3hFdvMm9SwNXFqtO7aFYTEcCrbHJw=;
        b=nLoJd9jnIq274Qa5WyD0271trqjVLH3+nRWfr4+KPS8vt6CF3wbPWJS6ucJseOTRwA
         neC9SCo9J0nDb2VfUOWLV52EZnH0Mqh88s5Q1lJP5badKDmzTUOuPMA0ZTLbmLmraB0z
         MqU+bvhPGyIeO/yInOf0k5pPhK8SimycR4XTgolomT1VoM41oGU9IFNxDNupTVIgX0z/
         ASmB5qD/J9QKoAwcEFUc4GKq5O5gFhFbTALsgbUboCZ459QDK3HUB8+pqyjqeHz6/9fn
         F0QoOndv1L6VSIklWkT7pBMf/GJv8MEBY/1k3JyUfwvX7DyJKkqv6Tn4kbCjDHLFr9Se
         dqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757685347; x=1758290147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFs/yrlv3BxwsD3hFdvMm9SwNXFqtO7aFYTEcCrbHJw=;
        b=bULKv+cvtvbNiTgcVGfWoM68V0oARoXa5tzT9nzrXG5fo9JnhQicNw8fOMO0Kgst3Z
         CCclLiq2QJhMew08ScMH8pCNzR+DD04JtpGVK6/mvtOWgkti0WX0YgWYI9Jmq3laURDs
         pjtpdq4S9W3nCM+5xSR/dPc05gG/M+ot/tYy69p4W9ZY45SHYUT3oQ5uLfGs4FH95Xdx
         tLyEeAbSZviJnUG4V3q1sO0Uv5c/EoYtKXT7/kWVcnaRLSB5okuD18H/80XN1TCOFnR7
         Rys4I4MMlAUe6vCJfGAKafuMmidIEVyuXlwp5hLCP0+YGmRs2+QGOzT08Gxd8rbKWldX
         XD4A==
X-Forwarded-Encrypted: i=1; AJvYcCVpoL27uLNCK8A8qAznmIT41vRrdTTLNhrxjcM8MOsoHsjnIgEbstzCyvvmp1EpDn6kbY5Hllz4oQ9Xa3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2h99IILz30FyIp9ZikcY5N9z2DVXoqdt6eoPvhdyV3HD1V311
	dlTBvrUqaBwD1Uy7N13gjIknuL0NrW30wyiQ6UtBPDdyFwGHLIkLH4mf
X-Gm-Gg: ASbGncs07K5V2637IOYQiGGcV73O8hGTGmIDsoZMYNFqmbW3pHgEDyKZNIBoqhZn1DR
	BnZ8yUDsR4BlMRHSPc9ipxPqn1m4l1TAqZwR1MafQH8OfvUufc7YE+s5rK7P1jIoEHF2KSZ+ZLW
	YChV8uLpTVRtEdV9JgnIohXYXrQNobiMaevHtMGQvEdXPAnJGVxNP6rdEj2pHRDanicqiWCdw3T
	riZlXGYOimZOgRrJIslIwlFUbn5eSlVjzkMMiGS2rHRTl8pOUVe8nToNp7DPzEhU1nVIeAWgxFz
	7OQApepv2hlR18Cmjz0g6ejm3x4WKOFNcWVsd6uPHYH5X5+sQWbZ62Hbox7AkHQ+INHxjx4GP8P
	fsTsoY/W5l7tF8aO0xkdLUXy8LYsCe/6LC3igi0fDtppKgmU=
X-Google-Smtp-Source: AGHT+IEfWvgTrCzJfv8ZQfD+Jx15z+YEpVcjInjP1fcgF1fRUw7eW1Phf8azNXvHtBWqDEj6x+bNog==
X-Received: by 2002:a17:907:9627:b0:b04:4625:2372 with SMTP id a640c23a62f3a-b07c356ec97mr305733666b.15.1757685346656;
        Fri, 12 Sep 2025 06:55:46 -0700 (PDT)
Received: from HomePC (89-67-214-154.dynamic.play.pl. [89.67.214.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b31292aasm381628566b.44.2025.09.12.06.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 06:55:46 -0700 (PDT)
From: Andrey Leonchikov <andreil499@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	dsimic@manjaro.org,
	dmitry.osipenko@collabora.com,
	tglx@linutronix.de,
	amadeus@jmu.edu.cn
Cc: Andrey Leonchikov <andreil499@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: arm64: dts: rockchip: RK356x: Add OTP description.
Date: Fri, 12 Sep 2025 15:55:41 +0200
Message-ID: <20250912135542.2304150-1-andreil499@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add OTP mapping, can be used on future by drivers.
Contain a factory-programmed values for a various peripheral.
U-Boot already use "CPU-ID" OTP value ("otp_id" on this patch).
All values from original Rockchip sources tree on github.

Signed-off-by: Andrey Leonchikov <andreil499@gmail.com>

diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index fd2214b6fad4..74523efa8ecf 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -1057,6 +1057,111 @@ rng: rng@fe388000 {
 		status = "disabled";
 	};
 
+	otp_ns: otp@fe38c000 {
+		compatible = "rockchip,rk3568-otp";
+		reg = <0x00 0xfe38c000 0x00 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		clocks = <&cru CLK_OTPC_NS_USR>,
+			<&cru CLK_OTPC_NS_SBPI>,
+			<&cru PCLK_OTPC_NS>,
+			<&cru PCLK_OTPPHY>;
+		clock-names = "usr", "sbpi", "apb", "phy";
+		resets = <&cru SRST_OTPPHY>;
+		reset-names = "otp_phy";
+
+		cpu_code: cpu-code@2 {
+			reg = <0x02 0x02>;
+		};
+
+		specification_serial_number: specification-serial-number@7 {
+			reg = <0x07 0x01>;
+			bits = <0x00 0x05>;
+		};
+
+		otp_cpu_version: cpu-version@8 {
+			reg = <0x08 0x01>;
+			bits = <0x03 0x03>;
+		};
+
+		mbist_vmin: mbist-vmin@9 {
+			reg = <0x09 0x01>;
+			bits = <0x00 0x04>;
+		};
+
+		otp_id: id@a {
+			reg = <0x0a 0x10>;
+		};
+
+		cpu_leakage: cpu-leakage@1a {
+			reg = <0x1a 0x01>;
+		};
+
+		log_leakage: log-leakage@1b {
+			reg = <0x1b 0x01>;
+		};
+
+		npu_leakage: npu-leakage@1c {
+			reg = <0x1c 0x01>;
+		};
+
+		gpu_leakage: gpu-leakage@1d {
+			reg = <0x1d 0x01>;
+		};
+
+		core_pvtm: core-pvtm@2a {
+			reg = <0x2a 0x02>;
+		};
+
+		cpu_tsadc_trim_l: cpu-tsadc-trim-l@2e {
+			reg = <0x2e 0x01>;
+		};
+
+		cpu_tsadc_trim_h: cpu-tsadc-trim-h@2f {
+			reg = <0x2f 0x01>;
+			bits = <0x00 0x04>;
+		};
+
+		gpu_tsadc_trim_l: npu-tsadc-trim-l@30 {
+			reg = <0x30 0x01>;
+		};
+
+		gpu_tsadc_trim_h: npu-tsadc-trim-h@31 {
+			reg = <0x31 0x01>;
+			bits = <0x00 0x04>;
+		};
+
+		tsadc_trim_base_frac: tsadc-trim-base-frac@31 {
+			reg = <0x31 0x01>;
+			bits = <0x04 0x04>;
+		};
+
+		tsadc_trim_base: tsadc-trim-base@32 {
+			reg = <0x32 0x01>;
+		};
+
+		cpu_opp_info: cpu-opp-info@36 {
+			reg = <0x36 0x06>;
+		};
+
+		gpu_opp_info: gpu-opp-info@3c {
+			reg = <0x3c 0x06>;
+		};
+
+		npu_opp_info: npu-opp-info@42 {
+			reg = <0x42 0x06>;
+		};
+
+		dmc_opp_info: dmc-opp-info@48 {
+			reg = <0x48 0x06>;
+		};
+
+		remark_spec_serial_number: remark-spec-serial-number@56 {
+			reg = <0x56 1>;
+			bits = <0 5>;
+		};
+	};
+
 	i2s0_8ch: i2s@fe400000 {
 		compatible = "rockchip,rk3568-i2s-tdm";
 		reg = <0x0 0xfe400000 0x0 0x1000>;
-- 
2.51.0


