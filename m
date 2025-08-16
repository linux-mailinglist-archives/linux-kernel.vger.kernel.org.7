Return-Path: <linux-kernel+bounces-771875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47445B28C73
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7785C1C82374
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E0B24503B;
	Sat, 16 Aug 2025 09:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="iUzjxrQy"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AFF24469A;
	Sat, 16 Aug 2025 09:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755336791; cv=pass; b=PyiMgyrNToRF76Ku4NEVQlQ8wLyVf8BoNOrTu+dV90V56ctFb4bzUGDPZ4GgTlh6GsaWJnHleFgw/7Cd0msCs5/vdQihZ911kJUGOQzoA/wdWtHyu6CqUaKZJqS+umEtFrPJMASnvrPlVEw8Ux34YNCFq2YwqsawRUSuLBB8U24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755336791; c=relaxed/simple;
	bh=BmlE93Zs1Qp2ycCVRZn6NL8x/s3gajsV6GrAT+07b6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1CKAgqpJ3BJD5RFd0F/xDsCXngZxMA7wv7Xx68UsqnDPeVBe1x1hVi+oKopmi9MDxiuNJFYcaI7DMJNXHt5HPTDlI1cl1Fbu9WA63R4clkRbnxqQuQVlXLnNtyuZl7rXpq4dWIyLiVFkFZslWa/HrLmq2nvInayxGKjCe8y6C8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=iUzjxrQy; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755336781; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=W0sLdmC/dzTpbI8WbmZT8YwZeQwmhYwQV4QpaCbOCr9Jt72D65DCoj4QJ2Wg4Bn8clzui2oVabNIBJREggmUQpq/8AKWX3u9Ra4Yd65la25yOqDb5ZAX1gix0gcXLOrrttZAIfcvrQRTvSiPPdOVpqfUsjubZSa7snzqIZfBvkw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755336781; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+z/oVlLFF1PycSfqjySbob+HkdEI6/LSvl3u/uL2B6Y=; 
	b=Wxug/1PhLezaZvsblAoh3ZoJ1pNCb81+3/Kj+6TZKRIFrAYznSl/gw/4uC75PC6OM4GYfrkCyjA6pFwopBuXeQvm2vQu7Q+HvmoKSdh6jbZmNubXce4bqLGosJNHF1QMd+/RiAwdPwrFtKqRlpPEU21IXzyzXmSC82rqJf1yrcU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755336780;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+z/oVlLFF1PycSfqjySbob+HkdEI6/LSvl3u/uL2B6Y=;
	b=iUzjxrQyI6HFaPu3MCLdm3l7YzqJrj9nWNy4mm9KDPRuPP7LgUnMpWQKZyhve+XC
	CWGZpCLtJullORPPuA5FEQQDMZ3NM06wQu3oh2XK0GWtx2QBe3HxrSpO22uHMc6p4ZK
	a7XQc0l6FF8Ne7IaII4LApHFq8eG15/yOAh3pYRc0J3zDycyfGoaP2Y4PGDaQlcrkzh
	bgnlOCYBGTEpbpGU2qoFMjGtXJ2w8XhifWquMYFWjUcztm5vCvlaUByqaPUU3OLorVd
	NwOkjs/hgF8z3gRSOmNa90hpvPfRXia+a9tYqjsGeqeTYHqO4MoqEJnrCx8jc5AxscE
	dHNPqFtWrg==
Received: by mx.zohomail.com with SMTPS id 1755336778054821.4036963515487;
	Sat, 16 Aug 2025 02:32:58 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 3/3] riscv: dts: thead: th1520: add soft PWM fan for Lichee Pi 4A
Date: Sat, 16 Aug 2025 17:32:09 +0800
Message-ID: <20250816093209.2600355-4-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816093209.2600355-1-uwu@icenowy.me>
References: <20250816093209.2600355-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Because of the SoM+Dock design of Lichee Pi 4A, heat dissipation does
not work well; fortunately it comes with a fan port with PWM driving
capability.

As the hardware PWM controller of Lichee Pi 4A isn't ready yet, drive it
with pwm-gpio driver (software PWM) now.

A long PWM period is used, because not only software PWM is used, but
also the fan port is a 2-pin one and fast PWM might confuse the BLDC
driver on fans.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 .../boot/dts/thead/th1520-lichee-pi-4a.dts    | 53 +++++++++++++++++++
 arch/riscv/boot/dts/thead/th1520.dtsi         |  2 +-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
index 4020c727f09e8..f696db01353c5 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
@@ -4,6 +4,7 @@
  */
 
 #include "th1520-lichee-module-4a.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Sipeed Lichee Pi 4A";
@@ -28,6 +29,58 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	gpio_pwm: gpio-pwm {
+		#pwm-cells = <3>;
+		compatible = "pwm-gpio";
+		gpios = <&gpio3 3 GPIO_ACTIVE_HIGH>;
+	};
+
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		#cooling-cells = <2>;
+		pwms = <&gpio_pwm 0 100000000 0>;
+		cooling-levels = <0 66 196 255>;
+	};
+};
+
+&cpu_thermal_zone {
+	trips {
+		fan_trip0: fan-trip-0 {
+			temperature = <40000>;
+			hysteresis = <8000>;
+			type = "active";
+		};
+
+		fan_trip1: fan-trip-1 {
+			temperature = <50000>;
+			hysteresis = <8000>;
+			type = "active";
+		};
+
+		fan_trip2: fan-trip-2 {
+			temperature = <60000>;
+			hysteresis = <8000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map-active-0 {
+			cooling-device = <&fan 1 1>;
+			trip = <&fan_trip0>;
+		};
+
+		map-active-1 {
+			cooling-device = <&fan 2 2>;
+			trip = <&fan_trip1>;
+		};
+
+		map-active-2 {
+			cooling-device = <&fan 3 3>;
+			trip = <&fan_trip2>;
+		};
+	};
 };
 
 &padctrl0_apsys {
diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index a48eca5def606..5ac8044a05f1e 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -703,7 +703,7 @@ gpio4: gpio-controller@0 {
 	};
 
 	thermal-zones {
-		cpu-thermal {
+		cpu_thermal_zone: cpu-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <15000>;
 
-- 
2.50.1


