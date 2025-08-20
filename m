Return-Path: <linux-kernel+bounces-778435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B74B2E5AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6A65E28A6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59EC2566D9;
	Wed, 20 Aug 2025 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q+sL2jbd"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED3836CE0C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 19:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755718512; cv=none; b=fETRnMUbpXPMbBS+pAAiLCfNagaEPn9gZAvuGg0X3EPAle7wLC6FVR6GrQhumKNu3ngJS22G83BfQ80HxovoTQv69aW/JpTOwJA4j0Z1WpRFAQXe8Ftlvq+lkpAKNfzaKQ/ELuc7F3qwUSoMc54p0vKHOgi6wflEAUev95b5Coo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755718512; c=relaxed/simple;
	bh=724Pm1JzuyehnhHNNGfp0UqBoyTRlg3w1zTn+Nadb4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmExeCVexTLa+igFnnPaHYqi23YRp751H6Z5T/4jPQIAOsUeXFi4bLvQev0MDc8+45TSq2Rdf8q4MDftch46nBwesQLttZlWA/NjZOaMuUj1aj88OKsmpu7aGwDqt4a438iegpPOwj6N3m6T8/DfgqnLJwDS2CJ6A349pPL71cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q+sL2jbd; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b29b714f8cso5021cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755718510; x=1756323310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Evl1Qwbb+l1iM9nDGqJDyJclUZR7xH02IVWIEnkyQLs=;
        b=Q+sL2jbdrz33Y981fRtFAYIweXzTVfrhsXkrcObAnHQE8GOuP5jCXdvbqcm+a+Oo65
         3SYCXp+hwpCEdTJMKA0S54fZbna9LcD4J+DVCIkK8DEyDGR4H/nLrsFrtIPF7QFDNqSG
         zk/MimBFZ/5JVGrlFwM/8nVaQYu5/7bQ3Fe9zBSPQygePXOBL4CBdnnEk5mmN1S8t+An
         WTFdfGQeYN6czdXPtkC7xgv8xaFLr0l5r/OcWh0VVE3BIPAmWzAhEGqyiUfSUsuD86M3
         FgALKV+/9EWwG66rd5h5l5momdlGx4PgfprgWCfy9Z6quOp3kyJbYln15qA2f/yQpi61
         PDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755718510; x=1756323310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Evl1Qwbb+l1iM9nDGqJDyJclUZR7xH02IVWIEnkyQLs=;
        b=wTHN/0u9qFQcuSQdVFuELH7dqtpn78QolGLcVhiC4yrDytpRckQZgRxnQYj+tu76G+
         dHFSqbYxUQwN4saji+MVAQ6+4Oj1M20WTom+QEYk/MFGOclH04lLiMLTR+VgMQ62KP21
         US3GOXhQADAp0kLvR3NjOc2qo3bzumD0dD38NKGEJMliDAgJRYbFNrgaBXbuodvLU8AT
         GNVBgpiepYVWZ65nCnQMUY+RXjnvtYGsvb0RnGDVsM7AwUleB5/Hkw0T8wc6SnCZbdtT
         LxupxcPLtxE4MI0V7UzMJ/MkwUkT6icFvq7Ab4TTqT9n0KiKFnj32lVuJO6QuYc+EX1g
         hXgA==
X-Forwarded-Encrypted: i=1; AJvYcCXeO639R8sVGkdnUBUQwL2l3QrRyfjKCLgcbMgV2NxIgcJFNpHiyrSnLQXl1TpdcATpiHFb1SoB5fOQfrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ5gPClva9hUbHwMD2xSq8Uam6mToTowVBHTM7z9ML2LedU4K+
	83NZQeYI+16krr9BTeAHt3SoX6TceQ2UqwcwpRFWvGBFKTmfMuNHZypaox+G5hmiIw/4uZpk9tW
	RYNvIy5JwTBtMFkPkfzKspYpOOIU9AyOhZjdPA0Ff
X-Gm-Gg: ASbGncv3MoRo7T7s0uFbvwUUgdncFG79Pkz9wT099/B9nWV+OhAvhj6ZCi6bdWabom0
	87LROFoMPnYBlMR0AJIvrkulmYC5tY/F7RFtoj8h4+M3huLb4sp7w+DlzIxp9SANzH7QKtX+6LR
	3Tlsccvrk7Kcx/c3Wpiwbo+AcWt0cyuNKsXZ1D2w5nV1W+eFh5sXx8UjYmJtG5X5lsFGLtLH/OJ
	D7H9/5Er+XFjtUA834b5+5s8nYyhIFimKn4ebLBTaRw
X-Google-Smtp-Source: AGHT+IHSq8YXOQCNZxVS8duDt8m8HWxXwke/qw5jSQBhWJsNAWDqDV4rrLkFdrONxwsGMw/pL8xCe6+zvaHaKX8Q7x8=
X-Received: by 2002:ac8:580f:0:b0:4a7:179e:5fec with SMTP id
 d75a77b69052e-4b29e713c4bmr816881cf.15.1755718509381; Wed, 20 Aug 2025
 12:35:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
 <20250818170136.209169-2-roman.gushchin@linux.dev> <CAJuCfpF2akVnbZgPoDAXea2joJ1DWvBTHC7wGzEJcYX9xF9dSA@mail.gmail.com>
 <878qjf13gx.fsf@linux.dev>
In-Reply-To: <878qjf13gx.fsf@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 20 Aug 2025 12:34:56 -0700
X-Gm-Features: Ac12FXy0lLRyFMPJP_Lri92PhEXXz9hvWGFjTmk5AjGe4AK2YQX_GDPqa3zp-wA
Message-ID: <CAJuCfpFT1oo0+9f_XQa29UeZseLNNbwc19pLbG0MOthgxrtVuQ@mail.gmail.com>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 1:06=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Suren Baghdasaryan <surenb@google.com> writes:
>
> > On Mon, Aug 18, 2025 at 10:01=E2=80=AFAM Roman Gushchin
> > <roman.gushchin@linux.dev> wrote:
> >>
> >> Introduce a bpf struct ops for implementing custom OOM handling polici=
es.
> >>
> >> The struct ops provides the bpf_handle_out_of_memory() callback,
> >> which expected to return 1 if it was able to free some memory and 0
> >> otherwise.
> >>
> >> In the latter case it's guaranteed that the in-kernel OOM killer will
> >> be invoked. Otherwise the kernel also checks the bpf_memory_freed
> >> field of the oom_control structure, which is expected to be set by
> >> kfuncs suitable for releasing memory. It's a safety mechanism which
> >> prevents a bpf program to claim forward progress without actually
> >> releasing memory. The callback program is sleepable to enable using
> >> iterators, e.g. cgroup iterators.
> >>
> >> The callback receives struct oom_control as an argument, so it can
> >> easily filter out OOM's it doesn't want to handle, e.g. global vs
> >> memcg OOM's.
> >>
> >> The callback is executed just before the kernel victim task selection
> >> algorithm, so all heuristics and sysctls like panic on oom,
> >> sysctl_oom_kill_allocating_task and sysctl_oom_kill_allocating_task
> >> are respected.
> >>
> >> The struct ops also has the name field, which allows to define a
> >> custom name for the implemented policy. It's printed in the OOM report
> >> in the oom_policy=3D<policy> format. "default" is printed if bpf is no=
t
> >> used or policy name is not specified.
> >>
> >> [  112.696676] test_progs invoked oom-killer: gfp_mask=3D0xcc0(GFP_KER=
NEL), order=3D0, oom_score_adj=3D0
> >>                oom_policy=3Dbpf_test_policy
> >> [  112.698160] CPU: 1 UID: 0 PID: 660 Comm: test_progs Not tainted 6.1=
6.0-00015-gf09eb0d6badc #102 PREEMPT(full)
> >> [  112.698165] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS 1.17.0-5.fc42 04/01/2014
> >> [  112.698167] Call Trace:
> >> [  112.698177]  <TASK>
> >> [  112.698182]  dump_stack_lvl+0x4d/0x70
> >> [  112.698192]  dump_header+0x59/0x1c6
> >> [  112.698199]  oom_kill_process.cold+0x8/0xef
> >> [  112.698206]  bpf_oom_kill_process+0x59/0xb0
> >> [  112.698216]  bpf_prog_7ecad0f36a167fd7_test_out_of_memory+0x2be/0x3=
13
> >> [  112.698229]  bpf__bpf_oom_ops_handle_out_of_memory+0x47/0xaf
> >> [  112.698236]  ? srso_alias_return_thunk+0x5/0xfbef5
> >> [  112.698240]  bpf_handle_oom+0x11a/0x1e0
> >> [  112.698250]  out_of_memory+0xab/0x5c0
> >> [  112.698258]  mem_cgroup_out_of_memory+0xbc/0x110
> >> [  112.698274]  try_charge_memcg+0x4b5/0x7e0
> >> [  112.698288]  charge_memcg+0x2f/0xc0
> >> [  112.698293]  __mem_cgroup_charge+0x30/0xc0
> >> [  112.698299]  do_anonymous_page+0x40f/0xa50
> >> [  112.698311]  __handle_mm_fault+0xbba/0x1140
> >> [  112.698317]  ? srso_alias_return_thunk+0x5/0xfbef5
> >> [  112.698335]  handle_mm_fault+0xe6/0x370
> >> [  112.698343]  do_user_addr_fault+0x211/0x6a0
> >> [  112.698354]  exc_page_fault+0x75/0x1d0
> >> [  112.698363]  asm_exc_page_fault+0x26/0x30
> >> [  112.698366] RIP: 0033:0x7fa97236db00
> >>
> >> It's possible to load multiple bpf struct programs. In the case of
> >> oom, they will be executed one by one in the same order they been
> >> loaded until one of them returns 1 and bpf_memory_freed is set to 1
> >> - an indication that the memory was freed. This allows to have
> >> multiple bpf programs to focus on different types of OOM's - e.g.
> >> one program can only handle memcg OOM's in one memory cgroup.
> >> But the filtering is done in bpf - so it's fully flexible.
> >>
> >> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> >> ---
> >>  include/linux/bpf_oom.h |  49 +++++++++++++
> >>  include/linux/oom.h     |   8 ++
> >>  mm/Makefile             |   3 +
> >>  mm/bpf_oom.c            | 157 +++++++++++++++++++++++++++++++++++++++=
+
> >>  mm/oom_kill.c           |  22 +++++-
> >>  5 files changed, 237 insertions(+), 2 deletions(-)
> >>  create mode 100644 include/linux/bpf_oom.h
> >>  create mode 100644 mm/bpf_oom.c
> >>
> >> diff --git a/include/linux/bpf_oom.h b/include/linux/bpf_oom.h
> >> new file mode 100644
> >> index 000000000000..29cb5ea41d97
> >> --- /dev/null
> >> +++ b/include/linux/bpf_oom.h
> >> @@ -0,0 +1,49 @@
> >> +/* SPDX-License-Identifier: GPL-2.0+ */
> >> +
> >> +#ifndef __BPF_OOM_H
> >> +#define __BPF_OOM_H
> >> +
> >> +struct bpf_oom;
> >> +struct oom_control;
> >> +
> >> +#define BPF_OOM_NAME_MAX_LEN 64
> >> +
> >> +struct bpf_oom_ops {
> >> +       /**
> >> +        * @handle_out_of_memory: Out of memory bpf handler, called be=
fore
> >> +        * the in-kernel OOM killer.
> >> +        * @oc: OOM control structure
> >> +        *
> >> +        * Should return 1 if some memory was freed up, otherwise
> >> +        * the in-kernel OOM killer is invoked.
> >> +        */
> >> +       int (*handle_out_of_memory)(struct oom_control *oc);
> >> +
> >> +       /**
> >> +        * @name: BPF OOM policy name
> >> +        */
> >> +       char name[BPF_OOM_NAME_MAX_LEN];
> >
> > Why should the name be a part of ops structure? IMO it's not an
> > attribute of the operations but rather of the oom handler which is
> > represented by bpf_oom here.
>
> The ops structure describes a user-defined oom policy. Currently
> it's just one handler and the policy name. Later additional handlers
> can be added, e.g. a handler to control the dmesg output.
>
> bpf_oom is an implementation detail: it's basically an extension
> to struct bpf_oom_ops which contains "private" fields required
> for the internal machinery.

Ok. I hope we can come up with some more descriptive naming but I
can't think of something good ATM.

>
> >
> >> +
> >> +       /* Private */
> >> +       struct bpf_oom *bpf_oom;
> >> +};
> >> +
> >> +#ifdef CONFIG_BPF_SYSCALL
> >> +/**
> >> + * @bpf_handle_oom: handle out of memory using bpf programs
> >> + * @oc: OOM control structure
> >> + *
> >> + * Returns true if a bpf oom program was executed, returned 1
> >> + * and some memory was actually freed.
> >
> > The above comment is unclear, please clarify.
>
> Fixed, thanks.
>
> /**
>  * @bpf_handle_oom: handle out of memory condition using bpf
>  * @oc: OOM control structure
>  *
>  * Returns true if some memory was freed.
>  */
> bool bpf_handle_oom(struct oom_control *oc);
>
>
> >
> >> + */
> >> +bool bpf_handle_oom(struct oom_control *oc);
> >> +
> >> +#else /* CONFIG_BPF_SYSCALL */
> >> +static inline bool bpf_handle_oom(struct oom_control *oc)
> >> +{
> >> +       return false;
> >> +}
> >> +
> >> +#endif /* CONFIG_BPF_SYSCALL */
> >> +
> >> +#endif /* __BPF_OOM_H */
> >> diff --git a/include/linux/oom.h b/include/linux/oom.h
> >> index 1e0fc6931ce9..ef453309b7ea 100644
> >> --- a/include/linux/oom.h
> >> +++ b/include/linux/oom.h
> >> @@ -51,6 +51,14 @@ struct oom_control {
> >>
> >>         /* Used to print the constraint info. */
> >>         enum oom_constraint constraint;
> >> +
> >> +#ifdef CONFIG_BPF_SYSCALL
> >> +       /* Used by the bpf oom implementation to mark the forward prog=
ress */
> >> +       bool bpf_memory_freed;
> >> +
> >> +       /* Policy name */
> >> +       const char *bpf_policy_name;
> >> +#endif
> >>  };
> >>
> >>  extern struct mutex oom_lock;
> >> diff --git a/mm/Makefile b/mm/Makefile
> >> index 1a7a11d4933d..a714aba03759 100644
> >> --- a/mm/Makefile
> >> +++ b/mm/Makefile
> >> @@ -105,6 +105,9 @@ obj-$(CONFIG_MEMCG) +=3D memcontrol.o vmpressure.o
> >>  ifdef CONFIG_SWAP
> >>  obj-$(CONFIG_MEMCG) +=3D swap_cgroup.o
> >>  endif
> >> +ifdef CONFIG_BPF_SYSCALL
> >> +obj-y +=3D bpf_oom.o
> >> +endif
> >>  obj-$(CONFIG_CGROUP_HUGETLB) +=3D hugetlb_cgroup.o
> >>  obj-$(CONFIG_GUP_TEST) +=3D gup_test.o
> >>  obj-$(CONFIG_DMAPOOL_TEST) +=3D dmapool_test.o
> >> diff --git a/mm/bpf_oom.c b/mm/bpf_oom.c
> >> new file mode 100644
> >> index 000000000000..47633046819c
> >> --- /dev/null
> >> +++ b/mm/bpf_oom.c
> >> @@ -0,0 +1,157 @@
> >> +// SPDX-License-Identifier: GPL-2.0-or-later
> >> +/*
> >> + * BPF-driven OOM killer customization
> >> + *
> >> + * Author: Roman Gushchin <roman.gushchin@linux.dev>
> >> + */
> >> +
> >> +#include <linux/bpf.h>
> >> +#include <linux/oom.h>
> >> +#include <linux/bpf_oom.h>
> >> +#include <linux/srcu.h>
> >> +
> >> +DEFINE_STATIC_SRCU(bpf_oom_srcu);
> >> +static DEFINE_SPINLOCK(bpf_oom_lock);
> >> +static LIST_HEAD(bpf_oom_handlers);
> >> +
> >> +struct bpf_oom {
> >
> > Perhaps bpf_oom_handler ? Then bpf_oom_ops->bpf_oom could be called
> > bpf_oom_ops->handler.
>
> I don't think it's a handler, it's more like a private part
> of bpf_oom_ops. Maybe bpf_oom_impl? Idk

Yeah, we need to come up with some nomenclature and name these structs
accordingly. In my mind ops means a structure that contains only
operations, so current naming does not sit well but maybe that's just
me...

>
> >
> >
> >> +       struct bpf_oom_ops *ops;
> >> +       struct list_head node;
> >> +       struct srcu_struct srcu;
> >> +};
> >> +
> >> +bool bpf_handle_oom(struct oom_control *oc)
> >> +{
> >> +       struct bpf_oom_ops *ops;
> >> +       struct bpf_oom *bpf_oom;
> >> +       int list_idx, idx, ret =3D 0;
> >> +
> >> +       oc->bpf_memory_freed =3D false;
> >> +
> >> +       list_idx =3D srcu_read_lock(&bpf_oom_srcu);
> >> +       list_for_each_entry_srcu(bpf_oom, &bpf_oom_handlers, node, fal=
se) {
> >> +               ops =3D READ_ONCE(bpf_oom->ops);
> >> +               if (!ops || !ops->handle_out_of_memory)
> >> +                       continue;
> >> +               idx =3D srcu_read_lock(&bpf_oom->srcu);
> >> +               oc->bpf_policy_name =3D ops->name[0] ? &ops->name[0] :
> >> +                       "bpf_defined_policy";
> >> +               ret =3D ops->handle_out_of_memory(oc);
> >> +               oc->bpf_policy_name =3D NULL;
> >> +               srcu_read_unlock(&bpf_oom->srcu, idx);
> >> +
> >> +               if (ret && oc->bpf_memory_freed)
> >
> > IIUC ret and oc->bpf_memory_freed seem to reflect the same state:
> > handler successfully freed some memory. Could you please clarify when
> > they differ?
>
> The idea here is to provide an additional safety measure:
> if the bpf program simple returns 1 without doing anything,
> the system won't deadlock.
>
> oc->bpf_memory_freed is set by the bpf_oom_kill_process() helper
> (and potentially some other helpers in the future, e.g.
> bpf_oom_rm_tmpfs_file()) and can't be modified by the bpf
> program directly.

I see. Then maybe we use only oc->bpf_memory_freed and
handle_out_of_memory() does not return anything?

