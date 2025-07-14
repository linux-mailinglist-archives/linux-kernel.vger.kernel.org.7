Return-Path: <linux-kernel+bounces-729668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24113B03A19
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434031797F9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23416233134;
	Mon, 14 Jul 2025 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+pZGC1e"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1406238171
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752483320; cv=none; b=fJKMzorCIlqHisRDROJKTFWd+7uCF9kmC30Ue61a79AaF11z3yE/5gu4VtJPgr4NcD/iAOnPdv/O2s8xGiuK2TZCaq0+hY6y0GLFij62h7SkBFWtumUYQ+0SwEPVaY+PJcF+eSR2zC3nMHKbEiQhHgqEd13dBdD9BAbDeew5W3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752483320; c=relaxed/simple;
	bh=dZxAbZ8ulWv334/QiHn19XkVOBuijNqEiiRbXClfk4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buinQBLzGhL+6HalDE3ESPCCH9G/9G4F96cCTKpSP2qW5RVMtKdY7bSnYMOuF0F3wmEQVD7jZwuklrCfAWAuc7TchZEi0XenFmssVaO05SXug5Ft4N8v1Bd3Y7N8CVVAZt6x24dsANZanjmnLxLLHGQzwaAEGS1G5J8+G9QubXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u+pZGC1e; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451d6ade159so29235975e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 01:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752483316; x=1753088116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gj+niLV6OALorn2kYpyE8/uWxGl7XxWeivxdBGPq6ow=;
        b=u+pZGC1eH2rAt6aQASXzBXuGeE9/05Y1VaneWtGHeBeJCpWisjmsCZ5nq7inhhJeNS
         BbccsTVFfQ8sZuJFaCW4FS3LTKZJS7hPURFo95Sh48Vw+AojQxSR7OVjUGPE9iz2K7Nq
         ldBlWX6NT6lcdpPyuEomW398zcit1MwEsebcOW7ESEYT7PQPK4weaHBEGg3+w85HSDpC
         Zr3VhEVzUbtEzS5v2gZ6CJZCaK7HwsFNlpSNCVrmzhStYRaK6csVB8s4CjvbQhObfJ9U
         dO7lhDkRIMJJUjRL3cVUwrdj3ucQjD0XPKEYp4YeuERXpKODP48mVo+x+SlYKoxrWzKf
         Xu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752483316; x=1753088116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gj+niLV6OALorn2kYpyE8/uWxGl7XxWeivxdBGPq6ow=;
        b=n5hAGyLLxVhnQOD3AQTKkG4xpelXlt8YkDdRVRQe7nudYCis6k4zfzy0eI6m3okFpN
         6aLa58ezVDnKkwOyerNMFMD7v2EvZom4j6reYe9vVvHLqjrmga7gONd42jOTZSr2qMy5
         jGvbHheKrdblJbWa0k0bBDYZn0qNiyChqtDkxm+bhsuCsQ/C2LkkbMGvYDiqGWckWz1N
         Owgh39RmJX4BcneDe0u7vOUvLyC4ZmCH29L7zD3XAa07eJeVbHwZa7PTnfGkGdrcbMio
         NugbNec6lwJ7TUi9+jQhQbLuC27UxkZuQI4d2NyEAdvGOBTH/E3pla6tylOAM1epk2T3
         7tbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeTFVLJcbAFC+HstqOCmvLnVJ6bd9bN34llsd28SzgoUAaKKjVaHiOB89weBSVSGhMxa+lNYdMIDY00Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh2LhNTLFvQRZWWkdde2pWFK/Im8brPTqOBIkYy81WNt83eCTK
	i8g4HyechsZPt6dJEqgdzHcfNfpTOkL3oLtQDlSvd40l058CW9k/Pu8yjifjCgszF3R+3BRI+r/
	VNhOSxVm1uC53TKoC8pMFOWZGH7UN7yJz2pajotJk
X-Gm-Gg: ASbGncuvki9v+bwT63LfqaUmV/+mZtWeWYvdV18PS5l9OIva0/ehUgLotVKV24R/N3l
	qndGXtCMXhrs81Ji3ZyRWhPpODFBY3WNBbpuo63brOfW8LpsyXe285CZE+DsG7eg2Col5U31msG
	0y5MzOPiyo7o06IwIe4Oe3xTNPLXnrxnS9FyG9OQiKp9Yv/b02EJhdo73DEs9/h2iS9/PP7h3av
	KXYjYnssNYlp/668xfCpnyl/VezS2R5vOdmfg==
X-Google-Smtp-Source: AGHT+IGsQeQEfcu02S30Jll96c0wDwxxBcoxIYEXCRnd0CfJMcytsTVZIf/b8uy6EvvrTgZ3nUg/bsWlB2lNPIlFVmI=
X-Received: by 2002:a05:600c:46d1:b0:456:e98:9d17 with SMTP id
 5b1f17b1804b1-4560e98a5ccmr52570005e9.5.1752483316042; Mon, 14 Jul 2025
 01:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712160103.1244945-1-ojeda@kernel.org> <20250712160103.1244945-3-ojeda@kernel.org>
In-Reply-To: <20250712160103.1244945-3-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 14 Jul 2025 10:55:03 +0200
X-Gm-Features: Ac12FXymYzZFPEmEJ79-ojPY2RmA0JBZ1Q8D2S9b-wAnvsipbXwRr9MT_ii7c3E
Message-ID: <CAH5fLgiZsdW+98-_kMmGcdujQzusDcLMdGJzPk-6VG7pkC2bcA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: use `#[used(compiler)]` to fix build and
 `modpost` with Rust >= 1.89.0
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	David Wood <david@davidtw.co>, Wesley Wiser <wwiser@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 12, 2025 at 6:02=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with Rust 1.89.0 (expected 2025-08-07), the Rust compiler fails
> to build the `rusttest` target due to undefined references such as:
>
>     kernel...-cgu.0:(.text....+0x116): undefined reference to
>     `rust_helper_kunit_get_current_test'
>
> Moreover, tooling like `modpost` gets confused:
>
>     WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/nov=
a/nova.o
>     ERROR: modpost: missing MODULE_LICENSE() in drivers/gpu/nova-core/nov=
a_core.o
>
> The reason behind both issues is that the Rust compiler will now [1]
> treat `#[used]` as `#[used(linker)]` instead of `#[used(compiler)]`
> for our targets. This means that the retain section flag (`R`,
> `SHF_GNU_RETAIN`) will be used and that they will be marked as `unique`
> too, with different IDs. In turn, that means we end up with undefined
> references that did not get discarded in `rusttest` and that multiple
> `.modinfo` sections are generated, which confuse tooling like `modpost`
> because they only expect one.
>
> Thus start using `#[used(compiler)]` to keep the previous behavior
> and to be explicit about what we want. Sadly, it is an unstable feature
> (`used_with_arg`) [2] -- we will talk to upstream Rust about it. The good
> news is that it has been available for a long time (Rust >=3D 1.60) [3].
>
> The changes should also be fine for previous Rust versions, since they
> behave the same way as before [4].
>
> Alternatively, we could use `#[no_mangle]` or `#[export_name =3D ...]`
> since those still behave like `#[used(compiler)]`, but of course it is
> not really what we want to express, and it requires other changes to
> avoid symbol conflicts.
>
> Cc: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> Cc: David Wood <david@davidtw.co>
> Cc: Wesley Wiser <wwiser@gmail.com>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Link: https://github.com/rust-lang/rust/pull/140872 [1]
> Link: https://github.com/rust-lang/rust/issues/93798 [2]
> Link: https://github.com/rust-lang/rust/pull/91504 [3]
> Link: https://godbolt.org/z/sxzWTMfzW [4]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

