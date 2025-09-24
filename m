Return-Path: <linux-kernel+bounces-830015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EB0B98743
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3373E19C0811
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE43266B41;
	Wed, 24 Sep 2025 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Y7b6w/X6"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF97D158874;
	Wed, 24 Sep 2025 07:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758697241; cv=none; b=Ft0k7poy637TFQhMv6/WNhYsi57lUosNO59KGM9hkVUD8u6kcMAPbRKyEkTaa6ABr1OCbGSh+alPHgpiN4vUA1jxoQ2FMS1wIZ/wjIdaDUkdvQS7CNxDqpPTe7i0Sjzg0mjdj5MCSAf+VavXV/8GsmUbb5zR3xU4iRrt0IKsVcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758697241; c=relaxed/simple;
	bh=qaRdaD9e0snQnNI9h8G4rrtJzVPX2MTBs+qyWdj2C8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDu46H090tcssuAgOToA3fBPDMV9gHjawbHA8RJ7Rz2b2pOHdK5rX6wnfKQwFZOs090YsJ5ogL+pdVhQL6OtwfWCUrUIsM1sgGzp1GS1roV/SDcAaqg1dL8x00jOTsxQzg4UBTyw3CDPi6DhnHuJl2M1CtyJ0cGRy86ugow8EVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=Y7b6w/X6; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=65Ekvlp4lXlO45wPdlxDADgOS4gpl6uVCi+UvvnIXPM=; b=Y7b6w/X6KXErcHzgZZ6rkY95jy
	s3G9yuimqhtwdtLG8szjXELPBBsSztxHd2DXx6D0iU1NNlhiB6vRmn50rGT7VkuiiqmoZsh3N5UZB
	9n69tbAClajUkr/VJoceHs8OjmtJKiulTSbCdBbC0J2w9AA0hr2f0ATWv6RYzraM5HQdsA0HQOyVB
	E24NXHB4ZW/carpz0RGYQZGry+hC4AzuA7I/QMIgnc0qUPRt0fyzknwljgrWGfrZ+Jv5OitKZpecl
	QAazzZS+SltOTDG6zAwfwwranv4Pz8gH/JxyE54AI3I/yBgfZ3bxFTZXQDGzdUHYqVCrDeTOrU5E6
	Xb7Zy1xw==;
Date: Wed, 24 Sep 2025 09:00:23 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Mark Brown <broonie@kernel.org>
Cc: jdelvare@suse.com, linux@roeck-us.net, lgirdwood@gmail.com,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, Alistair Francis
 <alistair@alistair23.me>
Subject: Re: [PATCH RFC 1/2] hwmon: (sy7636a) fix races during probe of mfd
 subdevices
Message-ID: <20250924090023.282ae450@kemnade.info>
In-Reply-To: <473e217a-c6b3-4ebc-895d-85beab50267c@sirena.org.uk>
References: <20250920114311.291450-1-andreas@kemnade.info>
	<20250920114311.291450-2-andreas@kemnade.info>
	<79aa98fe-b9b6-4210-a556-d33863f0129a@sirena.org.uk>
	<20250920233307.0c425863@kemnade.info>
	<473e217a-c6b3-4ebc-895d-85beab50267c@sirena.org.uk>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Sep 2025 23:18:59 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Sat, Sep 20, 2025 at 11:33:07PM +0200, Andreas Kemnade wrote:
> 
> > Just for learning, yes, it is an abuse of the _optional for non-optional
> > things, so a dirty hack which should not go in, therefore RFC. But what
> > happens more than having the hwmon device endlessly deferred at worst?  
> 
> There's also the fact that this API is so frequently abused for bad and
> broken reasons that I regularly audit users and try to fix them, I'd
> rather not see any new users that don't have a really strong reason to
> use it.
> 
> > The wanted regulator is the one defined in sy7636a-regulator.c. So it
> > is all an issue internal to the sy7636a.  
> 
> > Both subdevices are instantiated via drivers/simple-mfd-i2c.c.
> > I see several other solutions:
> > a) call device_is_bound() on every other children of dev->parent, if not
> > bound defer.
> > b) do not care about the regulator api at all, just check whether
> >    the corresponding bit is set before reading temperature, return
> >    -ENODATA if not, some mutex is probably needed.
> > c) do not care about the regulator api at all, just set the
> >    corresponding bit (together with some mutex locking and counting).  
> 
> I assume this is using the regulator API because someone might use an
> external regulator in a system design for some reason (better quality,
> power efficiency or a shared reference between multiple devices I
> guess?), or because the supply might also be used by external devices?
> 
> > d) copy the of_node pointer from the parent, add a regulator phandle property
> >    to the node pointing to the regulator in the node itself.
> >    That sounds like your idea but is against the current dt binding for
> >    this device and afaik it is uncommon to have mfd-internal things wired
> >    up this way
> > 
> > e) something clean, simple I miss  
> 
> The idea is that the relationship between the devices should be
> registered before the devices, that's how the regulator knows to defer.
> We used to have an API for doing this for board files which might fit
> here, but it got removed since nobody wants board files any more.  If
> you're allocating the devices dynamically that's annoying to implement
> though...

looking a bit around:
max5970-regulator.c has hwmon integrated and no extra device. That would
simplify things. Although it does not report temperature. Some
touchscreens have temperature via hwmon, some others have temperature
via iio, directly in one device without mfd. Maybe that is also
the better way here?

Regards,
Andreas

