Return-Path: <linux-kernel+bounces-879222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B13C2293B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6153BCE6D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B9633BBB6;
	Thu, 30 Oct 2025 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO+UIa4o"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12CD2D5C6C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761863901; cv=none; b=V9MRcMV6k2JKhiOtncvChQ4dyhF7KwOmhUwje2vGLtytRKUEUabm8Xt8tgZ5tiwkuuaSr6VKGlMDKjjSsykIypUCfJPt6rbOb867vGzMGAqOO/ewgeDqfyGzCb5ZLTioC+DHkciqcYL933YDYR2YPUKZhSbkuUcIzq3ZAmX7m6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761863901; c=relaxed/simple;
	bh=rJQAWq+XjRqxja76Aq+TSm1F0DMkRb0mJTNn7fYmTXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/j+YzNYAjOqeBfVOEto0rQMn2AoTgnCO0QUlZiYqna/FstgSBGEoUAxdxy+drhtm/RWvOpM+oB/II7R849ZbDaVVZF2NiQt7Mya4D4naLCVavmzSgZdnSePvDVdEPp1iTmn18d1/c6ULhek5VUNIeHnRwHjwara6Xg2dbNeXus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kO+UIa4o; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429be5d31c9so166063f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761863897; x=1762468697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wegkSekqGGUT4XWQzMNJtqpWRUXHy7Tf0VKql4UkVGc=;
        b=kO+UIa4oll1W3PmQnEPUrq9tq3NHR+xCBnoZIiUHA+vB5QfdM7cML8gZB4380FVFWk
         6fJj6Ci58+XYcH6+PDANksMjuRo9jeLgy1P7vH3H5uJp1zxtCVmODEa2ugVG1oSSrnV5
         qiqP0coFL5EMvmK+YdextWkm9pauocq+Ri4ZpxALJmigv/2TPLHOkPMunOsjcmWlSz6+
         Tr3Wdm9wGgQcX5KgeSlLwfb0f0GJA0UQ2CIR/x3KhMfEuLXQb9Xu20f8u8xp6XlFixeb
         MDXwECnHUJFtrMcOe0QvUyjnpPJzRKFoqJzsIrV8llyH/qNsO2bU1KN3BgGM3K+fOOow
         iHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761863897; x=1762468697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wegkSekqGGUT4XWQzMNJtqpWRUXHy7Tf0VKql4UkVGc=;
        b=CucGxNL/qEml3zneE5QIZXIRfJWaQYYTuT6iF2zH9HWv3ty+4MSq2CkuVPNAaTUYNT
         bz90W82vIpnbQn4D61s9RQsOIUrKtg6pvJysPbJxagZxoutazmoG4Mrzv6UllLUfpsrd
         1RAG6XPq0+GDgRdMOMNayLMsnjNdcSSe2qnV7FqklG7AVwCm5xkMVe65zd8CyUcGKA4G
         mnI+xYFbkLcbWndQsV5hGi8vaxyqXx61Eho9urkVIsulY0Zl1EuKO9FDNOQNPXtB1R9q
         ecqjIkkXISdI/3kABY8HaRc8dqYHSo7XGB8spilWlW2hIOjwOT3wNef8ptRYryDEerJq
         Galg==
X-Forwarded-Encrypted: i=1; AJvYcCXgKFl/3tTmKqk5FeDnVqjvSDD2NeEz+A67a+nvYiqDjLsOxSZRl75XoYbq0NaR2bt22OYJYLcmR0j80yM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1PDZJ14lVnvBbQuXF9DDdg0KRIfNkrR8Rc11TCgM8E4IOzSu4
	A9U8SxdR+3nA81haYxEulFvNLfsR6USB3J4Zm02yft+9EjgG2/ZHcAd9IVpMS2e4d0AbGOG8k79
	NjcFrJWGzcKecc6+KGaSC+vCc2I7+7OI=
X-Gm-Gg: ASbGncsuujQxVEsWTaitSEI8/+dIfK1ZA1bFTluLm84BgZgINMwW1HFFE/tKaiSNdR6
	XG/RLlWCmrVw42aNq1K/6ysNZBw1cOU/mD4IR2rUU22jZNTIbnT5LVduedc+xBZXLq5djfyF+/o
	+ZAJyMXHwgylxIRuV4hgai2HWnue27CXh53MfNit/S57Lp2qpKEMQkiNvuixPNTxjNH6S6PMioZ
	19LpRQ5jetTKEv8/uiz0ySM/eOT6oUHziUhsu/V5/k42lDX4O05bggnvtE9nT4mmFCF5r15FQQ2
	uNB4y5KU+mManu/CtA==
X-Google-Smtp-Source: AGHT+IFscxFW2ggLMAed0mcLjS+lTPXX/IYypIrwnI23PlvXCQXGwz8zeMmX8xN1ppTvvvdFYTwUzBStVAqGAO5MNc4=
X-Received: by 2002:a05:6000:430d:b0:428:3d1d:6d19 with SMTP id
 ffacd0b85a97d-429bd6e3c35mr975711f8f.47.1761863896907; Thu, 30 Oct 2025
 15:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030030010.95352-2-dongml2@chinatelecom.cn> <18b6f2c755710330b0c7399d17606a46c977f1ba3de4f37319aa1783638b1d2f@mail.kernel.org>
In-Reply-To: <18b6f2c755710330b0c7399d17606a46c977f1ba3de4f37319aa1783638b1d2f@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 30 Oct 2025 15:38:05 -0700
X-Gm-Features: AWmQ_bmL7lntft1GBOHR2IcVkzf9liFe42SBURFh4tzSUjIC9KTBL9QL13tu4yM
Message-ID: <CAADnVQKaUqRMvbno2RKo+kfK98377hkUjxSGMBV5qzgHOvkoMg@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: use rqspinlock for lru map
To: bot+bpf-ci@kernel.org
Cc: Menglong Dong <menglong8.dong@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Leon Hwang <leon.hwang@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, jiang.biao@linux.dev, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Chris Mason <clm@meta.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 8:38=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
>
> ```
> commit 8ae9fd98fe53c45a1a89adf6d254c2db90d26544
> Author: Menglong Dong <menglong8.dong@gmail.com>
>
> bpf: use rqspinlock for lru map
>
> This patch converts raw_spinlock_t to rqspinlock_t in BPF LRU maps to
> prevent NMI context deadlocks. The new lock API can fail gracefully
> instead of deadlocking, returning an error code.
>
> Link: https://lore.kernel.org/bpf/CAEf4BzbTJCUx0D=3Dzjx6+5m5iiGhwLzaP94hn=
w36ZMDHAf4-U_w@mail.gmail.com/
>
> > diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
> > index e7a2fc605..38fddcb1e 100644
> > --- a/kernel/bpf/bpf_lru_list.c
> > +++ b/kernel/bpf/bpf_lru_list.c
>
> [ ... ]
>
> > @@ -466,23 +470,26 @@ static struct bpf_lru_node *bpf_common_lru_pop_fr=
ee(struct bpf_lru *lru,
> >       do {
> >               steal_loc_l =3D per_cpu_ptr(clru->local_list, steal);
> >
> > -             raw_spin_lock_irqsave(&steal_loc_l->lock, flags);
> > +             if (raw_res_spin_lock_irqsave(&steal_loc_l->lock, flags))
> > +                     goto out_next;
> >
> >               node =3D __local_list_pop_free(steal_loc_l);
> >               if (!node)
> >                       node =3D __local_list_pop_pending(lru, steal_loc_=
l);
> >
> > -             raw_spin_unlock_irqrestore(&steal_loc_l->lock, flags);
> > +             raw_res_spin_unlock_irqrestore(&steal_loc_l->lock, flags)=
;
> >
> > +out_next:
> >               steal =3D cpumask_next_wrap(steal, cpu_possible_mask);
> >       } while (!node && steal !=3D first_steal);
> >
> >       loc_l->next_steal =3D steal;
> >
> >       if (node) {
> > -             raw_spin_lock_irqsave(&loc_l->lock, flags);
> > +             if (raw_res_spin_lock_irqsave(&loc_l->lock, flags))
> > +                     return NULL;
>                         ^^^^^^^^^^^
>
> Can this leak the node? At this point in bpf_common_lru_pop_free(),
> a node was successfully stolen from another CPU's list. The
> __local_list_pop_free() or __local_list_pop_pending() call removed
> the node from steal_loc_l, and steal_loc_l was unlocked. The node
> now exists but is not in any list.
>
> When raw_res_spin_lock_irqsave() fails here, the function returns
> NULL, but the stolen node is never added to the local pending list
> and never returned to any list. The node becomes orphaned.

AI is right. Here and in other places you can just leak the objects.
res_spin_lock() is not a drop-in replacement.
The whole thing needs to be thought through.

