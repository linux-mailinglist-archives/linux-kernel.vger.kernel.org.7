Return-Path: <linux-kernel+bounces-815905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A072DB56C8E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 23:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 214C87AC6F0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 21:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0AC2E8B7A;
	Sun, 14 Sep 2025 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chimac.ro header.i=@chimac.ro header.b="EFjT+GYP"
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch [79.135.106.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3F62E7F15;
	Sun, 14 Sep 2025 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757884853; cv=none; b=WQiKHR8+mnk6/FrQyWpNMmkaXEfByntiC6/IkruNmLH1vVwPdT1SIzFidV3kUAhw99kCBc/UL5AbxnRgOuiTgotKfGkUxwT/1bAFVAbrvN4GqHQ5N5LciAvqhtdZ68CicpKwQ0rnTa3YoJDT9NXuRjaQ3cjjN8wORxGI4gIZMWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757884853; c=relaxed/simple;
	bh=mmgJCfUyGE59PSXhluohTFxk2CSFp51DzKWgMlshUko=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MYeR9MUC/SeF0LXGlw/eoKvwnSHxPUENL/G5Klixvt6hUAhqePcCbV4qvww1sSvvkcfHSwRdMFOsFN3rMUD8nMvBWvMVttOREOrEtkswSQQ5wNBJmJTHvsW1ZrU2uMLA+QooHYUkJwh4egHEyJ7lK6y92jvSBkcvT/eV2q3iq5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chimac.ro; spf=pass smtp.mailfrom=chimac.ro; dkim=pass (2048-bit key) header.d=chimac.ro header.i=@chimac.ro header.b=EFjT+GYP; arc=none smtp.client-ip=79.135.106.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chimac.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chimac.ro
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chimac.ro;
	s=protonmail; t=1757884848; x=1758144048;
	bh=mmgJCfUyGE59PSXhluohTFxk2CSFp51DzKWgMlshUko=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EFjT+GYPLf7Fuy9LBws+HTJ22YxKwa15I1oUIQSH2bStoj0Prtx9I6TSv40dVAifj
	 mCT2qcc0lZTDeypszc+eBlOmJGRAyeA9furSO7n5APntt741nVGFkLg6pnAW7OBSHH
	 QsOj1R4pnxojfEo0QGrO1K5YxUrjqqyJ8tTXGNbsrUUaHxW1vHzjCjVy26Q0Y1TJHM
	 +iYJ/+fLSnCBqhkHrxEXkN5KObtYJZOXXJX+sdwwVMASaNF9n8ygp3tsnVpkOWcJRL
	 hQLm+sf/n7q62Z+7XDeT1LZMcjMbV0lkeL+bkVtAUUOfz5XW/y1l+GVYfOWHRLKSzE
	 LBPWIiFJhcDfA==
Date: Sun, 14 Sep 2025 21:20:42 +0000
To: Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alexandru Chimac <alexchimac@protonmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>
From: Alexandru Chimac <alex@chimac.ro>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandru Chimac <alex@chimac.ro>
Subject: [PATCH 8/8] arm64: dts: exynos9610-gta4xl: Assign clocks to existing nodes
Message-ID: <20250915-exynos9610-clocks-v1-8-3f615022b178@chimac.ro>
In-Reply-To: <20250915-exynos9610-clocks-v1-0-3f615022b178@chimac.ro>
References: <20250915-exynos9610-clocks-v1-0-3f615022b178@chimac.ro>
Feedback-ID: 139133584:user:proton
X-Pm-Message-ID: 817b1c8826d8fad866384fcd032225ea749d553a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Temporarily assign DISPAUD_DISP gate to simplefb node,
until the Exynos DRM driver will support this SoC.

Signed-off-by: Alexandru Chimac <alex@chimac.ro>
---
 arch/arm64/boot/dts/exynos/exynos9610-gta4xl.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos9610-gta4xl.dts b/arch/arm64/=
boot/dts/exynos/exynos9610-gta4xl.dts
index 1a09d5e8ebaa130e9cd0b7f3266ee2c9dac4cf9a..e08a3603c27396c96dc2e9d5186=
be504ff7ce3aa 100644
--- a/arch/arm64/boot/dts/exynos/exynos9610-gta4xl.dts
+++ b/arch/arm64/boot/dts/exynos/exynos9610-gta4xl.dts
@@ -29,6 +29,7 @@ framebuffer0: framebuffer@ca000000 {
 =09=09=09height =3D <2000>;
 =09=09=09stride =3D <(1200 * 4)>;
 =09=09=09format =3D "a8r8g8b8";
+=09=09=09clocks =3D <&cmu_dispaud CLK_GOUT_DISPAUD_CLK_DISPAUD_DISP>;
 =09=09};
 =09};
=20

--=20
2.47.3



