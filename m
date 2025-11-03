Return-Path: <linux-kernel+bounces-883468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E104C2D87E
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0564A3BA59A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513D921CFFA;
	Mon,  3 Nov 2025 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="OBJcL6dm"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0420B223710
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192077; cv=none; b=KJnh0cyE/5/yqgK7z/B63x/nKJkMxr3oPNGYMkKt3YZHmhWuOkuAOK/XcPSGIwx/kNDGn36Vp63uE/eIX5FYSNvLf3PG2Ts7nKgKqfSM8XNIysub17BoV3x3tcwhRgpE1nm9WSfQDVjUlLXJv0sI9J+7UGQE6JCfFjNj0o6hZ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192077; c=relaxed/simple;
	bh=SgKh3F2MqSvY/+atnwKQbzqTAv1ZnedXCRhqmQOnc24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7Vu2HIBquN9IvqDODe4c7kPgRN7zx+zCAZ30knZOpw95gLqWHcL1O3g/n15dkRww9ZkfjF0IbrgdcoE3+Pc51zdH3zrvgT2TF1y9S6aChKMI6lFX/QbI1mdQvDrKAKriT544RlIujOrP8qi4lKYwTXCAST0j8PR+QJxNFMsgoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linuxtx.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=OBJcL6dm; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linuxtx.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-9483ece8d4aso77288839f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1762192075; x=1762796875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjAKDCwmdTaGo3dsotYYIlyzJDEkmULXfXj+ZPIjvrU=;
        b=OBJcL6dm59zkEX2MVYKKWpnpZSg60u3gIanBYB1fBVpqGfbfKbY/MwUcefeIz0Mp69
         XNDI9sY9Dl7TwK5CpY+q2XnBWthJXWDzY7MNOGBQiW68lQAvl9lJggMoyfQs44diVvDQ
         /wdZpYucEgUnuNZG4/h7eHk3y0lHlkIRayb+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762192075; x=1762796875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjAKDCwmdTaGo3dsotYYIlyzJDEkmULXfXj+ZPIjvrU=;
        b=NexMaWoeL4LTe+fQ06YfAJ80OL7+QBAI7zAVhcrAZHKAyo0IGe4gLFUtu3sEViK7A5
         nobrSPSm6B8jCr+q4uOWOPgt4NjIEbFbuJURDPxW4sUOSUI3ILnq+1fkqeZE5is8o13r
         8iWZjKrAcJoA2GSacLgT4eQOD0d7h+avZ4wgrrsV65UPCcRTsyE0sZZRuddgwzvoiCx+
         NJRIMeXue5LON+WGgisuUqOUC2KHN/vb5iPRcCl+qDFNpZQ/T1roQUZPlTP0S9vBTVIQ
         gUjlFyHghlHNV6dRi/jJ1UY38XVY9JI3CWGYFChBJr6YoQv8ZtrF+4bUUs6dlHgBZgWf
         ILIg==
X-Forwarded-Encrypted: i=1; AJvYcCXJxbJJgwKyEkHe35LC185iI5be8hzWCOrPjWKa3cw0MylJmYFiB386+AuIr/+RBVFSZN9gu5s+pjB43eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIXo8rAGlqu+grC1qzFMEz8o8QEpn0DUrYeeS6SjWMiY8Rs7zr
	ykN+dWaR1h8B0/ES+szYwAfwFnNNR1CLYcm8pNd1mEXDtGMsLs7EPtgoOzeBWkAUSFHsqBxoeKv
	8iEuYa7eh5npf3EUoMM6SP5dVu09ffSYP/Xw4JMmY
X-Gm-Gg: ASbGncvlqClLywAdbRmudj4jwH7ZA9Aq+jGhGeXQoOcechnVpfOtZz2yW6hDU/xcGBr
	HqkHytFmKpFRCvruNnUUJxbc4L4yBaeQGH+zNRUNlJfbcm5IFnbbGvy9mZvIizXWKViloUoo2H7
	i0PL55LjeyNK+Ts9H68rTGvA1KxvCuHUrzMN5rSAo71l0pkdumJcIUONomcYE56MN9/DRXn5qag
	hKR7AW2USsJ66AmunTw7q7kqXTiSa+McNDbZBDucwqYpuhfX8qP+z7/UcxGz8c2yjli0la5
X-Google-Smtp-Source: AGHT+IEoZVeUMOUD21Jwvlvqg2DuQudLZFKN+F2ECw8IcJFa2Y5MP2DG+/93iqFN9rXQ8x3ei5N8FSQ+NKgZ+YBpzNA=
X-Received: by 2002:a05:6e02:12c1:b0:42e:d74:7260 with SMTP id
 e9e14a558f8ab-4330d217155mr180383195ab.29.1762192075132; Mon, 03 Nov 2025
 09:47:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102212853.1505384-1-ojeda@kernel.org> <aQiDjuHK0qpgmj1J@google.com>
In-Reply-To: <aQiDjuHK0qpgmj1J@google.com>
From: Justin Forbes <jmforbes@linuxtx.org>
Date: Mon, 3 Nov 2025 10:47:43 -0700
X-Gm-Features: AWmQ_bnqgY3TD7_cPq8iTJOPSR5fRhrV4vLHy7AAe5o1XlAgXCBBQw2b5bBW9MI
Message-ID: <CAFxkdAqxuFDMraNBNrOXPDpRzQTQftmc+QQMh_PVMgmLkuv=Tw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: kbuild: treat `build_error` and `rustdoc` as
 kernel objects
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

On Mon, Nov 3, 2025 at 3:29=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> On Sun, Nov 02, 2025 at 10:28:52PM +0100, Miguel Ojeda wrote:
> > Even if normally `build_error` isn't a kernel object, it should still
> > be treated as such so that we pass the same flags. Similarly, `rustdoc`
> > targets are never kernel objects, but we need to treat them as such.
> >
> > Otherwise, starting with Rust 1.91.0 (released 2025-10-30), `rustc`
> > will complain about missing sanitizer flags since `-Zsanitizer` is a
> > target modifier too [1]:
> >
> >     error: mixing `-Zsanitizer` will cause an ABI mismatch in crate `bu=
ild_error`
> >      --> rust/build_error.rs:3:1
> >       |
> >     3 | //! Build-time error.
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
> > Thus explicitly mark them as kernel objects.
> >
> > Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned=
 in older LTSs).
> > Link: https://github.com/rust-lang/rust/pull/138736 [1]
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

I can verify that this fixes kernel builds with rust 1.91 in Fedora.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

