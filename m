Return-Path: <linux-kernel+bounces-866042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 438CABFEC0C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 02:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67CDD4E6D84
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 00:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792D71A9F86;
	Thu, 23 Oct 2025 00:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="TVC9QOr9"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C86199230
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761179896; cv=none; b=VoJv1UGVne/h7OAPUPaM09DMnzBb8J10C8e/jIzN3dmG2x7pwq6ec3Yw52YIBYielFP1gCVzSb+JL1lPcX0hIgk0tJqGwDLsduqa1ENrvQ/EcfT8HdBhi6TQoZfhwleTOYuDP9sg6ECJmGEMm57Y6w4mWGshfizhfbDuifvG4Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761179896; c=relaxed/simple;
	bh=gQm6UZQMG9GuLC7rivGWh3/25mJ01qRv8OFC75ZAbWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLVJnQzqAtAlt++WnbLRJOr5h7NicYj9uxyd3ursh30j1s20RsBf0OVFj/Awxg1pTynjhIDHy3E++Msdct52y2hwEsaLOZ9mqs1p/z58AwDIXYjxMWiYlciFBF+Q0fXGW9FLc4Q+FLDF1djD83GC6HYq00FSI4qBOrMU5iHcCmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=TVC9QOr9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-273a0aeed57so18876285ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761179894; x=1761784694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZi117J1vBiwIo/cXocfBctHwFPx8c3ht9q0WpKQcrI=;
        b=TVC9QOr9Ih+0zIXt0btaSNwzHZivL1uEN5gaZO/GP5A8mKSSQqXq1TYr7c55VFZ0Q6
         I62CTHWTtJzDUJ/7gf7n9kxG4EdpyxeRGeFYamksxJe7ztbXP6XV0/+Jy/FtMFdNrcx8
         QAPm8zApYxws+YAfV3NZlE5zpra9hwNzz/QmKbm73PBbpo3Y2AihA5I1uxi4wzca71Mq
         hfQJgftmEOo9Kpx/SCnSTDzYuoiuZrB7FvFeqCJY39zPR+Ulmuoj8e242ZoGZKluVQsi
         wadXuqJUJsE8eGh1J2+WF8+3vxvmRllt8UvIxtWXMZyOqhIns4KxU+WEK/PRjtqBU7Wq
         ArIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761179894; x=1761784694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZi117J1vBiwIo/cXocfBctHwFPx8c3ht9q0WpKQcrI=;
        b=wCZSENklcoFAyhZoOnMCm7uIXySg96poiaJAxOB1vaLKFssL9zGpsZ4UPKrT/gzqXk
         gn2gElCpnh4blQoOyMcndoMvXu+n5iJsODQJZ7amLwYwGpvqZoOym5IG5WC3YB7XMT2/
         Ze3eg/8jqsygpu4lRSJLA3FjkJHwI/u7tJMmrb03Hbx+T5zQ9SU76tc9SMjNdpQ1V7zx
         awEkcomCLcbH5YzJ1nDiAALw7ohLNjibDmZtlwRGva6+vT8Jr+P1mFgcO/1EZ7aoHszD
         jS4QVWcXjR81REtigxF2uYu3slZj0+A+d8WhKVs1/UCmnA2hHO+lnS+h2X5zerkzpHay
         vR6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmYQeGwwN2/AwxtAt0vyIEuHnqbVmxLXTHFxC79y1yfiaCfiJELV6RRIZmg7tm1YZ5DVKg72blK8HHvFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0SQ0+8M/R9vWMGVJ35BtZzBAw3h2KwRyLIT1Cz8Rh0k471im/
	5LAU6sL6DUkaYsEZPcmMKmjO0t/AGmdcR5jROvkXy4wxBF8TdIIVMNI8qRYKGoT9UI/CmGk9qDN
	Reh3A
X-Gm-Gg: ASbGncs82Na4W5NGsRiuhBdtjqwbR4w5yq3E8Th4ryDCbWQnXoS5sbEeDY9xpsmlbgw
	Ew0WatTZZgbHexIYOxKszHml+OK2INuzqXsZIjmXlm3UCf9ov7j5eUSts3r2dypFRaC3LxnzS8o
	qV1AwGEo78Vkk1mq8lL5tpuntchuM1wY6p4pr+Cr4XsWnM1RSH21wyKmLz22nVYummBMaNES3Hv
	N7BoIDCWR6b7ORSrBMhajmN6Me9NMa4WKmH435cWayaZ59+BW8FCGke3fwjmzq10LmH6IzvfHU2
	+Wut2GozdV5HHM6K3jDgp0MyXkUBbqJ1zGQuk+ezUPVPlGkIXbqlF+iX7MDhc8Y98T5L8F/GgxI
	DoO8NgHIaVF07y72bNmEftZuzZl+dhn/kyUy0ZPZKzPEzEa6XT8hp+dgJ5kk8S3cEFT/HBOJ+zE
	WrFtKZFSuN5h8ECtfE7Fzp
X-Google-Smtp-Source: AGHT+IEWvdRIwpMP7FE0poYA69FglLzAR95069yydOr55gWBS8crCeiRws1bpCRtRXDuSgOcw3P9bA==
X-Received: by 2002:a17:902:d509:b0:269:8eba:e9b2 with SMTP id d9443c01a7336-292ffc97bfamr69040425ad.29.1761179894025;
        Wed, 22 Oct 2025 17:38:14 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda793esm4088985ad.5.2025.10.22.17.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 17:38:13 -0700 (PDT)
Date: Wed, 22 Oct 2025 17:38:11 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com,
	alexghiti@rivosinc.com, cleger@rivosinc.com, zong.li@sifive.com,
	valentin.haudiquet@canonical.com, jesse.huang@sifive.com,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH RFC] arch/riscv: add proc status (proc/<pid>/status)
Message-ID: <aPl48xlYTohtI648@debug.ba.rivosinc.com>
References: <20251020-proc_status-v1-1-59d2c8ccd4f0@rivosinc.com>
 <418119d5-4892-4697-a0ab-6a76302fea77@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <418119d5-4892-4697-a0ab-6a76302fea77@canonical.com>

Hi Hienrich,


On Tue, Oct 21, 2025 at 01:13:36PM +0200, Heinrich Schuchardt wrote:
>On 10/20/25 20:18, Deepak Gupta wrote:
>>x86 has proc/<pid>/status to see various runtime characteristics
>>of running task. Implement same for riscv. This patch implements
>>status for shadow stack and landing pad state.
>>
>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>---
>>This is just a one patch but sending it as RFC with cover letter to seek
>>feedback. x86 has `arch_proc_pid_thread_features` to enumerate status of
>>arch thread specific features on runtime. This can be done using prctl
>>as well but from quick/script perspective `cat /proc/<pid>/status` is more
>>desirable. In this patch, simply `arch_proc_pid_thread_features` is implemented
>>for riscv which queries shadow stack and landing pad state and reports back.
>>Thus it is dependent on riscv user cfi enabling series.
>
>Hello Deepak,
>
>This looks like a valuable addition.
>
>Shouldn't architecture specific fields be in
>/proc/<pid>/arch_status and not in /proc/<pid>/status?

Just following what x86 did. I believe shadow stack and landing pad are there
in arm64, x86 and riscv. So probably /proc/<pid>/status is best place.
>
>Please, add a documentation patch adding the RISC-V specific fields to
>"3.12  /proc/<pid>/arch_status - Task architecture specific information"
>in Documentation/filesystems/proc.rst.
>
>Should you stick to /proc/*/status, please, add the documentation to 
>Documentation/arch/riscv/.

Will do.

>
>>
>>If this patch itself is self-standing and good enough, I can roll this patch
>>as part of riscv user cfi enabling series.
>>
>>OR
>>
>>If there is ask for other riscv thread specific features that could be
>>enumerated in similar fashion, we will need it to be done as separate series
>>(with `thread_features` added to `thread_info`)
>>
>>Example output below.
>>
>>Name:   cat
>>Umask:  0022
>>State:  R (running)
>>Tgid:   133
>>Ngid:   0
>>Pid:    133
>>PPid:   129
>>TracerPid:      0
>>Uid:    0       0       0       0
>>Gid:    0       0       0       0
>>FDSize: 256
>>Groups: 0 10
>>NStgid: 133
>>NSpid:  133
>>NSpgid: 133
>>NSsid:  129
>>Kthread:        0
>>VmPeak:    10788 kB
>>VmSize:    10788 kB
>>VmLck:         0 kB
>>VmPin:         0 kB
>>VmHWM:      1400 kB
>>VmRSS:      1400 kB
>>RssAnon:             116 kB
>>RssFile:            1284 kB
>>RssShmem:              0 kB
>>VmData:       92 kB
>>VmStk:      8324 kB
>>VmExe:         4 kB
>>VmLib:      2312 kB
>>VmPTE:        40 kB
>>VmSwap:        0 kB
>>HugetlbPages:          0 kB
>>CoreDumping:    0
>>THP_enabled:    0
>>untag_mask:     0xffffffffffffffff
>>Threads:        1
>>SigQ:   0/31771
>>SigPnd: 0000000000000000
>>ShdPnd: 0000000000000000
>>SigBlk: 0000000000000000
>>SigIgn: 0000000000000000
>>SigCgt: 0000000000000000
>>CapInh: 0000000000000000
>>CapPrm: 000001ffffffffff
>>CapEff: 000001ffffffffff
>>CapBnd: 000001ffffffffff
>>CapAmb: 0000000000000000
>>NoNewPrivs:     0
>>Seccomp:        0
>>Seccomp_filters:        0
>>Speculation_Store_Bypass:       unknown
>>SpeculationIndirectBranch:      unsupported
>>Cpus_allowed:   3
>>Cpus_allowed_list:      0-1
>>Mems_allowed:   1
>>Mems_allowed_list:      0
>>voluntary_ctxt_switches:        0
>>nonvoluntary_ctxt_switches:     3
>>riscv_thread_features:  shstk_enabled lpad_enabled
>>riscv_thread_features_locked:   shstk_unlocked lpad_unlocked
>>---
>>  arch/riscv/kernel/Makefile     |  1 +
>>  arch/riscv/kernel/cpu/Makefile |  1 +
>>  arch/riscv/kernel/cpu/proc.c   | 28 ++++++++++++++++++++++++++++
>>  3 files changed, 30 insertions(+)
>>
>>diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>>index f60fce69b725..b32c11667d81 100644
>>--- a/arch/riscv/kernel/Makefile
>>+++ b/arch/riscv/kernel/Makefile
>>@@ -71,6 +71,7 @@ obj-y	+= vendor_extensions.o
>>  obj-y	+= vendor_extensions/
>>  obj-y	+= probes/
>>  obj-y	+= tests/
>>+obj-y	+= cpu/
>>  obj-$(CONFIG_MMU) += vdso.o vdso/
>>  obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
>>diff --git a/arch/riscv/kernel/cpu/Makefile b/arch/riscv/kernel/cpu/Makefile
>>new file mode 100644
>>index 000000000000..2b474fb49afe
>>--- /dev/null
>>+++ b/arch/riscv/kernel/cpu/Makefile
>>@@ -0,0 +1 @@
>>+obj-$(CONFIG_PROC_FS)			+= proc.o
>>diff --git a/arch/riscv/kernel/cpu/proc.c b/arch/riscv/kernel/cpu/proc.c
>>new file mode 100644
>>index 000000000000..4661190c43d1
>>--- /dev/null
>>+++ b/arch/riscv/kernel/cpu/proc.c
>>@@ -0,0 +1,28 @@
>>+// SPDX-License-Identifier: GPL-2.0
>>+#include <linux/smp.h>
>>+#include <linux/timex.h>
>>+#include <linux/string.h>
>>+#include <linux/seq_file.h>
>>+#include <linux/cpufreq.h>
>>+#include <linux/proc_fs.h>
>>+#include <asm/usercfi.h>
>>+
>>+#ifdef CONFIG_RISCV_USER_CFI
>>+
>>+void arch_proc_pid_thread_features(struct seq_file *m, struct task_struct *task)
>>+{
>>+	seq_puts(m, "riscv_thread_features:\t");
>>+	if (is_shstk_enabled(task))
>>+		seq_puts(m, "shstk_enabled ");
>
>According to Documentation/arch/x86/shstk.rst, x86 is avoiding the 
>'_enabled' postfix here:
>
>x86_Thread_features: shstk wrss

I can follow same and use `shstk`. We don't have `wrss` because
shadow stack is writeable by right instruction (sspush and ssamoswap) in
riscv.

>
>>+
>>+	if (is_indir_lp_enabled(task))
>>+		seq_puts(m, "lpad_enabled ");

Would you prefer similar here. Just "lpad"?

>>+
>>+	seq_putc(m, '\n');
>>+
>>+	seq_puts(m, "riscv_thread_features_locked:\t");
>>+	is_shstk_locked(task) ? seq_puts(m, "shstk_locked ") : seq_puts(m, "shstk_unlocked ");
>>+	is_indir_lp_locked(task) ? seq_puts(m, "lpad_locked ") : seq_puts(m, "lpad_unlocked ");
>
>Why do we need any entry for an unlocked feature in 
>riscv_thread_features_locked?

absence of "feature_locked" is considered unlocked, then I can drop it.

>
>Best regards
>
>Heinrich
>
>>+	seq_putc(m, '\n');
>>+}
>>+#endif /* CONFIG_RISCV_USER_CFI */
>>
>>---
>>base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
>>change-id: 20251017-proc_status-df1aedc85c7c
>>--
>>- debug
>>
>

