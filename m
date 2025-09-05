Return-Path: <linux-kernel+bounces-801957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87297B44C10
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED23EAA1689
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 03:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C44F1F4177;
	Fri,  5 Sep 2025 03:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRxSTBtO"
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0C64C9D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 03:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757041291; cv=none; b=WHAYq8GsdHazE9MvNsw4dOgfzKr8t/tI8gylHjCx1DPiBbgFvQrKUGJw5ju0ykjcV7CP5YMBZOoDNsjZmoHUIpAk1W4YRIWMbLH5Bp4D4CdvnUJbA5Z3nXUH+DQtlIij1pwp6rNQmqQLHaV5e+MY8RyX0oEfs8qHIPBTGqpsgAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757041291; c=relaxed/simple;
	bh=JshA3FhxZ8kRoBaCcjUALcrRTy2VwvGy1q1/tU0wLUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WmCg7sEu1fasjYOXhG67XlFs2ge7Knv6XmYrme9scDWV/bvSve3d+5BH7vPjhZFvhKd7eScZE5gXeURJEtl8Bx3HWrmKZP7ZbZt80JD0DeUFIJEUUiSOUtb0QHDMlCv8fVQlHgkFaBizm/KgVxXsLlBDOaZaDNO71H6Iz+tArdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRxSTBtO; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b042eb09948so299468166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 20:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757041288; x=1757646088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S6u2xz+54NzXNZmLhnJHAQsw81jc60MzJ5jjVdPzKVY=;
        b=iRxSTBtONXu2JbXwwStKIbxA8iIwlA8CnkKHPDVD0pdRcE5sXjPjxHQY7dvAcKShR9
         Kjt6ft4hq57ZhQ9wJTly+xkFVmT3QtpNABRchyoxZ5d+3NO7XWPBpiIlNKjmL3c9sw2u
         zkV3clmM3d/f8YZ9s9a8dypJx2SstoJegEMnynuHTEmns9+3J9ii6i576WW42F9rNYzC
         05qukr76oPmgH0qDp0fTOb6Q1b4wWBfLdZ/nmiK0/bKBn+OBEYaxqyozAzUH8RbKlDrG
         WLPUiE1eRJR13jJhmzRidOLmtBimm0F4SMJVftXvjeeDLtIK6RqTr1kqp3/TxUprEacx
         vteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757041288; x=1757646088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6u2xz+54NzXNZmLhnJHAQsw81jc60MzJ5jjVdPzKVY=;
        b=Rp5KiPuS5a1KQfpgFdAjQABzB3DfKpt7g1SpvDL01cYLV+g5GjfXOLNaw0tauE2FPV
         L9DBtztxQ3kme8yerUbobXgY8sQRDiNWroMZIYMAN0XPiZLl7oc6zPZSLm8y5TRAHgR6
         WBwPMWo/q+BpxTInGBnxJXkR1//f2kDaTc6Fm3z4fe1K8Mhax1Pn3Ok0iaTVa9ndY3go
         579W5yp/lAzhw87h7gTHoVrR58os8JyQEU+CyHCJ/iTHAsZ8p9T9Ka7Ta2BXiqut6tvH
         5s8euOeRqiLHZeJEnl4pKjuMXIaemULohYr+n+uxq4gkqvRHpgwptOKOJOq9eU/oDsZA
         SACg==
X-Forwarded-Encrypted: i=1; AJvYcCWpneWHOK1JVKPipMHOTmqpB88AKDHhbppL/m9S0s16bVyCj7UxpioGQzSY438nKK6GZuMbmCxzR/5Kw8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSPionL0iF0At75Cs2TJIj5aFkTGe8FgwJtG599UM2W0B29o/y
	D0NhguKxBIEOAs7UuVYN2zE0WY0F9cfZGJfPwvc6u/sbEC3Kf7ivp2oEmPZRM74d
X-Gm-Gg: ASbGncvT5QFXKWDvj65cc2BoFYa8golymM+RdyrzejwPzqOLVyyJ71w+ia7plFQRnZs
	O8TcybaRtvZh8PBvBZ+zwegOhrSV8QhC6GGKHLMjXTYy1Rg9sOUl2eu8X9DP2qs/JeC3C0f5UrK
	UgIMuuM+XejzY5jgycKQLQDOuq/AIwiuC+2ER/AXBlT4+bCvkzYokjCZ0TVACZK3p9C0kKBcXC9
	Iji0EMlW0DsTzgyapLLRhp1+AHwUrE65OCW/byfescr/PLXLedpDWpsKAvM5OWGk1CYo/uKX4ss
	4LqWXagMwv2lB/0RgU94tNEW/JANOuRtsPrbqRvw2bKRAAhi5YqaKQMAlFfciJy4/ZhCX4eCEjS
	MuD5D5hUuLerU3CF+6wCVYK9WgSDAUVbA6UVd4Lm27BchHqIJagj0wjuIo+EEQOnWGwQZb3CuAu
	fYDFNabblaeGRAzBP1gulF9KiF4Iz8/Q==
X-Google-Smtp-Source: AGHT+IGh3hdK30S/YL4l4HM1rz04jGTmvxyO+hcYNkuoWRUXhBo3cYzizNTwUgflsZZ2zIqZ8rUzgQ==
X-Received: by 2002:a17:907:9409:b0:b04:74d1:a575 with SMTP id a640c23a62f3a-b0474d1b166mr723803666b.62.1757041287951;
        Thu, 04 Sep 2025 20:01:27 -0700 (PDT)
Received: from [26.26.26.1] (ec2-3-64-111-74.eu-central-1.compute.amazonaws.com. [3.64.111.74])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04323984ffsm1049904366b.64.2025.09.04.20.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 20:01:27 -0700 (PDT)
Message-ID: <5b97da51-fc3e-4584-92e8-404e64c91101@gmail.com>
Date: Fri, 5 Sep 2025 11:01:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: fix task_numa_migrate to consider both task
 and group benefits
To: Jianyong Wu <wujianyong@hygon.cn>
Cc: "jianyong.wu@outlook.com" <jianyong.wu@outlook.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250829085529.15686-1-wujianyong@hygon.cn>
 <72d087b8-1af1-44a6-88c4-04a9ff98f660@gmail.com>
 <4c57fcd55047412b9752aeba79f86dec@hygon.cn>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <4c57fcd55047412b9752aeba79f86dec@hygon.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/5/2025 10:14 AM, Jianyong Wu wrote:
> Hello Ethan,
> 
> Thanks for reply.
> 
> There is inconsistency between the comments and the code. See the discussion in an older patch here https://lkml.org/lkml/2015/6/16/540
The literal meaning of the comment appears somewhat misleading,
we always need to understand it combined with code context. or
needs more wording effort.

Thanks,
Ethan>
> Following that, the issue is with the comments, not the code.
> 
> Bests
> Jianyong
> 
>> -----Original Message-----
>> From: Ethan Zhao <etzhao1900@gmail.com>
>> Sent: Friday, September 5, 2025 9:13 AM
>> To: Jianyong Wu <wujianyong@hygon.cn>
>> Cc: jianyong.wu@outlook.com; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] sched/fair: fix task_numa_migrate to consider both task
>> and group benefits
>>
>>
>>
>> On 8/29/2025 4:55 PM, Jianyong Wu wrote:
>>> The comment indicates that when searching for a suitable NUMA node, we
>>> should ensure that the selected node benefits both the task and its
>>> NUMA group. However, the current implementation can only guarantee
>>> that either the task or the group benefits, but not necessarily both.
>>>
>>> Signed-off-by: Jianyong Wu <wujianyong@hygon.cn>
>>> ---
>>>    kernel/sched/fair.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c index
>>> b173a059315c..58c899738399 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -2568,7 +2568,7 @@ static int task_numa_migrate(struct task_struct
>> *p)
>>>    			/* Only consider nodes where both task and groups benefit
>> */
>>>    			taskimp = task_weight(p, nid, dist) - taskweight;
>>>    			groupimp = group_weight(p, nid, dist) - groupweight;
>>> -			if (taskimp < 0 && groupimp < 0)
>>> +			if (taskimp < 0 || groupimp < 0)
>> Perhaps you misunderstand the comment, && means either the task or the
>> group has NO benefit from this migration, it wouldn't be done.
>> But if you replace it with ||, you will ignore the target node that could benefit
>> either the task or the group.
>>
>> There is more logic to consider the benefit for both task & group in the later
>> function part.
>>
>> One question, why not
>> if (taskimp <= 0 && groupimp <= 0) ?
>>
>> Thanks,
>> Ethan
>>>    				continue;
>>>
>>>    			env.dist = dist;
>>
> 


