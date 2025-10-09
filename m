Return-Path: <linux-kernel+bounces-846575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1108BC8640
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 12:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B141319E5A9C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 10:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B5C2D876A;
	Thu,  9 Oct 2025 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCYGb3El"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E1E2D5922
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760004014; cv=none; b=ZpmF8zCL5nzBiuMuL/2whG1p8SKr9yhHNg7b7R6Ocmv2oEM5SOTO1SnmO6t6ZkjhON5358MAw83t+OpGDuMEaxHMEHnB/0JcVvfK5EGAXFtRbCvf88sJwsXM49u0VY/jCnV7TD19AGR4fTYflr1VEX3nLXv9nZOkIGqmq0shvbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760004014; c=relaxed/simple;
	bh=8TJVIQx/l3tg7H2NTqKn6h0/AGsIlw/e7PI7n61qOAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwsiiGH5ZwJdIoDcYfUi3Fse5n3v/tJnLcNSfd2om8R7fpXVNMYNlRNFNBB1PDgcz1Da7Q+Yv2yFpWwpc2HtXRxZtHwZ1Hp9fGeugb2YOiDDmkz2yi4xifOxHhcLUze1qG4vEwSXYKq76x4OdgyKxXVtGzj0gG+J1tRW6uURtbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCYGb3El; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-795be3a3644so4762246d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 03:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760004010; x=1760608810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsHNfh2cevZ8eaqWHX2Uah677Z7UfWqdMMb2SSbci5w=;
        b=LCYGb3El/x6hJVwuKrM6YmN29cxwycbaWoilYJHNDH9QPGkh+fCeJBSgc0MTDuGd06
         bgvHOBvtZknD5DallVlXwVGb5r0nJnrUqp5/+7UI+PMX48pcumMq71tMmnfGG39gme9v
         yg1P5fM2DfrqW63Bbgpdv+y3I5d2EFAMcQWkp/RPWmXEZ+Aw3Ue1+dc5zq+MNFrBoy8S
         grs5vl5d7u4fPTRw8SNIdkwbGK9E8O0DJEDgjJfll/7ucxgV3c2GrfszcjLXqOriLuol
         97VWdSVlZ/Qdnkvrz4AhaNd1Ay74qNihBz4augyotbUh32J7itRHBIiMv9BC1Q8gcZEe
         zpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760004010; x=1760608810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsHNfh2cevZ8eaqWHX2Uah677Z7UfWqdMMb2SSbci5w=;
        b=WBgahoI7ykKxOx5+s/VbzGAR361HZRbsoWMx0TtFCYEig58ZvO0DRiHqIzf/XVc6DD
         4REWjrOm4cnWRaXKRreKgOj50rgB7SBlGdhS894tsUrs9SCgNqxknhdeD9aQ8yIwmAaT
         50nm/IJKTPiXb5EIMrHFBFRD4MtctdskCCxxq6EYnDNpJaqDHy6Dk6KtaTW4vUH4cKhr
         SjVZ2XPXIcvX91vO4wdUBIXIIFfOdkAtBiPQeEcaljbqiiNGw76TqbJ5qeFkfRZG3Obv
         mjEkNGtT3ZDCFoaOywMvAJG5vXclwlIAhcYVebn8t1wgA7eIX9rw/950yUlmEpZigf7V
         aR9w==
X-Forwarded-Encrypted: i=1; AJvYcCUJQLrrodQDQHSacYhx8BTjjR18TJ6dFsefC7Qi9BPf5syVwjIu3bFYZ7xH+IuLXKLfHEG6WPo49TJk7Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgXuWm0N9Y8o0rsqS8uP8HglVoQj3v2OGm/IdeyK0fn/+iKRac
	Wp8qru8rIiOJ4v9x4TKqXKNZgHxMLPA2pCKBmLP21n6m9UBsqDt6IBa/BrgE2JZLb9V6ZcSxN8r
	cJTFfAxbyvvulgblg6yKnrpbtNd4/HT0=
X-Gm-Gg: ASbGnctH8vQpZ1/wLiXLSrguDH1CSZ+Pz6shLPVgFTXf84mbgUn43wrMOxrxc1xs7DX
	t7+68aSwTmQChbD8upOFjo1pYyA9spUGdafPBzNfCNL3cWBDAWs+p9QZUkAB1nnaG8/8OyNp/k2
	5/5NR3tmJkUpXzFe5FAJb1mgagI70q437WDEWh9E0A4Xs1zh+KUJ8hLdMfaGsVSOJj3dZ89ONW5
	61VTPRU3Zm/8valPbLXTTFKvT9WgzwUzr3oNdx7BU6QBOyHoUKDFLhmJGToOvC5QrzX2jaLJcxS
	zud5oM/7Ag==
X-Google-Smtp-Source: AGHT+IETxQVsMJZ6FUrqxCOJXTq/1lBKlldBdCCphIo2WiWqP2OQZ5MBwrkw2Mvl/zoM5NqKDP1WjJ0VU5dCT5Ozh/c=
X-Received: by 2002:a05:6214:4003:b0:850:d233:62ab with SMTP id
 6a1803df08f44-87b2ef73213mr99406266d6.63.1760004010105; Thu, 09 Oct 2025
 03:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930055826.9810-1-laoar.shao@gmail.com> <20250930055826.9810-4-laoar.shao@gmail.com>
 <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com>
 <27e002e3-b39f-40f9-b095-52da0fbd0fc7@redhat.com> <CALOAHbBFNNXHdzp1zNuD530r9ZjpQF__wGWyAdR7oDLvemYSMw@mail.gmail.com>
 <7723a2c7-3750-44f7-9eb5-4ef64b64fbb8@redhat.com> <CALOAHbD_tRSyx1LXKfFrUriH6BcRS6Hw9N1=KddCJpgXH8vZug@mail.gmail.com>
 <96AE1C18-3833-4EB8-9145-202517331DF5@nvidia.com> <f743cfcd-2467-42c5-9a3c-3dceb6ff7aa8@redhat.com>
 <CALOAHbAY9sjG-M=nwWRdbp3_m2cx_YJCb7DToaXn-kHNV+A5Zg@mail.gmail.com> <129379f6-18c7-4d10-8241-8c6c5596d6d5@redhat.com>
In-Reply-To: <129379f6-18c7-4d10-8241-8c6c5596d6d5@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 9 Oct 2025 17:59:33 +0800
X-Gm-Features: AS18NWBlPtBCYqodlkqsQpTW3fhlgQOczuwvYOS9Vl81gX2DcaljddI-xWUUb9I
Message-ID: <CALOAHbD8ko104PEFHPYjvnhKL50XTtpbHL_ehTLCCwSX0HG3-A@mail.gmail.com>
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	baolin.wang@linux.alibaba.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	Matthew Wilcox <willy@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Amery Hung <ameryhung@gmail.com>, David Rientjes <rientjes@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, 21cnbao@gmail.com, Shakeel Butt <shakeel.butt@linux.dev>, 
	Tejun Heo <tj@kernel.org>, lance.yang@linux.dev, Randy Dunlap <rdunlap@infradead.org>, 
	bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 5:19=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 08.10.25 15:11, Yafang Shao wrote:
> > On Wed, Oct 8, 2025 at 8:07=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 08.10.25 13:27, Zi Yan wrote:
> >>> On 8 Oct 2025, at 5:04, Yafang Shao wrote:
> >>>
> >>>> On Wed, Oct 8, 2025 at 4:28=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> >>>>>
> >>>>> On 08.10.25 10:18, Yafang Shao wrote:
> >>>>>> On Wed, Oct 8, 2025 at 4:08=E2=80=AFPM David Hildenbrand <david@re=
dhat.com> wrote:
> >>>>>>>
> >>>>>>> On 03.10.25 04:18, Alexei Starovoitov wrote:
> >>>>>>>> On Mon, Sep 29, 2025 at 10:59=E2=80=AFPM Yafang Shao <laoar.shao=
@gmail.com> wrote:
> >>>>>>>>>
> >>>>>>>>> +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *v=
ma,
> >>>>>>>>> +                                     enum tva_type type,
> >>>>>>>>> +                                     unsigned long orders)
> >>>>>>>>> +{
> >>>>>>>>> +       thp_order_fn_t *bpf_hook_thp_get_order;
> >>>>>>>>> +       int bpf_order;
> >>>>>>>>> +
> >>>>>>>>> +       /* No BPF program is attached */
> >>>>>>>>> +       if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> >>>>>>>>> +                     &transparent_hugepage_flags))
> >>>>>>>>> +               return orders;
> >>>>>>>>> +
> >>>>>>>>> +       rcu_read_lock();
> >>>>>>>>> +       bpf_hook_thp_get_order =3D rcu_dereference(bpf_thp.thp_=
get_order);
> >>>>>>>>> +       if (WARN_ON_ONCE(!bpf_hook_thp_get_order))
> >>>>>>>>> +               goto out;
> >>>>>>>>> +
> >>>>>>>>> +       bpf_order =3D bpf_hook_thp_get_order(vma, type, orders)=
;
> >>>>>>>>> +       orders &=3D BIT(bpf_order);
> >>>>>>>>> +
> >>>>>>>>> +out:
> >>>>>>>>> +       rcu_read_unlock();
> >>>>>>>>> +       return orders;
> >>>>>>>>> +}
> >>>>>>>>
> >>>>>>>> I thought I explained it earlier.
> >>>>>>>> Nack to a single global prog approach.
> >>>>>>>
> >>>>>>> I agree. We should have the option to either specify a policy glo=
bally,
> >>>>>>> or more refined for cgroups/processes.
> >>>>>>>
> >>>>>>> It's an interesting question if a program would ever want to ship=
 its
> >>>>>>> own policy: I can see use cases for that.
> >>>>>>>
> >>>>>>> So I agree that we should make it more flexible right from the st=
art.
> >>>>>>
> >>>>>> To achieve per-process granularity, the struct-ops must be embedde=
d
> >>>>>> within the mm_struct as follows:
> >>>>>>
> >>>>>> +#ifdef CONFIG_BPF_MM
> >>>>>> +struct bpf_mm_ops {
> >>>>>> +#ifdef CONFIG_BPF_THP
> >>>>>> +       struct bpf_thp_ops bpf_thp;
> >>>>>> +#endif
> >>>>>> +};
> >>>>>> +#endif
> >>>>>> +
> >>>>>>     /*
> >>>>>>      * Opaque type representing current mm_struct flag state. Must=
 be accessed via
> >>>>>>      * mm_flags_xxx() helper functions.
> >>>>>> @@ -1268,6 +1281,10 @@ struct mm_struct {
> >>>>>>     #ifdef CONFIG_MM_ID
> >>>>>>                    mm_id_t mm_id;
> >>>>>>     #endif /* CONFIG_MM_ID */
> >>>>>> +
> >>>>>> +#ifdef CONFIG_BPF_MM
> >>>>>> +               struct bpf_mm_ops bpf_mm;
> >>>>>> +#endif
> >>>>>>            } __randomize_layout;
> >>>>>>
> >>>>>> We should be aware that this will involve extensive changes in mm/=
.
> >>>>>
> >>>>> That's what we do on linux-mm :)
> >>>>>
> >>>>> It would be great to use Alexei's feedback/experience to come up wi=
th
> >>>>> something that is flexible for various use cases.
> >>>>
> >>>> I'm still not entirely convinced that allowing individual processes =
or
> >>>> cgroups to run independent progs is a valid use case. However, since
> >>>> we have a consensus that this is the right direction, I will proceed
> >>>> with this approach.
> >>>>
> >>>>>
> >>>>> So I think this is likely the right direction.
> >>>>>
> >>>>> It would be great to evaluate which scenarios we could unlock with =
this
> >>>>> (global vs. per-process vs. per-cgroup) approach, and how
> >>>>> extensive/involved the changes will be.
> >>>>
> >>>> 1. Global Approach
> >>>>      - Pros:
> >>>>        Simple;
> >>>>        Can manage different THP policies for different cgroups or pr=
ocesses.
> >>>>     - Cons:
> >>>>        Does not allow individual processes to run their own BPF prog=
rams.
> >>>>
> >>>> 2. Per-Process Approach
> >>>>       - Pros:
> >>>>         Enables each process to run its own BPF program.
> >>>>       - Cons:
> >>>>         Introduces significant complexity, as it requires handling t=
he
> >>>> BPF program's lifecycle (creation, destruction, inheritance) within
> >>>> every mm_struct.
> >>>>
> >>>> 3. Per-Cgroup Approach
> >>>>       - Pros:
> >>>>          Allows individual cgroups to run their own BPF programs.
> >>>>          Less complex than the per-process model, as it can leverage=
 the
> >>>> existing cgroup operations structure.
> >>>>       - Cons:
> >>>>          Creates a dependency on the cgroup subsystem.
> >>>>          might not be easy to control at the per-process level.
> >>>
> >>> Another issue is that how and who to deal with hierarchical cgroup, w=
here one
> >>> cgroup is a parent of another. Should bpf program to do that or mm co=
de
> >>> to do that? I remember hierarchical cgroup is the main reason THP con=
trol
> >>> at cgroup level is rejected. If we do per-cgroup bpf control, wouldn'=
t we
> >>> get the same rejection from cgroup folks?
> >>
> >> Valid point.
> >>
> >> I do wonder if that problem was already encountered elsewhere with bpf
> >> and if there is already a solution.
> >
> > Our standard is to run only one instance of a BPF program type
> > system-wide to avoid conflicts. For example, we can't have both
> > systemd and a container runtime running bpf-thp simultaneously.
>
> Right, it's a good question how to combine policies, or "who wins".

From my perspective, the ideal approach is to have one BPF-THP
instance per mm_struct. This allows for separate managers in different
domains, such as systemd managing BPF-THP for system processes and
containerd for container processes, while ensuring that any single
process is managed by only one BPF-THP.

>
> >
> > Perhaps Alexei can enlighten us, though we'd need to read between his
> > characteristically brief lines. ;-)
>
> There might be some insights to be had in the bpf OOM discussion at
>
> https://lkml.kernel.org/r/CAEf4BzafXv-PstSAP6krers=3DS74ri1+zTB4Y2oT6f+33=
yznqsA@mail.gmail.com
>
> I didn't completely read through that, but that discussion also seems to
> be about interaction between cgroups and bpd programs.

I have reviewed the discussions.

Given that the OOM might be cgroup-specific, implementing a
cgroup-based BPF-OOM handler makes sense.

--=20
Regards
Yafang

