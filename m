Return-Path: <linux-kernel+bounces-768711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C17B9B2646D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E55377B93D7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2B22F2913;
	Thu, 14 Aug 2025 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dVlUAFmH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998D62BE020
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171463; cv=none; b=dZ0+rhfGG8x0rZUCasGRfomEFCh2E8WwwfF/HDVzwpYva0wVMST3cfDnHirdFOazIewGCvMFMtmAjvcdG608cOeYFEv2Y0TmFanVboYiZr78tHUG2VehcYxtzLcjAqypxqLqqNOvYlXnXtNdIsmP4i+8GnNXW/lx5wS/m05wGgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171463; c=relaxed/simple;
	bh=MvGkXuSZizdSAeen5J/IQpL/vIRSBfXfiCCe/dOr7jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjJpi8RGrqmenwu45sQ/9EQSfct0iWcT+3kZsXGxdLTHKPenxHHOkNTIC6qM9tugWMFv5ebRjVv8t5UX8eDj9oSg5kC1BEFZNQzlxUFDItEP1PczH3apcGVrS9kZP1TooB1MYAOvb3mPVaeYLEDsglOEG8OafQnueK9UjztM6MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dVlUAFmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D36C4CEED;
	Thu, 14 Aug 2025 11:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755171462;
	bh=MvGkXuSZizdSAeen5J/IQpL/vIRSBfXfiCCe/dOr7jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVlUAFmHJhJJMvEtb2lyovQ4H4POdKk14L0+sUSAiOoS8Q/oFtEM6GZXU2ahfcsc8
	 ICDhqRxfDxQtdFNBzGbknOlrsiVe0iLUTC81KcRUxlpqFruiXvHCET/Far0w57Yqeo
	 sSZi4nvPz48BMx/sKRPkobl+cQJNqpzAsMW3Fi84=
Date: Thu, 14 Aug 2025 13:37:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wang Wensheng <wangwensheng4@huawei.com>
Cc: rafael@kernel.org, dakr@kernel.org, tglx@linutronix.de,
	saravanak@google.com, robh@kernel.org, broonie@kernel.org,
	linux-kernel@vger.kernel.org, chenjun102@huawei.com
Subject: Re: [PATCH 1/3] driver core: Fix concurrent problem of
 deferred_probe_extend_timeout()
Message-ID: <2025081431-puzzling-mumble-9570@gregkh>
References: <20250814111023.2693-1-wangwensheng4@huawei.com>
 <20250814111023.2693-2-wangwensheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814111023.2693-2-wangwensheng4@huawei.com>

On Thu, Aug 14, 2025 at 07:10:21PM +0800, Wang Wensheng wrote:
> The deferred_probe_timeout_work may be canceled forever unexpected when
> deferred_probe_extend_timeout() executes concurrently. Start with
> deferred_probe_timeout_work pending, and the problem would
> occur after the following sequence.
> 
>          CPU0                                 CPU1
> deferred_probe_extend_timeout
>   -> cancel_delayed_work => true
>                                      deferred_probe_extend_timeout
>                                        -> cancel_delayed_wrok
>                                          -> __cancel_work
>                                            -> try_grab_pending
>   -> schedule_delayed_work
>    -> queue_delayed_work_on
> since pending bit is grabbed,
> just return without doing anything
>                                         -> set_work_pool_and_clear_pending
>                                      this __cancel_work return false and
>                                      the work would never be queued again
> 
> The root cause is that the PENDING_BIT of the work_struct would be set
> temporaily in __cancel_work and this bit could prevent the work_struct
> to be queued in another CPU.
> 
> Use deferred_probe_mutex to protect the cancel and queue operations for
> the deferred_probe_timeout_work to fix this problem.
> 
> Fixes: 2b28a1a84a0e ("driver core: Extend deferred probe timeout on driver registration")
> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
> ---
>  drivers/base/dd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 13ab98e033ea..1983919917e0 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -323,6 +323,7 @@ static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_
>  
>  void deferred_probe_extend_timeout(void)
>  {
> +	mutex_lock(&deferred_probe_mutex);
>  	/*
>  	 * If the work hasn't been queued yet or if the work expired, don't
>  	 * start a new one.
> @@ -333,6 +334,7 @@ void deferred_probe_extend_timeout(void)
>  		pr_debug("Extended deferred probe timeout by %d secs\n",
>  					driver_deferred_probe_timeout);
>  	}
> +	mutex_unlock(&deferred_probe_mutex);
>  }
>  
>  /**
> -- 
> 2.22.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

