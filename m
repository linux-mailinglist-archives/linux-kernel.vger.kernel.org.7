Return-Path: <linux-kernel+bounces-864587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A24EBFB1ED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B9814EB651
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E44305962;
	Wed, 22 Oct 2025 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTzrBOU6"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24E72F6919
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124692; cv=none; b=aGo3u5UY5WGKi5eV95PCI0mpW0tdaMWNacviIu1q8hWCNW2EYHzl9KOqS11nqqrXWTkz5njx+r2h1/b+XUztURtD6t4ZJXMDaHM0PeRTCrHn6TLksA8/gBKs9AnO8sWS456ZPASwq4QGQl4D0pqp5nDg7RShQZSd+nGVZXcPm/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124692; c=relaxed/simple;
	bh=ffUsTJrj/0WkSYj7XFxWsqgrnZ0ALQL/xKxox6/P4bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsTQb0ZdoYDVMPt378QJSdNVPF32buV+QQLOVAEdgnPFeHAXubPb8xpPV9cnoG8xU80IhVU6Sk1BjWTOKqZ+OBBWuNT7KiAd7iQ3ua/IISyPb9zeMBd1t30UJoeryz8WYevdke49C+CcgwgXNOq2P1yskb34OrLVFLQ92vBjMxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTzrBOU6; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-85a4ceb4c3dso875409885a.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761124687; x=1761729487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhkH+62s9AhGNEt/gcdilWodKjE5uLzcv1BGhnCuNyc=;
        b=CTzrBOU6ozp8lAdtQ0smd1m1zjSlpFi82R99gUJFRSfl+7dpmLWE0Lw7r80xVpOfaD
         j7Yc4hL8OIMGgG5kKu5lkQnoGwW5slW34LvsSNhcDFsZAdhkmirgEZE2quuD7fdsBLcX
         /objPqprnnzkz1tY8XIxW1qFCS9XF2bI0fkKZtHQPSLdSB7TIykd1YL+tMh6W818TPj9
         s5Gl3P7ej/HAMuEXTUD+4/qbQo6lwF1aPTRFwjhVImJADYAQNSrFqyA9kUVyqruqgYkY
         RNHhF2znAWpHBBV2hhwyI8yxhEPVNnMxZENUcqvqo6vIOURciKvdCRNPzbFs3ACKJOPU
         hOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761124687; x=1761729487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhkH+62s9AhGNEt/gcdilWodKjE5uLzcv1BGhnCuNyc=;
        b=P0mNrAHxGGG/8MJpC2o0XXQ1wdfiCSJUxK94qwlomT5ULzYh1KIOs8MCaw3dgHar0G
         XQliaIs8DdIGqGfRIjg/WS1dskzDbqpsyCkUt2scmprqDt6sfApTC3ze9xEgz/5N5P9y
         kbR/68M2EueQthIZwA1EudLXdh+54WFkWe/EwuAnmQ61UJldRuJ0jERrUckYjFbPQMg/
         Zjm2/De/xtLXnxYesozyd+k8aO2JXEkuFtIbYG02miYJMLWNQfuBc8uIrqx39R3cIr0L
         HQqsdZ0jXm6cg+KEA8qsXCJH9MgwQj8I3bwstN6ynElWGSsTkOv61helCynINHHYhfA6
         eTvA==
X-Forwarded-Encrypted: i=1; AJvYcCV8szPjOw/a5Xzxu2TyjyQLNXKCC7xGEPbbQIYmj1Y7hteAXfOwA8yLWMc6mtZ0/KfeyZof5w9BiXhcXi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvmqqgmcvOUqeL1jkuRgIfHDR28UugxKUq2VyluULoHl/uFfmv
	zw2IF+eUj/E+KBOqrM9d9pjThiTdTeyyGVWEVlG6Jqv1HtEnnnMt1vnh74u/N8IT80UH6ecpu9y
	W/QP0FI6bhycccIkk2XapQEoHBYhHxJg=
X-Gm-Gg: ASbGncstZncxDlh5kvjuSi8LVpHiecjitZAqSKj1Xkj9ojCbZcZoxj9lozCNuCDnh/p
	7uTIIOSIiRbbRr59QjCk/hXFVeEAyausLkgp+GCvmKfz951GMYKSd0BIRPm96ADrF7f3hh5H0fH
	JvvLk1H1ypsMIVKT05ETdZECaoLuw3ItOL5CYSzztrkVTNyfgu9YZ722TQbWJwaa9fNGrVlS9/8
	EudE6ribdV2/TFiAKlB/7PwXX9Rp4JHbQPOGHgnqCUvfKVkpoqKb4+sxc6wfIygHkAsKbbms2f1
	hAy48GMlET2Zpb0N
X-Google-Smtp-Source: AGHT+IF8ppZ20Wu/vkfm6iPYBWUkrNxb51/1c5/VT0XmJ/5FqE678G9roI4AMEu38Z7ygSJiTsaYJgwfrr18a9ZMw5I=
X-Received: by 2002:a05:620a:4710:b0:892:501a:290 with SMTP id
 af79cd13be357-892501a057amr1576601285a.86.1761124687335; Wed, 22 Oct 2025
 02:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013092038.6963-1-ying.huang@linux.alibaba.com>
 <20251013092038.6963-3-ying.huang@linux.alibaba.com> <CAGsJ_4xaA8QRjP9H=n1hQfEfGop7vOd5Y=J+KQzuOyfa8GK-kQ@mail.gmail.com>
 <87a51jfl44.fsf@DESKTOP-5N7EMDA> <CAGsJ_4zPH0fwBOLQwh1y6jG3tCXHLGRCTyVVSCWb+NfLCEMV0Q@mail.gmail.com>
 <871pmv9unr.fsf@DESKTOP-5N7EMDA>
In-Reply-To: <871pmv9unr.fsf@DESKTOP-5N7EMDA>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 22 Oct 2025 22:17:56 +1300
X-Gm-Features: AS18NWD3ObRkO5HEsMcrxUcjKoB8vtoXwTiGu2WDg5GLSA8-uJXsohVYB76Ay-4
Message-ID: <CAGsJ_4zW6ogVdi=t9JCuvGD9N21mA_ORXRCakw4Av68d9n+DDw@mail.gmail.com>
Subject: Re: [PATCH -v2 2/2] arm64, tlbflush: don't TLBI broadcast if page
 reused in write fault
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Yang Shi <yang@os.amperecomputing.com>, "Christoph Lameter (Ampere)" <cl@gentwo.org>, Dev Jain <dev.jain@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Yin Fengwei <fengwei_yin@linux.alibaba.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 10:02=E2=80=AFPM Huang, Ying
<ying.huang@linux.alibaba.com> wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> >> >
> >> > static inline void __flush_tlb_page_nosync(struct mm_struct *mm,
> >> >                                            unsigned long uaddr)
> >> > {
> >> >         unsigned long addr;
> >> >
> >> >         dsb(ishst);
> >> >         addr =3D __TLBI_VADDR(uaddr, ASID(mm));
> >> >         __tlbi(vale1is, addr);
> >> >         __tlbi_user(vale1is, addr);
> >> >         mmu_notifier_arch_invalidate_secondary_tlbs(mm, uaddr & PAGE=
_MASK,
> >> >                                                 (uaddr & PAGE_MASK) =
+
> >> > PAGE_SIZE);
> >> > }
> >>
> >> IIUC, _nosync() here means doesn't synchronize with the following code=
.
> >> It still synchronizes with the previous code, mainly the page table
> >> changing.  And, Yes.  There may be room to improve this.
> >>
> >> > On the other hand, __ptep_set_access_flags() doesn=E2=80=99t seem to=
 use
> >> > set_ptes(), so there=E2=80=99s no guarantee the updated PTEs are vis=
ible to all
> >> > cores. If a remote CPU later encounters a page fault and performs a =
TLB
> >> > invalidation, will it still see a stable PTE?
> >>
> >> I don't think so.  We just flush local TLB in local_flush_tlb_page()
> >> family functions.  So, we only needs to guarantee the page table chang=
es
> >> are available for the local page table walking.  If a page fault occur=
s
> >> on a remote CPU, we will call local_flush_tlb_page() on the remote CPU=
.
> >>
> >
> > My concern is that:
> >
> > We don=E2=80=99t have a dsb(ish) to ensure the PTE page table is visibl=
e to remote
> > CPUs, since you=E2=80=99re using dsb(nsh). So even if a remote CPU perf=
orms
> > local_flush_tlb_page(), the memory may not be synchronized yet, and it =
could
> > still see the old PTE.
>
> So, do you think that after the load/store unit of the remote CPU have
> seen the new PTE, the page table walker could still see the old PTE?  I

Without a barrier in the ish domain, remote CPUs=E2=80=99 load/store units =
may not
see the new PTE written by the first CPU performing the reuse.

That=E2=80=99s why we need a barrier in the ish domain to ensure the PTE is
actually visible across the SMP domain. A store instruction doesn=E2=80=99t=
 guarantee
that the data is immediately visible to other CPUs =E2=80=94 at least not f=
or load
instructions.

Though, I=E2=80=99m not entirely sure about the page table walker case.

> doubt it.  Even if so, the worse case is one extra spurious page fault?
> If the possibility of the worst case is low enough, that should be OK.

CPU0:                    CPU1:

write pte;

do local tlbi;

                                       page fault;
                                       do local tlbi; -> still old PTE

pte visible to CPU1

>
> Additionally, the page table lock is held when writing PTE on this CPU
> and re-reading PTE on the remote CPU.  That provides some memory order
> guarantee too.

Right, the PTL might take care of it automatically.

Thanks
Barry

