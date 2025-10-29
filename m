Return-Path: <linux-kernel+bounces-876240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 934EEC1B062
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E52C56955F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F418429ACF6;
	Wed, 29 Oct 2025 13:37:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BCC34CFCC
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745067; cv=none; b=S2FQavo0dwxB4KzCwuqaHF+3Y50k/dR9iCuR3D6Av1rJMW8cp7Ku8QL5MCaHPSr6BKDmdrN+HsnTtLFphjyEFfhEgScuz1IDlRZ5Qr0ibTC23/pgBKKpswqTHN7zLDaY1d1U3uRwB7+d8Xh6VOYEZtAlFna9vUwAfYwVjOKsBIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745067; c=relaxed/simple;
	bh=9tEtg7V2R9H8ulxWUVSwC12mguB/Jt7HY/pT9QTcixk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pr9gJjfte5IJEkPXI56bQiwrcIHHjHqp8S/HK0h1den+hzRBIYXc2jhnQVK86mP4xRt0sS38WiuUuncALjfKG7lCwZzSgVpLcFQEHwCzwkt21FU82WiML+EgGsNobYdSV4rlGmh1nVUCZtEjIRehNmPxev6Onb8eIGqHZ3dS0GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4855B1C2B;
	Wed, 29 Oct 2025 06:37:37 -0700 (PDT)
Received: from [10.57.39.117] (unknown [10.57.39.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD60F3F673;
	Wed, 29 Oct 2025 06:37:43 -0700 (PDT)
Message-ID: <4ece27d2-0948-4d28-84b8-063bddc3e38f@arm.com>
Date: Wed, 29 Oct 2025 13:37:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_ext: Fix use of uninitialized variable in
 scx_bpf_cpuperf_set()
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251029130843.2977395-1-arighi@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20251029130843.2977395-1-arighi@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/25 13:08, Andrea Righi wrote:
> scx_bpf_cpuperf_set() has a typo where it dereferences the local
> variable @sch, instead of the global @scx_root pointer. Fix by
> dereferencing the correct variable.
> 
> Fixes: 956f2b11a8a4f ("sched_ext: Drop kf_cpu_valid()")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index ecb251e883eab..1a019a7728fb2 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -6401,7 +6401,7 @@ __bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf)
>  
>  	guard(rcu)();
>  
> -	sch = rcu_dereference(sch);
> +	sch = rcu_dereference(scx_root);
>  	if (unlikely(!sch))
>  		return;
>  

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

