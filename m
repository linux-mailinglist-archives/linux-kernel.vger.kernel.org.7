Return-Path: <linux-kernel+bounces-887941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A668C3967E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 85E2634D378
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E1D221DAD;
	Thu,  6 Nov 2025 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwhnHbHQ"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812362C3252
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762414313; cv=none; b=U6Vz84f3Xor+A4+2q5CJ4unbqhzxsD7wGg0T74J+zrP37L+9zGLL4EpnqZir+YL8WZC6WHPZlITSmJDCLWhsqpyOaUYZV9XzxOgGWLu1MRUlz06/cacJYvv76g9LMByzpf6D1Hnu9Ah/JRtOl3dJX08de1lgwm07RUWLLqoE8Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762414313; c=relaxed/simple;
	bh=dIugdTT9QgcXdxHD3jeS/Zs4lEr4d6Ttv1SaVhZTko0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+uPfHvI42GOS6ETUt/iM/dCpbViuhAqJeahFsAvV/JWRx+E7P6uufOTd/4WY2o0JJX3AwOD8Pv9eUx3gmPdu4GWoqp5KvMpFCqu18U/UB9Xw9UuyqzMcxbugdmCQJEeTcUhkcDj1qr/o01zj+NEtdCroAgemzcrnO0z6kxLv0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwhnHbHQ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so104022866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 23:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762414310; x=1763019110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEdBdvOBBK4bNZmEPWCUQP+gmy8Y9dZYUZjqj6yp4LM=;
        b=bwhnHbHQ3T1/iycgZVpT6dPDnWRKpMv6u+3f0o15mpQwI6kYEPt4h8MvvzVKnNNO6v
         HuMG/UBquTAbkQ4+gk3+/otdfYJBLidONkRQ//P5U3q2XmImE8/XSi3mLofcZg6OVsvg
         Gfx1HO9ZnbdrVjOq1bvKyXLoTmyMwjYNF65Vk2ABVjDaEYonYUaszFGpSxAkpCkhEobD
         TyDqeXx/KzBrDJTuoCrIs9tppsH0vdr/DXKk4ovWLxBA21/OwWZKBrlw3wbEtL5awtom
         AfKWXiwvQKVD8vM7eFDHbCH59XoJrdAQeIEJWL1+MtjzRvjSNlxtdRzs65t+TvbeW3Ms
         GB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762414310; x=1763019110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEdBdvOBBK4bNZmEPWCUQP+gmy8Y9dZYUZjqj6yp4LM=;
        b=ZWJwCctr9N9WNXsiU7R2OXYbUdmBncVAcxR/LwYABBheRyDhB+3U2jfgvKpK50QWU1
         6scQXCSgDO17A0V8unAGa3jeIyZeiHhc9IVRs1yUOVDYgMF8Jeatv3xnI4ukqAGIoDgI
         XTrb9jswPWnsjJFhLXYcRh7dEutnmmYE8jyezXsvaFi5F70HpiZAWLs9lnfgzOEtAb7P
         +ic5W0acaxCuqAuypyWfuoYhdBK8JY96a1gqQQUNSLkteCdjF+W+0GyuTmZpgHVIkLMc
         8dIE5hSwFPiN+06aKSVRVf0YV6kaGQA0EghkdX5/fp0eRIf/MyHHBIWPxDT5ZlQ8Bodj
         Qxlg==
X-Forwarded-Encrypted: i=1; AJvYcCWdIfW8WEc9QDsgPOOyVAAVHYOeoucnJ5JGZnNArQSV+8wl7WQgZKUom83A3je4vwoFcj8q9278U1HVcvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhUSVdAF2J36q/CsOyREws5rp4/VshyvV+kZA+ixzoIK+EFkti
	6fcm+rWqrgNg05i9ynyUJMhKcYuwFRcg7FXPWbojqSTX8dGKvUq7KY2ZzGlzJsKd0o7VyMMdLIO
	tbLArcVWLjmJINQx6z7LqUAwAVFOXmuUXeAQQBfi6Cg==
X-Gm-Gg: ASbGncvS+HsWC67UjvfYT2NGW3TWw87zkLhQ9yr8CqQABEUl7HQcwL8MBsvMGYrraj9
	HRvAwMSEghhF/tu9UVDI4TJ3oZG2GbPN9x0twRAqhNgedaZigUG/4aVd+ZSarb++akRT6ov11PF
	kOxxJozqBj+x+q8mEyULDdb3h8xzhZyHWVzCZE4n+MW0LDzrog5bSBe18frH3qE5e+8SZpfuDrn
	eiWDOkPo6F/rU2xrXUpaNmDclzXEs1rDnqLAaW61sWXurc1P3dHUdBftz6z1A==
X-Google-Smtp-Source: AGHT+IFZLEAb0tF3f8VfzKhHMzw/x5BGPPybdTiV+cJui2Q89fodEN7NIvjc0u6+t6mEFUMfELjsjQ4RGu20sL/H5zY=
X-Received: by 2002:a17:907:da5:b0:b3e:babd:f263 with SMTP id
 a640c23a62f3a-b7265155cffmr658466966b.3.1762414309679; Wed, 05 Nov 2025
 23:31:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
 <20251104134033.344807-3-dolinux.peng@gmail.com> <CAEf4BzaQ9k=_JwpmkjnbN8o0XaA=EGcP-=CBxmXLc3kzh3aY3A@mail.gmail.com>
 <CAErzpmv8eBjuX-RO0nopuy8qMV7wzVxa2e+HteXfFodwbBoALg@mail.gmail.com> <CAEf4Bza+pHVSGTC2vcjF-DmsVxKq2Ksq321E9CJEGdyT8hQn3g@mail.gmail.com>
In-Reply-To: <CAEf4Bza+pHVSGTC2vcjF-DmsVxKq2Ksq321E9CJEGdyT8hQn3g@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Thu, 6 Nov 2025 15:31:37 +0800
X-Gm-Features: AWmQ_bmnn2sBxgxPGWOJs8QpeQkU48DxohVC4ZWNMlcCcA4QuKQbAQPgGyEjiu8
Message-ID: <CAErzpmvDk0Tvr9h772EDZk_4tRtLtAZv-r4yKCxEOM+_gc+G7A@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/7] libbpf: Add BTF permutation support for type reordering
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 2:29=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Nov 5, 2025 at 4:53=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.c=
om> wrote:
> >
> > On Wed, Nov 5, 2025 at 8:11=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Nov 4, 2025 at 5:40=E2=80=AFAM Donglin Peng <dolinux.peng@gma=
il.com> wrote:
> > > >
> > > > From: pengdonglin <pengdonglin@xiaomi.com>
> > > >
> > > > Introduce btf__permute() API to allow in-place rearrangement of BTF=
 types.
> > > > This function reorganizes BTF type order according to a provided ar=
ray of
> > > > type IDs, updating all type references to maintain consistency.
> > > >
> > > > The permutation process involves:
> > > > 1. Shuffling types into new order based on the provided ID mapping
> > > > 2. Remapping all type ID references to point to new locations
> > > > 3. Handling BTF extension data if provided via options
> > > >
> > > > This is particularly useful for optimizing type locality after BTF
> > > > deduplication or for meeting specific layout requirements in specia=
lized
> > > > use cases.
> > > >
> > > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > > Cc: Song Liu <song@kernel.org>
> > > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > > > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > > > ---
> > > >  tools/lib/bpf/btf.c      | 161 +++++++++++++++++++++++++++++++++++=
++++
> > > >  tools/lib/bpf/btf.h      |  34 +++++++++
> > > >  tools/lib/bpf/libbpf.map |   1 +
> > > >  3 files changed, 196 insertions(+)
> > > >
> > > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > > index 5e1c09b5dce8..3bc03f7fe31f 100644
> > > > --- a/tools/lib/bpf/btf.c
> > > > +++ b/tools/lib/bpf/btf.c
> > > > @@ -5830,3 +5830,164 @@ int btf__relocate(struct btf *btf, const st=
ruct btf *base_btf)
> > > >                 btf->owns_base =3D false;
> > > >         return libbpf_err(err);
> > > >  }
> > > > +
> > > > +struct btf_permute {
> > > > +       /* .BTF section to be permuted in-place */
> > > > +       struct btf *btf;
> > > > +       struct btf_ext *btf_ext;
> > > > +       /* Array of type IDs used for permutation. The array length=
 must equal
> > >
> > > /*
> > >  * Use this comment style
> > >  */
> >
> > Thanks.
> >
> > >
> > > > +        * the number of types in the BTF being permuted, excluding=
 the special
> > > > +        * void type at ID 0. For split BTF, the length corresponds=
 to the
> > > > +        * number of types added on top of the base BTF.
> > >
> > > many words, but what exactly ids[i] means is still not clear, actuall=
y...
> >
> > Thanks. I'll clarify the description. Is the following parameter
> > explanation acceptable?
> >
> > @param ids Array containing original type IDs (excluding VOID type ID
> > 0) in user-defined order.
> >                     The array size must match btf->nr_types, which
>
> Users don't have access to btf->nr_types, so referring to it in API
> description seems wrong.
>
> But also, this all will change if we allow removing types, because
> then array size might be smaller. But is it intentionally smaller or
> user made a mistake? Let's go with the ID map approach, please.

Thanks. I can implement both approaches, then we can assess their
pros and cons.

>
> > also excludes VOID type ID 0.
> >
> >
> > >
> > > > +        */
> > > > +       __u32 *ids;
> > > > +       /* Array of type IDs used to map from original type ID to a=
 new permuted
> > > > +        * type ID, its length equals to the above ids */
> > >
> > > wrong comment style
> >
> > Thanks, I will fix it in the next version.
> >
> > >
> > > > +       __u32 *map;
> > >
> > > "map" is a bit generic. What if we use s/ids/id_map/ and
> > > s/map/id_map_rev/ (for reverse)? I'd use "id_map" naming in the publi=
c
> > > API to make it clear that it's a mapping of IDs, not just some array
> > > of IDs.
> >
> > Thank you for the suggestion. While I agree that renaming 'map' to 'id_=
map'
> > makes sense for clarity, but 'ids' seems correct as it denotes a collec=
tion of
> > IDs, not a mapping structure.
> >
> > >
> > > > +};
> > > > +
> > > > +static int btf_permute_shuffle_types(struct btf_permute *p);
> > > > +static int btf_permute_remap_types(struct btf_permute *p);
> > > > +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx);
> > > > +
> > > > +int btf__permute(struct btf *btf, __u32 *ids, const struct btf_per=
mute_opts *opts)
> > >
> > > Let's require user to pass id_map_cnt in addition to id_map itself.
> > > It's easy to get this wrong (especially with that special VOID 0 type
> > > that has to be excluded, which I can't even make up my mind if that's
> > > a good idea or not), so having user explicitly say what they think is
> > > necessary for permutation is good.
> >
> > Thank you for your suggestion. However, I am concerned that introducing
> > an additional `id_map_cnt` parameter could increase complexity. Specifi=
cally,
> > if `id_map_cnt` is less than `btf->nr_types`, we might need to consider=
 whether
> > to resize the BTF. This could lead to missing types, potential ID remap=
ping
> > failures, or even require BTF re-deduplication if certain name strings =
are no
> > longer referenced by any types.
> >
>
> No, if the user provided a wrong id_map_cnt, it's an error and we
> return -EINVAL. No resizing.
>
> > >
> > > > +{
> > > > +       struct btf_permute p;
> > > > +       int i, err =3D 0;
> > > > +       __u32 *map =3D NULL;
> > > > +
> > > > +       if (!OPTS_VALID(opts, btf_permute_opts) || !ids)
> > >
>
> [...]
>
> > > > +               goto done;
> > > > +       }
> > > > +
> > > > +done:
> > > > +       free(map);
> > > > +       return libbpf_err(err);
> > > > +}
> > > > +
> > > > +/* Shuffle BTF types.
> > > > + *
> > > > + * Rearranges types according to the permutation map in p->ids. Th=
e p->map
> > > > + * array stores the mapping from original type IDs to new shuffled=
 IDs,
> > > > + * which is used in the next phase to update type references.
> > > > + *
> > > > + * Validates that all IDs in the permutation array are valid and u=
nique.
> > > > + */
> > > > +static int btf_permute_shuffle_types(struct btf_permute *p)
> > > > +{
> > > > +       struct btf *btf =3D p->btf;
> > > > +       const struct btf_type *t;
> > > > +       __u32 *new_offs =3D NULL, *map;
> > > > +       void *nt, *new_types =3D NULL;
> > > > +       int i, id, len, err;
> > > > +
> > > > +       new_offs =3D calloc(btf->nr_types, sizeof(*new_offs));
> > >
> > > we don't really need to allocate memory and maintain this, we can jus=
t
> > > shift types around and then do what btf_parse_type_sec() does -- just
> > > go over types one by one and calculate offsets, and update them
> > > in-place inside btf->type_offs
> >
> > Thank you for the suggestion. However, this approach is not viable beca=
use
> > the `btf__type_by_id()` function relies critically on the integrity of =
the
> > `btf->type_offs` data structure. Attempting to modify `type_offs` throu=
gh
> > in-place operations could corrupt memory and lead to segmentation fault=
s
> > due to invalid pointer dereferencing.
>
> Huh? By the time this API returns, we'll fix up type_offs, users will
> never notice. And to recalculate new type_offs we don't need
> type_offs. One of us is missing something important, what is it?

Thanks, however the bad news is that the btf__type_by_id is indeed called
within the API.

static int btf_permute_shuffle_types(struct btf_permute *p)
{
        struct btf *btf =3D p->btf;
        const struct btf_type *t;
        __u32 *new_offs =3D NULL, *ids_map;
        void *nt, *new_types =3D NULL;
        int i, id, len, err;

        new_offs =3D calloc(btf->nr_types, sizeof(*new_offs));
        new_types =3D calloc(btf->hdr->type_len, 1);
        ......
        nt =3D new_types;
       for (i =3D 0; i < btf->nr_types; i++) {
                id =3D p->ids[i];
                ......
                /* must be a valid type ID */
                t =3D btf__type_by_id(btf, id);  <<<<<<<<<<<<<
                ......
                len =3D btf_type_size(t);
                memcpy(nt, t, len);
                new_offs[i] =3D nt - new_types;
                *ids_map =3D btf->start_id + i;
                nt +=3D len;
        }
......
}

>
> [...]

