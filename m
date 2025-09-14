Return-Path: <linux-kernel+bounces-815902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CB9B56C83
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 23:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C46B3B6FFC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 21:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217E72E612F;
	Sun, 14 Sep 2025 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chimac.ro header.i=@chimac.ro header.b="Zg3jQpfL"
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7A92E5B36;
	Sun, 14 Sep 2025 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757884821; cv=none; b=bnJH3ua+rnF8jT+vatEWSZwupZ3CIP2UH8pfMOFQYO3fjO2nOhngLEsPLWlb4p0g7dsGH4dDsdRJVsUbYFfYbpjKoAPYDiehnD5+EUf8wKEJ84FpKRx4GzT5fOU66TJsntbUvKFuQjYdPZkQOhISSXWTQfbn+EVHrvpDj9DzKBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757884821; c=relaxed/simple;
	bh=M2Gl0h1IbNc0ONXLAYgn4s7jZx5zqBBGfF+tL32SZ3w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BghBsOgtt4qbx39jz7JEsHAl6nmjIZ1MrCZqssGFy/IbSg4eLHc7XtDkNVABvNs5EOkvI/6wT7SFu6YGJRjIL3jYAIkWWA0ScUaWEE8O3qB3BfEG/yRI4fElACHdFpTHea1hGGxtvbxGP0ELgzl2TQwJJI+EcSf5TpiMAgR9D0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chimac.ro; spf=pass smtp.mailfrom=chimac.ro; dkim=pass (2048-bit key) header.d=chimac.ro header.i=@chimac.ro header.b=Zg3jQpfL; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chimac.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chimac.ro
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chimac.ro;
	s=protonmail; t=1757884817; x=1758144017;
	bh=r6Y2Gkn706akrIKg6YESStK0AnOYg63HDq/ISSMQOuw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Zg3jQpfLTiNwnSTWvTuYzLoYFJY5wbKi6WuQ5nHrIXkpLfX13TSxMg8QQ639lGF3W
	 c4WOinvEQjYbgzWczW6rpsm2Bl67kLoG+kc8y8J0gxjXQW9LdJGBnYi/4kpqfPNsV3
	 PCjFTsKlTsv0yS990AWMAGWSFbTLtxctVm/OgcUPRbYP3oQYA5AIoe8uwoFGkeTL6t
	 9YDX0/diEPlXTIy0JrpUo96tSx4BW8YGWfz9d9IfdV6HsJzXQd2Nfw1p5XfX3xso4v
	 YpjqmKdK22Khoe8sLupBHnGcLIhCE5cWn/kWBCPxxgq53pt4WJyNsYKtZ89wT8aVAy
	 h75FKtCqA1V2A==
Date: Sun, 14 Sep 2025 21:20:09 +0000
To: Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alexandru Chimac <alexchimac@protonmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>
From: Alexandru Chimac <alex@chimac.ro>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandru Chimac <alex@chimac.ro>
Subject: [PATCH 5/8] dt-bindings: soc: exynos-sysreg: Add Exynos9610 SYSREG bindings
Message-ID: <20250915-exynos9610-clocks-v1-5-3f615022b178@chimac.ro>
In-Reply-To: <20250915-exynos9610-clocks-v1-0-3f615022b178@chimac.ro>
References: <20250915-exynos9610-clocks-v1-0-3f615022b178@chimac.ro>
Feedback-ID: 139133584:user:proton
X-Pm-Message-ID: 0485798802bb0d7269f0f916ac2aa86437c9d201
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add bindings for SYSREG nodes, compatible with the standard syscon
driver.

Signed-off-by: Alexandru Chimac <alex@chimac.ro>
---
 .../bindings/soc/samsung/samsung,exynos-sysreg.yaml  | 20 ++++++++++++++++=
++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-s=
ysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-s=
ysreg.yaml
index d8b302f975474a87e4886006cf0b21cf758e4479..9f759e457a0acc2870adfd077d3=
3870593cf7b83 100644
--- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.y=
aml
+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.y=
aml
@@ -30,6 +30,16 @@ properties:
               - samsung,exynos8895-fsys1-sysreg
               - samsung,exynos8895-peric0-sysreg
               - samsung,exynos8895-peric1-sysreg
+              - samsung,exynos9610-apm-sysreg
+              - samsung,exynos9610-cam-sysreg
+              - samsung,exynos9610-core-sysreg
+              - samsung,exynos9610-cpucl0-sysreg
+              - samsung,exynos9610-cpucl1-sysreg
+              - samsung,exynos9610-dispaud-sysreg
+              - samsung,exynos9610-fsys-sysreg
+              - samsung,exynos9610-g2d-sysreg
+              - samsung,exynos9610-g3d-sysreg
+              - samsung,exynos9610-peri-sysreg
               - samsung,exynosautov920-hsi2-sysreg
               - samsung,exynosautov920-peric0-sysreg
               - samsung,exynosautov920-peric1-sysreg
@@ -93,6 +103,16 @@ allOf:
               - samsung,exynos8895-fsys1-sysreg
               - samsung,exynos8895-peric0-sysreg
               - samsung,exynos8895-peric1-sysreg
+              - samsung,exynos9610-apm-sysreg
+              - samsung,exynos9610-cam-sysreg
+              - samsung,exynos9610-core-sysreg
+              - samsung,exynos9610-cpucl0-sysreg
+              - samsung,exynos9610-cpucl1-sysreg
+              - samsung,exynos9610-dispaud-sysreg
+              - samsung,exynos9610-fsys-sysreg
+              - samsung,exynos9610-g2d-sysreg
+              - samsung,exynos9610-g3d-sysreg
+              - samsung,exynos9610-peri-sysreg
     then:
       required:
         - clocks

--=20
2.47.3



