Return-Path: <linux-kernel+bounces-823203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D001B85CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D508B7E378B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A2731158F;
	Thu, 18 Sep 2025 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beoIJ7+O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044130CD90;
	Thu, 18 Sep 2025 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210561; cv=none; b=U3k0KVGmkH/eyp7wJp8E+BsJXTdX2Gl/m0GVU98xE0wPtrS9c0nXCuw/dTnnJ/qpafCDaTNU6RqnraX3i5vqqM0as+oGaM7aN5ud7DFTnn9LJrpr9HIlPgq6DevupI924fVrji/6RcL8wau+Lt5GTFXFYFDnRoqmBAtibuE0bSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210561; c=relaxed/simple;
	bh=f6pQ5rszWvYz9Kr0Qsa7yu+vrTbHKBxJzeBAVPLmT28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyk/CYhX2GvOnux3FizmxQ60JdJCAIyxZvCIId26m5TdbTHEhWpUTdzH0SUYvv2WQc1u2k3kWzg4oK1O+8ShSD7dSWcf9kcahuitvamx6HPdqpM7GRL5IVBO5pH2wM4B2s997LvLrme08B8W6nG3B9c2b8O0Bclf9twxPysqnnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beoIJ7+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CCFC4CEE7;
	Thu, 18 Sep 2025 15:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758210561;
	bh=f6pQ5rszWvYz9Kr0Qsa7yu+vrTbHKBxJzeBAVPLmT28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=beoIJ7+OcO5Q2MUNxSrOo35JEyJcrj4eVZtmEK+JQAJmPaY3UeL3LbQOR36ocp4BL
	 6VzOc2Xw+q/nXR3ZP1+OJwfv+GNxDT0znZhCxITI5ClU7ixC0OkD9Pp4jeAiKFSHQN
	 YvIBBO6p4kFQ3KwRjIkQ8Ix5QstyKfBvy8O5taZzEYfZefOyVXq+olNl+TlhCO3YT7
	 xzGnYfYr+OGnnX+H6vWVirdtCSxjVtDsVUyGU9nl2Yl8exS2rfkP9TkAgaClksUiUY
	 n/1O0Mdu9GZN9vL/68TfR+YK4cOsxfz7xTxBgyBfrL+fWpB0jgmUplahBatGBvE7BE
	 y3JA5bEPkhTkQ==
Date: Thu, 18 Sep 2025 05:49:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.18] sched_ext: Add migration-disabled
 counter to error state dump
Message-ID: <aMwqAP76eVSIIIDn@slm.duckdns.org>
References: <20250918092928.402242-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918092928.402242-1-arighi@nvidia.com>

Hello,

On Thu, Sep 18, 2025 at 11:29:28AM +0200, Andrea Righi wrote:
> Include the task's migration-disabled counter when dumping task state
> during an error exit.
> 
> This can help diagnose cases where tasks can get stuck, because they're
> unable to migrate elsewhere.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 477eccf023388..e03bb51364661 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4167,7 +4167,8 @@ static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
>  		  p->scx.sticky_cpu, p->scx.holding_cpu, dsq_id_buf);
>  	dump_line(s, "      dsq_vtime=%llu slice=%llu weight=%u",
>  		  p->scx.dsq_vtime, p->scx.slice, p->scx.weight);
> -	dump_line(s, "      cpus=%*pb", cpumask_pr_args(p->cpus_ptr));
> +	dump_line(s, "      cpus=%*pb migration_disabled=%u", cpumask_pr_args(p->cpus_ptr),

Can you abbreviate this a bit? We have limited dump buffer size and real
estate. Wouldn't e.g. no_mig= achieve the same with a lot less space?

Thanks.

-- 
tejun

