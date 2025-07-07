Return-Path: <linux-kernel+bounces-720336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA76AFBA6F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B71FF7B223C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73AB264613;
	Mon,  7 Jul 2025 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="nZAar/rj"
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5712309B9;
	Mon,  7 Jul 2025 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911993; cv=none; b=p71u+RKL8tq1IeNZ8L1msCBpT3bmV4gPFwgmeYgdWRos87iXvmdv4/dJSmWCANxt3rJv7GNVZ/JwsxumISPE5u1Vnx+lOQ7rhW3IZ1/IxA7JUHS8G1PJkACeP+0sGkzPI+tcIJWQ+Pf3E9mHcrThCZbheunrVLXQEio7kAXW640=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911993; c=relaxed/simple;
	bh=rFRYYJCIP2ryuFx0qAi9QitjGiV8aohMxO9S2W7Ms9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YL/Ik2SP5rt8ypSmtPIsGdqjN4UPL0CRtHJmnjDSd2ae7lnkvbKm0s+X5m6LmOJ1SkBd+2UMSmy9Vh48jagUNoASpe99sE0tqEMIfj043fUoBYJoCKpRBS2OGNxNc9fcJdM5HZnG/PoDBG0SWV+P1/0mucCsNaPjE2EG0y2J8Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=nZAar/rj; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:8a4:0:640:a4f2:0])
	by forward500d.mail.yandex.net (Yandex) with ESMTPS id B67F861D27;
	Mon,  7 Jul 2025 21:06:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id F6lUCgVL4qM0-JMKnurqm;
	Mon, 07 Jul 2025 21:06:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751911579;
	bh=BL4Skkx8wifOW4HnWAlWTXl2lbukdzEWszDYvbFdpU0=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=nZAar/rjLQF+WBjWro07jAeTTFhcz06dmbQbDR7PiqXXJGyN4KvFKgpjpBMYQjqxq
	 Ly0b2cbhdise9Fq05+Bs5pnTt0TBE8dPDMK+AWmxt7zK0XFJFKS3mSiXtcj3PCjv9H
	 Mit+nLcxK+UiKOrOY13tlRVVRFluRoM0hMbIarWM=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Mon, 7 Jul 2025 21:06:13 +0300
From: Onur <work@onurozkan.dev>
To: "Benno Lossin" <lossin@kernel.org>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <gary@garyguo.net>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
 <longman@redhat.com>, <felipe_life@live.com>, <daniel@sedlak.dev>,
 <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v5 2/3] implement ww_mutex abstraction for the Rust tree
Message-ID: <20250707210613.2fd5bb55@nimda.home>
In-Reply-To: <DB5XIWGZ8U36.1VB58YBJFL7OT@kernel.org>
References: <20250621184454.8354-1-work@onurozkan.dev>
	<20250621184454.8354-3-work@onurozkan.dev>
	<DASY7BECFRCT.332X5ZHZMV2W@kernel.org>
	<aFlQ7K_mYYbrG8Cl@Mac.home>
	<DATYHYJVPL3L.3NLMH7PPHYU9@kernel.org>
	<aFlpFQ4ivKw81d-y@Mac.home>
	<DAU0ELV91E2Q.35FZOII18W44J@kernel.org>
	<20250707163913.5ffc046d@nimda.home>
	<DB5XIWGZ8U36.1VB58YBJFL7OT@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Jul 2025 17:31:10 +0200
"Benno Lossin" <lossin@kernel.org> wrote:

> On Mon Jul 7, 2025 at 3:39 PM CEST, Onur wrote:
> > On Mon, 23 Jun 2025 17:14:37 +0200
> > "Benno Lossin" <lossin@kernel.org> wrote:
> >
> >> > We also need to take into consideration that the user want to
> >> > drop any lock in the sequence? E.g. the user acquires a, b and
> >> > c, and then drop b, and then acquires d. Which I think is
> >> > possible for ww_mutex.
> >> 
> >> Hmm what about adding this to the above idea?:
> >> 
> >>     impl<'a, Locks> WwActiveCtx<'a, Locks>
> >>     where
> >>         Locks: Tuple
> >>     {
> >>         fn custom<L2>(self, action: impl FnOnce(Locks) -> L2) ->
> >> WwActiveCtx<'a, L2>; }
> >> 
> >> Then you can do:
> >> 
> >>     let (a, c, d) = ctx.begin()
> >>         .lock(a)
> >>         .lock(b)
> >>         .lock(c)
> >>         .custom(|(a, _, c)| (a, c))
> >>         .lock(d)
> >>         .finish();
> >
> >
> > Instead of `begin` and `custom`, why not something like this:
> >
> > 	let (a, c, d) = ctx.init()
> > 	    .lock(a)
> >             .lock(b)
> >             .lock(c)
> >             .unlock(b)
> >             .lock(d)
> >             .finish();
> >
> > Instead of `begin`, `init` would be better naming to imply `fini`
> > on the C side, and `unlock` instead of `custom` would make the
> > intent clearer when dropping locks mid chain.
> 
> I don't think that this `unlock` operation will work. How would you
> implement it?


We could link mutexes to locks using some unique value, so that we can
access locks by passing mutexes (though that sounds a bit odd).

Another option would be to unlock by the index, e.g.,:

	let (a, c) = ctx.init()
	    .lock(a)
            .lock(b)
            .unlock::<1>()
            .lock(c)
            .finish();

The index approach would require us to write something very similar
to `Tuple` (with macro obviously) you proposed sometime ago.

We could also just go back to your `custom` but find a better name
for it (such as `retain`).

Regards,
Onur


