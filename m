Return-Path: <linux-kernel+bounces-809970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE71B51423
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 335F97A6A9A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC2826462E;
	Wed, 10 Sep 2025 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3ov+dCl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408D7265CD0;
	Wed, 10 Sep 2025 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757500691; cv=none; b=NShb+2EqfBqYzXaXvcTLg7sHYGNjTKrfOrCEFiELFgX7v2QfhN1g/5HyQLS2DQCgs6YHS1aQ8Zq/KN5SwZ+YB1I5tw5KIdyWWn67fVDhRjln6zzCTzQfkNTXVOqRgC9jUqvevRP1qj6sehTHNwhncaOVrY/x7MbIFVPPc5SycVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757500691; c=relaxed/simple;
	bh=8hMzHgrR+ooVhoc3BQTIPbC51/vRFe86N1PKy5ARtMw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=HbCOHVpNLkFUOKonfmn/nvXb7MrxJrvV+EBffo6LvAIXdG79jbbp2J5ZJzPwP+ibHrzbkHhL9GVOpF5PGgfJsPhTQ9pR2W2YQeeZwklidiRaa9a5TyNgTIBnkoQbtJJIPrSewCnZ7/0BZim/jZyFCTavX6KVRrFhGnSb8e/CDyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3ov+dCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB36C4CEF0;
	Wed, 10 Sep 2025 10:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757500690;
	bh=8hMzHgrR+ooVhoc3BQTIPbC51/vRFe86N1PKy5ARtMw=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=G3ov+dClHaByfhxDWxsXPjaV/a1Z8JVPxeyTEBS1CWxZpFUZ90sZ7kRgI5iWsf4mP
	 wiPcU8U3MtW+AJh9qQqmnzNpH6kNn25douYS22pooAMVU8fJot9PdWK+2jhEIkyom7
	 Cds83TE7hMCo/W16ffroOEenRTY806e3lxJeIv/34BbjORbYZsfbv268YafbuHZyhS
	 BY8AwjG10QmMyPcZKz+LQEhH6DlFmTeyeoTvEvs6GVWMOExRI8en5Syv2HxSZrgxY0
	 Dy9MSZpSismVeAucHTV22c9ta7NQ4RDnA9ZuybQmbR99zfE02TmV+P4ijfMbFyB8Mc
	 6qnglQYFPvtUA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 12:38:06 +0200
Message-Id: <DCP1ZX3ASX86.2LS8OQBF4DPL9@kernel.org>
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
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250905171209.944599-1-lossin@kernel.org>
 <20250905171209.944599-2-lossin@kernel.org>
 <CAH5fLgjD+S0nBvDMuTfMYd6-o-3f=xGztk+jZQRhm1_vmNiHAw@mail.gmail.com>
In-Reply-To: <CAH5fLgjD+S0nBvDMuTfMYd6-o-3f=xGztk+jZQRhm1_vmNiHAw@mail.gmail.com>

On Wed Sep 10, 2025 at 12:23 PM CEST, Alice Ryhl wrote:
> On Fri, Sep 5, 2025 at 7:12=E2=80=AFPM Benno Lossin <lossin@kernel.org> w=
rote:
>>
>> Make the `#[pin_data]` macro generate a `*Projection` struct that holds
>> either `Pin<&mut Field>` or `&mut Field` for every field of the original
>> struct. Which version is chosen depends on weather there is a `#[pin]`
>> or not respectively. Access to this projected version is enabled through
>> generating `fn project(self: Pin<&mut Self>) -> SelfProjection<'_>`.
>>
>> Link: https://github.com/Rust-for-Linux/pin-init/pull/75/commits/2d69836=
7d646c7ede90e01aa22842c1002d017b3
>> [ Adapt workqueue to use the new projection instead of its own, custom
>>   one - Benno ]
>> Signed-off-by: Benno Lossin <lossin@kernel.org>
>> ---
>>  rust/kernel/workqueue.rs    | 10 ++-----
>>  rust/pin-init/src/macros.rs | 60 +++++++++++++++++++++++++++++++++++++
>>  2 files changed, 62 insertions(+), 8 deletions(-)
>>
>> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
>> index b9343d5bc00f..6ca14c629643 100644
>> --- a/rust/kernel/workqueue.rs
>> +++ b/rust/kernel/workqueue.rs
>> @@ -356,18 +356,12 @@ struct ClosureWork<T> {
>>      func: Option<T>,
>>  }
>>
>> -impl<T> ClosureWork<T> {
>> -    fn project(self: Pin<&mut Self>) -> &mut Option<T> {
>> -        // SAFETY: The `func` field is not structurally pinned.
>> -        unsafe { &mut self.get_unchecked_mut().func }
>> -    }
>> -}
>> -
>>  impl<T: FnOnce()> WorkItem for ClosureWork<T> {
>>      type Pointer =3D Pin<KBox<Self>>;
>>
>>      fn run(mut this: Pin<KBox<Self>>) {
>> -        if let Some(func) =3D this.as_mut().project().take() {
>> +        if let Some(func) =3D this.as_mut().project().func.take() {
>> +            // if let Some(func) =3D this.as_mut().project_func().take(=
) {
>>              (func)()
>>          }
>>      }
>> diff --git a/rust/pin-init/src/macros.rs b/rust/pin-init/src/macros.rs
>> index 9ced630737b8..d225cc144904 100644
>> --- a/rust/pin-init/src/macros.rs
>> +++ b/rust/pin-init/src/macros.rs
>> @@ -831,6 +831,17 @@ macro_rules! __pin_data {
>>              $($fields)*
>>          }
>>
>> +        $crate::__pin_data!(make_pin_projections:
>> +            @vis($vis),
>> +            @name($name),
>> +            @impl_generics($($impl_generics)*),
>> +            @ty_generics($($ty_generics)*),
>> +            @decl_generics($($decl_generics)*),
>> +            @where($($whr)*),
>> +            @pinned($($pinned)*),
>> +            @not_pinned($($not_pinned)*),
>> +        );
>> +
>>          // We put the rest into this const item, because it then will n=
ot be accessible to anything
>>          // outside.
>>          const _: () =3D {
>> @@ -980,6 +991,55 @@ fn drop(&mut self) {
>>              stringify!($($rest)*),
>>          );
>>      };
>> +    (make_pin_projections:
>> +        @vis($vis:vis),
>> +        @name($name:ident),
>> +        @impl_generics($($impl_generics:tt)*),
>> +        @ty_generics($($ty_generics:tt)*),
>> +        @decl_generics($($decl_generics:tt)*),
>> +        @where($($whr:tt)*),
>> +        @pinned($($(#[$($p_attr:tt)*])* $pvis:vis $p_field:ident : $p_t=
ype:ty),* $(,)?),
>> +        @not_pinned($($(#[$($attr:tt)*])* $fvis:vis $field:ident : $typ=
e:ty),* $(,)?),
>> +    ) =3D> {
>> +        $crate::macros::paste! {
>> +            #[doc(hidden)]
>> +            $vis struct [< $name Projection >] <'__pin, $($decl_generic=
s)*> {
>
> I'm not sure we want $vis here. That's the visibility of the original
> struct, but I don't think we want it to be pub just because the struct
> is.

Why shouldn't it be pub if the original is pub? I don't really
understand the concern, since the fields themselves will still have the
correct visibility. Additionally, there is the `___pin_phantom_data`
field that's always private, so you cannot construct this outside of the
module.

---
Cheers,
Benno

