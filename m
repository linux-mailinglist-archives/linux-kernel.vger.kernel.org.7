Return-Path: <linux-kernel+bounces-845236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C269BBC41CA
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 11:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F574015D7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 09:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956662F7ACA;
	Wed,  8 Oct 2025 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBa4EzJy"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7642F5A1D
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914324; cv=none; b=sjqXPPujm/9W0372HOBdZ+rNxJQtAyCowxltHmo2ztoeBNJ7XeLWZqWxJo8OX4AwPNlVDQM1U2RmxXiM7Cyay+etflkKsY51s6BbYnwaFxzWfgNV2JRZCuaCCgq08XiG6IQcORX9ht4BvvKoRfMUxH0kG9UzO6sqi3pCT4DESrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914324; c=relaxed/simple;
	bh=O5jvZp7YSs8BkOVk59YxrtO8UmzmgVwYrqDwI5aX2fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNcoZrgb/7jJZmMpSsVxIYKF5S2zzj8LbsTB/lzKQebQqcOPY4f9eMX1Z+8Lwsh2Dnt4Gf1L/0TUXMD7UArPPzZHGm8dgMZaVRyd9+izg1Rsx90RtQwDl7gn3BvwEV+ON5Ccnsh384BNzor6BPFGNqPURFPxKpgZOdK/qmYqv8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBa4EzJy; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-79a7d439efbso66322786d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 02:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759914322; x=1760519122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4cYZmadA8mCAkJgxHGzRBrmoQCHtUHFnir9NGk0Mxs=;
        b=aBa4EzJy3HlZhHVePegvhxnRl7flkQOGJ/1AmPgYErrVPZfQvHFkdziSsmQH86SM6a
         iIuVUgsuYKehSCBk3V8Mx45VOBL55/l2fhtlTTLlgrpEWU3SCfitYCAYmbiJvdK5Ss5l
         paReAFa7Lw+75k4kX4+33hjoL8BBc6TOy2xtY9dyo2QlZCZWEEc2qbWbYdb+IHYK2S9L
         tAy/Ue3/7RuHDvUDMLTITnO04UMWQ41X6rlwAixbA8ZAZgZqjD7z0bR0axnFwXt6mIIv
         zInx0EdhWi+2ZILUVyXAI/W9PEiMUjOSlom4V6S4Dh5aGasiqLSr3t58HprtyGmjgW0W
         MfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759914322; x=1760519122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4cYZmadA8mCAkJgxHGzRBrmoQCHtUHFnir9NGk0Mxs=;
        b=d+7rJd74ar2PNvU8eeEKtsF9NjPLRxUjDPjISnUv54DePNCYYk1n3V3eHs3kK8liE4
         6t7BG9yjKvitKQASe9tGknktG8//4M9wYW1zsTuePnMRs5XIr7v177WVRV5rXAmc6Hfo
         hM5kicYVBt4S8Mhba0TQ8z4tBeISKPuNJD8eRo1BjR+4rJF99oN7Up7gR5fr+An3xp8P
         wHdijN11r/ooSzn3PBT0btXzxVJlfTU2Dp81cg1dCUeunmpxDUuYmvYsUUtXvPdbO+hO
         nA53FjA+bVKru76nD7z1Ag+HM6Vbd3t4dhJ/OPysyqwinXTOARMcXC3cyH0EIt+X+Ec2
         1JJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWkdlTO+v/IbD6ECYhmOS+tZee88fLhdTJX4LRVFwUL86vKk1OirgQRP8S2CJEWR30wDue4W2TKc2K42o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQvfWuIaXV7GWFIZSRkPCsSIYuAnTtoOj0NiX5a71YEeD02bJ1
	5SaMwJTTEHuPDKdKq6983xnnIMeSp7yp9pJjSC2d/OFnYQZm2JZ5PmDD0a0hQ2Gopn18cD3byQj
	oZ/gE26ReKYLLACRhLkn8T7DVfsOSpOI=
X-Gm-Gg: ASbGncsxQOknhwA/7QoKwBTxQjh7OQt5hCfY8gsq1LbRtnf8NoWn4fnY512n6/DbviF
	YUAMRZTfR0z3Z685sIv2KsHOgJoBfYrJk4BK0cwheZFI9kiO3RjOopLSeja6OmAV0rZmHiejW/s
	jgaMYdVggWxsmAuvPqAoUWniU6fM6/DwT/nYlFWMFtYuKY2RhQLrkO1h6NNIWbUDTgu5fsbEG5/
	GjHUioJFw46DEcmmGr/Jg+xm902PKsXNIUrCgosB3MCn3kONK5ol2JNZe/4BQPj
X-Google-Smtp-Source: AGHT+IFtF/lJgRUwcJ1lVxRX1vX8QykTlCWe2klEiz/B5NPbX3cSQGIv9tHJapmtZwhENtdJSXzQ5eGIRt0iWburmhc=
X-Received: by 2002:a05:6214:2a8a:b0:782:1086:f659 with SMTP id
 6a1803df08f44-87b2107dd72mr31942296d6.26.1759914321370; Wed, 08 Oct 2025
 02:05:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930055826.9810-1-laoar.shao@gmail.com> <20250930055826.9810-4-laoar.shao@gmail.com>
 <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com>
 <27e002e3-b39f-40f9-b095-52da0fbd0fc7@redhat.com> <CALOAHbBFNNXHdzp1zNuD530r9ZjpQF__wGWyAdR7oDLvemYSMw@mail.gmail.com>
 <7723a2c7-3750-44f7-9eb5-4ef64b64fbb8@redhat.com>
In-Reply-To: <7723a2c7-3750-44f7-9eb5-4ef64b64fbb8@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 8 Oct 2025 17:04:44 +0800
X-Gm-Features: AS18NWAJwXG18rE8UjAVYGwSMRoVGqsV4lXBJi6ePSpLgxcjj8cRCthEf3HoP2g
Message-ID: <CALOAHbD_tRSyx1LXKfFrUriH6BcRS6Hw9N1=KddCJpgXH8vZug@mail.gmail.com>
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
To: David Hildenbrand <david@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, Johannes Weiner <hannes@cmpxchg.org>, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	Matthew Wilcox <willy@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Amery Hung <ameryhung@gmail.com>, David Rientjes <rientjes@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, 21cnbao@gmail.com, Shakeel Butt <shakeel.butt@linux.dev>, 
	Tejun Heo <tj@kernel.org>, lance.yang@linux.dev, Randy Dunlap <rdunlap@infradead.org>, 
	bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 4:28=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 08.10.25 10:18, Yafang Shao wrote:
> > On Wed, Oct 8, 2025 at 4:08=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 03.10.25 04:18, Alexei Starovoitov wrote:
> >>> On Mon, Sep 29, 2025 at 10:59=E2=80=AFPM Yafang Shao <laoar.shao@gmai=
l.com> wrote:
> >>>>
> >>>> +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
> >>>> +                                     enum tva_type type,
> >>>> +                                     unsigned long orders)
> >>>> +{
> >>>> +       thp_order_fn_t *bpf_hook_thp_get_order;
> >>>> +       int bpf_order;
> >>>> +
> >>>> +       /* No BPF program is attached */
> >>>> +       if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> >>>> +                     &transparent_hugepage_flags))
> >>>> +               return orders;
> >>>> +
> >>>> +       rcu_read_lock();
> >>>> +       bpf_hook_thp_get_order =3D rcu_dereference(bpf_thp.thp_get_o=
rder);
> >>>> +       if (WARN_ON_ONCE(!bpf_hook_thp_get_order))
> >>>> +               goto out;
> >>>> +
> >>>> +       bpf_order =3D bpf_hook_thp_get_order(vma, type, orders);
> >>>> +       orders &=3D BIT(bpf_order);
> >>>> +
> >>>> +out:
> >>>> +       rcu_read_unlock();
> >>>> +       return orders;
> >>>> +}
> >>>
> >>> I thought I explained it earlier.
> >>> Nack to a single global prog approach.
> >>
> >> I agree. We should have the option to either specify a policy globally=
,
> >> or more refined for cgroups/processes.
> >>
> >> It's an interesting question if a program would ever want to ship its
> >> own policy: I can see use cases for that.
> >>
> >> So I agree that we should make it more flexible right from the start.
> >
> > To achieve per-process granularity, the struct-ops must be embedded
> > within the mm_struct as follows:
> >
> > +#ifdef CONFIG_BPF_MM
> > +struct bpf_mm_ops {
> > +#ifdef CONFIG_BPF_THP
> > +       struct bpf_thp_ops bpf_thp;
> > +#endif
> > +};
> > +#endif
> > +
> >   /*
> >    * Opaque type representing current mm_struct flag state. Must be acc=
essed via
> >    * mm_flags_xxx() helper functions.
> > @@ -1268,6 +1281,10 @@ struct mm_struct {
> >   #ifdef CONFIG_MM_ID
> >                  mm_id_t mm_id;
> >   #endif /* CONFIG_MM_ID */
> > +
> > +#ifdef CONFIG_BPF_MM
> > +               struct bpf_mm_ops bpf_mm;
> > +#endif
> >          } __randomize_layout;
> >
> > We should be aware that this will involve extensive changes in mm/.
>
> That's what we do on linux-mm :)
>
> It would be great to use Alexei's feedback/experience to come up with
> something that is flexible for various use cases.

I'm still not entirely convinced that allowing individual processes or
cgroups to run independent progs is a valid use case. However, since
we have a consensus that this is the right direction, I will proceed
with this approach.

>
> So I think this is likely the right direction.
>
> It would be great to evaluate which scenarios we could unlock with this
> (global vs. per-process vs. per-cgroup) approach, and how
> extensive/involved the changes will be.

1. Global Approach
   - Pros:
     Simple;
     Can manage different THP policies for different cgroups or processes.
  - Cons:
     Does not allow individual processes to run their own BPF programs.

2. Per-Process Approach
    - Pros:
      Enables each process to run its own BPF program.
    - Cons:
      Introduces significant complexity, as it requires handling the
BPF program's lifecycle (creation, destruction, inheritance) within
every mm_struct.

3. Per-Cgroup Approach
    - Pros:
       Allows individual cgroups to run their own BPF programs.
       Less complex than the per-process model, as it can leverage the
existing cgroup operations structure.
    - Cons:
       Creates a dependency on the cgroup subsystem.
       might not be easy to control at the per-process level.

>
> If we need a slot in the bi-weekly mm alignment session to brainstorm,
> we can ask Dave R. for one in the upcoming weeks.

I will draft an RFC to outline the required changes in both the mm/
and bpf/ subsystems and solicit feedback.

--
Regards
Yafang

