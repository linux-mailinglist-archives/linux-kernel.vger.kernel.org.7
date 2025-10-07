Return-Path: <linux-kernel+bounces-844802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA05BC2CFB
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A96D188AEF3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5E425782F;
	Tue,  7 Oct 2025 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eqTBKJ2M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20E51F63CD;
	Tue,  7 Oct 2025 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759874397; cv=none; b=JJVbR+On2CcaFUhPRGQawWmzv16yowR+wWAU7W5ba8lplusqcivF33dnlqcORXDTmKRjpXIJ5gbmLHjoS1vSOwyfcdC+gXgJVVbnG3tj5gshbJzLn71MU6iIhhKi4Csol8/pvuq3MMUFhYN8QppYM11k6Yl6t/6Ee3OR98hf4Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759874397; c=relaxed/simple;
	bh=ehRXRPc5gq4sto6XUaGVVNc4Uvx89XC3Wfecl1rHaAg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ehLlS6TN+9Y//0cslhL7tiuiIlD02XyM5s48Sd/l/d/2qXy5SmAlOyt8A6AQKZTEexlutInBgl6ABAc+HvEcdyuR2r80dobeCVJ5grDNrhJarjwzawdB/uZ4J9vSnIg1oLpX0AtpfnANlsg2OxLI3LyiPQQFjjXo3+P0RcH4o/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eqTBKJ2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94009C4CEF1;
	Tue,  7 Oct 2025 21:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1759874397;
	bh=ehRXRPc5gq4sto6XUaGVVNc4Uvx89XC3Wfecl1rHaAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eqTBKJ2M8ObGhNoqy8DBYa55islBZD7ZRmjTMTsXwVL99OoeyEL4uo6QHewJll/Vv
	 MLm8Zlu0p6IOruOhar0793ib45TmpBnhcl+5W6rW9hSLU1R8vV3kPSmzNJLoF7X8Cz
	 issd+zGW5zc6o2ZuYQfIE0VzhoVU1SvQjo+Rmvxg=
Date: Tue, 7 Oct 2025 14:59:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, corbet@lwn.net, muchun.song@linux.dev,
 osalvador@suse.de, david@redhat.com, hannes@cmpxchg.org,
 laoar.shao@gmail.com, brauner@kernel.org, mclapinski@google.com,
 joel.granados@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>, Michal Hocko
 <mhocko@suse.com>, Alexandru Moise <00moses.alexander00@gmail.com>, Mike
 Kravetz <mike.kravetz@oracle.com>, David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] Revert
 "mm, hugetlb: remove hugepages_treat_as_movable sysctl"
Message-Id: <20251007145955.31dba3afad6200e885e906a5@linux-foundation.org>
In-Reply-To: <20251007214412.3832340-1-gourry@gourry.net>
References: <20251007214412.3832340-1-gourry@gourry.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Oct 2025 17:44:12 -0400 Gregory Price <gourry@gourry.net> wrote:

> This reverts commit d6cb41cc44c63492702281b1d329955ca767d399.

It's been seven years.  Perhaps "reintroduce hugepages_treat_as_movable
sysctl" would be a better way of presenting this.  Not very important.

> This sysctl provides some flexibility between multiple requirements which
> are difficult to square without adding significantly more complexity.
> 
> 1) onlining memory in ZONE_MOVABLE to maintain hotplug compatibility
> 2) onlining memory in ZONE_MOVABLE to prevent GFP_KERNEL usage
> 3) passing NUMA structure through to a virtual machine (node0=vnode0,
>    node1=vnode1) so a guest can make good placement decisions.
> 4) utilizing 1GB hugepages for VM host memory to reduce TLB pressure
> 5) Managing device memory after init-time to avoid incidental usage
>    at boot (due to being placed in ZONE_NORMAL), or to provide users
>    configuration flexibility.
> 
> When device-hotplugged memory does not require hot-unplug assurances,
> there is no reason to avoid allowing otherwise non-migratable hugepages
> in this zone.  This allows for allocation of 1GB gigantic pages for VMs
> with existing mechanisms.
> 
> Boot-time CMA is not possible for driver-managed hotplug memory, as CMA
> requires the memory to be registered as SystemRAM at boot time.
> 
> Updated the code to land in appropriate locations since it all moved.
> Updated the documentation to add more context when this is useful.

I'll duck the patch for now, see what people have to say.

> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -55,6 +55,8 @@
>  #include "hugetlb_cma.h"
>  #include <linux/page-isolation.h>
>  
> +int hugepages_treat_as_movable;
> +
>  int hugetlb_max_hstate __read_mostly;
>  unsigned int default_hstate_idx;
>  struct hstate hstates[HUGE_MAX_HSTATE];

Could sprinkle some more __read_mostlys around here?

>
> ...
>

