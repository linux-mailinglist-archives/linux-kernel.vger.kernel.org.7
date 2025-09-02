Return-Path: <linux-kernel+bounces-795489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAE3B3F2CA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F3048550F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 03:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17462E0928;
	Tue,  2 Sep 2025 03:38:35 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0F3207A0C;
	Tue,  2 Sep 2025 03:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756784315; cv=none; b=EePaSoyYu2GZFwWhwov2foTItXCCWKheNWfF2CCaus19brcsWD7NU9a3Lbg9asOE6+AjvIcGoOlZQcj3MdZ/LH9ISRXhkPcJvmA9GwBX0afyx5IKUoXHghpI5k2PK9BghtfJtzKZxRcS37VMRQq1/2DukD2nXjBGg9NB2GaSISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756784315; c=relaxed/simple;
	bh=xjFXwLgN9+Tb+kcrEl/8o0thagVQvKnOfuOi+lF72ho=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=Ro1bHVRt7XAv48hM2/AcTl7ZofFg6/Idd33mQ1n28zBysUpIBM9EwHIFbM1IxJWE/DgxnYSz87bbsIOT63YpvixzUIrTYjsP7DOCxcu/abPwQRZfZbsu0hD99dandTv31TUrZ9Bha7bUH5LCJmB8NK/Hg4mq9dS8ziVRbg8q204=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cGBKZ4ZPrz5B8mt;
	Tue, 02 Sep 2025 11:38:26 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 5823c8KZ088347;
	Tue, 2 Sep 2025 11:38:08 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 2 Sep 2025 11:38:09 +0800 (CST)
Date: Tue, 2 Sep 2025 11:38:09 +0800 (CST)
X-Zmail-TransId: 2afb68b666a1f39-0ca5f
X-Mailer: Zmail v1.0
Message-ID: <202509021138097501cXkw4xiXiYSWRs8thevi@zte.com.cn>
In-Reply-To: <20250902100030967nPEcUoRRSnruExakQxAIm@zte.com.cn>
References: 202509020957458514CMgUiaqPjTURNET_d-w0@zte.com.cn,20250902100030967nPEcUoRRSnruExakQxAIm@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <fan.yu9@zte.com.cn>, <akpm@linux-foundation.org>
Cc: <akpm@linux-foundation.org>, <wang.yaxin@zte.com.cn>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <yang.yang29@zte.com.cn>, <fan.yu9@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0IDEvM10gdG9vbHMvZGVsYXl0b3A6IGFkZCBtZW1vcnkgdmVyYm9zZSBtb2RlIHN1cHBvcnQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5823c8KZ088347
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 02 Sep 2025 11:38:26 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68B666B2.000/4cGBKZ4ZPrz5B8mt

> From: Fan Yu <fan.yu9@zte.com.cn>
> 
> The original delaytop tool always displayed detailed memory
> subsystem breakdown, which could be overwhelming for users
> who only need high-level overview.
> 
> Add flexible display control allowing users to choose their
> preferred information granularity.
> 
> The new flexibility provides:
> 1) For quick monitoring: use normal mode to reduce visual clutter
> 2) For deep analysis: use verbose mode to see all memory subsystem details
> 
> Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>

This feature is very useful to analyze specific delay sources due to memory operations.

But these shown datas are basically average values rather than min/max, it's not enough

for debugging delay jitters. Will you add showing min/max values to delaytop in future? 

> ---
>  tools/accounting/delaytop.c | 111 ++++++++++++++++++++++++++++--------
>  1 file changed, 87 insertions(+), 24 deletions(-)
> 
>  /* PSI statistics structure */
> @@ -163,13 +166,14 @@ static void usage(void)
>  {
>  	printf("Usage: delaytop [Options]\n"
>  	"Options:\n"
> -	"  -h, --help				Show this help message and exit\n"
> -	"  -d, --delay=SECONDS	  Set refresh interval (default: 2 seconds, min: 1)\n"
> -	"  -n, --iterations=COUNT	Set number of updates (default: 0 = infinite)\n"
> -	"  -P, --processes=NUMBER	Set maximum number of processes to show (default: 20, max: 1000)\n"
> -	"  -o, --once				Display once and exit\n"
> -	"  -p, --pid=PID			Monitor only the specified PID\n"
> -	"  -C, --container=PATH	 Monitor the container at specified cgroup path\n");
> +	"  -h, --help               Show this help message and exit\n"
> +	"  -d, --delay=SECONDS      Set refresh interval (default: 2 seconds, min: 1)\n"
> +	"  -n, --iterations=COUNT   Set number of updates (default: 0 = infinite)\n"
> +	"  -P, --processes=NUMBER   Set maximum number of processes to show (default: 20, max: 1000)\n"
> +	"  -o, --once               Display once and exit\n"
> +	"  -p, --pid=PID            Monitor only the specified PID\n"
> +	"  -C, --container=PATH     Monitor the container at specified cgroup path\n"
> +	"  -M, --memverbose         Display memory detailed information\n");
>  	exit(0);
>  }
> 

..

> 
> +	suc &= BOOL_FPRINT(out, "%8s  %8s  %-17s", "PID", "TGID", "COMMAND");
> +
> +	if (!cfg.mem_verbose_mode) {
> +		suc &= BOOL_FPRINT(out, "%8s %8s %8s %8s\n",
> +			"CPU(ms)", "IO(ms)", "IRQ(ms)", "MEM(ms)");
> +		suc &= BOOL_FPRINT(out, "-----------------------");
> +		suc &= BOOL_FPRINT(out, "-----------------------");
> +		suc &= BOOL_FPRINT(out, "--------------------------\n");
> +	} else {
> +		suc &= BOOL_FPRINT(out, "%8s %8s %8s %8s %8s %8s %8s %8s %8s\n",
> +			"CPU(ms)", "IO(ms)", "IRQ(ms)", "MEM(ms)",
> +			"SWAP(ms)", "RCL(ms)", "THR(ms)", "CMP(ms)", "WP(ms)");
> +		suc &= BOOL_FPRINT(out, "-----------------------");
> +		suc &= BOOL_FPRINT(out, "-----------------------");
> +		suc &= BOOL_FPRINT(out, "-----------------------");
> +		suc &= BOOL_FPRINT(out, "-----------------------");
> +		suc &= BOOL_FPRINT(out, "-------------------------\n");
> +	}
> +
> 
> -	suc &= BOOL_FPRINT(out, "-----------------------------------------------");
> -	suc &= BOOL_FPRINT(out, "----------------------------------------------\n");
>  	count = task_count < cfg.max_processes ? task_count : cfg.max_processes;
> 
>  	for (i = 0; i < count; i++) {
> -		suc &= BOOL_FPRINT(out, "%5d  %5d  %-15s",
> +		suc &= BOOL_FPRINT(out, "%8d  %8d  %-15s",
>  			tasks[i].pid, tasks[i].tgid, tasks[i].command);
> -		suc &= BOOL_FPRINT(out, "%7.2f %7.2f %7.2f %7.2f %7.2f %7.2f %7.2f %7.2f\n",
> -			average_ms(tasks[i].cpu_delay_total, tasks[i].cpu_count),
> -			average_ms(tasks[i].blkio_delay_total, tasks[i].blkio_count),
> -			average_ms(tasks[i].swapin_delay_total, tasks[i].swapin_count),
> -			average_ms(tasks[i].thrashing_delay_total, tasks[i].thrashing_count),
> -			average_ms(tasks[i].compact_delay_total, tasks[i].compact_count),
> -			average_ms(tasks[i].wpcopy_delay_total, tasks[i].wpcopy_count),
> -			average_ms(tasks[i].irq_delay_total, tasks[i].irq_count));
> +		if (!cfg.mem_verbose_mode) {
> +			suc &= BOOL_FPRINT(out, FMT_NORMAL,
> +				average_ms(tasks[i].cpu_delay_total,
> +						   tasks[i].cpu_count),
> +				average_ms(tasks[i].blkio_delay_total,
> +						   tasks[i].blkio_count),
> +				average_ms(tasks[i].irq_delay_total,
> +						   tasks[i].irq_count),
> +				average_ms(task_total_mem_delay(&tasks[i]),
> +						   task_total_mem_count(&tasks[i])));
> +		} else {
> +			suc &= BOOL_FPRINT(out, FMT_MEMVERBOSE,
> +				average_ms(tasks[i].cpu_delay_total,
> +						   tasks[i].cpu_count),
> +				average_ms(tasks[i].blkio_delay_total,
> +						   tasks[i].blkio_count),
> +				average_ms(tasks[i].irq_delay_total,
> +						   tasks[i].irq_count),
> +				average_ms(task_total_mem_delay(&tasks[i]),
> +						   task_total_mem_count(&tasks[i])),
> +				average_ms(tasks[i].swapin_delay_total,
> +						   tasks[i].swapin_count),
> +				average_ms(tasks[i].freepages_delay_total,
> +						   tasks[i].freepages_count),
> +				average_ms(tasks[i].thrashing_delay_total,
> +						   tasks[i].thrashing_count),
> +				average_ms(tasks[i].compact_delay_total,
> +						   tasks[i].compact_count),
> +				average_ms(tasks[i].wpcopy_delay_total,
> +						   tasks[i].wpcopy_count));
> +		}
>  	}

I think if users press 'M', delaytop doesn't need to shown CPU/IRQ/IO delays, just show the detailed memory delays.


> 
>  	suc &= BOOL_FPRINT(out, "\n");
> -- 
> 2.25.1

