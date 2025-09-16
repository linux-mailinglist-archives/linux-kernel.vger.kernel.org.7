Return-Path: <linux-kernel+bounces-818236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A11B4B58E98
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 458084E141B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3595729B777;
	Tue, 16 Sep 2025 06:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WCTF2reE"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD91F2248B9;
	Tue, 16 Sep 2025 06:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758005210; cv=none; b=S/EZQgbVKlXMfpFLmR+5xEim9+ejD9XnvgDDT+/AfY3tgnowCbVPQm1YlD7eRTKoDGsz+di7WMjrT9wS2vEkW5pIbSUctvhUv5JwvS8VnBLNtIxHcsMYuJzmxFzPUR7fZox/nfTgT1Oyq7Rp0qXwXReT2pDizIB38qIj34kTt+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758005210; c=relaxed/simple;
	bh=ZqOIHfE7RCbzoCTcYAz2uDkLRSHhSPu96+CLS0vCxw4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ohx8Qio18GPI3blHjAt8IzjCF3V+ddvICfxNoZm7oUtRw01/B5dgmi+OD7NQbm2w2W7+ugVbLQ1+cFKzHciDHFChhVyZ1moKUKBrqomJos/JeleVGvO0qAJ4E2pYADb9op9WCBBnTR3bp2UuYera/1tDhx3ldqqSDdC0A9t3WGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WCTF2reE; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D39C74E40BFF;
	Tue, 16 Sep 2025 06:46:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A78A1606A8;
	Tue, 16 Sep 2025 06:46:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BF8E102F1690;
	Tue, 16 Sep 2025 08:46:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758005203; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ou1XNHgM0D/o6xvS5WM3/FqJJ9dvfYQmx33Egow2/Ec=;
	b=WCTF2reEUewbr1R9saW+C+RagNRbeaEEhOe76BBbF2NTwGyXnmsVb1Wo74ai5vS42o458G
	Krj2YS/AHLOiQPKUS0+O9bGvhbFRgXjlwOGUKHiqfnq0ALssXyhalFjX89ZyuEaSkkzZBy
	/rNDMVCUYkWmwh0KBGGPmmQGAaoIZSzNFZ+0jKgd8LzvcnNGym4zagQYyBLA9gyBQwWqI4
	tKV6W2cRkD/j9d/8HTrFwW7L/9dtZPR64OoGA8WxZaM+Wcr9FTnXI6kBsZJzMbPgYQXKug
	nitT/DALklDs5iL4etJqLDVRJvBXThFwi9FVEoQn9QOKCL4pvX5fQ6Mq5nkMxA==
Date: Tue, 16 Sep 2025 08:46:31 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Ayush Singh <ayush@beagleboard.org>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, Jason Kridner
 <jkridner@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Davis <afd@ti.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion
 at ELCE
Message-ID: <20250916084631.77127e29@bootlin.com>
In-Reply-To: <aMebXe-yJy34kST8@zatzit>
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

Hi David,

+CC Wolfram

On Mon, 15 Sep 2025 14:51:41 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Sep 11, 2025 at 10:48:28AM +0200, Herve Codina wrote:
> > Hi David,
> > 
> > On Wed, 10 Sep 2025 14:33:45 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >   
> > > On Tue, Sep 09, 2025 at 11:41:26AM +0200, Herve Codina wrote:  
> > > > Hi David,
> > > > 
> > > > On Tue, 9 Sep 2025 15:09:18 +1000
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > 
> > > > ...
> > > >     
> > > > > > I think that a connector is something with a bunch of resources provided
> > > > > > by the board where the connector is soldered. Those resources are wired
> > > > > > to the connector and defined by the connector pinout.
> > > > > > 
> > > > > >      3v3   ------- Pin 0
> > > > > >   i2c_scl  ------- Pin 1
> > > > > >   i2c_sda  ------- Pin 2
> > > > > >     gpio A ------- Pin 3
> > > > > >     gpio B ------- Pin 4
> > > > > >      gnd   ------- Pin 5
> > > > > > 
> > > > > > IMHO, this need to be described and defined in the base board and an addon can
> > > > > > only reference resources wired and described by the connector node.      
> > > > > 
> > > > > Yes, that's exactly what I'm proposing too.
> > > > >     
> > > > > > Now, questions are:
> > > > > >   - 1) How to describe a connector?
> > > > > >   - 2) How to reference resources provided at connector level from an add-on?      
> > > > > 
> > > > > Right.
> > > > >     
> > > > > > Our current approach was:
> > > > > > ---- base board DT ----
> > > > > >   connector0 {
> > > > > > 	gpio-map = <0 &gpio0 12>, /* gpio A wired to gpio 12 of gpio0 controller */
> > > > > >                    <1 &gpio2 10;  /* gpio B wired to gpio 10 of gpio2 controller */
> > > > > >         i2c-one {
> > > > > > 		compatible = "i2c-bus-extension";
> > > > > > 		i2c-parent = <i2c5>; /* i2c-one wired to i2c5 controller */
> > > > > > 	};
> > > > > > 
> > > > > > 	i2c-two {
> > > > > > 		compatible = "i2c-bus-extension";
> > > > > > 		i2c-parent = <i2c6>; /* i2c-two wired to i2c6 controller */
> > > > > > 	};
> > > > > > 
> > > > > > 	/*
> > > > > >          * From the addon we need to reference:
> > > > > >          *    - The connector itself,
> > > > > >          *    - Maybe some pinctrl related to signals wired to the connector,
> > > > > >          *    - In some cases the i2c bus (HDMI, ddc-i2c-bus = <&i2c-two>;)
> > > > > >          * 
> > > > > >          * This was solved introducing the controversial export-symbols node.
> > > > > >          */      
> > > > > 
> > > > > I think the type of connector should also be named on both sides (with
> > > > > 'compatible' or something like it).    
> > > > 
> > > > It makes sense.
> > > >     
> > > > >     
> > > > > >   };
> > > > > > 
> > > > > > ---- addon board DT ----
> > > > > >    {
> > > > > > 	some-node {
> > > > > > 		compatible = "foo,bar";
> > > > > > 		reset-gpios = <&connector 0>; /* gpio A used as a reset gpio */
> > > > > > 		ddc-i2c-bus = <&i2c-two>;
> > > > > >         }
> > > > > > 
> > > > > >         i2c-one {
> > > > > > 		eeprom@10 {
> > > > > > 			compatible = "baz,eeprom"
> > > > > > 			reg = 10; 
> > > > > > 		};
> > > > > > 	};
> > > > > >    };
> > > > > > 
> > > > > > The addon board DT can only be applied at a connector node.      
> > > > > 
> > > > > Right.  This is not how overlays work now.  By the nature of how
> > > > > they're built they apply global updates to the base tree.  That means
> > > > > we need to spec a new way of describing addons that *is* restricted to
> > > > > a particular connector slot (or slots, as Geert points out).  Since we
> > > > > have that opportunity, we should _not_ try to make it a minimal
> > > > > extension to existing overlay format, but define a new and better
> > > > > encoding, designed to meet the problems you're looking to address.    
> > > > 
> > > > On the kernel side, overlays can be applied at a specific node.
> > > > The node is chosen when the overlay is apply.
> > > >   https://elixir.bootlin.com/linux/v6.16/source/drivers/of/overlay.c#L970    
> > > 
> > > Huh, I wasn't aware that had already been merged.
> > >   
> > > > This allows to apply an overlay to a specific node without any modification
> > > > of the overlay dtb (dtbo).
> > > > 
> > > > Ajush proposed an update to support this feature in fdtoverlay
> > > >   https://lore.kernel.org/all/20250313-fdtoverlay-target-v1-0-dd5924e12bd3@beagleboard.org/    
> > > 
> > > Yes, and I've been disinclined to merge it because I think extending
> > > overlays in this way, without a more wide-ranging redesign, is not a
> > > great idea.
> > >   
> > > > ...    
> > > > >     
> > > > > > > > > 3) bus-reg / bus-ranges
> > > > > > > > > 
> > > > > > > > > One thing that makes connector plugins a bit awkward is that they
> > > > > > > > > often need to add things to multiple buses on the host system (MMIO &
> > > > > > > > > i2c for a simple case).  This means that once resolved the plugin
> > > > > > > > > isn't neatly a single subtree.  That's one factor making removal      
> > > > > > 
> > > > > > It can be a single subtree if decoupling is present at connector node available
> > > > > > in the base device tree.      
> > > > > 
> > > > > Right - allowing that decoupling is exactly what I'm proposing bus-reg
> > > > > for.  Note that the case of an addon that plugs into multiple
> > > > > connectors that Geert pointed out complicates this again.    
> > > > 
> > > > Geert's use case needs to be clarified.
> > > > 
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
> 
> I'm not sure what you mean by a decision at the base board level.  I
> certainly don't think this should be in the base DT.  I'd see this as
> a runtime parameter needed when you apply/insert/activate the addon.
> That's not really any different from addons with a single connector.
> To allow for base boards with multiple instances of that connector
> you'd need to specify at insert time which instance you're attaching
> to.
> 
> That information could be supplied by the user, or in the case of
> connectors that can be probed in some way (e.g. an EEPROM) the
> connector driver could supply the information.
> 
> 
> Which does make me think, considering this case says to me that
> conceptualizing the choice of where to plug an addon as "subnode in
> the base tree it goes under" is not a good idea.  That's not really
> going to work for a multiple connector addon.
> 
> So, we can specify where an addon goes by which "connector" it
> attaches to.  That connector would have an explicit entry in the base
> tree, but it could reference multiple places to add nodes within that
> base tree.  Which means thinking about it that way, we might not need
> 'bus-reg' / 'bus-ranges' after all, and in some cases maybe not bus
> extensions either.
> 
> Adding nodes in multiple places makes removal a bunch more complicated
> (although it's still much better than overlays being able to modify
> *anywhere*).
> 
> > Or any other combination that would match.
> > 
> > From the addon board point of view, the only think we can
> > say is "me, as an addon board, I need a connector of type 'foo' and a
> > connector of type 'bar'".  
> 
> Agreed.
> 
> > Also, at base board level, statically defined in the DT
> > connA is described (type 'foo'), connB and connC are
> > described (type 'bar').
> > 
> > The choice to map connA to the type 'foo' connector expected by the addon
> > and the choice to map connB or connC to the type 'bar' connector expected by
> > the addon can only be done at runtime and probably with the help of a driver
> > that have the knowledge of the 3 connectors.  
> 
> Agreed.
> 
> > I have the feeling that the choice of physical connectors to which the addon
> > board is connected to is a human choice when the board is connected.  
> 
> Yes.  Although if the addons have an EEPROM, or some other sort of ID
> register, it may be possible for some connector drivers to probe this.

Right, I think we agree that a driver is needed to help in the mapping at
least when multiple connectors are involved.

> 
> > > > Also adding and Addon on only one part (connA for instance) should not be an issue
> > > > if the connector describe both parts.
> > > > 
> > > > but well, here again I can miss something.
> > > > Geert, can you provide details?
> > > > 
> > > > ...
> > > >     
> > > > > > > > 
> > > > > > > > There is an i2c-bus-extension [1] and spi-bus-extension proposal to do the
> > > > > > > > same. But, if we can figure out a common way for all buses, that would be
> > > > > > > > great.      
> > > > > > 
> > > > > > Exactly, this is the purpose of bus extensions.      
> > > > > 
> > > > > Right, but redefining it for each bus type seems silly.    
> > > > 
> > > > Nexus node properties are re-defined for each kind of resources (interrupt,
> > > > gpio, pwm, ...).    
> > > 
> > > Yes, for historical reasons.  In IEE1275 days, interrupts was
> > > basically the only thing that worked this way.  gpio and pwm were
> > > added much later using interrupts as a model.  If we were designing
> > > from scratch having a common way of defining a nexus would make sense
> > > too.
> > >   
> > > > Why not for bus extensions.    
> > > 
> > > So that we don't need to keep defining new bindings for it.
> > >   
> > > > Also I am pretty sure that some bus extension will need to define some
> > > > properties specific to the bus related to the extension.    
> > > 
> > > Maybe, but then only those buses that specifically need it need the
> > > extra binding.
> > >   
> > > > > > Also, I don't thing that the 'ranges' property should be used for that purpose.
> > > > > > The 'ranges' property is used to translate addresses from child addresses space
> > > > > > to parent addresses space.      
> > > > > 
> > > > > The rationale for bus-ranges is that the add-on board could re-expose
> > > > > one of the buses on the connector (say MMIO for simplicity) to several
> > > > > chips physically included on the addon board.  We don't want those
> > > > > sub-chips to need different device nodes depending on whether they're
> > > > > on an addon board or wired directly onto a main board.  bus-ranges
> > > > > would allow the root of the connector to create a subtree in which
> > > > > regular MMIO (or whatever) devices can be described, and then routed
> > > > > via the connector onto the bus on the main board.    
> > > > 
> > > > bus extensions supports this feature without bus-regs nor bus-ranges.    
> > > 
> > > bus-reg & bus-ranges allow it for any bus without having to create a
> > > new binding.
> > >   
> > > > A bus extension ended by a sub node in the connector node.
> > > > Applying the addon DT at the connector node allow the addon to had
> > > > subnode to the extension node.    
> > > 
> > > I don't really understand what point you're making here.  
> > 
> > Hardware:
> >  +------------------+    +----------------------+
> >  |   base board     |    |      addon board     |
> >  |  +------+        |    |                      |
> >  |  | i2c0 |    +-----------+    +------------+ |
> >  |  |      +----+ connector +----+ eeprom @10 | |
> >  |  |      |    +-----------+    +------------+ |
> >  |  +------+        |    |                      |
> >  +------------------+    +----------------------+
> > 
> > base board DT:
> >     connector {
> > 	i2c-ctrl {
> > 		compatible = "i2c-bus-extension";
> > 		i2c-parent = <&i2c0>;
> >         };
> >     };
> > 
> > addon board DT:
> >     i2c-ctrl {
> > 	eeprom@10 {
> >             compatible = "foo,eeprom";
> >             reg = <10>;
> >         };
> >     };
> > 
> > Once addon board DT is applied at the base board connector node, the full
> > DT is:
> >     connector {
> > 	i2c-ctrl {
> > 	    compatible = "i2c-bus-extension";
> > 	    i2c-parent = <&i2c0>;
> > 
> >             eeprom@10 {
> >                compatible = "foo,eeprom";
> >                reg = <10>;
> >             };
> >         };
> >     };
> > 
> > I probably didn't understand the bus-reg and bus-range usage.
> > In order to clarify my understanding, using the same hardware example above,
> > can you provide an example of description using bus-reg &
> > bus-ranges?  
> 
> Thoughts above suggest a different direction, but here's what I was
> thinking before:
> 
> base board:
> 
> 	connector {
> 		/export/ "i2c" &i2c0;
> 	};
> 
> addon:
> 	eeprom@10 {
> 		compatible = "foo,eeprom";
> 		bus-reg = <&i2c 0x10>;
> 	}
> 
> Or, if the addon had multiple i2c devices, maybe something like:
> 
> 	board-i2c {
> 		compatible = "i2c-simple-bridge";
> 		bus-ranges = <&i2c 0 0x3ff>; /* Whole addr space */
> 		eeprom@10 {
> 			compatible = "foo,eeprom";
> 			reg = <0x10>;
> 		}
> 		widget@20 {
> 			compatible = "vendor,widget";
> 			reg = <0x20>;
> 		}
> 	}
> 
> Writing that, I realise I2C introduces some complications for this.
> Because it has #size-cells = <0>, ranges doesn't really work (without
> listing every single address to be translated).  Likewise, because we
> always need the parent bus phandle, we can't use the trick of an empty
> 'ranges' to mean an identity mapping.
> 
> We could invent encodings to address those, but given the addon with
> multiple connectors case provides another incentive for a single
> connector to allow adding nodes in multiple (but strictly enumerated)
> places in the base device tree provides a better approach.
> 

and the "place in base device tree" is the goal of the extension bus.

The strict enumeration of nodes enumerated is done by two means:
 - extension busses at connector level
   Those extensions are described as connector sub-nodes.
   The addon DT can only add nodes in those sub-nodes to describe devices
   connected to the relared extension bus.
 - export symbols
   An addon DT can only use symbols exported to reference symbols outside
   the addon DT itself.

Can I assume that bus extensions we proposed (i2c-bus-extension and
spi-bus-extension) could be a correct solution ?

Best regards,
Hervé

