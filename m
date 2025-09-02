Return-Path: <linux-kernel+bounces-795492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0490B3F2D2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6093A7D66
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 03:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5014B2E091D;
	Tue,  2 Sep 2025 03:42:05 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13D378F2B;
	Tue,  2 Sep 2025 03:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756784524; cv=none; b=I+c8OtrT0TTGnKDy9iObiU/DL3cThe5Q7KuWTlL2yzIy9HZc9IEb4gj5zSWjZx963LCsnkXtAZTtmB+3xbh6cl8JJgQ9qhURLG79tyMLUs4iU1X9nH5pyIAAah/DjYDpbxecSj4e1T7BcrRrjBbFW7mc518BGMo72onblsyeDpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756784524; c=relaxed/simple;
	bh=LadJrpixXgXmaI3t8blnnAPFhpyMM1cXP3eRwkOGBck=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=i0UpLdCcro/YTjAzEZXVNQK70OGrPCVamsI+KqcCNPE6wmEQuC3O2vKR6Oq/Qhv2vDPD3kvR6UL9FhIeA+81quib4kbp5VJIeBW+r/2LukRem/CPYlEuWab8LiSp55P3/o1/awC+7r1rz+2I/lkhknPXGIc7quJPs9v9+xVrn1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cGBPd5ldHz59vCT;
	Tue, 02 Sep 2025 11:41:57 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 5823fjET092808;
	Tue, 2 Sep 2025 11:41:45 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 2 Sep 2025 11:41:46 +0800 (CST)
Date: Tue, 2 Sep 2025 11:41:46 +0800 (CST)
X-Zmail-TransId: 2af968b6677a9ba-1b4d1
X-Mailer: Zmail v1.0
Message-ID: <202509021141468809-_7Kz9HvqZ60kTehEJiJ@zte.com.cn>
In-Reply-To: <20250902100353835xyAecL45pVFk1sbaC16f4@zte.com.cn>
References: 202509020957458514CMgUiaqPjTURNET_d-w0@zte.com.cn,20250902100353835xyAecL45pVFk1sbaC16f4@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <fan.yu9@zte.com.cn>, <akpm@linux-foundation.org>
Cc: <wang.yaxin@zte.com.cn>, <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <yang.yang29@zte.com.cn>,
        <fan.yu9@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0IDIvM10gdG9vbHMvZGVsYXl0b3A6IGFkZCBmbGV4aWJsZSBzb3J0aW5nIGJ5IGRlbGF5IGZpZWxk?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5823fjET092808
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 02 Sep 2025 11:41:57 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68B66785.002/4cGBPd5ldHz59vCT

> From: Fan Yu <fan.yu9@zte.com.cn>
> 
> The delaytop tool only supported sorting by CPU delay, which limited
> its usefulness when users needed to identify bottlenecks in other
> subsystems. Users had no way to sort processes by IO, memory, or
> other delay types to quickly pinpoint specific performance issues.
> 
> Add -s/--sort option to allow sorting by different delay types:
> 1) Basic modes: cpu, io, irq, mem  
> 2) Detailed modes (-M required): swap, reclaim, thrashing, compact, wpcopy
> 
> Users can now quickly identify bottlenecks in specific subsystems
> by sorting processes by the relevant delay metric.
> 
> Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
> ---
>  tools/accounting/delaytop.c | 130 +++++++++++++++++++++++++++++++++---
>  1 file changed, 121 insertions(+), 9 deletions(-)

I have tried this function. Nice to use.

Reviewed-by: xu xin <xu.xin16@zte.com.cn>

> 
> diff --git a/tools/accounting/delaytop.c b/tools/accounting/delaytop.c
> index f1e2e1cca4b8..39852cd70bdf 100644
> --- a/tools/accounting/delaytop.c
> +++ b/tools/accounting/delaytop.c
> @@ -173,7 +173,9 @@ static void usage(void)
>  	"  -o, --once               Display once and exit\n"
>  	"  -p, --pid=PID            Monitor only the specified PID\n"
>  	"  -C, --container=PATH     Monitor the container at specified cgroup path\n"
> -	"  -M, --memverbose         Display memory detailed information\n");
> +	"  -M, --memverbose         Display memory detailed information\n"
> +	"  -s, --sort=FIELD         Sort by delay field (default: cpu)\n"
> +	"                           Types: cpu|io|irq|mem|swap|reclaim|thrashing|compact|wpcopy\n");
>  	exit(0);
>  }
> 
> @@ -188,6 +190,7 @@ static void parse_args(int argc, char **argv)
>  		{"pid", required_argument, 0, 'p'},
>  		{"once", no_argument, 0, 'o'},
>  		{"processes", required_argument, 0, 'P'},
> +		{"sort", required_argument, 0, 's'},
>  		{"container", required_argument, 0, 'C'},
>  		{"memverbose", no_argument, 0, 'M'},
>  		{0, 0, 0, 0}
> @@ -206,7 +209,7 @@ static void parse_args(int argc, char **argv)
>  	while (1) {
>  		int option_index = 0;
> 
> -		c = getopt_long(argc, argv, "hd:n:p:oP:C:M", long_options, &option_index);
> +		c = getopt_long(argc, argv, "hd:n:p:oP:C:Ms:", long_options, &option_index);
>  		if (c == -1)
>  			break;
> 
> @@ -256,11 +259,53 @@ static void parse_args(int argc, char **argv)
>  		case 'M':
>  			cfg.mem_verbose_mode = 1;
>  			break;
> +		case 's':
> +			if (strlen(optarg) == 0) {
> +				fprintf(stderr, "Error: empty sort field\n");
> +				exit(1);
> +			}
> +
> +			if (strncmp(optarg, "cpu", 3) == 0)
> +				cfg.sort_field = 'c';
> +			else if (strncmp(optarg, "io", 2) == 0)
> +				cfg.sort_field = 'i';
> +			else if (strncmp(optarg, "irq", 3) == 0)
> +				cfg.sort_field = 'q';
> +			else if (strncmp(optarg, "mem", 3) == 0)
> +				cfg.sort_field = 'm';
> +			else if (strncmp(optarg, "swap", 4) == 0)
> +				cfg.sort_field = 's';
> +			else if (strncmp(optarg, "reclaim", 7) == 0)
> +				cfg.sort_field = 'r';
> +			else if (strncmp(optarg, "thrashing", 9) == 0)
> +				cfg.sort_field = 't';
> +			else if (strncmp(optarg, "compact", 7) == 0)
> +				cfg.sort_field = 'p';
> +			else if (strncmp(optarg, "wpcopy", 7) == 0)
> +				cfg.sort_field = 'w';
> +			else {
> +				fprintf(stderr, "Error: invalid sort field\n");
> +				fprintf(stderr, "Try to use cpu|io|irq|mem|");
> +				fprintf(stderr, "swap|reclaim|thrashing|compact|wpcopy\n");
> +				exit(1);
> +			}
> +			break;
>  		default:
>  			fprintf(stderr, "Try 'delaytop --help' for more information.\n");
>  			exit(1);
>  		}
>  	}
> +
> +	/* Validate sorting field compatibility with memory verbose mode */
> +	if (cfg.mem_verbose_mode == 0 &&
> +		cfg.sort_field == 's' ||
> +		cfg.sort_field == 'r' ||
> +		cfg.sort_field == 't' ||
> +		cfg.sort_field == 'p' ||
> +		cfg.sort_field == 'w') {
> +		fprintf(stderr, "Error: mem verbose mode is off, try to use -M\n");
> +		exit(1);
> +	}
>  }
> 
>  /* Create a raw netlink socket and bind */
> @@ -621,12 +666,77 @@ static int compare_tasks(const void *a, const void *b)
>  	case 'c': /* CPU */
>  		avg1 = average_ms(t1->cpu_delay_total, t1->cpu_count);
>  		avg2 = average_ms(t2->cpu_delay_total, t2->cpu_count);
> -		if (avg1 != avg2)
> -			return avg2 > avg1 ? 1 : -1;
> -		return t2->cpu_delay_total > t1->cpu_delay_total ? 1 : -1;
> +		break;
> +	case 'i': /* IO */
> +		avg1 = average_ms(t1->blkio_delay_total, t1->blkio_count);
> +		avg2 = average_ms(t2->blkio_delay_total, t2->blkio_count);
> +		break;
> +	case 'q': /* IRQ */
> +		avg1 = average_ms(t1->irq_delay_total, t1->irq_count);
> +		avg2 = average_ms(t2->irq_delay_total, t2->irq_count);
> +		break;
> +	case 'm': /* MEM(total) */
> +		avg1 = average_ms(task_total_mem_delay(t1), task_total_mem_count(t1));
> +		avg2 = average_ms(task_total_mem_delay(t2), task_total_mem_count(t2));
> +		break;
> +	/* Memory detailed display mode */
> +	case 's': /* swapin (SWAP) */
> +		avg1 = average_ms(t1->swapin_delay_total, t1->swapin_count);
> +		avg2 = average_ms(t2->swapin_delay_total, t2->swapin_count);
> +		break;
> +	case 'r': /* freepages (RCL) */
> +		avg1 = average_ms(t1->freepages_delay_total, t1->freepages_count);
> +		avg2 = average_ms(t2->freepages_delay_total, t2->freepages_count);
> +		break;
> +	case 't': /* thrashing (THR) */
> +		avg1 = average_ms(t1->thrashing_delay_total, t1->thrashing_count);
> +		avg2 = average_ms(t2->thrashing_delay_total, t2->thrashing_count);
> +		break;
> +	case 'p': /* compact (CMP) */
> +		avg1 = average_ms(t1->compact_delay_total, t1->compact_count);
> +		avg2 = average_ms(t2->compact_delay_total, t2->compact_count);
> +		break;
> +	case 'w': /* wpcopy (WP) */
> +		avg1 = average_ms(t1->wpcopy_delay_total, t1->wpcopy_count);
> +		avg2 = average_ms(t2->wpcopy_delay_total, t2->wpcopy_count);
> +		break;
> +	default:
> +		avg1 = average_ms(t1->cpu_delay_total, t1->cpu_count);
> +		avg2 = average_ms(t2->cpu_delay_total, t2->cpu_count);
> +		break;
> +	}
> +
> +	if (avg1 != avg2)
> +		return avg2 > avg1 ? 1 : -1;
> +
> +	return 0;
> +}
> 
> +static const char *get_sort_field(char sort_field)
> +{
> +	switch (sort_field) {
> +	case 'c':
> +		return "CPU";
> +	case 'i':
> +		return "IO";
> +	case 'q':
> +		return "IRQ";
> +	/* MEM(total) */
> +	case 'm':
> +		return "MEM";
> +	/* Memory detailed display mode */
> +	case 's':
> +		return "SWAP";
> +	case 'r':
> +		return "RCL";
> +	case 't':
> +		return "THR";
> +	case 'p':
> +		return "CMP";
> +	case 'w':
> +		return "WP";
>  	default:
> -		return t2->cpu_delay_total > t1->cpu_delay_total ? 1 : -1;
> +		return "UNKNOWN"; /* handle error */
>  	}
>  }
> 
> @@ -705,6 +815,7 @@ static void display_results(void)
>  {
>  	time_t now = time(NULL);
>  	struct tm *tm_now = localtime(&now);
> +	const char *sort_field;
>  	FILE *out = stdout;
>  	char timestamp[32];
>  	bool suc = true;
> @@ -766,8 +877,10 @@ static void display_results(void)
>  			container_stats.nr_stopped, container_stats.nr_uninterruptible,
>  			container_stats.nr_io_wait);
>  	}
> -	suc &= BOOL_FPRINT(out, "Top %d processes (sorted by CPU delay):\n",
> -			cfg.max_processes);
> +
> +	/* Task delay output */
> +	suc &= BOOL_FPRINT(out, "Top %d processes (sorted by %s delay):\n",
> +			cfg.max_processes, get_sort_field(cfg.sort_field));
>  	suc &= BOOL_FPRINT(out, "%8s  %8s  %-17s", "PID", "TGID", "COMMAND");
> 
>  	if (!cfg.mem_verbose_mode) {
> @@ -787,7 +900,6 @@ static void display_results(void)
>  		suc &= BOOL_FPRINT(out, "-------------------------\n");
>  	}
> 
> -
>  	count = task_count < cfg.max_processes ? task_count : cfg.max_processes;
> 
>  	for (i = 0; i < count; i++) {
> -- 
> 2.25.1

