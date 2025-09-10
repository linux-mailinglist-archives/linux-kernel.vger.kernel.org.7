Return-Path: <linux-kernel+bounces-810535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2D0B51C00
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C099188767E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851C0327A00;
	Wed, 10 Sep 2025 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMt59hWx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D818426F2B0;
	Wed, 10 Sep 2025 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518779; cv=none; b=DzCU/2dR0NiR7mXVwgO4l/u7yV9rBTOsVOm0VYzzqwhlRW+gl+8fYC9beBIrHgBFV687nltaW/7Qio/IfuC8Mr9mVvE4kbxIeAsksBGH1gTc10GBZpwdCLYXu++IAYYlxTjwDgVlevg7DgGEMKSrv2VXdIIy8bcKHDi9Tu/cUeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518779; c=relaxed/simple;
	bh=yUDdS/kuvrozQGLQ5U1rfQ0M4SPbUZSrG694a+5B/Qk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ghK3oj/I+OE2CjxX6XQR+1Lqyl+nW26Ef2LIkAi+NiEitZED+EpLps4sGIiRlDfheLPMk20KYDLDfCrBYoHYmOqcBPoKOo02MqujM/LO7daGZNgdrCn4lEO0ESeUw/aUWeqB5dCXhqpqrUpN8cBdDKLvgXmAla9od5SSh5VyrmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMt59hWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3503C4CEF7;
	Wed, 10 Sep 2025 15:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757518779;
	bh=yUDdS/kuvrozQGLQ5U1rfQ0M4SPbUZSrG694a+5B/Qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SMt59hWxE4DAiEWQ2LyGmBT1g9X4q51DD+ii+z0vGAQN/r3XzJ2MUKsQCqW4UvhI1
	 q6fy0a8tnE2hyVuSJpefhBaFfYD4iC0wombfDnp3hYD6zvaoybQ7pxcIYfkIMNxC9v
	 yLfIX9rffkNKP3JJdeO3akm2u3hMdeeJCtDEmFdA9UPK8EKmRo1Tkr9/7tb/g+652J
	 9MnBzITvmBQE/YkT7iO8iPCYw6qt0osAvJ45tLmIYKJS/hyjjXEkD5SYhetTKyelu8
	 uXqUB7jyn996I0omfV1+Kz2XXhy1r9EyWNTYrXSWfeq7l97/ni8oTcr1sR6ShMycHw
	 NCNQreXn9NNtA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 17:39:34 +0200
Message-Id: <DCP8ER16H0AF.2FF0F9922SS0@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Fiona Behrens" <me@kloenk.dev>, "Alban Kurti" <kurti@invicto.ai>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rust: pin-init: add `#[bind]` attribute to access
 previously initialized fields
X-Mailer: aerc 0.20.1
References: <20250910100755.2361281-1-lossin@kernel.org>
 <aMFQL-Hq1KvBG5lh@google.com> <DCP1Y8N4SRRF.25V7F6PV5ODCQ@kernel.org>
 <CAH5fLgg+-oz_cP9=ke+ukp9qYZAsD=hKqvvGfkJWRcCKdrTQ-g@mail.gmail.com>
 <DCP456FHT625.1L5BVZ4LPD8VQ@kernel.org> <aMGE64_J5R8U_rk5@tardis-2.local>
 <DCP7JTWPA4QS.9PTE12UVZFDC@kernel.org> <aMGT6h5yIcpR3mCg@tardis-2.local>
In-Reply-To: <aMGT6h5yIcpR3mCg@tardis-2.local>

On Wed Sep 10, 2025 at 5:06 PM CEST, Boqun Feng wrote:
> On Wed, Sep 10, 2025 at 04:59:11PM +0200, Benno Lossin wrote:
>> On Wed Sep 10, 2025 at 4:02 PM CEST, Boqun Feng wrote:
>> > On Wed, Sep 10, 2025 at 02:19:00PM +0200, Benno Lossin wrote:
>> >> On Wed Sep 10, 2025 at 12:40 PM CEST, Alice Ryhl wrote:
>> >> > On Wed, Sep 10, 2025 at 12:36=E2=80=AFPM Benno Lossin <lossin@kerne=
l.org> wrote:
>> >> >>
>> >> >> On Wed Sep 10, 2025 at 12:17 PM CEST, Alice Ryhl wrote:
>> >> >> > On Wed, Sep 10, 2025 at 12:07:53PM +0200, Benno Lossin wrote:
>> >> >> >> Assigning a field a value in an initializer macro can be marked=
 with the
>> >> >> >> `#[bind]` attribute. Doing so creates a `let` binding with the =
same
>> >> >> >> name. This `let` binding has the type `Pin<&mut T>` if the fiel=
d is
>> >> >> >> structurally pinned or `&mut T` otherwise (where `T` is the typ=
e of the
>> >> >> >> field).
>> >> >> >>
>> >> >> >> Signed-off-by: Benno Lossin <lossin@kernel.org>
>> >> >> >
>> >> >> > Is there a reason we can't apply this to all fields and avoid th=
e
>> >> >> > attribute?
>> >> >>
>> >> >> Adding the attribute was due to Boqun's concern on v1 [1]. I think=
 it
>> >> >> might be surprising too, but I'm also happy with no attribute.
>> >> >>
>> >> >> [1]: https://lore.kernel.org/all/aLshd0_C-1rh3FAg@tardis-2.local
>> >> >
>> >> > IMO the ideal is if it works without an attribute. Perhaps trying t=
hat
>> >> > in the kernel is a reasonable experiment to find out whether that's
>> >> > reasonable to do for the general language feature?
>> >>=20
>> >> @Boqun what is your opinion on this?
>> >>=20
>> >
>> > If we plan to make the in-place initializer language feature behave
>> > similar, as I asked here [1], then dropping `#[bind]` seems good to me=
.
>>=20
>> I don't think we can promise how that language feature is going to look
>> like. It will definitely support accessing already initialized fields,
>> but in what form remains to be seen.
>>=20
>
> Sure, but in kernel we are able to stay the same as whatever the
> language feature will be like, right?

Yes :)

> In other words, as long as we propose the same thing to the language
> feature and keep kernel code and language feature synced (presumbly
> there could be some more discussion on the syntax when presented to Rust
> commmunity), then I'm think it's fine.

I'll take v1 (with the in-tree fixes) then. Do you mind giving your RB
for that one? Thanks!

---
Cheers,
Benno

