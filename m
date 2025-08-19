Return-Path: <linux-kernel+bounces-774908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E99B2B910
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 590FD7A7195
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF732641FC;
	Tue, 19 Aug 2025 06:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="o9XuQOZO"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9210F24887E;
	Tue, 19 Aug 2025 06:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755583500; cv=none; b=l24K08bVr4JsqrhSFOc7gRRpgogsUvC9DezSYQffxkcbTHftpfAXW7lBvfr0HFZ2shIujvQM6kQreGi986dEmHGrnnX93ArYOkFJDKCccnDnaoJgYs0jkt9skhjgULmqlt1DezwplQ7nqxRaG3X1p0q33XDvaBfn2fhgr4CVUyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755583500; c=relaxed/simple;
	bh=ca2TLh9PH+yuIGEzRW160m3pIa3kMZUbkyLqmo10Wjs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ib/nsfBLfdb4CxxRK/od1dGswuJadCGfy1r4f8GWwpN3Q5aY7c9uiL3qY/dwDNY+fSMa9eRbyfkKlKwa5W82sEqWSzReQ3r5NzcyHyAvCOfUTlOYcBIVpm/jtV5n8Ti+3uercNIsBAlknBefWuAfzTm6zVMU5buy5GU+mFrZIWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=o9XuQOZO; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1755583489; x=1755842689;
	bh=x8vAcfV2l1e9X5MpDbuJZSQm+f+K0sl63RngOposAYA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=o9XuQOZOW/N0nn0YS57dPeBI/DVe4F0FTMrbAtXTueD9UD2KrUInl7DnNi76OXedQ
	 Em8+zP0qTCzR/0CVD/MGW7Ea2jpD8lECsG5XiP43NDEwYMHb4oWWeEZ8pFmv1MnjOd
	 /x7fvDURRHFUeblgQ7cYCNA3FhjG3e2g1mCnEe8S9virTIGyksJKVwPrI8R7yioa5U
	 WnYeksBZU4y+1htIUmKf52B5x3KpC1OCzHUPQKh2zNXrl0+1RmNWhwNZyBXfDdtzvZ
	 5OaBxSe7KTffm2X3F52l6MbDV6h74CH5mP6WrwyQLiXZcnj+gJV2uhTbAkmpCBWVDK
	 3YjjMR9I2OFLQ==
Date: Tue, 19 Aug 2025 06:04:43 +0000
To: Benno Lossin <lossin@kernel.org>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
Message-ID: <aKQT92ViZSL841rT@mango>
In-Reply-To: <DC5WOFIKX7VQ.30UNUNE37LOO5@kernel.org>
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me> <2OkNj7ab-vTaPaqMj_KRpIjaKTWgOW-F9Cn-CxnR12E6Dwg4lnjr6fx1vkjnoTx0boUeReeIVDbSyVFBWlYx7g==@protonmail.internalid> <20250618-unique-ref-v11-1-49eadcdc0aa6@pm.me> <87o6scdchf.fsf@t14s.mail-host-address-is-not-set> <aKMkvHAfDozzDjkB@mango> <DC5WOFIKX7VQ.30UNUNE37LOO5@kernel.org>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 6504b497798cda49f4f1e5b7e0b0710b179bc5ed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250819 0027, Benno Lossin wrote:
> On Mon Aug 18, 2025 at 3:04 PM CEST, Oliver Mangold wrote:
> > On 250818 1446, Andreas Hindborg wrote:
> >> "Oliver Mangold" <oliver.mangold@pm.me> writes:
> >> > +impl<T: OwnableMut> DerefMut for Owned<T> {
> >> > +    fn deref_mut(&mut self) -> &mut Self::Target {
> >> > +        // SAFETY: The type invariants guarantee that the object is=
 valid, and that we can safely
> >> > +        // return a mutable reference to it.
> >> > +        unsafe { self.ptr.as_mut() }
> >> > +    }
> >> > +}
> >>
> >> I think someone mentioned this before, but handing out mutable
> >> references can be a problem if `T: !Unpin`. For instance, we don't wan=
t
> >> to hand out `&mut Page` in case of `Owned<Page>`.
> >>
> >
> > That was the reason, why `OwnableMut` was introduced in the first place=
.
> > It's clear, I guess, that as-is it cannot be implemented on many classe=
s.
>=20
> Yeah the safety requirements ensure that you can't implement it on
> `!Unpin` types.
>=20
> But I'm not sure it's useful then? As you said there aren't many types
> that will implement the type then, so how about we change the meaning
> and make it give out a pinned mutable reference instead?

Making `deref_mut()` give out a pinned type won't work. The return types of
deref() are required to match.

> > Good question, I have been thinking about it, too. But it might
> > be, that it isn't needed at all. As I understand, usually Rust wrappers
> > are around non-movable C structs. Do we actually have a useful applicat=
ion
> > for OwnableMut?
>=20
> Also, do we even need two different traits? Which types would only
> implement `Ownable` but not `OwnableMut`?

I'm not 100% sure, but on a quick glance it looks indeed be safe to
substitute `OwnableMut` by `Unpin`.

If we add `get_pin_mut(&mut self) -> Pin<&mut T>` as Andreas suggested,
it would be possible to obtain an `&mut T` anyway, then, if T is `Unpin`.


