Return-Path: <linux-kernel+bounces-831004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5930CB9B235
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1777216727F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26E4315D59;
	Wed, 24 Sep 2025 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="4CbW3c2R"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7057F314A9D;
	Wed, 24 Sep 2025 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736447; cv=none; b=eBPpoRkXDGixZ/Xe9vllrXo9Bi/bVTkQNtHl7nJzkD3ocKhOMmsyDCC+R9HS20N676zxIUcJ+9KpANT84DH+By6VWseUVyc3v9M6W3M38kyqJ80kMySUIMVJP+xYs+VO8RBrz1xQiEpaAqjvcv5I0dUi1Ec8MVISn+TMlIIXMZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736447; c=relaxed/simple;
	bh=cE3pX6OhxAvLjDSNkZmyu9X7gUfiUnR4fNR8gMbwGb4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nzdVo76tceA2tJfos51CCXILdAZMNyf4kP5mWkzPRRnknIRr6XhtQ31nfS0klVGyfATxh2a1KGlbhc/5Es0e5uaLBOwmn710G0gEOpQjLK3hZ8a/bnBY9AtFv5NIJBsIC13DFQhGVIEPGtFbLCV+XBIHK3H5W+pkjaEOuF5g9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=4CbW3c2R; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=BHCNl4z3cqN0vem/EkdMaQ8XO0N/IuVzXb92EPLx/+o=; b=4CbW3c2Rg0mbXbv7OVuyuLMvsu
	BQ3RK5tpDw9gRSyAWfb/pD1VtU8j7S0II1jMShkI+RFdBJOA/l7a6JKrFuuU29WPmXJDP4LoUq+Mm
	s34OVbxQEwa4IFt4JgZ+wgvPiYoCwzkWNWQyq/X0VcoKOe0Bb22/raQifVoebxg+ZihEmRvYBNhSg
	V7ixT0s2IkdVniTgNjnHSU7iMXjhIwe00Hs3PhpRTUe9KENqv0LgQUwHJphR3f3mOWwoa8MVA629d
	BDriRjiP7XPvne236Qbf2G8lqzZ4ia8SZ+AAOPlgQn1K9RfwgeZQQfn3baJxJ4u9no+GuhEGU6zk4
	yGskfnWw==;
Date: Wed, 24 Sep 2025 19:53:58 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Mark Brown <broonie@kernel.org>, jdelvare@suse.com, lgirdwood@gmail.com,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, Alistair Francis
 <alistair@alistair23.me>
Subject: Re: [PATCH RFC 1/2] hwmon: (sy7636a) fix races during probe of mfd
 subdevices
Message-ID: <20250924195358.16bbd90c@kemnade.info>
In-Reply-To: <b68d40d9-6ea9-49a9-8a2e-8b899f33340d@roeck-us.net>
References: <20250920114311.291450-1-andreas@kemnade.info>
	<20250920114311.291450-2-andreas@kemnade.info>
	<79aa98fe-b9b6-4210-a556-d33863f0129a@sirena.org.uk>
	<20250920233307.0c425863@kemnade.info>
	<473e217a-c6b3-4ebc-895d-85beab50267c@sirena.org.uk>
	<20250924090023.282ae450@kemnade.info>
	<b68d40d9-6ea9-49a9-8a2e-8b899f33340d@roeck-us.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 00:17:48 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 9/24/25 00:00, Andreas Kemnade wrote:
> > On Sat, 20 Sep 2025 23:18:59 +0100
> > Mark Brown <broonie@kernel.org> wrote:
> >   
> >> On Sat, Sep 20, 2025 at 11:33:07PM +0200, Andreas Kemnade wrote:
> >>  
> >>> Just for learning, yes, it is an abuse of the _optional for non-optional
> >>> things, so a dirty hack which should not go in, therefore RFC. But what
> >>> happens more than having the hwmon device endlessly deferred at worst?  
> >>
> >> There's also the fact that this API is so frequently abused for bad and
> >> broken reasons that I regularly audit users and try to fix them, I'd
> >> rather not see any new users that don't have a really strong reason to
> >> use it.
> >>  
> >>> The wanted regulator is the one defined in sy7636a-regulator.c. So it
> >>> is all an issue internal to the sy7636a.  
> >>  
> >>> Both subdevices are instantiated via drivers/simple-mfd-i2c.c.
> >>> I see several other solutions:
> >>> a) call device_is_bound() on every other children of dev->parent, if not
> >>> bound defer.
> >>> b) do not care about the regulator api at all, just check whether
> >>>     the corresponding bit is set before reading temperature, return
> >>>     -ENODATA if not, some mutex is probably needed.
> >>> c) do not care about the regulator api at all, just set the
> >>>     corresponding bit (together with some mutex locking and counting).  
> >>
> >> I assume this is using the regulator API because someone might use an
> >> external regulator in a system design for some reason (better quality,
> >> power efficiency or a shared reference between multiple devices I
> >> guess?), or because the supply might also be used by external devices?
> >>  
> >>> d) copy the of_node pointer from the parent, add a regulator phandle property
> >>>     to the node pointing to the regulator in the node itself.
> >>>     That sounds like your idea but is against the current dt binding for
> >>>     this device and afaik it is uncommon to have mfd-internal things wired
> >>>     up this way
> >>>
> >>> e) something clean, simple I miss  
> >>
> >> The idea is that the relationship between the devices should be
> >> registered before the devices, that's how the regulator knows to defer.
> >> We used to have an API for doing this for board files which might fit
> >> here, but it got removed since nobody wants board files any more.  If
> >> you're allocating the devices dynamically that's annoying to implement
> >> though...  
> > 
> > looking a bit around:
> > max5970-regulator.c has hwmon integrated and no extra device. That would
> > simplify things. Although it does not report temperature. Some
> > touchscreens have temperature via hwmon, some others have temperature
> > via iio, directly in one device without mfd. Maybe that is also
> > the better way here?
> >   
> 
> Touchscreens reporting temperature via iio is in general the wrong thing to do.
> Touchscreens report the temperature for monitoring reasons, after all.
> But then, sure, if you insist. I am getting tired of arguing.
> 
I apparently did not make clear what my question refers to. It was more about separate
hwmon device + mfd vs. integrating everything into the regulator driver.

But since you brought up the topic hwmon vs. iio for temperature. I do not have
a strong opinion here as long as I can somehow live with it. Nothing I want to
fight for. One sensor I use for measuring room temperature is hwmon, another
one is iio. So it is all not that consistent.

But what is the hwmon equivalent for
devm_fwnode_iio_channel_get_by_name() + iio_read_channel_processed()?

I wonder whether I really need a thermal zone. It adds stuff not needed here,
trip points and polling. 

Documentation/hwmon/sy7636a-hwmon.rst seems to be wrong. It is not
SoC-on-die temperature, but temperature from an external NTC. And
that is typically used to tune the EPD refresh to the temperature.
I have a sy7636a connected to a broken display causing excessive current
consumption and heat generation. I looked at it with an IR camera.

Regards,
Andreas

