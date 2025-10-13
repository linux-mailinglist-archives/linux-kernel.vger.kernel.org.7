Return-Path: <linux-kernel+bounces-850221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5AFBD2488
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA93D3C35BB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C262FD7B8;
	Mon, 13 Oct 2025 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XTfbkTjA"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CDF1FDA89
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347478; cv=none; b=DWKB7zer+8vRuWlNmlTxAWv4e5+9TFhwvQr6e9sMARfIhhFwK9prUJjgbGdoSlGR2Ixxr/b+qWq1ZQF1RLrk7encuD97FoHrPefoCQ62RjFg9/kUDCn9Dy9Djm/w/FDOZKysMLG+8jlExhtcbe1r2LeuqrEEkolB4c1M9+Pm7D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347478; c=relaxed/simple;
	bh=3XO2swenS9mY4IMko8Mw960Yb400fnROyOVksotSmy0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=MsM9hQrfhaQHq0HVhR1EOThKBtiEXp8HeKRdzDFw0ALASwafLUC3Yz8MYf01duKCy4hS2LoutqhiVnIBMZ0LnHOTWuXgamcTwDgw0XGS4cd2ybe0Tf9BIOp1wmA9lep1vPMT46+qEMAzsrcPYnhgfnPOovIVYVJTwMShoZVMPzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XTfbkTjA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CNSEHs004466;
	Mon, 13 Oct 2025 09:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=5Z1InDRd5PqBViIyjKPHWspxuU5p
	Bw24tGibcs0QPW8=; b=XTfbkTjA59oc4kiUSP+t9GHKK0VI993NHs2IQ9O2kr2p
	/Zs5IzGCC7hq3r3sXld5buPDUh/WP6tPnns4hxzWwgCelXJnSPZRjy7oPUqNfSj1
	WanmhoXRC28nma4hLf9sW9WYZYvePf3ipYEwziFGyue7nfBOBc6B5lULwXMgh0TK
	AQexQoTW8qqm9/L2Zpv0YDe8lqaFrRJZ24yHkrZeLkrPHzZlLlh1ncfmwH+o6WFY
	BDgN5DKTVX8i8C/O+Zj9a8kb6CoLzI31xzk54zM6E2uls5bQsVb+jQA2QMtwzjr2
	ZOhNsJDZWo1jhUu0dhAZ0LX8aU242HKXilf5NMLGxA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey8g235-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 09:23:59 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59D9JmY4010479;
	Mon, 13 Oct 2025 09:23:59 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey8g231-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 09:23:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59D5UAZ6003603;
	Mon, 13 Oct 2025 09:23:58 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xxn6rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 09:23:58 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59D9Num16882804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 09:23:56 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6691258054;
	Mon, 13 Oct 2025 09:23:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AFE25805A;
	Mon, 13 Oct 2025 09:23:52 +0000 (GMT)
Received: from [9.67.162.81] (unknown [9.67.162.81])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Oct 2025 09:23:51 +0000 (GMT)
Message-ID: <31838b50-e420-405a-af23-6c6ede281386@linux.ibm.com>
Date: Mon, 13 Oct 2025 14:53:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
Subject: [bug report][PPC]: rmod nvme driver causes the kernel panic
To: namcao@linutronix.de
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, tglx@linutronix.de, maz@kernel.org,
        gautam@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2D6gErMqxO5tQ-47WKwO9UKRgclEgQXi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfX0OH3aLIUwOtV
 FWpYluDVPXk/lMTxFqREPJWmCZzPxxjy75cTWu3bl+EbM4fMonv3KmPRR9G2wr66Nuaek08H5ft
 /HJSWlYRpiW5NmPXuMWrJyOwLNh9lQaNjr9jc+tQqVtVXyOeEqm0X2U7F//p4oLugEgRzdDqkrI
 jz+qL91FyAMpdIbgyBdERF/nmdSZtGN+OFnE1mUI2x5cou/UeTh9gRCLqQOR1TXxkc5KMyzEoXH
 Rx5km5gMG5xoQW/AvDW81k1kVbQg7G+GuwfRgqMhicMk8PD78kiEnYTmC93E8r8nOFJEfc+0vJn
 nQhp0GqxnSA8Ms0SNbSXTFpFCT/89pqtsiJsQkntR2Dqrl5/kw9gZsAZCacHwqtTY4Hr96H5Prc
 KqnPwCGhPvOKk5wijPoHFTXypkKBug==
X-Proofpoint-GUID: -y4W86DtnsnamLlq3AXOhXHQeiGrWgsZ
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68ecc52f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=OUoyzMPROc-8slUz8rQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011

Hi Nam,

On the latest upstream mainline kernel, I am encountering a kernel
crash when attempting to unload the NVMe driver module (rmmod nvme)
on a POWER9 system. The crash appears to be triggered by the recent
work on using MSI parent domains, discussed here: 
https://lore.kernel.org/all/cover.1754903590.git.namcao@linutronix.de/

System details:
===============
Architecture: PowerPC (POWER9, IBM 9008-22L)
Kernel: 6.18.0-rc1 (mainline, unmodified)
Platform: pSeries / PHYP
Reproducibility: Always, when running rmmod nvme

Crash trace:
============
Kernel attempted to read user page (8) - exploit attempt? (uid: 0)
BUG: Kernel NULL pointer dereference on read at 0x00000008
Faulting instruction address: 0xc000000000b30638
Oops: Kernel access of bad area, sig: 11 [#1]
LE PAGE_SIZE=64K MMU=Hash  SMP NR_CPUS=2048 NUMA pSeries
Modules linked in: rpadlpar_io rpaphp bonding tls nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet n
CPU: 14 UID: 0 PID: 1973 Comm: rmmod Not tainted 6.18.0-rc1 #63 VOLUNTARY 
Hardware name: IBM,9008-22L POWER9 (architected) 0x4e0202 0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
NIP:  c000000000b30638 LR: c000000000111d90 CTR: c000000000111d6c
REGS: c00000011f1076e0 TRAP: 0300   Not tainted  (6.18.0-rc1)
MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 48008228  XER: 200400cf
CFAR: c00000000000d9cc DAR: 0000000000000008 DSISR: 40000000 IRQMASK: 0 
GPR00: c000000000111d90 c00000011f107980 c000000001da8100 0000000000000000 
GPR04: c0000000bcf535e8 0000000000000000 73efa01ced0dd290 00000000b0734e18 
GPR08: 0000000ffb4c0000 c0000000bcf53540 0000000000000000 0000000048008222 
GPR12: c000000000111d6c c000000017ff1c80 0000000000000000 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR24: 0000000000000000 0000000000000001 c0000000b70bd980 c0000000995890c8 
GPR28: 0000000000000000 c0000000bcf53590 c00000000e79c800 c0000000995890c8 
NIP [c000000000b30638] msi_desc_to_pci_dev+0x8/0x14
LR [c000000000111d90] pseries_msi_ops_teardown+0x24/0x38
Call Trace:
[c00000011f107980] [c0000000995890c8] 0xc0000000995890c8 (unreliable)
[c00000011f1079a0] [c000000000276118] msi_remove_device_irq_domain+0x9c/0x18c
[c00000011f1079e0] [c00000000027623c] msi_device_data_release+0x34/0xa8
[c00000011f107a10] [c000000000c657b8] release_nodes+0xac/0x1f0
[c00000011f107ab0] [c000000000c675e8] devres_release_all+0xc0/0x138
[c00000011f107b20] [c000000000c5bb8c] device_unbind_cleanup+0x2c/0xb0
[c00000011f107b50] [c000000000c5dfc8] device_release_driver_internal+0x2fc/0x34c
[c00000011f107ba0] [c000000000c5e0c4] driver_detach+0x74/0xe0
[c00000011f107bd0] [c000000000c5b3e0] bus_remove_driver+0x94/0x140
[c00000011f107c50] [c000000000c5f1c8] driver_unregister+0x48/0x88
[c00000011f107cc0] [c000000000b228ec] pci_unregister_driver+0x40/0x128
[c00000011f107d10] [c008000004b6834c] nvme_exit+0x20/0x7cd4 [nvme]
[c00000011f107d30] [c0000000002becb8] __do_sys_delete_module.constprop.0+0x1ac/0x3ec
[c00000011f107e10] [c000000000032324] system_call_exception+0x134/0x360
[c00000011f107e50] [c00000000000cedc] system_call_vectored_common+0x15c/0x2ec

Analysis:
=========
From tracing the cleanup path, it appears that the crash happens because the MSI 
descriptor is freed before the MSI teardown is invoked. Specifically, during NVMe
module unload (rmmod nvme), the call sequence is as follows:

cleanup_module
 -> pci_unregister_driver
   -> driver_unregister
     -> bus_remove_driver
       -> driver_detach
         -> device_release_driver_internal
           -> device_remove
            -> pci_device_remove
              -> nvme_remove
                -> nvme_dev_disable
                  -> pci_free_irq_vectors
                    -> pci_disable_msix
                      -> pci_free_msi_irqs
                        -> pci_msi_teardown_msi_irqs  ==> here we free msi_desc


Later, when call stack continue unwinding through,
-> device_release_driver_internal
  -> device_unbind_cleanup
    -> devres_release_all
      -> release_nodes
        -> msi_device_data_release
          -> msi_remove_device_irq_domain
            -> pseries_msi_ops_teardown => here the freed msi_desc is dereferenced, leads to crash

Possible Cause:
===============
This looks like a cleanup ordering issue introduced by the recent MSI parent
domain rework. The PCI/MSI teardown seems to assume that the MSI descriptor
remains valid until after the domain teardown path executes — which no longer
appears to hold true in this sequence.

Expected behavior:
==================
The rmmod nvme operation should cleanly unload the module without triggering a
crash or accessing freed MSI descriptors.

Additional notes:
=================
- The crash reproduces consistently on PowerPC (pseries, PHYP).
- It did not occur before the MSI parent domain series was merged.
- Likely to affect other MSI-capable PCI drivers.

Let me know if you need any further details. Also if you fix this bug,
I'd be glad to assist you validating the fix on PPC.

Thanks,
--Nilay


