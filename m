Return-Path: <linux-kernel+bounces-815882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FA0B56C42
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 22:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E363A189BD48
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36CF2E62CB;
	Sun, 14 Sep 2025 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chimac.ro header.i=@chimac.ro header.b="bFFaJw94"
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F512848AE;
	Sun, 14 Sep 2025 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757882647; cv=none; b=OHhl/PK+HBphGmrkviIl5oaZw+mKdMFXDDCFJlvKrf+rmWZ3xvAV9JOgP9MkZm45v1U0XE9zzgJYZbvh6PeEd8+lb+Q5lAjcSwzuDL9qsf2/YiAeXcf3aREvChGWB0T+fFOgyoB8cUbbNfbs3gwvJxgjnJJv52OTJhGVTZfxEE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757882647; c=relaxed/simple;
	bh=zlRL0aqqPu8FV33WZihiAyOLH+O4JklzuiAJK23fu0o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DSn5G7WIKcz5Z34HwHCDli3nL9AHpfV9gQPjy91oC3LV3NYpuGP1cHhSe8sCcqcXQQYJK14bRpua6oGfqwbdSqJxJYaZHdlH3IxMJYxJfFKAzs+5M+iCUNfhXm87tC3JmY8nnaBWARru83Sa5pYZPFcEEEKsWS4u6w0+ffrsaj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chimac.ro; spf=pass smtp.mailfrom=chimac.ro; dkim=pass (2048-bit key) header.d=chimac.ro header.i=@chimac.ro header.b=bFFaJw94; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chimac.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chimac.ro
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chimac.ro;
	s=protonmail; t=1757882643; x=1758141843;
	bh=4k2wvUidZXGm9nxO170X/NIchLZbbnseGG9mmcEP+hU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bFFaJw94g3MktzhyjX0mxxW8xxGJ6ypjvj/EX34xF5UKDEYvGzvc+ctnpdwkArf28
	 +c/uBqggqj7WsGhWli3PvmOd82NAFXGFiRFTvZrFLth6y0okDqbdbCyPh9KlxZ0i9X
	 8K5iLG6g/lBR5yIaGgfhZeX6be1hNpCTUz4j7bDGq05BFhNhdbsW8LG0fTmKxJ5G5P
	 wwGrWFMIVytuihscOFjmr+OaRyDUas58yDqkOo09gDUkseV0mNdR9e83ewHobx1Hiw
	 mAXJZKRQId2Rr4gXBuBsEJI41rKzYueX8Yj2YO/splMYlnX0nuGgohRKWx7dWF1hqt
	 +a12CJlstN51w==
Date: Sun, 14 Sep 2025 20:43:56 +0000
To: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>
From: Alexandru Chimac <alex@chimac.ro>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Alexandru Chimac <alex@chimac.ro>
Subject: [PATCH 1/3] dt-bindings: arm: samsung: Document gta4xl board binding
Message-ID: <20250914-exynos9610-devicetree-v1-1-2000fc3bbe0b@chimac.ro>
In-Reply-To: <20250914-exynos9610-devicetree-v1-0-2000fc3bbe0b@chimac.ro>
References: <20250914-exynos9610-devicetree-v1-0-2000fc3bbe0b@chimac.ro>
Feedback-ID: 139133584:user:proton
X-Pm-Message-ID: 744824239cd0443819c6a709d341ab1acfd156d6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add binding for the Samsung Galaxy Tab S6 Lite (SM-P610/SM-P615)
board.

Signed-off-by: Alexandru Chimac <alex@chimac.ro>
---
 Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml | 6 ++++=
++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.y=
aml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index f8e20e602c2059c827ed6a7fab3ac0d8ae4caab7..ae926239f5fa434e409ccc9e302=
66e9a1c9a8546 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -244,6 +244,12 @@ properties:
               - samsung,starlte                 # Samsung Galaxy S9 (SM-G9=
60F)
           - const: samsung,exynos9810
=20
+      - description: Exynos9610 based boards
+        items:
+          - enum:
+            - samsung,gta4xl # Samsung Galaxy Tab S6 Lite (SM-P610/P615)
+          - const: samsung,exynos9610
+
       - description: Exynos990 based boards
         items:
           - enum:

--=20
2.47.3



