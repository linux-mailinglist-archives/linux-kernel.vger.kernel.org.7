Return-Path: <linux-kernel+bounces-785463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 062BFB34B21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F3B5E0E46
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4483728688C;
	Mon, 25 Aug 2025 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iqu9+aje"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCB1286416;
	Mon, 25 Aug 2025 19:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151511; cv=none; b=hJGLFn4vMk5pi0zie52KvromISZ0gkKFoPEszn0ctzgujf3JF2g6LUYLVSc2g82TLedb3Ch+LYxTaWOlf28F2Fjk8ICmjiEHQLgFE2ulfmHyH6XAmWNFrhDnHGNaFONJwqrwZ3LCVEnN5HtjO+994Mp4+YWrFj2kVFIvhpt60C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151511; c=relaxed/simple;
	bh=Tbekkw7TMt9u3kn+5isYgrjUu2QkneexMVEHiIjInEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZOElb+pLVrmOQZhOYHfyBYhCYuWGEvMNRfNfT8dkP8mgpnLLBG+Wo76aZP2EVNHq1MmYxAk70eeprr6eK8vf/v8dq3hCG9MMDifTIvLOFPdSjmTzeuyJjC6JYtv7Ex5OviBQLzJNRNtLZhAjm1aRfq+9Eehwx1FjMmSj2wBcok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iqu9+aje; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-89253c47a1dso70547241.2;
        Mon, 25 Aug 2025 12:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756151509; x=1756756309; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IEDELcR4+2gugMjD8gvEqiydtOPSltlnlrJMBKC18Z8=;
        b=Iqu9+ajeyRIEfFaUK0e1kfyIycwVUDNhhaCjvaDcZtfM5qFWQkDEKzzRVrghGtH9un
         LvBwT1N5c1WWrh7Ex/KzTJIiCpuQQwKhCr4tKU9ZM3Ioa7OWvGDeQWGpcLrODlBcPG+N
         r07DqweyQSNjEkGd8JSOfVH8u5yIHbxuSm9UGCvqqE9Qf6qlyiv4zhR+JzSk8ROORh34
         Weupw5lqDhNGd5XwzvV/g/n0uEwMn8Li2mi9Aef4BjDGOcesBd8b7ePxiF5TsiVLNB7h
         Lgj4GrVyVMouL0BwGZXy5/qppYdycmmsi8Km+WZDX9tjTweLdXcoxvIbBAA+z49nCJoo
         ILWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756151509; x=1756756309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IEDELcR4+2gugMjD8gvEqiydtOPSltlnlrJMBKC18Z8=;
        b=lrZVrPibE9kwHQmscw3nXfmhWq9WTwKkydrIEo3blaxXaoARqL/H1QOwVy4MU/EgR5
         la+UClcW2FoTSbPHI6T67EGrDnv/agXFV9gzPsKww2KW5zWTC7fbkefzbjNi5+JIctxY
         NDsmO2LDN1vLrQJRkkVhmslZEEv4LKSIK8hv/wRfdX+QdlCVnV77nuhaOxP7iVGAmVYa
         p1Dgl+9SI30ukqZKvTprmRJIkkiFFgudHlY/dmBDaa93ST3gC4LH0JjOjO6m1jzFPWJt
         wFL2U2ejEoTK/NGIcWh2h4iK8p2slqxwg1fi2wD/zFh5HyTzVm0ZvFJkmytPK8I2fcvu
         qtpA==
X-Forwarded-Encrypted: i=1; AJvYcCWDU4rULHjD7QXDwk4P5u0IBZC6Zj1wEdLrhyss3LlWuJoecm5f9X3nuqL+lhSjoQifFQj3IofbJJq3g80=@vger.kernel.org, AJvYcCWmOHoeYFx3p7hg8QIuFhIDd/DekyNaGOJW1ke1FXgUpXYFBNg05y53oALa3UOLx21rDIOgLFu8JzON9b4yXTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws1Ji7WF19KbZXSoDDh/e2AWmFbhy/AVZeHCtkJzZbVbBwgwwx
	4+WcCBtV7oPhtubvsKRu4JPoFkO1YTfFisTcon+NrqUa9LHXZGZuaJf8IlkJ1Plyt3XRJQGi3hL
	Wfm797Sq8WkR/IK6na0ge4OWv9t344xs=
X-Gm-Gg: ASbGnctyd28DvJOvTOpLaQx+nxZhn4ZmY+SdX1m2f98h9LJR7IX2bQ0zR1iCfuGnhVr
	XZLu0r/5rzWyIUEyuw51puP7TVNMmao3lmVCH4FLJ1oI9oYhYRsokvGWd/DejMbuL9ycL3GJglS
	kW9zN2Vx965j9hXrqnDex2SCywRaBGfpH33y8fr5QBsN5H1Kz++kzNPzzDr1mFFE3672533qE3o
	kYdtW7w
X-Google-Smtp-Source: AGHT+IEqVXcLtquCPMTIQMLE4clg2U+3am94kIJBsnXi8tqVuvRxUpdOXLDTUAIgK4BjgVt9/Iy2WyLgr7mF5yEPgAU=
X-Received: by 2002:a05:6102:f8f:b0:50f:781b:8258 with SMTP id
 ada2fe7eead31-51d0c8bf7e8mr1678568137.2.1756151508935; Mon, 25 Aug 2025
 12:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824213134.27079-1-christiansantoslima21@gmail.com> <CANiq72kGh2PS-c1n2Q1g0t24J-b3ctB0kN3GK8RDXhtQMGAtTA@mail.gmail.com>
In-Reply-To: <CANiq72kGh2PS-c1n2Q1g0t24J-b3ctB0kN3GK8RDXhtQMGAtTA@mail.gmail.com>
From: Christian <christiansantoslima21@gmail.com>
Date: Mon, 25 Aug 2025 16:51:36 -0300
X-Gm-Features: Ac12FXwu9LcJjoNvnxXdyiQaZ_NOlzExZp03So8KpAhADq5bhvgQ8CMBUKHoO7o
Message-ID: <CABm2a9fQOMvg4Yjqz2-ba=1HwdXiu_Ep=Jsqz--69Vpec+iRXw@mail.gmail.com>
Subject: Re: [PATCH v10] rust: transmute: Add methods for FromBytes trait
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht, 
	richard120310@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi, Miguel.


> > Link: https://github.com/Rust-for-Linux/linux/issues/1119
> > Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
>
> Please add a link to the original suggestion if possible. If it is the
> link above, then the tags should be in the opposite order.
>
> Did Benno and Alexandre both suggest it?

Benno suggested the link to github in the issue there. Alexandre
helped in most of the design. It was a mistake by my part not to
specify that. Even if it's good, put you too as suggested-by, because
the idea of using `is_aligned` was yours. Maybe Alexandre can put it
there?

If I understand correctly, should be:

Suggested-by: Benno Lossin <benno.lossin@proton.me>,
Link: https://github.com/Rust-for-Linux/linux/issues/1119

Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
Link: https://lore.kernel.org/rust-for-linux/DC5INTQKY0EX.1T4HD6OU8C4PI@nvidia.com/

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://lore.kernel.org/rust-for-linux/CANiq72mnxRquFmjoJemb=3LSq+ZdUfs9J+HXTwM6AavprsVNUg@mail.gmail.com/

> > +/// fn test() -> Option<()> {
> > +///    let raw = [1, 2, 3, 4];
> > +///
> > +///    let result = u32::from_bytes(&raw)?;
> > +///
> > +///    #[cfg(target_endian = "little")]
> > +///    assert_eq!(*result, 0x4030201);
> > +///
> > +///    #[cfg(target_endian = "big")]
> > +///    assert_eq!(*result, 0x1020304);
> > +///
> > +///    Some(())
> > +/// }
>
> Should the function be called? Otherwise, we are only build-testing this.
>
> Should we just remove the function and to it directly at the top-level?

I think just calling `test()` is good, but it's an aesthetic preference.

Thanks,
Christian

