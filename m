Return-Path: <linux-kernel+bounces-770642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44315B27D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8AC5E10E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA342FB963;
	Fri, 15 Aug 2025 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FODDPZfA"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE4A1369B4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251100; cv=none; b=ddCq7Yz+W1s+VN3uiCHRRWJ5iTxt0GaLOLWQl/dQe4DDBWYcNkI4CPSKxOrK+qh72Im553eLtAywfMAEVnMFpCJ1XKiYY7DVE92xH76oq4PQu4ig+JdjzZ3Fmots0q/MJMyLH4u3Q0NtnoCciste+YRJZXE7L3s2sM+D18PPQ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251100; c=relaxed/simple;
	bh=Gy6mFyPr8TpOfUSRXzDGdsoCCKFEcHvfi5O4tG5J16w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q02SxHScDYgkPXfGGZs+I5NTzOOIEw/WjNAQzvlh2W6OWbwCtlUPLowAC/ZPzGLtu+D2+tWxSOV/VDQULmtBE8VDqJzOqDt6UqsBNZ6W8gazoR20m0G74N4OGtY9tk2zFA3ShtCUdwLguPVW850ZWw68C5YAtWsEpvGTdprA11w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FODDPZfA; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-50f88ed81c8so1219863137.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755251098; x=1755855898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWxDVNI9zWJDMw2/NzCN2d5ECLoC1ab46r5j/n61aEw=;
        b=FODDPZfAtZYNK81xwLyO3iynZtxxk8fO4It4Ws9vf4fpSnPinrI+Tamuj/Wt0bj9HG
         Y6Yv23xQ3zGuG5hDHQaDYcEOGe59yXvNTXajIXATjzstnbWr/w2SdIobDn/TZIxeFbsL
         HdienF0P6fm0BLj29jUsVoP/tgcJmISsrmj54tbJXdxA82dBh+PuzUXIz+tXqSuamYjW
         XW78rtpfbWIHt7nPtcDmzLQHN5paw1TURbA1M6y5FMqevyjqVfpYrPkXD3vB571MlUFE
         EIZQnAtzXH0u/9fVMiQrxGksQveF7/DsVFYGn5YY2+IiOJFHDTFpZZ28mSEmtrT1FFAw
         zK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755251098; x=1755855898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWxDVNI9zWJDMw2/NzCN2d5ECLoC1ab46r5j/n61aEw=;
        b=an1h+ubvlgbcgrPS/1a0uWjeJde7s8DCN8YcGuyXVKsTuzAtofz4yI9vHstiSidhOy
         roLC3udcdRzMirFtFIFF19LslZMCC01OFQ4jyPYc2g1N5M2OJsOWGc3RN3m8JZiwhsnV
         S16c9dK7IbSuKw9rHh0DDZzV610KYMoL06hKcbT9Rk7l4WYNJD4rOqhhL3f0O/0DC5/v
         VLhqs9tJ93/ok1VHf0ytNJt0f2z2BnxAZ/r1ZWyoQCjPEcJqXc5gW3WnMua6JMa726tk
         c/XufvT5hwbpO8d5MaEAToauwlHfNWWVZboLMDXLlOFVJB20qmQTFLTOSgT9qzv2Wthg
         v/Ew==
X-Forwarded-Encrypted: i=1; AJvYcCU7o0ds8vVgKH+u2Bpy8QJZrmxxOtOEceLFAriLYVnR2DehCubmyzNOCYae95apoKhTAWD4NymGg6h2cg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz6PsX+IklkkDfSYKwZV16EbXIFmwJUDSB95EwcCC9VXu5QdCt
	/fbk2f4rYDVpLkJbdA+aIY1ojYX5NNdha9ctOmXpXygECxDFnVvdrX+BDrZZbRQHgs50Q0FObn6
	N8w4ebGtp5Tciw9KriYhIGidKl7a8TJmY5oD0
X-Gm-Gg: ASbGncs0ScQKzqg1e+NUtWTV/7ynvMjh9tRgON4RG/4in8CoDQw74Qu7odhMXK4V5xd
	MgpIt/xgb93njgEwrjLrzCoblJ2I8GT6HzaX6WcH+TdnyIvoEtVfWBJ2ayIX7i4GXnmZ3EGafW3
	WqigD7/RcvkZQxnsqWI3oFRra4P7Fh3/r4grKM1vf6yJt31AxXJARWEPGcSycHE3kjaLju+Wj5d
	FACD1pHXwQueFyx9EpmSbFsFs/j
X-Google-Smtp-Source: AGHT+IFFuOn0icKNoTW5k2DO+u5beiSHnjainhBGuGTUruUcvKzxOD6TN07/SDAAx0VUAv7dTxAzY+xEtBf/UX86WTc=
X-Received: by 2002:a05:6102:3049:b0:4e4:f503:666b with SMTP id
 ada2fe7eead31-5126ab24a39mr377560137.3.1755251098016; Fri, 15 Aug 2025
 02:44:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813193024.2279805-1-lokeshgidra@google.com>
In-Reply-To: <20250813193024.2279805-1-lokeshgidra@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 15 Aug 2025 21:44:47 +1200
X-Gm-Features: Ac12FXyOCWcNh-7-U1FVsYELZvOP82LK07VXJeTUcBSMT9ncmkxu_m4V3mdpv-0
Message-ID: <CAGsJ_4w5bAJHyBrwb5+n_EANqzhz4cFSX+9yZacmOiXVJZ_Dkw@mail.gmail.com>
Subject: Re: [PATCH v5] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 7:30=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.co=
m> wrote:
>
> MOVE ioctl's runtime is dominated by TLB-flush cost, which is required
> for moving present pages. Mitigate this cost by opportunistically
> batching present contiguous pages for TLB flushing.
>
> Without batching, in our testing on an arm64 Android device with UFFD GC,
> which uses MOVE ioctl for compaction, we observed that out of the total
> time spent in move_pages_pte(), over 40% is in ptep_clear_flush(), and
> ~20% in vm_normal_folio().
>
> With batching, the proportion of vm_normal_folio() increases to over
> 70% of move_pages_pte() without any changes to vm_normal_folio().
> Furthermore, time spent within move_pages_pte() is only ~20%, which
> includes TLB-flush overhead.
>
> When the GC intensive benchmark, which was used to gather the above
> numbers, is run on cuttlefish (qemu android instance on x86_64), the
> completion time of the benchmark went down from ~45mins to ~20mins.
>
> Furthermore, system_server, one of the most performance critical system
> processes on android, saw over 50% reduction in GC compaction time on an
> arm64 android device.
>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Cc: Barry Song <v-songbaohua@oppo.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>

Reviewed-by: Barry Song <baohua@kernel.org>

[...]
> +static long move_present_ptes(struct mm_struct *mm,
> +                             struct vm_area_struct *dst_vma,
> +                             struct vm_area_struct *src_vma,
> +                             unsigned long dst_addr, unsigned long src_a=
ddr,
> +                             pte_t *dst_pte, pte_t *src_pte,
> +                             pte_t orig_dst_pte, pte_t orig_src_pte,
> +                             pmd_t *dst_pmd, pmd_t dst_pmdval,
> +                             spinlock_t *dst_ptl, spinlock_t *src_ptl,
> +                             struct folio **first_src_folio, unsigned lo=
ng len,
> +                             struct anon_vma *src_anon_vma)
> +{
> +       int err =3D 0;
> +       struct folio *src_folio =3D *first_src_folio;
> +       unsigned long src_start =3D src_addr;
> +       unsigned long src_end;
> +
> +       if (len > PAGE_SIZE) {
> +               len =3D pmd_addr_end(dst_addr, dst_addr + len) - dst_addr=
;
> +               src_end =3D pmd_addr_end(src_addr, src_addr + len);
> +       } else
> +               src_end =3D src_addr + len;

Nit:

Look at Documentation/process/coding-style.rst.

This does not apply if only one branch of a conditional statement is a sing=
le
statement; in the latter case use braces in both branches:

.. code-block:: c

    if (condition) {
        do_this();
        do_that();
    } else {
        otherwise();
    }

By the way, what about the following for both cases? Would it impact
performance in the `PAGE_SIZE` cases?

len =3D pmd_addr_end(dst_addr, dst_addr + len) - dst_addr;
src_end =3D pmd_addr_end(src_addr, src_addr + len);

Thanks
Barry

