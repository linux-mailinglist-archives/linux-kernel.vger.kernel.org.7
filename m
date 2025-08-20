Return-Path: <linux-kernel+bounces-777250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F27B2D75E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D0018886E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552972D9788;
	Wed, 20 Aug 2025 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qUMW6Hbj"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A49A1F3BB5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680283; cv=none; b=gBJm90a/krHXnoJIcaSIkVvS+NDfsprCU5lBJ8B/GP8KtSvRpXPcZFVkqtYoVor3Nrgq7MBzSzGfjmo+AD7F+bQqBVCiUyVJXwNvZfaLBNAnjlFERiBzBz8xINQwnLs7+5heoOaYpjhICnzpWVvHaIQw2ojseTw/N9in4UjgsCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680283; c=relaxed/simple;
	bh=9ZUXMVSyMXHq8LX6AkmtfjhFesC1kZpmtysgJnKq3Vk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IMkr6A8R0NIP/sIQVIjxRkkZN/jzCc0dzPt3PRFN0meSX8KbJUXSdnW8dZB6IpWSaxQVSYn3pdrKcKRxqQcGbIdWbnHsDKDa3u7nZ25tV8UOllylgHknGwz4m1TOEt0o/Cu9e5nElW8ktloiACU358gyqums/ZvSOdhwN3r/Luw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qUMW6Hbj; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7a34da58-874d-4271-9dbb-7991468d58ff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755680278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IEEqRTpCY494Z2w/6UzF2GroDTGA/QgdLl+vHg5gpWM=;
	b=qUMW6Hbj6XpyGTTHVacRcB0VNDElfP38acQxvpCBCvZDxpr6JIaa3vx9DWfjqG/5FKivrI
	RqR+lXLDft931IhrqBn0p+7Efk3WT0rnTMqj5MN7gHgyl9Dj+Zr/LghS3hdDZjK5bD9hLn
	eJCXsIae2gMiusK3+gUaUwmHUD5vdag=
Date: Wed, 20 Aug 2025 16:57:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] panic: Clean up message about deprecated 'panic_print'
 parameter
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Linux Memory Management List <linux-mm@kvack.org>,
 Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, paulmck@kernel.org, john.ogness@linutronix.de,
 kernel test robot <lkp@intel.com>, Feng Tang <feng.tang@linux.alibaba.com>
References: <aKRJKZHgcxyNF3y7@pathway.suse.cz>
 <202508200907.PsZ3geub-lkp@intel.com>
 <ae9bb2ea-c6e5-4a4b-ae25-aea1d6fe084d@linux.dev>
 <33a897b4-7d9a-4641-9c7a-07c19bb9cb6f@linux.dev>
In-Reply-To: <33a897b4-7d9a-4641-9c7a-07c19bb9cb6f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/8/20 09:56, Lance Yang wrote:
> 
> 
> On 2025/8/20 09:54, Lance Yang wrote:
>>
>>
>> On 2025/8/20 09:31, kernel test robot wrote:
>>> Hi Petr,
>>>
>>> kernel test robot noticed the following build errors:
>>>
>>>
>>>
>>> url:    https://github.com/intel-lab-lkp/linux/commits/ 
>>> UPDATE-20250819-180717/Feng-Tang/lib-sys_info-handle-sys_info_mask-0- 
>>> case/20250815-152131
>>> base:   the 3th patch of https://lore.kernel.org/ 
>>> r/20250815071428.98041-4-feng.tang%40linux.alibaba.com
>>> patch link:    https://lore.kernel.org/r/ 
>>> aKRJKZHgcxyNF3y7%40pathway.suse.cz
>>> patch subject: [PATCH] panic: Clean up message about deprecated 
>>> 'panic_print' parameter
>>> config: i386-buildonly-randconfig-004-20250820 (https:// 
>>> download.01.org/0day-ci/archive/20250820/202508200907.PsZ3geub- 
>>> lkp@intel.com/config)
>>> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 
>>> 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/ 
>>> archive/20250820/202508200907.PsZ3geub-lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new 
>>> version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild- 
>>> all/202508200907.PsZ3geub- lkp@intel.com/
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>>> kernel/panic.c:952:2: error: call to undeclared function 
>>>>> 'panic_print_deprecated'; ISO C99 and later do not support implicit 
>>>>> function declarations [-Wimplicit-function-declaration]
>>>       952 |         panic_print_deprecated();
>>>           |         ^
>>>     kernel/panic.c:958:2: error: call to undeclared function 
>>> 'panic_print_deprecated'; ISO C99 and later do not support implicit 
>>> function declarations [-Wimplicit-function-declaration]
>>>       958 |         panic_print_deprecated();
>>>           |         ^
>>>     2 errors generated.
>>
>>
>> Oops, panic_print_deprecated() is defined within the #ifdef
>> CONFIG_PROC_SYSCTL block, but it's also called from panic_print_set()
> 
> Correction:
> 
> CONFIG_SYSCTL block - sorry ;(
> 
>> and panic_print_get(), which are outside of that block.
>>
>> So, we need to move the definition out of the block to a common
>> scope where all its callers can see it. @Petr wdyt?
>>

If Petr is cool, @Andrew could you squash the following?

---
Subject: [PATCH 1/1] fixup: panic: clean up message about deprecated
  'panic_print' parameter

From: Lance Yang <lance.yang@linux.dev>

Moving the definition out of the CONFIG_SYSCTL block to a common scope
where all its callers can see it.

Reported-by: kernel test robot <lkp@intel.com>
Closes: 
https://lore.kernel.org/oe-kbuild-all/202508200907.PsZ3geub-lkp@intel.com/
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
  kernel/panic.c | 10 +++++-----
  1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index d3907fd95d72..24bca263f896 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -77,6 +77,11 @@ ATOMIC_NOTIFIER_HEAD(panic_notifier_list);

  EXPORT_SYMBOL(panic_notifier_list);

+static void panic_print_deprecated(void)
+{
+	pr_info_once("Kernel: The 'panic_print' parameter is now deprecated. 
Please use 'panic_sys_info' and 'panic_console_replay' instead.\n");
+}
+
  #ifdef CONFIG_SYSCTL

  /*
@@ -122,11 +127,6 @@ static int proc_taint(const struct ctl_table 
*table, int write,
  	return err;
  }

-static void panic_print_deprecated(void)
-{
-	pr_info_once("Kernel: The 'panic_print' parameter is now deprecated. 
Please use 'panic_sys_info' and 'panic_console_replay' instead.\n");
-}
-
  static int sysctl_panic_print_handler(const struct ctl_table *table, 
int write,
  			   void *buffer, size_t *lenp, loff_t *ppos)
  {
--
2.49.0


