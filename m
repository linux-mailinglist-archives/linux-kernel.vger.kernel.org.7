Return-Path: <linux-kernel+bounces-774583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5586FB2B485
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747021B21CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8C927B4FB;
	Mon, 18 Aug 2025 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kp5TBcx5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF503451B0;
	Mon, 18 Aug 2025 23:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755558873; cv=none; b=EtppewdgiuxHmUsN2iynapFAeHCAXpJxtg2abic/IsYjjPTz3DkUdw2c8AEgfBKsFZdy7WYqk9GxSCIsX5uVp/0Qommmzc1WSCunX7REFX1GpQAgV4HtrRpqNihNRNrih6OW0T0ZJjbDWCKAGyDwIdDJ3yH+EIBoItmv4i7mDG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755558873; c=relaxed/simple;
	bh=1sx3B1KICtDjf4DR2eWZu0vSeJzYHOxzQ4xJumzeAtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uS5OAlWZsD3+BlRMpSkVokQB+2Fs/+wkjewJnigtpMLFGSNs4GOWRyIGw3jvs6Uthz2chmDqpmDuKnB9E9+793pL895p4ZH0PjkDflbgw4INo2WyHNYGPUkAGBPKtmPvX7RkyZZGmYO5Rgju6ASSR1mCAG1cHRVWpXPFCPhrPoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kp5TBcx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65358C4CEF1;
	Mon, 18 Aug 2025 23:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755558873;
	bh=1sx3B1KICtDjf4DR2eWZu0vSeJzYHOxzQ4xJumzeAtc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kp5TBcx5Et95AVIF80WQgYameSH77W80k98u6hqqbT8XzHN2hNZGQpMZt/eD6VLw5
	 mMYVyk/aBPJparD/w/9SKCrKD+LYNPAvFgBh1YVQQcctliVOgNMzDiffKzzuBdYeGP
	 HvIB9cjaTf9kfH4pVI8m9z8gLDKQgc69Zur+n6abDgQ47ZZZdYNg91qD6BSoqFQdEY
	 IXdeX69O/fuSHZ8UTl0jQArVjLtS1MFnlAYer5AGFPhbzzNQ15OJVhELHS3xHQa4mg
	 MtoUeANZRV+pxsNT6q7VVVANpDkQTNRS4XVmh8+B/UvVbXUTJQSOuW1Mchfv8qyB+Y
	 fIXvh6o4l2+qw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5449ACA0ED1;
	Mon, 18 Aug 2025 23:14:33 +0000 (UTC)
From: Michael Riesch via B4 Relay <devnull+michael.riesch.collabora.com@kernel.org>
Date: Tue, 19 Aug 2025 01:00:35 +0200
Subject: [PATCH v2 1/7] dt-bindings: soc: rockchip: add rk3588 csidphy grf
 syscon
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rk3588-csi-dphy-v2-1-7a94f079b712@collabora.com>
References: <20250616-rk3588-csi-dphy-v2-0-7a94f079b712@collabora.com>
In-Reply-To: <20250616-rk3588-csi-dphy-v2-0-7a94f079b712@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Diederik de Haas <didi.debian@cknow.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Collabora Kernel Team <kernel@collabora.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, 
 Michael Riesch <michael.riesch@collabora.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755558041; l=927;
 i=michael.riesch@collabora.com; s=20250410; h=from:subject:message-id;
 bh=+caMXhRTVArPpx+x7pVyqXS9t7uDPpRu8sQdXP1mzpo=;
 b=mJW2C/Sgu9YPmlfYtkC+t4kXopDPZCvY9eIm5X81XBhFsZaeowIt+14ocQDcDKAc018WvOPlQ
 WBDDe2to+igBcK/Q3l2DVWYyg2rCmxf+2fbYTmWIH+YEx0HVj9GH3J6
X-Developer-Key: i=michael.riesch@collabora.com; a=ed25519;
 pk=+MWX1fffLFZtTPG/I6XdYm/+OSvpRE8D9evQaWbiN04=
X-Endpoint-Received: by B4 Relay for michael.riesch@collabora.com/20250410
 with auth_id=371
X-Original-From: Michael Riesch <michael.riesch@collabora.com>
Reply-To: michael.riesch@collabora.com

From: Michael Riesch <michael.riesch@collabora.com>

Add CSIDPHY GRF syscon compatible for the Rockchip RK3588.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Michael Riesch <michael.riesch@collabora.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 1ab0b092e2a5..b6e04e6491e9 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -47,6 +47,7 @@ properties:
               - rockchip,rk3576-vop-grf
               - rockchip,rk3588-bigcore0-grf
               - rockchip,rk3588-bigcore1-grf
+              - rockchip,rk3588-csidphy-grf
               - rockchip,rk3588-dcphy-grf
               - rockchip,rk3588-hdptxphy-grf
               - rockchip,rk3588-ioc

-- 
2.39.5



