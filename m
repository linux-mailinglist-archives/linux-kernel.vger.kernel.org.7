Return-Path: <linux-kernel+bounces-775137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D91B2BBD1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96985567663
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567CB3115B2;
	Tue, 19 Aug 2025 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGO/xRX7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4CE31159B;
	Tue, 19 Aug 2025 08:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591983; cv=none; b=S8FSYeS1bkNPD21FibsiSBGc/JP3yntBXRAMpYGrRiQJE9ZGw5vy2gF31pSVm8VChyBUfcKUAxo/wL9W1rkiRfBiwrySgmA9LMnhaK7OBEHi8q0tDdckIwizhznP5XKWkPBSZDCdxiY/tlZjQm6q2cDKbgcwQR8rD4BaU4U9iFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591983; c=relaxed/simple;
	bh=vQ+nNmzZIwCCcruO5mhWZDGl2dFxcQpyDW7zj1Vna9k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=IlO1xM1TZNCEcvqobVMknhZRnCGFznU5mqa6tqoLv03kuJZuZtCe60dDGU0gmj2oQngkOBA58/htZkJx4qsqqcEpD2WDwXUkDYlztdMRl6ksIrpNF0dny+I3JnC8hSI14zJX9G6ahW/mJ7aVe10QmZ6Nt/zpyWeXQ2+2YbAO1ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGO/xRX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02C4C4CEF1;
	Tue, 19 Aug 2025 08:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755591983;
	bh=vQ+nNmzZIwCCcruO5mhWZDGl2dFxcQpyDW7zj1Vna9k=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=nGO/xRX7gaU2h4dh6kCXpKk6SCrkqbUZNmCKvELs9XmHIKzDx1fhDay3XqAgkblSP
	 QOEsjGgbwLtd0R0xekm3DKZLHr1ZV2YnjwCcQXG9qDBIazyFWmoAuf3it8vLZENQMD
	 Md8SkoJNHj4U+nxT7zb5SHtjKKhjDMjQKZb8ufeG8Nh+bHdTUNjjchZBGE1Q+F1BJ+
	 H14yENllyW4fmE7XZNEGJNERXFvPqaZa5A4O4iwk1pWVq0hQRUuPVBfCKJ6wnjgyKc
	 X6/LC3plB3P9lQOiKulWgN63DtSmhospy/7Ch7mgnhX3mRqwennjlY32uKBSaCwnjc
	 FomXaJzBIp10g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 10:26:19 +0200
Message-Id: <DC69F17AFLB2.1KZ8JJUIH2CSP@kernel.org>
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
 <2OkNj7ab-vTaPaqMj_KRpIjaKTWgOW-F9Cn-CxnR12E6Dwg4lnjr6fx1vkjnoTx0boUeReeIVDbSyVFBWlYx7g==@protonmail.internalid> <20250618-unique-ref-v11-1-49eadcdc0aa6@pm.me> <87o6scdchf.fsf@t14s.mail-host-address-is-not-set> <aKMkvHAfDozzDjkB@mango> <DC5WOFIKX7VQ.30UNUNE37LOO5@kernel.org> <aKQT92ViZSL841rT@mango>
In-Reply-To: <aKQT92ViZSL841rT@mango>

On Tue Aug 19, 2025 at 8:04 AM CEST, Oliver Mangold wrote:
> On 250819 0027, Benno Lossin wrote:
>> On Mon Aug 18, 2025 at 3:04 PM CEST, Oliver Mangold wrote:
>> > On 250818 1446, Andreas Hindborg wrote:
>> >> "Oliver Mangold" <oliver.mangold@pm.me> writes:
>> >> > +impl<T: OwnableMut> DerefMut for Owned<T> {
>> >> > +    fn deref_mut(&mut self) -> &mut Self::Target {
>> >> > +        // SAFETY: The type invariants guarantee that the object i=
s valid, and that we can safely
>> >> > +        // return a mutable reference to it.
>> >> > +        unsafe { self.ptr.as_mut() }
>> >> > +    }
>> >> > +}
>> >>
>> >> I think someone mentioned this before, but handing out mutable
>> >> references can be a problem if `T: !Unpin`. For instance, we don't wa=
nt
>> >> to hand out `&mut Page` in case of `Owned<Page>`.
>> >>
>> >
>> > That was the reason, why `OwnableMut` was introduced in the first plac=
e.
>> > It's clear, I guess, that as-is it cannot be implemented on many class=
es.
>>=20
>> Yeah the safety requirements ensure that you can't implement it on
>> `!Unpin` types.
>>=20
>> But I'm not sure it's useful then? As you said there aren't many types
>> that will implement the type then, so how about we change the meaning
>> and make it give out a pinned mutable reference instead?
>
> Making `deref_mut()` give out a pinned type won't work. The return types =
of
> deref() are required to match.

I meant the changes that Andreas suggested.

>> > Good question, I have been thinking about it, too. But it might
>> > be, that it isn't needed at all. As I understand, usually Rust wrapper=
s
>> > are around non-movable C structs. Do we actually have a useful applica=
tion
>> > for OwnableMut?
>>=20
>> Also, do we even need two different traits? Which types would only
>> implement `Ownable` but not `OwnableMut`?
>
> I'm not 100% sure, but on a quick glance it looks indeed be safe to
> substitute `OwnableMut` by `Unpin`.

We just have to change the safety requirements of `OwnableMut`.

> If we add `get_pin_mut(&mut self) -> Pin<&mut T>` as Andreas suggested,
> it would be possible to obtain an `&mut T` anyway, then, if T is `Unpin`.

Well the `DerefMut` impl still is convenient in the `Unpin` case.

---
Cheers,
Benno

