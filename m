Return-Path: <linux-kernel+bounces-775501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4209AB2BFEA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1817720317
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66338322DDD;
	Tue, 19 Aug 2025 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZA5cP7MB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D20221F1A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601731; cv=none; b=qoG5WsPonhPWhhtPTNEdUhRLC+J3Ph+/XhWdC2X2ZYYNjEBmaIM1oD4lIVYM/sVAOB+vY+aorkRXm8mxHrr1r7lUJHdqcsM0Q5/J3aKGNkgqAzbOmQ+HLrto2k2lRvDldjew2aG71BuWdCtinTKoo/MpHXazo/HQvdcRNiERi4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601731; c=relaxed/simple;
	bh=5MPceD/isGCQ9ISw+xEdMKVBBYGiXC6Tj/RZnCLbHl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4Lgg9D+ysTj+2kgnncT1KHGI5LllTC1YAqczHlVoqYOhIYDQQn56/gQ1Q3kXrZCmdOt1vI+Ukc68tbx4NKqdyYX0DZoyglviAMGCYSgCPFwC3PrP7FLg7grySGrgtdt53xUvaM0ZcKjSdLW+GmZvW6RH9pp9OnzPhiH3umFGCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZA5cP7MB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F72C4CEF1;
	Tue, 19 Aug 2025 11:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755601731;
	bh=5MPceD/isGCQ9ISw+xEdMKVBBYGiXC6Tj/RZnCLbHl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZA5cP7MBOSuzmjM//kCxQYK1XpWTytJqHNbGKwPUNyKyuWDcasdzQNGZx/fY1PIzS
	 NpOYciqyrRFnQJOfCmNx5UVpMa9UmeTcnPm9v914jLpuetk2v3AcAUaP90jw4mdzPe
	 YzxXu7hJtvczOyrEN13MZpqniXPu8JdOpjNQPKRE=
Date: Tue, 19 Aug 2025 13:08:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: linux-kernel@vger.kernel.org, Mahesh Rao <mahesh.rao@altera.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH 3/5] firmware: stratix10-svc: Add initial support for
 asynchronous communication with Stratix10 service channel
Message-ID: <2025081904-swapping-waving-aa5b@gregkh>
References: <20250722163045.168186-1-dinguyen@kernel.org>
 <20250722163045.168186-3-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722163045.168186-3-dinguyen@kernel.org>

On Tue, Jul 22, 2025 at 11:30:43AM -0500, Dinh Nguyen wrote:
> From: Mahesh Rao <mahesh.rao@altera.com>
> 
> Introduce support for asynchronous communication
> with the Stratix10 service channel. Define new
> structures to enable asynchronous messaging with
> the Secure Device Manager (SDM). Add and remove
> asynchronous support for existing channels.
> Implement initialization and cleanup routines for
> the asynchronous framework. Enable sending and
> polling of messages to the SDM asynchronously.
> 
> The new public functions added are:
> - stratix10_svc_add_async_client: Adds an client
>         to the service channel.
> - stratix10_svc_remove_async_client: Removes an
>         asynchronous client from the service
>         channel.
> - stratix10_svc_async_send: Sends an asynchronous
>         message to the SDM mailbox in EL3 secure
>         firmware.
> - stratix10_svc_async_poll: Polls the status of an
>         asynchronous service request in EL3 secure
>         firmware.
> - stratix10_svc_async_done: Marks an asynchronous
>         transaction as complete and free's up the
>         resources.
> 
> These changes enhance the functionality of the
> Stratix10 service channel by allowing for more
> efficient and flexible communication with the
> firmware.
> 
> Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  drivers/firmware/stratix10-svc.c              | 657 +++++++++++++++++-
>  include/linux/firmware/intel/stratix10-smc.h  |  24 +
>  .../firmware/intel/stratix10-svc-client.h     |  88 +++
>  3 files changed, 765 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index a8c57963da99..4480ba8b2e11 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -4,9 +4,11 @@
>   * Copyright (C) 2025, Altera Corporation
>   */
>  
> +#include <linux/atomic.h>
>  #include <linux/completion.h>
>  #include <linux/delay.h>
>  #include <linux/genalloc.h>
> +#include <linux/hashtable.h>
>  #include <linux/io.h>
>  #include <linux/kfifo.h>
>  #include <linux/kthread.h>
> @@ -44,6 +46,47 @@
>  #define STRATIX10_RSU				"stratix10-rsu"
>  #define INTEL_FCS				"intel-fcs"
>  
> +/*Maximum number of SDM client IDs.*/
> +#define MAX_SDM_CLIENT_IDS 16
> +/*Client ID for SIP Service Version 1.*/
> +#define SIP_SVC_V1_CLIENT_ID 0x1
> +/*Maximum number of SDM job IDs.*/
> +#define MAX_SDM_JOB_IDS 16
> +/*Number of bits used for asynchronous transaction hashing.*/
> +#define ASYNC_TRX_HASH_BITS 3

Tabs for defines to make them more readable?

And use spaces in your comments please.


> +/* Total number of transaction IDs, which is a combination of
> + * client ID and job ID.
> + */

Wrong comment style.

I stopped reading here :(

thanks,

greg k-h

