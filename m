Return-Path: <linux-kernel+bounces-874422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 046D7C16466
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 737FD3565E8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF11A34D4CD;
	Tue, 28 Oct 2025 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdEK6NOy"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640DB34D4D8
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673565; cv=none; b=QwZpAKUEPjnzn3Ey1oU6cxATa08ksagFg4JCdWcQcCh7+Urfk3XWQawIqCAAfVJlKrcmUxMaSQd6YTjESWJeh2rhC26lUd7nBztgqTeV2rtOTf2+h9qOpimsgFB4/bHUhCiXerMQA3yxUfUcjmC4MAerxHQM1MhY5b4DeYlfBVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673565; c=relaxed/simple;
	bh=gB7hEkZPdK08HudRz2YuF8fv82Vq7UsDwA/HC8IHSaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btBuDkq+tp3G4Sl1ViMnm6vOSxc3NF0rlKhHjiA7GVJj9g2k8b43dsEhb4NE5SDokzvhEHt5cM5dNnxnZU2tydBTnvrEnpEa8t3Gflk2pwXfLBo/Ts8VFaEl55qFg2nvDgm6QtJOvW36wwT8RW8wlhEdmrVVrGkOJJ1VpPHbf7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdEK6NOy; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-427084a641aso4633108f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761673561; x=1762278361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8o8F76IUU0UbQ0/2SRvS77TkF8M8+mUDrHHUTizJsU=;
        b=EdEK6NOyQhyKdAf7e6PzuB+lCbL2yoTMei36RwI6UkbbU9Bn14Wn2giQDD4Qkv70CJ
         lnoKa4+nqmt9+U1xSlDWwfHOJpC2utZQ5jR0iWnWv1cZtbjeDGBiELXB5s59ZTGfpUXC
         3fuureugnjV3ePzbWnHc+lRs/msS0W6pIDDPsJ7DHuVwb/wywYVV+bLtPbi26mx2gept
         xx3yJXC8ls1Egw5KEF0uDUatfRepLzuKGMZUmHmQ5QYrhckIN0PDxgdVnTM/vzo5yXFQ
         u26Oj/YT/gtuTTUMJNsClH7XtQdenszfsOrOqFpYgz6PXe3LnZqCXEYzjdmSxqlWmH9+
         gnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673561; x=1762278361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8o8F76IUU0UbQ0/2SRvS77TkF8M8+mUDrHHUTizJsU=;
        b=DoTLRwa1YQYlWPwXJh+wEf3NjResFu/Sf869KUFxkcR8fnLAxwh3aEQX/luulzJsMO
         7ZLW6aOmZveS6XKD+wTQCNYS2CIPJ6FvhQGUEUDglU4syImr1m+SWGcPuMwwzDjLv4Il
         xBNnx30ZKlNqC59aRROPdAK0HqYD8USK1zzxQi/Aj4Y5uF8WzU9jV/MwMAVVx+q3trBO
         KEu2UUrm8Uaxf9wjUNRhKKtgIUkRJ88BMD2oXMqzth0EUK0wh8xfB65v1+xRr70IzvHw
         ugY5XAxrDwlc6i1W+4LxR0+ANFXa1rLkhLGPnfnZsMl1OUWmCuWdX7jT1yXNG45GLLdy
         9+yg==
X-Forwarded-Encrypted: i=1; AJvYcCWO3B48ANJdL5XafSvdIA/v8M7yJ4LqNKThFot0tBHI4dGvLdt4bpZTRARwx+Gqq66ONGTUEh+/f498in0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfXXEF537IBvn7ffoIEUzq1r8LeRHK/6OIISnj1j8RzXhRsalj
	G0hjqJIWRQ2q/dYw5LFv/jovOMjD6qijqWwde1be2hBQ4eGVlP+TJZ5mHbMsKxXa+5/fWcuYmGn
	1R7T6IB8SiRZSE4YTGSMGnmFWaDUht3o=
X-Gm-Gg: ASbGncufq3m7FjlVLKsx3MLAKHegbRcIIW2WefuS5JQaZkIist7H6AtF/uB5R72kzTV
	SWBo/o/sW2I3lvk37oSAlegvX028bVkOKl74NTof8ESQZ3E3+TMWJ9e6StKipJkl3RzsTjGeVDV
	DMTKGeS9PvkaJzqTecq5coRunqrOjWAIcpBQDLrr3coejkzQ8kbVybISWkGWo4c2+rmZpswRWkj
	jgd3ND6ng7YVid/54QlS79A9u4qDjao77Euk362fs2h5fLvAy7rbmNAGvP2WXiZUJPosq/yaXaM
X-Google-Smtp-Source: AGHT+IHdC935jXGEIZNQ8BYD/ANRC6JF/uyaxHO8iGt25M0BknomRTBrWpakBaxhp4hLDP8/bFuayzs/ibY+/MUNENI=
X-Received: by 2002:a05:6000:3108:b0:427:6cb:74a4 with SMTP id
 ffacd0b85a97d-429a7e7a1b0mr3757740f8f.39.1761673560565; Tue, 28 Oct 2025
 10:46:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev> <20251027231727.472628-7-roman.gushchin@linux.dev>
In-Reply-To: <20251027231727.472628-7-roman.gushchin@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 28 Oct 2025 10:45:47 -0700
X-Gm-Features: AWmQ_bncnJypaBtdt8pXLZmr8dzBy7-unV831zo2gE3qs0GF1C9pXA_M9bOiMqw
Message-ID: <CAADnVQKWskY1ijJtSX=N0QczW_-gtg-X_SpK_GuiYBYQodn5wQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/23] mm: introduce BPF struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Song Liu <song@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:18=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> +bool bpf_handle_oom(struct oom_control *oc)
> +{
> +       struct bpf_oom_ops *bpf_oom_ops =3D NULL;
> +       struct mem_cgroup __maybe_unused *memcg;
> +       int idx, ret =3D 0;
> +
> +       /* All bpf_oom_ops structures are protected using bpf_oom_srcu */
> +       idx =3D srcu_read_lock(&bpf_oom_srcu);
> +
> +#ifdef CONFIG_MEMCG
> +       /* Find the nearest bpf_oom_ops traversing the cgroup tree upward=
s */
> +       for (memcg =3D oc->memcg; memcg; memcg =3D parent_mem_cgroup(memc=
g)) {
> +               bpf_oom_ops =3D READ_ONCE(memcg->bpf_oom);
> +               if (!bpf_oom_ops)
> +                       continue;
> +
> +               /* Call BPF OOM handler */
> +               ret =3D bpf_ops_handle_oom(bpf_oom_ops, memcg, oc);
> +               if (ret && oc->bpf_memory_freed)
> +                       goto exit;
> +       }
> +#endif /* CONFIG_MEMCG */
> +
> +       /*
> +        * System-wide OOM or per-memcg BPF OOM handler wasn't successful=
?
> +        * Try system_bpf_oom.
> +        */
> +       bpf_oom_ops =3D READ_ONCE(system_bpf_oom);
> +       if (!bpf_oom_ops)
> +               goto exit;
> +
> +       /* Call BPF OOM handler */
> +       ret =3D bpf_ops_handle_oom(bpf_oom_ops, NULL, oc);
> +exit:
> +       srcu_read_unlock(&bpf_oom_srcu, idx);
> +       return ret && oc->bpf_memory_freed;
> +}

...

> +static int bpf_oom_ops_reg(void *kdata, struct bpf_link *link)
> +{
> +       struct bpf_struct_ops_link *ops_link =3D container_of(link, struc=
t bpf_struct_ops_link, link);
> +       struct bpf_oom_ops **bpf_oom_ops_ptr =3D NULL;
> +       struct bpf_oom_ops *bpf_oom_ops =3D kdata;
> +       struct mem_cgroup *memcg =3D NULL;
> +       int err =3D 0;
> +
> +       if (IS_ENABLED(CONFIG_MEMCG) && ops_link->cgroup_id) {
> +               /* Attach to a memory cgroup? */
> +               memcg =3D mem_cgroup_get_from_ino(ops_link->cgroup_id);
> +               if (IS_ERR_OR_NULL(memcg))
> +                       return PTR_ERR(memcg);
> +               bpf_oom_ops_ptr =3D bpf_oom_memcg_ops_ptr(memcg);
> +       } else {
> +               /* System-wide OOM handler */
> +               bpf_oom_ops_ptr =3D &system_bpf_oom;
> +       }

I don't like the fallback and special case of cgroup_id =3D=3D 0.
imo it would be cleaner to require CONFIG_MEMCG for this feature
and only allow attach to a cgroup.
There is always a root cgroup that can be attached to and that
handler will be acting as "system wide" oom handler.

