Return-Path: <linux-kernel+bounces-776995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8152B2D3D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB4A34E83E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDE62264A7;
	Wed, 20 Aug 2025 06:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ZJ9UeAp9"
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C321D2264AD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755669782; cv=none; b=OU8+gUKbWRdVcjE+P/9davxd2OMAb15n5p2dq3fsQyweXzjS1E4pw4Flbnkgdt8gnnhkE9u1Mx6SCVXjd+SE+ak6w+I4p5gFeFwEZ6IUEFbOb55SZcqGF/z7xu+MADGfbaeE4hJUauG5S5uv5YjkoPzZ0VwtgDGvx0fMWaHimac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755669782; c=relaxed/simple;
	bh=KosImDPOXhVCWVKnWya3bDCnB/Eq8uNkXxB0xulXn24=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FR/kypUSNUpXNigO9K2/5XM8OR4a8DVEmlhrbtWnA2CbyLt7jmkNBOqQg4F/czjPVVSR98oUQ2rwkGKo1nObd5h+KEQlMjY994A9K32IICr5GfSDRC6gCIHeL9a3Y9BIgIOkeVnJC39a+TZhdxDutyt/4GVvyxbiGxSxyc/H/pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ZJ9UeAp9; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1755669771; x=1755928971;
	bh=86F+If9SGWTpuQ7USu1RzC5V2T7IiWxYGj3PEzWHmFs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZJ9UeAp9NMUVWFPI89xzI+z3gbHyjaZCPQIW583ozBteTnS3ZpwTM6/AQjIMnAVnN
	 Uoqxcw9AxTKk4SLU0384Oz3vkdsA5Tbv1/6S85jkvxSFr9RY5tfv6lEdbaTTNhfXb6
	 NMZlboXRcJuL/ChXudQohUgJaNnCFIAtF9aA5egLrqnI1H9h06InKCSbWB6aRP2QRk
	 J5w4FQJI0h/6n0w+iFSKNa3ytZ3MSJ4mjCx5Gwbhk0c7dy/MG+FVVhjUBWQXQSwgy9
	 BsIQ7lHN1pd+fg8ur92eBIDrGNZCbNSnqRHsSIep+nGX6ymyFjnjPMy8EVKMgtgd41
	 ROwWHDTD4NIdA==
Date: Wed, 20 Aug 2025 06:02:47 +0000
To: Benno Lossin <lossin@kernel.org>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
Message-ID: <aKVlA1Ctya6f2Nzc@mango>
In-Reply-To: <DC6KN0JN4X4D.1PHXPQ46O5J1Q@kernel.org>
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me> <87o6scdchf.fsf@t14s.mail-host-address-is-not-set> <aKMkvHAfDozzDjkB@mango> <DC5WOFIKX7VQ.30UNUNE37LOO5@kernel.org> <aKQT92ViZSL841rT@mango> <iQ0qeYmzFSlOQkNLti-a4Z6ItwaZgh3r8Pqdu5rSwYz4wUxAsKZJlGCrsVQ481Qkzc9EapD3bzKKtrsXVkwt2A==@protonmail.internalid> <DC69F17AFLB2.1KZ8JJUIH2CSP@kernel.org> <87ldnfd766.fsf@t14s.mail-host-address-is-not-set> <DC6KN0JN4X4D.1PHXPQ46O5J1Q@kernel.org>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 9bf91d430d33ac3811c48dbe6430b4c9150023d2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250819 1913, Benno Lossin wrote:
> On Tue Aug 19, 2025 at 10:53 AM CEST, Andreas Hindborg wrote:
> > "Benno Lossin" <lossin@kernel.org> writes:
> >> On Tue Aug 19, 2025 at 8:04 AM CEST, Oliver Mangold wrote:
> >>> On 250819 0027, Benno Lossin wrote:
> >>>> On Mon Aug 18, 2025 at 3:04 PM CEST, Oliver Mangold wrote:
> >>>> > On 250818 1446, Andreas Hindborg wrote:
> >>>> >> "Oliver Mangold" <oliver.mangold@pm.me> writes:
> >>>> >> > +impl<T: OwnableMut> DerefMut for Owned<T> {
> >>>> >> > +    fn deref_mut(&mut self) -> &mut Self::Target {
> >>>> >> > +        // SAFETY: The type invariants guarantee that the obje=
ct is valid, and that we can safely
> >>>> >> > +        // return a mutable reference to it.
> >>>> >> > +        unsafe { self.ptr.as_mut() }
> >>>> >> > +    }
> >>>> >> > +}
> >>>> >>
> >>>> >> I think someone mentioned this before, but handing out mutable
> >>>> >> references can be a problem if `T: !Unpin`. For instance, we don'=
t want
> >>>> >> to hand out `&mut Page` in case of `Owned<Page>`.
> >>>> >>
> >>>> >
> >>>> > That was the reason, why `OwnableMut` was introduced in the first =
place.
> >>>> > It's clear, I guess, that as-is it cannot be implemented on many c=
lasses.
> >>>>
> >>>> Yeah the safety requirements ensure that you can't implement it on
> >>>> `!Unpin` types.
> >>>>
> >>>> But I'm not sure it's useful then? As you said there aren't many typ=
es
> >>>> that will implement the type then, so how about we change the meanin=
g
> >>>> and make it give out a pinned mutable reference instead?
> >>>
> >>> Making `deref_mut()` give out a pinned type won't work. The return ty=
pes of
> >>> deref() are required to match.
> >>
> >> I meant the changes that Andreas suggested.
> >
> > Not sure what you are asking, but I need to assert exclusive access to
> > an `Page`. I could either get this by taking a `&mut Owned<Page>` or a
> > `Pin<&mut Page>`. I think the latter is more agnostic.
>=20
> The former isn't really correct? It's like having a `&mut Box<Page>`
> which is weird. I was saying we can have a `DerefMut` impl gated on `T:
> Unpin` and a `fn get_pin_mut(&mut self) -> Pin<&mut T>`.

Yes. I think `Page` is the wrong example, as it already has owned semantics
and does its own cleanup. Wrapping it in an Owned would be redundant.

Best,

Oliver


