Return-Path: <linux-kernel+bounces-849194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 084D6BCF79D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 16:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 814B134B415
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 14:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9663427F163;
	Sat, 11 Oct 2025 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Adck1bBh"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B527EFEE
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760194394; cv=none; b=hD2eo2SZ0y7HQC7RnaMA35Onpcx3WkUAJTo5RIdBUGQ3tDCfm49qUjMGr0YvKUpjRDUgZnZiJAg7U4fm4XW35tGpfCN1VxaftpfFS3yfPc2YF85+gn7pxzsuV3tHpbjKPabiETY5WqQ+hiLio2lDhtX13HGCdq3+7X18H/9q350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760194394; c=relaxed/simple;
	bh=deCTSpq54gpA3efQXgVanMT20C+waxkdc3m30B3Qeo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pe+Vx9Urc0VqHPjx+vbVJczQa8OtqGuIFLTr2UiSlwJRY7yEp07Ljh9tBcZNLRDyB26wZbzJBpcOtOq5g2JukmRlW+QbFFwk4/L1KHFjo4o/Ljyp4mDPX4eZCMJUSr7PWe+JO1uEurxbqsdVTET7iTdmFdCu6W9cEAKdEeajijM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Adck1bBh; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-42f95010871so10338145ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 07:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760194392; x=1760799192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ax786NHBHHpTg8NhBwV3RBjSy/8C3s4oYnbb7WT6QLw=;
        b=Adck1bBh2gOUppzn/MguotEOxYEK/ShSzRmf0FLf2D7rjA9VxLcopILGT5arTDLld+
         feyhrgqOqyGqn5yH5Cx4uiRv8kXbuQpd+X8Wmshid0NCiSJn/EKBJszbbiFCOXWvSiL+
         zDK45L1jWMu1D3XFLwFpPp2vBsOwHHr9Uoia/FhCasPMYFbIDS51PqFvr24uLguHxX5r
         ZiMLq1BnVzXAi/wvOFqpN/lKfIpCLSCuDOw/iN5vOrH/iJckszUBPph6D4virHeQl/RY
         wCmM9dPgbg9OtYW8swpwXbEFu54QdLD1E1h4bTeXvBMCtzRHRw5M+C8jYeZLghQnanR/
         ktEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760194392; x=1760799192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ax786NHBHHpTg8NhBwV3RBjSy/8C3s4oYnbb7WT6QLw=;
        b=WehBD8wgWOaUHN52wuxEEV906h8OEKWxaw/MCvl0QtrIMf0wBGZ2klqgGgqXJiojvD
         TidTS0xoQkLGmDAUCp/1OlksV5obmMwAvq5VI1ODWH6fCQdERUvtc9Ict3ECMHE5e6XQ
         82X7jZKi9n2/7iThv3Cs9Xlr6Y0jlX44IkcOnqToxyNQa9+JMm5ffRMZg6+HLPtK2idX
         lsybJeQVjN7+4eQGZl+Ewt1fpHvvKfl5PiM1zT42+nVmiPlH1Pp8SfYL3ARhhb8nf3V4
         QFcZzoTahZMBRVMuH6gp0JeA+OFLSNZ8CtQVAKdM/Mh7kN5BDvwceIb/ua5JmvoCXOFv
         sFTA==
X-Forwarded-Encrypted: i=1; AJvYcCW7NpRd/xcvQx+bgMc9jw2dbhWzx2XEFmfVrIA1Wnr/hM8yVuCetbANomhf/VsMheA6sUCLTcOk/FIn7Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJXiua6ueeyD7f6I1kBExyql1nOzaobq0OJ++i42Vu55PIE50N
	7od9I3+tsqJG6MkYgLnOcO40ofuhp+yktflfRUWBKlicUeruhKm9oH6jgfpEm2OQL3YPUuFvFRT
	nAnADq7hF/W8WbtUJMwB0O42TUYAyezk=
X-Gm-Gg: ASbGnctEzTlFzkyAL894rOOzD75NdssgMyao/OmzTLJAf2Et83bH5/hjJ/Si5mbki5K
	0G9IenntkFl2qpnxdxkM/9gEB6JENCxUOQXovX60ndORcFMDiPTTyhqS45QbhSAuQJ59dTIn12h
	vPWFRPpqjirPPFcDywTQQmB2+0Fo2lyEYEfka/TJvInkidmx3pu6SsgHBLma5MKzaqRDX1fbTmb
	rWu2mO/PVt4KErwr1qp0nSnMtB5QFo7xSMfgtaqoxIlGSS1vg2v
X-Google-Smtp-Source: AGHT+IGelNAChiwvd1QIIsVjXT8otgdB/o8fUu1FJvzWGsfqv3ACbWv9Myx5ycGYbMHeIh8AcUX+c3ga6qd1PGeON+w=
X-Received: by 2002:a05:6e02:148d:b0:42f:9708:168f with SMTP id
 e9e14a558f8ab-42f9708183emr109556905ab.16.1760194392237; Sat, 11 Oct 2025
 07:53:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755235180.git.y.j3ms.n@gmail.com> <CANiq72nbERSOWKRUTJ96YYKCDeAoHLBuiVP+XkDUKg7JYkoyiA@mail.gmail.com>
 <CA+tqQ4KG98XcWh3rkAxEOiACSUtPf7KM0Wqh9Af=POgVDHJzzw@mail.gmail.com> <CANiq72kE89ukxpf3L0_jFOdv51TDtjjj3r=1mjJzdGWJwmAbaQ@mail.gmail.com>
In-Reply-To: <CANiq72kE89ukxpf3L0_jFOdv51TDtjjj3r=1mjJzdGWJwmAbaQ@mail.gmail.com>
From: Jesung Yang <y.j3ms.n@gmail.com>
Date: Sat, 11 Oct 2025 23:53:00 +0900
X-Gm-Features: AS18NWBxitqWPgx67xtxY0Tu7rDxhSjoDZ4dv9U5mH8wQ6n3kHU_eUVN0pCdWYk
Message-ID: <CA+tqQ4J7_z7_NmUNojJttF1e8GRR8Ua9w0Rap1t-U4gYPhQ1Yg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] rust: add `TryFrom` and `Into` derive macros
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 10, 2025 at 10:04=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
[...]
> But what case do you think we cannot assert? We can always take the
> discriminant and reject whatever inputs (e.g. ranges) we decide, no?
> And we know what type we are going into, so we can always decide what
> the values to check will be, i.e. we could in principle even support
> infallible conversions of the discriminant to other types like, say,
> the bounded integers or powers of two.
>
> Maybe the issue is in what you say at "the discriminant value
> interpreted as the target type" -- I am not sure what you mean by
> "interpreted", i.e. I would think of this as accepting only some bit
> patterns, i.e. working with in the discriminant space, not the target
> type one.
>
> I may be missing something, but in any case, at the end of the day,
> within a proc macro "everything" should be possible one way or another
> -- even if we had to inspect manually the literals :) And it seems
> worth to remove the pitfall.
>
> If really needed, we can always drop support for certain combinations.
> We already do, in the sense that we don't cover every single other
> type out there, like the ones I mention above, e.g. `Alignment`. But,
> just in case, I assume with that approach you mean skipping some
> combinations early (the ones that cannot be checked) and then still
> asserting the discriminants, right? Otherwise the caveat is still
> there.

Sorry about the confusion -- the rough sketch I shared earlier had
several mistakes.

My actual intention was to emit a compile-time error using
`compile_error!()` whenever a conversion could overflow. With this
approach, the caveat wouldn't exist, since proc macro users wouldn't be
able to generate `TryFrom` or `Into` (`From`) implementations that
could potentially cause overflow issues. For example:

    // This emits a compile-time error because not all `i128` values
    // can be converted to `u128`, even though 0 and 1 are valid `u128`
    // values.
    #[derive(TryFrom, Into)]
    #[try_from(u128)]
    #[into(u128)]
    #[repr(i128)]
    enum MyEnum {
        A =3D 0,
        B =3D 1,
    }

To make this idea work as intended, I should have revised the earlier
sketch as follows:

- const U128_ALLOWED: [&str; 9] =3D
-     ["u8", "i8", "u16", "i16", "i32", "u32", "u64", "i64", "u128"];
- const I128_ALLOWED: [&str; 9] =3D
-     ["u8", "i8", "u16", "i16", "i32", "u32", "u64", "i64", "i128"];
+ // Allowed helper inputs when `repr(u128)` is used.
+ const U128_ALLOWED: [&str; 1] =3D ["u128"];
+ // Allowed helper inputs when `repr(i128)` is used.
+ const I128_ALLOWED: [&str; 1] =3D ["i128"];

The downside of this approach is that, as you can see, it is overly
restrictive for large target types such as `u128` and `i128`, because
the remaining numeric types cannot accommodate their full range. As a
result, the macros could reject some valid use cases, for example when
the actual discriminants can be converted without overflow, since the
check operates at the type level rather than on specific discriminants.

Considering this, and as you suggested, I think the right direction is
to introduce a compile-time check for each discriminant. I initially
thought it would be difficult, but after some exploration, it seems
doable.

Thanks a lot for your feedback, I really appreciate it!

Best Regards,
Jesung

> Thanks!
>
> Cheers,
> Miguel

