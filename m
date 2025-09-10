Return-Path: <linux-kernel+bounces-810153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23989B516A7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9384E62DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8500F314B88;
	Wed, 10 Sep 2025 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQmLTDMr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E063923D7DD;
	Wed, 10 Sep 2025 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757506698; cv=none; b=LEWYHKBQkdg1PtIG9kh4K24mpi2qEL9uBFxQdb2f2YgugrR82PuTUTJAYwIqF3ZaaSXm0nwWgzdx6qC9Wy0CMwj9RrWHflGbfH1drKCW/qOXqn8T/XBiEN+4ezSXJhMQMC5d0ExgpOI85ZBH8bWUNoL3r7GzD00+OxgJw4thbm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757506698; c=relaxed/simple;
	bh=0hV3tkrU4SGdE6IFSduPjkgwxEJycXadDmHtsPMZUC0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Q6lI0NSD9iDWaX5vgQp/IUTAfuTsBVtXR0x3a0EGGwNOEFm6l827WrsvwVXKjIZPIt0G6hwnLVNkxpkUQ3fmtw7SXspP8SbSCMyGr1uv1D2/aKg/fWhPS5wIFDqsCHzslloIMANjG7yPaCtFBoRs698DWubr1AIfwj3IS1YynUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQmLTDMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634D4C4CEF0;
	Wed, 10 Sep 2025 12:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757506697;
	bh=0hV3tkrU4SGdE6IFSduPjkgwxEJycXadDmHtsPMZUC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RQmLTDMreDrLNLbTw/QCxdn24UUbbu5Jl4WVshC66deKy9gdQx7kcju9Dpfj9tmsJ
	 J8Ff56sRF80RJ0WIBHD9XbmVlrp/zUjJYhit9kXjSAxLpDwKO5posa7X9qxAEBygWr
	 NAUNAng7EqqYxrdG5GcEKvoRjXp9CdmDNnwpJ+WcONVCAGIO7xlf6mwg+BUZ3S0qXd
	 Co/xOaSgcY30xlDgKorJBAoiAZBR7EIAtyv+X0mO61mOjcVeXh4MX0DXMYFEBjQ8JB
	 26B7h0HB0pV80G8YOcyGsCU9Fmt9fuPTMaT6PQuVQ9Ls7agrwRjd11GNePBWwSVjkV
	 MJU5Dtmtw3YFQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 14:18:12 +0200
Message-Id: <DCP44KG3HEKL.35ANJWT161W6M@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
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
X-Mailer: aerc 0.20.1
References: <20250905171209.944599-1-lossin@kernel.org>
 <20250905171209.944599-2-lossin@kernel.org>
 <CAH5fLgjD+S0nBvDMuTfMYd6-o-3f=xGztk+jZQRhm1_vmNiHAw@mail.gmail.com>
 <DCP1ZX3ASX86.2LS8OQBF4DPL9@kernel.org>
 <CAH5fLghfeWZ1FYdgQKQ7aBftHEGgXPYZ9WTWueTSZxxtaaRB1A@mail.gmail.com>
In-Reply-To: <CAH5fLghfeWZ1FYdgQKQ7aBftHEGgXPYZ9WTWueTSZxxtaaRB1A@mail.gmail.com>

On Wed Sep 10, 2025 at 12:54 PM CEST, Alice Ryhl wrote:
> On Wed, Sep 10, 2025 at 12:38=E2=80=AFPM Benno Lossin <lossin@kernel.org>=
 wrote:
>>
>> On Wed Sep 10, 2025 at 12:23 PM CEST, Alice Ryhl wrote:
>> > On Fri, Sep 5, 2025 at 7:12=E2=80=AFPM Benno Lossin <lossin@kernel.org=
> wrote:
>> >> +    (make_pin_projections:
>> >> +        @vis($vis:vis),
>> >> +        @name($name:ident),
>> >> +        @impl_generics($($impl_generics:tt)*),
>> >> +        @ty_generics($($ty_generics:tt)*),
>> >> +        @decl_generics($($decl_generics:tt)*),
>> >> +        @where($($whr:tt)*),
>> >> +        @pinned($($(#[$($p_attr:tt)*])* $pvis:vis $p_field:ident : $=
p_type:ty),* $(,)?),
>> >> +        @not_pinned($($(#[$($attr:tt)*])* $fvis:vis $field:ident : $=
type:ty),* $(,)?),
>> >> +    ) =3D> {
>> >> +        $crate::macros::paste! {
>> >> +            #[doc(hidden)]
>> >> +            $vis struct [< $name Projection >] <'__pin, $($decl_gene=
rics)*> {
>> >
>> > I'm not sure we want $vis here. That's the visibility of the original
>> > struct, but I don't think we want it to be pub just because the struct
>> > is.
>>
>> Why shouldn't it be pub if the original is pub? I don't really
>> understand the concern, since the fields themselves will still have the
>> correct visibility. Additionally, there is the `___pin_phantom_data`
>> field that's always private, so you cannot construct this outside of the
>> module.
>
> I mean, for instance, it's going to mean that every single struct that
> wraps Opaque in a private field will get a useless pub function called
> project that will appear in html docs.

It's `#[doc(hidden)]` :)

> Pin-project limits the visibility to pub(crate) when the struct is pub.

I think I would have to look inside the `vis` to recreate that behavior,
so I'd rather do it as a future patch. Thoughts?

---
Cheers,
Benno

