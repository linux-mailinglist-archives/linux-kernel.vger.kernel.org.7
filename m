Return-Path: <linux-kernel+bounces-774844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE24AB2B846
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D2C621F7F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 04:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F8230F546;
	Tue, 19 Aug 2025 04:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dRkXHyF6"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC7324A063
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755576605; cv=none; b=VchF/aKpJeu6RCNNfzUOdUhfXH7E+7cFhDwwM+Q7IbIIQr1z1YDu36uLjiaLmfCq6HHCyHyIIvZuenvPnweRr7vFBFUP55HSYzEAUwULF08p+5idHMCQF/tl3If+PIilOmggEYr3MPOW1wOGyDohW74mVfvzI74kReAuTwcqG2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755576605; c=relaxed/simple;
	bh=V4imRU6rX46GWU3tLxAqueJIgbRUztEpGF3brIKZ7RQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=et9r9JWo6YAOoJC9vSZgWScM29xoqCUm4+u0Fd8G7vffMjWGfply9bWKkF3m5//oboWQmvNwfP7FhqXF+CUYcqAb8cPoAj9l6BYBdXElz4sGKv0lloIjmrn4vlNA9cQCk5FrBRqamCrMcAXnuUPWeF5uRelSbUbeJkXXJfw6FaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dRkXHyF6; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b0bf08551cso170411cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 21:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755576603; x=1756181403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAcHE8xVlLW9wfKAGaERtBwDgcukbXahbLqL6y1twww=;
        b=dRkXHyF6LvHrQlXZt2ro+Nysh8Wx8au3lFl30p2+0dt1TIK9K0maYXuM025FG1POjk
         fg93eQfN65yGwcNhHMM1UYrCu/M7myhYA/zZwFy4LUdGIAG/ePolTCk8gwg8vJ95Ivaf
         Tc6a0B9EBuzUgD8DvA0FCTZvYA7B7aQ/YEldX+XVGxAq8RDFPuUrDZ3X0gvnTOgkhFNn
         Et9KoH6i5hlQjRpD5ZundqrsEWMDYDO7T/U2FfSBigs9n6m4TUQtr2nF8QRCDxs0PNUP
         IvTy8dG/mIY0HpK8MaQFlFkpz9vcBJ4Tyij5AxJPJmv4ytdLaWLIUUAu9kHRUYyX3jW5
         CFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755576603; x=1756181403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAcHE8xVlLW9wfKAGaERtBwDgcukbXahbLqL6y1twww=;
        b=uY2ckIGftsy9Z0SILAUx64bPw+xIhdEBASetGWQ4nB5i4qyDUb+jvwarulPOU9uubb
         BVCMcCDXJfc/+FyQ34r06p7GDMzkvlWMcGWEEqOushqizdjMbD9zvPIyktc/KQqTeqna
         PeNaIZ84r66fXsK3rEsPM6EDqwdhEj+CQWSaNC1XdQ23kZJua56tH1YAIiXnOolNHU+w
         cN4k/3LIJjS7GKohXkVa0nEF6Sy0ZsvWRfD23NnA/VY6IjA4ScrfqIVDQA6G4ogCJW5w
         iElWdUR1RwF+fHt2dX6N1/sm+pihTJhuRKoX71rgt9lb3x2IlUt+UQcpr63LM4QlfPii
         jClA==
X-Forwarded-Encrypted: i=1; AJvYcCVZN4YDODNgkyCwW1AYhdY+poRvKA+TbR5PnYI3hRvlR9utjIhd09O9wv00Lkp96RrRIK2ZP03i9m0dpnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxswQ7BcOeYu2EVZ6GUs1k/Z25XxZu202xyy1Hvlb4z2xKQB0Im
	jBseGn+suNE32FNP/URE/lA7nQjoAU60Bm9qfSgMVtOQ0D+PEt2hDHQCxfsEgCVCz8lYrMXAo6N
	GyAAdnfAhCRrdsHtB/PJE3KTi7VXkNBJBfdCFpcBf
X-Gm-Gg: ASbGncuMgbBNkjgqKYTxsCc858nYy99CL9N7WZmxczieWVCUlsrHWylY6L2vkrT2VZS
	eX2/jRl60GSEH1fCrrp5wC0SjxX1uVtqug7FUcD7pxUnK9in7FE7hd5sNFVh05zOQXcKt9goSSd
	yQHS9GkcE99ZJHCYbZW+jjX2kg7bLbh1XDnryJixune905rLEaJ1aoyOq1OPKqEwOsR7R8tMiaF
	xhpfOdsROGth3HFOpJ0u+Q=
X-Google-Smtp-Source: AGHT+IErvoMpegg8y8j9zeFwYBiDHNJVT4ehiSG7I/0WDarN88VfjBc2ERe5fXUXKIxrb6LrWV+nNDH0v7lCq5ErPrE=
X-Received: by 2002:a05:622a:1211:b0:4a7:26d2:5a38 with SMTP id
 d75a77b69052e-4b286e3ba52mr1849461cf.19.1755576602453; Mon, 18 Aug 2025
 21:10:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev> <20250818170136.209169-12-roman.gushchin@linux.dev>
In-Reply-To: <20250818170136.209169-12-roman.gushchin@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 18 Aug 2025 21:09:51 -0700
X-Gm-Features: Ac12FXzwiAMJNHKgWkC-rXPe0woe2SXY7I2rKnlwZclcPiCByfY7XDFh78QLwmY
Message-ID: <CAJuCfpH5cSDGmwBfEmiXkShxxdTEuoRXrTKndNwTMMDUzX8f3A@mail.gmail.com>
Subject: Re: [PATCH v1 11/14] sched: psi: refactor psi_trigger_create()
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 10:02=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> Currently psi_trigger_create() does a lot of things:
> parses the user text input, allocates and initializes
> the psi_trigger structure and turns on the trigger.
> It does it slightly different for two existing types
> of psi_triggers: system-wide and cgroup-wide.
>
> In order to support a new type of psi triggers, which
> will be owned by a bpf program and won't have a user's
> text description, let's refactor psi_trigger_create().
>
> 1. Introduce psi_trigger_type enum:
>    currently PSI_SYSTEM and PSI_CGROUP are valid values.
> 2. Introduce psi_trigger_params structure to avoid passing
>    a large number of parameters to psi_trigger_create().
> 3. Move out the user's input parsing into the new
>    psi_trigger_parse() helper.
> 4. Move out the capabilities check into the new
>    psi_file_privileged() helper.
> 5. Stop relying on t->of for detecting trigger type.

It's worth noting that this is a pure core refactoring without any
functional change (hopefully :))

>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  include/linux/psi.h       | 15 +++++--
>  include/linux/psi_types.h | 33 ++++++++++++++-
>  kernel/cgroup/cgroup.c    | 14 ++++++-
>  kernel/sched/psi.c        | 87 +++++++++++++++++++++++++--------------
>  4 files changed, 112 insertions(+), 37 deletions(-)
>
> diff --git a/include/linux/psi.h b/include/linux/psi.h
> index e0745873e3f2..8178e998d94b 100644
> --- a/include/linux/psi.h
> +++ b/include/linux/psi.h
> @@ -23,14 +23,23 @@ void psi_memstall_enter(unsigned long *flags);
>  void psi_memstall_leave(unsigned long *flags);
>
>  int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res r=
es);
> -struct psi_trigger *psi_trigger_create(struct psi_group *group, char *bu=
f,
> -                                      enum psi_res res, struct file *fil=
e,
> -                                      struct kernfs_open_file *of);
> +int psi_trigger_parse(struct psi_trigger_params *params, const char *buf=
);
> +struct psi_trigger *psi_trigger_create(struct psi_group *group,
> +                               const struct psi_trigger_params *param);
>  void psi_trigger_destroy(struct psi_trigger *t);
>
>  __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
>                         poll_table *wait);
>
> +static inline bool psi_file_privileged(struct file *file)
> +{
> +       /*
> +        * Checking the privilege here on file->f_cred implies that a pri=
vileged user
> +        * could open the file and delegate the write to an unprivileged =
one.
> +        */
> +       return cap_raised(file->f_cred->cap_effective, CAP_SYS_RESOURCE);
> +}
> +
>  #ifdef CONFIG_CGROUPS
>  static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
>  {
> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> index f1fd3a8044e0..cea54121d9b9 100644
> --- a/include/linux/psi_types.h
> +++ b/include/linux/psi_types.h
> @@ -121,7 +121,38 @@ struct psi_window {
>         u64 prev_growth;
>  };
>
> +enum psi_trigger_type {
> +       PSI_SYSTEM,
> +       PSI_CGROUP,
> +};
> +
> +struct psi_trigger_params {
> +       /* Trigger type */
> +       enum psi_trigger_type type;
> +
> +       /* Resources that workloads could be stalled on */

I would describe this as "Resource to be monitored"

> +       enum psi_res res;
> +
> +       /* True if all threads should be stalled to trigger */
> +       bool full;
> +
> +       /* Threshold in us */
> +       u32 threshold_us;
> +
> +       /* Window in us */
> +       u32 window_us;
> +
> +       /* Privileged triggers are treated differently */
> +       bool privileged;
> +
> +       /* Link to kernfs open file, only for PSI_CGROUP */
> +       struct kernfs_open_file *of;
> +};
> +
>  struct psi_trigger {
> +       /* Trigger type */
> +       enum psi_trigger_type type;
> +
>         /* PSI state being monitored by the trigger */
>         enum psi_states state;
>
> @@ -137,7 +168,7 @@ struct psi_trigger {
>         /* Wait queue for polling */
>         wait_queue_head_t event_wait;
>
> -       /* Kernfs file for cgroup triggers */
> +       /* Kernfs file for PSI_CGROUP triggers */
>         struct kernfs_open_file *of;
>
>         /* Pending event flag */
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index a723b7dc6e4e..9cd3c3a52c21 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3872,6 +3872,12 @@ static ssize_t pressure_write(struct kernfs_open_f=
ile *of, char *buf,
>         struct psi_trigger *new;
>         struct cgroup *cgrp;
>         struct psi_group *psi;
> +       struct psi_trigger_params params;
> +       int err;
> +
> +       err =3D psi_trigger_parse(&params, buf);
> +       if (err)
> +               return err;
>
>         cgrp =3D cgroup_kn_lock_live(of->kn, false);
>         if (!cgrp)
> @@ -3887,7 +3893,13 @@ static ssize_t pressure_write(struct kernfs_open_f=
ile *of, char *buf,
>         }
>
>         psi =3D cgroup_psi(cgrp);
> -       new =3D psi_trigger_create(psi, buf, res, of->file, of);
> +
> +       params.type =3D PSI_CGROUP;
> +       params.res =3D res;
> +       params.privileged =3D psi_file_privileged(of->file);
> +       params.of =3D of;
> +
> +       new =3D psi_trigger_create(psi, &params);
>         if (IS_ERR(new)) {
>                 cgroup_put(cgrp);
>                 return PTR_ERR(new);
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index ad04a5c3162a..e1d8eaeeff17 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -489,7 +489,7 @@ static void update_triggers(struct psi_group *group, =
u64 now,
>
>                 /* Generate an event */
>                 if (cmpxchg(&t->event, 0, 1) =3D=3D 0) {
> -                       if (t->of)
> +                       if (t->type =3D=3D PSI_CGROUP)
>                                 kernfs_notify(t->of->kn);
>                         else
>                                 wake_up_interruptible(&t->event_wait);
> @@ -1281,74 +1281,87 @@ int psi_show(struct seq_file *m, struct psi_group=
 *group, enum psi_res res)
>         return 0;
>  }
>
> -struct psi_trigger *psi_trigger_create(struct psi_group *group, char *bu=
f,
> -                                      enum psi_res res, struct file *fil=
e,
> -                                      struct kernfs_open_file *of)
> +int psi_trigger_parse(struct psi_trigger_params *params, const char *buf=
)
>  {
> -       struct psi_trigger *t;
> -       enum psi_states state;
> -       u32 threshold_us;
> -       bool privileged;
> -       u32 window_us;
> +       u32 threshold_us, window_us;
>
>         if (static_branch_likely(&psi_disabled))
> -               return ERR_PTR(-EOPNOTSUPP);
> -
> -       /*
> -        * Checking the privilege here on file->f_cred implies that a pri=
vileged user
> -        * could open the file and delegate the write to an unprivileged =
one.
> -        */
> -       privileged =3D cap_raised(file->f_cred->cap_effective, CAP_SYS_RE=
SOURCE);
> +               return -EOPNOTSUPP;
>
>         if (sscanf(buf, "some %u %u", &threshold_us, &window_us) =3D=3D 2=
)
> -               state =3D PSI_IO_SOME + res * 2;
> +               params->full =3D false;
>         else if (sscanf(buf, "full %u %u", &threshold_us, &window_us) =3D=
=3D 2)
> -               state =3D PSI_IO_FULL + res * 2;
> +               params->full =3D true;
>         else
> -               return ERR_PTR(-EINVAL);
> +               return -EINVAL;
> +
> +       params->threshold_us =3D threshold_us;
> +       params->window_us =3D window_us;
> +       return 0;
> +}
> +
> +struct psi_trigger *psi_trigger_create(struct psi_group *group,
> +                                      const struct psi_trigger_params *p=
arams)
> +{
> +       struct psi_trigger *t;
> +       enum psi_states state;
> +
> +       if (static_branch_likely(&psi_disabled))
> +               return ERR_PTR(-EOPNOTSUPP);
> +
> +       state =3D params->full ? PSI_IO_FULL : PSI_IO_SOME;
> +       state +=3D params->res * 2;
>
>  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
> -       if (res =3D=3D PSI_IRQ && --state !=3D PSI_IRQ_FULL)
> +       if (params->res =3D=3D PSI_IRQ && --state !=3D PSI_IRQ_FULL)
>                 return ERR_PTR(-EINVAL);
>  #endif
>
>         if (state >=3D PSI_NONIDLE)
>                 return ERR_PTR(-EINVAL);
>
> -       if (window_us =3D=3D 0 || window_us > WINDOW_MAX_US)
> +       if (params->window_us =3D=3D 0 || params->window_us > WINDOW_MAX_=
US)
>                 return ERR_PTR(-EINVAL);
>
>         /*
>          * Unprivileged users can only use 2s windows so that averages ag=
gregation
>          * work is used, and no RT threads need to be spawned.
>          */
> -       if (!privileged && window_us % 2000000)
> +       if (!params->privileged && params->window_us % 2000000)
>                 return ERR_PTR(-EINVAL);
>
>         /* Check threshold */
> -       if (threshold_us =3D=3D 0 || threshold_us > window_us)
> +       if (params->threshold_us =3D=3D 0 || params->threshold_us > param=
s->window_us)
>                 return ERR_PTR(-EINVAL);
>
>         t =3D kmalloc(sizeof(*t), GFP_KERNEL);
>         if (!t)
>                 return ERR_PTR(-ENOMEM);
>
> +       t->type =3D params->type;
>         t->group =3D group;
>         t->state =3D state;
> -       t->threshold =3D threshold_us * NSEC_PER_USEC;
> -       t->win.size =3D window_us * NSEC_PER_USEC;
> +       t->threshold =3D params->threshold_us * NSEC_PER_USEC;
> +       t->win.size =3D params->window_us * NSEC_PER_USEC;
>         window_reset(&t->win, sched_clock(),
>                         group->total[PSI_POLL][t->state], 0);
>
>         t->event =3D 0;
>         t->last_event_time =3D 0;
> -       t->of =3D of;
> -       if (!of)
> +
> +       switch (params->type) {
> +       case PSI_SYSTEM:
>                 init_waitqueue_head(&t->event_wait);

I think t->of will be left uninitialized here. Let's set it to NULL please.


> +               break;
> +       case PSI_CGROUP:
> +               t->of =3D params->of;
> +               break;
> +       }
> +
>         t->pending_event =3D false;
> -       t->aggregator =3D privileged ? PSI_POLL : PSI_AVGS;
> +       t->aggregator =3D params->privileged ? PSI_POLL : PSI_AVGS;
>
> -       if (privileged) {
> +       if (params->privileged) {
>                 mutex_lock(&group->rtpoll_trigger_lock);
>
>                 if (!rcu_access_pointer(group->rtpoll_task)) {
> @@ -1401,7 +1414,7 @@ void psi_trigger_destroy(struct psi_trigger *t)
>          * being accessed later. Can happen if cgroup is deleted from und=
er a
>          * polling process.
>          */
> -       if (t->of)
> +       if (t->type =3D=3D PSI_CGROUP)
>                 kernfs_notify(t->of->kn);
>         else
>                 wake_up_interruptible(&t->event_wait);
> @@ -1481,7 +1494,7 @@ __poll_t psi_trigger_poll(void **trigger_ptr,
>         if (!t)
>                 return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
>
> -       if (t->of)
> +       if (t->type =3D=3D PSI_CGROUP)
>                 kernfs_generic_poll(t->of, wait);
>         else
>                 poll_wait(file, &t->event_wait, wait);
> @@ -1530,6 +1543,8 @@ static ssize_t psi_write(struct file *file, const c=
har __user *user_buf,
>         size_t buf_size;
>         struct seq_file *seq;
>         struct psi_trigger *new;
> +       struct psi_trigger_params params;
> +       int err;
>
>         if (static_branch_likely(&psi_disabled))
>                 return -EOPNOTSUPP;
> @@ -1543,6 +1558,10 @@ static ssize_t psi_write(struct file *file, const =
char __user *user_buf,
>
>         buf[buf_size - 1] =3D '\0';
>
> +       err =3D psi_trigger_parse(&params, buf);
> +       if (err)
> +               return err;
> +
>         seq =3D file->private_data;
>
>         /* Take seq->lock to protect seq->private from concurrent writes =
*/
> @@ -1554,7 +1573,11 @@ static ssize_t psi_write(struct file *file, const =
char __user *user_buf,
>                 return -EBUSY;
>         }
>
> -       new =3D psi_trigger_create(&psi_system, buf, res, file, NULL);
> +       params.type =3D PSI_SYSTEM;
> +       params.res =3D res;
> +       params.privileged =3D psi_file_privileged(file);
> +
> +       new =3D psi_trigger_create(&psi_system, &params);
>         if (IS_ERR(new)) {
>                 mutex_unlock(&seq->lock);
>                 return PTR_ERR(new);
> --
> 2.50.1
>

