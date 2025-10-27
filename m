Return-Path: <linux-kernel+bounces-871954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18824C0EF6D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F7D3500B67
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E1330BB87;
	Mon, 27 Oct 2025 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7P/rMf+"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BD121C9E1
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578491; cv=none; b=OhvgWxyzfVSRWMlKRbeGhlMBkupYDyByGo7ndTJw3vQKjBDF0SZ6XfMmPtBTXKy6dDS2DfB+mDWwEISyONXmZoNOPVZ4T5XRu8Oovo8VFlijGzP0Eo+wtrqMX+eO8txKL8P+w8DHBm5uYC9qK4qOwOQKhmOlYiJa446XUV/Pu+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578491; c=relaxed/simple;
	bh=uzvdb9L2hEpKRhWkf7joC4v7ZGbAToUwxioRTGyJ/ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFSFKNgc5yEFP/BZh0750xfVVSn15tU0XhuxLBo3yv9HDFEwA3POph7Oa3imVw/Q5XFj3OeqPiX8IdjwydxGI5o+IOpfzigyrbHBc+ncZpjAxreK2tq4uyWXz3Uakrmmtu4DqQA2hJaRqKqreCAwN0oKu7oTU+sshwlohW8Fbfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7P/rMf+; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b6ce806af3eso4393988a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761578490; x=1762183290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAuDRjv5uAXTsOVI/eb5J4UAMhtSLGfuIUeu/cvlLSU=;
        b=I7P/rMf+oAG/9fpEOTaASMHF4QHJYCE54kRTClC486Of14054wkiX7BSf0IYUIcwRT
         pX7cgknBlJoQaz2wOcqQpZq+xmabtxZylY/AupVl9mKo3EYKygFrxCx/JgVwa0ORU9iH
         lUPNPIxLADoqWX6vqMslQ7Z8nv1Rrx7xR9OR1qOfNp+i0PR6b/W8ivFzcVp1pHo2wvLf
         k8Kfi90N0g8vMKGSElH5i+JN6nb0HCusoIP4gQYjOGknpxkygBE2XkWcsLnJuqUA4F3H
         wh0HfFWvo3+gKNZtBoLd1FltYH6txU+vLdRx8EMwtRWvhLpPG9yX4PpHxP2OxBRw38T3
         k4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761578490; x=1762183290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAuDRjv5uAXTsOVI/eb5J4UAMhtSLGfuIUeu/cvlLSU=;
        b=lc4aBqxuK94XLp1WvOz2lSM70GzJkfXeQJZYWBJctZC5FwZIverHEo5jhwjEq9nHs5
         +kXmT++LMh1OTVaUkGOjKSayL4ottCPzFngvZ3OY0sp8sGBQA8+pivJ4KYhEXLDF7E2t
         g+nw1/Ao3RWtUOZzNWlM7OVkWL93ZgrHaTnXWX6h3DHmx0pL2/wmp0dAdgrn7bJTS2CC
         zJggOymIULcASYzQCGSrKxBS6fSy4mEl9GEUnGfWaB7ypHPaWPuCaCSQAPU1wtewfCNM
         hocra1jDmxPFFgsowydlDioGNjNqcFsMCqt1aylYZHQyyHtIOsuh8MlHOoA0Ma6vGghx
         SAyg==
X-Forwarded-Encrypted: i=1; AJvYcCXqLvgMtsuf9sbtWoxAxeTRuRpvcGOd5OsMKDoM2PlCjxvXWXeduG9AD0xeHRTYCUDvjUEwqKHm/ZmWn1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzngOqOx7GVJOzHbgfGPd9rMmA/nmvNLipRJCKfQbzjbkbRCOTK
	zqRpFK24BgGC5rKN0ig0wsmW33EHjmOkSKO5W23sk2RMkdt9p2FWXetV
X-Gm-Gg: ASbGncvjQ3ZmsbJEoVpUKgOjsjWVaHkhQVyGfuYghF9e5gQOA3LLDBijJNgqU/WLu4D
	tVBoIMMkjB//9zUHs5/bZKVs0rCgOZ3/oQc40TirzFEH5EZDeLSz7XzcnHte90tiF9bs7zzymTB
	f8Z2EOp91EQ73xXkzPrw1FHY1vLXi/nI0r4/vKXBF+SuB7W0K/Ld30+tDgXOy5L+nlWPYJ24SVr
	zqRW4D3T0ogedo10Ppf66LMudO46HJH6XsVOPKNbbVXQWdc2lu7fomolXN4sqExIx1dCmOWW7XU
	NnNbnYrSwb+u9wq3JGJEEUFbHFW004oXQUCO3CUTuBAfr56OtyRrrN6vK87F2hK0G+TQ4bnmykr
	ytnrWqN6KHKCyA/+t9QFVShVgiSGfAH+bs2SMeMQDSSAh3UmyYceD7pPm18j7iVxKyPsFa0/Hfd
	od6EWwCItbFTR52qV0w1n6bGanWFt+2tT87bA=
X-Google-Smtp-Source: AGHT+IE98kyCeEo6PTndR/a9uNVMw9TW4vCsYVgseUaymh3OJieDxpigWzsO7C6JngKgDnTsgFT3wA==
X-Received: by 2002:a17:903:1d0:b0:290:dfab:ca91 with SMTP id d9443c01a7336-294cb68836emr3428795ad.54.1761578489223;
        Mon, 27 Oct 2025 08:21:29 -0700 (PDT)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3426sm87711215ad.7.2025.10.27.08.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 08:21:28 -0700 (PDT)
From: Xie Yuanbin <qq570070308@gmail.com>
To: peterz@infradead.org,
	riel@surriel.com,
	segher@kernel.crashing.org,
	linux@armlinux.org.uk,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	luto@kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	qq570070308@gmail.com,
	thuth@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ryan.roberts@arm.com,
	max.kellermann@ionos.com,
	urezki@gmail.com,
	nysal@linux.ibm.com
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	will@kernel.org
Subject: Re: [PATCH 0/3] Optimize code generation during context
Date: Mon, 27 Oct 2025 23:21:00 +0800
Message-ID: <20251027152100.62906-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024182628.68921-1-qq570070308@gmail.com>
References: <20251024182628.68921-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I conducted a more detailed performance test on this series of patches.
https://lore.kernel.org/lkml/20251024182628.68921-1-qq570070308@gmail.com/t/#u

The data is as follows:
1. Time spent on calling finish_task_switch (unit: rdtsc):
| compiler && appended cmdline | without patches | with patches  |
| clang + NA                   | 14.11 - 14.16   | 12.73 - 12.74 |
| clang + "spectre_v2_user=on" | 30.04 - 30.18   | 17.64 - 17.73 |
| gcc + NA                     | 16.73 - 16.83   | 15.35 - 15.44 |
| gcc + "spectre_v2_user=on"   | 40.91 - 40.96   | 30.61 - 30.66 |

Note: I use x86 for testing here. Different architectures have different
cmdlines for configuring mitigations. For example, on arm64, spectre v2
mitigation is enabled by default, and it should be disabled by adding
"nospectre_v2" to the cmdline.

2. bzImage size:
| compiler | without patches | with patches  |
| clang    | 13173760        | 13173760      |
| gcc      | 12166144        | 12166144      |

No size changes were found on bzImage.

Test info:
1. kernel source:
latest linux-next branch:
commit id 72fb0170ef1f45addf726319c52a0562b6913707
2. test machine:
cpu: intel i5-8300h@4Ghz
mem: DDR4 2666MHz
Bare-metal boot, non-virtualized environment
3. compiler:
gcc: gcc version 15.2.0 (Debian 15.2.0-7)
clang: Debian clang version 22.0.0 (++20250731080150+be449d6b6587-1~exp1+b1)
4. config:
base on default x86_64_defconfig, and setting:
CONFIG_PREEMPT=y
CONFIG_PREEMPT_DYNAMIC=n
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_HZ=100
CONFIG_DEBUG_ENTRY=n
CONFIG_X86_DEBUG_FPU=n
CONFIG_EXPERT=y
CONFIG_MODIFY_LDT_SYSCALL=n
CONFIG_CGROUPS=n
CONFIG_BUG=n
CONFIG_BLK_DEV_NVME=y
5. test method:
Use rdtsc (cntvct_el0 can be use on arm64/arm) to obtain timestamps
before and after finish_task_switch calling point, and created multiple
processes to trigger context switches, then calculated the average
duration of the finish_task_switch call.
Note that using multiple processes rather than threads is recommended for
testing, because this will trigger switch_mm (where spectre v2 mitigations
may be performed) during context switching.

I put my test code here:
kernel(just for testing, not a commit):
```
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index ced2a1dee..9e72a4a1a 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -394,6 +394,7 @@
 467	common	open_tree_attr		sys_open_tree_attr
 468	common	file_getattr		sys_file_getattr
 469	common	file_setattr		sys_file_setattr
+470	common	mysyscall		sys_mysyscall
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1842285ea..bcbfea69d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5191,6 +5191,40 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	calculate_sigpending();
 }
 
+static DEFINE_PER_CPU(uint64_t, mytime);
+static DEFINE_PER_CPU(uint64_t, total_time);
+static DEFINE_PER_CPU(uint64_t, last_total_time);
+static DEFINE_PER_CPU(uint64_t, total_count);
+
+static __always_inline uint64_t myrdtsc(void)
+{
+    register uint64_t rax __asm__("rax");
+    register uint64_t rdx __asm__("rdx");
+
+    __asm__ __volatile__ ("rdtsc" : "=a"(rax), "=d"(rdx));
+    return rax | (rdx << 32);
+}
+
+static __always_inline void start_time(void)
+{
+	raw_cpu_write(mytime, myrdtsc());
+}
+
+static __always_inline void end_time(void)
+{
+	const uint64_t end_time = myrdtsc();
+	const uint64_t cost_time = end_time - raw_cpu_read(mytime);
+
+	raw_cpu_add(total_time, cost_time);
+	if (raw_cpu_inc_return(total_count) % (1 << 20) == 0) {
+		const uint64_t t = raw_cpu_read(total_time);
+		const uint64_t lt = raw_cpu_read(last_total_time);
+
+		pr_emerg("cpu %d total_time %llu, last_total_time %llu, cha : %llu\n", raw_smp_processor_id(), t, lt, t - lt);
+		raw_cpu_write(last_total_time, t);
+	}
+}
+
 /*
  * context_switch - switch to the new MM and the new thread's register state.
  */
@@ -5254,7 +5288,10 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	switch_to(prev, next, prev);
 	barrier();
 
-	return finish_task_switch(prev);
+	start_time();
+	rq = finish_task_switch(prev);
+	end_time();
+	return rq;
 }
 
 /*
@@ -10854,3 +10891,19 @@ void sched_change_end(struct sched_change_ctx *ctx)
 		p->sched_class->prio_changed(rq, p, ctx->prio);
 	}
 }
+
+
+static struct task_struct *my_task;
+
+SYSCALL_DEFINE0(mysyscall)
+{
+	preempt_disable();
+	while (1) {
+		if (my_task)
+			wake_up_process(my_task);
+		my_task = current;
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		__schedule(0);
+	}
+	return 0;
+}
```

User program:
```c
int main()
{
	cpu_set_t mask;
	if (fork())
		sleep(1);

	CPU_ZERO(&mask);
	CPU_SET(5, &mask); // Assume that cpu5 exists
	assert(sched_setaffinity(0, sizeof(mask), &mask) == 0);
	syscall(470);
	// unreachable
	return 0;
}
```

Usage:
1. set core5 as isolated cpu: add "isolcpus=5" to cmdline
2. run user programe
3. wait for kernel print

Everyone is welcome to test it.

Xie Yuanbin

