Return-Path: <linux-kernel+bounces-877427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0AFC1E16A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 45F0834B790
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7622F6939;
	Thu, 30 Oct 2025 02:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bQ+vSas/"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1661E47C5
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761789992; cv=none; b=q7KtPzQq0Bg4JfidaBb8BF4qvJRvhwp3K+kn1Yp7OnfzSdCEK7PIzkzOY16SQht0DgJYuHht0fSbz2CJmYs3uHJAtGeG0wDFAwb3bzJ4ebNgE/Z9K89cTdMzR76YW2SOUlUpn7+UjYdj6ovv7VNq3KtDhV1TevbySCqPc4982lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761789992; c=relaxed/simple;
	bh=3DW2D3snAzKZcz7YOGY+asYfDJpOBVNAyF0YerBCiiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8CIvcowr7HUIvZ04om5lEAmR+7DrJijO9syArNq/MCEJgVpr0/VJJNplCAmwZH4wWM0I5lrNJqWwvLJVQbOmDc8/1SvmrszuZFS7hNkNzZlvypqVY+uLre0/tCl5sOYnFOxCBVj1CGrW00YlPRc1Qvoau+tkaNB89uVDBqjVL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bQ+vSas/; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761789977; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=qPpeS+GoVRZ3rsZgnlkupCzK9elsbAA1Iblkepf9T8I=;
	b=bQ+vSas/r0cg47wtrrD34/HsUzG76hzItxffB6HfRyPIYdNwiuXcYsARE8lQRMhtTslKjXcb++CEJBV9IYVXZTCGShRnk4+HLKhKxKvg14JnbSEQffU/aGHE1qt5mfQA6qG8+bXiFIDx7QG0w3w0i7vfb974g3DS/PvEMEZNBtc=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WrI6cr2_1761789977 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 30 Oct 2025 10:06:17 +0800
Date: Thu, 30 Oct 2025 10:06:14 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 6/6] panic: sys_info: Factor out read and write
 handlers
Message-ID: <aQLIFovZGopZb-QX@U-2FWC9VHC-2323.local>
References: <20251029111202.3217870-2-andriy.shevchenko@linux.intel.com>
 <20251029111202.3217870-8-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251029111202.3217870-8-andriy.shevchenko@linux.intel.com>

On Wed, Oct 29, 2025 at 12:07:41PM +0100, Andy Shevchenko wrote:
> For the sake of the code readability and easier maintenance
> factor out read and write sys_info handlers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/sys_info.c | 72 ++++++++++++++++++++++++++++++--------------------
>  1 file changed, 44 insertions(+), 28 deletions(-)
> 
> diff --git a/lib/sys_info.c b/lib/sys_info.c
> index c86f52644857..8ed3b4b55854 100644
> --- a/lib/sys_info.c
> +++ b/lib/sys_info.c
> @@ -43,13 +43,52 @@ unsigned long sys_info_parse_param(char *str)
>  
>  #ifdef CONFIG_SYSCTL
>  
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
> @@ -67,33 +106,10 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
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

As the if and else block each has only round 10 lines of code, and fit a
screen well, I'm not sure whether adding 2 new functions will improve
readabilty, but I'm fine with the change.

Thanks,
Feng

