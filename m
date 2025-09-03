Return-Path: <linux-kernel+bounces-799155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47EEB427CD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B193B8CE6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69255320A3F;
	Wed,  3 Sep 2025 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCkYGDYu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB44F2BD01E;
	Wed,  3 Sep 2025 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919953; cv=none; b=ZkWaRbmBUvATttf4OwqbOXq+bTcVKojn3SXXsik1xRXrf1G1jTfDCcmGXBPFlC1ID9HbloYKtBCAJMG4WrbjHa5hFpkLLOajMHtiySouYt5k3D+L65C58P8PES8q54LMUNKmeY/sl0gtHkiFtrusH7NCnNrQM4N3zhFIBw8gJ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919953; c=relaxed/simple;
	bh=1sx3B1KICtDjf4DR2eWZu0vSeJzYHOxzQ4xJumzeAtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g9x/ALEYZ+0trPaJbZfGWrjZcCQhsSoDsdKEeAUKGNruk0hH8rF4OfbjDjIOOkLqnnKGiCjp0gWmnmbtlBrPFpx+fgWJgdSYLhATK9UcVvYvyNSUM+hz4Klp3bywiPPH0IHKPkvWqEGmSkcXMkQmPlmb7eki14UeJg9RIsO2FMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCkYGDYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C6DFC4CEF0;
	Wed,  3 Sep 2025 17:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756919953;
	bh=1sx3B1KICtDjf4DR2eWZu0vSeJzYHOxzQ4xJumzeAtc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oCkYGDYuNxsGC5YEQIMritYRJh4JK5wfWSJZRnSgH7wdcs3ur3qRIogLrUHpxoGT3
	 QGibnYcvQOnIi+zc9/y3XQgaAbfKXFPUhureJ0lgPfbS+HzK6ZxMMWUk7y9siIuV4l
	 VAHcCAKJ74ar6t6PK7OTDjD/cBKSwneWLrtynRb135JgoZI8wz3C0NRWOYE4u88Mx+
	 1//6XYv09eiHXr9tkQPNgNqncKtr2z/G0F4I+6/8jXn5biEDQR26sJDDXSBs91NoB7
	 8Qubq6Hs//g/IrLSakGMnokQw258Zagn6cG7ZW+MRCog6TXHIWw4aMVUDt8lbax6qJ
	 Pp1SukXgAimWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A1DCA1009;
	Wed,  3 Sep 2025 17:19:13 +0000 (UTC)
From: Michael Riesch via B4 Relay <devnull+michael.riesch.collabora.com@kernel.org>
Date: Wed, 03 Sep 2025 19:04:49 +0200
Subject: [PATCH v4 1/7] dt-bindings: soc: rockchip: add rk3588 csidphy grf
 syscon
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rk3588-csi-dphy-v4-1-a4f340a7f0cf@collabora.com>
References: <20250616-rk3588-csi-dphy-v4-0-a4f340a7f0cf@collabora.com>
In-Reply-To: <20250616-rk3588-csi-dphy-v4-0-a4f340a7f0cf@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756919100; l=927;
 i=michael.riesch@collabora.com; s=20250410; h=from:subject:message-id;
 bh=+caMXhRTVArPpx+x7pVyqXS9t7uDPpRu8sQdXP1mzpo=;
 b=wG1IidUa2QHST5Z3WZhLbs1BKkObhL4egG+9FfeF6DpRFd2akprZNyXGUXX5xJtY+UK3vNQ75
 aViQTtHPXncDe6KTa09aaDns2yQsvZ3Th0vCUdmYP7FaUKaB96WVPya
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



