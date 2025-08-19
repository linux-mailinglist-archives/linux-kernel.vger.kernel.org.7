Return-Path: <linux-kernel+bounces-775493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 932FEB2BFD2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1A118934A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA355322C86;
	Tue, 19 Aug 2025 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EZPyDhcj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D9B311941
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601590; cv=none; b=t0OzvCJSq6LCiskbWmaHK4jY5ZIxqCNzgw31XQK1k2BJCh2Qqm7HSOA2syiCicOTzCWIzILzxVSw76FnYbhfEbVK/NLg4tC4+t284QXnLXSGT+pPb4AzOLNJsU+TZFgWdPsDwpYJzD6MZ1Fq4ZFeW3Gh5IwYuhxLXohrFuaqwpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601590; c=relaxed/simple;
	bh=qFv9FNyBKVIrJtLfPWt5W1iZl6uk6V4yO6O+Wf65SPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpzPJF/3h+npzFS/9dmJCd7XBEs+H7rXqvfUOvBhisCGsxcYDRFm2GRbXZdTvxWSGC58StlnL9M05j6qqBiD8PpefC9NedROABSVZ3B0ykt7e2ASz/MaFYnHUf3o8ou0oiRM3d5iiA6IHuEMHHPMCmEhGM+1scMOwqdY08C7rjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EZPyDhcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EE2C113D0;
	Tue, 19 Aug 2025 11:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755601589;
	bh=qFv9FNyBKVIrJtLfPWt5W1iZl6uk6V4yO6O+Wf65SPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZPyDhcjERooqM7BKtsnaRpzVAjG7uqW6FBt0YXu+2Y4Ovl6Mg4UU8STkGyOpZ17V
	 ZAtaH0+jRIR9J82NPr1XOODRISeoBy0WeZrOhPneddrsV2H5eur3FRPJc2DFtTzpD2
	 Z7mcFeAvEF/TpfkzjM5SG5prkalh9EpQgrNICdSE=
Date: Tue, 19 Aug 2025 13:06:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: linux-kernel@vger.kernel.org, Mahesh Rao <mahesh.rao@altera.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH 1/5] firmware: stratix10-svc: Add mutex lock and unlock
 in stratix10 memory allocation/free
Message-ID: <2025081920-greyhound-discuss-79b2@gregkh>
References: <20250722163045.168186-1-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722163045.168186-1-dinguyen@kernel.org>

On Tue, Jul 22, 2025 at 11:30:41AM -0500, Dinh Nguyen wrote:
> From: Mahesh Rao <mahesh.rao@altera.com>
> 
> This commit adds a mutex lock to protect the
> stratix10_svc_allocate_memory and
> stratix10_svc_free_memory functions to ensure
> thread safety when allocating and freeing memory.
> This prevents potential race conditions and ensures
> synchronization.

You have 72 columns to write a changelog in, please use it :)

And is this fixing a bug?  If so, shouldn't this be tagged for stable
and add a Fixes: tag?

If this isn't a bug, then why is it needed?  How can these race?

> 
> Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  drivers/firmware/stratix10-svc.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index e3f990d888d7..73c77b8e9f2b 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2017-2018, Intel Corporation
> + * Copyright (C) 2025, Altera Corporation
>   */
>  
>  #include <linux/completion.h>
> @@ -171,6 +172,10 @@ struct stratix10_svc_chan {
>  
>  static LIST_HEAD(svc_ctrl);
>  static LIST_HEAD(svc_data_mem);
> +/* svc_mem_lock protects access to the svc_data_mem list for
> + * concurrent multi-client operations
> + */

Odd coding style, this isn't the network subsystem :(

And what about a lock for svc_ctrl?

> +static DEFINE_MUTEX(svc_mem_lock);
>  
>  /**
>   * svc_pa_to_va() - translate physical address to virtual address
> @@ -182,14 +187,18 @@ static LIST_HEAD(svc_data_mem);
>  static void *svc_pa_to_va(unsigned long addr)
>  {
>  	struct stratix10_svc_data_mem *pmem;
> +	void *ret = NULL;
>  
>  	pr_debug("claim back P-addr=0x%016x\n", (unsigned int)addr);
> +	mutex_lock(&svc_mem_lock);

Why not just use the guard() functionality instead?  Makes for much
simpler code and a smaller patch.  Please do so for all of these.

thanks,

greg k-h

