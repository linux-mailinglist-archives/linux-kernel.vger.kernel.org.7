Return-Path: <linux-kernel+bounces-759429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EC9B1DD71
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35085669AB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5272248B8;
	Thu,  7 Aug 2025 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="V3vtkqtN"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E322E36E5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754594341; cv=none; b=dNdLUHJeYi8SvvZoAD4JSJe7b9DGayDGc3xM+cIR16q3SnGYWou0IEcxCio9a5PoBU37gyJdyzm8HhFfCI70T1jW+wbqpMwRYVm+u291Buy3C/JvUxKRbUHRzMUjnRBZepZGHqYzFiWvuIYUsIPEIhE+PUwFGheUjdytSFM3r9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754594341; c=relaxed/simple;
	bh=P6CYGkCBsS2/j/K0E7tBx1r/xDresPDft3Hy8CqhCSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=giboGZ5SIKHm0/30IuBXjBDjwEYK3nEaG46J9G3DwYbnTSXCKsC8tD38s3/KyAFeMXWMKtKocgqSlzpclc9qajRLflY5CVomKdUOHPfQhQ0vdGwC5X89JvNDM7whcuvPHXaLpFZXFfC5SZZNOj4L1n1hlLnsn5jREHfehKm/xSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=V3vtkqtN; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso974994f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 12:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1754594336; x=1755199136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TMojSpDs0TkBAWsUruscamCHlztjGhkLSL63bamzheI=;
        b=V3vtkqtNNN04JiPQ0ZJhIUhwRoB5EWtUW+BmasHBjB4U1p/NyWgpC7G/jYNZE5F/xD
         4MoBkJYvguw5u0+CwDDpvOG8V5AIfFT5hIs9ge8SKtTPU58SlZyua/kPLWwcFscRXIpp
         rX9y/yvsJgPz/vAKD/cLzGYHUmV58ZvQ3OBwc0ksvLdJefrF1RSME/bJnUXKP7/8Rso5
         p9UsF0BPtZMIV/CijsXostTaKgly2nQAl9Jrfu67QwvGN3/H2jUkPFLQgpZc9vc9+BFz
         fpoa2m/4O38aC3j+MOoVOLop/yoxbR9ppyvywkGr6fzbOFrYbLoJKrk0LdTU24lGvjk6
         uKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754594336; x=1755199136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMojSpDs0TkBAWsUruscamCHlztjGhkLSL63bamzheI=;
        b=WyEAmdP8/SdKmngzHyY5GWRFlxIgSO6t+Zsez9pFvIiVlmhNSWkjfCP8+AEZoLwgFm
         NybLnsxkt1LSpI0rDU6vMrY7FQTfSKbGOrzsl1Y7AYLCJnc/ttepKXIhBIwDiaVpWs3n
         ecwSkhN/74TwL7lE/YeTe3auH0oFH2wu56pe707Kjy25tqk1RFJt/w2YLIeNlgjpWpah
         bZ5qDgn3Z525V5wWGm7VDadX+wFGezxPp2FV4YV+bprL+LhxJkbmHBkcsYlndXSUBl+4
         dBCFUmNckJCLVsezeJrjLaQsAUVv188LaCyHSMFGwV2Pm/Tr8BJ4DquQPG5Ig4/+acns
         KNng==
X-Forwarded-Encrypted: i=1; AJvYcCVmzrKSebaBvWo30yzxqW8X6u6egKVmlnjU2qqlwITZ4YPDkAUpholeVmr/Eczkx0/CSMYqJZVB9sC5mYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlY+jn9J4LeXJE3UTJy/jcG9gtG1URzVLsgNZCxKBX7Mo1mU1h
	FyTfcxkEdCZN+LoxYrO0TiNuT6eJ/gCDQ7t/l8DDa7HmXxijcCWYnP7Y/LSdno0fS6U=
X-Gm-Gg: ASbGncsrM1X+dQOv5i0/lT1hWAnpzcsUuNmbCoVQmjb1PntN35pCP1YbJ712/Yj6Vem
	3BwH4l4NXf8XCNGBq4Fe88qfM0onqdTDFlNrmjl6BdO9rYzBIi5GZp06byCV+u/5eKAiR03zBpC
	5PqqFaXUaSFFkuBHoVDvLb5Az8KNM3XAW6E3gLYYV1L4yqLv59htWR1hE+jeZwiDA4hfgGoJ9x4
	kaDkmyrGhUJQ+8NNdPVZyjtdIlTS2VLKsVHnsVVZoWu4JZuFC1kGoG+g9CIH8ND13Wo1tE5N0Rt
	/dZCQlLhBy+PHWNuEv/hdEUbwRTFqTYg5JO56nh5awh3n1+p9siR6QQ01jdCO51yygz0CJB76nM
	OxGKIJbmO9GFxYDKLr1tkKGsYxk5UNVPHJdHBAEnmqplJeYmKEg==
X-Google-Smtp-Source: AGHT+IGmsZp5QGEdNPY5skMi/ehXySxn/2GJ+zanQmX1/LX2oBeqJ3fxjEoYN3cf/lF9eTayqWyhUQ==
X-Received: by 2002:a05:6000:40ce:b0:3a3:65b5:51d7 with SMTP id ffacd0b85a97d-3b900b54b20mr297294f8f.26.1754594335784;
        Thu, 07 Aug 2025 12:18:55 -0700 (PDT)
Received: from pop-os.telenet.be ([2a02:1807:2a00:3400:3bcd:db43:406c:324d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c4d02sm26988589f8f.33.2025.08.07.12.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 12:18:54 -0700 (PDT)
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
Subject: [PATCH] riscv: dts: spacemit: add UART resets for Soc K1
Date: Thu,  7 Aug 2025 21:18:17 +0200
Message-ID: <20250807191817.157494-1-hendrik.hamerlinck@hammernet.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add reset control entries for all UARTs in the SpaceMIT K1 SoC Device Tree.
UART0 was functional as it did not need a reset. But the other UARTs were
unable to access their registers without the reset being applied.

Although perhaps not needed I did add the reset for UART0 as well,
to ensure consistency across all UARTs. With the current-speed set to
112500 baud rate, it matches the factory U-Boot settings.
This should not give issues with early console usage. But perhaps it could
be a good idea to let somebody else confirm this as well.

Tested this locally on both Orange Pi RV2 and Banana Pi BPI-F3 boards. 
I enabled the UART9 and was able to use it successfully.

Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index abde8bb07c95..7a5196a98085 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -667,6 +667,8 @@ uart0: serial@d4017000 {
 				clocks = <&syscon_apbc CLK_UART0>,
 					 <&syscon_apbc CLK_UART0_BUS>;
 				clock-names = "core", "bus";
+				current-speed = <115200>;
+				resets = <&syscon_apbc RESET_UART0>;
 				interrupts = <42>;
 				reg-shift = <2>;
 				reg-io-width = <4>;
@@ -680,6 +682,7 @@ uart2: serial@d4017100 {
 				clocks = <&syscon_apbc CLK_UART2>,
 					 <&syscon_apbc CLK_UART2_BUS>;
 				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_UART2>;
 				interrupts = <44>;
 				reg-shift = <2>;
 				reg-io-width = <4>;
@@ -693,6 +696,7 @@ uart3: serial@d4017200 {
 				clocks = <&syscon_apbc CLK_UART3>,
 					 <&syscon_apbc CLK_UART3_BUS>;
 				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_UART3>;
 				interrupts = <45>;
 				reg-shift = <2>;
 				reg-io-width = <4>;
@@ -706,6 +710,7 @@ uart4: serial@d4017300 {
 				clocks = <&syscon_apbc CLK_UART4>,
 					 <&syscon_apbc CLK_UART4_BUS>;
 				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_UART4>;
 				interrupts = <46>;
 				reg-shift = <2>;
 				reg-io-width = <4>;
@@ -719,6 +724,7 @@ uart5: serial@d4017400 {
 				clocks = <&syscon_apbc CLK_UART5>,
 					 <&syscon_apbc CLK_UART5_BUS>;
 				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_UART5>;
 				interrupts = <47>;
 				reg-shift = <2>;
 				reg-io-width = <4>;
@@ -732,6 +738,7 @@ uart6: serial@d4017500 {
 				clocks = <&syscon_apbc CLK_UART6>,
 					 <&syscon_apbc CLK_UART6_BUS>;
 				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_UART6>;
 				interrupts = <48>;
 				reg-shift = <2>;
 				reg-io-width = <4>;
@@ -745,6 +752,7 @@ uart7: serial@d4017600 {
 				clocks = <&syscon_apbc CLK_UART7>,
 					 <&syscon_apbc CLK_UART7_BUS>;
 				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_UART7>;
 				interrupts = <49>;
 				reg-shift = <2>;
 				reg-io-width = <4>;
@@ -758,6 +766,7 @@ uart8: serial@d4017700 {
 				clocks = <&syscon_apbc CLK_UART8>,
 					 <&syscon_apbc CLK_UART8_BUS>;
 				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_UART8>;
 				interrupts = <50>;
 				reg-shift = <2>;
 				reg-io-width = <4>;
@@ -771,6 +780,7 @@ uart9: serial@d4017800 {
 				clocks = <&syscon_apbc CLK_UART9>,
 					 <&syscon_apbc CLK_UART9_BUS>;
 				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_UART9>;
 				interrupts = <51>;
 				reg-shift = <2>;
 				reg-io-width = <4>;
-- 
2.43.0


