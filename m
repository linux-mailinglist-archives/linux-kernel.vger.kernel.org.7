Return-Path: <linux-kernel+bounces-895552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A9EC4E427
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF2EE4ED526
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D805D35BDA4;
	Tue, 11 Nov 2025 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM6fBr1Y"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF7359FAA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869293; cv=none; b=SRMx+N2fNBsUoMaxEC77doU2egnj+VRBYNn4OH2TaO7rtorrHLl2MgUnw6yz9WQ6WH9qJdr2i4J44eQD1jJSGvyK6jAgZFbaNMOKbldZD1J9QwWpYaNo5pj/R0Yj/TOzAclaejzNJfpNRdNmcC9bhmgm7d5SjR4ZCxd2NJxTL4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869293; c=relaxed/simple;
	bh=A2TkjakrfDdkYRGuTxjcRqTay/V7iT1zDDZWS1m5mUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TySBtlgxy0tNadjv+njTh+dLZpTzfSjoBN3j9hXCYrz1kfDZsIYC6zplvnh6mlFcnaBjBsKEmZghzK0bhZ2z9doSVv06UgEfFZsBAliut8S0rk7ZbxvjF+GY3o2OTDfhc0PQGvyEkPeoxERM2NDiIBl+YhEJZY3tI5ynXfNSjm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VM6fBr1Y; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297ea936b39so4128005ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 05:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762869289; x=1763474089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZoLj4f0GVdI3DGKFlEJ4QWVzpBGFdDaaHgYw2dfwqU=;
        b=VM6fBr1YGmxYu0TgqLDBmuYZthtRhP2l1NGNo+6VXxP63RHkYR6cUAEkj/dIxOGUDY
         oNeBF75BrIsmhCH442DLOVHmuDmCsnEl07eWREbkDA9cPqBd3p2KFNJhMdz5pcwbE521
         Uv1XYgqMlp06hHuWENh50Z2/aORP8v+Uc6ccSwTdklMewwZ5TgE7Zz6CH0K+qfQ9ZAkF
         nqzieJYyDxQ6ixKS9ex2CgxZLk0cZrYMJrvIq+lWi6e4d5+nzro2LqyuaPGMjGdh1/Gs
         6HaKBVvNAu7EXRjl3GQZRcdOkpSHq16Nhy5lEsaoRcfzicfeYvXeY+bOkLsY+uQVSBXN
         t74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762869289; x=1763474089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DZoLj4f0GVdI3DGKFlEJ4QWVzpBGFdDaaHgYw2dfwqU=;
        b=i15jmvOPirheAfZ6fZa1iaDWw9pa0xy2K5xDVW6gmGtX4PArt0cF9Qw8YoHMgSUDSv
         L0olZ2rlQ8GNXu+xHcEHO2+khDoS2fD+QOpyAVbamwdz6C4SZ0Bi7/cxCWzlyPihOAaO
         idnU8wsqjbsnxZvq1FLEEtvqeOupLxUrjX8EDEqtOoDrRQ0vjmHFep3zZXAeSjuKx40l
         qDQweGvHXJ4ldISgHUxC4IRpd3fqipQrgsMps4mYSebPefLF2gNPiOy3xbjMKvUGunqg
         z6A05EvDqkoAg6QK0tUuLF7AGIcCP74JGa5C+ZPi0YQyKLRazUg0eLNkng1o9ByQ7MYb
         AM0A==
X-Forwarded-Encrypted: i=1; AJvYcCVudmB6PNmfuCzG2Ik1Pnw32RRQbv8YZq5YcyPDXQlyAmu8IA2orXo0AW8nAgM+0tV+ESF+YiBe6ifNBao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwItGWMIUOVNka7/wsAGJuf/NB8X6yj0EAbtW3g5iHrXLnUoZQq
	hQzL9GeBSIbbEJHlmUqTRGMKtGcxOJw+ZliOVlkkgtzGKT4a/1YICBvU6JQDclkPilOHGSbdwaJ
	SwtQVlZT2D61p+arHfotwHSYM7k+5+NI=
X-Gm-Gg: ASbGncvExtOQspz4Ho8vyT4VTofsKQnZim/1RSwEOqO4WXWIobsHu5UK32pFbDYZfNd
	RoTpZInJFVUnGEPt2JfiLa/cpNYEH9tdCrI/6Slt8H1jvxRTvx7u0kA6jGzygncg6klO8e/liwz
	gz7HvDhof5js/u6qAVVU6jV/GesvHjJqJhOfu695nP6wsQotES6h5LcSMaHfw5astc+kc5xg9e3
	CPB6FB76YrLTcvAUCxayQFoWyW3DQ1vtTgtSEfeGhoI30OgsZFUNaiWhJ78U+3ePM657ISUBukI
	AOEF99TBiKvFgrMzArwEWnCAlcBzLnxCblXpjE1vCGGOL9AJCv+YnNz6KMlEguIoctIy4ggVd+Y
	ohbfhVqsziBqv0Q==
X-Google-Smtp-Source: AGHT+IF0Z68cGNnWIYfhE+GmNXty3zSKglcsJIW8DTGnNaR5oz+N94f18Ae9bgXwDGF1o3kKuYh1bmeQkQ96c2H5z8Y=
X-Received: by 2002:a17:902:ea09:b0:295:511d:534 with SMTP id
 d9443c01a7336-297e5731561mr84933915ad.10.1762869289453; Tue, 11 Nov 2025
 05:54:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110131913.1789896-1-ojeda@kernel.org>
In-Reply-To: <20251110131913.1789896-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Nov 2025 14:54:36 +0100
X-Gm-Features: AWmQ_blj1Y6aEDrIDY1SHsBj9ipAJhqLELG9lX2PJ-XtkIigMIPK_72YnkrkjN8
Message-ID: <CANiq72mjFobjfQEtNvk9aA+757RkLpcfmCCEJAH69ZYsr67GdA@mail.gmail.com>
Subject: Re: [PATCH v2] gendwarfksyms: Skip files with no exports
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 2:19=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> From: Sami Tolvanen <samitolvanen@google.com>
>
> Starting with Rust 1.91.0 (released 2025-10-30), in upstream commit
> ab91a63d403b ("Ignore intrinsic calls in cross-crate-inlining cost model"=
)
> [1][2], `bindings.o` stops containing DWARF debug information because the
> `Default` implementations contained `write_bytes()` calls which are now
> ignored in that cost model (note that `CLIPPY=3D1` does not reproduce it)=
.
>
> This means `gendwarfksyms` complains:
>
>       RUSTC L rust/bindings.o
>     error: gendwarfksyms: process_module: dwarf_get_units failed: no debu=
gging information?
>
> There are several alternatives that would work here: conditionally
> skipping in the cases needed (but that is subtle and brittle), forcing
> DWARF generation with e.g. a dummy `static` (ugly and we may need to
> do it in several crates), skipping the call to the tool in the Kbuild
> command when there are no exports (fine) or teaching the tool to do so
> itself (simple and clean).
>
> Thus do the last one: don't attempt to process files if we have no symbol
> versions to calculate.
>
>   [ I used the commit log of my patch linked below since it explained the
>     root issue and expanded it a bit more to summarize the alternatives.
>
>       - Miguel ]
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Reported-by: Haiyue Wang <haiyuewa@163.com>
> Closes: https://lore.kernel.org/rust-for-linux/b8c1c73d-bf8b-4bf2-beb1-84=
ffdcd60547@163.com/
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://lore.kernel.org/rust-for-linux/CANiq72nKC5r24VHAp9oUPR1HVPq=
T+=3D0ab9N0w6GqTF-kJOeiSw@mail.gmail.com/
> Link: https://github.com/rust-lang/rust/commit/ab91a63d403b0105cacd72809c=
d292a72984ed99 [1]
> Link: https://github.com/rust-lang/rust/pull/145910 [2]
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

I will send a couple other fixes to Linus this week, so if nobody
shouts, I will be picking this one.

Thanks!

Cheers,
Miguel

