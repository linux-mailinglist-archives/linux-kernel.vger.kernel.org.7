Return-Path: <linux-kernel+bounces-890905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A189EC41594
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 19:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6C61885E18
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 18:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3826E21770A;
	Fri,  7 Nov 2025 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNnhzg8C"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9F6337106
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541665; cv=none; b=q5xxdZOl4lsbm2F7d29ITgYp1HNQoT13co9O/e90Zg2e7VCavvLzqVslXuckteHPsQckBHuipltXAEpjvFDWfa7+pUKu7EHDObsCRhXBl+esCx7BeeBghfgsIw5+jQ7kuWfr86NZDiVKB6GmZwn0F0vJrpYqqtwAa064L1kqSGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541665; c=relaxed/simple;
	bh=QQ3G1VWedHNxdvNK68+FDDzVdBQJK2d8klekLNmQKJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EK8hYhIsADtUMguKEMCFyJKwWkB/31JyfIHMmmOa28lgew9d7dw0IvBMzRHEeFCbKiBGRjYBsdyLDlSxebIHvuPWThBQ1CvaKC+olrV9wM5+tUJTPPsWulzFNYIFY/15V4h+6k9kuIl2cBea9pXgYktwe8LTnclaAwF7CvfGegs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNnhzg8C; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4711b95226dso10804575e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 10:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541662; x=1763146462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kaxkngmgRdxi8oV+NfeXjpTAJmQlpGAXOb0Xk9M0lg=;
        b=nNnhzg8C5wohIjqZEK+GM1nr4/bOg+5nFyv8J34DyObOoShv6fQ+ojgtvYRTqfEfVr
         NbmafZTOyV+W3ij4bSr+Jc8+UAIazi5slpdzQkJsrDIH+Prn2v/ax5JCJXEoqVgXK39a
         LGOnTHHUNKrYS4h1DmmRQKeN/Oc7pNsBZxOs5tm6a7q3ufspVoXz0FN0QIDgW/Ehe43x
         jsPnvk8Fk6P8IiueTFwfisyitSU0iV9AsLMkISvCQNGDw+JNXFgh7dF/fdANtDeFEtmA
         yaDTCSzBdLJNfT3WDJMMS7xG6fFge6qEkAzN9VhOba56/H+yIaQqRoNXTelH2OoZRpYE
         6d8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541662; x=1763146462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3kaxkngmgRdxi8oV+NfeXjpTAJmQlpGAXOb0Xk9M0lg=;
        b=eUq+fTm4sRX0p9vA8ePV8t5yaL4qllllrnEzRMdm0NreAht9ZahwAEPbMM0jPWLEm1
         0IzzXccpHAZC263eex9Q/lmQSs/m7W4y0bf/wDgawBOzmGtDvWPQtOSaMoFN3Xru4Cg1
         bPkFoQUahwunaxc7HYNKgq1B0adJu4IXyilHbmwZrWEdYQmVyfwc4onTjYyKlk5R3EcO
         zNWuIOC8IlX7MVDHEdO4utBOWpHSkZW+5TVRGKQaYv7JkdOM7z3XtfBDK/B/ROc91Tbf
         QhNu2LtcJCF9/029UwTvz9q03RxLiNfVNt69aLjZUMvQXLAr+lknbgwtVTeRxG21aL3P
         XQsw==
X-Forwarded-Encrypted: i=1; AJvYcCU0qbcTeGlpmCrEfPj0Gglgt/Fc51Xy6mHw3SKqBnhnHE5IGo4nTFBaTABmZjuGYJTjb4JKK8b3zcssWxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkkmHXpFzShTFYLOUI2nMHUvHTLaPHtzHyoHxHiENQlMuOggi4
	hSDxUwNvxsRcLV3k8+rt6Nj1bKMqLybk9av5t0Cttfo2a1tgtcxu24Sgig+NqMU4zgdwAr3zE3H
	5FOp+FZiX0lQ8H8rFHs/l1ZwEmkODPCg=
X-Gm-Gg: ASbGncvvforEb+k3LWKJzgCSH9h1JTXol0MX5Q4+K2lBbdeFMR1C+IXTt+ncDo14+6Y
	ObfFYYgf7kTgv6w7Fi1hfF3FXwAs+Tve3RF/Il365oh/Tng2HR8WXWD+u5FcIBLZcP2gaq9nXK2
	IgvRn3llX0Om2+uqM39ri3gQwKAWeIHUPIBXnLod1nEJwMU/X67QhDsdUMmi2ZIKmwhoGOyh2Dc
	z1Bmd4qwWlKBKBOvMbhg+/BaDJU1GhmpaXopvvQJEd2EwqSBN6cBscfZOJ+vyvQvltm/65tVJSx
	8U3WGtTidfIskPENWYTs4Yk8d8bD
X-Google-Smtp-Source: AGHT+IHSNHYbxMDdDdySZV2TSNAyHltwDO8S9QyDEBq/JSKnXLpJA29lGeID2Oj/NVR984xYZSVGAHurEl7ly4eTA68=
X-Received: by 2002:a05:600c:1f14:b0:471:3b6:f2d with SMTP id
 5b1f17b1804b1-477732a2228mr681535e9.38.1762541661724; Fri, 07 Nov 2025
 10:54:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106131956.1222864-7-dolinux.peng@gmail.com>
 <d57f3e256038e115f7d82b4e6b26d8da80d3c8d8afb4f0c627e0b435dee7eaf6@mail.kernel.org>
 <CAErzpmtRYnSpLuO=oM7GgW0Sss2+kQ2cJsZiDmZmz04fD0Noyg@mail.gmail.com> <74d4c8e40e61dad369607ecd8b98f58a515479f0.camel@gmail.com>
In-Reply-To: <74d4c8e40e61dad369607ecd8b98f58a515479f0.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Nov 2025 10:54:10 -0800
X-Gm-Features: AWmQ_bnINvTVFWzZHW7k1lOai2Irrj3m0sroF-RQjXYc44E4rSQDkftGWjCA36s
Message-ID: <CAADnVQLkS0o+fzh8SckPpdSQ+YZgbBBwsCgeqHk_76pZ+cchXQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] btf: Add lazy sorting validation for binary search
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, bot+bpf-ci@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, zhangxiaoqin@xiaomi.com, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 10:19=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2025-11-07 at 15:08 +0800, Donglin Peng wrote:
> > On Thu, Nov 6, 2025 at 9:47=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
> > >
> > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > index 66cb739a0..33c327d3c 100644
> > > > --- a/kernel/bpf/btf.c
> > > > +++ b/kernel/bpf/btf.c
> > > > @@ -552,6 +552,70 @@ u32 btf_nr_types(const struct btf *btf)
> > > >       return total;
> > > >  }
> > > >
> > > > +/* Verifies that BTF types are sorted in ascending order
> > > > according to their
> > > > + * names, with named types appearing before anonymous types. If
> > > > the ordering
> > > > + * is correct, counts the number of named types and updates the
> > > > BTF object's
> > > > + * nr_sorted_types field.
> > > > + *
> > > > + * Return: true if types are properly sorted, false otherwise
> > > > + */
> > > > +static bool btf_check_sorted(struct btf *btf)
> > > > +{
> > > > +     const struct btf_type *t;
> > > > +     int i, n, k =3D 0, nr_sorted_types;
> > > > +
> > > > +     if (likely(btf->nr_sorted_types !=3D BTF_NEED_SORT_CHECK))
> > > > +             goto out;
> > > > +     btf->nr_sorted_types =3D 0;
> > >                             ^
> > >
> > > Can multiple threads race when writing to btf->nr_sorted_types
> > > here?
> > > Looking at btf_find_by_name_kind()->btf_check_sorted(), I see that
> > > btf_find_by_name_kind() receives a const pointer but casts away the
> > > const
> > > to call btf_check_sorted(). The function bpf_find_btf_id() calls
> > > btf_find_by_name_kind() without holding any locks (line 737), and
> > > later
> > > explicitly unlocks before calling it again (lines 756-757).
> > >
> > > This means multiple threads can concurrently enter
> > > btf_check_sorted() and
> > > write to btf->nr_sorted_types. While the validation logic is
> > > idempotent
> > > and all threads would compute the same value, the concurrent writes
> > > to the
> > > same memory location without synchronization could trigger KCSAN
> > > warnings.
> > >
> > > Should this use atomic operations, or should the validation be
> > > performed
> > > under a lock during BTF initialization before the BTF becomes
> > > visible to
> > > multiple threads?
> >
> > Hi, is it necessary to address this issue?
> > For example, by using atomic_try_cmpxchg or WRITE/READ_ONCE? Using
> > atomic_try_cmpxchg can prevent race conditions on writes but requires
> > an atomic
> > variable, while WRITE_ONCE/READ_ONCE can avoid KCSAN warnings. Since
> > the race condition is unlikely to cause critical issues, I suggest
> > using
> > WRITE_ONCE/READ_ONCE.
>
> Probably use WRITE_ONCE/READ_ONCE?
>
> > > > +
> > > > +     if (btf->nr_types < 2)
> > > > +             goto out;
> > > > +
> > > > +     nr_sorted_types =3D 0;
> > > > +     n =3D btf_nr_types(btf) - 1;
> > > > +     for (i =3D btf_start_id(btf); i < n; i++) {
> > > > +             k =3D i + 1;
> > > > +             if (btf_compare_type_names(&i, &k, btf) > 0)
> > > > +                     goto out;
> > > > +
> > > > +             t =3D btf_type_by_id(btf, i);
> > > > +             if (t->name_off)
> > > > +                     nr_sorted_types++;
> > > > +     }
> > > > +
> > > > +     t =3D btf_type_by_id(btf, k);
> > > > +     if (t->name_off)
> > > > +             nr_sorted_types++;
> > > > +     if (nr_sorted_types)
> > > > +             btf->nr_sorted_types =3D nr_sorted_types;
> > >                              ^
> > >
> > > The same race condition applies to this write of nr_sorted_types as
> > > well.
> > >
> > > > +
> > > > +out:
> > > > +     return btf->nr_sorted_types > 0;
> > > > +}
> > >
> > > [ ... ]
> > >
> > > > @@ -610,7 +674,7 @@ s32 btf_find_by_name_kind(const struct btf
> > > > *btf, const char *name, u8 kind)
> > > >                       goto out;
> > > >       }
> > > >
> > > > -     if (btf->nr_sorted_types !=3D BTF_NEED_SORT_CHECK) {
> > > > +     if (btf_check_sorted((struct btf *)btf)) {
> > >                                   ^
> > >
> > > The const cast here enables the concurrent writes discussed above.
> > > Is
> > > there a reason to mark the btf parameter as const if we're
> > > modifying it?
> >
> > Hi team, is casting away const an acceptable approach for our
> > codebase?
>
> Casting away const is undefined behaviour, e.g. see paragraph 6.7.3.6
> N1570 ISO/IEC 9899:201x Programming languages =E2=80=94 C.
>
> Both of the problems above can be avoided if kernel will do sorted
> check non-lazily. But Andrii and Alexei seem to like that property.

Ihor is going to move BTF manipulations into resolve_btfid.
Sorting of BTF should be in resolve_btfid as well.
This way the build process will guarantee that BTF is sorted
to the kernel liking. So the kernel doesn't even need to check
that BTF is sorted.

