Return-Path: <linux-kernel+bounces-840815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E153BB57B4
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 23:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236E619E861A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 21:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAE326F467;
	Thu,  2 Oct 2025 21:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HShZiSmn"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C01126BF1
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 21:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759440924; cv=none; b=cGd4otMUX+r/wgg0MSspCy4jkT8hZ815i7Sgz3Muio+eDACmIXDqtNSjvRzB3OGzwee98hfdrGa/0j1+Ug76c5zXK0LN5anaU4CP5SnDBaYVuMEZDWpiX7yu62hxv7UhHBRerY9aq1b5B8JsIg0gCU2+OAu0yr9GJTqMX5eLVvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759440924; c=relaxed/simple;
	bh=AVVFwwOZs/J59otbhwfw4JT56nx06ai60RPEpmvIzvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQ+lWvt95OnE8/hML69m7Yq+6SddcNJWmOJ9NBzHOJdQ/C/b5wd0GbdIwz/k5QEQpvTN+acOpn19ePCWbLv9kp9cMYE+cY5x9ZlxrEBiFY71WxOZ4x3g8Wx9FSj/3wrA2ZV63jRTEsKhuUocywp033yOn2w2ZzVrOQpm0wVG2RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HShZiSmn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-26808b24a00so2223485ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759440923; x=1760045723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4oFCmF2MJYP82Tx26J9+m0tH7yujIZ19Q3AuUhH2Vw=;
        b=HShZiSmngGwwkbMzDFmKm2X5l/FxURwI4DMKGUulJc0vXxtlAbtP88DTeGYbRiClE8
         CBol9/OirXLiqYuRDqjvjDpL+K2pFKcsYVqPqo5z2w17XveWdwRDp87SemhbUj8h/B8L
         b5IsA/9wmmrfQqLq/SQdcnp6rTNlsoZj51rgYKwwLcpZGk06rveeYHExfvrjN2tVv83x
         +SRkjvL3kBGE8LCVAnn2+s+8PPHTwKkMlEAtsL2vC3oh/Eu9erT38SHaPDOIq2EWvEyt
         vhRmWxseE+vuwiyxgyWRf7laXDUk5N8BS0teY3E8nkQakW4NQOif5IaTk+30sUWFAVqe
         x1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759440923; x=1760045723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4oFCmF2MJYP82Tx26J9+m0tH7yujIZ19Q3AuUhH2Vw=;
        b=fbwvgqAT3QE/3JB/Sb6O0H90VluJFojENRjFrNRoZH/DukWRnbjUeJkApFG2fIsN++
         mWzksHOc+GfG+PIcVIBA9R596g63hGiDoG43DvYqtxtps2SWFRkiukFeX2/LZCIFP7nC
         jyLDa4TljRT5MI7zNoZsaCFw7FieNu5ywFmYr4I7jGqRoFwi8BBoH7Wzor2/zXRU6xer
         DPv69pM1zg+aeyDXJpsD1FMe8XAoo+Z0pb9wyKtwoeff5nLDXH3ZAuhXE6QiYjUAGRjk
         x0+YU6EEU1iADiSqgTseTPb3fhVUQoe/xwVIgMvSjMyY+T44e3pNo5GPd+viJSMIdOkC
         AdcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG2M7VB9xTsEdrvHPuAzGaKQB5xCmhQT7F0W71cGRh2FzjlRwCLx35CCaZ8KX5IGVrDty3+lYg5b5HKpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMjudbQfIgi2kMOSmbQrvI72E4iOzWmrBsDOS2QGyGrM01ak2R
	3/0acTBhl285aWp/wZw4hT3hXyi8AT1mrrfBvBWKz6Ojnq0NM7H41fSl6Q+qd0bv2dFZafr0dD2
	fN0mIzLvWCJXLWuCdxdslnrmZvoDUNZA=
X-Gm-Gg: ASbGnctjTxEpuGELm6CJKR2MvACePnxY7qk0XOriAvo0qxQH4UnktFBKAyxtqnTrCww
	vL/0q6BRjSxr5veRLdfQqLNq3u2Y9wNIJcO9bJvcZy35OVyBWY6ZFjhCHfm/8aJOHdwDNIodYMb
	Q7yy6UWumjxHrH+ULRGgqzKyd0/NqbqgEgJBSVy/ChFljaGnaikswN6hp1mV/z6r97xTen5pdAV
	veBeT0f2ozqU85GwzEW6XW+St0tCWzExjIT8ojLeHw/xhtwzJRGRmXgQexYULbguzPMg26khXTx
	3SjipOER4JV54OllaVyuu/maCaW2je68t/QtDcZvh1leHhmpxA==
X-Google-Smtp-Source: AGHT+IG/xHpb8vODrMK0iW2dO7jnh1RpIn7FOgY3FtTrp6iPO2ruZi3ef2cbGbqIJ/HrnJZyknLRRFb1B6+7lSVn0Sc=
X-Received: by 2002:a17:902:e802:b0:269:85aa:3776 with SMTP id
 d9443c01a7336-28e9a6e3c9fmr4516935ad.11.1759440922764; Thu, 02 Oct 2025
 14:35:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aN6qWFc6hIcbRU1o@sirena.org.uk> <aN7cRUOxq-zwCoZN@stanley.mountain>
In-Reply-To: <aN7cRUOxq-zwCoZN@stanley.mountain>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 2 Oct 2025 23:35:10 +0200
X-Gm-Features: AS18NWBdoHHZzscWUqRPxLm5RbUpvjG-fyzvyu5Mm6idZH8fsQtFe8T5gS5qDp4
Message-ID: <CANiq72mDsU3W5Qfyf=sKhbad4tAHJYF8WnY+4VPz2J0paA2gTw@mail.gmail.com>
Subject: Re: linux-next: Tree for Oct 2
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: rust-for-linux@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 10:10=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
>   RUSTC L rust/core.o
> error: cannot find a built-in macro with name `define_opaque`
>     --> /usr/lib/rustlib/src/rust/library/core/src/macros/mod.rs:1757:5
>      |
> 1757 | /     pub macro define_opaque($($tt:tt)*) {
> 1758 | |         /* compiler built-in */
> 1759 | |     }
>      | |_____^
>

Thanks Dan.

Hmm... Strange, it is the `core` library, which comes with the
compiler and thus should always work.

So it sounds like a mismatch between the binary used and the sources
of the standard library (or perhaps other kind of mismatch, like the
wrong edition being passed, but from a quick look it doesn't seem like
it).

I will try to reproduce it. Did you happen to recently upgrade the
toolchain(s) or something like that, by chance? Are you using the
Debian packages?

Thanks!

Cheers,
Miguel

