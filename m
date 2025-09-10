Return-Path: <linux-kernel+bounces-809307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C10B50BCF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 04:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1901888EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3419246BD8;
	Wed, 10 Sep 2025 02:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELIyMPzk"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089ED2033A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472671; cv=none; b=iHWJY1Yop1eFO1MmwFpe8VZr9tQh/do7zpAUk6+/MqpFXSuXrLJmvxrw66jqw3iDcXw5d01B3XGrbfNSZmVKEeUBG4qsg+C3lMbKlZBcd0ugxKfGhJT2SpsB4/yTWgtz3lELnuoOjBMcdLB7GcxAIKABky8FMyWzijkDuarV6ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472671; c=relaxed/simple;
	bh=EtsERrGuUPQUjphbYZJJaJS3niN77FqxYnzLWZQAx64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FqRidMfkMQXqq15/tQDm0VrOOKXZZ3kPb3vRPv0OAQqHJaETo3fnqL0p3bIWoBb2tDcnZla3phaI6OeotcUIQJspWuCPEBhrlDAFxLF6iHR4Ak3xixxRw199k6O+/JJgqYeLGG8BFKuuQeShQ0GV3Ik7qmChIrtcW8D+GBnwA0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELIyMPzk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24b132bd90dso12810415ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 19:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472669; x=1758077469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3cDWVvExlqY0E+Cv0lKzyo4mEyiBol+XD/LhCh80Vo=;
        b=ELIyMPzkR89YUy1X0gXm/c+cO2CzjLO8+D0rRt8Yp4nzrx/Zrqux1fqod08eXhDFW0
         HZVO8bMcBg5QduJMLHPITAM2RB6/7Unu4wLUat2nGl7XoRFXClofvV9Q+n1fgMURy9SN
         gBCz46VIC5Xkn/WbpDpgKm9CeiNIOpa3gBc5W0TZyU6XeOOvA0TRl59s3izGGLItrhhN
         d+PhpdisnhRCDU9CewjxxS7la7ly5sw5GRdj2jHCbrRpDOHt5MwZlu9lYlTbr+ZX190z
         2fHdthQuyHfklJarPge6fTwHHknW6hHQaYQnGzQ5VF9vJ3O4GC1CP+Wmeh92W463fvii
         1q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472669; x=1758077469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3cDWVvExlqY0E+Cv0lKzyo4mEyiBol+XD/LhCh80Vo=;
        b=uIg38/xIcugXhv5WgcUmPNX6pZZtftvSvqrYCDnWHKFX9eDVOHOamGNRdREsCnDs5x
         pYmvHaFlkgu4ggz6ouCdvJVcdObJHC3e5EGCjV3YZXHHZzXD8qjazIAy//dwMxOBuHBd
         5taEjVrKoPm8GyQbtIZ5frbqpEmXVoP3DSbIoxMN7UWWSgZLF4MWeUTbP/Pm6LNwY2ta
         4Vn7QM7mfz0BMIHneovlgMKJNVq5WQ3Bv1BDbLZLyG4pxtOt9tq6J7YnjJeMhMwZD9bR
         eUfGv3sPZmxo/WySFZlhgv+F781QquDx9zNiy4d5jIu+/kd0G0ktFUKHnnxPMrVnSgb5
         OI/A==
X-Forwarded-Encrypted: i=1; AJvYcCWQ4SWVA2BTdcCRv0QFQ0NshqGyzIV/bgWhw1fYLFeFeta6iZJv9mfTpnjHRORFTjM7T7l3SmikrpIHm44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbWKN2x7JvVTxU9CS/k4fFZQfmRIq6rMIUMfyBJPOPK3fG6M3Q
	jgybfYv5zdskjqe/8/F6mXhA8LUEPzWQ46SGZpaiB8XFL9NZj4xuUX5EP/sxGfZWjVhU7z4YyE9
	aXjjnCCFae39mmXyIg9K0uAjFzcYK1cM=
X-Gm-Gg: ASbGnctm78exFcWSRuxVVfZLQHIAqpDdvZZyEkaKIhE0KEFWec6Arz8L8/O+CtnqY48
	JxMuqgDKmlYRFvI4Ii+gYIwrOSZfdUGSBZWLL7+6LGBihU2Ayyz55EPb8zoDHIsRoMGf63BiChP
	j3K/Z1PJ4CBWqaGIkpQVNOpAvLRwG+/JADPSbwRrw9Tn22FNjitXGOniqGxnREBaC/h5Z4i6HFH
	/zy7ceRS6MZlXL3hLyhgKIOoLGu9lcUnMR+qJMbaiAqDBqMqilloS0AD5bt3pZ/B6sHGcMqWy4W
	mwYlaRxX4MxxYVmB/rh1QHtFbcnGisX0L7Va
X-Google-Smtp-Source: AGHT+IGOVxPPeHlaId8gR8lioyyzsheNaiwTT3Z4mTxmXaDAiOl1rybxKWa35nYEmELwWpePOnf3WMn/mBBDODtw6NE=
X-Received: by 2002:a17:902:ce83:b0:24c:b881:201 with SMTP id
 d9443c01a7336-251757ba959mr101664375ad.9.1757472669129; Tue, 09 Sep 2025
 19:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906140256.3059395-1-vitaly.wool@konsulko.se>
 <aL6YHkF96ICqqbBZ@google.com> <94252007-f389-41d0-b5a0-ed948225543a@kernel.org>
 <CANiq72k6OXcvjzKimfzKAAw8QPzDoVxUx_smFA8KU6gEwJ3yeQ@mail.gmail.com> <3f8de021-8eb3-4a7c-9adb-8244c5aa250a@nvidia.com>
In-Reply-To: <3f8de021-8eb3-4a7c-9adb-8244c5aa250a@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 10 Sep 2025 04:50:56 +0200
X-Gm-Features: AS18NWDFbBI9-w6QOjK9I1s_Ny3SqcFb8YmUlOePJpvF51e4H4-1WzSgXfRqZlc
Message-ID: <CANiq72=ex8zJx+KZTV5eRoqkYE=PUkbG5TTvOJo5cXTtd7b1Fg@mail.gmail.com>
Subject: Re: [PATCH v2] rust: rbtree: add immutable cursor
To: John Hubbard <jhubbard@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Vitaly Wool <vitaly.wool@konsulko.se>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 3:09=E2=80=AFAM John Hubbard <jhubbard@nvidia.com> =
wrote:
>
> Interesting. I know the topic of rustc minimum version (1.78 right now)
> has been discussed a lot, but I'm somehow still confused about how this
> works, on nova for example.
>
> The &raw feature requires rustc 1.82.0. So I thought we couldn't use
> it. But clearly we can...right?
>
> So confused. Please help. :)

Please see what I have at this subpage:

    https://rust-for-linux.com/unstable-features

I hope that helps!

Cheers,
Miguel

