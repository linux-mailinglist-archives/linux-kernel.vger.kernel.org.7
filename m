Return-Path: <linux-kernel+bounces-895058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2D1C4CD51
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A0A3A8960
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81052FC030;
	Tue, 11 Nov 2025 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WVN04Tna"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750AF2EDD51;
	Tue, 11 Nov 2025 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854780; cv=none; b=CDkiD0TfbeXchs6Uf/dyYblaywnv/zp8sFvuhO6dezFGnN9vo0HMvzC+rmAYm+bKLa3X+jVjzGSV0hEkNF0SSVl/JWptUfpd/QHBP7Z972xCMlP5MSVnYg+tUic6ZPcRuF1HOokEdH/JWZXDwyPiaUnCgSBFhCK8e3btHtNK9cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854780; c=relaxed/simple;
	bh=Irzh1PTNsLt8R/60k1PuvPBimXLH1RDXRsIyuXJHTCg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNNXF60h+dNMuLl8EpDUvp+VVvUosOoQfOqEJr4U1/3etl+VINqJ/Hfl87kmN2EAeBlqtOAb8s2RXHFHMIvfm2GrCmzGYHlsmoCoo0uDawZC8zJfizL6i72MMjeSt0GOervtTozZdgPkJEa9PsGKLQuvGX7rfmOQiTQlth0on54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WVN04Tna; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762854778; x=1794390778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Irzh1PTNsLt8R/60k1PuvPBimXLH1RDXRsIyuXJHTCg=;
  b=WVN04Tna99j/yUr93n177RcMQXG4B2KCZQoigfC2XHw+Jx/0nYuYOe9o
   IcBFUlpoCgVGmR/evtuycVxF5Zd5sfx8iu9MmxJXGseJRJv+J3bvoSMqu
   +JxPKsI5Z2mPHosaFIT9kCJzeB3M8odAOkVGxwMmDl2uqE15LutIErJiQ
   UMyaUqu1R2V16aXJTBeYNsT197ycE/zoaQLK7w6XvVTvTwaldWYLRkjQA
   /fULLt+Gactyl47BQbe6E79X0nijcvr77/WLinEuUIH+LHOKxm8DcZtZP
   zAusqFFyvTZWPGaTz2iqhdfb0tS6cNelX/2X4jaAb1HROl7Q71ltVpxXW
   A==;
X-CSE-ConnectionGUID: 7IfXqfEJTEGKMKthwNbgEg==
X-CSE-MsgGUID: mUYY+TfiREmm6rhAZ3a50Q==
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="48307863"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2025 02:52:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 11 Nov 2025 02:51:47 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 11 Nov 2025 02:51:47 -0700
Date: Tue, 11 Nov 2025 10:50:16 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linux-phy@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Daniel Golle
	<daniel@makrotopia.org>
Subject: Re: [PATCH 0/2] phy: microchip: lan966x: Allow to invert N and P
 signals
Message-ID: <20251111095016.42byrgj33lp4bouo@DEN-DL-M31836.microchip.com>
References: <20251110110536.2596490-1-horatiu.vultur@microchip.com>
 <20251110114216.r6zdgg4iky7kasut@skbuf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20251110114216.r6zdgg4iky7kasut@skbuf>

The 11/10/2025 13:42, Vladimir Oltean wrote:
> 
> Hi Horatiu,

Hi Vladimir,

> 
> On Mon, Nov 10, 2025 at 12:05:34PM +0100, Horatiu Vultur wrote:
> > Allow to invert the N and P signals of the Serdes for both RX and TX. This
> > is used to allow the board designer to trace more easily the signals.
> >
> > Horatiu Vultur (2):
> >   phy: microchip: lan966x: Add support for inverting the rx/tx lanes
> >   dt-bindings: phy: lan966x: Add optional microchip,sx-tx/rx-inverted
> >
> >  .../phy/microchip,lan966x-serdes.yaml         | 24 +++++++++++++++++++
> >  drivers/phy/microchip/lan966x_serdes.c        | 23 ++++++++++++++++++
> >  2 files changed, 47 insertions(+)
> >
> > --
> > 2.34.1
> 
> For context, I am trying to describe the lane polarity property
> generically, and I've already blocked Daniel Golle's attempt to
> introduce the similar in intent "maxlinear,rx-inverted" and
> "maxlinear,tx-inverted".
> https://lore.kernel.org/netdev/20251028000959.3kiac5kwo5pcl4ft@skbuf/
> 
> I am trying to find out all there is to know in order about this
> feature, and I just noticed your patch, so I have to ask some questions
> in order to understand, had a generic property existed, whether you
> would have used it.

Yes, if there was something generic that would fit, I would like to use it.

> 
> So I see that you don't have OF nodes for individual SerDes lanes, so
> this makes your device tree structure incompatible with simple
> "tx-polarity"/"rx-polarity" properties. Are those something you're not
> willing to introduce? 

Do you propose to change the device tree to describe each SerDes lane
individualy?
Apparently in the lan966x_serdes we have also the port muxing which I am
not sure it should be there as it should be in the switch. I have done
it this way because I have use the phy-ocelot-serdes.c as an example.
If I change the device tree to describe each lane, then first I need to
take the port muxing which is fine for me. But there might be a problem,
if someone will use a newer kernel with an older device tree, it would
break the things?

> What about other stuff that's in
> Documentation/devicetree/bindings/phy/transmit-amplitude.yaml?
> You also won't be able to make use of the existing device tree
> properties if you don't have OF node containers for each lane.

To be honest, I haven't look at transmit-amplitude.yaml yet.

-- 
/Horatiu

