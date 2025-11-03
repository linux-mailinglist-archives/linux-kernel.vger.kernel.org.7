Return-Path: <linux-kernel+bounces-883469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20482C2D88D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4CFD3BD45D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE1D26A1B9;
	Mon,  3 Nov 2025 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="RL9oQ0iN"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADAB21E0BB
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192105; cv=none; b=WvgafM5KBJQry0jsehQRZ0Qp0+2yW69vTOQ21JMWTp8gd5GXWgT7i2r+oyaGAxQQ2u63KdptcTn4RPc7SuGUjtsNDCEqBimOAIt66w2t0/yV4In2le/kzykhurUEdT+XIICtK7nfFbhZwGcK+RkbDu8DFaKdmDcX/WnScd5jGIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192105; c=relaxed/simple;
	bh=DZohdGmwhvfS7Y62yh/IEXkOppV7V3lqoMgTejWulFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T31D/EZyG45De5w7eHmNtadpIOYQnqecogvhsG2bp6glOXGwWW+GJK1Wue/SdH7cXEWE0jWuICn1r5STl0rpQ1VShEqyXtxi7rLwASfTnqqie75WkWbB/dcg1cNGxHiYrhgzW/ThtOMLC9k+pkkrhMaAYchuzs636BGtOuuwMlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linuxtx.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=RL9oQ0iN; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linuxtx.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-433217b58d9so8383255ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1762192103; x=1762796903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWkOe5YDiqYERha5LD7zMqeSoJ/N7fJr/JJ2cnjXNyg=;
        b=RL9oQ0iNkWnjynRpoeRSTn/PDDB+2Z2SiA/hlgrKBN0orRhtuTcBlBjncpxg9IS1wV
         wvl/0yvVKcIv+A4y7w0YmC3eGL33jnmkBFjBRnq4DT9h4KVAZ8GT0pV9xJEC6ZtsuqVc
         yHhU01Qmml7krU4BMRvzmvvDsmdQXOzWVVt/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762192103; x=1762796903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWkOe5YDiqYERha5LD7zMqeSoJ/N7fJr/JJ2cnjXNyg=;
        b=p+kWmXAehnxX0Xol4a+TurxIukH4wFEf6uWyoDjf0Rj6WDJo1ox8/pN1Kxni0FalJW
         Qjbd2UQDZyz07c1JxZLuM5mnlC1mYoin/h96dwtiHEdu864M1RFaAHZNzM4Nrm8LLxLD
         Y7DAbPJL1ulGjpSnoHn3M7HFBjyDPjqY0jGd3u21LyVrdMmvu0tpoKbexK0xrBwUGXUm
         qPSpRrEr0+dEvfIHLrEH0DFh06kfLxqYBUTBFZFF7yLyjFoYzKhA4zHtvz+mozwmcnAf
         DNdY/uEN36HSILm5c2N/nKgQ8TWYhk86hFza76yAyf6ZjacOTjCAgb2UPYH7oHnygZuw
         04AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwO9MrsjUPgcrvtE5w5fyDFiP/0UamXgDkgAszZNWqCllxsuhcCMgrNw+O/BDxh6l1U3MfTQQ7O+nV5aE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyrC4om2IcsMA9Rhk9qFS+x7gQWKT1cg7GQsdKqYTCXGL9HLJd
	qw4lg5T1tUHBj0YL261HU7bNqOWXe+71ZVLtqVdHtcdQ4p0/A3wQRVxBHPOZSozMdl+aMMOAlFI
	JMr5Ari9xYXYtF+/zSrbrbm3KelbyMF3FJhi8Nzb8
X-Gm-Gg: ASbGnct2wvoWlz7WGsAIacjLeTyIsWovQ6J+gX4TAjcr0gnJq/Apllqrmbifpqz/35K
	gDiLJYHSR43z64A5jwLcd7TT5KeFE2lqWVBVVRdEJKfKCpQCszimpUjMq/wdZIf3LQR/Be51pje
	nlpGKtvRl6jU4qz9qxxlHPIMAQ7sXQ88uiEHW3V/EJQuymxmzqr58tMCdQ9UbRHqISaVCVTYLqx
	bSKf7XGCche9jEPx6poOFytuT81cqQ4TkrpGX7KAEVm7RBqOEZtG08sTu0UjA==
X-Google-Smtp-Source: AGHT+IF9g9cwwuNwEQElfAQDhH0pHEpQX+9ymSaDZSx7wt1xXs7tDoLgwlfGaAsR869GJ5w28gauCBpymwrx1MG7HaA=
X-Received: by 2002:a05:6e02:470e:b0:433:22fc:bb9a with SMTP id
 e9e14a558f8ab-43322fcc5d4mr112236115ab.13.1762192102332; Mon, 03 Nov 2025
 09:48:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102212853.1505384-1-ojeda@kernel.org> <20251102212853.1505384-2-ojeda@kernel.org>
 <aQiDdZvRNrBkrB-U@google.com>
In-Reply-To: <aQiDdZvRNrBkrB-U@google.com>
From: Justin Forbes <jmforbes@linuxtx.org>
Date: Mon, 3 Nov 2025 10:48:11 -0700
X-Gm-Features: AWmQ_blfBw9zTFrICe8pc1ZBkE8gZV528mb4K6Tu6zlEDetF0EtgCfFYO7hVTdg
Message-ID: <CAFxkdArACiepmcjk7GFH313db4cpXDcWouVy4a6zQTMR1aDmPA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: kbuild: workaround `rustdoc` doctests modifier bug
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 3:28=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> On Sun, Nov 02, 2025 at 10:28:53PM +0100, Miguel Ojeda wrote:
> > The `rustdoc` modifiers bug [1] was fixed in Rust 1.90.0 [2], for which
> > we added a workaround in commit abbf9a449441 ("rust: workaround `rustdo=
c`
> > target modifiers bug").
> >
> > However, `rustdoc`'s doctest generation still has a similar issue [3],
> > being fixed at [4], which does not affect us because we apply the
> > workaround to both, and now, starting with Rust 1.91.0 (released
> > 2025-10-30), `-Zsanitizer` is a target modifier too [5], which means we
> > fail with:
> >
> >       RUSTDOC TK rust/kernel/lib.rs
> >     error: mixing `-Zsanitizer` will cause an ABI mismatch in crate `ke=
rnel`
> >      --> rust/kernel/lib.rs:3:1
> >       |
> >     3 | //! The `kernel` crate.
> >       | ^
> >       |
> >       =3D help: the `-Zsanitizer` flag modifies the ABI so Rust crates =
compiled with different values of this flag cannot be used together safely
> >       =3D note: unset `-Zsanitizer` in this crate is incompatible with =
`-Zsanitizer=3Dkernel-address` in dependency `core`
> >       =3D help: set `-Zsanitizer=3Dkernel-address` in this crate or uns=
et `-Zsanitizer` in `core`
> >       =3D help: if you are sure this will not cause problems, you may u=
se `-Cunsafe-allow-abi-mismatch=3Dsanitizer` to silence this error
> >
> > A simple way around is to add the sanitizer to the list in the existing
> > workaround (especially if we had not started to pass the sanitizer
> > flags in the previous commit, since in that case that would not be
> > necessary). However, that still applies the workaround in more cases
> > than necessary.
> >
> > Instead, only modify the doctests flags to ignore the check for
> > sanitizers, so that it is more local (and thus the compiler keeps check=
ing
> > it for us in the normal `rustdoc` calls). Since the previous commit
> > already treated the `rustdoc` calls as kernel objects, this should allo=
w
> > us in the future to easily remove this workaround when the time comes.
> >
> > By the way, the `-Cunsafe-allow-abi-mismatch` flag overwrites previous
> > ones rather than appending, so it needs to be all done in the same flag=
.
> > Moreover, unknown modifiers are rejected, and thus we have to gate base=
d
> > on the version too.
>
> Ah .. we may want to file a bug for that.
>
> > Finally, `-Zsanitizer-cfi-normalize-integers` is not affected, so it is
> > not needed in the workaround.
> >
> > Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned=
 in older LTSs).
> > Link: https://github.com/rust-lang/rust/issues/144521 [1]
> > Link: https://github.com/rust-lang/rust/pull/144523 [2]
> > Link: https://github.com/rust-lang/rust/issues/146465 [3]
> > Link: https://github.com/rust-lang/rust/pull/148068 [4]
> > Link: https://github.com/rust-lang/rust/pull/138736 [5]
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

I can verify that this fixes kernel builds with rust 1.91 in Fedora.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

