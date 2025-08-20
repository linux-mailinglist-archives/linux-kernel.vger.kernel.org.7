Return-Path: <linux-kernel+bounces-777090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64D8B2D513
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADB42A38A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B572D8378;
	Wed, 20 Aug 2025 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3nWiMlm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A795256D;
	Wed, 20 Aug 2025 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755675669; cv=none; b=QIKc1ccHur7VkJkJ/obnMlKB8a28OyfqIbTDv1aqFcZtks9qSRX/Y3sag/J0P4IF/taQ5nges0qbnHbxzgoMx0j1KraDzvrg5Lk5FODPiO9OcEZU2CeFSpLAVynD6vtvttqhuaovlZfsAITyFj2BRTmdRGV+6b5sxK8SvedPSWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755675669; c=relaxed/simple;
	bh=7582QjSZOJKaR7M/xNgEU/LanovGbAq371XLoEphlcs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Hji7q2tVipupmyEjDwdF2styEDXtpjg47cFajE32c7MuT19WpwhEusa9+YF+6kqfu3rE/nnviz2TzQ+cgOdUuedJ/ayFTtxph8GbvTtn1ZKhJLvENAPV+dh9a2hREhIRPMX9/6txFiAkJsnk1ke3HfOLWyG0cuuF9eslLLO5fA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3nWiMlm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45B5C4CEEB;
	Wed, 20 Aug 2025 07:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755675668;
	bh=7582QjSZOJKaR7M/xNgEU/LanovGbAq371XLoEphlcs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=H3nWiMlmZJ3jBrqvP26L4C7TPuPcvRrudx9gI3EokQkeZEZEuYj+9VJdF5CCr2o+H
	 Km1kui60TeBW2izEOvAJFeDmEej16wBtXUsCPwkN1avQgZgdaqg8/LtDjPoEVi7d3F
	 iYr/4yvEKL9zKzm7yIDZ46VuppC4WeG4q1nQZVsGo7n8QLCh3dKQtE8I/PCJbmmUl8
	 vkmqFV5SY+9Mz6omYiw4wJ8BFTTwe9hK0zDN8433HdJ5fiYWe3jsINXxiJOZU7944v
	 iVbSCQtFfDLMVR08P5gXinjKtPJrPedeEY0ju23saz25/Nzr2Ycy1k+ZTrZW88unMS
	 mOXUR1UUroWPw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 09:41:04 +0200
Message-Id: <DC732XTLKE1U.244I3Q2DR8JNK@kernel.org>
Cc: "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Asahi Lina"
 <lina+kernel@asahilina.net>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
From: "Benno Lossin" <lossin@kernel.org>
To: "Oliver Mangold" <oliver.mangold@pm.me>
X-Mailer: aerc 0.20.1
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
 <87o6scdchf.fsf@t14s.mail-host-address-is-not-set> <aKMkvHAfDozzDjkB@mango>
 <DC5WOFIKX7VQ.30UNUNE37LOO5@kernel.org> <aKQT92ViZSL841rT@mango>
 <iQ0qeYmzFSlOQkNLti-a4Z6ItwaZgh3r8Pqdu5rSwYz4wUxAsKZJlGCrsVQ481Qkzc9EapD3bzKKtrsXVkwt2A==@protonmail.internalid> <DC69F17AFLB2.1KZ8JJUIH2CSP@kernel.org> <87ldnfd766.fsf@t14s.mail-host-address-is-not-set> <DC6KN0JN4X4D.1PHXPQ46O5J1Q@kernel.org> <aKVlA1Ctya6f2Nzc@mango>
In-Reply-To: <aKVlA1Ctya6f2Nzc@mango>

On Wed Aug 20, 2025 at 8:02 AM CEST, Oliver Mangold wrote:
> On 250819 1913, Benno Lossin wrote:
>> On Tue Aug 19, 2025 at 10:53 AM CEST, Andreas Hindborg wrote:
>> > "Benno Lossin" <lossin@kernel.org> writes:
>> >> On Tue Aug 19, 2025 at 8:04 AM CEST, Oliver Mangold wrote:
>> >>> On 250819 0027, Benno Lossin wrote:
>> >>>> On Mon Aug 18, 2025 at 3:04 PM CEST, Oliver Mangold wrote:
>> >>>> > On 250818 1446, Andreas Hindborg wrote:
>> >>>> >> "Oliver Mangold" <oliver.mangold@pm.me> writes:
>> >>>> >> > +impl<T: OwnableMut> DerefMut for Owned<T> {
>> >>>> >> > +    fn deref_mut(&mut self) -> &mut Self::Target {
>> >>>> >> > +        // SAFETY: The type invariants guarantee that the obj=
ect is valid, and that we can safely
>> >>>> >> > +        // return a mutable reference to it.
>> >>>> >> > +        unsafe { self.ptr.as_mut() }
>> >>>> >> > +    }
>> >>>> >> > +}
>> >>>> >>
>> >>>> >> I think someone mentioned this before, but handing out mutable
>> >>>> >> references can be a problem if `T: !Unpin`. For instance, we don=
't want
>> >>>> >> to hand out `&mut Page` in case of `Owned<Page>`.
>> >>>> >>
>> >>>> >
>> >>>> > That was the reason, why `OwnableMut` was introduced in the first=
 place.
>> >>>> > It's clear, I guess, that as-is it cannot be implemented on many =
classes.
>> >>>>
>> >>>> Yeah the safety requirements ensure that you can't implement it on
>> >>>> `!Unpin` types.
>> >>>>
>> >>>> But I'm not sure it's useful then? As you said there aren't many ty=
pes
>> >>>> that will implement the type then, so how about we change the meani=
ng
>> >>>> and make it give out a pinned mutable reference instead?
>> >>>
>> >>> Making `deref_mut()` give out a pinned type won't work. The return t=
ypes of
>> >>> deref() are required to match.
>> >>
>> >> I meant the changes that Andreas suggested.
>> >
>> > Not sure what you are asking, but I need to assert exclusive access to
>> > an `Page`. I could either get this by taking a `&mut Owned<Page>` or a
>> > `Pin<&mut Page>`. I think the latter is more agnostic.
>>=20
>> The former isn't really correct? It's like having a `&mut Box<Page>`
>> which is weird. I was saying we can have a `DerefMut` impl gated on `T:
>> Unpin` and a `fn get_pin_mut(&mut self) -> Pin<&mut T>`.
>
> Yes. I think `Page` is the wrong example, as it already has owned semanti=
cs
> and does its own cleanup. Wrapping it in an Owned would be redundant.

After we have these owned patches, we are going to change `Page` to
`Opaque<bindings::page>`.

---
Cheers,
Benno

