Return-Path: <linux-kernel+bounces-868828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71687C0640F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6091C04F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2203164A4;
	Fri, 24 Oct 2025 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uogF3IuR"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867DE30F555;
	Fri, 24 Oct 2025 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761308940; cv=none; b=WtbJ7CFVqgRCAmFSXiByMmaP2LNuxtUhB+qFob2HadSAloZSPNjlmGZgIHXQckNNATePhvR1JyhjoN2HNZT91O3PuJLmQnKpnK8zShXQa+0TH+XzQkK10jmWh7GYZs4/A78aJkAd5v2baEYQNhSaa6fE9YMYu1qdym0oO3dmL3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761308940; c=relaxed/simple;
	bh=BE/akZXQwrdXjuyG2e5B2KI6YeEUFyqRwF71dm7STHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJ3l8BOFZ5Sx7Flspj5zEeIM15En/YZ4Ke2IQkF81yrX3DTIb6Dmoo24YYu/RdeR+KCKx7OFAAhZwpwJEvj/qn+5bzbZnyLlHhWN3XAkBigp/nHe8IDT74Z1w6wlIC56fSUyKE+qE7K5B5LtluTyDFB/u8mWaITPhU4JPJG/JB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uogF3IuR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bLpiuHTkVYJeeQyf1nxnU5c82uk7vYrn+Np6jyjJloc=; b=uogF3IuRHG65F4F/hUsAqYa5bv
	5bsEVw1N/nJ5cZ5HPwcZYOW/3aWpoNIZAMC/mgFUSrbwJIbB9xWFXoHv5GOUgsHFBY4vIbbu8qtEO
	Mv3EUx/1xB9l12UKduwnjXRhTIt7Dt2X8IJzQcM/ctu9HTVb2THqkYrI3S3QCdwG/jdo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vCGuA-00Bzil-7X; Fri, 24 Oct 2025 14:28:26 +0200
Date: Fri, 24 Oct 2025 14:28:26 +0200
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
Message-ID: <71df9bdf-53b2-45e2-a9e3-5b00a556f957@lunn.ch>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com>
 <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com>
 <TY2PPF5CB9A1BE6CF8336D211641A18E2DEF2F1A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PPF5CB9A1BE6CF8336D211641A18E2DEF2F1A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>

> > >> This probably needs some explanation: why are there two 'soc@...'
> > >> devices? Is this literally two chips in the system, or are you
> > >> describing two buses inside of the same SoC?
> > >
> > > The AST2700 is two soc connection with a property bus.
> > > Sharing some decode registers. Each have it own ahb bus.
> > 
> > I don't understand your explanation,
> 
> Let me clarify more clearly:
> The AST2700 is a dual-SoC architecture, consisting of two interconnected SoCs,
> referred to as SoC0 and SoC1. Each SoC has its own clock/reset domains. 
> They are connected through an internal "property bus", 
> which is Aspeed's internal interconnect providing shared
> address decoding and communication between the two SoCs.

By SoC are you just referring to peripherals? Or are there two sets of
CPUs as well?

If it is just peripherals, this has been done before by Marvell.

See armada-cp11x.dtsi. Marvell calls it a CP, they are identical, so
there is one description of it, which then gets included twice.

	Andrew

