Return-Path: <linux-kernel+bounces-747001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5D6B12E17
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 09:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4323161840
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 07:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB441DE891;
	Sun, 27 Jul 2025 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ioo/jTLj"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DCC19597F
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753601597; cv=none; b=GvFHtH1lndu6acysXl7ILaPHhLbW7pY3q+dMJTXFlzSJIoi9Pfyn3kYEbTbMz24ysS5XsGd4xxBvNJ6EyGF2sZ4DosDwDYMuDLXVM4/X69SntWeLfoTo/7L0uHwsiAOe7PeJ+PnJVmv4/2HfTSkt6si/GfqsgZagGZFxRXh3XxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753601597; c=relaxed/simple;
	bh=xNXAN5OC8QovG17c6hDzmGpifBFd1oX8XYR6z/b/R0I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f8jMOimnFLOOmZGtGGbYKqyqPdUHVyvOyRcmK8JaEXBia9fwcDxxJ2eRBr/sC5WHENN60vI6e44oOlcCnl06PJTmAO5A4snH7J6OfJiJsCt0/mY1waJVWvGul6lcO1uF4qmVd1ucpidU1MVqHsj7kuOw2BfyQvP8iFMrd3/L9us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ioo/jTLj; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-adb33457610so491922066b.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 00:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753601595; x=1754206395; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rYEn9n4wbY++FfZAv8qg2eI1fEk6Vh6uQZs/oAqAxtQ=;
        b=Ioo/jTLja08sR2beXygQdhABt7qyBUaUeFddb5hT0ed2N/6E9XWeOGax9sdONGZ86w
         W6JQBuAGQjYP4LwqTuYdRO15Lx0Yl+G02kxGPwa3Km2JfW53WLEbpWymgUTvzZjqdZCb
         UJZvRyg0r4cN14B53AGXXAMlZXieRe3HMIAKDNF5FZUxXQKu2Alr5BJZRF7g6pvJLO2Q
         t0Gzr24wy8HEeZmknkMFRPS7bcthi/5CriZ5U9SzY5Li6ZfAONlYGm5JGbhrK15VIz6J
         ny0/MpYpVs9APQ/LTmWSb1biJTZB1RYIRSo9Xd59ptS/xBiIdRLskKEfIUa9Py7hW8+i
         WMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753601595; x=1754206395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYEn9n4wbY++FfZAv8qg2eI1fEk6Vh6uQZs/oAqAxtQ=;
        b=Uj6odSTVAfDEC5at7gMcVyqK04bmX7jaGn3cnhYSYGuSKGzBD6mKYWiyhV8J0X8LfG
         kmrDP0rZpH84kvwmUQ6iJ8WQ+y7E+6J0oUEsuwh0VCUBYOBNtBTQTsWXWPfa74+alNRv
         3sauFshyLOgNmsNk606+VNqwKHvbsO8x8nKAgNkseNGb+mlUqjpZKv0pZh4Fqf/60ZQ+
         arnijkOXirtrWpXXIoMxBuSU1ygl+winymvpvD30gzJ6sppq5B3/V2/2QWw/5PQjZCTG
         P7K12iQvcDEhoGAszNzZ5oifSVprOTFS7333rrfBvdwALkCV/adI2B2xDKMRathVcWvs
         ghGw==
X-Forwarded-Encrypted: i=1; AJvYcCWZd4qXgOXwdf6uXpnmsoMA5Mf9xAu3/J1WhKgRiEL4gOYHRk+M+7+OpCCriCK4o22yvUDHgiGXECb3/xI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVNrQQoCH5UAHyC1tbssU6YlnZg+hjzZ/ygwBmEaG8VFk17GzK
	2NEsBLN+QcMavjwzW3iABwT6+62RlaCStoJ9POMU2ilSmu4a0pS7SWfg1Qt6o581GIcNTnu9VPY
	f3hC9MY5PqKhupyoJ3Q==
X-Google-Smtp-Source: AGHT+IHJuP57hLADqtVsQty+/0f+0R1qq/T6WDOD6QMkMTz/X2EQnn2t1TjcFe/W5l7/3jJIOxYQ8lRHpppR1Vg=
X-Received: from ejcth17.prod.google.com ([2002:a17:907:8e11:b0:ae3:5cde:6220])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:7946:b0:ae0:a813:1bc0 with SMTP id a640c23a62f3a-af61eb1244bmr877981866b.53.1753601594842;
 Sun, 27 Jul 2025 00:33:14 -0700 (PDT)
Date: Sun, 27 Jul 2025 07:33:14 +0000
In-Reply-To: <20250724185700.557505-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724185700.557505-1-lyude@redhat.com> <20250724185700.557505-2-lyude@redhat.com>
Message-ID: <aIXWOgTWdSODz7EH@google.com>
Subject: Re: [PATCH 1/2] rust: time: Implement Add<Delta>/Sub<Delta> for Instant
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

On Thu, Jul 24, 2025 at 02:54:06PM -0400, Lyude Paul wrote:
> In order to maintain the invariants of Instant, we use saturating
> addition/subtraction that is clamped to the valid value range for a
> non-negative Ktime.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> +impl<T: ClockSource> ops::Add<Delta> for Instant<T> {
> +    type Output = Self;
> +
> +    #[inline]
> +    fn add(self, rhs: Delta) -> Self::Output {
> +        // INVARIANT: We clamp the resulting value to be between `0` and `KTIME_MAX`.
> +        Self {
> +            inner: self.inner.saturating_add(rhs.nanos).clamp(0, i64::MAX),
> +            _c: PhantomData,
> +        }
> +    }
> +}
> +
> +impl<T: ClockSource> ops::Sub<Delta> for Instant<T> {
> +    type Output = Self;
> +
> +    #[inline]
> +    fn sub(self, rhs: Delta) -> Self::Output {
> +        // INVARIANT: We clamp the resulting value to be between `0` and `KTIME_MAX`.
> +        Self {
> +            inner: self.inner.saturating_sub(rhs.nanos).clamp(0, i64::MAX),
> +            _c: PhantomData,
> +        }
> +    }
> +}

I'm not so sure what to think about this clamp logic. Maybe it is the
best way to go ...

Alice

