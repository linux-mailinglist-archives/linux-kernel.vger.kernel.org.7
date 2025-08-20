Return-Path: <linux-kernel+bounces-777178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C346B2D63F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20CD51C24717
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AC72D9EFF;
	Wed, 20 Aug 2025 08:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="cwIb+PwC"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8900D2D9ED5;
	Wed, 20 Aug 2025 08:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678133; cv=none; b=S0BTOI0hyGqEDaHOl+j1vkSGRtHN7j9sm0E0W1k53xUEHP0Gl2nA9eO46fobsB7XeYaO6TvjGs4LQhkYK05JJoQwbOTJgzG/z7vgwERkbtYLDwh6ScEefW6SMj+99CPu+Bwon/lhVrvuc2B+Toanu4cGhZddB6KR+VRorDLgwyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678133; c=relaxed/simple;
	bh=9QEbuG+GPIKc6HZ7LEQZXRiiQ3D0aZWLbFTkKdd+2Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWh2m9T9VkAnZS54K3CsLVQy0FywTQUV1kMfFXivP4ZiWWXa3dsr7suYn1IwBXWi727LPye+BJU5y9jbAFqwKNVQsMRnv7eYRi9A3slcIZCz6+UYFx91HANT/yVj8laXO2zzGjyAUPMleZCetjOnntm1DjbSRTiDT2jHd2jnoPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=cwIb+PwC; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=JcAm9yTTKvqNJOXNP8pEqbZUIKYNqPig/u1OHo43/AU=; b=cwIb+PwC9yFnPRQfveAMrK7LZo
	ree++Om7C7EhWBUGYfmLWFqIDBHm7X5pzJzjkXp5EjX0mPx1jts/jgcMMtG1ALBfeL6In6e/blUjr
	pJtVUJ9CQTkw0PgshK2hw/Zg04XH3tiSMv/BeZLr4eCQyuaiUXZas3OiYSOkWY7tnR48wi/FxAjQO
	i+kwMO8ihycvStlkduzclhDSB0d9u2us0nPdZ0JkQJDBgYFywEkm6mVN4lo0UMo8Xpa6KBZPy6zxT
	egkUxAt46xi97doBFnmuuiulLVRkeODq43eiaYHVS/z/Jf0vUR5oqSstSHwtmySvPp5p6zaw8oDsJ
	njdWopcA==;
Received: from i53875a0d.versanet.de ([83.135.90.13] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uoe4b-0003a0-N1; Wed, 20 Aug 2025 10:21:33 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "H. Nikolaus Schaller" <hns@goldelico.com>, Arnaud Vrac <avrac@freebox.fr>,
 Pierre-Hugues Husson <phhusson@freebox.fr>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject:
 Re: [PATCH 3/3] dt-bindings: display: rockchip,dw-mipi-ds: Narrow clocks for
 rockchip,rk3288-mipi-dsi
Date: Wed, 20 Aug 2025 10:21:32 +0200
Message-ID: <1829992.7aRn1RRit1@diego>
In-Reply-To: <20250820-dt-bindings-display-v1-3-d5b2555df51f@linaro.org>
References:
 <20250820-dt-bindings-display-v1-0-d5b2555df51f@linaro.org>
 <20250820-dt-bindings-display-v1-3-d5b2555df51f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,


Am Mittwoch, 20. August 2025, 09:02:42 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Krzysztof Kozlowski:
> The binding allows in top-level from one to four clocks and each variant
> narrows the choice, but rockchip,rk3288-mipi-dsi missed the minItems.

subject is missing an "i" in rockchip,dw-mipi-ds(i)

Other than that
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml      =
| 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,=
dw-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockc=
hip,dw-mipi-dsi.yaml
> index 0881e82deb1105e4f92843380c0183569f688f08..c59df3c1a3f78ae0d345dc725=
f4dfb3eedb3de22 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi=
=2Ddsi.yaml
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi=
=2Ddsi.yaml
> @@ -97,9 +97,11 @@ allOf:
>      then:
>        properties:
>          clocks:
> +          minItems: 2
>            maxItems: 2
> =20
>          clock-names:
> +          minItems: 2
>            maxItems: 2
> =20
>    - if:
>=20
>=20





