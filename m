Return-Path: <linux-kernel+bounces-772729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 092F3B296E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFCFF17F73F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA8F246761;
	Mon, 18 Aug 2025 02:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lpr76ho+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D082236E3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755483506; cv=none; b=pGbiUGB/723na1RSFMLJIqjtdpZQaDDidDf1VmWyofUTVHziWjMqoOHigE2ANa5pwSpyvpLu6dgjcDDcI75U8yLpg7jmdAeTD6YRfYnoia8mevlq3vwnO14rh/a9/JWO30ExfAvDso2ow0F4h2dZyiYyPg1y74vtO+JkAArnt8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755483506; c=relaxed/simple;
	bh=9C/OgKK6Jq11I3HNli6+hEImiLYRcGL+i1Wirubu1pg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=T8qnaV98LTo3Vs9xhhtBrQqwIGeNT0pvmmxbbzKIcJMluEx+2NAYjcxGZKBQhA2r/NUNyZklcIUSqCPcrKd3nSqt22oZYqXvzLK9eIAdPeltXJfy5DAbu0//PWX5HwQLroRQwdno+Dsy+zSmjGMjuRK049M8XLKV4EaHsvdpCuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=lpr76ho+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B524C4CEEB;
	Mon, 18 Aug 2025 02:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755483506;
	bh=9C/OgKK6Jq11I3HNli6+hEImiLYRcGL+i1Wirubu1pg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lpr76ho+zHkCH8DUobo58mMCHRbtad+s7SQTnCQyeirtDgY37aWah5P6lU8L2w0K7
	 xl/l1EsrF1GE8DvmboWvCUAMZmBC9KkbO/071ToGKEEs3/O6iqd9OJL8LO9wURKbBZ
	 ygcd4/hL5eORSHfwjx9vrcTDpcFO6qz1Nv/n5oms=
Date: Sun, 17 Aug 2025 19:18:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: yaozhenguo <yaozhenguo1@gmail.com>
Cc: tglx@linutronix.de, yaoma@linux.alibaba.com, max.kellermann@ionos.com,
 lihuafei1@huawei.com, yaozhenguo@jd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog/softlockup:Fix incorrect CPU utilization
 output during softlockup
Message-Id: <20250817191825.ef254428d688d987333d4f4e@linux-foundation.org>
In-Reply-To: <20250812082510.32291-1-yaozhenguo@jd.com>
References: <20250812082510.32291-1-yaozhenguo@jd.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 12 Aug 2025 16:25:10 +0800 yaozhenguo <yaozhenguo1@gmail.com> wrote:

> From: ZhenguoYao <yaozhenguo1@gmail.com>
> 
> Since we use 16-bit precision, the raw data will undergo
> integer division, which may sometimes result in data loss.
> This can lead to slightly inaccurate CPU utilization calculations.
> Under normal circumstances, this isn’t an issue.  However,
> when CPU utilization reaches 100%, the calculated result might
> exceed 100%.  For example, with raw data like the following:
> 
> sample_period 400000134 new_stat 83648414036 old_stat 83247417494
> 
> sample_period=400000134/2^24=23
> new_stat=83648414036/2^24=4985
> old_stat=83247417494/2^24=4961
> util=105%
> 
> Below log will output：
> 
> CPU#3 Utilization every 0s during lockup:
>     #1:   0% system,          0% softirq,   105% hardirq,     0% idle
>     #2:   0% system,          0% softirq,   105% hardirq,     0% idle
>     #3:   0% system,          0% softirq,   100% hardirq,     0% idle
>     #4:   0% system,          0% softirq,   105% hardirq,     0% idle
>     #5:   0% system,          0% softirq,   105% hardirq,     0% idle
> 
> To avoid confusion, we enforce a 100% display cap when
> calculations exceed this threshold.
> 
> ...
>
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -444,6 +444,13 @@ static void update_cpustat(void)
>  		old_stat = __this_cpu_read(cpustat_old[i]);
>  		new_stat = get_16bit_precision(cpustat[tracked_stats[i]]);
>  		util = DIV_ROUND_UP(100 * (new_stat - old_stat), sample_period_16);
> +		/* Since we use 16-bit precision, the raw data will undergo

		/*
		 * Since ...

please.

> +		 * integer division, which may sometimes result in data loss,
> +		 * and then result might exceed 100%. To avoid confusion,
> +		 * we enforce a 100% display cap when calculations exceed this threshold.
> +		 */
> +		if (util > 100)
> +			util = 100;
>  		__this_cpu_write(cpustat_util[tail][i], util);
>  		__this_cpu_write(cpustat_old[i], new_stat);
>  	}

Can we do something to make this output more accurate?  For example,

	return (data_ns + (1 << 23)) >> 24LL;

would round to the nearest multiple of 16.8ms?



