Return-Path: <linux-kernel+bounces-887043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA10C371B9
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C46F5013FF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6EF325499;
	Wed,  5 Nov 2025 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="e9Q2i3qm"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCDD334C25;
	Wed,  5 Nov 2025 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363631; cv=none; b=n0w/ALlS72SrfmvTI1UDlMJf4po6NdOHbYxixgSo59q0U1XRaOcGvNq44OlDpVobA+Ku8GlfvR73ty6VkkleljM1+39W53JjBbUQh3h0AwDlA6eE1hnqEQEgPgwW3LJPPKT3aY71QIZztVbnolkUAv/sAMq0tRyR2IYeeuxMzUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363631; c=relaxed/simple;
	bh=0zh7mU6+Q2DgrXPwAM6Mbt58/5XP2Rm18IkdrvGTcKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmYzVSNXeua2QIWU6mjIL4+/dBAxi0265Jjbng/OrttpaNYA0QvLQqGkCqn6DIavs51p477vHowaGU6JquTF4fIn8SpXtXLW9cEwCPCh6jyrCHGnUaontLrB8NiIk3EZDIFluiWjOaK3Sw3Y+bWyte/gZaZ8xH+CsGSD9YULcTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=e9Q2i3qm; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (82-203-161-95.bb.dnainternet.fi [82.203.161.95])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 0F214B5;
	Wed,  5 Nov 2025 18:25:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762363513;
	bh=0zh7mU6+Q2DgrXPwAM6Mbt58/5XP2Rm18IkdrvGTcKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e9Q2i3qmyZ20IOL7SdDM+WwB9D19VYgM5hqbItih+ttfImYlnN/blGMLwogAQtYPB
	 bsrjefm/q4T1d3In/NUbRQrX4xYlYUtZu3BoGa5DzLIpv61oBNlzJkkAah0NPR1Mvr
	 4geXc6/x8mJ2K/8w8L8Bl8RkgGyZi8B5hpa7hh4k=
Date: Wed, 5 Nov 2025 19:27:03 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Guoniu Zhou <guoniu.zhou@nxp.com>
Subject: Re: [PATCH v3 1/3] media: dt-bindings: nxp,imx8-isi: Add i.MX95 ISI
 compatible string
Message-ID: <20251105172703.GC6046@pendragon.ideasonboard.com>
References: <20251105-isi_imx95-v3-0-3987533cca1c@nxp.com>
 <20251105-isi_imx95-v3-1-3987533cca1c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105-isi_imx95-v3-1-3987533cca1c@nxp.com>

Hi Guoniu,

Thank you for the patch.

On Wed, Nov 05, 2025 at 01:55:10PM +0800, Guoniu Zhou wrote:
> From: Guoniu Zhou <guoniu.zhou@nxp.com>
> 
> The ISI module on i.MX95 supports up to eight channels and four link
> sources to obtain the image data for processing in its pipelines. It
> can process up to eight image sources at the same time.
> 
> Signed-off-by: Guoniu Zhou <guoniu.zhou@nxp.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../devicetree/bindings/media/nxp,imx8-isi.yaml    | 27 +++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml b/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml
> index f43b91984f0152fbbcf80db3b3bbad7e8ad6c11e..c5cf4a9787ee7f31273bd097d2200402fb346773 100644
> --- a/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml
> +++ b/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml
> @@ -23,6 +23,7 @@ properties:
>        - fsl,imx8mp-isi
>        - fsl,imx8ulp-isi
>        - fsl,imx93-isi
> +      - fsl,imx95-isi
>  
>    reg:
>      maxItems: 1
> @@ -49,7 +50,7 @@ properties:
>    interrupts:
>      description: Processing pipeline interrupts, one per pipeline
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 8
>  
>    power-domains:
>      maxItems: 1
> @@ -98,6 +99,7 @@ allOf:
>      then:
>        properties:
>          interrupts:
> +          minItems: 2
>            maxItems: 2
>          ports:
>            properties:
> @@ -109,6 +111,29 @@ allOf:
>              - port@0
>              - port@1
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx95-isi
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 8
> +        ports:
> +          properties:
> +            port@0:
> +              description: Pixel Link Slave 0
> +            port@1:
> +              description: Pixel Link Slave 1
> +            port@2:
> +              description: MIPI CSI-2 RX 0
> +            port@3:
> +              description: MIPI CSI-2 RX 1
> +          required:
> +            - port@2
> +            - port@3
> +
>  additionalProperties: false
>  
>  examples:

-- 
Regards,

Laurent Pinchart

