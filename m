Return-Path: <linux-kernel+bounces-740204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB983B0D159
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E198E7AB8C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C36028AAEB;
	Tue, 22 Jul 2025 05:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j7QpvljM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADF728C877
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753163111; cv=none; b=DYH6sVjAJ34/nqlwiYs1smw1aMD5KGjqqaU/yAsd2TTQzPHfblY5nZNwElrn0VTEBx7zpB+Cfpf4yQnv0be3ykLvKtr7Dlg29DQ9SqS15p9MeNlt4oT/nvwIQaIWMvsZIT+L25Pn2mWUjxvv4SqqDWDyOtyCDNI21ieob0J+DjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753163111; c=relaxed/simple;
	bh=wiq/us2Oz59OggVrNFpR/QNSFuLKVRucyRykzTBbm7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaasEl47XGXImo+upL9sD0dhEkQLzH/sN2aZEqLRq3NpC2RUn5rn0yP5xqW41vdKJ3+CRhXJsnsmmPWXK3Eh0tbw9RMWrED5QB1qeP/nsneZ37D8zOacAkcDA3vmvqcesOFZBuZsQGpGZzZdlYQMXL22EqqVKGMhDqVakHNmwCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j7QpvljM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CF5C4CEEB;
	Tue, 22 Jul 2025 05:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753163110;
	bh=wiq/us2Oz59OggVrNFpR/QNSFuLKVRucyRykzTBbm7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7QpvljMWzREorHJEufvkKjUIRJagDzBdKRXdhtiDb+UTPFl4XzaaIk6Q6+oDlB+4
	 0MZF6jAXSiwiXNtC62WF4Hm2F7EaMqaLPS9EvgTcPbBYeSXwUXeS7yoKKTx2bOIFWl
	 MupM4JXD+aObBhoysyA21cx7DtTKv0Ki1N1v5umc=
Date: Tue, 22 Jul 2025 07:45:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jia He <justin.he@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: percpu: Introduce normalized CPU-to-NUMA node
 mapping to  reduce max_distance
Message-ID: <2025072202-june-cable-d658@gregkh>
References: <20250722041418.2024870-1-justin.he@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722041418.2024870-1-justin.he@arm.com>

On Tue, Jul 22, 2025 at 04:14:18AM +0000, Jia He wrote:
> pcpu_embed_first_chunk() allocates the first percpu chunk via
> pcpu_fc_alloc() and used as-is without being mapped into vmalloc area. On
> NUMA systems, this can lead to a sparse CPU->unit mapping, resulting in a
> large physical address span (max_distance) and excessive vmalloc space
> requirements.

Why is the subject line "mm: percpu:" when this is driver-core code?

And if it is mm code, please cc: the mm maintainers and list please.

> For example, on an arm64 N2 server with 256 CPUs, the memory layout
> includes:
> [    0.000000] NUMA: NODE_DATA [mem 0x100fffff0b00-0x100fffffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x500fffff0b00-0x500fffffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x600fffff0b00-0x600fffffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x700ffffbcb00-0x700ffffcbfff]
> 
> With the following NUMA distance matrix:
> node distances:
> node   0   1   2   3
>   0:  10  16  22  22
>   1:  16  10  22  22
>   2:  22  22  10  16
>   3:  22  22  16  10
> 
> In this configuration, pcpu_embed_first_chunk() computes a large
> max_distance:
> percpu: max_distance=0x5fffbfac0000 too large for vmalloc space 0x7bff70000000
> 
> As a result, the allocator falls back to pcpu_page_first_chunk(), which
> uses page-by-page allocation with nr_groups = 1, leading to degraded
> performance.

But that's intentional, you don't want to go across the nodes, right?

> This patch introduces a normalized CPU-to-NUMA node mapping to mitigate
> the issue. Distances of 10 and 16 are treated as local (LOCAL_DISTANCE),

Why?  What is this going to now break on those systems that assumed that
those were NOT local?

> allowing CPUs from nearby nodes to be grouped together. Consequently,
> nr_groups will be 2 and pcpu_fc_alloc() uses the normalized node ID to
> allocate memory from a common node.
> 
> For example:
> - cpu0 belongs to node 0
> - cpu64 belongs to node 1
> Both CPUs are considered local and will allocate memory from node 0.
> This normalization reduces max_distance:
> percpu: max_distance=0x500000380000, ~64% of vmalloc space 0x7bff70000000
> 
> In addition, add a flag _need_norm_ to indicate the normalization is needed
> iff when cpu_to_norm_node_map[] is different from cpu_to_node_map[].
> 
> Signed-off-by: Jia He <justin.he@arm.com>

I think this needs a lot of testing and verification and acks from
maintainers of other arches that can say "this also works for us" before
we can take it, as it has the potential to make major changes to
systems.

What did you test this on?


> ---
>  drivers/base/arch_numa.c | 47 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> index c99f2ab105e5..f746d88239e9 100644
> --- a/drivers/base/arch_numa.c
> +++ b/drivers/base/arch_numa.c
> @@ -17,6 +17,8 @@
>  #include <asm/sections.h>
>  
>  static int cpu_to_node_map[NR_CPUS] = { [0 ... NR_CPUS-1] = NUMA_NO_NODE };
> +static int cpu_to_norm_node_map[NR_CPUS] = { [0 ... NR_CPUS-1] = NUMA_NO_NODE };
> +static bool need_norm;

Shouldn't these be marked __initdata as you don't touch them afterward?

thanks,

greg k-h

