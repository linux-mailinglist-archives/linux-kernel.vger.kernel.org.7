Return-Path: <linux-kernel+bounces-757130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CC2B1BE12
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 02:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16C467A711B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 00:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850436A33B;
	Wed,  6 Aug 2025 00:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lxma2KTC"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C78AD2C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 00:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754441762; cv=none; b=bVo4bmpD5Tu0tU7BAdmlu/anjIQeBWZ1v29IiiUXIjFN6QJLVzr60XbFV/kcOtpl/ICGKAnfrFBpW1kUVpMHBcC0xU7nEVzDexbSZ29TmpW6+CBbEgGn8ByWBldZLWkls1uWLP+nVoq978ulzzEjhggRskpDZV9BOAt14ri6dLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754441762; c=relaxed/simple;
	bh=iPC3z3gMYVMG/CMuPenzeoTizHS5H2S9q/tIOZ4yh1Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NkgYFyQcrKmWcI0r/HO2hnm4fJjYjtl//OAN68zpU/PaTINoXNIAHEtc9bntOb2rd4O1lZPaBnX9jiy3veNvyHcXaerc5ldjkdyk9AWe7eMc4NmrIk/FTnoIi/RGDBgxuaaL/Qbycj5YLnACPJvFExt0rldIgnIZC7bavDmh3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lxma2KTC; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754441756; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=4Nv+Vg9VFAs7UldZj1lghwRAambUUpMnmtp1eMFhsOw=;
	b=lxma2KTCEn7aB06q5MgZxVIR1/+pu5BcNr9IPJItLwSpPl32sAoA5Ok7aqvcqms3mkM6IqVrHfYXB/cx3zLB1R/VXaIl59Ye8qU3KqAbvV3lenazPxZA+rSbGrkgYfl+KvcyqtuYfb6/fPQ++Q4bjOJlb6DNoW9JjqWZuO0+a3s=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wl7gM-I_1754441743 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Aug 2025 08:55:55 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@redhat.com>,  SeongJae Park <sj@kernel.org>,  Alistair Popple
 <apopple@nvidia.com>,  Byungchul Park <byungchul@sk.com>,  Gregory Price
 <gourry@gourry.net>,  Matthew Brost <matthew.brost@intel.com>,  Rakie Kim
 <rakie.kim@sk.com>,  Zi Yan <ziy@nvidia.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  kernel-team@meta.com
Subject: Re: [PATCH v3] mempolicy: Clarify what zone reclaim means
In-Reply-To: <20250805205048.1518453-1-joshua.hahnjy@gmail.com> (Joshua Hahn's
	message of "Tue, 5 Aug 2025 13:50:47 -0700")
References: <20250805205048.1518453-1-joshua.hahnjy@gmail.com>
Date: Wed, 06 Aug 2025 08:55:42 +0800
Message-ID: <87zfcduv3l.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

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
>  #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
>  
>  /*
> + * Enabling zone reclaim means the page allocator will attempt to fulfill
> + * the allocation request on the current node by triggering reclaim and
> + * trying to shrink the current node.
> + * Fallback allocations on the next candidates in the zonelist are considered
> + * when reclaim fails to free up enough memory in the current node/zone.
> + *
>   * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
> - * ABI.  New bits are OK, but existing bits can never change.
> + * ABI.  New bits are OK, but existing bits should not be changed.

Should we avoid to call sysctl ABI here?

>   */
> -#define RECLAIM_ZONE	(1<<0)	/* Run shrink_inactive_list on the zone */
> +#define RECLAIM_ZONE	(1<<0)	/* Enable zone reclaim */
>  #define RECLAIM_WRITE	(1<<1)	/* Writeout pages during reclaim */
>  #define RECLAIM_UNMAP	(1<<2)	/* Unmap pages during reclaim */
>  
>
> base-commit: 6bcdbd62bd56e6d7383f9e06d9d148935b3c9b73

---
Best Regards,
Huang, Ying

