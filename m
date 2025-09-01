Return-Path: <linux-kernel+bounces-795337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB256B3F046
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 23:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9180F2C04AB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 21:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E36275B03;
	Mon,  1 Sep 2025 21:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkoWhKMj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E88223E355;
	Mon,  1 Sep 2025 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756760513; cv=none; b=WsOV9isXMuE0UHFEknQCnKPZUzhaZlHVFoWBWuqegVibtKS/wo7D0dQ91vwZMFWLFeKv61ffcvnJ5phaNU2ww8xAFbaUmQcDLHXlb+mysZ9N9kC9UVXIvR+Mxcvyp1wEoxsB22NFHDP7u3ymNeNn303ry7yC+cj2BwL2dxwlAxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756760513; c=relaxed/simple;
	bh=1sx3B1KICtDjf4DR2eWZu0vSeJzYHOxzQ4xJumzeAtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K6js5t325QPXvoaeHroqQzjb7ktqvrebFoZIbRrEV8fSQRWfnfkM81qrKc4KZgg5Zu81KDwtRjsNgUioQY0k3KSvWW+rpaj3IIVUSejzZn1sGNEJGrRU3lZs8ckVetMI+Z9zXRRsQ592F4thPaz/vciN/TPXGszVxGNY0PrbmSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkoWhKMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7BB4C4CEF7;
	Mon,  1 Sep 2025 21:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756760512;
	bh=1sx3B1KICtDjf4DR2eWZu0vSeJzYHOxzQ4xJumzeAtc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XkoWhKMjQB6gbvpKIp/AOEGBepJ0nRjMBF3GTFxzyUOGfcIFueD+Cc9AFgAsMhDeO
	 0emRqz1xu2gN8aoMwgRDCKJGmI4nJgTCAoCnjH/K7fJ9TkRYOkSDawEaw2iFVu8ax6
	 o04mXEEjcnW44L/02dN/pn8sWZdGD4puIFf3a0P0vIHyRghAyWztzMPHFsOGNEV3sD
	 GHSJ2aF/+Vgwb8+7Suxz2QP9teYQpz7ckdr3DDXD6XSnNUlbKUCNQdb3zpN6QkXQGB
	 cBuo5S/m79+QASQ+XTKHkgnMr53URgN6v5K2VtyNkrFnlLyvtuJPfujwM3tj2D5m9U
	 HdgxhX9ek0Ipw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F57ACA1005;
	Mon,  1 Sep 2025 21:01:52 +0000 (UTC)
From: Michael Riesch via B4 Relay <devnull+michael.riesch.collabora.com@kernel.org>
Date: Mon, 01 Sep 2025 22:47:42 +0200
Subject: [PATCH v3 1/7] dt-bindings: soc: rockchip: add rk3588 csidphy grf
 syscon
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rk3588-csi-dphy-v3-1-a5ccd5f1f438@collabora.com>
References: <20250616-rk3588-csi-dphy-v3-0-a5ccd5f1f438@collabora.com>
In-Reply-To: <20250616-rk3588-csi-dphy-v3-0-a5ccd5f1f438@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756759662; l=927;
 i=michael.riesch@collabora.com; s=20250410; h=from:subject:message-id;
 bh=+caMXhRTVArPpx+x7pVyqXS9t7uDPpRu8sQdXP1mzpo=;
 b=GhQI9Eco07YwwzPj4YTacxR9ShNGnxBwmititeHbHW1kIAEG2Bw+zEuUCgD/mYM9Ly6AOr296
 l4E1Rg7ApYBDnXLv/WBlnyGdN7ZTjKeScLWhpLvyf0aUIDe7NY2fqHA
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



