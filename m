Return-Path: <linux-kernel+bounces-887117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DB8C374F0
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC34D34F838
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79EC2BFC60;
	Wed,  5 Nov 2025 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaeamlqV"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635A6283FC5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367363; cv=none; b=vCfYJyaTOg6F5rLQcshhvkuIuqkmJ6+gYMs1UASE8J/gjXCj4cXQZ+dDMS8v+uSdEIAui1es4BtTh+5zNdgDmdOKsMyy9PZzyM57JJWvWm0yd+KwrKOIxcWdnbF66WJR7zWJkvHjLEr04LGanUlTZuJ+WzAKCCc59TNVHPCIgjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367363; c=relaxed/simple;
	bh=6EdBpPqm7H9EeEXxV1AjUAUIXnBn1iVITd1W0fyo1uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y086nr6qw13+f3BdTa7c8+8rgWn2hfoStHclwjIr6SZuCSzhOr1GyiaicdbHiAbs3FLPSBl7n71LCLIZaDRGLXb5WVa6EWTWiz6NxkMrNwQPRciUXnv9rp5AIFKELSw/5ceXgMxCBZce0++kdSS2cxt6Rn/3Tz4/WiZTqmX5ZpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaeamlqV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-294df925292so1504505ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 10:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762367361; x=1762972161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uP7Mo7uoLw4cpjXQQ+NrlYJU3DE4k04KpKbXfylIIIU=;
        b=EaeamlqVxHQSbjroOPBw61Jz7jrfeLg1y8Gynv4d59XnvcErqssSMyLUywCTrrafRz
         UEpwXRM07s/kXYz01qNVnAwGd1xa4Shj2rbLm23sJ1NknBaysmVO/Ay//cs8acAq7LSJ
         HzqUIRm5g/vQND1sf8RuQy+Aa27NpPJAGGLAhc2r7INb02jN8hZ/NQgeCUIERRfqkerl
         85vPoJgAZL3SB0y3X0cPHNmBg/DIRkhcV0yhs/dua6WT6Tvxh7tDwFq1cfFGS1CxxmP0
         hYja22Q1+n2Q18Jx0taFu1lXpPAHLeMc//rTJsFE64AIo52UUQ5azSUjISpJIjb49vwn
         p43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762367361; x=1762972161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uP7Mo7uoLw4cpjXQQ+NrlYJU3DE4k04KpKbXfylIIIU=;
        b=a6bCJfI2NAzNX/ONpcV4vFbCcAiQcSBbgEaEArqNoiC0qTyQqBWf1dw5HE+CSDyYcw
         4jNiKDUUbODu0NM7pWDmpfsIQ4RkLi9ks15iCypORXvrpT/zKc5zN8Ldgz6kj+m+8Oo9
         z8iFfJbHHhfbO2arP7Vj7X51dBWMcHmUl6hpgFBYkoUcdxS6vAAgausYNQZs63bmddRh
         g4lBCC3giAzE4chXghZPKiIbpWJFNedrnaX9Sk9RGkRJ/vrrP4FqR1OFDN5xkDoAF2tb
         mTmG4RI06gu0/JCTTmQpaF6eVFZJFTj2RaibMVYtu6wUDgH2aSF6QMD+cL4vpBms+KNV
         /hUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqRJxKPJ/aLttS6JCEkpbkH8kT3H/xnAkqFfdVHos95t4oFE9d1WIsYwEfUKQ9CeVs3dy+DtGBITaGiAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTzoJnn4DWIFQLXXMuB86RIIVv58Iz/8z/Reaqgve82pk3m6DG
	y8f31JfnHsr4joYa2xdCAGQzoctsFX8ygjkIt9Samm3Q0FJAd9a+W1VerU55n63Zn/5kvsc+aYl
	HI3C2WCigCBzwZkyWG7SR9V6QQXpNRLo=
X-Gm-Gg: ASbGncsArHcOchC5g2VoYn3UgeC5k34F2+9JSNurDD6ssVa4zgoG4oC7Zyc6vvsduWQ
	tw8LJU37Y9qfQ8gODmdZqlHlWzeE+t9WobE8TDcMaOyMhafE0+p5KBxVRTGjxmTFtu45tf2oj7c
	0AsQ/WuDTX48c9Kc8oKAW9LJxvn5qQgyLRTMVo/8xroyo4iJmpXi5NY2SsKTVWDhHZm1SqZLKQL
	qIZuy3Qfj+mYjfUfpNdCWBemG9EwN/bug46S49c2xbJGRZu3p7bUshVxEQ6
X-Google-Smtp-Source: AGHT+IEb0QpXHvxEq6ngFuSjtgFmQZZW+gDIxYgjmHaL3sAYJ7x+EggDdzvuMD1/WyIDHQXKyvwLSghJ724Ef8DLuxA=
X-Received: by 2002:a17:902:fc46:b0:27e:ec72:f6d with SMTP id
 d9443c01a7336-2962ad0a0e0mr60441475ad.11.1762367360600; Wed, 05 Nov 2025
 10:29:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
 <20251104134033.344807-3-dolinux.peng@gmail.com> <CAEf4BzaQ9k=_JwpmkjnbN8o0XaA=EGcP-=CBxmXLc3kzh3aY3A@mail.gmail.com>
 <CAErzpmv8eBjuX-RO0nopuy8qMV7wzVxa2e+HteXfFodwbBoALg@mail.gmail.com>
In-Reply-To: <CAErzpmv8eBjuX-RO0nopuy8qMV7wzVxa2e+HteXfFodwbBoALg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Nov 2025 10:29:06 -0800
X-Gm-Features: AWmQ_bnvLcXjk8-JilQFv03Ai6j9oTMM0FJ77V9BXopcXRgv9isPbEAokGIU0dY
Message-ID: <CAEf4Bza+pHVSGTC2vcjF-DmsVxKq2Ksq321E9CJEGdyT8hQn3g@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/7] libbpf: Add BTF permutation support for type reordering
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:53=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> On Wed, Nov 5, 2025 at 8:11=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Nov 4, 2025 at 5:40=E2=80=AFAM Donglin Peng <dolinux.peng@gmail=
.com> wrote:
> > >
> > > From: pengdonglin <pengdonglin@xiaomi.com>
> > >
> > > Introduce btf__permute() API to allow in-place rearrangement of BTF t=
ypes.
> > > This function reorganizes BTF type order according to a provided arra=
y of
> > > type IDs, updating all type references to maintain consistency.
> > >
> > > The permutation process involves:
> > > 1. Shuffling types into new order based on the provided ID mapping
> > > 2. Remapping all type ID references to point to new locations
> > > 3. Handling BTF extension data if provided via options
> > >
> > > This is particularly useful for optimizing type locality after BTF
> > > deduplication or for meeting specific layout requirements in speciali=
zed
> > > use cases.
> > >
> > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > Cc: Song Liu <song@kernel.org>
> > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > > ---
> > >  tools/lib/bpf/btf.c      | 161 +++++++++++++++++++++++++++++++++++++=
++
> > >  tools/lib/bpf/btf.h      |  34 +++++++++
> > >  tools/lib/bpf/libbpf.map |   1 +
> > >  3 files changed, 196 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > index 5e1c09b5dce8..3bc03f7fe31f 100644
> > > --- a/tools/lib/bpf/btf.c
> > > +++ b/tools/lib/bpf/btf.c
> > > @@ -5830,3 +5830,164 @@ int btf__relocate(struct btf *btf, const stru=
ct btf *base_btf)
> > >                 btf->owns_base =3D false;
> > >         return libbpf_err(err);
> > >  }
> > > +
> > > +struct btf_permute {
> > > +       /* .BTF section to be permuted in-place */
> > > +       struct btf *btf;
> > > +       struct btf_ext *btf_ext;
> > > +       /* Array of type IDs used for permutation. The array length m=
ust equal
> >
> > /*
> >  * Use this comment style
> >  */
>
> Thanks.
>
> >
> > > +        * the number of types in the BTF being permuted, excluding t=
he special
> > > +        * void type at ID 0. For split BTF, the length corresponds t=
o the
> > > +        * number of types added on top of the base BTF.
> >
> > many words, but what exactly ids[i] means is still not clear, actually.=
..
>
> Thanks. I'll clarify the description. Is the following parameter
> explanation acceptable?
>
> @param ids Array containing original type IDs (excluding VOID type ID
> 0) in user-defined order.
>                     The array size must match btf->nr_types, which

Users don't have access to btf->nr_types, so referring to it in API
description seems wrong.

But also, this all will change if we allow removing types, because
then array size might be smaller. But is it intentionally smaller or
user made a mistake? Let's go with the ID map approach, please.

> also excludes VOID type ID 0.
>
>
> >
> > > +        */
> > > +       __u32 *ids;
> > > +       /* Array of type IDs used to map from original type ID to a n=
ew permuted
> > > +        * type ID, its length equals to the above ids */
> >
> > wrong comment style
>
> Thanks, I will fix it in the next version.
>
> >
> > > +       __u32 *map;
> >
> > "map" is a bit generic. What if we use s/ids/id_map/ and
> > s/map/id_map_rev/ (for reverse)? I'd use "id_map" naming in the public
> > API to make it clear that it's a mapping of IDs, not just some array
> > of IDs.
>
> Thank you for the suggestion. While I agree that renaming 'map' to 'id_ma=
p'
> makes sense for clarity, but 'ids' seems correct as it denotes a collecti=
on of
> IDs, not a mapping structure.
>
> >
> > > +};
> > > +
> > > +static int btf_permute_shuffle_types(struct btf_permute *p);
> > > +static int btf_permute_remap_types(struct btf_permute *p);
> > > +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx);
> > > +
> > > +int btf__permute(struct btf *btf, __u32 *ids, const struct btf_permu=
te_opts *opts)
> >
> > Let's require user to pass id_map_cnt in addition to id_map itself.
> > It's easy to get this wrong (especially with that special VOID 0 type
> > that has to be excluded, which I can't even make up my mind if that's
> > a good idea or not), so having user explicitly say what they think is
> > necessary for permutation is good.
>
> Thank you for your suggestion. However, I am concerned that introducing
> an additional `id_map_cnt` parameter could increase complexity. Specifica=
lly,
> if `id_map_cnt` is less than `btf->nr_types`, we might need to consider w=
hether
> to resize the BTF. This could lead to missing types, potential ID remappi=
ng
> failures, or even require BTF re-deduplication if certain name strings ar=
e no
> longer referenced by any types.
>

No, if the user provided a wrong id_map_cnt, it's an error and we
return -EINVAL. No resizing.

> >
> > > +{
> > > +       struct btf_permute p;
> > > +       int i, err =3D 0;
> > > +       __u32 *map =3D NULL;
> > > +
> > > +       if (!OPTS_VALID(opts, btf_permute_opts) || !ids)
> >

[...]

> > > +               goto done;
> > > +       }
> > > +
> > > +done:
> > > +       free(map);
> > > +       return libbpf_err(err);
> > > +}
> > > +
> > > +/* Shuffle BTF types.
> > > + *
> > > + * Rearranges types according to the permutation map in p->ids. The =
p->map
> > > + * array stores the mapping from original type IDs to new shuffled I=
Ds,
> > > + * which is used in the next phase to update type references.
> > > + *
> > > + * Validates that all IDs in the permutation array are valid and uni=
que.
> > > + */
> > > +static int btf_permute_shuffle_types(struct btf_permute *p)
> > > +{
> > > +       struct btf *btf =3D p->btf;
> > > +       const struct btf_type *t;
> > > +       __u32 *new_offs =3D NULL, *map;
> > > +       void *nt, *new_types =3D NULL;
> > > +       int i, id, len, err;
> > > +
> > > +       new_offs =3D calloc(btf->nr_types, sizeof(*new_offs));
> >
> > we don't really need to allocate memory and maintain this, we can just
> > shift types around and then do what btf_parse_type_sec() does -- just
> > go over types one by one and calculate offsets, and update them
> > in-place inside btf->type_offs
>
> Thank you for the suggestion. However, this approach is not viable becaus=
e
> the `btf__type_by_id()` function relies critically on the integrity of th=
e
> `btf->type_offs` data structure. Attempting to modify `type_offs` through
> in-place operations could corrupt memory and lead to segmentation faults
> due to invalid pointer dereferencing.

Huh? By the time this API returns, we'll fix up type_offs, users will
never notice. And to recalculate new type_offs we don't need
type_offs. One of us is missing something important, what is it?

[...]

