Return-Path: <linux-kernel+bounces-757098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C65B1BDA9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 02:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C279C620077
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 00:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B7B2BDC33;
	Tue,  5 Aug 2025 23:59:56 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F912BDC20
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 23:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754438396; cv=none; b=Qt0P5b/YYnAdmE4c316hDYHLLPKwwUQx0jXOQ/E3HMXrKw/vNzZzsb8QIc5ZCFzIbvp6sCKCww+Ptcj2l5LyornhP6lK7mIjuWpoL6wkbmaCEEB2bZLjvsz7dh/B6i1C/3hVtyJmys7gWQdYq5tf1XohfKjyIXBSA+DapKRQ9jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754438396; c=relaxed/simple;
	bh=T7FWAJl2O0sB9hDVUZvzEUX1GkEPWogbdYPF7hesC38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pENkm4pijnWzioHaq7hg5JYz3Y8zqzHQEPMqisS/NGfuYSHlgztsKTVqW9sAm9R3w9NjT5xxal2JYox7vrMHZPzRSXz+tN7UiQDnxEO9pOU0FEHzap7aJnB2W/oh/04Jmsho6IARRsz1fjEF68veVv3DynZM5ALhv/6G+0FZCQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-02-68929af3b516
Date: Wed, 6 Aug 2025 08:59:41 +0900
From: Byungchul Park <byungchul@sk.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>, SeongJae Park <sj@kernel.org>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Gregory Price <gourry@gourry.net>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>, Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel-team@meta.com, kernel_team@skhynix.com
Subject: Re: [PATCH v3] mempolicy: Clarify what zone reclaim means
Message-ID: <20250805235941.GA53923@system.software.com>
References: <20250805205048.1518453-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805205048.1518453-1-joshua.hahnjy@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LhesuzSPfzrEkZBl2LhSzmrF/DZrHrRojF
	1/W/mC1+3j3ObnF86zx2i30XgeKXd81hs7i35j+rxbc+aYvDX98wWaxek2Ex++g9dgcej52z
	7rJ7dLddZvdYvOclk8emVZ1sHps+TWL3ODHjN4vHzoeWHucuVnj0Nr9j83i/7yqbx+dNcgHc
	UVw2Kak5mWWpRfp2CVwZOxefZiuYKlqxa/U3xgbG6YJdjJwcEgImEncnNzN3MXKA2ctbvEDC
	LAIqEs/bbzGD2GwC6hI3bvwEs0UENCVOtE4Csrk4mAW2M0vsOjiLDSQhLOAk0XHjPSOIzStg
	IbFj/3x2EFtIwE5iz9v1bBBxQYmTM5+wgNjMAloSN/69ZALZyywgLbH8HwdImFPAXmLvxF2s
	ILaogLLEgW3HmUB2SQi0s0vMe7OPGeJmSYmDK26wTGAUmIVk7CwkY2chjF3AyLyKUSgzryw3
	MTPHRC+jMi+zQi85P3cTIzB+ltX+id7B+OlC8CFGAQ5GJR7eDNFJGUKsiWXFlbmHGCU4mJVE
	eGPq+zOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xp9K08REkhPLEnNTk0tSC2CyTJxcEo1MJoa
	z3aetfW6B9OE04sbKtpWx3lu5X3qzvU/wuvbVMddnyfeXP5v2hHTPQ9/XtqxWcEqyuxmFG/m
	HMXzZ10YfbLsGSMuPrp8QGOF+bN3a3/fbOOZXmEjfe3lEovJlilbD8Zx1R1bIHNhkd+yP0zn
	/1k/bgm2jH6v1PnFcaezjcexTN6FZ7/t8jqpxFKckWioxVxUnAgA12be3ZsCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsXC5WfdrPt51qQMgyMTGS3mrF/DZrHrRojF
	1/W/mC1+3j3ObnF86zx2i30XgeKH555ktbi8aw6bxb01/1ktvvVJWxy69pzV4vDXN0wWq9dk
	WMw+eo/dgc9j56y77B7dbZfZPRbvecnksWlVJ5vHpk+T2D1OzPjN4rHzoaXHuYsVHr3N79g8
	3u+7yubx7baHx+IXH5g8Pm+SC+CN4rJJSc3JLEst0rdL4MrYufg0W8FU0Ypdq78xNjBOF+xi
	5OCQEDCRWN7i1cXIycEioCLxvP0WM4jNJqAucePGTzBbREBT4kTrJCCbi4NZYDuzxK6Ds9hA
	EsICThIdN94zgti8AhYSO/bPZwexhQTsJPa8Xc8GEReUODnzCQuIzSygJXHj30smkL3MAtIS
	y/9xgIQ5Bewl9k7cxQpiiwooSxzYdpxpAiPvLCTds5B0z0LoXsDIvIpRJDOvLDcxM8dUrzg7
	ozIvs0IvOT93EyMwPpbV/pm4g/HLZfdDjAIcjEo8vBmikzKEWBPLiitzDzFKcDArifDG1Pdn
	CPGmJFZWpRblxxeV5qQWH2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTDWq7FXTd1T
	78/NsyvQU/fszcbwaw/Nphdqn7i87PL9wuO3PJhE3onfdDd53GUheGGqZ4B6deE/jtPXfj85
	6rjB1Wnj9kWduu/6W6+nftsx/dIu08BGo9tcQsWhzgvDPs578e/NrN1aC5stE51mPZk7z8h7
	shijwJu5j3Qrsj2nWyzy0DmfMvmWEktxRqKhFnNRcSIAgiVw8YsCAAA=
X-CFilter-Loop: Reflected

On Tue, Aug 05, 2025 at 01:50:47PM -0700, Joshua Hahn wrote:
> The zone_reclaim_mode API controls the reclaim behavior when a node runs out of
> memory. Contrary to its user-facing name, it is internally referred to as
> "node_reclaim_mode".
> 
> This can be confusing. But because we cannot change the name of the API since
> it has been in place since at least 2.6, let's try to be more explicit about
> what the behavior of this API is.
> 
> Change the description to clarify what zone reclaim entails, and be explicit
> about the RECLAIM_ZONE bit, whose purpose has led to some confusion in the
> past already [1] [2].
> 
> While at it, also soften the warning about changing these bits.
> 
> [1] https://lore.kernel.org/linux-mm/1579005573-58923-1-git-send-email-alex.shi@linux.alibaba.com/
> [2] https://lore.kernel.org/linux-mm/20200626003459.D8E015CA@viggo.jf.intel.com/
> 
> Acked-by: SeongJae Park <sj@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> ---
> v2 --> v3:
> - Fixed typos
> - Softend wording from "never" --> "should not"
> 
>  include/uapi/linux/mempolicy.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
> index 1f9bb10d1a47..683c130782f0 100644
> --- a/include/uapi/linux/mempolicy.h
> +++ b/include/uapi/linux/mempolicy.h
> @@ -66,10 +66,16 @@ enum {
>  #define MPOL_F_MORON   (1 << 4) /* Migrate On protnone Reference On Node */
> 
>  /*
> + * Enabling zone reclaim means the page allocator will attempt to fulfill
> + * the allocation request on the current node by triggering reclaim and
> + * trying to shrink the current node.
> + * Fallback allocations on the next candidates in the zonelist are considered
> + * when reclaim fails to free up enough memory in the current node/zone.

I was confused too, at the beginning.  Thanks for the explicit comment.

Acked-by: Byungchul Park <byungchul@sk.com>

	Byungchul

> + *
>   * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
> - * ABI.  New bits are OK, but existing bits can never change.
> + * ABI.  New bits are OK, but existing bits should not be changed.
>   */
> -#define RECLAIM_ZONE   (1<<0)  /* Run shrink_inactive_list on the zone */
> +#define RECLAIM_ZONE   (1<<0)  /* Enable zone reclaim */
>  #define RECLAIM_WRITE  (1<<1)  /* Writeout pages during reclaim */
>  #define RECLAIM_UNMAP  (1<<2)  /* Unmap pages during reclaim */
> 
> 
> base-commit: 6bcdbd62bd56e6d7383f9e06d9d148935b3c9b73
> --
> 2.47.3

