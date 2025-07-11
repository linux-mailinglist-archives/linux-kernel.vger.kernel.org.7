Return-Path: <linux-kernel+bounces-727814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 484DAB02011
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E9EDB4192F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BF82EA475;
	Fri, 11 Jul 2025 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fqi/32ml"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A432E9EAC
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752246564; cv=none; b=o/FBSThgs0b8tspv6YeU40z5/Y7aAqTDQd8/k7yv3/60IAzzyt+FvWmAf3bRbBscmk+md2A1wg2B41O5ccSwqoRiHvv/v7u5fsZg6rdAN/m1N0oQ/iDcXuAHVjGbN7eKMNdepQld0UMTvLUQiPJzXKZYCLl4jTRlGhBcP2r3ICk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752246564; c=relaxed/simple;
	bh=c0QG91nXD6uWs9AtRjzcXxjXSdJgq5tP6Jomtf1ATJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIdXa9R/rn0r7/feHuc8WesDbBTxJRSzBfQG4Bc5m5j6PqWMxirF7wpMkIr1HbggcKgZnK0S+KvoCVFk7B9Pk93jesxjoYPoMAGo6K98Prz/ClovS4RUiNiZLk28XLZFDp8hXxUsTRI7GvrJr6E8Qr68gLUVtyKHFYlAHAPwY+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fqi/32ml; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752246557; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=ODtWHFNcHhdiD6bL5WKwotebt6sv6eO+EG8OfRrD7LY=;
	b=fqi/32mlOmpmWy8Gro4/8yg0qPCubVhtkQG+CDqPizWIPixkT6nLBcM8ePPuiZ2jKXcjk9+HG25RecKXIKUETBaLBiznXkTSdJysxq2yeVytWnnpzyIyoPlD+T5+iAOCbsEqKWKHAiZVweQiTg8aZ5nvVzOj3D+t3y9GaMaLhpI=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WihMlaV_1752246556 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Jul 2025 23:09:17 +0800
Date: Fri, 11 Jul 2025 23:09:16 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v1 7/7] panic: sys_info: Factor out read and write
 handlers
Message-ID: <aHEpHEtnPms2LUi-@U-2FWC9VHC-2323.local>
References: <20250711095413.1472448-1-andriy.shevchenko@linux.intel.com>
 <20250711095413.1472448-8-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250711095413.1472448-8-andriy.shevchenko@linux.intel.com>

On Fri, Jul 11, 2025 at 12:51:13PM +0300, Andy Shevchenko wrote:
> For the sake of the code readability and easier maintenance
> factor out read and write sys_info handlers.

IIRC, I did implement separate 'write' handler, but chose not
to do that to save some common definition. I guess it's personal
preference, and I'm fine with either one. 

Thanks,
Feng

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/sys_info.c | 72 ++++++++++++++++++++++++++++++--------------------
>  1 file changed, 44 insertions(+), 28 deletions(-)
> 
> diff --git a/lib/sys_info.c b/lib/sys_info.c
> index 7483b6e9b30b..32bf639c4de2 100644
> --- a/lib/sys_info.c
> +++ b/lib/sys_info.c
> @@ -40,13 +40,52 @@ unsigned long sys_info_parse_param(char *str)
>  }
>  
>  #ifdef CONFIG_SYSCTL
> +static int sys_info_write_handler(struct ctl_table *table,
> +				  void *buffer, size_t *lenp, loff_t *ppos,
> +				  unsigned long *si_bits_global)
> +{
> +	unsigned long si_bits;
> +	int ret;
> +
> +	ret = proc_dostring(table, 1, buffer, lenp, ppos);
> +	if (ret)
> +		return ret;
> +
> +	si_bits = sys_info_parse_param(table->data);
> +
> +	/* The access to the global value is not synchronized. */
> +	WRITE_ONCE(*si_bits_global, si_bits);
> +
> +	return 0;
> +}
> +
> +static int sys_info_read_handler(struct ctl_table *table,
> +				 void *buffer, size_t *lenp, loff_t *ppos,
> +				 unsigned long *si_bits_global)
> +{
> +	unsigned long si_bits;
> +	unsigned int len = 0;
> +	char *delim = "";
> +	unsigned int i;
> +
> +	/* The access to the global value is not synchronized. */
> +	si_bits = READ_ONCE(*si_bits_global);
> +
> +	for_each_set_bit(i, &si_bits, ARRAY_SIZE(si_names)) {
> +		len += scnprintf(table->data + len, table->maxlen - len,
> +				 "%s%s", delim, si_names[i]);
> +		delim = ",";
> +	}
> +
> +	return proc_dostring(table, 0, buffer, lenp, ppos);
> +}
> +
>  int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
>  					  void *buffer, size_t *lenp,
>  					  loff_t *ppos)
>  {
>  	struct ctl_table table;
>  	unsigned long *si_bits_global;
> -	unsigned long si_bits;
>  	unsigned int i;
>  	size_t maxlen;
>  
> @@ -64,33 +103,10 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
>  	table.data = names;
>  	table.maxlen = maxlen;
>  
> -	if (write) {
> -		int ret;
> -
> -		ret = proc_dostring(&table, write, buffer, lenp, ppos);
> -		if (ret)
> -			return ret;
> -
> -		si_bits = sys_info_parse_param(names);
> -		/* The access to the global value is not synchronized. */
> -		WRITE_ONCE(*si_bits_global, si_bits);
> -		return 0;
> -	} else {
> -		/* for 'read' operation */
> -		unsigned int len = 0;
> -		char *delim = "";
> -
> -		/* The access to the global value is not synchronized. */
> -		si_bits = READ_ONCE(*si_bits_global);
> -
> -		for_each_set_bit(i, &si_bits, ARRAY_SIZE(si_names)) {
> -			len += scnprintf(names + len, maxlen - len,
> -					 "%s%s", delim, si_names[i]);
> -			delim = ",";
> -		}
> -
> -		return proc_dostring(&table, write, buffer, lenp, ppos);
> -	}
> +	if (write)
> +		return sys_info_write_handler(&table, buffer, lenp, ppos, si_bits_global);
> +	else
> +		return sys_info_read_handler(&table, buffer, lenp, ppos, si_bits_global);
>  }
>  #endif
>  
> -- 
> 2.47.2

