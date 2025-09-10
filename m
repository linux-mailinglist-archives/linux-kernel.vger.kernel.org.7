Return-Path: <linux-kernel+bounces-810425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2B9B51AB8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394D0A008FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0170B341641;
	Wed, 10 Sep 2025 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="feTMT6ab"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319AC334703;
	Wed, 10 Sep 2025 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515438; cv=pass; b=VBIfu7PtesqK2eBzR4komwf9OlamMUeGwhb1WbQN4YOcTuAfAJ6g6gmdW8jWYFzn/nqT13zmN9QolV6Ew8RcMfW84MaxEveh1PjSX23Y0qr39cnNFAslH8SQu+wZE0dH3fkWz5+95kbSG1nSMj9EjpI01WAXmQBZyjy3vV4xwPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515438; c=relaxed/simple;
	bh=jWf+1iSB/smQ+JM7XZSTmLuJQb9ZbXX2Cx7HEGs4BjM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aeBPX2se+cKT7DqG4AtNSrkArlJW4J/YuUCouNigcVVZzrEqBZ4gedW/7DUMAQ0Gt2o9NMPq0Zer2Mvd+eecNY6xmD0C1tgVE+9leyoD04IZJ/xM64z1ws5SkGlaB1z7ao85te+losXRWextJhpfYvNP1uByhMtv4HIZcbg/UcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=feTMT6ab; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757515418; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MMq+EoqgJoYlcFOzgg1a8Rz0lEeN5cuylX5lnnSpflLZ5mXnOKDWI7YiZXMl6g60S96YuzP2PwSFTM0tfoep9dg9ToUKs2/N4P16VJWlefmW5LdxYiN29uRSheROOCYUdkwTgvmQMk010tZxHjSyk0LoEGlAUX3QR7RexDO7R6c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757515418; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=n+BmJhI3Z0aT6bNC5a9jb74/Ds7aMQmdDL2VAdy6ZWM=; 
	b=dQSCL3rUmgkm16VUxU+JFLWQRwbgF2PBIm7Tv6Xo5L0o53BjkYf+iNwKpzSxmxTaRiSmdQ4of1xB+EKboI/3ZecGdRPTNTLXzExBBu1xUkKa5IAFF0hVRaqKfzCntx6GHJroLVVs0fzkt8D38WBB6GWwsHdh+NCVLxsL/tJDTdU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757515418;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=n+BmJhI3Z0aT6bNC5a9jb74/Ds7aMQmdDL2VAdy6ZWM=;
	b=feTMT6ab8zHYd4DYR1SX81008fE8ZqkjzRgxAxnwcdzCss/Op11bxN9GyKTWG0LE
	p1vsSlCdxvOABlpOaem5T3xibu999Qq1wIXit9rgK77e/XJu3oTGa0IgHAkPReVJ30F
	4IghQ3BKgmJAb/J2YhPDX6c0xAMacslC5GmRpEtw=
Received: by mx.zohomail.com with SMTPS id 175751541634272.4536622769192;
	Wed, 10 Sep 2025 07:43:36 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] rust: irq: request: touch up the documentation
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <aMEc0-8mM4uaFwlB@google.com>
Date: Wed, 10 Sep 2025 11:43:20 -0300
Cc: Danilo Krummrich <dakr@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6149F5A9-D38A-4D28-8F97-3D672079AAB7@collabora.com>
References: <20250909-irq-andreas-fixes-v1-1-dbc9aafed2cb@collabora.com>
 <aMEc0-8mM4uaFwlB@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Alice,

> On 10 Sep 2025, at 03:38, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> On Tue, Sep 09, 2025 at 05:46:55PM -0300, Daniel Almeida wrote:
>> Parts of the documentation are either unclear or misplaced and can
>> otherwise be improved. This commit fixes them.
>>=20
>> This is specially important in the context of the safety requirements =
of
>> functions or type invariants, as users have to uphold the former and =
may
>> rely on the latter, so we should avoid anything that may create
>> confusion.
>>=20
>> Suggested-by: Andreas Hindborg <a.hindborg@kernel.org>
>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>=20
>> /// A request for an IRQ line for a given device.
>> @@ -112,7 +117,7 @@ impl<'a> IrqRequest<'a> {
>>     ///
>>     /// - `irq` should be a valid IRQ number for `dev`.
>>     pub(crate) unsafe fn new(dev: &'a Device<Bound>, irq: u32) -> =
Self {
>> -        // INVARIANT: `irq` is a valid IRQ number for `dev`.
>> +        // By function safety requirement, irq` is a valid IRQ =
number for `dev`.
>>         IrqRequest { dev, irq }
>=20
> When creating a value with an Invariants section, we usually have an
> INVARIANT comment. Why was this one removed?

This was requested by Andreas [0].

>=20
>>     }
>>=20
>> @@ -183,6 +188,8 @@ pub fn irq(&self) -> u32 {
>> /// * We own an irq handler whose cookie is a pointer to `Self`.
>> #[pin_data]
>> pub struct Registration<T: Handler + 'static> {
>> +    /// We need to drop inner before handler, as we must ensure that =
the handler
>> +    /// is valid until `free_irq` is called.
>>     #[pin]
>>     inner: Devres<RegistrationInner>,
>>=20
>> @@ -196,7 +203,8 @@ pub struct Registration<T: Handler + 'static> {
>> }
>>=20
>> impl<T: Handler + 'static> Registration<T> {
>> -    /// Registers the IRQ handler with the system for the given IRQ =
number.
>> +    /// Registers the IRQ handler with the system for the IRQ number =
represented
>> +    /// by `request`.
>>     pub fn new<'a>(
>>         request: IrqRequest<'a>,
>>         flags: Flags,
>> @@ -208,7 +216,11 @@ pub fn new<'a>(
>>             inner <- Devres::new(
>>                 request.dev,
>>                 try_pin_init!(RegistrationInner {
>> -                    // INVARIANT: `this` is a valid pointer to the =
`Registration` instance
>> +                    // INVARIANT: `this` is a valid pointer to the =
`Registration` instance.
>> +                    // INVARIANT: `cookie` is being passed to =
`request_irq` as
>> +                    // the cookie. It is guaranteed to be unique by =
the type
>> +                    // system, since each call to `new` will return =
a different
>> +                    // instance of `Registration`.
>>                     cookie: this.as_ptr().cast::<c_void>(),
>=20
> I believe these comments address the invariants of RegistrationInner. =
In
> that case, we usually place them on the struct:
>=20
> // INVARIANT: `this` is a valid pointer to the `Registration` =
instance.
> // INVARIANT: `cookie` is being passed to `request_irq` as
> // the cookie. It is guaranteed to be unique by the type
> // system, since each call to `new` will return a different
> // instance of `Registration`.
> try_pin_init!(RegistrationInner {
>=20

Also requested by Andreas, i.e.:

> >>> +/// # Invariants
> >>> +///
> >>> +/// - `self.irq` is the same as the one passed to =
`request_{threaded}_irq`.
> >>> +/// - `cookie` was passed to `request_{threaded}_irq` as the =
cookie. It is guaranteed to be unique
> >>> +/// by the type system, since each call to `new` will return a =
different instance of
> >>> +/// `Registration`.
> >>
> >> This seems like a mix of invariant declaration and conformance. I =
don't
> >> think the following belongs here:
> >>
> >> It is guaranteed to be unique
> >> by the type system, since each call to `new` will return a =
different instance of
> >> `Registration`.
> >>
> >> You could replace it with a uniqueness requirement.
> >
> > WDYM? This invariant is indeed provided by the type system and we do =
rely on it
> > to make the abstraction work.
>=20
> The invariant section of the type documentation should be a list of
> invariants, not reasoning about why the invariants hold. The reasoning
> goes in the code where we construct the type, where we momentarily
> break invariants, or where we change the value of the type.
>=20
> In this case, I think the invariant is that `cookie` is unique. How we
> conform to this invariant does not belong in the list. When you
> construct the type, you should have an `// INVARIANT:` comment
> explaining why the newly constructed type upholds the invariant.
>=20
> At least that is how I understand intended use of the framework.



> Also, I don't really understand these comments. The first invariant =
is:
>=20
> `self.irq` is the same as the one passed to `request_{threaded}_irq`.
>=20
> and the justification for that is that `this` is a valid pointer to =
the
> `Registration` instance. That doesn't make sense to me because this
> comment talks about `this`/`cookie` when it should talk about `irq`.
>=20
>>                     irq: {
>>                         // SAFETY:
>=20
> Alice

Is the order supposed to match? I wasn=E2=80=99t relating these two at =
this particular =E2=80=9C// INVARIANT: "

[0]: =
https://lore.kernel.org/rust-for-linux/87zfblurtj.fsf@t14s.mail-host-addre=
ss-is-not-set/=

