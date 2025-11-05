Return-Path: <linux-kernel+bounces-886520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E210DC35CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D92567411
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C7131D367;
	Wed,  5 Nov 2025 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBbMX4p4"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CB030B538
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762348990; cv=none; b=fN8hpVo5oyXCnLj9VBz5gC06wbF6q6IX8gw9LO1FlTgey44ntomEpUP5bHPhGwXrIR19oXTR9C5OyXxRudiFq7BMzbJE78Dxh1t8R6xrzrN0BaYXFTlyy217YJiqsC4VT8bnz6BYExR/HRK7PnLEsMG38V8GLUPDx9uiB7NahtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762348990; c=relaxed/simple;
	bh=CoMbWSj/vo5HjtiTi+kug+L+kepzqsMVzgo83GiLEC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n8Vv1LvH49zCPX+eBor9QK8Ym8dACyPnB0R3jkE7peyrytZBdono1MIFGJgOYlVZp/2WIEP8BGETv7g3Kay/rebCGCMwO6cFkqNjJpzFQ5u8uV+9oDo27VQP0hqlz/KawEMwUEM/cfRHAlxBpacntGYymIi1p1zmxQz5pVkA6g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBbMX4p4; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso11436019a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762348986; x=1762953786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9B8whzP9ipdDMHhFec8IRfTS6Px+ykdqpOPFvCS5A8=;
        b=DBbMX4p4nYIYKzfKRksZdsdTrpErPY6ko+DDSw/21aVQY9T4WXhyRX1koUthkuuLnI
         saU7I+ic2YHluHnbV1D9NlF7RzL8N2bFAGDXWD9jkOo3LJ8yLypEWSamPT6+7ixKcA45
         /fgLjEwvqVAr9VrJeEKqf8LSfu9US9j3wtBW+2BwYvNdqlSkCaMSTV8XikRe3ZUW4tvB
         vMlmz3OllXRlal2y01GdShYznas00YHq5wR5mT4nTwVDGMf3k2vEJ6Vmn8aUiGpX3/S6
         4vmQlIhJc1ewHt47fNlAY73MG4nrk2oecHI9xQ1QQtfvpBJauyX96dHrAsXl26kRAjyi
         D4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762348986; x=1762953786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9B8whzP9ipdDMHhFec8IRfTS6Px+ykdqpOPFvCS5A8=;
        b=Qjl3vWtiYsR5Xu1Zio5/wUuzLJj+mxMndOrWWDeiO2NwXI9aYBDAir/6EiEQ/0jK32
         LJuFcSlrwqFKNCO+l8E+zZub0xDFV5Vq6JKDw/6L+mwY3I5I1QzKQlB1yAgBdR/mruFq
         qMr2QTZGWRIr6Y7brw8JLQXy4fwBbebpRqZJu4877X/En4qi9bRqbPTYHYjlfuMI5/Po
         G0jspRTUMHQkBEPN8OyrFiLfWcEa0L711JKv7l/qXGRtzOI9HewaqXJusrT1uJ0WCpT+
         CuFUhvbaOU9bEGQ8cK4LlhLLUzUNVqag6C2gSLs47GxkIUPAIWxSjauiwU8EuR/0p/Zg
         oiNg==
X-Forwarded-Encrypted: i=1; AJvYcCVsyWDlYAVm61W9CFL3+BngO+77OmowX6NzcAGmHZANr9Kau4r6Rejird/qlxGN0LF5oGyOzmF35Ez5qG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuyl3jBWk+rKsiySL0HBaynGf5Verx6ymrLhQqVPDD/k9C5DJ3
	AL98paQeLp/v9HfnkaRdG0bClMjvdfyPSsWZr5RPO490UlLrlFbcVoiqfA4DHgZ9g8LwZbsqIX3
	pr7mUnkawXd6bWkSddXkIkov/LqC76rw=
X-Gm-Gg: ASbGncsN3U9EMh4XM0RgGtn8NSDQQQYRoUS7KJ2KkvKisjVdOERJN4vY8B6LuDPAFt/
	w+ksDT8k0TIVkvcDCRJZZs3XfbnCydRgsrBuWcXke5M9Abeu5Oe5rIfQIPYeFh9lJMlz6MVFc+m
	DJRXLWMtPp/vpoCsgWuVsqUhK7fgjbWvHYq63YpSp1NuoxWng3uJIKFUJAvts6xMiITANocOyB/
	IJEi+CcP+k1Pq+eskudhcetx1EzqrpvDabmZEpl58iGCKUHUv2859qp8yigwQ==
X-Google-Smtp-Source: AGHT+IG7CiMn1pVBwCimhQLiSNsKrIR7ykAgVoJCZw98eXg5nYh2eDMcLV7Tpk/mhkz+H4kL/dcU+9JlqS+z8L8UDus=
X-Received: by 2002:a17:906:9fc8:b0:b6d:a7ad:2fda with SMTP id
 a640c23a62f3a-b726515cf00mr375891566b.12.1762348986473; Wed, 05 Nov 2025
 05:23:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
 <20251104134033.344807-6-dolinux.peng@gmail.com> <CAADnVQKxqScrBhTKOXcwSL_mVXE36YQ_yQX7qwg8C3X1ZnXHnA@mail.gmail.com>
In-Reply-To: <CAADnVQKxqScrBhTKOXcwSL_mVXE36YQ_yQX7qwg8C3X1ZnXHnA@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 5 Nov 2025 21:22:54 +0800
X-Gm-Features: AWmQ_bnGbmFjJ6q-_y06ft1mm_glR8Lqlb0wd4xHRSwLEGd7iR_eZWmMQUagz04
Message-ID: <CAErzpmt0t3=Bgn0HJ6C9DH9-=MfuYqyhpvz1NvCF81MsbTshZA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 5/7] btf: Optimize type lookup with binary search
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 1:15=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 4, 2025 at 5:41=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.c=
om> wrote:
> >
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > Improve btf_find_by_name_kind() performance by adding binary search
> > support for sorted types. Falls back to linear search for compatibility=
.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Song Liu <song@kernel.org>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > ---
> >  kernel/bpf/btf.c | 111 ++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 101 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 0de8fc8a0e0b..da35d8636b9b 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -259,6 +259,7 @@ struct btf {
> >         void *nohdr_data;
> >         struct btf_header hdr;
> >         u32 nr_types; /* includes VOID for base BTF */
> > +       u32 nr_sorted_types; /* exclude VOID for base BTF */
> >         u32 types_size;
> >         u32 data_size;
> >         refcount_t refcnt;
> > @@ -494,6 +495,11 @@ static bool btf_type_is_modifier(const struct btf_=
type *t)
> >         return false;
> >  }
> >
> > +static int btf_start_id(const struct btf *btf)
> > +{
> > +       return btf->start_id + (btf->base_btf ? 0 : 1);
> > +}
> > +
> >  bool btf_type_is_void(const struct btf_type *t)
> >  {
> >         return t =3D=3D &btf_void;
> > @@ -544,24 +550,109 @@ u32 btf_nr_types(const struct btf *btf)
> >         return total;
> >  }
> >
> > -s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 =
kind)
> > +/* Find BTF types with matching names within the [left, right] index r=
ange.
> > + * On success, updates *left and *right to the boundaries of the match=
ing range
> > + * and returns the leftmost matching index.
> > + */
> > +static s32 btf_find_by_name_kind_bsearch(const struct btf *btf, const =
char *name,
> > +                                               s32 *left, s32 *right)
> >  {
> >         const struct btf_type *t;
> >         const char *tname;
> > -       u32 i, total;
> > +       s32 l, r, m, lmost, rmost;
> > +       int ret;
> >
> > -       total =3D btf_nr_types(btf);
> > -       for (i =3D 1; i < total; i++) {
> > -               t =3D btf_type_by_id(btf, i);
> > -               if (BTF_INFO_KIND(t->info) !=3D kind)
> > -                       continue;
> > +       /* found the leftmost btf_type that matches */
> > +       l =3D *left;
> > +       r =3D *right;
> > +       lmost =3D -1;
> > +       while (l <=3D r) {
> > +               m =3D l + (r - l) / 2;
> > +               t =3D btf_type_by_id(btf, m);
> > +               tname =3D btf_name_by_offset(btf, t->name_off);
> > +               ret =3D strcmp(tname, name);
> > +               if (ret < 0) {
> > +                       l =3D m + 1;
> > +               } else {
> > +                       if (ret =3D=3D 0)
> > +                               lmost =3D m;
> > +                       r =3D m - 1;
> > +               }
> > +       }
> >
> > +       if (lmost =3D=3D -1)
> > +               return -ENOENT;
> > +
> > +       /* found the rightmost btf_type that matches */
> > +       l =3D lmost;
> > +       r =3D *right;
> > +       rmost =3D -1;
> > +       while (l <=3D r) {
> > +               m =3D l + (r - l) / 2;
> > +               t =3D btf_type_by_id(btf, m);
> >                 tname =3D btf_name_by_offset(btf, t->name_off);
> > -               if (!strcmp(tname, name))
> > -                       return i;
> > +               ret =3D strcmp(tname, name);
> > +               if (ret <=3D 0) {
> > +                       if (ret =3D=3D 0)
> > +                               rmost =3D m;
> > +                       l =3D m + 1;
> > +               } else {
> > +                       r =3D m - 1;
> > +               }
> >         }
> >
> > -       return -ENOENT;
> > +       *left =3D lmost;
> > +       *right =3D rmost;
> > +       return lmost;
> > +}
> > +
> > +s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 =
kind)
> > +{
> > +       const struct btf *base_btf =3D btf_base_btf(btf);;
> > +       const struct btf_type *t;
> > +       const char *tname;
> > +       int err =3D -ENOENT;
> > +
> > +       if (base_btf)
> > +               err =3D btf_find_by_name_kind(base_btf, name, kind);
> > +
> > +       if (err =3D=3D -ENOENT) {
>
> Please avoid the needless indent.

Thanks. I will fix it.

>
> > +               if (btf->nr_sorted_types) {
>
> looks buggy,
> since you init it to btf->nr_sorted_types =3D BTF_NEED_SORT_CHECK;
>
> Also AI is right. Init the field in the same patch.

Thanks. I will fix it.

>
> pw-bot: cr

