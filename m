Return-Path: <linux-kernel+bounces-873615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5311CC143A9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB52A621880
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B19630595F;
	Tue, 28 Oct 2025 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xoh03vzA"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EB9304975;
	Tue, 28 Oct 2025 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648971; cv=none; b=dQIKEtNfT/Ow8ixCMVlnp20nufSdtfEfFGrEHWRFwiIoBuIRCpvRBF1wKCHToXw/t6L327pVO3ZTJvRH/vS1A8Yr7KX0NdEHpLEjDOBtZp5fT0yJmfVbOstEQBA6rxEz11pdoiV6pjHK2ovK/d/NTJz0mkZxFZfjvDHtio0Sn4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648971; c=relaxed/simple;
	bh=yvKNly4kNDHA/alqUn5lYahkVt1wQ08+EXTSQGii2ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9hzOp9ZMMfGqYzVY0neekF7lCKyjSsZbSQjnbFNwCodFW0NOvIfBFELTKqieEOP1ZkbxLb7COwNLF3N/nKtqStRxXLvtqrLgz9+G3ioQXVqGK8fc6Xir4ugyqiujSVQgWF73CvU531+rLfZ+Z7lA0Le+WhugqujkMeVvLjgL5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xoh03vzA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RNBix4000657;
	Tue, 28 Oct 2025 10:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hiHeN2x4B81hmvIwx
	hk14paD4xhooOSCeWVobZBBx9Y=; b=Xoh03vzAY7tZZZa30s9q9zDkAHeU2/GJE
	QytVs88MCBWGbQQGxuFFL/Ww9dck+Tp0T3uDpYIsszRvHv3bTa8BZrM9oIG97XEY
	IcN6PtzXFxq/woSCTzeut7hnjrCCh+SlplpG2w+r79KeigLmqfcqLQZmTR5zep5d
	zeVD/5yZ7YGQgv3Ti85ew0ilAG2zNlQg0iF7hMmUYdfq2SbfEd1KIex4halZeH1b
	hnEVZ/LzOm5pUzX0M/P/aPMOyhftwadeT9oGGmTyCu7dp0NxpT34e6ZftMmw92dQ
	m+AyOkHpH+Ys6H65yBwhZfxyW657s5JgoNWuBn+5cG0C5RpimM6RA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p293fas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 10:55:56 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59SAt1qa026510;
	Tue, 28 Oct 2025 10:55:56 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p293fap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 10:55:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59S9Dhan009428;
	Tue, 28 Oct 2025 10:55:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a1b3j23h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 10:55:54 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59SAtpYn61079834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 10:55:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2ED8A2004D;
	Tue, 28 Oct 2025 10:55:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C5882004B;
	Tue, 28 Oct 2025 10:55:48 +0000 (GMT)
Received: from li-80eaad4c-2afd-11b2-a85c-af8123d033e3.ibm.com (unknown [9.124.209.152])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Oct 2025 10:55:47 +0000 (GMT)
From: "Nysal Jan K.A." <nysal@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Srikar Dronamraju <srikar@linux.ibm.com>,
        "Nysal Jan K.A." <nysal@linux.ibm.com>,
        Sachin P Bappalige <sachinpb@linux.ibm.com>, stable@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc/kexec: Enable SMT before waking offline CPUs
Date: Tue, 28 Oct 2025 16:25:12 +0530
Message-ID: <20251028105516.26258-1-nysal@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025080512.85690-1-nysal@linux.ibm.com>
References: <20251025080512.85690-1-nysal@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxOSBTYWx0ZWRfX3HlIKYqMJBCw
 GiGoZU+Qn6PVA60ZhQ/djUXs1yGbK1b8u0Jlj/DBebpNdojxsuoTGeIc0iP3SOlJv48ugyUmkIE
 XV2WbYe0kUzwGpECADfsKDUNPEFhoReXqqA9XV+jQOuycYqMuZF50rgxHZDltIGeR4brKcYHGb3
 E1XA7Psq9rqlJPe9zZa/Tf4rIUwLW69mAKR+zn7EWx1U1xF6czg2Ebh6c5kvOnUmgNWfvGOcuSa
 fBA+J6CD3SR5Zzyi9pBioj4zUpPbYkODyHRQ6uNHGO5rJzjYruyfzZ7/1ilbDTKPYmrx4Di82PG
 S91+LPBwY//omJhNrEg8G6tb35zuB0MoM2Z0Jhx7ZxA6UxCHOp39K1ckFp5k8ALulypLUZbSqrX
 yABUgjTpxX1GpwWlBkbsIs3Fm+c5WA==
X-Proofpoint-GUID: E9-2bkI_G8UU2zgmOr-_y4VMStsIEBkv
X-Authority-Analysis: v=2.4 cv=V8ZwEOni c=1 sm=1 tr=0 ts=6900a13c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=nGyChcL-Hsos-sZBGsMA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: vaZVXXfJ7prvJcR8iUk7Xt9Hqwqy8q_z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510250019

If SMT is disabled or a partial SMT state is enabled, when a new kernel
image is loaded for kexec, on reboot the following warning is observed:

kexec: Waking offline cpu 228.
WARNING: CPU: 0 PID: 9062 at arch/powerpc/kexec/core_64.c:223 kexec_prepare_cpus+0x1b0/0x1bc
[snip]
 NIP kexec_prepare_cpus+0x1b0/0x1bc
 LR  kexec_prepare_cpus+0x1a0/0x1bc
 Call Trace:
  kexec_prepare_cpus+0x1a0/0x1bc (unreliable)
  default_machine_kexec+0x160/0x19c
  machine_kexec+0x80/0x88
  kernel_kexec+0xd0/0x118
  __do_sys_reboot+0x210/0x2c4
  system_call_exception+0x124/0x320
  system_call_vectored_common+0x15c/0x2ec

This occurs as add_cpu() fails due to cpu_bootable() returning false for
CPUs that fail the cpu_smt_thread_allowed() check or non primary
threads if SMT is disabled.

Fix the issue by enabling SMT and resetting the number of SMT threads to
the number of threads per core, before attempting to wake up all present
CPUs.

Fixes: 38253464bc82 ("cpu/SMT: Create topology_smt_thread_allowed()")
Reported-by: Sachin P Bappalige <sachinpb@linux.ibm.com>
Cc: stable@vger.kernel.org # v6.6+
Reviewed-by: Srikar Dronamraju <srikar@linux.ibm.com>
Signed-off-by: Nysal Jan K.A. <nysal@linux.ibm.com>
---
 arch/powerpc/kexec/core_64.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 222aa326dace..825ab8a88f18 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -202,6 +202,23 @@ static void kexec_prepare_cpus_wait(int wait_state)
 	mb();
 }
 
+
+/*
+ * The add_cpu() call in wake_offline_cpus() can fail as cpu_bootable()
+ * returns false for CPUs that fail the cpu_smt_thread_allowed() check
+ * or non primary threads if SMT is disabled. Re-enable SMT and set the
+ * number of SMT threads to threads per core.
+ */
+static void kexec_smt_reenable(void)
+{
+#if defined(CONFIG_SMP) && defined(CONFIG_HOTPLUG_SMT)
+	lock_device_hotplug();
+	cpu_smt_num_threads = threads_per_core;
+	cpu_smt_control = CPU_SMT_ENABLED;
+	unlock_device_hotplug();
+#endif
+}
+
 /*
  * We need to make sure each present CPU is online.  The next kernel will scan
  * the device tree and assume primary threads are online and query secondary
@@ -216,6 +233,8 @@ static void wake_offline_cpus(void)
 {
 	int cpu = 0;
 
+	kexec_smt_reenable();
+
 	for_each_present_cpu(cpu) {
 		if (!cpu_online(cpu)) {
 			printk(KERN_INFO "kexec: Waking offline cpu %d.\n",
-- 
2.47.3


