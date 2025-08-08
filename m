Return-Path: <linux-kernel+bounces-759972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C63BB1E51F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F5C1643FD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626BB26B2DA;
	Fri,  8 Aug 2025 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vz4EJl6N"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B38425CC42
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643415; cv=none; b=nj2xzvCy0T3qw2fNtG++sVs2C4qap7X4q/Tvp823+60M8jcxLqPHCXm+ThPSXjHH9M54PCdp11fVbzJF7+73IHqfhHTyN2UzieA6pTdraXfioaNM29/sY9+9w/G7eI8wPNDoTcLHbKHeOLdvtqBtyhe1om0nnV3oMAWLoIEM32Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643415; c=relaxed/simple;
	bh=AvUJvGV6k1Y0yxMfq2do+BEGAQPPDxM3RqtsjtneEv0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W5vdk/JlMOk3/Kf2zthzc0IGAtvcmxdlrBCS7CBnysPGVZ3v09VF4nRU1eRoqWgx/tO/42Z/ONEmjMCXolSpfdeqmVZPQ4C36uNzNVzf2+27iPOax598vzeAnhEctvEzsa5laoDC9mLhonDya5ALCNj1Q2FyWxWtmb02QKdb31w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vz4EJl6N; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-458c0c8d169so9532095e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 01:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754643412; x=1755248212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ueZ2gWJlbQvRxrR+aVYA4nsQ6QTJQxWiKvR+t21yTQ=;
        b=vz4EJl6Nc3EwTzbWFsqerOEjnto1aROuWw/VyfGx5hoJ9q7ncF1veSsAdgGCW0n5Zv
         uMsTVnJrxGkxlAyCSSncc/fQquaFcfzdk2lsALcgY43YIYP3nN0F8TZKxB9z3RJq8QZC
         o0X12ybOEHhKEsox9BcUjZKZMZ2y6zoFBxbHHa+tlop3XCb1baZaFrBO1f59zH52jPL3
         P0ADbvahaIBQuBnNeuEZbsW62FQbhxxLD0I1nhizdBKuFunRzF8lRDt6qCSZwJJ+dfAa
         5/5RuBxq597Pv1G0g0WUnCkLCLmpJ+6kavoHPSEsgFfTVEgW3qSLwH+wM9y8qFQ9jcoG
         zpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643412; x=1755248212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ueZ2gWJlbQvRxrR+aVYA4nsQ6QTJQxWiKvR+t21yTQ=;
        b=RkzZY0H2bB7dKA5WHFNjcT/n/CU1DYR3nV0/6R9/0e0PDK2MEMzJPaiusQAhMd5YVy
         jSv2ruSD4mhvGysqcMwblOLztRzPoyR2O3p2jfjr8ZypU4d0C+DBwG8ZoSx+E9c4KGjo
         yS2z00UO+SSHZH3LchVkB+L9xuhI7lVxn2Iqttfx4SBo9GCyVFbGPKIZvGM4U57vGdq5
         k0ZQfjxPwsoguZMiK9x0it5QUYhXx7B5ea9Yfaa69IMpXf+H0giz1MhlgdR05+d8jkLb
         iBBHIiK9Ykoq8mHg/S4mFnPT+asDjHIgHoYQRir8aLLEhDFY7OOfYT7Pe4Sg8QplGVjU
         lyMw==
X-Forwarded-Encrypted: i=1; AJvYcCUZWMwOqxHsoEzjzM6pZOTrpO9A+EK/JcSOgO/qlTY0fqEjhLHvJPKSs2NJaN25heJPv0UM77HNi2+2VSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0HnkbTSzakxLahaIy0YZMt4d2NX6yTA9EHfRxNJNW+iwQMFGT
	eEk0s/tShPDAaXf8uTOIqZG25PcrmjwoiFKcpzqGKaavgIbzPESO0qS7chFTuYbN+HGUCf0oqVm
	h6Ek8xodZCD4dX7dYPA==
X-Google-Smtp-Source: AGHT+IET1DdJb5Jz5G6vVLd0YVDZI+QgAZD0cOx2t4RsN8WWzMVeQsfkD8X4H0cSdsj0IbkyiAcmX8uUm/kCnxw=
X-Received: from wmsr17.prod.google.com ([2002:a05:600c:8b11:b0:458:715c:51a1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3103:b0:456:28f4:a576 with SMTP id 5b1f17b1804b1-459f4f2badbmr17332435e9.27.1754643411897;
 Fri, 08 Aug 2025 01:56:51 -0700 (PDT)
Date: Fri, 8 Aug 2025 08:56:50 +0000
In-Reply-To: <DBWUBK3RSCMB.F1FJ5V6NCOJU@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807190649.3078875-1-lyude@redhat.com> <20250807190649.3078875-2-lyude@redhat.com>
 <DBWUBK3RSCMB.F1FJ5V6NCOJU@kernel.org>
Message-ID: <aJW70pW5zVTPSrdj@google.com>
Subject: Re: [PATCH v2 2/2] rust: time: Implement basic arithmetic operations
 for Delta
From: Alice Ryhl <aliceryhl@google.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Fri, Aug 08, 2025 at 08:42:30AM +0200, Benno Lossin wrote:
> On Thu Aug 7, 2025 at 9:06 PM CEST, Lyude Paul wrote:
> > While rvkms is only going to be using a few of these, since Deltas are
> > basically the same as i64 it's easy enough to just implement all of the
> > basic arithmetic operations for Delta types.
> >
> > Keep in mind there's one quirk here - the kernel has no support for
> > i64 % i64 on 32 bit platforms, the closest we have is i64 % i32 through
> > div_s64_rem(). So, instead of implementing ops::Rem or ops::RemAssign we
> > simply provide Delta::rem_nanos().
> 
> We could still provide the trait implementations on CONFIG_64BIT? WDYT?
> 
> > +impl ops::Div for Delta {
> > +    type Output = Self;
> > +
> > +    #[inline]
> > +    fn div(self, rhs: Self) -> Self::Output {
> > +        #[cfg(CONFIG_64BIT)]
> > +        {
> 
> This pattern seems to be rather common in this patchset & in general I
> think I've also seen it elsewhere. We should think about adding a
> `if_cfg!` macro:
> 
>     Self {
>         nanos: if_cfg! {
>             if CONFIG_64BIT {
>                 self.nanos / rhs.nanos
>             } else {
>                 unsafe { ... }
>             }
>         },
>     }
> 
> But we can do that later. I'll file a good-first-issue.

This kind of macro breaks rustfmt, so I wouldn't recommend it. I would
suggest just using the native Rust pattern rather than introduce even
more macros.

Alice

