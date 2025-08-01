Return-Path: <linux-kernel+bounces-752782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C027B17AD1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 03:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA009189F031
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 01:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A39978F5D;
	Fri,  1 Aug 2025 01:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tsTglBGz"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B7F73451
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 01:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754011777; cv=none; b=Ib2bLf4HkY3NTv5vDQetMnTsGSDy6C0GAON1KVpcprUZv8DX3MFmDNaWo4j5/QC+OEB3pRRNoQESxKs2jO8sQfm+GzZ7QfPA88J9wBgJGslGy6M82Hf5DODaVjg7NKXIntYyKdwVkQLbqYlULMLDvl2S7qz+B9P4MjoTLsYDmbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754011777; c=relaxed/simple;
	bh=bgtmNrmGz0CNFTquJDzruC0P+qlOrhrEaOzu3SVJCeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EpUElJUpDsm/iFMnN8rXRra5ilnClPNrNjcO0Pn0fMBPATlrMeSnwnBvC8/vOu1oSKrcavuSOBstRNTgVjPxt7ZIJbUgUBGA/1Lb6dRM7+g5WsMCI4FqJMC0j5TUNxb2IXyy8ofTjlOIk7A5DKJGJJdxTJoHDOQe3b4diGsOvkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tsTglBGz; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4c39dd4f-0aab-47b5-8424-4e0f23221623@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754011763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlBrEOWBwp2LaUvEWBoldwdP4AZNXcY/+WkMid7j1KI=;
	b=tsTglBGz5o1X0rBNSU6dWl3EvM3PT7AtBJtkzraPB4HJaEi3NCMasCYUphTl49DWAVssva
	sK9wLscetmsNQFadxJkoOCYHNizcBLi1SfdbdXK8chsexT6VfaiFax07wsk0G7rEZUjjdQ
	3LuYGS7Lu85SBdkkRC2RPxKqSaB8ExQ=
Date: Fri, 1 Aug 2025 09:29:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] hung_task: fix objtool sibling call warning in
 watchdog()
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>
Cc: lkp@intel.com, akpm@linux-foundation.org, zi.li@linux.dev,
 llvm@lists.linux.dev, mhiramat@kernel.org, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250731023934.48840-1-lance.yang@linux.dev>
 <20250731175951.GC1455142@ax162>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20250731175951.GC1455142@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/8/1 01:59, Nathan Chancellor wrote:
> On Thu, Jul 31, 2025 at 10:39:34AM +0800, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> The kernel test robot reported an objtool warning on the loongarch
>> architecture with clang:
>>
>>          vmlinux.o: warning: objtool: watchdog+0x418: sibling call from
>> callable instruction with modified stack frame
>>
>> To resolve this, explicitly prevent the compiler from inlining or
>> performing a tail call on check_hung_uninterruptible_tasks() by marking
>> it with the noinline attribute. This ensures a standard function call
>> with a proper stack frame, satisfying objtool's validation requirements.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202507301256.cZlxQ10s-lkp@intel.com/
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> 
> While this may solve that particular instance of the warning, the fact
> there are many, many more with that configuration indicates that there
> will need to be a more generalized fix. I have started a separate thread
> with some LoongArch folks around this issue:

Thanks for the heads-up!

Yes, you're right, a more general fix is definitely the way to go.

I'll keep an eye on that thread and see how I can help ;)

Thanks,
Lance

> 
> https://lore.kernel.org/20250731175655.GA1455142@ax162/
> 
> Cheers,
> Nathan
> 
>> ---
>>   kernel/hung_task.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
>> index 8708a1205f82..a5b5a0a2c262 100644
>> --- a/kernel/hung_task.c
>> +++ b/kernel/hung_task.c
>> @@ -283,7 +283,7 @@ static bool rcu_lock_break(struct task_struct *g, struct task_struct *t)
>>    * a really long time (120 seconds). If that happens, print out
>>    * a warning.
>>    */
>> -static void check_hung_uninterruptible_tasks(unsigned long timeout)
>> +static noinline void check_hung_uninterruptible_tasks(unsigned long timeout)
>>   {
>>   	int max_count = sysctl_hung_task_check_count;
>>   	unsigned long last_break = jiffies;
>> -- 
>> 2.49.0
>>
>>


