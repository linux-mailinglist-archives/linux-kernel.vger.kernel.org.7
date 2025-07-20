Return-Path: <linux-kernel+bounces-738247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD26B0B64E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 15:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC6317B1E8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 13:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767CA219A86;
	Sun, 20 Jul 2025 13:56:09 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B8920C48A;
	Sun, 20 Jul 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753019769; cv=none; b=RQ9yqQ2H+FBQXcO2rAfNe90e1IfSht/nNfKA3nkcFhHIkOXWIC+R2jCASY05TET70NABjxGV/w8g1z2vQp8bA12/B6ZmscQqYjS2yusIJpJe8C3rBZ61jm4F9545LBefKbvGSCQQNtvRKUvBA356FV84hfS0mBhj9Qh3vuFXVss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753019769; c=relaxed/simple;
	bh=hTKwUnvtj0A0tq4ZN9BtDBtvHLfzofQo8pGcks5pqHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTd+My7ZMrGhHjCb5sUOCoJBHdzD7ibEe0Q4RkOoFLI/aFHkSpVm7UvBDBlME9nFELp9xxvkL3juo1ge9DyQG08XWY2/bxwfbChIzwApJcighZokQTHoKhJPHQVrX8iKdncLtvEhhfgS0vzjI7QsY6SDBeQbAmvDfvJ+x0qYoos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 2E5941C025E;
	Sun, 20 Jul 2025 15:55:56 +0200 (CEST)
X-Spam-Level: 
Date: Sun, 20 Jul 2025 15:55:51 +0200
From: Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Kevin Tang <kevin.tang@unisoc.com>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] dt-bindings: display: sprd: adapt for UMS9230
 support
Message-ID: <aHz1Z94swDewvriQ@abscue.de>
References: <20250719-ums9230-drm-v1-0-e4344a05eb3d@abscue.de>
 <20250719-ums9230-drm-v1-1-e4344a05eb3d@abscue.de>
 <9966b9e4-399b-4446-81e4-15daf9acbff7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9966b9e4-399b-4446-81e4-15daf9acbff7@kernel.org>

On Sun, Jul 20, 2025 at 02:26:19PM +0200, Krzysztof Kozlowski wrote:
> On 19/07/2025 14:09, Otto Pflüger wrote:
> > diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
> > index 4ebea60b8c5ba5f177854e3a8d89e93e7304e18b..6fedb6e508b247eb71da17ced589b8ed09085592 100644
> > --- a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
> > +++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
> > @@ -16,7 +16,12 @@ description: |
> >  
> >  properties:
> >    compatible:
> > -    const: sprd,sharkl3-dpu
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - sprd,ums9230-dpu
> > +          - const: sprd,sharkl3-dpu
> > +      - const: sprd,sharkl3-dpu
> >  
> >    reg:
> >      maxItems: 1
> > @@ -25,12 +30,15 @@ properties:
> >      maxItems: 1
> >  
> >    clocks:
> > -    minItems: 2
> > +    minItems: 1
> 
> This is wrong. You miss maxItems. I will fix existing bindings.

Will fix this, thanks.

> 
> >  
> >    clock-names:
> > -    items:
> > -      - const: clk_src_128m
> > -      - const: clk_src_384m
> > +    oneOf:
> > +      - items:
> > +        - const: clk_src_128m
> > +        - const: clk_src_384m
> > +      - items:
> > +        - const: enable
> >  
> >    power-domains:
> >      maxItems: 1
> > diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
> > index bc5594d18643010b91376c92a8f235a522d7dc3d..8438d2da0a4277db03e30b13cb270684c0c360cb 100644
> > --- a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
> > +++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
> > @@ -11,7 +11,9 @@ maintainers:
> >  
> >  properties:
> >    compatible:
> > -    const: sprd,sharkl3-dsi-host
> > +    enum:
> > +      - sprd,sharkl3-dsi-host
> > +      - sprd,ums9230-dsi-host
> >  
> >    reg:
> >      maxItems: 1
> > @@ -23,8 +25,11 @@ properties:
> >      minItems: 1
> >  
> >    clock-names:
> > -    items:
> > -      - const: clk_src_96m
> > +    oneOf:
> > +      - items:
> > +          - const: clk_src_96m
> > +      - items:
> > +          - const: enable
> 
> Why this is completely different clock? How same class device could have
> completely different clock INPUT?

The clocks should be the same on sharkl3 (sc9863a) and ums9230, but
the existing bindings don't really make sense here or are incomplete.
AFAIK there is no SoC in which this display controller is directly
connected to the PLL as shown in the example. The DSI controller is
connected to a clock gate. The DPU actually does have two clocks, both
of which are clock muxes that allow selecting different frequencies and
one of which is behind a clock gate. I can add the second clock for the
DPU if needed.

Since nothing seems to be using these bindings at the moment, would it
be okay to drop the old clock names that refer to specific frequencies?

> 
> >  
> >    power-domains:
> >      maxItems: 1
> > 
> 
> 
> Best regards,
> Krzysztof

