Return-Path: <linux-kernel+bounces-775180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D647B2BC3D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D993B188BFFE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FD2311C38;
	Tue, 19 Aug 2025 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeLCtlwM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFD121ABBB;
	Tue, 19 Aug 2025 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593597; cv=none; b=D2egx55mfBTITAhcN1FncXWVIVXqB7eYWBJjaRjstLrQ758/XkElCEno7EDIEp8xRhaOpJ77HqMbxhZmmigqzFUQrqULxlmq7L486KSERMugW28Ia51LBZSyA7qPI1qVVYqw8QJqSYx5DR9S5ZaHkXUhDfe02AYbmv6Cvbt2Ws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593597; c=relaxed/simple;
	bh=96qLS02pIAXRjyx2OB/KMcSVqS25OHmsXS08TCX2//0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XBvKYX4v+NRKz4KYQLffLZsQN5/SezunbocLtTyv+VOweSNejRuWF35C4f9RVw+0rRzHzFYzGAG7ZtU12wVp0IpHijnhCMAHN8HULoIpbPVCQOYl3BHVlfvKCPkD8ksyd+ny52yk7IPp97p/mMkySZA6v2eg5SmqkYv/7V91cIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeLCtlwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEF6C4CEF1;
	Tue, 19 Aug 2025 08:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755593596;
	bh=96qLS02pIAXRjyx2OB/KMcSVqS25OHmsXS08TCX2//0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UeLCtlwMcBwbyEOix+qMDU6FnGYOeP56No5L9qGxEJWugXJMn2npm6qwfv9XjzGrc
	 MZgktJTOSK4JyXCuXuwN6bHNgV5K7a5urzlGvNTJq21YOwr9T72NUknOQOgiv8+zFF
	 kcR9LsRdDUjgaJKDYGXsSCZt6SN/WUa3+sGF4yivBoy6r4Fwwmzop0ggBeOtetrx0N
	 SrbM5Vr47Oye+RL1TLvg4UcDevdZCA6I3AjnFG9GUYRj/uwoc+R+TdP0sPdyFq5JGm
	 5kznRinmoLrLE8CfNht2teFwepXIGfOE7DczknkJ9Rb98AXt+VmsGqVWGAe2EIr/dO
	 q9TOWnTi7MZZA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Benno Lossin <lossin@kernel.org>, Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina+kernel@asahilina.net>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
In-Reply-To: <DC69F17AFLB2.1KZ8JJUIH2CSP@kernel.org>
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
 <2OkNj7ab-vTaPaqMj_KRpIjaKTWgOW-F9Cn-CxnR12E6Dwg4lnjr6fx1vkjnoTx0boUeReeIVDbSyVFBWlYx7g==@protonmail.internalid>
 <20250618-unique-ref-v11-1-49eadcdc0aa6@pm.me>
 <87o6scdchf.fsf@t14s.mail-host-address-is-not-set>
 <aKMkvHAfDozzDjkB@mango> <DC5WOFIKX7VQ.30UNUNE37LOO5@kernel.org>
 <aKQT92ViZSL841rT@mango>
 <iQ0qeYmzFSlOQkNLti-a4Z6ItwaZgh3r8Pqdu5rSwYz4wUxAsKZJlGCrsVQ481Qkzc9EapD3bzKKtrsXVkwt2A==@protonmail.internalid>
 <DC69F17AFLB2.1KZ8JJUIH2CSP@kernel.org>
Date: Tue, 19 Aug 2025 10:53:05 +0200
Message-ID: <87ldnfd766.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <lossin@kernel.org> writes:

> On Tue Aug 19, 2025 at 8:04 AM CEST, Oliver Mangold wrote:
>> On 250819 0027, Benno Lossin wrote:
>>> On Mon Aug 18, 2025 at 3:04 PM CEST, Oliver Mangold wrote:
>>> > On 250818 1446, Andreas Hindborg wrote:
>>> >> "Oliver Mangold" <oliver.mangold@pm.me> writes:
>>> >> > +impl<T: OwnableMut> DerefMut for Owned<T> {
>>> >> > +    fn deref_mut(&mut self) -> &mut Self::Target {
>>> >> > +        // SAFETY: The type invariants guarantee that the object is valid, and that we can safely
>>> >> > +        // return a mutable reference to it.
>>> >> > +        unsafe { self.ptr.as_mut() }
>>> >> > +    }
>>> >> > +}
>>> >>
>>> >> I think someone mentioned this before, but handing out mutable
>>> >> references can be a problem if `T: !Unpin`. For instance, we don't want
>>> >> to hand out `&mut Page` in case of `Owned<Page>`.
>>> >>
>>> >
>>> > That was the reason, why `OwnableMut` was introduced in the first place.
>>> > It's clear, I guess, that as-is it cannot be implemented on many classes.
>>>
>>> Yeah the safety requirements ensure that you can't implement it on
>>> `!Unpin` types.
>>>
>>> But I'm not sure it's useful then? As you said there aren't many types
>>> that will implement the type then, so how about we change the meaning
>>> and make it give out a pinned mutable reference instead?
>>
>> Making `deref_mut()` give out a pinned type won't work. The return types of
>> deref() are required to match.
>
> I meant the changes that Andreas suggested.

Not sure what you are asking, but I need to assert exclusive access to
an `Page`. I could either get this by taking a `&mut Owned<Page>` or a
`Pin<&mut Page>`. I think the latter is more agnostic.

>
>>> > Good question, I have been thinking about it, too. But it might
>>> > be, that it isn't needed at all. As I understand, usually Rust wrappers
>>> > are around non-movable C structs. Do we actually have a useful application
>>> > for OwnableMut?
>>>
>>> Also, do we even need two different traits? Which types would only
>>> implement `Ownable` but not `OwnableMut`?
>>
>> I'm not 100% sure, but on a quick glance it looks indeed be safe to
>> substitute `OwnableMut` by `Unpin`.
>
> We just have to change the safety requirements of `OwnableMut`.

`OwnableMut` already requires `Unpin`, it just does not say so directly:


/// - It is safe to call [`core::mem::swap`] on the [`Ownable`]. This excludes pinned types
///   (i.e. most kernel types).

We could remove this and then just add a trait bound on `Unpin`.

>
>> If we add `get_pin_mut(&mut self) -> Pin<&mut T>` as Andreas suggested,
>> it would be possible to obtain an `&mut T` anyway, then, if T is `Unpin`.
>
> Well the `DerefMut` impl still is convenient in the `Unpin` case.

`OwnableMut` is probably not that useful, since all the types we want to
implement `Ownable` for is `!Unpin`. We could remove it, but I felt it
was neat to add the `DerefMut` impl for `Unpin` types.


Best regards,
Andreas Hindborg




