Return-Path: <linux-kernel+bounces-811815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D72B52E38
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4EC3B6A17
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2651530FF37;
	Thu, 11 Sep 2025 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hQs2yNsV"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA662EA74B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586224; cv=none; b=hzkUU/5wE+2uVgrKISxu/11l1/IlC+1Vp5Rm7bWeJ/KyI713Mq1umIZf0s6SoIpk6Pw5yLt7ySv8oxo3e5RlcZG5gb4qe+DW/NxOLVQaquylMtNLMNdHIgde94Zq0k1Ep/wjj3AIzTHbGiXvsHqIujTjNdVC7dlc8A8pQ+SkwBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586224; c=relaxed/simple;
	bh=zj395NGtLp3wWDRiU7x8MlIhLyNVVrYHtjTxo8ibqjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qur2TC4GB/95Q57hUSmCCHkcMnvJlBf3AmeTU8aB97oKOW8lbldBuXxZh//ZVMURky80A7cFF7nigtc0zGJVo/scJZAKnXETJj7QsQ9iLrUJDEdcngObwAqfuDGUHg79Y1TV/TxyaYZqxJLKXOga5MqMlakJmXInXx0Jvx36M4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hQs2yNsV; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 80647C6B3AB;
	Thu, 11 Sep 2025 10:23:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 58977606BB;
	Thu, 11 Sep 2025 10:23:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B87C5102F28D9;
	Thu, 11 Sep 2025 12:23:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757586219; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fSrvBtmVDJ/Y7zdKA6slVDKkHGqVbp66YbTHBWoJXqg=;
	b=hQs2yNsVa7EzafMz5eljtqbV6kcvXx7k0u/ZW1wswB2c97Ub3rdAKVqN1LvzvkqmDkXvqp
	7c8SOTs2izMjM9g8P4ZrAjQ1LXOCkCVg4BGwpCupNkLcrK03a1SVSaTLfEMk6yUJZuF1yR
	3jyZ83dBWoIxB4yZ7oW01zrhAZwVFua3dRg4lEYD4/NZMaZNyYhg8tMiUUhOKLRVVFqlTh
	jaqkS3tE/4xKlqN5fOvJpFqHwP8PCN0Xoc4jUpPoywCeqBnI+6fA8hnVMi2wl0U5kKL9+h
	j1wHNqetzwYceeERZqWJ2MAPYR0T+MWA0E6ia5r1rzxdMgEv5NIFH6eGE15fdQ==
Date: Thu, 11 Sep 2025 12:23:33 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Ayush Singh
 <ayush@beagleboard.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, Rob
 Herring <robh@kernel.org>, Jason Kridner <jkridner@gmail.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Davis <afd@ti.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion
 at ELCE
Message-ID: <20250911122333.2e25e208@bootlin.com>
In-Reply-To: <CAMuHMdUUGoaetdsTEVx27TYQZ_khzyCn0wzi2+TibYcvkg1fXw@mail.gmail.com>
References: <20250902105710.00512c6d@booty>
	<aLkiNdGIXsogC6Rr@zatzit>
	<337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org>
	<aL5dNtzwiinq_geg@zatzit>
	<20250908145155.4f130aec@bootlin.com>
	<aL-2fmYsbexEtpNp@zatzit>
	<20250909114126.219c57b8@bootlin.com>
	<aMD_qYx4ZEASD9A1@zatzit>
	<20250911104828.48ef2c0e@bootlin.com>
	<CAMuHMdUUGoaetdsTEVx27TYQZ_khzyCn0wzi2+TibYcvkg1fXw@mail.gmail.com>
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

Hi Geert,

On Thu, 11 Sep 2025 10:54:02 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Hervé,
> 
> On Thu, 11 Sept 2025 at 10:48, Herve Codina <herve.codina@bootlin.com> wrote:
> > On Wed, 10 Sep 2025 14:33:45 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:  
> > > On Tue, Sep 09, 2025 at 11:41:26AM +0200, Herve Codina wrote:  
> > > > Suppose a base board with 2 connectors:
> > > >  - connA
> > > >  - connB
> > > >
> > > > Case 1: Addons are independant
> > > >                +--------+
> > > >   connA <----> | AddonA |
> > > >                +--------+
> > > >                           +--------+
> > > >   connB <---------------->| AddonB |
> > > >                           +--------+
> > > >
> > > > With addonA and B two addon board each connected at one connector without any
> > > > relationship between addon A and B
> > > >
> > > > Case 2: Only one Addons using ressources from both connector
> > > >
> > > >                 +------+
> > > >   connA <-----> |Addon |
> > > >                 |      |
> > > >   connB <-----> |      |
> > > >                 +------+  
> > >
> > > Case 2 is what I'm talking about.  Case 1 is the easy one.
> > >  
> > > > The addon is connected to both connector and uses ressources from connA and
> > > > connB in a dependent manner.
> > > >
> > > >
> > > > The Case 2 can be solved using a connector that described both connA and connB.
> > > > Having the split connA and connB is a mechanical point of view.  
> > >
> > > I don't think that's a good solution, because it means you have to
> > > make that decision at the board layer.  If I understand his case
> > > correctly, you have a board where you could do either case 1 or case 2
> > > at runtime.  We'd want the differences between these cases to only be
> > > reflected on the addon device tree, not the base board device tree.  
> >
> > Based on my understanding of Geer's use-case, I think decision at base
> > board level will be needed.
> >
> > base board        addon board
> >   connA +--------+conn1
> >   connB +--------+conn2
> >   connC +
> >
> > Or
> >
> > base board        addon board
> >   connA +--------+conn1
> >   connB +    ,---+conn2
> >   connC +---'
> >
> > Or any other combination that would match.
> >
> > From the addon board point of view, the only think we can
> > say is "me, as an addon board, I need a connector of type 'foo' and a
> > connector of type 'bar'".
> >
> > Also, at base board level, statically defined in the DT
> > connA is described (type 'foo'), connB and connC are
> > described (type 'bar').  
> 
> Correct.
> 
> > The choice to map connA to the type 'foo' connector expected by the addon
> > and the choice to map connB or connC to the type 'bar' connector expected by
> > the addon can only be done at runtime and probably with the help of a driver
> > that have the knowledge of the 3 connectors.
> >
> > I have the feeling that the choice of physical connectors to which the addon
> > board is connected to is a human choice when the board is connected.  
> 
> All these choices and decisions apply to single-connector add-on boards, too.
> 

Yes, in our use case (me and Luca), each addon has an eeprom, wired exactly the
same on all supported addon, which allows to known the exact addon. Also addon
insertions and removals are detected using some gpios wired to the connector.

Based on that our specific driver handling our specific connector perform the
following operations on addon insertion detection:
  - load a first addon DT to have access to the eeprom
  - Read the eeprom to determine the addon type
  - load the DT matching with the addon type

This part is of course connector type specific. I mean having an eeprom with
some encoded addon type values and hotplug detection with gpio is a part of
the contract between the board and the addon (part of connector specification).

Best regards,
Hervé


