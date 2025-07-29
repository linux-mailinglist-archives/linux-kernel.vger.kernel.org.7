Return-Path: <linux-kernel+bounces-749374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C12B14D84
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7213D189F454
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3410E28FAAD;
	Tue, 29 Jul 2025 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SeSZZN/C"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF730230BC9
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753791340; cv=none; b=AFpsgu4zV22Tsoh4q5hwZGMuR7FLO7myEpL9lwjUcFkKDQZYCEtku1hfU5vXRCRu5knkayhPfI84PK9TxYZhQc6LyEXGLqDVRWjw0hkY9OhuOchVZRMVnpd9XfxRChQoJsTTe6W8DXZtfOORHOWWGf/67MynbZExWGTRF6jMDak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753791340; c=relaxed/simple;
	bh=pRKWkEQ859AqbMty/6nEBTeAZEv6HUIc36eyCZvgTD4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Une0YDBIh0zm8hCMCkY+1KJjeFmRBT6mGLMvk2aRQDHvApuCchF9Ac3uy9vLGClP3hA7OLzokQnRRq7zOujZ3Hku8BPKq9r+DOrFlNPLU2+wAaj1MvpKKs50PtkrQmxQo5WYGBxT0dqa0sWX9lSr9YJ/tb79hgAPoEZJHdpE+4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SeSZZN/C; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-ae98864f488so628444066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753791337; x=1754396137; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lYzZqhjw8TBD0wreOo10dc1gdI2xJtGND/ZcoPMk/NA=;
        b=SeSZZN/CRYZPX1j9NTP17/DvMhV7whVJV5trQjGoCaOAKFPFESAo4yuTLnjLL3p+yz
         3PGyoDqMjItRTROJo1uqoDaK9WngSzzu6NN1ls6OSugjaPkwkifzGnsjdw8TW4FunO8Z
         gajH03n/l9aeKTMFIxsGWnQ7UT20TJcBPro1hAbOlEe3ZJsEvHQEV+KZyZHZfiAz0saP
         Yrex1jqonuLQzKZFVAwgGxa+N8gKz877EOCuycBiMfsVdi2jIzhb/koSy9uUFdENPEJf
         xc5r/rB26wSDsICT9eQhZeod3KYr9x7RZ9mrlEgEQtepSYJ5CSWwWz4WgZ4qXk+pQbIl
         YX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753791337; x=1754396137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYzZqhjw8TBD0wreOo10dc1gdI2xJtGND/ZcoPMk/NA=;
        b=RBvOvBJZUIX5DeOL7dFqE11yOMrpZEIGO5Tu0uj+7c66ruNa2p9Ph0+JFLl19UtzmV
         OgDVfj/7cfnQhTpQdLzUBkVZZ2mFfi96FPR4wIXcXoQBIjJ+V5fw18/NxS/BxDSxZ+/B
         dLnd9sgpMHz+8ZzQDq/Y65Qr8fwxH9FOiVUtD+fOvnCOi4+pkL9vqyxM91WWujcfaIet
         w+Pt4E2BzcdawAauRVXmjIRUkCvrCjO/Z15lTvXEtbUeFm/bG7oaUkNIccoJBsVS851/
         uWhcuotZv5p1DTVxEOgXOPrEwFhvGOzxDFcuh4TfnVKohwAS9LIH9KRS3wCxb0/TYJNT
         xfbw==
X-Forwarded-Encrypted: i=1; AJvYcCUUvua7wfUtGCwf8Bf7GbDJiN7u55dfjCGU/Vvm/eV7pP/xghOHayKuD+/YiWx5kHzUPCUcfkYdw0dK3/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/axcpr6Yt7U/UEwcSR09K13dtVx9Ja/pK8fLAqsDClAVu3Kjk
	cvgixsDPK6ulMNzplsdNr84jl9jYInBHAh3ckSirFxMZjKKjnV0q/sd5qZMTX1T3JRDZUJzMXyx
	8gwczYg4COw/gN1uKxA==
X-Google-Smtp-Source: AGHT+IGSHNfo7Zrf2KfxC7hlR2bqTHQpTRrlnzGDMx0KhUGV2by0O6HJ7+TOJf/JhZjV+hwsM1vj07vYYew4aMM=
X-Received: from ejbgx7.prod.google.com ([2002:a17:906:f1c7:b0:af8:f1eb:c67])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:9287:b0:ae9:bf58:4190 with SMTP id a640c23a62f3a-af616efc1ddmr1835841566b.4.1753791337106;
 Tue, 29 Jul 2025 05:15:37 -0700 (PDT)
Date: Tue, 29 Jul 2025 12:15:35 +0000
In-Reply-To: <f92b5f82b3ad7bb8d5bf60b272aac8cf1e6ced24.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724185700.557505-1-lyude@redhat.com> <20250724185700.557505-3-lyude@redhat.com>
 <aIXVzIwBDvY1ZVjL@google.com> <f92b5f82b3ad7bb8d5bf60b272aac8cf1e6ced24.camel@redhat.com>
Message-ID: <aIi7ZycRtmOZNtcf@google.com>
Subject: Re: [PATCH 2/2] rust: time: Implement basic arithmetic operations for Delta
From: Alice Ryhl <aliceryhl@google.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Mon, Jul 28, 2025 at 02:36:50PM -0400, Lyude Paul wrote:
> On Sun, 2025-07-27 at 07:31 +0000, Alice Ryhl wrote:
> > The CONFIG_64BIT restriction seems annoying. Could we not support 32-bit
> > from the get-go? Where is this going to be used?
> > 
> > After all, we have stuff like this:
> > https://lore.kernel.org/r/20250724165441.2105632-1-ojeda@kernel.org
> 
> I'm not really sure how the example is relevant here since we're dealing with
> a different problem. The issue is that division and remainders for u64s are
> not implemented natively on many 32 bit architectures. Also for where it's
> going to be used: currently I'm using it in rvkms for calculating the time of
> the next vblank when we enable/disable our vblank event timer. We basically
> use the duration of a single frame and divide the time elapsed since our
> emulated display was turned on, then use the remainder to figure out how many
> nanoseconds have passed since the beginning of the current scanout frame -
> which we then can just use to figure out the time of the next vblank event.

The reason I bring up the example is that once you add code using these
impls, you're going to get kernel build bot errors from your code not
compiling on 32-bit. And as seen in the linked one, code may be compiled
for 32-bit when setting CONFIG_COMPILE_TEST even if you don't support it
for real.

> This being said, the kernel does have a math library that we can call into
> that emulates operations like this on 32 bit - which I'd be willing to convert
> these implementations over to using. I just put the CONFIG_64BIT there because
> if we do use the kernel math library, I just want to make sure I don't end up
> being the oen who has to figure out how to hook up the kernel math library for
> 64 bit division outside of simple time value manipulation. I've got enough
> dependencies on my plate to get upstream as it is :P

If you just want to call the relevant bindings:: method directly without
any further logic that seems fine to me.

Alice

