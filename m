Return-Path: <linux-kernel+bounces-765560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1336DB239F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D306E089B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EF82D73A6;
	Tue, 12 Aug 2025 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CilKU77A"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3404E2D0627;
	Tue, 12 Aug 2025 20:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755030639; cv=none; b=jhvWP1r/fCwFMBsS/J+WL34Cld4xRNTsOXOphg+RILmdAT6y0j4dZGwvQ016r7zgbbwOY8wicHjdhkh37+rOAWu9flf33quoJsbYdeoSqphvEmoGa7KmjUlooD2h8XjKAXRrLWmFVNTeYz3DGoWUCkxsYANJWdK2bp6LICaFbCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755030639; c=relaxed/simple;
	bh=Z46ZEe7O+jWIb3cQLmtasBStIyvB4eOFL1/6Uj9pPf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZHYMK78hs44lO5uSesMJC8Lz9uDmX8vG2OhnZUmKOSh+jkTlpEOk/LCX/Erxfx7oWaUC8iVRpxVGXOGAltnMPIesDYQd/AHvCkFNlPx8XSErvGgiHrEzHGExUTlkSym82ZsIY0BjCACGeyxDh+/jnQlpur3vCGIprgNcbw4V1/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CilKU77A; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6182b3218aeso4650549a12.2;
        Tue, 12 Aug 2025 13:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755030635; x=1755635435; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nwf0tl4nBa13UJCl6mfa+smPxgRED9nFICt3MHieDdU=;
        b=CilKU77A4zil2IIUM8/pJZ5alWXN9cF0/JduTvKNyATzbo6/52U9d9Py3CQUvHird5
         BrD6VWEX3esUkBnw1Mua9HkNMBme4EEs52IUraxI0ARbfrtaF53/5Z8P573m9Pv8iJl1
         7gdUmKgJSX3R/bPyK3Zvdwfw+OPF0kKuFEoO01HyqgkwzpUU2LFzoSx0GZtIsjqfvHXv
         WbPVnCjO6+dgaBm5Bc8Si+GiZljrUuji1gOisWsBPoTKb34/xhx3r3CPsJD4slPeEKgb
         pabtd3On4TdAUE1wxqNP7gcrizup8TzGti26eGJynOlDRoQKmHCZ8B7EDo5mX4bc25q5
         vF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755030635; x=1755635435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nwf0tl4nBa13UJCl6mfa+smPxgRED9nFICt3MHieDdU=;
        b=OukAbtwOqJb8uSKLt3wJ/ehDq6y+S6aCTYdwngaFzFX/YUkyETH+W5ffUrco/5MxF+
         mrqpjKjfOYc46lCXsF1ybuF6gZlEMm4HLhkRNnyTWK1Sc52Dj8gfKxCS9MjwMc5LjIZw
         Q47Mj0n+PebtdSgXBoDHobrMWRcg74lxPlHbaseDpBkXqg60LgfUYEAOj7Mr4JEA2kxv
         JLmusjv7tIqLUnVScNV1m1HuwMAk80sBDsKABZvwDcOcky0Sii4lUBpLHCJy58+6rajN
         mrmJCrnmxIdU0v8KqSeNpwReLHUirJXGhOUwZ6kogRPYEwwCS6X33fo8+KN478kYE55I
         3K3A==
X-Forwarded-Encrypted: i=1; AJvYcCXQqZV6errrvXJZJJPUXpjRBDfztIYWMyAzd0dRhDLTdUTbbuA4oklr53DpYpYM3LLyfW5R2co1+haTFGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlddiNw4O3nTvloUUWLWJ36tN/xIiIzQmdftXq4BC2w5dYcLwv
	/jV/5RpK5JC0MS3szD9GHDk7PbFcQeWxcpca3amaR8FVKhS9XJIqyVS12BwBhfofr9I=
X-Gm-Gg: ASbGncufZPwul/7RkceXtfpYVbO/tp6+eiJPtz4/8uoD+wB+X65+DNZvtXZOr8j/vd7
	15kHxas/nw6R0cLUxggBN/qg7DQSE3PgvZyGldXd48c7x5/HAztPOrmItITAKiHV0pht7Bw86I/
	1CI06xdRPy6+RL24h2zv1M0LJ+ruWZ9/n5hkhP8gdcUYREwlBqK9CtJ93sC3YWaA3rDZoh7FUlp
	mqxnnZupP3LYIta8RQ95W+3MC2w2J9VbNsOMIdwUhYFUkYhVk+OAQehinlDsET6mid4iO4a9jSa
	DbmgOfgVVL+VIQm+aTsS1XJ6D4Hsl/wYMxdmtkoXf95CpcWqMEVYAPYlon/VHoux3LulD0sblF5
	4wXyi1itABfPUNjXscL0A0OUhwHdxFqKZ1R63UUf+kgIXGQumiac=
X-Google-Smtp-Source: AGHT+IEfTzvBVYRLiP0bE3VohxDxUnqG+MLEAQ2wwCgb+zmjB2XzUTRJ02q7YAarySiFmVMKHcddMQ==
X-Received: by 2002:a17:907:3fa7:b0:af9:24e7:1c85 with SMTP id a640c23a62f3a-afca4e6c854mr56918366b.55.1755030635456;
        Tue, 12 Aug 2025 13:30:35 -0700 (PDT)
Received: from alchark-surface.localdomain ([185.213.155.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3b58sm2266073166b.58.2025.08.12.13.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 13:30:35 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 13 Aug 2025 00:30:25 +0400
Subject: [PATCH 3/3] arm64: dts: rockchip: Add Bluetooth on rk3576-evb1-v10
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-evb1-rtcwifibt-v1-3-d13c83422971@gmail.com>
References: <20250813-evb1-rtcwifibt-v1-0-d13c83422971@gmail.com>
In-Reply-To: <20250813-evb1-rtcwifibt-v1-0-d13c83422971@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Pavel Zhovner <pavel@flipperdevices.com>, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755030626; l=2008;
 i=alchark@gmail.com; s=20250416; h=from:subject:message-id;
 bh=Z46ZEe7O+jWIb3cQLmtasBStIyvB4eOFL1/6Uj9pPf8=;
 b=RQg31BRxfObH1cVBuJD4fSCw1UhS4ukP9dJLnufNSw+VBfFIYLbjeudwPAaPOhmQ/zr8CmtWj
 T5kSwCxhfcqBhEHdI4Qbo6cHZoG/vAF0oDbaA1OF8Ax5LUPH8J7jLej
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=ltKbQzKLTJPiDgPtcHxdo+dzFthCCMtC3V9qf7+0rkc=

Add device tree nodes to enable Bluetooth in the Ampak AP6275P module
found on Rockchip RK3576 EVB1 and connected over a UART link.

Note that this doesn't enable the out-of-band PCM connection. It's
routed to SAI2 M0 pins in case anyone wishes to add it.

Tested-by: Pavel Zhovner <pavel@flipperdevices.com>
Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
index 100ca2e23c6093ae517d741fcd047e2a8172f457..d3e70a646fbe1e99cb007e7d9f09da33beedc842 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
@@ -766,6 +766,20 @@ &pcie1 {
 };
 
 &pinctrl {
+	bluetooth {
+		bt_reg_on: bt-reg-on {
+			rockchip,pins = <1 RK_PC7 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		bt_wake_host: bt-wake-host {
+			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		host_wake_bt: host-wake-bt {
+			rockchip,pins = <1 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	hym8563 {
 		rtc_int: rtc-int {
 			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
@@ -843,6 +857,27 @@ &uart0 {
 	status = "okay";
 };
 
+&uart4 {
+	pinctrl-0 = <&uart4m1_xfer &uart4m1_ctsn &uart4m1_rtsn>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&hym8563>;
+		clock-names = "lpo";
+		device-wakeup-gpios = <&gpio1 RK_PD4 GPIO_ACTIVE_HIGH>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PB1 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-0 = <&bt_reg_on &bt_wake_host &host_wake_bt>;
+		pinctrl-names = "default";
+		shutdown-gpios = <&gpio1 RK_PC7 GPIO_ACTIVE_HIGH>;
+		vbat-supply = <&vcc_3v3_s3>;
+		vddio-supply = <&vcc_1v8_s3>;
+	};
+};
+
 &ufshc {
 	status = "okay";
 };

-- 
2.49.1


