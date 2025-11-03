Return-Path: <linux-kernel+bounces-883766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC94CC2E5FD
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 00:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470BA3AA866
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 23:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAEA2FDC31;
	Mon,  3 Nov 2025 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMiHZA1D"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE5B2FABFF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 23:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762211159; cv=none; b=dFFdD3fp6p0RDr4KVote1EME06L8ZZeXh++LHuH46StRXvnJNOoMIFzKHS8qpq9jFr8SFsy4daKrVtykT9/Jxefe2AkGCPnKUJdNCdDMHO6X1poaVW3tsVwV8p75IdOIQelsSlDQiTrO6dYaHYZtkya4KU133LcWcWjemKu+e1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762211159; c=relaxed/simple;
	bh=wpVJWBuenZcD3eSVXXuQBdHxyRZUm/ZGGvsoPgMAlCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIvBl3KzkHB2QJ9U4SmhcT5ztzRHgKYcJ9OaR10F3IiGzl8+VGCGxQFK8at5b4dHr9PogiYS267Ho6X60YtMA7SadxIRJV3BMoV3Ms3aY35dT0QOcud6FRwm9bwvu28lHPvP4vC5yxv+RJO81XORHszP7c502N2CLiU0qIAdt48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMiHZA1D; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-28d18e933a9so4791035ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 15:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762211157; x=1762815957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogon7TK6sOugcfKJJppW+WnECgyNYUKvMApdomYEbKo=;
        b=CMiHZA1Dx3TONUc1uZHfqLTY7pYjVGhppzjfh99oqjSc5G6TRcS4jMtNzlwmIts3E3
         y8bFQ8QVMOTvVX/EpzNoQLJ3j64+hwAE4YusSzS3JcnVpcdu1UyJP3H4mRz60h7HjMCQ
         FR2fpLyws20tNwjfyEDwODyz0t9rhbE8W7Ws/cjVfAfYj3jIlwRwUw+S/yqhijCI6ZQ1
         7T233cgYC4xnP/sPKtzAmODvFl/bA+tWZnqOjLXrHHkYps3uQl9enlYMv78BNMvig5co
         iWg2ytYb/XHpX6IIc35vuYCyJOcq22owxU1WEBYOLGUL0nRDqvvHDgtoZ1+WevzBKGUC
         Q3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762211157; x=1762815957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogon7TK6sOugcfKJJppW+WnECgyNYUKvMApdomYEbKo=;
        b=vI/xFXS+Dxl4orSdZLAJU2XOe6K5T5P35p3JSMAIeOqxjFgU4m4ICV9u7cz5UvU9Fh
         rCSOxmCbCbN4XMiCHCcyghj1RwdUhwt/vRG/WGWGwWcNKTtkaTeZt7IATj5iCKX1jxLk
         0m+DDBukvw3bPFpKmoA36egq+IEvlMBSGvleQyF5cg7UF8c3KjiCgGEGDpBKqn0IIqXc
         Pv72rm2mNKkpR5+eo+e/O36EP6Mh0uoHvs5Mef/4wH+dUJUu+dqW17FxlmMDKlIE4w64
         q5OjQurlMLU8aqUKxc+6ZYUgjnJ5I9jOBorwkv6dd8O8cxOCvFV1f2KAvxjquVSX0qXI
         5Hdw==
X-Forwarded-Encrypted: i=1; AJvYcCXMMYeSiJnbzkfNVH2wuncLDTc6x7LCW854ZfBvceLegupuZCm3Vu0hzG97L6EAOqMUARRDYzGaek7svng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxipq1Em1E8l8fpPOHfYN6ClVaGhU7xJSW+igoFLRqUBs5nwZX
	oYflDBjtcj5poeEU6hXL7Rh8ZPnwbZzKTFucUnoz89w+SetBw7oDnxeaLy3J8ZSFGHB9gEWXxvx
	RFR16rddJ6gkmM8Wqn8sR7jcGIzVyy90=
X-Gm-Gg: ASbGncsJigJBQ8fBZZ9KJcNrJeLciES5GgswJBkyldEHoJdoDi1NyaJTmMsrB3LTYhX
	/r1SDAlkijrxRhdg4o2JAeDwAUGfjQ2hpJnBX7/oWvGHBsRpN6a+iYNqGYhx9qtmvCMqxh3/Y9H
	bf3ONhu+dnm5iV4/bSwzY8dj1bwLI/gpHjmACHe2A+y0brvwVO9fMkMrOUdtCUS8QC1jbns+ScI
	aUkxC8N3EXTAlfCuN41yHQ8r6FEVX8ByIjbrk7AVCMyUh9+OtDAdVbmYPLodUu5jiyQlLxa8QDw
	z5hsSXqIReqd3HyNt1sH8rvNGp4tcMH7DnxLbht6e2ahRXvWit57GvIHjxNJPPAQLcZohM7n5Sy
	vT0zDPedPlx8pDg==
X-Google-Smtp-Source: AGHT+IHugv4iFaTOCN4EOCjTVF2FfjlZWUSHrrn/GBxoYhXzdeo7YpUX0U5SRp9TWEaFsHczNUaXZUgkuqVdFch+J/I=
X-Received: by 2002:a17:903:187:b0:290:ad79:c617 with SMTP id
 d9443c01a7336-2951a380699mr111057345ad.1.1762211157387; Mon, 03 Nov 2025
 15:05:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102212853.1505384-1-ojeda@kernel.org>
In-Reply-To: <20251102212853.1505384-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 4 Nov 2025 00:05:45 +0100
X-Gm-Features: AWmQ_bkuLE73e6Hn0H_oMw4VNuro5lNa0qxJ-qywqWQaWYuKfzn120mRL3CMPr4
Message-ID: <CANiq72=0JJz5XDHGpiyQBd9AmPCr4veJ=2oJywyyqQB8iMxqvA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: kbuild: treat `build_error` and `rustdoc` as
 kernel objects
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 10:30=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Even if normally `build_error` isn't a kernel object, it should still
> be treated as such so that we pass the same flags. Similarly, `rustdoc`
> targets are never kernel objects, but we need to treat them as such.
>
> Otherwise, starting with Rust 1.91.0 (released 2025-10-30), `rustc`
> will complain about missing sanitizer flags since `-Zsanitizer` is a
> target modifier too [1]:
>
>     error: mixing `-Zsanitizer` will cause an ABI mismatch in crate `buil=
d_error`
>      --> rust/build_error.rs:3:1
>       |
>     3 | //! Build-time error.
>       | ^
>       |
>       =3D help: the `-Zsanitizer` flag modifies the ABI so Rust crates co=
mpiled with different values of this flag cannot be used together safely
>       =3D note: unset `-Zsanitizer` in this crate is incompatible with `-=
Zsanitizer=3Dkernel-address` in dependency `core`
>       =3D help: set `-Zsanitizer=3Dkernel-address` in this crate or unset=
 `-Zsanitizer` in `core`
>       =3D help: if you are sure this will not cause problems, you may use=
 `-Cunsafe-allow-abi-mismatch=3Dsanitizer` to silence this error
>
> Thus explicitly mark them as kernel objects.
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Link: https://github.com/rust-lang/rust/pull/138736 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied series to `rust-fixes` -- thanks everyone!

I will send another less urgent one for 1.92.0 (in beta now) that goes
on top of these here.

Cheers,
Miguel

