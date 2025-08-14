Return-Path: <linux-kernel+bounces-768710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2CCB2646C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3A41C84F2E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79882EE29B;
	Thu, 14 Aug 2025 11:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NZrLUswu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295B82BCF6C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171455; cv=none; b=ZJpgMwLimwaiiNqbdIIrtal3YR6UNROzIcEVyDMnUyhiyfT7CBCEZ3Mhy1i6hSeTmiI+/AGC+h0C/GO5jC7EbP54LmD96atktlknSjmY/SqTYHTmmrHGc9jqgersu8es4nb0rfgXjPheVWGi1XyC6ruqjxft4rmQi24Ye4lUOWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171455; c=relaxed/simple;
	bh=m92ZkHYBwGSR/MWGeeE7TM23PRZOOX3uclgnrUE8vxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBWPAs9tlI+U0S6X0fJWoM1TnWYr58fJHKRxAqKrfKmS4dlxTK9cSTFRaAeB5oOz+uy+xe5jSwsInrWBbccuWYev8U4fxnElQAnZbCqFq9jVupUE7E6x/rkJtbx0ZRY5Ntn2wL8ldTW/xMsseoEghLugSAZSE6cl4tKg9JQDu3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NZrLUswu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19ECFC4CEED;
	Thu, 14 Aug 2025 11:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755171453;
	bh=m92ZkHYBwGSR/MWGeeE7TM23PRZOOX3uclgnrUE8vxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NZrLUswurNZ3RhMLS0zNJ69M/Bmo8dzo3XdiNkD0YpAgqaqdZTt8QOoTaAW13EtWM
	 qOGneKYMg/BNf4zDcsnKmHURHXfxx/wm6QYgqouAD+nxSDCNvl5NNN8/7w+7l5VFLL
	 d2fEgNGRXN3b714NxZWbeBIUH4z8qI6r35HNrNug=
Date: Thu, 14 Aug 2025 13:37:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wang Wensheng <wangwensheng4@huawei.com>
Cc: rafael@kernel.org, dakr@kernel.org, tglx@linutronix.de,
	saravanak@google.com, robh@kernel.org, broonie@kernel.org,
	linux-kernel@vger.kernel.org, chenjun102@huawei.com
Subject: Re: [PATCH 1/3] driver core: Fix concurrent problem of
 deferred_probe_extend_timeout()
Message-ID: <2025081416-reverb-unaired-1de9@gregkh>
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

Perhaps use a guard() instead?

thanks,

greg k-h

