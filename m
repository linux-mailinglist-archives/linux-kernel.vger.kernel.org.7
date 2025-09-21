Return-Path: <linux-kernel+bounces-826383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A65AFB8E5E8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB52189A823
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C269F299952;
	Sun, 21 Sep 2025 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AR+d//3z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB02749EA;
	Sun, 21 Sep 2025 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758488762; cv=none; b=aWm0np4cL4XO/YlcNu7TgqzETfaIcmDzr9MRk4anmYc61ePNc0iHVYhFUIAbuwqV53WBuXFTX+EloR4ojaOjrBvLXQDZ38roQj/NYrej9qYa92RDl0ZH5ZxUJwBvil/Aqu1BZIpfhEDNo2JC9bfdbndImppPTHJYWQxbJjg6Y3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758488762; c=relaxed/simple;
	bh=1aL4no0mi5PNjdNB8FcaWT6LzUxH9iQQGF+ylzaGSRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c3ReNg532ZWHDpbBQqhRxY+ASkaP8GJWDsCcox0OfwacUmHEy6HEwOvz003GR07mpI1+e2RXOxRlZhOgBeTeGZEtKvAJIECPEXmQ5Ji0s4tEpcFTNWumH1ulsZPkLGetAs98eZeHa5smaUpZNTlhZkxQuPejiDi393+wh2RSCUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AR+d//3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1006C116D0;
	Sun, 21 Sep 2025 21:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758488761;
	bh=1aL4no0mi5PNjdNB8FcaWT6LzUxH9iQQGF+ylzaGSRE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AR+d//3zSG5dJCuPGQoIWmqyzvGJ71WiyP6tn+g0z8pYYXLzzH16fMqGMCmXkCmBF
	 /QxasG85nd8C1eMDr7mOckgvD+V5adh8RMeSGp0wkFeJNocr/HPneBQLnFcLDZCe7l
	 cfgaN0so5RGn6AYpCAMRkePhAFJY21jWVmzUDe2JZX/Dh/WcjzDov6MRpgAcNe0G5e
	 fLp1wI3fxYFzuSKG2g+245yl94s6Ht+W+VUq+KQXkk1AIjRUwLb4fQM8ZsPXGtDtbd
	 3wL4ZtM5up5sp3WX/B/31Cv8TtZhtzoWwnE/ADqv/LJLTZnA02FZtkOFBZYa3bGPNk
	 TF4MNReIRyrYw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D09BCAC5AC;
	Sun, 21 Sep 2025 21:06:01 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Sun, 21 Sep 2025 14:05:57 -0700
Subject: [PATCH v3 4/5] arm64: dts: rk3399-pinephone-pro: Add mount-matrix
 for magnetometer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-ppp_light_accel_mag_vol-down-v3-4-7af6651f77e4@gmail.com>
References: <20250921-ppp_light_accel_mag_vol-down-v3-0-7af6651f77e4@gmail.com>
In-Reply-To: <20250921-ppp_light_accel_mag_vol-down-v3-0-7af6651f77e4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>, 
 "Leonardo G. Trombetta" <lgtrombetta@gmx.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758488760; l=1257;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=WnIwsZU2Xz0wbBXu3PZDS4k0R/N336ICVXq38moA7Dg=;
 b=aiflitYD3CgGimotMuLdm+ecTFMs31SYzVzdsNarsAUOis2CgLbjI9KYwpXvNjsi8hoNbZQtc
 UZvkvJc7DM2Dh88Lh5F45oRYSeS1o2XkwS42SuF1mX3jKKySG7MT6JP
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=ETrudRugWAtOpr0OhRiheQ1lXM4Kk4KGFnBySlKDi2I=
X-Endpoint-Received: by B4 Relay for guptarud@gmail.com/20240916 with
 auth_id=211
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: guptarud@gmail.com

From: "Leonardo G. Trombetta" <lgtrombetta@gmx.com>

After experimenting with the magnetometer on the Pinephone Pro I found
out the mount-matrix currently reported by the AF8133J driver is just
the identity matrix (no rotation), which is wrong. It would seem to me
that there is currently no `mount-matrix` info and that's why the driver
reports a trivial answer. As far as I can tell from my tests, a 90
degree clockwise rotation in the XY plane would align it properly.

Signed-off-by: Leonardo G. Trombetta <lgtrombetta@gmx.com>
Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index 266a08540dd0fe099319ec703bb0828c8c5c2c25..a744f207dd1acebcdf566eef1c2a471b1e8f3f56 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -561,6 +561,11 @@ af8133j: compass@1c {
 		reset-gpios = <&gpio1 RK_PA1 GPIO_ACTIVE_LOW>;
 		avdd-supply = <&vcc_3v0>;
 		dvdd-supply = <&vcc_1v8>;
+
+		mount-matrix =
+			"0", "1", "0",
+			"1", "0", "0",
+			"0", "0", "-1";
 	};
 };
 

-- 
2.51.0



