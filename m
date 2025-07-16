Return-Path: <linux-kernel+bounces-732975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A4AB06E58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCAF1795A8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5682C28934B;
	Wed, 16 Jul 2025 06:58:20 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8A617B50A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649099; cv=none; b=bo0+aHZGwsBNAkMcYs3Z1LrvnUHvdLU/QjRmRAyLni76VjrKTu4WYtt36OPSvvRVIB+mX1kH73a5n5J3U4MsnBLqMmTwKObkFMb4DuqPSUdYEUzCZuMQ/dquZ/moDKeXK4NSAIQhdML+dH/amScSp/jNnPMc9DUkaINNlslRm3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649099; c=relaxed/simple;
	bh=LbwWcvssm9FrIHYv26AUMJv8OB9zaujfSbuaSQ61mA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjUfznJHTILgVBM1QTol8MyaPLjJ/Lt+Ad3EPwQwYcydxdmB04gcQSb7W6dSce7MFjz8bhD7AryLgjGcYdIgNyVrP26VT9xKQk+bQ134OhCfCdS3rJHQOKlFnI9LP0mpur4hVqXI0TF7Y4A1mAJc0fR9i2cXI5rNgzA6Qjay4+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 857D443997;
	Wed, 16 Jul 2025 06:58:06 +0000 (UTC)
Message-ID: <7207e208-a70f-4445-9acc-d910c4da745c@ghiti.fr>
Date: Wed, 16 Jul 2025 08:58:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] Fix for riscv vmcore issue
To: Pnina Feder <PNINA.FEDER@mobileye.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>
Cc: Gregory Greenman <Gregory.Greenman@mobileye.com>,
 "bjorn@rivosinc.com" <bjorn@rivosinc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "mick@ics.forth.gr" <mick@ics.forth.gr>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
 Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
References: <20250409182129.634415-1-bjorn@kernel.org>
 <20250630112309.97162-2-pnina.feder@mobileye.com>
 <87jz4txsjx.fsf@all.your.base.are.belong.to.us>
 <MRWPR09MB80229B89C8D4B4865783B3D78F43A@MRWPR09MB8022.eurprd09.prod.outlook.com>
 <bd2bca3b-2b23-40be-b81b-f842b7afb10e@ghiti.fr>
 <MRWPR09MB80220E49BECD4D18E4AEC5C38F4CA@MRWPR09MB8022.eurprd09.prod.outlook.com>
 <MRWPR09MB8022F4714CF3B62DCCA683D68F54A@MRWPR09MB8022.eurprd09.prod.outlook.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <MRWPR09MB8022F4714CF3B62DCCA683D68F54A@MRWPR09MB8022.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehjedtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepuefffedvleetleetjefhjeehudejteetvedtvddvtdfhieetffelvdffgefgieeinecuffhomhgrihhnpehinhhfrhgruggvrggurdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemleehtdgumehftgegieemjeejlegvmedvfhgvfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemleehtdgumehftgegieemjeejlegvmedvfhgvfedphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemleehtdgumehftgegieemjeejlegvmedvfhgvfegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheprffpkffptedrhffgfffgtfesmhhosghilhgvhigvrdgtohhmpdhrtghpthhtohepsghjohhrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepi
 fhrvghgohhrhidrifhrvggvnhhmrghnsehmohgsihhlvgihvgdrtghomhdprhgtphhtthhopegsjhhorhhnsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhhitghksehitghsrdhfohhrthhhrdhgrhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomh
X-GND-Sasl: alex@ghiti.fr

Hi Pnina,

On 7/14/25 14:00, Pnina Feder wrote:
>>>> Hi Pnina,
>>>>> Pnina!
>>>>>
>>>>> Pnina Feder <pnina.feder@mobileye.com> writes:
>>>>>
>>>>>> We are creating a vmcore using kexec on a Linux 6.15 RISC-V system
>>>>>> and analyzing it with the crash tool on the host. This workflow
>>>>>> used to work on Linux 6.14 but is now broken in 6.15.
>>>>> Thanks for reporting this!
>>>>>
>>>>>> The issue is caused by a change in the kernel:
>>>>>> In Linux 6.15, certain memblock sections are now marked as Reserved
>>>>>> in /proc/iomem. The kexec tool excludes all Reserved regions when
>>>>>> generating the vmcore, so these sections are missing from the dump.
>>>>>> How are you collecting the /proc/vmcore file? A full set of commands would be helpful.
>>>> We’ve defined in our system that when a process crashes, we call panic().
>>>> To handle crash recovery, we're using kexec with the following command:
>>>> kexec -p /Image --initrd=/rootfs.cpio --append "console=${con} earlycon=${earlycon} no4lvl"
>>>>
>>>> To simulate crash, we trigger it using:
>>>> sleep 100 & kill -6 $!
>>>>
>>>> This boots into the crash kernel (kdump), where we then copy the /proc/vmcore file back to the host for analysis.
>>>>
>>>>>> However, the kernel still uses addresses in these regions—for
>>>>>> example, for IRQ pointers. Since the crash tool needs access to
>>>>>> these memory areas to function correctly, their exclusion breaks the analysis.
>>>>> Wdym with "IRQ pointers"? Also, what version (sha1) of crash are you using?
>>>>>
>>>>> We are currently using crash-utility version 9.0.0 (master).
>>>>>   From the crash analysis logs, we observed errors like:
>>>>>
>>>> "......
>>>> IRQ stack pointer[0] is  ffffffd6fbdcc068
>>>>> crash: read error: kernel virtual address: ffffffd6fbdcc068  type: "IRQ stack pointer"
>>>> .....
>>>>
>>>>> <read_kdump: addr: ffffffff80edf1cc paddr: 8010df1cc cnt: 4>
>>>> <readmem: ffffffd6fbdd6880, KVADDR, "runqueues entry (per_cpu)",
>>>> 3456, (FOE), 55acf03963e0>
>>>>> read_kdump: addr: ffffffd6fbdd6880 paddr: 8fbdd6880 cnt: 1920<
>>>> crash: read error: kernel virtual address: ffffffd6fbdd6880  type: "runqueues entry (per_cpu)"
>>>
>>> I can't reproduce this issue on qemu, booting with sv39. I'm using the latest kexec-tools (which recently merged riscv .support), crash 9.0.0 and kernel 6.16.0-rc4. Note that I'm using crash in qemu.
>>>
>>> Are you able to reproduce this on qemu too?
>> Yes, I am using qemu too on main and crash kernel, with latest kexec-tools, crash 9.0.0 and kernel 6.15
>>
>>
>>> Maybe that's related to the config, can you share your config?
>> this is my dev_config
>>
>> CONFIG_SYSVIPC=y
>> CONFIG_POSIX_MQUEUE=y
>> CONFIG_AUDIT=y
>> CONFIG_NO_HZ_IDLE=y
>> CONFIG_HIGH_RES_TIMERS=y
>> CONFIG_BPF_SYSCALL=y
>> CONFIG_PREEMPT_RT=y
>> CONFIG_TASKSTATS=y
>> CONFIG_TASK_DELAY_ACCT=y
>> CONFIG_PSI=y
>> CONFIG_IKCONFIG=y
>> CONFIG_IKCONFIG_PROC=y
>> CONFIG_CGROUPS=y
>> CONFIG_MEMCG=y
>> CONFIG_CGROUP_SCHED=y
>> CONFIG_CFS_BANDWIDTH=y
>> CONFIG_RT_GROUP_SCHED=y
>> CONFIG_CGROUP_PIDS=y
>> CONFIG_CGROUP_FREEZER=y
>> CONFIG_CGROUP_HUGETLB=y
>> CONFIG_CPUSETS=y
>> CONFIG_CGROUP_DEVICE=y
>> CONFIG_CGROUP_CPUACCT=y
>> CONFIG_CGROUP_PERF=y
>> CONFIG_CGROUP_BPF=y
>> CONFIG_NAMESPACES=y
>> CONFIG_USER_NS=y
>> CONFIG_CHECKPOINT_RESTORE=y
>> CONFIG_BLK_DEV_INITRD=y
>> CONFIG_EXPERT=y
>> CONFIG_PROFILING=y
>> CONFIG_KEXEC=y
>> CONFIG_ARCH_VIRT=y
>> CONFIG_NONPORTABLE=y
>> CONFIG_SMP=y
>> CONFIG_NR_CPUS=32
>> CONFIG_HZ_1000=y
>> CONFIG_CPU_IDLE=y
>> CONFIG_MODULES=y
>> CONFIG_MODULE_UNLOAD=y
>> CONFIG_IOSCHED_BFQ=y
>> CONFIG_PAGE_REPORTING=y
>> CONFIG_PERCPU_STATS=y
>> CONFIG_NET=y
>> CONFIG_PACKET=y
>> CONFIG_UNIX=y
>> CONFIG_XFRM_USER=m
>> CONFIG_INET=y
>> CONFIG_IP_MULTICAST=y
>> CONFIG_IP_ADVANCED_ROUTER=y
>> CONFIG_INET_ESP=m
>> CONFIG_NETWORK_SECMARK=y
>> CONFIG_NETFILTER=y
>> CONFIG_IP_NF_IPTABLES=y
>> CONFIG_IP_NF_FILTER=y
>> CONFIG_BRIDGE=m
>> CONFIG_BRIDGE_VLAN_FILTERING=y
>> CONFIG_VLAN_8021Q=m
>> CONFIG_NET_SCHED=y
>> CONFIG_NET_CLS_CGROUP=m
>> CONFIG_NETLINK_DIAG=y
>> CONFIG_NET_L3_MASTER_DEV=y
>> CONFIG_CGROUP_NET_PRIO=y
>> CONFIG_FAILOVER=y
>> CONFIG_DEVTMPFS=y
>> CONFIG_DEVTMPFS_MOUNT=y
>> CONFIG_MTD=y
>> CONFIG_MTD_BLOCK=y
>> CONFIG_MTD_CFI=y
>> CONFIG_MTD_CFI_INTELEXT=y
>> CONFIG_MTD_PHYSMAP=y
>> CONFIG_MTD_PHYSMAP_OF=y
>> CONFIG_BLK_DEV_LOOP=y
>> CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
>> CONFIG_VIRTIO_BLK=y
>> CONFIG_SCSI=y
>> CONFIG_BLK_DEV_SD=y
>> CONFIG_SCSI_VIRTIO=y
>> CONFIG_MD=y
>> CONFIG_BLK_DEV_DM=y
>> CONFIG_NETDEVICES=y
>> CONFIG_MACB=y
>> CONFIG_PCS_XPCS=m
>> CONFIG_SERIO_LIBPS2=y
>> CONFIG_VT_HW_CONSOLE_BINDING=y
>> CONFIG_LEGACY_PTY_COUNT=16
>> CONFIG_SERIAL_8250=y
>> CONFIG_SERIAL_8250_CONSOLE=y
>> CONFIG_SERIAL_OF_PLATFORM=y
>> CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
>> CONFIG_VIRTIO_CONSOLE=y
>> CONFIG_HW_RANDOM=y
>> CONFIG_HW_RANDOM_VIRTIO=y
>> CONFIG_I2C=y
>> CONFIG_I2C_DESIGNWARE_CORE=y
>> CONFIG_SPI=y
>> CONFIG_PINCTRL=y
>> CONFIG_PINCTRL_SINGLE=y
>> CONFIG_GPIOLIB=y
>> CONFIG_GPIO_SYSFS=y
>> CONFIG_GPIO_DWAPB=y
>> CONFIG_GPIO_SIFIVE=y
>> CONFIG_POWER_SUPPLY=y
>> CONFIG_WATCHDOG=y
>> CONFIG_WATCHDOG_CORE=y
>> CONFIG_REGULATOR=y
>> CONFIG_REGULATOR_FIXED_VOLTAGE=y
>> CONFIG_BACKLIGHT_CLASS_DEVICE=m
>> CONFIG_SCSI_UFSHCD=y
>> CONFIG_SCSI_UFSHCD_PLATFORM=y
>> CONFIG_SCSI_UFS_DWC_TC_PLATFORM=y
>> CONFIG_RTC_CLASS=y
>> CONFIG_RTC_DRV_M41T80=y
>> CONFIG_DMADEVICES=y
>> CONFIG_SYNC_FILE=y
>> CONFIG_COMMON_CLK_EYEQ=y
>> CONFIG_RPMSG_CHAR=y
>> CONFIG_RPMSG_CTRL=y
>> CONFIG_RPMSG_VIRTIO=y
>> CONFIG_RESET_CONTROLLER=y
>> CONFIG_RESET_SIMPLE=y
>> CONFIG_GENERIC_PHY=y
>> CONFIG_EXT4_FS=y
>> CONFIG_EXT4_FS_POSIX_ACL=y
>> CONFIG_EXT4_FS_SECURITY=y
>> CONFIG_MSDOS_FS=y
>> CONFIG_VFAT_FS=y
>> CONFIG_TMPFS=y
>> CONFIG_TMPFS_POSIX_ACL=y
>> CONFIG_HUGETLBFS=y
>> CONFIG_KEYS=y
>> CONFIG_SECURITY=y
>> CONFIG_SECURITYFS=y
>> CONFIG_SECURITY_NETWORK=y
>> CONFIG_SECURITY_PATH=y
>> CONFIG_CRYPTO_RSA=y
>> CONFIG_CRYPTO_ECB=y
>> CONFIG_CRYPTO_BLAKE2B=m
>> CONFIG_CRYPTO_XXHASH=m
>> CONFIG_CRYPTO_USER_API_HASH=y
>> CONFIG_CRC_CCITT=m
>> CONFIG_CRC_ITU_T=y
>> CONFIG_CRC7=y
>> CONFIG_LIBCRC32C=m
>> CONFIG_PRINTK_TIME=y
>> CONFIG_DYNAMIC_DEBUG=y
>> CONFIG_DEBUG_INFO_DWARF5=y
>> CONFIG_DEBUG_FS=y
>> CONFIG_DEBUG_PAGEALLOC=y
>> CONFIG_PTDUMP_DEBUGFS=y
>> CONFIG_SCHED_STACK_END_CHECK=y
>> CONFIG_DEBUG_VM=y
>> CONFIG_DEBUG_VM_PGFLAGS=y
>> CONFIG_DEBUG_MEMORY_INIT=y
>> CONFIG_DEBUG_PER_CPU_MAPS=y
>> CONFIG_SOFTLOCKUP_DETECTOR=y
>> CONFIG_WQ_WATCHDOG=y
>> CONFIG_DEBUG_RT_MUTEXES=y
>> CONFIG_DEBUG_SPINLOCK=y
>> CONFIG_DEBUG_ATOMIC_SLEEP=y
>> CONFIG_DEBUG_LIST=y
>> CONFIG_DEBUG_PLIST=y
>> CONFIG_DEBUG_SG=y
>> CONFIG_RCU_EQS_DEBUG=y
>> CONFIG_MEMTEST=y
>>
>>>> These failures occur consistently for addresses in the 0xffffffd000000000 region.
>>>
>>> FYI, this region is the direct mapping (see Documentation/arch/riscv/vm-layout.rst).
>>>
>>> Thanks,
>>>
>>> Alex
>>>
> Hi Alex!
>
> Do I have something to try or help to process this issue?
> maybe, can you give your Config and I will try it on my system?
> Any more information I can share?


So I'm able to reproduce your issue with your config, it only happens 
with kexec_load(), not kexec_file_load().

Your patch does not fix the problem for me, makedumpfile still fails. I 
spent quite some time looking for the code that parses the memory 
regions and exposes them as PT_LOAD segments in vmcore, but I did not 
find it, do you know where that happens for kexec_load()?

Thanks,

Alex


>
> Thanks a lot,
> Pnina
>
>>>> Upon inspection, we confirmed that the physical addresses corresponding to those virtual addresses are not present in the vmcore, as they fall under Reserved memory sections.
>>>> We tested a patch to kexec-tools that prevents exclusion of the Reserved-memblock section from the vmcore. With this patch, the issue no longer occurs, and crash analysis succeeds.
>>>> Note: I suspect the same issue exists on ARM64, as both the signal.c and kexec-tools implementations are similar.
>>>>
>>>>> Thanks!
>>>>> Björn
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

