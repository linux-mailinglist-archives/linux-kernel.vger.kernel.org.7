Return-Path: <linux-kernel+bounces-889860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D44BDC3EB6B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACAA64EAA1C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2483307AD0;
	Fri,  7 Nov 2025 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2QffX2q"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F50306D26
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762499584; cv=none; b=fxrObxOIDt0v7evhiECqeGys9FjV7Un0ENZ4caZRs+CHmJd+g99iOpKdfhKW5VfHdIKl7kiOFzkDNqnFrKrQqZ5a6RBsO+/iPFk6CmDUy0zmXFNlopL54KIJz46GvM7r2iq1FHSMfE+qDvLCAHXJ/Ehb+VlBypV5peTRRBO3l7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762499584; c=relaxed/simple;
	bh=AnHNniu0pCdXghvw2Pl/euA5eGN8u2vE4cvHIahrfxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4S0kyObVX0l0I23bTkOQgj3xc1U77FXwq9+vmslJ5FZkZbYaYyAl6lndwx71vn+46ocZ677FRtW7KG2ReKYPH7Fqjxtipcxlz1c1lYEwKcyP+IGTTa2wJsKm6V1NwVNaOnf0ixf0G8XT1GOiNcPSBT5ASbxAzU6jNT2Vc2WdAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2QffX2q; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7272012d30so63864066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 23:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762499581; x=1763104381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgSLZZs6Fwc/5qGJ5Q4UyqQtiAlwyxjSUqJRm3a25hI=;
        b=m2QffX2qNvUr45YO660hHZrSdER8K5+la03cZ75bpvJow1E9CJl3e+vSCb8T0oO7Fb
         rHtJaKL9NLlDOhAELRC8jiWuAO3XRyetLPZtKwQjpLLK/TyqFnEs2mWKhNk6jT928yx1
         k3lsr9k/SLbf6bRuloZOf+z0ziNTNns2+BJtxetCjj7FLWG/XO+Np47YS9rNIS1pDuD6
         3eH8aYKny8+h7FsQU5RBsIJf8rVP882g10hDEiaz7pKqJ8RNtyaHuw55K5N/0lqM72k9
         bKltN6BE3Ohe68Q9CMM0Zn+3Sl4exbL31h5vjEMlEbXkHxd8O9J/MN4V3iLgURb9pDPZ
         df8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762499581; x=1763104381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hgSLZZs6Fwc/5qGJ5Q4UyqQtiAlwyxjSUqJRm3a25hI=;
        b=kXvVsv/QC7bu82HxjcikUcBI4rxVzEClosn+HcGd5NXZxj4WL2C+wmA4K6fqiQdpp1
         gzbDJFl7ZSQfR13aDciUXBsjwZLdUTYAY9aIAgKJen6VagMt8E1wLA99bKj9iKrGFT1K
         oA0qp+gfSJa7UXv2xDeTLGZOp4dK+JG7zbTjVohhpnnxDo7aGwooef1zA2sqjs076YSN
         xvpbCC+zMxwibrfQIDJ1G7Dg2oSQqLVH/vDT7pYhtm5iGjO2lyTVts4b1tveyZAR+9gj
         UJa12L/kzhvWIaowMA7eH8i5rU1fq0oNMYeMQ7YhapVx2rOnVV8n08jqR9XEUXQgAkmy
         PurA==
X-Forwarded-Encrypted: i=1; AJvYcCWue5wyJOltzNPcHXSCQk1m9PBAUDzAiTXddMa7l9cTMC72mKr2bKO8fANCFcyJIpx9qhPH/pqquo7CjR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqyjzWesaOlNBBeEifxwJSuy8o/TfvdWBGHgp2gbeaGf8HS1b/
	fWW5zFcCLmfKnMS1LrfBuOYXSAO9+Jq0aNpcspQz/lIZdCv5iDfoHe5/WdDirNB0QXRD4ZaDgOT
	hyMdWKHCFKQEEogduSeKYhh2rb6o/nio=
X-Gm-Gg: ASbGnct/+7QYgEQO7azDuMQOq1b+/O/06C63IPMSjORVSoS6ZiahIuMUjAa7Tz1bD3L
	Ibk7tLhs8Gv8gKPehUKpCGgWh65CNEetR586WcoNpIxrtR76mENR7lI00KzmDoPfw1u+i3AJCr/
	iK2uP2yAK5uuhGGTI4X5rOyTHdeQEddwQy509jOq+dpEDz+ORW2lqQPjfLJ8KAg6xpxtXtOhAb2
	U7Yhc59jjcx1lEmhtUyrMhedaZkf1fsWD9q5M6WVW776NGQwcbm472MW5yNTCRSrxDMiwQV
X-Google-Smtp-Source: AGHT+IEuqvDGcde7z9yd376iwgyGimO6uoR69Fkm1BPx7nWXVFk+h9CgdUcqdihT6jI1cgO1zJBBkUlHmIDIBoLM8Ok=
X-Received: by 2002:a17:907:1c18:b0:b71:1420:334a with SMTP id
 a640c23a62f3a-b72c0932a0dmr203114466b.13.1762499580592; Thu, 06 Nov 2025
 23:13:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106131956.1222864-3-dolinux.peng@gmail.com> <36cd75fea9d630152704e29bd21054aba72dcb459a7b9d40b5d979313b1fe3a5@mail.kernel.org>
In-Reply-To: <36cd75fea9d630152704e29bd21054aba72dcb459a7b9d40b5d979313b1fe3a5@mail.kernel.org>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 7 Nov 2025 15:12:48 +0800
X-Gm-Features: AWmQ_blNvN-Ihf8AbmrgtyJ2vjtFsUEMSGGxRnE8kPrZNs0IA_vnsSz-wxumv3M
Message-ID: <CAErzpmt0L6hS8W0xXznrVY8dLJN_opS8ZyyorT3m7yyANLQ9Cw@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] libbpf: Add BTF permutation support for type reordering
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, eddyz87@gmail.com, andrii.nakryiko@gmail.com, 
	zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	alan.maguire@oracle.com, song@kernel.org, pengdonglin@xiaomi.com, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 9:47=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 9c389b2c8..97451a929 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
>
> [ ... ]
>
> > +int btf__permute(struct btf *btf, __u32 *ids, __u32 ids_sz, const stru=
ct btf_permute_opts *opts)
> > +{
> > +     struct btf_permute p;
> > +     int err =3D 0;
> > +     __u32 *ids_map =3D NULL;
> > +
> > +     if (!OPTS_VALID(opts, btf_permute_opts) || (ids_sz > btf->nr_type=
s))
> > +             return libbpf_err(-EINVAL);
> > +
> > +     ids_map =3D calloc(ids_sz, sizeof(*ids_map));
>
> Can ids_map overflow here in btf_permute_shuffle_types()?
>
> The ids_map array is allocated with ids_sz elements, giving valid
> indices from 0 to ids_sz-1. However, in btf_permute_shuffle_types()
> the code accesses:
>
>     ids_map =3D &p->ids_map[id - btf->start_id]
>
> where 'id' is validated only to be in range [btf->start_id,
> btf->start_id + btf->nr_types). When ids_sz < btf->nr_types
> (truncation case) and a user provides a type ID where
> (id - btf->start_id) >=3D ids_sz, this results in an out-of-bounds
> write to ids_map.
>
> For example, with start_id=3D1, nr_types=3D100, and ids_sz=3D50:
> - ids_map has 50 elements (indices 0-49)
> - If user includes type ID 75 in the ids array
> - btf__type_by_id(btf, 75) succeeds (75 < 101)
> - ids_map[75-1] =3D ids_map[74] writes beyond the array
>

Thanks, I will fix it.

> The same issue occurs in btf_permute_remap_type_id() where the code
> reads from ids_map without validating the index is within ids_sz:
>
>     new_type_id =3D p->ids_map[*type_id - p->btf->start_id]
>
> If any included type references a type ID beyond ids_sz, this reads
> uninitialized memory (or out-of-bounds if the ID is >=3D ids_sz +
> start_id).

Thanks, I will fix it.

>
> > +     if (!ids_map) {
> > +             err =3D -ENOMEM;
> > +             goto done;
> > +     }
> > +
> > +     p.btf =3D btf;
> > +     p.btf_ext =3D OPTS_GET(opts, btf_ext, NULL);
> > +     p.ids =3D ids;
> > +     p.ids_map =3D ids_map;
> > +     p.ids_sz =3D ids_sz;
> > +
> > +     if (btf_ensure_modifiable(btf)) {
> > +             err =3D -ENOMEM;
> > +             goto done;
> > +     }
> > +     err =3D btf_permute_shuffle_types(&p);
> > +     if (err < 0) {
> > +             goto done;
> > +     }
> > +     err =3D btf_permute_remap_types(&p);
> > +     if (err < 0) {
> > +             goto done;
> > +     }
> > +
> > +done:
> > +     free(ids_map);
> > +     return libbpf_err(err);
> > +}
>
> [ ... ]
>
> > +static int btf_permute_shuffle_types(struct btf_permute *p)
> > +{
> > +     struct btf *btf =3D p->btf;
> > +     const struct btf_type *t;
> > +     __u32 *new_offs =3D NULL, *ids_map;
> > +     void *nt, *new_types =3D NULL;
> > +     int i, id, len, err;
> > +
> > +     new_offs =3D calloc(p->ids_sz, sizeof(*new_offs));
> > +     new_types =3D calloc(btf->hdr->type_len, 1);
> > +     if (!new_offs || !new_types) {
> > +             err =3D -ENOMEM;
> > +             goto out_err;
> > +     }
> > +
> > +     nt =3D new_types;
> > +     for (i =3D 0; i < p->ids_sz; i++) {
> > +             id =3D p->ids[i];
> > +             /* type IDs from base_btf and the VOID type are not allow=
ed */
> > +             if (id < btf->start_id) {
> > +                     err =3D -EINVAL;
> > +                     goto out_err;
> > +             }
> > +             /* must be a valid type ID */
> > +             t =3D btf__type_by_id(btf, id);
> > +             if (!t) {
> > +                     err =3D -EINVAL;
> > +                     goto out_err;
> > +             }
> > +             ids_map =3D &p->ids_map[id - btf->start_id];
> > +             /* duplicate type IDs are not allowed */
> > +             if (*ids_map) {
> > +                     err =3D -EINVAL;
> > +                     goto out_err;
> > +             }
> > +             len =3D btf_type_size(t);
> > +             memcpy(nt, t, len);
> > +             new_offs[i] =3D nt - new_types;
> > +             *ids_map =3D btf->start_id + i;
> > +             nt +=3D len;
> > +     }
>
> [ ... ]
>
> > +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
> > +{
> > +     struct btf_permute *p =3D ctx;
> > +     __u32 new_type_id =3D *type_id;
> > +
> > +     /* skip references that point into the base BTF */
> > +     if (new_type_id < p->btf->start_id)
> > +             return 0;
> > +
> > +     new_type_id =3D p->ids_map[*type_id - p->btf->start_id];
> > +     if (new_type_id > BTF_MAX_NR_TYPES)
> > +             return -EINVAL;
> > +
> > +     *type_id =3D new_type_id;
> > +     return 0;
> > +}
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/191371=
95500

