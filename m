Return-Path: <linux-kernel+bounces-739919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9143B0CD08
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268B117E69F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78C323B61E;
	Mon, 21 Jul 2025 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CL+5bBN1"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8AF22D785;
	Mon, 21 Jul 2025 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753135184; cv=none; b=LRZubjnS4iJMjSUWvLnBhqGS3euVtdIKcnFYa5SvNTMRE2C05qH0AHwLmB4MOU3Y2/mS5G5FeygU81ypQqSQ5YH0msp6lMxbKaLNC+QnS5lwyEFsSwiYcIKtDrVlp+5KsbrX3NvQW2feh4DEZVp5juUoVOM8tTr3b1Ye4QsQi0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753135184; c=relaxed/simple;
	bh=gCOOFpCoTt+/b7OiEKIdXM21IF0ykuPxhhT1C++qe/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wr7etF11D/EggZ6f+W8iZBkHRDSKIc5A4FGXFqOjBE7FG0vEqqWf5wOsngNm1F9R7ASo8q0KIYDU1utLc46yapD3bf4h4lb/f9YfiXUG2OnNPk2sxY0S3aXHee+mQjcgr2OVaQw6yDX4EaiJoqj2Lrpig46tUXsYZRsFLw8tRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CL+5bBN1; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-313fab41fd5so1214176a91.1;
        Mon, 21 Jul 2025 14:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753135182; x=1753739982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCOOFpCoTt+/b7OiEKIdXM21IF0ykuPxhhT1C++qe/c=;
        b=CL+5bBN12QAY0ixKUThGx6WELosGHcOBmpcBhj32rR5XmmZiprhz1lT8sBBZu/UILl
         z4kMwkASrBcSBhTymUzLq4PBdtvznAhaVB1a5xX89nNbydMq8Pm3+mXpMmdac6DUGx2p
         mmYXaYpjvzkxpC40K2GDnqJAGGqRo6SV0+goslVIGFPYx9UBy12LHBG4cQyb0EB+rAI+
         tDk1SNSDaj2KmdCblBxI8o6v5j+AfDzkkGM2dHxm3r0zsiO7ntXbEXFE9Zndz6dq4VRi
         QcEQ+a4RdKjz7XW0WQmCI6yCeIqQxNx0q+weBFiOJQhA0TcsUmmKzBqTpTH6foATQKMI
         Tu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753135182; x=1753739982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCOOFpCoTt+/b7OiEKIdXM21IF0ykuPxhhT1C++qe/c=;
        b=pPqpYOAYvOYgpkGdWLKIgbGgz4zDg4EnRG0FCnlcd0vf4RC+xJsK4VgsYWnfEl8b6K
         0Vl+KVft1PSvut+s0a4LjtKRUtYd5Y0P2j03IktgQ1Bw4Ua0RSesRQF6dZWqXfQNiqax
         lwM3m6uhwkmYQ1fPpxsYC/xEMQRqnBb4y3yzjXoZ+1Fyhwbw+IpTKY1i6NOLbX9uhzvn
         dlSid2vrixp+0D3FmNtPvFKSfEFhz8iQY2oxhT4rHDC2quTzJERnrgMyXE7R1GuKTScm
         o/QE9qrpx41/vV281f+Du1aCILiToRx3RJmGd+2itGs3SsL5WRCF119lM3APEHacRVFh
         M35w==
X-Forwarded-Encrypted: i=1; AJvYcCX5zF9Z9w7b9afnLLbDZrPolgoQu65A7/KvHBs2zpCO5VZ1zU2eskMuYWcSls0X2MReTQuk03oklRhlQVQ=@vger.kernel.org, AJvYcCXCLzR0FOq0VTZPHuKEZO160iAo94CEWhZJ1l8fnQSpPBVFm+PWdvPFzQN4aZlPMo7FCvH52m0OZb4UnP/51I4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx69YCSCRPKsu1JC901u0yPRa7eeST8XrJc1aTDSPJgRm5thvhL
	lhcFe0d2yLdrrRmEUSgfM469DX7eCohdd9wykgJLB0VWdCtCTsf9oyEsxVqc6WghX1hMOVb1qS2
	7B10OLbv7LIv778giikbxxh5x4AhJ4gI=
X-Gm-Gg: ASbGncsSsPQJzrM8R7t3w3eB7JDsKxxaM/WKPm3Abu2KBpG2Ev9eLwTaKQ7Y1M1kLV6
	Jdw6sqIYwFzdo7w5mRx64MHx/k745rRF4SMy8Qo7rpl5dN3CJsnEAlmXa1mrxgawaGv7iHgXeNs
	rfUxopGGDxZ4Po8vFHk4sQhPpH25Oajzt4Ts20zgP1HN1CGX+Qd4LKZXCTfw5jV5zQoA9BIF0us
	lQcQrXG
X-Google-Smtp-Source: AGHT+IHoEPWMAkV6iMGsEDvCSjEjzV6lIppOH9ZDFEQgHs/G3RC7eyTMmTa1FXxESrNc287Xi4dDiGLnn3bWa/qZVvg=
X-Received: by 2002:a17:90b:2ec7:b0:31c:3871:27ad with SMTP id
 98e67ed59e1d1-31c9e5febd9mr12931859a91.0.1753135182141; Mon, 21 Jul 2025
 14:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519124304.79237-1-lossin@kernel.org>
In-Reply-To: <20250519124304.79237-1-lossin@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 21 Jul 2025 23:59:30 +0200
X-Gm-Features: Ac12FXwQv9HVGJAp6Vy9cz0Ne-aQb6-ETcJ5yoM7YPSexUlrihf-hiPis9kBRO0
Message-ID: <CANiq72=a9BV_VjGUBY+t0=_0SY+JgEMSceLf858hP4LT7SUf2Q@mail.gmail.com>
Subject: Re: [PATCH] rust: types: remove `Either<L, R>`
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>, Dirk Behme <dirk.behme@de.bosch.com>, 
	Kartik Prajapati <kartikprajapati987@gmail.com>, 
	Aliet Exposito Garcia <aliet.exposito@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 2:43=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> This enum is not used. Additionally, using it would result in poor
> ergonomics, because in order to do any operation on a value it has to be
> matched first. Our version of `Either` also doesn't provide any helper
> methods making it even more difficult to use.
>
> The alternative of creating a custom enum for the concrete use-case also
> is much better for ergonomics. As one can provide functions on the type
> directly and users don't need to match the value manually.
>
> Signed-off-by: Benno Lossin <lossin@kernel.org>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

