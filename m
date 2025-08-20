Return-Path: <linux-kernel+bounces-777008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09710B2D401
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 698847B5A7C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BC7261B64;
	Wed, 20 Aug 2025 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBaQnzKc"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB5518A93F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755670985; cv=none; b=mrVWRnnf4k8Ss7oB+lLjHWaqtWqhwvrnoMBCWkxz9EJ19v0wN0NWS++30o+newbePBpE83/+imd4XUzVnMJZoxAI73kEW1/IPjgkcs9QrLWT4jerPklnaQIgoTcQOEW9HyQLa7cG+VqJuWS0vVGhfvaoZK7K88Xle1Kn5mftVrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755670985; c=relaxed/simple;
	bh=boOusmaYByKP5jxMW9KTEZu45SyWQ5YnzJ5l7DVR+DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3csE6VU29Xc9+owVeFBaxs6RM9Z0yE+0ySNrGSihqbIXMUP/LSMN+AIP+YtJnvO5YwCVPVHFoj72OOxE1yR2kx+6l2BRl86wWKubujquCFA5X7bi8BbEw0agKvH2hjcN3CXpkvMPvTcojdmHBYK+4SKtkuhwMOQMoklr96kTng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBaQnzKc; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2e8aff06so4791957b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755670983; x=1756275783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ow7o4zEBrDv+M/VPxOP9Kk65hdCSfAHOCcmPOMKRc1w=;
        b=VBaQnzKcWSfcAO/evZiYy9zVIEDSFw2B536lwz7gJUtIiLFrtPatMlPEgBRHpB/b88
         wEsgQz0sm6fqARK/20DI2yB8z3l3WNe0AYpnBGKfhuYUkSXFZW7Ijk2xlutKsGtB/07b
         16d338STNjq2a2iOIaUrBw3fYw7My8vMNq1ksC57gOvMVQyQr+ET5DsI5FG2j7QUs7OG
         dzs4XaWJVkUnM3TT0kBIcyCrl8sf1c3Kbf3K2kc+G81Gq0VE6ffzX564iZKB9CBm57Zp
         zqUJoOCHiSbB2auUQgbt2pUGtMAcW0FPYl7aua0fND2IcQdyBTmyb3ZO38g7RYjQnujt
         EJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755670983; x=1756275783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow7o4zEBrDv+M/VPxOP9Kk65hdCSfAHOCcmPOMKRc1w=;
        b=pvly0bI/CeNC9y6SD7Vq4AQY1huruYiP+lYuRsjvZZ+hhex0PmxoPjucZAUBsLYScL
         tkNU6WomZKaUXn26n7/WHV7Ir7mI3pKvmxBXnhGNN6VE8tvSTGh+8w+3x8QXgEurwwB4
         5U27KFlAQrBhFIDCgVALC6pQfLgkmdJ6vp/7pc4Ks0ouJkcR0c0nZN0y8jQF1peDWgXA
         tLKFNQh2xJwoi0fy62d9FoDFuUtGbMRI2SrrhvZ9Kr0bBzRmi6IBEqVlS+17rKOPHFFg
         R7LW7Ca/Yoi0gPEVIJB0gHgG5xrMpa+m2jdZxO/hbfcupR6aCwVlAJxIcDxp/WFBvmJf
         Z5xA==
X-Forwarded-Encrypted: i=1; AJvYcCVb54G36OyvCgJRVKiDBThmm+6cYbxOD3IVh9eIbNXkdh7xBFfCZMx+GvAHxSX997JmVzh4onkokJnQBsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy61IwQzfYUSYdyVBx0CV2ur+qgeJq3YFkC6SmRM6c3xvDRe5S3
	C+Pckump4te29Z/06ZaLjc0bU52IHBl+mawmKUioWusNiSWpYa7MN0xO
X-Gm-Gg: ASbGncvlmZCxDHGAtC3bFMzjndUuIBRhzacstgZ72wRzGBQ7YvG3nzCyzenri34DVYs
	+LXCQSksIA5TUx7b5KdoyXZYQF4a4XGYpfVMNFs3kG2NO+cwK/Gg5PQxhYxsYlQ0jukn/Powi9O
	daKlSr2r2HcNTaJ8pr7C5dt4QiqaWunhwWZZgH3AA9WajuwO5WubOSmVOY9N8eVwjtybOuLhq7f
	BZDqwqgBez4Cy1XVnJpq4933fimJSzu2QVFpRs7sBZq4n27nCCHbosNYQaoI7R5IZHfu4UmuUCe
	Ipj6UMjW6YhmUoOWdRjMleks6UzlrzqaXc1VEEUI8kmpb9d6vCVIydoHzXo01ehtF3viu6CBkkw
	HQO5nxMnTlbhG86zXXtme
X-Google-Smtp-Source: AGHT+IGa+NWabu0A5audCLbSTBwIgJVkA9VdSKrmVElbhihveAIkz6BPHtz+JeANK9Imn2c411Gcjg==
X-Received: by 2002:a05:6a00:180c:b0:76b:6288:e2e7 with SMTP id d2e1a72fcca58-76e8dcef2c2mr2102089b3a.20.1755670983083;
        Tue, 19 Aug 2025 23:23:03 -0700 (PDT)
Received: from [127.0.0.1] ([2403:2c80:6::3058])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d524c88sm4339590b3a.76.2025.08.19.23.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 23:23:02 -0700 (PDT)
Message-ID: <970366ee-0fc0-4a64-816e-3c3ac738e24a@gmail.com>
Date: Wed, 20 Aug 2025 14:22:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] panic: call hardlockup_detector_perf_stop in panic
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Joel Granados <joel.granados@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Sravan Kumar Gundu <sravankumarlpu@gmail.com>,
 Ryo Takakura <takakura@valinux.co.jp>, linux-kernel@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20250730030638.65355-1-wangjinchao600@gmail.com>
 <aKSRzbUvuEkVz-Gk@pathway.suse.cz>
Content-Language: en-US
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <aKSRzbUvuEkVz-Gk@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/25 23:01, Petr Mladek wrote:
> On Wed 2025-07-30 11:06:33, Wang Jinchao wrote:
>> When a panic happens, it blocks the cpu, which may
>> trigger the hardlockup detector if some dump is slow.
>> So call hardlockup_detector_perf_stop() to disable
>> hardlockup dector.
> 
> Could you please provide more details, especially the log showing
> the problem?

Here's what happened: I configured the kernel to use efi-pstore for kdump
logging while enabling the perf hard lockup detector (NMI). Perhaps the
efi-pstore was slow and there were too many logs. When the first panic was
triggered, the pstore dump callback in kmsg_dump()->dumper->dump() took a
long time, which triggered the NMI watchdog. Then emergency_restart()
triggered the machine restart before the efi-pstore operation finished.
The function call flow looked like this:

```c
real panic() {
	kmsg_dump() {
		...
		pstore_dump() {
			start_dump();
			... // long time operation triggers NMI watchdog
			nmi panic() {
				...
				emergency_restart(); //pstore unfinished
			}
			...
			finish_dump(); // never reached
		}
	}
}
```

This created a nested panic situation where the second panic interrupted
the crash dump process, causing the loss of the original panic information.
> 
> I wonder if this is similar to
> https://lore.kernel.org/all/SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com/
> 
> There was a problem that a non-panic CPU might get stuck in
> pl011_console_write_thread() or any other con->write_thread()
> callback because nbcon_reacquire_nobuf(wctxt) ended in an infinite
> loop.
> 
> It was a real lockup. It has got recently fixed in 6.17-rc1 by
> the commit 571c1ea91a73db56bd94 ("printk: nbcon: Allow reacquire
> during panic"), see
> https://patch.msgid.link/20250606185549.900611-1-john.ogness@linutronix.de
> It is possible that it fixed your problem as well.
> 
> That said, it might make sense to disable the hardlockup
> detector during panic. But I do not like the proposed way,
> see below.
> 
>> --- a/kernel/panic.c
>> +++ b/kernel/panic.c
>> @@ -339,6 +339,7 @@ void panic(const char *fmt, ...)
>>   	 */
>>   	local_irq_disable();
>>   	preempt_disable_notrace();
>> +	hardlockup_detector_perf_stop();
> 
> I see the following in kernel/watchdog_perf.c:
> 
> /**
>   * hardlockup_detector_perf_stop - Globally stop watchdog events
>   *
>   * Special interface for x86 to handle the perf HT bug.
>   */
> void __init hardlockup_detector_perf_stop(void)
> {
> [...]
> 	lockdep_assert_cpus_held();
> [...]
> }
> 
> 1. It is suspicious to see an x86-specific "hacky" function called in
>     the generic panic().
> 
>     Is this safe?
>     What about other hardlockup detectors?
> 
> 
> 2. I expect that lockdep_assert_cpus_held() would complain
>     when CONFIG_LOCKDEP was enabled.
> 
> 
> Anyway, it does not look safe. panic() might be called in any context,
> including NMI, and I see:
> 
>   + hardlockup_detector_perf_stop()
>     + perf_event_disable()
>       + perf_event_ctx_lock()
>         + mutex_lock_nested()
> 
> This might cause deadlock when called in NMI, definitely.
> 
> Alternative:
> 
> A conservative approach would be to update watchdog_hardlockup_check()
> so that it does nothing when panic_in_progress() returns true. It
> would even work for both hardlockup detectors implementation.
Yes, I think it is a better solution.
I didn't find panic_in_progress() but found 
hardlockup_detector_perf_stop() available instead :)
I will send another patch.

> 
> Best Regards,
> Petr


-- 
Best regards,
Jinchao

