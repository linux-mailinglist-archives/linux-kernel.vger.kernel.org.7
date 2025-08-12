Return-Path: <linux-kernel+bounces-765379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E21B23118
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32B53B0186
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93F02F8BE7;
	Tue, 12 Aug 2025 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJcGEnbo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001B12FA0DB;
	Tue, 12 Aug 2025 17:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021518; cv=none; b=LiQuMqA9V5sAluRjIa1pOn2NaBSOCXt0yAs9pXEcK+vYKwtc7XRSBqn8fqIDdvszG9iQ5PNwXQZ8zTprjoEtIRH/NAqsA03xYpc0nVsN70Gky7+pak2zc+SmI1nZ5GqLMTLRTyXS52XWIWSMmywmA1tZwHULDTTRyYb+EHNVh+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021518; c=relaxed/simple;
	bh=K9HJlgKoboOg57mFD6AXVLvu90ujz+dtJXLIykrYC/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsFOY67OGTEmA9xrc5Whv3iFyHXZVNgKxJDANqw0oU8ob5J7gjLajk5JH9WIc6QDG61QKfKqtNvyyhl3FYZ2HaqdAZLqcuXmKjrCIMNpGgokMjZ13BWTUZp2lNNYqOzEnBp5B6+Xw7dg9NbXlWzPrYqfPHT0iDa7ZXPlDdVURgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJcGEnbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B918C4CEF0;
	Tue, 12 Aug 2025 17:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755021517;
	bh=K9HJlgKoboOg57mFD6AXVLvu90ujz+dtJXLIykrYC/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJcGEnbogs/hh2wjquEi7PPOfmGPbxIFmjo2kxAeWolR4c8NhGDkFYYHyE8ybChpK
	 Yaas07GjWGtfivH+Y2VuwL7T4/WghZuA/Y/V5jawYT5LPuA2OgMDTz+XaYvwNrZeNh
	 2pdPZxxrfvwq0dR/v16nWZnjdTVELAgXY5q7v1empY4nlBcZOw3SknUafSa9KiWW6K
	 9VtxrKmNW3DM94jl4MhCwdRKY2djK+cbQAvdbqU0uqyiFNNulJdYeBXtHHKe36zJMB
	 i5xAhibBNj/Hzm+OivDwY+/rT3nS2ZdBPLm5Hb2XyRqHhbyfW+zwUxkzrqP4eg0HrG
	 Q0Fmawoa4XqpA==
Date: Tue, 12 Aug 2025 18:58:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: dri-devel@lists.freedesktop.org,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Robert Foss <rfoss@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: drm/bridge: ti-tmds181: Add TI TMDS181
 and SN65DP159 bindings
Message-ID: <20250812-designing-tyke-db85527b373d@spud>
References: <20250812145256.135645-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.3b7d4319-e208-470d-9ada-585343a64822@emailsignatures365.codetwo.com>
 <20250812145256.135645-2-mike.looijmans@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dbziaZc0F74rJp3E"
Content-Disposition: inline
In-Reply-To: <20250812145256.135645-2-mike.looijmans@topic.nl>


--dbziaZc0F74rJp3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 04:51:34PM +0200, Mike Looijmans wrote:
> Add DT binding document for TI TMDS181 and SN65DP159 HDMI retimers.
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>=20
>  .../bindings/display/bridge/ti,tmds181.yaml   | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,t=
mds181.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,tmds181.=
yaml b/Documentation/devicetree/bindings/display/bridge/ti,tmds181.yaml
> new file mode 100644
> index 000000000000..87ffb556c4ad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,tmds181.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/ti,tmds181.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TMDS181 and SN65DP159 HDMI retimer/redriver chips
> +
> +maintainers:
> +  - Mike Looijmans <mike.looijmans@topic.nl>
> +
> +description: |
> +  Texas Instruments TMDS181 and SN65DP159 retimer and redriver chips.
> +  https://www.ti.com/product/TMDS181
> +  https://www.ti.com/product/TMDS181

These two links are the same.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tmds181
> +      - ti,sn65dp159

The driver contains:
+	{ .compatible =3D "ti,tmds181", },
+	{ .compatible =3D "ti,sn65dp159", },
+	{}
so why is a fallback compatible not suitable here?

Otherwise, this looks fine to me.

> +
> +  reg:
> +    enum:
> +      - 0x5b
> +      - 0x5c
> +      - 0x5d
> +      - 0x5e
> +
> +  oe-gpios:
> +    maxItems: 1
> +    description: GPIO specifier for OE pin (active high).
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: Video port for HDMI (ish) input
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: Video port for HDMI output (panel or bridge)
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        bridge@5b {
> +            compatible =3D "ti,sn65dp159";
> +            reg =3D <0x5b>;
> +
> +            oe-gpios =3D <&gpio2 1 GPIO_ACTIVE_HIGH>;
> +
> +            ports {
> +                #address-cells =3D <1>;
> +                #size-cells =3D <0>;
> +
> +                port@0 {
> +                    reg =3D <0>;
> +
> +                    endpoint {
> +                        remote-endpoint =3D <&encoder_out>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg =3D <1>;
> +
> +                    endpoint {
> +                        remote-endpoint =3D <&hdmi_connector_in>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> --=20
> 2.43.0
>=20
>=20
> Met vriendelijke groet / kind regards,
>=20
> Mike Looijmans
> System Expert
>=20
>=20
> TOPIC Embedded Products B.V.
> Materiaalweg 4, 5681 RJ Best
> The Netherlands
>=20
> T: +31 (0) 499 33 69 69
> E: mike.looijmans@topic.nl
> W: www.topic.nl
>=20
> Please consider the environment before printing this e-mail

--dbziaZc0F74rJp3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJuAxwAKCRB4tDGHoIJi
0ilQAP4x9yBhbNPygxd4NcXThsRpDcosvNUBF+h/zqQNshrlKgEApLWHOg6xMrko
QzqNtEuOGGH/3uhnTNGVZ85NL9X1ngk=
=inRX
-----END PGP SIGNATURE-----

--dbziaZc0F74rJp3E--

