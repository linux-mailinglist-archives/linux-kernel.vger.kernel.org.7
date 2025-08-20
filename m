Return-Path: <linux-kernel+bounces-777512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1B0B2DA5B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D13D5C4F6B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA802E2DF7;
	Wed, 20 Aug 2025 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqJ76beM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75B319F464;
	Wed, 20 Aug 2025 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755687080; cv=none; b=OxEZs8Tu5bdzMt90PW0BgD1TuQBdTDh317PVvtBVq81gGcISw8nQjlVgdw6ctmqMJeIGUXMPcTMvJ9mEDGlLd1RMcnuw6iJ1fFiBM7Ve9ZmZd5ANJh7IEbsXB5RFKLPFF+c2sSPEaif09C4r2/nTEbkGz+NAuCR2KvbD2tv3S0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755687080; c=relaxed/simple;
	bh=ftbWhPhTq0/pc2ywQ/3r5J1AkPH0jYGq+ptt1+mIhBs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jRk2h20mD8GdE3Y4WwBaDPo0dYyWasV1ob9k9lg/6UXQEnA5C+aCehP3XK4giRnhhf3ySUXugmTSY/9pV3EpqFdAxWQBpazau1y+wSrAmSl4fYzxy9NrH84oxiw2crnrM8ZGuMzVu77N+qJEXjEyDuYbKfZ/RIJvimHO+HCt+54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqJ76beM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC86C4CEED;
	Wed, 20 Aug 2025 10:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755687080;
	bh=ftbWhPhTq0/pc2ywQ/3r5J1AkPH0jYGq+ptt1+mIhBs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nqJ76beMYiRpjoyvlQeZ6dc3cSkWRnEc4ZZ5xiokGOVHnZSQBW6SjieH3ISBkk+uk
	 s506k4mrJW4FMT7+NvRKP4DdFTG9uRfJQytOq50mmtOAd6ukL4DtliCtvEv7650xWA
	 Z67zU3KxQKvAJ/JK5A0mgp82UrActZansn1Uk3CD5TjruyLeFuu/TXwYdjlhDtMnRm
	 NnG2bBuJ+Sj/GYHlm1mc7I0PthfE4jKKtKqIdfZg1Cbra2LeC9qJnACC5LgJY9W390
	 BXSx83r8vuW6sfcKaZIfGnwamOd4JcXpzSOburokesg5KbpjqJdozKBBLHMGTVhgIp
	 MlD/7rqxCiryA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Oliver Mangold <oliver.mangold@pm.me>, Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina+kernel@asahilina.net>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
In-Reply-To: <aKV8h6i5vmiD0gHj@mango>
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
 <DC5WOFIKX7VQ.30UNUNE37LOO5@kernel.org> <aKQT92ViZSL841rT@mango>
 <iQ0qeYmzFSlOQkNLti-a4Z6ItwaZgh3r8Pqdu5rSwYz4wUxAsKZJlGCrsVQ481Qkzc9EapD3bzKKtrsXVkwt2A==@protonmail.internalid>
 <DC69F17AFLB2.1KZ8JJUIH2CSP@kernel.org>
 <87ldnfd766.fsf@t14s.mail-host-address-is-not-set>
 <DC6KN0JN4X4D.1PHXPQ46O5J1Q@kernel.org> <aKVlA1Ctya6f2Nzc@mango>
 <DC732XTLKE1U.244I3Q2DR8JNK@kernel.org>
 <M3562k-1Geu1ikj3nWnLQ_kh6D2zoY-27s8hhs3MbpECSjG3nY4gzKWlLqcKmODxp-LK_9v1KzVAPDRJuURxhA==@protonmail.internalid>
 <aKV8h6i5vmiD0gHj@mango>
Date: Wed, 20 Aug 2025 12:51:12 +0200
Message-ID: <875xeicllr.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Oliver Mangold" <oliver.mangold@pm.me> writes:

> On 250820 0941, Benno Lossin wrote:
>> On Wed Aug 20, 2025 at 8:02 AM CEST, Oliver Mangold wrote:
>> > On 250819 1913, Benno Lossin wrote:
>> >> On Tue Aug 19, 2025 at 10:53 AM CEST, Andreas Hindborg wrote:
>> >> > "Benno Lossin" <lossin@kernel.org> writes:
>> >> >> On Tue Aug 19, 2025 at 8:04 AM CEST, Oliver Mangold wrote:
>> >> >>> On 250819 0027, Benno Lossin wrote:
>> >> >>>> On Mon Aug 18, 2025 at 3:04 PM CEST, Oliver Mangold wrote:
>> >> >>>> > On 250818 1446, Andreas Hindborg wrote:
>> >> >>>> >> "Oliver Mangold" <oliver.mangold@pm.me> writes:
>> >> >>>> >> > +impl<T: OwnableMut> DerefMut for Owned<T> {
>> >> >>>> >> > +    fn deref_mut(&mut self) -> &mut Self::Target {
>> >> >>>> >> > +        // SAFETY: The type invariants guarantee that the object is valid, and that we can safely
>> >> >>>> >> > +        // return a mutable reference to it.
>> >> >>>> >> > +        unsafe { self.ptr.as_mut() }
>> >> >>>> >> > +    }
>> >> >>>> >> > +}
>> >> >>>> >>
>> >> >>>> >> I think someone mentioned this before, but handing out mutable
>> >> >>>> >> references can be a problem if `T: !Unpin`. For instance, we don't want
>> >> >>>> >> to hand out `&mut Page` in case of `Owned<Page>`.
>> >> >>>> >>
>> >> >>>> >
>> >> >>>> > That was the reason, why `OwnableMut` was introduced in the first place.
>> >> >>>> > It's clear, I guess, that as-is it cannot be implemented on many classes.
>> >> >>>>
>> >> >>>> Yeah the safety requirements ensure that you can't implement it on
>> >> >>>> `!Unpin` types.
>> >> >>>>
>> >> >>>> But I'm not sure it's useful then? As you said there aren't many types
>> >> >>>> that will implement the type then, so how about we change the meaning
>> >> >>>> and make it give out a pinned mutable reference instead?
>> >> >>>
>> >> >>> Making `deref_mut()` give out a pinned type won't work. The return types of
>> >> >>> deref() are required to match.
>> >> >>
>> >> >> I meant the changes that Andreas suggested.
>> >> >
>> >> > Not sure what you are asking, but I need to assert exclusive access to
>> >> > an `Page`. I could either get this by taking a `&mut Owned<Page>` or a
>> >> > `Pin<&mut Page>`. I think the latter is more agnostic.
>> >>
>> >> The former isn't really correct? It's like having a `&mut Box<Page>`
>> >> which is weird. I was saying we can have a `DerefMut` impl gated on `T:
>> >> Unpin` and a `fn get_pin_mut(&mut self) -> Pin<&mut T>`.
>> >
>> > Yes. I think `Page` is the wrong example, as it already has owned semantics
>> > and does its own cleanup. Wrapping it in an Owned would be redundant.
>>
>> After we have these owned patches, we are going to change `Page` to
>> `Opaque<bindings::page>`.
>
> Ah, okay. Makes sense, I guess.

I applied Linas patch with this change to my tree [1].

Best regards,
Andreas Hindborg


[1] https://lore.kernel.org/all/20250202-rust-page-v1-2-e3170d7fe55e@asahilina.net/



