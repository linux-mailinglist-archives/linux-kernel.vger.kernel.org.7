Return-Path: <linux-kernel+bounces-889664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87235C3E2EA
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 02:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE9FA4E9188
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 01:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168D12F9DAF;
	Fri,  7 Nov 2025 01:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gP0s5TO1"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1AA2FB97D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 01:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762480724; cv=none; b=Kv+MBJFNbmI2z0G7NJSh82I7oPALfOshgeg+HOv36bB5liX1cqnW+gK4AR1cixGQny/0aal+F/r3xRdzmcQuo5WjWO/zmfZY7oDS5A0vm9fBCopVxzx5Go7LVS3g4sjNeMH9OAODumLf4gC9ivVq0Fq1QBMFpMsVZBuWLTfCJDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762480724; c=relaxed/simple;
	bh=uE+Rkygh9horIXIFvnROjufDWX1NgopkGjoPYzMfJYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1WmxDZNA8kY1nxxSqhFX7VeRGnoidPrUT6GTH+mEdWTHQoQqH2UGRZ587n+CqWtMtQ2VUFi8inQlyqu3aVsQEdqlPRiHXYNhZUyozZC178BMSwLbB6XYPOlEFXObB7p0cA+kl/Cy1IdxbSVd4GFxLuofwFjUJjBujd2b4WuWaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gP0s5TO1; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-787be077127so2919877b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 17:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762480721; x=1763085521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ws1923/IMmVOcT4O7JQ0j2rMySLfeg19gDf6kDjpaRU=;
        b=gP0s5TO1U7xSlsLirO/yPY7M4TaVxwpNBj98UtcrMyl04CeZ0mDjfpNwy70ahNXHKd
         t2jjeyNqq7moI9r3VlNkSODiiUCupLurs6cOy4GuVcPXgahwzW8Pi5Nuylke8sGXytLc
         nzJHVgROcZzPNz1lY9ZdTiYX+yuAdrQ/rca3+5v548xNzOprOwmc6j4oIJCL9y8VjtFI
         NKrvEJEjMoqqMMNcg9hJTZGIhyjsmvdXflclV76QL3IOPcC5WlXB3MTd73Lriid+P+bb
         lD1q/OrGsM8dDEHqpvIBiPG/J+gx64hLBBQ5kJfw4a9y6Ba6pUjbZVWrBIXdg+qp1kKg
         Z2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762480721; x=1763085521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ws1923/IMmVOcT4O7JQ0j2rMySLfeg19gDf6kDjpaRU=;
        b=fCCL8HQ+eMSjUKtmhmy+Py3bVpaWz+UqIXwqWKZNEARPp+1rw9aY2uuUxG+OY7mRGm
         8biqRZMPEyyDchlJ9mTh28ZPv5by/5A48H4DB3xFCb32+/m//J4LE+yEB38GW3h2tHkB
         bm4eVfEpeUrRvlZQ0pDRduHdLdNcISqmU4s/JhM5AtbPCGDvQL0FI6d9ceVuVE1+UW4h
         WpaMN4/UZaC4BCjyRg0Ir9/DHagCWZzy/1qLibFPE+OoYgh69gY6qDUrOETYj+225Ln8
         rygwbzM9n1BkTyUSGIjQ9IlLsqPcTxlrjgbcSd4U7ZI1osVsVP2sN04625xk9S7jT8rU
         Zntg==
X-Forwarded-Encrypted: i=1; AJvYcCVyY+wsm6rh9NwFTGDKM/2sfqWkDYcYsqaEe9FhL/HotrMlrLtZaVpyDD6NrqxGr99avsaSwne9glYdonk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLS2eCkVWNmJZYTpbgkx4nq12Q/dRK/DlVP/Bz1c1YobGQe3+M
	osBzZGnHuJ9llSa3m8Y5yBNu5p9YN4BxxkUwla1x4wUVjmV8el+e4Y4HQfynRC4RjNq10Ana+Ic
	Ss4NyGB40nd3WO3n2oUBsvbtioRqPkkk=
X-Gm-Gg: ASbGncu7Hf/wDlB01xwYSVv/XMpeL8rhkJWQmht9H+xZHHgVdLOVWyCPgJHeUnQHPWr
	v+M60wpOUUy8scKqnQoEnYy2dBJeTrWVPhEM7DromnhGkZJ5cLKwSvYY8urXUGuFgsjR5pFg6dU
	uKf6vQpPro/XC1Bi906n0DETj5XRP0wZa8dIodNRx/Gjbv53QthYJkI/auIt2+u7E/tYuXAs/lf
	iarzkXA8oEtqfXkJpW3kpDGGsSoKd91RZK/gigTzeMiDRBTRTNvIazxn78IGQ==
X-Google-Smtp-Source: AGHT+IFD1W4wWaFnX4WWC5V+GTvvDhI/nCF0mztprUtQtCHUG3Xcq5/Li5dJnu2eCXiyQxiY6R9td23BLW3X6YNPej0=
X-Received: by 2002:a05:690e:dc6:b0:63f:8734:36d5 with SMTP id
 956f58d0204a3-640c43eb044mr1470211d50.61.1762480720646; Thu, 06 Nov 2025
 17:58:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106205852.45511-1-a.safin@rosa.ru>
In-Reply-To: <20251106205852.45511-1-a.safin@rosa.ru>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 7 Nov 2025 09:58:04 +0800
X-Gm-Features: AWmQ_blKz8xkp87Ie3SuRJxJXNqDNP3e1oq6mV_yZNh0EqOO6_kc5GFDmtfaPIg
Message-ID: <CALOAHbCcfszFFDuABhPHoMioT26GAXOKZzMqww0QY1wKogNm1g@mail.gmail.com>
Subject: Re: [PATCH] bpf: hashtab: fix 32-bit overflow in memory usage calculation
To: Alexei Safin <a.safin@rosa.ru>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-patches@linuxtesting.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 4:59=E2=80=AFAM Alexei Safin <a.safin@rosa.ru> wrote=
:
>
> The intermediate product value_size * num_possible_cpus() is evaluated
> in 32-bit arithmetic and only then promoted to 64 bits. On systems with
> large value_size and many possible CPUs this can overflow and lead to
> an underestimated memory usage.
>
> Cast value_size to u64 before multiplying.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 304849a27b34 ("bpf: hashtab memory usage")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexei Safin <a.safin@rosa.ru>
> ---
>  kernel/bpf/hashtab.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 570e2f723144..7ad6b5137ba1 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2269,7 +2269,7 @@ static u64 htab_map_mem_usage(const struct bpf_map =
*map)
>                 usage +=3D htab->elem_size * num_entries;
>
>                 if (percpu)
> -                       usage +=3D value_size * num_possible_cpus() * num=
_entries;
> +                       usage +=3D (u64)value_size * num_possible_cpus() =
* num_entries;
>                 else if (!lru)
>                         usage +=3D sizeof(struct htab_elem *) * num_possi=
ble_cpus();
>         } else {
> @@ -2281,7 +2281,7 @@ static u64 htab_map_mem_usage(const struct bpf_map =
*map)
>                 usage +=3D (htab->elem_size + LLIST_NODE_SZ) * num_entrie=
s;
>                 if (percpu) {
>                         usage +=3D (LLIST_NODE_SZ + sizeof(void *)) * num=
_entries;
> -                       usage +=3D value_size * num_possible_cpus() * num=
_entries;
> +                       usage +=3D (u64)value_size * num_possible_cpus() =
* num_entries;
>                 }
>         }
>         return usage;
> --
> 2.50.1 (Apple Git-155)
>

Thanks for the fix. What do you think about this change?

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 4a9eeb7aef85..f9084158bfe2 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2251,7 +2251,7 @@ static long bpf_for_each_hash_elem(struct
bpf_map *map, bpf_callback_t callback_
 static u64 htab_map_mem_usage(const struct bpf_map *map)
 {
        struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map);
-       u32 value_size =3D round_up(htab->map.value_size, 8);
+       u64 value_size =3D round_up(htab->map.value_size, 8);
        bool prealloc =3D htab_is_prealloc(htab);
        bool percpu =3D htab_is_percpu(htab);
        bool lru =3D htab_is_lru(htab);


--=20
Regards
Yafang

