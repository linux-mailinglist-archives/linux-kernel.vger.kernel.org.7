Return-Path: <linux-kernel+bounces-791161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C62AEB3B2AC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180851C84731
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D564F2192FA;
	Fri, 29 Aug 2025 05:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CA64r+20"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12E81A5BBC;
	Fri, 29 Aug 2025 05:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756446355; cv=none; b=Y7pPsr3XyQ3W4JZh9dzJ9ipz82YUYHp10YtcuEF/QkkxDTRpk9WQglFUqt6UA7FKwermP4EJ0cD+TxTxXZTdD8jH3osY5/y/xk0kK2uQdvO6qpWF4LmWQNJ3/J8EjlTSkAo4PZVqpNpLfKnrYg9wJ/TpoJ/Rjyeiwyys89H/FEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756446355; c=relaxed/simple;
	bh=zxu8J2WrYuFMRqqAxh+B9j3+Cit4UuUGVXUSne1R0RE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E1EBRFlm3B1n2FADhQ3N5NkoUT/MbCzj+OKIjLhmN3m9Hh2tD/UE9p4ohL/3Y3EwrCcNeZ4P5PHXLew3C3Wjl/eyf7wVyDI17PyoqZaqK2FvKSdzS6ifrujE3rWj760+T5WFDkrc1drsp1qAIRD5gBBG1cyFHjKNy+fUVlBxGZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CA64r+20; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b0bde14so9970855e9.2;
        Thu, 28 Aug 2025 22:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756446352; x=1757051152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GvFqQMURmL14u9c97vY/ctIINxRzc4H/Bt6epNcKPBU=;
        b=CA64r+20uppb3Y34EXuaA65sv+jrJUAfd9vA7F4tqRefsw8vr7Obq8KFsy6mU3dE/o
         Vuz3l01ZDiB7w7aHo/DrnBh/PJ9D1n0ng6EazFyT1vK1wYhPhYr21eiyXXC1cXP2esC1
         rz1PkxBJf6PW1ivMOc5J5mmQvdDn4MPlsHRO89slD2CosdT9RKA1K1wE43I5EqKW/nKE
         um1hOaj2JKsIp17bf0UJGWvioNR4Ms3SpV/ytihRFo27+RR+brLxHu3kRvFLS+j5Sx7l
         9rHLTPa2C35Tot9N8W/K81/6GQu4cD/XkE76PfLDp9Xu4yYpIroSi+iLEU00NigAqnMI
         fn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756446352; x=1757051152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvFqQMURmL14u9c97vY/ctIINxRzc4H/Bt6epNcKPBU=;
        b=OQQdt3NIqhuopSmj1dcB2z/VcERodILTKVgem7Cx3l6/TltveMsWQpRi6m8uQcGs+t
         vyDLscjTgcUjVtqVGntmF39ZPhBYMc+ZfO1Pwe4EeiB0f9yc1wtJ0h0npDEEZsFHDvic
         fKQpXO/3dmN/9kT9IcXfYaBI+TKQ6cwtO3bdzzJbblMWnGvwPG71A5Rbv944E43wnhAz
         lvpBexL1znrWJqpZv0jo6PsTczbAZQdnObBF+zO75yoB9v5NO5BVsJEKckDwlGLuB6nh
         30/G52N3BPdWR5dMdixzqH1x9vMUjQ0n0o5iL44hhYBjz13pnSSn4ENsU5149I9W8AAy
         nDPA==
X-Forwarded-Encrypted: i=1; AJvYcCUdpqQksNxa0mR4Y++/c/TJbqEixszVUSMq4fEpGPoHUsfMLtdeLl74/emKelSs+VNbQLm5kHawV5oz@vger.kernel.org, AJvYcCXU5RE9ZxD5BCdnFr1gmG90PnZGPWmgepDCpkw7pZT6iG/HhsCgo0SUn+9LWl9z6z+Ns/88lqYpcFFA8puR@vger.kernel.org
X-Gm-Message-State: AOJu0YxgDyR55+jZXy6E8YyWVifZkJM4U/YoIsKC1EcGXU6sTDeytXao
	wWguSJEmWExesmwJvgt/hSRY40u7g8zNFOOdfLwwqENIXR9TlPq+GDCaV7mDDA==
X-Gm-Gg: ASbGncsnx+ZcZg+6olq6tQ2ZwQOMfdjNN8bzwfBSypx3aWVdY98lXFyipzqX3ygYQCf
	LFVAL34+2eEkkJy0nwAhKrRUkkzgUJa+eebJ9ncC87UYdcyOroEQHmF5AmGaFNuWimsS4Fbsk27
	FpLYGxCT0R+npP4BDgDV+oGqHGLbY+d//P2uFWKNvGaSxeLnHDkoVcmZPWiQPQ/A7V9sxxzQMJG
	q+qIpqLofWUXSz/YweWA23w42iVJXUZeQTG/WYvtlma4Jbiri2r2D8RpLrGJY7N7Kg8ZJDklGj7
	dD1g57Tjq2G2ccoEBxvBETGWMVOlzwUTDszpOyxemU0Dxnkm1gjrrlJhfZnLCfD8luVysPcYdG9
	OfPPDaBy3eUwVPiARmWIBm7xjPqI=
X-Google-Smtp-Source: AGHT+IFCNnOTYeJKgtAudAIEV7Vht0gJlV0c6V/BdAzJw9IrIqsKSZY6cnSXqd7x5MJsuSpzEld5CQ==
X-Received: by 2002:a05:6000:2891:b0:3cd:96bb:b948 with SMTP id ffacd0b85a97d-3cd96bbc28fmr4602815f8f.47.1756446351739;
        Thu, 28 Aug 2025 22:45:51 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7f14bbsm22600945e9.8.2025.08.28.22.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 22:45:51 -0700 (PDT)
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
Subject: [PATCH] arm64: dts: rockchip: add IR receiver to rk3328-roc
Date: Fri, 29 Aug 2025 05:45:47 +0000
Message-Id: <20250829054547.4053558-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Bee <knaerzche@gmail.com>

Add the ir-receiver and ir pinctrl nodes to enable the IR receiver
on the ROC-RK3328-CC board.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
index b5bd5e7d5748..aa1d5a6d7fd5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
@@ -84,6 +84,13 @@ vcc_phy: regulator-vcc-phy {
 		regulator-boot-on;
 	};
 
+	ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&ir_int>;
+		pinctrl-names = "default";
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -300,6 +307,13 @@ &io_domains {
 };
 
 &pinctrl {
+
+	ir {
+		ir_int: ir-int {
+			rockchip,pins = <2 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	pmic {
 		pmic_int_l: pmic-int-l {
 			rockchip,pins = <1 RK_PD0 RK_FUNC_GPIO &pcfg_pull_up>;
-- 
2.34.1


