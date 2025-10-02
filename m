Return-Path: <linux-kernel+bounces-840685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A6CBB4F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 21:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C203C76E0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 19:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08F027BF85;
	Thu,  2 Oct 2025 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PZXzD5Zz"
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3C72765D0
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 19:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759432559; cv=none; b=L7Ijbvv9CoizQSGdY0iJYb2IneuuV/sLNSkkzQme3HMn/CsKN3UnUxo6nSPkMtpLsCXCUD4be0Cd87lybhhgONSrshzBSmv5qch6P4xyOzgheRdO71KjlcFElFWNEJGJ4ySeDtYv6Z0Pp7P64ArfawA2Idbu6qoH+7Cc+C7+WNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759432559; c=relaxed/simple;
	bh=+zUJ+V7AF6trwz+E0+m82ALZccwI8tHrx/4CY5UxghY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvY8FDafP5NyQcBi6ll1ppGCQjCK4M5u0anXDoz+bauwdfiNYhR1bncZIZlUUkJSYyw/7EZj4ZOa9q3cKSUUxysyyNrT9F4P/ukIbjynykz3oUpnUQZDi0FSEpUtHAqnF1+M8IkUvthL/iB9n+qjnIV+lUfoU7IWyLpDtCFBlE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PZXzD5Zz; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-30ccec59b4bso1072688fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 12:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759432557; x=1760037357;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBDs2bdcKRgqGyWIksvowQ1AGmCof5oVczYUtFLBDbw=;
        b=F/b+3IwKcJX1mrH4kkykDnlBMmqaYKYfbF7JhX/HbK3rPn6ZIbm8UU7Ti3+WjmRwP1
         VVfA2ObBc5bfV9N+WSJIOlr3GYe/oe92chEutWWNhl3/wEO7MxFqN2OssNF2LVxtEgvL
         b126f440GDIdwU13IMqGv2Ox68PfUC+J+LwF4PKX/vIHh5+gXsSO9i5y0bHoWaffLn5B
         IOt+QSfX/gjpy5+875FkOwkJmkoL/ROc7sXjyjUvnVnnyU5eV2fjHxspF+yw1Ihe5zbY
         J4tMvo9zE7MuCatNBDhpo2c5p/cKkXJIP57f93PThWU74mldiUyV5jmUqcpGvrkynAXw
         A5Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVeFi/xVvypGZtZ+ZHQ9iapzPVXpw+b6/OGoGZPGCWms4LEj9YxYshFUraQxdZWchzY+DUD3016WMoPZ4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt9Wc96eFxWS5Dfr40gEEID3uFTy6D164nCNli6DCyCCASyVmL
	lGPG5PqsBRY1XP5YT1JVpo8/IdySLH7Vi0EG4bo5f+GLwKLDfpqaeD1DNnO6X2/BfdjOipB3Sxd
	7XlHQ8mBd2l8iBLCXfxg7hJSYB44oGLTb+/K1ofUrvh8/gAF8N3o/Hm+fbuilK/KEWyL3605cYK
	bgn2Bqn7R+CMv3jDG/diofQh/yQ+eJqpInigFcjkaUMFmw4PpzUhpZalIqGNO1bsARJuUTvBmhq
	9XxeAI0Sh5Irqv9VFwhMqnD
X-Gm-Gg: ASbGncsN5oS33EsAyhNkpJ8djxJ3/yiYqCgplyJit1Z0vyGBrLodX0tbWPOn7AfDukY
	b9QP+huXJzOuLGSF/2QbPl/2aq8v/guYopRGLwhV7MhqnPcSafrm1RJ/6WdIUhbm+vaOZR7+kes
	A4xvPq5He8Zk9baEnGcPL7SBZuy7gEVquwrxcj3/UCthwe1/w1mwZetzxBFHQBimQD81kVt2Zhc
	6+7Vt/t4/opnoH8Swl4S3SaILqouetS1HqGgdEm4RqgL3zDu3SWgAAdTdUCyEW+Li0CWHpXhFsu
	T1SYWEpZs09osoiB4UPrr0+Fb7t0dyAeh/rE3VWEmOJm10OBOkTGJJZHwybDQCUHokfvphR2mrm
	OHi39bS58cm7aBShfrxlY6w6vxrn28zTrsBanlBDMHMQQk1rmtzFa3CI+bfb/Pcbx+oH8knIP80
	TYw+yARFV1GrD4
X-Google-Smtp-Source: AGHT+IHfjBc0jswHnwVQ/UlDH3cHPWESmuBabBcxJxRTvbFbEE9ruwF2OPcNXH+Tcq7BvF1MMvn8uhD5ksYm
X-Received: by 2002:a05:6871:413:b0:2eb:b6a2:8d77 with SMTP id 586e51a60fabf-3b0f90cfb5emr506489fac.29.1759432557207;
        Thu, 02 Oct 2025 12:15:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3ab94d9871csm247262fac.17.2025.10.02.12.15.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Oct 2025 12:15:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b557abaad02so1793058a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 12:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759432556; x=1760037356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YBDs2bdcKRgqGyWIksvowQ1AGmCof5oVczYUtFLBDbw=;
        b=PZXzD5ZzwBbONufZ5T/rYVv4QWfIc3mJjU2+z5mQJm7Kv+toGcNDN3Guj02Nd0Wtin
         Pe7Hk+3Ji5OfuvPq7CJyzeg78hnHjO2OB3HS7R6sSSJ/P1U3wnxAU3koGhM1xUfMy3J2
         ZySSF2U+ludsG60lXMuKhX8Ktk7K5mUTIE7lk=
X-Forwarded-Encrypted: i=1; AJvYcCWG6huut68esRn4FB+h77ZlZgYxSYExYP0g4tGZQO/GwMH/FO068TR14ZEiN4yEwMW3ifkh1lrz2YlfrMQ=@vger.kernel.org
X-Received: by 2002:a17:90b:4d05:b0:32e:a5c2:7f87 with SMTP id 98e67ed59e1d1-339c27878dfmr455741a91.22.1759432555833;
        Thu, 02 Oct 2025 12:15:55 -0700 (PDT)
X-Received: by 2002:a17:90b:4d05:b0:32e:a5c2:7f87 with SMTP id 98e67ed59e1d1-339c27878dfmr455712a91.22.1759432555353;
        Thu, 02 Oct 2025 12:15:55 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ebe5f2sm5650223a91.11.2025.10.02.12.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 12:15:53 -0700 (PDT)
Message-ID: <1051f4e7-49ca-4df3-94fc-8c866388d34e@broadcom.com>
Date: Thu, 2 Oct 2025 12:15:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/deadline: only set free_cpus for online
 runqueues
To: Doug Berger <opendmb@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20250815012236.4053467-1-opendmb@gmail.com>
 <aKMja4BvgQ5vFaNN@jlelli-thinkpadt14gen4.remote.csb>
 <20250903075436.GN3245006@noisy.programming.kicks-ass.net>
 <5bb8ad3a-9d05-4d07-8d4b-207be28cceb1@gmail.com>
 <88998fa9-b454-45c1-a8e2-164d2e2d94c0@gmail.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <88998fa9-b454-45c1-a8e2-164d2e2d94c0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 9/23/2025 11:03 AM, Doug Berger wrote:
> On 9/4/2025 9:43 PM, Doug Berger wrote:
>> On 9/3/2025 12:54 AM, Peter Zijlstra wrote:
>>> On Mon, Aug 18, 2025 at 02:58:19PM +0200, Juri Lelli wrote:
>>>> Hello,
>>>>
>>>> On 14/08/25 18:22, Doug Berger wrote:
>>>>> Commit 16b269436b72 ("sched/deadline: Modify cpudl::free_cpus
>>>>> to reflect rd->online") introduced the cpudl_set/clear_freecpu
>>>>> functions to allow the cpu_dl::free_cpus mask to be manipulated
>>>>> by the deadline scheduler class rq_on/offline callbacks so the
>>>>> mask would also reflect this state.
>>>>>
>>>>> Commit 9659e1eeee28 ("sched/deadline: Remove cpu_active_mask
>>>>> from cpudl_find()") removed the check of the cpu_active_mask to
>>>>> save some processing on the premise that the cpudl::free_cpus
>>>>> mask already reflected the runqueue online state.
>>>>>
>>>>> Unfortunately, there are cases where it is possible for the
>>>>> cpudl_clear function to set the free_cpus bit for a CPU when the
>>>>> deadline runqueue is offline. When this occurs while a CPU is
>>>>> connected to the default root domain the flag may retain the bad
>>>>> state after the CPU has been unplugged. Later, a different CPU
>>>>> that is transitioning through the default root domain may push a
>>>>> deadline task to the powered down CPU when cpudl_find sees its
>>>>> free_cpus bit is set. If this happens the task will not have the
>>>>> opportunity to run.
>>>>>
>>>>> One example is outlined here:
>>>>> https://lore.kernel.org/lkml/20250110233010.2339521-1- 
>>>>> opendmb@gmail.com
>>>>>
>>>>> Another occurs when the last deadline task is migrated from a
>>>>> CPU that has an offlined runqueue. The dequeue_task member of
>>>>> the deadline scheduler class will eventually call cpudl_clear
>>>>> and set the free_cpus bit for the CPU.
>>>>>
>>>>> This commit modifies the cpudl_clear function to be aware of the
>>>>> online state of the deadline runqueue so that the free_cpus mask
>>>>> can be updated appropriately.
>>>>>
>>>>> It is no longer necessary to manage the mask outside of the
>>>>> cpudl_set/clear functions so the cpudl_set/clear_freecpu
>>>>> functions are removed. In addition, since the free_cpus mask is
>>>>> now only updated under the cpudl lock the code was changed to
>>>>> use the non-atomic __cpumask functions.
>>>>>
>>>>> Signed-off-by: Doug Berger <opendmb@gmail.com>
>>>>> ---
>>>>
>>>> This looks now good to me.
>>>>
>>>> Acked-by: Juri Lelli <juri.lelli@redhat.com>
>>>
>>> So I just had a look at said patch because Juri here poked me; and I
>>> came away with the feeling that cpudl_clear() is now a misnomen, seeing
>>> how it is called from rq_online_dl().
>>>
>>> Would cpudl_update() be a better name?
>> Thanks for taking a look.
>>
>> I don't really have a dog in any fights over naming here, but it seems 
>> to me that cpudl_clear and cpudl_set are intended to be complementary 
>> functions and the naming reflects that. It would appear that these are 
>> primarily intended to maintain the cpudl max-heap entries which is 
>> what are being set and cleared.
>>
>> rq_online_dl() would now call one or the other based on whether any 
>> deadline tasks are running on the queue when it is onlined to ensure 
>> that the max-heap is valid. This either clears a stale entry that may 
>> occur from scenarios like the ones I'm running into or set the entry 
>> to the current deadline. In this context the names seem appropriate to 
>> me.
>>
>> Renaming cpudl_clear to cpudl_update may be more confusing since the 
>> comment for cpudl_set reads "cpudl_set - update the cpudl max-heap".
>>
>> I don't feel that the name change is relevant to my patch, but if we 
>> want to do it concurrently maybe cpudl_clear_max_heap() and 
>> cpudl_set_max_heap() would be more meaningful.
>>
>> Please let me know how you would like to proceed,
>>      Doug
> 
> Is there any way I can help to move this patch forward?

OK, so we are all busy and whatnot but the response time on this patch 
seems to be completely abysmal, and reminder that it fixes an actual bug 
that we have been running into on production systems. Can we just get it 
applied and move on?
-- 
Florian


