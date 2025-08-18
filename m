Return-Path: <linux-kernel+bounces-774536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A11B2B3EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EEB81B623AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A9927AC4D;
	Mon, 18 Aug 2025 22:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eUyIgmSg"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1388427A925
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755554769; cv=none; b=jAOOHPg4VbRzZfDI2gy63apteqQ9y02qisA0TnX/BgNTs9zdPsBepxAggWqe4eTuhJdelRKXsHJlGmLB8U1FVuyXyS6BN5TDVsZ/OiNflbOE3vgNAehmu1dZazZ7t912uqMjtju5kJuRmqqBAlfxU9EeV1skVsvjdSm438hXMng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755554769; c=relaxed/simple;
	bh=N3tSa4eZY9kU9rIayo2ksXQAHAw93ivpiznq9dIOADU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eeH0v4UQkmqqXCNsxFwQSiVhg9woIE8p0JT1p0gBzG1Dsk30WW0XL8HdoEFoh0ExO8R3gP/doSpQB8vHRk/FGMDSJR8hyBL/BQI66quMC/BEhGTboeUjG7xOBYzhmV8+yTeYAGItAyWlD9s2yDFq42VZ6B2qkJRkepJVrS3yx/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eUyIgmSg; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9a342e8ffso3294365f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755554765; x=1756159565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3tSa4eZY9kU9rIayo2ksXQAHAw93ivpiznq9dIOADU=;
        b=eUyIgmSgwMGpxG3HtV2ALZmX11xFjEi2wLVICOcCfZfpwYmswf8Qevd5opmgNFMq7S
         dheQlOqCEMGkJGBZXtgrmgqstBdlKfn0bliEFCutds6KF0E0iMB26JBNUmPifDudoLxb
         ESjqoSm88S2CN6dgg+ZI2jV+Y8XpNeb/8ciZxzGEZUIGhb9z7pHEVSeC8R7RxS8DL/3q
         ZlPJxqnLpQIORfxSmGSP17YbJB4zycLEpqSx7EynpU+P5V2URqezTe1nk1rNAyvxompk
         8YXPaJmI1RxHDj4HEJezrVUHT3unTJdSlJjRCtZQ2Xud9wh2EjYGxp9tui9S4FLX/CHV
         ovcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755554765; x=1756159565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3tSa4eZY9kU9rIayo2ksXQAHAw93ivpiznq9dIOADU=;
        b=M39P9DlWm4HwMIlI/0Vgh1bEOJXpdg+Cnn2hFll9fbCn+rCYFl2UybiIdN/6tLuveu
         74RbicTiobNHgbBvK2hiZDUKnQqk3QuTA69X0vnvJVHOJ7jbOLj+BZeLdfVZK6GpkEji
         8maOck9t4gNlgvtK+qeYtOov3KDLxDxCjE2J9twZiuslzoUsxPyUD5MSd3Bia5QjZ1Mb
         al4WthgejZgx+OcBOdxlmcZiWhAoc5g+EJL27hIDDlwFguGG3V4jwBmX8RynjrH7V0JK
         qUQn9DggI+f5R0/PW+KIGctkEzr1J/Mi4ZHX4ayxNwkwxrXRmD405TsP58OWb0Pqsmf4
         aXLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtWUbFaPq0HpMwZ9IUh3Ac3ke0J+mQ4s1hjQBf3CNjnYrr6GhnC5pFLi4ZmI4aZ/31rMvOzryJxC9/Apw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy33uSBvK9NY1Agupbl7khM8DXRa4NBYXEdxeKWjxK5btCgomwf
	S9++WwQx5NwMa534MDeVjP/xBnhqEh1xacgqW/+gIPAj4hfThTyq9MFBGXTXge/Nwy3teT9D3CC
	x21Lg7KzgsKPCeIVfaYwkwZTnlpzg6wXZYIpflhDp
X-Gm-Gg: ASbGncuzwexR3qTlLGocS3mAb2/Mr1DX6uCbu2EpIooV1wE09gqyFBkSmW53CJNd0ud
	AmLTFgoan++TDETBliHk3si4kyZKfg/pfZMjoRjoOYmd4EsOblrss80YYHCZQS62Z9ZlJf62hGt
	ISvZV/y3owFMdpOgWLiPEfIsLvaNt7H8kEbVY31rj4dKXPlhx7ZJyKbS0o0ETaiuf2yvnypDI01
	45GmgvkLIUsRaGNVLmYDsWXYg==
X-Google-Smtp-Source: AGHT+IFCQt6uTdxNJOL8MDlH+UvsjGsdlpD1gJo+LDPFtuqTKkPLiGhf2m1VSyVS6vfpJ8pjthhmwUtwki2fM1T2D9w=
X-Received: by 2002:a5d:5d0a:0:b0:3b7:8acf:1887 with SMTP id
 ffacd0b85a97d-3c1333b5d05mr49367f8f.13.1755554765184; Mon, 18 Aug 2025
 15:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816114409.10107-1-shankari.ak0208@gmail.com>
 <aKKdULYbLFRMS9qe@mail.hallyn.com> <CAHC9VhRwpYx0jVybcAnGdm4AGDno-GwyCzZCS7U+56Fwu2tuCg@mail.gmail.com>
In-Reply-To: <CAHC9VhRwpYx0jVybcAnGdm4AGDno-GwyCzZCS7U+56Fwu2tuCg@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 19 Aug 2025 00:05:52 +0200
X-Gm-Features: Ac12FXxHVkHHjsjzroxYO2hLV5awVzQ5ch9P37B2T1QViWU5EDCtAQkTwIhqx1E
Message-ID: <CAH5fLgin9OhTmf52i2hQKztYLcHTxE+n1gMPXDFN83atE+u_oA@mail.gmail.com>
Subject: Re: [PATCH] rust: cred: update AlwaysRefCounted import to sync::aref
To: Paul Moore <paul@paul-moore.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Shankari Anand <shankari.ak0208@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 11:22=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Sun, Aug 17, 2025 at 11:26=E2=80=AFPM Serge E. Hallyn <serge@hallyn.co=
m> wrote:
> > On Sat, Aug 16, 2025 at 05:14:09PM +0530, Shankari Anand wrote:
> > > Update the import of `AlwaysRefCounted` in `cred.rs` to use `sync::ar=
ef`
> > > instead of `types`.
> >
> > Thank you for forwarding, Miguel.
> >
> > As far as I can see from the included links, this looks good.
> >
> > > This is part of the ongoing effort to move `ARef` and
> > > `AlwaysRefCounted` to the `sync` module for better modularity.
> > >
> > > Suggested-by: Benno Lossin <lossin@kernel.org>
> > > Link: https://github.com/Rust-for-Linux/linux/issues/1173
> > > Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> > Acked-by: Serge Hallyn <serge@hallyn.com>
>
> As mentioned previously, I'm still not well versed in Rust so as long
> as Serge is happy with it, I'm good with it too :)
>
> I'm guessing it probably makes sense to include rust/kernel/cred.rs in
> the creds MAINTAINERS section just as we did (or will do) with the LSM
> Rust shim?

That would make sense to me.

My understanding is that this patch, unlike the pin-init one, is
intended to go through the LSM / CRED tree rather than taking
everything through a shared tree with Acked-bys.

Alice

