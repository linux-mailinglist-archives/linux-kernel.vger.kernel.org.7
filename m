Return-Path: <linux-kernel+bounces-738245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B5FB0B64A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 15:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3DF217B0CD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 13:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4D61E32DB;
	Sun, 20 Jul 2025 13:51:47 +0000 (UTC)
Received: from smtp.blochl.de (mail.blochl.de [151.80.40.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7847E110
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.40.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753019507; cv=none; b=EISjm6kv1lp0UyYlZbqr7h/Ebiu3lRQfGsyKSPWWY74C5ruzqsEupXd4qyAc+ImAleQmUfDR/Pk5XsdlFx5xlHdcp93YLLxwGdNLelbJYiCzaV1zxrxgS+NgJ+IzlbRBGEn7212zfmmpFHEfgI21v7KeZoux6oPTYdqOgRVzWys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753019507; c=relaxed/simple;
	bh=g92cDChICHPCHuRnXP+vXwyk0wxHavdHF1Tzgd8LHKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9j2pIT1wV3suxm2ogrnjdR7wAfO4aGRdwJ7W00tFzbPzCDvZ9CAf1EWhD6e6rWq7eqic9mgaOJHbqVE6E40W+custgMoiVz9vmAeLNN3ifELV6/1yKxwBlgjj9CGvQHail5ZNDhoAsL77pusuJq+VnDfc6OYx9FSNVuWncGH8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blochl.de; spf=pass smtp.mailfrom=blochl.de; arc=none smtp.client-ip=151.80.40.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blochl.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blochl.de
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.blochl.de D6798446649A
Authentication-Results: mail.blochl.de; dmarc=none (p=none dis=none) header.from=blochl.de
Authentication-Results: mail.blochl.de; spf=fail smtp.mailfrom=blochl.de
Received: from WorkKnecht.fritz.box (ppp-93-104-0-143.dynamic.mnet-online.de [93.104.0.143])
	by smtp.blochl.de (Postfix) with ESMTPSA id D6798446649A;
	Sun, 20 Jul 2025 13:51:31 +0000 (UTC)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.4.2 at 472b552e6fe8
Date: Sun, 20 Jul 2025 15:51:27 +0200
From: Markus =?utf-8?Q?Bl=C3=B6chl?= <markus@blochl.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Markus =?utf-8?Q?Bl=C3=B6chl?= <Markus.Bloechl@ipetronik.com>, 
	John Stultz <jstultz@google.com>, "Christopher S. Hall" <christopher.s.hall@intel.com>, 
	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] timekeeping: Always initialize use_nsecs when querying
 time from phc drivers
Message-ID: <eouuhjxmtlnrrsvi45mzyjzrycwjwhzgut3hnlghhbblbdkdeu@5nzama2xthvh>
References: <txyrr26hxe3xpq3ebqb5ewkgvhvp7xalotaouwludjtjifnah2@7tmgczln4aoo>
 <CANDhNCoRZOs0qNdJqUF=5RBWP0MCCC_4zbvvftzNWwvuX087xA@mail.gmail.com>
 <6rweov4mf5z7sy4k3sfhktko3qt2cj5jgo3y4hvexjtykdlgj7@7tomywnjtlio>
 <87a551w8k7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a551w8k7.ffs@tglx>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (smtp.blochl.de [0.0.0.0]); Sun, 20 Jul 2025 13:51:32 +0000 (UTC)

Hi Thomas,

On Fri, Jul 18, 2025 at 10:25:12PM +0200, Thomas Gleixner wrote:
> On Wed, Jul 09 2025 at 10:32, Markus Blöchl wrote:
> > On Tue, Jul 08, 2025 at 12:09:40PM -0700, John Stultz wrote:
> >> On Tue, Jul 8, 2025 at 9:46 AM Markus Blöchl
> >> <markus.bloechl@ipetronik.com> wrote:
> >> >
> >> > diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> >> > index a009c91f7b05..be0da807329f 100644
> >> > --- a/kernel/time/timekeeping.c
> >> > +++ b/kernel/time/timekeeping.c
> >> > @@ -1269,6 +1269,8 @@ int get_device_system_crosststamp(int (*get_time_fn)
> >> >
> >> >         do {
> >> >                 seq = read_seqcount_begin(&tk_core.seq);
> >> > +               system_counterval.use_nsecs = false;
> >> > +
> >>
> >> So if the argument is the local system_counterval structure isn't
> >> being fully initialized by the get_time_fn() functions it is passed
> >> to, it seems like it would be better to do so at the top of
> >> get_device_system_crosststamp(), and not inside the seqloop.
> >
> > Probably, I was just afraid of the case where get_time_fn() would take
> > like *very* different paths during different iterations.
> > But that seems really unlikely, indeed.
> 
> It's impossible. xtstamp->device and the related get_time_fn() are
> immutable during the call.

I don't see it being entirely impossible, just nonsensical.
get_time_fn() tends to read volatile external data and is thus far from
being a pure function.
Some implementations (e.g. ptp_vmclock_get_time_fn()) can take some
weird turns, which I did not want to follow all the way.
I have no clue what could happen e.g. during a VM migration.
That's why resetting the struct before every invocation seemed to be
the safer option to me.
If you are certain that something like that can never happen, then I'm
totally happy.

> 
> >> But having the responsibility to initialize/fill in the structure
> >> being split across the core and the implementation logic (leaving some
> >> of the fields as optional) feels prone to mistakes, so it makes me
> >> wonder if those drivers implementing the get_time_fn() really ought to
> >> fully fill out the structure, and thus the fix would be better done in
> >> those drivers.
> >
> > Yes, they should.
> 
> No, they should not.
> 
> The data structure is instantiated in get_device_system_crosststamp()
> and then handed in un-initialized to get_time_fn(), which is wrong to
> begin with. Why?
> 
> That means if the structure is ever expanded, then you'd have to fix up
> all of the get_time_fn() implementations.

As long as all get_time_fn() implementations adhere to the convention of
always assigning an entire, fully-initialized struct and are always
compiled against the same headers as the kernel, I don't see that
necessity. But yes, those are obviously a lot of "if"s...

> 
> Seriously?
> 
> The obviously correct and future proof thing to do is:
> 
> -	struct system_counterval_t system_counterval;
> +	struct system_counterval_t system_counterval = { };
> 
> Which fixes the problem you discovered once and forever, no?

Works for me, too.
Reroll follows.

> 
> Thanks,
> 
>         tglx

Thanks a lot,

Markus

-- 

