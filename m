Return-Path: <linux-kernel+bounces-763352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CB9B213C8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40FF3B8E7E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C521D2F42;
	Mon, 11 Aug 2025 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgxRYv30"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34B42D4817;
	Mon, 11 Aug 2025 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754935151; cv=none; b=BywU/URNyEYIVEQ2K5KNeSF0NMl9HRDsZ7+FI1YQU1eTW5qHZe21/5cTcP4xFEbMEJ2GFtX1i7Ou7nVmR4w4BaFxjMMof3hWGoN6afNgepka9uJwAvNeMZpA8S/v2HD0eJ5TMeT+shmGV9PBO073htMlm4kWC9M/UNO7FrZ6c50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754935151; c=relaxed/simple;
	bh=N3BZLi0x5iIKhppufuwrZBzWb/8OEWoKLxpK+yiKaXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ7DJgPGwPRNgQiFYM0mihpdtkHzd7H7rc72QfjyL6k+eH3MXIYfrB6We7xVMnHhqKt5joaYutG9SakUjBpR1cmWWMELIT6NSP3WjznhRNNcvcP2uAJFHT8SjutlfS8E3+ay1S37fbnyGYRauQWSSNuw7OdpuZ0fAu5ewSpFlKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgxRYv30; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b42254ea4d5so3038516a12.1;
        Mon, 11 Aug 2025 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754935149; x=1755539949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NPGqZRk2tdKjLTVo7iab98KYyj6+5ibV8YSbBT2zSlg=;
        b=GgxRYv30+jpOWBEWra98j9mqtyY2BlUEAL1ndLzSyZLU3j///7mb/h8PPQJK2uvCfa
         zMX9kSFmI/sRsqdW0K5itYfuoNqCPZhIHLHKfxfxKXR8+iVi2CmIogN2BC70h8oibVBS
         ONYGEegicQp5G5nCu16P+0SQHHJ1UdZMyymOlKNsxGAmebNLWBhuSZHqga68UtDIk3in
         eyIMko3pSlng55ok620OoDziIZitjgb4Rok2OkwTjTFAjrPGTlISIcb4kKFKMPQpkVIK
         Moy3yl1DvgS1V6L49kQ9FtS2idyG9yEjkjhBqzko9Y/AgIoG+Gkuz/YrVVeUe5KgRFv1
         Kgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754935149; x=1755539949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPGqZRk2tdKjLTVo7iab98KYyj6+5ibV8YSbBT2zSlg=;
        b=R+MR+Y65P5v6vDm8cZ/9Bl40V/5s3lkuXAOjSl5t2pxTzepl8NYlIMgvvn51lKvtpJ
         Y4H3mT+3FAY/lm24JS00JReO3vdLlTvTYNYz9I6OAjzD8xFc37VVj7S9labuew+powqs
         CM2X8knJT42turVJsN+F6DP5Yvqu0vgYCJjRjGf8ZXWq6qqelAYMeCTwyEFv3DjR7/9G
         TvCJCG0rBW17NDTNFdUgqlUUFVKo+4DZLvdgwDPYhy3D/6m2v/V/6JJ2izmtvR/hbqB6
         FHH1N+sYe7BaTQR8lE7zOAiRuQa608RHSelQro1WFp52zZhbABWVl4csZ3d+1xV2V0n6
         cirw==
X-Forwarded-Encrypted: i=1; AJvYcCW3aNU3BXk0T0WgHs4wNR/CuthAzqN2giwMfS2iHgs3fkepwsNR/bGirfr0meB/TaJ8tTz717iEo7HyBCTej5EPrUkRzg==@vger.kernel.org, AJvYcCW5iSIGm82LxKpiEjrRKP8CglTCE6tJyppYG6pkUvfNYcleevO03qMzmNk5R9HMgNxHj3WGPM7NSd6wouI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+8wK1VwGSLvHLSGtSQoPx48sdbeF4dx5xYvYl9af69KrwwlYo
	HcTs5UvKR0+qqRuiSBWX/OBCMCLphdzrqhFx9xvet6Mz2QrnwHtHaqJCw/2pOQ==
X-Gm-Gg: ASbGncsm/abrPIUh97zlqBwx3ZtKBOUpMMIweiQzIDd3g3qfkcFprVYwY5gpZ4AIdim
	KHpRkBwkrG0V6egiTLJMBvc/n+4ic/ZFLV7YWuOvThNYy9LGQqucCyDPEgSZmgMN2ZhjxZub3Wp
	CzO8+XUjbLxFG4ASiHYC98xTzkunvb0G55qETQQM1z98MrZqBpVXDUZwU3HWnwrxUeLX/pbGiMq
	9yrDsbOAkKaN7L4hv0rWEUvs5vICWl0k/rM3/nY08QNw4xOB9fuBj54VJId874fvzEE5gZlBfPt
	7MKy/Yg2DQOeBE6POupgfAJ7uzX1LE/zijM0UO5IdY9eiq31oSlifvcX87k13bmJleo6CyD9FCi
	ZEkMT5qtQduTeU0m6VkfWJSk=
X-Google-Smtp-Source: AGHT+IH+gZKqPy9wNLG0JDlHLKmawauaiFQ3slK2a16Y8JIcs+Fa5Qm+A0Ok6vZMta3bq5dx9EFGdQ==
X-Received: by 2002:a17:90b:4e83:b0:31e:cb1a:3dc5 with SMTP id 98e67ed59e1d1-321839ee09bmr21032963a91.11.1754935148921;
        Mon, 11 Aug 2025 10:59:08 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:69d7:30de:b05e:915b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3216125b7b5sm14949375a91.20.2025.08.11.10.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 10:59:08 -0700 (PDT)
Date: Mon, 11 Aug 2025 10:59:05 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Santosh Kumar Yadav <santoshkumar.yadav@barco.com>, Peter Korsgaard <peter.korsgaard@barco.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: barco-p50-gpio: use software nodes for
 gpio-leds/keys
Message-ID: <7bylxufp3r5qzf5axqrtytamkveaw5dpsidmdyiany4wkexbpd@s4yremtvct4a>
References: <2meuzip4qnxvle4bwk4hbow4j34ii3cwb46xd5inq5btif5mjg@iiygy6ir7vtr>
 <aJnlnx2qF6P61jJN@smile.fi.intel.com>
 <7c2d08e3-d1e2-433e-b726-307246ab17e9@kernel.org>
 <aJoQE2CQv3nzaSqc@smile.fi.intel.com>
 <uakyig6sp2sfuwtt2aq7ds5dcbsjrgcijenunefqzc46inpees@xc6bfr4mjnan>
 <c60ccef1-7213-4dd7-8c10-e8ef03675bd8@kernel.org>
 <4151a14f-8427-41a9-84cf-e901080d0eb1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4151a14f-8427-41a9-84cf-e901080d0eb1@kernel.org>

On Mon, Aug 11, 2025 at 07:44:01PM +0200, Hans de Goede wrote:
> On 11-Aug-25 7:40 PM, Hans de Goede wrote:
> > Hi,
> > 
> > On 11-Aug-25 5:49 PM, Dmitry Torokhov wrote:
> >> On Mon, Aug 11, 2025 at 06:45:23PM +0300, Andy Shevchenko wrote:
> >>> On Mon, Aug 11, 2025 at 04:20:33PM +0200, Hans de Goede wrote:
> >>>> On 11-Aug-25 2:44 PM, Andy Shevchenko wrote:
> >>>>> On Sun, Aug 10, 2025 at 09:31:37PM -0700, Dmitry Torokhov wrote:
> >>>
> >>> ...
> >>>
> >>>>> Otherwise LGTM as here it looks like we establish platform device ourselves and
> >>>>> hence no need some additional magic Hans mentioned in the other series.
> >>>>
> >>>> Not entirely like with the x86-android-tablets patches this
> >>>> declares a software-node for the gpiochip:
> >>>>
> >>>> static const struct software_node gpiochip_node = {
> >>>> 	.name = DRIVER_NAME,
> >>>> };
> >>>>
> >>>> and registers that node, but nowhere does it actually
> >>>> get assigned to the gpiochip.
> >>>>
> >>>> This is going to need a line like this added to probe():
> >>>>
> >>>> 	p50->gc.fwnode = software_node_fwnode(&gpiochip_node);
> >>>>
> >>>> note the software_node_fwnode() call MUST be made after
> >>>> registering the software-nodes (group).
> >>>>
> >>>> Other then needing this single line things are indeed
> >>>> much easier when the code containing the software
> >>>> properties / nodes is the same code as which is
> >>>> registering the gpiochip.
> >>>
> >>> Ah, good point!
> >>
> >> This is wrong though, the software node need not be attached to the
> >> gpiochip (and I wonder if it is even safe to do so). It simply provides
> >> a name by which gpiochip is looked up in swnode_get_gpio_device().
> > 
> > Ah interesting. This is very different from how fwnodes generally
> > work though. Generally speaking when a PROPERTY_ENTRY_REF() is used
> > like PROPERTY_ENTRY_GPIO() does then the lookup is done by matching
> > the reference to the fwnode of the type of device to which the
> > reference points.
> > 
> > IOW the standard way how this works for most other subsystems
> > is that gpiolib-swnode.c: swnode_get_gpio_device() would call
> > gpio_device_find() with a compare function which uses
> > device_match_fwnode().
> > 
> > I see that instead it uses the swnode name and passes that to
> > gpio_device_find_by_label().
> > 
> > I must say that AFAIK this is not how swnodes are supposed to
> > be used the swnode name field is supposed to only be there
> > for debugging use and may normally be left empty all together.

Hmm, given that I wrote both the references support for software nodes
and gpiolib-swnode.c they work exactly as I wanted them ;) Yes, in
general name is optional, but for GPIOs it is needed.

> > 
> > I guess using the swnode-name + gpio_device_find_by_label()
> > works but it goes against the design of how fw-nodes
> > and especially fwnode-references are supposed to be used...
> > 
> > Having a fwnode reference pointing to what is in essence
> > a dangling (not attached to any device) fwnode is weird.

I agree it is a bit weird, but this allows to disconnect the board file
from the GPIO driver and makes it easier to convert to device tree down
the road as it can be done in a piecemeal fashion. If you want fwnode
actually attached to the gpiochip then:

1. You can't really have static/const initializers in most of the cases
2. Fishing it out from an unrelated subsystem is much harder than
matching on a name.

> > 
> > Are there already any users of PROPERTY_ENTRY_GPIO() in
> > the kernel? If not then I think that we should fix things
> > up to actually do a reference match and not a name based
> > lookup.

I converted spitz and a few other drivers. Some of that has landed.

> > 
> > Andy IIRC you've done quite a bit of work on software-nodes,
> > what is your take on this ?
> > 
> > Note this is likely my last email in this thread for
> > a while since I will be traveling without email access.
> 
> p.s.
> 
> It seems that atm device_match_fwnode() only checks
> that the passed in fwnode to match on matches the primary
> fwnode of the device. This should be modified to also
> match on the secondary node if matching the first node
> fails. Like how e.g. fwnode_property_present() falls
> back to checking the secondary node if the requested
> property is not present in the primary fwnode.

Thanks.

-- 
Dmitry

