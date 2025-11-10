Return-Path: <linux-kernel+bounces-892740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF77C45B74
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7EA18817D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2B52E8B71;
	Mon, 10 Nov 2025 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Kc/FraVr"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB9710F1;
	Mon, 10 Nov 2025 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768054; cv=none; b=H0g4BESylDTTZELuFhq1/9dJczWQRZpruHRLCdAV8PMMWTXEPYufVfVT1piQB/33MW1/GEtwLcyWhY5bzXxq6RK+IkSfNxCPAaWe7Sd1Zpw3GK4LFwCOpD24O8iCcs7gDXE4YWN3BsrWaKVUDfUuKDfztGTlCPM1IGztxOPCNEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768054; c=relaxed/simple;
	bh=ZPZAu3Yx3uQxIFiVlHQEp7xY9ST1BHQ/DaO3u8rBR7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMcpGn0UK6P+X8gERHmW0FTyY2rr6n6jfcBPt+Bap3wMyBCX/HQf9dH73MdpppFPjhlB4hLyeXKwBGfJ3AhvRJ74iwPu9LoMVHZH6eIy35UFsZRpkDG/5n4PyCkUeNVwrbKYCMT1ZyDQlSXhKbJv4C2PiZ/uNop/8e376pbsfZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Kc/FraVr; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 998811F83E;
	Mon, 10 Nov 2025 10:47:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1762768040;
	bh=KQl61L9I9u2xQQF1X/UfEPM0pFoUMJSuuR9eAoGyqZU=; h=From:To:Subject;
	b=Kc/FraVr8ImWie5WC1jnKVxUUKZybUzTIr+lzPA9SNd+LOWtP8X4l7o9cIbp8+bE9
	 X7LRhRkAuMGkcvqGne9Inav3v9pAP1H3J8MWs8Z1CSFACj55DSesFQEOc/2Ur+Ko+W
	 WHDSHDbY7ftYB9eXrwj60NNdKXU6MQjine3zfmej8XYClIUJn2dywB6/4F/zDEu/Up
	 hJV1RNG2/stKN+IszKMJKbcXntU92f+dPCW66xCMC8Eu5odPidFQaO9XFn3bgN0hF4
	 6KSFmZeCpbHUDXsyMEw/sCSUL7Jf0Wh/m7QoWoXwMmbHUWjV4EnOrpNhmM47Ny9krY
	 VGTL7LA9c+6/w==
Date: Mon, 10 Nov 2025 10:47:16 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Andrew Davis <afd@ti.com>,
	Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Parth Pancholi <parth.pancholi@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 2/3] arm64: dts: ti: Add Aquila AM69 Support
Message-ID: <20251110094716.GA7356@francesco-nb>
References: <20251104144915.60445-1-francesco@dolcini.it>
 <20251104145240.61219-1-francesco@dolcini.it>
 <20251104145240.61219-2-francesco@dolcini.it>
 <d77bf3dd-4501-4f17-a776-3353f96f4fb1@ti.com>
 <20251105115335.GA14157@francesco-nb>
 <7024f4b3-00a0-4618-8bf9-53e305fcc982@ti.com>
 <20251106101932.GA5975@francesco-nb>
 <e1b2a13d-fab0-47f1-aae3-f2661c94d54a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1b2a13d-fab0-47f1-aae3-f2661c94d54a@ti.com>

Hi Vignesh,

On Mon, Nov 10, 2025 at 10:06:58AM +0530, Vignesh Raghavendra wrote:
> On 06/11/25 15:49, Francesco Dolcini wrote:
> >>> Yes, known. Is this an issue?
> >>>
> >>> This node must be disabled, no matter what is present in any included
> >>> dtsi file, it's a deliberate decision.
> >>>
> >>> This dtsi file describes a SoM, the used pins/functions are defined on
> >>> the pinout, but this node cannot be enabled unless the SoM is mated with
> >>> a carrier board that is exposing it.
> >> Same as my point above, you shouldn't enable nodes that are not used
> >> or have anything attached. The SoM only has some edge connectors so
> >> it should not be enabled at the SoM level, that we seem to agree, but
> >> the carrier board doesn't connect those lines to anything either. They
> >> just run to a pin header with nothing attached, how is that header
> >> any different than the pins on the edge of the SoM?
> > You are commenting something unrelated here, or I am not understanding
> > you.
> > 
> > You commented that the status = "disabled" is redundant. We both agree
> > that this node needs to be disabled in the SoM dtsi, and it is already
> > like that.
> > 
> > I would prefer to keep the redundant "disabled", because I see value on
> > not having to rely on what is done on any included dtsi, where the
> > original node is defined. 
> 
> 
> One can always reverse compile the DTB to see if a node is enabled or not.

Sure. My reason for having it explicitly disabled here is not to have to
depend on anything that is happening on the included dtsi on this
regard, given that we really want those disabled in the SoM.

See for example https://lore.kernel.org/all/20251015111344.3639415-1-s-vadapalli@ti.com/
where you can see that our verdin am62 was not impacted by this change
at all. 

To me this is just a benefit, without any drawback.

> > I see this as a common pattern in multiple
> > dts/dtsi file and is what I would prefer to have (and I do not see any
> > kind of maintenance  overhead on having it nor this being in conflict
> > with dts-coding-style.rst).
> 
> I cannot seem to find any precedence to such a pattern (adding status =
> "disabled" for nodes that are already disabled at SoC level dtsi.) Could
> you point me to some?

Just a couple of examples, you can easily find more if needed

  k3-am62-verdin.dtsi:&main_spi1
  nxp/imx/imx6qdl-phytec-phycore-som.dtsi:&fec


> > Vignesh, Nishanth, what is your expectation on this redundant
> > `status = "disabled"` property?
> > 	
> 
> Assuming such pattern exists, please add a note in the commit message in
> the next version.

With that said, it's a small thing, if you prefer me to change it just
let me know and I'll send a v2 with this changed.

Vignesh: do you prefer a v2 with a mention in the commit message on the
`disabled` node, or that I just get rid of those? Anything else that you
spotted on this patch and that should be changed?

Francesco


