Return-Path: <linux-kernel+bounces-776014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C1CB2C76F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D4CE7AA2C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09E927B35C;
	Tue, 19 Aug 2025 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXpWx/FW"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FAD20299E;
	Tue, 19 Aug 2025 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614888; cv=none; b=M8cQu/leJyPkfG2sVNmB32vCZXSCVBiqr1eDX1ml9SzrrWU/sB4D+kEcJn8esoKM4gbftIQWNCeJ78BAR0WcULPgnMFbLEMrREcqMvN3Ix2D79PRrzVr2XbeBoRiIu5yW6Xsr4TyPaCg6plmygI2ybpLxJrwAb5p5MwAtDj0JpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614888; c=relaxed/simple;
	bh=bamZIVszD7K2gwd4bSSEzjS/2o979NAePLY9MkVsMZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZR+zTi9H7zQhxrrM/M3CHdRybsMafa9KHUi0slEGs2HTkfLet5h/FsGSXELegUaMaswJIMUaBf36sfB4PEVlNDVtia3g88y93I3iFq54N4SJEEAWmDkPP5kIldjfVzXL1JgpuKIY8IfD3XartuvlbFQ3CDEkUxZ4j1QbJ0rssOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXpWx/FW; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-333f8d25d33so5818781fa.0;
        Tue, 19 Aug 2025 07:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755614884; x=1756219684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bamZIVszD7K2gwd4bSSEzjS/2o979NAePLY9MkVsMZM=;
        b=JXpWx/FWZnsXQkKwBNNMj+LvWI3NdWupXUCTCOl/dVTZAjCGcSnMNXfYaj6Im+FfXL
         PvdvbbNoxdgBW0XFtMR7YA8TxwjVdq6L1nU7WI8G5rJxrGvWPvSdiIjLkm5RKgAXULrx
         4Bgpj1oupyGAKzkpehr9rI4dIy44NjzQ+ivYFcks2ZsfSZ2zqWiBDHmLc2pOUziu97Ts
         oytzIT0s2RpDyCiLDxAgLFw/7uB4koN3nv5fuFozWv8YJQQvNm8eWqLN/YPQjVR3Dp8r
         kDIi+F4haVuC7+G2M4UA7MtYOjLIqPoQmB+bieQOvI9smwYmN/zP4lWSiSkvd3uf1xfe
         U7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755614884; x=1756219684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bamZIVszD7K2gwd4bSSEzjS/2o979NAePLY9MkVsMZM=;
        b=KH9LBxsNQUbPLJAO0EzcYhasQZ9qedTteuAu/D0BJEPCUqFzzIHkyLFB9ZXjejCpJi
         ExPzmRcLyj6UNghwLGBOIzlOeBiil61f7Rl/uWNW1nkygkYq94Ecwr8M2Y+/FyDTqUw+
         /QncLMxoNGLf0eaIs91EMRBTk6jHr4OdT3+UxFKvuv0t8OIZE7AH+Hn3XiE4iBzQXL4Q
         Z/ozF88Tw4kVBnNpGpT+GXjVNetNx24RaCejGxgf+UTS1+rDvX7ymC+5qHieL1OtQS6V
         jLxbGWEGoD0SfQdxuFfwCMDye2OITHh67avKlwuNTmCW85l0GfKq4lPbjp2gXTskqEH3
         RRaw==
X-Forwarded-Encrypted: i=1; AJvYcCUBV2bcsXJE+GUfburM9x/6W89341PIp4zn++k8zN/xwBZ/GsIjfUyDLTA6Z6AOE29af4HUgRXgYFXBgP4=@vger.kernel.org, AJvYcCXL1P+yBQan76ZrkI2TFGpoooGFt/nvsH1vB7GmB6dQWUrXtf4vgjy+jhjJqkBdeqgvhDH9aVgCHNat3GaJ0nU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO1dWvprt5ZzRSqkjKcPN2PF5sHW9bHTSN5VYsZ8HSWxufzpfF
	+ht3PTbChA/BISEp4JK1W9nLhiDmhvZuR/a/Qy6rywSGTNtfBHCNlE0EcI7k/86sv8rbyxPRH6e
	C3dXqAU1uHTKZ1JL6OKVrxE11yXK67xA=
X-Gm-Gg: ASbGncvl5WzM+arswR05Q1K7bUeh4a5Xb9jA9uV65oReHuCQQIM6sYHGyFYjWPJBrw+
	9ZlQjZd3pULpjEQTgHCfcYf9gR0BvjxZqZ48EZZQFy/uSyLcRLgzx1nKfmaH/euEjVQxHhkRJSv
	1R2R+yuZ4YzphwSkm+EqlKKsEmH6Md3fNxaFiUx2HvTEQ2IYSAvaJizpK2K8HToYLR3Y0/wxyNH
	24J37m024njiHoKD6c=
X-Google-Smtp-Source: AGHT+IEyffd9XMDA7xk/70Fz0AHtmXcTx2FhM+gPswfLgAiVJzBX6bBWADeKfPTaRQLgm/I9g47JhyJuPJ//2TFmeZE=
X-Received: by 2002:a2e:be8d:0:b0:335:2b7c:cb68 with SMTP id
 38308e7fff4ca-3353051a9c0mr3875381fa.1.1755614884180; Tue, 19 Aug 2025
 07:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
 <20250709-debugfs-rust-v9-3-92b9eab5a951@google.com> <2a0f2965-af37-4ffe-8806-3bb469361b1d@de.bosch.com>
 <CAGSQo03meaA2fmoHqxdcVSXrKdE7yTTK0JfWH28mHZ=0kWoTzA@mail.gmail.com>
In-Reply-To: <CAGSQo03meaA2fmoHqxdcVSXrKdE7yTTK0JfWH28mHZ=0kWoTzA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 19 Aug 2025 16:47:48 +0200
X-Gm-Features: Ac12FXySenraZccTpa6BzV08XuNlfN14wcN2xhp_sXUvgfpZnDIOpcygK6RK5bo
Message-ID: <CANiq72ks-B--6UxO-VsPAvvqpKap7G7rSHxJs5gam0hjWB+vOg@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] rust: debugfs: Support `PinInit` backing for `File`s.
To: Matthew Maurer <mmaurer@google.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Timur Tabi <ttabi@nvidia.com>, 
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 4:33=E2=80=AFPM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> The easy way to resolve this is to use `rustc` 1.82.0 or newer (you're
> only one revision behind!), but that's past the MSRV for the kernel at
> the moment of 1.79.0. I intend to send up a new patch today, so I
> suppose I'll need to put that behind a flag similar to
> `RUSTC_HAS_DERIVE_COERCE_POINTEE`.

The syntax changed after our minimum version IIRC -- does this case
require the precise syntax or can we use one of the workarounds?

> Did you add `#![feature(precise_capturing)]` to
> `samples/rust/rust_debugfs.rs` as well? It is its own crate, so it has
> its own set of features.

This would need to go into the `allowed_features` list, assuming it
works, but please check the above to see if the syntax is allowed
across the versions.

Thanks!

Cheers,
Miguel

