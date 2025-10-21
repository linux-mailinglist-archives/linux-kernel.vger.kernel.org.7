Return-Path: <linux-kernel+bounces-862713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBD5BF5F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B929188B298
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F01E2F1FEC;
	Tue, 21 Oct 2025 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="hIZQ5khV"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0430134AB
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045227; cv=none; b=nK9nqH3pQckEhRABFmYQ0pQpxbA9cDPbwqKnopFaIsSVVtALzkJsB/c1H/5Mz6MrPy+7LgBC8RwOK5KvxAFGPyc8d99RnHiokuJ5HUQ7rtYfmcH7NOZc13BVVOGVFHG9O1s2k7zVcz0GFPT2lbj51iSQKde7EsA5kT+kVXd6Cz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045227; c=relaxed/simple;
	bh=uw0CA7oFuxITLDZD/L/VOTAIizyG0JRsyPLP0XAL9lU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DwFWJ+5tzr3CGSRdqz/KTGCNW1UMRUEhUGr0TkyAmqFDRCWfK4aUnEcxhZXeUe7sEMCoP4WtCvn+euqyDr1DHi1FcwEG7QZ/x6ylcEG2OeAI6I3UkZUARWKTyelOsl7x+zw0/06wqm34uwzAKto/bbESjQiZhKgnCWbQIxcN9xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=hIZQ5khV; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1B5FC3F686
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1761045222;
	bh=ikcIzK7s67FNHE582ucGZVht5ku4GdzRhtqL5nJR72A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=hIZQ5khVcxCcCgjIY6yG3I48u6Wtxurgt2oGt694g+pnuSZMfxS5gRhIS1jSQlw81
	 xRkTXPRFx9glB+/UO1vXu4RjuFiLnksruBrbT1r/ygcJqmAX45Do3sXyJUIKxYzlSa
	 oOBK+U2PmRfT324g1msHF+vQrDy/RQEWs0Mg33yUMRmk/XEA7V56N1tBvvOhIeF7k7
	 rjXZ0J/Ab3q2O8dGU1clY1+150SZUc+VKiD9gfuTn9CzXEnBNZGsFlCOUlopqB5VX5
	 qWgyb4CCnhVoAj1KGAEDvaEuNijXLGxvE38UqOyMKyp6kmKRkkCE/wm7UjZgIHlIxQ
	 wC6qamhXAYbay3wFFXHDSNAdEGKu01dxgDv8bPBAscrwV6ZJQXQR/XH3R2YgHya2pz
	 nOvsrPkA+/LQro6h+2wpfeSvPUaQn59jePBfIT0EPOJbpksKj+WjOhcL183Sm23LmE
	 zsnRQSCYYTSqKGn0/pygO7IHpRyWbxdtB/pZuHb10oMVoWzXxDCKF/xiPDaRX2CTVn
	 U8UCaNQK2rao1MaL0YffU/60gJywb+IQXLbbRDqKIaZbFJfyXGKu2A6WdaPf9cJcww
	 MEXqajkSippsi7rjyK8Fr+GpWLkOoS1g+lvhP/Yr6nixqfUk7NE6WRdd+OE5U9P5jz
	 exsWM4y8KgQXeP8H6Cd7FxAQ=
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-470fd92ad57so111029285e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 04:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761045220; x=1761650020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ikcIzK7s67FNHE582ucGZVht5ku4GdzRhtqL5nJR72A=;
        b=LoN43wKigUZGLsAhgaADDmKJG4oDtr10HH6p1jIDWH0Ff9+pwheRXa8DEOItiUudIB
         UDpkvkdDQ8TJZKOnZMI6r/p0QsXCw61Pi1bBpuOol76haTIHBFWUJFy2YVFDe9p9bfL5
         TkQ+zSgaDi7jAgF38zG0X/Q9VPGbot+djW3dyzvWYPIkhFR4sYlGsHno4aofoxDH8tzY
         SoGQFzzNLrl+gU1xU0lHuotgOvNFx2YXjfP655tg7fOcEqttWBO+y70uePGcQOZkfP1U
         QRsNyyhM2O0UVPf9i78PJ0LeG4pABkC283OuL1XeCsvZAkhFYJC/ZDvOn2m36UooubcT
         Pyew==
X-Forwarded-Encrypted: i=1; AJvYcCUIxnZX1cuGCXHea6uaLzG+tkTRTq+PBNoTZ6OlATfpJFyo5psUonNKAzqvqCcS4OBdg2YM3Mu19Pr4wog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgt4T3algqXaDoWTuBeOdtyiIQ5WcP9X9u96g9vC73jKF4LpHz
	k7QLibsna/SU5zRg6pDEAsNKqbZvBnGMnM3ClLW99/sllkbqqnmkXJ0GXOcbW2Vw0QWAiqkrV9a
	L9Ky4/C3RoZlyNwZczW5kQHT5HoVdxTQiOLuXhIjVw0FUuE6kCVltlAX+qMA3vyZaMZzfWyZe9y
	nI6Ez4Ww==
X-Gm-Gg: ASbGnctATjbWd/bXc3TvGczpxcMePso58JFO3co8a9d0Fs8lDo7TJapKgn3+UQYHLrM
	VCPvR9a6Qs2aAvAZ5JfHuLWMUb7o7o+2NqASBAavandCfvf6U/W74AZCUjng+fhobzltO/8O6Rm
	IJLTT1Y7QfgjC3qS57uNLMlhAP4caldECseTs4P0fQ6FGXBAgUOGyx66pUtp1uEOQt/V52H+lLa
	wuwyySLpdKhMHeHP/BtdfZIVvStu3/7o5Yn92ewuX2cJfjvywRR4JkUzb6skJi6rl6Wee0MPe/o
	nWTmuO4SUprYi3BabEG9kwskR0INycit5frOUZ9jhCrVDtpc6QyCkSYcIDLvzwLQqbkRdgMV73t
	9RnFYkgZlLfweQLMrRpaFuvv9s77nVIylWWGPKD/jWUapllnkt87YtwN/eDwU8QH/Enk=
X-Received: by 2002:a05:600c:468b:b0:46e:4cd3:7d6e with SMTP id 5b1f17b1804b1-47117876a24mr123878545e9.9.1761045220286;
        Tue, 21 Oct 2025 04:13:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF12WpfWrU8b5X405jb6W3VuO4hxrcKC71Wzb1g7mzM71B00ZT2riB3oMBV7+2D+0OPaXkcSg==
X-Received: by 2002:a05:600c:468b:b0:46e:4cd3:7d6e with SMTP id 5b1f17b1804b1-47117876a24mr123878215e9.9.1761045219861;
        Tue, 21 Oct 2025 04:13:39 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:7f7c:5941:9cba:d029:72de? ([2a02:3035:6e0:7f7c:5941:9cba:d029:72de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47114423862sm279651695e9.1.2025.10.21.04.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 04:13:39 -0700 (PDT)
Message-ID: <418119d5-4892-4697-a0ab-6a76302fea77@canonical.com>
Date: Tue, 21 Oct 2025 13:13:36 +0200
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
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251020-proc_status-v1-1-59d2c8ccd4f0@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 20:18, Deepak Gupta wrote:
> x86 has proc/<pid>/status to see various runtime characteristics
> of running task. Implement same for riscv. This patch implements
> status for shadow stack and landing pad state.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
> This is just a one patch but sending it as RFC with cover letter to seek
> feedback. x86 has `arch_proc_pid_thread_features` to enumerate status of
> arch thread specific features on runtime. This can be done using prctl
> as well but from quick/script perspective `cat /proc/<pid>/status` is more
> desirable. In this patch, simply `arch_proc_pid_thread_features` is implemented
> for riscv which queries shadow stack and landing pad state and reports back.
> Thus it is dependent on riscv user cfi enabling series.

Hello Deepak,

This looks like a valuable addition.

Shouldn't architecture specific fields be in
/proc/<pid>/arch_status and not in /proc/<pid>/status?

Please, add a documentation patch adding the RISC-V specific fields to
"3.12  /proc/<pid>/arch_status - Task architecture specific information"
in Documentation/filesystems/proc.rst.

Should you stick to /proc/*/status, please, add the documentation to 
Documentation/arch/riscv/.

> 
> If this patch itself is self-standing and good enough, I can roll this patch
> as part of riscv user cfi enabling series.
> 
> OR
> 
> If there is ask for other riscv thread specific features that could be
> enumerated in similar fashion, we will need it to be done as separate series
> (with `thread_features` added to `thread_info`)
> 
> Example output below.
> 
> Name:   cat
> Umask:  0022
> State:  R (running)
> Tgid:   133
> Ngid:   0
> Pid:    133
> PPid:   129
> TracerPid:      0
> Uid:    0       0       0       0
> Gid:    0       0       0       0
> FDSize: 256
> Groups: 0 10
> NStgid: 133
> NSpid:  133
> NSpgid: 133
> NSsid:  129
> Kthread:        0
> VmPeak:    10788 kB
> VmSize:    10788 kB
> VmLck:         0 kB
> VmPin:         0 kB
> VmHWM:      1400 kB
> VmRSS:      1400 kB
> RssAnon:             116 kB
> RssFile:            1284 kB
> RssShmem:              0 kB
> VmData:       92 kB
> VmStk:      8324 kB
> VmExe:         4 kB
> VmLib:      2312 kB
> VmPTE:        40 kB
> VmSwap:        0 kB
> HugetlbPages:          0 kB
> CoreDumping:    0
> THP_enabled:    0
> untag_mask:     0xffffffffffffffff
> Threads:        1
> SigQ:   0/31771
> SigPnd: 0000000000000000
> ShdPnd: 0000000000000000
> SigBlk: 0000000000000000
> SigIgn: 0000000000000000
> SigCgt: 0000000000000000
> CapInh: 0000000000000000
> CapPrm: 000001ffffffffff
> CapEff: 000001ffffffffff
> CapBnd: 000001ffffffffff
> CapAmb: 0000000000000000
> NoNewPrivs:     0
> Seccomp:        0
> Seccomp_filters:        0
> Speculation_Store_Bypass:       unknown
> SpeculationIndirectBranch:      unsupported
> Cpus_allowed:   3
> Cpus_allowed_list:      0-1
> Mems_allowed:   1
> Mems_allowed_list:      0
> voluntary_ctxt_switches:        0
> nonvoluntary_ctxt_switches:     3
> riscv_thread_features:  shstk_enabled lpad_enabled
> riscv_thread_features_locked:   shstk_unlocked lpad_unlocked
> ---
>   arch/riscv/kernel/Makefile     |  1 +
>   arch/riscv/kernel/cpu/Makefile |  1 +
>   arch/riscv/kernel/cpu/proc.c   | 28 ++++++++++++++++++++++++++++
>   3 files changed, 30 insertions(+)
> 
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f60fce69b725..b32c11667d81 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -71,6 +71,7 @@ obj-y	+= vendor_extensions.o
>   obj-y	+= vendor_extensions/
>   obj-y	+= probes/
>   obj-y	+= tests/
> +obj-y	+= cpu/
>   obj-$(CONFIG_MMU) += vdso.o vdso/
>   
>   obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
> diff --git a/arch/riscv/kernel/cpu/Makefile b/arch/riscv/kernel/cpu/Makefile
> new file mode 100644
> index 000000000000..2b474fb49afe
> --- /dev/null
> +++ b/arch/riscv/kernel/cpu/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_PROC_FS)			+= proc.o
> diff --git a/arch/riscv/kernel/cpu/proc.c b/arch/riscv/kernel/cpu/proc.c
> new file mode 100644
> index 000000000000..4661190c43d1
> --- /dev/null
> +++ b/arch/riscv/kernel/cpu/proc.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/smp.h>
> +#include <linux/timex.h>
> +#include <linux/string.h>
> +#include <linux/seq_file.h>
> +#include <linux/cpufreq.h>
> +#include <linux/proc_fs.h>
> +#include <asm/usercfi.h>
> +
> +#ifdef CONFIG_RISCV_USER_CFI
> +
> +void arch_proc_pid_thread_features(struct seq_file *m, struct task_struct *task)
> +{
> +	seq_puts(m, "riscv_thread_features:\t");
> +	if (is_shstk_enabled(task))
> +		seq_puts(m, "shstk_enabled ");

According to Documentation/arch/x86/shstk.rst, x86 is avoiding the 
'_enabled' postfix here:

x86_Thread_features: shstk wrss

> +
> +	if (is_indir_lp_enabled(task))
> +		seq_puts(m, "lpad_enabled ");
> +
> +	seq_putc(m, '\n');
> +
> +	seq_puts(m, "riscv_thread_features_locked:\t");
> +	is_shstk_locked(task) ? seq_puts(m, "shstk_locked ") : seq_puts(m, "shstk_unlocked ");
> +	is_indir_lp_locked(task) ? seq_puts(m, "lpad_locked ") : seq_puts(m, "lpad_unlocked ");

Why do we need any entry for an unlocked feature in 
riscv_thread_features_locked?

Best regards

Heinrich

> +	seq_putc(m, '\n');
> +}
> +#endif /* CONFIG_RISCV_USER_CFI */
> 
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251017-proc_status-df1aedc85c7c
> --
> - debug
> 


