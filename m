Return-Path: <linux-kernel+bounces-829688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22935B97A28
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6B019C3B80
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C32F2F1FDD;
	Tue, 23 Sep 2025 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SSO/EhRY"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E2A2E7F27
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664303; cv=none; b=Wj/YRyj12UECFW8cT9xYaQgy5zO5tmH+XZPWsEGJTMq82e3QVZs4dcV9UAM0xrd1sJ3lnqW86TC6AhsmvUsXpIxIjFos51gVqbRhHB8V4r663uDxAETMMRl+llndYhNiuSsZUWYTuzrKi2cM6pUrqg8hhSQf5rum2bAIyNQr0kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664303; c=relaxed/simple;
	bh=TZ/4RZqmJx8nT5UAqseK8KWLNlnTGv2swniVLnuOw1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVhj0DFkIxkMaYQPr4Jgq2zHo6M8kngDrYSJFlxWzfK6hr4yRv6ei8prazIcEx4KSQC/g6eksH7Ysk8eRwI6KFHI9u44+gijZd2Tf+47kSsxQsLnJIjOCgMAe/rg/8gSe+C/N00VWM/D4LnqJNuXfPD7UfpJYOB6egPo2dLjWCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SSO/EhRY; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b553412a19bso2316285a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758664301; x=1759269101; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l3xBl6BdAh/kCCxZLUhoPYjdbnlgJBcOgSnus1I/AnU=;
        b=SSO/EhRYrj2EsfMOYdqj26cf08FbHnrQWCorioGPBzDDfhFTLU2MPFUUWpag8LiFOb
         lhdyX0B5GoQj/qjqXrdaKW/aSCD7JjfENYt42iazZPhByEMvKaIh7Phj/cUNt1idTLGt
         +XFzfEADNXHd56SWR2WnxYQfDNia2uhl3mmMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758664301; x=1759269101;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3xBl6BdAh/kCCxZLUhoPYjdbnlgJBcOgSnus1I/AnU=;
        b=tMq4quI5jo7NFM1SWS+OlnR9ZBW6rwThFx5hRBQlAOEx9niPKuiwNo2zoI4sBq2e8k
         DrCERhr79O54HKeWmYKBreLe9kY62jK+WMPQLFaWOo0OY5JYEQhNa3p1pJwwzG6LA8Xk
         faQT/kNNdPhXp9xULyFkbVwSdKYENaiBfY5ixOQ+pcg225gJ7gDluY1PrLcMlPNy0pDy
         bceh0V2CqMYE/iv0t2yJVyBB3OXM4ONiwvcL3+l1y8plnQn/SxnH8u6oQ1MWfLD+7AkF
         ijt5Ug0KtjkKCIZP8wubHuj2ToYxELbPlDUSRllu1DgYl4p6JzUdrcnb5MdwqdQ1FntM
         Gylw==
X-Forwarded-Encrypted: i=1; AJvYcCVaE44T1hXPv1PEuesMbVVAgGgu/EqjYTuc4CnkmnyUOYp/5N9JPdmyaoXis+hWykXIo9JcU8vpFs9Fk/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YylRISv2fQlg0hu+x5MjRvJXo65xqD0doEbfoQN355hwdpud4ip
	K6yeEs/x5CZUCUwCl/FjrRW2DosiIaXM3B4kQchkzzB/Y93u2Hur/DVVu+s0hoTe1A==
X-Gm-Gg: ASbGncsXVC6GggbLoF5vsyc3SDnivZCIDBCb/TtoXD9U49zMa2NQ3rW1MU8f1CsxN4l
	F4GxzHP5x97thYFRt9vmomLm4g6O4KaqeEHvB3c5sUhrGSOZ0Q7/MkbVGdIWehij29JLUsX4dX8
	l8FIDntBoDqcPUnNyVP4KnKxcFMeVC3IrjfahD+KRxERPa0bZaBv8PryxJCi9CMAcaMsn6JCH7S
	r0dHoQ6F5AGMXQYcGXoddF8MSS4otXMa0jqnkV42PvAbR27Wd7uwYBHFngCggt0MJHI3EU2xCU0
	MO6cc5ddUn6T4ey/DgeiagnmClwdwzju3+mqYyclWpEo09U5ShQ2NuD7oTpsUPpjw7qTOVHnc8E
	BlptntplLHKbt9QuICdtTCutpsXh3nWKwSpIjLZwYmjuuFPZPobwDA/Rp7gXfU+u6KIORqEc=
X-Google-Smtp-Source: AGHT+IHWViQLu1PbJGPzKYrSBRQBX86hUFB9kfkvbHhNkjyoiP0lWB6Ubwl2tc0o+ip+ejDbq5Ft1A==
X-Received: by 2002:a17:902:f685:b0:246:7a43:3f84 with SMTP id d9443c01a7336-27cc128c12amr52545175ad.5.1758664301584;
        Tue, 23 Sep 2025 14:51:41 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:26d9:5758:328a:50f8])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-27d6cba0a18sm21282405ad.145.2025.09.23.14.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 14:51:40 -0700 (PDT)
Date: Tue, 23 Sep 2025 14:51:39 -0700
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	kunit-dev@googlegroups.com, Len Brown <lenb@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PM: runtime: Add basic kunit tests for API contracts
Message-ID: <aNMWa0SD5l4Cb6G_@google.com>
References: <20250829003319.2785282-1-briannorris@chromium.org>
 <CAJZ5v0gGKsR0bVayyTXy1W9FLwVfG1S+gseH7jPKtggzZFNpfA@mail.gmail.com>
 <aMHjOJGaKi9cwbsn@google.com>
 <CAJZ5v0iELLPYBS6FKmX=DhoyQ2tDq9F9DAzuV0A8etv0dGeJvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iELLPYBS6FKmX=DhoyQ2tDq9F9DAzuV0A8etv0dGeJvQ@mail.gmail.com>

Hi Rafael,

On Fri, Sep 19, 2025 at 06:58:50PM +0200, Rafael J. Wysocki wrote:
> On Wed, Sep 10, 2025 at 10:44 PM Brian Norris <briannorris@chromium.org> wrote:
> > On Fri, Sep 05, 2025 at 07:37:38PM +0200, Rafael J. Wysocki wrote:
> > > On Fri, Aug 29, 2025 at 2:33 AM Brian Norris <briannorris@chromium.org> wrote:
> > > > +       /* Flush, in case the above (non-sync) triggered any work. */
> > > > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_barrier(dev)); /* no wakeup needed */
> > >
> > > Why do you run pm_runtime_barrier(dev) here?  It is guaranteed that no
> > > requests are pending at this point.
> >
...
> > So IMO, it's a reasonable thing to run in this test, although I probably
> > should drop the "Flush" comment.
> 
> Yeah, changing the comment would help.

Will do.

> > > > +
> > > > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > >
> > > This has already been tested above.
...
> > Anyway, like I said, it's probably some matter of opinion/style. I can
> > drop some of these checks if you still think they have no place here.
> 
> I would do just two of them, one at the beginning and one at the end.
> It should be an invariant for everything in between.

Ack.

> > > > +       /*
> > > > +        * We never actually left RPM_SUSPENDED, but rpm_idle() still treats
> > > > +        * this as -EAGAIN / "runtime PM status change ongoing".
> > >
> > > No, this means "Conditions are not suitable, but may change".
> >
> > I'm just quoting the API docs for put():
> >
> > """
> > * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
> > """
> >
> > If that's the wrong language, then we should update the API doc. At any
> > rate, I'm not sure what's "unsuitable" about a suspended device when we
> > call put(). It's not unsuitable -- it's already in the target state!
> >
> > Notably, I'm also changing this behavior in patch 2, since I think it's
> > an API bug. And the comment then goes away.
> 
> Yeah, so I'd prefer to change this particular thing entirely,
> especially in the face of
> 
> https://lore.kernel.org/linux-pm/5049058.31r3eYUQgx@rafael.j.wysocki/
> 
> which quite obviously doesn't take the return value of
> pm_runtime_put() and pm_runtime_put_sutosuspend() into account.
> 
> I would like these two functions to be void.

Sure, I think inspecting put() return codes is generally a bad idea.
'void' would be cool with me, although maybe a bit impractical now,
considering how many users look at the current return code. So at a
minimum, I'd separate "make 'em void" from my "document and test the
API" work.

Really, I'm mostly looking at this area because I have to support driver
developers trying to learn how to use the runtime PM API, and they
wonder about the return codes. So if they exist, I'd at least like them
to make sense.

Anyway, for the particulars of this test: I can try to adapt the comment
language a bit. But are you suggesting I shouldn't even try patch 2,
which fixes the pm_runtime_put() return codes?

> Of course, there are existing users that check their return values,
> but I'm not sure how much of a real advantage from doing that is.  At
> least some of those users appear to not exactly know what they are
> doing.
> 

...

> > > > +static void pm_runtime_error_test(struct kunit *test)
> > > > +{
...

> > > > +       /* Still suspended */
> > >
> > > Error is still pending.
> >
> > Your statement is true, but I'm not quite sure what you're suggesting.
> > Are you suggesting I should
> >
> >         KUNIT_EXPECT_EQ(test, -EIO, dev->power.runtime_error);
> >
> > ?
> >
> > Or are you suggesting I change the comment?
> 
> Change the comment.
> 
> > I'm thinking I'll do both.
> 
> That will work too.

Ack.

Brian

