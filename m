Return-Path: <linux-kernel+bounces-744233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615CDB109E5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9065A5C4A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81802C1586;
	Thu, 24 Jul 2025 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y+zEs39m"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BE224FBFF
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358825; cv=none; b=hfEmxEwkaSUTygoW0gY2pkf9sLBwgOFEFr4rN2bi7qEri14MaoS8r2ddEvS9p7+vZQfgUTdpOMg9INfiPMREWrxWNpkyqlxDO1FBtDkuqpFIxJ8yeNAhYkaeTNH8Lhbkyid5OhOEF3FTJcXW1rk6UFhJNDz0aFJDXyh1sjHF+0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358825; c=relaxed/simple;
	bh=Lm1PUCVP7YrsEOgLlcfttiA2dAxskPHeqhjheTvAtis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULokq9UmicAZkvMzEP5kL+mR9xd9Qebp4HC0qgCS8hswwgGiECapYYoevfyDZc6DShDwC6u/X2ulEwU18iHEKtOnDeD4pEEbfB4U+DSMrd3t/KLNV4FHjOEPP4LpMdq51720+afh+HbdBWCZ/WivEvzfxtDGJ1U2EC3Ffcs6rik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y+zEs39m; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bdd8f5de-acd5-4c09-b3a4-ec6af54b396c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753358820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nY2Ue6HqUfFSMWwiEeojRR9Dn6sZyi4ONs19yYgfpm0=;
	b=Y+zEs39mUTpRn+Gxf/ZSJswL5+3uHTkHVJ1dZsouQSdDlwNbZ18ZKpjSPUORQqe9x6Wl/h
	ciHKJ82UoClLCYj5dZUHU3eZ9V1q+UP6Oxg2aR17YAvJgYOeoBIBkRDxGh5TAHrdq9d6gM
	K4OfnebiGAWFm9WnIQLpyRo+QC/2zZw=
Date: Thu, 24 Jul 2025 20:06:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] hung_task: Add detection count to hung task warning
 message
Content-Language: en-US
To: Ye Liu <ye.liu@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <liuye@kylinos.cn>, linux-kernel@vger.kernel.org
References: <20250724072326.2031432-1-ye.liu@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20250724072326.2031432-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/7/24 15:23, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Add [#N] to hung task warnings to show occurrence count.
> This helps quickly identify warning order when multiple
> messages appear in logs.

Hmm... once we have this number, what do we do with it?

While I totally get the desire for a quick reference number, my thinking
is that the hung_task_detect_count counter is the intended and more
reliable way for users to check.

But like I said before, let's see what Andrew thinks ;)

Thanks,
Lance

> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> 
> Changes in v2:
> - Directly use sysctl_hung_task_detect_count.
> - Link to v1:https://lore.kernel.org/all/20250721031755.1418556-1-ye.liu@linux.dev/
> ---
>   kernel/hung_task.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 8708a1205f82..231afdb68bb2 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -232,8 +232,9 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>   	if (sysctl_hung_task_warnings || hung_task_call_panic) {
>   		if (sysctl_hung_task_warnings > 0)
>   			sysctl_hung_task_warnings--;
> -		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
> -		       t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
> +		pr_err("INFO: task %s:%d blocked for more than %ld seconds. [#%ld]\n",
> +		       t->comm, t->pid, (jiffies - t->last_switch_time) / HZ,
> +		       sysctl_hung_task_detect_count);
>   		pr_err("      %s %s %.*s\n",
>   			print_tainted(), init_utsname()->release,
>   			(int)strcspn(init_utsname()->version, " "),


