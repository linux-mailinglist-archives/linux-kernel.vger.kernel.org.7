Return-Path: <linux-kernel+bounces-866210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E083BFF2EF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D549F4F38C8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 04:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD59235063;
	Thu, 23 Oct 2025 04:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ABLqdiPP"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D12222D0
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761195309; cv=none; b=O2OlAAWL0xBjZxOHHFuvjJSaFbEPFZPDCKBKthoB+z1NwkMfYe1K7pD3K/TMeWXgb2UYowxHEHUDoRjJqTaDdLnDuFUsopBzNDqJG65qiy4OOIUPvhH+tF4E67HF/tN80a0uitl+JitF/uinMmSh5nc82mUXel9sHlqmQ9jilO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761195309; c=relaxed/simple;
	bh=ja/ZV7G7VTDY6EvzSv5yxghHvz6IGd6mvMG3OAmvhtc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=jIA+EsCEAfrNTtpaaFv3zz4KCsz6MCHeV1mmYDvCrORJsIgJCGJfyJqxzE66GW+RjdZSzUPmh4BGcgCWzXQSlJ065SgFzLMuKXrLL0tr+2nrNJWXcvKDr6Nt4p/ytMYGrdXdA2PO7xOJsZz5oBX31LIGaMQpIOlFIU/Mvh846aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ABLqdiPP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MHA7KI030688;
	Thu, 23 Oct 2025 04:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=v1a6U0E6Q1G/qYwmiRKb9Bb2RVSy
	ZIyJUpKYvFG1vdE=; b=ABLqdiPPm2q8Qh7y/Jl68ZHI2EwpKVUTxQmlF8ht5WdP
	I8LrBmmEqDHP0WC7IngM0sY9kT+ihXQ5O8+iNwoNMcC1YnQ2TNySNdvt7mU6kxP5
	q46yX0DPDaXGsUZLo9JVAsapO8reOoDbNyMpsenXxz3k4wp+VF9bQSMexC2ux7sF
	t6Rkn7hTnfwCxyQd11FevBLdmCwjud1QohmIwA6VlzJ7oHyPvNkvSJRNc4S/xqtu
	ECySBHRAUSte85lXIF4Ul5vK1mDpYcqk/1ydBRDc3UhdKOZbVneTRSWkZ6GneLHp
	Xk84lkcXSmwojX8jd8GDx2cGT5KVURc40KGqEe2iFw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s8bp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 04:55:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N1a0ae032103;
	Thu, 23 Oct 2025 04:54:59 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7n3yhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 04:54:59 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59N4svlW24773256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 04:54:58 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7D825805C;
	Thu, 23 Oct 2025 04:54:57 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A481358054;
	Thu, 23 Oct 2025 04:54:56 +0000 (GMT)
Received: from [9.61.246.164] (unknown [9.61.246.164])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Oct 2025 04:54:56 +0000 (GMT)
Message-ID: <4b107285-57d7-482d-9fdf-8499e5fdbebb@linux.ibm.com>
Date: Thu, 23 Oct 2025 10:24:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [mainline] Kernel OOPs while running powerpc/mce/ selftest
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZpDk261nlMXTLoIZI_CkaKlH7IIkr-pQ
X-Proofpoint-GUID: ZpDk261nlMXTLoIZI_CkaKlH7IIkr-pQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX2EiPJgIl5t4V
 XQTfbwmeyEBQ0erFR2G5vqgbR3OKw7menx1Idzs/DE13EMQShMxktZd+8H/JmtjB8W85UHbzRSc
 GXtj23wd+iaq90Yn+RUdHyUuh39fCL1jF4fhwTGso8zs9uVWzvoXdULm61EfGd+TRGULfriUlXm
 hAQBUB5ywRViGmwYp8lPo3l/yQWrEiHZ/9jj8skSciyOBGpOIEDd+05DfKQAdky45PfV6a4J2wj
 BQNoflPh3o55KZ+JRX68ZMycpofYShdAgHZtHZzuSMUBX//Vzl8/7SHDl4iMSkvkYcoK0ZUVc9n
 e3z7PxrMma5rncjpQNZGkWYE6/zAn+zo28OiV65nSu8EU3JWDYx8Qr3BoSXwxK4g3kdITxroSxq
 bZhkW8HrVP9Nvc4GfgR7rz6Rhpvf0w==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f9b524 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=BgshIIh1BqXnNibNEX8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Greetings!!!


IBM CI has reported a kernel crash while running mce selftests on 
mainline kernel, from tools/testing/selftests/powerpc/mce/.


This issue is hit when CONFIG_KASAN is enabled. If its disabled, test 
passes.


Traces:


[ 8041.225432] BUG: Unable to handle kernel data access on read at 
0xc00e0001a1ad6103
[ 8041.225453] Faulting instruction address: 0xc0000000008c54d8
[ 8041.225461] Oops: Kernel access of bad area, sig: 11 [#1]
[ 8041.225467] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
[ 8041.225475] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 
nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct 
nft_chain_nat nf_nat nf_conntrack bonding tls nf_defrag_ipv6 
nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink pseries_rng vmx_crypto 
dax_pmem fuse ext4 crc16 mbcache jbd2 nd_pmem papr_scm sd_mod libnvdimm 
sg ibmvscsi ibmveth scsi_transport_srp pseries_wdt
[ 8041.225558] CPU: 17 UID: 0 PID: 877869 Comm: inject-ra-err Kdump: 
loaded Not tainted 6.18.0-rc2+ #1 VOLUNTARY
[ 8041.225569] Hardware name: IBM,9080-HEX Power11 (architected) 
0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
[ 8041.225576] NIP:  c0000000008c54d8 LR: c00000000004e464 CTR: 
0000000000000000
[ 8041.225583] REGS: c0000000fff778d0 TRAP: 0300   Not tainted (6.18.0-rc2+)
[ 8041.225590] MSR:  8000000000001003 <SF,ME,RI,LE>  CR: 48002828  XER: 
00000000
[ 8041.225607] CFAR: c00000000004e460 DAR: c00e0001a1ad6103 DSISR: 
40000000 IRQMASK: 3
[ 8041.225607] GPR00: c0000000019d0598 c0000000fff77b70 c00000000244a400 
c000000d0d6b0818
[ 8041.225607] GPR04: 0000000000004d43 0000000000000008 c00000000004e464 
004d424900000000
[ 8041.225607] GPR08: 0000000000000001 18000001a1ad6103 a80e000000000000 
0000000003000048
[ 8041.225607] GPR12: 0000000000000000 c000000d0ddf3300 0000000000000000 
0000000000000000
[ 8041.225607] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[ 8041.225607] GPR20: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[ 8041.225607] GPR24: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[ 8041.225607] GPR28: c000000d0d6b0888 c000000d0d6b0800 0000000000004d43 
c000000d0d6b0818
[ 8041.225701] NIP [c0000000008c54d8] __asan_load2+0x54/0xd8
[ 8041.225712] LR [c00000000004e464] pseries_errorlog_id+0x20/0x3c
[ 8041.225722] Call Trace:
[ 8041.225726] [c0000000fff77b90] [c0000000001f8748] 
fwnmi_get_errinfo+0xd4/0x104
[ 8041.225738] [c0000000fff77bc0] [c0000000019d0598] 
get_pseries_errorlog+0xa8/0x110
[ 8041.225750] [c0000000fff77c00] [c0000000001f8f68] 
pseries_machine_check_realmode+0x11c/0x214
[ 8041.225762] [c0000000fff77ce0] [c000000000049ca4] 
machine_check_early+0x74/0xc0
[ 8041.225771] [c0000000fff77d30] [c0000000000084a4] 
machine_check_early_common+0x1b4/0x2c0
[ 8041.225782] ---- interrupt: 200 at 0x100105cc
[ 8041.225788] NIP:  00000000100105cc LR: 00000000100105c4 CTR: 
0000000000000000
[ 8041.225795] REGS: c0000000fff77d60 TRAP: 0200   Not tainted (6.18.0-rc2+)
[ 8041.225801] MSR:  8000000002a0f033 
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 84002822  XER: 00000000
[ 8041.225829] CFAR: 000000000000021c DAR: 00007fffa0a40000 DSISR: 
02000008 IRQMASK: 0
[ 8041.225829] GPR00: 00000000100105c4 00007fffdaa5bd20 0000000010047f00 
00007fffa0a40000
[ 8041.225829] GPR04: 0000000000001000 0000000000000003 0000000000000001 
0000000000000005
[ 8041.225829] GPR08: 0000000000000000 fffffffffffff000 0000000000000000 
0000000000000000
[ 8041.225829] GPR12: 0000000000000000 00007fffa0b3ad20 0000000000000000 
0000000000000000
[ 8041.225829] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[ 8041.225829] GPR20: 0000000000000000 0000000000000000 0000000000000000 
00000000100102c0
[ 8041.225829] GPR24: 00007fffa0b30000 00007fffa0b2f6c0 00007fffdaa5c408 
000000001003fce8
[ 8041.225829] GPR28: 00007fffdaa5c658 0000000000000001 0000000000000005 
0000000000000000
[ 8041.225919] NIP [00000000100105cc] 0x100105cc
[ 8041.225925] LR [00000000100105c4] 0x100105c4
[ 8041.225930] ---- interrupt: 200
[ 8041.225934] Code: 6129ffff 792907c6 6529ffff 6129ffff 7c234840 
40810058 39230001 3d40a80e 71280007 41820034 7929e8c2 794a07c6 
<7d2950ae> 7d290775 40820070 38210020
[ 8041.225969] ---[ end trace 0000000000000000 ]---



If you happen to fix this issue, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>



Regards,

Venkat.



