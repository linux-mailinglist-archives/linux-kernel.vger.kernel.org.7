Return-Path: <linux-kernel+bounces-795479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB7BB3F29E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82045484A96
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 03:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD042DF3FD;
	Tue,  2 Sep 2025 03:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IStlruoH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B271E9B3A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 03:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756782842; cv=none; b=Lq58i3YE8ufnEkRvSuZaPhznvoRnaO9XAgwjYfqlX0gV6Cu2KqxCkd4HWJ7Sp/JWSG2rPb3nGQG6qGseelSRHFhXHHIB+ZPAZGbs0aoVF30MQ3DDwR6AqRmJJRgRD/bMXYAZ8FJYGXiF/95LCTqUpCYfpmx7oU3HCvHVw67dDso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756782842; c=relaxed/simple;
	bh=8tRc8k8YGWK9MMlGkaSLcLvU0VnkuktJf34kIwuKRNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXQkJE9HGbG+h8+stHuJsbEI4uekPmmcB/AmB2BAZ+dRJmFvBlBZgDfiWT6P1M8bJaQcFYB1bLqM7EZsxR8FFcMfOFN1XPCalIvw53Q+eXcX6f9G1IzLdur0kSJFqnLdvRBHuHv2L8faq/qw1CFTTe51cSUanLACtJqNJBoxHLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IStlruoH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9A0C4CEF0;
	Tue,  2 Sep 2025 03:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756782842;
	bh=8tRc8k8YGWK9MMlGkaSLcLvU0VnkuktJf34kIwuKRNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IStlruoHV17kUxTKoN29PmCrF7uh2z+fshCzr0KTNrPM1eeOpd/i+s9SjtFqHAgPg
	 Ak2RvUtwLGkDdD83HOWBfV8Mw/HD2DbCH0JobnrxVE86GgYLF5G9AlHcqHUGmjeIwY
	 JA7lPdTVT0LeVbXrQJfpb8xKUVine4dW9bGDe2c+Gva1JRq/RCSmN2C/OuaZkiUk4g
	 nVB3rVsEj2MDMjY/fa/oAeFnu5gndyK1aS5rBDmjZZ+pTCIlgrI7xduU++i3JZVrMQ
	 mtNqlyPelyKkaNkHV6AwUidgC+gzZVjblbGRgR/9b6BeV6+tdtC6YLp6GJtVfFydfj
	 /YtJV7E9s/cJw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	kernel-dev@igalia.com
Subject: Re: [PATCH] mm: show_mem: show number of zspages in show_free_areas
Date: Mon,  1 Sep 2025 20:13:59 -0700
Message-Id: <20250902031359.170361-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250902014933.93741-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon,  1 Sep 2025 18:49:33 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> On Mon,  1 Sep 2025 15:37:28 -0300 Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> 
> > When OOM is triggered, it will show where the pages might be for each zone.
> > When using zram, it might look like lots of pages are missing. After this
> > patch, zspages are shown as below.
> [...]
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > ---
> >  mm/show_mem.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/mm/show_mem.c b/mm/show_mem.c
> > index 41999e94a56d..ecf20a93ea54 100644
> > --- a/mm/show_mem.c
> > +++ b/mm/show_mem.c
> > @@ -310,6 +310,7 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
> >  			" inactive_file:%lukB"
> >  			" unevictable:%lukB"
> >  			" writepending:%lukB"
> > +			" zspages:%lukB"
> >  			" present:%lukB"
> >  			" managed:%lukB"
> >  			" mlocked:%lukB"
> > @@ -332,6 +333,7 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
> >  			K(zone_page_state(zone, NR_ZONE_INACTIVE_FILE)),
> >  			K(zone_page_state(zone, NR_ZONE_UNEVICTABLE)),
> >  			K(zone_page_state(zone, NR_ZONE_WRITE_PENDING)),
> > +			K(zone_page_state(zone, NR_ZSPAGES)),
> 
> I found latest mm-new fails kunit's um build as below, and 'git bisect' points
> this patch.
> 
>     $ make all compile_commands.json scripts_gdb ARCH=um O=.kunit --jobs=40
>     ERROR:root:In file included from ../mm/show_mem.c:18:
>     ../mm/show_mem.c: In function ‘show_free_areas’:
>     ../mm/show_mem.c:336:49: error: ‘NR_ZSPAGES’ undeclared (first use in this function); did you mean ‘NR_STATS’?
>       336 |                         K(zone_page_state(zone, NR_ZSPAGES)),
>           |                                                 ^~~~~~~~~~
>     [...]
> 
> Maybe some CONFIG_ZSMALLOC undeclard case handling, like below, is needed?
> 
>     --- a/mm/show_mem.c
>     +++ b/mm/show_mem.c
>     @@ -333,7 +333,9 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
>                             K(zone_page_state(zone, NR_ZONE_INACTIVE_FILE)),
>                             K(zone_page_state(zone, NR_ZONE_UNEVICTABLE)),
>                             K(zone_page_state(zone, NR_ZONE_WRITE_PENDING)),
>     +#if IS_ENABLED(CONFIG_ZSMALLOC)
>                             K(zone_page_state(zone, NR_ZSPAGES)),
>     +#endif

Of course, the above example will make the output shows wrong values on
'zspages:' and later fields when ZSMALLOC is unset.  Maybe below change on top
of the above diff makes sense?

    --- a/mm/show_mem.c
    +++ b/mm/show_mem.c
    @@ -335,6 +335,8 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
                            K(zone_page_state(zone, NR_ZONE_WRITE_PENDING)),
     #if IS_ENABLED(CONFIG_ZSMALLOC)
                            K(zone_page_state(zone, NR_ZSPAGES)),
    +#else
    +                       0,
     #endif
                            K(zone->present_pages),
                            K(zone_managed_pages(zone)),


Thanks,
SJ

[...]

