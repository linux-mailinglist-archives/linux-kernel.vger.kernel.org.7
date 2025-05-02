Return-Path: <linux-kernel+bounces-630141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E26CAA760F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 17:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB4A1C044F3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 15:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD202571BD;
	Fri,  2 May 2025 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBSBBrE+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2C2746E
	for <linux-kernel@vger.kernel.org>; Fri,  2 May 2025 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746199848; cv=none; b=XYIeF4U738SyqYamu2p5se3P9kL5ilOQ0cjN3RTUWcQqAAthT+SQ6TUSru3LobzTfwYou4ALTS5KITDbruubp/wKXWpf40hfha/PEHsuxEG320oZFzpiALb7bDHlg9aV4i4RKQLatTYlorQ7omaQHQq+MpLZzMq6j/KkILhQ6uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746199848; c=relaxed/simple;
	bh=BIFWU+BQxI+ybrEDzGvM0RmDpuDQig3eWd60cE/H7E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GK0iY0QtoRPaRGzjTn9AY77magD8FK0JUc4950Ml/1Q9wxR4q7IrrFABkT/o6oGaHcerHfdWTxIEmMaI2FbbBFwve7KL9wYG8cRYRcKdG6Ko9hGFGQZbbDvUStD1P8i3Vq3S9x15+Fxp7dBmVRxpAUidrUgMaC+tueH4FoN7oA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CBSBBrE+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746199845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkRh4xfxcDiGVCznroJyFPZrZVvXnyniPVMlI+7tnp0=;
	b=CBSBBrE+NpD5hFsD713SMEFfwozxWcfADa7vKAOCBwigg1dUmphk2/ETQRMnGrPNGPigW6
	UYJ2JgWCMfaBzdvLzqlGyAuM2T4RChjKsCFgrxWRX6RcRliFUjMBgJOfABiYrpqDiRM6Hw
	suqK9NZE0mecpkirU2F6962Vut0biwU=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-9PunCwrgNDyoTDf0hI3bAA-1; Fri, 02 May 2025 11:30:44 -0400
X-MC-Unique: 9PunCwrgNDyoTDf0hI3bAA-1
X-Mimecast-MFC-AGG-ID: 9PunCwrgNDyoTDf0hI3bAA_1746199843
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-707cf1b0ecbso31155067b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 May 2025 08:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746199843; x=1746804643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkRh4xfxcDiGVCznroJyFPZrZVvXnyniPVMlI+7tnp0=;
        b=J5bc6hKPhb2T+9PL0zUPeozje//Omi2cuuw4Dcqllnp/ZmnqZAU9v9RmhGTIpKMe7k
         1Iqji7oTdQsWgbLfxe9WXR+Yu1vbnZ3z5VH0uhurJ+3SBpnvnmCBbiSgEXskscDnwGMv
         6Fj89tNZEsnWyXLglhLqX3sjk3WZt7K0U4ZhNjE+tO9gY8s9jiB/2UsRWP6QR9Q+J4F2
         6NaMv7AQnuslkN50oVhNYBRP2QyP8aQ+CMCNQx6BIa/6jCJ4tFBldZLOVyxH2LcpAA1i
         taFhmkfe2QLZUAdbn/szdriiOZd6Dw8HIwtq260cFeiJuBGAWI0zzPLVE3NWRFehqZ2T
         kvRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE+zdsS/fShUUtZonKhNjclzsbFGEhBBGAJiomju3MUUt1Augol3T2/12eDe9DI3V7AiH8Ga4DaQSC1mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw72mHtKMafd0kv3FfPJUKEvG7XZuPnSsQMDLyhRlPFRT0ANoeI
	c89Y+POOyyes/hzg0gjYMYdaYYkSz1gyBANnp8bymvl+4ckdk//+wq7Z9zE3dzvYua5YDwE6yQ3
	UP3flthQuVIyB66Oilt4b5w5wqNRwqWt5UwIgWjgnguEi0n+t+kfWGeUjkEwSfk8AOVBAiuyJw3
	AYSGPnWNluyexz4J3Gsyb8v/ZUoenoubnZm7eP
X-Gm-Gg: ASbGncvedAgDPVyqt8dyFkasMEt0v/9s9pIyQC6tNBzreSGIWXSIkGEtjg4MPuTooRr
	lm0o1GB3eUKxL2xVcASvqvvvHzggZHgH67QMGPe57Z6KQ/NP/O7yCtIAhggdPkVCaHxHuGA==
X-Received: by 2002:a05:6902:1b8a:b0:e73:1bce:cc9 with SMTP id 3f1490d57ef6-e7565659e7fmr4340353276.41.1746199843126;
        Fri, 02 May 2025 08:30:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD6u8L0lnSuVxL/j3o/HQoXiJHgTftmzjv4yoMTN8vHad/uToYdYiOCpNgDW/bu4MUj8nb7B5bHGeWlfpjB0I=
X-Received: by 2002:a05:6902:1b8a:b0:e73:1bce:cc9 with SMTP id
 3f1490d57ef6-e7565659e7fmr4340275276.41.1746199842658; Fri, 02 May 2025
 08:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428181218.85925-1-npache@redhat.com> <20250428181218.85925-8-npache@redhat.com>
 <CAG48ez2oge4xs1pSz_T9L46g=wQnFyC63kQKsXwbHGRWAxQ+aw@mail.gmail.com>
 <CAA1CXcBHJbs7_DGVR929NOD5G4nkJ3LguDrL9itV8-QS+BNUpg@mail.gmail.com>
 <b6093db0-9b18-4b70-81bd-6c02e80ac9fa@redhat.com> <CAG48ez0oe6oZ0QTDWr1rtUJFFTLO69sVpdoCmo+CxZUb6L1seg@mail.gmail.com>
 <b91af3df-643e-4131-96e7-2680f322194d@redhat.com> <CAG48ez25Wo7BSt4dn3v+xO0mojvjtBpd02kaAu7kn_+AfgSrNQ@mail.gmail.com>
In-Reply-To: <CAG48ez25Wo7BSt4dn3v+xO0mojvjtBpd02kaAu7kn_+AfgSrNQ@mail.gmail.com>
From: Nico Pache <npache@redhat.com>
Date: Fri, 2 May 2025 09:30:15 -0600
X-Gm-Features: ATxdqUER09h9rU5R_TsgAlu2Vl2YcDHMhrm313BXUDsCp0-N15muBn86mxdYUg8
Message-ID: <CAA1CXcBn3eZpcdzsG5DRNBa+rFBg1dQjssC=SYyXW5_7fDmwXg@mail.gmail.com>
Subject: Re: [PATCH v5 07/12] khugepaged: add mTHP support
To: Jann Horn <jannh@google.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, ryan.roberts@arm.com, willy@infradead.org, 
	peterx@redhat.com, ziy@nvidia.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	dev.jain@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com, 
	tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, 
	cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com, 
	hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com, 
	rdunlap@infradead.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 9:27=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Fri, May 2, 2025 at 5:19=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
> >
> > On 02.05.25 14:50, Jann Horn wrote:
> > > On Fri, May 2, 2025 at 8:29=E2=80=AFAM David Hildenbrand <david@redha=
t.com> wrote:
> > >> On 02.05.25 00:29, Nico Pache wrote:
> > >>> On Wed, Apr 30, 2025 at 2:53=E2=80=AFPM Jann Horn <jannh@google.com=
> wrote:
> > >>>>
> > >>>> On Mon, Apr 28, 2025 at 8:12=E2=80=AFPM Nico Pache <npache@redhat.=
com> wrote:
> > >>>>> Introduce the ability for khugepaged to collapse to different mTH=
P sizes.
> > >>>>> While scanning PMD ranges for potential collapse candidates, keep=
 track
> > >>>>> of pages in KHUGEPAGED_MIN_MTHP_ORDER chunks via a bitmap. Each b=
it
> > >>>>> represents a utilized region of order KHUGEPAGED_MIN_MTHP_ORDER p=
tes. If
> > >>>>> mTHPs are enabled we remove the restriction of max_ptes_none duri=
ng the
> > >>>>> scan phase so we dont bailout early and miss potential mTHP candi=
dates.
> > >>>>>
> > >>>>> After the scan is complete we will perform binary recursion on th=
e
> > >>>>> bitmap to determine which mTHP size would be most efficient to co=
llapse
> > >>>>> to. max_ptes_none will be scaled by the attempted collapse order =
to
> > >>>>> determine how full a THP must be to be eligible.
> > >>>>>
> > >>>>> If a mTHP collapse is attempted, but contains swapped out, or sha=
red
> > >>>>> pages, we dont perform the collapse.
> > >>>> [...]
> > >>>>> @@ -1208,11 +1211,12 @@ static int collapse_huge_page(struct mm_s=
truct *mm, unsigned long address,
> > >>>>>           vma_start_write(vma);
> > >>>>>           anon_vma_lock_write(vma->anon_vma);
> > >>>>>
> > >>>>> -       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, =
address,
> > >>>>> -                               address + HPAGE_PMD_SIZE);
> > >>>>> +       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, =
_address,
> > >>>>> +                               _address + (PAGE_SIZE << order));
> > >>>>>           mmu_notifier_invalidate_range_start(&range);
> > >>>>>
> > >>>>>           pmd_ptl =3D pmd_lock(mm, pmd); /* probably unnecessary =
*/
> > >>>>> +
> > >>>>>           /*
> > >>>>>            * This removes any huge TLB entry from the CPU so we w=
on't allow
> > >>>>>            * huge and small TLB entries for the same virtual addr=
ess to
> > >>>>
> > >>>> It's not visible in this diff, but we're about to do a
> > >>>> pmdp_collapse_flush() here. pmdp_collapse_flush() tears down the
> > >>>> entire page table, meaning it tears down 2MiB of address space; an=
d it
> > >>>> assumes that the entire page table exclusively corresponds to the
> > >>>> current VMA.
> > >>>>
> > >>>> I think you'll need to ensure that the pmdp_collapse_flush() only
> > >>>> happens for full-size THP, and that mTHP only tears down individua=
l
> > >>>> PTEs in the relevant range. (That code might get a bit messy, sinc=
e
> > >>>> the existing THP code tears down PTEs in a detached page table, wh=
ile
> > >>>> mTHP would have to do it in a still-attached page table.)
> > >>> Hi Jann!
> > >>>
> > >>> I was under the impression that this is needed to prevent GUP-fast
> > >>> races (and potentially others).
> > >
> > > Why would you need to touch the PMD entry to prevent GUP-fast races f=
or mTHP?
> > >
> > >>> As you state here, conceptually the PMD case is, detach the PMD, do
> > >>> the collapse, then reinstall the PMD (similarly to how the system
> > >>> recovers from a failed PMD collapse). I tried to keep the current
> > >>> locking behavior as it seemed the easiest way to get it right (and =
not
> > >>> break anything). So I keep the PMD detaching and reinstalling for t=
he
> > >>> mTHP case too. As Hugh points out I am releasing the anon lock too
> > >>> early. I will comment further on his response.
> > >
> > > As I see it, you're not "keeping" the current locking behavior; you'r=
e
> > > making a big implicit locking change by reusing a codepath designed
> > > for PMD THP for mTHP, where the page table may not be exclusively
> > > owned by one VMA.
> >
> > That is not the intention. The intention in this series (at least as we
> > discussed) was to not do it across VMAs; that is considered the next
> > logical step (which will be especially relevant on arm64 IMHO).
>
> Ah, so for now this is supposed to only work for PTEs which are in a
> PMD which is fully covered by the VMA? So if I make a 16KiB VMA and
> then try to collapse its contents to an order-2 mTHP page, that should
> just not work?
Correct! As I started in reply to Hugh, the locking conditions explode
if we drop that requirement. A simple workaround we've considered is
only collapsing if a single VMA intersects a PMD. I can make sure this
is more clear in the coverletter + this patch.

 Cheers,
-- Nico
>


