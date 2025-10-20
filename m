Return-Path: <linux-kernel+bounces-861227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD68BF21E0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC3E18A3854
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A6126C3BD;
	Mon, 20 Oct 2025 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXiJrIJ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B86F26B955
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974190; cv=none; b=F/WCRb7eJ6Xb7WgckrdCU24gjPRiY8oRdRz6VvHC68Ple0NlU5oD5lDeSalexHtqBQCSr/o9Iy+RaS4EFcJu5NhaLN1pCFoA0y1rmTDHtvPupD1zpXCKy5H2rrik+itPPF8c2OJdfEtCqJt86z03Mxj3KHXm4eT0crqPjqwj6GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974190; c=relaxed/simple;
	bh=O1orugBr2pvTT4K3ZaPXwEVdYUClnxbj+YqzNevsSfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aOHiE8E3lZlXI0ryz2l7p++twNjbGqBGjbqFTL24pzrXoam2i2atCj2dH0ebNyuQ4zN9JyN6rYWTPhymdBYjpw2tLPjbPtziat4J8gY6T/YXtNXr1gygnw9uLNrcs2BkzRW6STrwxmN7yPbiSCDVBZ1QUx6AKoqcSTZYB1dd8R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXiJrIJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D2BC4CEF9;
	Mon, 20 Oct 2025 15:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760974189;
	bh=O1orugBr2pvTT4K3ZaPXwEVdYUClnxbj+YqzNevsSfs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uXiJrIJ687SJ+ZX5Q9oD4LYK5sQUkdBCyvr+bs6NtwlmsufLYur10NjjA0u5WTGnm
	 JRmI2YhfP4weHJj8V5eSziLaUAUrt7B5YAVrqZyN+PdEDso6q/fNmLpcA3aux5cj8Y
	 Yk9PpxF/uV91kzuWgAU2Tir+58s4qs+jJtHrYpYULtU5lGBaWp2fNWq4wkUH0fkZ1J
	 c8i/yjnj8QJ5tGDRgXbs4gd1hcUg3sL2NJLjzdbgbW1UJ3Dj616krygQMks7XZFvaD
	 +pSHufqszj8KlVb4M+mdQ5Q0yYyA4R8RSGEhsuAZt3bAtITJC8UhwAtrw4LJtxwzRD
	 v+BiJRk4g+3Ig==
Message-ID: <33f2a0f7-3e15-4256-a631-70e68fdec15d@kernel.org>
Date: Mon, 20 Oct 2025 09:29:49 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmalloc: Use kmalloc_array() instead of kmalloc()
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>,
 akpm@linux-foundation.org, urezki@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251018201207.27441-1-mehdi.benhadjkhelifa@gmail.com>
Content-Language: en-US
From: Khalid Aziz <khalid@kernel.org>
In-Reply-To: <20251018201207.27441-1-mehdi.benhadjkhelifa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/18/25 2:11 PM, Mehdi Ben Hadj Khelifa wrote:
> The number of NUMA nodes (nr_node_ids) is bounded, so overflow is not a
> practical concern here. However, using kmalloc_array() better reflects the
> intent to allocate an array of unsigned ints, and improves consistency with
> other NUMA-related allocations.
> 
> No functional change intended.
> 
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> ---
>   mm/vmalloc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 798b2ed21e46..697bc171b013 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -5055,7 +5055,7 @@ static int vmalloc_info_show(struct seq_file *m, void *p)
>   	unsigned int *counters;
>   
>   	if (IS_ENABLED(CONFIG_NUMA))
> -		counters = kmalloc(nr_node_ids * sizeof(unsigned int), GFP_KERNEL);
> +		counters = kmalloc_array(nr_node_ids, sizeof(unsigned int), GFP_KERNEL);
>   
>   	for_each_vmap_node(vn) {
>   		spin_lock(&vn->busy.lock);

This looks like reasonable change for clarity.

Reviewed-by: Khalid Aziz <khalid@kernel.org>

--
Khalid

