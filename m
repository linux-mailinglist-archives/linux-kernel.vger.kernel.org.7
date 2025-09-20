Return-Path: <linux-kernel+bounces-825464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F01B8BDAA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 04:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC2E97BC7DF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 02:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B207120E005;
	Sat, 20 Sep 2025 02:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGch4222"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FD91EE033
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 02:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758336494; cv=none; b=XEeA+wQn+0CKpWpjzpqcg7H/e8eanf7QViOUk29/xQNk1Is+m4SpfwEW+2m9r/hV9L/U5uSV3e5HD3D6iMdxWXTM3sHOzbj+CLU9HQB3Q2d4sO8tmwLRo7QwUti4HfoalvdzL7+cCecuS8MkLC6L4BpdAARXsYNZMdKSwtQwzVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758336494; c=relaxed/simple;
	bh=Ton40rAlvuh4011vTiJ3OoCLQVC0Li7m27f1HUP1kPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8f41tnGFAW9uiVy5RWZGC2wF+ZgSxpnCPbmzoXgd3lI01RTmK6ByBXj4TlIY9ZotjzcimT85qHefGe2IUGNdp24wpsMy5VMicErBHJj7Zw23TgUsqZGZEaLWSE7CMsiUx7IqSECMVBTUk2sqiNYnCfZTRDyAeGJgjkdqwsW4F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGch4222; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso1271352f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 19:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758336489; x=1758941289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VA73xWwtqoqelJv447Pz6QfkkHHxd9uLfHHkEXnpMbo=;
        b=dGch4222kZeCkdeSkke+cEUaVB9Wy7oMUMqiPUdtlEmcpxmH/9gUqQEZA/vBSpZu67
         Jmfh/sVgWe1FsL/uVGNCgBOBiLT2eveW2xhOn2dFGnd1Q5wWwxfS/SqilOixIUCM+v/0
         hwGtXQWvFYdBzx/qUB/2jUcPL3GdW9+ztMWgg/MksZ/HU15IXooTzZHAbAn2UspeXVw7
         tbV7kA+OqNlfVqezj9QqzJ1DUsDyDFNSbZQO++cXAdNwOH07+eD2aN+79JcmtqQS1+Ql
         JEZfSHz9OZLSjPrz/G02iTXOkElep5GLeImltyBoL9DJXDm4LIw0bgKQddhbVKBc8hte
         G8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758336489; x=1758941289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VA73xWwtqoqelJv447Pz6QfkkHHxd9uLfHHkEXnpMbo=;
        b=rW/N1s3JNTd1VmREoVb92t9ghVAOSmThjetLk0z1kn+6oa9ZGLvEh3wYdl65BTvQKR
         /ACpqFxDIZS49baDWPOlhWWQPKtI+Wmoq/isUnnam0SuGsY6G8hIWtuVekmeTyLCSBfH
         VlbglL4Kwc1JxmAFY8m6m68CgEh8I6Z2Q3iTAzve22alGFu7Ra/FLIxgvWNUFCDnEarT
         6fUiw7Q8cGuWdUzHUqIoWo3ywbx7Julq4LzLYWZVqyT7dZqvrYUvlVseJJnk6+EJ5xxq
         TOl1NUs32y7R/nfAmkQa68P5F9R7aQygNyQabGzPQHSCwePpSADEnn5xAm54XnXphcvW
         6FfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTukuMa5cdHrhiReqN0mpxRVLDfD6eW2pFvMB7UTun1mC1SJLtfkJd+F/EqoBxx+iAZpe0YOn+TlFk8ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlCQgcjvlb3Sfp+nHq+a17JdX19yH05ORFh/jNn06eK4y4f/lU
	B/IhgAD68RDuncgCZtkiWbhmvZ0OlC7/n584JVWjvZyHotRxHrh7QTWxhw/v9z22JUhsnjbJmz+
	fG5LNC/mVuTe+I9kKQfwIUNrh9YCuSPw=
X-Gm-Gg: ASbGnct641CjRT1dvoTPpoMokNDzv8BnyKk6HRDQjdA9DXJecfhADQMMty1G/DKXLuD
	daFqmX2EKn4k1pb+C/Qz20a2i7VkqTX0wWMmI/QWGGVCDktwJGtBV7bJ1W3spPQR5oq8nxB8gk/
	1lfSiCWfhzTBUA9uRpnw1rhCuk3nCGq9zMy2eB/R5FJmVXFxvOzCBKMqTXG5j7+wDU1V/JLGpOx
	KJPohCwxAHofch04O0i12wbsQ0FIqdADOpMqLJLO+MzLC0=
X-Google-Smtp-Source: AGHT+IGp9bGYRkTkDW6fd6bXtrx6LP9cUZ+4VQjJn95/G+cQmyMR8Z4+A9CZYe+F8G2SGIDbt3ooSazH/OpX/66QP8A=
X-Received: by 2002:a05:6000:2211:b0:3e9:2189:c2c3 with SMTP id
 ffacd0b85a97d-3ee83da0048mr5003952f8f.33.1758336488882; Fri, 19 Sep 2025
 19:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905201606.66198-1-shakeel.butt@linux.dev> <5qi2llyzf7gklncflo6gxoozljbm4h3tpnuv4u4ej4ztysvi6f@x44v7nz2wdzd>
In-Reply-To: <5qi2llyzf7gklncflo6gxoozljbm4h3tpnuv4u4ej4ztysvi6f@x44v7nz2wdzd>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Sep 2025 19:47:57 -0700
X-Gm-Features: AS18NWDH3QBNef0yPtwliaQkmE3uG7opfcVN1SH_V692E7Q9oKx5y5fjeVYAS8M
Message-ID: <CAADnVQK_wvu-KBgF6dNq=F5qNk-ons-w3UenJNaew6h9qTBpGw@mail.gmail.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Peilin Ye <yepeilin@google.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 7:49=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Fri, Sep 05, 2025 at 01:16:06PM -0700, Shakeel Butt wrote:
> > Generally memcg charging is allowed from all the contexts including NMI
> > where even spinning on spinlock can cause locking issues. However one
> > call chain was missed during the addition of memcg charging from any
> > context support. That is try_charge_memcg() -> memcg_memory_event() ->
> > cgroup_file_notify().
> >
> > The possible function call tree under cgroup_file_notify() can acquire
> > many different spin locks in spinning mode. Some of them are
> > cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let'=
s
> > just skip cgroup_file_notify() from memcg charging if the context does
> > not allow spinning.
> >
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
>
> Here I am just pasting the irq_work based prototype which is build
> tested only for now and sharing it early to show how it looks. Overall I
> think it is adding too much complexity which is not worth it. We have to
> add per-cpu irq_work and then for each memcg we have to add per-cpu
> lockless node to queue the deferred event update. Also more reasoning is
> needed to make sure the updates are not missed by the deferred work.
>
> Anyways, this is the early prototype. Unless there are comments on how
> to make it better, I will ask Andrew to just pick the previous patch I
> sent.
>
>
> From d58d772f306454f0dffa94bfb32195496c450892 Mon Sep 17 00:00:00 2001
> From: Shakeel Butt <shakeel.butt@linux.dev>
> Date: Thu, 18 Sep 2025 19:25:37 -0700
> Subject: [PATCH] memcg: add support for deferred max memcg event
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  include/linux/memcontrol.h |  3 ++
>  mm/memcontrol.c            | 85 ++++++++++++++++++++++++++++++++++++--
>  2 files changed, 84 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 16fe0306e50e..3f803957e05d 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -69,6 +69,7 @@ struct mem_cgroup_id {
>         refcount_t ref;
>  };
>
> +struct deferred_events_percpu;
>  struct memcg_vmstats_percpu;
>  struct memcg1_events_percpu;
>  struct memcg_vmstats;
> @@ -268,6 +269,8 @@ struct mem_cgroup {
>
>         struct memcg_vmstats_percpu __percpu *vmstats_percpu;
>
> +       struct deferred_events_percpu __percpu *deferred_events;
> +
>  #ifdef CONFIG_CGROUP_WRITEBACK
>         struct list_head cgwb_list;
>         struct wb_domain cgwb_domain;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e090f29eb03b..a34cb728c5c6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -132,6 +132,63 @@ bool mem_cgroup_kmem_disabled(void)
>         return cgroup_memory_nokmem;
>  }
>
> +struct deferred_events_percpu {
> +       atomic_t max_events;
> +       struct mem_cgroup *memcg_owner;
> +       struct llist_node lnode;
> +};
> +
> +struct defer_memcg_events {
> +       struct llist_head memcg_llist;
> +       struct irq_work work;
> +};
> +
> +static void process_deferred_events(struct irq_work *work)
> +{
> +       struct defer_memcg_events *events =3D container_of(work,
> +                                               struct defer_memcg_events=
, work);
> +       struct llist_node *lnode;
> +
> +       while (lnode =3D llist_del_first_init(&events->memcg_llist)) {
> +               int i, num;
> +               struct deferred_events_percpu *eventsc;
> +
> +               eventsc =3D container_of(lnode, struct deferred_events_pe=
rcpu, lnode);
> +
> +               if (!atomic_read(&eventsc->max_events))
> +                       continue;
> +               num =3D atomic_xchg(&eventsc->max_events, 0);
> +               if (!num)
> +                       continue;
> +               for (i =3D 0; i < num; i++)
> +                       memcg_memory_event(eventsc->memcg_owner, MEMCG_MA=
X);
> +       }
> +}
> +
> +static DEFINE_PER_CPU(struct defer_memcg_events, postpone_events) =3D {
> +       .memcg_llist =3D LLIST_HEAD_INIT(memcg_llist),
> +       .work =3D IRQ_WORK_INIT(process_deferred_events),
> +};

Why all these per cpu stuff ? I don't understand what it helps with.
To have max_events per-cpu?
Just one global llist and irq_work will do just fine.
and global max_events too.

In some previous thread there was a question about atomiciting
of atomic_long. It's normal 32-bit atomic on 32-bit archs.

