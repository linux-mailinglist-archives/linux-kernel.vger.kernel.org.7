Return-Path: <linux-kernel+bounces-868494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E30F6C0552B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E6A14E788C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F51309F0F;
	Fri, 24 Oct 2025 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KOx5z8x8"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC0426CE37
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298053; cv=none; b=se+UXupAsEQm6xtk9oTUqUHs/cjiwTqquTLMlORc9sOea8EbCHrfBrREJYMXlCRnmp3d0QVMmBzfBENztpjYfPqW2iLBN82VBTEZ2OVdSsG4i36490seNgdEohHSngH4VBFZ/8J39GWHuXhUAvUmD/jpvFqkJBqAn2GHkOIrSTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298053; c=relaxed/simple;
	bh=jz3r6IG//8UpNyt5YK3+fvQAu9iJEiCU7Jg/ynlHlE4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FP/+0WlXXJ/k+dj20aq4e6BTczvFZNWyfv+kSDtibtHUnMde4hAMFxf4YdnO9i/B43KZXn0U7vVl45efQyuTn3UUyToX5PNR09bpnvcFSHzILw8NR4QvVlQin92VhMl+LzH7zDxYLcK2XyHeQVzRYDR/GGYNgpUZUN4d8HTZCFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KOx5z8x8; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b5a8827e692so139798566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761298050; x=1761902850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JkKniSG37xTx1eVGmGkTV5Ir1JTVe3QhsEKcXT38Iss=;
        b=KOx5z8x8cAkXV44T0yNxAZlxB7iTtqw1eiNZ612Fl9igMi9zjKEdyclYw05F4AGM9Q
         iIMszdAX4Fq2G9G0cCYz628rzrpUcUAMNvUNjFQrfyPM6nwtAT+c2y1RbJVb1owDAEeQ
         vkUfCjuf4qY00sR6CIVv447mbUXK/paYc3qgG2a5zIhi7zEEbW/0SFD0yXIkan7D7Hgq
         N2wVTIP3rU9M5ttW15U5+h2nGRWs+HT3QctGHV+q0U1p5zahEeNaQI0icSbaOUEzAX1y
         j6paiUXU2kjGw6K8yysmbaI2L9pVV68fXogsxGUWqdCKzJZlm7XZVw+LOLYMcVc5/UuY
         czBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761298050; x=1761902850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JkKniSG37xTx1eVGmGkTV5Ir1JTVe3QhsEKcXT38Iss=;
        b=IKFT9n6OuyrOz8XrCZNX8dLuLxUxtWhFCPXmLPRVMcpImWh1y+UZUylmtNw6YzdFKN
         QDiRuKHKsFOeDS//hlOGnCwskq7vcOpOufQJEX9oLkBaAiGg/mJoWGIYgNcnl/4m7R08
         S0Y/Q3sWIOlM4fhyQwlYbzF+pdbu8fQ2C3PxSmaVgkIfEJsWwxDxaWlnx5B3PYY7eTba
         G4pirEanSD4KEZsoZ0aFNeQ8PQXqwEYjUA955bPs576Z9TZQO9l3qH1oVKuIarQaWXjO
         tKY1WHX7rChPljPDeqOLC/vtJ2ZbGD6Qb7rWT4KRbbh3xQTdm/5HpnDYtQ7S+Lg1x8kM
         hXgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVQbjEvrCqblb9LG1I1lApTk8CNa5MLaWvn3/Ij7AZSls77zO/t42rizTzElF1TAkouPULeD5v+hUFi+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/4Ne3Nkrd+pxQHWi1GHPlPZaVIoh5uoX4tinXbSaxWFRP9a3e
	YCHgLAQclHTnrW8nxxGhPn5TdztsuvkodI7p6KppOBRSOpPAhWEJvuNJMvODdmgZVe7/lhXj77Z
	7s9lToq83bhQlv6pAZQ==
X-Google-Smtp-Source: AGHT+IGfllOsRSovrXNjZ4P8vLQLDZn7m27advgrGNGOThiOpA4iYZmKtTm5wFMwSkiRyWwhbQxA8qGpfZt0JVE=
X-Received: from edp28.prod.google.com ([2002:a05:6402:439c:b0:63b:54ec:172e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:5c9:b0:b04:25ae:6c76 with SMTP id a640c23a62f3a-b6473f3feeamr3050584666b.47.1761298049771;
 Fri, 24 Oct 2025 02:27:29 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:27:28 +0000
In-Reply-To: <877bwkhfrr.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <DDO3G26SIZTK.1KV7Q0PQXHWTA@kernel.org> <CANiq72nUiizxo3YFgxUZ1jiczRNbY2ATao2YUBiCEC7k5hbv6Q@mail.gmail.com>
 <DDO3OMBHS8TB.2LDODR1AFRCU3@kernel.org> <20251022.193230.585171330619599845.fujita.tomonori@gmail.com>
 <vTqqW7yepc41IJ7rUH2GAcWAJ1HHAUQ2_NeQ_os6L5MKNZ-acMHFwH9u3m0oRDumL2YQPnZ6Qu58-iLlAv0Tew==@protonmail.internalid>
 <aPjmKSrETqrchW_e@google.com> <877bwkhfrr.fsf@t14s.mail-host-address-is-not-set>
Message-ID: <aPtGgNajcXKWpji0@google.com>
Subject: Re: [PATCH v2 1/2] rust: add udelay() function
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, dakr@kernel.org, 
	miguel.ojeda.sandonis@gmail.com, daniel.almeida@collabora.com, 
	alex.gaynor@gmail.com, ojeda@kernel.org, anna-maria@linutronix.de, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, frederic@kernel.org, 
	gary@garyguo.net, jstultz@google.com, linux-kernel@vger.kernel.org, 
	lossin@kernel.org, lyude@redhat.com, rust-for-linux@vger.kernel.org, 
	sboyd@kernel.org, tglx@linutronix.de, tmgross@umich.edu, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="utf-8"

On Fri, Oct 24, 2025 at 10:20:56AM +0200, Andreas Hindborg wrote:
> "Alice Ryhl" <aliceryhl@google.com> writes:
> 
> > On Wed, Oct 22, 2025 at 07:32:30PM +0900, FUJITA Tomonori wrote:
> >> On Tue, 21 Oct 2025 17:20:41 +0200
> >> "Danilo Krummrich" <dakr@kernel.org> wrote:
> >>
> >> > On Tue Oct 21, 2025 at 5:13 PM CEST, Miguel Ojeda wrote:
> >> >> i.e. if they aren't sure what the value is, then I would prefer they
> >> >> clamp it explicitly on the callee side (or we provide an explicitly
> >> >> clamped version if it is a common case, but it seems to me runtime
> >> >> values are already the minority).
> >> >
> >> > Absolutely! Especially given the context udelay() is introduced
> >> > (read_poll_timeout_atomic()), the compile time checked version is what we really
> >> > want.
> >> >
> >> > Maybe we should even defer a runtime checked / clamped version until it is
> >> > actually needed.
> >>
> >> Then perhaps something like this?
> >>
> >> #[inline(always)]
> >> pub fn udelay(delta: Delta) {
> >>     build_assert!(
> >>         delta.as_nanos() >= 0 && delta.as_nanos() <= i64::from(bindings::MAX_UDELAY_MS) * 1_000_000
> >>     );
> >
> > This is a bad idea. Using build_assert! assert for range checks works
> > poorly, as we found for register index bounds checks.
> 
> What was the issue you encountered here?

Basically, the problem is that it's too unreliable. The code does not
build unless the compiler can optimize out the build_error() call.
For range checks, seemingly unrelated code changes turn out to affect
these optimizations and break the code.

To make matters worse, the error message when a build_assert!() fails is
terrible. But even if it wasn't, the optimization issue is enough for me
to say we should not use it for range checks.

There have already been at least two instances where someone wasted a
lot of time and had to ask for help trying to debug a failing
build_assert!() used for bounds checks.

Alice

