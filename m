Return-Path: <linux-kernel+bounces-775195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B034B2BC5E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E545563101
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36EB31577B;
	Tue, 19 Aug 2025 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqjHh/g4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C1B22424E;
	Tue, 19 Aug 2025 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594028; cv=none; b=quUErKBC+i4YUvdGvIXZn7HiJcedAGNaHpZhLPQILtCCx19T+CX3toN0r2DGHQ9LhLKUxg5HdaJG3Lv4FfSL4zl9h9OyEhNNI35nVb+NqfLwUOCZuZuwqWeeMi6s9tvrxMBo3fHJZLpM8uzYoJ352pRLtFkgyBB+lANPSUqXa2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594028; c=relaxed/simple;
	bh=7QbUTWEpkcM8qGtXGdD+x2dG+4b53wetY9jEtBfcwQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vFNU4d7c7Vru2Kc5svjHJlUt2cJZMmcNgZy6F95eFXJJT944fQNcdjuHcnZG+wVwSPIbZV6535v/2iWy8ZY5SIy/EwcVkc3kE6591vxBq3bjPjQ89H3BeeNCr6FGcn6yshNeFTg4kh8m5oDKPlqgPNsVAuhI35p4x16G3As/f10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqjHh/g4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F71C116B1;
	Tue, 19 Aug 2025 09:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755594028;
	bh=7QbUTWEpkcM8qGtXGdD+x2dG+4b53wetY9jEtBfcwQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fqjHh/g4xTzGj+RfVM4lZ7b8LIkGfE0nQoImv5fTKUSxacQDXLgTWCGxhY13TfxfO
	 2SzYHizTeKZuWUEms18YoEh2beVytqF5QhPwh/g/c8AcmgZkR2iGKzP+ya6NMo8Xx7
	 IuMHS4OcEb7e4d5qYNB2wQQfF0K3NjsMYBsV1a3mrylz7ewZ8+0bzbGzD7//qesq/s
	 KIpireHDb1GXed7ljUCUgOs00cHMykaiC8usCLBP520E+R6ugHNf0uLoQQ3gAehTzi
	 jlDS3RBBEmPr9s44IrSyE6dQ42N9XGKyRepPLZfuGrmzDjlXn+5QouXYwNfvXQvUEM
	 WeR8oY0ZmnewA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Oliver Mangold <oliver.mangold@pm.me>, Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina+kernel@asahilina.net>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
In-Reply-To: <aKQ5rHqxOBEI2n4w@mango>
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
 <2OkNj7ab-vTaPaqMj_KRpIjaKTWgOW-F9Cn-CxnR12E6Dwg4lnjr6fx1vkjnoTx0boUeReeIVDbSyVFBWlYx7g==@protonmail.internalid>
 <20250618-unique-ref-v11-1-49eadcdc0aa6@pm.me>
 <87o6scdchf.fsf@t14s.mail-host-address-is-not-set>
 <aKMkvHAfDozzDjkB@mango> <DC5WOFIKX7VQ.30UNUNE37LOO5@kernel.org>
 <aKQT92ViZSL841rT@mango> <DC69F17AFLB2.1KZ8JJUIH2CSP@kernel.org>
 <7ORM055ehFH_Z124bk1l8YRI5whcremycMy8JsSgzMf4rRdagKSDHSloL8sz3O8FmX3k9cni7TG2_EFLyInWbw==@protonmail.internalid>
 <aKQ5rHqxOBEI2n4w@mango>
Date: Tue, 19 Aug 2025 11:00:15 +0200
Message-ID: <87h5y3d6u8.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Oliver Mangold" <oliver.mangold@pm.me> writes:

> On 250819 1026, Benno Lossin wrote:
>> On Tue Aug 19, 2025 at 8:04 AM CEST, Oliver Mangold wrote:
>> > On 250819 0027, Benno Lossin wrote:
>> >> On Mon Aug 18, 2025 at 3:04 PM CEST, Oliver Mangold wrote:
>> >> > On 250818 1446, Andreas Hindborg wrote:
>> >> >> "Oliver Mangold" <oliver.mangold@pm.me> writes:
>> >> >> > +impl<T: OwnableMut> DerefMut for Owned<T> {
>> >> >> > +    fn deref_mut(&mut self) -> &mut Self::Target {
>> >> >> > +        // SAFETY: The type invariants guarantee that the object is valid, and that we can safely
>> >> >> > +        // return a mutable reference to it.
>> >> >> > +        unsafe { self.ptr.as_mut() }
>> >> >> > +    }
>> >> >> > +}
>> >> >>
>> >> >> I think someone mentioned this before, but handing out mutable
>> >> >> references can be a problem if `T: !Unpin`. For instance, we don't want
>> >> >> to hand out `&mut Page` in case of `Owned<Page>`.
>> >> >>
>> >> >
>> >> > That was the reason, why `OwnableMut` was introduced in the first place.
>> >> > It's clear, I guess, that as-is it cannot be implemented on many classes.
>> >>
>> >> Yeah the safety requirements ensure that you can't implement it on
>> >> `!Unpin` types.
>> >>
>> >> But I'm not sure it's useful then? As you said there aren't many types
>> >> that will implement the type then, so how about we change the meaning
>> >> and make it give out a pinned mutable reference instead?
>> >
>> > Making `deref_mut()` give out a pinned type won't work. The return types of
>> > deref() are required to match.
>>
>> I meant the changes that Andreas suggested.
>>
>> >> > Good question, I have been thinking about it, too. But it might
>> >> > be, that it isn't needed at all. As I understand, usually Rust wrappers
>> >> > are around non-movable C structs. Do we actually have a useful application
>> >> > for OwnableMut?
>> >>
>> >> Also, do we even need two different traits? Which types would only
>> >> implement `Ownable` but not `OwnableMut`?
>> >
>> > I'm not 100% sure, but on a quick glance it looks indeed be safe to
>> > substitute `OwnableMut` by `Unpin`.
>>
>> We just have to change the safety requirements of `OwnableMut`.
>
> You mean of `Ownable`, when `OwnableMut` is removed? Yes. A good question
> in that context is, what it actually means to have an `&mut Opaque<T>`
> where `T` is `Unpin`. If that implies being allowed to obtain an `&mut T`,
> it would we easy, I guess.

You should not be able to get a `&mut T` from a `&mut Opaque<T>`.
`Opaque` opts out of invariants that normally hold for rust references.

>
>> > If we add `get_pin_mut(&mut self) -> Pin<&mut T>` as Andreas suggested,
>> > it would be possible to obtain an `&mut T` anyway, then, if T is `Unpin`.
>>
>> Well the `DerefMut` impl still is convenient in the `Unpin` case.
>
> I agree. What I meant is, it could not introduce an extra safety
> requirement having it, if that indirect method can be used anyway.

As I mention in my other email, I think we can still have `OwnableMut`
if we add a trait bound on `Unpin`.

>
> But what I am wondering is, if we actually want to start using `Pin`
> at all. Isn't `Opaque` currently used about everywhere pinning is needed?

`Opaque` is `!Unpin`, but pinning guarantees does not come into effect
until we produce a `Pin<Opaque<T>>`.


Best regards,
Andreas Hindborg




