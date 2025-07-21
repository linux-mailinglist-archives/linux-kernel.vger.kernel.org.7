Return-Path: <linux-kernel+bounces-739725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F369B0CA20
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671AA6C1B30
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA6A2E11BA;
	Mon, 21 Jul 2025 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5ZlYaGr"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056BB21B9F4
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753120075; cv=none; b=b9AfvoifyXFagb2MPYcpgVyu26gU6Swl1Gm6Hy3TWSUzVX8no+0PPhz0WXMGxWSJJoBny3jFqPxl+P1h9nhzR+ZYMh4tDayDGbW8yOgPSxqKXfPFM2/U2rgIOuKN7WP4GKVcEOtkHoRBdfyK19XvYyaF9Kj97ueTNcEKDtr7J/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753120075; c=relaxed/simple;
	bh=0YFqN0a4A6xpAiRDkR8q3z6mZvuOtA6mTOducRFFgOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zj8q3ze+OuVohLW1+3d5tHTp4OLQW46EzfF8bp446558Ar6550nc+VQOFYA6CMDAP7x2HI/MHccmBscgfMF3lY07rLcmGeQ8AyQwN695t6QRB/OJVpHuIhGAxfE0zY8JxddQlEGY1Ec5moQMO5Y0g7UtPSfdAtahy4PceL2QQnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5ZlYaGr; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32cdc9544ceso41224751fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753120071; x=1753724871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoE3XADz+fZxJevoESosVUJSwk5B/k7LFoq6KDG5zto=;
        b=Q5ZlYaGroaZkjDeyVfmaX4r7LjkxWSzBEcGCXWSJ+Gn/z5Ws54KcVFWe3d8gFBkqhJ
         Z1QX8nirKyDQ2Ij3fQeXvbQ9JXppDnePLWSQRDhf27FqIq7QsD1GiOhy6upi+Z8ec1ta
         glq8HtPpJxAQYWSt/xWHtDpeRsrI2PGHlI5NRXuqifwijJRe6yrZ/Z9mHZ0FGd0JoyMt
         IGq0RZEdthleD8lzrx6EpxmzzdWLJm1wgWiOXHJMHPu5SmHAj79VJkgTSR7GYSnePJtB
         oHUqokK505Z4SfklhXuCqadknFzg17gcVEskkh0dPg3jww9RzpFc6BNGaJi0AE9x3BJz
         AR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753120071; x=1753724871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WoE3XADz+fZxJevoESosVUJSwk5B/k7LFoq6KDG5zto=;
        b=FAEg35P6FtsCtluk9wA4O5C05L+lv89kw6DDJpRKVPRbciIE4jVD+O6fDW6Jb3XXi3
         0NSRz3dVJe5Sbmnq5oC9ecq4KqeDteXE6j/qWWQYnAezhB2Mrf1I2+tbH7GpzG/lMOaM
         tSzH3G4Swsy2dg9XTLkGfChzNua57uBcHGAjN/+tdGFL0sU9l3HxjHwSudwtv3q6wIwF
         uLgXqwiiJTzWYLVjJG9dQ63r22tepFF/KlsP7NHuUUn+wxthgt5Zh2mwQIbpqd0BRUyo
         hoV6HMPhFMiUWmAvW7XK40YTPlGmA+yOEtycWEFk9CJaDQ2LhAs+RkFAKx3swoMuzgGa
         miGg==
X-Gm-Message-State: AOJu0YzJtz70iJUbnPEpOJabQ8yd9/smFvq+OHF1MNXBBmNcRxIwSaqf
	mW/0+nH4p8MUGIhne/opk/XjBffhFMLpKgcDB7TX6uaXrVAi5K8FAp65cA4AX5U0g48YZYsi0AI
	NTgU5iuW6XeOHTZguZSxFZu+jzCM7jD/nBQ==
X-Gm-Gg: ASbGnctaB4nNX9MO15kU24T0JLTWVf53sfUzCupbNj6Bfpl5975lonFxsQtjuR1tMax
	7Y7wb/YYXgMfCtDh1gOcQrdNmV0IkEAYQdAs2n3SQDeiB69R2y/EZEPrER7CS2vqfBIGru5pymR
	CnkJ9BksaYbWLEQBeg/SpZ9C2myEuzosC1Oadk3aB1AABhgT8sjgxa+wtJsDDogJCpNjEATrZf0
	Hzb2F0dPiPXCXj5/VvqGGs/II7e
X-Google-Smtp-Source: AGHT+IGccbbkLDNRZf5uGtuhQ4vvp8vhQfi4kdXMQXqsARiXZ4jWDxuVkdo6kRtbk3hjjxJFPNsHaMhDi/++eU5oIkY=
X-Received: by 2002:a2e:a99a:0:b0:32d:fd9b:34d2 with SMTP id
 38308e7fff4ca-3308f60d7e9mr50236951fa.31.1753120070277; Mon, 21 Jul 2025
 10:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721174227.28002-1-ubizjak@gmail.com>
In-Reply-To: <20250721174227.28002-1-ubizjak@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 21 Jul 2025 19:47:37 +0200
X-Gm-Features: Ac12FXyzGELRWpYTywe1PCaK9FFHZEf2ogE6DV9X8_k2FaKDgf7fYzEOG1gbp_Y
Message-ID: <CAFULd4Ya1Me0+-cnmVKBAxcJJfiEbzk+_AavM7vyJksUaOtnGQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] ucount: Fix atomic_long_inc_below argument typei()
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexey Gladkov <legion@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	MengEn Sun <mengensun@tencent.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, patches in this series have some problems in their description,
please expect v2.

Uros.

On Mon, Jul 21, 2025 at 7:42=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> The type of u argument of atomic_long_inc_below() should be long
> to avoid unwanted truncation to int.
>
> Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Alexey Gladkov <legion@kernel.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: MengEn Sun <mengensun@tencent.com>
> Cc: "Thomas Wei=C3=9Fschuh" <linux@weissschuh.net>
> ---
>  kernel/ucount.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index 8686e329b8f2..f629db485a07 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -199,7 +199,7 @@ void put_ucounts(struct ucounts *ucounts)
>         }
>  }
>
> -static inline bool atomic_long_inc_below(atomic_long_t *v, int u)
> +static inline bool atomic_long_inc_below(atomic_long_t *v, long u)
>  {
>         long c, old;
>         c =3D atomic_long_read(v);
> --
> 2.50.1
>

