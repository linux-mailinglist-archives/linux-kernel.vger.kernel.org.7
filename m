Return-Path: <linux-kernel+bounces-871472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B3CC0D6BF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79799406B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB152FFF81;
	Mon, 27 Oct 2025 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GrMibrmT"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28752FB09C;
	Mon, 27 Oct 2025 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761566525; cv=none; b=KY1KYwthX7XByWPeEG4LPQZtJqmX+euUQ4lii8jx9lSsESc0kY+MZxRkNNWaTH6DJL4bKDEhcRVBcF11KGro8RMMGDGqPswHjDfrj3xQc3i6ynsvC+H4lTgf8NJoBibiyvXbTKpq4nFht5mrIDAMt+Ehr1k5SckI9bCfsK/3WeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761566525; c=relaxed/simple;
	bh=GhjZkO0YBy/OMPm6/mkRVqZ1k7ALj+6jPmWbikAYjYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzImzL8kNBk1p6YA36MiAD1rUt1jtcGZA0Pakj57shBuQ9cuzvoAGcRuRH4ns2MQOEfiRFnaEsb/XSkjj2tGsenFeLIEFVL0E86AW1UrpsAyXTOlRVjnksINFLlkRmpkm2jwaHnf8aU0xmlP3OjpNWvKIW8WfU4wXOazQNFkYJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GrMibrmT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FdoLUkFsTrx3NpFcZ9/EDnFFAX0bYLccLygNQPaZVns=; b=GrMibrmTQ7wGPam738kHj/tSaX
	IsT0YMk50MEpusuZFh1pLbq15Efa1km3bGjICrTTGK0kTSVVdkoM7eSer0kQ5PQJeaLJa6S22x4f9
	PtWcj2AyljqPqv/UB3DBWGBVWTRwddCfAUEcO6S5tVF7QvS5v53mIGKCQ7AMrD2hTEDI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDLui-00CBcN-Nb; Mon, 27 Oct 2025 13:01:28 +0100
Date: Mon, 27 Oct 2025 13:01:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Arnd Bergmann <arnd@arndb.de>, BMC-SW <BMC-SW@aspeedtech.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Jeremy Kerr <jk@codeconstruct.com.au>, Lee Jones <lee@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Nishanth Menon <nm@ti.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Taniya Das <quic_tdas@quicinc.com>,
	"Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC
 device tree
Message-ID: <01573262-69a8-44cf-ae02-2e9842c59dde@lunn.ch>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com>
 <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com>
 <TY2PPF5CB9A1BE6CF8336D211641A18E2DEF2F1A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <71df9bdf-53b2-45e2-a9e3-5b00a556f957@lunn.ch>
 <TY2PPF5CB9A1BE6F3E95C7FD61CF4F90ECAF2FEA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <fdbc471f-514e-4521-b7a1-dcf6127d64ff@lunn.ch>
 <TY2PPF5CB9A1BE6DD93D0F397C961D5CB5AF2FCA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PPF5CB9A1BE6DD93D0F397C961D5CB5AF2FCA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>

On Mon, Oct 27, 2025 at 02:42:01AM +0000, Ryan Chen wrote:
> > Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device
> > tree
> > 
> > > SoC0, referred to as the CPU die, contains a dual-core Cortex-A35
> > > cluster and two Cortex-M4 cores, along with its own clock/reset
> > > domains and high-speed peripheral set.
> > 
> > > SoC1, referred to as the I/O die, contains the Boot MCU and its own
> > > clock/reset domains and low-speed peripheral set, and is responsible
> > > for system boot and control functions.
> > 
> > So is the same .dtsi file shared by both systems? 
> 
> This .dtsi represents the Cortex-A35 view only and is not shared
> with the Cortex-M4 or the Boot MCU side, since they are separate
> 32-bit and 64-bit systems running independent firmware.

DT describes the hardware. The .dtsi file could be shared, you just
need different status = <>; lines in the dtb blob.

> > How do you partition devices
> > so each CPU cluster knows it has exclusive access to which peripherals?
> 
> Before the system is fully brought up, Boot MCU configure hardware 
> controllers handle the resource partitioning to ensure exclusive access.

Are you saying it modifies the .dtb blob and changes some status =
"okay"; to "disabled";?

	Andrew

