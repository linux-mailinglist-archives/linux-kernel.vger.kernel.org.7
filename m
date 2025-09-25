Return-Path: <linux-kernel+bounces-832133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CE2B9E6E2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373442E00CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98CD2EB863;
	Thu, 25 Sep 2025 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNS63t1Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241A92E8B8F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793016; cv=none; b=XwcTG3RbYtAt9C1CHrgAZKpd7/9zPccuMgaKsz/LQhLK45HpdBgetX0IRCQq0z6kibjORGgVSjkZHjOu+KB00iabS8qA9a5KNEei+egKg5PwdXyZlRn6+LF8PJi/MVJZKlqxIp/TOcENVQuK9PJBK24kTsMaBEU3FM/v8FUnB7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793016; c=relaxed/simple;
	bh=cs/L+0FILav66EYCnGQ2S40EG8qSxOGdJiC2KVHCzWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDaWBT6n/Dj88uWFZbpEYAC66r0RWpbxgT1rq/xmX1mcwYulv3vXYrwcUCH//Ha5XLB4CVX2cD9YqtQVJ/3xnJqp5X+CUAqdMR1JAZMlHDBuljzezzn9P7XQGWGl0PvMFFS9OpkPCBf/pg8iuuh2X5EN4Baoo/CTPQx7/wyzlVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNS63t1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6028FC4CEF0;
	Thu, 25 Sep 2025 09:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758793015;
	bh=cs/L+0FILav66EYCnGQ2S40EG8qSxOGdJiC2KVHCzWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KNS63t1YVh7qWaG9Mk5Zip6SaVXM184O6Qb2KV9EMskZBqPPNfZqUFaosPgubxI18
	 LsQkBDCtSVyx3pKh33fZtIqyy12Ylj1u4PkXwoZ13XS7W8A2O8hAbcQkgnLAOOWWDS
	 V50+hLErC1yQn0xrCei7L9bUlOtJLem7eOc27U/dgZNnkINcCBklSIByRyGkBDviIA
	 ZBORN1BW1GZhZAr2sA44EmknpdQE0QJSuQ7TMFjLIgo1/4NQlHPlgk+ipdL/JPGt0w
	 kBcA0MSKyXA3ud22LA7rGP5/i3c2K+dQuXuqtjkZ+VaTEL0JaJYwFLOzkEiTxeXDwl
	 gb7mZHKeW8Vow==
Date: Thu, 25 Sep 2025 12:36:46 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH 0/2] drivers/base/node: fold node register and unregister
 functions
Message-ID: <aNUNLlyy2Kj5VsGX@kernel.org>
References: <cover.1758736423.git.donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758736423.git.donettom@linux.ibm.com>

On Thu, Sep 25, 2025 at 12:10:49AM +0530, Donet Tom wrote:
> This change came from the discussion in [1]. It consists of two patches:
> 
> The first patch merges register_one_node() and register_node(), leaving a
> single register_node() function.
> 
> The second patch merges unregister_one_node() and unregister_node(), leaving
> a single unregister_node() function.
> 
> There is no functional change in these patches.
> 
> [1] https://lore.kernel.org/all/5512b1b6-31f8-4322-8a5f-add8d1e9b22f@redhat.com/
> 
> Donet Tom (2):
>   drivers/base/node: merge register_one_node() and register_node() to a
>     single function.
>   drivers/base/node: merge unregister_one_node() and unregister_node()
>     to a single function.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

>  arch/powerpc/platforms/pseries/pci_dlpar.c |  2 +-
>  arch/x86/mm/numa.c                         |  4 +-
>  drivers/base/node.c                        | 89 +++++++++-------------
>  include/linux/node.h                       | 10 +--
>  mm/memory_hotplug.c                        |  8 +-
>  mm/mm_init.c                               |  2 +-
>  6 files changed, 49 insertions(+), 66 deletions(-)
> 
> -- 
> 2.51.0
> 

-- 
Sincerely yours,
Mike.

