Return-Path: <linux-kernel+bounces-898484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AC3C555E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E60B4E19E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492B729E11A;
	Thu, 13 Nov 2025 02:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Yrx0QE6l"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDE62248AF;
	Thu, 13 Nov 2025 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762999242; cv=none; b=WfY1iXm1RwM0SqlCC9O9uw8YAlVtfr6bU9BDdZps1g1LiyOX1xSwn7FEVrxaKxvLbbEgT39c9SRc+ZMAR+iCOXHRK+BnSqpBYcQ9VFnCye+lcFcFGT+WR1Zp7UMdKYEYpykAAtL2T/RZ9TESY6JC8GGxsvzVQrH6d3MCg2Rg4HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762999242; c=relaxed/simple;
	bh=m/JsSUuuwvDOeT9RQcGvgVZikLHJyfgvCRC/Km24WVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AT1O9WgYTgm86RRIv/Vyke80QXYuhL0NI2UVzcNphHedL9xcsCloACGWJTS5ja1bqR9me9BCz3Yev0S9v6mvHMDEeeGSLJbRhQRxAB5sU/83ElRy8Is+G/sMml0x74BUp4sLztidkZz4D4YYJHHIQgvQd3+Iijp9BBtQ3IIPC14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Yrx0QE6l; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (unknown [213.216.211.176])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 8B042BD2;
	Thu, 13 Nov 2025 02:58:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762999118;
	bh=m/JsSUuuwvDOeT9RQcGvgVZikLHJyfgvCRC/Km24WVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yrx0QE6l81GKJpO7fUpDjtqnA5GrvpgVcKw12mkvhSUeNKwzoA5dm+f8PQQU/pHwQ
	 pOTPOexPfTcmFKdY2Uv+IlpJCWsNnxJaxnQL0L+hG679KyV9uQqt3ii6BXKlD9jxR6
	 eH9ydbOSbO4wdbNojVfBEQeCE5fR4cuG+zJarzCY=
Date: Thu, 13 Nov 2025 04:00:27 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Guoniu Zhou <guoniu.zhou@oss.nxp.com>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Guoniu Zhou <guoniu.zhou@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v7 1/5] media: dt-bindings: nxp,imx8mq-mipi-csi2: Add
 i.MX8ULP compatible string
Message-ID: <20251113020027.GE9135@pendragon.ideasonboard.com>
References: <20251023-csi2_imx8ulp-v7-0-5ecb081ce79b@nxp.com>
 <20251023-csi2_imx8ulp-v7-1-5ecb081ce79b@nxp.com>
 <20251027000537.GM13023@pendragon.ideasonboard.com>
 <aROg99ryy6RTZZIx@lizhi-Precision-Tower-5810>
 <20251111211025.GA26805@pendragon.ideasonboard.com>
 <aROzSqKEOXQgkWLz@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aROzSqKEOXQgkWLz@lizhi-Precision-Tower-5810>

On Tue, Nov 11, 2025 at 05:06:02PM -0500, Frank Li wrote:
> On Tue, Nov 11, 2025 at 11:10:25PM +0200, Laurent Pinchart wrote:
> > On Tue, Nov 11, 2025 at 03:47:51PM -0500, Frank Li wrote:
> > > On Mon, Oct 27, 2025 at 02:05:37AM +0200, Laurent Pinchart wrote:
> > > > On Thu, Oct 23, 2025 at 05:19:42PM +0800, Guoniu Zhou wrote:
> > > > > From: Guoniu Zhou <guoniu.zhou@nxp.com>
> > > > >
> > > > > The CSI-2 receiver in the i.MX8ULP is almost identical to the version
> > > > > present in the i.MX8QXP/QM, but i.MX8ULP CSI-2 controller needs pclk
> > > > > clock as the input clock for its APB interface of Control and Status
> > > > > register(CSR). So add compatible string fsl,imx8ulp-mipi-csi2 and
> > > > > increase maxItems of Clocks (clock-names) to 4 from 3.  And keep the
> > > > > same restriction for existing compatible.
> > > > >
> > > > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > Signed-off-by: Guoniu Zhou <guoniu.zhou@nxp.com>
> > > > > ---
> > > > >  .../bindings/media/nxp,imx8mq-mipi-csi2.yaml       | 41 ++++++++++++++++++++--
> > > > >  1 file changed, 39 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml b/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
> > > > > index 3389bab266a9adbda313c8ad795b998641df12f3..da3978da1cab75292ada3f24837443f7f4ab6418 100644
> > > > > --- a/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
> > > > > +++ b/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
> > > > > @@ -20,6 +20,7 @@ properties:
> > > > >        - enum:
> > > > >            - fsl,imx8mq-mipi-csi2
> > > > >            - fsl,imx8qxp-mipi-csi2
> > > > > +          - fsl,imx8ulp-mipi-csi2
> > > > >        - items:
> > > > >            - const: fsl,imx8qm-mipi-csi2
> > > > >            - const: fsl,imx8qxp-mipi-csi2
> > > > > @@ -39,12 +40,16 @@ properties:
> > > > >                       clock that the RX DPHY receives.
> > > > >        - description: ui is the pixel clock (phy_ref up to 333Mhz).
> > > > >                       See the reference manual for details.
> > > > > +      - description: pclk is clock for csr APB interface.
> > > > > +    minItems: 3
> > > > >
> > > > >    clock-names:
> > > > >      items:
> > > > >        - const: core
> > > > >        - const: esc
> > > > >        - const: ui
> > > > > +      - const: pclk
> > > > > +    minItems: 3
> > > > >
> > > > >    power-domains:
> > > > >      maxItems: 1
> > > > > @@ -130,19 +135,51 @@ allOf:
> > > > >          compatible:
> > > > >            contains:
> > > > >              enum:
> > > > > -              - fsl,imx8qxp-mipi-csi2
> > > > > +              - fsl,imx8ulp-mipi-csi2
> > > > > +    then:
> > > > > +      properties:
> > > > > +        reg:
> > > > > +          minItems: 2
> > > > > +        resets:
> > > > > +          minItems: 2
> > > > > +          maxItems: 2
> > > > > +        clocks:
> > > > > +          minItems: 4
> > > > > +        clock-names:
> > > > > +          minItems: 4
> > > >
> > > > Do we need the clock-names constraint ? The DT schemas will enforce that
> > > > clocks and clock-names always have the same number of elements.
> > >
> > > clock-names list already restrict at top section
> > >
> > > clock-names:
> > >   items:
> > >     - const: core
> > >     - const: esc
> > >     - const: ui
> > >     - const: pclk
> > >   minItems: 3
> > >
> > > Here just restrict need 4 clocks, instead 3 clock for fsl,imx8ulp-mipi-csi2
> >
> > I understand that. My point was that the dt-schema will always verify
> > that the number of clocks items is equal to the number of clock-names
> > items. That's a constraint enforced by the core schemas. As
> > clocks: minItems is set to 4, the clock-names: minItems constraint is
> > redundant.
> 
> I am not sure when have such features. Previous comments from Rob require
> clocks and clock-names keep the same at binding yaml.
> 
> https://lore.kernel.org/linux-devicetree/20251031000012.GA466250-robh@kernel.org/
> 
> Rob have not said that clock-names can be removed.
> 
> Do you have any thread, which inidicate we only need limit clocks at
> if-else branch?
> 
> I also have not found related commit at
> https://github.com/devicetree-org/dt-schema.git

I think you're right. There are dependencies between clock-names and
clocks described in the DT schemas, but I don't see any automatic
dependency regarding the number of items. I seem to have dreamt this :-/
Sorry about the noise.

> > > > > +
> > > > > +  - if:
> > > > > +      properties:
> > > > > +        compatible:
> > > > > +          contains:
> > > > > +            const: fsl,imx8qxp-mipi-csi2
> > > > >      then:
> > > > >        properties:
> > > > >          reg:
> > > > >            minItems: 2
> > > > >          resets:
> > > > >            maxItems: 1
> > > > > -    else:
> > > > > +        clocks:
> > > > > +          maxItems: 3
> > > > > +        clock-names:
> > > > > +          maxItems: 3
> > > > > +
> > > > > +  - if:
> > > > > +      properties:
> > > > > +        compatible:
> > > > > +          contains:
> > > > > +            enum:
> > > > > +              - fsl,imx8mq-mipi-csi2
> > > > > +    then:
> > > > >        properties:
> > > > >          reg:
> > > > >            maxItems: 1
> > > > >          resets:
> > > > >            minItems: 3
> > > > > +        clocks:
> > > > > +          maxItems: 3
> > > > > +        clock-names:
> > > > > +          maxItems: 3
> > > > >        required:
> > > > >          - fsl,mipi-phy-gpr
> > > > >
> > > >
> > > > Could you please sort those conditional blocks by alphabetical order of
> > > > the compatible strings ?

-- 
Regards,

Laurent Pinchart

