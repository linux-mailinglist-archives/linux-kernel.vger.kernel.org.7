Return-Path: <linux-kernel+bounces-809971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9BDB51424
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0EDC4E081F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AA8266EEA;
	Wed, 10 Sep 2025 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDhCORUe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DE126462E;
	Wed, 10 Sep 2025 10:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757500727; cv=none; b=K2bpjwJlXE4Ue9xjzRZ5VT0UszUMrlbCZugMWxPhoSePV4NcmR+j+7liU7JfiGT8oLQoB5IFNN+N5WVaGSMobD0XaDrQUOJzGlc+jujqQjvlpa3nve17jkkV7Tj3WWpsmTUjr+gRzXiQJaU/sLBKe7gyvaDnGx3k+L2ONNVeciA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757500727; c=relaxed/simple;
	bh=FkQ1EMvCWPyVw5lidXqwG1FjiH6rcwMTyeVpnQL7iYs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dalgnnlpFTdF6ehQtkCGZp55TBjEkJUkc2ojVeUFx6qA04QAFeANUBcphcUxdEAcy3KvTAXEUcN8AFwK6wjoxH3/nVTMgMzb8igbhcNVneLVpnYB685V8UTSj1GkBHd8ojQCefv58CXuP5zc7+/1rwvFII3JEU4hijDiYc9tSiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDhCORUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B3BC4CEF5;
	Wed, 10 Sep 2025 10:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757500726;
	bh=FkQ1EMvCWPyVw5lidXqwG1FjiH6rcwMTyeVpnQL7iYs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=DDhCORUe6nftvRzEoFY1vbSelx3f/iGw2uYuNbaAcVgseNN/mfyURBV86hjxabZK+
	 8RX42g2zP4diN9agjREtpXjxjr0qCOJFS4JooVFJ2Fx3RMeYDK9ITAVAQG+rLd4tVd
	 Hib5R7lWkr/u0tBeXeiB1YUiF+7kDn/lEVhRaRIRi6Xff7b6jg2aAUuHU+U/gJJPyB
	 2Zbq9duMT75XsuRzyJJUuNSKuIhz+q2MGw/Ysgd39LBLAijkS1Y1ZYvoBbGTaBopM2
	 apAgC1De/4sHwucMoTwEqM4RdJqcCkzHVpvrllf820mE8CqB1VycGYpGD/48RryJFb
	 /pK6JEppGlMSw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 12:38:41 +0200
Message-Id: <DCP20DIJQAPL.27RYRE2FWAPT6@kernel.org>
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
 <CAH5fLgi5M+9gaH8QmwLd=7Gto7C6nceLd6g25a4O7hcrax16kQ@mail.gmail.com>
In-Reply-To: <CAH5fLgi5M+9gaH8QmwLd=7Gto7C6nceLd6g25a4O7hcrax16kQ@mail.gmail.com>

On Wed Sep 10, 2025 at 12:24 PM CEST, Alice Ryhl wrote:
> On Wed, Sep 10, 2025 at 12:23=E2=80=AFPM Alice Ryhl <aliceryhl@google.com=
> wrote:
>>
>> On Fri, Sep 5, 2025 at 7:12=E2=80=AFPM Benno Lossin <lossin@kernel.org> =
wrote:
>> >
>> > Make the `#[pin_data]` macro generate a `*Projection` struct that hold=
s
>> > either `Pin<&mut Field>` or `&mut Field` for every field of the origin=
al
>> > struct. Which version is chosen depends on weather there is a `#[pin]`
>> > or not respectively. Access to this projected version is enabled throu=
gh
>> > generating `fn project(self: Pin<&mut Self>) -> SelfProjection<'_>`.
>> >
>> > Link: https://github.com/Rust-for-Linux/pin-init/pull/75/commits/2d698=
367d646c7ede90e01aa22842c1002d017b3
>> > [ Adapt workqueue to use the new projection instead of its own, custom
>> >   one - Benno ]
>> > Signed-off-by: Benno Lossin <lossin@kernel.org>
>> > ---
>> >  rust/kernel/workqueue.rs    | 10 ++-----
>> >  rust/pin-init/src/macros.rs | 60 ++++++++++++++++++++++++++++++++++++=
+
>> >  2 files changed, 62 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
>> > index b9343d5bc00f..6ca14c629643 100644
>> > --- a/rust/kernel/workqueue.rs
>> > +++ b/rust/kernel/workqueue.rs
>> > @@ -356,18 +356,12 @@ struct ClosureWork<T> {
>> >      func: Option<T>,
>> >  }
>> >
>> > -impl<T> ClosureWork<T> {
>> > -    fn project(self: Pin<&mut Self>) -> &mut Option<T> {
>> > -        // SAFETY: The `func` field is not structurally pinned.
>> > -        unsafe { &mut self.get_unchecked_mut().func }
>> > -    }
>> > -}
>> > -
>> >  impl<T: FnOnce()> WorkItem for ClosureWork<T> {
>> >      type Pointer =3D Pin<KBox<Self>>;
>> >
>> >      fn run(mut this: Pin<KBox<Self>>) {
>> > -        if let Some(func) =3D this.as_mut().project().take() {
>> > +        if let Some(func) =3D this.as_mut().project().func.take() {
>> > +            // if let Some(func) =3D this.as_mut().project_func().tak=
e() {
>
> Spurious comment.

Oh yeah, will remove on apply.

---
Cheers,
Benno

