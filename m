Return-Path: <linux-kernel+bounces-789608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EA2B39827
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37E0E7A5122
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02C62D6E58;
	Thu, 28 Aug 2025 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="H/RUX6rv"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D9020B22
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756373029; cv=none; b=PwpczXhKPUsBb5l2lSqXpw+9fBX0o+xFlZ46/VuZQUbm5jubIIjP/t3hzcspT4n4F93HR0EoJBwaUyw20MgzzMZ2mdc8Gn+90GOdJttVaVRCxfXVCT36uk5STqjf/uqRY+OKX/EkVrU/x5PIBBBD90wXVtsgDHWEb5UW/Kcr+pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756373029; c=relaxed/simple;
	bh=gm7TKtJRm24E2PnvvzouJwhBGbVjm7/6uQ30vSTEMjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqRoO0q0LY/9JR71AVN4ClMnPaRfM8bfBkZ4hx/JhePFe3QKMMer7uDCqkYMYLK7vStnBHmCL8m+XluBjXpJThYM8RM0/7bdjRB9iS3oIYU/zhO4+FYrkW+4uyy9CrjrkCqj63TySJPh1BzpEUIq2usvRSYiLDbhPO39KneM31c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=H/RUX6rv; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756373022; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1KiEI/MNllscjBydiuZhBDQoXCblw/sdc1toMUg90I4=;
	b=H/RUX6rvkM9+1+xz6H6zWY92mIsTpxy533EnDFIaftBSnGOkDwY7cykM9tVkOw6TSWpvA3WTszirTRwtN4emoWucqqHNH96JRO6UHyVZEx10Dgx9b3PBIm1uJwHyc1Lf2Cv8QJVLl1z4/QgDlM0qxOtaPjrBiZ9/BqNgaLF1hJA=
Received: from 30.74.128.191(mailfrom:tongweilin@linux.alibaba.com fp:SMTPD_---0WmmiZOF_1756373021 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Aug 2025 17:23:41 +0800
Message-ID: <35e0a580-ae78-4485-b285-7f71f91e046d@linux.alibaba.com>
Date: Thu, 28 Aug 2025 17:23:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: Use pr_warn_once() for min_free_kbytes warning
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, vbabka@suse.cz,
 surenb@google.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com
References: <20250828030602.204332-1-tongweilin@linux.alibaba.com>
 <aK_7GKJ4BWjye4tZ@tiehlicka>
Content-Language: en-US
From: Weilin Tong <tongweilin@linux.alibaba.com>
In-Reply-To: <aK_7GKJ4BWjye4tZ@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/8/28 14:45, Michal Hocko 写道:

> On Thu 28-08-25 11:06:02, Weilin Tong wrote:
>> When min_free_kbytes is user-configured, increasing system memory via memory
>> hotplug may trigger multiple recalculations of min_free_kbytes. This results
>> in excessive warning messages flooding the kernel log if several memory blocks
>> are added in a short period.
>>
>> Sample dmesg output before optimization:
>> ...
>> [ 1303.897214] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
>> [ 1303.960498] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
>> [ 1303.970116] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
>> [ 1303.979709] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
>> [ 1303.989254] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
>> [ 1303.999122] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
>> [ 1304.008644] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
>> [ 1304.018537] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
>> [ 1304.028054] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
>> [ 1304.037615] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
>> ...
>>
>> Replace pr_warn() with pr_warn_once() to ensure only one warning is printed,
>> preventing large volumes of repeated log entries and improving log readability.
> pr_warn_once seems too aggressive as we could miss useful events. On the
> other hand I agree that repeating the same message for each memory block
> onlining is not really helpful. Would it make sense to only pr_warn when
> new_min_free_kbytes differs from the previous one we have warned for?
Thanks for your feedback!

The dmesg output above comes from hotplugging a large amount of memory 
into ZONE_MOVABLE, where new_min_free_kbytes does not actually change, 
resulting in repeated warnings with identical messages.

However, if memory is hotplugged into ZONE_NORMAL (such as pmem-type 
memory), new_min_free_kbytes changes on each operation, so we still get 
a large number of warnings—even though the value is different each time.

If the concern is missing useful warnings, pr_warn_ratelimited() would 
be an acceptable alternative, as it can reduce log spam without 
completely suppressing potentially important messages. However I still 
think that printing the warning once is sufficient to alert the user 
about the overridden configuration, especially since this is not a 
particularly critical warning.
>> Signed-off-by: Weilin Tong <tongweilin@linux.alibaba.com>
>> ---
>>   mm/page_alloc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index baead29b3e67..774723150e5b 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -6412,7 +6412,7 @@ void calculate_min_free_kbytes(void)
>>   	if (new_min_free_kbytes > user_min_free_kbytes)
>>   		min_free_kbytes = clamp(new_min_free_kbytes, 128, 262144);
>>   	else
>> -		pr_warn("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
>> +		pr_warn_once("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
>>   				new_min_free_kbytes, user_min_free_kbytes);
>>   
>>   }
>> -- 
>> 2.43.7

