Return-Path: <linux-kernel+bounces-861509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F43BF2E89
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1523AF47F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF842C3271;
	Mon, 20 Oct 2025 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="NzTuUlAy"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CB3332905
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760984336; cv=none; b=fwd5jMf1pwHTuaOuBx6j5XuDRrXfxfC5zu0FtgKW5FALNqMi7K8fej22mOLE5DaFqbJ0nu6P6PCUB0epuN2PSby8nRljYHLClMt8evFgdsy2yRPlU/FnwdxJVKUzk2TmJ7TNlM3Z+Uco1MfzCEFcAlxs3IRgQWDRgleT7W3f94Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760984336; c=relaxed/simple;
	bh=HTQ7AqipbpEFjOSw2SAnook8GHMgNeBvluv+1LerSeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XMWaUwse1Tu8AGfYF26qS0EEjHLJDUAW0xSpTHvPk0RMwVbvIFWjfUFl5AGb4vaPjfd0aPqrXTa3kaoAljxruRWSZ60lgg7GzPVIbMrZgSHaHyjgJkticZa4p9mJ9b2gi5YCExliu3bLNw/Yr+4ijSANI1N9FUFjpkMcTEIGBB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=NzTuUlAy; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3381f041d7fso6076503a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760984334; x=1761589134; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J3wXXjw9bzD6MPVLbQ5doCpWIDPvan0gGJzfGLwRl50=;
        b=NzTuUlAyvQELTeughwB+xv5+VUDQbAjpK2XidsMfOOfNrE8A7FwwQPa9Gp6P7837R2
         RovQSDAPLt6kMMlNIgByLampHUz3NOLKLaHWNHGkQUIZFyEsfKfI7WX4RIHJFnqaEibW
         oKTxQ3fFUvBGplQlTVu9NNZfliCZJXUC6C4Q3q+chCiMJFtt6rjeAWBascslQGCQYzTF
         ihRRSBR1aRTcqBBL9HLZO0en0dwGE8+x+Q6/9ceaM4AADGjgMBhCmzKeqrgLGBDQYGMJ
         PdXudgJRysE4wxn/DuCkKo3Liw8hB+0nfRIF8PWLep9J6MW80sat52aLFRnujqOhaE1N
         EDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760984334; x=1761589134;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3wXXjw9bzD6MPVLbQ5doCpWIDPvan0gGJzfGLwRl50=;
        b=Rq1JnrS5Fe8zageFJl1JelGPZkjQUqhKBMlos8DQes3dOwaKIWJ9GbJHamX7+F48Pf
         T9Fbf3JROHqc9AUy5GDArPtUkeh+G0Po1nDJtEi3ZJuu4bQ7tR63Iq2wb+RsxwbVkAcd
         3bylrbq1oKnNfS1pLhVcn8okT4jmqei6VfG8YLDagJPRIxEKchOdVoRWQKUOKB6h9E76
         oEWRQamyqDN34eP0CGpldEieAZ8pkimkuI8Y+ePUcAv8yp3uWFf2+d2lyM89BbEp1ONK
         /r61/KQbjTF02fSzyhIt8cQRtJAAqP8glo3AHCImRuyoRFmc7+R1XT7ilcB89VlDowXL
         tfLA==
X-Forwarded-Encrypted: i=1; AJvYcCV8UeTsOuFSoHKbdC7d6Jb99aAopruJTlq4gtxxeTjII3ppCpXAo1x0yCJ4g6xSQebsL07N6G9tHfsnRWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpOvvSet9DaUlb9q2I1eW/uiWsMdu4f4R83jzlnOcG7KpLBj2S
	1ma+PC2989LAY3DqyGYm0ZYeX6W1ZzNp8YdtgcdniOFz1oV6ubgPnRiBR2wHBxw8LQI=
X-Gm-Gg: ASbGncutlU1S5TKoN/NqppIKTFCZAzRlR4A/CHBOSWWyt1ZQ3+GwGtr65V2KqS3AjY6
	Z2GH+juB7nHTyWQPGd8mVnjllHRRm4Rp5zvnGZr6T87Ao0TyHbSjJN8cSahVivNnciapu5JwUVY
	szhkDsr50AUkM5xKEBWyM47Q771TUjvDdC1ee5KP2fI+zen1TZwm3MQMY2uy3T8vhgbJUFFoSXB
	0n0hgi1qJQr+tLygAkbsI0rK6Q07Z1zHf3uJSmi4Mji9/DIWAJPo6i9+i+OuGyZUwFtLQM74hJI
	zo8FzyldXwj393Nv5ybDvIbfxeGUfX3ouFFsN1n5+KnlOYIRRx/ra6lH4bKIwqUj8qWSiJOvLuq
	dCAbJvKXq0RmOCbdIAFJTIY2ZAyaFvMiCjHO/0XmuFTk90mHUY1m9MGRvPliJdGRqm3ugXI9/cp
	tQOON2CcGsbTTot0SWm4EP
X-Google-Smtp-Source: AGHT+IGTvGMOz93bZ6gvLfbDW2Z5HUTn/LhD3gZSIqP3hEuhNTUpAhz52wVhznRHxX8oqUHCbXBsgg==
X-Received: by 2002:a17:90a:d406:b0:32d:e027:9b26 with SMTP id 98e67ed59e1d1-33bc9d1a8e6mr20155181a91.13.1760984333589;
        Mon, 20 Oct 2025 11:18:53 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5df93591sm8775752a91.17.2025.10.20.11.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 11:18:53 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 20 Oct 2025 11:18:52 -0700
Subject: [PATCH RFC] arch/riscv: add proc status (proc/<pid>/status)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-proc_status-v1-1-59d2c8ccd4f0@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAAt99mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0Nz3YKi/OT44pLEktJi3ZQ0w8TUlGQL02TzZCWgjoKi1LTMCrBp0Up
 Bbs5KsbW1ABchsmtiAAAA
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
 alexghiti@rivosinc.com, cleger@rivosinc.com, zong.li@sifive.com, 
 heinrich.schuchardt@canonical.com, valentin.haudiquet@canonical.com, 
 jesse.huang@sifive.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

x86 has proc/<pid>/status to see various runtime characteristics
of running task. Implement same for riscv. This patch implements
status for shadow stack and landing pad state.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
This is just a one patch but sending it as RFC with cover letter to seek
feedback. x86 has `arch_proc_pid_thread_features` to enumerate status of
arch thread specific features on runtime. This can be done using prctl
as well but from quick/script perspective `cat /proc/<pid>/status` is more
desirable. In this patch, simply `arch_proc_pid_thread_features` is implemented
for riscv which queries shadow stack and landing pad state and reports back.
Thus it is dependent on riscv user cfi enabling series.

If this patch itself is self-standing and good enough, I can roll this patch
as part of riscv user cfi enabling series.

OR

If there is ask for other riscv thread specific features that could be
enumerated in similar fashion, we will need it to be done as separate series
(with `thread_features` added to `thread_info`)

Example output below.

Name:   cat
Umask:  0022
State:  R (running)
Tgid:   133
Ngid:   0
Pid:    133
PPid:   129
TracerPid:      0
Uid:    0       0       0       0
Gid:    0       0       0       0
FDSize: 256
Groups: 0 10
NStgid: 133
NSpid:  133
NSpgid: 133
NSsid:  129
Kthread:        0
VmPeak:    10788 kB
VmSize:    10788 kB
VmLck:         0 kB
VmPin:         0 kB
VmHWM:      1400 kB
VmRSS:      1400 kB
RssAnon:             116 kB
RssFile:            1284 kB
RssShmem:              0 kB
VmData:       92 kB
VmStk:      8324 kB
VmExe:         4 kB
VmLib:      2312 kB
VmPTE:        40 kB
VmSwap:        0 kB
HugetlbPages:          0 kB
CoreDumping:    0
THP_enabled:    0
untag_mask:     0xffffffffffffffff
Threads:        1
SigQ:   0/31771
SigPnd: 0000000000000000
ShdPnd: 0000000000000000
SigBlk: 0000000000000000
SigIgn: 0000000000000000
SigCgt: 0000000000000000
CapInh: 0000000000000000
CapPrm: 000001ffffffffff
CapEff: 000001ffffffffff
CapBnd: 000001ffffffffff
CapAmb: 0000000000000000
NoNewPrivs:     0
Seccomp:        0
Seccomp_filters:        0
Speculation_Store_Bypass:       unknown
SpeculationIndirectBranch:      unsupported
Cpus_allowed:   3
Cpus_allowed_list:      0-1
Mems_allowed:   1
Mems_allowed_list:      0
voluntary_ctxt_switches:        0
nonvoluntary_ctxt_switches:     3
riscv_thread_features:  shstk_enabled lpad_enabled
riscv_thread_features_locked:   shstk_unlocked lpad_unlocked
---
 arch/riscv/kernel/Makefile     |  1 +
 arch/riscv/kernel/cpu/Makefile |  1 +
 arch/riscv/kernel/cpu/proc.c   | 28 ++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f60fce69b725..b32c11667d81 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -71,6 +71,7 @@ obj-y	+= vendor_extensions.o
 obj-y	+= vendor_extensions/
 obj-y	+= probes/
 obj-y	+= tests/
+obj-y	+= cpu/
 obj-$(CONFIG_MMU) += vdso.o vdso/
 
 obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
diff --git a/arch/riscv/kernel/cpu/Makefile b/arch/riscv/kernel/cpu/Makefile
new file mode 100644
index 000000000000..2b474fb49afe
--- /dev/null
+++ b/arch/riscv/kernel/cpu/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_PROC_FS)			+= proc.o
diff --git a/arch/riscv/kernel/cpu/proc.c b/arch/riscv/kernel/cpu/proc.c
new file mode 100644
index 000000000000..4661190c43d1
--- /dev/null
+++ b/arch/riscv/kernel/cpu/proc.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/smp.h>
+#include <linux/timex.h>
+#include <linux/string.h>
+#include <linux/seq_file.h>
+#include <linux/cpufreq.h>
+#include <linux/proc_fs.h>
+#include <asm/usercfi.h>
+
+#ifdef CONFIG_RISCV_USER_CFI
+
+void arch_proc_pid_thread_features(struct seq_file *m, struct task_struct *task)
+{
+	seq_puts(m, "riscv_thread_features:\t");
+	if (is_shstk_enabled(task))
+		seq_puts(m, "shstk_enabled ");
+
+	if (is_indir_lp_enabled(task))
+		seq_puts(m, "lpad_enabled ");
+
+	seq_putc(m, '\n');
+
+	seq_puts(m, "riscv_thread_features_locked:\t");
+	is_shstk_locked(task) ? seq_puts(m, "shstk_locked ") : seq_puts(m, "shstk_unlocked ");
+	is_indir_lp_locked(task) ? seq_puts(m, "lpad_locked ") : seq_puts(m, "lpad_unlocked ");
+	seq_putc(m, '\n');
+}
+#endif /* CONFIG_RISCV_USER_CFI */

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251017-proc_status-df1aedc85c7c
--
- debug


