Return-Path: <linux-kernel+bounces-885608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B779C33733
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 01:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B42B18C7100
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 00:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3C0239562;
	Wed,  5 Nov 2025 00:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcS9jbRY"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DF52222CB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762301513; cv=none; b=iIRAgURGDxQ4PIBiY0ULsDT3Ys5H/rLUbiaQ1OqxiEbsvrqFWFQI/MUcMDnxEw/l8QKiRhNhLfMeIVcB9qyjm/sHTRcgpaGAR+QCm9zAVauDxEBVanurL07vLhBmJS5yocn9Bvjh4hqnp/yqFtbshvHex9pfcD97Oc0GwkIwgCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762301513; c=relaxed/simple;
	bh=egApfFk13KJcnOMuBl7XQXyD2R2emCM7KSm4uD1h+h4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xi/jOr6A6jL8GzA6U8Ye3KVvq6+ZujycTDxY1CelgLn129nmyJwSnwU5NxgliNjWwQdn8dbUyWSYpZfRyaqv3mzG0Bo2P6BSm50Om0V6G7PsnqBfGQRVVLJg+79qzidLc6BsGPmYXZjRY23uHDHbJgpjHaB5FNOAwtbNgtg4f2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcS9jbRY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-295247a814bso67172455ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 16:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762301512; x=1762906312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtWfTJRPCw7anAtGgSIQB0yO/0AIyh3oLVZfL/RYThw=;
        b=VcS9jbRYDVQzoR4GdtPdyKAQiCOCgFOJxqgJsns/BDs7mjvP6v3ihOuItaldIn48gm
         sVz1vTOAzVsf0nlFKfmUkc1TOFS2oU0Lo4/RP1wQyFBiTklNuPrbDfa88aih4/ymJfAg
         tpl1m5uuSTqKLPzLElN7mTJNDYhWmB7/Wccv62UQuCCLTvGAlJ2zUm3Z1YrshJhnHgVD
         mZ2YaAzyAV2FrXNoqozQ/1uxmDVjjQCsMeH/mQ6wSL8msjcOVZTf3tdHB+4I8BEVwXc2
         kHYWMUbBk226PhGWemJToJZAJhXcrOqmq0IhwxLspdv6Y1jsLm9QMi48oeSX2vijJLQB
         hteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762301512; x=1762906312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtWfTJRPCw7anAtGgSIQB0yO/0AIyh3oLVZfL/RYThw=;
        b=bIjupL+vIoncXCGlj9JLLshw5Ysb9vee+1T0SpMXBh3NX3LAJZxIsU6PeGYoiQm2/+
         cV7QqO194Y9Gg9QbWz8Ta1mk0iFqJQFkuD92gAipm9oGfhlKs8rwKn+cKSUX8wLHW7ML
         1vx0vKQdFQy2ccgp+bQUaron5V7jePXv5TLJYb86HOeePXBT8IHiVh76i1C4U/6dt1cI
         aCmbqXlY0bTytP2xHe1dv2vaonDoykz4mG85NzUbSF7ISKF8x8yTiNGfnM2lGJe3MrEu
         S5nKgyYuhn/nDandQ9Y1Fd3jWMw5ySmyQyostXsTXxmxaDlWIUwT1PGLjTQBQH4iBt5Q
         PUzg==
X-Forwarded-Encrypted: i=1; AJvYcCXHGTxE83wTRa9qIqfKGD9So1ozuLiZZ6izQNmcvMJ8fnO2nIy6tcbdg7x3adFQY7lo1WCADigprWB3nz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAjVIQj1rAXai0EgFn0Y8evfnCgAnMhqN7LKLgpLcjei1EYDOv
	BfFsgyMNNczWRLHAtNJRJF373i+rpo+S3LDX0moryNw+F7NTJZ/baoqGXVvvlpeOBU8d637gL1S
	Bco+aObcHIrKlJE1S0bSXxVIeRWtkmWE=
X-Gm-Gg: ASbGncvOI9njWXdK2cvPE9CUMQDHdfCoBsgtcWu8cydnhdaxLcJ5ADsfvIOQT2AnDRO
	Anf2gGI+rZyKJlW2lWzvoC6LXhb0fM3xhElE9Bl794JxhWBzR8QzmZ+LFCmHnLsOV6jUAbvuqi3
	YISdt1MUiKVC0hCNMonMX5JuJXsQ3ert01J+zN+95rf2FGb+E1y10X9rX/PBvOUESKU26/stWEr
	j7gjikb3BgzukXotqN8bTCA5lM2vJ5kbMSIfpAcBRJ1ziDTfRFiH0a4YbBKWfVINNq7p7wcoRcR
X-Google-Smtp-Source: AGHT+IEhjTh/ZHI4iUJDdgOVprEO3BpQW6eiDMY6bUkLMJswioiYcUn1kIFEW75KNONN2oRBsZ3KLYI3t0DN2b20NKY=
X-Received: by 2002:a17:902:da84:b0:290:a3b9:d4c7 with SMTP id
 d9443c01a7336-2962ae1098dmr18996845ad.30.1762301511853; Tue, 04 Nov 2025
 16:11:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com> <20251104134033.344807-4-dolinux.peng@gmail.com>
In-Reply-To: <20251104134033.344807-4-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Nov 2025 16:11:36 -0800
X-Gm-Features: AWmQ_blQWORGG8pOOv8yg8w-WgvnMq2ZFiRlQ9TP4A1w_-607aYq6uqmsxXVUJ0
Message-ID: <CAEf4BzaxU1ea_cVRRD9EenTusDy54tuEpbFqoDQUZVf46zdawg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/7] libbpf: Optimize type lookup with binary
 search for sorted BTF
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 5:40=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> This patch introduces binary search optimization for BTF type lookups
> when the BTF instance contains sorted types.
>
> The optimization significantly improves performance when searching for
> types in large BTF instances with sorted type names. For unsorted BTF
> or when nr_sorted_types is zero, the implementation falls back to
> the original linear search algorithm.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---
>  tools/lib/bpf/btf.c | 142 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 119 insertions(+), 23 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 3bc03f7fe31f..5af14304409c 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -92,6 +92,12 @@ struct btf {
>          *   - for split BTF counts number of types added on top of base =
BTF.
>          */
>         __u32 nr_types;
> +       /* number of sorted and named types in this BTF instance:
> +        *   - doesn't include special [0] void type;
> +        *   - for split BTF counts number of sorted and named types adde=
d on
> +        *     top of base BTF.
> +        */
> +       __u32 nr_sorted_types;

we don't need to know the count of sorted types, all we need is a
tristate value: a) data is sorted, b) data is not sorted, c) we don't
know yet. And zero should be treated as "we don't know yet". This is
trivial to do with an enum.

>         /* if not NULL, points to the base BTF on top of which the curren=
t
>          * split BTF is based
>          */
> @@ -897,44 +903,134 @@ int btf__resolve_type(const struct btf *btf, __u32=
 type_id)
>         return type_id;
>  }
>
> -__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
> +/*
> + * Find BTF types with matching names within the [left, right] index ran=
ge.
> + * On success, updates *left and *right to the boundaries of the matchin=
g range
> + * and returns the leftmost matching index.
> + */
> +static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, const =
char *name,
> +                                               __s32 *left, __s32 *right=
)

I thought we discussed this, why do you need "right"? Two binary
searches where one would do just fine.


Also this isn't quite the same approach as in find_linfo() in
kernel/bpf/log.c, that one doesn't have extra ret =3D=3D 0 condition

pw-bot: cr

>  {
> -       __u32 i, nr_types =3D btf__type_cnt(btf);
> +       const struct btf_type *t;
> +       const char *tname;
> +       __s32 l, r, m, lmost, rmost;
> +       int ret;
> +

[...]

