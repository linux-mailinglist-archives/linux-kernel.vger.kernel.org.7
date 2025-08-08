Return-Path: <linux-kernel+bounces-760733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6EEB1EF5F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 22:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA6617F555
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A446230981;
	Fri,  8 Aug 2025 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kvl5RbfS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B983D186E2D;
	Fri,  8 Aug 2025 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754684501; cv=none; b=AHp3xEVdrJ+Oa+m82gHZpO7NcreRsZNo2gJFN2ajFQ/3NSHWqiGAjRbd95jIuEAMd93h4d+jVRBKOmSxcTU3C/x2Cabx7mq2U4SFc3djFoF4wzA3TNqLg8Mi5qIwjT9mL0q+GfSUUiAKoT0i2g4+driP/pmBWlYAZsdg2CC3eh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754684501; c=relaxed/simple;
	bh=R8oG58Z481rL+wJgJ81k7mSvjv7QsSdJBB8O91oeHRM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=If1i14wrzw+Zo+71TovGQur0cBuDtjU5T81hDurIZd/LtmOPTyIYcGXKHcmJTBFyNFdVF2yCnv4xKFZ3OSDHgaa3HalX43iR/TzHXwaNhGkIP7YFkgsSRZVtHSDyfy/SNZdpKZWDiDDVNz5T9ZfarBVJjcQSlE+pEvDpZanEjTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kvl5RbfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13DBC4CEED;
	Fri,  8 Aug 2025 20:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754684501;
	bh=R8oG58Z481rL+wJgJ81k7mSvjv7QsSdJBB8O91oeHRM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Kvl5RbfSpqyiiVHewCSmgJkOP2uYeyTKwa0yCyEj5OwtmZCGEU9WI4Pdw3Frp5Qk7
	 CM3F5MvNMwdd0ZLZY9/A9QlGhnoAcv8FhoHKmFZNVR/KaD5j9aWslVXDN6MPf4XhgY
	 JcN4hvNr7T4A5jOWHDg9NIM9zMYa/FuhoKfX2AOOFvdcCYb5EtUIG+/TNDtPZ+w8UK
	 hFvf6hWl0/sLH85JzJx04TJLACciMeb5S9ZCMH3mcR/E4wM6sBM6wGrqMOZsAP8iIs
	 jku+xILiSV9ryI7YDNjBAJbysuWMeOolmubQgzOyT+ahbNrsShDDJUC2UA8Jsfq7R1
	 Af94KvOK5N/7w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 Aug 2025 22:21:35 +0200
Message-Id: <DBXBQP6IAQNQ.ZOW1WR7T66A8@kernel.org>
Cc: "Lyude Paul" <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Frederic Weisbecker" <frederic@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>, "John Stultz" <jstultz@google.com>, "Stephen
 Boyd" <sboyd@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/2] rust: time: Implement basic arithmetic
 operations for Delta
From: "Benno Lossin" <lossin@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
X-Mailer: aerc 0.20.1
References: <20250807190649.3078875-1-lyude@redhat.com>
 <20250807190649.3078875-2-lyude@redhat.com>
 <DBWUBK3RSCMB.F1FJ5V6NCOJU@kernel.org> <aJW70pW5zVTPSrdj@google.com>
In-Reply-To: <aJW70pW5zVTPSrdj@google.com>

On Fri Aug 8, 2025 at 10:56 AM CEST, Alice Ryhl wrote:
> On Fri, Aug 08, 2025 at 08:42:30AM +0200, Benno Lossin wrote:
>> On Thu Aug 7, 2025 at 9:06 PM CEST, Lyude Paul wrote:
>> > While rvkms is only going to be using a few of these, since Deltas are
>> > basically the same as i64 it's easy enough to just implement all of th=
e
>> > basic arithmetic operations for Delta types.
>> >
>> > Keep in mind there's one quirk here - the kernel has no support for
>> > i64 % i64 on 32 bit platforms, the closest we have is i64 % i32 throug=
h
>> > div_s64_rem(). So, instead of implementing ops::Rem or ops::RemAssign =
we
>> > simply provide Delta::rem_nanos().
>>=20
>> We could still provide the trait implementations on CONFIG_64BIT? WDYT?
>>=20
>> > +impl ops::Div for Delta {
>> > +    type Output =3D Self;
>> > +
>> > +    #[inline]
>> > +    fn div(self, rhs: Self) -> Self::Output {
>> > +        #[cfg(CONFIG_64BIT)]
>> > +        {
>>=20
>> This pattern seems to be rather common in this patchset & in general I
>> think I've also seen it elsewhere. We should think about adding a
>> `if_cfg!` macro:
>>=20
>>     Self {
>>         nanos: if_cfg! {
>>             if CONFIG_64BIT {
>>                 self.nanos / rhs.nanos
>>             } else {
>>                 unsafe { ... }
>>             }
>>         },
>>     }
>>=20
>> But we can do that later. I'll file a good-first-issue.
>
> This kind of macro breaks rustfmt, so I wouldn't recommend it.

Ah then just use `if_cfg!(...)` that should work.

> I would suggest just using the native Rust pattern rather than
> introduce even more macros.

Trevor showed me https://github.com/rust-lang/rust/issues/115585, so we
can use that in the future. I still think the macro is useful though.

---
Cheers,
Benno

