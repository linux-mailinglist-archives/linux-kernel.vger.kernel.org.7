Return-Path: <linux-kernel+bounces-747838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7657B138F9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70723B721A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C2E24678F;
	Mon, 28 Jul 2025 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="dj1ravgx"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A086B1F55F8;
	Mon, 28 Jul 2025 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753698640; cv=none; b=gQLscSooMDmYJAE1vYrMCaUpEXvUCKQMzZ78bqP4Tyaso/f9cTnZpeDqauRo/BH5gpmm5/2G8zFXfvSwqsulQJec65ftlfpA/UtOYdtTb8Y3vlmFpf1ZfGbaUK+FT74w61eYFNzLP75BxLEmvnuxTvFV4CLSfnBUPYBmGkjibBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753698640; c=relaxed/simple;
	bh=Jfm+a3MgKlJehkc71YMruhRwgQp6YcyxJyDDAsg6U9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yb0hchAK2yUd5DTVPju+xJgDevkUgfDfl83SOzmnNHvRZhW1Ul3vxhyZAW74rmJ2/Xd/D9W4ah9EPp9ClUg+aSOapYioMnOPslq/UQ2gHUVbaIrQeeGISF37hayt+hC5p6FkhoY293efg6mmTu1ki2t9zCbSGmql+1+Yhs19yiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=dj1ravgx; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id CD7D022B59;
	Mon, 28 Jul 2025 12:30:36 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pu-hSX5CNDgp; Mon, 28 Jul 2025 12:30:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1753698636; bh=Jfm+a3MgKlJehkc71YMruhRwgQp6YcyxJyDDAsg6U9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dj1ravgxkuRYsKVGCSW3SvyFQIM0EK24lPgw+PyZ7UsFuqc1uTmMPVrXup/mrHAkg
	 H6xokRarAW7zexhG8HzfKX+MqNobF8K88y1jZawn3FHl9Sh4wc+ssyZdMMWoBDmF+Z
	 Gw6vAWe4LRlINp8Jdh/hIZbI0ip4MGez/0IUNFumDyeXoXJQx01IKvdWVCtjXaJW+Q
	 2ytRew78fOB1OlugCfvqX59yxJhKwo3UPMCeG6TyyWoFPJv6+XmWRJgjxaMvCU3thV
	 noK/3IEodeyb6y06JxK+L/b56M1W5hNxIfE47wOOu6RgDP6pVCBgcJOTsuqh1JK6mP
	 KMYiBf5SNfcig==
From: Yao Zi <ziyao@disroot.org>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Yao Zi <ziyao@disroot.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/6] dt-bindings: soc: rockchip: Add RK3528 pipe-phy GRF syscon
Date: Mon, 28 Jul 2025 10:29:43 +0000
Message-ID: <20250728102947.38984-3-ziyao@disroot.org>
In-Reply-To: <20250728102947.38984-2-ziyao@disroot.org>
References: <20250728102947.38984-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible string for pipe-phy GRF found on RK3528 SoC, which
controls misc settings for the integrated naneng-combphy.

Signed-off-by: Yao Zi <ziyao@disroot.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 1ab0b092e2a5..fe5361713167 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -16,6 +16,7 @@ properties:
           - enum:
               - rockchip,rk3288-sgrf
               - rockchip,rk3528-ioc-grf
+              - rockchip,rk3528-pipe-phy-grf
               - rockchip,rk3528-vo-grf
               - rockchip,rk3528-vpu-grf
               - rockchip,rk3562-ioc-grf
-- 
2.50.1


