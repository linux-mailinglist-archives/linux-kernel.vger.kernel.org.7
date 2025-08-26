Return-Path: <linux-kernel+bounces-786200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C955B35670
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282773B9DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0CD2E228D;
	Tue, 26 Aug 2025 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="axxKgrpi"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A582820DC;
	Tue, 26 Aug 2025 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756195754; cv=pass; b=DgscUYm43V4Iotv2MFOo8MnF9lpDZaP8D5EEOS+daEr4sg8yxllvGkkzaCcoOQZz3LHPRodDC1plWqXOX2qO5h0OIvRHy/1cyvOKv10zZZ4koqkdApB30Gyqase4KBAb4+7khU3kYvXHI6SIVL9fiwdfcXLa+xBomf2Z/u5Q+yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756195754; c=relaxed/simple;
	bh=pS0giqbxEtwfcfpUpDjAvN9dQBh7w0iJSZvbZZgwE8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GpDKsq4S7r7tuKFbpq6Ptv4/Z2YRo8clz7NM54Bt0Ok9FUY4qTXSkkNU32pm9Q2efn6oV677AmJm/mkOd7BmsnLEHSMcbbIEkxUv0Icopai1dR6vtaLNt88iecWQkVnA985rUKIQOkLLSHuHtGZ1qlDboK84oZyjLRSDoh9WH0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=axxKgrpi; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756195730; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HQT7tDXC/yWwR8w6bz2TMYXR6rQDcAJexCzbhZsVebCfj85wkK5c3mZ3rbJEX/FjfBwowuPO3wIxnTdPhamDRigWpije91EZViPco6iyGcgOxowyy4QGkvm1jQ4nB4xgm/zeqrPJnBd6UMWJaZA+szvgV9N8iNMuPdvfDaAz0DA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756195730; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PjionKT6OwbRK0J6AUKOW0mIzZnze/DXEyeszRo0i8U=; 
	b=HzmJv0eSVmM8YX/NhQ9J9hvL8MyPfepRjKpKhV991yQsSbMAkyYsOS2jabB9Vkj4CvUgFU7EG11brpvOrZMQY/XQF3NX0frTyK0RO51sQo6LKRV5rX+KqOeBO/6DKlAQaNvzcrizUUEmIHD0H+VCKzFYM5ijKI6Iw1oV245Jx0Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756195730;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=PjionKT6OwbRK0J6AUKOW0mIzZnze/DXEyeszRo0i8U=;
	b=axxKgrpiEQTwmD048MbUk1jSWzdYLEB2NtX7ls5Q/aX8gtKFMR8+ffhqKkkKkhsy
	D2YiMEz0zgRDEWilKSx6Rr6/0paNgItNWJ8Rg2o4YZ8QEqyTUA6pUlCx8ILpAuVhEdd
	rsDVBcgr1BH5CIgHEp0MstCmtxzHj7dCshUAU+/g=
Received: by mx.zohomail.com with SMTPS id 1756195727126157.99311646141769;
	Tue, 26 Aug 2025 01:08:47 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 26 Aug 2025 10:08:36 +0200
Subject: [PATCH] arm64: dts: rockchip: fix second M.2 slot on ROCK 5T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-rock5t-second-m2-fix-v1-1-8252124f9cc8@collabora.com>
X-B4-Tracking: v=1; b=H4sIAINrrWgC/yWMQQrDIBAAvyJ77ha12Eq+UnJIdG2XorZqQiHk7
 5XmOAMzG1QqTBUGsUGhlSvn1EGdBLjnlB6E7DuDltpIqw2W7F6mYSWXk8eoMfAXVSDjzGyD9RJ
 6+i7U9X97Hw8u9Fn6vR0S5qkSuhwjt0Gs17O6YXEXGPf9B1vV+J6TAAAA
X-Change-ID: 20250825-rock5t-second-m2-fix-1fe5c5b8f8d0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: kernel@collabora.com, FUKAUMI Naoki <naoki@radxa.com>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

The Radxa ROCK 5T has two M.2 slots, much like the Radxa Rock 5B+. As it
stands, the board won't be able to use PCIe3 if the second M.2 slot is
in use.

Fix this by adding the necessary node enablement and data-lanes property
to the ROCK 5T device tree, mirroring what's in the ROCK 5B+ device
tree.

Reported-by: FUKAUMI Naoki <naoki@radxa.com>
Closes: https://libera.catirclogs.org/linux-rockchip/2025-08-25#38610630;
Fixes: 0ea651de9b79 ("arm64: dts: rockchip: add ROCK 5T device tree")
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts
index 258c7400301d7f77517197ab433946bbfa39cf63..d061fbc897552401df1a73da12fc0614d7edc2d3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts
@@ -68,6 +68,22 @@ &pcie2x1l1 {
 	status = "okay";
 };
 
+&pcie30phy {
+	data-lanes = <1 1 2 2>;
+};
+
+&pcie3x2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie3x2_rst>;
+	reset-gpios = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie30>;
+	status = "okay";
+};
+
+&pcie3x4 {
+	num-lanes = <2>;
+};
+
 &pinctrl {
 	hdmirx {
 		hdmirx_hpd: hdmirx-5v-detection {
@@ -90,6 +106,12 @@ pcie2_0_vcc3v3_en: pcie2-0-vcc-en {
 		};
 	};
 
+	pcie3 {
+		pcie3x2_rst: pcie3x2-rst {
+			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	sound {
 		hp_detect: hp-detect {
 			rockchip,pins = <4 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;

---
base-commit: 89d926fa53d0a6c257c4e8ac1c00c3d9a194ef31
change-id: 20250825-rock5t-second-m2-fix-1fe5c5b8f8d0

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


