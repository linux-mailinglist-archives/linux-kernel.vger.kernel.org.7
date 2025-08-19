Return-Path: <linux-kernel+bounces-776331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9542B2CC03
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8966B523825
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260E620B80B;
	Tue, 19 Aug 2025 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCgRNwsa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721E230F806;
	Tue, 19 Aug 2025 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628148; cv=none; b=SoZidyFrcQwmQNYqvk8JQRv9/ey8WwK6GRc5xwGTKoLw/OPD/ikvn4Y6425CdUsy69aPjH3QZ/W6tm879lkBTA+QHRUnd3dV5fuBxXrahxX0h8UkrmO40TazEdGKNJHNldV9NbIBtU60GjwtTDRYe4/tBdo+9Bx6bqS6jde9sls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628148; c=relaxed/simple;
	bh=0PVyGpkvyeNsFdkiKWEVNDYAhc7GqDEfCv0tINKPntw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uYR6nd9kN9h3I8Z35Wv4X5RzZIJF/sr+7daGRItQBAjBg2EuMI0/n3Hu09Fh4GR0q2q+0gaFJiftXkF5O9c2MCLfWSHVyH/kq6okD97f2ot9faremKVrpcol4VTcDOuNStUw2AADofyUz+L11rYiOscOiwhM2gB/q81wSnMJzg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCgRNwsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B134DC16AAE;
	Tue, 19 Aug 2025 18:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755628148;
	bh=0PVyGpkvyeNsFdkiKWEVNDYAhc7GqDEfCv0tINKPntw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rCgRNwsaes/rMHIcQXpV4dq32KlKygD0sbbGYUrwIllPKvFhBIub5GQzc6O03HXp6
	 gPMvIHFmcDnta/NedoPWXMjrypjoMY/i0HzqvAUTDt4YGChtzr9bK5QqLK7t7KGvHp
	 /EN36bfvPqrY4tPWXByleg6Q7A4Zt+EQ8v/B6X8qinZkVl6ZfFIo5qUILag27EZU20
	 a+tWwLayRl9l37rjnOgzdsAYljQPL8+NxCZTmPpaOe8rGS5U9jE7ASh1y+gCRWvBP/
	 9oUgD11MYCQhyCTXV+W86SSqm+kQBtc8sQEAEHAc0FzkNlNX+SEcpkeBukyO/waa/B
	 O8msJYEAEMvcQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Benno Lossin <lossin@kernel.org>, Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>,
 Trevor
 Gross <tmgross@umich.edu>, Asahi Lina <lina+kernel@asahilina.net>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
In-Reply-To: <DC6KN0JN4X4D.1PHXPQ46O5J1Q@kernel.org>
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
 <2OkNj7ab-vTaPaqMj_KRpIjaKTWgOW-F9Cn-CxnR12E6Dwg4lnjr6fx1vkjnoTx0boUeReeIVDbSyVFBWlYx7g==@protonmail.internalid>
 <20250618-unique-ref-v11-1-49eadcdc0aa6@pm.me>
 <87o6scdchf.fsf@t14s.mail-host-address-is-not-set>
 <aKMkvHAfDozzDjkB@mango> <DC5WOFIKX7VQ.30UNUNE37LOO5@kernel.org>
 <aKQT92ViZSL841rT@mango>
 <iQ0qeYmzFSlOQkNLti-a4Z6ItwaZgh3r8Pqdu5rSwYz4wUxAsKZJlGCrsVQ481Qkzc9EapD3bzKKtrsXVkwt2A==@protonmail.internalid>
 <DC69F17AFLB2.1KZ8JJUIH2CSP@kernel.org>
 <87ldnfd766.fsf@t14s.mail-host-address-is-not-set>
 <SrUs3F3lvGkO0K2cL7_oyXD0qqPQ2CXsCkNBQz5JQ2BozT8sCdqfzzZ1fLt2gyUUpLgLD5LC2jvbkd9ncNtvQg==@protonmail.internalid>
 <DC6KN0JN4X4D.1PHXPQ46O5J1Q@kernel.org>
Date: Tue, 19 Aug 2025 20:28:56 +0200
Message-ID: <87bjobcgif.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Benno Lossin" <lossin@kernel.org> writes:

> On Tue Aug 19, 2025 at 10:53 AM CEST, Andreas Hindborg wrote:
>> "Benno Lossin" <lossin@kernel.org> writes:
>>> On Tue Aug 19, 2025 at 8:04 AM CEST, Oliver Mangold wrote:
>>>> On 250819 0027, Benno Lossin wrote:
>>>>> On Mon Aug 18, 2025 at 3:04 PM CEST, Oliver Mangold wrote:
>>>>> > On 250818 1446, Andreas Hindborg wrote:
>>>>> >> "Oliver Mangold" <oliver.mangold@pm.me> writes:
>>>>> >> > +impl<T: OwnableMut> DerefMut for Owned<T> {
>>>>> >> > +    fn deref_mut(&mut self) -> &mut Self::Target {
>>>>> >> > +        // SAFETY: The type invariants guarantee that the objec=
t is valid, and that we can safely
>>>>> >> > +        // return a mutable reference to it.
>>>>> >> > +        unsafe { self.ptr.as_mut() }
>>>>> >> > +    }
>>>>> >> > +}
>>>>> >>
>>>>> >> I think someone mentioned this before, but handing out mutable
>>>>> >> references can be a problem if `T: !Unpin`. For instance, we don't=
 want
>>>>> >> to hand out `&mut Page` in case of `Owned<Page>`.
>>>>> >>
>>>>> >
>>>>> > That was the reason, why `OwnableMut` was introduced in the first p=
lace.
>>>>> > It's clear, I guess, that as-is it cannot be implemented on many cl=
asses.
>>>>>
>>>>> Yeah the safety requirements ensure that you can't implement it on
>>>>> `!Unpin` types.
>>>>>
>>>>> But I'm not sure it's useful then? As you said there aren't many types
>>>>> that will implement the type then, so how about we change the meaning
>>>>> and make it give out a pinned mutable reference instead?
>>>>
>>>> Making `deref_mut()` give out a pinned type won't work. The return typ=
es of
>>>> deref() are required to match.
>>>
>>> I meant the changes that Andreas suggested.
>>
>> Not sure what you are asking, but I need to assert exclusive access to
>> an `Page`. I could either get this by taking a `&mut Owned<Page>` or a
>> `Pin<&mut Page>`. I think the latter is more agnostic.
>
> The former isn't really correct? It's like having a `&mut Box<Page>`
> which is weird. I was saying we can have a `DerefMut` impl gated on `T:
> Unpin` and a `fn get_pin_mut(&mut self) -> Pin<&mut T>`.
>
>>>>> > Good question, I have been thinking about it, too. But it might
>>>>> > be, that it isn't needed at all. As I understand, usually Rust wrap=
pers
>>>>> > are around non-movable C structs. Do we actually have a useful appl=
ication
>>>>> > for OwnableMut?
>>>>>
>>>>> Also, do we even need two different traits? Which types would only
>>>>> implement `Ownable` but not `OwnableMut`?
>>>>
>>>> I'm not 100% sure, but on a quick glance it looks indeed be safe to
>>>> substitute `OwnableMut` by `Unpin`.
>>>
>>> We just have to change the safety requirements of `OwnableMut`.
>>
>> `OwnableMut` already requires `Unpin`, it just does not say so directly:
>>
>>
>> /// - It is safe to call [`core::mem::swap`] on the [`Ownable`]. This ex=
cludes pinned types
>> ///   (i.e. most kernel types).
>>
>> We could remove this and then just add a trait bound on `Unpin`.
>
> Oh I happened to not have read it that thoroughly then... I don't think
> it makes sense to have `OwnableMut` then. So I agree with your suggested
> change :)
>
>>>> If we add `get_pin_mut(&mut self) -> Pin<&mut T>` as Andreas suggested,
>>>> it would be possible to obtain an `&mut T` anyway, then, if T is `Unpi=
n`.
>>>
>>> Well the `DerefMut` impl still is convenient in the `Unpin` case.
>>
>> `OwnableMut` is probably not that useful, since all the types we want to
>> implement `Ownable` for is `!Unpin`. We could remove it, but I felt it
>> was neat to add the `DerefMut` impl for `Unpin` types.
>
> But we don't need `OwnableMut` in that case?

Right, we can directly limit the `DerefMut` impl.

>
> Let's just do the following if it makes sense:
> * remove `OwnableMut`
> * allow obtaining a `Pin<&mut T>` from `Owned<T>` via a `&mut self`
>   method (we need a new safety requirement for this on `Ownable`)
> * have the `DerefMut` impl require `T: Unpin`

Sounds good to me =F0=9F=91=8D


Best regards,
Andreas Hindborg



