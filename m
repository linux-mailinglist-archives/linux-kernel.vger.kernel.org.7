Return-Path: <linux-kernel+bounces-737340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A310B0AB1B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8BF31C807C7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF93F21A436;
	Fri, 18 Jul 2025 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JNCa3p9O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+RnNcx8+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D510D3597E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752870317; cv=none; b=LHBMx3dN1k+7b4Osg0m7tXkuJzMBvlG1bLc9O/+5okhNzLs9r1d8bPuxgYovoE/7/i0Cpu/eKxytZOWMEV6z0KRpmwd0AjY0ny872S5hmlmpzDnyLWM7ppgE/UJtAGoKLL+85cAfAJmVnGHIPkmfOnJCkgXx79m/SCN1XR8c7sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752870317; c=relaxed/simple;
	bh=FIJnaiLJ7/jMTBjTat+x4rEXmus+Fr275rfKBD7bnDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YT4kqfS93X86aqOKnrFVbtWNwZ+8cEkDTzpz+s28FFSDHzyK6tm1xg7Sw8zmiqRiuC2JuFcPn57HJGE3uu4GB2xCdE3V/NeVqXnH9MCqI04+CDxfwgGiO42Yv3AU+KYHg2YxrXwcqEBDZLuxwKGS68U6zVJoyYmjDvuLQzI5XSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JNCa3p9O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+RnNcx8+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752870314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVS4zSK+i2h9K8I4Xk0uOTcJW+Rkh1rnWs37pjnV/m0=;
	b=JNCa3p9O7DDgmABD5dazRknv9MDly+o/ddHOj3An8ImwTVuYYg75p/atGkQWhbE1QWx3Uk
	NsgOWenGOIwFPlDFqpOhhTn4RZm9Jd4TfMKrZ2VHbUT/NZSF0LpF8B/QnknKWDoBOQmpaY
	AkXtgq57sbuLDF5DHPgknxiCXhQ6KZdh/yH1kaEHbxMT25MqACLCFK9U1v4m2z5qvAWyaW
	UxZDcSxqXDXgJXEtSABjysY8RK7j3KjIBu6/dycdajm/pFsyUR0iJ2fE0O2uJIpGetjV/Q
	8wMcCtMeO4Umx85TG48JhFEapo5VC/k8NrV6qYl5Lzu5JVKk92ld98oh77ZQ+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752870314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVS4zSK+i2h9K8I4Xk0uOTcJW+Rkh1rnWs37pjnV/m0=;
	b=+RnNcx8+UxJU1wrTF+ZyZ6qmZplLO04UAmqIR8+WjVX4WERmfIeaDrAOWjVbrfLppL+kyK
	kkMhn04RixCN2VCA==
To: Markus =?utf-8?Q?Bl=C3=B6chl?= <Markus.Bloechl@ipetronik.com>, John
 Stultz
 <jstultz@google.com>
Cc: "Christopher S. Hall" <christopher.s.hall@intel.com>, Lakshmi Sowjanya D
 <lakshmi.sowjanya.d@intel.com>, Stephen Boyd <sboyd@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] timekeeping: Always initialize use_nsecs when querying
 time from phc drivers
In-Reply-To: <6rweov4mf5z7sy4k3sfhktko3qt2cj5jgo3y4hvexjtykdlgj7@7tomywnjtlio>
References: <txyrr26hxe3xpq3ebqb5ewkgvhvp7xalotaouwludjtjifnah2@7tmgczln4aoo>
 <CANDhNCoRZOs0qNdJqUF=5RBWP0MCCC_4zbvvftzNWwvuX087xA@mail.gmail.com>
 <6rweov4mf5z7sy4k3sfhktko3qt2cj5jgo3y4hvexjtykdlgj7@7tomywnjtlio>
Date: Fri, 18 Jul 2025 22:25:12 +0200
Message-ID: <87a551w8k7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09 2025 at 10:32, Markus Bl=C3=B6chl wrote:
> On Tue, Jul 08, 2025 at 12:09:40PM -0700, John Stultz wrote:
>> On Tue, Jul 8, 2025 at 9:46=E2=80=AFAM Markus Bl=C3=B6chl
>> <markus.bloechl@ipetronik.com> wrote:
>> >
>> > diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
>> > index a009c91f7b05..be0da807329f 100644
>> > --- a/kernel/time/timekeeping.c
>> > +++ b/kernel/time/timekeeping.c
>> > @@ -1269,6 +1269,8 @@ int get_device_system_crosststamp(int (*get_time=
_fn)
>> >
>> >         do {
>> >                 seq =3D read_seqcount_begin(&tk_core.seq);
>> > +               system_counterval.use_nsecs =3D false;
>> > +
>>
>> So if the argument is the local system_counterval structure isn't
>> being fully initialized by the get_time_fn() functions it is passed
>> to, it seems like it would be better to do so at the top of
>> get_device_system_crosststamp(), and not inside the seqloop.
>
> Probably, I was just afraid of the case where get_time_fn() would take
> like *very* different paths during different iterations.
> But that seems really unlikely, indeed.

It's impossible. xtstamp->device and the related get_time_fn() are
immutable during the call.

>> But having the responsibility to initialize/fill in the structure
>> being split across the core and the implementation logic (leaving some
>> of the fields as optional) feels prone to mistakes, so it makes me
>> wonder if those drivers implementing the get_time_fn() really ought to
>> fully fill out the structure, and thus the fix would be better done in
>> those drivers.
>
> Yes, they should.

No, they should not.

The data structure is instantiated in get_device_system_crosststamp()
and then handed in un-initialized to get_time_fn(), which is wrong to
begin with. Why?

That means if the structure is ever expanded, then you'd have to fix up
all of the get_time_fn() implementations.

Seriously?

The obviously correct and future proof thing to do is:

-	struct system_counterval_t system_counterval;
+	struct system_counterval_t system_counterval =3D { };

Which fixes the problem you discovered once and forever, no?

Thanks,

        tglx

