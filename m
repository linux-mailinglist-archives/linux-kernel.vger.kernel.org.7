Return-Path: <linux-kernel+bounces-838128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5C1BAE810
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C543A8C40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC4828C00C;
	Tue, 30 Sep 2025 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0TRGPzD"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3255A1A83ED
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759263184; cv=none; b=Dhrd9MjR4mYRl4K+C25eMQzfJ3gyIC7cRZr5NuCnQCQt7oS1uRh+gmQttDtzjxF/hbQB/ETv/8ORs7aHyDuLz3R+SEC14NSDC/+hUmLGboQzIcLYXuvtRVQNVQZva+gA/7doRzI12OZbf+ehWOqAfEVKWYvlH56xP91os7f+K6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759263184; c=relaxed/simple;
	bh=uZ2S6dKSY8g1rbmRM06pb3DssGvzzzn78HdItZZ7jqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBv8rttAwf19/zlDdYe9UeFf8/tglZUdvoG8UKKix1DHuOKJ6WnZ3AIPvJqdelp54hIr7NHjt8OWl+O0LDNohECs3IsXU38zyTI57gVxHuEWehGOcbvS4GjYmoPG0u/L15f+rC4ikwTO76I5930X8mVLqxwqympZI5d0CvLfJPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0TRGPzD; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5796051ee6aso1248084e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759263181; x=1759867981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vy7D8szbhIRwtgr1N1d15ZOmlMfXdraquxLR+CvWcVg=;
        b=g0TRGPzDupQAninCxfXz0BXWIYAFvJpbUdNKW1UM0XMOnr5vySRZ3QhVO3uIJL6VNN
         VenOsiDxbaahecsm82k5kwFRN/7aR7jDGAf1xsXTCe1o3UyRbTGnx6voSDW+NI2RJEhC
         ZUP69hGAkWEM00vn0iAn6X/6FZlYI80UkJ417J6RuEsUY+oPY4PxATGPcMZxNcCTrqCo
         j72M4LSUvmiBoXphfQ3FwYwFPLx/NjrBep7XWjV5aADpizZcxTCgmBumEt63b9OK2BFB
         JvYoMwOGn8xrMM1/DuMIS+2V8cWILReVBIUl7oggYp1GFoWPuQnYYDLrZwuW+k0O6o9v
         aNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759263181; x=1759867981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vy7D8szbhIRwtgr1N1d15ZOmlMfXdraquxLR+CvWcVg=;
        b=Y28kSKZRw+HxqXCmZzzJ/ghSdKQITq2oD5Dnovx0ptz78OO8hpcl9zNB+9du86hM4v
         vwYcTNMwWrmk3eOBi0pRXbkeut2KwGz1H2c9XcdjEKZUZdrtYvEY6ed7ThkrYfSD52Tk
         c/p6wvX1eKTucxcWCPIX2hCj6Pw3+Q+Vm7GoSRs8p146qdGPy5FbVrgzPuSYhKjNlpvm
         zjkP6uhtMwO0cMVDa0HsdrT3pjlOnbu8uLvH9TUQDs11/LdtZm/0J5n2hZdaqz8GYlqX
         KSTOgk271vMsBQDgR+xpqkLiGclTkkvazFJ6jvHLmvqVXARstryobX4nku6hTYwMfMe9
         9KQw==
X-Forwarded-Encrypted: i=1; AJvYcCXJiKwofIPtfGdF9G0DjJx6EvebQ4i/BL4Qpi+v2SYaoDZ34NREvFzLqL6lZUaSREd8m9smVTxb2urXDxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg7APFvYD75w8VAd+pBht6kIPj1f82irok4CGtcxIGSRKWmzua
	SiB5MrPL19rfKNWnitISGM+3G8YlmBSJRwjalBiFlBEMnDeZN1NKC9IeMmbDuvUG8OdSnrvoGIo
	yT42VmGvaVBUh2cwQNRI24fki6ZNlBWE=
X-Gm-Gg: ASbGncsVJUASmZL1SkmPULJQgoFc6mXkZTZzWGKrE2tHxsknj75raGJS9N6WN4UUTp4
	27QY+ODnZvXPe8QwdmpfM2MujgfT5KuXYkMUy6rQZw3PkamfbQzZ8UQKqHUcxAWYmaFTIqRnd6I
	7bjQSGmgColDV+Pmhf4USx/F4gbi/RPnDgogwc6748DX7LMO+iTXQlmWfveEov84AMGVa4bSX/4
	e1eLPHzjruvnQwdh9thiTd6HsrKC0Wm+7+x12TcM+RXB7RMtXI7Yb7vnH03NDr5pNGkJ2Xj/WjM
	Id0UOYVu+p0puF9SVohGX0cbR/an+OHZJVBkGtPmGvLljzytiKzASRQ6uFjB
X-Google-Smtp-Source: AGHT+IFtvw/2t0q6x52tfdQq5Jy2e/VSbjt1lzNtaWguSG6A/2TPrH6YJ+0urbPzdntmF9O0R56v9RKpZ+3tGWsFzOA=
X-Received: by 2002:a05:6512:3b9a:b0:55f:5965:e4e5 with SMTP id
 2adb3069b0e04-58af9f3d196mr109397e87.6.1759263181040; Tue, 30 Sep 2025
 13:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755235180.git.y.j3ms.n@gmail.com>
In-Reply-To: <cover.1755235180.git.y.j3ms.n@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 30 Sep 2025 22:12:42 +0200
X-Gm-Features: AS18NWCr6YpjKIG8ty5QsX8lB_uHMxpdXprhMtC5CD6I1cvtweLAmRebm3I8mVk
Message-ID: <CANiq72nbERSOWKRUTJ96YYKCDeAoHLBuiVP+XkDUKg7JYkoyiA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] rust: add `TryFrom` and `Into` derive macros
To: Jesung Yang <y.j3ms.n@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 7:32=E2=80=AFAM Jesung Yang <y.j3ms.n@gmail.com> wr=
ote:
>
> This patch series introduces derive macros for `TryFrom` and `Into`
> traits.

I took a quick look -- it is a nice series!

Some notes:

  - My biggest concern is the overflow caveat, which is a fairly big
one if one, especially if one is dealing with runtime values.

    Can we do better? Accessing the discriminant via `as` is available
in const context, and you already have every variant easily available,
so can we check that every variant fits in the relevant target types?

    For instance, by creating some item-level const blocks
(`static_assert!`s) -- dummy example for an unsigned-to-unsigned case:

        const _: () =3D { assert! (E::A as u128 <=3D u8::MAX as u128); };
        const _: () =3D { assert! (E::B as u128 <=3D u8::MAX as u128); };
        ...

    and so on. There may be better ways to do it -- I just quickly
brute forced it that unsigned case with what you already had for
handling variants:

        variants.iter().map(|variant| {
            quote! {
                const _: () =3D { assert!(#enum_ident::#variant as u128
<=3D #ty::MAX as u128); };
            }
        });

    Maybe this was already discussed elsewhere and there is a reason
not to do something like this, but it seems to me that we should try
to avoid that risk.

  - On other news, I will post in the coming days the `syn` patches,
and my plan is to merge them for next cycle, so when those are out,
Benno thought you could give them a go (we can still merge this with
your current approach and then convert, but still, more `syn` users
and converting the existing macros would be nice :).

    (By the way, the linked patches about converting the existing
macros to `syn` are an RFC in the sense that they cannot be applied,
but having `syn` itself is something we already agreed on a long time
ago.)

  - Couple nits: typo arise -> arises, and I would do `repr-rust`
instead of `repr-rs` since that is the anchor in the reference that
you are linking.

Thanks a lot!

Cheers,
Miguel

