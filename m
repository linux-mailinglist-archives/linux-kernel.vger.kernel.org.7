Return-Path: <linux-kernel+bounces-882387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53373C2A4FD
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 08:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F38513487BF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 07:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52B429B224;
	Mon,  3 Nov 2025 07:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JKhQo3Yo"
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B6529AB05
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154777; cv=none; b=PKlpl9piH1P4NH1D/LhQEc/wdXxKjQ6StiNJ4NCcdk6KuxDnbbhLaWt9ZuiVEyOEge8rxD+ENbI3fgCEfCFCPLn7eBwfDbMh0CtKnSyNfKbb0ni2CaeQwQvEP9wRFyX9tfnmHHPJGjLAxyT4Zqrcn+BNznsw3XSeIs/1jzOp1xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154777; c=relaxed/simple;
	bh=Otd7bdxN+rfrR3bs+j6ZJjbd9hlt9mHkn4DmkAdXHJs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gbZmXOTT1E9FgJw3PHFGfZIbZlZa61romWuErab5h2sOS0jkDglLzEzIJ6VY96RTROna8X0OEBH2PpeET+uk7pyZ7idn6URSDP9wXq+z3z2I37sSICS4XqdSushROmwOPV7TTt31ujZTFrsmVv2WcEVN1hPRnmVqF2pvsNxcODE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JKhQo3Yo; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E7772EC00A3;
	Mon,  3 Nov 2025 02:26:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 03 Nov 2025 02:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762154772; x=1762241172; bh=PX5prZmahrgIhU+JbpH47LcMvc0AFM9ySNd
	raK9Ud/c=; b=JKhQo3YoXbYZpttHEkp/VzRzZ+zsA4JJPVBjTs9ObI96ELmjiXJ
	3bgZaO7IO28F7ZxAR4p/3gvJ5w94dcpYmpRHRFsqbYvPExECiloT2MHBwCtzQ2QN
	Zo+r081EFl0oEkmbFfv/9EFTKbKuQe/x3Mzi5IQTRsDyfvUwvET6ihul5I7sOXjS
	LaB9duP/puZKFuyvmWQDVpe64dCRLbdQCk9sSowrnUtgAAqLCryn+X6MhfWGwr93
	j5OUHy6TlbKVsYZGN3DJQF3oiHHMuYizx/nRLTH85P9YQMWuy51E5rniW/XWxnKI
	QF8582XslPwikLYYRLorSeOI2rZmimpEECQ==
X-ME-Sender: <xms:E1kIaYl8JOPjS-j3yFMlOJK7JOiIplv4c80tVxwFlQL4nom9cl9uVw>
    <xme:E1kIaTqH6dfYtsVTb5eOXY5Y0tqsjec8yQd6D-z338uUWSEerbHPJZsjKxdw7uqRo
    LT7NWXsqOEFh7BoCVwUnzXRgnf69T6qZ715cDjFLqMmFMhiPzQkxLg>
X-ME-Received: <xmr:E1kIaSDptXscHynC45OT4jocW6HYUEL9KWtXBkapk922NtkulIOYWYi2ZwuxlupiZ0-XS55Dil5zUS2XyBvN4t5dNFHnmssyb7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeuheeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeduuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugiesthhrvggslhhighdrohhrgh
    dprhgtphhtthhopehushgvrhhmheejseihrghhohhordgtohhmpdhrtghpthhtohepmhhp
    vgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghpthhtohepnhhpihhgghhinhesghhmrg
    hilhdrtghomhdprhgtphhtthhopegthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhr
    ohhuphdrvghupdhrtghpthhtohepshgrmhesrhgrvhhnsghorhhgrdhorhhgpdhrtghpth
    htohepsggvnhhhsehkvghrnhgvlhdrtghrrghshhhinhhgrdhorhhgpdhrtghpthhtohep
    lhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:E1kIaeE_FfgsNskovQSA7E_VFEENGQ6iM_wWINonI8A0PYjrkEli0w>
    <xmx:E1kIaU3vZgDv1anx4lcTGSu7HrfwcWAPtrytRL9fD4yXVachoZ_xHw>
    <xmx:E1kIaXPjzTI_L1FdaVTDQPLzVzitx9urVxiD45ks-7jCDGoKO1hvmQ>
    <xmx:E1kIacY3oM0B64yU5wJxmfSCYXfjDPEcGweelGfldRYrRVQwec4y_A>
    <xmx:FFkIafGIA-HvFZtAdfZFwMZLMrcjjkmS59C5w6p5uUC0V112cuUfGRJT>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 02:26:08 -0500 (EST)
Date: Mon, 3 Nov 2025 18:26:16 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
cc: Stan Johnson <userm57@yahoo.com>, mpe@ellerman.id.au, npiggin@gmail.com, 
    christophe.leroy@csgroup.eu, sam@ravnborg.org, benh@kernel.crashing.org, 
    linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
    rdunlap@infradead.org, Cedar Maxwell <cedarmaxwell@mac.com>
Subject: Re: [PATCH v4] powerpc: Use shared font data
In-Reply-To: <aQgJ95Y3pA-8GdbP@gallifrey>
Message-ID: <797f0a13-350f-e26d-f1ef-876419e1c013@linux-m68k.org>
References: <20230825142754.1487900-1-linux@treblig.org> <d81ddca8-c5ee-d583-d579-02b19ed95301@yahoo.com> <aQeQYNANzlTqJZdR@gallifrey> <20108eef-b7cf-3f23-264a-5d97021f9ffa@linux-m68k.org> <aQgJ95Y3pA-8GdbP@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Mon, 3 Nov 2025, Dr. David Alan Gilbert wrote:

> 
> > Anyway, I imagine that the problem with your patch was that it relies 
> > on font data from a different (read only) section, which is 
> > unavailable for some reason (MMU not fully configured yet?)
> > 
> > So I've asked Stan to test a patch that simply removes the relevant 
> > 'const' keywords. It's not a solution, but might narrow-down the 
> > search.
> 

Stan tested my patch to remove 'const' from the font_desc and font_data 
structs but it did not help. (There goes that theory.)

> I wonder if this is a compiler-flag-ism;  I see 
> arch/powerpc/kernel/Makefile has a pile of special flags, and for 
> btext.o it has a -fPIC (as well as turning off some other flags). I 
> wonder if bodging those in lib/fonts/Makefile for 
> lib/fonts/font_sun8x16.c fixes it? But... this is data - there's no code 
> is there - are any of those flags relevant for data only?
> 

I don't know. But I'm sure Stan would be willing to test a patch for you.

> > 
> > The BootX bootloader doesn't work on New World systems, which is 
> > probably why we don't see this regression on anything newer than a 
> > Wallstreet.
> > 
> > It's likely that other Old World systems are also affected, if they 
> > are using BootX. We don't yet know whether the regression also affects 
> > Old World systems using the iQUIK bootloader instead of BootX.
> 
> OK, remember I don't think I've ever tried PPC via MacOS booting, so not 
> familiar with it.
> 

I will try to set up a MacOS guest in QEMU, to see if the hang can be 
reproduced that way.

