Return-Path: <linux-kernel+bounces-897311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1955C52920
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B5B64F07AB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BD2222587;
	Wed, 12 Nov 2025 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EAjUey3P"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFBF1C84B8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955150; cv=none; b=Ly2wsk3XUCXK2gpaETLChno2BQO8//w23V/eSpF9KCmeuoSTgYYyB6VfjWM3laW6MxCakTE9FnYXeHI+7S71OS1PIMmSfO6Zquj4Z92b9H/hSDXNT+LgwT2plXtdIqDHm32ULhzVnC9DdxbKgofMjgYnnu6pglT7cJuZfL7nLAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955150; c=relaxed/simple;
	bh=YIPTfa64HZLcY6wKz8x+9uvpiF5j652harAzo4fAsKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NzUnXLLOLahp6iML3rxYEakTJ4XJvtFo5d4oaaipZxnpgC5g5eF6TtaDl5XM/bECwvuZx8snSP2LvLbzoxeogqYsYqFsEw8HlUSsdbgfkC/+b7Zq7vdU1bngPsIEafhs7p32lUERMgz2rpqOUW+PqVt/AzugeN2vPfolRIbLAoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EAjUey3P; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7ae9b0c0-c84a-4c2c-b2ee-9252e9c411b0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762955135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ajkdIEmvDvs8JJigmuXriUJQWZc8PJATNFsgVzxh4rs=;
	b=EAjUey3Pst31XxcF40fuB8DykkBskhYr8sugnBcq/MXK0PxyPYDLygMtEDNkZzlCjmiwFw
	ButNwR43KkJI4SQ7PjAkJpJWR+1XCKS2nWB9gYFW7k5PoigY7APrV5HqC6EhkPONV2ONLB
	QYRi4Z2awTw9ITG09dWLMzuyfS7gMok=
Date: Wed, 12 Nov 2025 13:45:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v1 3/7] ptp: ocp: Refactor
 ptp_ocp_i2c_notifier_call()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20251111165232.1198222-1-andriy.shevchenko@linux.intel.com>
 <20251111165232.1198222-4-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251111165232.1198222-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/11/2025 16:52, Andy Shevchenko wrote:
> Refactor ptp_ocp_i2c_notifier_call() to avoid unneeded local variable.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/ptp/ptp_ocp.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 28243fb1d78f..1dbbca4197bc 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -4872,16 +4872,6 @@ ptp_ocp_i2c_notifier_call(struct notifier_block *nb,
>   {
>   	struct device *dev, *child = data;
>   	struct ptp_ocp *bp;
> -	bool add;
> -
> -	switch (action) {
> -	case BUS_NOTIFY_ADD_DEVICE:
> -	case BUS_NOTIFY_DEL_DEVICE:
> -		add = action == BUS_NOTIFY_ADD_DEVICE;
> -		break;
> -	default:
> -		return 0;
> -	}

the reason we've done it is to avoid iterating over devices and do
string comparisons for actions we don't care about. We can still avoid
local variable by changing if condition later in the code, but I'm not
sure this refactor gives any benefits.

>   
>   	if (!i2c_verify_adapter(child))
>   		return 0;
> @@ -4894,10 +4884,17 @@ ptp_ocp_i2c_notifier_call(struct notifier_block *nb,
>   
>   found:
>   	bp = dev_get_drvdata(dev);
> -	if (add)
> +
> +	switch (action) {
> +	case BUS_NOTIFY_ADD_DEVICE:
>   		ptp_ocp_symlink(bp, child, "i2c");
> -	else
> +		break;
> +	case BUS_NOTIFY_DEL_DEVICE:
>   		sysfs_remove_link(&bp->dev.kobj, "i2c");
> +		break;
> +	default:
> +		return 0;
> +	}
>   
>   	return 0;
>   }


