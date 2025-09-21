Return-Path: <linux-kernel+bounces-826030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 756F7B8D5DB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 08:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 095CE7B31CF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 06:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C03D2C2356;
	Sun, 21 Sep 2025 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tU0sBtEo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F055C2D0610;
	Sun, 21 Sep 2025 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758436865; cv=none; b=CbM7FXLcOPXj17hIW9KLphzutJd1CnSX8K6E55nwxc6vxKO4qm/jiaFlS4eFCcWmExfKLnNm5bOQ2DFLtS0aahelqh9EWCdk8vn/t6AtZ80sdLB+HmB4c5zIi7MmTL9HYQJfUmUWRt6tF0OHchrUfpyI7zMGpcu/0Jy7Ckv5+XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758436865; c=relaxed/simple;
	bh=H0MR3uHU5hlIJ5/WlfYAN+ZyZHORnNIRwdhIa+6AmvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qj0mw/xwRfRBuAlMi54LYczqbIWk8kYwyH3d0ghVYBE2GjG/YERAYTIJ3lBcWZtLcYcEWOhQBViDWNx4uVK0tr4pGK1K0EckLJvoAIfUSsm4bj3kKIwsQzUhXUc+eq4gbSnmYyWLZcuLMQWAuOrEJNrCsk+A5Kr2GXKWfaMoyDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tU0sBtEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 729C7C16AAE;
	Sun, 21 Sep 2025 06:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758436864;
	bh=H0MR3uHU5hlIJ5/WlfYAN+ZyZHORnNIRwdhIa+6AmvQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tU0sBtEoiDEgZEE1o19lRP1cZT1bBc14iuxTCGSPHkUIwyqAlFmEl3YVAP8ZnaykW
	 zoIpfrzksjhDACsDQH7Eyu/Cs8f3XOnPWwRP5Nhs/FD2MnuPiwaaDUSEnIhLl/AgdL
	 JMJxR21Lx/6XzIONeuiGDghNxCJ3yiwDcG8BFITk6JiWbtm8npUcmom/i+gQLwpnKk
	 uGr++m34gbs2wF/S1h9fPnpKogj4zG9vsb42U2lTrChlvCI6hId61p3XKi3Xiv70i3
	 Rw2iP0nGX5bxi/jn6qSeKKSiaTi3tD/uQJQ9dp7IEZgWaFP9sMf+lUV3UA8JrbgidP
	 uuRBoemUGAoTg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6976ECAC5AE;
	Sun, 21 Sep 2025 06:41:04 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Sat, 20 Sep 2025 23:41:07 -0700
Subject: [PATCH 5/5] arm64: dts: rk3399-pinephone-pro: Fix voltage
 threshold for volume down key
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-ppp_light_accel_mag_vol-down-v1-5-c8bbcd3e2e94@gmail.com>
References: <20250920-ppp_light_accel_mag_vol-down-v1-0-c8bbcd3e2e94@gmail.com>
In-Reply-To: <20250920-ppp_light_accel_mag_vol-down-v1-0-c8bbcd3e2e94@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>, Ondrej Jirman <megi@xff.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758436863; l=918;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=7iLC5O0dsn9zg2F9rKhLMzmaUzVCOfuKGE4Zt0swuq8=;
 b=MJylPNpnn+pwiXJ58hFB97Qz4rPkvEFoEZMVglpZ16MXoaVzkYwPs6YRstrJ1+oKN9yl4XSvR
 3McwS+qLyM6BUxB5XU1j/xe2r5pCpPbcWvnwxEoyczXHnpwcovrjq5O
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=ETrudRugWAtOpr0OhRiheQ1lXM4Kk4KGFnBySlKDi2I=
X-Endpoint-Received: by B4 Relay for guptarud@gmail.com/20240916 with
 auth_id=211
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: guptarud@gmail.com

From: Ondrej Jirman <megi@xff.cz>

U-Boot and Linux use different algorithms for determining voltage ranges
for comparison. Pick value that will work with both.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index 9442ca4c9ae47d639ed6139c370bacf1bffa65b6..82e29e547fe25ea0c7fa681813514da6e06ecacd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -46,7 +46,7 @@ button-up {
 		button-down {
 			label = "Volume Down";
 			linux,code = <KEY_VOLUMEDOWN>;
-			press-threshold-microvolt = <600000>;
+			press-threshold-microvolt = <400000>;
 		};
 	};
 

-- 
2.51.0



