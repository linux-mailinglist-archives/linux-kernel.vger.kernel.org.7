Return-Path: <linux-kernel+bounces-810210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C7FB51746
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF17E3B9A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337C231B83E;
	Wed, 10 Sep 2025 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/k/LErI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8885830DED5;
	Wed, 10 Sep 2025 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757508740; cv=none; b=tobtKroq7Wl9fqA/vevwgIQiY97Qwjp4Z2rCkVhxiB0KoCzYTJvL9WIU9D7pmH6is09W736Xkz/vO+iZaaUzJSLHOAaWPwo+hCAyQbQwoTReer8qu+u1sz6+4EpbtuSBsiDpwdCqfSDlpXdXRk9IGpq2eqe3oeOK2vfBDdyzX+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757508740; c=relaxed/simple;
	bh=9JDZHZd4tCgBHhJTUaC0MpfPEcg9L1KKWQiqUNb8TLw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=p8DIQHGCNpW2jursn0y/8RfpnFEMRnWR6in2mOisLjpi856P1SRZ+sk2NWL4VM9OzW0k9+qzuf81rZADQhLaN1VWHHZVN38TTtEOpCcyEgsokdh660r7uDuNKt5Le4oLuiNt92G1SituLyu84erRlNuLl/AKrPaZGC7diJOKwZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/k/LErI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D33DC4CEF0;
	Wed, 10 Sep 2025 12:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757508740;
	bh=9JDZHZd4tCgBHhJTUaC0MpfPEcg9L1KKWQiqUNb8TLw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=b/k/LErIvNUEqUNqC83K9hpRipDzoa/rn582eztjjd5i7KUVB2n3Br7JETbexU0kQ
	 Ctk7e1MwsnxNavzO6hCWysTmmzb3EloqDa3Ir3pZzDfOkJn0/RDyGWQUIXgSuF+J3H
	 2E9NfmuXiW82YA/i4XlN1DotdeLZpERkKPgItg4xFIePt0jWOIC9cfsoMHR+41YpsG
	 lKnzuSTXpjudqEcY5f0uqTJfcS0TRjeG38/5OLkbT0bdc7cvPEfTG/yukrxrxMY0TP
	 B8g5YsDqWco9A2iahNgWiUHOJ2CUy+nv5tQMbbCXIWvJ2VmScfhlQ/dVhubymNuDJJ
	 WgVNm7L29V78w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 14:52:15 +0200
Message-Id: <DCP4UN1A8JTR.2F29BUUOZ0MW9@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Tejun Heo" <tj@kernel.org>, "Tamir Duberstein" <tamird@gmail.com>, "Dirk
 Behme" <dirk.behme@gmail.com>, "Alban Kurti" <kurti@invicto.ai>, "Fiona
 Behrens" <me@kloenk.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rust: pin-init: add pin projections to
 `#[pin_data]`
From: "Benno Lossin" <lossin@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
X-Mailer: aerc 0.20.1
References: <20250905171209.944599-1-lossin@kernel.org>
 <20250905171209.944599-2-lossin@kernel.org>
 <CAH5fLgjD+S0nBvDMuTfMYd6-o-3f=xGztk+jZQRhm1_vmNiHAw@mail.gmail.com>
 <DCP1ZX3ASX86.2LS8OQBF4DPL9@kernel.org>
 <CAH5fLghfeWZ1FYdgQKQ7aBftHEGgXPYZ9WTWueTSZxxtaaRB1A@mail.gmail.com>
 <DCP44KG3HEKL.35ANJWT161W6M@kernel.org>
 <CAH5fLgjZnnPRLn8LpaXrQ4hbqig07+N=7q7b0E+9JL1hnXCOVg@mail.gmail.com>
In-Reply-To: <CAH5fLgjZnnPRLn8LpaXrQ4hbqig07+N=7q7b0E+9JL1hnXCOVg@mail.gmail.com>

On Wed Sep 10, 2025 at 2:28 PM CEST, Alice Ryhl wrote:
> On Wed, Sep 10, 2025 at 2:18=E2=80=AFPM Benno Lossin <lossin@kernel.org> =
wrote:
>>
>> On Wed Sep 10, 2025 at 12:54 PM CEST, Alice Ryhl wrote:
>> > On Wed, Sep 10, 2025 at 12:38=E2=80=AFPM Benno Lossin <lossin@kernel.o=
rg> wrote:
>> >>
>> >> On Wed Sep 10, 2025 at 12:23 PM CEST, Alice Ryhl wrote:
>> >> > On Fri, Sep 5, 2025 at 7:12=E2=80=AFPM Benno Lossin <lossin@kernel.=
org> wrote:
>> >> >> +    (make_pin_projections:
>> >> >> +        @vis($vis:vis),
>> >> >> +        @name($name:ident),
>> >> >> +        @impl_generics($($impl_generics:tt)*),
>> >> >> +        @ty_generics($($ty_generics:tt)*),
>> >> >> +        @decl_generics($($decl_generics:tt)*),
>> >> >> +        @where($($whr:tt)*),
>> >> >> +        @pinned($($(#[$($p_attr:tt)*])* $pvis:vis $p_field:ident =
: $p_type:ty),* $(,)?),
>> >> >> +        @not_pinned($($(#[$($attr:tt)*])* $fvis:vis $field:ident =
: $type:ty),* $(,)?),
>> >> >> +    ) =3D> {
>> >> >> +        $crate::macros::paste! {
>> >> >> +            #[doc(hidden)]
>> >> >> +            $vis struct [< $name Projection >] <'__pin, $($decl_g=
enerics)*> {
>> >> >
>> >> > I'm not sure we want $vis here. That's the visibility of the origin=
al
>> >> > struct, but I don't think we want it to be pub just because the str=
uct
>> >> > is.
>> >>
>> >> Why shouldn't it be pub if the original is pub? I don't really
>> >> understand the concern, since the fields themselves will still have t=
he
>> >> correct visibility. Additionally, there is the `___pin_phantom_data`
>> >> field that's always private, so you cannot construct this outside of =
the
>> >> module.
>> >
>> > I mean, for instance, it's going to mean that every single struct that
>> > wraps Opaque in a private field will get a useless pub function called
>> > project that will appear in html docs.
>>
>> It's `#[doc(hidden)]` :)
>>
>> > Pin-project limits the visibility to pub(crate) when the struct is pub=
.
>>
>> I think I would have to look inside the `vis` to recreate that behavior,
>> so I'd rather do it as a future patch. Thoughts?
>
> You could make the struct and method always pub(crate)?

That doesn't work for module-private structs though?

---
Cheers,
Benno

