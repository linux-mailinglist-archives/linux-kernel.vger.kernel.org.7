Return-Path: <linux-kernel+bounces-612027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4E6A94997
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Apr 2025 22:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983081890AE6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Apr 2025 20:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59891D79B8;
	Sun, 20 Apr 2025 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WbRmDCR0"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4E53FC7
	for <linux-kernel@vger.kernel.org>; Sun, 20 Apr 2025 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745181720; cv=none; b=WhmfsAViq2rsBMhC0BveyHgnIjq7WbjI05nRDDThO0P1wS29brE+OOouZCbZlZT5W2oZfAEf1uo2gFaySy4nwODUnlGPewOcpaJ5x4kkzpIXFc+Hk7PDH9clY5zP6pbC39m3frLGCxf3tI86PBWWnM0IEh6voul7WKJoiyohSNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745181720; c=relaxed/simple;
	bh=XK8HEqDcimlmTcihmL3GPtM0jfToct0zLPpWXwcxe50=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=s9Km6PkNyWbzu9s/mh+jaAANN2gRckMHsZF8aW8yhUt4vCOwvNu5IbttHH5eaBuE/TkJjs4yLL53CmwXaBHDtcJuUMEAMVeH9bN/oW2ShQymNsRA0way+fl42ZWEVZPVFGeGaSl4nyc8dKp+Qk8pB0JHBxipF9TZoX8Y47nsZt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WbRmDCR0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KAxlsr007039;
	Sun, 20 Apr 2025 20:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=V+5KCxVUP22yoKn+8q64easFm8gl
	/xpafJ8bCS+8sCk=; b=WbRmDCR0HhrxMBq5yS1ZKIwjDxxijXwDK172W9m3Kuqm
	HkR1SGazKg2H2KittXzC1wqpxYWYPwfTkAKFy4HIoRQp0dAH2Msy1jxHdhWa9Axe
	Tk+SI2u/MhkXLnjrZAGm5qfSPE7vLqmTtZB0vGAwSPdEIUtyeywRbKl+K2Cl5a09
	WdlIJ8XRvar+fuP/Qel97v7A1z2BjRQ+jVcUqWV5aPRKl18LXwtkRr2nhgJQUwHv
	aen0QM8sJTSL27kLyUlRqXSuCyAjqvJNudaMgD0DpX2DTxNxe/9IFLnGTtjqOQAu
	XvIObFKbbLeK2ck/Hq551KttfkfpFbdIt4Bx193v8w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 464kyv2yr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Apr 2025 20:41:35 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53KKfZqK002672;
	Sun, 20 Apr 2025 20:41:35 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 464kyv2yr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Apr 2025 20:41:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53KIfcHA028188;
	Sun, 20 Apr 2025 20:41:34 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 464rv1tyq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Apr 2025 20:41:34 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53KKfX2d30278150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Apr 2025 20:41:33 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DBFF58052;
	Sun, 20 Apr 2025 20:41:33 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E09605805A;
	Sun, 20 Apr 2025 20:41:32 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 20 Apr 2025 20:41:32 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Apr 2025 02:11:32 +0530
From: Misbah Anjum N <misanjum@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [BUG][powerpc] OOPs: Kernel access of bad area during zram swap write
 - kswapd0 crash
Message-ID: <89bfdedb74416156423d36d28c5b92e9@linux.ibm.com>
X-Sender: misanjum@linux.ibm.com
Organization: IBM
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TIiBd-8zE3LyvnBklhUrdXuz20CXG08o
X-Proofpoint-ORIG-GUID: 5NEcexLDHB0FR8CpvRwJUfgoDINgK3jb
X-Authority-Analysis: v=2.4 cv=c8KrQQ9l c=1 sm=1 tr=0 ts=68055bff cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=NEAV23lmAAAA:8 a=6RsTFN_rFLdIBpCPd1AA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-20_09,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504200169

Bug Description:
When running Avocado-VT based functional tests on KVM guest, the system 
encounters a
kernel panic and crash during memory reclaim activity when zram is 
actively used for
swap. The crash occurs in the kswapd0 kernel thread during what appears 
to be a write
operation to zram.


Steps to Reproduce:
1. Compile Upstream Kernel on LPAR
2. Compile Qemu, Libvirt for KVM Guest
3. Run Functional tests on KVM guest using Avocado-VT Regression Bucket
     a. Clone: git clone https://github.com/lop-devops/tests.git
     b. Setup: python3 avocado-setup.py --bootstrap --enable-kvm 
--install-deps
     c. Add guest in folder: tests/data/avocado-vt/images/
     d. Run: python3 avocado-setup.py --run-suite guest_regression 
--guest-os\
             <Guest-name> --only-filter 'virtio_scsi virtio_net qcow2'\
             --no-download

The bug is reproducible when Avocado-VT Regression bucket is executed 
which
consists of series of functional tp-libvirt tests performed on the KVM 
guest in the
following order: cpu, memory, network, storage and hotplug (disk, change 
media,
libvirt_mem), etc.
Whilst execution, the system crashes during test:
io-github-autotest-libvirt.libvirt_mem.positive_test.mem_basic.cold_plug_discard
Note: This does not appear to be caused by a single test, but by 
cumulative
operations during the test sequence.


Environment Details:
     Kernel: 6.15.0-rc1-g521d54901f98
     Reproducible with: 6.15.0-rc2-gf3a2e2a79c9d
     Platform: IBM POWER10 LPAR (ppc64le)
     Distro: Fedora42
     RAM: 64GB
     CPUs: 80
     Qemu: 9.2.93 (v10.0.0-rc3-10-g8bdd3a0308)
     Libvirt: 11.3.0


System Memory State:
     # free -mh
                     total        used        free      shared  
buff/cache   available
         Mem:            61Gi       3.0Gi        25Gi        11Mi        
33Gi        58Gi
         Swap:          8.0Gi          0B       8.0Gi
     # zramctl
         NAME       ALGORITHM DISKSIZE DATA COMPR TOTAL STREAMS 
MOUNTPOINT
         /dev/zram0 lzo-rle         8G  64K  222B  128K         [SWAP]
     # swapon --show
         NAME       TYPE      SIZE USED PRIO
         /dev/zram0 partition   8G   0B  100


Call Trace:
[180060.602200] BUG: Unable to handle kernel data access on read at 
0xc00800000a1b0000
[180060.602219] Faulting instruction address: 0xc000000000175670
[180060.602224] Oops: Kernel access of bad area, sig: 11 [#1]
[180060.602227] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=2048 NUMA 
pSeries
[180060.602232] Modules linked in: dm_thin_pool dm_persistent_data 
dm_bio_prison dm_zero
dm_snapshot dm_bufio nfsv4 dns_resolver nfs netfs vfat fat openvswitch 
nf_conncount psample
act_police sch_ingress cls_fw sch_sfq xt_set ip_set_hash_ip ip_set ext4 
crc16 mbcache jbd2
target_core_pscsi target_core_file target_core_iblock ebt_arp ebt_ip 
xt_sctp xt_conntrack
xt_dscp br_netfilter nft_meta_bridge xt_physdev nft_compat 
iscsi_target_mod target_core_user
target_core_mod nvram rpcsec_gss_krb5 binfmt_misc vhost_net vhost 
vhost_iotlb tap tun kvm_hv
kvm nft_masq nft_ct nft_reject_ipv4 nf_reject_ipv4 nft_reject act_csum 
cls_u32 sch_htb
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 
nf_tables bridge stp llc
rpcrdma rdma_cm iw_cm ib_cm ib_core bonding rfkill nfsd auth_rpcgss 
nfs_acl lockd grace
pseries_rng vmx_crypto drm loop drm_panel_orientation_quirks nfnetlink 
vsock_loopback
vmw_vsock_virtio_transport_common vsock zram xfs dm_service_time sd_mod 
ibmvscsi ibmveth
scsi_transport_srp ipr btrfs blake2b_generic xor
[180060.602306]  raid6_pq zstd_compress sunrpc dm_mirror dm_region_hash 
dm_log be2iscsi bnx2i
cnic uio cxgb4i cxgb4 tls libcxgbi libcxgb qla4xxx iscsi_boot_sysfs 
iscsi_tcp libiscsi_tcp
libiscsi scsi_transport_iscsi dm_multipath fuse dm_mod [last unloaded: 
ipmi_msghandler]
[180060.602345] CPU: 68 UID: 0 PID: 465 Comm: kswapd0 Kdump: loaded Not 
tainted
6.15.0-rc1-g521d54901f98 #1 VOLUNTARY
[180060.602351] Hardware name: IBM,9080-HEX POWER10 (architected) 
0x800200 0xf000006 of:IBM,FW1060.21
(NH1060_078) hv:phyp pSeries
[180060.602355] NIP:  c000000000175670 LR: c0000000006d96b4 CTR: 
01fffffffffffc05
[180060.602358] REGS: c0000000a5a56da0 TRAP: 0300   Not tainted  
(6.15.0-rc1-g521d54901f98)
[180060.602362] MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 
44042880  XER: 20040001
[180060.602370] CFAR: c0000000001756c8 DAR: c00800000a1b0000 DSISR: 
40000000 IRQMASK: 0
[180060.602370] GPR00: 000000000e000000 c0000000a5a57040 
c0000000017a8100 c000000d34cefd00
[180060.602370] GPR04: c00800000a1affe8 fffffffffffffffa 
01ffffffffffffff 03ffffff2cb33000
[180060.602370] GPR08: 0000000080000000 0000000000000010 
0000000000000020 0000000000000030
[180060.602370] GPR12: 0000000000000040 c000000ffde34300 
0000000000000050 0000000000000060
[180060.602370] GPR16: 0000000000000070 5deadbeef0000122 
0000000101124ad9 0000000000018028
[180060.602370] GPR20: 0000000000c01400 c0000000a5a574b0 
0000000000010000 0000000000000051
[180060.602370] GPR24: c000000002be02f8 c00c000003ef7380 
c00800000a190000 c0000001054dbbe0
[180060.602370] GPR28: c00c0000034d3340 00000000000002d8 
fffffffffffffffa c0000001054dbbb0
[180060.602410] NIP [c000000000175670] memcpy_power7+0x670/0x7d0
[180060.602417] LR [c0000000006d96b4] zs_obj_write+0x224/0x290
[180060.602422] Call Trace:
[180060.602424] [c0000000a5a57040] [c000000000175274] 
memcpy_power7+0x274/0x7d0 (unreliable)
[180060.602430] [c0000000a5a57140] [c0000000006d96b4] 
zs_obj_write+0x224/0x290
[180060.602435] [c0000000a5a571b0] [c008000009174a50] 
zram_write_page+0x298/0x530 [zram]
[180060.602442] [c0000000a5a57260] [c008000009174ff4] 
zram_bio_write+0x1cc/0x2b0 [zram]
[180060.602446] [c0000000a5a57310] [c0000000009323ac] 
__submit_bio+0x15c/0x340
[180060.602451] [c0000000a5a573a0] [c000000000932614] 
__submit_bio_noacct+0x84/0x240
[180060.602456] [c0000000a5a57410] [c000000000926d34] 
submit_bio_wait+0x74/0x110
[180060.602461] [c0000000a5a57480] [c00000000065ab5c] 
swap_writepage_bdev_sync+0xec/0x140
[180060.602467] [c0000000a5a57540] [c00000000065b90c] 
swap_writepage+0x21c/0x2b0
[180060.602471] [c0000000a5a57570] [c0000000005ada30] 
shmem_writepage+0x4a0/0x640
[180060.602476] [c0000000a5a57630] [c00000000059d700] 
pageout+0x1d0/0x440
[180060.602480] [c0000000a5a57850] [c00000000059eafc] 
shrink_folio_list+0x7cc/0x1150
[180060.602484] [c0000000a5a57aa0] [c0000000005a0b38] 
shrink_inactive_list+0x278/0x6f0
[180060.602488] [c0000000a5a57b70] [c0000000005a12a0] 
shrink_lruvec+0x2f0/0x470
[180060.602492] [c0000000a5a57c80] [c0000000005a16f4] 
shrink_node_memcgs+0x2d4/0x360
[180060.602497] [c0000000a5a57d00] [c0000000005a183c] 
shrink_node+0xbc/0x4e0
[180060.602500] [c0000000a5a57d80] [c0000000005a24e0] 
balance_pgdat+0x4b0/0xa00
[180060.602504] [c0000000a5a57ef0] [c0000000005a2b50] kswapd+0x120/0x260
[180060.602508] [c0000000a5a57f80] [c00000000026ea68] 
kthread+0x168/0x180
[180060.602512] [c0000000a5a57fe0] [c00000000000df98] 
start_kernel_thread+0x14/0x18
[180060.602516] Code: 39c00050 39e00060 3a000070 7cc903a6 60000000 
60000000 60000000 60000000
7ce020ce 1107042b 7cc448ce 11263c2b <7ca450ce> 1145342b 7c8458ce 
11642c2b
[180060.602529] ---[ end trace 0000000000000000 ]---


Crash Utility Output:
# crash /home/kvmci/linux/vmlinux vmcore
crash 8.0.6-4.fc42

       KERNEL: /home/kvmci/linux/vmlinux  [TAINTED]
     DUMPFILE: vmcore  [PARTIAL DUMP]
         CPUS: 80
         DATE: Wed Dec 31 18:00:00 CST 1969
       UPTIME: 2 days, 02:01:00
LOAD AVERAGE: 0.72, 0.66, 0.64
        TASKS: 1249
     NODENAME: ***
      RELEASE: 6.15.0-rc1-g521d54901f98
      VERSION: #1 SMP Wed Apr  9 05:13:03 CDT 2025
      MACHINE: ppc64le  (3450 Mhz)
       MEMORY: 64 GB
        PANIC: "Oops: Kernel access of bad area, sig: 11 [#1]" (check log 
for details)
          PID: 465
      COMMAND: "kswapd0"
         TASK: c000000006067d80  [THREAD_INFO: c000000006067d80]
          CPU: 68
        STATE: TASK_RUNNING (PANIC)

crash> bt
PID: 465      TASK: c000000006067d80  CPU: 68   COMMAND: "kswapd0"
  R0:  000000000e000000    R1:  c0000000a5a57040    R2:  c0000000017a8100
  R3:  c000000d34cefd00    R4:  c00800000a1affe8    R5:  fffffffffffffffa
  R6:  01ffffffffffffff    R7:  03ffffff2cb33000    R8:  0000000080000000
  R9:  0000000000000010    R10: 0000000000000020    R11: 0000000000000030
  R12: 0000000000000040    R13: c000000ffde34300    R14: 0000000000000050
  R15: 0000000000000060    R16: 0000000000000070    R17: 5deadbeef0000122
  R18: 0000000101124ad9    R19: 0000000000018028    R20: 0000000000c01400
  R21: c0000000a5a574b0    R22: 0000000000010000    R23: 0000000000000051
  R24: c000000002be02f8    R25: c00c000003ef7380    R26: c00800000a190000
  R27: c0000001054dbbe0    R28: c00c0000034d3340    R29: 00000000000002d8
  R30: fffffffffffffffa    R31: c0000001054dbbb0
  NIP: c000000000175670    MSR: 8000000002009033    OR3: c0000000001756c8
  CTR: 01fffffffffffc05    LR:  c0000000006d96b4    XER: 0000000020040001
  CCR: 0000000044042880    MQ:  0000000000000000    DAR: c00800000a1b0000
  DSISR: 0000000040000000     Syscall Result: 0000000000000000
  [NIP  : memcpy_power7+1648]
  [LR   : zs_obj_write+548]
  #0 [c0000000a5a56c50] crash_kexec at c00000000037f268
  #1 [c0000000a5a56c80] oops_end at c00000000002b678
  #2 [c0000000a5a56d00] __bad_page_fault at c00000000014f348
  #3 [c0000000a5a56d70] data_access_common_virt at c000000000008be0
  #4 [c0000000a5a57040] memcpy_power7 at c000000000175274
  #5 [c0000000a5a57140] zs_obj_write at c0000000006d96b4
  #6 [c0000000a5a571b0] zram_write_page at c008000009174a50 [zram]
  #7 [c0000000a5a57260] zram_bio_write at c008000009174ff4 [zram]
  #8 [c0000000a5a57310] __submit_bio at c0000000009323ac
  #9 [c0000000a5a573a0] __submit_bio_noacct at c000000000932614
#10 [c0000000a5a57410] submit_bio_wait at c000000000926d34
#11 [c0000000a5a57480] swap_writepage_bdev_sync at c00000000065ab5c
#12 [c0000000a5a57540] swap_writepage at c00000000065b90c
#13 [c0000000a5a57570] shmem_writepage at c0000000005ada30
#14 [c0000000a5a57630] pageout at c00000000059d700
#15 [c0000000a5a57850] shrink_folio_list at c00000000059eafc
#16 [c0000000a5a57aa0] shrink_inactive_list at c0000000005a0b38
#17 [c0000000a5a57b70] shrink_lruvec at c0000000005a12a0
#18 [c0000000a5a57c80] shrink_node_memcgs at c0000000005a16f4
#19 [c0000000a5a57d00] shrink_node at c0000000005a183c
#20 [c0000000a5a57d80] balance_pgdat at c0000000005a24e0
#21 [c0000000a5a57ef0] kswapd at c0000000005a2b50
#22 [c0000000a5a57f80] kthread at c00000000026ea68
#23 [c0000000a5a57fe0] start_kernel_thread at c00000000000df98


Thank you,
Misbah Anjum N

