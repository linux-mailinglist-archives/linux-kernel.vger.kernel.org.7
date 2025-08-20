Return-Path: <linux-kernel+bounces-776801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576BDB2D19F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8496221BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A2F2773DA;
	Wed, 20 Aug 2025 01:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pCVNV4T7"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4835970823
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755654872; cv=none; b=lhQopWuUqavNuiLYE8lpjrBRtrkUAE4tdQllapVg+G89zPAw8SCo1sZ89Lrkl5Olej3nsL8s6I88xVAm2wEBwHmVZezG+YYTYfjMWrbX0oSYsNJcA79EXHAPDmvt5xGFPTmd7icoFMZ11KDrqteEIYiv7Wb7VBLpBY+iWxz1DRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755654872; c=relaxed/simple;
	bh=0dS7Dvi8VpyLmp3azlPofNJqhmQ2Buq2f8WM9QeJlXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+HInF8prvjwtNShBN8jcxwiX4UHjf5BOYSQKil3CUk2OiWiRRZNvJEajF1RfNmRz/Yncl+OIsIEVx5Hf+z7adfb8Df8U5nxNxKmNQS5BlAjSPZDbddz8X++g5Kb7T+Su4lRHrjg2nizX8wqAamOALF16bxe27h7dAMPsTpyUgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pCVNV4T7; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ae9bb2ea-c6e5-4a4b-ae25-aea1d6fe084d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755654866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eahXrLInkrCA7eb/xYG4dx3o/yyl8ef/xSYb6rkODMY=;
	b=pCVNV4T7NVg27PHyW7dCE6EQ2iYGKoebYGF5nWklRLOs50SrZ29zYiPpwykLNVldlIPPMn
	87ztk76Nit13NdGb9ZWJRSDNYFfWUOZKFw5jZhiBrrruzGrpH1szx7wUByV+Ot4Qwk7vGn
	ocmNnYPAKKPZj4SrKETmiDy4cbdnrV8=
Date: Wed, 20 Aug 2025 09:54:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] panic: Clean up message about deprecated 'panic_print'
 parameter
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, Petr Mladek <pmladek@suse.com>,
 Feng Tang <feng.tang@linux.alibaba.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, paulmck@kernel.org, john.ogness@linutronix.de
References: <aKRJKZHgcxyNF3y7@pathway.suse.cz>
 <202508200907.PsZ3geub-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <202508200907.PsZ3geub-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/8/20 09:31, kernel test robot wrote:
> Hi Petr,
> 
> kernel test robot noticed the following build errors:
> 
> 
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/UPDATE-20250819-180717/Feng-Tang/lib-sys_info-handle-sys_info_mask-0-case/20250815-152131
> base:   the 3th patch of https://lore.kernel.org/r/20250815071428.98041-4-feng.tang%40linux.alibaba.com
> patch link:    https://lore.kernel.org/r/aKRJKZHgcxyNF3y7%40pathway.suse.cz
> patch subject: [PATCH] panic: Clean up message about deprecated 'panic_print' parameter
> config: i386-buildonly-randconfig-004-20250820 (https://download.01.org/0day-ci/archive/20250820/202508200907.PsZ3geub-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250820/202508200907.PsZ3geub-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508200907.PsZ3geub-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> kernel/panic.c:952:2: error: call to undeclared function 'panic_print_deprecated'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>       952 |         panic_print_deprecated();
>           |         ^
>     kernel/panic.c:958:2: error: call to undeclared function 'panic_print_deprecated'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>       958 |         panic_print_deprecated();
>           |         ^
>     2 errors generated.


Oops, panic_print_deprecated() is defined within the #ifdef
CONFIG_PROC_SYSCTL block, but it's also called from panic_print_set()
and panic_print_get(), which are outside of that block.

So, we need to move the definition out of the block to a common
scope where all its callers can see it. @Petr wdyt?

Thanks,
Lance

> 
> 
> vim +/panic_print_deprecated +952 kernel/panic.c
> 
>     949	
>     950	static int panic_print_set(const char *val, const struct kernel_param *kp)
>     951	{
>   > 952		panic_print_deprecated();
>     953		return  param_set_ulong(val, kp);
>     954	}
>     955	
> 


