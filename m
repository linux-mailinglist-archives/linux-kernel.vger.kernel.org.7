Return-Path: <linux-kernel+bounces-799029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90CCB42608
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63ACB3B9A55
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1148F296BC2;
	Wed,  3 Sep 2025 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNKpr1OS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A916291C3F;
	Wed,  3 Sep 2025 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915006; cv=none; b=BnXmWcpw1kJupPjjnaacnwmUs5XxXmHaXkZsJ69sZ8x2QCXiIl3MjWC0WbHCsdIJqNEVF8bRdzKESoOsl2krcNXcHFxbLluO5UamMdOKvxYvOz7gFsoDc0m1nJcw+2HerPBoCU0vxmx2JoO6vYfIPfNDBvT5tAl5q0PfsRjfTn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915006; c=relaxed/simple;
	bh=1uUf8zFT8Dpvr4KiqlYIOeNPCqKHRzNjH8DWD2yyoo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckCAzMtE0oV4hSlKXbGsEe0KJLYNZ4rQlBF1aLPh+PfMBjSX6mz5Ax1w6kdDUWueLcpw3LC1wD41gDdipJya3b+9+ClgrADiNExhxdwk0e8agZjco3/I7AOzpjcWqWax3H1o3ZPBuq22OoBEX1zNCQA+XaE9tBzDWYE+gyqnksc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNKpr1OS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA8FC4CEE7;
	Wed,  3 Sep 2025 15:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756915005;
	bh=1uUf8zFT8Dpvr4KiqlYIOeNPCqKHRzNjH8DWD2yyoo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vNKpr1OSe/AWh1p6mz7/YMzTcgbDFC7YSEoZ6bJhffZ8/c661uMORFLF72HBfTQU/
	 Ca3+H9t6A17dYSD2Ub3V0XIbMv+WySIMfnMecrzzTGWjXCshA77gr1cVUL4wuW0ntx
	 B/X8pl0BnNX5shnMLgLFNFehmPi6tiWFmSi96qXcremiLiAZcBJjqZlBhHwOhh6fJ1
	 ROExf4XMv8M7Yb+lodgP4FmNGehYYYoElUtLwkNTHSiHB3Vu3SjN8sS14xZY2ILY6I
	 96k4b5y9ugklo9fZZ+riSodu8YVF65fwY4V7IgljqYQo+qLdWnw3wYrDL6903wrCFD
	 EziQ46sxVzl5A==
Date: Wed, 3 Sep 2025 05:56:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: arighi@nvidia.com, void@manifault.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
	mingo@redhat.com, peterz@infradead.org, jake@hillion.co.uk
Subject: Re: [PATCH v5 3/3] sched_ext: deprecation warn for scx_bpf_cpu_rq()
Message-ID: <aLhlPaa_lLFPnX2A@slm.duckdns.org>
References: <20250901132605.2282650-1-christian.loehle@arm.com>
 <20250901132605.2282650-5-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901132605.2282650-5-christian.loehle@arm.com>

On Mon, Sep 01, 2025 at 02:26:04PM +0100, Christian Loehle wrote:
> scx_bpf_cpu_rq() works on an unlocked rq which generally isn't safe.
> For the common use-cases scx_bpf_cpu_rq_locked() and
> scx_bpf_remote_curr() work, so add a deprecation warning
> to scx_bpf_cpu_rq() so it can eventually be removed.
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  kernel/sched/ext.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index e242a2520f06..a524d404ad09 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -7427,6 +7427,9 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
>  	if (!kf_cpu_valid(cpu, NULL))
>  		return NULL;
>  
> +	pr_warn_once("%s() is deprecated; use scx_bpf_cpu_rq_locked() when holding rq lock "
> +		     "or scx_bpf_remote_curr() to read remote curr safely.\n", __func__);
> +

I wonder whether it'd make more sense to tie the once testing to the
scheduler instance (see warned_zero_slice).

Thanks.

-- 
tejun

