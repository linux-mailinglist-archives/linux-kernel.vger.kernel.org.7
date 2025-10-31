Return-Path: <linux-kernel+bounces-880227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78676C2524F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA141A24554
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8802534B1BD;
	Fri, 31 Oct 2025 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fx9INj2v"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C14534B1A8
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915435; cv=none; b=eWXv3ocBfUQUdhdgM/zwpaTunSsGGobk1dJhtHMtlnmHUQaAKprvIz6AzNqGgnoxU0SKtgmsZuPnKKTdiEjY6s9lM58le2nSrXxblpd50esdSfpYXvZcLlbVY+5LbU07621SJGgSDqn190aVfeoh7AiI9vWeQPDjNZjnaFzV+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915435; c=relaxed/simple;
	bh=57XM95AelX9DUBLfU9THwVSSutS8OZT8Oj+HWgG7Ons=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1mmrjlsDDKVk9bocLr3iA2IDd+fyRYwCeOd3o4R2Pf9w/qsqGR/T04TSBwn7UrBWbnrh3j6HAJ9WWF/oBY8fQKs2K7Yg/xpaxKImzHiFjrkJjq7Pm+tbFtyranubGbOCRlF9tTrHo5W4+NBmWtv4pXrDEyGEx4cujv8LwZSveE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fx9INj2v; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b87171370b5so348362a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761915434; x=1762520234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57XM95AelX9DUBLfU9THwVSSutS8OZT8Oj+HWgG7Ons=;
        b=Fx9INj2v/zscGtylqr7LuT9oOrhVNAaptHEDLaTEIhjIXv+edlW88reBW9iWrRsvrl
         el1j+Vtv8ANRYj7wUuqVGwf8LaMzKdY5ESO2mYiYa8UE9J/dBekJ1yvfdWou4FdYmu6m
         F8T6+NZQY7atZn6LZ09MoFWF+E9O6XTsOArTbOlnBv23KAKKFpVWxiWcVsbBp7pp+27/
         y3kMy6BgMLtP4VndSGTeVz/P+R9V7vOuTCUIp4nk7ApM69jJn6VgqY3iEXJ52XCvhaTd
         iyPyFdWpDSx68PN1J0ucNN75jES6QvH8Skeo9nufrZ2SCsEqScR4gOoRHfzmitSkoqhF
         H21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915434; x=1762520234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57XM95AelX9DUBLfU9THwVSSutS8OZT8Oj+HWgG7Ons=;
        b=P5b0+27bxa1KmcB63unJu7mAMlorKE71IG09stbZxMl7ClxxrQ2Im/ithHLQrzL0QD
         cAqFJvjK4s4QnS/g7r8wnbuODf6x5squ2D4A8NINYvc3sN+DXAlMbPlIEPt8pTeIuy/8
         bwW5fbUIjYRQndLxzBiZms4Kcza5vzDjs/Myyn7l8jbwZ/Jtjyq7GKdVf9nSGaxc2GpR
         gkZBP2PNwCm3BCoz9WeOU3VBGp0OFor2h50x6o3PZHtnB3ShOlSdf3GV9QwIGjdMhWRN
         6v1dINmR4sfQJXpfZrznGWkMoPnvQ+MMAteYMALiy3mf2/3U9gcFxbSv0vAOZKrExf8r
         N/Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXyVjzGMf4XjKH10l0Uv/sJZn9bGjwhn21mDbleX3PRd53NME6TLpUIQTKLps0hEaP3oKlSUHDGRWdfLoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrmBGD2efXS3Jm6m2T/qkRbuf4sMggqZ5t8eTeP4P+cmgUD45d
	irP9SNrdW7Zso7PH/WlWbgsxinSUVrc1+oTDnsDOrBbEJSWFuMafC3SN6k3xFpYD39h2EtQju/d
	yVGFP1uTj6RCjAEk6+Ep/y9HS0zeCT7A=
X-Gm-Gg: ASbGncuLv61yeb8pn3v+uiBH32Zl+LgAwMgg5KvjjeN6e4yzHae1OaZU9uhHGoSY84U
	Ur9L0WS+8rFuG/tVHmJXLUCsFQ6r1A0EPK28s0eRBa8qdXPiT878nxRXrbWatNl1wPeNguV+C57
	Vk7JWFLc/7EYO5Ik0VhRdhWx+k+F2tx0BUBhIVqaAWZpf3VHXkJze3MJ5OQNcpq7CVGaJf/fngf
	h4Y+jro8VjvdgPwzvFrHcvLSPTsKiDe3qgH4dOWF/SdEsJ+CAYTOyKQYf203EkplQElPOfwbjVA
	TuGXdp/IZvIvbwG9JcxRBgMWMZ0m9J5yODb7J0pP4ejKoDdXL6mSFU5IHDyF/LHGSoDCF/DMx21
	k64LJJbEwjx0VSQ==
X-Google-Smtp-Source: AGHT+IFJM+PQMbTXmTGodnAosPHILr2GU6NSMb59LbmXplfAnvliIPhU9LCa4gpUD72tPa8WjMFa+1grBXZZatyQfa0=
X-Received: by 2002:a17:902:e887:b0:272:2bf1:6a1f with SMTP id
 d9443c01a7336-2951a3d2847mr26244955ad.4.1761915433746; Fri, 31 Oct 2025
 05:57:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-pwm_fixes-v1-0-25a532d31998@samsung.com>
 <CGME20251028122316eucas1p2733987cd4c1eb8f83d6572d542e76d2a@eucas1p2.samsung.com>
 <20251028-pwm_fixes-v1-1-25a532d31998@samsung.com> <h3sivr3uuzr5oodqe326svchbw3rzo4f4nw4chpeee2jwzjq3j@bdtecauehkn4>
In-Reply-To: <h3sivr3uuzr5oodqe326svchbw3rzo4f4nw4chpeee2jwzjq3j@bdtecauehkn4>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 31 Oct 2025 13:57:00 +0100
X-Gm-Features: AWmQ_blGoLkmXXueKnCk5kJ5O9pXLS5GlmxYneYVuP4K75NG97cEfvhzpNZh5XM
Message-ID: <CANiq72nNxVJeMZdESrrB+LGmdRK+M5AGZbUw-x2aE-Qa-=HtJQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] rust: macros: Add support for 'imports_ns' to module!
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 8:47=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@ker=
nel.org> wrote:
>
> I already asked this in reply to the cover letter, but the question was
> lost on the way (no offense!), so I'm asking again. As it only really
> affects this patch, I'm doing that here:
>
> Can I have some blessing to take this patch via my pwm tree? Would you
> prefer a tag to also merge it into your tree? Then I would apply it on
> top of 6.18-rc1 and provide a tag for you to merge.

Sounds fine to me, but I am Cc'ing the modules maintainers since they
were not, just in case:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

I think we don't need the tag/merge, unless someone else is looking to
use this (is there such a user? I may have missed it).

Thanks!

Cheers,
Miguel

