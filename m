Return-Path: <linux-kernel+bounces-827738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CD6B92950
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE3A2A4481
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A936331770E;
	Mon, 22 Sep 2025 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l30ktzbZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D3CC2FB;
	Mon, 22 Sep 2025 18:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564973; cv=none; b=VDPGicRuWz2tloLG6Mtm/xtuWwinb0DnITSRj9j3rz6gL5UO2VY8p7ednuvYZZrOyn5we2gKLbS7hN5d7vh6dj4n5GcXaaNcW73VzAMupg9XoCbNLkv2paQ4s+nVJwUYNeAS1zXjzhTbvZaISkbXhI2ULHreSjqDlMFe94Bqwis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564973; c=relaxed/simple;
	bh=B27HomHuhJBTrQOAEO4poRW47y74aiAoiPzAwmJBk+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMtU4bQBTYkNHVQwVoUYIhobTNMGy9wl4rNeVpGL9u6fFE65vkyLoEt30Yd7StTXKbKvhe7HfOZlcAsfllBcToRvLIZJwpc/mgRPnac1xCQljGSd9GeRxrFDpoPp5MihtSgQr6OMzbEszL2yPxhGkwHKgtO5/2+h0TSVbRtYCSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l30ktzbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50281C4CEF0;
	Mon, 22 Sep 2025 18:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758564972;
	bh=B27HomHuhJBTrQOAEO4poRW47y74aiAoiPzAwmJBk+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l30ktzbZF077F855O0xutvYLVis5e2kFa2zr5BK0uU49ekrNDOoOQLBOA34o5wvkd
	 lMkdIigJT6NGy45DFVdaagNhbioDHCJrIffvCjXqSUF3nRogRh+fdXQWxxlOUgb+hj
	 SfRWCroIxZR6dbzrqOIilUwA/f3LsnMB9Ch4OrCN7PF+whQvwqPvZvfm1MMvs9slPD
	 i2QkoELimpXiFIVj6O+hl97UNXIsOMlPWADFQJz3zVxzKH19EV23qPVRw7Z+G7Em9r
	 IJk1e8RhcOCT9I7sk72jMzp7viNPNOLxSCQzvb0fWOmi68xtbcVPDSxSUr5Pt1kwx+
	 Ak2BDG4SqdATg==
Date: Mon, 22 Sep 2025 13:16:11 -0500
From: Rob Herring <robh@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: Re: [RFC PATCH 1/5] dt-bindings: mfd: x-powers,axp152: Add
 polyphased property
Message-ID: <20250922181611.GA567602-robh@kernel.org>
References: <20250919000020.16969-1-andre.przywara@arm.com>
 <20250919000020.16969-2-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919000020.16969-2-andre.przywara@arm.com>

On Fri, Sep 19, 2025 at 01:00:16AM +0100, Andre Przywara wrote:
> Some X-Powers AXP PMICs can combine some of their DC/DC buck converter
> outputs in a multi-phase fashion, to achieve higher currents and
> decrease the output ripple. The datasheets call this poly-phase. This is
> programmable in the PMIC, although often set up as the PMIC's reset
> default.
> 
> Add the "x-powers,polyphased" property to the binding, to describe those
> pairs or tuples of regulators that should work together. In the lead
> regulator node, the property lists the phandles of the connected
> regulators. Just an empty property means no poly-phasing.

Don't we have a coupled regulator binding already?

> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../devicetree/bindings/mfd/x-powers,axp152.yaml   | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> index 45f015d63df16..260c4c0afc475 100644
> --- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> +++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> @@ -304,6 +304,15 @@ properties:
>                noise. This probably makes sense for HiFi audio related
>                applications that aren't battery constrained.
>  
> +          x-powers,polyphased:
> +            $ref: /schemas/types.yaml#/definitions/phandle-array
> +            description:
> +              A list of phandles pointing to other regulators that should be
> +              polyphased with this regulator. The linked regulators will be
> +              synchronised with this regulator, within the PMIC, but only if
> +              supported by the PMIC. An empty list means this regulator
> +              should be configured in a single-phase setup.

phandle-array is poorly named and is really a matrix because you can 
have arg cells. So you need:

items:
  maxItems: 1

And is there an outer max for linked regulators?

Rob

