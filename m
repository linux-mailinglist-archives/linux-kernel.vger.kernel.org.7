Return-Path: <linux-kernel+bounces-775749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED33DB2C488
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90800724643
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2B1340D80;
	Tue, 19 Aug 2025 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dx8gHTLS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A1933EB09;
	Tue, 19 Aug 2025 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608306; cv=none; b=JZvOh8iAsQgfupqsXvyg1wNqB/FpCDPw4F53irZ20L8O+kGpEm84k4duCJOYc3w5SRcqubm+B6TcmeBTa3vgSVoVZVnF4CIoybKCX0a7OELLvZCRLH9UZjJ54awXmUYVu9bRcZ8rPt85WluBn5cttJJDeq+JxtVaHfhJEYr/VgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608306; c=relaxed/simple;
	bh=4DO3dYAOM5pTDmnI1hLhVydMIin2dEAMrChEU5JifQg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=Q+LyDRwo4C9QW44RkNnhdM3klNzsSCtPYrN6nXDRygu/E6N2KpVTwL4bZBWCOmshQTV1Q7RllECQ51BeyPQwAkPfr15f+mqtXtnDjLicr8dhPjP/6Gc8A8pcQp2yVsYY+XHonF5PYyhNq5IMBN1vcdbLGCYfBKIGNT315XiW00U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dx8gHTLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242C1C113D0;
	Tue, 19 Aug 2025 12:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755608306;
	bh=4DO3dYAOM5pTDmnI1hLhVydMIin2dEAMrChEU5JifQg=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=dx8gHTLSmdApS+hHpltE88MUhCsHHt1MRH532v/ggxPXGNIWWPmnn/3FfBveGOq6f
	 JNIkdDaQIkQsMJi2L69hCyXyNHHN8R9TDex52yYrRJXhJdMZhAVyjs44KO41Uoe8SK
	 8iQee498MjVKFcn9D1BfY2h0vS3w+Ar1QPSHP4C9qbXOaL4gEOkj+cSd8O4ZEUH6qL
	 WAodkhxeNDPDG8QfzZlB3YpxYg7f8dQCBSis9kxUWCGoxdxZ6PF9uhJDxjrcp1vvj5
	 Jx4D6THiLj0HdWuh3yV1AWKjldwyz6Ucb6daPp0csYFXX/cwOFID+p3qGED2qE7CGX
	 lLmEip0Lu/Cug==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 14:58:21 +0200
Message-Id: <DC6F7BN2L19O.1APQU9KWZV7H5@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/5] rust: maple_tree: add MapleTree
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Andrew Ballance"
 <andrewjballance@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <maple-tree@lists.infradead.org>,
 <rust-for-linux@vger.kernel.org>, <linux-mm@kvack.org>
To: "Alice Ryhl" <aliceryhl@google.com>
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
 <20250819-maple-tree-v2-2-229b48657bab@google.com>
 <DC6DC244ZIUL.304JSP7JFDE9Z@kernel.org> <aKRx8xsY8CpzbeEm@google.com>
In-Reply-To: <aKRx8xsY8CpzbeEm@google.com>

On Tue Aug 19, 2025 at 2:45 PM CEST, Alice Ryhl wrote:
> On Tue, Aug 19, 2025 at 01:30:30PM +0200, Danilo Krummrich wrote:
>> On Tue Aug 19, 2025 at 12:34 PM CEST, Alice Ryhl wrote:
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index fe168477caa45799dfe07de2f54de6d6a1ce0615..26053163fe5aed2fc4b4e3=
9d47062c93b873ac13 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -16250,7 +16250,9 @@ L:	rust-for-linux@vger.kernel.org
>> >  S:	Maintained
>> >  W:	http://www.linux-mm.org
>> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>> > +F:	rust/helpers/maple_tree.c
>> >  F:	rust/helpers/mm.c
>> > +F:	rust/kernel/maple_tree.rs
>> >  F:	rust/kernel/mm.rs
>> >  F:	rust/kernel/mm/
>>=20
>> A later patch adds a separate entry; is this intended?
>
> Ah, no, this isn't intended.
>
>> > +impl<T: ForeignOwnable> MapleTree<T> {
>> > +    /// Create a new maple tree.
>> > +    ///
>> > +    /// The tree will use the regular implementation with a higher br=
anching factor.
>>=20
>> What do you mean with "regular implementation" and what is "a higher bra=
nching
>> factor" in this context?
>>=20
>> Do you mean that the maple tree has a higher branching factor than a reg=
ular RB
>> tree, or something else?
>
> This is compared to the alloc variant of the maple tree from the last
> patch in this series.

I think it'd be good to mention this. You could add the corresponding comme=
nt
and link when you introduce the type in the subsequent patch.

>> > +    #[inline]
>> > +    pub fn new() -> impl PinInit<Self> {
>> > +        pin_init!(MapleTree {
>> > +            // SAFETY: This initializes a maple tree into a pinned sl=
ot. The maple tree will be
>> > +            // destroyed in Drop before the memory location becomes i=
nvalid.
>> > +            tree <- Opaque::ffi_init(|slot| unsafe { bindings::mt_ini=
t_flags(slot, 0) }),
>> > +            _p: PhantomData,
>> > +        })
>> > +    }
>> > +
>> > +    /// Insert the value at the given index.
>> > +    ///
>> > +    /// If the maple tree already contains a range using the given in=
dex, then this call will fail.
>>=20
>> Maybe add an error section for this?
>>=20
>> > +    ///
>> > +    /// # Examples
>> > +    ///
>> > +    /// ```
>> > +    /// use kernel::maple_tree::{MapleTree, InsertErrorKind};
>> > +    ///
>> > +    /// let tree =3D KBox::pin_init(MapleTree::<KBox<i32>>::new(), GF=
P_KERNEL)?;
>> > +    ///
>> > +    /// let ten =3D KBox::new(10, GFP_KERNEL)?;
>> > +    /// let twenty =3D KBox::new(20, GFP_KERNEL)?;
>> > +    /// let the_answer =3D KBox::new(42, GFP_KERNEL)?;
>> > +    ///
>> > +    /// // These calls will succeed.
>> > +    /// tree.insert(100, ten, GFP_KERNEL)?;
>> > +    /// tree.insert(101, twenty, GFP_KERNEL)?;
>> > +    ///
>> > +    /// // This will fail because the index is already in use.
>> > +    /// assert_eq!(
>> > +    ///     tree.insert(100, the_answer, GFP_KERNEL).unwrap_err().cau=
se,
>>=20
>> A lot of the examples, including the ones in subsequent patches contain =
variants
>> of unwrap().
>>=20
>> I think we should avoid this and instead handle errors gracefully -- eve=
n if it
>> bloats the examples a bit.
>>=20
>> My concern is that it otherwise creates the impression that using unwrap=
() is a
>> reasonable thing to do.
>>=20
>> Especially for people new to the kernel or Rust (or both) it might not b=
e
>> obvious that unwrap() is equivalent to
>>=20
>> 	if (!ret)
>> 		do_something();
>> 	else
>> 		panic();
>>=20
>> or the fact that this is something we should only do as absolute last re=
sort.
>
> How would you write it? The way you write it in normal code is an
> if/else where you handle both cases, but that doesn't map nicely.

I'd just

	assert!(tree.insert(100, the_answer, GFP_KERNEL).is_err());

and if you want to test that the error you'd expect is actually returned, I=
'd
suggest a regular kunit test, rather than a doc-test.

I think doc-tests should mostly illustrate idiomatic usage, especially now =
that
we have good and easily accessible kunit support.

I say "mostly" because I think tests to the degree of where they stay withi=
n
reasonable bounds of illustrating idiomatic usage are fine of course.

