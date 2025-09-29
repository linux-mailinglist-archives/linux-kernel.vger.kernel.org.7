Return-Path: <linux-kernel+bounces-835881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17416BA8426
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA283A555D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18492C0F6E;
	Mon, 29 Sep 2025 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2hZtDgb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B2E2BF3DB;
	Mon, 29 Sep 2025 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759131314; cv=none; b=EfL/yASEcOBqUj4sfo00jXgMROAEoP/fCH+94O5oiA03D3bLAEPdV6kNbhCIaZ5EZD6wFr6jusrK7D/jggVJp1Wa+4HD7MqcOThL1UZ2TUji0IF2cU8qRy0RI/wJN2dIy0s0Ix6oSWTum+vFrmoNPbiiZM/ugW8c7huI8LL59Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759131314; c=relaxed/simple;
	bh=7NYQN/xl5KhOZgk379tTGk/P5gU5kC6zCwf6FS1ZnTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q+BUGPJhxKBR7wrSTflRV21vbmeXlqMwRQyJMxrzb6YvlraaTYvik4gYrvUKOm/xIcenyyVv+kWc9L8zExwub27fP0imJVz8G1j+ZU9ZWB6bJnbiR4kagjJnp8Wr9w2IMlXd2A7UzwApGtx979Eh6dlUVh57RF8FZfoKF2JPWsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2hZtDgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3A79C19422;
	Mon, 29 Sep 2025 07:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759131313;
	bh=7NYQN/xl5KhOZgk379tTGk/P5gU5kC6zCwf6FS1ZnTQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=o2hZtDgb5K9QlOfTjC98L5iRwA7E8xwtpmOTUYjQTtwmEBdwX/LOug36uTyqiqae8
	 QjdqwHSQHR8HUKfGoX83DEpcxvsQMFiyUABwTzkySgbYboeaMbGlTYNiq28Kdo3HtU
	 YMZ+a9WPJZg1OGXNzDZAzc0jXkImKI+lIa4TYoVVQBzJJ3okUw2HllPY52K6PLKds0
	 dH1S/ktWVuM3L30nSi8dFAVddjBrSf/4kSBtgDolrEkG212c1pIAjr63vmHcfQMsgy
	 rYSavRbn4tLGwXRHJ/7IVEnJg+68bFXk153AMil8UhVJLZtOQVIrlI3YhgTCYcbMoA
	 0SidfooQBnmYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAA4CAC5BD;
	Mon, 29 Sep 2025 07:35:13 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Mon, 29 Sep 2025 00:35:15 -0700
Subject: [PATCH v4 4/4] arm64: dts: rk3399-pinephone-pro: Fix voltage
 threshold for volume keys
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-ppp_light_accel_mag_vol-down-v4-4-6598f22d3451@gmail.com>
References: <20250929-ppp_light_accel_mag_vol-down-v4-0-6598f22d3451@gmail.com>
In-Reply-To: <20250929-ppp_light_accel_mag_vol-down-v4-0-6598f22d3451@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>, Ondrej Jirman <megi@xff.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759131312; l=1565;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=GpUQl51v5pQWdXs2BOWJyovxr7JU7F5Mge6gevMi3Lg=;
 b=ab+W3K7XcZNNPkj23XjF8RuvULAYxDqRHxKlFjqVR6ZPwZRRPaYRduyUSHUAvKCp5CjHrBRh1
 DFFnuf1ZL/cDshMh6NFs21K2ORl4epAIXZULo5mGQaKSbeKqpBQ12/D
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=ETrudRugWAtOpr0OhRiheQ1lXM4Kk4KGFnBySlKDi2I=
X-Endpoint-Received: by B4 Relay for guptarud@gmail.com/20240916 with
 auth_id=211
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: guptarud@gmail.com

From: Ondrej Jirman <megi@xff.cz>

Previously sometimes pressing the volume-down button would register as
a volume-up button. Match the thresholds as shown in the Pinephone Pro
schematic.

Tests:

~ $ evtest
    // Mashed the volume down ~100 times with varying intensity
    Event: time xxx, type 1 (EV_KEY), code 114 (KEY_VOLUMEDOWN), value 1
    Event: time xxx, type 1 (EV_KEY), code 114 (KEY_VOLUMEDOWN), value 0
    // Mashed the volume up ~100 times with varying intensity
    Event: time xxx, type 1 (EV_KEY), code 115 (KEY_VOLUMEUP), value 1
    Event: time xxx, type 1 (EV_KEY), code 115 (KEY_VOLUMEUP), value 0

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index 05aaf152b5efa5a87663fc97ce034e75131670bb..e7b0d965df6f5daa3e1b7ff98d567b74e8c7715f 100644
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



