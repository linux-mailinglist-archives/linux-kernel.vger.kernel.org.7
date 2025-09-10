Return-Path: <linux-kernel+bounces-810008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BE1B51491
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A42E54E11F8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219A33148CE;
	Wed, 10 Sep 2025 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5U9Q3DU"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49973115A2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501715; cv=none; b=GIAVn/fXRDWRxX/Gbo2+Y6KM8iqWDsjYY3JJ6mFHAFF19QCL/PGjpa+nSU4A+7KNt8IlwcrBQ9ZG2ob9nWCOWjwqZgD21koxbuEAJfJhMIa+UC75XxG553fJl6Ew56M8g1cFurftxGAvEJpgTdKaOr9kSuhkVjeeKkNr5VjOIMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501715; c=relaxed/simple;
	bh=MAGVA123E1gAKnR4p9rAiRHSHpo8wtnSVtT+I88iagY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhuFhs3w9PYENxA7yoKb7lXLUxnL8JHZZtUp95ZA+yTJYDHukfD74Ic4YloVJSw4KxXvLG7kUcyWslVvYu09mhX1KJrgxk4GcSTJLQP+E1tK8n1oYQCxogyMz8dbySHYO5iXhgXCERklcpeugHnqsiuDEdz31RMs4NOUwELQtuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r5U9Q3DU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45cb5492350so43912585e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757501712; x=1758106512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GoaN9JHJEw/teQcETOteCH6EEDHiKVDQmJXwf3Tgro=;
        b=r5U9Q3DUFJ5hxmWnUOWzV+Ede3X8YobFK8HfPAVx4vwFkkHfmmIrGk0XQxjQtDwPBN
         PFpY/iTkLjCfaS9ggFMNM7uHrRD1dGP7QZ2ZbDz75M7KdcDgzp4jhSCw6nz53N8irgQH
         6XY/hBXjCSsMZalxUuJMlU9u3IQRszgXFY1AdRnaLL9kS0aq6yCDQAHq0qWYy1WtGijY
         TNiEq6qGaCCUCYxxw5MG1J79Qyi4Ap7CT8fsmcuZHA29Nhd/s5JKBCVi9aGT53vP14ys
         CtpTFs4+SycMPC1gTc6evIoWlqjB0FJCEnLXAM4jYcKsJe+X78pBrcsc4Gb3r4dNd/Lo
         Gi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757501712; x=1758106512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GoaN9JHJEw/teQcETOteCH6EEDHiKVDQmJXwf3Tgro=;
        b=XN8TXTCnOhqc3cjeCSi0pQYN/Doq/llZyO+47Yduo78kkxyjGFzdhzOew5zw8cuQnr
         u9hTEntkyhtJyIIRngrh0eF8HGnbj5fVPPFr124IBvm0eKYORzjCI1lW8EJYnXu2Ft2a
         ovSF9AFjbMk0L0r6wFzVo7M9AgoQFiEQiEeIYHhcst5HE6MEYmY9OlDBMH0lCillevJx
         7fw8scz+JypFS5WuF6aGokWVpXPJNMmf8EwO8GAsiSmggZ0toHpv9edpqJwmytQpBx7m
         RTp3Hi72uN0em9x25pCEjJB812B5E0jmG4Idk8yLDbK7QEpocTVLPkcWfc9fNoZlQZdS
         PA0A==
X-Forwarded-Encrypted: i=1; AJvYcCV6tKT/PfMSCCDo3kqM6AklkVparWvjL2DKFMsJfFxGuRs2MHapEoVFfXKlJwtEsSf08yfpgUxE4/BGYSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwakBuW2D0aefV2+MyTQLndM+uPXh3kmcOkABmOTuicNmhVIKyJ
	fiEp0VHWXkl1il3U73om0gjv3HvAC3laB2N3gUeD+op3uUV+6iXLoAYuULKwrMW3+MBDsqQwwBe
	fIgAWz4pVRMvc9RJWVg8UAmvgttU0lB9/2VdjO9oN
X-Gm-Gg: ASbGncsswW1xdXoHN11VN/7B7eMiXwnkwygV8o9rbX9sBCCNG/edyhJkLO3xeTheuCk
	+iEbZuJub3khL05feJ54uYd2icCGq0pbs3ly/qMKT2NpX9IlsvjJPLH4tBIN7cRrudXbqam/Ck7
	S4xN9CGiec7LS5uiM3hZ2etMwfCdb4aYuG0Drd1MB/etE8715lr6IgAbBlVZGXmdKgk0iTrbE1i
	NwwlvLo36ElOdmphoNG4aee49iIAw2qeeZLfl1PHtfakJI=
X-Google-Smtp-Source: AGHT+IHuVlz3mBU+3JdqlREPhQlnzTh1ay0yxBCt9FPbgZqYpY6Q5iWmldRZF+lHNpILkuXX7zM/RDjJmc9fPMlNWiY=
X-Received: by 2002:a05:600c:1912:b0:45d:f804:b843 with SMTP id
 5b1f17b1804b1-45df804ba63mr17138565e9.19.1757501712098; Wed, 10 Sep 2025
 03:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905171209.944599-1-lossin@kernel.org> <20250905171209.944599-2-lossin@kernel.org>
 <CAH5fLgjD+S0nBvDMuTfMYd6-o-3f=xGztk+jZQRhm1_vmNiHAw@mail.gmail.com> <DCP1ZX3ASX86.2LS8OQBF4DPL9@kernel.org>
In-Reply-To: <DCP1ZX3ASX86.2LS8OQBF4DPL9@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 10 Sep 2025 12:54:59 +0200
X-Gm-Features: AS18NWBmw44nmRiKv1qM6qRJMsYNejPw9DO4HnIzbMp8JGPQSc2nif9fDYEnv8A
Message-ID: <CAH5fLghfeWZ1FYdgQKQ7aBftHEGgXPYZ9WTWueTSZxxtaaRB1A@mail.gmail.com>
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

On Wed, Sep 10, 2025 at 12:38=E2=80=AFPM Benno Lossin <lossin@kernel.org> w=
rote:
>
> On Wed Sep 10, 2025 at 12:23 PM CEST, Alice Ryhl wrote:
> > On Fri, Sep 5, 2025 at 7:12=E2=80=AFPM Benno Lossin <lossin@kernel.org>=
 wrote:
> >> +    (make_pin_projections:
> >> +        @vis($vis:vis),
> >> +        @name($name:ident),
> >> +        @impl_generics($($impl_generics:tt)*),
> >> +        @ty_generics($($ty_generics:tt)*),
> >> +        @decl_generics($($decl_generics:tt)*),
> >> +        @where($($whr:tt)*),
> >> +        @pinned($($(#[$($p_attr:tt)*])* $pvis:vis $p_field:ident : $p=
_type:ty),* $(,)?),
> >> +        @not_pinned($($(#[$($attr:tt)*])* $fvis:vis $field:ident : $t=
ype:ty),* $(,)?),
> >> +    ) =3D> {
> >> +        $crate::macros::paste! {
> >> +            #[doc(hidden)]
> >> +            $vis struct [< $name Projection >] <'__pin, $($decl_gener=
ics)*> {
> >
> > I'm not sure we want $vis here. That's the visibility of the original
> > struct, but I don't think we want it to be pub just because the struct
> > is.
>
> Why shouldn't it be pub if the original is pub? I don't really
> understand the concern, since the fields themselves will still have the
> correct visibility. Additionally, there is the `___pin_phantom_data`
> field that's always private, so you cannot construct this outside of the
> module.

I mean, for instance, it's going to mean that every single struct that
wraps Opaque in a private field will get a useless pub function called
project that will appear in html docs.

Pin-project limits the visibility to pub(crate) when the struct is pub.

Alice

