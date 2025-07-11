Return-Path: <linux-kernel+bounces-727798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DCDB01FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E765B763BD4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB8F2EA485;
	Fri, 11 Jul 2025 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="s0hLXYe2"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28882E9EBF
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245805; cv=none; b=XlszvfqB+sQahDO8VlyzHpUGpYXWtvHdvHiDt838YjBHCDvlXWEZqXktNZZ5yUu8Vss5IUxZUwioDbSHD88z6clH0iw2PIP5bQu0oppeoCkSV6sKuJXbLdLb/jQRMfOy1pf4N5DyYKaiEXTnqXwcbz5fdHbO4iay9FfAX+/PccQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245805; c=relaxed/simple;
	bh=5mr1aDtNGT9/lR8ahICjF7wy8bx2blUwkHSxUA2Oby0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMHCHsBTHuH8aU6XisGHq1NsnJqZaPLtJekPf55Kqctqmg0Ll3QSSlCJoXlXAW1+iwjh5Y6pJWN7XdjOSCTwNKdF4dwRymyax4k4X2pmrRMpaU+FA8LFM7Cr7Q7T8C61IXSXn0AUUt3XKZtbnvwaQCG4CPf+iW3nzY8JjR8zfzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=s0hLXYe2; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752245795; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=coA4qiWVT+RKqvwey9IFyaoAUEmOXNmxt9MXcVW2deA=;
	b=s0hLXYe2sD9uAM/447y+0dQwcxTsowpWKgPAXUakhXc1gnGIF3CAs3fsciGXZz31CEhrKhZUgIex6tloyWzksLE9O20MOsQMOzS2G8nX7KRrxk8I9bG2l/zFR8+sFn/kuvgW1mokjLnvHP/FBkysozN+xPGTgIFFyQEtKVx6Tnw=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WihPbBJ_1752245793 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Jul 2025 22:56:34 +0800
Date: Fri, 11 Jul 2025 22:56:33 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v1 3/7] panic: sys_info: Capture si_bits_global before
 iterating over it
Message-ID: <aHEmIdgXvOeHtgMM@U-2FWC9VHC-2323.local>
References: <20250711095413.1472448-1-andriy.shevchenko@linux.intel.com>
 <20250711095413.1472448-4-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250711095413.1472448-4-andriy.shevchenko@linux.intel.com>

Hi Andy,

Thanks for the patch! please cc Petr Mladek <pmladek@suse.com> for changes
as I mentioned in the cover letter, he contributed a lot to the code and arch
from RFC to v3.

On Fri, Jul 11, 2025 at 12:51:09PM +0300, Andy Shevchenko wrote:
> The for-loop might re-read the content of the memory the si_bits_global
> points to on each iteration. Instead, just capture it for the sake of
> consistency and use that instead.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/sys_info.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/sys_info.c b/lib/sys_info.c
> index 44bc6d96b702..5d98560f3f53 100644
> --- a/lib/sys_info.c
> +++ b/lib/sys_info.c
> @@ -58,11 +58,11 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
>  	char names[sizeof(sys_info_avail) + 1];
>  	struct ctl_table table;
>  	unsigned long *si_bits_global;
> +	unsigned long si_bits;
>  
>  	si_bits_global = ro_table->data;
>  
>  	if (write) {
> -		unsigned long si_bits;
>  		int ret;
>  
>  		table = *ro_table;
> @@ -81,8 +81,11 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
>  		char *delim = "";
>  		int i, len = 0;
>  
> +		/* The access to the global value is not synchronized. */
> +		si_bits = READ_ONCE(*si_bits_global);

Good catch!

Thanks,
Feng

> +
>  		for (i = 0; i < ARRAY_SIZE(si_names); i++) {
> -			if (*si_bits_global & si_names[i].bit) {
> +			if (si_bits & si_names[i].bit) {
>  				len += scnprintf(names + len, sizeof(names) - len,
>  					"%s%s", delim, si_names[i].name);
>  				delim = ",";
> -- 
> 2.47.2
>

