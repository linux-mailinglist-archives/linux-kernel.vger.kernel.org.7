Return-Path: <linux-kernel+bounces-896175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBCCC4FCEB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A793E4F458A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A9327A917;
	Tue, 11 Nov 2025 21:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jT76vbs5"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C6335CBD1;
	Tue, 11 Nov 2025 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762895437; cv=none; b=WpDrKWBfq5R9OEEynmvwPqorjQV43CVA/B9O29x9vHsr0H3snoAU5mmGb9J+XCrN7kl74Y1kONF8PM1fPtS0OlZailRAlfVBscn/FilzL6dyPXW0UHkmqPhpovu7scLmtHhBMeNNJtnT0RIFrsrNGeAFYcTf+Cv/vMtPCCooGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762895437; c=relaxed/simple;
	bh=ZJnPqy6rt4JkyACEYLFsrsiMs+h4L3/AcaMs5XAVPDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7gMe1piAV3EhcJKFzXRuPisbDPPMvk11oBnzuQIxOXrB7DVmLR9uLsSdXuC5X7AzZR2F2/DOUCGI75F+U4jkfv6yJXDZrs+S16SHAgwIRunUzYhvnMRuSRlkpUGzmtNEkvoXYlNTuWqkrUv8pFF1ZBl53q5+DlarEiPUDzPbcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=jT76vbs5; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (82-203-161-95.bb.dnainternet.fi [82.203.161.95])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id BFCC822B;
	Tue, 11 Nov 2025 22:08:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762895313;
	bh=ZJnPqy6rt4JkyACEYLFsrsiMs+h4L3/AcaMs5XAVPDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jT76vbs53VCjgG63S5D9R7y0iPpHgrzLVxTtqaB4Zt46N0L5cOd7Zzh8pXJbchYoo
	 9yk1uLktXbinrkbaHuDan8Nv7IDnemA6Htso7ey4RS3mjH4kI1ubZXcKNmYpxfQQaG
	 VKOaUFMWQmFjGiRmqv1n/JaSGZAXN+M0nowVwKuU=
Date: Tue, 11 Nov 2025 23:10:25 +0200
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
Message-ID: <20251111211025.GA26805@pendragon.ideasonboard.com>
References: <20251023-csi2_imx8ulp-v7-0-5ecb081ce79b@nxp.com>
 <20251023-csi2_imx8ulp-v7-1-5ecb081ce79b@nxp.com>
 <20251027000537.GM13023@pendragon.ideasonboard.com>
 <aROg99ryy6RTZZIx@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aROg99ryy6RTZZIx@lizhi-Precision-Tower-5810>

On Tue, Nov 11, 2025 at 03:47:51PM -0500, Frank Li wrote:
> On Mon, Oct 27, 2025 at 02:05:37AM +0200, Laurent Pinchart wrote:
> > On Thu, Oct 23, 2025 at 05:19:42PM +0800, Guoniu Zhou wrote:
> > > From: Guoniu Zhou <guoniu.zhou@nxp.com>
> > >
> > > The CSI-2 receiver in the i.MX8ULP is almost identical to the version
> > > present in the i.MX8QXP/QM, but i.MX8ULP CSI-2 controller needs pclk
> > > clock as the input clock for its APB interface of Control and Status
> > > register(CSR). So add compatible string fsl,imx8ulp-mipi-csi2 and
> > > increase maxItems of Clocks (clock-names) to 4 from 3.  And keep the
> > > same restriction for existing compatible.
> > >
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > Signed-off-by: Guoniu Zhou <guoniu.zhou@nxp.com>
> > > ---
> > >  .../bindings/media/nxp,imx8mq-mipi-csi2.yaml       | 41 ++++++++++++++++++++--
> > >  1 file changed, 39 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml b/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
> > > index 3389bab266a9adbda313c8ad795b998641df12f3..da3978da1cab75292ada3f24837443f7f4ab6418 100644
> > > --- a/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
> > > +++ b/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
> > > @@ -20,6 +20,7 @@ properties:
> > >        - enum:
> > >            - fsl,imx8mq-mipi-csi2
> > >            - fsl,imx8qxp-mipi-csi2
> > > +          - fsl,imx8ulp-mipi-csi2
> > >        - items:
> > >            - const: fsl,imx8qm-mipi-csi2
> > >            - const: fsl,imx8qxp-mipi-csi2
> > > @@ -39,12 +40,16 @@ properties:
> > >                       clock that the RX DPHY receives.
> > >        - description: ui is the pixel clock (phy_ref up to 333Mhz).
> > >                       See the reference manual for details.
> > > +      - description: pclk is clock for csr APB interface.
> > > +    minItems: 3
> > >
> > >    clock-names:
> > >      items:
> > >        - const: core
> > >        - const: esc
> > >        - const: ui
> > > +      - const: pclk
> > > +    minItems: 3
> > >
> > >    power-domains:
> > >      maxItems: 1
> > > @@ -130,19 +135,51 @@ allOf:
> > >          compatible:
> > >            contains:
> > >              enum:
> > > -              - fsl,imx8qxp-mipi-csi2
> > > +              - fsl,imx8ulp-mipi-csi2
> > > +    then:
> > > +      properties:
> > > +        reg:
> > > +          minItems: 2
> > > +        resets:
> > > +          minItems: 2
> > > +          maxItems: 2
> > > +        clocks:
> > > +          minItems: 4
> > > +        clock-names:
> > > +          minItems: 4
> >
> > Do we need the clock-names constraint ? The DT schemas will enforce that
> > clocks and clock-names always have the same number of elements.
> 
> clock-names list already restrict at top section
> 
> clock-names:
>   items:
>     - const: core
>     - const: esc
>     - const: ui
>     - const: pclk
>   minItems: 3
> 
> Here just restrict need 4 clocks, instead 3 clock for fsl,imx8ulp-mipi-csi2

I understand that. My point was that the dt-schema will always verify
that the number of clocks items is equal to the number of clock-names
items. That's a constraint enforced by the core schemas. As
clocks: minItems is set to 4, the clock-names: minItems constraint is
redundant.

> > > +
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: fsl,imx8qxp-mipi-csi2
> > >      then:
> > >        properties:
> > >          reg:
> > >            minItems: 2
> > >          resets:
> > >            maxItems: 1
> > > -    else:
> > > +        clocks:
> > > +          maxItems: 3
> > > +        clock-names:
> > > +          maxItems: 3
> > > +
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - fsl,imx8mq-mipi-csi2
> > > +    then:
> > >        properties:
> > >          reg:
> > >            maxItems: 1
> > >          resets:
> > >            minItems: 3
> > > +        clocks:
> > > +          maxItems: 3
> > > +        clock-names:
> > > +          maxItems: 3
> > >        required:
> > >          - fsl,mipi-phy-gpr
> > >
> >
> > Could you please sort those conditional blocks by alphabetical order of
> > the compatible strings ?

-- 
Regards,

Laurent Pinchart

