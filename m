Return-Path: <linux-kernel+bounces-866741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BD5C0089A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 528EF50612C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF6F30CDB6;
	Thu, 23 Oct 2025 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQSKs/MK"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB43630CD89
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215730; cv=none; b=LsEQU06IQ2bHDOZgUX+8RXo8nEXYWvVweNJ+0rOkBSdfQpAS0NLCXEAfQbhZKX0/zGbhheAW8KvufVRKyi+yXKYVJMlp2TSLrg2thW6j97XviGrR2BTlIlw/MEBJmsFMZKZaykqj1JjRPf3QyCU0ADvU/JkONLzH9GGMfYIkHsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215730; c=relaxed/simple;
	bh=2OvdrGqTK5W015YbOl6ecdcmtrJ6uIZZ+8FUcPCO3yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOmRkeBaxxq4y/sHsI1AXW0DcUl7rGaKPRBswQOjFwUHeVNgzfw9QbO+Joo8PcDdianm4tIScbYn36DHZQgcgC9M5ZCiWouX0Qq5e8UF8w/d10wMvLAOQGYIIK3Q5wkvT8cFlgxyKZvWNxLC02TX1n9wodMP2tolp1o+UtAq/xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQSKs/MK; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c31c20b64so1184910a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761215727; x=1761820527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/NyBsDyPqxAs09AD04tT0GajFzhKoMJsLbCSMeMmfU=;
        b=MQSKs/MK2p4UQnJwDsvFiGuux+hMnNJFx339pGQ8E+DGTEeBsMb2pNFNhhKNydqguz
         gO647RzfgQw2u62X8N004Tw0uhWUBNfmxnJ5daQH2A8TjM3iW5rlOhK8MZVR0nfJGRWa
         x1I/eSJAx7TwwpEMjomJEMSJp8NyNtKs4fvzMcx9Fprp7/2O2a8JamXKIZnnbjkQjQs2
         xjr4isSvR0R8G3o6QJ5VQGV0Y8+3PAIAMMORU1QxIZQiPto74ucWgnuKSPH0m0fNa5Ts
         F6sPLgapPOyhgCEnVBYjN0rmL4z+8OYd0mQ0RgM+VZACNiw3O+gzOIj8TZ/3m6Shm8nT
         Jkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215727; x=1761820527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/NyBsDyPqxAs09AD04tT0GajFzhKoMJsLbCSMeMmfU=;
        b=airavYxdN9uG8a0b2DC34UkXReaVod6NN/R/+i6KIyfqN0BGfKM6XOcdOmOPBQvXr3
         Fq0qt84BVmeASZNuclTvI9SyKPCiSQ+bgxNZ/GXUASwKTnpOGu+4Oypir0ZAsK1DWYFR
         SZgV9iIzKZmPzFL5UsYOymWtDijznrsP50m94FX2ppqJWYOA3yqXWOEsA2mm8vHLNkvK
         3xxELgR+MxGtkKGNS1Pm65OUm7howUYSmnuv2e65gjE9o6s1bPcDlmUr95jdWkN6gyzy
         YFdP/YNz2VDaXO3lB8nA2Jc15ppRGddC7zBGXKpchSb4Wp6S4p8IottbaWuvZ3bbsUlV
         27nw==
X-Gm-Message-State: AOJu0YwfoG0Rf1vVhn+XP+j6ibKwLXAHXkcss3/frN3oipgtjN1DKvQr
	ibewR2O1S1ltKp1u1X8KbK9gFuohWnH6nSsP85in2ubKAs+lyoi3kt3PJpa0gUOnA9h9AVNnfnQ
	86r/JDDtygux0mt3mWV/3OMt8yE7dsYk=
X-Gm-Gg: ASbGncte3DC0MP/o+1RiYmp4VP22CE/fRwHYhB4h+Bo+qdmF/sIr8FEJnT/r5cYR0An
	T+P7nIzNkM6aznDk13t9kdl6BFSqW0Ybo1wQTE4B8iiT39ua8VEXbzkaQwBMsLDWnx2XNFN8aM8
	2qTx7H9tIBTHfwYq1yIULT/BEpl6JVwbCCs5OWf82eY1pJFHGrx/wifdd/iI0Eh7iXNxNqo8YDG
	oA5xxMOEE/QQNWKHfftsdMbwOeCCVMgsW7J/Z/guEofag5WFIiq42bMrWgH864c0swVS4t2OBs+
	nkCLDHg=
X-Google-Smtp-Source: AGHT+IEJmrbFzD+rzvgNDjg2zEfsJzdSKfdpwtiErnDLZepRFN7K5+TUfy4JVtg5vUbQrfyWtWxnTDWKkviGHu+fz0w=
X-Received: by 2002:a17:907:c1c:b0:b43:5c22:7e62 with SMTP id
 a640c23a62f3a-b6475128cb3mr2821287066b.50.1761215726737; Thu, 23 Oct 2025
 03:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-3-dolinux.peng@gmail.com> <174642a334760af39a5e7bacdd8b977b392a82c7.camel@gmail.com>
 <CAErzpmusSgOaROhEO25fKenvxQJU1oSPKKzUA4h67ptdQxWM7A@mail.gmail.com> <7651ac9cc74e135f04ecfee8660bea0a0d3883ab.camel@gmail.com>
In-Reply-To: <7651ac9cc74e135f04ecfee8660bea0a0d3883ab.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Thu, 23 Oct 2025 18:35:13 +0800
X-Gm-Features: AS18NWC2o8PUyH4u5SJ09KqPj_TFtkt5BxK4Lg6Pc77PCzynhAuS--UvvdPyMCA
Message-ID: <CAErzpmtWLLYuFk3npTiOgGOKcEcH1QUGGEHLvPncVT+z261C1A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/5] btf: sort BTF types by kind and name to enable
 binary search
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 4:50=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-10-22 at 11:02 +0800, Donglin Peng wrote:
> > On Wed, Oct 22, 2025 at 2:59=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:
> > > > This patch implements sorting of BTF types by their kind and name,
> > > > enabling the use of binary search for type lookups.
> > > >
> > > > To share logic between kernel and libbpf, a new btf_sort.c file is
> > > > introduced containing common sorting functionality.
> > > >
> > > > The sorting is performed during btf__dedup() when the new
> > > > sort_by_kind_name option in btf_dedup_opts is enabled.
> > >
> > > Do we really need this option?  Dedup is free to rearrange btf types
> > > anyway, so why not sort always?  Is execution time a concern?
> >
> > The issue is that sorting changes the layout of BTF. Many existing self=
tests
> > rely on the current, non-sorted order for their validation checks. Intr=
oducing
> > this as an optional feature first allows us to run it without immediate=
ly
> > breaking the tests, giving us time to fix them incrementally.
>
> How many tests are we talking about?
> The option is an API and it stays with us forever.
> If the only justification for its existence is to avoid tests
> modification, I don't think that's enough.

I get your point, thanks. I wonder what others think?

>
> > >
> > > > For vmlinux and kernel module BTF, btf_check_sorted() verifies
> > > > whether the types are sorted and binary search can be used.
> > >
> > > [...]
> > >
> > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > index c414cf37e1bd..11b05f4eb07d 100644
> > > > --- a/kernel/bpf/btf.c
> > > > +++ b/kernel/bpf/btf.c
>
> [...]
>
> > > > +s32 btf_find_by_name_kind(const struct btf *btf, const char *name,=
 u8 kind)
> > > > +{
> > > > +     return find_btf_by_name_kind(btf, 1, name, kind);
> > >                                          ^^^
> > >                 nit: this will make it impossible to find "void" w/o =
a special case
> > >                      in the find_btf_by_name_kind(), why not start fr=
om 0?
> >
> > Thanks. I referred to btf__find_by_name_kind in libbpf. In
> > btf_find_by_name_kind,
> > there is a special check for "void". Consequently, I've added a
> > similar special check
> > for "void" in find_btf_by_name_kind as well.
>
> Yes, I see the special case in the find_btf_by_name_kind.
> But wouldn't starting from 0 here avoid the need for special case?

The start_id parameter here serves the same purpose as the one in
libbpf's btf_find_by_name_kind. However, its implementation in
find_btf_by_name_kind was incorrect. I will fix this in the next version.

__s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type_na=
me,
__u32 kind)
{
return btf_find_by_name_kind(btf, btf->start_id, type_name, kind);
}

__s32 btf__find_by_name_kind(const struct btf *btf, const char *type_name,
     __u32 kind)
{
return btf_find_by_name_kind(btf, 1, type_name, kind);
}

static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
   const char *type_name, __u32 kind)
{
__u32 i, nr_types =3D btf__type_cnt(btf);

if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void"))
return 0;

for (i =3D start_id; i < nr_types; i++) {
const struct btf_type *t =3D btf__type_by_id(btf, i);
const char *name;

if (btf_kind(t) !=3D kind)
continue;
name =3D btf__name_by_offset(btf, t->name_off);
if (name && !strcmp(type_name, name))
return i;
}

return libbpf_err(-ENOENT);

}

>
> [...]
>
> > > > diff --git a/tools/lib/bpf/btf_sort.c b/tools/lib/bpf/btf_sort.c
> > > > new file mode 100644
> > > > index 000000000000..2ad4a56f1c08
> > > > --- /dev/null
> > > > +++ b/tools/lib/bpf/btf_sort.c
> > >
> > > [...]
> > >
> > > > +/*
> > > > + * Sort BTF types by kind and name in ascending order, placing nam=
ed types
> > > > + * before anonymous ones.
> > > > + */
> > > > +int btf_compare_type_kinds_names(const void *a, const void *b, voi=
d *priv)
> > > > +{
> > > > +     struct btf *btf =3D (struct btf *)priv;
> > > > +     struct btf_type *ta =3D btf_type_by_id(btf, *(__u32 *)a);
> > > > +     struct btf_type *tb =3D btf_type_by_id(btf, *(__u32 *)b);
> > > > +     const char *na, *nb;
> > > > +     int ka, kb;
> > > > +
> > > > +     /* ta w/o name is greater than tb */
> > > > +     if (!ta->name_off && tb->name_off)
> > > > +             return 1;
> > > > +     /* tb w/o name is smaller than ta */
> > > > +     if (ta->name_off && !tb->name_off)
> > > > +             return -1;
> > > > +
> > > > +     ka =3D btf_kind(ta);
> > > > +     kb =3D btf_kind(tb);
> > > > +     na =3D btf__str_by_offset(btf, ta->name_off);
> > > > +     nb =3D btf__str_by_offset(btf, tb->name_off);
> > > > +
> > > > +     return cmp_btf_kind_name(ka, na, kb, nb);
> > >
> > > If both types are anonymous and have the same kind, this will lead to
> > > strcmp(NULL, NULL). On kernel side that would lead to null pointer
> > > dereference.
> >
> > Thanks, I've confirmed that for anonymous types, name_off is 0,
> > so btf__str_by_offset returns a pointer to btf->strs_data (which
> > contains a '\0' at index 0) rather than NULL. However, when name_off
> > is invalid, btf__str_by_offset does return NULL. Using str_is_empty
> > will correctly handle both scenarios. Unnamed types of the same kind
> > shall be considered equal. I will fix it in the next version.
>
> I see, thank you for explaining.
> Checking the usage of kernel/bpf/btf.c:btf_name_valid_identifier(),
> it looks like kernel validates name_off for all types.
> So, your implementation should be fine.
>
> [...]

