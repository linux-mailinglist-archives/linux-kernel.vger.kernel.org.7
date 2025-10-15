Return-Path: <linux-kernel+bounces-855359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A8CBE1003
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 01:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6612B19C5D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783F83164D0;
	Wed, 15 Oct 2025 23:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M37ZrIlu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34E131579B
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760569940; cv=none; b=XIyO8I7EtwuihaNWCDOph/84Nn3qmNnZqmEwdVy2Oj47wxCwNGKGmSe8AUKok3riy75b28SBdOmmAPXcpSjgJPzDijpeCZU3ZGx9ov7rYd/i3Ame1wPdG/mG+56Jtn14jcnuymvgg5CIhIbJ+uk1J92ieTyeyVWy7fUTqwhVgoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760569940; c=relaxed/simple;
	bh=r44UktmLfbn87icefxwzup3DZAKCpa44gU2sA9H0npw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHTAIdcimeAPzuNUvYM0tp7wqw1ceIHhkC9chERX4Y6deOrVhAQNzg4E7NQnx8FBUDa/SFf0PRLnaFoqD+k3cN0ZMQrBE77ErklM02GtAnZqZNJ3l7sexeBeKZzbG8PBDbrRmO2ZF8ol1lSFodJ/OS448JD6iyKvXYb0SDp5zoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M37ZrIlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A967C116C6
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760569940;
	bh=r44UktmLfbn87icefxwzup3DZAKCpa44gU2sA9H0npw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M37ZrIluwq5EeNwUaKS8VbE2fDg3ZFE1Bt8q8AASK4XuvaEBY9UHPgrR6Vo6hQTvO
	 HwjHoag6GWY3w6vHPNSMU/2soplGUj7M/aZANKW2HEZLqT8xeoo4TJqyupgBGMoUVE
	 NDvWoRBjbJZ9ALVMRE15YaBgrDcdI/Bf0bv4mMbNYj8uU5LCFxPKgFYMDazmdZmWeL
	 h2oBkg2tBO1iQlyVZBtk3uTFGK4OfKV1yhNiV0cJ+5jgVr+MAIDwJbJqkWCBuWJ8yY
	 ZVNOmyFKaGGYjWuBAq/23b3P+Kl4MqNBbwsdIL3XK6p9ghk/HLQ6rHSeEhaKHvKUTi
	 Rb+Nf9Ho011+w==
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-87c148fb575so1172576d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:12:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUU8EDtTLnrkWAbtxZhPMxZ9mJSSGoUUkykvr5a/s7UoFc2ZeqkTfg5S1P6HR5wvTKbo80FVLGoPrRFt6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf0cJrlOfqi8BjXQWJ9rpLZ7/QCMuIiBewwCczTbtHnXxiB7lU
	/rnTvL0FYNq9X2tOpavkabUldrHtjXwf6HJehSc8bkPJ5ADeBbP220bQW/fiz0f25ywRPomCwWI
	cEU+K0/1S08/1OU3DW3vvsmfVp2QVUh0=
X-Google-Smtp-Source: AGHT+IFLrZdMNDEHSuM1l+l7K0Igp2TgGHURmcyfMZduSiR21b8bfTpAX6I0Lw+bgngZoJ0JLG8z/3PI1EZqoF171Qs=
X-Received: by 2002:a05:6214:ac4:b0:802:7214:5bb with SMTP id
 6a1803df08f44-87b21031efemr529272216d6.28.1760569939755; Wed, 15 Oct 2025
 16:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015190813.80163-1-inwardvessel@gmail.com> <20251015190813.80163-2-inwardvessel@gmail.com>
In-Reply-To: <20251015190813.80163-2-inwardvessel@gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 15 Oct 2025 16:12:06 -0700
X-Gmail-Original-Message-ID: <CAHzjS_s3L7f=Rgux_Y3NQ7tz+Jmec5T8hLyQCxseLJ9-T-9xuQ@mail.gmail.com>
X-Gm-Features: AS18NWCRhZ0HbfQIAsuNZF3o7IVIRRvXVmXcToP6BTqFWLZSUci3-Th1d7PMPqA
Message-ID: <CAHzjS_s3L7f=Rgux_Y3NQ7tz+Jmec5T8hLyQCxseLJ9-T-9xuQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] memcg: introduce kfuncs for fetching memcg stats
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, andrii@kernel.org, ast@kernel.org, 
	mkoutny@suse.com, yosryahmed@google.com, hannes@cmpxchg.org, tj@kernel.org, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 12:08=E2=80=AFPM JP Kobryn <inwardvessel@gmail.com>=
 wrote:
>
[...]
> ---
>  mm/memcontrol.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4deda33625f4..6547c27d4430 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -871,6 +871,73 @@ unsigned long memcg_events_local(struct mem_cgroup *=
memcg, int event)
>  }
>  #endif
>
> +static inline struct mem_cgroup *memcg_from_cgroup(struct cgroup *cgrp)
> +{
> +       return cgrp ? mem_cgroup_from_css(cgrp->subsys[memory_cgrp_id]) :=
 NULL;
> +}
> +

We should add __bpf_kfunc_start_defs() here, and __bpf_kfunc_end_defs()
after all the kfuncs.

> +__bpf_kfunc static void memcg_flush_stats(struct cgroup *cgrp)

We mostly do not make kfunc static, but it seems to also work.

> +{
> +       struct mem_cgroup *memcg =3D memcg_from_cgroup(cgrp);
> +
> +       if (!memcg)
> +               return;

Maybe we can let memcg_flush_stats return int, and return -EINVAL
on memcg =3D=3D NULL cases?

> +
> +       mem_cgroup_flush_stats(memcg);
> +}
> +
[...]

