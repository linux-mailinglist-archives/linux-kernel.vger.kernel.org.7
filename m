Return-Path: <linux-kernel+bounces-739245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D25B0C3D2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059EF1AA3435
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B01F2D3EC9;
	Mon, 21 Jul 2025 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U5GK0Hmf"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47022BEFF3
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753099647; cv=none; b=c3SBDWsSH8u4/K1NnQoXprYvxim82BF+oddzLX5gv8PwPkPH0Ft3Ixg/ziw2y/2N0AAmKOhizIsiUFw4z0vAfhXgLyZVoGVx0/nrrQXkqAlzFA7BcTvtWU5d2Ym+eeYK6J/zmDVd3RabQIDiJvJj8M9GcDMLjSzWevQ1wDxWwsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753099647; c=relaxed/simple;
	bh=wG8gn7o4OLaoNek5oVDTyFfMLxH5oEdd1Vk0w8wqX3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hAIU+yb9hWGqe9lhIPiDbXPxCKIOp5IN/WxS1pP1JyrrIuW7VYg45Ra3nYa8ZdBBisugZHOTyY0uuLNpGzIVfARSnY7m+doYAEIu98Z61z8Bar9GM8Ko9NQlXlufZtVd0OtYvaaL4VdT+ObCwX3KkEU7nyeYggQLHpuld9S+0Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U5GK0Hmf; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-456267c79deso13783545e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 05:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753099643; x=1753704443; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Gzuzppwiayyz5cF0fOXjbu6tFBcc0/Gyguf/uYR3tU=;
        b=U5GK0Hmfz4M46LC3l4ECcQFUJC3mxw/eNOLqUhKwNYLuhp6cw7XRS3S57WDpIdBAwp
         w5s+PrbM/8WlBxOTSice9ss4rZ+jEJL2YfT0cX2xYaBU50s8cSTohhrU2qGedblAoiX1
         0/IRWSfRl6frbHL2KPVhtgJCtQOVAZnEIIju1ULTQ3NHYj+5FpUs6TY75FXq+6094y/M
         Uc1Yr7BxTcUMTkBDT4tephQlkiJEqNNDOVronA5jX2YOLo/7a7UDhJ9n29TzS/l7vN4k
         Kj8NncnLoEYwb70YUJb1iklgrtZJWkC1JwAg4CLtt0SPZYZZIAtEw1vmpPPH9qjxbsGD
         KsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753099643; x=1753704443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Gzuzppwiayyz5cF0fOXjbu6tFBcc0/Gyguf/uYR3tU=;
        b=bu38ZZYvWA3VkhepEV+3xXeJ4jCMcVQN5kCVVL+NKZciYEquPSxkV1b6sTcXT9ttKg
         Z3tAIShaPjzo0yd2xs26pN27xPIF6bJ+RJSrEPZzOYGTAQXbmyVB0+8NE4uR4B8oWIa2
         qMFP2oFZKEUqI+bRth31Nw4UFbNqRXsI7xPerscqjZOiWaa7934X1ja3eU1gu5kWiLPx
         ZYt+yR5zaI57PlHtlHdLrFfvfKNmanrWsVfNbWnOHQYE+iZfu23FWHEfO0FRvaMmry5W
         GrpdNlTQhvmTlmuwlI9nSdzBK/wXIh2843taiqR/jKO4HZ3+26vw6X9d5K0AzQ98BlX7
         iL9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7u4MFBuytlet2FtooWQQchTEhVt3RTYuWEZG86mAgnMPJaQ3ANqbzafykp2Y9vHSKwru424nXJMp/bGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQj/vCiT+MpgIsnJdULBEV9+9SjU7jUrr9QK7HWUbn/KdomCk4
	7pLYxYJV/pINiQQVigHWoPCPw5zc8i0WZOmlrSL7yVpOs7IjbHdgZxfDgQgJU9ab9ATZe0vpTGj
	CRPL7T2GLQGkGD9dI6w==
X-Google-Smtp-Source: AGHT+IEGOWH6FGkEv2x1QGuPeg0wkb+XCwMNp9QWP/+3SmmKTDb2l35xDE25WpVhR9Rs+D5wYQShvojHrq1r8Oo=
X-Received: from wmrn36.prod.google.com ([2002:a05:600c:5024:b0:456:24b4:ebc3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:19cb:b0:43c:ee3f:2c3 with SMTP id 5b1f17b1804b1-4562e37a0ecmr155540775e9.7.1753099643214;
 Mon, 21 Jul 2025 05:07:23 -0700 (PDT)
Date: Mon, 21 Jul 2025 12:07:22 +0000
In-Reply-To: <2025072125-twine-curling-db0b@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717224806.54763-1-dakr@kernel.org> <20250717224806.54763-3-dakr@kernel.org>
 <aH4juIVmj8euE1CA@google.com> <2025072125-twine-curling-db0b@gregkh>
Message-ID: <aH4telYyyexiMbjx@google.com>
Subject: Re: [PATCH 2/3] device: rust: expand documentation for Device
From: Alice Ryhl <aliceryhl@google.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Danilo Krummrich <dakr@kernel.org>, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Jul 21, 2025 at 01:42:17PM +0200, Greg KH wrote:
> On Mon, Jul 21, 2025 at 11:26:23AM +0000, Alice Ryhl wrote:
> > On Fri, Jul 18, 2025 at 12:45:38AM +0200, Danilo Krummrich wrote:
> > > The documentation for the generic Device type is outdated and deserves
> > > much more detail.
> > > 
> > > Hence, expand the documentation and cover topics such as device types,
> > > device contexts, as well as information on how to use the generic device
> > > infrastructure to implement bus and class specific device types.
> > > 
> > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > 
> > Overall I think this series is pretty great. It also clarifies some
> > things for me, particularly the difference between bus and class
> > devices.
> > 
> > > +/// # Device Types
> > >  ///
> > > +/// A [`Device`] can represent either a bus device or a class device.
> > >  ///
> > > +/// ## Bus Devices
> > > +///
> > > +/// A bus device is a [`Device`] that is associated with a physical or virtual bus. Examples of
> > > +/// buses include PCI, USB, I2C, and SPI. Devices attached to a bus are registered with a specific
> > > +/// bus type, which facilitates matching devices with appropriate drivers based on IDs or other
> > > +/// identifying information. Bus devices are visible in sysfs under `/sys/bus/<bus-name>/devices/`.
> > > +///
> > > +/// ## Class Devices
> > > +///
> > > +/// A class device is a [`Device`] that is associated with a logical category of functionality
> > > +/// rather than a physical bus. Examples of classes include block devices, network interfaces, sound
> > > +/// cards, and input devices. Class devices are grouped under a common class and exposed to
> > > +/// userspace via entries in `/sys/class/<class-name>/`.
> > > +///
> > > +/// # Device Context
> > > +///
> > > +/// [`Device`] references are generic over a [`DeviceContext`], which represents the type state of
> > > +/// a [`Device`].
> > > +///
> > > +/// As the name indicates, this type state represents the context of the scope the [`Device`]
> > > +/// reference is valid in. For instance, the [`Bound`] context guarantees that the [`Device`] is
> > > +/// bound to a driver for the entire duration of the existence of a [`Device<Bound>`] reference.
> > > +///
> > > +/// Other [`DeviceContext`] types besides [`Bound`] are [`Normal`], [`Core`] and [`CoreInternal`].
> > > +///
> > > +/// Unless selected otherwise [`Device`] defaults to the [`Normal`] [`DeviceContext`], which by
> > > +/// itself has no additional requirements.
> > > +///
> > > +/// It is always up to the caller of [`Device::from_raw`] to select the correct [`DeviceContext`]
> > > +/// type for the corresponding scope the [`Device`] reference is created in.
> > > +///
> > > +/// All [`DeviceContext`] types other than [`Normal`] are intended to be used with
> > > +/// [bus devices](#bus-devices) only.
> > 
> > This raises a few questions for me.
> > 
> > The first one is "why"? On other series I have been told that interrupts
> > must be registered and deregistered before the device is unbound. Does
> > the same not apply to interrupts for an input device such as a USB
> > keyboard?
> 
> USB drivers don't have interrupts :)

I guess that if class drivers never have interrupts, then that is an
answer to my question.

> Seriously, generally, yes, you should always unregister your irq handler
> BEFORE you unbind the driver from the device, otherwise the callback
> logic normally assumes that the driver is bound to the device and the
> pointers are almost always "stale" at that time.
> 
> But I don't understand what interrupts have to do with the above
> documentation, what's the connection?

The connection is that to request an irq you must have a &Device<Bound>,
so if you can only obtain a &Device<Bound> to a bus device, then that
means that you can never request an irq for a class device.

> > The second one is why we use the same `Device` type for both cases?
> > Would it not make more sense to have a BusDevice and ClassDevice type?
> 
> We used to have both types, years/decades ago, and in the end, just gave
> up and merged them together as it really didn't make much sense as the
> structure really was the same type of thing everywhere.  So let's not go
> back to that mess if we can prevent it please.
> 
> We also used to have a out-of-tree patchset that just merged class and
> bus together, as they are almost the same thing as well, but that just
> caused too much confusion so we never merged it.

Okay, thanks!

Alice

