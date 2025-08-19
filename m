Return-Path: <linux-kernel+bounces-776227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666A6B2CA4D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B7477B8252
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0D92E22A7;
	Tue, 19 Aug 2025 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIPr+3aM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF785251793;
	Tue, 19 Aug 2025 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755623641; cv=none; b=VaAcyN8VzoI3nZh7+nEyl/2oO00+2jPaQ3P3V1VWTJDaVbsrByjCpfc8l9jupvdmhl6OY0mM+xdyQip7OCbrIuvuhD+gyBDIeZhBEaCWrv/8+dKAnS3k5cz5TjNsh5q2+rceVzuubMatOzKu7SYSSOovb1GvHClFqa5V91fgt8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755623641; c=relaxed/simple;
	bh=P8ypOkRbNuhXHWJoEf9Jdx/j5XBQWH+tFc/kF/oAtAI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=N+f9ZxJylnOo5UvGSGx9P2/5VPZt0y336QrPtc1TR+mZ8MJfe2ZrdCrN+K+hdCtYjPErVm92Iio0WCkbGwecz6eZeiyExQerlQLR4Def/TckVKA/lH2gkZ8Cdoaab0rRpzSc8Zc4DENtElydzxvuh4pKT3hzzO9GA467Au65ZqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIPr+3aM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D590CC4CEF1;
	Tue, 19 Aug 2025 17:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755623641;
	bh=P8ypOkRbNuhXHWJoEf9Jdx/j5XBQWH+tFc/kF/oAtAI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=aIPr+3aM7AnZKdlgQ4v2eVdq3QC7LBNbsEGAtj700GSmCoEIvZ7RMBBpOpfAkgtEb
	 GE0m+Rnfoccu/OA2HhwUZ1PFQGaLQFA9/NML+UT2UyPzK9Qgk8YDQclQBJJ+0QAAS9
	 k4t5wQpmZKl4lDHoEweZzb5ghJrrK+7r0nXz6NbAiYfgS4lL85Gl/XNCNj3V4YoXql
	 eGQ4XyUEmkluebNft6HpsLcmePcO6FIdDfl1AwSmiwbl8nchTfRaYBNd7MrWlVl3bT
	 w661rI73u5j17VtGS49Xo8Scxmg6dDYvsLMzq+olkCUA4lr6QDq8Zw7rof3bjrsz79
	 LK/CgqawT0diw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 19:13:56 +0200
Message-Id: <DC6KN0JN4X4D.1PHXPQ46O5J1Q@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, "Asahi Lina" <lina+kernel@asahilina.net>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
From: "Benno Lossin" <lossin@kernel.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Oliver Mangold"
 <oliver.mangold@pm.me>
X-Mailer: aerc 0.20.1
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
 <2OkNj7ab-vTaPaqMj_KRpIjaKTWgOW-F9Cn-CxnR12E6Dwg4lnjr6fx1vkjnoTx0boUeReeIVDbSyVFBWlYx7g==@protonmail.internalid> <20250618-unique-ref-v11-1-49eadcdc0aa6@pm.me> <87o6scdchf.fsf@t14s.mail-host-address-is-not-set> <aKMkvHAfDozzDjkB@mango> <DC5WOFIKX7VQ.30UNUNE37LOO5@kernel.org> <aKQT92ViZSL841rT@mango> <iQ0qeYmzFSlOQkNLti-a4Z6ItwaZgh3r8Pqdu5rSwYz4wUxAsKZJlGCrsVQ481Qkzc9EapD3bzKKtrsXVkwt2A==@protonmail.internalid> <DC69F17AFLB2.1KZ8JJUIH2CSP@kernel.org> <87ldnfd766.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87ldnfd766.fsf@t14s.mail-host-address-is-not-set>

On Tue Aug 19, 2025 at 10:53 AM CEST, Andreas Hindborg wrote:
> "Benno Lossin" <lossin@kernel.org> writes:
>> On Tue Aug 19, 2025 at 8:04 AM CEST, Oliver Mangold wrote:
>>> On 250819 0027, Benno Lossin wrote:
>>>> On Mon Aug 18, 2025 at 3:04 PM CEST, Oliver Mangold wrote:
>>>> > On 250818 1446, Andreas Hindborg wrote:
>>>> >> "Oliver Mangold" <oliver.mangold@pm.me> writes:
>>>> >> > +impl<T: OwnableMut> DerefMut for Owned<T> {
>>>> >> > +    fn deref_mut(&mut self) -> &mut Self::Target {
>>>> >> > +        // SAFETY: The type invariants guarantee that the object=
 is valid, and that we can safely
>>>> >> > +        // return a mutable reference to it.
>>>> >> > +        unsafe { self.ptr.as_mut() }
>>>> >> > +    }
>>>> >> > +}
>>>> >>
>>>> >> I think someone mentioned this before, but handing out mutable
>>>> >> references can be a problem if `T: !Unpin`. For instance, we don't =
want
>>>> >> to hand out `&mut Page` in case of `Owned<Page>`.
>>>> >>
>>>> >
>>>> > That was the reason, why `OwnableMut` was introduced in the first pl=
ace.
>>>> > It's clear, I guess, that as-is it cannot be implemented on many cla=
sses.
>>>>
>>>> Yeah the safety requirements ensure that you can't implement it on
>>>> `!Unpin` types.
>>>>
>>>> But I'm not sure it's useful then? As you said there aren't many types
>>>> that will implement the type then, so how about we change the meaning
>>>> and make it give out a pinned mutable reference instead?
>>>
>>> Making `deref_mut()` give out a pinned type won't work. The return type=
s of
>>> deref() are required to match.
>>
>> I meant the changes that Andreas suggested.
>
> Not sure what you are asking, but I need to assert exclusive access to
> an `Page`. I could either get this by taking a `&mut Owned<Page>` or a
> `Pin<&mut Page>`. I think the latter is more agnostic.

The former isn't really correct? It's like having a `&mut Box<Page>`
which is weird. I was saying we can have a `DerefMut` impl gated on `T:
Unpin` and a `fn get_pin_mut(&mut self) -> Pin<&mut T>`.

>>>> > Good question, I have been thinking about it, too. But it might
>>>> > be, that it isn't needed at all. As I understand, usually Rust wrapp=
ers
>>>> > are around non-movable C structs. Do we actually have a useful appli=
cation
>>>> > for OwnableMut?
>>>>
>>>> Also, do we even need two different traits? Which types would only
>>>> implement `Ownable` but not `OwnableMut`?
>>>
>>> I'm not 100% sure, but on a quick glance it looks indeed be safe to
>>> substitute `OwnableMut` by `Unpin`.
>>
>> We just have to change the safety requirements of `OwnableMut`.
>
> `OwnableMut` already requires `Unpin`, it just does not say so directly:
>
>
> /// - It is safe to call [`core::mem::swap`] on the [`Ownable`]. This exc=
ludes pinned types
> ///   (i.e. most kernel types).
>
> We could remove this and then just add a trait bound on `Unpin`.

Oh I happened to not have read it that thoroughly then... I don't think
it makes sense to have `OwnableMut` then. So I agree with your suggested
change :)

>>> If we add `get_pin_mut(&mut self) -> Pin<&mut T>` as Andreas suggested,
>>> it would be possible to obtain an `&mut T` anyway, then, if T is `Unpin=
`.
>>
>> Well the `DerefMut` impl still is convenient in the `Unpin` case.
>
> `OwnableMut` is probably not that useful, since all the types we want to
> implement `Ownable` for is `!Unpin`. We could remove it, but I felt it
> was neat to add the `DerefMut` impl for `Unpin` types.

But we don't need `OwnableMut` in that case?

Let's just do the following if it makes sense:
* remove `OwnableMut`
* allow obtaining a `Pin<&mut T>` from `Owned<T>` via a `&mut self`
  method (we need a new safety requirement for this on `Ownable`)
* have the `DerefMut` impl require `T: Unpin`

---
Cheers,
Benno

