Return-Path: <linux-kernel+bounces-797566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAA6B411F4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435D8548241
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C7A1684B4;
	Wed,  3 Sep 2025 01:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ph0ZExWO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9494536B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 01:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756863064; cv=none; b=uQdESNQiMxeIrMQdAzSj4LxEbine9PJJ2xiDr5nW8xuoe4TymFZeOzv0lyUikpzztrMjh9/70nwdkrSUXL79k3rc7Xa9xgR7MfIJ9vYkPxYBkfn4qoe02Us+WPTTMq5DtLey0aj24xD1dE2TLfy6TwIdsRsbeuuVJADfzD/FcYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756863064; c=relaxed/simple;
	bh=kqYf/4DtmRggyCL5vvRGSjcy7p5hV4/sZ1rl1iXDH6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j3zudNmPptvg9XS2Nx1m3rTnpzWXOCAyWANSLzgCW2ZNxpqCbINC7HEETMApyiapo6zC+/167XBp5AMOtW6u8mcGvZXTzzc8su+igyDUC8quXQTNZmdaK924RLpicNjEeH4IK3ozrlNPEwW7NVMRPu8owaNjdkxFbOOhcH7b5Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ph0ZExWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58D8C4CEED;
	Wed,  3 Sep 2025 01:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756863064;
	bh=kqYf/4DtmRggyCL5vvRGSjcy7p5hV4/sZ1rl1iXDH6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ph0ZExWOTBSSmdRfB4nmMhQhpcprkugPz/3bDYGAsmJlDy/PRZCLfFe4VWhx8UcxK
	 GvxTS2gTgHt8ho4jjnQBpzPHuy8cKx+bXFnjPwq2x/KVW4W8VleFoKZZVbpOJDeYmZ
	 X02vYw4zs7CnPVub1abgfNYQFzxZ21DKLEVxtzXqwVyu2ridEC87Zi8fKV5PdqicZM
	 WUK/GQH+5IW6Z7ZCIVBoiG1t5Vu//ll0qvnjvGgcTac4EumsDOGn8MWGTdUfQKzXjH
	 lrceChUUKZhRSYVUXIYGQ3VRp6Z93MZweRgm7Jb0Zvysbzuxy3hjs3gOqUcc9ZY+TA
	 uxjPGStPBlnnw==
From: SeongJae Park <sj@kernel.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH v2] mm: show_mem: show number of zspages in show_free_areas
Date: Tue,  2 Sep 2025 18:31:00 -0700
Message-Id: <20250903013100.190488-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250902-show_mem_zspages-v2-1-545daaa8b410@igalia.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  2 Sep 2025 09:49:21 -0300 Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:

> When OOM is triggered, it will show where the pages might be for each zone.
> When using zram or zswap, it might look like lots of pages are missing.
> After this patch, zspages are shown as below.
> 
> [   48.792859] Node 0 DMA free:2812kB boost:0kB min:60kB low:72kB high:84kB reserved_highatomic:0KB free_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB zspages:11160kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [   48.792962] lowmem_reserve[]: 0 956 956 956 956
> [   48.792988] Node 0 DMA32 free:3512kB boost:0kB min:3912kB low:4888kB high:5864kB reserved_highatomic:0KB free_highatomic:0KB active_anon:0kB inactive_anon:28kB active_file:8kB inactive_file:16kB unevictable:0kB writepending:0kB zspages:916780kB present:1032064kB managed:978944kB mlocked:0kB bounce:0kB free_pcp:500kB local_pcp:248kB free_cma:0kB
> [   48.793118] lowmem_reserve[]: 0 0 0 0 0
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

