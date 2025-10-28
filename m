Return-Path: <linux-kernel+bounces-872904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77268C12928
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 02:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6485C4E54BD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E062517A5;
	Tue, 28 Oct 2025 01:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvDNA4hN"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969F1246786
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 01:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761615593; cv=none; b=gT07iZpfWkkyXDZf+yULGU+JKaiO+u3geicNxIIis+6f49rrkxcx8qNQbJS8adD4EIl45Xph13SFezldjyTogxV/05DN3LVVzZCjuYz6HQ3VMTLeyAFP2nsHThD079Q1ApEmnU6tWPITiI+SuRIIQ74Zpnznp0i1Cor2d3AklFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761615593; c=relaxed/simple;
	bh=PaaP9fdww3JPs0IwiX5e4GSI4u3vKpvVQOB5b/eN0Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8oUgnh41jbRS5OQJ433ioIJ+Cvi9DLkLkrgOb3dYUEZlsyYREbix0YHoIcSC80z9EYVhDQ7oVPnkJLtFSYqQg0sS3quEoUklv+d+tYPl5B5birZ4uWrYhZ2A7vr5lTLjGUk9lM5kK/MCwiIv4KxvSc4jsmi9HLvoIfLI1Z4teA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvDNA4hN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47714bb5c49so1483595e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 18:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761615589; x=1762220389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mBblJ3nsftn2mS8ULy+s3OXZomR0giH+rj9ZthWrG/c=;
        b=TvDNA4hN7mg1cY6ig39lumptD5kQrClyB8jIvMQBOilSLN2WDiSP1Cwl2sFT5c7bmC
         U3Nij3PGhKlLnWLbF8bNl2XNd93vxSVc08kDzxl/fi37opTRqeDXQ+eDS86LDZhh7kk2
         vvJn7smy1RX/1025eXHOLuXK1krulqtd62G1XzpBpPSHSvWj2lZ1jsch+kMI3lJOgfBS
         S3XBa3S026GK9Gdh+MFw8QOHti4W9v3czDCh9Fxe/LXIMWUlo9UjoaNkV3q//ebXNzVc
         zzU5ytSVAo/ObNMk7FSnLt7dthn4Y7AaozxmJLhs8jAbjw2YaRRZipN3wIYUJtn4ooGe
         5VVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761615589; x=1762220389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBblJ3nsftn2mS8ULy+s3OXZomR0giH+rj9ZthWrG/c=;
        b=TGwSo9BcrvuRIN7qhAeZXlUmc8BbgwG7UnjJLxLGd3yzb+O7asZe1OWmm65u8e5b6L
         n/1jvSckbwgOoiHzIlt0INA14hu5in8twvVTaYF9feZ25OqZTkqFxl+AWssKY/yAy5cc
         TDmA2UR6gCT9cmKy5KH8LXx82UuY2ln/NL/Riwf5EBhedthj34JK3SpImCir88GYCTuc
         mGq28J/wufylNfxoEO/9/DbzIPy5XjZTDrjwFO7uGxjpVNm+VuDv2UbJWGpLdlC+ZUfC
         mBU4NU6SxMFUYwR5EXCC/ya4bmSbKcxZMBMxcXUlDy9cJUZjz6B/w3GqGS68vyNNPHSs
         1UXA==
X-Forwarded-Encrypted: i=1; AJvYcCWDxzGhKRil7SEfwZKgYenNAzkBBBIW5p/Xkn0sI9rJN4hpUZXqKR21q2vV3X2xIlQrE1ZpFGfrFx8epMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJPfZAUXHGrIGa05BT/pI+GL/lzoJUtstAsN6MZieigAbn8Cww
	kF91YsM0+n3p881nvxrpwz6YhJf1s7d/Gj1AHNvbYx06n60pcVyusqIs
X-Gm-Gg: ASbGncuWTNufIC6dlrgvcVHZt/YNQ1K9aDrJMdG/B8fX7LrIoXNOn0PVqhCDW//P7M+
	dF1GLINZk5v5Id+EtTrkarmX7R29XZjv5hX1ufOp99lezw17vvHbH4zCWGIjx3zYlL/Jne4Ul3n
	7akw5XmXNmqok+EhnvcYOOsMWnQgtL6z9AQPz3umaueYF3xOrW+7/tF0CvcEDopiR+zx2Op/Bj5
	DwOJM+wDLGeyOZolVP6wqjeSCoqNHzM6OmaMo8g/vK1cKT/TgdmTO/9HVxzhUu+OXNazL6CmSjE
	f6enPzNzUHP+nP+YB6u09VIW1999ZtRG1zuM4ZUlzyKyszRClOSuFI3GSzw4+jzOJ3B3W5H39up
	e7EgwZrXKTsIuGuKHdDn4Fk1Lj2lmOwY0irkUC4tX0VMRzOE7hlmfIvJGpxk+CZ4AlYCC
X-Google-Smtp-Source: AGHT+IHe7guKvzidfJFf4IbFz3oSjaETN9prbXYTVEJHNFR2d9Uk4DABdSF+8z9fO+jHVcJW38gmVA==
X-Received: by 2002:a05:600c:4446:b0:475:dade:b94c with SMTP id 5b1f17b1804b1-47717e573fcmr7007035e9.5.1761615588805;
        Mon, 27 Oct 2025 18:39:48 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d406:ee00:3eb9:f316:6516:8b90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4924a4sm168027855e9.7.2025.10.27.18.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 18:39:48 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:39:44 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v3 06/12] dt-bindings: net: dsa: lantiq,gswip:
 add support for MII delay properties
Message-ID: <20251028013944.lmjboagptxl4dob7@skbuf>
References: <cover.1761521845.git.daniel@makrotopia.org>
 <cover.1761521845.git.daniel@makrotopia.org>
 <e7a4dadf49c506ff71124166b7ca3009e30d64d8.1761521845.git.daniel@makrotopia.org>
 <e7a4dadf49c506ff71124166b7ca3009e30d64d8.1761521845.git.daniel@makrotopia.org>
 <20251027230439.7zsi3k6da3rohrfo@skbuf>
 <aQADFttLJeUXRyRF@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQADFttLJeUXRyRF@makrotopia.org>

On Mon, Oct 27, 2025 at 11:41:10PM +0000, Daniel Golle wrote:
> On Tue, Oct 28, 2025 at 01:04:39AM +0200, Vladimir Oltean wrote:
> > On Sun, Oct 26, 2025 at 11:45:19PM +0000, Daniel Golle wrote:
> > > Add support for standard tx-internal-delay-ps and rx-internal-delay-ps
> > > properties on port nodes to allow fine-tuning of RGMII clock delays.
> > > 
> > > The GSWIP switch hardware supports delay values in 500 picosecond
> > > increments from 0 to 3500 picoseconds, with a default of 2000
> > > picoseconds for both TX and RX delays.
> > > 
> > > This corresponds to the driver changes that allow adjusting MII delays
> > > using Device Tree properties instead of relying solely on the PHY
> > > interface mode.
> > > 
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > ---
> > > v3:
> > >  * redefine ports node so properties are defined actually apply
> > >  * RGMII port with 2ps delay is 'rgmii-id' mode
> > > 
> > >  .../bindings/net/dsa/lantiq,gswip.yaml        | 29 +++++++++++++++++--
> > >  1 file changed, 26 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > > index f3154b19af78..b0227b80716c 100644
> > > --- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > > +++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > > @@ -6,8 +6,29 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> > >  
> > >  title: Lantiq GSWIP Ethernet switches
> > >  
> > > -allOf:
> > > -  - $ref: dsa.yaml#/$defs/ethernet-ports
> > > +$ref: dsa.yaml#
> > > +
> > > +patternProperties:
> > > +  "^(ethernet-)?ports$":
> > > +    type: object
> > > +    patternProperties:
> > > +      "^(ethernet-)?port@[0-6]$":
> > > +        $ref: dsa-port.yaml#
> > > +        unevaluatedProperties: false
> > > +
> > > +        properties:
> > > +          tx-internal-delay-ps:
> > > +            enum: [0, 500, 1000, 1500, 2000, 2500, 3000, 3500]
> > > +            default: 2000
> > 
> > No. This is confusing and wrong. I looked at the driver implementation
> > code, wanting to note that it has the potential of being a breaking
> > change for device trees without the "tx-internal-delay-ps" and
> > "rx-internal-delay-ps" properties.
> > 
> > But then I saw that the driver implementation is subtly different.
> > "tx-internal-delay-ps" defaults to 2000 only if "rx-internal-delay-ps" is set, and
> > "rx-internal-delay-ps" defaults to 2000 only if "tx-internal-delay-ps" is set.
> > 
> > So when implemented in this way, it won't cause the regressions I was
> > concerned about, but it is misrepresented in the schema.
> > 
> > Why overcomplicate this and just not set a default? Modify the RX clock
> > skew if set, and the TX clock skew if set.
> 
> The problem is that before adding support for both *-internal-delay-ps
> properties the internal delays would be set exclusively based on the
> interface mode -- and are inverted logic:
> 
> ```
>          switch (state->interface) {
>          case PHY_INTERFACE_MODE_RGMII_ID:
>                  gswip_mii_mask_pcdu(priv, GSWIP_MII_PCDU_TXDLY_MASK |
>                                            GSWIP_MII_PCDU_RXDLY_MASK, 0, port);
>                  break;
>          case PHY_INTERFACE_MODE_RGMII_RXID:
>                  gswip_mii_mask_pcdu(priv, GSWIP_MII_PCDU_RXDLY_MASK, 0, port);
>                  break;
>          case PHY_INTERFACE_MODE_RGMII_TXID:
>                  gswip_mii_mask_pcdu(priv, GSWIP_MII_PCDU_TXDLY_MASK, 0, port);
>                  break;
>          default:
>                  break;
>          }
> ```
> 
> As you can see the delays are set to 0 in case of the interface mode
> being RGMII_ID (and the same for RGMII_RXID and RGMII_TXID
> respectively).
> 
> This is probably the result of the delays being initialized to 2000ps by
> default, and if the **PHY connected to the switch port** is set to take
> care of the clk/data delay then the switch port RGMII interface doesn't
> have to do it.
> 
> From my understanding this is a bit awkward as "internal delay" usually
> means the delay is taken care of by the PHY rather than by discrete
> parts of the board design. Here, however, it is *never* part of the
> board design and always handled by either the switch RGMII interface
> (MAC side) or the connected PHY.
> 
> So in order to not break existing board device trees expecting this
> behavior I've decided to only fall-back to adjust the delay based on the
> interface mode in case both properties are missing.
> 
> Please correct me if that's the wrong thing to do or if my understanding
> is flawed in any way.

Ok, I missed the fact that there's RGMII delay handling outside of
gswip_mii_delay_setup() too (a bit bizarre).

So "why overcomplicate this" has a good reason. You have legacy to
maintain for xrx200, xrx300, xrx330 - essentially the same situation as
documented in sja1105_parse_rgmii_delays(). But no legacy for the newly
introduced switches though?  I don't see why you'd opt them into this
behaviour of applying MAC delays based on phy-mode.

Also, the point still stands that your documented default delay value
is incorrect. What happens in lack of one property depends on the
presence of the other, and on the phy-mode. I think deleting the
default value from the schema is much better than having wrong
documentation for it.

