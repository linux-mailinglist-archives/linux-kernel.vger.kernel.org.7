Return-Path: <linux-kernel+bounces-789755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE44DB39A01
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7FCA1C235CD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9457A30C61E;
	Thu, 28 Aug 2025 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="j+ikrmBE"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFB030C616
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377064; cv=none; b=gLqy5W4fC9W8uuZbTbOxtl0PP+VjMcGQ0ghZKXbURfRE/5Z+A2xJ7rkJWnfeDVCZE45Q3p4cdtukBgCb9WOV55K02QflA8fcOtH/GoC/m7GnM9f6HxGtXZmFP9l51s++tWiYJQUP+SQf/3nlJ5Uq+F54Zwxvl35W439SOghMC9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377064; c=relaxed/simple;
	bh=5Cm4Q5y6uqLhfWD3Jz701KdZsCnWtf0jsdufxtM3Nm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HaXFNLTtnOkorTyh93BOAHqh1OX6uWLA4MWOQQh7zfDBPyqLwSwTDqLLiVUXnex85+Zw5lj1qtTv8MvcWUdhJUHJYLGSE6UrTEPcwEO+V2YoRoDBF/2Cu6Uxr10yPdXsp49R8ILuOGCZAcbhqH0cIxRVfq5Lmcq0EJ1swOM5bv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=j+ikrmBE; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756377057; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=h3HUDLwwcHzYbAtlolpUh3esRybaOlr+CrGOLxJ95c8=;
	b=j+ikrmBEP8ZYhE+03wVw4upUAKWj1MJS1TvW+j3M7q2cishSwsbp0LV5QRKPC1yto7Q4ZBUuDAouICEztyOc1gIhS2kL2QmoFtnzpNerBIXCTyBux02zhzi5birIJXaUAhCgghRUfUnVghLQPZz38OBqeZ76QIzOB7UUHB0Ab0Q=
Received: from 30.74.128.191(mailfrom:tongweilin@linux.alibaba.com fp:SMTPD_---0Wmmy9ac_1756377056 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Aug 2025 18:30:57 +0800
Message-ID: <9a02a229-96da-45cc-a0fa-ae5344faa540@linux.alibaba.com>
Date: Thu, 28 Aug 2025 18:30:56 +0800
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
 <35e0a580-ae78-4485-b285-7f71f91e046d@linux.alibaba.com>
 <aLAj-itGT9DD3SU3@tiehlicka>
 <9639adfe-13ba-4c27-8ba6-8bf3e2190450@linux.alibaba.com>
 <aLAq5TaqdR7GQB6J@tiehlicka>
Content-Language: en-US
From: Weilin Tong <tongweilin@linux.alibaba.com>
In-Reply-To: <aLAq5TaqdR7GQB6J@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/8/28 18:09, Michal Hocko 写道:
> On Thu 28-08-25 17:48:54, Weilin Tong wrote:
>> 在 2025/8/28 17:40, Michal Hocko 写道:
>>> On Thu 28-08-25 17:23:40, Weilin Tong wrote:
>>>> 在 2025/8/28 14:45, Michal Hocko 写道:
>>>>
>>>>> On Thu 28-08-25 11:06:02, Weilin Tong wrote:
>>>>>> When min_free_kbytes is user-configured, increasing system memory via memory
>>>>>> hotplug may trigger multiple recalculations of min_free_kbytes. This results
>>>>>> in excessive warning messages flooding the kernel log if several memory blocks
>>>>>> are added in a short period.
>>>>>>
>>>>>> Sample dmesg output before optimization:
>>>>>> ...
>>>>>> [ 1303.897214] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
>>>>>> [ 1303.960498] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
>>>>>> [ 1303.970116] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
>>>>>> [ 1303.979709] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
>>>>>> [ 1303.989254] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
>>>>>> [ 1303.999122] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
>>>>>> [ 1304.008644] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
>>>>>> [ 1304.018537] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
>>>>>> [ 1304.028054] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
>>>>>> [ 1304.037615] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
>>>>>> ...
>>>>>>
>>>>>> Replace pr_warn() with pr_warn_once() to ensure only one warning is printed,
>>>>>> preventing large volumes of repeated log entries and improving log readability.
>>>>> pr_warn_once seems too aggressive as we could miss useful events. On the
>>>>> other hand I agree that repeating the same message for each memory block
>>>>> onlining is not really helpful. Would it make sense to only pr_warn when
>>>>> new_min_free_kbytes differs from the previous one we have warned for?
>>>> Thanks for your feedback!
>>>>
>>>> The dmesg output above comes from hotplugging a large amount of memory into
>>>> ZONE_MOVABLE, where new_min_free_kbytes does not actually change, resulting
>>>> in repeated warnings with identical messages.
>>> Yes, this is clear from the changelog
>>>
>>>> However, if memory is hotplugged into ZONE_NORMAL (such as pmem-type
>>>> memory), new_min_free_kbytes changes on each operation, so we still get a
>>>> large number of warnings—even though the value is different each time.
>>> We can check whether the value has changed considerably.
>>>
>>>> If the concern is missing useful warnings, pr_warn_ratelimited() would be an
>>>> acceptable alternative, as it can reduce log spam without completely
>>>> suppressing potentially important messages. However I still think that
>>>> printing the warning once is sufficient to alert the user about the
>>>> overridden configuration, especially since this is not a particularly
>>>> critical warning.
>>> The thing is that kernel log buffer can easily overflow and you can lose
>>> those messages over time, especially for system with a large uptime -
>>> which is far from uncommon.
>>>
>>> I am not entirely enthusiastic about rate limiting because that is time
>>> rather than even driven. Anyway, if you can make ratelimiting work for
>>> your usecase, then no objection from me but I would rather make the
>>> reporting more useful than hack around it.
>> I agree with your suggestion.
>>
>> With respect to your suggestion that “we can check whether the value has
>> changed considerably” I would like to seek your advice on how to define what
>> constitutes a significant change in this context. Do you have any
>> recommended criteria or thresholds for determining when a difference in
>> min_free_kbytes should trigger a warning?
> No really. Certainly increasing min_free_kbytes by 1% would be barely
> noticeable but 10% might show some difference. This will likely need to
> be tuned on real life usecases so start with something and we can tune
> that based on future usecases.
>
Understood, thank you for your suggestion.

I'm also looking forward to additional discussion and input from the 
community.


