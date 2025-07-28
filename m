Return-Path: <linux-kernel+bounces-747720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6BFB13745
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497441891DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04CD223311;
	Mon, 28 Jul 2025 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQBnyrCG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575C01581EE;
	Mon, 28 Jul 2025 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753693792; cv=none; b=Iye1zsC4C36SYUPwFYKuibSXuzj907XPfAR/b5aEQ6qtmyggAEqIrh34K2sgEpOdw8hZenjHjA+jS7rg1xkGjc60aROdSl0emaNCV/un+TaL6leUK2JZmjQ6/18k/gFY5usZ5CzNp1eR/bDmxkdNRXqRQqIMoZ4aXld9h9DbSYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753693792; c=relaxed/simple;
	bh=cWgmH3BuawbobjDaa0eE20DMqqT/O99GfvxSOa2Xmio=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XHmC5UW+Bjxy0h+oSU34QAE7D7mgo4wRX6b6aX4Mawt288kf2zbq3cDAyNiRE8shHmalcXGpO20wiF9OMspwUq6fjhcxkOBKahAK8e/KQ1Iqwr+a6i9iDR42IxEnFBKfi+CHo4jsC4UXAy76FLzjAqWzGUNqXwVdeiTkxoCKhYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQBnyrCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5F1C4CEE7;
	Mon, 28 Jul 2025 09:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753693791;
	bh=cWgmH3BuawbobjDaa0eE20DMqqT/O99GfvxSOa2Xmio=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=PQBnyrCGmT0ahUnvFEEw+PuJBcqltJccjIhBY2CZN4h8Mtm5z3XpHx1N+NxTdgeg3
	 6uxD71PkzRuBry9a9dB9S4Zm3Xh0cWMmTas/lsT5Ns8VhYg9jKSJOU56FBCy+axkwj
	 B3RZ2IKx/a7NBAPipE70zlIWyIxp6dE1ZtelJv4zuv0yN3vDN1bBBsUqExeJB9QE58
	 EzsdoB3UgEUfTCOPPPBhYyKWEmOsG01xJ2C2pSdnadB8me38xE0L8s9HXmT/AtJFPW
	 iOd/DdG/VAJouzwvxTAJHSknDO/RkVEGHKT77ZrOuBCavXLqj3rfxMd0Uy9kti8JSd
	 4p6toUSujbIwA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Jul 2025 11:09:46 +0200
Message-Id: <DBNKKBNVFP9Z.1MO75JXMR2LTZ@kernel.org>
Cc: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Robin
 Murphy" <robin.murphy@arm.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Christian S. Lima" <christiansantoslima21@gmail.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] rust: transmute: add `as_bytes` method for `AsBytes`
 trait
From: "Benno Lossin" <lossin@kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>
X-Mailer: aerc 0.20.1
References: <20250726-as_bytes-v3-1-eb7514faab28@nvidia.com>
 <CAH5fLghNDDo0HKupPXe8G6z2TP4TJE881Bd76k0LDjSm75KcEQ@mail.gmail.com>
 <aIX-JDehurnGYppE@google.com> <DBMUEH5MYR2L.CXM12OIUH7TZ@kernel.org>
 <DBNDJGIUQC1L.3EYGJ1ROIGMBY@nvidia.com>
In-Reply-To: <DBNDJGIUQC1L.3EYGJ1ROIGMBY@nvidia.com>

On Mon Jul 28, 2025 at 5:39 AM CEST, Alexandre Courbot wrote:
> On Sun Jul 27, 2025 at 9:39 PM JST, Benno Lossin wrote:
>> On Sun Jul 27, 2025 at 12:23 PM CEST, Alice Ryhl wrote:
>>> On Sun, Jul 27, 2025 at 08:52:00AM +0200, Alice Ryhl wrote:
>>>> On Sat, Jul 26, 2025 at 4:47=E2=80=AFAM Alexandre Courbot <acourbot@nv=
idia.com> wrote:
>>>> > diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
>>>> > index 1c7d43771a37b90150de86699f114a2ffb84db91..69c46c19a89191d8a2ab=
c5801564cacda232218c 100644
>>>> > --- a/rust/kernel/transmute.rs
>>>> > +++ b/rust/kernel/transmute.rs
>>>> > @@ -47,7 +47,16 @@ macro_rules! impl_frombytes {
>>>> >  ///
>>>> >  /// Values of this type may not contain any uninitialized bytes. Th=
is type must not have interior
>>>> >  /// mutability.
>>>> > -pub unsafe trait AsBytes {}
>>>> > +pub unsafe trait AsBytes {
>>>> > +    /// Returns `self` as a slice of bytes.
>>>> > +    fn as_bytes(&self) -> &[u8] {
>>>> > +        let data =3D core::ptr::from_ref(self).cast::<u8>();
>>>> > +        let len =3D size_of_val(self);
>>>> > +
>>>> > +        // SAFETY: `data` is non-null and valid for `len * sizeof::=
<u8>()` bytes.
>>>> > +        unsafe { core::slice::from_raw_parts(data, len) }
>>>> > +    }
>>>> > +}
>>>>=20
>>>> Let's also have an as_bytes_mut() method. I would require the type to
>>>> also implement FromBytes as it lets you replace the value with another
>>>> set of bytes.
>>>
>>> s/I would/It would/
>>>
>>> FromBytes is needed only for as_bytes_mut(), not for the existing
>>> method.
>>
>> I agree with your suggestion, but it can be an independent patch and
>> doesn't need to go in via this one, right?
>
> Given where we are in the merge cycle, it seems like we have a couple of
> months until that code gets merged anyway, so I don't see any reason to
> not send a v4 with Alice's suggestion? The only drawback I see is that I
> would have to reset the Reviewed-by tags.

Yeah sounds good.

---
Cheers,
Benno

