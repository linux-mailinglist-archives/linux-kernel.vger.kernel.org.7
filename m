Return-Path: <linux-kernel+bounces-828241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B81B943BF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A01918A507B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B402727E0;
	Tue, 23 Sep 2025 04:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kcAvOmBL"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EA21EA6F;
	Tue, 23 Sep 2025 04:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758602144; cv=none; b=evaLTNA1rH0Flk/KbrigzPfxUwJz6dupAF8NjgH0i2IqhmyLqGX8y5wRFhT5M3rOWe+UXNsyAI0UdViuU5hVnJjoFsJ55PqGxxcrnt+JxlX2da8ouBluUG3ap8K4qOtAkLnWeFuSDxbt9Re2fdX9C26BH3osAGSLUJ3pOdthxOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758602144; c=relaxed/simple;
	bh=xri9HMi8QTBdXGPkcCdmuhSmhLfz6PzTKoTEPYht7Os=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jwcIpNtserPsaxs5nvUDYy6csFtvfhI25I2kHgNC2jPQlTtkNviZ7u0rVyAQN9eKq+USV87X/geKPFfQ5vPIxHK19oUcjuiBwUHNZwPIv5TxEQb/HL4JhzZRcHWXTIYoXP6JdpwiMkBiL8Llc6elpdvbeTNrkRSBY0B+5dZuY3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kcAvOmBL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=O9I28wKAMBkmm9Tu0w7FNn4HF9+jbOIT06uYWRFS70o=; b=kcAvOmBLofRrjt24slIRMG/ZhU
	I+oaDiGETpO7jV9rLCxtWa3omGmG+4iYkFuCp0AJnkOnae/boV334MDaFdhqfHJgKygwFVkvgrQlm
	y9wUPd0mDsiDrH/iXPGasUAqW8xzeiC+IB3ECvi1dtCenDU7zFRwQyQDb5vFeRUovh0K4mKzZxHtV
	Gtrt/cPzI7IY/MIpFsVwqkk511TZPeYhHu00mRndqgTfITJW31tsF2JqgNJLvZM2YZA3+aQSx58AE
	wLbR3MdFyhSErtxcIx0tqs614Dsnfgs4JLySmzbXUaC9Y2LzbSJjqZKGAzGVPMUq4r36NZHRcW8vR
	AJJ6a3Gg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0ukX-0000000CLHg-0OfQ;
	Tue, 23 Sep 2025 04:35:33 +0000
Message-ID: <6ea3231d-d131-4431-bd72-9dbb1e4410c9@infradead.org>
Date: Mon, 22 Sep 2025 21:35:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][RFC] hung_task: Support to panic when the maximum number
 of hung task warnings is reached
To: lirongqing <lirongqing@baidu.com>, corbet@lwn.net,
 akpm@linux-foundation.org, lance.yang@linux.dev, mhiramat@kernel.org,
 paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com, mingo@kernel.org,
 dave.hansen@linux.intel.com, rostedt@goodmis.org, kees@kernel.org,
 arnd@arndb.de, feng.tang@linux.alibaba.com, pauld@redhat.com,
 joel.granados@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250923033740.2696-1-lirongqing@baidu.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250923033740.2696-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/22/25 8:37 PM, lirongqing wrote:
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index dc0e0c6..e7cf166 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1264,10 +1264,10 @@ config DEFAULT_HUNG_TASK_TIMEOUT
>  	  Keeping the default should be fine in most cases.
>  
>  config BOOTPARAM_HUNG_TASK_PANIC
> -	bool "Panic (Reboot) On Hung Tasks"
> +	int "Panic (Reboot) On Hung Tasks"
>  	depends on DETECT_HUNG_TASK
>  	help
> -	  Say Y here to enable the kernel to panic on "hung tasks",
> +	  Say 1|2 here to enable the kernel to panic on "hung tasks",

Please make that   "1|2"    more user-friendly, e.g., "1 or 2".

>  	  which are bugs that cause the kernel to leave a task stuck
>  	  in uninterruptible "D" state.

-- 
~Randy


