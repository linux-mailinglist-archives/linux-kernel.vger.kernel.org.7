Return-Path: <linux-kernel+bounces-829476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD63B9728A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FDC319C3C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80AD2F9D86;
	Tue, 23 Sep 2025 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbMLXiTV"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F522F7477
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650606; cv=none; b=ZQOuF88aNTmjVM4td5aJi6fiof1cL1b2OJNsJHgmb1rtLSRa/mmcU8csoolPo3QcG2tIhN3icjRrZZK2xFGk2QcNE8xQRKLgdW1NDKSzOey9yuV9dlobKbW0BUV2FFwXY3EOeVJk2zF/d1bRX1+e9VpqqLpvF/HpItNg3SbzLt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650606; c=relaxed/simple;
	bh=oUN/dB6Hd4xqb9dUex4iSz2XqtprQCX3xex50HmbAEc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XQo6AeSTwCg5KBAmSNOfTlH2ygARcS75LRI6wBBlNVbDPvp0Me+p+Mbvo3yfmfqY/RsV06l6LGhqjJq8nghKOf1NnAAU/9+dTun8PKtNgTpAZ+jdYb2E66CxN/VnyPfHFzOISAXtsWGqfM21c9VujfTb1y6c7n0HwGU0fjgvBhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbMLXiTV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so14021675ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758650604; x=1759255404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=19tzoZHYNOC/V2f+ozUmR/P2PK0Vw1GmmrGvz3k+h2I=;
        b=JbMLXiTV/5KARnaXgRHwIjJhkjGKmVB5K32ct7Hcp1eigkep/hwPzXEuKZdwnl9fF/
         Ab6HuGVq96DTR46E/KOPb6gZeqqGetKXMqeDxQQ55kDJR1IqRrZmdgJcy+g7ZNjUnkQJ
         Pnzf4MfzbcyK2uCkcBE66OHmQtddXddRZL3WJdLUw6wUp4cE6w842KknWw1OAOLPzaA+
         R33eBERtNR1mavJ3Lm3yH+vrYz6Yp1/pz0sFP9ihAItkINKD4eFhX7kNUk711ml3Kehk
         oaPehx6PCvk23XQ79HqvCg2ogUk7S4Vx1gWpRRsOExAj59F3f2rPMweCEZ/n2rEtZbf/
         1BjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758650604; x=1759255404;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19tzoZHYNOC/V2f+ozUmR/P2PK0Vw1GmmrGvz3k+h2I=;
        b=X67aq5gCPgl15qHv6tTDBct0IZKW6mLPe3j+Z/4ARGPMZSGECR4QkLCIoHS+2G7pnZ
         4mlPaSBdAre0i9k5RBxd1Qa+xhwYpRinBCA34TR423bn+dITEg5aBGnbRmlg00IqVOSl
         72RF88qb0RgIuW4SM2lU+61FCftxqNoujdvnXptT4UPKLD8o+ps4933lGvZrlqDJZgsM
         3kvQ/H4q2fckNJpdokRS7eupN1be+DSYOx2DsC74bI/2k5sHWCuF6tgXMeI+7y2G+le5
         0m5AwcSRVZ0o1m1aLzAo12UvkCpMKr34iAZyMc65hdgBQwc9wtHD4YLuO42TRZAqzQrr
         QI0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnxXFJ5EyFe9UzGz4W/9SIexb8rwCjvm9nyk0EJd8HeLxKrO7PKOe7Bep4iADSdJdWMt+MJYvHgoH5Z1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRaNXCTMJNYcGxnSvOMNnA9WnkqvGtH43jEkS+29LpvFWUoFsE
	2SEO67e59KorunLAe81MRkv2Fym9qmqpWFPxR/yGqe8kIiLxylVePVD+
X-Gm-Gg: ASbGnctJmCTrsArVVWZBrr4EsMMbIx3mSC+MVCjnLnrwYKV7FZF4rsW+/EbxKQ6V6oD
	N63WCjFPtopwIc4BnIgWH00M/GZWBJ7hPDOWCmFf7ebuWw9sA0t3JDqwPz13LXeiFs6pNxOVEG7
	1Uz4iIECJCI6mUt8t5WojqeaxPhlwDK8hw7XHPqYQFKZP5fC4qLcow8qhd4BSyYQvkA2RqT1tsT
	L90BE7Wcgy20L/vCjRq4d8NJ+vCDElygUBP5pMpbQhutjzNnmYNXTDuaQT0zDkgN7hffJ2lK7DL
	+LaHcW5ShnjLtJR+6GNJ0n5hMPUNvRnVnj5dj23y4tqKECR0+4E2uX4R+7jMRFhBIU+7IgXcAys
	uYN25UgJX51dvPkZ3JzLgerpR/m0mmQ8XPoNqhw==
X-Google-Smtp-Source: AGHT+IEPZXVxTvQYVFWF/63TaN0wxmzYyWQOogj8xYSrHpWopNXMmB0k9UmB4Y7CeABL+enqE2uV7g==
X-Received: by 2002:a17:903:4b2d:b0:24c:c8e7:60b5 with SMTP id d9443c01a7336-27cc2101e4dmr45450955ad.16.1758650603459;
        Tue, 23 Sep 2025 11:03:23 -0700 (PDT)
Received: from [10.230.0.228] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2699363989fsm160895385ad.92.2025.09.23.11.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 11:03:23 -0700 (PDT)
Message-ID: <88998fa9-b454-45c1-a8e2-164d2e2d94c0@gmail.com>
Date: Tue, 23 Sep 2025 11:03:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/deadline: only set free_cpus for online
 runqueues
From: Doug Berger <opendmb@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org,
 Florian Fainelli <florian.fainelli@broadcom.com>
References: <20250815012236.4053467-1-opendmb@gmail.com>
 <aKMja4BvgQ5vFaNN@jlelli-thinkpadt14gen4.remote.csb>
 <20250903075436.GN3245006@noisy.programming.kicks-ass.net>
 <5bb8ad3a-9d05-4d07-8d4b-207be28cceb1@gmail.com>
Content-Language: en-US
In-Reply-To: <5bb8ad3a-9d05-4d07-8d4b-207be28cceb1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/2025 9:43 PM, Doug Berger wrote:
> On 9/3/2025 12:54 AM, Peter Zijlstra wrote:
>> On Mon, Aug 18, 2025 at 02:58:19PM +0200, Juri Lelli wrote:
>>> Hello,
>>>
>>> On 14/08/25 18:22, Doug Berger wrote:
>>>> Commit 16b269436b72 ("sched/deadline: Modify cpudl::free_cpus
>>>> to reflect rd->online") introduced the cpudl_set/clear_freecpu
>>>> functions to allow the cpu_dl::free_cpus mask to be manipulated
>>>> by the deadline scheduler class rq_on/offline callbacks so the
>>>> mask would also reflect this state.
>>>>
>>>> Commit 9659e1eeee28 ("sched/deadline: Remove cpu_active_mask
>>>> from cpudl_find()") removed the check of the cpu_active_mask to
>>>> save some processing on the premise that the cpudl::free_cpus
>>>> mask already reflected the runqueue online state.
>>>>
>>>> Unfortunately, there are cases where it is possible for the
>>>> cpudl_clear function to set the free_cpus bit for a CPU when the
>>>> deadline runqueue is offline. When this occurs while a CPU is
>>>> connected to the default root domain the flag may retain the bad
>>>> state after the CPU has been unplugged. Later, a different CPU
>>>> that is transitioning through the default root domain may push a
>>>> deadline task to the powered down CPU when cpudl_find sees its
>>>> free_cpus bit is set. If this happens the task will not have the
>>>> opportunity to run.
>>>>
>>>> One example is outlined here:
>>>> https://lore.kernel.org/lkml/20250110233010.2339521-1-opendmb@gmail.com
>>>>
>>>> Another occurs when the last deadline task is migrated from a
>>>> CPU that has an offlined runqueue. The dequeue_task member of
>>>> the deadline scheduler class will eventually call cpudl_clear
>>>> and set the free_cpus bit for the CPU.
>>>>
>>>> This commit modifies the cpudl_clear function to be aware of the
>>>> online state of the deadline runqueue so that the free_cpus mask
>>>> can be updated appropriately.
>>>>
>>>> It is no longer necessary to manage the mask outside of the
>>>> cpudl_set/clear functions so the cpudl_set/clear_freecpu
>>>> functions are removed. In addition, since the free_cpus mask is
>>>> now only updated under the cpudl lock the code was changed to
>>>> use the non-atomic __cpumask functions.
>>>>
>>>> Signed-off-by: Doug Berger <opendmb@gmail.com>
>>>> ---
>>>
>>> This looks now good to me.
>>>
>>> Acked-by: Juri Lelli <juri.lelli@redhat.com>
>>
>> So I just had a look at said patch because Juri here poked me; and I
>> came away with the feeling that cpudl_clear() is now a misnomen, seeing
>> how it is called from rq_online_dl().
>>
>> Would cpudl_update() be a better name?
> Thanks for taking a look.
> 
> I don't really have a dog in any fights over naming here, but it seems 
> to me that cpudl_clear and cpudl_set are intended to be complementary 
> functions and the naming reflects that. It would appear that these are 
> primarily intended to maintain the cpudl max-heap entries which is what 
> are being set and cleared.
> 
> rq_online_dl() would now call one or the other based on whether any 
> deadline tasks are running on the queue when it is onlined to ensure 
> that the max-heap is valid. This either clears a stale entry that may 
> occur from scenarios like the ones I'm running into or set the entry to 
> the current deadline. In this context the names seem appropriate to me.
> 
> Renaming cpudl_clear to cpudl_update may be more confusing since the 
> comment for cpudl_set reads "cpudl_set - update the cpudl max-heap".
> 
> I don't feel that the name change is relevant to my patch, but if we 
> want to do it concurrently maybe cpudl_clear_max_heap() and 
> cpudl_set_max_heap() would be more meaningful.
> 
> Please let me know how you would like to proceed,
>      Doug

Is there any way I can help to move this patch forward?

Thanks,
     Doug

