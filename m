Return-Path: <linux-kernel+bounces-847911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9D2BCC026
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A566E35442D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3DE27A456;
	Fri, 10 Oct 2025 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DILNMdye"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7229275B09;
	Fri, 10 Oct 2025 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760083188; cv=none; b=Dv1IofNXr0q1N0pqAYVFD1MmfzcXiQMzHN3mwl1jRtKSB2asz15le0mJYIl1zZ43B+Ss7zAmbNbsGi2+1iPbwKCPn/GzIm7IRh3qmQt6l04sdU144Ij1zhsIVgnjjBE2lIi0ZtL70A3ifJ838kQ0oZU4Yp9oclTRk3VtiVBX5Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760083188; c=relaxed/simple;
	bh=hWWWHaGfvsyPHs2pZRrd90S4dgi24OVDDU76rEfXqKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufBLl3LtqtpmouRJeXK1Cj7FkguScNyjls1ynjOpoH1vq1eTkk/FMIBA2uV/XBoOemyONBKYoD+0T/J2eWUtyqYHI3vNkUz9AT6C8PWd3/jjVQJ8Z388lkJoGDs0eAg8+vFDc/yPFos7DXhLUYfCnCa8XDd3db3ml8dvV9pFmzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DILNMdye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A707EC4CEF1;
	Fri, 10 Oct 2025 07:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760083188;
	bh=hWWWHaGfvsyPHs2pZRrd90S4dgi24OVDDU76rEfXqKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DILNMdyeJ6YRpGmuH9Cmh7+S0EHICxNDYjJhfXpPifrbdllIeStVzmPKJsoexfPF2
	 tbreQxyyBBaYQB5bdxuxS80Wezh+dgknwuQQ+K1KF9/Jv4/TQ7auHCkLuYuWYpghNI
	 kFRwCYSKLFy/JrYiFFZj2Qh8uvuYDYH9NgzbQ0zN2wa+Q5QAbIktSrjozfXLJjSLOb
	 sKw5PyldBPjmBRlVDU3Y1Qw0yCAxZp4k7kjumGG9S+IBIN6OaSedoi4uMJqQhUvNn4
	 MGl4AW2oRCQrfSmFbHbTwqxU8SqXRSAYoFF5a2mBw4BvOYsnme1Oau6Z19bp3P29Vl
	 23FayPcdPFXMA==
Date: Fri, 10 Oct 2025 08:59:43 +0100
From: Lee Jones <lee@kernel.org>
To: Jonathan Brophy <professor_jonny@hotmail.com>
Cc: Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Radoslav Tsvetkov <rtsvetkov@gradotech.eu>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] leds: Add Virtual Color LED Group driver
Message-ID: <20251010075943.GB2988639@google.com>
References: <20251009084339.1586319-1-professorjonny98@gmail.com>
 <20251009151847.GC2890766@google.com>
 <DS0PR84MB3746BE2BCCCC3BB0185D3F6B9FEFA@DS0PR84MB3746.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS0PR84MB3746BE2BCCCC3BB0185D3F6B9FEFA@DS0PR84MB3746.NAMPRD84.PROD.OUTLOOK.COM>

On Fri, 10 Oct 2025, Jonathan Brophy wrote:

> 
> 
> -----Original Message-----
> From: Lee Jones <lee@kernel.org> 
> Sent: Friday, 10 October 2025 4:19 AM
> To: Jonathan Brophy <professorjonny98@gmail.com>
> Cc: Pavel Machek <pavel@kernel.org>; Jonathan Brophy <professor_jonny@hotmail.com>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Radoslav Tsvetkov <rtsvetkov@gradotech.eu>; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-leds@vger.kernel.org
> Subject: Re: [PATCH 1/4] leds: Add Virtual Color LED Group driver
> 
> On Thu, 09 Oct 2025, Jonathan Brophy wrote:
> 
> > From: Jonathan Brophy <professor_jonny@hotmail.com>
> > 
> > This commit introduces a new driver that implements virtual LED groups 
> > by aggregating multiple monochromatic LEDs. The driver provides 
> > priority-based control to manage concurrent LED activation requests, 
> > ensuring that only the highest-priority LED group's state is active at 
> > any given time.
> > 
> > This driver is useful for systems that require coordinated control 
> > over multiple LEDs, such as RGB indicators or status LEDs that reflect 
> > complex system states.
> > 
> > Co-developed-by: Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
> > Signed-off-by: Jonathan Brophy <professor_jonny@hotmail.com>
> > ---
> >  drivers/leds/rgb/Kconfig                   |  17 +
> >  drivers/leds/rgb/Makefile                  |   1 +
> >  drivers/leds/rgb/leds-group-virtualcolor.c | 440 
> > +++++++++++++++++++++
> >  3 files changed, 458 insertions(+)
> >  create mode 100644 drivers/leds/rgb/leds-group-virtualcolor.c
> > 
> > diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig index 
> > 222d943d826a..70a80fd46b9c 100644
> > --- a/drivers/leds/rgb/Kconfig
> > +++ b/drivers/leds/rgb/Kconfig
> > @@ -75,4 +75,21 @@ config LEDS_MT6370_RGB
> >  	  This driver can also be built as a module. If so, the module
> >  	  will be called "leds-mt6370-rgb".
> >  
> > +config LEDS_GROUP_VIRTUALCOLOR
> > +	tristate "Virtual LED Group Driver with Priority Control"
> > +	depends on OF || COMPILE_TEST
> > +	help
> > +	  This option enables support for virtual LED groups that aggregate
> > +	  multiple monochromatic LEDs with priority-based control. It allows
> > +	  managing concurrent LED activation requests by ensuring only the
> > +	  highest-priority LED state is active at any given time.
> 
> Grep for:
> 
>   "This driver groups several monochromatic LED devices in a single multicolor LED device."
> 
> Does this scratch your itch?  Is this something worth building on?
> 
> > +
> > +	  Multiple LEDs can be grouped together and controlled as a single
> > +	  virtual LED with priority levels and blinking support. This is
> > +	  useful for systems that need to manage multiple LED indicators
> > +	  with different priority levels.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called leds-group-virtualcolor.
> 
> --
> Lee Jones [李琼斯]

It's better to set your mailer up to quote properly, then place your
replies directly under the text you're replying to.

> I'm not entirely sure what you mean about grep for but I can update the message more friendly, if that is what you mean?

And line-wrap too please.

> As for is this worth something building on....  there Are possibly more features that can be added, but it serves the purpose I intended to use it for currently, I did think it may be a security issue if one could create virtual led instances form userspace but it is a potential feature.
> 
> Other features such a cycling, diming sequences, on delay and off delay or more complex logic could be configured in the DTS I guess?.
> 
> Originally the driver was intended for OpenWrt so standard triggers and aliases can be attached to virtual LEDs,  the intention was to be able to closely match functions of OEM products status LEDs that often indicate multiple states.
> The intention was to eliminate userspace scripting controlling the logic, so these statuses could be realised by just simple bindings.
> 
> There is a similar basic driver function in the Qualcomm SDK based on OpenWrt but it does not feature properties such as timing and priority.
> 
> One thing is that the led dt bindings property's function and colour are quite restrictive in naming as you can't stack the functions when you are trying to describe properties of a complex led, or if you have multiple virtual LEDs of the same color, it can get confusing as it prioritises this as opposed to the node name or label.
> The label property makes it easy to describe it but this format is deprecated.
> 
> EG:
> 
> function = LED_FUNCTION_STATUS;
> color = < LED_COLOR_ID_YELLOW>;
> 
> label =<YELLOW_SYSTEM_FLASHING_VIRTUAL_STAUS_LED> ;
> 
> could we stack the property function in an array to make it more descriptive:
> 
> function = < LED_FUNCTION_STATUS >, < LED_FUNCTION_FLASH>, < LED_FUNCTION_VIRTUAL_STATUS> ;
> 
> One thing I did also notice the Colour Magenta is not an available option in the DT bindings which is technically correct for an RGB LED  but violet and purple is there as a close option but I don't know where he best place is to comment on this.
> 
> Jonathan Brophy

Whoa, that was too much text for a reply to a message you didn't understand!

By "Grep for", I really did mean to "physically grep for this line in the kernel".

Doing so would have brought you to here:

https://github.com/torvalds/linux/blob/master/drivers/leds/rgb/leds-group-multicolor.c#L5

This looks similar to what you're trying to achieve.  At least the
documentation line appears to describe something related.

Please read leds-group-multicolor.c and see if it helps you at all.

-- 
Lee Jones [李琼斯]

