Return-Path: <linux-kernel+bounces-886552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CD7C35EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609F518C6C41
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DED53126A8;
	Wed,  5 Nov 2025 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wmx54f+P"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A429E3148A4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350537; cv=none; b=qqwtxEzgFw5DLMUCc3xy28u5QrSiV38Wr3JLuyQCdzlNLQJyw/CPpwps6RtoAmw0lShwmVR7FDasnQLji0vY3PFsZzJMzznXvftOJMO+q6Hgln2rkuwYU4Jrk8b44EhIRdrpBVVYu/M3iGQmyNqbB+LO9f+VjVLACmzeJSu/pdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350537; c=relaxed/simple;
	bh=5oI5qj5FAoT/zD4PITm/avrYSdsCmqjpO6F2XoPyDxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9n4KvJDK7TiUEfaZSkTPenOstoJsueuZdlo/DanQr6CT2PHCLhr3gM1fgKJqU2sMFI6mv1F+I+VAdi7ytRgSAM7KL+Pyi18Ek+W0LJWZuj5+EXbQFWv8u57yZUGozRWDFBgFmpHhQcjBev/73EFiVuh1cM6a9tocRs06uvwewk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wmx54f+P; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b71397df721so553421666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762350534; x=1762955334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6A5M4lHiwAqecEpYdy09Dd0pGpiHeylPQ1THRXjXvY=;
        b=Wmx54f+PTu++Npt1dHK/kS2g/3FhETHIqetcTtY9dkCcDI4SlJcLJfQq/l3fTff+ke
         GNZtS6cEw9C+F0McYtE2vpAhZeWk+oMNYfLwoqMjrsA32HJSBnW+C+hcLvF1V56ydpXQ
         5dUa13jwxvFma40vuGbN5PY9tvLdkfho0opZHiZhZLHRavRUicFn1JSmAJHPDkB4iFUS
         m0nbgX/XkRK2J1w4G/FOF+iazYswfD8PGwb1kofBzw8s4h1mrcWAgsnuBdLZJ/pDXCrn
         oVrNIG5I7eNmbN5A24nLhcDTTzGNixYArCB4KBAf+JcZkvHAxZdH28EvsmW/Dxbt0350
         91uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762350534; x=1762955334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6A5M4lHiwAqecEpYdy09Dd0pGpiHeylPQ1THRXjXvY=;
        b=MIMN503XSuAq/y4xUMcNlchY6v7b3NDMeRjSxYft78skJfhdkqtKPidoXmrv56254d
         9HRfbDf46tVxis9zg2Dmcc8q+bdVYS6K/R+uSYx4ppe7IXX8jE7ywrp5unyW+BF5jUyH
         Jpc2Q98TlSuZScXGbZvyaw5RPWH419Hm+3JaZf+YJT2Cw06pUgqvl+WRpsJzMV1PAuyP
         MTWmXZRHjxmeAXE+uhboFYtGz7DjbUuOV+rU0/5C/bET/Noyo3XlF2YaIQvvYiKPFhjB
         4b0faqxWJbwytd+PwWgdVtQPNE02TtHlcitRLFvvji+2Pso759YJypa1vnC3ziJNNxsa
         SdHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO77LP1uCi95+MLPrXvEO1SKpzKiQ9Cqu5AugH3K7BaCr5Fs8BZXmQFQkDwcO6j/sYT0jrIQOXK2wJnEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfHzTyu7TajnFleJdmkHpKbUTkLif3E1N0JYCddZwyvK2sVjQC
	8rbxC5Vy42EMK3KQ2SUh/n6cfN9B+uunBA0mY2tt9ZqHfS6+DL1u2f/0Vu6fnW6qcQpkZeTPP0q
	OauANZXXPwN4RmXRjTGVvtqsEEO+3b74=
X-Gm-Gg: ASbGnctvA22wpcTpqu4MjKwILvrDweFK4IWIKUgRmywgjbnUAMMdKi9aXlrvXFjFKJm
	dVRQ94YMztOeH1auw/IeKkXomhYDO8kRMBgEX2Z2oYbywhKZh5oSMznfISv27AqIIpn+0YGy7ch
	XsGcKn1XeD/RdigpqQQKSMaIv2SguVtlrzirIzusQK5zckNUlzicixAdhvkPQT4IfzwWmHQqjMP
	noYzs3SZYC1VTD/cDuGyIMdXgCk8s8Uuw9AKCH4XPVhuOXVEcakBfJ2/Lh8TDomaOmijcWp
X-Google-Smtp-Source: AGHT+IEIOCx5nbP23B6IgW+Zf8q2gjqPW5IHj6AM03AAs1xYsEA2yw1wTJNGJI3WTD6OsF2moJ8RHSebS8878U8L/Y4=
X-Received: by 2002:a17:907:d27:b0:b72:58b6:b263 with SMTP id
 a640c23a62f3a-b72656902a0mr343574366b.60.1762350533743; Wed, 05 Nov 2025
 05:48:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
 <20251104134033.344807-4-dolinux.peng@gmail.com> <CAEf4BzaxU1ea_cVRRD9EenTusDy54tuEpbFqoDQUZVf46zdawg@mail.gmail.com>
 <a2aa0996f076e976b8aef43c94658322150443b6.camel@gmail.com>
 <CAEf4Bzb73ZGjtbwbBDg9wEPtXkL5zXc3SRqfbeyuqNeiPGhyoA@mail.gmail.com> <7c77c74a761486c694eba763f9d0371e5c354d31.camel@gmail.com>
In-Reply-To: <7c77c74a761486c694eba763f9d0371e5c354d31.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 5 Nov 2025 21:48:42 +0800
X-Gm-Features: AWmQ_bl8iNYRoJAtiKbBAMBI0VEiK9JYPyC0kuOrdZYworiStDsxnQijZbZj20g
Message-ID: <CAErzpmtu7UuP9ttf1oQSuVh6f4BAkKsmfZBjj_+OHs9-oDUfjQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/7] libbpf: Optimize type lookup with binary
 search for sorted BTF
To: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 9:17=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2025-11-04 at 16:54 -0800, Andrii Nakryiko wrote:
> > On Tue, Nov 4, 2025 at 4:19=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:
> > >
> > > [...]
> > >
> > > > > @@ -897,44 +903,134 @@ int btf__resolve_type(const struct btf *bt=
f, __u32 type_id)
> > > > >         return type_id;
> > > > >  }
> > > > >
> > > > > -__s32 btf__find_by_name(const struct btf *btf, const char *type_=
name)
> > > > > +/*
> > > > > + * Find BTF types with matching names within the [left, right] i=
ndex range.
> > > > > + * On success, updates *left and *right to the boundaries of the=
 matching range
> > > > > + * and returns the leftmost matching index.
> > > > > + */
> > > > > +static __s32 btf_find_type_by_name_bsearch(const struct btf *btf=
, const char *name,
> > > > > +                                               __s32 *left, __s3=
2 *right)
> > > >
> > > > I thought we discussed this, why do you need "right"? Two binary
> > > > searches where one would do just fine.
> > >
> > > I think the idea is that there would be less strcmp's if there is a
> > > long sequence of items with identical names.
> >
> > Sure, it's a tradeoff. But how long is the set of duplicate name
> > entries we expect in kernel BTF? Additional O(logN) over 70K+ types
> > with high likelihood will take more comparisons.
>
> $ bpftool btf dump file vmlinux | grep '^\[' | awk '{print $3}' | sort | =
uniq -c | sort -k1nr | head
>   51737 '(anon)'
>     277 'bpf_kfunc'
>       4 'long
>       3 'perf_aux_event'
>       3 'workspace'
>       2 'ata_acpi_gtm'
>       2 'avc_cache_stats'
>       2 'bh_accounting'
>       2 'bp_cpuinfo'
>       2 'bpf_fastcall'
>
> 'bpf_kfunc' is probably for decl_tags.
> So I agree with you regarding the second binary search, it is not
> necessary.  But skipping all anonymous types (and thus having to
> maintain nr_sorted_types) might be useful, on each search two
> iterations would be wasted to skip those.

Thank you. After removing the redundant iterations, performance increased
significantly compared with two iterations.

Test Case: Locate all 58,719 named types in vmlinux BTF
Methodology:
./vmtest.sh -- ./test_progs -t btf_permute/perf -v

Two iterations:
| Condition          | Lookup Time | Improvement |
|--------------------|-------------|-------------|
| Unsorted (Linear)  | 17,282 ms   | Baseline    |
| Sorted (Binary)    | 19 ms       | 909x faster |

One iteration:
Results:
| Condition          | Lookup Time | Improvement |
|--------------------|-------------|-------------|
| Unsorted (Linear)  | 17,619 ms   | Baseline    |
| Sorted (Binary)    | 10 ms       | 1762x faster |

Here is the code implementation with a single iteration approach.
I believe this scenario differs from find_linfo because we cannot
determine in advance whether the specified type name will be found.
Please correct me if I've misunderstood anything, and I welcome any
guidance on this matter.

static __s32 btf_find_type_by_name_bsearch(const struct btf *btf,
const char *name,
                                                __s32 start_id)
{
        const struct btf_type *t;
        const char *tname;
        __s32 l, r, m, lmost =3D -ENOENT;
        int ret;

        /* found the leftmost btf_type that matches */
        l =3D start_id;
        r =3D btf__type_cnt(btf) - 1;
        while (l <=3D r) {
                m =3D l + (r - l) / 2;
                t =3D btf_type_by_id(btf, m);
                if (!t->name_off) {
                        ret =3D 1;
                } else {
                        tname =3D btf__str_by_offset(btf, t->name_off);
                        ret =3D !tname ? 1 : strcmp(tname, name);
                }
                if (ret < 0) {
                        l =3D m + 1;
                } else {
                        if (ret =3D=3D 0)
                                lmost =3D m;
                        r =3D m - 1;
                }
        }

        return lmost;
}

static __s32 btf_find_type_by_name_kind(const struct btf *btf, int start_id=
,
                                   const char *type_name, __u32 kind)
{
        const struct btf_type *t;
        const char *tname;
        int err =3D -ENOENT;
        __u32 total;

        if (!btf)
                goto out;

        if (start_id < btf->start_id) {
                err =3D btf_find_type_by_name_kind(btf->base_btf, start_id,
                                                 type_name, kind);
                if (err =3D=3D -ENOENT)
                        start_id =3D btf->start_id;
        }

        if (err =3D=3D -ENOENT) {
                if (btf_check_sorted((struct btf *)btf)) {
                        /* binary search */
                        bool skip_first;
                        int ret;

                        /* return the leftmost with maching names */
                        ret =3D btf_find_type_by_name_bsearch(btf,
type_name, start_id);
                        if (ret < 0)
                                goto out;
                        /* skip kind checking */
                        if (kind =3D=3D -1)
                                return ret;
                        total =3D btf__type_cnt(btf);
                        skip_first =3D true;
                        do {
                                t =3D btf_type_by_id(btf, ret);
                                if (btf_kind(t) !=3D kind) {
                                        if (skip_first) {
                                                skip_first =3D false;
                                                continue;
                                        }
                                } else if (skip_first) {
                                        return ret;
                                }
                                if (!t->name_off)
                                        break;
                                tname =3D btf__str_by_offset(btf, t->name_o=
ff);
                                if (tname && !strcmp(tname, type_name))
                                        return ret;
                                else
                                        break;
                        } while (++ret < total);
                } else {
                        /* linear search */
...
                }
        }

out:
        return err;
}

