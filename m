Return-Path: <linux-kernel+bounces-825780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46738B8CCCF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 18:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37A964E155C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 16:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF7B3064A0;
	Sat, 20 Sep 2025 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUrBZQkD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60352FF151;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385493; cv=none; b=Y+bELuegfZl0KQ10NiJhovL1DAEAEsgEFvZMKoIIzW+yHiGavoPUN5+NZ2ZZdpH64NS4gWuXZhZI4TPSqjYxU5XN3z3tiZEZAddIX0GI4EtXxWTWTc48CDdlIro+63nGu30TEu0ArShgGosVDTUhjKeLf422YwRowhug3poPpx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385493; c=relaxed/simple;
	bh=Yw21Bj4O1CcXJALjZystKMv5JLsbgLxSaC0YPKbfZUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h3Op62QR9OUBPlPo7I1Tj9L2NJwgYsMGzp3jxDpVwM1niej6m1z/BVuACoOC1Ew2ieGuMSzzh5ThtPoV0SmHNEekyJfamazD4ZAgReBLsvePfvJh85/ZSwyYArKGD3mVuNamJ2OxENUVugbnkSuIYfMKTIAD5uDvl6gpWUa9EOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUrBZQkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57939C116B1;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758385493;
	bh=Yw21Bj4O1CcXJALjZystKMv5JLsbgLxSaC0YPKbfZUc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XUrBZQkDTUcos1EmYXcH+Gg5TepAB6pxcKoAuBd07gLLrxWGxMDxQnFrmHnTkH6YJ
	 n2ObM5LqX7E5sO2iYH6IUD4Mlt0eqWl1pO2zjSiwacIuMBACouqRWwV74tKKIyyJsc
	 Wa76qkKuk+5NzMkJCDswxtfhQfVqhvWLNnUVHWqZ5MbMTguvNe9pQj3uYLkXccfEQ/
	 rW14Ukl5d9m9kAoT6DSXN/riwls4ncNS/h/+vTJ6+MMWS95nwFLp077dMnCXme1H15
	 HDGNa8M/Gswgy5rtSZNlY9hE8SHmI7n3czOaxrroSXd2noKVLvB9jg1XpyWxw3C51f
	 OY7cKPz2lU1Ag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F804CAC5A9;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
From: Cristian Cozzolino via B4 Relay <devnull+cristian_ci.protonmail.com@kernel.org>
Date: Sat, 20 Sep 2025 20:23:30 +0200
Subject: [PATCH 05/10] ARM: dts: mediatek: mt6582: remove compatible
 property from root node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-mt6582-v1-5-b887720f577d@protonmail.com>
References: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
In-Reply-To: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 phone-devel@vger.kernel.org, 
 Cristian Cozzolino <cristian_ci@protonmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758392693; l=662;
 i=cristian_ci@protonmail.com; s=20250620; h=from:subject:message-id;
 bh=LHxW1zi0DUMWIe5Lj8+bFJxdSQEdq66WG8h16b3dP4E=;
 b=TMvWA8WAGPT44mYP1vueAUHoVtdz+gB18NfVa5rTYKl9Nvrdu+N4bkMVEM0O20iu9Q/hAADvR
 nyg/7JLiZh/BjIexjLpZYiTP2vBK9Ll6QgIwFucLxYSOOgRikBzNpzI
X-Developer-Key: i=cristian_ci@protonmail.com; a=ed25519;
 pk=xH5IvIPUNHV1Q8R0/pq2CfuVFR/wTiAyuyi6IwedjZY=
X-Endpoint-Received: by B4 Relay for cristian_ci@protonmail.com/20250620
 with auth_id=438
X-Original-From: Cristian Cozzolino <cristian_ci@protonmail.com>
Reply-To: cristian_ci@protonmail.com

From: Cristian Cozzolino <cristian_ci@protonmail.com>

SoC's DTSI does not require compatible property. Drop that.

Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
---
 arch/arm/boot/dts/mediatek/mt6582.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/mediatek/mt6582.dtsi b/arch/arm/boot/dts/mediatek/mt6582.dtsi
index 8ada8c6518661509ebee647367064187f4376ab9..8a14dc1759d6f65fa75accddab83c1b6424d1632 100644
--- a/arch/arm/boot/dts/mediatek/mt6582.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt6582.dtsi
@@ -9,7 +9,6 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
-	compatible = "mediatek,mt6582";
 	interrupt-parent = <&sysirq>;
 
 	cpus {

-- 
2.49.0



