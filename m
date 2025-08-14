Return-Path: <linux-kernel+bounces-768996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37778B26890
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A47647B32D0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D891C2DB2;
	Thu, 14 Aug 2025 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXxvpwzh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7B31A9FB8;
	Thu, 14 Aug 2025 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180081; cv=none; b=GecX4OUEAdJP8OOknQSJ8T6NkeBO3XX7Tc2xImjX5Oem6BigJEh7wtJMAiqvfd3mzGZTwFUrFO3pNxbR3tiQRFx2ycrp14AgxgvRLQ5viz3Gi56s1nReAB1dUBbijZ0MQ69X8M5yAd9HEdZjEQ1FLKBn7llLxs6nas3+QlqlkH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180081; c=relaxed/simple;
	bh=OJwgXQoKUoVQ6JMi/lzTSRWNwpU4o4E8nVxhmW1I3Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7tM0IParRRqmS38nrTILmaQEvBM7oRSEuUc5GqrpIp0G7gMCgG3ckqEl3SG6271o6SmHol3+TDh8IjtRGkK6zEM0sxkZtjDPny9eqwYdH0UBeQCYqXILq3N0IFgc9cdPh36XytGXEVe3un0AdSZWB0gDxlaDp0/ysvhDZ4cS4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXxvpwzh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EEAC4CEED;
	Thu, 14 Aug 2025 14:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755180080;
	bh=OJwgXQoKUoVQ6JMi/lzTSRWNwpU4o4E8nVxhmW1I3Ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iXxvpwzh2EedlQ9q7ou5ppIO27ljUbxMV/BYUmWblGZ1axlrwXYBkLHJbakoVUplp
	 FJisloc00zW1zUG09FJ7SC2dfPNqNth15fQHg3p56Km6tGXpkCdpDcO9H6zOnCWlCZ
	 ekmvqIscoPehmfSCBl0RCOAw/PDt3VEhHv5Sq7QcZMl/2s09izsd7TOghFMXT5+GmK
	 nTHkIry1mQfjv91Zyl2Qt2LudY3/1iR5ZfqKfi9egVQ3Zp0v5zNRnC599NTzcqM08d
	 DjDCgL9SZg7CzXSM964X4m05Re4k5PN9KQIQRmXNIVdoLWD0REGYRtj14NWj+ktkcl
	 KY8jAsbjcUlzw==
Date: Thu, 14 Aug 2025 09:01:19 -0500
From: Rob Herring <robh@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Yannick Fertre <yannick.fertre@foss.st.com>,
	Philippe Cornu <philippe.cornu@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/13] dt-bindings: display: st: add new compatible to
 LVDS device
Message-ID: <20250814140119.GA2748790-robh@kernel.org>
References: <20250812-drm-misc-next-v2-0-132fd84463d7@foss.st.com>
 <20250812-drm-misc-next-v2-3-132fd84463d7@foss.st.com>
 <20250814-dancing-nautilus-of-camouflage-ebb441@kuoka>
 <2c13bf48-5453-4302-9cde-eac51e314af1@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c13bf48-5453-4302-9cde-eac51e314af1@foss.st.com>

On Thu, Aug 14, 2025 at 02:36:47PM +0200, Raphael Gallais-Pou wrote:
> 
> 
> On 8/14/25 11:09, Krzysztof Kozlowski wrote:
> > On Tue, Aug 12, 2025 at 03:49:00PM +0200, Raphael Gallais-Pou wrote:
> >> Update the compatible to accept both "st,stm32mp255-lvds" and
> >> st,stm32mp25-lvds" respectively.  Default will fall back to
> >> "st,stm32mp25-lvds".
> >>
> >> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> >> ---
> >>  Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml | 8 +++++++-
> >>  1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml b/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml
> >> index 6736f93256b5cebb558cda5250369ec4b1b3033c..b777c55626e4b322d77ef411ad9e4a3afb6c9131 100644
> >> --- a/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml
> >> +++ b/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml
> >> @@ -31,7 +31,13 @@ description: |
> >>  
> >>  properties:
> >>    compatible:
> >> -    const: st,stm32mp25-lvds
> >> +    oneOf:
> >> +      - items:
> >> +          - enum:
> >> +              - st,stm32mp255-lvds
> >> +          - const: st,stm32mp25-lvds
> >> +      - items:
> > Drop. This should be just enum or const, no need for items.
> 
> Why would items not be applicable in this case ? I want the compatible field to
> be either:
> 
> compatible = "st,stm32mp255-lvds", "st,stm32mp25-lvds";
> 
> or
> 
> compatible = "st,stm32mp25-lvds";

Krzysztof is only talking about the 2nd 'items' here. For cases with a 
single entry, you can skip 'items'. It's just a shorter version. Either 
way will work the same.

Rob

