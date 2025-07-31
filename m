Return-Path: <linux-kernel+bounces-752670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97331B1792B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17EC51C23D06
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C486E27E1C8;
	Thu, 31 Jul 2025 22:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdkKqmjm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D3321CFF6
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754001719; cv=none; b=k3TkllgDauO/dG5G0SJHj58EIQjLrz8uHxIL67MHQKLvCHK2IZI2bm6/j5YB0QA+qCppodr2vYsJ0n5d8zu3+5rBSWPpCdvIHyOL2sRg9tDmH0mlViAojgSxoJA/jJqH5PmCk3dLY1/gm1r3Suju03DA2pUNAl5U0qbuRvPcC+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754001719; c=relaxed/simple;
	bh=NX3VDwS2KlMRe0hwzmcACuSTvo8Y4CFQGjFkgf0LbB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZIP/mR/Zft5qHZ3XJo3vLpsFNezN0GXFDN9ESRH9E5Zctja45NoeuV/CcoDJYdRD+SGJ+spPUygCSZF3hacAeQoK+ASMh2ZaM09F+j3OXc/LWaD+USAUE563bMwIgh96/3qku7C9BTUWuc50j2qqSLl1VNSw64AudVuN22w+8cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdkKqmjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D68BC4CEEF;
	Thu, 31 Jul 2025 22:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754001718;
	bh=NX3VDwS2KlMRe0hwzmcACuSTvo8Y4CFQGjFkgf0LbB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qdkKqmjmcmujLYDVA5N7mG/bn/cMLxTSmWjFuCttZmMsEQRupy82AlwKaJq3+KwEw
	 k/ROFw7V5Dkrusts59WmZt321IrJwdzsGdwY5g1Bv/Aovc4CG1IrKMztyydubQEPev
	 VPGUPCMBIT65IWwB6Nb4V9kJ0q4vJJCsG2U7ck2GU0qOyYhQVyZkurTVQLAz5FgVSj
	 GDn6gDB1PitRorEcCfea5Q77DucDNa3SsZAttjWsBrzC5l/FBHpgK281t/sIYdux6M
	 p/xFQhB2r8cJCagWBny6OmwjOxcnajRn9G38Q7Bgj0PtgXm/8PWl9MLZAa5YfCyiEq
	 A50uiISpybLtg==
From: SeongJae Park <sj@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Alistair Popple <apopple@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2] mempolicy: Clarify what zone reclaim means
Date: Thu, 31 Jul 2025 15:41:55 -0700
Message-Id: <20250731224155.1646-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250731210738.1451854-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 31 Jul 2025 14:07:37 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

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
> [1] https://lore.kernel.org/linux-mm/1579005573-58923-1-git-send-email-alex.shi@linux.alibaba.com/
> [2] https://lore.kernel.org/linux-mm/20200626003459.D8E015CA@viggo.jf.intel.com/
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> ---
>  include/uapi/linux/mempolicy.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
> index 1f9bb10d1a47..6c9c9385ff89 100644
> --- a/include/uapi/linux/mempolicy.h
> +++ b/include/uapi/linux/mempolicy.h
> @@ -66,10 +66,16 @@ enum {
>  #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
>  
>  /*
> + * Enabling zone reclaim means the page allocator will attempt to fulfill
> + * the allocation request on the current node by triggering reclaim and
> + * trying to shrink the current node.
> + * Fallback allocations on the next candidates in the zonelist are considered
> + * zone when reclaim fails to free up enough memory in the current node/zone.

s/zone when reclaim fails/when reclaim fails/ ?

> + *
>   * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
>   * ABI.  New bits are OK, but existing bits can never change.
>   */
> -#define RECLAIM_ZONE	(1<<0)	/* Run shrink_inactive_list on the zone */
> +#define RECLAIM_ZONE	(1<<0)	/* Enable zone reclaim */
>  #define RECLAIM_WRITE	(1<<1)	/* Writeout pages during reclaim */
>  #define RECLAIM_UNMAP	(1<<2)	/* Unmap pages during reclaim */
>  
> 
> base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2
> -- 
> 2.47.3
> 

Other than the above trivial thing,

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

