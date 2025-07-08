Return-Path: <linux-kernel+bounces-722022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA7FAFD221
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9C518972B8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274552E2F0D;
	Tue,  8 Jul 2025 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W5tDj252"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064D52E5B11;
	Tue,  8 Jul 2025 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992806; cv=none; b=NR/ikgi2EIZDSyogmJwJzNs/e+6WjZOnDnfbBUrMt9pE0KhdWnke/jD1J8GTjHNwEmysZwUDGk3HMM77g/rLag/oZ0s/CDHclDKu5jEn0ZIB90JKur1KsD5a4Zx5UDp251t8eOXah/nf6wZCS53qZR0gJbfGP6RIYQmy5BXQqcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992806; c=relaxed/simple;
	bh=ONbcMMuBpDKvVYqTKA6WEv/23LdYMCSzD36Cn6S4Wes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqz8DrcNXtW6QB1vwjCX1Wo9JqJP35048ELDWh4Be/JdLHOnXW207v97T8N9a1VvjRDU1e9xeIwbk+r9g9+ekrewv6dXxbCqUL3SdHrp5qQffF2/BhiPxHwjB8CdR2Tl7y+CfxOL6wyvN1W2xu6rSsdBUmk2SNTQ2OHTNQYasj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=W5tDj252; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dWz3CQl3Hyfv4Ozhor8+07wg6X7dBTPFYEAyJfxYObQ=; b=W5tDj252G837QmC8BdmftZjzei
	j2OFy2XAgMpSVYiMTPnWSatB5hUYTehmfiGGEpsCcr0WOrKzkSfIw9/+JS4X7ltAaDxvMSnos0+vl
	Mhm1vNbSwFDbffuN/sYNjoUnDFSxjeP0tQuFf+/lh3CaVHB+B0IxkP1g8eGkOdhQaOe4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZBMA-000qSM-HV; Tue, 08 Jul 2025 18:39:46 +0200
Date: Tue, 8 Jul 2025 18:39:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lukas Schmid <lukas.schmid@netcube.li>
Cc: Andre Przywara <andre.przywara@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 3/5] ARM: dts: sunxi: add support for NetCube Systems
 Nagami SoM
Message-ID: <b3c18067-f06e-4818-bf0b-e33fdf27b174@lunn.ch>
References: <20250707184420.275991-1-lukas.schmid@netcube.li>
 <20250707184420.275991-4-lukas.schmid@netcube.li>
 <20250708002205.70ec9097@minigeek.lan>
 <3700020.R56niFO833@lukas-hpz440workstation>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3700020.R56niFO833@lukas-hpz440workstation>

On Tue, Jul 08, 2025 at 05:19:31PM +0200, Lukas Schmid wrote:
> On Dienstag, 8. Juli 2025 01:22:05 CEST Andre Przywara wrote:
> > On Mon,  7 Jul 2025 20:44:15 +0200
> > Lukas Schmid <lukas.schmid@netcube.li> wrote:
> > 
> Hi Andre,
> 
> > Hi Lukas,
> > 
> > please try to refrain from sending subsequent patches too quickly, that
> > might just put off and confuse reviewers. To acknowledge a change
> > request, it is probably sufficient to just reply to the mail with a
> > confirmation.
> 
> Sorry about that. I'm still trying to get the hang of this whole "submitting 
> patches" thing. What is a good time/reason to send the next revision/version 
> of a patchset?

It varies per subsystem. For netdev there is a clear rule to wait 24
hours. For other subsystems, it might not be documented. GregKH used
to say he would always respond within 2 weeks for USB patches. To some
extent, you just need to see how fast each Maintainer works, and
resubmit based on that.

Also, if there is a discussion going on, you need to wait for that
discussion to come to some sort of conclusion before reposting a new
version.

	Andrew

