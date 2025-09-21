Return-Path: <linux-kernel+bounces-826385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33115B8E5F7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 903733BF39E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902E42749EA;
	Sun, 21 Sep 2025 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Khxnc8Gx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B500275872;
	Sun, 21 Sep 2025 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758488762; cv=none; b=gY0Q4QRb7fVgOcWBcZ5YADS7cN2es/zwMnKVtUT3zWt08F6Zk3ApXJRwzBNFiisoex0alFC7+LWDNxNCbj9bSPMpvGDuZK7rK3YvmKh8HIMTTnudcqAYven/YRvHNoeWMrb+oTuNvN751SclqsEValhlo26h+G7JK1AUG+XWj/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758488762; c=relaxed/simple;
	bh=rKwU+gFeJjRDdUOznuCYUPhpUn5SReAiuxGnMZgpY+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RGMRp+vgW3nTY8ihHdXDq7I0Fc22o4mEutujQM97NHXpX/ahiCRQ9K6osJ6goLcG2P30UjltfvOvELw9f3r9RiIw24yfP40dw7dI2ZfZKE5mOp24RsHLX3kQAp3CHavDx0A6efIKyjxc2CCtk0YUHx5zhE+IqNYiNtLOjq59K5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Khxnc8Gx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B98C8C19424;
	Sun, 21 Sep 2025 21:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758488761;
	bh=rKwU+gFeJjRDdUOznuCYUPhpUn5SReAiuxGnMZgpY+E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Khxnc8GxN5NTqGL92qsPIpR0Bu2/n2RKGR3QzBpbRjFHyP0FboiyHjb3oc1wdhtmO
	 HkVDNbggyjm/b7HHYfk1QD6JIlf8x+c81L1K0WV5K+DfqZFidXxD7qGAAjw6F34PNQ
	 k4Fv1iuvVo2w3WzfEeLL2D3BvAKRAGw3EFlNUwNEAV+CLyVinCC1p9RlZDMGM3IlUw
	 lyAdFf+0XDb4jrTRJfkv5JhyhzQS4nxsnkMuRVss8lTG/RCcYWJapp/zbWnPB54D7w
	 C6AljBo3XLGUkec8rf18yJjx+iNxZ//KclYeQp6NMMFIGUpvpqbRC3iwdyQfbfM65C
	 idi1WXHjHiq/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D72CAC5A8;
	Sun, 21 Sep 2025 21:06:01 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Sun, 21 Sep 2025 14:05:58 -0700
Subject: [PATCH v3 5/5] arm64: dts: rk3399-pinephone-pro: Fix voltage
 threshold for volume keys
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-ppp_light_accel_mag_vol-down-v3-5-7af6651f77e4@gmail.com>
References: <20250921-ppp_light_accel_mag_vol-down-v3-0-7af6651f77e4@gmail.com>
In-Reply-To: <20250921-ppp_light_accel_mag_vol-down-v3-0-7af6651f77e4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>, Ondrej Jirman <megi@xff.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758488760; l=1028;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=XPT9s2nJHVubXTdQ1l+Dr/LbFevwg26FGF4Dclc5IQY=;
 b=wq9IsKEpwJC/5ZZc6rO3amlFoJCTMLy9a95VNPSB0xoAUzITYuavLfZi4vXHnitWefHorWnYv
 DikUGLKd6dpC0o7Fs2lxwY3D5FNgyeOSHmnu7VNhGookvFs3+Oh+sDQ
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=ETrudRugWAtOpr0OhRiheQ1lXM4Kk4KGFnBySlKDi2I=
X-Endpoint-Received: by B4 Relay for guptarud@gmail.com/20240916 with
 auth_id=211
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: guptarud@gmail.com

From: Ondrej Jirman <megi@xff.cz>

Match the thresholds as shown in the Pinephone Pro schematic.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index a744f207dd1acebcdf566eef1c2a471b1e8f3f56..80c0acb506062b379a307a3125c322929724a7e8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -40,13 +40,13 @@ adc-keys {
 		button-up {
 			label = "Volume Up";
 			linux,code = <KEY_VOLUMEUP>;
-			press-threshold-microvolt = <100000>;
+			press-threshold-microvolt = <2000>;
 		};
 
 		button-down {
 			label = "Volume Down";
 			linux,code = <KEY_VOLUMEDOWN>;
-			press-threshold-microvolt = <600000>;
+			press-threshold-microvolt = <300000>;
 		};
 	};
 

-- 
2.51.0



