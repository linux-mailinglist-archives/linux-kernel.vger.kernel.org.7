Return-Path: <linux-kernel+bounces-783038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2463B328A6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D083A4139
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660E62797A5;
	Sat, 23 Aug 2025 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Is+9f/LK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A233F25D1E5;
	Sat, 23 Aug 2025 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755953034; cv=none; b=o0S/mRuIA2Wj7BIGKfqLzZ3ZiNiJNA8jJesV/1bdlZSM6BY0ioJ+JlHOmFf1HwohHaoZ77e0R3IevXPZCodtAaEBUHpKFHIeLH3QYFVLieRyo7N3s0z18ssN5hfcN6tZIRzCSSwfhhaux/34w/CAEyJKzXGYGnzHFgFt0ax84GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755953034; c=relaxed/simple;
	bh=B0yWv5F7kSvazoMcjgU+eIFJl5bLPubYgvJIyWU40a4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ol6wG0aZ1hqhGCuDyOFzMzrNevuZmbk5KEWdAOm4ZTSJ4yRZoDd26cPANNf63+OgCm5wTzXw838yDKh0EzCxn4P4syuJwyEr7x/zO1lvkSqIkvODqrKAUiw9LFwcoHP/hlyEyOzW0BkccR0wG5j7hfm2mqy+QriCKIbrFtHBJPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Is+9f/LK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3ABCDC4FDF9;
	Sat, 23 Aug 2025 12:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755953034;
	bh=B0yWv5F7kSvazoMcjgU+eIFJl5bLPubYgvJIyWU40a4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Is+9f/LKlPgXOnVoQjCbpl0SRkyPIhdLVusrD1VHKH4EhAX0rOXLL76gpa93j1Uka
	 YEaQNCztshxn2SyniYROzQjnTCF5MRuz9omm8IRZGZs9mFqnIivO+IreUMWKBeuID8
	 zxJNgOTuUrJo7qYvLB363lOnT7OuGKRDakkCNnlE6dZleVTE7LKmuxGM3sDe76QwcG
	 BPed3Z+7askIlg6pPFfJrS/26E3jysNElOV91/HBqnzWtfYkxxe9TstmdN6x3de0dz
	 LtOGOBFu9xDk4xoQDzShFgmza6EL2LCe7z+y+/O2VyDShlcTFACJ0qqvsvAUsRS4eN
	 k499aE2fooCVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321B6CA0EE4;
	Sat, 23 Aug 2025 12:43:54 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maud_spierings.hotmail.com@kernel.org>
Date: Sat, 23 Aug 2025 14:43:50 +0200
Subject: [PATCH 1/3] arm64: dts: rockchip: Fix the headphone detection on
 the orangepi 5 plus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250823-orangepi5-v1-1-ae77dd0e06d7@hotmail.com>
References: <20250823-orangepi5-v1-0-ae77dd0e06d7@hotmail.com>
In-Reply-To: <20250823-orangepi5-v1-0-ae77dd0e06d7@hotmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Ondrej Jirman <megi@xff.cz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Maud Spierings <maud_spierings@hotmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755953033; l=1342;
 i=maud_spierings@hotmail.com; s=20241110; h=from:subject:message-id;
 bh=kGPjNY4n/uxG/MNPreW3TR8PtxdOfCOti3K91Nz2Q5M=;
 b=DIIVLpd0YMMUOmcU63vKLqzgA2GVop3tml6nsagnUg28WHgYFNVQa1U8unq2gIzeNRFYO+3xa
 zedfsD0szo3C/pGzsmbaED6YJPXVZCsHsZqCDvRN/JxRx91zW/Cx/Jk
X-Developer-Key: i=maud_spierings@hotmail.com; a=ed25519;
 pk=CeFKVnZvRfX2QjB1DpdiAe2N+MEjwLEB9Yhx/OAcxRc=
X-Endpoint-Received: by B4 Relay for maud_spierings@hotmail.com/20241110
 with auth_id=273
X-Original-From: Maud Spierings <maud_spierings@hotmail.com>
Reply-To: maud_spierings@hotmail.com

From: Maud Spierings <maud_spierings@hotmail.com>

The logic of the headphone detect pin seems to be inverted, with this
change headphones actually output sound when plugged in.

Verified by checking /sys/kernel/debug/gpio and by listening.

Fixes: 236d225e1ee7 ("arm64: dts: rockchip: Add board device tree for rk3588-orangepi-5-plus")
Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>
---
There was a big change at some point so it will take some effor to port
it back that far.
---
 arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
index 121e4d1c3fa5dab0d08edf7cba692a765b48f7b4..8222f1fae8fadc5cbb4ef16b3db5ed975ed43915 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
@@ -77,7 +77,7 @@ &analog_sound {
 	pinctrl-names = "default";
 	pinctrl-0 = <&hp_detect>;
 	simple-audio-card,aux-devs = <&speaker_amp>, <&headphone_amp>;
-	simple-audio-card,hp-det-gpios = <&gpio1 RK_PD3 GPIO_ACTIVE_LOW>;
+	simple-audio-card,hp-det-gpios = <&gpio1 RK_PD3 GPIO_ACTIVE_HIGH>;
 	simple-audio-card,widgets =
 		"Microphone", "Onboard Microphone",
 		"Microphone", "Microphone Jack",

-- 
2.50.1



