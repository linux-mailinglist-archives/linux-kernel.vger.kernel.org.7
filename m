Return-Path: <linux-kernel+bounces-873622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B472FC14465
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D90B85812AD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D36330DEA2;
	Tue, 28 Oct 2025 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qCj9yXJa"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A1830C630
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649102; cv=none; b=kSQ0GSp248rPA3v7dx52ZXA07JkCuXMi7ptXu/AhRtxnQC0xVmCMImmRcW/g5wIq5e2qh+gU8FkGInRBMdes/ddiviWOudVKL5LlsSNEU8ITeZUEYPgOpsVdSqyYhBA0gqQECRvDod//Dp7pPMzqwEdqrZzo3lIfvjsPXvLJ9c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649102; c=relaxed/simple;
	bh=JxUme9cfnI+8jiySy7ZR+bUgDUIt0Kibj3FZylH8Rk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lmQmqWOdmGXda9v9JvY73fcJLyutufkNmQll6idrTKSoaQoOLJPK+FLmu76Bvd7rz3h+jfompLxCAhNEwWnu5wdY5sAcz/ZSeYlYs+HONs+LYkT73z8EO++YDKcX/QoXRC/IuIE/NxO3E1tYXiaZURe2Yog1BACRUDlq758n3gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qCj9yXJa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S44T58014687;
	Tue, 28 Oct 2025 10:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=+m38Q3fzeV+gGSLEeg95jWXB2c0i8OLehMk5Asu57
	kk=; b=qCj9yXJaQeFnre+7kfoFqeUg4CBDzFmXhPu6T2ICEH9i0NvMTZTlwd6pN
	T3d3fT6gpoUuXricUbWoHJZmc2Xz3NGFKOuh2H0VXJU3AVp2379uJJU/npwGjVCC
	lkFw/N9eH9LjeAYSYvvXjYFdpxvqBc7LDwA6XRhLj8GyReXFbv4Sf1zePAEHqg6c
	shhlkIMpSYxs26jrWx7ArAB69BxqxrE/09GZOdDw2tIrfNs3do2hl+e8e7khJoKD
	NhHT8Q9dA0JsPa/Y1ylNf1Dl8IFASnZXPGqhmEUROefsT/qb2wMlhPr716TzEpQn
	7TPvROJNbddAo3XsqRead7Fur20uA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p7235te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 10:58:04 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59SAucxC015593;
	Tue, 28 Oct 2025 10:58:04 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p7235tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 10:58:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59S7c2U3022896;
	Tue, 28 Oct 2025 10:58:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a198xjc0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 10:58:03 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59SAvxsf8323578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 10:57:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4521620040;
	Tue, 28 Oct 2025 10:57:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87A8D20043;
	Tue, 28 Oct 2025 10:57:57 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.39.27.1])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Oct 2025 10:57:57 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>
Subject: [PATCH] powerpc/smp: Expose die_id and die_cpumask
Date: Tue, 28 Oct 2025 16:27:34 +0530
Message-ID: <20251028105734.1894998-1-srikar@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eqlCB5_NcA4kJxNt4a7G9zp3yNS8OlLf
X-Proofpoint-ORIG-GUID: 60nBmd7rrilIa35fxIj0lje-FnD78iZH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAyNCBTYWx0ZWRfXwLSVbLw6o3bY
 WUvh1fNg2OLg4Tz79hmr6MRax/BBh2Q790zOtus8e0/4BP34wIBgHAsv9H4+L5EkAGZ5K/FAgei
 YWJV6dnJfGrnYJhZFOEOW9FFq1CVFEwVhhtdTTZEoFL8r/1dukRR9BLsEXFdLNzwrI9aj0tn+Y4
 KIryIvZ4mJ2beqzGCNFzVBuQu625uffXHj1IpUsrYqJqNl95PvfdnfQkQwOOkpM8BXoZZ2rs+fg
 ItiDeXf10Qwb+TTbnDuHDbK39VCtI1ZswkrB7FQDfGFFR4n15ZoDvUXiYzW+ioiF72kkCGogtC0
 Kwq44ktecRCEn/ISFxI6Gzey9O9aYVe3/6chylaXi7HnYnM2zCbTv+LRXCCDeyfIb4Uj97RvzRu
 Say4i3rWxV09Hh/HTHLGpxhLoTCq7g==
X-Authority-Analysis: v=2.4 cv=G/gR0tk5 c=1 sm=1 tr=0 ts=6900a1bc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=T_2GlfgT9jnswVrFPU8A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250024

From Power10 processors onwards, each chip has 2 hemispheres. For LPARs
running on PowerVM Hypervisor, hypervisor determines the allocation of
CPU groups to each LPAR, resulting in two LPARs with the same number of
CPUs potentially having different numbers of CPUs from each hemisphere.
Additionally, it is not feasible to ascertain the hemisphere based
solely on the CPU number.

Users wishing to assign their workload to all CPUs, or a subset of CPUs
within a specific hemisphere, encounter difficulties in identifying the
cpumask. To address this, it is proposed to expose hemisphere
information as a die in sysfs. This aligns with other architectures
and facilitates the identification of CPUs within the same hemisphere.
Tools such as lstopo can also access this information.

Please note: The hypervisor reveals the locality of the CPUs to
hemispheres only in dedicated mode. Consequently, in systems where
hemisphere information is unavailable, such as shared LPARs, the
die_cpus information in sysfs will mirror package_cpus, with
die_id set to -1.

Without this change.
$ grep . /sys/devices/system/cpu/cpu8/topology/{die*,package*} 2> /dev/null
/sys/devices/system/cpu/cpu8/topology/package_cpus:0000,ffffff00
/sys/devices/system/cpu/cpu8/topology/package_cpus_list:8-31

With this change.
$ grep . /sys/devices/system/cpu/cpu8/topology/{die*,package*} 2> /dev/null
/sys/devices/system/cpu/cpu8/topology/die_cpus:0000,0000ff00
/sys/devices/system/cpu/cpu8/topology/die_cpus_list:8-15
/sys/devices/system/cpu/cpu8/topology/die_id:4
/sys/devices/system/cpu/cpu8/topology/package_cpus:0000,ffffff00
/sys/devices/system/cpu/cpu8/topology/package_cpus_list:8-31

snipped lstopo-no-graphics o/p
Group0 L#0
  Package L#1
    NUMANode L#1 (P#2 8135MB)
    Die L#0 + Core L#1
      L3 L#2 (4096KB) + L2 L#2 (1024KB) + L1d L#2 (32KB) + L1i L#2 (48KB)
        PU L#8 (P#8)
        PU L#9 (P#10)
        PU L#10 (P#12)
        PU L#11 (P#14)
      L3 L#3 (4096KB) + L2 L#3 (1024KB) + L1d L#3 (32KB) + L1i L#3 (48KB)
        PU L#12 (P#9)
        PU L#13 (P#11)
        PU L#14 (P#13)
        PU L#15 (P#15)
    Die L#1
      Core L#2
        L3 L#4 (4096KB) + L2 L#4 (1024KB) + L1d L#4 (32KB) + L1i L#4 (48KB)
          PU L#16 (P#16)
          PU L#17 (P#18)
          PU L#18 (P#20)
          PU L#19 (P#22)
        L3 L#5 (4096KB) + L2 L#5 (1024KB) + L1d L#5 (32KB) + L1i L#5 (48KB)
          PU L#20 (P#17)
          PU L#21 (P#19)
          PU L#22 (P#21)
          PU L#23 (P#23)
      Core L#3
        L3 L#6 (4096KB) + L2 L#6 (1024KB) + L1d L#6 (32KB) + L1i L#6 (48KB)
          PU L#24 (P#24)
          PU L#25 (P#26)
          PU L#26 (P#28)
          PU L#27 (P#30)
        L3 L#7 (4096KB) + L2 L#7 (1024KB) + L1d L#7 (32KB) + L1i L#7 (48KB)
          PU L#28 (P#25)
          PU L#29 (P#27)
          PU L#30 (P#29)
          PU L#31 (P#31)
  Package L#2

Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
---
 arch/powerpc/include/asm/topology.h |  4 ++++
 arch/powerpc/kernel/smp.c           | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index f19ca44512d1..c6ad1eb7e44a 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -132,6 +132,8 @@ static inline int cpu_to_coregroup_id(int cpu)
 #include <asm/cputable.h>
 
 struct cpumask *cpu_coregroup_mask(int cpu);
+const struct cpumask *cpu_die_mask(int cpu);
+int cpu_die_id(int cpu);
 
 #ifdef CONFIG_PPC64
 #include <asm/smp.h>
@@ -141,6 +143,8 @@ struct cpumask *cpu_coregroup_mask(int cpu);
 #define topology_sibling_cpumask(cpu)	(per_cpu(cpu_sibling_map, cpu))
 #define topology_core_cpumask(cpu)	(per_cpu(cpu_core_map, cpu))
 #define topology_core_id(cpu)		(cpu_to_core_id(cpu))
+#define topology_die_id(cpu) (cpu_die_id(cpu))
+#define topology_die_cpumask(cpu) (cpu_die_mask(cpu))
 
 #endif
 #endif
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 68edb66c2964..a0b0b46b78e3 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1085,6 +1085,24 @@ static int __init init_big_cores(void)
 	return 0;
 }
 
+const struct cpumask *cpu_die_mask(int cpu)
+{
+	if (has_coregroup_support())
+		return per_cpu(cpu_coregroup_map, cpu);
+	else
+		return cpu_node_mask(cpu);
+}
+EXPORT_SYMBOL_GPL(cpu_die_mask);
+
+int cpu_die_id(int cpu)
+{
+	if (has_coregroup_support())
+		return cpu_to_coregroup_id(cpu);
+	else
+		return -1;
+}
+EXPORT_SYMBOL_GPL(cpu_die_id);
+
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned int cpu, num_threads;
-- 
2.43.5


