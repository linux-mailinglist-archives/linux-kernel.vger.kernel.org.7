Return-Path: <linux-kernel+bounces-632032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5E9AA91AB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 13:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1F41898C23
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 11:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D131207A27;
	Mon,  5 May 2025 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5iAPNWE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8711F202F87
	for <linux-kernel@vger.kernel.org>; Mon,  5 May 2025 11:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746443439; cv=none; b=E0hy/4my/rdqXJZ3g3BH1ZLHUB7QqJeZK+6vwDSbPYIsQ7QLtMapftlOHcbARLT84YmDziX14meXUsesjzOr2eMJaMfJ62fcEMC65nvw3MBhKGyx19Md8UNh/n/IXPFrCf3tlPDFtCuRxRIO2ipkwEFB3sYUqSFP2cxlDDzIsgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746443439; c=relaxed/simple;
	bh=P2LKh1TBvBgopa3Rf/LqikiGAwnI6+PEIU/z7zZdUTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kto0ZEIeoHmSYx8bsthXFaGn2mkhbKnsJBobok1yUC3bD0nf63CT6Tir5sRhD/U1+UiN9YNiLb00jhvSXIFF3Q7IJ1kK/GElx6GPi/8rXHXGb3VY6s3W/GG4tWwr5zOGfJMX16wPmvQb5NPyvHG9Pv3pj3ri6xOimutOmzt2mBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5iAPNWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2185C4CEE4;
	Mon,  5 May 2025 11:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746443439;
	bh=P2LKh1TBvBgopa3Rf/LqikiGAwnI6+PEIU/z7zZdUTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W5iAPNWEYMstFBEqcL/f3qOXTdokuksBp+6kIpLdNv5HKqOfBOjR1TldfHtjYOVrd
	 Z5mDYd4J2UsgHZYcn3NVy0iLwUKizpcAaVtXTfrG5OH7xfIecxydUXAyZKbr7aAy7F
	 bK3wjun5yWdZVqA/N2hl95j6FB8LaM59sPma7cxNGvaLFrN1VFHZCdkZyFdbzpVWt7
	 7A/JI2zifKItZTdky3cH692GoHF740ASGnYrDpoWRGoTHwGiScs/H1zaRLqYezErHt
	 ZiwMdct5eeXLcHrpX9D1gEwDnNA4b+RY05L97AFGJPuTT4lAScSNISR+l4HL7lcVu+
	 hOWX0ixBxqw5A==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH 15/15] x86/kconfig/32: Synchronize the x86-32 defconfig to the x86-64 defconfig
Date: Mon,  5 May 2025 13:09:46 +0200
Message-ID: <20250505110946.1095363-16-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250505110946.1095363-1-mingo@kernel.org>
References: <20250505110946.1095363-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just a mechanic synchronization of kernel options enabled: nobody
really develops kernel features on x86-32 anymore, so make sure the
defconfig is roughly equivalent to the 64-bit one, so that testing
doesn't cover some combination that nobody cares about.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
---
 arch/x86/configs/defconfig.x86_32 | 116 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 110 insertions(+), 6 deletions(-)

diff --git a/arch/x86/configs/defconfig.x86_32 b/arch/x86/configs/defconfig.x86_32
index e983f1db22dd..26a0fc03d642 100644
--- a/arch/x86/configs/defconfig.x86_32
+++ b/arch/x86/configs/defconfig.x86_32
@@ -1,37 +1,63 @@
 CONFIG_WERROR=y
+CONFIG_UAPI_HEADER_TEST=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_WATCH_QUEUE=y
 CONFIG_USELIB=y
 CONFIG_AUDIT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_BPF_JIT=y
+CONFIG_BPF_JIT_ALWAYS_ON=y
+CONFIG_BPF_PRELOAD=y
+CONFIG_BPF_PRELOAD_UMD=y
+CONFIG_BPF_LSM=y
 CONFIG_PREEMPT_VOLUNTARY=y
+CONFIG_SCHED_CORE=y
+CONFIG_IRQ_TIME_ACCOUNTING=y
 CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_TASKSTATS=y
 CONFIG_TASK_DELAY_ACCT=y
 CONFIG_TASK_XACCT=y
 CONFIG_TASK_IO_ACCOUNTING=y
+CONFIG_PSI=y
+CONFIG_PSI_DEFAULT_DISABLED=y
 CONFIG_LOG_BUF_SHIFT=18
-CONFIG_CGROUPS=y
+CONFIG_PRINTK_INDEX=y
+CONFIG_UCLAMP_TASK=y
+CONFIG_MEMCG=y
+CONFIG_MEMCG_V1=y
 CONFIG_BLK_CGROUP=y
-CONFIG_CGROUP_SCHED=y
+CONFIG_CFS_BANDWIDTH=y
+CONFIG_UCLAMP_TASK_GROUP=y
 CONFIG_CGROUP_PIDS=y
 CONFIG_CGROUP_RDMA=y
+CONFIG_CGROUP_DMEM=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_HUGETLB=y
 CONFIG_CPUSETS=y
+CONFIG_CPUSETS_V1=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_PERF=y
+CONFIG_CGROUP_BPF=y
 CONFIG_CGROUP_MISC=y
 CONFIG_CGROUP_DEBUG=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_NAMESPACES=y
+CONFIG_USER_NS=y
+CONFIG_CHECKPOINT_RESTORE=y
+CONFIG_SCHED_AUTOGROUP=y
+CONFIG_SYSFS_SYSCALL=y
+CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PROFILING=y
 CONFIG_KEXEC=y
 CONFIG_SMP=y
 CONFIG_HYPERVISOR_GUEST=y
 CONFIG_PARAVIRT=y
+CONFIG_PARAVIRT_SPINLOCKS=y
 CONFIG_NR_CPUS=8
 CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
 CONFIG_X86_MSR=y
@@ -50,7 +76,11 @@ CONFIG_ACPI_BGRT=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_X86_ACPI_CPUFREQ=y
-CONFIG_KPROBES=y
+CONFIG_KVM=y
+CONFIG_KVM_INTEL=y
+CONFIG_KVM_AMD=y
+CONFIG_KVM_XEN=y
+CONFIG_KVM_MAX_NR_VCPUS=4096
 CONFIG_JUMP_LABEL=y
 CONFIG_COMPAT_32BIT_TIME=y
 CONFIG_MODULES=y
@@ -60,7 +90,23 @@ CONFIG_BLK_CGROUP_IOLATENCY=y
 CONFIG_BLK_CGROUP_IOCOST=y
 CONFIG_BLK_CGROUP_IOPRIO=y
 CONFIG_BINFMT_MISC=y
+CONFIG_ZSWAP=y
+CONFIG_SLAB_FREELIST_RANDOM=y
+CONFIG_SLAB_FREELIST_HARDENED=y
+# CONFIG_SLAB_BUCKETS is not set
 # CONFIG_COMPAT_BRK is not set
+CONFIG_PAGE_REPORTING=y
+CONFIG_KSM=y
+CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
+CONFIG_MEMORY_FAILURE=y
+CONFIG_HWPOISON_INJECT=y
+CONFIG_TRANSPARENT_HUGEPAGE=y
+CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
+CONFIG_IDLE_PAGE_TRACKING=y
+CONFIG_ANON_VMA_NAME=y
+CONFIG_USERFAULTFD=y
+CONFIG_LRU_GEN=y
+CONFIG_LRU_GEN_ENABLED=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_XFRM_USER=y
@@ -120,6 +166,7 @@ CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_MAC80211_LEDS=y
 CONFIG_RFKILL=y
+CONFIG_RFKILL_INPUT=y
 CONFIG_NET_9P=y
 CONFIG_NET_9P_VIRTIO=y
 CONFIG_PCI=y
@@ -189,6 +236,8 @@ CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
+# CONFIG_HW_RANDOM_INTEL is not set
+# CONFIG_HW_RANDOM_AMD is not set
 CONFIG_NVRAM=y
 CONFIG_HPET=y
 # CONFIG_HPET_MMAP is not set
@@ -208,7 +257,19 @@ CONFIG_SND_SEQ_DUMMY=y
 CONFIG_SND_HDA_INTEL=y
 CONFIG_SND_HDA_HWDEP=y
 CONFIG_HIDRAW=y
+CONFIG_HID_A4TECH=y
+CONFIG_HID_APPLE=y
+CONFIG_HID_BELKIN=y
+CONFIG_HID_CHERRY=y
+CONFIG_HID_CHICONY=y
+CONFIG_HID_CYPRESS=y
+CONFIG_HID_EZKEY=y
 CONFIG_HID_GYRATION=y
+CONFIG_HID_ITE=y
+CONFIG_HID_KENSINGTON=y
+CONFIG_HID_REDRAGON=y
+CONFIG_HID_MICROSOFT=y
+CONFIG_HID_MONTEREY=y
 CONFIG_HID_NTRIG=y
 CONFIG_HID_PANTHERLORD=y
 CONFIG_PANTHERLORD_FF=y
@@ -234,6 +295,8 @@ CONFIG_DMADEVICES=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_INPUT=y
 CONFIG_EEEPC_LAPTOP=y
+CONFIG_INTEL_IOMMU=y
+# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
@@ -264,14 +327,55 @@ CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_KERNEL=y
+CONFIG_BOOT_PRINTK_DELAY=y
+CONFIG_DYNAMIC_DEBUG=y
 CONFIG_FRAME_WARN=1024
-CONFIG_MAGIC_SYSRQ=y
+CONFIG_STRIP_ASM_SYMS=y
+CONFIG_HEADERS_INSTALL=y
+CONFIG_DEBUG_SECTION_MISMATCH=y
+CONFIG_KGDB=y
+CONFIG_KGDB_TESTS=y
+CONFIG_KGDB_LOW_LEVEL_TRAP=y
+CONFIG_KGDB_KDB=y
+CONFIG_KDB_KEYBOARD=y
+CONFIG_UBSAN=y
+CONFIG_UBSAN_SHIFT=y
+CONFIG_PAGE_OWNER=y
+CONFIG_PAGE_POISONING=y
 CONFIG_DEBUG_STACK_USAGE=y
+CONFIG_SCHED_STACK_END_CHECK=y
+CONFIG_DEBUG_MEMORY_INIT=y
+CONFIG_KFENCE=y
+CONFIG_DEBUG_SHIRQ=y
+CONFIG_PANIC_ON_OOPS=y
+CONFIG_HARDLOCKUP_DETECTOR=y
+CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
+# CONFIG_DETECT_HUNG_TASK is not set
+CONFIG_WQ_CPU_INTENSIVE_REPORT=y
 CONFIG_SCHEDSTATS=y
+CONFIG_NMI_CHECK_CPU=y
+CONFIG_DEBUG_LIST=y
+CONFIG_RCU_CPU_STALL_CPUTIME=y
+CONFIG_BOOTTIME_TRACING=y
+CONFIG_FUNCTION_GRAPH_RETVAL=y
+CONFIG_FUNCTION_PROFILER=y
+CONFIG_STACK_TRACER=y
+CONFIG_SCHED_TRACER=y
+CONFIG_HWLAT_TRACER=y
+CONFIG_TIMERLAT_TRACER=y
+CONFIG_MMIOTRACE=y
+CONFIG_FTRACE_SYSCALLS=y
 CONFIG_BLK_DEV_IO_TRACE=y
+CONFIG_USER_EVENTS=y
+CONFIG_HIST_TRIGGERS=y
+CONFIG_TRACE_EVENT_INJECT=y
+CONFIG_RV=y
+CONFIG_RV_MON_WWNR=y
 CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
 CONFIG_EARLY_PRINTK_DBGP=y
+CONFIG_EARLY_PRINTK_USB_XDBC=y
 CONFIG_DEBUG_BOOT_PARAMS=y
 CONFIG_DEBUG_ENTRY=y
 CONFIG_UNWINDER_FRAME_POINTER=y
+CONFIG_FUNCTION_ERROR_INJECTION=y
+CONFIG_MEMTEST=y
-- 
2.45.2


