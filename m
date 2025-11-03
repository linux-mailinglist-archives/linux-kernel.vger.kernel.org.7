Return-Path: <linux-kernel+bounces-882211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6876BC29E40
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 03:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E57F6347CDC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 02:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A098285CAA;
	Mon,  3 Nov 2025 02:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPk3UNVH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A8419F12D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 02:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762138510; cv=none; b=KjgnidICpvyve0/kaRaDcXbjbnKOZt6Z9v/ZsvritS7jd86rPecSXEQ+SGGGqwm87qlj3KUhQDT/r4JNvGsoRpmND1SrWB4tTvhmj4p+fQl5rbrfmx3zutiPHBRwXwQxpNF/8TxxydyvdOHCIM69kaLh65bWFc0ZqBaqJe9eEL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762138510; c=relaxed/simple;
	bh=et1AqohLz1luWH0lrOFvOQWO5UQJy0xpj3yiKHMnycA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqlWpyhqBDqIUo8LbDf0eOXUZFM11+9MPW+gqDqpp6cCj+ExmGAj7SBjkUqn3oRnPqe4XqGlx1tBak8uHdayvwVIhvpeg2JNd/1PkTvumOUljQw8zGDF+QiiTG1Peodll7XFFgIi/P66AdM1PLXFMjuMOCYjOzk4VX5o0QKbh9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPk3UNVH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762138505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X2q0M43HiImC77msPAox01Eekne3kZwBQne5m3Gl0v0=;
	b=SPk3UNVHmBLkCBW4d7jyFjmJB+2iH1KQL+LRKGRftxLaMCkTP3rksx0fEjxONIAVkFeU8g
	UF0RlEbCZd+FiCm4y9uYd12Lxs7RRGE82Z26OMiyiES7NcxyE4u54Ogj881ZPi8b/X0jDE
	6wHI7yt1dJ5pUarpauhkDXxfddJrdCE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-ESv9nNmDPxqM20Jo0oTHrQ-1; Sun,
 02 Nov 2025 21:54:59 -0500
X-MC-Unique: ESv9nNmDPxqM20Jo0oTHrQ-1
X-Mimecast-MFC-AGG-ID: ESv9nNmDPxqM20Jo0oTHrQ_1762138498
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E962195606C;
	Mon,  3 Nov 2025 02:54:56 +0000 (UTC)
Received: from localhost (unknown [10.72.112.98])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8DDC30001A1;
	Mon,  3 Nov 2025 02:54:54 +0000 (UTC)
Date: Mon, 3 Nov 2025 10:54:50 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Zhen Lei <thunder.leizhen@huawei.com>, kexec@lists.infradead.org
Subject: Re: [PATCH] crash: fix crashkernel resource shrink
Message-ID: <aQgZekkvdC6Ekq8V@MiWiFi-R3L-srv>
References: <20251101193741.289252-1-sourabhjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101193741.289252-1-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/02/25 at 01:07am, Sourabh Jain wrote:
> When crashkernel is configured with a high reservation, shrinking its
> value below the low crashkernel reservation causes two issues:
> 
> 1. Invalid crashkernel resource objects
> 2. Kernel crash if crashkernel shrinking is done twice
> 
> For example, with crashkernel=200M,high, the kernel reserves 200MB of
> high memory and some default low memory (say 256MB). The reservation
> appears as:
> 
> cat /proc/iomem | grep -i crash
> af000000-beffffff : Crash kernel
> 433000000-43f7fffff : Crash kernel
> 
> If crashkernel is then shrunk to 50MB (echo 52428800 >
> /sys/kernel/kexec_crash_size), /proc/iomem still shows 256MB reserved:
> af000000-beffffff : Crash kernel
> 
> Instead, it should show 50MB:
> af000000-b21fffff : Crash kernel
> 
> Further shrinking crashkernel to 40MB causes a kernel crash with the
> following trace (x86):
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000038
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> <snip...>
> Call Trace: <TASK>
> ? __die_body.cold+0x19/0x27
> ? page_fault_oops+0x15a/0x2f0
> ? search_module_extables+0x19/0x60
> ? search_bpf_extables+0x5f/0x80
> ? exc_page_fault+0x7e/0x180
> ? asm_exc_page_fault+0x26/0x30
> ? __release_resource+0xd/0xb0
> release_resource+0x26/0x40
> __crash_shrink_memory+0xe5/0x110
> crash_shrink_memory+0x12a/0x190
> kexec_crash_size_store+0x41/0x80
> kernfs_fop_write_iter+0x141/0x1f0
> vfs_write+0x294/0x460
> ksys_write+0x6d/0xf0
> <snip...>
> 
> This happens because __crash_shrink_memory()/kernel/crash_core.c
> incorrectly updates the crashk_res resource object even when
> crashk_low_res should be updated.
> 
> Fix this by ensuring the correct crashkernel resource object is updated
> when shrinking crashkernel memory.
> 
> Fixes: 16c6006af4d4 ("kexec: enable kexec_crash_size to support two crash kernel regions")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: kexec@lists.infradead.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  kernel/crash_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 3b1c43382eec..99dac1aa972a 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -373,7 +373,7 @@ static int __crash_shrink_memory(struct resource *old_res,
>  		old_res->start = 0;
>  		old_res->end   = 0;
>  	} else {
> -		crashk_res.end = ram_res->start - 1;
> +		old_res->end = ram_res->start - 1;

It's a code bug, nice catch, thanks.

Acked-by: Baoquan He <bhe@redhat.com>


