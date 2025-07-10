Return-Path: <linux-kernel+bounces-726175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B263B00907
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC2F174DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FA12F0042;
	Thu, 10 Jul 2025 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CEBLDZTe"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568052EF9DE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165607; cv=none; b=uc35dorR4EpbMTsNZzB8cexFFYnu4HzPUTuFgqaALH5JG+mV4nXnlXYKINvUEqt6jwZW57Ye8moDltZQl4D/xVdwYQxMrhEzNQ40eMRnA7ruKVQSzcCYrBDUDsyylFwzvzaO9ifKfIL1CX9WP98FI7+wth3io5JX7hSI6AIJ0Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165607; c=relaxed/simple;
	bh=2mVD105ELfyiZ3Icw9b4TIbfswMnLBIA2fWIJ6fXAOk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=CqX6gg0WM0/QFdvQsLIM56068Caa4D6XIJWcMktJ/G0KU8kR36LdL4/hsyqNskMxirhTMjrInH6aqFxkJN1TVQZN+9vag1avW4x8V8hgoMva9c1uNq2FpLtCKLE1dfdAY6wnYpaAifSb4w/C9xbMXPqPJEkJlM0UkWnr+Z4jSfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CEBLDZTe; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a577f164c8so88063f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752165603; x=1752770403; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nrn4nfiPG+tAqCMVAZ7jqIn9oEnuj7dwUbTTAq45dGg=;
        b=CEBLDZTefSIlRkHYo3bdsW6wdcMdx619Afz7sRIf4y2ZCXnsbYH6I1NarAFx0+zeqS
         8esCPDIIIsy50VTfHEUXIS++tKMxf1xr6J11iugYAStpyBQGqky7FS0H/dF0Es/KHAqr
         6fw9MZaaEWHlALqZWz+yJjPU2B+UGOiarQGLz6tv13/dhUZTS2zRHc8rAkN8h2r53RWm
         qU10FfZVpGuHsilPTW+fzSDXUwtxKkeuHiJT2DX77syBRoKutkuqcF+XT1JIIfTXQvF4
         t33d9C5p2lQc1ADF/likb7iZhuTwZrLf5Px2XLy/J4dtm0Dg7S4JOpo66yINDrluYKDa
         lWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752165603; x=1752770403;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nrn4nfiPG+tAqCMVAZ7jqIn9oEnuj7dwUbTTAq45dGg=;
        b=KQejV72swMCNkq7Z16ezVvnnO9hD7S1BGqvzfgkyWSj3maEhpv9+fgDFMb9U89lGfO
         Rwy3fMlzobixPj9jTpl73JRieSr0585BdQKebLEG6Fxf6deBdGZv3dUQUbcP7CVEVq+k
         3q+KkSsmt7TGsg+fXMhjFsGJUclXSFeckFhjFkAh9oFMAnGLPjW7laf3TYU/4ex5OHIm
         dcY/h9a8tA1U5G+ATGGVBbpR5KI5mpiFbFMSiTxyfiqexP4U0NYYksGiwYa4bznzfFw0
         uSxoZVmuYgDxiHlOsdqaiiAC8NFY/gS7ryknra/8H/oKuOSJ77CNMbfsAVkyL97R8Nw3
         tLiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm55uTSWJcVlVliNlHm6AdoizIxDEKp1eyhF+D7M7FPAAKZ8ksmj4TnqdltLNrZaxKwFsPXjQoD3cZB8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjILgi402KiskryJ2MeIyupeP73zIIqh2AvuimxPRGKV5pVzwW
	nCFCdMhP1UgPiHFs8iAUt00OIetgfD1uUAljrhc6MByHU+Dxd77+fpPR0jdX2MSVTQw=
X-Gm-Gg: ASbGncu1HEodzGMX0IRwf973SY9/PWFQVUotCNFfr4K4CFQhJkWBIzYXZwROfqUDecQ
	IoeLY/kcEVo4iH6cd2vP0CgXg34sE0zNR4aohC6ltjj77qmB61qbo3b6hmsByCBZV7qGIga0fCI
	iy18qGKcDTz9e85x38t6tB8ewAtYrJiYxNcqjVS6wnMVOCJpX6q0inMzazJkUS7MXedPuEx15T/
	q5x10H7AxuQ18RXk+fMgu9dCUIqruZuk6Dk01GZKQcsZdbV3NusgIp+Z8bzO8x8L2LJyB7Xlwg5
	bXcw/Dv7Lc+HWLH5kGIdO6C5VdfXdKPS04f89l77a5VRl1yG3fErvBd7XW2UHxgOHFV6dA==
X-Google-Smtp-Source: AGHT+IFz1D8/12XwlMH9nD/1jWSY5+ZD+bTmwmjROaWHbn7m2/jSD8nUPromTyulLxho5aGATXbK1g==
X-Received: by 2002:a05:6000:18a3:b0:3a3:584b:f5d7 with SMTP id ffacd0b85a97d-3b5f186afb6mr95564f8f.5.1752165603110;
        Thu, 10 Jul 2025 09:40:03 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:bf57:83e8:7a62:80b7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d511b43csm60588395e9.37.2025.07.10.09.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 18:40:02 +0200
Message-Id: <DB8IV9GMLI6X.25TJF0WMVHZEM@ventanamicro.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: [PATCH] RISC-V: store precomputed percpu_offset in the task struct
Cc: <masahiroy@kernel.org>, <nathan@kernel.org>, <nicolas.schier@linux.dev>,
 <dennis@kernel.org>, <tj@kernel.org>, <cl@gentwo.org>,
 <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
 <alex@ghiti.fr>, <andybnac@gmail.com>, <bjorn@rivosinc.com>,
 <cyrilbur@tenstorrent.com>, <rostedt@goodmis.org>, <puranjay@kernel.org>,
 <ben.dooks@codethink.co.uk>, <zhangchunyan@iscas.ac.cn>,
 <ruanjinjie@huawei.com>, <jszhang@kernel.org>, <charlie@rivosinc.com>,
 <cleger@rivosinc.com>, <antonb@tenstorrent.com>, <ajones@ventanamicro.com>,
 <debug@rivosinc.com>, <haibo1.xu@intel.com>, <samuel.holland@sifive.com>,
 <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>, <wangziang.ok@bytedance.com>
To: "yunhui cui" <cuiyunhui@bytedance.com>
References: <20250704084500.62688-1-cuiyunhui@bytedance.com>
 <DB5U402ARSEO.4H4PE19LGCR7@ventanamicro.com>
 <CAEEQ3w=V6-d+YSWP=0WMt6UAZexrazq0UQjdyUmS3AnMtkdoKQ@mail.gmail.com>
 <DB6MLPA3BJ75.2U5FP5JSJD2LO@ventanamicro.com>
 <CAEEQ3wkoy3Jr0vZk=X4U56KYPq3=5t7Wr4RE6uNby3MS5qzh-g@mail.gmail.com>
 <DB7L9ZHZI3AI.36SXWX2SO9OS7@ventanamicro.com>
 <CAEEQ3wnaL5X_jXEmbbWFp3jx1Aq=02Gf7kDNBS=wcPyfEq7yBw@mail.gmail.com>
 <DB8607ITP9UR.2LOW61O3OVJ2F@ventanamicro.com>
 <CAEEQ3wmxJ50PZHVpdexeyy1ELqKw+5mrb+8gRCA4KNj9zsrykA@mail.gmail.com>
In-Reply-To: <CAEEQ3wmxJ50PZHVpdexeyy1ELqKw+5mrb+8gRCA4KNj9zsrykA@mail.gmail.com>

2025-07-10T19:47:27+08:00, yunhui cui <cuiyunhui@bytedance.com>:
> On Thu, Jul 10, 2025 at 2:35=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrc=
mar@ventanamicro.com> wrote:
>> It would be to store the percpu offset in CSR_SCRATCH permanently, do
>> the early exception register shuffling with a percpu area storage, and
>> load the thread pointer from there as well.
>> That method would also eliminate writing CSR_SCRATCH on every exception
>> entry+exit, so maybe it makes sense to try it even if CSRs are slow...
>
> Based on the patch, optimizations for percpu offset have been added,
> with the following data:
> 6.989 7.046 6.976 6.986 7.001 7.017 7.007 7.064 7.008 7.039
> Geometric mean: 7.013248303
> Compared to reusing the scratch register, the performance has improved
> by approximately 0.7%.

Nice, thanks.  The CSR_SCRATCH accesses seem much slower than GPRs, and
possibly even slower than L1 hit -- we might gain more by storing the
precomputed offset in the task struct.

Can you check this patch as well?

(It should be compared against a variant of CSR_SCRATCH that uses the
 TASK_TI_PERCPU_OFFSET optimizations, but we can try to interpolate. :])

---8<---
RISC-V: store precomputed percpu_offset in the task struct

Exploring the memoization trade-off... hoping that __set_task_cpu covers
everything. :)

I didn't put any though into where the percpu_offset should live, and
the naive approach is to put it next to cpu.
This needs more work to not break build on other arches, because I
directly added RISC-V specific code to __set_task_cpu, to save time
figuring out where else it could be.
---
 arch/riscv/include/asm/asm.h         | 6 +-----
 arch/riscv/include/asm/percpu.h      | 8 ++++++++
 arch/riscv/include/asm/thread_info.h | 3 ++-
 arch/riscv/kernel/asm-offsets.c      | 1 +
 arch/riscv/kernel/smpboot.c          | 6 ++++++
 kernel/sched/sched.h                 | 1 +
 6 files changed, 19 insertions(+), 6 deletions(-)
 create mode 100644 arch/riscv/include/asm/percpu.h

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index a8a2af6dfe9d..2a6b831d9cdf 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -91,11 +91,7 @@
 #endif
=20
 .macro asm_per_cpu dst sym tmp
-	REG_L \tmp, TASK_TI_CPU_NUM(tp)
-	slli  \tmp, \tmp, PER_CPU_OFFSET_SHIFT
-	la    \dst, __per_cpu_offset
-	add   \dst, \dst, \tmp
-	REG_L \tmp, 0(\dst)
+	REG_L \tmp, TASK_TI_PERCPU_OFFSET(tp)
 	la    \dst, \sym
 	add   \dst, \dst, \tmp
 .endm
diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/percp=
u.h
new file mode 100644
index 000000000000..c37a0fce6ebc
--- /dev/null
+++ b/arch/riscv/include/asm/percpu.h
@@ -0,0 +1,8 @@
+#ifndef __ASM_PERCPU_H
+#define __ASM_PERCPU_H
+
+#define __my_cpu_offset (current_thread_info()->percpu_offset)
+
+#include <asm-generic/percpu.h>
+
+#endif
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/=
thread_info.h
index f5916a70879a..da776b7a1d02 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -60,8 +60,9 @@ struct thread_info {
 	 */
 	long			kernel_sp;	/* Kernel stack pointer */
 	long			user_sp;	/* User stack pointer */
-	int			cpu;
+	int			cpu;		// TODO: could be packed better
 	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
+	unsigned long		percpu_offset;	// XXX: randomly placed here
 #ifdef CONFIG_SHADOW_CALL_STACK
 	void			*scs_base;
 	void			*scs_sp;
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offset=
s.c
index 6e8c0d6feae9..9c7bb4d7e3b3 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -50,6 +50,7 @@ void asm_offsets(void)
 #endif
=20
 	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
+	OFFSET(TASK_TI_PERCPU_OFFSET, task_struct, thread_info.percpu_offset);
 	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
 	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
 	OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 601a321e0f17..3c09c8f3e30c 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -41,6 +41,11 @@
=20
 static DECLARE_COMPLETION(cpu_running);
=20
+void __init smp_prepare_boot_cpu(void)
+{
+	current_thread_info()->percpu_offset =3D per_cpu_offset(smp_processor_id(=
));
+}
+
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	int cpuid;
@@ -183,6 +188,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidl=
e)
 {
 	int ret =3D 0;
 	tidle->thread_info.cpu =3D cpu;
+	tidle->thread_info.percpu_offset =3D per_cpu_offset(cpu);
=20
 	ret =3D start_secondary_cpu(cpu, tidle);
 	if (!ret) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 475bb5998295..2180a85b1403 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2199,6 +2199,7 @@ static inline void __set_task_cpu(struct task_struct =
*p, unsigned int cpu)
 	 */
 	smp_wmb();
 	WRITE_ONCE(task_thread_info(p)->cpu, cpu);
+	WRITE_ONCE(task_thread_info(p)->percpu_offset, per_cpu_offset(cpu));
 	p->wake_cpu =3D cpu;
 #endif
 }

