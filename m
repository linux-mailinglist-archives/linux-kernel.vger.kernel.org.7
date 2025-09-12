Return-Path: <linux-kernel+bounces-813603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076A0B5482E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BCFF482E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED191280CFA;
	Fri, 12 Sep 2025 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GEk1kG1U"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007BC27B337
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670062; cv=none; b=eAGw9rlDGWgKF8fxnA5drO2NUfDXuGm8CH34Bh0uAWV4E0rFebzZus5Y5WHqZRZcEdsXrQaaDrDcKEAfHAq8+/rIKJlYSvjUVJMYTu2uWrVMnpICsuWjRYVT5PH6FzGjPd7ctxEMGFqzaudyKQLMDZimlvmRzkblW6FE9Jkz/vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670062; c=relaxed/simple;
	bh=BH7CqmsvHPPdGqoLyzJXfhl7pz0d6jIqPw0TUeR/8Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZqbRBnltPu/damsggth+dBr6sLjnHleG1r4VW+BthxClFx60QS+DAEhx8/di4tPDG1Tqx9wqI2xDHb1SNYaDwvsTKV9kj4Q2ZuldijcfOxX37kCMO3ADcLib3DmLecmDyyTrL0z0PrVAv2VnSpFZ0rDYgRY2ZEo4WItdkE8Z7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GEk1kG1U; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 418721A0C87;
	Fri, 12 Sep 2025 09:40:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 144C760638;
	Fri, 12 Sep 2025 09:40:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B400F102F28FD;
	Fri, 12 Sep 2025 11:40:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757670057; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aGohR6ZwN7IVvK/xkjACU4BzL/wpsxEBY2zURHYAXvg=;
	b=GEk1kG1UYxRFqOQ4qCeE/ExtZytcac5jN4GY28dN/Smu7ejEQTsarl5B8M7MpBzvv5AD12
	/4n4PAnVIvVIOp3HM96w0duxv6OJVpWD0gSiAR7g5X0COlTERYA9/B9L5SfvZFRSEX7Ph1
	qChjUJRaYQIAZN/UPO4PUqyOZSFIqKSXNSWPxb/k3M5WOfu7a907k6ZC/24o00ZykvPGTv
	VwG91NzZ2uqE4K/XByPiiNDTBaIncHHagf2oZBA5rZQ7H05RJIH4DAOIO8xd4MKngvSn8X
	EWvofgdpXJ5nFv2AidIa0MK9QRcYy4zdFmkcfcBPDVMtMPuqkD4s43LHKMhB1g==
Date: Fri, 12 Sep 2025 11:40:39 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Ayush Singh <ayush@beagleboard.org>, Krzysztof
 Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, Rob Herring
 <robh@kernel.org>, Jason Kridner <jkridner@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Davis <afd@ti.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion
 at ELCE
Message-ID: <20250912114039.30e8422f@booty>
In-Reply-To: <20250911121103.40ccb112@bootlin.com>
References: <20250902105710.00512c6d@booty>
	<aLkiNdGIXsogC6Rr@zatzit>
	<337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org>
	<aL5dNtzwiinq_geg@zatzit>
	<20250908145155.4f130aec@bootlin.com>
	<aL-2fmYsbexEtpNp@zatzit>
	<20250909114126.219c57b8@bootlin.com>
	<CAMuHMdVarhTFEhQoYHWCnJp0iWRCjm0wh_ryP73aOdUwVa0X4Q@mail.gmail.com>
	<aMEAXrAC0uEW2sCc@zatzit>
	<20250911121103.40ccb112@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On Thu, 11 Sep 2025 12:11:03 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> Hi David, Geert,
> 
> On Wed, 10 Sep 2025 14:36:46 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
> ...
> > > 
> > > A PMOD Type 2A (expanded SPI) connector provides SPI and 4 GPIOS.
> > > A PMOD Type 6A (expanded I2C) connector provides I2C and 4 GPIOS.
> > > Hence a plug-in board that needs SPI, I2C, and a few GPIOs, would need
> > > to plug into two PMOD connectors.
> > > 
> > > Or:
> > > A PMOD Type 1A (expanded GPIO) connector provides 8 GPIOS.
> > > Hence a non-multiplexed dual 7-segment LED display plug-in board needs
> > > 14 or 16 GPIOS, and thus would plug into two PMOD connectors.
> > > 
> > > To plug into two connectors, a mapping needs to provided between two
> > > connectors on base and add-on board.
> > >   
> 
> Base on this, let me draft some ideas to have some basis to move forward.
> 
> Suppose:
> - A base board with:
>   2x PMOD Type 2A (SPI + 4 GPIOS)
>   1x PMOD Type 6A (I2C + 4 GPIOS)
>   3x PMOD Type 1A ( 8 GPIOS)
> 
> - An addon board which needs:
>   - 1x PMOD type 2A
>   - 2x PMOD type 1A
> 
> Hardware connection:
>   base board               addon board
>     PMOD 2A #0    +------+ PMOD 2A
>     PMOD 2A #1
>     PMOD 6A
>     PMOD 1A #0 
>     PMOD 1A #1    +------+ PMOD 1A I
>     PMOD 1A #2    +------+ PMOD 1A II
> 
> The base board 'PMOD 1A #0' is not connected to the addon board.
> The addon board uses the base board PMOD 1A #1 and #2.
> 
> 
> The base board DT:
>     pmods {
> 	compatible = "pmods";
> 
>         pmod_2a_0: pmod-2a-0 {
> 	    compatible = "pmod-2a"
> 
>             /* Describe 4 gpios connected to this connector */
>             gpio-map = < 0 &gpio 10>,
>                        ...
>                        < 3 &gpio 43>;
> 
>             /* Describe the bus connected to this connector */
>             spi_bus_2a_0: spi-bus {
>                 compatible = "spi-bus-extension";
>                 spi-parent = <&spi2>;
>             };
> 		
>             /* Export symbols related to this connector */
>             export-symbols {
>                 pmod-2a = <&pmod_2a_0>;
>                 spi = <&spi_bus_2a_0>;
> 	        ...
>             };
> 	};
> 
> 	pmod_2a_1: pmod-2a-1 {
> 	    compatible = "pmod-2a"
> 
>             /* Describe 4 gpios connected to this connector */
>             gpio-map = ...
> 
>             /* Describe the bus connected to this connector */
>             spi_bus_2a_1: spi-bus { ... };
> 		
> 	    /* Export symbols related to this connector */
>             export-symbols {
>                 pmod_2a = <&pmod_2a_1>;
>                 spi = <&spi_bus_2a_1>;
>                 ...
>             };
> 	};
> 
> 	pmod_6a: pmod-6a {
>             compatible = "pmod-6a";
>             ...
>             export-symbols {
>                pmod_6a = <&pmod_6a>;
> 			...
> 		};
> 	};
> 
> 	pmod_1a_0: pmod-1a-0 {
>             compatible = "pmod-1a"
> 
>             /* Describe 8 gpios connected to this connector */
>             gpio-map = < 0 &gpio 16>,
>                        ...
>                        < 7 &gpio 33>;
> 
>             export-symbols {
>                 pmod_1a = <&pmod_1a_0>;
>                 gpio0_muxed_as_gpio = <&pin_mux_xxxx>;
>                 gpio1_muxed_as_gpio = <&pin_mux_yyyy>;
> 		gpio2_muxed_as_gpio = <&pin_mux_zzzz>;
>             };
>         };
> 
>         pmod_1a_1: pmod-1a-1 {
>             compatible = "pmod-1a"
> 
>             /* Describe 8 gpios connected to this connector */
>             ...
> 
>             export-symbols {
>                 pmod_1a = <&pmod_1a_1>;
>             };
>         };
> 
>         pmod_1a_2: pmod-1a-2 {
>             compatible = "pmod-1a"
> 
>             /* Describe 8 gpios connected to this connector */
>             ...
> 
>             export-symbols {
>                 pmod_1a = <&pmod_1a_2>;
>             };
>         };
>     };
> 
> 
> -- Question 1: How to describe resources needed by the addon
> 
> On the addon side, we need to tell that we need 1 PMOD 2A and 2
> PMODs 1A (named i and ii).
> 
> Proposal supposing that this description will be applied at
> base board pmods node (the one grouping pmod connectors):
> 
> \{ or ??? corresponding to the entry point of the addon
>    import-symbols {
>       pmod_2a = "pmod_2a";
>       pmod_1a_i = "pmod_1a";
>       pmod_1a_ii = "pmod_1a";
>    };
> 
>    &pmod_2a {
>       spi-bus {
>         regulator@0 {
>            compatible "gpio-regulator";
> 	   pinctrl-0 = <&pmod_1a_i.gpio2_muxed_as_gpio>;
>            enable-gpios = <&pmod_1a_i 2>; /* Use GPIO #2 available on PMOD 1A I */
>         };
> 
>         ...
>    };
> };
> 
> Import-symbols asked for symbols with local name and type (compatible string ?).
> for instance 'pmod_1a_i = "pmod_2a";' means:
>   Hey I refernce localy 'pmod_1a_i' but I don't define it and so 'pmod_1a_i' should
>   be remapped to a symbol, probably a node of my expected type "pmod_2a".
> 
> Also, we can node the syntax:
>   &pmod_1a_i.gpio2_muxed_as_gpio
> 
> meaning I use the symbols gpio2_muxed_as_gpio provided by pmod_1a_i (namespace).
> In other word, to have the addon DT successfully applied,
> the node remapped to 'pmod_1a_i' has to export the symbol 'gpio2_muxed_as_gpio'.

Thanks for taking time to prepare a complete example. I think this
example is very effective as it exposes perhaps all the features we are
discussing.

I consider it pseudocode, i.e. the syntax may not be OK, but that's not
too relevant at this point of the discussion. But as far as I can say
it has the right information at the right place, and IMO that's what we
need to iron out in the first place.

> --- Question 2: how to perform the mapping between pmods available on the
>     base board and pmods needed by the addon board.
> 
> The addon board describes what it is expected:
>   import-symbols {
>       pmod_2a = "pmod_2a";
>       pmod_1a_i = "pmod_1a";
>       pmod_1a_ii = "pmod_1a";
>    };
> 
> Based on compatible string:
>   pmod_2a expected by the addon can be remapped to the node
>   pmod-2a-0 or pmod-2a-1 described in the base board.
> 
>   pmod_1a_i and pmod_1a_ii expected by the addon can be remapped
>   to pmod-1a-0, pmod-1a-1, pmod-1a-2.  
> 
>   We need some more information to set correct mapping
>     pmod_2a <---> pmod-2a-0
>     pmod_1a_i <---> pmod-1a-1
>     pmod_1a_ii <---> pmod-1a-2
> 
>   Can we imagine that this mapping is set by the compatible "pmods"
>   driver base on some specific external information.
>    - Read info from addon to have some more hardware connection
>      details (not sure it is relavant with PMODs connector)
> 
>    - Expect this information from user-space ?
> 
>    - Any other ideas ?

I'd say the only possible answer to question 2 is "this is specific to
each connector type and thus to each connector driver".

As you just described in [0], some connector types have model discovery
capabilities so the driver can do on its own. In principle this might
apply to addons using multiple connectors.

However for PMODs AFAIK there is no discovery at all, so the driver must
be instructed by the user.

[0] https://lore.kernel.org/all/20250911122333.2e25e208@bootlin.com/

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

