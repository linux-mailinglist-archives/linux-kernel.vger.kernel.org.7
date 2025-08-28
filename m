Return-Path: <linux-kernel+bounces-790425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54512B3A6FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15FAB3AEBF3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A33327797;
	Thu, 28 Aug 2025 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tk8fhy3a"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2440E239591;
	Thu, 28 Aug 2025 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400069; cv=none; b=C1lR8GZ1FULk4USshPpyr0RMqVvInV7XIApFY7vyLyYsg2aFLqFo5OZfAVDIoJW0+3rKAKvlqdK7yDdbjrhEnj/5z0lxnQMwR7hSwDsa8+jS4WzKvNzGgBRkHqKaWEmV5nHoRujJv521HwvVc0Gr28uhFkOATHV7RR2/b6MDJiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400069; c=relaxed/simple;
	bh=viNyCIWqe5KCLAeA6tui7LQ8rd69iw2R5ocI3n/Zj9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F5gwdIDZjUr17JIAdpiOlIOWcK4Najv++eOka0mTqcVomCdsgpCYEKBDVFGOua6ouqutUP6dsSFyT2ypeEOh70fIrt6IsCNUOOik83olaxr/AznJQPOi+wPUjIbOf0qctq6bhI4puos6Lr7y0aFsbghukiJUd594iBjg0DvzEa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tk8fhy3a; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso7535355e9.2;
        Thu, 28 Aug 2025 09:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756400065; x=1757004865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o/S9spYbGe0FPlB/C0yhWG1tadTkgGdkbhIgR1f5N4Q=;
        b=Tk8fhy3aPiJSbq3SYwCV0AjA8VigiD1WxG1u4eyvzr7kITgXDzw9DXqMPsuEH8RVy0
         y12XX08MGKUMFC96ejnIu/w0FC97p3RODcd+Ut0bfdf045BhL0dDVtKQ62W/rIkcQ8eR
         2JTMhfRT61ftgG4hqJN5U1UxLLqKl9Ucj0D1poSC1FYowJOFEyiQbbrw2SO/miJRpJlp
         apSYCyFaKmVMZsLPKDa4V4wcpCGTq3w6BY9lVB6FhBR4IYcQRzjKdo45cYTA/deecLrF
         9L1dy3W24gGKOEIBFK5LrUpKACmpKM5oDASsBVX752r4LBdYCCNzfeiw/KnO/tnhL2yS
         n5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756400065; x=1757004865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/S9spYbGe0FPlB/C0yhWG1tadTkgGdkbhIgR1f5N4Q=;
        b=omdAPDAi6l1nhpzLMu/iIB8nJaho5bOZyistGQHGIrmp5ov/XVAl2mfQ4VTba6d49s
         bi4AORaMr1+mg3keUB4MjC8cKCaYjMycewYOUCdrseXHJ9gFQb53J67Bkx5ab5pbqJLP
         D7/aH9mKvLVxRha6Y83enETJ1VK03gyfHBVuL/w+k3Ibgoyq+O6n2oIaF/1YNUVWkxPl
         nOouZ/3pVe7Ynz1cPPoJbD9ya25skPbFoq89NoHWT9E3G0cD6zgVBw1W/g4fJSx77zHW
         vtyBUJ93BxFr2Vb5Sq5l5fdfgd3lA3PK1ViGNeJ8DGNVifki34QxIjxOuuyw88h5rrBI
         fcyg==
X-Forwarded-Encrypted: i=1; AJvYcCUidOFDcuVVrHIX1tIs5Msm8qbR9D0P5Luhreyn0zeYQ05/PyfM4MyEmgLZfJyTssnS9N9KwVZy1Q7H@vger.kernel.org, AJvYcCWngTs5cL5uw0t7EbT1CODHrEas+cXUFw/qQfthGwJ6cChx6nOWNCIBOzdplxZWKC7+0tuwF6qTN+m+dDse@vger.kernel.org
X-Gm-Message-State: AOJu0YyKwHq/2C23o0ouyJSnSGAqNmIUGH/j2FmkCIj+/EqS7hcV7RvH
	OFo/8afxMvDxg2MaxjQ4pAQo1Ek/XDlRRkgL8XJH4GIurZIH8K0Z4JH6
X-Gm-Gg: ASbGncuKLKnLSVymZr5AuxyYsOfxylC6MfmEi8Gyxj7O5WvaBhBv/pIpz8iaTj3uprH
	4/9IdwH15ft0lZZa2XKtlDM0XsKkpq6RCmQcdpDsVPOmGtNMaGk0iFOhrjTNebobxx8oY0EeWnN
	RQVWYe7y6jmD7YqQ55oeYI0sCoy4nMb6ekp+19tSedYC3vvL4G14aDGG3eNov69Z3UN+9ksmLuT
	vf3R1tl95R3IVjhQv5ArDVTx/6mnofUaYXpRgzlTZNLyYNKbrsnoIKjmvetwfHwjVkEkUJO0AJa
	LP5O/8YIbPD7uMY4Z5XcYlFip3UM137f0Xba7V5NCTPMGsm6S+aGHAx/kLdMnHxrcyIJ2z8LW+Y
	th8Hu03r3n17yBG2UYQnrA99MPis=
X-Google-Smtp-Source: AGHT+IFM9OS5cZ7H0ceO2f7sAP8sszHuEF9xmtBJC46ZU809/y4cnHB22I6xxBweh71b6M2mv9XnsA==
X-Received: by 2002:a05:600c:a46:b0:456:19be:5e8 with SMTP id 5b1f17b1804b1-45b517d459dmr207436525e9.20.1756400065247;
        Thu, 28 Aug 2025 09:54:25 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf34491a7fsm11393f8f.57.2025.08.28.09.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:54:24 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alex Bee <knaerzche@gmail.com>
Subject: [PATCH] ARM: dts: rockchip: add CEC pinctrl to rk3288-miqi
Date: Thu, 28 Aug 2025 16:54:21 +0000
Message-Id: <20250828165421.3829740-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Bee <knaerzche@gmail.com>

Enable CEC control on the HDMI port for MiQi.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3288-miqi.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3288-miqi.dts b/arch/arm/boot/dts/rockchip/rk3288-miqi.dts
index 20df626547bd..a5f5c6d38f80 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-miqi.dts
+++ b/arch/arm/boot/dts/rockchip/rk3288-miqi.dts
@@ -145,6 +145,8 @@ &gpu {
 
 &hdmi {
 	ddc-i2c-bus = <&i2c5>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_cec_c0>;
 	status = "okay";
 };
 
-- 
2.34.1


