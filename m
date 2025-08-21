Return-Path: <linux-kernel+bounces-778766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ACCB2EABE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADA45C6240
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C592417F0;
	Thu, 21 Aug 2025 01:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOz7JSAO"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602D92AD0D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755740126; cv=none; b=GF6VamCY5Q66Cf1VZNkjJ7Vja0DLrrTjtyf2JrfBWTCAwSGuzjhcPd2CzAUYRLiXVl9iy9Ca9H0i0bjPGaVU6rUFs+qMclPIvip2r0MVGA15t87AucEzZAjHPKkTgpXtyt5B5DzKuKAWHOJD5GOHc6SslDCYWx8fzrmCFd0u04I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755740126; c=relaxed/simple;
	bh=gfCixLlJcRaSOkSy040l8xtqRBghjWbb37uc7NPEKlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HyTw/sF/W4Jc6l9CqsDOWcqEwF+pKswSinGabO7mo2UKZifTi2Tbc/Qm4FS8pQUMEEy6FOr9w3sI5dOQjz9l5g/ZuksweniBCErryPPDK/fsRw3om70P7q98o4K6X5DjjgskYe0P9ktcDWw3ovd4+TMbSABJJ4vpzoEIoEGYUTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOz7JSAO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2e89bebaso407266b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755740125; x=1756344925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ug/ZZsuCXPeqkvaweqf/sR1rVoR3Ypv6FddRa9JXTew=;
        b=VOz7JSAOfzrW/EkaOfI1r0/soYCg2prXrt3q22oqHlwoCQhhYAqOu/DApYOh52hV6u
         31Q56w+nagTEjptCZwHm/wI4vKZzCi156VmAYEtC41RKTt0hSJ/lpW2ZmBn0leI8o6wu
         bDnsSJnFA0uljFRfQkHJpNmgq75cMg2AXSt/icNebgHv1XPLqgK8z0i54DdiGQo9E8+P
         dDCnAYegByQGDnHOsCcAEqipire7IuQflEX3wmBw9zlCg2nHB8x2O9BwGUhwhtdeuE5E
         onX34N83wzdtissFFSYo/8MPatAyiC7nzXG1QRT5pwozF2KTLDDkOqpUtPGZMe4gwm1E
         ESCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755740125; x=1756344925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ug/ZZsuCXPeqkvaweqf/sR1rVoR3Ypv6FddRa9JXTew=;
        b=c192lBv0DC92sn5cVNuLSKXJOnAkMVe0mFcVn8Td1XmodXsj87Z3S0phXT/zjxSiDe
         rW3Qd+4ahSwtEUHXNOyxedn8EtvnYQDl1F4eQor0y+gANlXSnWIZEzyPpD1hf2RNdzwI
         rY8TuBD2wZtxFba36cqn2FUSzVqyzymkCl/SbWuddmJC38RlH6vaxAaTe2P3F50pZXvF
         nTUiePGaDImT8hhFZ7+wZy6REWyX2369w8hKjnRgSPTMGyGzP5bN+DD4jfNEpIwxBfFP
         OQDM2KjnfgqagVPArCEXaz4iXLWYIVG6D0PY3zP1ea3HKo3V6HI1vQBQLyb2yk/eshS3
         UTqA==
X-Forwarded-Encrypted: i=1; AJvYcCXiKPKk77PxnG4y6Ybn6SDcmwEI+tK7VfHJm37OHdfTv/Jyaxc1OSUAHqFR+7Y2iLra192un16eCbm3YA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF5bdLRmxehK2ybmxL6UlI0faGJSowscKHjm0lrCtOA/CUaWfS
	zgQ+ltxVxvYft3lOIWI6l2pLlyzyg/7xjg9vFo1MHTtm9PyjbfpSNDOb
X-Gm-Gg: ASbGncvY9HkNizOeNRDS+wJ7x1nnFbU2DbOaT1UQN9Sd9b8auFj2rGD2DLb7rYp/YLM
	PiMgLudXWaA/o+4odM1Cx7SHDUACosdrnNL6d74Mn9v8OYq0IAVG2By3ARa4OYLLv+soWCWqwft
	ALfXmhyaYBUwQkeviVKRdC0Tlpr86TS96zXGYhtsg60s/WGxeTvrYQctD1JUTDAO7KuVTXedkNp
	OU6a7YguAc3NrW9hbk0xkDmrJK6ngocXrrC/q7tVdwrhverJaGMubgR6n81ssCaIqf8vH6skqgN
	Is4UCi99iZxuVsloHvQUW7tRqOLYMOiStOUKZkCdZ+KuYORtY4DyiaKX5QfReBRK2neHGyRUKsz
	cqgDHfQw6qqwafvBMb11O90BYOAWd/QU=
X-Google-Smtp-Source: AGHT+IGI29xhYHjAtv9AeFB7XwRQl+/F2EZcOSsd57rYWJnYfil5XVRkWAdFKaB5TBHoBZ08AmEICQ==
X-Received: by 2002:a05:6a00:80e:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-76ea3240953mr854727b3a.18.1755740124493;
        Wed, 20 Aug 2025 18:35:24 -0700 (PDT)
Received: from [127.0.0.1] ([2403:2c80:17::10:40f3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d1492sm6612754b3a.23.2025.08.20.18.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 18:35:23 -0700 (PDT)
Message-ID: <b627609f-e5a3-4f7b-8ff9-fa40faf97d86@gmail.com>
Date: Thu, 21 Aug 2025 09:35:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] panic: call hardlockup_detector_perf_stop in panic
Content-Language: en-US
To: Petr Mladek <pmladek@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: John Ogness <john.ogness@linutronix.de>,
 Joel Granados <joel.granados@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Sravan Kumar Gundu <sravankumarlpu@gmail.com>,
 Ryo Takakura <takakura@valinux.co.jp>, linux-kernel@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20250730030638.65355-1-wangjinchao600@gmail.com>
 <aKSRzbUvuEkVz-Gk@pathway.suse.cz>
 <970366ee-0fc0-4a64-816e-3c3ac738e24a@gmail.com>
 <aKWh2R0ZVZ7nnLiw@pathway.suse.cz>
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <aKWh2R0ZVZ7nnLiw@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/25 18:22, Petr Mladek wrote:
> Adding Peter Zijlstra into Cc.
> 
> The nested panic() should return. But panic() was never supposed to
> return. It seems that it is not marked as noreturn but I am not sure
> whether some tricks are not hidden somewhere, in objtool, or...
> 
> On Wed 2025-08-20 14:22:52, Jinchao Wang wrote:
>> On 8/19/25 23:01, Petr Mladek wrote:
>>> On Wed 2025-07-30 11:06:33, Wang Jinchao wrote:
>>>> When a panic happens, it blocks the cpu, which may
>>>> trigger the hardlockup detector if some dump is slow.
>>>> So call hardlockup_detector_perf_stop() to disable
>>>> hardlockup dector.
>>>
>>> Could you please provide more details, especially the log showing
>>> the problem?
>>
>> Here's what happened: I configured the kernel to use efi-pstore for kdump
>> logging while enabling the perf hard lockup detector (NMI). Perhaps the
>> efi-pstore was slow and there were too many logs. When the first panic was
>> triggered, the pstore dump callback in kmsg_dump()->dumper->dump() took a
>> long time, which triggered the NMI watchdog. Then emergency_restart()
>> triggered the machine restart before the efi-pstore operation finished.
>> The function call flow looked like this:
>>
>> ```c
>> real panic() {
>> 	kmsg_dump() {
>> 		...
>> 		pstore_dump() {
>> 			start_dump();
>> 			... // long time operation triggers NMI watchdog
>> 			nmi panic() {
>> 				...
>> 				emergency_restart(); //pstore unfinished
>> 			}
>> 			...
>> 			finish_dump(); // never reached
>> 		}
>> 	}
>> }
>> ```
>>
>> This created a nested panic situation where the second panic interrupted
>> the crash dump process, causing the loss of the original panic information.
> 
> I believe that we should prevent the nested panic() in the first
> place. There already is the following code:
> 
> void vpanic(const char *fmt, va_list args)
> {
> [...]
> 	 * Only one CPU is allowed to execute the panic code from here. For
> 	 * multiple parallel invocations of panic, all other CPUs either
> 	 * stop themself or will wait until they are stopped by the 1st CPU
> 	 * with smp_send_stop().
> 	 *
> 	 * cmpxchg success means this is the 1st CPU which comes here,
> 	 * so go ahead.
> 	 * `old_cpu == this_cpu' means we came from nmi_panic() which sets
> 	 * panic_cpu to this CPU.  In this case, this is also the 1st CPU.
> 	 */
> 	old_cpu = PANIC_CPU_INVALID;
> 	this_cpu = raw_smp_processor_id();
> 
> 	/* atomic_try_cmpxchg updates old_cpu on failure */
> 	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
> 		/* go ahead */
> 	} else if (old_cpu != this_cpu)
> 		panic_smp_self_stop();
> 
> 
> We should improve it to detect nested panic() call as well,
> something like:
> 
> 	this_cpu = raw_smp_processor_id();
> 	/* Bail out in a nested panic(). Let the outer one finish the job. */
> 	if (this_cpu == atomic_read(&panic_cpu))
> 		return;
> 
> 	/* atomic_try_cmpxchg updates old_cpu on failure */
> 	old_cpu = PANIC_CPU_INVALID;
> 	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
> 		/* go ahead */
> 	} else if (old_cpu != this_cpu)
> 		panic_smp_self_stop();
> 
Agree with you.
Please see my patchset of "panic: introduce panic status function family"
https://lore.kernel.org/all/20250820091702.512524-1-wangjinchao600@gmail.com/

For this nested panic problem, see patch 9.

> 
>>> That said, it might make sense to disable the hardlockup
>>> detector during panic. But I do not like the proposed way,
>>> see below.
>>>
>>>> --- a/kernel/panic.c
>>>> +++ b/kernel/panic.c
>>>> @@ -339,6 +339,7 @@ void panic(const char *fmt, ...)
>>>>    	 */
>>>>    	local_irq_disable();
>>>>    	preempt_disable_notrace();
>>>> +	hardlockup_detector_perf_stop();
>>>
>>> Anyway, it does not look safe. panic() might be called in any context,
>>> including NMI, and I see:
>>>
>>>    + hardlockup_detector_perf_stop()
>>>      + perf_event_disable()
>>>        + perf_event_ctx_lock()
>>>          + mutex_lock_nested()
>>>
>>> This might cause deadlock when called in NMI, definitely.
>>>
>>> Alternative:
>>>
>>> A conservative approach would be to update watchdog_hardlockup_check()
>>> so that it does nothing when panic_in_progress() returns true. It
>>> would even work for both hardlockup detectors implementation.
>> Yes, I think it is a better solution.
>> I didn't find panic_in_progress() but found hardlockup_detector_perf_stop()
>> available instead :)
>> I will send another patch.
> 
> OK.
> 
> Best Regards,
> Petr


-- 
Best regards,
Jinchao

