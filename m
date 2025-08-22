Return-Path: <linux-kernel+bounces-781306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C21FEB310C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6AA1CE6CAE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6E82EA470;
	Fri, 22 Aug 2025 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sZbNPx43"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A1E2E8E1E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848793; cv=none; b=fh5YYJv27onIAjXwNHl8ttyGFAbQ7jwXDdk+dHokflUnoM/3+bwxZtNo1vM0A06/wvkbNdFtj7yA21kzYxl81SeTJZufEiLRBWDj8ee6fR9PC9IcJbp6BX5Po9n7+e9WRGzwMO+MyvM0UDm1eAeXiuD1RBxOabRqpDvMlFLhl4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848793; c=relaxed/simple;
	bh=V+y/12bmCVEdEzySarnT8TDFKs7NTABXDxXLLo+kWhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWXJY9jgEXkuj+S5HwrLnD4Igj12w+2opm4RsDTIEHszFqVjQB0cDOI+mATplL6uk5u8o0qV9RvL+mnuIZ726MKyd5AtCF4sjMKL9E1F2E2LiFZTxCeMYG23SYpIWqPgq0VdAXbhx9gr8l7bo1wIRsWgLpMlyrJTFlnFMtkMthU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sZbNPx43; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a20c51c40so14764455e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 00:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755848788; x=1756453588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YemliuHyBp0gvdTdDd76NLCLOXa02us54ebhu4Bbrk=;
        b=sZbNPx43YMboO6zGn9z3YeLGmCFsyhGegMdhVlJuvA+boHK4G+yPQR1xZc4baXD9qk
         8iqg4qXJ8ld0ex2gSSKdTdMRG9tFsSVboW2iiim/L5fdAhdIwQLO3IYODD5RRtNX8ee4
         0hGbou0VU7wMIzAL6aCQ4fEZNlVqxGFmNYeKTG47vicaPCpmpE8tnHICNK8KZQMCk63B
         LrGRPcEmJ3QgTbj0cMat6GSEWU2xBR2BbvQ9V7R2cHwpGqmlhsABcacaYMzUmhHfU3lS
         P5MqBksOoBkMGTI7uPahsVLghJbKZGxgl700PXJpCIrEiry0d8uTFRuhNqrdYLy7otoo
         5slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755848788; x=1756453588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YemliuHyBp0gvdTdDd76NLCLOXa02us54ebhu4Bbrk=;
        b=GTTJ9ENvGZyQ4xoTNA4mVOhUkZHebGe7Q3hoETJixxEyzVBeIijn0LX6E6+06aNe2I
         5D5er9j8OIpdz3gK2PRercL9/O/FxSYM3fmdpKJD29XZoNAT/DK6FJVtbiCo0rbfy3CZ
         3ixXpfgLCuzokPvIjbt6+OoHDtQeMuFftdsSsX9WlNHACmsdAuEcpndTqZ0vWY3moqUr
         S+/1QFagxU1iSf709CgezqNMB/8/oppB50OwJFV/NdL6JDyEqzAsRoKsJrcqgmA2JGWz
         crQWdS6BrI4qH+V6LH1xH1C93Ecbuuk1yNsOFHUs6cmiQbl+mkRjTFehyZ+KoWx98ZV1
         JdXg==
X-Forwarded-Encrypted: i=1; AJvYcCV/bTFRDSn3QTuNAR9bBGU1vVydRNO1Z3guWXJWtFX/XI/Y2FYMolqrbpuj+/yviN7b8lpagy2j7tJjYwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkNOR3oeeV5zpl8WUsZLJ4ysv54X20iJ4vb/EM7ssqx1BkTYtS
	cabpKBwXpVUABbBQu+SCrSDy81bgGoL1rHhjxuhj6Cf20dPwdK8Yq8Xoj++jXaG8SIvxeMvU1xE
	UiWbx/KO9CdQ36BjJRknUUnvqQlQHZvbxwUdzyCuf
X-Gm-Gg: ASbGncucASWMB0ffRPVjld9FzFJqK471HVQkSbox+unASCunTV7tHxqk2dkOaRbO4We
	nwmr6M3e0+Orjvl0PTZiYJAfmrCs3FaFDDzJm6C72sLoQ58wgoQrXpP8Pyq+7SJw0fl7gaioDB0
	g+5bh4+DWexcy0cnxt4ixlqmeDosKi/WPrHP1WcdYSz1iW5fwtDBc2rgLKneG/OflUtkP1wlQB9
	T4dANgMUd05SBgGIq8dGOr3MCQXJuwXNHyEySo6i0cUjmUz2lLLA8q8EF4FUfUw3N15kIbFUxp6
X-Google-Smtp-Source: AGHT+IEl2XpR4GD0AcM3PV0w3+9+iurmsg+S83Mh1YS4hRyFfQy7CFdHopm4vAXAHb9ywoT72IWHsvSnmLYcnOWUXxM=
X-Received: by 2002:a05:600c:4e8c:b0:456:1ac8:cace with SMTP id
 5b1f17b1804b1-45b5179e7e8mr15262675e9.12.1755848788250; Fri, 22 Aug 2025
 00:46:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821193259.964504-1-lyude@redhat.com> <20250821193259.964504-7-lyude@redhat.com>
In-Reply-To: <20250821193259.964504-7-lyude@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 22 Aug 2025 09:46:15 +0200
X-Gm-Features: Ac12FXxz1OPWMgKtoRfP1tPNgTj_X4Rl-KjHLxrj8UR8juldOTLwAUm0J19o1kw
Message-ID: <CAH5fLgggbF2KWHazQ9rDeyVEjxg4LipfXA1qepPAhkkaHD4Mxw@mail.gmail.com>
Subject: Re: [PATCH v9 6/7] rust: time: Add Instant::from_ktime()
To: Lyude Paul <lyude@redhat.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, 
	"open list:DELAY, SLEEP, TIMEKEEPING, TIMERS [RUST]" <rust-for-linux@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 9:34=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrote=
:
>
> For implementing Rust bindings which can return a point in time.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> V4:
> * Turn from_nanos() into an unsafe function in order to ensure that we
>   uphold the invariants of Instant
> V5:
> * Add debug_assert!() to from_nanos
> V8:
> * Change name of function from Instant::from_nanos() to
>   Instant::from_ktime()
> V9:
> * Fix outdated comments in from_ktime (nanos -> ktime)
>
>  rust/kernel/time.rs | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 64c8dcf548d63..874a1023dcdf9 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -200,6 +200,29 @@ pub fn elapsed(&self) -> Delta {
>      pub(crate) fn as_nanos(&self) -> i64 {
>          self.inner
>      }
> +
> +    /// Create an [`Instant`] from a `ktime_t` without checking if it is=
 non-negative.
> +    ///
> +    /// # Panics
> +    ///
> +    /// On debug builds, this function will panic if `ktime` is not in t=
he range from 0 to
> +    /// `KTIME_MAX`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller promises that `ktime` is in the range from 0 to `KTIM=
E_MAX`.
> +    #[expect(unused)]

I would consider just making it pub to avoid the need for this expect.

> +    #[inline]
> +    pub(crate) unsafe fn from_ktime(ktime: bindings::ktime_t) -> Self {
> +        debug_assert!(ktime >=3D 0);

If you're going to have a debug assertion, perhaps it would make sense
to check both bounds?

Alice

