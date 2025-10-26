Return-Path: <linux-kernel+bounces-870466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 215F9C0AE18
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097CD189D60D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 16:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175A725DAF0;
	Sun, 26 Oct 2025 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOnHN2+C"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E8F1D432D
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761497063; cv=none; b=Y6729URyJP6D9DoLQzA1WMXUwNWsmVRenIVVNYqG8vviC7a2ditut6qflJRwm2tm39ZsGPGdgiseRt2WuzS0hWg+eYmC5uR5YfvGrnryc0mWtKuyHCJqZyqpswcC+lqJf9D8CHrQoT0DV48aBjsryp16MZIWBjWV3wOH4ppi8ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761497063; c=relaxed/simple;
	bh=KMWnw6b6pivqyFZPVbwAkq33BfV587bvoZCL9h4aJtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlRNPcCIi0mIyuyTvvN+1ESKGx9QdTBBYeb7A2UrLs+Bf6LHK+yvnVDYekp7MfvSNcqtPgg3F8cwEMtIzc5z47daw9RkpndjpPhFh2skG6UEl1/wFcWG/Ovqed7yXvMQYGCslnP+tqyiCG52mxcrlF7NYw+AZ4df94a2iDCvlIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOnHN2+C; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-26816246a0aso6951785ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 09:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761497061; x=1762101861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wILLtfeNYO6vlF1lVdjizAOVshwGgLXWHD0xoxegrM=;
        b=aOnHN2+Cc0sTDJrg76LxC1mQ82AnbxndPGh5Vkv1OX1bG1wPKamjoxA5vV/nFdc5DV
         ku4jifojt9QEgIplgkbUTaYF/k26rSYkWhfJH14PCpueZ39tpU+48r86YvgxcPes/5E5
         2lTJVDZjLYQAwMA96cbkPDHUg+X7szYzmgSo5kne7ia2HC9WmGOcR7lJ0wQ+hv5CVKjC
         zyQ7dv0YOQyJmRkOHSCuILbRyASwtrBqEJ56gkuadLEKk4lCqVhfGg+hwrHBbvyt1mID
         aUithr606CfOsE4Y0sWYv8nc0Di7FLNlpWhKdg4G1XTrxIXnQ4fhTKDe41cTjnSV2rB+
         fGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761497061; x=1762101861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wILLtfeNYO6vlF1lVdjizAOVshwGgLXWHD0xoxegrM=;
        b=HvTffd7A4EEv5/28n77QHb9uvrsLAVOeJ+QOlDkK0hwJFu+XrmW8MEgARwgF1KiUpe
         ujoqgHxoK+RBD/ylhIYj6DFrkaScDprZD+oOD1y1YxnY6ZQsBuRW3F8wRKZ+sINaJ1ZA
         qKARwghk2mY5auyaut30Oq6zw4qeIOWbMamohtneekIjjsPjf1D9AHVW9EvS6/nrmm5U
         Zd0V2IMQkWl1dzqbe+NWoQfNBk/cNnyP/Wl2cOKv1ZqQ4h5L71Le7sOPEx3Jy5ESPvU2
         agOUmr8EPg021fO/dZFFcx/ZICSLsvUdWF/qj+YMP9yMY3iarLqhcYxJokQjCkX75dBJ
         y4uA==
X-Forwarded-Encrypted: i=1; AJvYcCU9ZwJ97k3hO2cWbGWQ3791uzck5QL4XfQSGznYwEFYx1LZ8/5YE0aLNPK3r0BwR9d0Oitw53pUfyY0zT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKvtxUMQ0bMt4QUYvg58wRzdAb2+Yij3tIqbJHRZVU7vFakc8r
	Rnwbl8kj24SoNUy2VG2tCFQbK5PCX+9MVL6zv1VQNclgAhZR/RtXzifcXW4AaLbnkXvJ0uVNPkR
	aX/dIwRKWDEnIJfEd3Xfmq5LgFQDMiJw=
X-Gm-Gg: ASbGncv9Kdyk28sUnfGoRl/iiptN0+2f1dJyOwrw7Cp1H8AGNtKLUJWtr2pSLeLmaVJ
	DEza/wTcFjVQ5WCYYYhWZS8jfCjAjM9iEwrBsS6q4arpg4kdGraBk1Pr/ygJ9S8/fHSNWZ/2ckN
	itnbHI4KE8GVwcrnJokEq0GbfHaXn4popjZ/C/DfRAX5oZHm6neoOQr4j2D8U/O+U0CXMgKYiVu
	ZeCrQ4FaxUP/YRm4lgJXk1JixIQraFGyZ53aGFPC/iznHv7T88qWkWnvYYKoNBcWJWc16plX4/2
	rV37nxo14LkUyQxyXjNUcjKgtnIY6EyPcejcju27FNS5QIm4ZbTi7ulcEtKPnd+PcVzDH6GYpPf
	6YLQRBMu2a0Di4m3ih/KlsQ7K
X-Google-Smtp-Source: AGHT+IGcKNBiOeJRVxt2uo6Hqt2C6o0CYIe4RfW4BEVkfN4Gc0z8gi+UAYPMQz7pRTqkzl3cw39cqdYTdggHuWXBRN4=
X-Received: by 2002:a17:903:1ac8:b0:267:8b4f:df1f with SMTP id
 d9443c01a7336-292d3e5084dmr130371015ad.1.1761497061350; Sun, 26 Oct 2025
 09:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026-nova-as-v1-0-60c78726462d@nvidia.com> <20251026-nova-as-v1-5-60c78726462d@nvidia.com>
In-Reply-To: <20251026-nova-as-v1-5-60c78726462d@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 26 Oct 2025 17:44:08 +0100
X-Gm-Features: AWmQ_bkdt-5-XZk5dwhGctE3nBdh_GyjtSn8Bs5HCiaG241yBI4aSb7WE_0r3tU
Message-ID: <CANiq72mgoW_TyWf9Nv=5t3Qij_dsDjicNpGsa=F1t+sg23vxSA@mail.gmail.com>
Subject: Re: [PATCH 5/7] gpu: nova-core: add extra conversion functions and traits
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, John Hubbard <jhubbard@nvidia.com>, 
	Alistair Popple <apopple@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 3:40=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> +/// Infallibly converts a `usize` to `u64`.
> +///
> +/// This conversion is always lossless as Linux only supports 32-bit and=
 64-bit platforms, thus a
> +/// `usize` is always smaller than or of the same size as a `u64`.
> +///
> +/// Prefer this over the `as` keyword to ensure no lossy conversions are=
 performed.
> +///
> +/// This is for use from a `const` context. For non `const` use, prefer =
the [`FromAs`] and
> +/// [`IntoAs`] traits.
> +pub(crate) const fn usize_as_u64(value: usize) -> u64 {
> +    kernel::static_assert!(size_of::<u64>() >=3D size_of::<usize>());
> +
> +    value as u64
> +}

Since you have the static asserts, this is fine today.

However, we may actually get 128-bit architectures in the
not-so-distant future -- Matthew suggests to be ready by 2035:

    https://lwn.net/Articles/908026/

So this one in particular may actually not be true "soon" -- we also
had related discussions about these assumptions, e.g.:

    https://lore.kernel.org/rust-for-linux/CANiq72m9AeqFKHrRniQ5Nr9vPv2MmUM=
HFTuuj5ydmqo+OYn60A@mail.gmail.com/

So we should consider having the `cfg` already to prevent people from
assuming it will be always available, and likely a note in its docs,
i.e. we may introducing trouble to port later on to new architectures.
Similarly, the docs of the trait may need rewording.

What do you think?

Regarding the `.into_as()` name, it makes sense, but it can be a bit
surprising when reading out of context... The standalone functions are
super clear, in comparison. But I am not sure what could be better.
`into_in_this_arch()` or similar could emphasize that this will only
work in certain architectures, i.e. it is "an `into()` for this arch"
rather than the general one.
That would go well with the idea that you didn't implement it for
other obvious types, which I guess was to avoid developers using this
instead of `into()` by mistake, right?

(By the way, please use intra-doc links on the primitives too.)

Thanks!

Cheers,
Miguel

