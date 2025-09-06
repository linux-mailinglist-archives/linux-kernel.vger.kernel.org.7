Return-Path: <linux-kernel+bounces-804165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F1AB46AFD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 13:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454C93B97AA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 11:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9580284684;
	Sat,  6 Sep 2025 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOfs7rW3"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEE523C51D;
	Sat,  6 Sep 2025 11:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757157639; cv=none; b=hADS5AB0kTYJkhHzMirHd7aUf+F1NDohQRJ7sbuWaCsH4rFlYvspSNzquTWi1KxTLUnfC1H26LTNgbgZwmokXEbUQdg+AvBmdMHuEth8obhM84utBx8rhW7JJbTi8DvP1zNBVqzaZzW4Ur4wQXQGML6G/D/LXdIcx1qS2IrhezA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757157639; c=relaxed/simple;
	bh=NP25UIE0+x01UR7gmr+DnY3vcN0HGnNza7b3p0mgBVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VbzEnRa24pIIevkI0lMh8aDIGtmw2VHgzUG6wFgzbQC9h2+DbdDsx3Y8QjoK476KQbYGjJH+0vCrbjj2g8eeTrGwFThWv+hQKZcwX4hZKQwnIKH+rBNZILNyKl/J9GchFVxlmuyq1OCL+5S5T9ntfcHSy7Rjjpa3ZPN9+KLtH2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOfs7rW3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45ddcf50e95so6088255e9.0;
        Sat, 06 Sep 2025 04:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757157636; x=1757762436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKcui5kqlHLRoGonq2UNIvF4/eUOOrD4c41D8AoISsY=;
        b=DOfs7rW3tZWnJhdqi1A+uexVJDeEjYbylFP9Atton2JwOGNkd49uChy2L4AeyxEKKz
         s3ohuaMQDajEdEd3tVZPOP7nKYFXapWygwz+aUBpJREo9qfTKdj0qGsiXpvoYoseKUpq
         ooI98j5VTWD9F5CfYUXK5DFQMFtvIhD7djImpy8gi4rti41PmHRFSG6p22NwdeNur6GC
         Q3H0/C3qVPeXeEgbEy70vsmmwUYujeY23zBwCbQuusuLOVqx2ijtKAjaZxXN3V/PHsvQ
         eZk4HKFeLcXyj7W92A+bGnneGVS3sRBtD8C8TP8xaKIp6EmWgK4HN1yMNKy6sPdE5E4z
         4sIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757157636; x=1757762436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKcui5kqlHLRoGonq2UNIvF4/eUOOrD4c41D8AoISsY=;
        b=J/ubfkkUBXki4Cg+2cLKOLsry1JgZMSJmzerqDczkOk0kSjZJCO/Q/RJigXS/NUlX/
         mxvr8JJcF5Xp/O9yWpjWaIrht8ZQ08o3Ulzn3I8kH9+M3OJaZAubgPxvNYzG9YLZjlYh
         UR+OKDxeh14I9D/iPr1Yfuv2M23/kt4cdiBU0WsIMras+tsk7Ae+M4QwD4rIqOPpCpzC
         +amMCwtrULrC9bj0HBm0XQR74n2SwB7Oqmb7qex8Fn+2RpMZgLktBEqzgDnUyUxu2YJP
         A/27uZxZhEYYstTUOtmYdV70IlHsftZgI1J179oc4GfdnP78YKk4SOZ1cQCKROKAMwcN
         Bx5A==
X-Forwarded-Encrypted: i=1; AJvYcCVajQRsV/rON880ff3ad6bGpHKixMSdeZEA+/FfF9spyY+o8XPXBMZ0UrHJGELarXPqc6YuZDfT/r7S@vger.kernel.org, AJvYcCXAg3scMzlrHKSASsNODpw7BRXLa6/hbQ+1EADdE6WOZhbbfpAqqw3IMr3I17TTilrq3Rp9KjWGict0/VzB@vger.kernel.org
X-Gm-Message-State: AOJu0YzK5bWMIRGNW2kflgKIW6u2WOiK4Q3re6bN3FzfSCevRtr8eD0u
	LcWybqVmScuM2TXu570XWsDDCP3kbGHYGLosGdnaOb90yT3CTkN5TbXQ
X-Gm-Gg: ASbGncvOtiW9ehTJCeI52KBKqhyGcuXV4uD+TIVUHJfMJk5m5bbGQr2uJCnlWSgyiEh
	+wyqIM4HVY+mtC624cFvtCfJHSMnXh6+NiWPehCXnINovTmUr406fUt/WvOj6YBznxb+vDMD366
	rB8rCvE02UvEq8Ign6kmrIpFKOsCOh5mbVrlRFq3eCHPqOf6mJYgPt1Z6+Y55CYtZLK6FnnP7iY
	pjlCaGbmXssxhD+9oFKQPhsWUSUDa6Kd7YlK3eYQQ+TAAHj33+YKFd25hDDnUiZiXG7vL0iYMaH
	LTmxHJa479i9HCzuTIjNiGINDi48xmokTZY8V4B6f1AfUOBuK9zYQdEHc49FGj52CwqXnU+Xs9t
	Zpd6zy5yFelSaJ+BYiSVNIalGz2f5fW7wrHlEhQ==
X-Google-Smtp-Source: AGHT+IFv8cE90LFD5yJ/sYFcSqb8G8+DIxE6PJiMga9p7H+75K2qsCzvml9epgjQGTdfAnAhHf5Ufg==
X-Received: by 2002:a05:600c:1c0d:b0:45b:9961:9c01 with SMTP id 5b1f17b1804b1-45ddde832ebmr18317335e9.16.1757157635521;
        Sat, 06 Sep 2025 04:20:35 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de18f4824sm6646655e9.10.2025.09.06.04.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 04:20:35 -0700 (PDT)
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
Subject: [PATCH v2 2/2] arm64: dts: rockchip: enable the Mali GPU on RK3328 boards
Date: Sat,  6 Sep 2025 11:20:30 +0000
Message-Id: <20250906112030.1829706-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250906112030.1829706-1-christianshewitt@gmail.com>
References: <20250906112030.1829706-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Bee <knaerzche@gmail.com>

Add a gpu node to the rock64 board to enable the Mali GPU and
move the existing node from roc-pc to the shared roc dtsi to
enable it also for the roc-cc board.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
Changes since v1:
- No changes

 arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts | 4 ----
 arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi   | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 4 ++++
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts
index 329d03172433..c0b7b98ff788 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts
@@ -44,10 +44,6 @@ &codec {
 	mute-gpios = <&grf_gpio 0 GPIO_ACTIVE_LOW>;
 };
 
-&gpu {
-	mali-supply = <&vdd_logic>;
-};
-
 &pinctrl {
 	ir {
 		ir_int: ir-int {
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
index b5bd5e7d5748..7eef6f7f108f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
@@ -160,6 +160,10 @@ &gmac2io {
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_logic>;
+};
+
 &hdmi {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 5367e5fa9232..592fd8ca21df 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -152,6 +152,10 @@ &gmac2io {
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_logic>;
+};
+
 &hdmi {
 	avdd-0v9-supply = <&vdd_10>;
 	avdd-1v8-supply = <&vcc_18>;
-- 
2.34.1


