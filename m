Return-Path: <linux-kernel+bounces-738687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD210B0BBF4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C905189A5A7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2E920485B;
	Mon, 21 Jul 2025 04:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jn0PQfyY"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77167DA95
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753073802; cv=none; b=XrOug1FAN9z254mURcevS0Sa2+LwkeUnCoMgT5t1iEtd34IFpw1+ZMsiVduQ1ZMrJgQ29z+eEUTAjPAy4DjzYFVOqJTo9lYTBvuLJtI+NC779ok6V/QLA1Cc/lY8INKDxvY1uhjTj5woHZCLxNX9MET/NP0ngzwxZ4BjJCmdRHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753073802; c=relaxed/simple;
	bh=pyBu1GZtzP2913Y9O2Ctx1/PDGrpN4QegWgsbmvJ1EA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EuZO8WJjsTPfCOnDzk4hfbfcToblmxbuvN5mClWTIRm9mdv4VVTRnXmpR7e+WQArAeC8VOaa4lOQLFnmvpb8OwNeRGeGykK9jEm8A6c1PESdv0aMCnbyVkUXJFAtq5tEhC2EZcgCKaodDlfM122jbIT5Dd+etD8lQw/NiuA6mv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jn0PQfyY; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0d15cf75-abbd-446d-86fa-49ea251f7a82@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753073796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tpJk2In6xaDXHVkpnOgAC2P/JpOAk/YeUj8fHl7WN0I=;
	b=jn0PQfyYpqbMkgr5RgA/tYdea1+rB5pG8DSRTGaOMvUSsj4o2JEtf7AwNCFHDWG/qjgBnl
	QdjtjuNnGWGx7d6GR61FrUbcrP7eRCsfnuiTPTIkrS9naaGw1dHFKR50qqo9H9j+eaxaLO
	VEvojzy9DhdEq99Awz0MedR9nUQ2a9U=
Date: Mon, 21 Jul 2025 12:56:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] hung_task: add warning counter to blocked task report
Content-Language: en-US
To: Ye Liu <ye.liu@linux.dev>
Cc: Ye Liu <liuye@kylinos.cn>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Zi Li <zi.li@linux.dev>
References: <20250721031755.1418556-1-ye.liu@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20250721031755.1418556-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Ye,

Thanks for your patch!

On 2025/7/21 11:17, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Add a warning counter to each hung task message to make it easier
> to analyze and locate issues in the logs.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> ---
>   kernel/hung_task.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 8708a1205f82..9e5f86148d47 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -58,6 +58,7 @@ EXPORT_SYMBOL_GPL(sysctl_hung_task_timeout_secs);
>   static unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
>   
>   static int __read_mostly sysctl_hung_task_warnings = 10;
> +static int hung_task_warning_count;
>   
>   static int __read_mostly did_panic;
>   static bool hung_task_show_lock;
> @@ -232,8 +233,9 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>   	if (sysctl_hung_task_warnings || hung_task_call_panic) {
>   		if (sysctl_hung_task_warnings > 0)
>   			sysctl_hung_task_warnings--;
> -		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
> -		       t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
> +		pr_err("INFO: task %s:%d blocked for more than %ld seconds. [Warning #%d]\n",
> +		       t->comm, t->pid, (jiffies - t->last_switch_time) / HZ,
> +		       ++hung_task_warning_count);
>   		pr_err("      %s %s %.*s\n",
>   			print_tainted(), init_utsname()->release,
>   			(int)strcspn(init_utsname()->version, " "),

A quick thought on this: we already have the hung_task_detect_count
counter, which tracks the total number of hung tasks detected since
boot ;)

While this patch adds a counter inline with the warning message, the
existing counter already provides a way to know how many hung task
events have occurred.

Could you elaborate on the specific benefit of printing this count
directly in the log, compared to checking the global hung_task_detect_count?

Also, if the goal is to give each warning a unique sequence number,
I think the dmesg timestamp prefix serves the same purpose ;)

Thanks,
Lance

