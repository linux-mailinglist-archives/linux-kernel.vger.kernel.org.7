Return-Path: <linux-kernel+bounces-612176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D825A94BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 06:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300A13A1998
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 04:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52EA21CC54;
	Mon, 21 Apr 2025 04:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D4YT1QC/"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1260222083
	for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 04:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745208469; cv=none; b=G5AqWJw05fHRgWDCv0vELHCF5rR6JECm0xzWyrY7YjWOJ8fsfVsMSkN45HW7Umbt1rj0BF6Y7jSIB3xXS81tydq1ZS2u2aheRZdBGQfIFS0WlyW32kQZTprWXKo4RYCsmRh4UiK3AxrtY9voooG9ugISADhYB+BQ+xp7uieBUEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745208469; c=relaxed/simple;
	bh=qhVyi5NIjMRp3HvFSwxZ8QBaIujA7Z4UNdEqnwxzx/I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=hL4CokV77Y/PlMoEZTyqXXbEOzOwWKNn6ejetj87S9dyvmU/3v6iQPpqsepUurn4tnByWui1hYEor5Lvudam6bm+GOW4xFQo4X0KgTqD1bPVHsremRZ64RIJB5F5+RMCsv2nVZ30AXrZxq04Gyv5fcEFqMs7X7HoyOSd7XtcbkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D4YT1QC/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KNos3g002038;
	Mon, 21 Apr 2025 04:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=pp1;
	 bh=HRFUO9a1WSTf5uHZBKqj9EI8jZVn1hbbYyqsjg816SI=; b=D4YT1QC/t0pz
	7dP7RjNMlFKCoMGULcDMxecPbOddU0uYONu9H2FjuTYtwU8huYOk3PWMUQrShFNG
	R3qicDNAswDrRUsOTc5EkzbYqRTFMdvLURPEkTiMJFXXpnCPbXzkesAtc+XGxVYd
	47Ugk8yPDK0vvDlWlw4XfUoe129d1QwSJV7hreZUKKom5gsY0zUxEcGxaOcgyuMa
	qeR4RzX0PyLXnA/RCnQCgRffpK1vCbqIvLyviq7G7MpKhn9ehq1mJpk0TvGVvl+6
	8bjyUXm/JPLPQHRW39CI2xorC2+TuLmEJNhIYkgXd9Vbw2/gC+7jcWU7Q2s8Y21+
	S3jQ5UonZQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4658gk15g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 04:07:23 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53L41tUv019208;
	Mon, 21 Apr 2025 04:07:22 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4658gk15fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 04:07:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53L1o6F6032587;
	Mon, 21 Apr 2025 04:07:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 464phycub7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 04:07:21 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53L47H7N38666508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 04:07:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EDA120043;
	Mon, 21 Apr 2025 04:07:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9262820040;
	Mon, 21 Apr 2025 04:07:15 +0000 (GMT)
Received: from dw-tp (unknown [9.204.200.111])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 21 Apr 2025 04:07:15 +0000 (GMT)
From: Ritesh Harjani (IBM) <riteshh@linux.ibm.com>
To: Misbah Anjum N <misanjum@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG][powerpc] OOPs: Kernel access of bad area during zram swap write - kswapd0 crash
In-Reply-To: <89bfdedb74416156423d36d28c5b92e9@linux.ibm.com>
Date: Mon, 21 Apr 2025 09:19:50 +0530
Message-ID: <87ldrujhr5.fsf@gmail.com>
References: <89bfdedb74416156423d36d28c5b92e9@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fbKQvrz3Qgxv3fye5tTAgqddksCXgoui
X-Authority-Analysis: v=2.4 cv=Xv/6OUF9 c=1 sm=1 tr=0 ts=6805c47b cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=XR8D0OoHHMoA:10 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=yIKW3ajNzEgG7qbgV0IA:9
X-Proofpoint-ORIG-GUID: vP7bf7UDbwwfu8oe7cgjLe_qJAghOrC3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_02,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 clxscore=1011
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210029
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


++ linux-mm

Misbah Anjum N <misanjum@linux.ibm.com> writes:

> Bug Description:
> When running Avocado-VT based functional tests on KVM guest, the system 
> encounters a
> kernel panic and crash during memory reclaim activity when zram is 
> actively used for
> swap. The crash occurs in the kswapd0 kernel thread during what appears 
> to be a write
> operation to zram.
>
>
> Steps to Reproduce:
> 1. Compile Upstream Kernel on LPAR
> 2. Compile Qemu, Libvirt for KVM Guest
> 3. Run Functional tests on KVM guest using Avocado-VT Regression Bucket
>      a. Clone: git clone https://github.com/lop-devops/tests.git
>      b. Setup: python3 avocado-setup.py --bootstrap --enable-kvm 
> --install-deps
>      c. Add guest in folder: tests/data/avocado-vt/images/
>      d. Run: python3 avocado-setup.py --run-suite guest_regression 
> --guest-os\
>              <Guest-name> --only-filter 'virtio_scsi virtio_net qcow2'\
>              --no-download
>
> The bug is reproducible when Avocado-VT Regression bucket is executed 
> which
> consists of series of functional tp-libvirt tests performed on the KVM 
> guest in the
> following order: cpu, memory, network, storage and hotplug (disk, change 
> media,
> libvirt_mem), etc.
> Whilst execution, the system crashes during test:
> io-github-autotest-libvirt.libvirt_mem.positive_test.mem_basic.cold_plug_discard
> Note: This does not appear to be caused by a single test, but by 
> cumulative
> operations during the test sequence.
>
>
> Environment Details:
>      Kernel: 6.15.0-rc1-g521d54901f98
>      Reproducible with: 6.15.0-rc2-gf3a2e2a79c9d


Looks like the issue is happening on 6.15-rc2. Did git bisect revealed a
faulty commit?


>      Platform: IBM POWER10 LPAR (ppc64le)
>      Distro: Fedora42
>      RAM: 64GB
>      CPUs: 80
>      Qemu: 9.2.93 (v10.0.0-rc3-10-g8bdd3a0308)
>      Libvirt: 11.3.0
>
>
> System Memory State:
>      # free -mh
>                      total        used        free      shared  
> buff/cache   available
>          Mem:            61Gi       3.0Gi        25Gi        11Mi        
> 33Gi        58Gi
>          Swap:          8.0Gi          0B       8.0Gi
>      # zramctl
>          NAME       ALGORITHM DISKSIZE DATA COMPR TOTAL STREAMS 
> MOUNTPOINT
>          /dev/zram0 lzo-rle         8G  64K  222B  128K         [SWAP]
>      # swapon --show
>          NAME       TYPE      SIZE USED PRIO
>          /dev/zram0 partition   8G   0B  100
>
>
> Call Trace:
> [180060.602200] BUG: Unable to handle kernel data access on read at 
> 0xc00800000a1b0000
> [180060.602219] Faulting instruction address: 0xc000000000175670
> [180060.602224] Oops: Kernel access of bad area, sig: 11 [#1]
> [180060.602227] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=2048 NUMA 
> pSeries
> [180060.602232] Modules linked in: dm_thin_pool dm_persistent_data 
> vmw_vsock_virtio_transport_common vsock zram xfs dm_service_time sd_mod 
> [180060.602345] CPU: 68 UID: 0 PID: 465 Comm: kswapd0 Kdump: loaded Not 
> tainted
> 6.15.0-rc1-g521d54901f98 #1 VOLUNTARY
> [180060.602351] Hardware name: IBM,9080-HEX POWER10 (architected) 
> 0x800200 0xf000006 of:IBM,FW1060.21
> (NH1060_078) hv:phyp pSeries
> [180060.602355] NIP:  c000000000175670 LR: c0000000006d96b4 CTR: 
> 01fffffffffffc05
> [180060.602358] REGS: c0000000a5a56da0 TRAP: 0300   Not tainted  
> (6.15.0-rc1-g521d54901f98)
> [180060.602362] MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 
> 44042880  XER: 20040001
> [180060.602370] CFAR: c0000000001756c8 DAR: c00800000a1b0000 DSISR: 
> 40000000 IRQMASK: 0
<...>
>
>
> Crash Utility Output:
> # crash /home/kvmci/linux/vmlinux vmcore
> crash 8.0.6-4.fc42
>
>        KERNEL: /home/kvmci/linux/vmlinux  [TAINTED]
>      DUMPFILE: vmcore  [PARTIAL DUMP]
>          CPUS: 80
>          DATE: Wed Dec 31 18:00:00 CST 1969
>        UPTIME: 2 days, 02:01:00
> LOAD AVERAGE: 0.72, 0.66, 0.64
>         TASKS: 1249
>      NODENAME: ***
>       RELEASE: 6.15.0-rc1-g521d54901f98
>       VERSION: #1 SMP Wed Apr  9 05:13:03 CDT 2025
>       MACHINE: ppc64le  (3450 Mhz)
>        MEMORY: 64 GB
>         PANIC: "Oops: Kernel access of bad area, sig: 11 [#1]" (check log 
> for details)
>           PID: 465
>       COMMAND: "kswapd0"
>          TASK: c000000006067d80  [THREAD_INFO: c000000006067d80]
>           CPU: 68
>         STATE: TASK_RUNNING (PANIC)
>
> crash> bt
> PID: 465      TASK: c000000006067d80  CPU: 68   COMMAND: "kswapd0"
>   R0:  000000000e000000    R1:  c0000000a5a57040    R2:  c0000000017a8100
>   R3:  c000000d34cefd00    R4:  c00800000a1affe8    R5:  fffffffffffffffa
>   R6:  01ffffffffffffff    R7:  03ffffff2cb33000    R8:  0000000080000000
>   R9:  0000000000000010    R10: 0000000000000020    R11: 0000000000000030
>   R12: 0000000000000040    R13: c000000ffde34300    R14: 0000000000000050
>   R15: 0000000000000060    R16: 0000000000000070    R17: 5deadbeef0000122
>   R18: 0000000101124ad9    R19: 0000000000018028    R20: 0000000000c01400
>   R21: c0000000a5a574b0    R22: 0000000000010000    R23: 0000000000000051
>   R24: c000000002be02f8    R25: c00c000003ef7380    R26: c00800000a190000
>   R27: c0000001054dbbe0    R28: c00c0000034d3340    R29: 00000000000002d8
>   R30: fffffffffffffffa    R31: c0000001054dbbb0
>   NIP: c000000000175670    MSR: 8000000002009033    OR3: c0000000001756c8
>   CTR: 01fffffffffffc05    LR:  c0000000006d96b4    XER: 0000000020040001
>   CCR: 0000000044042880    MQ:  0000000000000000    DAR: c00800000a1b0000
>   DSISR: 0000000040000000     Syscall Result: 0000000000000000
>   [NIP  : memcpy_power7+1648]
>   [LR   : zs_obj_write+548]
>   #0 [c0000000a5a56c50] crash_kexec at c00000000037f268
>   #1 [c0000000a5a56c80] oops_end at c00000000002b678
>   #2 [c0000000a5a56d00] __bad_page_fault at c00000000014f348
>   #3 [c0000000a5a56d70] data_access_common_virt at c000000000008be0
>   #4 [c0000000a5a57040] memcpy_power7 at c000000000175274
>   #5 [c0000000a5a57140] zs_obj_write at c0000000006d96b4

Looks like zsmalloc new object mapping API being called, which was
merged in rc1?  But let's first confirm from git bisect, unless someone
from linux-mm who knows zsmalloc subsystem better and can point on what
could be going wrong here.


>   #6 [c0000000a5a571b0] zram_write_page at c008000009174a50 [zram]
>   #7 [c0000000a5a57260] zram_bio_write at c008000009174ff4 [zram]
>   #8 [c0000000a5a57310] __submit_bio at c0000000009323ac
>   #9 [c0000000a5a573a0] __submit_bio_noacct at c000000000932614
> #10 [c0000000a5a57410] submit_bio_wait at c000000000926d34
> #11 [c0000000a5a57480] swap_writepage_bdev_sync at c00000000065ab5c
> #12 [c0000000a5a57540] swap_writepage at c00000000065b90c
> #13 [c0000000a5a57570] shmem_writepage at c0000000005ada30
> #14 [c0000000a5a57630] pageout at c00000000059d700
> #15 [c0000000a5a57850] shrink_folio_list at c00000000059eafc
> #16 [c0000000a5a57aa0] shrink_inactive_list at c0000000005a0b38
> #17 [c0000000a5a57b70] shrink_lruvec at c0000000005a12a0
> #18 [c0000000a5a57c80] shrink_node_memcgs at c0000000005a16f4
> #19 [c0000000a5a57d00] shrink_node at c0000000005a183c
> #20 [c0000000a5a57d80] balance_pgdat at c0000000005a24e0
> #21 [c0000000a5a57ef0] kswapd at c0000000005a2b50
> #22 [c0000000a5a57f80] kthread at c00000000026ea68
> #23 [c0000000a5a57fe0] start_kernel_thread at c00000000000df98
>

-ritesh

