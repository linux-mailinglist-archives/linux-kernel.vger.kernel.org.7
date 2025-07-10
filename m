Return-Path: <linux-kernel+bounces-725744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 958BEB00332
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B7F586A57
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CF32253A4;
	Thu, 10 Jul 2025 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SO1ZSiUe"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EE122423A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752153657; cv=none; b=nG/60+H1XP5K0k9eCANikYfC9vJXFgTajUoHzg/XVBD8gOlyREnmhUQ1dWkaLUZ+nR6VNx1OoJQwMj7gXzAPjp6H/zezrfPq4rM5uJfMRInr+Xvl00W+9kTjwTRCT8VpopptrS/KMk0cYT69TnCOsbhZsyo2A5R0JXkQaZvandI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752153657; c=relaxed/simple;
	bh=bj9Gfo/3Jr9EZIY9fK3lkcHewhYwv0doXs2kKiWDFPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIVDDXsCaOPXi6Q70coc67YAT7Hq7ka57iKPLyfA4jE1sj5GP42OG0bFq5ztF9gaqabold8J9T8wmxv4I8p1OHG3xZlqj/L0zRQY8reW0Txv9LDI0kDr6SzQ2Nv4zMdiooPfd4Ac5IYFJSsldorw891vo/NG7GS08iqgudbgZ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SO1ZSiUe; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso7896775e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 06:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752153654; x=1752758454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/d3JWJXTPbcoiacIjfsqcFG5gW+YCew8k+ctgwhFlQI=;
        b=SO1ZSiUeXMtF9VJrlr6TVVAJueG/bcEFu6R61NrM5yK5eY/lFQBr4Xle8DLkpN1nTh
         icZso3d8rcwHB2PNDwby+uf6RS8Vgq+BGSESjX8j6NE+UCWMgAEEeCVfZSaDaU6bEOPx
         vn4zmaMNIl0Yd+Ff+RTrnNGUgF41EQ3SU8W0d4unGA0sKrnFsTrxQG1sVRV6SoExRwLp
         ooYVzniDtlSroGx4Y9NRMFYigkhOdIazMGOHuPGZl7dF+0+ch9GuLA8Ybd/MzdTnTkau
         rLfaDLY+/7rvuCNc/sNf3KFjteMucuqglpyomVg0JOLHwGaR/2OTB63Jhgb6rvWiwRai
         MU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752153654; x=1752758454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/d3JWJXTPbcoiacIjfsqcFG5gW+YCew8k+ctgwhFlQI=;
        b=kTOMNsWgLEKMZ7E8N8yNInjKEoHVpjlWBaP+rtQv8z+xgHIhCbh1tS8yV9+pWofQkv
         3kYk+k1nWX2U/lh+MgXM5xJHiZnY6pPNb/v5OuUIjOCxZq+8nY4RIbOms1tWtW9RX0tS
         d3fpqeqHnFacwd3xbKIvVXMHUfFgrpjqamvL3n/K8+r0DXppJR/1NYRY3SlPiLCSZvxa
         yN6l/CQkzqF8k5/WpwT1TCFWgmT6GXxfH2L2wflYH4FpA7QcxRRPx7b4VDkxRHnF3iaW
         k8O6fnj1TTN/Tn8kmO5qj3Cg9Wfn2HTWVKJCJ2pGnJ8U5mf1+2egEDnUZSBkpXDLRHij
         okgg==
X-Forwarded-Encrypted: i=1; AJvYcCWzDYWsdmT/alnzW7zMtAw/KlxfrBW9u9W92yXfRd0IeeAHE0Y9AtxBmuOG3yTHaKF7vfpXl/xrdH+llYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkq6AOs2o6FQQqJVHOpkEP4KcVX/bioofCEAPzlgYyPyXc6wt9
	BGNpTBG/Yznt3l8bsLoh7a7IMYDbm/RFpVjia9FoUDIY7MQfWj3AQkFOV2KPegyPnLHC0kWPpH1
	iSHNuS5vc+Z+QqS9QUUxgWzJIW2CG989niZVjKb5K
X-Gm-Gg: ASbGnctVL9Uoxi1o5yWncTSYXtw1DyiXOHmhg9NsM5N1YyM5WvBd2WzGndbiX4cTWoY
	CG5dy/YVPnT33axje/mXKiKHrVXKsKhiM0yhiY/tVzhL1VhACyYIGD3MRq4p4HxuRMDbv25vb/r
	e8mHbY7wIoIuczPBqiJAI7L2t0J4Kje7+t40uEDEbZqkWBSGnhCG+F0EqQqM6rTxi7upOC9O1DH
	w==
X-Google-Smtp-Source: AGHT+IFujM42vH3V09euhJ0T7/vZlUGl5l2Mqd+XJHCpPSNb1kApqRjCh9Jtd3SgLVxJgkK09tgAyiBl1EsMOOSUJIA=
X-Received: by 2002:a05:6000:2806:b0:3b2:e07f:757 with SMTP id
 ffacd0b85a97d-3b5e788d3d0mr2685032f8f.1.1752153654256; Thu, 10 Jul 2025
 06:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com>
In-Reply-To: <20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 10 Jul 2025 15:20:41 +0200
X-Gm-Features: Ac12FXzitYxvRbQjbTDWexl7FT9vfcJPNeta0DSIvcawfTODepd7_rNw8p5wCA4
Message-ID: <CAH5fLggU_DsJ4-gj_xBeGgG8mS4CSrypNsmOqu6c677Lyyvqxw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Replace `kernel::str::CStr` with `core::ffi::CStr`
 (cycle 1)
To: Tamir Duberstein <tamird@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 10:16=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> This series makes preparations for the replacement of our custom `CStr`
> type with the analogous type available in `core`.
>
> As this is a large migration that touches many subsystems, it will take
> place in several cycles, each of which may see multiple series:
> 1. introduces facades in the kernel crate that downstream
>    code can reference. [this series]
> 2. migrate downstream code to kernel crate facades. (N series, divided
>    by subsystem).
> 3. replace kernel crate facades to allow `Display`ing foreign types
>    (such as `core::ffi::CStr`). Replace `CStr` with `core::ffi::CStr`.
> 4. migrate uses of `c_str!` to C-String literals. Replace references to
>    `kernel::str::CStr` with `kernel::ffi::CStr`. (N series, divided by
>    subsystem).
> 5. rename `c_str!` to discourage use. Remove `CStr` reexport from
>    `kernel/str.rs`.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> Tamir Duberstein (6):
>       rust: kernel: remove `fmt!`, fix clippy::uninlined-format-args
>       rust: kernel: add `fmt` module
>       rust: use `kernel::{fmt,prelude::fmt!}`
>       rust: str: remove unnecessary qualification
>       rust: add `CStr` methods matching `core::ffi::CStr`
>       rust: use `core::ffi::CStr` method names
>
>  drivers/cpufreq/rcpufreq_dt.rs    |  3 +-
>  drivers/gpu/nova-core/firmware.rs |  5 +-
>  rust/kernel/error.rs              |  8 ++--
>  rust/kernel/fmt.rs                |  7 +++
>  rust/kernel/lib.rs                |  1 +
>  rust/kernel/opp.rs                |  2 +-
>  rust/kernel/prelude.rs            |  2 +-
>  rust/kernel/print.rs              |  6 +--
>  rust/kernel/str.rs                | 97 ++++++++++++++++++++++++---------=
------
>  samples/rust/rust_print_main.rs   |  2 +-
>  10 files changed, 83 insertions(+), 50 deletions(-)
> ---
> base-commit: 769e324b66b0d92d04f315d0c45a0f72737c7494
> change-id: 20250704-core-cstr-prepare-9b9e6a7bd57e
>
> Best regards,
> --
> Tamir Duberstein <tamird@gmail.com>
>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

