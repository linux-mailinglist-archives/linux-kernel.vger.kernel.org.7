Return-Path: <linux-kernel+bounces-761993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3934AB200DC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700923AB15E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5B72DAFCA;
	Mon, 11 Aug 2025 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3xoNAGG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DB72DAFB5;
	Mon, 11 Aug 2025 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898743; cv=none; b=Zw2HPI1nKkiA+3gaBCVVi9g7lJ2ZZ41XpaFUbe6QhNW/YwOP9Ia1TV5iOuQeJcXc7VqSPlUsfIPF0VF2CQTU7uPIyLiPHCz0uTl6jU1x6wnneLC2KA8p4cFsnra6BF/21JeZpBxSHSihVNHkBucj9Fc2Bbug+13NAaGA/42UHcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898743; c=relaxed/simple;
	bh=+BLSntymQrh/XkLGtypJrfw1XGjtmza1kggD9wXIN/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpOCeFcs3SYx+stvo9FbfE1WYGQVW0wzQo+AFUez1JzBqtN3Eua3fW5YU1b5GInt0YnjKCUYch6RHNnvQrsF5NrT7BSe3LyssDW0YgA5JHuBuoM6wZ4+Wn1nMs9kspebV1ojIlM7jJvnieWJ8vb52k5+y2UYnH1kMXTNOfngWAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3xoNAGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2789C4CEF1;
	Mon, 11 Aug 2025 07:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754898743;
	bh=+BLSntymQrh/XkLGtypJrfw1XGjtmza1kggD9wXIN/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c3xoNAGGbBNP16XXgIDYcgwJd9nwpp7WrxtkkARd2jjqlGYdgVvAW7yRKCBgy4Rdq
	 M5at+getsjQyZrr1zDnGMPVAgkJnrvWG7GT1DmeO1ZpQT7l+qC/EIkdVms2N+fm4KC
	 +p1ZVXt7G6V5YzMfswmlYf8QN5OGHEJ6jorFpbvCPPqSfLhKMro8dWUpQVwLZlWFp7
	 54u3+f9Vab1ZYWYP9PF6iCHDXSdTOeTOrOkgdeuKx2ieFHH8ivBgegaelFB3zUdrK7
	 id2rntASo0QuOuceEZec6vuN/kshdYGtk5BBA90nR3rAN87MtGoac6JkEEtMWOA2KO
	 qDbgYyRAy/rkQ==
Date: Mon, 11 Aug 2025 09:52:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jay Liu <jay.liu@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/6] dt-bindings: display: mediatek: disp-tdshp: Add
 support for MT8196
Message-ID: <20250811-boisterous-skinny-ammonite-a4ca7b@kuoka>
References: <20250808125512.9788-1-jay.liu@mediatek.com>
 <20250808125512.9788-5-jay.liu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250808125512.9788-5-jay.liu@mediatek.com>

On Fri, Aug 08, 2025 at 08:53:59PM +0800, Jay Liu wrote:
> Add disp-tdshp hardware description for MediaTek MT8196 SoC
>=20
> Signed-off-by: Jay Liu <jay.liu@mediatek.com>
> ---
>  .../display/mediatek/mediatek,disp-tdshp.yaml | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/me=
diatek,disp-tdshp.yaml

We expect filename based on compatibles (see writing bindings).

>=20
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
disp-tdshp.yaml b/Documentation/devicetree/bindings/display/mediatek/mediat=
ek,disp-tdshp.yaml
> new file mode 100644
> index 000000000000..94aa33a2a5ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp-td=
shp.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,disp-tdshp.=
yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek display 2D sharpness processor
> +
> +maintainers:
> +  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
> +  - Philipp Zabel <p.zabel@pengutronix.de>
> +
> +description: |
> +  MediaTek display 2D sharpness processor, namely TDSHP, provides a
> +  operation used to adjust sharpness in=C2=A0display system.
> +  TDSHP device node must be siblings to the central MMSYS_CONFIG node.

Heh? Why would this have to be a sibling? This is really odd, because
you cannto actually rely on that.

You just added unverifiable unusual ABI with no explanation.


> +  For a description of the MMSYS_CONFIG binding, see
> +  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +  for details.
> +
> +properties:
> +  compatible:
> +    items:

Drop, just enum.

> +      - enum:
> +          - mediatek,mt8196-disp-tdshp
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +

Drop blank line

> +    soc {
> +      #address-cells =3D <2>;
> +      #size-cells =3D <2>;

messed indentation

> +
> +      disp-tdshp@321e0000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetr=
ee-basics.html#generic-names-recommendation

e.g. image-processor

Best regards,
Krzysztof


