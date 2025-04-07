Return-Path: <linux-kernel+bounces-592542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6C5A7EE6C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 22:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C891898019
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 20:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071B4223328;
	Mon,  7 Apr 2025 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTDEVXji"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3844D2206B6;
	Mon,  7 Apr 2025 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056197; cv=none; b=ki0MiJN2JmuKNh+1PITDewnSqc00blkW4/0Yvw+6kKfo/89o8rMM5g01gRzl4ywPUSWN1KxZTkgRQHOce7VWpzaWHgO/VpTW4yQTzRMyXD3peT+2qjj6TDmk30pLgbT0AO4sVNPov3oH4XPC88227cMQh6f4yg+PLPDRu1NxyCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056197; c=relaxed/simple;
	bh=3EKCRIQbwtBUlUpec8gu+1qG8QcOMBPBU2NPHsauFtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GL+orTKJhXN97UAvC/sgDjV9dMvLacD2Y2pYC/XiEcBM/fDV0g7ShqjdaTaUhFnSqqsxLysboQ9L7/+1cEBx00t8RyJuUcl91sbmdSeVZyprKmnVVEMnYOxMuxUPH3w16iri7/qo8UnnnnfPVGY5XgA49uRls86mPlYUY87knF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTDEVXji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5DDDC4CEE9;
	Mon,  7 Apr 2025 20:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744056196;
	bh=3EKCRIQbwtBUlUpec8gu+1qG8QcOMBPBU2NPHsauFtM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tTDEVXjiTaRg82h666TCev6oxyYBA3yNSMqXz9fKJ9VD03cxgpQxeGWjDbEc/fWX0
	 A4LdGH2kXT+I/jyDDQn5jBVg94xPRluaFfFX/m4gSGfOgGO91DWgCMIKE4QswKfUGJ
	 F0tmdkY9HEsHjuJikB9RcjIZ36qoe6affu/v+EAFEhkVcERilMPidqWFul/o9QJZjY
	 rjtVSYNE6xjcxfqLZ3bU4DoHze5QBMhDKuOqzhO97aSXZwOnm7jP+BceLLo102j1Q2
	 A14dfkCCCeEm6rz7TRHAKdrY/Hfq45WHdiaK7wo4/jvQ73dXep+Z7e+9L4wy/VfISZ
	 wDGguTS8N9QCA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EB2C369A1;
	Mon,  7 Apr 2025 20:03:16 +0000 (UTC)
From: =?utf-8?q?Duje_Mihanovi=C4=87_via_B4_Relay?= <devnull+duje.mihanovic.skole.hr@kernel.org>
Date: Mon, 07 Apr 2025 22:02:12 +0200
Subject: [PATCH v15 1/4] dt-bindings: marvell: Document PXA1908 SoC and
 samsung,coreprimevelte
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-pxa1908-lkml-v15-1-e83ef101f944@skole.hr>
References: <20250407-pxa1908-lkml-v15-0-e83ef101f944@skole.hr>
In-Reply-To: <20250407-pxa1908-lkml-v15-0-e83ef101f944@skole.hr>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 soc@lists.linux.dev, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205;
 i=duje.mihanovic@skole.hr; s=20240706; h=from:subject:message-id;
 bh=0HZYngyzaREGDzMJHsAvgTM3SsJmtfsUf/jVpOGt2SA=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDOlf9Bu3P7002btD6MyP5Ezu7c0/nsW96K749Oy29v7ki
 JX++8sedJSyMIhxMciKKbLk/ne8xvtZZOv27GUGMHNYmUCGMHBxCsBEgmIZGY58lVa8/3Plnflb
 NBbGLr9zMr+3THq/ONOCa+eXfdpSf6GZkeGgwoNX0o/Zvt9efsbgkG5E1+rZ4hkfpaTCDbzmFd6
 7t4gXAA==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03
X-Endpoint-Received: by B4 Relay for duje.mihanovic@skole.hr/20240706 with
 auth_id=191
X-Original-From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Reply-To: duje.mihanovic@skole.hr

From: Duje Mihanović <duje.mihanovic@skole.hr>

Add dt bindings for the Marvell PXA1908 SoC and the Samsung Galaxy Core
Prime VE LTE phone (model number SM-G361F) using the SoC.

The SoC comes with 4 Cortex-A53 cores clocked up to ~1.2GHz and a
Vivante GC7000UL GPU. The phone also has a 4.5" 480x800 touchscreen, 8GB
eMMC and 1GB of LPDDR3 RAM.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml b/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
index 4c43eaf3632e4ec8e7d9aeac62f7204e2af4405a..f73bb8ec3a1a1b9594eb059b72d95dcbf8c87c6b 100644
--- a/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
+++ b/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
@@ -35,6 +35,11 @@ properties:
           - enum:
               - dell,wyse-ariel
           - const: marvell,mmp3
+      - description: PXA1908 based boards
+        items:
+          - enum:
+              - samsung,coreprimevelte
+          - const: marvell,pxa1908
 
 additionalProperties: true
 

-- 
2.49.0



