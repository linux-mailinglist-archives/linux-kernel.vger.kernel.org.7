Return-Path: <linux-kernel+bounces-677269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39342AD1890
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 08:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC50166E8F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 06:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E02427FB16;
	Mon,  9 Jun 2025 06:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P9OSyJRI"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4DC2F3E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Jun 2025 06:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749450303; cv=none; b=hnv0MD9BqCFFi26iDfL4YosTZftWddP+Ic1dfSAjanTU4wbwvXH9ynmuLl1x5lBRCQufxIHHeszeO85H0NRV/QGjI+KldTLb8xDCNpQNgfx8dm8y7GqnreNLLzYRCjaoaGknsgMPoBwUnyCejdh2c41jLF3qIablqgALVqHtgzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749450303; c=relaxed/simple;
	bh=Tp3q+/2iejmrFYo2CMlLtgX4uqseV1prqS2gZ7LThZ4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ZrE0JIDnprSFtul7+JP3ESQM+ZsYedKiLMemL91hztGPq0hQHa+DC0bjf9jWFefNZSigPXOC63sLLM7gMmAHDGEq2N8JA+zjKhRS9EcIPkNsgai0wJRwxsH68FhS9lZ5K+YecwEpviJzXKkYssef4rYzFV3zkrTfbDuiy40o/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P9OSyJRI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 558I03ED005012;
	Mon, 9 Jun 2025 06:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ezK+AV6OzoAOJNPToclUuCy6yaiv
	DiBk3ZUca/PDRv4=; b=P9OSyJRIDijPAe1e0DhYFJnjcpp3+gEVaf9KWl2ztgEr
	B2mfUZUWikpxh8NXNiImX4DWhLJ0C8XOWKqP1MUje+YhI2/u0I2pc6o0QptfFrR2
	XkNTjxpYET3gS27FrXMFVObxPwiKrnpYuM93Yt/7m1IJy43a02KzdZxVl0MLH9S6
	86x3EpqvtD8Foky7c7FVR6JDcwKfCoYyjAqAZDQ1F3pC/clX6b4CkJNN3nmfOpJS
	aAFr86HyH1zX/NymmGvdovFfCiPELXs0o6dQYeKYPoJ3ggPfYeCqmhbaOMaWcRiJ
	1xKfFcRBsBxBXNd9C5V8dolpqYG2TN759cEf8Gh1xg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474dv76yfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Jun 2025 06:24:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5594JAHj015186;
	Mon, 9 Jun 2025 06:24:55 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrt4r7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Jun 2025 06:24:55 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5596OrKw29950714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Jun 2025 06:24:54 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8E2F58062;
	Mon,  9 Jun 2025 06:24:53 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8E5858054;
	Mon,  9 Jun 2025 06:24:52 +0000 (GMT)
Received: from [9.61.250.8] (unknown [9.61.250.8])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Jun 2025 06:24:52 +0000 (GMT)
Message-ID: <7b0370c1-4917-4fba-823e-7b5c6c1f8a60@linux.ibm.com>
Date: Mon, 9 Jun 2025 11:54:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [mainline]Kernel OOPs at migrate_swap_task
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1FlT2uhghWZu1LC6ACPm_wX5EeaAdFz8
X-Proofpoint-GUID: 1FlT2uhghWZu1LC6ACPm_wX5EeaAdFz8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA0OCBTYWx0ZWRfXxvG+3ZdfB2sA vWT5aFwwyiEuKbcmhwA4d8MskM/RRtPEl6BgtEh2WcuPD80SDjDPIjwCube1OVY80Kh5T+wQ9vp dLJb3l/phBrAOOXwXQg39sXy9fvQcIu91c87HtH0yr6HiqRdcT0FxvUFnLN1vP7USSj7fZfYDVA
 fQir2bqt5kWYTpgwhowLolOJpiHcVAeEwV0SrWbqO3SrWJHWc/On6lmIBJI0JI8nlh1ILWoX9Ki cwaEEaUqsVSVhBxgCsb7B+EdLa/p3+R8ClgclsAClC2B3dWsJoyFkuicR2C1WgHxYKn6sKcyyBu rc9LwHIS+y5FAF21B1smOBf3pa8hbnIRTBHk/ZXVcQqI9mDn8dO0zurSzI0aG86gIP+zK/dmIJ/
 bEOIdw7/h2HZevDXiysZd6bQxduY9pt+iHRN0evIR5PRNrrWECrUROuOyZ0xSyGQ/OaqK5HH
X-Authority-Analysis: v=2.4 cv=CfMI5Krl c=1 sm=1 tr=0 ts=68467e38 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=W4kWWihBoIyN2mbi5FAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_02,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=819 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090048

Hello,


IBM CI has reported a kernel oops, while running cpu monitor test [1], 
on the mainline kernel.


[1]: 
https://github.com/avocado-framework-tests/avocado-misc-tests/blob/master/cpu/cpupower_monitor.py


I am still in porcess of doing git bisect, meanwhile, wondering if below 
traces gives any clue.


Traces:


[ 2181.567879] Kernel attempted to read user page (5b0) - exploit 
attempt? (uid: 0)
[ 2181.567913] BUG: Kernel NULL pointer dereference on read at 0x000005b0
[ 2181.567918] Faulting instruction address: 0xc0000000001d4a48
[ 2181.567924] Oops: Kernel access of bad area, sig: 11 [#1]
[ 2181.567929] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
[ 2181.567936] Modules linked in: dm_mod ext4 crc16 mbcache jbd2 loop 
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet 
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bonding tls rfkill ip_set 
nf_tables nfnetlink pseries_rng vmx_crypto fuse xfs sr_mod cdrom sd_mod 
sg ibmvscsi scsi_transport_srp ibmveth [last unloaded: scsi_debug]
[ 2181.567990] CPU: 0 UID: 0 PID: 19 Comm: migration/0 Kdump: loaded Not 
tainted 6.15.0-ge271ed52b344 #1 VOLUNTARY

[ 2181.568003] Stopper: multi_cpu_stop+0x0/0x22c <- migrate_swap+0xe8/0x214
[ 2181.568016] NIP:  c0000000001d4a48 LR: c0000000001d4a3c CTR: 
c0000000001d6864
[ 2181.568021] REGS: c0000000087ffaf0 TRAP: 0300   Not tainted 
(6.15.0-ge271ed52b344)
[ 2181.568026] MSR:  8000000002803033 <SF,VEC,VSX,FP,ME,IR,DR,RI,LE>  
CR: 48004202  XER: 00000000
[ 2181.568038] CFAR: c00000000003a360 DAR: 00000000000005b0 DSISR: 
40000000 IRQMASK: 3
[ 2181.568038] GPR00: c0000000001d4df4 c0000000087ffd90 c000000001648100 
0000000000000003
[ 2181.568038] GPR04: 0000000000000010 0000000000000000 00000941d4c72888 
0000000000000000
[ 2181.568038] GPR08: 00000004fdad0000 0000000000000000 000000000000013a 
0000000000004000
[ 2181.568038] GPR12: c0000004ffd3c780 c000000002ff0000 c0000000001ae2e0 
c0000000040533c0
[ 2181.568038] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[ 2181.568038] GPR20: 0000000000000000 0000000000000000 0000000000000000 
0000000000000001
[ 2181.568038] GPR24: c000000529930f4c 0000000000000000 c000000529930180 
c000000642c60100
[ 2181.568038] GPR28: c000000642c60ecc c0000013fd68c700 0000000000000010 
c000000642c60100
[ 2181.568088] NIP [c0000000001d4a48] __migrate_swap_task+0x6c/0x1d8
[ 2181.568094] LR [c0000000001d4a3c] __migrate_swap_task+0x60/0x1d8
[ 2181.568100] Call Trace:
[ 2181.568103] [c0000000087ffd90] [c0000000001d4b70] 
__migrate_swap_task+0x194/0x1d8 (unreliable)
[ 2181.568112] [c0000000087ffdc0] [c0000000001d4df4] 
migrate_swap_stop+0x240/0x2b4
[ 2181.568118] [c0000000087ffe20] [c0000000002efc04] 
multi_cpu_stop+0xd8/0x22c
[ 2181.568123] [c0000000087ffe90] [c0000000002ef8e8] 
cpu_stopper_thread+0x158/0x24c
[ 2181.568129] [c0000000087fff40] [c0000000001b93b0] 
smpboot_thread_fn+0x200/0x2c0
[ 2181.568137] [c0000000087fff90] [c0000000001ae40c] kthread+0x134/0x164
[ 2181.568144] [c0000000087fffe0] [c00000000000df98] 
start_kernel_thread+0x14/0x18
[ 2181.568150] Code: 60690001 992d0932 e90d0030 3d2200c2 39290378 
7d49402a 394a0001 7d49412a 4be65771 60000000 60000000 e93f0a70 
<e86905b0> 48426c89 60000000 2c230000
[ 2181.568165] ---[ end trace 0000000000000000 ]---
[ 2181.568687]


If you happen to fix this, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>



Regards,

Venkat.


