Return-Path: <linux-kernel+bounces-762121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AF4B20262
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC7F3A1B8E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71252DC34C;
	Mon, 11 Aug 2025 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t/rtueEP"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D679F2D5C9F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902460; cv=none; b=lILsz9WbTeKQkRR1QA6rgF6KA7Bh4AcHEpRvyRCVRJxp+LYA25I/ecNTE/DnahWMxJvs7w4WAIuIHiirmcA/+hROIjdUD7MYBbEaSonk0jNMFItOY/G1Jcj26iVCgq8ITJ6tINmP1qCLBCmDH6a1Pos7FG9GDm4smemGD76bWaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902460; c=relaxed/simple;
	bh=+P8bhVOwv74YoOnMiIN2tr6EOCNywG2x3gGP2baVj9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5VLTD0tJmPWDYEZ6kfhW9ZRVp7ziP69fpUM8P8AZMq6KznX1Y5VqLc7dY+yYKu5T1dM1hWUdsgQJtEFr1DUe09r0of6SUMb3HjZSJSEIENMoN7y65HiZEVA2KnycQSS8REZSb2zCuFwO+dj8CEkEhT4n9TMYAm33Fhi7sDu8M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t/rtueEP; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4af027d966eso49391911cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 01:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754902458; x=1755507258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggBs91xhT5OGerz7WB6lsIzNIUixHqSJQNYCiUzD130=;
        b=t/rtueEPdSpOr6xdOCDOVwFFeuMs7KTFDvqcr+ymi/wfDWiDRPoo0dyH5f8ltC8iQr
         Z/zKrN62QUqjfJ1uQO9lLNLnDnTSFeEcpe8EWSEzmftsWC6DFFyfMXHAo4gjwnRQJM7g
         XDAvvgrzUHnKtIT8gWu5Rn+LFnr2Du5HN7jdTKvGx8wIGUQ3cGl2IO/MRK7Ok+F0La+v
         Z4+6JSmISTW9FA0IyFxHd2U5YaNY6aENWLOkgXEclwLnJhv099tYOzwTpEn5rTtDkyQv
         XRt23bLmN2flm7/88QtRa2groxNX7DOicRFAZkqvtLpnLwYmF4iqjuXmW3yPlLDJCnZ6
         xdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902458; x=1755507258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggBs91xhT5OGerz7WB6lsIzNIUixHqSJQNYCiUzD130=;
        b=ovIB5fbeKmsUpcwPtieCmfA+QRRMXxQ5GzaW0aUW19gWlxOEC5teI+0jfr4g4Vw/bD
         UKQzMD4/ICwhoAEHIlpw+04Y5JuknaeZStrQK0SdIeBJ+/1SPnkoOMXG2EKfF36qwHsN
         Znl50FD4shu8KGvlLQIUb2Qw4wAKiVU1XqVmMQCLrFP8EvaRsJSi3EIAl5E4lXVwWoUT
         ImrJJUJk8lpZRV7gly4phUDERwJglPYbMb2XdOe8MEiz1lgekhVh36l8zIO1gW8uENz5
         6tzjLsp9O1BgB/UJNR4fDmh4M72PDpXvlb2Z4RvZ9DDyqPDO8Rs9rqN1kZVJbCV0E1tz
         9K7w==
X-Forwarded-Encrypted: i=1; AJvYcCVIObuapkhoAdstZpCpq8FQ4C59IPos1Ec+1OYK145o2vKMRjW6AkzSGctj2qbw0dHC4/KPz6oHeo/q+fQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzZuMPgBjEE8iqK7n3Ly/TdKa1GZmWfDTl+ZOZuj8n5BrkHELS
	iUg6dmNn4rc2DJxNLO3QYRXJkigftAvZbgM0g52w7i6jr5ThGhy4Ji5IRl3MmayCSatZYjvQHB2
	60TRUG0iwxb/PO8Ii5/3V5hnpnCX0lz/ZPOja8Du7
X-Gm-Gg: ASbGncvCk6QaSxMaU7QD+yZiu4WVg860i3RWFskskFNFHFr7DhHZO2RL+du2JPyu3R2
	8WoQ1NGeo63vEHMK1QRNixGAHFM50oRmLpAecQfcn3CPobJCO0btYLB2BiVKeInk2ShINakjG2w
	sgwQtvCszetjh+z76n17tOTfTAy9OufD7yCKkhZabbaK3/eaz1YjYWbJ1E8t5/i9MobL6wJQ7Cj
	RFP0VQD72tzcvsjBg==
X-Google-Smtp-Source: AGHT+IG89vGodbMDduFmWXYAKYKFluMW/TUv1KNzoncPyzwA4Ywx0KGrdM0+oGpLbFz8OgPt0cdJzwZZzvcsfyGaDmo=
X-Received: by 2002:a05:622a:5587:b0:4a9:b1ca:9fe1 with SMTP id
 d75a77b69052e-4b0aec59430mr156307251cf.12.1754902457392; Mon, 11 Aug 2025
 01:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810072944.438574-1-rongqianfeng@vivo.com> <20250810072944.438574-2-rongqianfeng@vivo.com>
In-Reply-To: <20250810072944.438574-2-rongqianfeng@vivo.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 11 Aug 2025 01:54:06 -0700
X-Gm-Features: Ac12FXwqVWBo7ThXFkCkWpYauhWAWMYvv5F__fjkB3vLi2kEx3RFoeqxwYzI7ic
Message-ID: <CANn89iKFbfNvKWa=yrPnfkTdfEo-xS-9TfE6ThgZF8MATU0Cmg@mail.gmail.com>
Subject: Re: [PATCH 1/3] tcp: cdg: remove redundant __GFP_NOWARN
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"open list:NETWORKING [TCP]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2025 at 12:30=E2=80=AFAM Qianfeng Rong <rongqianfeng@vivo.c=
om> wrote:
>
> GFP_NOWAIT already includes __GFP_NOWARN, so let's remove the redundant
> __GFP_NOWARN.
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  net/ipv4/tcp_cdg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_cdg.c b/net/ipv4/tcp_cdg.c
> index ba4d98e510e0..fbad6c35dee9 100644
> --- a/net/ipv4/tcp_cdg.c
> +++ b/net/ipv4/tcp_cdg.c
> @@ -379,7 +379,7 @@ static void tcp_cdg_init(struct sock *sk)
>         /* We silently fall back to window =3D 1 if allocation fails. */
>         if (window > 1)
>                 ca->gradients =3D kcalloc(window, sizeof(ca->gradients[0]=
),
> -                                       GFP_NOWAIT | __GFP_NOWARN);
> +                                       GFP_NOWAIT);

Reviewed-by: Eric Dumazet <edumazet@google.com>

It is unclear why GFP_NOWAIT was used here, while all other TCP
allocations use GFP_ATOMIC or GFP_KERNEL.

