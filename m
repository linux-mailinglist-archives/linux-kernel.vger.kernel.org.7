Return-Path: <linux-kernel+bounces-789782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1409B39A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92EE33B4E09
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB65F30C61B;
	Thu, 28 Aug 2025 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ap83NkI1"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E38B266581;
	Thu, 28 Aug 2025 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378079; cv=none; b=Xv4UYChrmDvd1SKWyr8Js9yJUZu3asdsp86BTOfll0vRN47Lspb/HBLlc6PT8GEIjzcOAcrRXIUkuA9tOAhgReMteZk5e0xIXJUwYa/b/k1vBfAHY46y2naLTYFa54lJf+Gb3m0XBHLCo8wEiYVX/paPSVVJRsQ31+nIZkwuqO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378079; c=relaxed/simple;
	bh=pfcgF6pZCJ4F9CDOjLvQCcRHqbXKVKDmiud8duJFw7k=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IQx0BbD9ksLftfnx9h1Lh9GkA81BA3KnmSJREnmgw86ezIbIazf/lP1vuD4FTVDIMvp1C7mpzkxMZX2kDpSPiOdNvXH6IC66lNiTBcNa9NYXEfd1wOEdjZqNQIqf3vMY8NqXYC7uG95u33Gk3ok5pxcQ3Q9xYTf9/E8Cpo8Q4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ap83NkI1; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afeceee8bb1so108132866b.3;
        Thu, 28 Aug 2025 03:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756378076; x=1756982876; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nNkOhOIiPM65w/ELjYcU0ClhVCyNWsnF7Z4xDxI4VQ=;
        b=ap83NkI1kOgBLHlDbBION2+3iOwgBqJS4lX5VJmtyYmE8x3PZUAgpWwYDhqD74T3ci
         EucK2WPgZhmm+4t9GIbpqpwyKNelJdEUG9tTEB26QkM4B1pBqYiGwPETjLLQZk97h+4v
         6hFzqpq9qgdGadpzIaVXKYeusONRExmQQ2JTL18OMPbUkP4AfgyJBmUEf/idAJsnswsZ
         Kr99Kwlh38MJuUAkDYNnJx25UccPAVHFpT4clFURJTs6gK6MuQe6Bm1FTYtHBR+Oyl1C
         tYlGar9nSQacq83O1LxcmFSzCIGHxVjmLDKCBlGCG6guCbOGxpWgnxitZh7/NFGHFt1W
         KN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756378076; x=1756982876;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+nNkOhOIiPM65w/ELjYcU0ClhVCyNWsnF7Z4xDxI4VQ=;
        b=LZMKEZTNMUkeH4WOY9y9MXbI8uOCBXJKVnovPcKUmargz67ZM7Jk4JRdc7ON3Lvve8
         3goEiOYt20LmrZw7+qZAN1LCwI5CFOV/3PLheqKljsNCknNqU7ArUPUVLRF2bPwxdbEm
         /mAR/lbdSntaSkdmkdREb9sLV9/5mi35hVSws2ULdlMMkTSHl1v5nn8HjmoJ+dXYBiUl
         rZ2mnItMAT8lzlLk/LQyZN+ExFTSDA8KFxBkOI7iT3Y4isxbbDoksIlJB3WE0a6v4N0f
         pjfAt+H9sdDXmp7BBCnbqZ54RJg6dtrwRH4RPYk0DjK9bP1KT9fHTrztTajYONwxKHwE
         IgxA==
X-Forwarded-Encrypted: i=1; AJvYcCUPW+xDMkXVMBxnfmDW05FQXrk9wB3/aebRMWWwdrsKGR8fHpnxJQiwqsNrKxwY91gwDqZkgsduYVBY6P4=@vger.kernel.org, AJvYcCWrzB4gxdqgMVaboZe+eHok+rTjW8i6QcICdDDt4ivwE/zt2Sk8WjWFjWZC9I9JM6uXNsci9+2jKHaUv3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywen6yXOWPuiGP3s5P9Yy+TI78EjQVapk8B3t1jZFs3iCfIglsg
	TQwHsbwjBfnpHipGmWP/s67ZxQ0k7xYRJD89a+p41GdXhxjalhyzUF91WsftgZw7
X-Gm-Gg: ASbGncu9tJzBg44Zux01mSineIeLhigMGQbJvn8ZRb46bUJx5ifsHiOmxS93d2Nz84z
	GzV6KBwiQby1Oob4rTE78KY/YSTl4lGU8wm1M7ubXezfHBgjLlkGPSO3BH9O95Kb0Kx46CyGZgc
	qMzRKO8xO8WBKxeg0tB0x6XAi8a6ldXsLRk20qQGNF1I6xFEzBR9adSEKNFif73u/f/gEU13ik7
	LGIJWCq5tRqpDf+/NbywptsX4kE1/VCV13VSjYkAOfGrvanT4vjo2hDw+RGe4VUElbWyQZ20FIr
	reL7mTvRxBkeoGVR4Q83P0b+I/ounYsMjkvrh0IKKpMhJ4kMhej7GDIG9YyRiM+7nqNqa+SsBCI
	NyJTS1tLxNRk3iu5o8PJ/zbQ=
X-Google-Smtp-Source: AGHT+IExkkfeTtRJDkJLzZve1q/akcs4u+GrGLzPghsDpNh8yEOfMGptbb6JvJBuJ3jUGav4rOHMSA==
X-Received: by 2002:a17:906:2291:b0:afe:6c9b:c828 with SMTP id a640c23a62f3a-afe6c9bcabcmr1324349666b.61.1756378075707;
        Thu, 28 Aug 2025 03:47:55 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe8d03f94asm745601966b.57.2025.08.28.03.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:47:55 -0700 (PDT)
Message-ID: <98942933af31a9e003b5d1a809a22a93a736c381.camel@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: adau1977: use int type to store negative
 error codes
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown	 <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai	 <tiwai@suse.com>, "open list:ANALOG
 DEVICES INC ASOC CODEC DRIVERS"	 <linux-sound@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Thu, 28 Aug 2025 11:48:17 +0100
In-Reply-To: <20250828075406.386208-3-rongqianfeng@vivo.com>
References: <20250828075406.386208-1-rongqianfeng@vivo.com>
	 <20250828075406.386208-3-rongqianfeng@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-28 at 15:53 +0800, Qianfeng Rong wrote:
> Change the 'ret' variable from unsigned int to int to store negative erro=
r
> codes or zero returned by regmap_update_bits().
>=20
> Storing the negative error codes in unsigned type, doesn't cause an issue
> at runtime but it's ugly as pants. Additionally, assigning negative error
> codes to unsigned type may trigger a GCC warning when the -Wsign-conversi=
on
> flag is enabled.
>=20
> No effect on runtime.
>=20
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0sound/soc/codecs/adau1977.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/codecs/adau1977.c b/sound/soc/codecs/adau1977.c
> index ae59efb38f26..c193a9f22f59 100644
> --- a/sound/soc/codecs/adau1977.c
> +++ b/sound/soc/codecs/adau1977.c
> @@ -795,7 +795,7 @@ static int adau1977_set_sysclk(struct snd_soc_compone=
nt
> *component,
> =C2=A0	struct adau1977 *adau1977 =3D snd_soc_component_get_drvdata(compon=
ent);
> =C2=A0	unsigned int mask =3D 0;
> =C2=A0	unsigned int clk_src;
> -	unsigned int ret;
> +	int ret;
> =C2=A0
> =C2=A0	if (dir !=3D SND_SOC_CLOCK_IN)
> =C2=A0		return -EINVAL;

