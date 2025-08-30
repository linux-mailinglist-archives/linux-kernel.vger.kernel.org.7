Return-Path: <linux-kernel+bounces-792912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C44B3CA55
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4316B206574
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D914F2798FE;
	Sat, 30 Aug 2025 11:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5xlCvdK"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE09726D4F8;
	Sat, 30 Aug 2025 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756552087; cv=none; b=Lwbx0shJCe7WAMSjoPWYfu7sArc9WYlZgsKaiHMo8wCpVpawvSuA7jalUpPPpuKQBcFjwV1epnXSIk64nIfh12LZ6AdsUzZMbLBe6fwogU+XpBT3bd/nquLRZovL8ivYAwH2EVsqruCaFklL+yiK7q4lZInCoLaPmMP5o1Pozew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756552087; c=relaxed/simple;
	bh=DC07IAJNLS87gP6QZ4GAcetAKm85JzcJ0eqYsCK5qmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3JC/aTkeOfboEaoeLMzIEiAGSCY+Z9GPEsy9Ld3MSNiEufDvuibStiDuU41reSAaSXpayOi1kdi6cRmJzEK5fkhul1cNw5I1ImYwbiUIuc80yO1xg1l+et62LN1FPwJ7hYlERwoQMFeGBZViKUDVTLjVVf2vce+Ben0Wa1dLHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5xlCvdK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-248e01cd834so6761155ad.0;
        Sat, 30 Aug 2025 04:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756552085; x=1757156885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DC07IAJNLS87gP6QZ4GAcetAKm85JzcJ0eqYsCK5qmw=;
        b=c5xlCvdK5NHjpxbsleL4hW0BioJT5dhC4wHUgb5WWSKYbodnN10Z0BLZT1q7UlJyYZ
         94v36n7pwtzC8p1nBxu3VQgq2bH/EeQAgE5343wCxoOxPA57jCSfi8oBTsQLfLQvcgHm
         /G13GT8R2yDNABwx+BfaNtYSyPUOiEdqS/uHnHj7Sq78OU0l6RAGgu8I0p1p5hi7X+yi
         2EEj0XmiObYIoF5/3JLvwkZtM+jKIvo8SfSWeSeqBik26D3k2tChXtNx3rk1Sx0uDh5h
         3J1wq4Ps9yotFvkl3pLHnmZMAwGFjSivFHrNpFVl5nYa9/oIArLIj4zRQjDphvsQFmnn
         GKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756552085; x=1757156885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DC07IAJNLS87gP6QZ4GAcetAKm85JzcJ0eqYsCK5qmw=;
        b=tvuF3R9f+IS9dNWPjrSHf+wFHbI894umqhehijhp8MqyQrtNxJwcRnJ1fe7xvm/EWr
         fZhgViQMOTDEdUKr+LQe2Hf0lmQNhzv8LFv7ZwTxtZzEHKzmvKeB9MtRI2nOBeJsgkGe
         YvnPqyGzGdwqZjIzNEwrBDbZWk2Z18bp0rme9ZKawkYlBAHZ9teueWuMag38YRqykhSK
         9gDsvhcBtBYs1dLLVemHApgxWIGDA2VyZUE3dSOjNtZTmB+a+zE9uk0onBZMT/AFHiN7
         Cmd88cviFC5j8OpdzmBFjBFomOn2TTtpXWu4AEhTvawo7/6/xJz2bROWQIKjJDIFXMy2
         9HBg==
X-Forwarded-Encrypted: i=1; AJvYcCWC9mzAhwt01biK61V9MIHYCSbPvDIawRWNZGvwXrqEDjsSJmpowug6eICsDjw4F8Fr+VJl8fSLhyDWrKncn14=@vger.kernel.org, AJvYcCXOpzDr2arSjKuIvVljEVd4F1/9fe/CATna+OKqgZOk+loFf63gecjKdhBFwpMFl47Ztlw5v7xyvfksasU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjogQrCfG0em0WP1ARxwgHLqfZsNF2NHDBcXZp6PwbxMabjVLn
	AYG+CXE/qf9yi5rk19kePD9b5vfbCnve3siNiM8FiHriW5Cp0ARCI2ghc8UbXL+0sx4y6WvA32H
	dwRFe6Dx1L8Mz3MbeSFRML63PO/g8Nic=
X-Gm-Gg: ASbGncupExVg0uLB7E+RwBMbAucD4hPuFNAQ6aE23GBuV0MWkTwJucbtqvsPX/sXS7u
	y0COw5gsDiAzn3zLyPeFMFUS02BjjBToRaHk8LD4vJeBhojMewgctFg/34JON+ZyU2NhOBzoiUq
	GhkhfMAFkA/X/osCGZfJoy0F0jzvkntc9tj3ZWTK04SMU2hP9smtL+RynwGWkE6CfqpiFM3lIZ9
	GIuBkW4NYa9529lwzGYk8IwY2yf9VdSwkO/7izm6wfwpdHgPzsf+reGL2vMXV7J9dBrSR+DkxL/
	pyiD9lQm5rhUButn/ubh1w/p5EXEMZKk4s0t
X-Google-Smtp-Source: AGHT+IH5ZNvD4l8TuAzdnDz24AupViHRUbZNq8TFYy6umeiXqfTUMOwh+H66Ull3ujqV3KdwuMCRZvo1OnXw8eI5Pfs=
X-Received: by 2002:a17:903:1c7:b0:240:8717:e393 with SMTP id
 d9443c01a7336-2490f7591bdmr39162875ad.5.1756552084948; Sat, 30 Aug 2025
 04:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829192243.678079-1-ojeda@kernel.org> <20250829192243.678079-4-ojeda@kernel.org>
 <CANiq72k7_GbFwRxW5vikF_SpiNcNm7Ff0oe6jyYX_voDg92QFA@mail.gmail.com> <2025083032-barmaid-rising-a977@gregkh>
In-Reply-To: <2025083032-barmaid-rising-a977@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 30 Aug 2025 13:07:52 +0200
X-Gm-Features: Ac12FXxtE1MzAIWtlE3GhZGNxnNcK1rhQ_lrX5csjRmJrEow6fqjYBmIW6jipio
Message-ID: <CANiq72nAagBBPhyU3XdETMKBuFPbMMRaSTStWPpyLnByYPP=+A@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: error: replace `WARN_ON_ONCE` comment with `debug_assert!`
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 8:28=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> If you wish to state that CONFIG_RUST_DEBUG_ASSERTIONS=3Dy should NEVER b=
e
> used in ANY shipping Linux system, then yes, we can carve out an
> exception for this (we do that if lockdep is enabled as that should
> never be in a running system, only a development one).

The config option is meant for development purposes ("debug"). We
don't control all its behavior anyway, because the compiler/stdlib
will also add many assertions (e.g. for unsafe preconditions). So, for
instance, it could easily have a non-trivial performance impact.

For the same reason, it will also change behavior depending on the
compiler version. So, for instance, new assertions in new compiler
versions could have an impact that is not seen in previous versions.

Thus, for this particular config option, we cannot guarantee much, and
the help text already states "This can be used to enable extra
debugging code in development but not in production.".

Having said that, I regularly CI-test our main branches with the
option enabled, and it has worked fine so far.

So if a user actually run with such kind of asserts in production,
because they really want to crash on anything and everything, I don't
see why they couldn't. It may really be that it actually stops an
important exploit from going on. Of course, it may also be that it
elevates a trivial bug into a denial of service elsewhere, but that
risk may be worth it for certain users.

In fact, I would say it is a good thing that certain specialized users
run with it enabled, because then it means they may find potential
bugs for others, and that makes everyone safer in practice.

But I don't know what exact constraints the CVE system puts on you, so
it is hard to assess what the best wording for such an option would
be.

As an addendum: the fact that the compiler is involved is a bit
tangential -- we could have our own "debug" asserts (or "extra
paranoid" asserts) that are independent of the compiler, and we could
have a separate config option etc. But, of course, in this case with
the compiler/stdlib involved it means it is harder to
blanket-recommend for production.

Thanks!

Cheers,
Miguel

