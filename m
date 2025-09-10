Return-Path: <linux-kernel+bounces-810831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9697DB5204D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00211C84D7F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1922C3245;
	Wed, 10 Sep 2025 18:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kg1V77eU"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BCD2C21FB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757529315; cv=none; b=kzMoni9DN9ZMNTHTzm1RftYu/SfKHohK0G8sETJl/UorXAjH8lZU8D5K56AEgyw3U3XwoIOWOXSbPHL7OBZquNv5F/4C530qWN/tUyeEmokWHWvLA+pgsw/zkw0SPgFi4Q0BROHKtNQfACbYwfEhIK9WKr6bHrN/OBk8P1TuuAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757529315; c=relaxed/simple;
	bh=5lFys8BTPsGWhrt0SoMF130W3SY2Xb+sxr9D2suSUyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwlVj6/3LwQDEmKAO2oBohKAqsVOVoaHWdqahCohI4K8Ctzt+lOttADD8p8qY4b4J/xKpXDIsGYrJ/2bVB5wXp24H3lOA+K6MWMwYzcQ6UvOsFFP75q+DQmWtRoLTWOlfPwyVKO1CxU5rzfh5mMixBMHfKQZUiDPNGTFT5iz3o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kg1V77eU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77250e45d36so6301166b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757529313; x=1758134113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtDjIHDTo3C1gWUX1+oDXMnJAa5/njN7fZggjarDkBw=;
        b=kg1V77eUf3SglXa4GCnEZsMPWXlf/ZxlggfSMwZms+pwhg4hxSeLb8sLPd24tU3iE9
         WicklG67Mo9PlxzU4USgoXTYzlGPWhhmSpR+uBoQMoN9TvMyqS23sdldsGVOMcjN6UZs
         qvEK7YnlAC80H/KqCUt8SUKZbmjH/uKb9+F8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757529313; x=1758134113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtDjIHDTo3C1gWUX1+oDXMnJAa5/njN7fZggjarDkBw=;
        b=RI86hDivHS5trWw6P5KCaQWYCX3e8KL2feETDY3biygl0jrcMBVpwgxS1GZd7nPmJK
         UlSJPwBM4mYTJI+cIEWkJmfHYuS/VgimvhOHnH1wkWVyne8o7JqzTJCEZLX1K/k1BjGr
         jO+T53nEfNJ9k/vOIaImiCwRGROgEhk4JG25YvdRsIOW0a3NB9z2phTnt4bvoMHwB/ds
         8rz9ubjJC5UiuVFozcjQV5qMsWPxGjJ7XfD6s95dSltqCSXAib+ktWITYzixvCpFXMur
         GzQvf9jHu3L3MtndIIZhPL/JoNvCkDVqACwMucbyF3ePbI/wSILZsomrKBzKkxVc9Rto
         xBpA==
X-Forwarded-Encrypted: i=1; AJvYcCU7Mejb1qTJX44Cng3tEyIvpJFnA6VY/PBU61K9BL7MO15bmH44yfv/ysJIynhducbsFU1HCu1FsVRnnOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YywOHQ7NtXykw5myZdF3zX6CXhdc2jzI4lNNM+syFItZmtiiavW
	UBFRnhd4TlLnRK/2yftxhpG3yIyHqulRVn8ASMBYnMJQeDzx5c9xPXwxCdWr1qN0J7ZOr/PUHav
	oNjQ=
X-Gm-Gg: ASbGnct97t61otBx0j5Apze5KT79dccAkeWrC6ocGe6chlxpwgn+50+b+qOYoOPaLZA
	N/7pSjg4NcuPjV0zjPsPc9P0pmJt4fchIHKwxIJcRRsdw7qwBuKgiweDz3dcLq4WbJ86gjxJ/65
	W71UBU9kE1XOK7eoNU9lsVz31bcBf+ovkBN7fmHgdsFozQKNvlCYTMQ4sPNsdkzJAfrX63whTWn
	H7H6uEPEbEg3luF9i7bzCDhxinTzdydB+aSd7h8QIhdJKasD/yW6vBFOVjjwfaL13AhZIlv75OA
	ZezvP5f+xbLR6G77LqW6soIU2c7UVaWPOsBr/ObZg9SI2r1AzeE2xzq1thzFtFXiXTNimZiKahK
	kVeK0i0kkEn4gReNjFAf0T7njrsolR15yTlL471qXKdta4vsRsbf9oxCU4YmxSIibVtWfyXM=
X-Google-Smtp-Source: AGHT+IEv3VB5QczmrOwpVAmxhE/aEbuXp1vgX7hNah2/dUWAz+OV7H3EEAVGg1UBZuQpPsnmusrRcA==
X-Received: by 2002:a05:6a00:c89:b0:772:177:d442 with SMTP id d2e1a72fcca58-7742dddce93mr17438912b3a.20.1757529313302;
        Wed, 10 Sep 2025 11:35:13 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:4780:f759:d36a:6480])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7746629088dsm5859972b3a.53.2025.09.10.11.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 11:35:12 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:35:10 -0700
From: Brian Norris <briannorris@chromium.org>
To: Ethan Zhao <etzhao1900@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: Ensure devices are powered for config reads
Message-ID: <aMHE3hmnGTYBrK0E@google.com>
References: <20250820102607.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid>
 <dfdc655e-1e06-42df-918f-7d56f26a7473@gmail.com>
 <aKaK4WS0pY0Nb2yi@google.com>
 <048bd3c4-887c-4d17-9636-354cc626afa3@gmail.com>
 <aKc7D78owL_op3Ei@google.com>
 <da46b882-0cd3-48cd-b4fc-b118b25e1e7e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da46b882-0cd3-48cd-b4fc-b118b25e1e7e@gmail.com>

On Fri, Aug 22, 2025 at 09:11:25AM +0800, Ethan Zhao wrote:
> On 8/21/2025 11:28 PM, Brian Norris wrote:
> > On Thu, Aug 21, 2025 at 08:41:28PM +0800, Ethan Zhao wrote:
> > > Hold a PM reference by pci_config_pm_runtime_get() and then write some
> > > data to the PCIe config space, no objection.
> > > 
> > > To know about the linkspeed etc capabilities/not status, how about
> > > creating a cached version of these caps, no need to change their
> > > power state.
> > 
> > For static values like the "max" attributes, maybe that's fine.
> > 
> > But Linux is not always the one changing the link speed. I've seen PCI
> > devices that autonomously request link-speed changes, and AFAICT, the
> > only way we'd know in host software is to go reread the config
> > registers. So caching just produces cache invalidation problems.
> Maybe you meant the link-speed status, that would be volatile based on
> link retraining.

Yes.

> Here we are talking about some non-volatile capabilities value no
> invalidation needed to their cached variables.

I missed the "not status" part a few lines up.

So yes, I agree it's possible to make some of these (but not all) use a
cache. I could perhaps give that a shot, if it's acknowledged that the
non-cacheable attributes are worth fixing.

>
> > > If there is aggressive power saving requirement, and the polling
> > > of these caps will make up wakeup/poweron bugs.
> > 
> > If you're worried about wakeup frequency, I think that's a matter of
> > user space / system administraction to decide -- if it doesn't want to
> > potentially wake up the link, it shouldn't be poking at config-based
> IMHO, sysfs interface is part of KABI, you change its behavior , you
> definitely would break some running binaries. there is alternative
> way to avoid re-cooking binaries or waking up administrator to modify
> their configuration/script in the deep night. you already got it.

That's not how KABI works. Just because there's a potentially-observable
difference doesn't mean we're "breaking" the ABI. You'd have to
demonstrate an actual use case that is breaking. I don't see how it's
"broken" to wake up a device when the API is asking for a value that can
only be retrieved while awake. Sure, it's potentially a small change in
power consumption, but that can apply to almost any kind of change.

My claim is that this is a currently broken area, and that it is
impossible to use these interfaces on a system that aggressively enters
D3cold. If a system observes any difference from this change, then it
was broken before. Bugfixes are not inherently KABI breakages just
because they can be observed.

Brian

