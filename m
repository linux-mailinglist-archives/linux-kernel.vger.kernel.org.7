Return-Path: <linux-kernel+bounces-845330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A70D7BC4785
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B3A3AFEA8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5629B2F6175;
	Wed,  8 Oct 2025 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CqKxEpgi"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DBE241663
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921050; cv=none; b=ViTjNWWs/ApCFEr2Ggr5dUB8SutGbfufqQYoCSnfRgrA/ojpTKQGa0nAKcvmv49gH7G/yCtS06Iy/TfS0gCp1Ze8mORx0qWno3hnIOJJ+eN3ae9zc8711fmACdQTMA/Zi3SKS8iHDIdMq2tHKCFrIDgQqQU2MCaSbIq3s4rhpUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921050; c=relaxed/simple;
	bh=ySRwBlWziiemGmyaxTBDp24sJLqPLKFp+CfUmRNo7sk=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=SaL2Mo4GVwApAJMFQtG4vtMup7ECVgPVpYfX1An+iKYUYmznKIr6yyyAIWBS+hgO0bqMV7cqrEGuChGRGBAsZR7qn3X1NoVCWFIPbsqV6ysCExkfSGTgp14qXnEHbQdbYGdWT/yevUAh1gPaqc/gB1xwdY5pRrOpMUJcux4ImD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CqKxEpgi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5981TICi026908;
	Wed, 8 Oct 2025 10:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=p8NSbWm9IEoYi5uQFkj/3P7IK5Hr
	ivY02JEHQjt4EiA=; b=CqKxEpgi3tQ7etqpaMuaYxz91raHFQmYVrMHxNooR3qT
	eE7e+hg2uE3XlVkDJK2a2+rWRNOs2nF2KwrZke6ADO4N7mlWIYkIaa3RwG77W0HZ
	IHtkpVMUyzLikAh1xb2pSot1UakYlHjwb4S8bWSvgas0bg8fY5TD/5JwKiVIJkdK
	hyE+tkGrfvSKBy0ivoLvNKHJiGdle9XyiPKGC9kv9xhriQnGPbzMqFndM7N2nPvs
	D9lZqFpBlYcCdJiJ+Zg8tkBRGXFGG23xwr681nPhGPoOKRGgu3r5y3B3Lj7jOMwt
	+VBZx+CfkAL29BHW8gbGPXrQsBIh/3W8rNP5ziFTTg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49jt0pky90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 10:57:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59894wPv000875;
	Wed, 8 Oct 2025 10:57:06 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49ke9y87d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 10:57:06 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 598Av4qT18023130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Oct 2025 10:57:05 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBAF258059;
	Wed,  8 Oct 2025 10:57:04 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E17C58063;
	Wed,  8 Oct 2025 10:57:03 +0000 (GMT)
Received: from [9.98.109.65] (unknown [9.98.109.65])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Oct 2025 10:57:02 +0000 (GMT)
Message-ID: <878d7651-433a-46fe-a28b-1b7e893fcbe0@linux.ibm.com>
Date: Wed, 8 Oct 2025 16:27:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: namcao@linutronix.de, Madhavan Srinivasan <maddy@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Gautam Menghani <gautam@linux.ibm.com>
Subject: [bisected][mainline]Kernel OOPs at msi_desc_to_pci_dev
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XvT3+FF9 c=1 sm=1 tr=0 ts=68e64383 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=bC-a23v3AAAA:8 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=hGzw-44bAAAA:8 a=LQ17Lw9wAAAA:8 a=7SvweCavL4N-QW0_bQoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
 a=HvKuF1_PTVFglORKqfwH:22 a=j77vJcMW1SzrPxEKBuqB:22 a=poXaRoVlC6wW9_mwW8W4:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-ORIG-GUID: krJpq2lmt3FxVw9ixvNVUoOnut--x046
X-Proofpoint-GUID: krJpq2lmt3FxVw9ixvNVUoOnut--x046
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwOSBTYWx0ZWRfX19SnQfQYzMsi
 CZyqrdxSi0JdkyJVU+JQwzWzAtkx1JS4gRXH4+KE4UFafZYUCVXR05yn/h7w8oW4kypOy7gDg/7
 9ZXMJLCqaki6UMxxSma2hhhbkt9y/K8GzceP/hUAmWNG7jp4Jl14ipaJPcQmi2hOpbPSrzAQMk/
 kfbdrFbVRD6Zhxt55MxYRjn3zhRjvixlZNkHpWtnBpzQr8XmpkeIakpJGpn03hE5slgxWLU6aTj
 3dU7zEJc/Mcv1PeOR8nd0diJU/7iUIoaJSelZvoe5zDFMtSbl5htNSGo3t/9fuiI5xFIO4HgNg4
 49em3LwA5M26OAM/giNJ6+Fjk7hcsRW5Kp3KA8/cziFOg68fmAbZmPlD7OyKL03rkH5mbIK7TKP
 2JtEqcMpRoiYAbRtUfZbiKzY31/4Rw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040009

Greetings!!


IBM CI has reported a kernel crash while running module load and unload 
testing on lpfc driver.


Traces:


[  177.928316] BUG: Kernel NULL pointer dereference on read at 0x00000008
[  177.928323] Faulting instruction address: 0xc0000000009c5d68
[  177.928331] Oops: Kernel access of bad area, sig: 11 [#1]
[  177.928337] LE PAGE_SIZE=64K MMU=Hash  SMP NR_CPUS=8192 NUMA pSeries
[  177.928346] Modules linked in: rpadlpar_io rpaphp nft_compat xsk_diag 
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet 
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct bonding nft_chain_nat 
nf_nat nf_conntrack tls nf_defrag_ipv6 nf_defrag_ipv4 ip_set rfkill 
nf_tables nfnetlink binfmt_misc dm_round_robin dm_multipath dm_mod 
pseries_rng vmx_crypto drm fuse drm_panel_orientation_quirks xfs sd_mod 
sg lpfc(-) nvmet_fc ibmvscsi ibmveth scsi_transport_srp nvmet nvme_fc 
nvme_fabrics nvme_core scsi_transport_fc
[  177.928436] CPU: 0 UID: 0 PID: 10129 Comm: modprobe Kdump: loaded Not 
tainted 6.17.0-rc4-auto-00024-g043439ad1a23-dirty #17 VOLUNTARY
[  177.928448] Hardware name: IBM,9009-42A POWER9 (architected) 0x4e0202 
0xf000005 of:IBM,FW950.A0 (VL950_141) hv:phyp pSeries
[  177.928455] NIP:  c0000000009c5d68 LR: c00000000010e550 CTR: 
c00000000010e52c
[  177.928462] REGS: c000000132e1f720 TRAP: 0300   Not tainted 
(6.17.0-rc4-auto-00024-g043439ad1a23-dirty)
[  177.928471] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  
CR: 48008222  XER: 20040000
[  177.928494] CFAR: c00000000000dbbc DAR: 0000000000000008 DSISR: 
40000000 IRQMASK: 0
[  177.928494] GPR00: c00000000010e550 c000000132e1f9c0 c000000001678100 
0000000000000000
[  177.928494] GPR04: c0000001329f75f0 c000000132e1fab8 c000000120459d00 
fffffffffffe0000
[  177.928494] GPR08: 0000000000000000 c0000001329f7540 0000000000000000 
c00800000d8e3560
[  177.928494] GPR12: c00000000010e52c c000000002ff0000 0000000000000000 
0000000000000000
[  177.928494] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[  177.928494] GPR20: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[  177.928494] GPR24: 0000000000000000 0000000000000000 c00800000d905f38 
c000000012076394
[  177.928494] GPR28: 0000000000000000 c0000001329f7598 c000000120484680 
c0000000120760c8
[  177.928580] NIP [c0000000009c5d68] msi_desc_to_pci_dev+0x8/0x14
[  177.928596] LR [c00000000010e550] pseries_msi_ops_teardown+0x24/0x38
[  177.928609] Call Trace:
[  177.928613] [c000000132e1f9c0] [c00000000dd3a8b0] 0xc00000000dd3a8b0 
(unreliable)
[  177.928625] [c000000132e1f9e0] [c000000000244e44] 
msi_remove_device_irq_domain+0x98/0x18c
[  177.928637] [c000000132e1fa20] [c000000000244f6c] 
msi_device_data_release+0x34/0xa8
[  177.928647] [c000000132e1fa50] [c000000000af7648] 
release_nodes+0x64/0x13c
[  177.928663] [c000000132e1fa90] [c000000000af9770] 
devres_release_all+0xc0/0x130
[  177.928672] [c000000132e1fb00] [c000000000aee2a8] 
device_unbind_cleanup+0x2c/0xb0
[  177.928682] [c000000132e1fb30] [c000000000af0668] 
device_release_driver_internal+0x2dc/0x32c
[  177.928692] [c000000132e1fb80] [c000000000af077c] 
driver_detach+0x8c/0x160
[  177.928701] [c000000132e1fbc0] [c000000000aedab0] 
bus_remove_driver+0x94/0x140
[  177.928710] [c000000132e1fc40] [c000000000af16a8] 
driver_unregister+0x48/0x88
[  177.928720] [c000000132e1fcb0] [c0000000009b808c] 
pci_unregister_driver+0x3c/0x184
[  177.928733] [c000000132e1fd00] [c00800000d8e18e4] 
lpfc_exit+0x38/0xe754 [lpfc]
[  177.928825] [c000000132e1fd30] [c00000000027bfd8] 
__do_sys_delete_module.constprop.0+0x1ac/0x3ec
[  177.928836] [c000000132e1fe10] [c000000000033338] 
system_call_exception+0x138/0x330
[  177.928847] [c000000132e1fe50] [c00000000000d05c] 
system_call_vectored_common+0x15c/0x2ec
[  177.928860] ---- interrupt: 3000 at 0x7fffb17d848c
[  177.928867] NIP:  00007fffb17d848c LR: 00007fffb17d848c CTR: 
0000000000000000
[  177.928873] REGS: c000000132e1fe80 TRAP: 3000   Not tainted 
(6.17.0-rc4-auto-00024-g043439ad1a23-dirty)
[  177.928880] MSR:  800000000280f033 
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 44004882  XER: 00000000
[  177.928902] IRQMASK: 0
[  177.928902] GPR00: 0000000000000081 00007fffcc632ff0 00007fffb18c7100 
00000100200c1e58
[  177.928902] GPR04: 0000000000000800 00000001015e71d8 0000000000000000 
00000000000000da
[  177.928902] GPR08: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[  177.928902] GPR12: 0000000000000000 00007fffb20cc5a0 0000000000000000 
0000000000000000
[  177.928902] GPR16: 00007fffcc6358b8 0000000000000001 00000001015e7c10 
00000100200c02f8
[  177.928902] GPR20: 0000000000000000 00000001015e8b38 00000100200c1df0 
0000000000000000
[  177.928902] GPR24: 00007fffcc6358c8 00007fffcc6358c8 00000100200d0430 
00000100200c02d0
[  177.928902] GPR28: 00000100200c1e58 0000000000000000 00000100200c1df0 
0000000000100000
[  177.928979] NIP [00007fffb17d848c] 0x7fffb17d848c
[  177.928985] LR [00007fffb17d848c] 0x7fffb17d848c
[  177.928991] ---- interrupt: 3000
[  177.928997] Code: ebc10020 38210030 e8010010 ebe1fff8 7c0803a6 
4e800020 ebc10020 4bffff7c 60000000 60000000 7c0802a6 60000000 
<e8630008> 3863ff38 4e800020 3c4c00cb
[  177.929034] ---[ end trace 0000000000000000 ]---
[  177.935447] pstore: backend (nvram) writing error (-1)
[  177.935452]


Bisection logs:


daaa574aba6f9c683408b58a7ab2dc775ece2f98 is the first bad commit
commit daaa574aba6f9c683408b58a7ab2dc775ece2f98 (HEAD)
Author: Nam Cao <namcao@linutronix.de>
Date:   Mon Aug 11 11:28:56 2025 +0200

     powerpc/pseries/msi: Switch to msi_create_parent_irq_domain()

     Move away from the legacy MSI domain setup, switch to use
     msi_create_parent_irq_domain().

     Signed-off-by: Nam Cao <namcao@linutronix.de>
     Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
     Link: 
https://patch.msgid.link/c7a6d8f27fd217021dea4daad777e81a525ae460.1754903590.git.namcao@linutronix.de

  arch/powerpc/include/asm/pci-bridge.h  |   2 --
  arch/powerpc/platforms/pseries/Kconfig |   1 +
  arch/powerpc/platforms/pseries/msi.c   | 114 
++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------------------------
  3 files changed, 49 insertions(+), 68 deletions(-)


git bisect start
# status: waiting for both good and bad commits
# bad: [c746c3b5169831d7fb032a1051d8b45592ae8d78] Merge tag 
'for-6.18-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
git bisect bad c746c3b5169831d7fb032a1051d8b45592ae8d78
# status: waiting for good commit(s), bad commit known
# good: [038d61fd642278bab63ee8ef722c50d10ab01e8f] Linux 6.16
git bisect good 038d61fd642278bab63ee8ef722c50d10ab01e8f
# good: [e25079858627916b22c4a789005a90a9fae808d8] Merge branch 
'net-better-drop-accounting'
git bisect good e25079858627916b22c4a789005a90a9fae808d8
# bad: [05a54fa773284d1a7923cdfdd8f0c8dabb98bd26] Merge tag 
'sound-6.18-rc1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect bad 05a54fa773284d1a7923cdfdd8f0c8dabb98bd26
# bad: [ae28ed4578e6d5a481e39c5a9827f27048661fdd] Merge tag 
'bpf-next-6.18' of 
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
git bisect bad ae28ed4578e6d5a481e39c5a9827f27048661fdd
# good: [6855f06042ae8d134f96c63feb5dfb3943c6d789] Merge tag 
'i2c-for-6.17-rc8' of 
git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
git bisect good 6855f06042ae8d134f96c63feb5dfb3943c6d789
# bad: [30d4efb2f5a515a60fe6b0ca85362cbebea21e2f] Merge tag 
'for-linus-6.18-rc1-tag' of 
git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip
git bisect bad 30d4efb2f5a515a60fe6b0ca85362cbebea21e2f
# good: [a9401710a5f5681abd2a6f21f9e76bc9f2e81891] Merge tag 
'v6.18-rc-part1-smb3-common' of git://git.samba.org/ksmbd
git bisect good a9401710a5f5681abd2a6f21f9e76bc9f2e81891
# good: [fe68bb2861808ed5c48d399bd7e670ab76829d55] Merge tag 
'microblaze-v6.18' of git://git.monstr.eu/linux-2.6-microblaze
git bisect good fe68bb2861808ed5c48d399bd7e670ab76829d55
# good: [feafee284579d29537a5a56ba8f23894f0463f3d] Merge tag 
'arm64-upstream' of 
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect good feafee284579d29537a5a56ba8f23894f0463f3d
# good: [9cc220a422113f665e13364be1411c7bba9e3e30] Merge tag 
's390-6.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
git bisect good 9cc220a422113f665e13364be1411c7bba9e3e30
# bad: [b48b6cc8c655d8cdcf5124ba9901b74c8f759668] powerpc/pseries: 
Enable HVPIPE event message interrupt
git bisect bad b48b6cc8c655d8cdcf5124ba9901b74c8f759668
# good: [7f9bcf13069731fac48d8b44086fab179fbc04c9] powerpc/cpm2: Drop 
legacy-of-mm-gpiochip.h header
git bisect good 7f9bcf13069731fac48d8b44086fab179fbc04c9
# good: [f0ac60e6e311062f1a452d93376055787db4b070] powerpc/powernv/pci: 
Switch to use msi_create_parent_irq_domain()
git bisect good f0ac60e6e311062f1a452d93376055787db4b070
# bad: [814ef095f12c9fa142043ee689500f3a41bb6dab] powerpc/pseries: Add 
papr-hvpipe char driver for HVPIPE interfaces
git bisect bad 814ef095f12c9fa142043ee689500f3a41bb6dab
# bad: [043439ad1a23cd3f65628310d1f5a06e61f8b431] powerpc/pseries: 
Define papr-hvpipe ioctl
git bisect bad 043439ad1a23cd3f65628310d1f5a06e61f8b431
# bad: [daaa574aba6f9c683408b58a7ab2dc775ece2f98] powerpc/pseries/msi: 
Switch to msi_create_parent_irq_domain()
git bisect bad daaa574aba6f9c683408b58a7ab2dc775ece2f98
# first bad commit: [daaa574aba6f9c683408b58a7ab2dc775ece2f98] 
powerpc/pseries/msi: Switch to msi_create_parent_irq_domain()


If you happen to fix this, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>



Regards,

Venkat.



