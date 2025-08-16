Return-Path: <linux-kernel+bounces-771749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF998B28B27
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE91D2A7549
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 06:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E4521B9FD;
	Sat, 16 Aug 2025 06:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+kfgW7t"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3CD1C5D55
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 06:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755326325; cv=none; b=QKrRgtuA6/Mu9xBH3PIBAjWAcWrosbE9SCg4OZKDqtnTBOYlEqRKf7ovROJyHCGwmvgA0C4/AdUwpzjFH7Aa1Xj+tSANUUyosC/etHAUeSmCzHatYMiWI4ZTkYxnVGjELO/gzuyQjTsgxM9el22A90J3fawywa5z1fvXSWfGyNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755326325; c=relaxed/simple;
	bh=TQ28VSvdB50Zyk0PHjovw7iMmHcmu19p4YPQXTsmhpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=negCQxYWxPYi0iSNWSsHWCF0Ah9vfpU1PF61KIPno39kYdQjVMf+CWqjYlDqZqh/2KVgtWXgEGhayTAePYRC+5TXnd7SyNfd/8qtkhP1qjDGExDRLrRTxuwBWf/hvhFP1KZJpAwRN8qxD9ll6rIZGqTDMkCx5txJZJGZQ4Ux0KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+kfgW7t; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-53b17552198so820404e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 23:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755326322; x=1755931122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQnIeoP+s7VQU+kygRJWTfXX5/GWV+imwlaAnb6OVOA=;
        b=M+kfgW7tTl2hbYs5DsALu60ewGv9VZgeM9UGELDLP/vl2gN+ssRQ8t0lCWImS6+ENk
         W+StkFEG46HNjCnYYbOPASt/f5W1OB/CAbxMkZISnUvEIdl/HTk7aSIRQiMVid9gNB8P
         wbtuPZc0eDSkErbwEpvt/c8rY0ooG/58UVL/UfpuOmmlA1uxrqPK8plB3u8HjI9prl2b
         WPkwPklaiFXQD7PsLH4db7krXo7/mrJd4Lc8oQOcxAt4qXfRzOHAB7KFlHb8Vz5r5sx9
         U3MujyghgIApwLs6HiYpFhyfQeaFf8ncXAJKN8sReOD+FxypRorNMWj3ty3n+hVWRHf2
         hNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755326322; x=1755931122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQnIeoP+s7VQU+kygRJWTfXX5/GWV+imwlaAnb6OVOA=;
        b=CBn1o2/5yZ9yX2mZzJF2uDPgo2AcjS67al/F1h/u1jQYo5ejL/1GjkjmmluE00qyhN
         mqJz3xeJAt/dEkeRv6GJTesznt6MlTGiNP4skmawrMTfHRc5E5cASbazMb129BxTlBtn
         np+y5KOIcP4WaoaU83kXDuuaEe6wjunOlEE74P3aHvjEvtoUg8leg/aEOivE7ZiAR3lY
         +ivAGx2xL6JXJUcWMB1PUkB9BsmGPqy7P7MaLi+fhAxQuEWFuflS3O1berxg/eua1nH5
         I5w/dndg3J8fUveD00uitIfu6FF6SPY86IFQjMRyaiyq/ARhkD5jcne7yWs0IVV8zapI
         WqXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgQaiMKjrhVNxv6PCoIxTEv4nAZfwZi6ltTrN/3d+JPDde3JzB/21aRKrcG6i+ZC2dHCURz9oyN8IcZ+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7i/ZWbWDKrRvk/yEsfDB24/r2LSz7X7Es9qz8BmDDoasSs601
	z9T4Nr7r7/FXkBKTx/uKpvpQbS6oKs6Xc6H1xmQKeDLwIoy8wFgsFeyYNbIzdsQdyNN1T3ZeGXS
	dPHPz6sR51h0Wds6OBxcEmoZ+rRP/a9A=
X-Gm-Gg: ASbGnctQEdWsCg+C4WA8ienMEWf8mp4whMRdm634PBI+YQlxdJGES1Ms3LCyZTiVQZa
	a7t8qfH5RYTBdpO2INhqBmV7hbDFmF2MveuQp6/dRI8eOBDoeX3e5Jpfag7XJ8YgKcrwtMqjmYG
	55N5vhr/f/gFGzxanyH54OicKGR7P8jnacYOW/PHkhaTpy44sN839BJthMLeLnLruIBJDbGV7DB
	wvQ/bamQH5rQFeoMQ==
X-Google-Smtp-Source: AGHT+IFTBt0NsG+0QYclG+jSrN2ZA3xi0vSYGNE0ci5JVOTRpGQ3xUkVJgoW/6nmW62VzJSlkY+L7UjQUUl9QZNp72M=
X-Received: by 2002:a05:6102:508d:b0:505:ff14:8e0 with SMTP id
 ada2fe7eead31-5126af225afmr1907875137.11.1755326321996; Fri, 15 Aug 2025
 23:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813193024.2279805-1-lokeshgidra@google.com>
 <CAGsJ_4w5bAJHyBrwb5+n_EANqzhz4cFSX+9yZacmOiXVJZ_Dkw@mail.gmail.com>
 <CAGsJ_4wt_30C82B9_ZoOB2umBi-u_kE441ARvYoJVjkLtLqFCg@mail.gmail.com> <CA+EESO4NfgT6uAP52eQEt4_cx7KPdHv4MxnSw_UwHVSurime8w@mail.gmail.com>
In-Reply-To: <CA+EESO4NfgT6uAP52eQEt4_cx7KPdHv4MxnSw_UwHVSurime8w@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 16 Aug 2025 14:38:31 +0800
X-Gm-Features: Ac12FXzp4854qVOc_OABL1f6f01YvG2rCYIPXU2drb4n_pA96sDmbgBZnCK5-6g
Message-ID: <CAGsJ_4wwHMDocUjg=PBGafWYXmyDdbuDOi8kB3Xm2Q=J3VpCbQ@mail.gmail.com>
Subject: Re: [PATCH v5] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 12:27=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.c=
om> wrote:
>
> On Fri, Aug 15, 2025 at 3:11=E2=80=AFAM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Fri, Aug 15, 2025 at 9:44=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > On Thu, Aug 14, 2025 at 7:30=E2=80=AFAM Lokesh Gidra <lokeshgidra@goo=
gle.com> wrote:
> > > >
> > > > MOVE ioctl's runtime is dominated by TLB-flush cost, which is requi=
red
> > > > for moving present pages. Mitigate this cost by opportunistically
> > > > batching present contiguous pages for TLB flushing.
> > > >
> > > > Without batching, in our testing on an arm64 Android device with UF=
FD GC,
> > > > which uses MOVE ioctl for compaction, we observed that out of the t=
otal
> > > > time spent in move_pages_pte(), over 40% is in ptep_clear_flush(), =
and
> > > > ~20% in vm_normal_folio().
> > > >
> > > > With batching, the proportion of vm_normal_folio() increases to ove=
r
> > > > 70% of move_pages_pte() without any changes to vm_normal_folio().
> > > > Furthermore, time spent within move_pages_pte() is only ~20%, which
> > > > includes TLB-flush overhead.
> > > >
> > > > When the GC intensive benchmark, which was used to gather the above
> > > > numbers, is run on cuttlefish (qemu android instance on x86_64), th=
e
> > > > completion time of the benchmark went down from ~45mins to ~20mins.
> > > >
> > > > Furthermore, system_server, one of the most performance critical sy=
stem
> > > > processes on android, saw over 50% reduction in GC compaction time =
on an
> > > > arm64 android device.
> > > >
> > > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > > Cc: Kalesh Singh <kaleshsingh@google.com>
> > > > Cc: Barry Song <v-songbaohua@oppo.com>
> > > > Cc: David Hildenbrand <david@redhat.com>
> > > > Cc: Peter Xu <peterx@redhat.com>
> > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > >
> > > Reviewed-by: Barry Song <baohua@kernel.org>
> Thanks :-)
> > >
> > > [...]
> > > > +static long move_present_ptes(struct mm_struct *mm,
> > > > +                             struct vm_area_struct *dst_vma,
> > > > +                             struct vm_area_struct *src_vma,
> > > > +                             unsigned long dst_addr, unsigned long=
 src_addr,
> > > > +                             pte_t *dst_pte, pte_t *src_pte,
> > > > +                             pte_t orig_dst_pte, pte_t orig_src_pt=
e,
> > > > +                             pmd_t *dst_pmd, pmd_t dst_pmdval,
> > > > +                             spinlock_t *dst_ptl, spinlock_t *src_=
ptl,
> > > > +                             struct folio **first_src_folio, unsig=
ned long len,
> > > > +                             struct anon_vma *src_anon_vma)
> > > > +{
> > > > +       int err =3D 0;
> > > > +       struct folio *src_folio =3D *first_src_folio;
> > > > +       unsigned long src_start =3D src_addr;
> > > > +       unsigned long src_end;
> > > > +
> > > > +       if (len > PAGE_SIZE) {
> > > > +               len =3D pmd_addr_end(dst_addr, dst_addr + len) - ds=
t_addr;
> > > > +               src_end =3D pmd_addr_end(src_addr, src_addr + len);
> > > > +       } else
> > > > +               src_end =3D src_addr + len;
> > >
> > > Nit:
> > >
> > > Look at Documentation/process/coding-style.rst.
> > >
> > > This does not apply if only one branch of a conditional statement is =
a single
> > > statement; in the latter case use braces in both branches:
> > >
> > > .. code-block:: c
> > >
> > >     if (condition) {
> > >         do_this();
> > >         do_that();
> > >     } else {
> > >         otherwise();
> > >     }
> Sorry for missing that. I can fix this in v6.
> > >
> > > By the way, what about the following for both cases? Would it impact
> > > performance in the `PAGE_SIZE` cases?
>
> I just wanted to avoid a bunch of instructions in two pmd_addr_end
> invocations for the (len =3D=3D PAGE_SIZE) case, which is not going to be
> uncommon. But I guess overall, it is not big enough to matter so can
> be removed.

Reducing the number of instructions doesn=E2=80=99t necessarily improve
performance=E2=80=94in fact, it can often have the opposite effect. It may =
lead
to increased branch mispredictions or make the code more memory-bound.
In this particular case, could branch misprediction be the real issue?

> > >
> > > len =3D pmd_addr_end(dst_addr, dst_addr + len) - dst_addr;
> > > src_end =3D pmd_addr_end(src_addr, src_addr + len);
> >
> > By the way, do src and dst always have the same offset within a
> > single PMD? I don=E2=80=99t think so. If not, how can we verify that if
> > src=E2=80=99s PMD is not overflowing, dst is safe as well?
> >
> > Have you only checked src? And for src, since you are already using
> > pmd_addr_end(), is src_end =3D src_addr + len fine? Why are you calling
> > pmd_addr_end twice after your first pmd_addr_end has already limited
> > the range?
>
> Effectively, we have to calculate min(len, extent in src pmd, extent
> in dst pmd). That's the max that can be batched within a single
> critical section of src_ptl and dst_ptl. The first pmd_addr_end() is
> calculating min(len, extent of dst pmd). The second pmd_addr_end() is
> calculating min(result of previous pmd_addr_end, extent of src pmd). I
> don't think I'm missing any overflow check. But please correct me if
> I'm mistaken.

You are right. I misunderstood your code yesterday.

Thanks
Barry

