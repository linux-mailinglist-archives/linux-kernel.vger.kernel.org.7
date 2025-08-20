Return-Path: <linux-kernel+bounces-777095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C73B2D51F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95DE1C23D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0769D2D8DBD;
	Wed, 20 Aug 2025 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="D3lAeHTV"
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F512D8DA4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755675801; cv=none; b=X0+nuoi6cUVxrT0mucJu4RIoxQvx50nBTrsAv5zhn86KFypK2oCayOELSEIvgO3QUbq9pA3Y1018GyWppD6hMQ21+jXzbpIKLDzeupBm2tO3JdbDI49JgR6+4xW50H51iYnSz8ZeifMIfzwN+dxDWqyZxXlgVXpVrdCYdYhGRwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755675801; c=relaxed/simple;
	bh=4auqw/phu6z/jlypeBfepV0a/baTEw5ESZBSdVZ5xz8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UmA7DPAvd6XxkDmcsvaTrEfkhcC8QdMkSG2WA+zk17JuBji1tHvMR/vgx08Td+FwNdHPBxRD0me2jlVTK6m5STFJxeac9cByWiHTkm+Zvkx5c9sSnIr+ajhGIzezTLAixkCUqpJikJx6lMJyyzbEHdVBby8PrSOhZr/zQ4FEkbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=D3lAeHTV; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1755675790; x=1755934990;
	bh=ed6yVSBNvc+WLbrEvk5vB+fyF1kLBiK/kk3SPf6wWiA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=D3lAeHTVgunKA9ZeLRagKntCYGciZ3iMzY2SHP+HB07/ukNbdiKENFhlTGf7DMvZn
	 irbU84G04jviMnosqvqU8r14Gy/7iNZ1nBA1/oq0domkLjA1FgEjeepFWZEKdl+zx5
	 2xe39k/sHAZeTtDNQjMDXrmuq6q7p8QQPTU0zc3stU/HmeyUzjtrY0bH0J8/e3mcyi
	 SoNglKogqgoAPfo4+lfZfxMr4gGejiBvXEKRfaf+PLEnJZimNTeXhfiq80Zlgimo8w
	 ylnf31yTnvvEP28+4Ac9/sEUv38Sp7qTXu6yLPeXy2LRbfNrZMtmwklurdxs6sFz7T
	 OY41UhEd67mVA==
Date: Wed, 20 Aug 2025 07:43:07 +0000
To: Benno Lossin <lossin@kernel.org>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
Message-ID: <aKV8h6i5vmiD0gHj@mango>
In-Reply-To: <DC732XTLKE1U.244I3Q2DR8JNK@kernel.org>
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me> <DC5WOFIKX7VQ.30UNUNE37LOO5@kernel.org> <aKQT92ViZSL841rT@mango> <iQ0qeYmzFSlOQkNLti-a4Z6ItwaZgh3r8Pqdu5rSwYz4wUxAsKZJlGCrsVQ481Qkzc9EapD3bzKKtrsXVkwt2A==@protonmail.internalid> <DC69F17AFLB2.1KZ8JJUIH2CSP@kernel.org> <87ldnfd766.fsf@t14s.mail-host-address-is-not-set> <DC6KN0JN4X4D.1PHXPQ46O5J1Q@kernel.org> <aKVlA1Ctya6f2Nzc@mango> <DC732XTLKE1U.244I3Q2DR8JNK@kernel.org>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 7497ccf72aa2a36754b18fa9a79b3a05554b78ca
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250820 0941, Benno Lossin wrote:
> On Wed Aug 20, 2025 at 8:02 AM CEST, Oliver Mangold wrote:
> > On 250819 1913, Benno Lossin wrote:
> >> On Tue Aug 19, 2025 at 10:53 AM CEST, Andreas Hindborg wrote:
> >> > "Benno Lossin" <lossin@kernel.org> writes:
> >> >> On Tue Aug 19, 2025 at 8:04 AM CEST, Oliver Mangold wrote:
> >> >>> On 250819 0027, Benno Lossin wrote:
> >> >>>> On Mon Aug 18, 2025 at 3:04 PM CEST, Oliver Mangold wrote:
> >> >>>> > On 250818 1446, Andreas Hindborg wrote:
> >> >>>> >> "Oliver Mangold" <oliver.mangold@pm.me> writes:
> >> >>>> >> > +impl<T: OwnableMut> DerefMut for Owned<T> {
> >> >>>> >> > +    fn deref_mut(&mut self) -> &mut Self::Target {
> >> >>>> >> > +        // SAFETY: The type invariants guarantee that the o=
bject is valid, and that we can safely
> >> >>>> >> > +        // return a mutable reference to it.
> >> >>>> >> > +        unsafe { self.ptr.as_mut() }
> >> >>>> >> > +    }
> >> >>>> >> > +}
> >> >>>> >>
> >> >>>> >> I think someone mentioned this before, but handing out mutable
> >> >>>> >> references can be a problem if `T: !Unpin`. For instance, we d=
on't want
> >> >>>> >> to hand out `&mut Page` in case of `Owned<Page>`.
> >> >>>> >>
> >> >>>> >
> >> >>>> > That was the reason, why `OwnableMut` was introduced in the fir=
st place.
> >> >>>> > It's clear, I guess, that as-is it cannot be implemented on man=
y classes.
> >> >>>>
> >> >>>> Yeah the safety requirements ensure that you can't implement it o=
n
> >> >>>> `!Unpin` types.
> >> >>>>
> >> >>>> But I'm not sure it's useful then? As you said there aren't many =
types
> >> >>>> that will implement the type then, so how about we change the mea=
ning
> >> >>>> and make it give out a pinned mutable reference instead?
> >> >>>
> >> >>> Making `deref_mut()` give out a pinned type won't work. The return=
 types of
> >> >>> deref() are required to match.
> >> >>
> >> >> I meant the changes that Andreas suggested.
> >> >
> >> > Not sure what you are asking, but I need to assert exclusive access =
to
> >> > an `Page`. I could either get this by taking a `&mut Owned<Page>` or=
 a
> >> > `Pin<&mut Page>`. I think the latter is more agnostic.
> >>
> >> The former isn't really correct? It's like having a `&mut Box<Page>`
> >> which is weird. I was saying we can have a `DerefMut` impl gated on `T=
:
> >> Unpin` and a `fn get_pin_mut(&mut self) -> Pin<&mut T>`.
> >
> > Yes. I think `Page` is the wrong example, as it already has owned seman=
tics
> > and does its own cleanup. Wrapping it in an Owned would be redundant.
>=20
> After we have these owned patches, we are going to change `Page` to
> `Opaque<bindings::page>`.

Ah, okay. Makes sense, I guess.

Best,

Oliver


