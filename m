Return-Path: <linux-kernel+bounces-845491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE6DBC5259
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360781898DBF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAE527E1AC;
	Wed,  8 Oct 2025 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfzQuLW2"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7A1A31
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929139; cv=none; b=Wh//9l4bhMc7SFg282yigKr+2S8agbX00AP+dfVx+oAU/i2ThSAs/MjRJdNn/BNXAjydAFZ7jROTiJKEi97hYIWbJBpYLd44mI23s3DDMqP72HceZDZuPB6zvo6MIqWzRnnBDUnf70qT8NhtlwCi2PyLp8rj8bDQ+cTBz+FGAS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929139; c=relaxed/simple;
	bh=xpmGg4c/Cl5ZY8pMnlzNFA1QPQP86/btg3j7tq3p2As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRyBIKbrt7htuxAlrEm/eD+eQZTX8/YzmrAFPgB27PmVVAtQbPLNfszQ/lC0NjJIyGNBvgoxrDDeC8Co0o+fbYQJB1epZDkoAqMeSZ0HizFrclQLSzOD9fWLsSoVl5/MXbb01ds8BcI6rbrPLWVHBMinfFf2bB89c5Xcj9PZEfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfzQuLW2; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-7900f7f4ba9so71750516d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 06:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759929137; x=1760533937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBKwa75rcl5jnXtV/oS/WIGH19YZKQyj0WoGa9cCm+I=;
        b=AfzQuLW26qLV0TO7J0YgyYvNWLNPTP+63uUk5+wQH7LcU/y06cOHO92q/9QCxgyLIs
         ZJTMMMjbd8kzYT4Wl2KaPQN6rAx3z90MAKJhYUq+9XN2QhfKkRnumtDWq+DtL92JK/x/
         D9+qjNLJBHIZoUy5HTjCnuQ7cxrYCPCDIIJiH+yJJxBMHC+00Tm6qU1ZaNa5GTO0ed0T
         JLHc0ZOOrJ+AvvfjAI4SYHWfJe6IX3ol1dyGJRPNJOJhN9a+Xqr+BvSISEvrdluc4ly0
         +/SaJCpENX8XbfSwnGTgUtfTbUzeConzbS/GEclFORfYcLkBx5nLayKmf4qiYKqeBgoe
         syyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759929137; x=1760533937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBKwa75rcl5jnXtV/oS/WIGH19YZKQyj0WoGa9cCm+I=;
        b=KY538CqCsjWIdQghLHUor2BRY43RhtffMVCtaa7iNwdT3IbrqlIv4nZE2XDjy8/Oud
         tY8+VZ0y94F13qREPWbeTa8S0lj+nI094+4N6hPUW0C4xNzvSHxD3I68fHZywuYLUiFP
         lhE/RcCsy62qm6rlzU1NdRiMSYicsE6D7YKz9y+SvZ5kiuMDHN8fFdUYFQytWZqxVtsl
         qdQOjBtUWyam00NR5fMHIwZXsEIiC4gN0LJk1tl3ylyrzx3DgpmN0R3aIUqjShYmlmj6
         VLuxgTPOEhnmbdEyYvq1zHWti41Kuzp65NyX9fL0o8442tzOHdqpFqLMsL7eTbuB+0dv
         uXMg==
X-Forwarded-Encrypted: i=1; AJvYcCVD3T6Yj9fwWiOzjKG7TsBACH1j2H2OA7aoR3lcGNoXg3AfkJ6Gx6TAotP/tl+8jXY2bVH4CYJSE/OdWNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YweBQQb0NotYWKMoOyOq1Z3nnf3Qj2wjwItoz6khXgDdT23fz58
	bchTUdq78HfY9df8bGGPElBY6bItSj27ICEUO4ilTcz8Q1nMEya7pfpYnbVxdwGYuSTWTmU1guJ
	p9GKmemvA10lu02BX0pkel2IPeJSEHdM=
X-Gm-Gg: ASbGncv5eyAM0ZUN0wiSP65CgbdYkiugasmnZLzrb0Is0aJMxDeBF4GNeegpMDSC35k
	OyqPWOoT5jnMjQi4xI/WJFxmUmGfsAFXtnN1Smo7Yb2QvtNuAAd44edzEWj328RxIsjqGQbvq4F
	FN1Z6TiMGA2PflcCGUz/Z0CIomBfoBjbk62QibC/g9lepEuMLOTBQqypdj0EKWd/ar0cfygRwtr
	ter75YQY44o/Rw04SDwqiVJQEvJJ2aSKVNqWPAwRJlrLYz/yhB/2U55fGvMi6yzFS2y/ken670=
X-Google-Smtp-Source: AGHT+IFzUXffB1zB7vnWpuKrlcQPdtVGJfSjZp7EPf6PBL/bCYvn3+y9LWXlhXOmcWWw4fXUcxkyECmMdiurn0kjvhs=
X-Received: by 2002:a05:6214:268b:b0:796:6034:c0fb with SMTP id
 6a1803df08f44-87b20ff9e9fmr42443166d6.13.1759929136653; Wed, 08 Oct 2025
 06:12:16 -0700 (PDT)
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
In-Reply-To: <f743cfcd-2467-42c5-9a3c-3dceb6ff7aa8@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 8 Oct 2025 21:11:39 +0800
X-Gm-Features: AS18NWAfLSZj5vVPHQEFQdqoJ0RU1U5dgEf--oeMfkY_sJP1b_wNMDZYIuMpIdc
Message-ID: <CALOAHbAY9sjG-M=nwWRdbp3_m2cx_YJCb7DToaXn-kHNV+A5Zg@mail.gmail.com>
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

On Wed, Oct 8, 2025 at 8:07=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 08.10.25 13:27, Zi Yan wrote:
> > On 8 Oct 2025, at 5:04, Yafang Shao wrote:
> >
> >> On Wed, Oct 8, 2025 at 4:28=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>>
> >>> On 08.10.25 10:18, Yafang Shao wrote:
> >>>> On Wed, Oct 8, 2025 at 4:08=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> >>>>>
> >>>>> On 03.10.25 04:18, Alexei Starovoitov wrote:
> >>>>>> On Mon, Sep 29, 2025 at 10:59=E2=80=AFPM Yafang Shao <laoar.shao@g=
mail.com> wrote:
> >>>>>>>
> >>>>>>> +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma=
,
> >>>>>>> +                                     enum tva_type type,
> >>>>>>> +                                     unsigned long orders)
> >>>>>>> +{
> >>>>>>> +       thp_order_fn_t *bpf_hook_thp_get_order;
> >>>>>>> +       int bpf_order;
> >>>>>>> +
> >>>>>>> +       /* No BPF program is attached */
> >>>>>>> +       if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> >>>>>>> +                     &transparent_hugepage_flags))
> >>>>>>> +               return orders;
> >>>>>>> +
> >>>>>>> +       rcu_read_lock();
> >>>>>>> +       bpf_hook_thp_get_order =3D rcu_dereference(bpf_thp.thp_ge=
t_order);
> >>>>>>> +       if (WARN_ON_ONCE(!bpf_hook_thp_get_order))
> >>>>>>> +               goto out;
> >>>>>>> +
> >>>>>>> +       bpf_order =3D bpf_hook_thp_get_order(vma, type, orders);
> >>>>>>> +       orders &=3D BIT(bpf_order);
> >>>>>>> +
> >>>>>>> +out:
> >>>>>>> +       rcu_read_unlock();
> >>>>>>> +       return orders;
> >>>>>>> +}
> >>>>>>
> >>>>>> I thought I explained it earlier.
> >>>>>> Nack to a single global prog approach.
> >>>>>
> >>>>> I agree. We should have the option to either specify a policy globa=
lly,
> >>>>> or more refined for cgroups/processes.
> >>>>>
> >>>>> It's an interesting question if a program would ever want to ship i=
ts
> >>>>> own policy: I can see use cases for that.
> >>>>>
> >>>>> So I agree that we should make it more flexible right from the star=
t.
> >>>>
> >>>> To achieve per-process granularity, the struct-ops must be embedded
> >>>> within the mm_struct as follows:
> >>>>
> >>>> +#ifdef CONFIG_BPF_MM
> >>>> +struct bpf_mm_ops {
> >>>> +#ifdef CONFIG_BPF_THP
> >>>> +       struct bpf_thp_ops bpf_thp;
> >>>> +#endif
> >>>> +};
> >>>> +#endif
> >>>> +
> >>>>    /*
> >>>>     * Opaque type representing current mm_struct flag state. Must be=
 accessed via
> >>>>     * mm_flags_xxx() helper functions.
> >>>> @@ -1268,6 +1281,10 @@ struct mm_struct {
> >>>>    #ifdef CONFIG_MM_ID
> >>>>                   mm_id_t mm_id;
> >>>>    #endif /* CONFIG_MM_ID */
> >>>> +
> >>>> +#ifdef CONFIG_BPF_MM
> >>>> +               struct bpf_mm_ops bpf_mm;
> >>>> +#endif
> >>>>           } __randomize_layout;
> >>>>
> >>>> We should be aware that this will involve extensive changes in mm/.
> >>>
> >>> That's what we do on linux-mm :)
> >>>
> >>> It would be great to use Alexei's feedback/experience to come up with
> >>> something that is flexible for various use cases.
> >>
> >> I'm still not entirely convinced that allowing individual processes or
> >> cgroups to run independent progs is a valid use case. However, since
> >> we have a consensus that this is the right direction, I will proceed
> >> with this approach.
> >>
> >>>
> >>> So I think this is likely the right direction.
> >>>
> >>> It would be great to evaluate which scenarios we could unlock with th=
is
> >>> (global vs. per-process vs. per-cgroup) approach, and how
> >>> extensive/involved the changes will be.
> >>
> >> 1. Global Approach
> >>     - Pros:
> >>       Simple;
> >>       Can manage different THP policies for different cgroups or proce=
sses.
> >>    - Cons:
> >>       Does not allow individual processes to run their own BPF program=
s.
> >>
> >> 2. Per-Process Approach
> >>      - Pros:
> >>        Enables each process to run its own BPF program.
> >>      - Cons:
> >>        Introduces significant complexity, as it requires handling the
> >> BPF program's lifecycle (creation, destruction, inheritance) within
> >> every mm_struct.
> >>
> >> 3. Per-Cgroup Approach
> >>      - Pros:
> >>         Allows individual cgroups to run their own BPF programs.
> >>         Less complex than the per-process model, as it can leverage th=
e
> >> existing cgroup operations structure.
> >>      - Cons:
> >>         Creates a dependency on the cgroup subsystem.
> >>         might not be easy to control at the per-process level.
> >
> > Another issue is that how and who to deal with hierarchical cgroup, whe=
re one
> > cgroup is a parent of another. Should bpf program to do that or mm code
> > to do that? I remember hierarchical cgroup is the main reason THP contr=
ol
> > at cgroup level is rejected. If we do per-cgroup bpf control, wouldn't =
we
> > get the same rejection from cgroup folks?
>
> Valid point.
>
> I do wonder if that problem was already encountered elsewhere with bpf
> and if there is already a solution.

Our standard is to run only one instance of a BPF program type
system-wide to avoid conflicts. For example, we can't have both
systemd and a container runtime running bpf-thp simultaneously.

Perhaps Alexei can enlighten us, though we'd need to read between his
characteristically brief lines. ;-)

>
> Focusing on processes instead of cgroups might be easier initially.


--=20
Regards
Yafang

