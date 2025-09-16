Return-Path: <linux-kernel+bounces-819021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C23B59A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B641C071D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E021311C3D;
	Tue, 16 Sep 2025 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="w1XMFRY8"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6637258ED4;
	Tue, 16 Sep 2025 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032749; cv=none; b=LGXQC74fpqBGO/dxQzLRdhSdkte53reM8I73mCUZoZTOo5JQyV/4lFyPwMq7kfD3MgBdGhfuCIH/LT4B80JDECOhB5QgGfmBWzlRYKVMcKvqtim5OEAmot/fM0DLiulHPK6iNRF8u0dsiVVDOM4VXpNka2pyizV3AWXNApuK7aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032749; c=relaxed/simple;
	bh=T+UDq0UnEbvO5J81jJsA1gzhHOErWzf6150SKF7RKs0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNQdeed/UZ4GEXLsHGThN3Fh4/824LmVtGT9Uqc5Y4wiU+/j+9SNtt94fBq8vkeAPKxmuPFYVq2Y01xk8u5UlgPBarFMSdxE6C042DNscIBGrtmOVox0HQxMAJ9t5z0a+dHn+Upn+yFBJq9WqhY0Ln56M8HDkC43fyYnmGUQljM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=w1XMFRY8; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 290211A0C11;
	Tue, 16 Sep 2025 14:25:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F1C366061E;
	Tue, 16 Sep 2025 14:25:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8C3F7102F1729;
	Tue, 16 Sep 2025 16:25:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758032743; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Zs/3zKQqObgzpzgsl1JuuZBNFTt/Tqkh8Yadyq0d6uc=;
	b=w1XMFRY8MYaJalKXlyLbWtP5vEgPREZ5caCpe+uG2ZGBn5hCtun7mqEwLWBWRP9gtmwenZ
	sH1N6o4wTkReUhF8/ylqbgiv+bjxSgHng0dJ3kIqQV+QGMn9zxfrcRJOOA+riHRdinU8tX
	XlIKJhjuGwKN+ypndnGakq2DYIUxVKqmwrPQ7XQhTNX8aF67w2CalO0h5za7DxZcSS8otQ
	iH583rJWjL2yr8J2eQ/DV84QHakAx4Thz8o1J5eUi0yEI7PVr7UInqH9qYlzE91UbW55ST
	Lw6Bop3JQSm/E9GLS8poMIbKssCHCFohC2OT4GXASaSiNgs9H2kEY+YmEURbmQ==
Date: Tue, 16 Sep 2025 16:25:34 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ayush Singh <ayush@beagleboard.org>, David Gibson
 <david@gibson.dropbear.id.au>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, Rob
 Herring <robh@kernel.org>, Jason Kridner <jkridner@gmail.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Davis <afd@ti.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion
 at ELCE
Message-ID: <20250916162534.43ad4dfe@bootlin.com>
In-Reply-To: <CAMuHMdUgnw4Q90a5yzOcK30iBUAQTgUDgAauzSifnngQf7bwqQ@mail.gmail.com>
References: <20250902105710.00512c6d@booty>
	<aLkiNdGIXsogC6Rr@zatzit>
	<337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org>
	<aL5dNtzwiinq_geg@zatzit>
	<20250908145155.4f130aec@bootlin.com>
	<aL-2fmYsbexEtpNp@zatzit>
	<20250909114126.219c57b8@bootlin.com>
	<aMD_qYx4ZEASD9A1@zatzit>
	<20250911104828.48ef2c0e@bootlin.com>
	<aMebXe-yJy34kST8@zatzit>
	<20250916084631.77127e29@bootlin.com>
	<CAMuHMdXXi97HN-G_Ozbs7vc141GmbMTPD6Ew6U_0ERj5wh6gvg@mail.gmail.com>
	<397483db-91de-4ff2-82e3-52ae785bc343@beagleboard.org>
	<CAMuHMdUgnw4Q90a5yzOcK30iBUAQTgUDgAauzSifnngQf7bwqQ@mail.gmail.com>
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

On Tue, 16 Sep 2025 15:34:52 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Ayush,
> 
> On Tue, 16 Sept 2025 at 14:22, Ayush Singh <ayush@beagleboard.org> wrote:
> > On 9/16/25 15:44, Geert Uytterhoeven wrote:  
> > > On Tue, 16 Sept 2025 at 08:46, Herve Codina <herve.codina@bootlin.com> wrote:  
> > >> On Mon, 15 Sep 2025 14:51:41 +1000
> > >> David Gibson <david@gibson.dropbear.id.au> wrote:  
> > >>> On Thu, Sep 11, 2025 at 10:48:28AM +0200, Herve Codina wrote:  
> > >>>>  From the addon board point of view, the only think we can
> > >>>> say is "me, as an addon board, I need a connector of type 'foo' and a
> > >>>> connector of type 'bar'".  
> > >>> Agreed.
> > >>>  
> > >>>> Also, at base board level, statically defined in the DT
> > >>>> connA is described (type 'foo'), connB and connC are
> > >>>> described (type 'bar').
> > >>>>
> > >>>> The choice to map connA to the type 'foo' connector expected by the addon
> > >>>> and the choice to map connB or connC to the type 'bar' connector expected by
> > >>>> the addon can only be done at runtime and probably with the help of a driver
> > >>>> that have the knowledge of the 3 connectors.  
> > >>> Agreed.
> > >>>  
> > >>>> I have the feeling that the choice of physical connectors to which the addon
> > >>>> board is connected to is a human choice when the board is connected.  
> > >>> Yes.  Although if the addons have an EEPROM, or some other sort of ID
> > >>> register, it may be possible for some connector drivers to probe this.  
> > >> Right, I think we agree that a driver is needed to help in the mapping at
> > >> least when multiple connectors are involved.  
> >  
> > > I agree you need a driver to read an ID EEPROM.
> > > But why would you need a driver if no ID EEPROM is involved?
> > > If the connector types on base board and add-on match, it should work.  
> 
> > How would a connector be disabled in such a setup? I guess maybe status
> > property can be used while applying overlay to check if the connector is
> > enabled. But maybe that goes outside the scope of fdtoverlay?  
> 
> Why would you want to disable a connector?
> 
> > Also, I would assume that most such connectors would want to provide
> > some kind of configfs based API to add/remove addon boards.  
> 
> Yes, we need some way to configure add-on board add/remove,
> and on which connector(s).
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

Having drivers for connectors is an expectation from Rob:
  https://lore.kernel.org/all/CAL_JsqKg0NpDi1Zf1T+f2rYw5UuVfK7+kjWj1_edFWH8EStjXw@mail.gmail.com/

Maybe at the end we could find some kind of generic driver if no specific
hotplug mecanism is involved and if we find a generic way (maybe configfs)
to provide the addon DT.

IMHO, before diving in a generic driver, basics need to be there and at least
one "specific" driver should be present to validate concepts discussed here.

Best regards,
Hervé

