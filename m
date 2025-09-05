Return-Path: <linux-kernel+bounces-802025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DD5B44CDA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9991C28136
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6DA26F28F;
	Fri,  5 Sep 2025 04:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9ZKOONV"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112DC26CE35
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757047442; cv=none; b=Z5rO5EMMwz7hGgNTOui5r4AsRxp6qLp5WePt6m/jzFkTVE2UbNuFOxbf9+8sokbmEI+d04C2LX0RubqSWmWK7sZWjWORyz+uEfb6JDSKrZYyaDYhvl6/SYOyxGFJ+3cGmwqjVIjjCk01AaWibWPtAwfHr0obS0xVAOLM64QJaP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757047442; c=relaxed/simple;
	bh=/AIbGRcrKOzRkI52gIZR5a8HeHWAeQSVqbwHi8hTqFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuZOGMbT2TMzhI12jVfnLgdWn/LWtN8iCwgRkUDpq8gImHU+XdPJWiEP/MhLa8mnLvAxifHOqueSi96UXZ7fGev9V2lvVQhK2kl5ypI+Fj6luI5uVBL1HUXxym1/hHITn1F+MYSzCrWCAFmIdhBJt8eyiKaNfvQNY1CZxCWWnDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9ZKOONV; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8112c7d196eso32666185a.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 21:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757047440; x=1757652240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9wRXGIwGBL210dXSCyQFQQ9h1ubvOG81fQT01W5jExs=;
        b=j9ZKOONVg+2zoy4VVVGH6cmTltzSndOU0urtKJNF9nlS7HolbMOaDTUXc97h7o3Aqa
         gqHgDb4q70kz5WqOvVvWg/orem8bNTwyFNPfZ4Ge0CZ3hpYhBe+fmv37ida3lg1g10C4
         BV0lL/ddJ1uEpsbjvokoVVkn5+FfQAUwRRkBPIXfpmybkCrisOtOfjWOcDmFa+IJmhac
         Ndbf/PzL4WIvxQw1v6Y+a2MjyniGEL77rf+RjYDXeeXXfxGPtQ740ktKhc3zFkA1mf71
         pJKUeLvoyhT61uJogkF31s/xe8bMc9wpkJuP3C13pvsNhEX3S400EaupF7SyPFYjZUQp
         I8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757047440; x=1757652240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9wRXGIwGBL210dXSCyQFQQ9h1ubvOG81fQT01W5jExs=;
        b=AM/aTePUfw1MozSy8P6xm9TDuduLRqoNyKhn1pzpmUFdImhqit0VCHzGQHmrOTq88M
         BlZy85fNxYPXgHpPo2wPqgJrRQMYZGt/mQ+Smoo0gbZu+o4K2ogvCpvUGnb5E0qDIrEO
         JFzbpP0Tjapd6170ar+1E/SEcJovZhRwL04UXo8dbo2DlnbbjR2IXA7ePAfPEk76Vpx2
         0zwPR5/V6fu7WSwR25DpnDloYzrZHk0zDvfLxbelb0u4dxHXvHVy9cDudSQCWJmK1Q84
         bxy9F9Y9e/HKvTwmzldNZzumToQ+G6Ui4vM6JLCwq7dv7Qoso932qn/jRqRZK5xPbDLB
         DKZw==
X-Forwarded-Encrypted: i=1; AJvYcCU0Gp6aII3ze0mG6jEvRiejN3iTl8oIYilmfMTj5syZl7H2J7dSTwRQjXXgu4WK1rDLTlSFPSHZwlgKzYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLj1BLg+i80iPljEoUWjoyvBasAQNKxIyORl8RxBneMRo5rfoI
	3f8R4oGK6EhexLqQTk+vbyX71lb3UfnoxCP1q/z+pRm3DwPWpf4O93YH
X-Gm-Gg: ASbGnctdoL89KV/reMgcqhzV1+uzCG8NAbf1V5dEEXI7w6Kfi0mvztK0xFekOBNh1JT
	jajGgSq6qlcm9zNWGHDcwJG3++lRcdDDFnNnZko5sbYUXlroRSlteMMC2VFQ3f8dRNho+gkgXul
	HyqyBrvoMYZMq5cTC3ylL1irC5mhKBZRzm53mM7IBirAnUgaJLAUzKPviKiG0EjapxBKiGwwGS0
	E6bQkUAsDfr25tYRs2CiQ+v3lW5cba7dRwaPqROeR6JBOZH2kllXWQpNQE3x7g576KvQgWqvRuW
	YH1MyFohI2mMjN2bo4k1+lBomILlLHFpP/0H1HlStVa7/jMwdwdqjnX0pBo6yqcH9ubf3I6rg75
	YxLf5IZyDWGaCw+pwHJ0Q78F9g2NPlZGe8Zt8wnPTolSxEaaeHtM5hWGxyn396t+3sA==
X-Google-Smtp-Source: AGHT+IEejQNHfxWUYVYK/WqgipvlaC720EoLFvNjhLb8atpZwc6bjFE+eZEjY7RikYb3QOccyRGrQw==
X-Received: by 2002:a05:620a:190f:b0:810:3637:a161 with SMTP id af79cd13be357-8103646e5e2mr370778485a.2.1757047439884;
        Thu, 04 Sep 2025 21:43:59 -0700 (PDT)
Received: from [192.168.12.220] ([172.58.117.113])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aa62c70c4sm419463285a.9.2025.09.04.21.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 21:43:59 -0700 (PDT)
Message-ID: <5bb8ad3a-9d05-4d07-8d4b-207be28cceb1@gmail.com>
Date: Thu, 4 Sep 2025 21:43:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/deadline: only set free_cpus for online
 runqueues
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
Content-Language: en-US
From: Doug Berger <opendmb@gmail.com>
In-Reply-To: <20250903075436.GN3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/2025 12:54 AM, Peter Zijlstra wrote:
> On Mon, Aug 18, 2025 at 02:58:19PM +0200, Juri Lelli wrote:
>> Hello,
>>
>> On 14/08/25 18:22, Doug Berger wrote:
>>> Commit 16b269436b72 ("sched/deadline: Modify cpudl::free_cpus
>>> to reflect rd->online") introduced the cpudl_set/clear_freecpu
>>> functions to allow the cpu_dl::free_cpus mask to be manipulated
>>> by the deadline scheduler class rq_on/offline callbacks so the
>>> mask would also reflect this state.
>>>
>>> Commit 9659e1eeee28 ("sched/deadline: Remove cpu_active_mask
>>> from cpudl_find()") removed the check of the cpu_active_mask to
>>> save some processing on the premise that the cpudl::free_cpus
>>> mask already reflected the runqueue online state.
>>>
>>> Unfortunately, there are cases where it is possible for the
>>> cpudl_clear function to set the free_cpus bit for a CPU when the
>>> deadline runqueue is offline. When this occurs while a CPU is
>>> connected to the default root domain the flag may retain the bad
>>> state after the CPU has been unplugged. Later, a different CPU
>>> that is transitioning through the default root domain may push a
>>> deadline task to the powered down CPU when cpudl_find sees its
>>> free_cpus bit is set. If this happens the task will not have the
>>> opportunity to run.
>>>
>>> One example is outlined here:
>>> https://lore.kernel.org/lkml/20250110233010.2339521-1-opendmb@gmail.com
>>>
>>> Another occurs when the last deadline task is migrated from a
>>> CPU that has an offlined runqueue. The dequeue_task member of
>>> the deadline scheduler class will eventually call cpudl_clear
>>> and set the free_cpus bit for the CPU.
>>>
>>> This commit modifies the cpudl_clear function to be aware of the
>>> online state of the deadline runqueue so that the free_cpus mask
>>> can be updated appropriately.
>>>
>>> It is no longer necessary to manage the mask outside of the
>>> cpudl_set/clear functions so the cpudl_set/clear_freecpu
>>> functions are removed. In addition, since the free_cpus mask is
>>> now only updated under the cpudl lock the code was changed to
>>> use the non-atomic __cpumask functions.
>>>
>>> Signed-off-by: Doug Berger <opendmb@gmail.com>
>>> ---
>>
>> This looks now good to me.
>>
>> Acked-by: Juri Lelli <juri.lelli@redhat.com>
> 
> So I just had a look at said patch because Juri here poked me; and I
> came away with the feeling that cpudl_clear() is now a misnomen, seeing
> how it is called from rq_online_dl().
> 
> Would cpudl_update() be a better name?
Thanks for taking a look.

I don't really have a dog in any fights over naming here, but it seems 
to me that cpudl_clear and cpudl_set are intended to be complementary 
functions and the naming reflects that. It would appear that these are 
primarily intended to maintain the cpudl max-heap entries which is what 
are being set and cleared.

rq_online_dl() would now call one or the other based on whether any 
deadline tasks are running on the queue when it is onlined to ensure 
that the max-heap is valid. This either clears a stale entry that may 
occur from scenarios like the ones I'm running into or set the entry to 
the current deadline. In this context the names seem appropriate to me.

Renaming cpudl_clear to cpudl_update may be more confusing since the 
comment for cpudl_set reads "cpudl_set - update the cpudl max-heap".

I don't feel that the name change is relevant to my patch, but if we 
want to do it concurrently maybe cpudl_clear_max_heap() and 
cpudl_set_max_heap() would be more meaningful.

Please let me know how you would like to proceed,
     Doug

