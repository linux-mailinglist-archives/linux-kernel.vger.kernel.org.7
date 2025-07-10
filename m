Return-Path: <linux-kernel+bounces-726539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DA9B00E69
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09D53ADC70
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA08A2951B5;
	Thu, 10 Jul 2025 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OICT/CVX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447AA293C57
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752184894; cv=none; b=OFuKIYqElZm4/HNokhxf5NyRz7LuHZrWmS3t4yppoZsKQ5uauyKXME2P0QyvzwqLV9bjDUW/5hXIPdcM3TM7hB9iVCTqAMHGezG7Ks162SaZeQThBT6rZTs51kmQj1zvTFq2vtXK8KuPoZsrseLpbifxuE0pZTY0utp+t2YY450=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752184894; c=relaxed/simple;
	bh=6MdF5i/RpZPtk45CWd9nolEmBp5s/RmeoUjMV5XhZwI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UVi1uoBVOgMvhLy2zH/ShTYqMZCKI04rOM5ey9YuHO9Bpc4wihHt1badi7GhsVbRe/FMuFgRRajee81wNilg6yXdFQcqtAOV9aIDZw6x7XIR1CAqQmycVMW40b9LvXy0rg3/Rdus9rZqNarMbFVE59AdbtPcOAZRnUnIs320u3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OICT/CVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B76BC4CEE3;
	Thu, 10 Jul 2025 22:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752184894;
	bh=6MdF5i/RpZPtk45CWd9nolEmBp5s/RmeoUjMV5XhZwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OICT/CVXnbAYMC8+MvstH7ZXTfriVfQy+4pGsAzGSG/7v5COziVUEralpPz2ZfW6x
	 yFtqmLgl8i59krSPPvw4nlIwrCMSj0LXWIm3jNO8UvAgSqUPb0XL7cxS0XMWKAY5j3
	 j3y2kdYsBvSsWOhiooxBQrcq8eaXSAwdWfDNGoPo=
Date: Thu, 10 Jul 2025 15:01:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Feng Tang <feng.tang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] panic: Fix compilation error (`make W=1`)
Message-Id: <20250710150133.680679cf8a0f6b2f0bf3369f@linux-foundation.org>
In-Reply-To: <20250710094816.771656-1-andriy.shevchenko@linux.intel.com>
References: <20250710094816.771656-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 12:48:16 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Compiler is not happy about the recently added code:
> 
> lib/sys_info.c:52:19: error: variable 'sys_info_avail' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
>    52 | static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
>       |                   ^~~~~~~~~~~~~~
> 
> Fix it in the same way how, for example, lib/vsprintf.c does in the similar
> cases, i.e. by using string literal directly as sizeof() parameter.
> 
> ...
>

> --- a/lib/sys_info.c
> +++ b/lib/sys_info.c
> @@ -49,13 +49,11 @@ unsigned long sys_info_parse_param(char *str)
>  
>  #ifdef CONFIG_SYSCTL
>  
> -static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
> -
>  int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
>  					  void *buffer, size_t *lenp,
>  					  loff_t *ppos)
>  {
> -	char names[sizeof(sys_info_avail) + 1];
> +	char names[sizeof("tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks") + 1];
>  	struct ctl_table table;
>  	unsigned long *si_bits_global;
>  

Yes, that's neater than the fix we currently have.  I'll grab, thanks.

