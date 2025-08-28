Return-Path: <linux-kernel+bounces-789822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7481B39B25
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9C23637E4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0596130DD32;
	Thu, 28 Aug 2025 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CnDG0qTn"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB0030DD29
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379522; cv=none; b=I6SEq5+7USEUnkHaaDOdis+uB5c80VwAuFWZAAMXDtSKVDuqrhBbWBQwjW+T9R6mfTwwgj46N1D4//oEb5NrLKEYIXB/SNBfA51FtOdYSX9gCUzvmteM8RR7R/XwxoWVubsvCLuFAUofl7dHyAXeK7VSNfgMmvOd5Ug7sJt2KdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379522; c=relaxed/simple;
	bh=azVT6OyX17mJ1mLSMWuru5qH6So32sdeLByBxjRBfgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GXtNjzJ21pMQQdsDkGTQkn7SI62eTxbTruYNoHVE2WlFFYEF3SB/+4MMU48ckqSXSDRoju32E5s1da+OWskD4lWou17WrPkDhTqBjRqC2Sxs/HFz5lAYGP2V8gXPZlEAuviAs528oo1U8iRa7WMNWapwoia41XzO1QrbmQEV56I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CnDG0qTn; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <25ff983c-8479-4c2e-9afc-2a3befedabb0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756379516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3IXxPSrRxO339QcDyVUwSO1LP7tYTXUUNNhlUINf988=;
	b=CnDG0qTnaRMloKRTbTSYCakSn5XmfRrARG6tNq8n5gwCsObaWhfkxM4SLVB+IDWuwY0iIX
	dgT2ejDDe7wM0F4dyfpODdaz5RC/Cbh5Z4kXMsRYci1rnlyENpSmZM1lZz6EmF4XzX/zDN
	ACQFl2SdexFK5QqpTo6teYPxNUJcJ8I=
Date: Thu, 28 Aug 2025 12:11:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ptp: ocp: fix use-after-free bugs causing by
 ptp_ocp_watchdog
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 jonathan.lemon@gmail.com, richardcochran@gmail.com,
 linux-kernel@vger.kernel.org
References: <20250828082949.28189-1-duoming@zju.edu.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250828082949.28189-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/08/2025 09:29, Duoming Zhou wrote:
> The ptp_ocp_detach() only shuts down the watchdog timer if it is
> pending. However, if the timer handler is already running, the
> timer_delete_sync() is not called. This leads to race conditions
> where the devlink that contains the ptp_ocp is deallocated while
> the timer handler is still accessing it, resulting in use-after-free
> bugs. The following details one of the race scenarios.
> 
> (thread 1)                           | (thread 2)
> ptp_ocp_remove()                     |
>    ptp_ocp_detach()                   | ptp_ocp_watchdog()
>      if (timer_pending(&bp->watchdog))|   bp = timer_container_of()
>        timer_delete_sync()            |
>                                       |
>    devlink_free(devlink) //free       |
>                                       |   bp-> //use
> 
> Resolve this by unconditionally calling timer_delete_sync() to ensure
> the timer is reliably deactivated, preventing any access after free.
> 
> Fixes: 773bda964921 ("ptp: ocp: Expose various resources on the timecard.")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

> ---
>   drivers/ptp/ptp_ocp.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index d39073dc4072..4e1286ce05c9 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -4557,8 +4557,7 @@ ptp_ocp_detach(struct ptp_ocp *bp)
>   	ptp_ocp_debugfs_remove_device(bp);
>   	ptp_ocp_detach_sysfs(bp);
>   	ptp_ocp_attr_group_del(bp);
> -	if (timer_pending(&bp->watchdog))
> -		timer_delete_sync(&bp->watchdog);
> +	timer_delete_sync(&bp->watchdog);
>   	if (bp->ts0)
>   		ptp_ocp_unregister_ext(bp->ts0);
>   	if (bp->ts1)


