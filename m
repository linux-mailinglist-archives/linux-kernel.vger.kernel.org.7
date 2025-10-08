Return-Path: <linux-kernel+bounces-845784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5C5BC6199
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E229A188E99E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33672EC56F;
	Wed,  8 Oct 2025 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyLm4jwx"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94292EBB87
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759942627; cv=none; b=pwlVBqJdd3/uiWgJecC6CUMDHBt9ru5G4Jw+Z95zIbjnsRYqN+YJqakl8XCfeSk6XBbQ8XR/ejJxP1ma6P5c8AJ672+BYC8XAHh9qHC5xgL22SZQzEs2gWyKiMCdulw3hicR95e0x2nQxiUkLEeI48i3M+2VJ8tYL99UFPmPYqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759942627; c=relaxed/simple;
	bh=HDU1bF3pytAw2bYvWqTIIrNFDsE3a9r1wsIR+RF0I38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOuJh8E/IbpLLJBdxY7OgfFX0tdL1oP2zphIIPTi/MDjyxj/GkNZWyKXq2Rc7flwsLPlfVtYaL/p9RPYmxLqk8lFmzfojpoghc8RrMM+ZjvQY9yGYZFTANfhaiu+m5Yq8dR8L0mLKBCKQ+IcNNcm6fJ3hhHLrpoqwavqW37gEdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyLm4jwx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27ec3db6131so58315ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759942625; x=1760547425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtxsZvw7ZUfiZlsMlvMyfedw4t0xzCAElKBhmmA01y8=;
        b=GyLm4jwxP/0XOX/w7UicKMISUGzxHtO0dqsU6LQK80hEuat6u1aUXOOW9eNN2lZYVu
         tQDLyhJO5/zOMFTN/x+vw+HGp8pBDbKstSccHf5Ar/h/EDkAS+k7/3Xx+IYOkzjonloP
         Z8pq3u1rmaFKyKARwuNSmVtWHDrwP7GrvryzqfwT1Csw7V0TriGGIhsjHJRiGVoaP4n3
         6vF/lw0JxGr1KumjhP+p3EN7/KwCYWLhqi8buTE2WYzH9CgXyc1U4aqt1/k/i3PYsXrk
         TGHADTPfN4H7jFRua9VyWln9bgEQgdYQVCM4i5PXZvYK45cWhrju/M8pEpx/45W6utpe
         HYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759942625; x=1760547425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtxsZvw7ZUfiZlsMlvMyfedw4t0xzCAElKBhmmA01y8=;
        b=SleI3zTxqrAaWGd4xavfAWXXstQyOpLUtb7abWVn46rKUV5lMWuns24XRCj3zcYw/v
         eu7aBShG5RZACk61N4UnVHmXMWiIl+5W1MaF14aSZYgt05kn/w2jME4RuKylX6yN7Gxa
         pxlpVnzrfEdd+rtGyurJSVYr0J5xrYXfLHYm/AmEK7d+v6LM4EGpK1sX1h+wG55y7Y/l
         iMnL0TLrWU3UkGXDBfvjA5l7DzbLDbIq4Vi8N+NRqFCdp5UpAHB0BwKBy0MlPT306gHV
         3STD9BDHbHcdh3hQPoje0NdABWUmoE+JBBhyuguSe11dDP8+vPTbRpOh0+wF4itoii5E
         GdgA==
X-Forwarded-Encrypted: i=1; AJvYcCWLNYSoxFI5WiWTUlqwJrgJed64PijbGybDc8HDMar838qCAYdBmhmdooBG6cXDTNk8o6QOGB4zZBHgZpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO9TCSm7g6D30PrEYeI1zoQ8HbwekAlKXjYck1A7kWgQM1URDh
	q6Vv2/l7TQ+f8jZJVMf5C31AG+NOkgCNoKxQQ9OAonqPI/rLvtzN+TLvRGC2rXWQ6DA0l6KDZ4u
	bPhPocakivdulP6ya8JSowsV8wAhBI0Y=
X-Gm-Gg: ASbGncv92OIRjsM/zOYRvZw8ffDbMzqHVhp8WayHmjSMmOdx0iK7iBd5C1Ls2xM0dEq
	8YXkLxSB0uvLJSKpfTwKI7FgKO7FSB1JDqGwjN1xi/Dte/5L4TB5zRr34VGaiyJMsj+Zv5/7cko
	TuuyNyjTyaMCY29Yfo4ar7Cq+7Jcx9Vo/buTRXCvcTCgSNdHvrtLC6WYx0eV9n14SonSnf7sMTt
	O0yekT5re8kYRg8Fdk5Xv3K05gdjZzMTGGif/z9a85R/kICChw4rfBI1YTeBoLmUV9+9ZGjas1S
	5NtMl8AgtJnXu17dxJf3uSKWILrpyTWxQwG8Y24QzwsV3oY37A==
X-Google-Smtp-Source: AGHT+IE+hV5XvZK2LLA5Zj8MS65c8DKZNoLYsUmppQ2+DVDFH0vWuOn4hQEUZM9Ru/QEpwQVpwGiPDgdVyGxI0qTssQ=
X-Received: by 2002:a17:902:d4d2:b0:25c:9c28:b425 with SMTP id
 d9443c01a7336-2902745c0a2mr34349905ad.11.1759942624756; Wed, 08 Oct 2025
 09:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008001253.437911-1-apopple@nvidia.com> <20251008001253.437911-5-apopple@nvidia.com>
In-Reply-To: <20251008001253.437911-5-apopple@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 8 Oct 2025 18:56:52 +0200
X-Gm-Features: AS18NWBIne5rc-AVIeVWCfebGQh2r5eidrg652ppzGpIdVO4I8s2bzW85Um8QvY
Message-ID: <CANiq72k5f3f8Kys40sRmaKR8eeq8-4DsDkWDkwMPZ0A1JSFj8g@mail.gmail.com>
Subject: Re: [PATCH v4 04/13] gpu: nova-core: Add a slice-buffer (sbuffer) datastructure
To: Alistair Popple <apopple@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	dakr@kernel.org, acourbot@nvidia.com, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, John Hubbard <jhubbard@nvidia.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, linux-kernel@vger.kernel.org, 
	nouveau@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 2:13=E2=80=AFAM Alistair Popple <apopple@nvidia.com>=
 wrote:
>
> +/// Example:
> +///
> +/// let mut buf1 =3D [0u8; 3];
> +/// let mut buf2 =3D [0u8; 5];
> +/// let mut sbuffer =3D SWriteBuffer::new([&buf1, &buf2]);
> +///
> +/// let data =3D b"hellowo";
> +/// let result =3D sbuffer.write_all(0, data);
> +///
> +/// A sliding window of slices to proceed.

Please write documentation in the expected format, i.e. using a code
block and a header:

    https://docs.kernel.org/rust/coding-guidelines.html#code-documentation

Eventually, this documentation will get rendered just like the
`kernel` crate (and the examples building/running as tests etc.),
which requires following the expected conventions.

By the way, is the sentence "A sliding window of slices to proceed." cut?

Thanks!

Cheers,
Miguel

