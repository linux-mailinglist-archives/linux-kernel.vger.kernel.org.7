Return-Path: <linux-kernel+bounces-795434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF82B3F200
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 03:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641F21A82C6E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 01:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59941F91F6;
	Tue,  2 Sep 2025 01:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRN7Gou4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F6115539A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 01:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756777776; cv=none; b=p6vd5juf35oS4fBA8tcUAdVxIiBNSN9f/3ddfRPIK2Kwh/SNHY8F1fUD154ySOO3HJ2OIR09bL/Xbuxj4PJWljoKnA0Ujdn8dwiiOUegtUOhKUxMlvLhZrbwwDqgbMfN49nSEoEIrIy7R/vwvwtRe3RprqobccTN6voWUSDkhTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756777776; c=relaxed/simple;
	bh=8M8wnjRYNPa0jtbL/Noba8HTd/cqzH4ui9hKV/F7loU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sj2940tR/lMKDZTJ1dnICqTdUJu3FgYux5XIOorV1jsyY6QzD3KlhB6vhAjPNK0OeQgFAMD2NpABuKD2KTQUBy9+ljG/zuXwidIMhURCzV7tYqc3iaHpsFeIlCQdhaRba4O4dXkrK3t/wqpQpWDWs9CCMKgGkxKEmcCS5UxZHc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRN7Gou4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC59C4CEF0;
	Tue,  2 Sep 2025 01:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756777775;
	bh=8M8wnjRYNPa0jtbL/Noba8HTd/cqzH4ui9hKV/F7loU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRN7Gou4OABBn9mlDaRLEp4VCeCBzahudyrXnvcxU+/TZyHLuurlIkuuCJ3OHoQTu
	 kWWlP+ote19hsy/oahskqXVB5hbctkXkeQr0GwxhWP8+JyaZgBRAckKISLJ5Hock/1
	 Emo+mpZsOo58573gxzfPov1buzoG/xBdV4TEnNKd/TXTA6zlD6LAnA0Ss0WmYiOxm6
	 K0JK9op2UJ1McsiMhyef7muPqGCxwAx4IxiQhsjBB6yg1BZ8QOajFdgvfl4u1Nh0QA
	 hFMkpifOKnD8C2WcYQU+e0BH4tdnRVbukkEAr15B4rMmOogpp74cjAV8+WD1ov/BEc
	 lWz3d3DLYJRIg==
From: SeongJae Park <sj@kernel.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: SeongJae Park <sj@kernel.org>,
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
Date: Mon,  1 Sep 2025 18:49:33 -0700
Message-Id: <20250902014933.93741-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250901183729.3900578-1-cascardo@igalia.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On Mon,  1 Sep 2025 15:37:28 -0300 Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:

> When OOM is triggered, it will show where the pages might be for each zone.
> When using zram, it might look like lots of pages are missing. After this
> patch, zspages are shown as below.
[...]
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>  mm/show_mem.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/show_mem.c b/mm/show_mem.c
> index 41999e94a56d..ecf20a93ea54 100644
> --- a/mm/show_mem.c
> +++ b/mm/show_mem.c
> @@ -310,6 +310,7 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
>  			" inactive_file:%lukB"
>  			" unevictable:%lukB"
>  			" writepending:%lukB"
> +			" zspages:%lukB"
>  			" present:%lukB"
>  			" managed:%lukB"
>  			" mlocked:%lukB"
> @@ -332,6 +333,7 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
>  			K(zone_page_state(zone, NR_ZONE_INACTIVE_FILE)),
>  			K(zone_page_state(zone, NR_ZONE_UNEVICTABLE)),
>  			K(zone_page_state(zone, NR_ZONE_WRITE_PENDING)),
> +			K(zone_page_state(zone, NR_ZSPAGES)),

I found latest mm-new fails kunit's um build as below, and 'git bisect' points
this patch.

    $ make all compile_commands.json scripts_gdb ARCH=um O=.kunit --jobs=40
    ERROR:root:In file included from ../mm/show_mem.c:18:
    ../mm/show_mem.c: In function ‘show_free_areas’:
    ../mm/show_mem.c:336:49: error: ‘NR_ZSPAGES’ undeclared (first use in this function); did you mean ‘NR_STATS’?
      336 |                         K(zone_page_state(zone, NR_ZSPAGES)),
          |                                                 ^~~~~~~~~~
    [...]

Maybe some CONFIG_ZSMALLOC undeclard case handling, like below, is needed?

    --- a/mm/show_mem.c
    +++ b/mm/show_mem.c
    @@ -333,7 +333,9 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
                            K(zone_page_state(zone, NR_ZONE_INACTIVE_FILE)),
                            K(zone_page_state(zone, NR_ZONE_UNEVICTABLE)),
                            K(zone_page_state(zone, NR_ZONE_WRITE_PENDING)),
    +#if IS_ENABLED(CONFIG_ZSMALLOC)
                            K(zone_page_state(zone, NR_ZSPAGES)),
    +#endif
                            K(zone->present_pages),
                            K(zone_managed_pages(zone)),
                            K(zone_page_state(zone, NR_MLOCK)),


Thanks,
SJ

[...]

