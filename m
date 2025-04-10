Return-Path: <linux-kernel+bounces-597269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C90EEA83750
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 05:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC99F4A01C0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 03:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FB31F0998;
	Thu, 10 Apr 2025 03:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EyCnx1Dr"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37063B9;
	Thu, 10 Apr 2025 03:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744256776; cv=none; b=i5kQTJpv1VkOoJTjkaLI8M2Tb9dH6xzQdNRhs7z5gZ2NveYG/V56y8YYBi7gD/Y/4sYq+90DVZ7AdtR2XUZ814m3DEm3kjjA2RScmpUuHsTSVEGLck9+mGztjbM8AYH47sGKKFcNOpoPFHMPDs2fYiagbuZ+hHq37bK2pRl+P4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744256776; c=relaxed/simple;
	bh=XkAnvmsFoDxV2cICqM23oG076J05VqxxjGS98fi8Ows=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sYNT0TrAwkKBbJ2sJQxOsB271enmkSlwrtkXkyxt2vXohwa5TVKX7nCwzk9t6v+GKqeepYkUe2dC0tMtkS1FliXczZDEsxjDXeck2vUO53t6340Re8YxZHN2W8fdl14B4/96LWMF08TiSJjOQWUdfnrqHsCNH9N8AJwG71IgvRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EyCnx1Dr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539Kcxiq004650;
	Thu, 10 Apr 2025 03:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qeY40K
	cfg3vqEaQiu8oLFXPizAYYuMMFOFiNUXOhvUg=; b=EyCnx1DrpK2/C1hlwKbvqH
	FePHBfY8eo11KVmsgD2ByRrlcWvbdVXwxHIF4BBRciUrwprRLUpB3kHACpzcwe/B
	qV8ZlQvJP9sk4tjumzQDgo8y5QiKZ9dFGsA/jBrtI9rYB+u4saBYlgw49b0/Pz/d
	WuJFUWT075i5RVAEBwfo8m6ZbKEy5KD0TY/dn+KYhAHdUUTXRV5BUgo3qs56L/DO
	MVrpvWxBCd6zjjbYj6KFAmUAcLiWETwnv9mh9yNUw2e+Gf/xMeegtARujkZWsLBV
	G1rulMva4wN9heV01oss5FUOF2dlCo8VNrogI06ynwN1AVYz9ALXSRlNFcQjOEzQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45x0401yb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 03:46:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53A1B5N3029541;
	Thu, 10 Apr 2025 03:46:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45x1k71k9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 03:46:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53A3jxBl54591892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 03:45:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0771D20043;
	Thu, 10 Apr 2025 03:45:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5536B20040;
	Thu, 10 Apr 2025 03:45:57 +0000 (GMT)
Received: from [9.109.204.62] (unknown [9.109.204.62])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Apr 2025 03:45:57 +0000 (GMT)
Message-ID: <70ef4489-dc7c-49fe-ac8e-fc0fd58e2bab@linux.ibm.com>
Date: Thu, 10 Apr 2025 09:15:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: scomp - Fix null-pointer deref when freeing
 streams
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-crypto@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
References: <3c239727-6c46-45c2-80e7-d6853427f72c@linux.ibm.com>
 <Z_SkEnIWk8E0mLJf@gondor.apana.org.au>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <Z_SkEnIWk8E0mLJf@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: --Jy6UgJDcCTMr0Pz6LpJt1i3n7gWOXT
X-Proofpoint-GUID: --Jy6UgJDcCTMr0Pz6LpJt1i3n7gWOXT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_06,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504100024

Hi Herbert,


On 08/04/25 09:50, Herbert Xu wrote:
> On Mon, Apr 07, 2025 at 11:49:27PM +0530, Sourabh Jain wrote:
>> [   90.892796] NIP [c000000000845eb0] scomp_free_streams+0x6c/0xe8
>> [   90.892803] LR [c000000000845ee0] scomp_free_streams+0x9c/0xe8
> Looks like I never tested 842 which curiously does not have a
> self-test.  Please try this patch:
>
> ---8<---
> As the scomp streams are freed when an algorithm is unregistered,
> it is possible that the algorithm has never been used at all (e.g.,
> an algorithm that does not have a self-test).  So test whether the
> streams exist before freeing them.
>
> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Fixes: 3d72ad46a23a ("crypto: acomp - Move stream management into scomp layer")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> diff --git a/crypto/scompress.c b/crypto/scompress.c
> index d435d4b24469..f67ce38d203d 100644
> --- a/crypto/scompress.c
> +++ b/crypto/scompress.c
> @@ -111,6 +111,9 @@ static void scomp_free_streams(struct scomp_alg *alg)
>   	struct crypto_acomp_stream __percpu *stream = alg->stream;
>   	int i;
>   
> +	if (!stream)
> +		return;
> +
>   	for_each_possible_cpu(i) {
>   		struct crypto_acomp_stream *ps = per_cpu_ptr(stream, i);


The above fix doesn't apply cleanly on next-20250409.

Your changes are part of scomp_free_streams function but this function 
is not
their in next-20250409.


Also the issue reproducible on next-20250409, here is the backtrace:

5.955234] systemd-shutdown[1]: Syncing /dev/dm-1.
[   36.014414] systemd-shutdown[1]: Not all DM devices detached, 1 left.
[   36.014521] systemd-shutdown[1]: Detaching DM devices.
[   36.014789] systemd-shutdown[1]: Not all DM devices detached, 1 left.
[   36.014798] systemd-shutdown[1]: Cannot finalize remaining DM 
devices, continuing.
[   36.348709] systemd-shutdown[1]: Successfully changed into root pivot.
[   36.348726] systemd-shutdown[1]: Entering exitrd...
[   36.369754] dracut Warning: Killing all remaining processes
dracut Warning: Killing all remaining processes
[48;1R^[[48;213R[   36.389749] XFS (dm-0): Unmounting Filesystem 
256d3d13-3884-4ddd-a72e-82e0ebbd9475
[   36.392895] dracut Warning: Unmounted /oldroot.
dracut Warning: Unmounted /oldroot.
[   36.407513] dracut: Disassembling device-mapper devices
[   36.816091] Removing IBM Power 842 compression device
[   36.816132] ------------[ cut here ]------------
[   36.816137] WARNING: CPU: 47 PID: 2725 at kernel/workqueue.c:4205 
__flush_work+0x74/0x590
[   36.816150] Modules linked in: bonding tls rfkill ibmveth pseries_rng 
vmx_crypto sg fuse loop nfnetlink vsock_loopback 
vmw_vsock_virtio_transport_common vsock xfs sd_mod ibmvscsi 
scsi_transport_srp pseries_wdt dm_mirror dm_region_hash dm_log dm_mod
[   36.816180] CPU: 47 UID: 0 PID: 2725 Comm: kexec Not tainted 
6.15.0-rc1-next-20250409kexec-crypto-fix #19 VOLUNTARY
[   36.816188] Hardware name: IBM,9080-HEX POWER10 (architected) 
0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_012) hv:phyp pSeries
[   36.816195] NIP:  c000000000250384 LR: c00000000025035c CTR: 
0000000000000000
[   36.816200] REGS: c00000009e7eb5d0 TRAP: 0700   Not tainted 
(6.15.0-rc1-next-20250409kexec-crypto-fix)
[   36.816206] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE> CR: 
24088280  XER: 2004000a
[   36.816217] CFAR: c000000000180724 IRQMASK: 0
[   36.816217] GPR00: 0000000000000001 c00000009e7eb870 c000000001d58100 
c00000009e7eb890
[   36.816217] GPR04: 0000000000000000 0000000000000000 c00000009e7eb8d8 
0000000000000000
[   36.816217] GPR08: 0000000000000000 0000000000000001 0000000000000000 
0000000044088282
[   36.816217] GPR12: c00000000093c840 c0000003fdd81880 0000000000000000 
0000000000000000
[   36.816217] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[   36.816217] GPR20: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[   36.816217] GPR24: 0000000000000000 0000000000000000 0000000000000000 
c0000000030365f8
[   36.816217] GPR28: 0000000000000001 c000000002c06898 c000000002cca628 
c000000002cca628
[   36.816266] NIP [c000000000250384] __flush_work+0x74/0x590
[   36.816272] LR [c00000000025035c] __flush_work+0x4c/0x590
[   36.816276] Call Trace:
[   36.816279] [c00000009e7eb870] [c00000000024e694] 
__cancel_work+0xa4/0x180 (unreliable)
[   36.816286] [c00000009e7eb910] [c000000000251664] 
cancel_work_sync+0xa4/0xe0
[   36.816292] [c00000009e7eb940] [c00000000093af84] 
crypto_acomp_free_streams+0x44/0x120
[   36.816300] [c00000009e7eb990] [c00000000093c860] 
crypto_scomp_destroy+0x20/0x40
[   36.816306] [c00000009e7eb9b0] [c0000000009284a4] 
crypto_unregister_alg+0xf4/0x160
[   36.816314] [c00000009e7eba50] [c00000000093ca10] 
crypto_unregister_scomp+0x20/0x40
[   36.816320] [c00000009e7eba70] [c000000000e375b8] nx842_remove+0x8c/0x114
[   36.816328] [c00000009e7ebaf0] [c0000000001d3db0] 
vio_bus_remove+0x50/0xc0
[   36.816334] [c00000009e7ebb20] [c000000000c6bf4c] 
device_shutdown+0x21c/0x39c
[   36.816342] [c00000009e7ebbb0] [c0000000002657b0] 
kernel_restart_prepare+0x50/0x70
[   36.816349] [c00000009e7ebbd0] [c00000000038bf48] kernel_kexec+0xa8/0x110
[   36.816358] [c00000009e7ebc40] [c000000000265e44] 
__do_sys_reboot+0x204/0x2d0
[   36.816364] [c00000009e7ebda0] [c000000000030be8] 
system_call_exception+0x138/0x2d0
[   36.816372] [c00000009e7ebe50] [c00000000000cedc] 
system_call_vectored_common+0x15c/0x2ec
[   36.816380] --- interrupt: 3000 at 0x7fffb0c99d70
[   36.816389] NIP:  00007fffb0c99d70 LR: 00007fffb0c99d70 CTR: 
0000000000000000
[   36.816393] REGS: c00000009e7ebe80 TRAP: 3000   Not tainted 
(6.15.0-rc1-next-20250409kexec-crypto-fix)
[   36.816398] MSR:  800000000280f033 
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48022484  XER: 00000000
[   36.816413] IRQMASK: 0
[   36.816413] GPR00: 0000000000000058 00007fffe7ba4e50 0000000000100000 
fffffffffee1dead
[   36.816413] GPR04: 0000000028121969 0000000045584543 0000000000000000 
0000000000000003
[   36.816413] GPR08: 0000000000000004 0000000000000000 0000000000000000 
0000000000000000
[   36.816413] GPR12: 0000000000000000 00007fffb0f0b3c0 ffffffffffffffff 
0000000000000000
[   36.816413] GPR16: 0000000000000001 0000000000000002 0000000000000001 
0000000000000001
[   36.816413] GPR20: 0000000123c8f520 0000000000000000 0000000000000000 
0000000000000001
[   36.816413] GPR24: 0000000139a80480 0000000000000003 0000000000000003 
00007fffe7ba4f20
[   36.816413] GPR28: 0000000123c6a7b0 0000000123c6a7a8 00007fffb0d818d0 
0000000139a804a0
[   36.816460] NIP [00007fffb0c99d70] 0x7fffb0c99d70
[   36.816464] LR [00007fffb0c99d70] 0x7fffb0c99d70
[   36.816468] --- interrupt: 3000
[   36.816471] Code: 39200000 4bf302f1 60000000 3d22010c 8929b344 
69290001 0b090000 2c090000 408202e0 e95e0018 7d490074 7929d182 
<0b090000> 2c2a0000 418202c8 fba10088
[   36.816486] ---[ end trace 0000000000000000 ]---
[   36.816491] Kernel attempted to read user page (3faee0008) - exploit 
attempt? (uid: 0)
[   36.816498] BUG: Unable to handle kernel data access on read at 
0x3faee0008
[   36.816503] Faulting instruction address: 0xc00000000093afe0
[   36.816511] Oops: Kernel access of bad area, sig: 11 [#1]
[   36.816514] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
[   36.816519] Modules linked in: bonding tls rfkill ibmveth pseries_rng 
vmx_crypto sg fuse loop nfnetlink vsock_loopback 
vmw_vsock_virtio_transport_common vsock xfs sd_mod ibmvscsi 
scsi_transport_srp pseries_wdt dm_mirror dm_region_hash dm_log dm_mod
[   36.816539] CPU: 47 UID: 0 PID: 2725 Comm: kexec Tainted: G        
W           6.15.0-rc1-next-20250409kexec-crypto-fix #19 VOLUNTARY
[   36.816546] Tainted: [W]=WARN
[   36.816549] Hardware name: IBM,9080-HEX POWER10 (architected) 
0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_012) hv:phyp pSeries
[   36.816554] NIP:  c00000000093afe0 LR: c00000000093afb4 CTR: 
0000000000000000
[   36.816558] REGS: c00000009e7eb6a0 TRAP: 0300   Tainted: G 
W            (6.15.0-rc1-next-20250409kexec-crypto-fix)
[   36.816563] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE> CR: 
44088280  XER: 2004000a
[   36.816572] CFAR: c000000000a42b14 DAR: 00000003faee0008 DSISR: 
40000000 IRQMASK: 0
[   36.816572] GPR00: c00000000093af84 c00000009e7eb940 c000000001d58100 
0000000000000000
[   36.816572] GPR04: 0000000000000080 0000000000000000 0000000000000000 
ffffffffffffffff
[   36.816572] GPR08: c0000000017d11d8 00000003faee0000 0000000000000000 
0000000000008000
[   36.816572] GPR12: c000000000e37640 c0000003fdd81880 0000000000000000 
0000000000000000
[   36.816572] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[   36.816572] GPR20: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[   36.816572] GPR24: 0000000000000000 0000000000000000 0000000000000000 
c0000000017d11d8
[   36.816572] GPR28: 0000000000000000 c000000000e37640 c000000002d5c0f0 
0000000000000000
[   36.816620] NIP [c00000000093afe0] crypto_acomp_free_streams+0xa0/0x120
[   36.816624] LR [c00000000093afb4] crypto_acomp_free_streams+0x74/0x120
[   36.816630] Call Trace:
[   36.816632] [c00000009e7eb940] [c00000000093af84] 
crypto_acomp_free_streams+0x44/0x120 (unreliable)
[   36.816638] [c00000009e7eb990] [c00000000093c860] 
crypto_scomp_destroy+0x20/0x40
[   36.816644] [c00000009e7eb9b0] [c0000000009284a4] 
crypto_unregister_alg+0xf4/0x160
[   36.816650] [c00000009e7eba50] [c00000000093ca10] 
crypto_unregister_scomp+0x20/0x40
[   36.816656] [c00000009e7eba70] [c000000000e375b8] nx842_remove+0x8c/0x114
[   36.816662] [c00000009e7ebaf0] [c0000000001d3db0] 
vio_bus_remove+0x50/0xc0
[   36.816667] [c00000009e7ebb20] [c000000000c6bf4c] 
device_shutdown+0x21c/0x39c
[   36.816674] [c00000009e7ebbb0] [c0000000002657b0] 
kernel_restart_prepare+0x50/0x70
[   36.816680] [c00000009e7ebbd0] [c00000000038bf48] kernel_kexec+0xa8/0x110
[   36.816685] [c00000009e7ebc40] [c000000000265e44] 
__do_sys_reboot+0x204/0x2d0
[   36.816692] [c00000009e7ebda0] [c000000000030be8] 
system_call_exception+0x138/0x2d0
[   36.816698] [c00000009e7ebe50] [c00000000000cedc] 
system_call_vectored_common+0x15c/0x2ec
[   36.816705] --- interrupt: 3000 at 0x7fffb0c99d70
[   36.816708] NIP:  00007fffb0c99d70 LR: 00007fffb0c99d70 CTR: 
0000000000000000
[   36.816713] REGS: c00000009e7ebe80 TRAP: 3000   Tainted: G 
W            (6.15.0-rc1-next-20250409kexec-crypto-fix)
[   36.816719] MSR:  800000000280f033 
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48022484  XER: 00000000
[   36.816730] IRQMASK: 0
[   36.816730] GPR00: 0000000000000058 00007fffe7ba4e50 0000000000100000 
fffffffffee1dead
[   36.816730] GPR04: 0000000028121969 0000000045584543 0000000000000000 
0000000000000003
[   36.816730] GPR08: 0000000000000004 0000000000000000 0000000000000000 
0000000000000000
[   36.816730] GPR12: 0000000000000000 00007fffb0f0b3c0 ffffffffffffffff 
0000000000000000
[   36.816730] GPR16: 0000000000000001 0000000000000002 0000000000000001 
0000000000000001
[   36.816730] GPR20: 0000000123c8f520 0000000000000000 0000000000000000 
0000000000000001
[   36.816730] GPR24: 0000000139a80480 0000000000000003 0000000000000003 
00007fffe7ba4f20
[   36.816730] GPR28: 0000000123c6a7b0 0000000123c6a7a8 00007fffb0d818d0 
0000000139a804a0
[   36.816776] NIP [00007fffb0c99d70] 0x7fffb0c99d70
[   36.816780] LR [00007fffb0c99d70] 0x7fffb0c99d70
[   36.816784] --- interrupt: 3000
[   36.816786] Code: 48107aa1 60000000 813e0000 7faceb78 7c7f1b78 
7c6a1ef4 7c091840 4081005c 3d2200ff 39292568 7d29502a 7d29e214 
<e8690008> 2c230000 41820010 7fa903a6
[   36.816802] ---[ end trace 0000000000000000 ]---
[   36.819332] pstore: backend (nvram) writing error (-1)
[   36.819336]
[   37.819340] Kernel panic - not syncing: Fatal exce


It could be possible that the below commit is causing the conflict:

commit 42d9f6c774790d290c175e8775ce9f1366438098
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Wed Mar 19 14:04:52 2025 +0800

     crypto: acomp - Move scomp stream allocation code into acomp

     Move the dynamic stream allocation code into acomp and make it
     available as a helper for acomp algorithms.

     Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>


The above commit actually removes the scomp_free_streams function.

Thoughts?

Thanks,
Sourabh Jain





