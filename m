Return-Path: <linux-kernel+bounces-890302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9DDC3FBF6
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CBC64E63C0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1072F4A0E;
	Fri,  7 Nov 2025 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV8mEXQw"
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B935E259C92
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515341; cv=none; b=s5AhC/zusr/JdrkI1NkiBJaGj8Jh985N3v07/sxraS0Y0xrxGPMyV1/Tb7ucrtdFHsdmHWz2ajDKucEKWka0UUvZhnpK0GJpBA9LU9dgtE+PvIfftXE29R+/qnJmcAw2/szfNrg+yhmVCZoC++p/a17RYpx9op3fXbu+y832VYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515341; c=relaxed/simple;
	bh=zNqXV7WRO/eVwUnndTihrxnpBVkbzuZTXPTv4fgK0XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+xCAcb0ILVryOy4YEmls5LDYEwdtPteoqxYJCW2kz0SAUoh2vQYSSv1h8eNCG6lz8VayqnqwzKOouWyaFZAxcz9onuPaqRkSerfOrMrlZzE98D+mMq7kn5C0P054PuU/lZG2Q+7CSJPAWuKCRg4mAU/u9i494Juw4YWRx8m/aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV8mEXQw; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63f996d4e1aso598992d50.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762515339; x=1763120139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++p55Z22oOKt7e+LqpAwzHw/R5/V6CL0JDal82TPeYM=;
        b=YV8mEXQw3xfK5ilP0bn7MGca4kjbAPHFAxEWpK2RypcRydKmvAbaHdBP09EM6WqxHR
         s+D841T7rmb+c6dBHSaVsJC5rL89aAy6FYV5l+9MHXrg3QEwdZrjP1A/t+rlVirIiOrp
         AD8HRQUsrKWRUug7yx/B5+NrhF7exSa+NtjxxQmpzd5xXqg08QHOoKN1ktlw989csp32
         DaL7UlJakvWrrf6gZrwtxBhpK7NxELgm/V9qdnzzqIvrs0RskXho1aD8a/KfGckDiMQf
         a6EPlKGSf/n5WmKBKUL4f0xSZ9t93TSWoa5Ll0y2wxVDehyyCUWbwS0mi5psJzLiA2R8
         cSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762515339; x=1763120139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=++p55Z22oOKt7e+LqpAwzHw/R5/V6CL0JDal82TPeYM=;
        b=lD3wrXp4zWHHtAdNHpA/nQk3g+kuAiDd3xwA9B9ubNlTSQNcMI45hk5lYKWQ8Vwfry
         OsG227BvnZCuagnVMKF3RfNbusAvPbP0qL0aQuYZ8sxb6cn0cZbeAI2NwavAenGvJAZN
         TMEifXlEHYq9PEXFinS5b74bzJRSU9xoc+O2Itqf7co3eX27e/rIBWsTcsD8XUiePLFE
         BgaZhw7NPOEolY3sktjBO9998NM4WgPtCeoQD9UKci9rCfVuwv1FffaTz+0acC38ud0s
         6LEdRe/N6Wd+0RbDB2jfmzwSqVD42BFdkoNgNuavdAZYQ7uc5SyUnJ/Z+jcGl5uBrFrs
         y35g==
X-Forwarded-Encrypted: i=1; AJvYcCUUnhuUsEqWOezhidZUt6F5CDtxmsYpGJz5z4STF2MduvilAj+BWwHNR+3804QVJQvZ1/dOxb4QYxbQSvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRLZYsHTwo+wqJhMU6hohHDSTtAdIwI+2JCLXoQ1F6eq0UT0PK
	rn46VUcgv3ys853OAt2BmxOp6kiDSN+FIBY4HBsmd2dor3RDxNS1zgGytGXnPRbfhdrRr8d3YGw
	AkT9dQ30euh/zYbyfWBsK5i/MG+cTFr4=
X-Gm-Gg: ASbGncu/9dYO00I9/ezAwpIz1PR4ZuZnjy7TzN5E5JMB2HwqDQXixpAhPgpeMe698Es
	1Unop5dY43yuQj2uiF4SA/LRVeFTVGUorztpVAiexiCCy8hfEPY+nZH6caKEZSxW2PrHc1LktOp
	sKExyH/qhLwlvGwAMZZDqfzV09GMFy6MWBvEmMFxZTeamu6vo0IU4jnhBszo/5kgLx3nUnPb36n
	LwKEY2Wi4bNEhEjJz1oKMU6tMDQb4UoZaH5IHk4tEPFCbbIjJvZspgeKbQbqw==
X-Google-Smtp-Source: AGHT+IGXYJDMaVrUBMedAXp8lQRn7HgcOZXWi6MRoLsHiQLGzhj7GRFpkd3fc0HO9nlH6lIVhM8c66RWKCBzqaH+Avc=
X-Received: by 2002:a53:c059:0:20b0:63f:b922:ed79 with SMTP id
 956f58d0204a3-640c418d78dmr2148649d50.14.1762515338720; Fri, 07 Nov 2025
 03:35:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107100310.61478-1-a.safin@rosa.ru>
In-Reply-To: <20251107100310.61478-1-a.safin@rosa.ru>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 7 Nov 2025 19:35:02 +0800
X-Gm-Features: AWmQ_bmDQR-XfcumZ--vLoQjq_ZgB7K9GMeBPoe20HqNsFPwE-dH9_mC25f64J0
Message-ID: <CALOAHbDGw_kfz-Vv7BRwY0Rk3SofMQ4rzvvQph2wBT=_9ZK0HQ@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: hashtab: fix 32-bit overflow in memory usage calculation
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

On Fri, Nov 7, 2025 at 6:03=E2=80=AFPM Alexei Safin <a.safin@rosa.ru> wrote=
:
>
> The intermediate product value_size * num_possible_cpus() is evaluated
> in 32-bit arithmetic and only then promoted to 64 bits. On systems with
> large value_size and many possible CPUs this can overflow and lead to
> an underestimated memory usage.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 304849a27b34 ("bpf: hashtab memory usage")
> Cc: stable@vger.kernel.org
> Suggested-by: Yafang Shao <laoar.shao@gmail.com>
> Signed-off-by: Alexei Safin <a.safin@rosa.ru>

Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
> v2: Promote value_size to u64 at declaration to avoid 32-bit overflow
> in all arithmetic using this variable (suggested by Yafang Shao)
>  kernel/bpf/hashtab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 570e2f723144..1f0add26ba3f 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2252,7 +2252,7 @@ static long bpf_for_each_hash_elem(struct bpf_map *=
map, bpf_callback_t callback_
>  static u64 htab_map_mem_usage(const struct bpf_map *map)
>  {
>         struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map)=
;
> -       u32 value_size =3D round_up(htab->map.value_size, 8);
> +       u64 value_size =3D round_up(htab->map.value_size, 8);
>         bool prealloc =3D htab_is_prealloc(htab);
>         bool percpu =3D htab_is_percpu(htab);
>         bool lru =3D htab_is_lru(htab);
> --
> 2.50.1 (Apple Git-155)
>


--=20
Regards
Yafang

