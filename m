Return-Path: <linux-kernel+bounces-888162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2B7C39FFC
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE09A188F846
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF80630C628;
	Thu,  6 Nov 2025 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEAu6+aR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEB7225760
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423285; cv=none; b=Sy6NUKITXmNGP49Xl+ErVE6XaWngWb/B7trJRUoO4j8ezlxuucr56IvSY8Ihf17akK41dq2a0NuSOvqZ2bP/uZ4g+wNyAjnrdHq82e1wlDEOERiTAaEThM7FijqMbkUZXIjl8zcKTrBhT/QFlYrkG9WHwawwlkF1RG0cuU9Gzd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423285; c=relaxed/simple;
	bh=iesv8rC4QL3CIngwo4NyosSS6ta4t5WL2Exyy3yA59w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxtVVbyBM4sgMFJaOkPtnsjrmYOE+CJ8EIf+q8sEyjzcaqh2NkOnj0hFDjZ1vZqGU8DTXNordh1yV/u8qQhZdS5W0V2E93na7mSjPCHb6oq8gDwSdnWLNrD956XzfMzvDVi/9uTaGeT87Rtp0AIjSfYfnnj5+5sDbKmb0iWsD/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEAu6+aR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53586C4AF09;
	Thu,  6 Nov 2025 10:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762423284;
	bh=iesv8rC4QL3CIngwo4NyosSS6ta4t5WL2Exyy3yA59w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fEAu6+aRo3d5d8m/ufEdiQ9WpLry8x99RB9cJihQTwfgbp2i5L3HqpCsuP9B9mRK1
	 zTOKLwgeHpWHHE0BD36pWhDu7aktyGUsbedSntOskcbGOuW3pUqFaVXj6zSCAgraZ/
	 ZJ+qJGLf9SRH9rgph2nn7KV8fzB03B2ZG0RSOmFUSWO05RMmIYXI4oPP9QcxNU/SSx
	 UO+09a3UNwkW7dXkZ7+3hmsWWCiYVzRym8aK1kGnzIQW6M+1M6/oUPFbtavKwmKyiP
	 ++sOVeS+c3yKZLlOCl8CTRcwPyoHrtTPA7xLizpV+AI/LpNiQgSfm1fdAAsqHv6dAr
	 B4AVLpt7gsNfA==
Message-ID: <5c7c607e-079e-4650-be8d-6a1210730b57@kernel.org>
Date: Thu, 6 Nov 2025 11:01:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] hugetlb: add memory-hotplug notifier to only allocate for
 online nodes
To: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:HUGETLB SUBSYSTEM" <linux-mm@kvack.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com
References: <20251106085645.13607-1-swarajgaikwad1925@gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251106085645.13607-1-swarajgaikwad1925@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06.11.25 09:56, Swaraj Gaikwad wrote:
> This patch is a RFC on a proposed change to the hugetlb cgroup subsystem’s
> css allocation function.
> 
> The existing hugetlb_cgroup_css_alloc() uses for_each_node() to allocate
> nodeinfo for all nodes, including those which are not online yet
> (or never will be). This can waste considerable memory on large-node systems.
> The documentation already lists this as a TODO.

We're talking about the

kzalloc_node(sizeof(struct hugetlb_cgroup_per_node), GFP_KERNEL, node_to_alloc);

$ pahole mm/hugetlb_cgroup.o

struct hugetlb_cgroup_per_node {
         long unsigned int          usage[2];             /*     0    16 */

         /* size: 16, cachelines: 1, members: 1 */
         /* last cacheline: 16 bytes */
};

16 bytes on x86_64. So nobody should care here.

Of course, it depends on HUGE_MAX_HSTATE.

IIRC only HUGE_MAX_HSTATE goes crazy on that with effectively 15 entries.

15*8 ~128 bytes.

So with 1024 nodes we would be allocating 128 KiB.


And given that this is for each cgroup (right?) I assume it can add up.

> 
> Proposed Change:
>      Introduce a memory hotplug notifier that listens for MEM_ONLINE
>      events. When a node becomes online, we call the same allocation function
>      but insted of for_each_node(),using for_each_online_node(). This means
>      memory is only allocated for nodes which are online, thus reducing waste.

We have a NODE_ADDING_FIRST_MEMORY now, I'd assume that is more suitable?

> 
> Feedback Requested:
>      - Where in the codebase (which file or section) is it most appropriate to
>        implement and register the memory hotplug notifier for this subsystem?

I'd assume you would have to register in hugetlb_cgroup_css_alloc() and
free in hugetlb_cgroup_css_free().

>      - Are there best practices or patterns for handling the notifier lifecycle,
>        especially for unregistering during cgroup or subsystem teardown?

Not that I can think of some :)

>      - What are the standard methods or tools to test memory hotplug scenarios
>        for cgroups? Are there ways to reliably trigger node online/offline events
>        in a development environment?

You can use QEMU to hotplug memory (pc-dimm device) to a CPU+memory-less node and
to then remove it again. If you disable automatic memory onlining, you should be able to
trigger this multiple times without any issues.

>      - Are there existing test cases or utilities in the kernel tree that would help
>        to verify correct behavior of this change?

Don't think so.

>      - Any suggestions for implementation improvements or cleaner API usage?

I'd assume you'd want to look into NODE_ADDING_FIRST_MEMORY.

-- 
Cheers

David

