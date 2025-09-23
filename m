Return-Path: <linux-kernel+bounces-829009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E113B96094
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33084845F9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3731F327A23;
	Tue, 23 Sep 2025 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DVpWf27E"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2917327A1B;
	Tue, 23 Sep 2025 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634631; cv=none; b=WYXfwCJGteQ+lalV+qduVR3k65xjQohpzKTlVokR0KZOAdkDP9m+tLKpxdkiU4Vbr8umyfe3uBh0KykSri8AyB0dVp4Wgp1OP8G2eswR8nTwwKmYhvuiaEh4AyYpYJOhB2DPVmusZmE8wD8q66RMxz0L0e/JpYQHObxOGxblmJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634631; c=relaxed/simple;
	bh=IjG04YAsgqRFw7Eb4bkKvESHmFuVAEmEfIf7vfwOwb4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNVUwmduxoNAzqpSqloQQ4r8uNNJSQWR1sv3r4rw9VcasbKrZOmUq9E+rwu751Ljp4SoH3mwiXVCX9ChJrdcJOPLfjzrkS0FUATZSpcS8Nd8/lu7xg2U8LFfu+IESXY3fMMfMtmx2t8z5XPBr8cAgaVsf3/1QUD5EoENvB/2ZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DVpWf27E; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id ACCA44E40CAD;
	Tue, 23 Sep 2025 13:37:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8088C60690;
	Tue, 23 Sep 2025 13:37:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 901BD102F1950;
	Tue, 23 Sep 2025 15:36:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758634625; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KBPR5buXz86hknin/D1hAnT/+VJp1Du2pRilGmtvOAw=;
	b=DVpWf27EyfK2+Gd/sf4BJ5J0yv2Sl36D5fnkCVNFBZOPRkyCLlgY8T+tPxjzW0F5YXpUtf
	0MpB8DZpOdzDeZ6108lfaKxgN7URcpdc9jNQ9EMVcuAwdFXi7+J6RelhVyIeZ2xgB/cGnf
	GBZet49ZmXyY4pV55yX0u3ta+loar2Zfq4chLMR2VEnaAn1X+WWdimwOJ/5BUkRc2Hfxlj
	t75DnNVvgCIXP91f+q52pTUY4itQz9RQ7XJIKAZqL1MiC0N71NUTC1MpBWkfFr52Dv6UvX
	drfeGAk7+xVfgs7+TNGrJVN8084+YjjJabDjkdZZ3KLOz51RW/D57fI/cdcp9Q==
Date: Tue, 23 Sep 2025 15:36:46 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Ayush Singh
 <ayush@beagleboard.org>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring
 <robh@kernel.org>, Andrew Davis <afd@ti.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, devicetree@vger.kernel.org, Jason Kridner
 <jkridner@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, devicetree-compiler@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion
 at ELCE
Message-ID: <20250923153646.754e86f8@bootlin.com>
In-Reply-To: <CAMuHMdWmDwedyPnBERs-tSYEG15nMUuh9u1Q+W_FdquHpUC0-A@mail.gmail.com>
References: <aL-2fmYsbexEtpNp@zatzit>
	<20250909114126.219c57b8@bootlin.com>
	<aMD_qYx4ZEASD9A1@zatzit>
	<20250911104828.48ef2c0e@bootlin.com>
	<aMebXe-yJy34kST8@zatzit>
	<20250916084631.77127e29@bootlin.com>
	<aMt5kEI_WRDOf-Hw@zatzit>
	<20250918094409.0d5f92ec@bootlin.com>
	<aMzhgDYOuG4qNcc0@zatzit>
	<dcbeaff2-0147-4a27-bb46-e247e42810d7@beagleboard.org>
	<aNJVqSpdAJzGliNx@zatzit>
	<20250923114849.2385736d@bootlin.com>
	<CAMuHMdWmDwedyPnBERs-tSYEG15nMUuh9u1Q+W_FdquHpUC0-A@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 23 Sep 2025 12:29:27 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Hervé,
> 
> On Tue, 23 Sept 2025 at 11:49, Herve Codina <herve.codina@bootlin.com> wrote:
> > On Tue, 23 Sep 2025 18:09:13 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:  
> > > Ah, right.  To be clear: we absolutely don't want multiple addons
> > > altering the same nodes.  But I think we could do that in ways other
> > > than putting everything under a connector.  This is exactly why I
> > > think we should think this through as an end-to-end problem, rather
> > > trying to do it as a tweak to the existing (crap) overlay system.
> > >
> > > So, if we're thinking of this as an entirely new way of updating the
> > > base dt - not "an overlay" - we can decide on the rules to ensure that
> > > addition and removal is sane.  Two obvious ones I think we should
> > > definitely have are:
> > >
> > > a) Addons can only add completely new nodes, never modify existing
> > >    ones.  This means that whatever addons are present at runtime,
> > >    every node has a single well defined owner (either base board or
> > >    addon).  
> >
> > In this rule I suppose that "never modify existing ones" should be understood
> > as "never modify, add or remove properties in existing ones". Because, of course
> > adding a full node in a existing one is allowed (rule b).  
> 
> What if the add-on board contains a provider for the base board.
> E.g. the connector has a clock input, fed by an optional clock generator
> on the add-on board.  Hooking that into the system requires modifying
> a clocks property in the base board, cfr. [1].
> Or is there some other solution?
> 
> I was also wondering about endpoints, as they have two sides: one on
> the base board, and one on the add-on board. But it seems that typically
> both ends are added by the extension, so these fall under rule b.
> 
> Thanks!
> 
> [1] https://elixir.bootlin.com/linux/v6.16/source/arch/arm64/boot/dts/renesas/white-hawk-ard-audio-da7212.dtso#L165
> 

Hi Geert,

Addon DT we talk about is not a way to fine tune base board devices.

For the clock, you need a clock driver which is able to support clock hot-plugging.
Same for endpoint, the remote endpoint part should support hot-plugging.

I don't think that addon DT should support what is done in the dtso you pointed out.

Best regards,
Hervé


