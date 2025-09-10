Return-Path: <linux-kernel+bounces-810172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569E3B516DF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D81172DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1FA3191DE;
	Wed, 10 Sep 2025 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="moTNvFDW"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130E92749E2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507305; cv=none; b=IsyNNGySSEE2fMB22G4iY7rz/tJIMnNURXIr1f5yokOSrg3GFaOuwhQA8lbYgnS7nPwuhqdkfVaHwVZ9VcHlfakJ1EilQoAX22+5Z9rYmT+mwpw+nf5GE8fK4chbG/g88jYhZZIV8eJlWNk/pJuAd7o+1J69gFPXpytt+IKtCAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507305; c=relaxed/simple;
	bh=6iRbUz6HNcivZBZXhhr6c48doSj9UQKZZWm65LBXZeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIqkXxoDGSqJ5wYzNSRikAJZivLWGpJ0OEd77MN7j0dtsRzVT2ah0XyKcgjiy39kRi5xG1HEIDeHltrYKqN42SJVhCPRp0FaQzx248YmUCvz67ou6P0h89j/MuuEXDRMymGskGVCoi34MOtex39YyM6rMFVwCVMY9QSUkAXbOt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=moTNvFDW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45df656889cso8141745e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 05:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757507302; x=1758112102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/llJ8V5aprdAFv039Ka3XSsdbWtR5dUVaUyCb0W042g=;
        b=moTNvFDWNhajhYCwS5l4XLZHeOr2Ed2m08qkmA3tk2kQq0HfhV64O2xxqzqsza1Aql
         JzX2XYNcfFRUSC7kckVXIPAdSd6lqPsFVFQcTWca6q2r7tWnwwhCuWcnve5/0eIIy+h1
         YTd9NYYRUVlPxJps5dzEzw5CgJZneb/b6m673P0BSzJ8dC3asIpHbJ5c0bdzgKOP1SgE
         IEox/uxg0s0x7HZqxSEV0ziS0tPOfr3PVIUJ/iID+KcCV77b3kQ7o579r1sLeUczfDRL
         cj4yy3a+6cgDkzTULX7j7mOfzWfZ5+HWJEHJ1SFiUSptehvIT3BH4cMvNnI3y+ivEFJ9
         uoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757507302; x=1758112102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/llJ8V5aprdAFv039Ka3XSsdbWtR5dUVaUyCb0W042g=;
        b=iQs27d64gVLUpz9V8isH0V42lIHyPxg7+UnrTXHBQCpMVDuKFGjJ9duCdGmNUDVv+f
         goScOCMR1tuJrBBq2XgAEwHOL9H3vBPLabN8Td3oQgvgLu0N+hTgNWCnL+NsyP1UctmS
         QBobefKHYHAEU8RbhbSp/GtSkcqzFBZyR6gpXiAIRx1e16MOeaCy1jMEcDg1JBobt/td
         ieZ5ErA1n2RH7Nymq5VvhyNnZFnto3M0iA9JVBqXBo37W/OfHCoLXJu2KVLt4Ij2JpX+
         yGz9wQPGxar7NEpksE0uXuuG/H5JLBlp2+TaArhHHmE0W1Xgbqc06nVohVXgkv1DVuQz
         4P/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlibOshd+8wozWZXmi5YTJWn56HTmnzk4mJV5O6oNI/isHVUEdn8ueDqpfumXYeUHozV4W6wQ9gcjdk48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+WAVU0vP9jPlwIVau/rvwrLDj84C5wbUGKQq0ToqpQwhQP0C+
	Qnbh2wmZYIuzogwXUkbODf/ShltW9f7KTVpldWRyrWyTuv4tq4BLESbDIaRo9+rp4KLNCvrbVod
	lpas7qIYZLBXen5PEKg689/8Dg/K9Q+yFOXayk8fg
X-Gm-Gg: ASbGncsIkAlZkTAEX/7KXr45mrbagBOph9AYrv4ZUMzjvfcWpEd2KJ0tlSNsuYRnrJE
	HhaOzGjs6cwiCr3197qPU4wgj9KBx7MAjnwoXSSe68hnSY5FoARqgtAU+6qonX0n2fLhlOvNWR6
	Lq7IGyHgXo1kd7nti/kux3qNVCCKx0ENO6bC3xGuXwLXHfkNVI2BJYbKAFodeKqdRGYbhuXwGgB
	tLx9ws/Ew/i0S8pBpGpX6zDrJHGJUwb5C/bG5eTIlrF4FgLARaQ4n6z4+00wOmLiq4i
X-Google-Smtp-Source: AGHT+IEq9O3ERwBV1bYCD+HGg+BbVyCIq5fLNlsBzLj9IwTx5FL6jJtPrmUlaDuCrfISHoE17NfIUKFnAKXMMOjoSgE=
X-Received: by 2002:a05:6000:2285:b0:3e7:4334:2afe with SMTP id
 ffacd0b85a97d-3e743342e6cmr12660961f8f.5.1757507302140; Wed, 10 Sep 2025
 05:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905171209.944599-1-lossin@kernel.org> <20250905171209.944599-2-lossin@kernel.org>
 <CAH5fLgjD+S0nBvDMuTfMYd6-o-3f=xGztk+jZQRhm1_vmNiHAw@mail.gmail.com>
 <DCP1ZX3ASX86.2LS8OQBF4DPL9@kernel.org> <CAH5fLghfeWZ1FYdgQKQ7aBftHEGgXPYZ9WTWueTSZxxtaaRB1A@mail.gmail.com>
 <DCP44KG3HEKL.35ANJWT161W6M@kernel.org>
In-Reply-To: <DCP44KG3HEKL.35ANJWT161W6M@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 10 Sep 2025 14:28:10 +0200
X-Gm-Features: AS18NWD0FBwqqEl2G5VaaKSePEClUp1I2lUWpw29y5tah7QMoK9mQ9yF-5sIObs
Message-ID: <CAH5fLgjZnnPRLn8LpaXrQ4hbqig07+N=7q7b0E+9JL1hnXCOVg@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: pin-init: add pin projections to `#[pin_data]`
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tejun Heo <tj@kernel.org>, Tamir Duberstein <tamird@gmail.com>, 
	Dirk Behme <dirk.behme@gmail.com>, Alban Kurti <kurti@invicto.ai>, Fiona Behrens <me@kloenk.dev>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 2:18=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> On Wed Sep 10, 2025 at 12:54 PM CEST, Alice Ryhl wrote:
> > On Wed, Sep 10, 2025 at 12:38=E2=80=AFPM Benno Lossin <lossin@kernel.or=
g> wrote:
> >>
> >> On Wed Sep 10, 2025 at 12:23 PM CEST, Alice Ryhl wrote:
> >> > On Fri, Sep 5, 2025 at 7:12=E2=80=AFPM Benno Lossin <lossin@kernel.o=
rg> wrote:
> >> >> +    (make_pin_projections:
> >> >> +        @vis($vis:vis),
> >> >> +        @name($name:ident),
> >> >> +        @impl_generics($($impl_generics:tt)*),
> >> >> +        @ty_generics($($ty_generics:tt)*),
> >> >> +        @decl_generics($($decl_generics:tt)*),
> >> >> +        @where($($whr:tt)*),
> >> >> +        @pinned($($(#[$($p_attr:tt)*])* $pvis:vis $p_field:ident :=
 $p_type:ty),* $(,)?),
> >> >> +        @not_pinned($($(#[$($attr:tt)*])* $fvis:vis $field:ident :=
 $type:ty),* $(,)?),
> >> >> +    ) =3D> {
> >> >> +        $crate::macros::paste! {
> >> >> +            #[doc(hidden)]
> >> >> +            $vis struct [< $name Projection >] <'__pin, $($decl_ge=
nerics)*> {
> >> >
> >> > I'm not sure we want $vis here. That's the visibility of the origina=
l
> >> > struct, but I don't think we want it to be pub just because the stru=
ct
> >> > is.
> >>
> >> Why shouldn't it be pub if the original is pub? I don't really
> >> understand the concern, since the fields themselves will still have th=
e
> >> correct visibility. Additionally, there is the `___pin_phantom_data`
> >> field that's always private, so you cannot construct this outside of t=
he
> >> module.
> >
> > I mean, for instance, it's going to mean that every single struct that
> > wraps Opaque in a private field will get a useless pub function called
> > project that will appear in html docs.
>
> It's `#[doc(hidden)]` :)
>
> > Pin-project limits the visibility to pub(crate) when the struct is pub.
>
> I think I would have to look inside the `vis` to recreate that behavior,
> so I'd rather do it as a future patch. Thoughts?

You could make the struct and method always pub(crate)?

Alice

