Return-Path: <linux-kernel+bounces-808791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E697AB504CB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F25A67B05CD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8900732CF75;
	Tue,  9 Sep 2025 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7gUZ61G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFB627FB18
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757440891; cv=none; b=JFQj8tA+r/gKzMIxAS0dJtJ24+JHfkZKpg1IIuyrk/3rzYcJrKYyhETAwCfUeo8sYC1n8ycFvyeS8Dj2uevA+yHbA786we+pRrFDPtQ4WhYog3gbsu1/UgIGehkoAZNlsTatTQDfhk8+nCelgz9yjxqxHqfdk+GJLqJdkdHLJNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757440891; c=relaxed/simple;
	bh=5ilK8ia7UPhfVMvyxiXK2/ObZT0rv1xyPRWOvrYgFLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZUlCMtfe7+Julp4UkcECY68G9xMBDUiJx4qfECl7/mksunk/f1HHz6UEiReC2o7JvPIYne6HY/SJTQga7wQ9rmeyGLOpc4iSj7N5GPOsCB1qEk0EOCNpmPa9nAynUwRB3qkHVdriO/Ah9nteOzYv1sdURMqYnWivVmqlmVPp6fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7gUZ61G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C32AC4CEF9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 18:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757440890;
	bh=5ilK8ia7UPhfVMvyxiXK2/ObZT0rv1xyPRWOvrYgFLg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A7gUZ61GSZHU6YDGEoeo6YaMEpuViXK5JJnpfKsLC3OdC/7OsNL1VMEFWk7WUc6nR
	 8xXTYol0G1LFeXmksDKOTVh2icvAU2FJTUdyJlbbG0y+/CZYE3LlMHlCk/4H+ZJphv
	 HDkMq0ck8Md86nJaZSdKg4n8ONb5a6hhU/KNQmQy6GcCyp/V7dwziUS95LTYo2E22c
	 YQGuiLlKALHda9ECCXEllwsWZ6u9aV1KdnP+z1d+A/uW71NpEKf6fB/RvUiEeZuvuB
	 V5dD9qONFZlZbDBJgxJuI5LDQdYn9w4i7pz+0xbSwYlC1CJOvlURSG5/lBccebrShG
	 kM81WQmbKjqFg==
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45de2856648so9425e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 11:01:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUX9flPlWYA0GT2f0cQWqTFk8H1ROO4XampcANWotQXNHnLjv1Rl8zeSBEPQVFp7jR+UhxhsQJUNSOskSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvAVillVdi0Jhxg9M3yUj/aV5iYjDqtq1KFD6rY0cEu4ElTyPh
	rXLCulxzH9fKpXuHTIjTbeP//eIibyg2iOLza3q/eQoKuVpoAqRjFN2x1e6izZFMFlcgZobtQfT
	oQleZBiGHexNdIDdyMcgxlKXZNg6GpqtczaFbh9Q+
X-Google-Smtp-Source: AGHT+IEHiqW6W81fKTiUrSgccv+699732yqAFTxOHwHdOHXueJL7aAAseuYOZ6okifCTYPp/jMJ7ubGR/z4jzyU8EOo=
X-Received: by 2002:a05:600c:33a9:b0:45d:f51c:193 with SMTP id
 5b1f17b1804b1-45df758d891mr14615e9.7.1757440888599; Tue, 09 Sep 2025 11:01:28
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909065349.574894-1-liulei.rjpt@vivo.com> <CAMgjq7Ca6zOozixPot3j5FP_6A8h=DFc7yjHKp2Lg+qu7gNwMA@mail.gmail.com>
 <CAGsJ_4xiTteQECtUNBo+eC9uu8R3CgVT2rpvGCGdFqc3psSnWQ@mail.gmail.com> <CAF8kJuM4BEeHnkhw5bSM6ap23paChMBZtqCY6ksie+8EghYb8g@mail.gmail.com>
In-Reply-To: <CAF8kJuM4BEeHnkhw5bSM6ap23paChMBZtqCY6ksie+8EghYb8g@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 9 Sep 2025 11:01:16 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNJEchVPWQhbKqePA7NBJsznVEzhfp1D-bxsC64aFfttA@mail.gmail.com>
X-Gm-Features: AS18NWChhVMZpbE3ggz7fev2b5EP2VFRMFP1IX5t70ZHFiaCFFddAwgtajoPUoU
Message-ID: <CAF8kJuNJEchVPWQhbKqePA7NBJsznVEzhfp1D-bxsC64aFfttA@mail.gmail.com>
Subject: Re: [PATCH v0 0/2] mm: swap: Gather swap entries and batch async release
To: Barry Song <21cnbao@gmail.com>
Cc: Kairui Song <ryncsn@gmail.com>, Lei Liu <liulei.rjpt@vivo.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, 
	Hao Jia <jiahao1@lixiang.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Usama Arif <usamaarif642@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Fushuai Wang <wangfushuai@baidu.com>, 
	"open list:MEMORY MANAGEMENT - OOM KILLER" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 9:15=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Tue, Sep 9, 2025 at 2:24=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
> > I feel the cover letter does not clearly describe where the bottleneck
> > occurs or where the performance gains originate. To be honest, even
> > the versions submitted last year did not present the bottleneck clearly=
.
> >
> > For example, is this due to lock contention (in which case we would
> > need performance data to see how much CPU time is spent waiting for
> > locks), or simply because we can simultaneously zap present and
> > non-present PTEs?
>
> I have done some long tail analysis of the zswap page fault a while
> back, before zswap converting to xarray. For the zswap page fault, in
> the long tail a good chunk is a bath free swap slot. The breakdown
> inside  shows a huge chunk is the clear_shadow() followed by
> memsw_uncharge(). I will post the link to the breakdown image once it
> is available.

Here is a graph, high level breakdown shows the batch free swap slot
contribute to the long tail:
https://services.google.com/fh/files/misc/zswap-breakdown.png

The detail breakdown inside bath free swap slots:
https://services.google.com/fh/files/misc/zswap-breakdown-detail.png

Those data are on pretty old data, before zswap uses the xarray.

Now the batch freeing the swap entries is gone. I am wondering if the
new kernel shows any bottleneck for Lei's zram test case.

Hi Lei, Please report back on your new findings. In this case, with
removal of swap slot cache, the performance profile will likely be
very different. Let me know if you have difficulties running the
latest kernel on your test bench.

Chris

