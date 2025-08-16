Return-Path: <linux-kernel+bounces-772099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC6DB28EB5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E758AAC1DAF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0352F6584;
	Sat, 16 Aug 2025 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qko627C1"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D42E2F60BB
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755356433; cv=none; b=C7pZdqhjKSO6KPbg/iQw7IQKI4NQEY1LGqWnAxcZW+ZKIGStznllknchvjSYGA25VfgRosnklRbAOGQRlHBytC0hN1DeIFrFbGOaGFhsY7BjB5Zg+QHzpKZ474DXNf8/ikg+4tb7ssow09hKApA7b3B77g5aqOTRkh4nP5qsblI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755356433; c=relaxed/simple;
	bh=/gpyYtfq8Blo29qT8ISDniWROZznmJLC/ShaYteoNFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZK8D3vXojD+V2aP1Y8nYw1O7JuBYRB2kLvs9ck/wDdSGNChJk9JqXu3grZnPUubeNjh7KpqVcHho6bZkuhGUYxEJ75vaOrSFc3/JiU6U37aOzbEsYNVde9hY4zlyxC+WmsP2HnApAn8iZK+r9eCtyhEYqE1wwUM+1L83HhbXGto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qko627C1; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61a207a248cso970a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 08:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755356430; x=1755961230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vul7COE0io0WgsaBqJz6prHxr50hd7AzfA83m1brrv0=;
        b=qko627C11jXmBL0i+MhdKnHhQBt/WGMUxLsFSQxbtOZaxMKaMTN8rFRvKPvYzjNkCD
         q5eXXLIanQi9msOoSaFxbw4rZmX43QAxWSwAuSrSO0l6RbWhLkwTCGh4U/TZiOICuv7i
         Dh352pSDGr5fKGL05RQ/Qdr3WDDEfe9StURXf+x+CD+bWiuTnA/e4Kg6sEs1zmNrHBsw
         5HySs7B/p2WvChGQpez9/dMnidh+3RyOXPjsJ0m2/dsxigmj4rUQJ/TvV4qOWE9k0ehM
         vqiOJfHQUbynEawWX4pVjwBtn6v1z+xYmfpChmr41s6RMofHu8A99g2kjpvaAeSVDHnW
         MZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755356430; x=1755961230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vul7COE0io0WgsaBqJz6prHxr50hd7AzfA83m1brrv0=;
        b=frXDGh8D8LxJCWsPDTov5exotIccroHFlaTxrOk3bQ3YkD10rG60yDLxUE4mJDdSbr
         JqeDUzuW/9Lpwe4MpFxfNZm0/5zSBhoT1fwKhHXll32hufb/W56EKOm5NSQyzlBa5Tg/
         5L6rL2J9hWe/pqs2BGYUE8Uq1t5Az9k7KZFO1cOvuEXcscx1zmzKVnn2ueptwAcc2qYU
         kW67afFC+Uk7LXBsat8zTNKZXrXMoVlvijqmUhcAUpeAoHsHFM+x+jh3K0771q44PdpR
         KTfU/ySx8y2badtWl+M6W/5DcE58sCi6vKEANGl3qhqI9JuLD4qsbckuAbezMFPc39qT
         EZHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlhf2t46mYV2/phXVqiMIGXukoIQ6kW6rsI6uHdctHp9DwRZu2s4dBKekaoFkoT0WHRRh+PwkDPKxCplE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhM8SqQBDHmUtv7SwEON67/0NQVZHlPcPlKAOWM45D3wLMykrO
	thoX+vreJBxbALcDWswXP/X9dbe2LFsYe2LuUV3tvEHX9ltZbIURlH/mX6+iaKbwmjhbKx7Ih5A
	/Hmrvc4LntrjOi9131/g/bfU2dci5JAPNBeelAv+a
X-Gm-Gg: ASbGncuk+teVgz9KI+MkSEiqwsrUp4LPUgtUBSntAVmN+y9pKcpgdf5Ubg/FUpTWOUL
	z5Ws/1/REKnk5P9qtcaAsDVrs8Ai33gRKwg4eGY7GlvWF2YSuYap81uwkp7S7cF0UWsvbMyxs4t
	OhnIDBMuJKzWzkMnvvYJiNPXyo3khpxOwH5F+4YLd3wzjZuu6UsvWhu3hcxi8RIq5LogEtrx7cK
	5rZ4UmocLF8YOUXj9lVDsMXHP2Xq5AXcKSMSxzA/jmk1ckNWOBxho20
X-Google-Smtp-Source: AGHT+IEBzRezYSYENEGQB4vdaRuKAx6mnqwYgnJlL+f4GN/mn8+qaw7DmjcIAZ19UuK4URTXsDvO8Pn1rKjDF7g3rts=
X-Received: by 2002:a50:a688:0:b0:618:8373:30f0 with SMTP id
 4fb4d7f45d1cf-61989f4aabdmr42872a12.2.1755356429386; Sat, 16 Aug 2025
 08:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813193024.2279805-1-lokeshgidra@google.com>
 <CAGsJ_4w5bAJHyBrwb5+n_EANqzhz4cFSX+9yZacmOiXVJZ_Dkw@mail.gmail.com>
 <CAGsJ_4wt_30C82B9_ZoOB2umBi-u_kE441ARvYoJVjkLtLqFCg@mail.gmail.com>
 <CA+EESO4NfgT6uAP52eQEt4_cx7KPdHv4MxnSw_UwHVSurime8w@mail.gmail.com> <CAGsJ_4wwHMDocUjg=PBGafWYXmyDdbuDOi8kB3Xm2Q=J3VpCbQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4wwHMDocUjg=PBGafWYXmyDdbuDOi8kB3Xm2Q=J3VpCbQ@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Sat, 16 Aug 2025 08:00:15 -0700
X-Gm-Features: Ac12FXzNg6vh5n_QlZ8x6Ax4Y-ZniX5_i1umDqlfb7dKVuW-D5hNIsKUXldoccI
Message-ID: <CA+EESO7cO7WBPvrrC2BqHqT0sg4k4J60c7bQtN-T68kJCWC0Yg@mail.gmail.com>
Subject: Re: [PATCH v5] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 11:38=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Sat, Aug 16, 2025 at 12:27=E2=80=AFAM Lokesh Gidra <lokeshgidra@google=
.com> wrote:
> >
> > On Fri, Aug 15, 2025 at 3:11=E2=80=AFAM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > On Fri, Aug 15, 2025 at 9:44=E2=80=AFPM Barry Song <21cnbao@gmail.com=
> wrote:
> > > >
> > > > On Thu, Aug 14, 2025 at 7:30=E2=80=AFAM Lokesh Gidra <lokeshgidra@g=
oogle.com> wrote:
> > > > >
> > > > > MOVE ioctl's runtime is dominated by TLB-flush cost, which is req=
uired
> > > > > for moving present pages. Mitigate this cost by opportunistically
> > > > > batching present contiguous pages for TLB flushing.
> > > > >
> > > > > Without batching, in our testing on an arm64 Android device with =
UFFD GC,
> > > > > which uses MOVE ioctl for compaction, we observed that out of the=
 total
> > > > > time spent in move_pages_pte(), over 40% is in ptep_clear_flush()=
, and
> > > > > ~20% in vm_normal_folio().
> > > > >
> > > > > With batching, the proportion of vm_normal_folio() increases to o=
ver
> > > > > 70% of move_pages_pte() without any changes to vm_normal_folio().
> > > > > Furthermore, time spent within move_pages_pte() is only ~20%, whi=
ch
> > > > > includes TLB-flush overhead.
> > > > >
> > > > > When the GC intensive benchmark, which was used to gather the abo=
ve
> > > > > numbers, is run on cuttlefish (qemu android instance on x86_64), =
the
> > > > > completion time of the benchmark went down from ~45mins to ~20min=
s.
> > > > >
> > > > > Furthermore, system_server, one of the most performance critical =
system
> > > > > processes on android, saw over 50% reduction in GC compaction tim=
e on an
> > > > > arm64 android device.
> > > > >
> > > > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > > > Cc: Kalesh Singh <kaleshsingh@google.com>
> > > > > Cc: Barry Song <v-songbaohua@oppo.com>
> > > > > Cc: David Hildenbrand <david@redhat.com>
> > > > > Cc: Peter Xu <peterx@redhat.com>
> > > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > >
> > > > Reviewed-by: Barry Song <baohua@kernel.org>
> > Thanks :-)
> > > >
> > > > [...]
> > > > > +static long move_present_ptes(struct mm_struct *mm,
> > > > > +                             struct vm_area_struct *dst_vma,
> > > > > +                             struct vm_area_struct *src_vma,
> > > > > +                             unsigned long dst_addr, unsigned lo=
ng src_addr,
> > > > > +                             pte_t *dst_pte, pte_t *src_pte,
> > > > > +                             pte_t orig_dst_pte, pte_t orig_src_=
pte,
> > > > > +                             pmd_t *dst_pmd, pmd_t dst_pmdval,
> > > > > +                             spinlock_t *dst_ptl, spinlock_t *sr=
c_ptl,
> > > > > +                             struct folio **first_src_folio, uns=
igned long len,
> > > > > +                             struct anon_vma *src_anon_vma)
> > > > > +{
> > > > > +       int err =3D 0;
> > > > > +       struct folio *src_folio =3D *first_src_folio;
> > > > > +       unsigned long src_start =3D src_addr;
> > > > > +       unsigned long src_end;
> > > > > +
> > > > > +       if (len > PAGE_SIZE) {
> > > > > +               len =3D pmd_addr_end(dst_addr, dst_addr + len) - =
dst_addr;
> > > > > +               src_end =3D pmd_addr_end(src_addr, src_addr + len=
);
> > > > > +       } else
> > > > > +               src_end =3D src_addr + len;
> > > >
> > > > Nit:
> > > >
> > > > Look at Documentation/process/coding-style.rst.
> > > >
> > > > This does not apply if only one branch of a conditional statement i=
s a single
> > > > statement; in the latter case use braces in both branches:
> > > >
> > > > .. code-block:: c
> > > >
> > > >     if (condition) {
> > > >         do_this();
> > > >         do_that();
> > > >     } else {
> > > >         otherwise();
> > > >     }
> > Sorry for missing that. I can fix this in v6.
> > > >
> > > > By the way, what about the following for both cases? Would it impac=
t
> > > > performance in the `PAGE_SIZE` cases?
> >
> > I just wanted to avoid a bunch of instructions in two pmd_addr_end
> > invocations for the (len =3D=3D PAGE_SIZE) case, which is not going to =
be
> > uncommon. But I guess overall, it is not big enough to matter so can
> > be removed.
>
> Reducing the number of instructions doesn=E2=80=99t necessarily improve
> performance=E2=80=94in fact, it can often have the opposite effect. It ma=
y lead
> to increased branch mispredictions or make the code more memory-bound.
> In this particular case, could branch misprediction be the real issue?
>
That's true. I didn't even consider branch misprediction. I will
upload v6 which removes the condition, thereby also fixing the nit.
> > > >
> > > > len =3D pmd_addr_end(dst_addr, dst_addr + len) - dst_addr;
> > > > src_end =3D pmd_addr_end(src_addr, src_addr + len);
> > >
> > > By the way, do src and dst always have the same offset within a
> > > single PMD? I don=E2=80=99t think so. If not, how can we verify that =
if
> > > src=E2=80=99s PMD is not overflowing, dst is safe as well?
> > >
> > > Have you only checked src? And for src, since you are already using
> > > pmd_addr_end(), is src_end =3D src_addr + len fine? Why are you calli=
ng
> > > pmd_addr_end twice after your first pmd_addr_end has already limited
> > > the range?
> >
> > Effectively, we have to calculate min(len, extent in src pmd, extent
> > in dst pmd). That's the max that can be batched within a single
> > critical section of src_ptl and dst_ptl. The first pmd_addr_end() is
> > calculating min(len, extent of dst pmd). The second pmd_addr_end() is
> > calculating min(result of previous pmd_addr_end, extent of src pmd). I
> > don't think I'm missing any overflow check. But please correct me if
> > I'm mistaken.
>
> You are right. I misunderstood your code yesterday.
>
> Thanks
> Barry

