Return-Path: <linux-kernel+bounces-747344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 629ECB132CB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 03:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D93A1894395
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 01:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE86198851;
	Mon, 28 Jul 2025 01:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xPOCyhAn"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D195A136E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 01:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753667056; cv=none; b=gJprI7gVdZDoH5dNyp4cjbqLfewWbMRCTEr/0tWGBkJbtyHasDBYBPmygwfi7XnccKt6JEq2BTRSpSEyMQbkCbTjXQcaL/zV085C2fox5kMno/3ioRMatpW7qnxXRYvRTPBYRnJ9EXT+xpGHb4FowpMRAiHThn9pEUUFb2udbvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753667056; c=relaxed/simple;
	bh=BEW18mkbPW12YdFGNWkkq1wqbX59znTn7FRLF5mwEAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tPW/DV1wr0T/NWM3AsJuCzG+LNIM5diz3QLRvR9k+R9sk0iqowi/jXX+n03NPC01/nIIU0KEayHNLZD3tU+wD7IL8R5vD3UbRxwISQ5jCHDkTKAIKEgwnb6UOSUYolfBnHysZATaGQG0f694Fonn5jOpTHlzOVw5a8c2BwxImnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xPOCyhAn; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753667050; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=06xZ+bJju6hr8mDQ5HFTV8f7N7lQsAGxfNBuRYPHHVo=;
	b=xPOCyhAnMTWwraPRn4aoaMdYGF1miD/gkCul6b9m9PT1sOOHisbrUZ5K0v7HagF9PrQIm6omTVi46H0azuPP96IUBdGZzqBWrhQ0bKGxJSgyF4E5v3GkAYYNnN50tiDwBSXYZgaiaKqG+UmejEH7oesy8KOhO3CDukuP/cF1KQc=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WkBGr5i_1753667048 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Jul 2025 09:44:08 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@redhat.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Zi Yan
 <ziy@nvidia.com>,  Matthew Brost <matthew.brost@intel.com>,  Rakie Kim
 <rakie.kim@sk.com>,  Byungchul Park <byungchul@sk.com>,  Gregory Price
 <gourry@gourry.net>,  Alistair Popple <apopple@nvidia.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  kernel-team@meta.com
Subject: Re: [PATCH] mempolicy: Clarify what RECLAIM_ZONE means
In-Reply-To: <20250725173546.2295177-1-joshua.hahnjy@gmail.com> (Joshua Hahn's
	message of "Fri, 25 Jul 2025 10:35:45 -0700")
References: <20250725173546.2295177-1-joshua.hahnjy@gmail.com>
Date: Mon, 28 Jul 2025 09:44:06 +0800
Message-ID: <87ms8p2iop.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Joshua,

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

> The zone_reclaim_mode API controls reclaim behavior when a node runs out of
> memory. Contrary to its user-facing name, it is internally referred to as
> "node_reclaim_mode". This is slightly confusing but there is not much we can
> do given that it has already been exposed to userspace (since at least 2.6).
>
> However, what we can do is to make sure the internal description of what the
> bits inside zone_reclaim_mode aligns with what it does in practice.
> Setting RECLAIM_ZONE does indeed run shrink_inactive_list, but a more holistic
> description would be to explain that zone reclaim modulates whether page
> allocation (and khugepaged collapsing) prefers reclaiming & attempting to
> allocate locally or should fall back to the next node in the zonelist.
>
> Change the description to clarify what zone reclaim entails.
>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> ---
>  include/uapi/linux/mempolicy.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
> index 1f9bb10d1a47..24083809d920 100644
> --- a/include/uapi/linux/mempolicy.h
> +++ b/include/uapi/linux/mempolicy.h
> @@ -69,7 +69,7 @@ enum {
>   * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
>   * ABI.  New bits are OK, but existing bits can never change.
>   */
> -#define RECLAIM_ZONE	(1<<0)	/* Run shrink_inactive_list on the zone */
> +#define RECLAIM_ZONE	(1<<0)	/* Prefer reclaiming & allocating locally */
>  #define RECLAIM_WRITE	(1<<1)	/* Writeout pages during reclaim */
>  #define RECLAIM_UNMAP	(1<<2)	/* Unmap pages during reclaim */
>  
>
> base-commit: 25fae0b93d1d7ddb25958bcb90c3c0e5e0e202bd

Please consider the document of zone_reclaim_mode in
Documentation/admin-guide/sysctl/vm.rst too.

And, IIUC, RECLAIM_ZONE doesn't mean "locally" exactly.  It's legal to
bind to some node other than "local node".

---
Best Regards,
Huang, Ying

