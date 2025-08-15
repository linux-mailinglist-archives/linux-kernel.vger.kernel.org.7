Return-Path: <linux-kernel+bounces-770705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DEDB27E14
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A38A02728
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BF32FFDC4;
	Fri, 15 Aug 2025 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAEXNv80"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C016F2D3238
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252698; cv=none; b=Rq8ja2VA7ZuKJm2ONQKtkyfsqApUx3cITGeD9iZwX7EDJYkoI6uKKLzAeJ9Q50hHvymmqfyfA6Z4geKTKLvUMQWJwmlNSDtjpGZ8Qkmaw20ItV1wz13VhqgCX2/jp4XXk14ii+xps8nRgRzGAEFTCyHooc5c9d5zu9jPxLwQ1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252698; c=relaxed/simple;
	bh=82MME80llOO5PUh/slmozG/9lFyGZAx89iSR6BNXaKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BskvfHlfbewZCIgh3ErcjKhix0OcnwSNtxxtiGGplbn0KpooDuSm1Ju79qXuhizTkMdpMsoX9DTZwao0Jq/pdbq3yBwKiU9JzQ/WwPN+m8oFVOEPuLC0Eo6PjTW0BY4l6S86oLuRbBBLhCYXBfSPYUMXkdE91UhA+uQzMsms/B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAEXNv80; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-53b173aa4a9so1307813e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 03:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755252696; x=1755857496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrP1RqrQrE+CCMDK7L29Lp1vhVh6WWRUdC6cwnE/mfA=;
        b=bAEXNv80z02X8Ns6n4Z081yqopYI6eQcF9cFd4Ol4RlU6Mad0eNH5tsR0L+7/aFQqw
         vM7BIkUohQy/26+fxZKcRe+eIsnbZEoqWBHbu55G/3iP5Ujny7pP0OSwt+bRlibVgrZB
         Ib5hxsRhWjWsTCqbR5ZFpYLgx4yqex//ZhT+P89W9A7d8wVKllcKDyAHf70MPQw2b9FM
         1tbzHVXeCuThPc9RbslFMcqkcrfXSirn5lyRL3jr7zjJVAevxzAXI69v83XGGyGqfwbK
         g8itYv1EF1OTRIFmqASXU2IgXQZprZftU1O9AArNNg5ILRm2ZT+vPSj3/CFVa3htbyuK
         0S7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755252696; x=1755857496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrP1RqrQrE+CCMDK7L29Lp1vhVh6WWRUdC6cwnE/mfA=;
        b=Iiz3arpvpWU+xqBHHd3hYns0PvMzjq1wlttnWwiaTdqyA0bacjT+hzM+QAKmIEoZwN
         Onbvky+jk0nfQIyYAGj29f/koBwzv9xwjdXIAFs0iBP4Zw3LzDfcmRtQg57DyPviZ14L
         P3+hYxTgcWdCXl0xwISfaABXwuTLv6EDkWnDGWvACzsTp1AXQzgOqNs8OMNzEuF8+cbx
         xoHXrSl3lCcwTw7l4ACPO3MfmEzJxGxy7m9H/2AbNQz7zXa421Jcz1ULMaVFE6NYc1XD
         xcyOT4B8E0+fYWaJmHReJR/FSAcipmr0DktUBzZegKroGv//7kMt0JIYOexwNarW05jh
         IQYg==
X-Forwarded-Encrypted: i=1; AJvYcCXIBI4HiHN8c/nuombdtzAcrxxK5z7+P3a8SDlKbq7wn7oci8yeuFltkXgeo9I4CXHFDvDkkXw6PFy+oos=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQl6A67Sgl4/UkNg4XkVS6wH/yfO1siDR92tk631vBCmsliT4J
	WZCp+1niZQiIbffgIoTOvi8YbqUBse5PaKlEV8ErfU8czs6uyBAoA/WENVHCDDcW+38kI8Miz/f
	81WqXbG22ryi5SX4wL5tgFUrflXUcK+A=
X-Gm-Gg: ASbGncs0BzVOB5kLnE7kN4POUwYAEsJOjUvS+YkU2AhSUfD/Fadgn5VE8NeDnscLPHO
	RSNlCghJmn9AAQCckCNwyr9BtF6lrZ/AumIBRuLiXau6fEcxhabg9+DChhDKGkOlqQt0rpFQVNN
	RedLavXMvtZjcli68fMq3OHDMQTNBECElzTl2GbEGWFVLBADkaEKOOuDfBwOj/PGVazzEBIDL3B
	HKYihw=
X-Google-Smtp-Source: AGHT+IECBZnTmPM/nQEDW9y3twNaByBLA0nvasb656eSYR4D1TwoU4UEw/SNZt9fDLmfjZvtmjPsBcSSy+1Vk1LmRk4=
X-Received: by 2002:a05:6122:8c6:b0:534:765a:8c3c with SMTP id
 71dfb90a1353d-53b2b76a0afmr362427e0c.5.1755252695644; Fri, 15 Aug 2025
 03:11:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813193024.2279805-1-lokeshgidra@google.com> <CAGsJ_4w5bAJHyBrwb5+n_EANqzhz4cFSX+9yZacmOiXVJZ_Dkw@mail.gmail.com>
In-Reply-To: <CAGsJ_4w5bAJHyBrwb5+n_EANqzhz4cFSX+9yZacmOiXVJZ_Dkw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 15 Aug 2025 22:11:24 +1200
X-Gm-Features: Ac12FXyaxQVPiABbs0kk2SIpgx7aAzdVcSx5eE7DyS2AoekcEk8ObJBnRsYHtE8
Message-ID: <CAGsJ_4wt_30C82B9_ZoOB2umBi-u_kE441ARvYoJVjkLtLqFCg@mail.gmail.com>
Subject: Re: [PATCH v5] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 9:44=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Thu, Aug 14, 2025 at 7:30=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.=
com> wrote:
> >
> > MOVE ioctl's runtime is dominated by TLB-flush cost, which is required
> > for moving present pages. Mitigate this cost by opportunistically
> > batching present contiguous pages for TLB flushing.
> >
> > Without batching, in our testing on an arm64 Android device with UFFD G=
C,
> > which uses MOVE ioctl for compaction, we observed that out of the total
> > time spent in move_pages_pte(), over 40% is in ptep_clear_flush(), and
> > ~20% in vm_normal_folio().
> >
> > With batching, the proportion of vm_normal_folio() increases to over
> > 70% of move_pages_pte() without any changes to vm_normal_folio().
> > Furthermore, time spent within move_pages_pte() is only ~20%, which
> > includes TLB-flush overhead.
> >
> > When the GC intensive benchmark, which was used to gather the above
> > numbers, is run on cuttlefish (qemu android instance on x86_64), the
> > completion time of the benchmark went down from ~45mins to ~20mins.
> >
> > Furthermore, system_server, one of the most performance critical system
> > processes on android, saw over 50% reduction in GC compaction time on a=
n
> > arm64 android device.
> >
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Kalesh Singh <kaleshsingh@google.com>
> > Cc: Barry Song <v-songbaohua@oppo.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
>
> Reviewed-by: Barry Song <baohua@kernel.org>
>
> [...]
> > +static long move_present_ptes(struct mm_struct *mm,
> > +                             struct vm_area_struct *dst_vma,
> > +                             struct vm_area_struct *src_vma,
> > +                             unsigned long dst_addr, unsigned long src=
_addr,
> > +                             pte_t *dst_pte, pte_t *src_pte,
> > +                             pte_t orig_dst_pte, pte_t orig_src_pte,
> > +                             pmd_t *dst_pmd, pmd_t dst_pmdval,
> > +                             spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > +                             struct folio **first_src_folio, unsigned =
long len,
> > +                             struct anon_vma *src_anon_vma)
> > +{
> > +       int err =3D 0;
> > +       struct folio *src_folio =3D *first_src_folio;
> > +       unsigned long src_start =3D src_addr;
> > +       unsigned long src_end;
> > +
> > +       if (len > PAGE_SIZE) {
> > +               len =3D pmd_addr_end(dst_addr, dst_addr + len) - dst_ad=
dr;
> > +               src_end =3D pmd_addr_end(src_addr, src_addr + len);
> > +       } else
> > +               src_end =3D src_addr + len;
>
> Nit:
>
> Look at Documentation/process/coding-style.rst.
>
> This does not apply if only one branch of a conditional statement is a si=
ngle
> statement; in the latter case use braces in both branches:
>
> .. code-block:: c
>
>     if (condition) {
>         do_this();
>         do_that();
>     } else {
>         otherwise();
>     }
>
> By the way, what about the following for both cases? Would it impact
> performance in the `PAGE_SIZE` cases?
>
> len =3D pmd_addr_end(dst_addr, dst_addr + len) - dst_addr;
> src_end =3D pmd_addr_end(src_addr, src_addr + len);

By the way, do src and dst always have the same offset within a
single PMD? I don=E2=80=99t think so. If not, how can we verify that if
src=E2=80=99s PMD is not overflowing, dst is safe as well?

Have you only checked src? And for src, since you are already using
pmd_addr_end(), is src_end =3D src_addr + len fine? Why are you calling
pmd_addr_end twice after your first pmd_addr_end has already limited
the range?

Thanks
Barry

