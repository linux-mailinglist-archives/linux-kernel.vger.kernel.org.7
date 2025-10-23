Return-Path: <linux-kernel+bounces-866459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 019BCBFFCF7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6478F4F5B60
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C3E2EB874;
	Thu, 23 Oct 2025 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="sBZFuF3Y"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C676624634F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207081; cv=none; b=Z5qaFY75xAOlCirW1FpobCM0SYm5iljQz1LHougEXZRcQg4/y8dT05Ht8+92p64AqH2DwM5JOvbmJ0N+Va4sn2R8iaIcr9UhJvc0Z4mVNMwYkLiclv2vj5hdd/AW54CXYuZ16/A6W4i5JjNwWOUuM1baZyKEI7mpdBrHIHlKs0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207081; c=relaxed/simple;
	bh=CqszR/X5kq183GkKOLCTm1PeARC5U8LJBHyR+K0M6W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ol7DZLtnBs6b2yTzl4Xa4z0im/9kYHRrSqQEIh8/vhh8Ri6/VNOF8rZ+5/tAwFJifsGHtB9dxwqR7fmbNl1AFiuYe6DAEHXJIH5//yQw9dAoWxm/nGyEYFNW+hU81E4gF6CWb7s6+tR12O2Pq9eltLpDO8m1g/7wVoFn7zttp7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=sBZFuF3Y; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EA4F73FCD2
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1761207071;
	bh=Z5SN8O79YRYmCSSNpNrgkSyaMZl3w3aJ8IKWpZBuE5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=sBZFuF3YE+3GdkPQUKLxfm8aHe5BtvwG40TPeiivcf/EF0T6izLWB+iEegYzHc7JI
	 ohQFUY6UbVLZJSEwOixVFOiAR7JdDhCLJXCTmmlpRg3BmRGmnHEWnyMc1OBk2vc2ZP
	 Ypx+dPUzOQ1Eaf5kTy4A0YxfF09sXk4X7t7VkbBOO16fvHwRux+mJxT9EFhAupDp5E
	 GI3V8Zvpf+rSf7dHO1xEfhBjvhRtHIa2GBSpLrt4siAdrJ5Nrcm1LVPsCKoKgKE0oa
	 F9CixNps6ELVFAc/gwuQigtZAowB/VeuhQCoYm7e4gTrCwzabnVaJagXzVa7RuKvhS
	 24pQDGg2r6utsx7FdjKeJ9LglJONKXGgHNGGdOHTizn/obUMn3xjVDwA+IU8UTVNUU
	 Ag0XmytKrIJrcihfHt4wwx37HTO+Nvt1LWTNCztCeWsxK2jD3MVVohxeQmL60ZiK9C
	 qBU7Y/YiirnEhyRbAzebooRvVrC2k+6ZteXP2oizlI3thXTyhSTtylMU3GKoYRlaKk
	 RG7zrQ5a5KqPcyarIFrKrFxx82SqWb0iaIpo04CkIvrSel8m2rm/W+Ndn4Wr0HM3Av
	 gifP0UOwgJrc8Bucj+B+gamFURDtjsN/lP07WPe94bk6Uh77fWA93+M63bxm1WFleb
	 RIEu/8utCl2192MKjpJ/DoW4=
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46fa88b5760so1909775e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761207069; x=1761811869;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5SN8O79YRYmCSSNpNrgkSyaMZl3w3aJ8IKWpZBuE5c=;
        b=L1fyqDrotcL9qZ23DLdp028Mm2bAJ/Lhne7Z+3zKflA1AefakIrreoZhlku0tU7A8K
         z1hAnkCzwUIyLyVfAsgPo5YAQz0e+j4L7Nd4DhkcCpHRFnMJoyS5mKBHrZJE2sUH/+zF
         eTmP+kms6BzKaQk0uFjCzxmqHP2UVrdulIWetbc6Y3bMluC6iOGOoP2cxZ1QDAgTdcOQ
         vEo4sx1TdsnW7siHtCbLdLwrzZ1ns2dgnQimUMQYR5mmTLtEs0GLX0yHr/oBUma70L7U
         A5kounNk2SR1dX/AJhAa635ZohvdrLPBNiLkt1nCm52i+jboz1r/ng8IsNbkV2h5wxkw
         U44g==
X-Forwarded-Encrypted: i=1; AJvYcCVryT70pZN5421o/zr2dPVnlpnK7ol1Gc9q82ekHbh8lb3nHYaCxZV5oi0xRs5UWLNFNSV83ATscmzDKTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YymroZ+hHDDYvxc3kzyWtKPVhcYrXB0niFuEGZLkP6f8bqxtDdG
	qbLDuGJE57o+g4/diiEKyYV5gBoNlp8lvb1M8lzfhazneTI2J+r7TfmwuSX9JPSelb9jjE+6QIq
	ICtGYnuwShRe2GOtSPVT2MNff+QXo/LDBTrKTIIdy4URd5mSN6MZFlSkYgLZqBpbouIcL3aApWI
	A60mGZeg==
X-Gm-Gg: ASbGncvzXCLqjjKsZJVS7MMpMdhWVIF5c6Wb3bH+CtJ9x61DxvL2FoibAH+6c0JQjA2
	yTy4x5EgGX13545lLcawBtIk9vlbUJmGlISd9uEVQUNekuj8I9IQ5OGiim2bG567BqUvV54sEDT
	kKpvTtfiSyrYToPsUCaGHz38GNdbFO0/+wHZEeQlGOc2BGh1w7VIF8rxey4A0FYwV+KPcpowJrm
	/1/DMbro0Toe7bNEj+N7k1gNLVbJdRyaOi/9m0L1J8MGdKla7Mtf2430jw2UYW3oJsSv/tI4wcl
	rxv5NsdUkanaOsktjEA/UniAD3EdN6k6vBYtTWq0+rrdH+IsPGyEcjo8F3rZ9RrvtcSSBjsu9El
	CA7U0m/+YieW447cZChU3GOSkqtwfHnxNb9feeg0Y7AnKpD+6yJ+YUeE74F+yddw=
X-Received: by 2002:a5d:5c89:0:b0:3ec:d7c4:25b6 with SMTP id ffacd0b85a97d-42704d78abfmr17575451f8f.27.1761207069395;
        Thu, 23 Oct 2025 01:11:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4lM0Aosb5M4emD0MUgVZEES7YYuTxTxi5d+yu262Bbn7yJS0L3y2j+jUfDJDn0IFEpYEaXw==
X-Received: by 2002:a5d:5c89:0:b0:3ec:d7c4:25b6 with SMTP id ffacd0b85a97d-42704d78abfmr17575413f8f.27.1761207068944;
        Thu, 23 Oct 2025 01:11:08 -0700 (PDT)
Received: from ?IPV6:2a00:2381:43b9:32:c6f5:a3d6:39ca:b30e? ([2a00:2381:43b9:32:c6f5:a3d6:39ca:b30e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897f57b7sm2622170f8f.16.2025.10.23.01.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 01:11:08 -0700 (PDT)
Message-ID: <22b5f8d0-c2c1-4072-b311-5750c8c6a045@canonical.com>
Date: Thu, 23 Oct 2025 09:11:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] arch/riscv: add proc status (proc/<pid>/status)
To: Deepak Gupta <debug@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com,
 alexghiti@rivosinc.com, cleger@rivosinc.com, zong.li@sifive.com,
 valentin.haudiquet@canonical.com, jesse.huang@sifive.com,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
References: <20251020-proc_status-v1-1-59d2c8ccd4f0@rivosinc.com>
 <418119d5-4892-4697-a0ab-6a76302fea77@canonical.com>
 <aPl48xlYTohtI648@debug.ba.rivosinc.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <aPl48xlYTohtI648@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/23/25 01:38, Deepak Gupta wrote:
> Hi Hienrich,
> 
> 
> On Tue, Oct 21, 2025 at 01:13:36PM +0200, Heinrich Schuchardt wrote:
>> On 10/20/25 20:18, Deepak Gupta wrote:
>>> x86 has proc/<pid>/status to see various runtime characteristics
>>> of running task. Implement same for riscv. This patch implements
>>> status for shadow stack and landing pad state.
>>>
>>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>> ---
>>> This is just a one patch but sending it as RFC with cover letter to seek
>>> feedback. x86 has `arch_proc_pid_thread_features` to enumerate status of
>>> arch thread specific features on runtime. This can be done using prctl
>>> as well but from quick/script perspective `cat /proc/<pid>/status` is 
>>> more
>>> desirable. In this patch, simply `arch_proc_pid_thread_features` is 
>>> implemented
>>> for riscv which queries shadow stack and landing pad state and 
>>> reports back.
>>> Thus it is dependent on riscv user cfi enabling series.
>>
>> Hello Deepak,
>>
>> This looks like a valuable addition.
>>
>> Shouldn't architecture specific fields be in
>> /proc/<pid>/arch_status and not in /proc/<pid>/status?
> 
> Just following what x86 did. I believe shadow stack and landing pad are 
> there
> in arm64, x86 and riscv. So probably /proc/<pid>/status is best place.
>>
>> Please, add a documentation patch adding the RISC-V specific fields to
>> "3.12  /proc/<pid>/arch_status - Task architecture specific information"
>> in Documentation/filesystems/proc.rst.
>>
>> Should you stick to /proc/*/status, please, add the documentation to 
>> Documentation/arch/riscv/.
> 
> Will do.
> 
>>
>>>
>>> If this patch itself is self-standing and good enough, I can roll 
>>> this patch
>>> as part of riscv user cfi enabling series.
>>>
>>> OR
>>>
>>> If there is ask for other riscv thread specific features that could be
>>> enumerated in similar fashion, we will need it to be done as separate 
>>> series
>>> (with `thread_features` added to `thread_info`)
>>>
>>> Example output below.
>>>
>>> Name:   cat
>>> Umask:  0022
>>> State:  R (running)
>>> Tgid:   133
>>> Ngid:   0
>>> Pid:    133
>>> PPid:   129
>>> TracerPid:      0
>>> Uid:    0       0       0       0
>>> Gid:    0       0       0       0
>>> FDSize: 256
>>> Groups: 0 10
>>> NStgid: 133
>>> NSpid:  133
>>> NSpgid: 133
>>> NSsid:  129
>>> Kthread:        0
>>> VmPeak:    10788 kB
>>> VmSize:    10788 kB
>>> VmLck:         0 kB
>>> VmPin:         0 kB
>>> VmHWM:      1400 kB
>>> VmRSS:      1400 kB
>>> RssAnon:             116 kB
>>> RssFile:            1284 kB
>>> RssShmem:              0 kB
>>> VmData:       92 kB
>>> VmStk:      8324 kB
>>> VmExe:         4 kB
>>> VmLib:      2312 kB
>>> VmPTE:        40 kB
>>> VmSwap:        0 kB
>>> HugetlbPages:          0 kB
>>> CoreDumping:    0
>>> THP_enabled:    0
>>> untag_mask:     0xffffffffffffffff
>>> Threads:        1
>>> SigQ:   0/31771
>>> SigPnd: 0000000000000000
>>> ShdPnd: 0000000000000000
>>> SigBlk: 0000000000000000
>>> SigIgn: 0000000000000000
>>> SigCgt: 0000000000000000
>>> CapInh: 0000000000000000
>>> CapPrm: 000001ffffffffff
>>> CapEff: 000001ffffffffff
>>> CapBnd: 000001ffffffffff
>>> CapAmb: 0000000000000000
>>> NoNewPrivs:     0
>>> Seccomp:        0
>>> Seccomp_filters:        0
>>> Speculation_Store_Bypass:       unknown
>>> SpeculationIndirectBranch:      unsupported
>>> Cpus_allowed:   3
>>> Cpus_allowed_list:      0-1
>>> Mems_allowed:   1
>>> Mems_allowed_list:      0
>>> voluntary_ctxt_switches:        0
>>> nonvoluntary_ctxt_switches:     3
>>> riscv_thread_features:  shstk_enabled lpad_enabled
>>> riscv_thread_features_locked:   shstk_unlocked lpad_unlocked
>>> ---
>>>  arch/riscv/kernel/Makefile     |  1 +
>>>  arch/riscv/kernel/cpu/Makefile |  1 +
>>>  arch/riscv/kernel/cpu/proc.c   | 28 ++++++++++++++++++++++++++++
>>>  3 files changed, 30 insertions(+)
>>>
>>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>>> index f60fce69b725..b32c11667d81 100644
>>> --- a/arch/riscv/kernel/Makefile
>>> +++ b/arch/riscv/kernel/Makefile
>>> @@ -71,6 +71,7 @@ obj-y    += vendor_extensions.o
>>>  obj-y    += vendor_extensions/
>>>  obj-y    += probes/
>>>  obj-y    += tests/
>>> +obj-y    += cpu/
>>>  obj-$(CONFIG_MMU) += vdso.o vdso/
>>>  obj-$(CONFIG_RISCV_MISALIGNED)    += traps_misaligned.o
>>> diff --git a/arch/riscv/kernel/cpu/Makefile b/arch/riscv/kernel/cpu/ 
>>> Makefile
>>> new file mode 100644
>>> index 000000000000..2b474fb49afe
>>> --- /dev/null
>>> +++ b/arch/riscv/kernel/cpu/Makefile
>>> @@ -0,0 +1 @@
>>> +obj-$(CONFIG_PROC_FS)            += proc.o
>>> diff --git a/arch/riscv/kernel/cpu/proc.c b/arch/riscv/kernel/cpu/proc.c
>>> new file mode 100644
>>> index 000000000000..4661190c43d1
>>> --- /dev/null
>>> +++ b/arch/riscv/kernel/cpu/proc.c
>>> @@ -0,0 +1,28 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +#include <linux/smp.h>
>>> +#include <linux/timex.h>
>>> +#include <linux/string.h>
>>> +#include <linux/seq_file.h>
>>> +#include <linux/cpufreq.h>
>>> +#include <linux/proc_fs.h>
>>> +#include <asm/usercfi.h>
>>> +
>>> +#ifdef CONFIG_RISCV_USER_CFI
>>> +
>>> +void arch_proc_pid_thread_features(struct seq_file *m, struct 
>>> task_struct *task)
>>> +{
>>> +    seq_puts(m, "riscv_thread_features:\t");
>>> +    if (is_shstk_enabled(task))
>>> +        seq_puts(m, "shstk_enabled ");
>>
>> According to Documentation/arch/x86/shstk.rst, x86 is avoiding the 
>> '_enabled' postfix here:
>>
>> x86_Thread_features: shstk wrss
> 
> I can follow same and use `shstk`. We don't have `wrss` because
> shadow stack is writeable by right instruction (sspush and ssamoswap) in
> riscv.
> 
>>
>>> +
>>> +    if (is_indir_lp_enabled(task))
>>> +        seq_puts(m, "lpad_enabled ");
> 
> Would you prefer similar here. Just "lpad"?

That would be consistent with what is done for x86.

Best regards

Heinrich

> 
>>> +
>>> +    seq_putc(m, '\n');
>>> +
>>> +    seq_puts(m, "riscv_thread_features_locked:\t");
>>> +    is_shstk_locked(task) ? seq_puts(m, "shstk_locked ") : 
>>> seq_puts(m, "shstk_unlocked ");
>>> +    is_indir_lp_locked(task) ? seq_puts(m, "lpad_locked ") : 
>>> seq_puts(m, "lpad_unlocked ");
>>
>> Why do we need any entry for an unlocked feature in 
>> riscv_thread_features_locked?
> 
> absence of "feature_locked" is considered unlocked, then I can drop it.
> 
>>
>> Best regards
>>
>> Heinrich
>>
>>> +    seq_putc(m, '\n');
>>> +}
>>> +#endif /* CONFIG_RISCV_USER_CFI */
>>>
>>> ---
>>> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
>>> change-id: 20251017-proc_status-df1aedc85c7c
>>> -- 
>>> - debug
>>>
>>


