Return-Path: <linux-kernel+bounces-826070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4F3B8D735
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 10:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6ACBD4E11B8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 08:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571B01E5B78;
	Sun, 21 Sep 2025 08:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ratRWKWW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B715245005;
	Sun, 21 Sep 2025 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758441861; cv=none; b=uhP35XmoY/jQv0QcPDJa+Dbd474zcWZ+2z6kvfrwYoqM3YMbtKjettlTxx2XRNNzeJTn7Zy3iR30Rl+S1QCaU5q3MppwszZZJGyykr2DdUCHNJPF4QCM2yWUtrH1XSK3TYSTk+pTM/VVl2Fe52Ap2oC3U7GSQWVekp/YDFgUwBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758441861; c=relaxed/simple;
	bh=uBKLNDOkooe/3vuqO/OZ3y3mvA6lc9G0GfI+taewNvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Et2BolhhnEREh4XR0snjDvLORlHDtl603q6BpXn8g8lwDdQaXTc+AcRLVPQe9g5b944FvYblED5Drz6wCEMtH3ABxM57l2UrrFDtfR+2GzTvTgtb50WslpTI0vV7c5t4xraV8Ct7X+H7vRgDiAnzDJkzCxY8MFQLOIH2gSPEPSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ratRWKWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EB08C2BC86;
	Sun, 21 Sep 2025 08:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758441860;
	bh=uBKLNDOkooe/3vuqO/OZ3y3mvA6lc9G0GfI+taewNvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ratRWKWWb+DWNVvN9W0Lqg3txh4a5owIcUV0gHR2MBiqDFh1ytbg71XEnh8QZznwh
	 V8yIiHsUmcwAhbhmFJ/4iQk+9WtW1S0K1AvEBdI9SLk1FzTcxl5dQ6c7HdYC4FDIjw
	 zSH6SRj/gCHTesOSRGHxhJfthRpxUnGjs8an8k3oB4v5uNlwnlGsQ4lXq+sZcsKcWs
	 lbaBq9MVpqAV7zKAziPia58szmqY/63qx/5T2eivYJLeGkR6SVI+/O9ILgHl5mN8W3
	 OGoeU8FYqFHOWlB0xg9+HFV7StDP35i5pgmd92lU5JfaGPactzTj5SspvQinckbn2S
	 Paf/XcSgnmvfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F72CAC5A7;
	Sun, 21 Sep 2025 08:04:20 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Sun, 21 Sep 2025 01:04:23 -0700
Subject: [PATCH v2 5/5] arm64: dts: rk3399-pinephone-pro: Fix voltage
 threshold for volume down key
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-ppp_light_accel_mag_vol-down-v2-5-e6bcc6ca74ae@gmail.com>
References: <20250921-ppp_light_accel_mag_vol-down-v2-0-e6bcc6ca74ae@gmail.com>
In-Reply-To: <20250921-ppp_light_accel_mag_vol-down-v2-0-e6bcc6ca74ae@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>, Ondrej Jirman <megi@xff.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758441859; l=918;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=b2Y2d/HCInz27ts/XaKTXbc5Q1Z/myeoiVLoN5Pgsog=;
 b=zJ/SzjGEcWe22uQJE+V9sjp5PXkhwQeIOk1uEMMei9LIVJsw8MEP2dCoehW2P0vj0nHOUnqp9
 Tqa0iwC1miiDnAsbiHldOuFHjezVTSNzLslQEBZVOFBc+3/M0EhLJAG
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
index 0a4121b05d36c5a7e05eddbd3514a11ae4f7d3eb..4e6df664d780ed4798015db6b2fe79bf7c4e4c00 100644
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



