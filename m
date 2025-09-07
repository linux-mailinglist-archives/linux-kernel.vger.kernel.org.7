Return-Path: <linux-kernel+bounces-804865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8102EB4810D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 00:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1AA3B44EB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 22:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B472253FF;
	Sun,  7 Sep 2025 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+NEyT5w"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6DA4A06;
	Sun,  7 Sep 2025 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757284237; cv=none; b=m8pHoA+pNRGXgLLV0NdBbtwPZgNnVV1lbYPTR9ycociP9fQKupDAKUBUfnVlE9pKWVEqHDfUc6KigT22q5xtDcY1gUJrnvAsi0uRtHAvDHesp1nit7tY7VSmhbNNyXHaFFxe6tHyk9NubaoZ9vmQyseNtkiX9j19/7XxyGkbhY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757284237; c=relaxed/simple;
	bh=oe7705fPiOUzmQOYpaksxFwnwPJWnc3qXrnd/JInQqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOF/nE7fgme4zb0FqCuCv+pg+mPgr8tw122250OmmSuivvcqJe5R2egFMbr4oVbRhpX75sFgoo7iybMDlQsggoVyu4d6ONpQwyHl+pVgCHnQ5HieSYdriE85UThp8J05M8Sndlvce017lJie+Y2JBNrVxJ31ukOlFGrgZi/SQ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+NEyT5w; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3296a9d17d3so168685a91.1;
        Sun, 07 Sep 2025 15:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757284235; x=1757889035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BfqH7/wH+FWixUO4h9ke279qH+H4GREdSJwfb372k0=;
        b=N+NEyT5wQ/s8oYGhcqXvpoZNb/S4Fl6Fz59bHVv9uGO70iF99kfwui1fpRFtRAunwm
         S1OWKcCb0YLgxj1xpkx0mUNJdemVxa4bMcbCKJ49pNgb5CxZIcyTKhCcOurGLq+7xKuJ
         dCHZaZeIJZehgE8lwfM8Ed+AvDBcYhdQP9krHYbwSH97ZpBM746GfAb6qdWaIoHjXo8V
         Px8I/hjiMlAYa2iMTn4MjmugFp1pmXBEqvc92bNjvOlfvoxAJ27a0PRriYolyLOaF8ZP
         ULu/i+Wxtn0AbtduZvshjdWBDqJZ5AmblCpDMECP8mx3dMHaBss8iNuUuvphFVxf741v
         SSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757284235; x=1757889035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BfqH7/wH+FWixUO4h9ke279qH+H4GREdSJwfb372k0=;
        b=qkjDosfMzBWKzlElJvGqMa1hxuql5DNcMJxKvAOPPfltH9ila0xPLMwWUFmmBOpVEz
         IPX/CZtYRTH9vwqP0cN0FG9PX6fukh4LyeU7FmwCH6u6hgjEUpsD0AXGMrPRAtHBXn1H
         Y5gUDSbh46k7t0vg0ZzjeKV+LBVFTDXcgYynCbxmlieQQ95tDX8Kuf02HeCHdvYdZshe
         YPvYt8cgVQlse86CaFeUPSFa8IF9rBQcmVY7mMjMuRjVZZ9wddVa74ptivZwq0oa5ix8
         dSJPE4fTPIdzzNAS8dEG7KPD4+Q1u6QAHY3WiVQdYLjSP2wAkoNdhDM6XjULPGcqwFY4
         7fsw==
X-Forwarded-Encrypted: i=1; AJvYcCUHi3GbQ4yKqEWSDaqrqrDsNikOzduAofg0ricpbjNHQv47PyTr33twIQt0MT5yoIFhoQmAz7R7nQxhgjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2F7BAsEFNXh0igATECPMKoxDbapmtsHp0mzTl0kpZAc+IE0ts
	+HDtpZH7MiRTnVVsVQQivZsFX1rGMN+h2mN1fysgaBSdz279Peum0MSZTK2f8rEw6Vptlvr5w3i
	D+J+OPNnO1F/ax3SQHWtjh4Y9ZVX+ACQ=
X-Gm-Gg: ASbGncs66HG0FlgjRNPRflIlhkJVtAZ43Mv6etUrb6GRhugciV6HcmMFjeG6Qzmi0Tl
	0HSUXWj1tuN1OCCY6DjfJC+y7fUXv5nEriRiJ2KViNp066OqAQEhDXc7Z9ZTiR3mvHCuD4HVq04
	ZoMRdF8Z3L5zu1Tnn4MIhz46bgSJu8wiiIOWomMbWqvaSVhKyNs+FktvRroMb+G6KXAI8QkjQm9
	wUEIvlcL1jidG3RZ8m9pf+7J3vLTiQD8BDFhG/Ifb39Wpj3v2VUP/vEPSw/s6ZhFs9XjeYHqFrv
	XPspZrfiz0ZfyuC1peqFp1Wxnw==
X-Google-Smtp-Source: AGHT+IEqnIJQe2J0slyY9YH17Q93n/5CGO/W+oQkkNNzqdpSua/J+7QaVqFO/CvZbn36WBRGUtl/FFwfttmoV6eUPGw=
X-Received: by 2002:a17:902:d486:b0:248:f30e:6a26 with SMTP id
 d9443c01a7336-25174c1b646mr44708885ad.7.1757284235153; Sun, 07 Sep 2025
 15:30:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731204115.13669-1-work@onurozkan.dev>
In-Reply-To: <20250731204115.13669-1-work@onurozkan.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Sep 2025 00:30:22 +0200
X-Gm-Features: AS18NWBannjdWsSs0FSeZ9Jnpmo9F-1ZWJ6Z76sksYEcH-ddG_P9www43yxQOwY
Message-ID: <CANiq72nWYu-RwAmRx3JetY8Ox9OHud15ykAFRfqB4T7jQ5QF7w@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] rust: update error.rs documentation
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, me@kloenk.dev, felipe_life@live.com, 
	abdiel.janulgue@gmail.com, dirk.behme@de.bosch.com, daniel@sedlak.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 2:18=E2=80=AFAM Onur =C3=96zkan <work@onurozkan.dev>=
 wrote:
>
> Changelog:
>   v1: Removed header link to keep the doc more generic.
>   v2: Reverted v1 and added missing header links.
>   v3: Replaced `arch/mips/include/uapi/asm/errno.h` with
>     `nclude/uapi/asm-generic/errno.h` header link.

Applied to `rust-next` -- thanks everyone!

    [ Sorted headers. Added line breaks. Reworded commit message. - Miguel =
]

Cheers,
Miguel

