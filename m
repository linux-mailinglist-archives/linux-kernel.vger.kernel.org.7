Return-Path: <linux-kernel+bounces-812079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22861B532AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44DD37BABE2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C68322DBD;
	Thu, 11 Sep 2025 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OClbhVIp"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49FE3218D2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757594728; cv=none; b=WDRxwbmQNzg5V+ISRhB47QmgvBnFHFld7iZvtlgEZx5dn6kNwB+InP3PcCEUYM8NhScpI+pI4gnKTcBOpJygfBVC2pRRYEENP22ZR/aBbAf4dUTpocDxQ/IsQfg49GbBg9GmrSG253ZmFWzpTAkokAKXzLbn54GyK/IRkrjHS7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757594728; c=relaxed/simple;
	bh=XRcVmZ1ZyfltRROAE2ameocQTP7l5w0Qo71VLpa2cLs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gABwCoDbH+Dlbei2fiUnSQjOlYt1StqJWn6Kcx5E7RV4s0wB+JVR/maZb2sPUksfcKrzQVc1ox6/cGXLrTEurBQa02/k9o12Grij9FESiYQUu1sZY+bcGKcxdGjop9EkF2WYSD9+RKltP55/Ad0IGrf7r9MWOVH1uflboCnGfrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OClbhVIp; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E6F81C6B3B4;
	Thu, 11 Sep 2025 12:45:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C0ABF60630;
	Thu, 11 Sep 2025 12:45:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0D649102F28C0;
	Thu, 11 Sep 2025 14:45:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757594721; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tHh/qi/3IlidAk2jgmjJykEnX0p6XLUXjIm0eo+RjTQ=;
	b=OClbhVIpEM5AOkBoRnpvC38+a4UPnGhuoin+pzdvl+NrNXG198fX6S5FmLJ1yBAtB6ypMD
	Y02ZpH1DspR7wIVidLe3tF5XHjWn2Ud8dAGxsaSsNrT9zGcgIZ1ZMO7tnEs8TreRvw91eT
	rajPisCUsPti94lSN+Bll9Ywdxg1Yko5SfyeZWnlIar1EVKv4pdXrK7Mx1hFHPFtW3wcVW
	W9dwjfRMMazy6Ng3pUBqIdSvVMWeikw8GGuzZSjmH+zAZSKTuUxSrJOzH2Kqkkj1XRKjpK
	bEa4ttAC19uNKMFsCxdUegb7bXuxImJt5yY1SWKD6tnFU8xaq9TAenLHBzQLJw==
Date: Thu, 11 Sep 2025 14:45:06 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, David Gibson
 <david@gibson.dropbear.id.au>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, Rob
 Herring <robh@kernel.org>, Jason Kridner <jkridner@gmail.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Davis <afd@ti.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion
 at ELCE
Message-ID: <20250911144506.51809eb3@bootlin.com>
In-Reply-To: <36a85af7-75b1-46db-8df8-e83372d33b93@beagleboard.org>
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
	<20250911122333.2e25e208@bootlin.com>
	<36a85af7-75b1-46db-8df8-e83372d33b93@beagleboard.org>
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

Hi Ayush,

On Thu, 11 Sep 2025 17:45:17 +0530
Ayush Singh <ayush@beagleboard.org> wrote:

> On 9/11/25 15:53, Herve Codina wrote:
> > Hi Geert,
> >
> > On Thu, 11 Sep 2025 10:54:02 +0200
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >  
> >> Hi Hervé,
> >>
> >> On Thu, 11 Sept 2025 at 10:48, Herve Codina <herve.codina@bootlin.com> wrote:  
> >>> On Wed, 10 Sep 2025 14:33:45 +1000
> >>> David Gibson <david@gibson.dropbear.id.au> wrote:  
> >>>> On Tue, Sep 09, 2025 at 11:41:26AM +0200, Herve Codina wrote:  
> >>>>> Suppose a base board with 2 connectors:
> >>>>>   - connA
> >>>>>   - connB
> >>>>>
> >>>>> Case 1: Addons are independant
> >>>>>                 +--------+
> >>>>>    connA <----> | AddonA |
> >>>>>                 +--------+
> >>>>>                            +--------+
> >>>>>    connB <---------------->| AddonB |
> >>>>>                            +--------+
> >>>>>
> >>>>> With addonA and B two addon board each connected at one connector without any
> >>>>> relationship between addon A and B
> >>>>>
> >>>>> Case 2: Only one Addons using ressources from both connector
> >>>>>
> >>>>>                  +------+
> >>>>>    connA <-----> |Addon |
> >>>>>                  |      |
> >>>>>    connB <-----> |      |
> >>>>>                  +------+  
> >>>> Case 2 is what I'm talking about.  Case 1 is the easy one.
> >>>>     
> >>>>> The addon is connected to both connector and uses ressources from connA and
> >>>>> connB in a dependent manner.
> >>>>>
> >>>>>
> >>>>> The Case 2 can be solved using a connector that described both connA and connB.
> >>>>> Having the split connA and connB is a mechanical point of view.  
> >>>> I don't think that's a good solution, because it means you have to
> >>>> make that decision at the board layer.  If I understand his case
> >>>> correctly, you have a board where you could do either case 1 or case 2
> >>>> at runtime.  We'd want the differences between these cases to only be
> >>>> reflected on the addon device tree, not the base board device tree.  
> >>> Based on my understanding of Geer's use-case, I think decision at base
> >>> board level will be needed.
> >>>
> >>> base board        addon board
> >>>    connA +--------+conn1
> >>>    connB +--------+conn2
> >>>    connC +
> >>>
> >>> Or
> >>>
> >>> base board        addon board
> >>>    connA +--------+conn1
> >>>    connB +    ,---+conn2
> >>>    connC +---'
> >>>
> >>> Or any other combination that would match.
> >>>
> >>>  From the addon board point of view, the only think we can
> >>> say is "me, as an addon board, I need a connector of type 'foo' and a
> >>> connector of type 'bar'".
> >>>
> >>> Also, at base board level, statically defined in the DT
> >>> connA is described (type 'foo'), connB and connC are
> >>> described (type 'bar').  
> >> Correct.
> >>  
> >>> The choice to map connA to the type 'foo' connector expected by the addon
> >>> and the choice to map connB or connC to the type 'bar' connector expected by
> >>> the addon can only be done at runtime and probably with the help of a driver
> >>> that have the knowledge of the 3 connectors.
> >>>
> >>> I have the feeling that the choice of physical connectors to which the addon
> >>> board is connected to is a human choice when the board is connected.  
> >> All these choices and decisions apply to single-connector add-on boards, too.
> >>  
> > Yes, in our use case (me and Luca), each addon has an eeprom, wired exactly the
> > same on all supported addon, which allows to known the exact addon. Also addon
> > insertions and removals are detected using some gpios wired to the connector.
> >
> > Based on that our specific driver handling our specific connector perform the
> > following operations on addon insertion detection:
> >    - load a first addon DT to have access to the eeprom
> >    - Read the eeprom to determine the addon type
> >    - load the DT matching with the addon type
> >
> > This part is of course connector type specific. I mean having an eeprom with
> > some encoded addon type values and hotplug detection with gpio is a part of
> > the contract between the board and the addon (part of connector specification).
> >
> > Best regards,
> > Hervé
> >  
> 
> My usecase is a bit more complicated, since I am trying to model all the 
> available headers on BeagleBoard.org sbcs (particularly PocketBeagle 2 
> initially) as connectors. However, that still ends up being a single 
> connector which can have multiple addon-boards simultaneously instead of 
> the other way around.
> 

In that case, a connector cannot have the state "free" or "used" handled
globally by a core part.

IMHO, each connector drivers should handle this kind of state if relevant.
I mean, in case of "pmods" compatible driver having this state per PMOD
connector could make sense whereas in "beagle-connector" it doesn't.

Also, on my side, with my 2-step DT loading, the first loading should not
consider the connector as 'used'.

All of that is implied by the "contract" between the board and the addon.
It is connector specific and so should be handled by the specific connector
driver itself.

Best regards,
Hervé

