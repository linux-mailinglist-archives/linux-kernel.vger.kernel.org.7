Return-Path: <linux-kernel+bounces-746401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC68B1263D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 23:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FED81C28C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA44255F27;
	Fri, 25 Jul 2025 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GR04n0h2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D43253B71
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753479869; cv=none; b=hiLOV0mUsS+GYTVehSsvass+wpEZ93i4fyqoo6h/Q/ULYP3ebDPZqbSCNb2HSeMEKGYBAgav4FTZy8RqjfbypAcuqWe9VoHoB3W3skbjH/QFj36Imf2pOHxcgySQr3Ug4PkEYhO5132dp+NmjtDLV8roQ7B4qJEjoAqK6e9HHiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753479869; c=relaxed/simple;
	bh=Ur6WVXT+zlU1qsY+I4gZjcoE9NWvZt+RtiuwS/szdVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gI5JCdkH3QaRBYSS/1wRhiCSgb1esyfmUcUs9LSzCM0z1DO4iicugCKk7riQmCNfInDndzsDVOm82btzYJwVIK9Yr5AE12ffckrCoKfTNTa62Ch8IcCQJYivVRZxJwq0Trvh/SmqBftVk6gX3kjoc05ADyuO9hYCbAx0azYiEkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GR04n0h2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACB2C4CEE7;
	Fri, 25 Jul 2025 21:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753479868;
	bh=Ur6WVXT+zlU1qsY+I4gZjcoE9NWvZt+RtiuwS/szdVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GR04n0h2o7S/xCW5QmNqXw0mx9KKrV7Bou45GpHi+j+ANJPKxQLvZ9PfLOvkLueoV
	 iewzYhackZhg3IIg+T1egjF9vzT9BPwour7oxs0Wr6PudfsqI3poqM00mQyLWTYBGo
	 AZanlJD+u8n6eXSv1gyH24ANwMLfV0b6RIzaRaTkMf8G7E12UZt9brJCZ2KWVAWopg
	 TSEh+G3lWKZsoIUbBonjuCtCzJwprqRRQS5LbTPrnoIJ8g/sLTf5ykqeiYM+8IDg7y
	 auhemNSr4+RXgkM8j8FyY3KBk4rb6MPxXRweam1z4jN8XErKCM4GvM+aurj3r4zGrB
	 FdcrV3bIMLVRg==
From: SeongJae Park <sj@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH] mempolicy: Clarify what RECLAIM_ZONE means
Date: Fri, 25 Jul 2025 14:44:26 -0700
Message-Id: <20250725214426.51487-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250725173546.2295177-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joshua,

On Fri, 25 Jul 2025 10:35:45 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

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

I agree the new comment is more holistic.  It explains general
zone_reclaim_mode behavior (how the system works if the mode is turned on by
having any of rightmost three bits is set) well.  But, I think the old
description is for the specific mode of it (when the rightmost bit is set), and
the place is appropriate for that purpose.

What about keeping the old comment but adding the holistic description on the
upper multi-lines comments block?

And the behavior is also well described in zone_reclaim_mode section of
Documentation/admin-guide/sysctl/vm.rst document in my opinion.  Maybe putting
a reference to the doc together for readers who curious about more details
could also be useful?


Thanks,
SJ

[...]

