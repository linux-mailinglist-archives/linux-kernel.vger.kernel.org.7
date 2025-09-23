Return-Path: <linux-kernel+bounces-828142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60747B940A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CECF3B3349
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 02:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3090126CE35;
	Tue, 23 Sep 2025 02:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VHWjKxQV"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21859154BF5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758595533; cv=none; b=eqV/MpqSo3EDqUqzmRKZEjRttWzT6lCbUN5jqrMb+b2TmPmrteueyB/X2bTZGgNcnvWI5UrzvEgWrsxpYfZm7CHrpxz3dSIhT5qBZS45mdC0Bw+8tLencCT5mpzgec309OHOi4E53gFZd4TovV2spwuinBXfgfkWnUHv70Fif4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758595533; c=relaxed/simple;
	bh=gPQeCnvlLjNXOScZzlKmAeieC1iEgYR7c/FsgaRnaXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gw54MHlGoGAJ0BvBk8d1mlCZTYGuwUfGAOON22KwhF9t6qhsxfq1P80gbEUZAKTeKpMs/HCWL+Z/YAIdX33VRZjeIunl+2wB0xh9+S+QYouHYVzjtrXQzRulU2GmyoPZsvjsssn7A9Wj2je3GCDrjWuODqJuA6wJ58Zcqlnatfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VHWjKxQV; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-ea669836e8dso3001565276.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 19:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758595530; x=1759200330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6365fPv5K1r6MdfQx7YnrIrtYvqaUOifa7cKiePXYlo=;
        b=VHWjKxQVTks/q/RojHh+9skoXr5hokLM2E83GvTjn7IkUMOLWxoeNfCNZDXMnR3Nk4
         xHyH6rEV73DSfWQl416htENeaR3TohIBfx/xLfgfqXyRBN2z9zVDQIr0tpcRgPsTAOcw
         UwLSrYAbCTK+Qy5FeR/3A2dIUpMb3O1YkMAOcA2Sw0SGGUcQthvSwjH8reS67lDdV59h
         J7sd9/9AltSpu1BwZCw3lRl6GSK8l2m5jPGE82N/vq2INUmAveGkJx3rTaqk0gc9kO9b
         DnCj9pLIj4grFJd7RHy6of7+zAP1sgCBkjb4VIxFl5KG0MTaPBUcWyacQO2YJI8II5pH
         HT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758595530; x=1759200330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6365fPv5K1r6MdfQx7YnrIrtYvqaUOifa7cKiePXYlo=;
        b=edZIRugCQANghvUYa7h2/cTHhJPmtjtLzIqs3lf9grq522wuZxcqwdBBvZk5XTb3zT
         ZP7y7qexgVXsIq628PAGY24LGiUzkNgxlTrGGVNFySbVhZkNuGqfpa/1rhkgVx8sMzQr
         Yq5XdYBPz5GBMmg73lIJMzIAQpmnyySyvGeYOVEln7wSPhEECWeUkATmL9AS5FJWNeGp
         L8UrgwyjWCl9e8sTVC2pWife4hm7qnpfvIZTJd3L/d606Y1ibwJuKD4owudfVVsoC8El
         ApuCVYDjr0MEWmqfeers+M40bCi5TIR9/bvtrF+Cg+9Iv1Hy1IJ/aXyaqQtj4JPMyepW
         s7Wg==
X-Forwarded-Encrypted: i=1; AJvYcCU4Q0ACXj3OYXZNj/jVzX5XbstSU4Q8+KPtI9knJ3UyzAT8I9jMnoQ+b5cJorcRSAS7IBFIPJTi6JYr+Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5pvvbcxWL3Ytw0a4Ug/4QrmJacLre2ommXc3+60Hw1yIXOxlr
	tDKmW/NIwfzLRjteqTN4eSajSkUthOqXwdR5+swfPtGmmePCroR+lvEJTsa32mZh+0+cMHQAVkY
	gzXc184x92PnpUcaYmWQ8KKTt+vjW13JlFybaxtH++g==
X-Gm-Gg: ASbGncuXEEVlCy3pJ/9WInCZ+C+tFtC5EuMaxtNbuDDud2vLPa3Y3lV//GV3UFe99Je
	bhKPjZBxoSZbOVJSfo1ajh1OGwFrQ8OB/G28HM6m+c5ESRXLQXLnyo8JKMYyU8g/LLtP64ZK8mZ
	aa7602xl64KSiBYzdOdJvcnlpmRjSI096FaPgWl7PIeuW8V68Rb75t+Nvjmw8h0wUMdeQwQiiKN
	auUzFFXOPYr2hkcTLTN
X-Google-Smtp-Source: AGHT+IFMEL9PkIVcJlRLDG5zxFO6vdqLCRKTI8+1dxWCSeE1bi9AjyZUVthjwkH8JWE9iNDq+fue8IwJGVlNXlzdKos=
X-Received: by 2002:a05:690c:9a11:b0:739:522b:6b73 with SMTP id
 00721157ae682-75893af5c0bmr7490157b3.2.1758595529905; Mon, 22 Sep 2025
 19:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
 <b31a538a-c361-4e3e-a5b6-6a3d2083ef3b@linux.dev> <20250922145754.31890092257495f70db3909d@linux-foundation.org>
 <9665ff9f-3e1d-4c39-8c8f-b9e12fb4d5f4@linux.dev>
In-Reply-To: <9665ff9f-3e1d-4c39-8c8f-b9e12fb4d5f4@linux.dev>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Tue, 23 Sep 2025 10:45:19 +0800
X-Gm-Features: AS18NWAqWWi_FlI2_uL7X4H2Yo7-HIXR56U8zd5JkmQgxhiY1POdKn6jBAmTP54
Message-ID: <CAHSKhtee3amv12XdBu0Wbfde_27pSm7WdRtifGhpfycLwmov0A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 0/3] Suppress undesirable hung task warnings.
To: Lance Yang <lance.yang@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, mhiramat@kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	agruenba@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 10:30=E2=80=AFAM Lance Yang <lance.yang@linux.dev> =
wrote:
>
>
>
> On 2025/9/23 05:57, Andrew Morton wrote:
> > On Mon, 22 Sep 2025 19:38:21 +0800 Lance Yang <lance.yang@linux.dev> wr=
ote:
> >
> >> On 2025/9/22 17:41, Julian Sun wrote:
> >>> As suggested by Andrew Morton in [1], we need a general mechanism
> >>> that allows the hung task detector to ignore unnecessary hung
> >>
> >> Yep, I understand the goal is to suppress what can be a benign hung ta=
sk
> >> warning during memcg teardown.
> >>
> >>> tasks. This patch set implements this functionality.
> >>>
> >>> Patch 1 introduces a PF_DONT_HUNG flag. The hung task detector will
> >>> ignores all tasks that have the PF_DONT_HUNG flag set.
> >>
> >> However, I'm concerned that the PF_DONT_HUNG flag is a bit too powerfu=
l
> >> and might mask real, underlying hangs.
> >
> > I think that's OK if the calling task is discriminating about it.  Just
> > set PF_DONT_HUNG (unpleasing name!) around those bits of code where
> > it's needed, clear it otherwise.
>
> Makes sense to me :)
>
> >
> > Julian, did you take a look at what a touch_hung_task_detector() would
> > involve?  It's a bit of an interface inconsistency - our various other
> > timeout detectors (softlockup, NMI, rcu) each have a touch_ function.
>
> On second thought, I agree that a touch_hung_task_detector() would be a
> much better approach for interface consistency.
>
> We could implement touch_hung_task_detector() to grant the task temporary
> immunity from hung task checks for as long as it remains uninterruptible.
> Once the task becomes runnable again, the immunity is automatically revok=
ed.

Yes, this looks much cleaner.  I didn=E2=80=99t think of this specific code
implementation method :)
>
> Something like this:
>
> ---
> diff --git a/include/linux/hung_task.h b/include/linux/hung_task.h
> index c4403eeb7144..fac92039dce0 100644
> --- a/include/linux/hung_task.h
> +++ b/include/linux/hung_task.h
> @@ -98,4 +98,9 @@ static inline void *hung_task_blocker_to_lock(unsigned
> long blocker)
>   }
>   #endif
>
> +void touch_hung_task_detector(struct task_struct *t)
> +{
> +       t->last_switch_count =3D ULONG_MAX;
> +}
> +
>   #endif /* __LINUX_HUNG_TASK_H */
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 8708a1205f82..094a277b3b39 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -203,6 +203,9 @@ static void check_hung_task(struct task_struct *t,
> unsigned long timeout)
>         if (unlikely(!switch_count))
>                 return;
>
> +       if (t->last_switch_count =3D=3D ULONG_MAX)
> +               return;
> +
>         if (switch_count !=3D t->last_switch_count) {
>                 t->last_switch_count =3D switch_count;
>                 t->last_switch_time =3D jiffies;
> @@ -317,6 +320,9 @@ static void
> check_hung_uninterruptible_tasks(unsigned long timeout)
>                     !(state & TASK_WAKEKILL) &&
>                     !(state & TASK_NOLOAD))
>                         check_hung_task(t, timeout);
> +               else if (t->last_switch_count =3D=3D ULONG_MAX)
> +                       t->last_switch_count =3D t->nvcsw + t->nivcsw;

Maybe we don't need this statement here, the if (switch_count !=3D
t->last_switch_count) statement inside the check_hung_task() will do
it automatically. Or am I missing something?
> +
>         }
>    unlock:
>         rcu_read_unlock();
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8dc470aa6c3c..3d5f36455b74 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3910,8 +3910,10 @@ static void mem_cgroup_css_free(struct
> cgroup_subsys_state *css)
>         int __maybe_unused i;
>
>   #ifdef CONFIG_CGROUP_WRITEBACK
> -       for (i =3D 0; i < MEMCG_CGWB_FRN_CNT; i++)
> +       for (i =3D 0; i < MEMCG_CGWB_FRN_CNT; i++) {
> +               touch_hung_task_detector(current);
>                 wb_wait_for_completion(&memcg->cgwb_frn[i].done);
> +       }
>   #endif
>         if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_no=
socket)
>                 static_branch_dec(&memcg_sockets_enabled_key);
> ---
>
> Using ULONG_MAX as a marker to grant this immunity. As long as the task
> remains in state D, check_hung_task() sees the marker and bails out.

Thanks for your review, I will send patch v2 with this approach.


--=20
Julian Sun <sunjunchao@bytedance.com>

