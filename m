Return-Path: <linux-kernel+bounces-856338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32574BE3E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98553AEC5D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E31B33EB09;
	Thu, 16 Oct 2025 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xs+GY7nq"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935352D47E0
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760624940; cv=none; b=mkvGdAWXB8s+voOOGj/cezTgxcHDU2pJQKII3L4jIHOVZa6vI6uEBtaAMScg3caFLTGNv1UWv4hgS+YTyRp06H4wqKq9++0zJFzBjK48kiPxPZCwlMn//jaIbHffV1AHaTbh3vVCrd3h7tziJHO81bZaM5+p8OBs9q5NQfmPnt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760624940; c=relaxed/simple;
	bh=jS+h2mTsPYVg4ZN46hzQ0YSn3x573VzIHIMKBOo1cw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZQbgnXkozR7YCn+XaNWJAzrs6QRz/4iFHYV8g4Ux01WhAXrDCvpYLZfdonHqd6RUrZrBmET+JUhozjMNsqNz9liwe8ekpTnSvpaUqQYntaBK5tZ1wPwYYehKJ2Fsodc5G4lB+s2hLJqgT2qlGE26BzXQ5/FY9XgNzCs/LkyMH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xs+GY7nq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GAm8WP001407;
	Thu, 16 Oct 2025 14:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=N6TCUvBIFH9Km535j+F8XX51XzSvyn3JmZRkey0E9
	jU=; b=Xs+GY7nqdj0+1k5lWjeQLPxkL7kHSCW4+/iwN94o1X5kd78iMEM911WNA
	tBtCIAD5k1/NtGNyG1tJ9HKqhlvd9FZNJ8FxFjQDWTtoOxJuEl1fSESSDQQMxpuH
	tnmZoyMYssqGvjrqli5GCnNSHHkiBebib9RldkEHp3x6IRwPbdg0SQSnAyERsoTu
	mgEuaIoEgfG4B9X4pX5icPKJNWAM6YfnocS5RsLqZPh+AiZ0cPuE9bPV42vUr6MU
	qVtMFtuNX6ryDjh/Bbrm3MrIK5yyBJQ2jVtDYWycnUvwJtRgyZ+Srs+FBR591iPJ
	3+MowHnSr0TpfgAsutfiMqW/63Z6A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp865s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 14:28:41 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59GEP5GX013814;
	Thu, 16 Oct 2025 14:28:41 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp865rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 14:28:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GBJkmm015028;
	Thu, 16 Oct 2025 14:28:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sjnyb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 14:28:40 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GESaXZ51380616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 14:28:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7265D20148;
	Thu, 16 Oct 2025 14:28:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AC5B20150;
	Thu, 16 Oct 2025 14:28:34 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.in.ibm.com (unknown [9.109.204.116])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Oct 2025 14:28:33 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan he <bhe@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] crash: let architecture decide crash memory export to iomem_resource
Date: Thu, 16 Oct 2025 19:58:31 +0530
Message-ID: <20251016142831.144515-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VN6n-4cdB3fGC8v1n0JAnjD6jY94qsWV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfXxtWerBGArH7U
 zHMHpqxZ8tU+A95PdpfIz5fqKAQb1LJSXtLXXz1l4BCk7Ky36lbRJwR5KYQw0/58iyjjSAa/fde
 VgaMQCHlAyEVI7x1xtqjJICz1pNKiiiPyGL41zy9LPLnOyKdO9Vn5qyi5VuGjxdqnLHJLJMjMIH
 ENTwvTYtE6hBAY5aBBtoNdKP1dxHsh8Mm11LFfdRnaXMFj3RYpSIGYn6TJs+izvK0XzDf4TgpVk
 tuHOZQuayRozT8Br4DyWCvxYxN31MiV/UmK9t0UsJ+j5RDm5ua0gt2HKkqGuUVhSdPvBSNK143W
 iVnnFA8oTlBTZMhgZWinb0JZpsElZuFcKFYE0f/G7qaT0TxiPWqnP+CtFJ/qEGDf8GIvS9jfN7n
 /6Y4YfVFKST8cPaeO5CV8JB/KacK4w==
X-Proofpoint-GUID: oR4BFbbA78zC_rTnWXR5gpyNLlsY0sK-
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68f10119 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8
 a=oNOrHKTX8ZNhZH91a0IA:9 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084

With the generic crashkernel reservation, the kernel emits the following
warning on powerpc:

WARNING: CPU: 0 PID: 1 at arch/powerpc/mm/mem.c:341 add_system_ram_resources+0xfc/0x180
Modules linked in:
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.17.0-auto-12607-g5472d60c129f #1 VOLUNTARY
Hardware name: IBM,9080-HEX Power11 (architected) 0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
NIP:  c00000000201de3c LR: c00000000201de34 CTR: 0000000000000000
REGS: c000000127cef8a0 TRAP: 0700   Not tainted (6.17.0-auto-12607-g5472d60c129f)
MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 84000840  XER: 20040010
CFAR: c00000000017eed0 IRQMASK: 0
GPR00: c00000000201de34 c000000127cefb40 c0000000016a8100 0000000000000001
GPR04: c00000012005aa00 0000000020000000 c000000002b705c8 0000000000000000
GPR08: 000000007fffffff fffffffffffffff0 c000000002db8100 000000011fffffff
GPR12: c00000000201dd40 c000000002ff0000 c0000000000112bc 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000015a3808
GPR24: c00000000200468c c000000001699888 0000000000000106 c0000000020d1950
GPR28: c0000000014683f8 0000000081000200 c0000000015c1868 c000000002b9f710
NIP [c00000000201de3c] add_system_ram_resources+0xfc/0x180
LR [c00000000201de34] add_system_ram_resources+0xf4/0x180
Call Trace:
add_system_ram_resources+0xf4/0x180 (unreliable)
do_one_initcall+0x60/0x36c
do_initcalls+0x120/0x220
kernel_init_freeable+0x23c/0x390
kernel_init+0x34/0x26c
ret_from_kernel_user_thread+0x14/0x1c

This warning occurs due to a conflict between crashkernel and System RAM
iomem resources.

The generic crashkernel reservation adds the crashkernel memory range to
/proc/iomem during early initialization. Later, all memblock ranges are
added to /proc/iomem as System RAM. If the crashkernel region overlaps
with any memblock range, it causes a conflict while adding those memblock
regions as iomem resources, triggering the above warning. The conflicting
memblock regions are then omitted from /proc/iomem.

For example, if the following crashkernel region is added to /proc/iomem:
20000000-11fffffff : Crash kernel

then the following memblock regions System RAM regions fail to be inserted:
00000000-7fffffff : System RAM
80000000-257fffffff : System RAM

Fix this by not adding the crashkernel memory to /proc/iomem on powerpc.
Introduce an architecture hook to let each architecture decide whether to
export the crashkernel region to /proc/iomem.

For more info checkout commit c40dd2f766440 ("powerpc: Add System RAM
to /proc/iomem") and commit bce074bdbc36 ("powerpc: insert System RAM
resource to prevent crashkernel conflict")

Note: Before switching to the generic crashkernel reservation, powerpc
never exported the crashkernel region to /proc/iomem.

Fixes: e3185ee438c2 ("powerpc/crash: use generic crashkernel reservation").
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan he <bhe@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/90937fe0-2e76-4c82-b27e-7b8a7fe3ac69@linux.ibm.com/
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/include/asm/crash_reserve.h | 8 ++++++++
 include/linux/crash_reserve.h            | 6 ++++++
 kernel/crash_reserve.c                   | 3 +++
 3 files changed, 17 insertions(+)

diff --git a/arch/powerpc/include/asm/crash_reserve.h b/arch/powerpc/include/asm/crash_reserve.h
index 6467ce29b1fa..d1b570ddbf98 100644
--- a/arch/powerpc/include/asm/crash_reserve.h
+++ b/arch/powerpc/include/asm/crash_reserve.h
@@ -5,4 +5,12 @@
 /* crash kernel regions are Page size agliged */
 #define CRASH_ALIGN             PAGE_SIZE
 
+#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+static inline bool arch_add_crash_res_to_iomem(void)
+{
+	return false;
+}
+#define arch_add_crash_res_to_iomem arch_add_crash_res_to_iomem
+#endif
+
 #endif /* _ASM_POWERPC_CRASH_RESERVE_H */
diff --git a/include/linux/crash_reserve.h b/include/linux/crash_reserve.h
index 7b44b41d0a20..f0dc03d94ca2 100644
--- a/include/linux/crash_reserve.h
+++ b/include/linux/crash_reserve.h
@@ -32,6 +32,12 @@ int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 void __init reserve_crashkernel_cma(unsigned long long cma_size);
 
 #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+#ifndef arch_add_crash_res_to_iomem
+static inline bool arch_add_crash_res_to_iomem(void)
+{
+	return true;
+}
+#endif
 #ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
 #define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
 #endif
diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 87bf4d41eabb..62e60e0223cf 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -524,6 +524,9 @@ void __init reserve_crashkernel_cma(unsigned long long cma_size)
 #ifndef HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
 static __init int insert_crashkernel_resources(void)
 {
+	if (!arch_add_crash_res_to_iomem())
+		return 0;
+
 	if (crashk_res.start < crashk_res.end)
 		insert_resource(&iomem_resource, &crashk_res);
 
-- 
2.51.0


