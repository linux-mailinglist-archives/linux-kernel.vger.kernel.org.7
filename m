Return-Path: <linux-kernel+bounces-618838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 402F5A9B420
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 18:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9211BA7405
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 16:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEAE28B4E6;
	Thu, 24 Apr 2025 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GgAFBDBZ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC3D28A1F5;
	Thu, 24 Apr 2025 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512285; cv=none; b=TFLXxUPBdRn65HgRFtfi2smRWGsOehXhTEY+asjR95+XZy0Qbdpa8G5WokD2obZxrZ4XZgsE8UGW3SRtVbHOGG6N5LQGoNoZyH7hPEoIN5gWl9Ey6z73gYVO6Z4HQLicn0ORlkOhaWBQO701Ha6cn2EkZfIKbF28hTq3sSBvRTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512285; c=relaxed/simple;
	bh=8QlfL504AlrDBflKeQr9raFxx+ggF+hQRWXr0xUPChw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DNmcwic2fZdTb4bgcpL+hEqx5qySS+RdQN7SxdppE7JRemdTw3EDCTy1PucQ+vvh/zXd71HpIEU2wAniKlCo4ag7ZEeOxAcj9GDBnJEqUdMmBW9Pw4iaEFaH0HKu80Uw4sOlXeQyabug7A/2TwM89FEfVH7wIysu3cMx9XyRmcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GgAFBDBZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OA4BSo001192;
	Thu, 24 Apr 2025 16:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=AeStgiHpN78toq6wCfUHn8W/0v1Icm8psMwmJXEJd
	LY=; b=GgAFBDBZ5zBwX2gqNhhYxHMWJnYn+VZdnO4l+FETxDTDrvpW9mOcepUNV
	UpcuReCfMmLaqnpWR3QQnecVqmVmz/ul3FMjP1yrnUmKntkc/253XUbzHHZlXtcp
	Fb0QijrTBrR8SqNSUbEaNnF3K+JfN9XQxgGSnHvpFn7rALsLV2vENA+BsD1UoqEZ
	Bks0GaMR12fIKZ7+srpouW3nWyb99ViEZlA6R1I6bjj6PqU/CKIMSEbLy6Lnf+3V
	zCB2qdl6Dw11+RDmQPKAjMQzXV8QP2pAMWd3tukD1AZDL47He5U+SMWXdyYesnkW
	yYLx1rpvRcG5Wct2nJYEO1H2+Qlwg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467k7k1x15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 16:30:53 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53OGIBQr009207;
	Thu, 24 Apr 2025 16:30:52 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467k7k1x0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 16:30:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OFTM7A005893;
	Thu, 24 Apr 2025 16:30:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxh19t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 16:30:51 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53OGUlv838601056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 16:30:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C68520043;
	Thu, 24 Apr 2025 16:30:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FD602004B;
	Thu, 24 Apr 2025 16:30:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.255.99])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 16:30:37 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, hbathini@linux.vnet.ibm.com,
        Aditya.Bodkhe1@ibm.com, jiang.peng9@zte.com.cn, venkat88@linux.ibm.com,
        Tejas.Manhas1@ibm.com, sshegde@linux.ibm.com, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org, mingo@redhat.com, ravi.bangoria@amd.com,
        bp@alien8.de
Subject: [PATCH] perf build: Add tools/arch/x86/include/asm/amd/ibs.h to sync the headers
Date: Thu, 24 Apr 2025 22:00:33 +0530
Message-Id: <20250424163033.6601-1-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: c6LYmF1ELxYl5aF87cqOMbGU_VZNdb7w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDExMCBTYWx0ZWRfX2xV+lQy/Ilnv sapCP8MXS+DVtkTvt29rNSRHEYMTZSb6g2U57E4OJwRX1woMoZGCYq3ct86z0eXBkNknPy5x3PI 3u7MY0H5c4mECAQHDzveoIfQrzbhEZbDGrwYHXr/bthUThTLYO8qGVgiLnDdNfhkP4nJaKko4IV
 uDPpFiv48IF9wdZunAbfTuMVO/RKSFQnqyFp5YfaAryA/fNWpg4XNO5Z+rhOgByijkszEPH1ibi 8FxF07cuf2DA+ZEnnVg+tLJOXFVonh6h5rL1Tm+Vd32IJY12QjxKoARra48JE6+dNE7k8G065t9 3ugtPUBzPunpG3qlhE4D952U+w9s8hG3GG43i0sqfr+2v1M4aqfOS1bjP4Sab2SsZx0vjcheoh1
 1p/GlZMXl+7M3ytG8GBbz4+sEA5YminMu6MqcxI08YuQS830KeBkmVSahBDrdR3L+Ix7i3Ct
X-Authority-Analysis: v=2.4 cv=KZjSsRYD c=1 sm=1 tr=0 ts=680a673d cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=XR8D0OoHHMoA:10 a=rOUgymgbAAAA:8 a=VnNF1IyMAAAA:8 a=TPoRyGlK7JHtAbWEY9kA:9 a=MP9ZtiD8KjrkvI0BhSjB:22
X-Proofpoint-GUID: 1LXnGdwGsU6jl9leUgjpDfjYAA1YR0O1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240110

Headers sync up update for the patch that adds the original
copy of the IBS header file in arch/x86/include/asm/amd/ibs.h

Without this, perf shows build warning:

 # make
  BUILD:   Doing 'make -j24' parallel build
diff: tools/arch/x86/include/asm/amd/ibs.h: No such file or directory
Warning: Kernel ABI header differences:
  diff -u tools/include/uapi/linux/bits.h include/uapi/linux/bits.h
  diff -u tools/include/linux/bits.h include/linux/bits.h
  diff -u tools/include/vdso/unaligned.h include/vdso/unaligned.h
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
  diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
  diff -u tools/arch/x86/include/asm/amd/ibs.h arch/x86/include/asm/amd/ibs.h
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h

Add tools/arch/x86/include/asm/amd directory and also file
tools/arch/x86/include/asm/amd/ibs.h to sync up the kernel headers
with perf tools and fix the warning:

diff: tools/arch/x86/include/asm/amd/ibs.h: No such file or directory

Apart from the warning, the perf build also fails as below on powerpc:

  In file included from util/amd-sample-raw.c:12:0:
  /root/bug/tip/tools/include/../../arch/x86/include/asm/amd/ibs.h:10:10: fatal error: asm/msr-index.h: No such file or directory
   #include <asm/msr-index.h>
            ^~~~~~~~~~~~~~~~~
  compilation terminated.

To fix this, added this change:

  -#include <asm/msr-index.h>
  +#include "../msr-index.h"

And change the check-headers.sh entry to ignore this line when
comparing with the original kernel header.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/arch/x86/include/asm/amd/ibs.h | 158 +++++++++++++++++++++++++++
 tools/perf/check-headers.sh          |   2 +-
 2 files changed, 159 insertions(+), 1 deletion(-)
 create mode 100644 tools/arch/x86/include/asm/amd/ibs.h

diff --git a/tools/arch/x86/include/asm/amd/ibs.h b/tools/arch/x86/include/asm/amd/ibs.h
new file mode 100644
index 000000000000..cbce54fec7b9
--- /dev/null
+++ b/tools/arch/x86/include/asm/amd/ibs.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_AMD_IBS_H
+#define _ASM_X86_AMD_IBS_H
+
+/*
+ * From PPR Vol 1 for AMD Family 19h Model 01h B1
+ * 55898 Rev 0.35 - Feb 5, 2021
+ */
+
+#include "../msr-index.h"
+
+/* IBS_OP_DATA2 DataSrc */
+#define IBS_DATA_SRC_LOC_CACHE			 2
+#define IBS_DATA_SRC_DRAM			 3
+#define IBS_DATA_SRC_REM_CACHE			 4
+#define IBS_DATA_SRC_IO				 7
+
+/* IBS_OP_DATA2 DataSrc Extension */
+#define IBS_DATA_SRC_EXT_LOC_CACHE		 1
+#define IBS_DATA_SRC_EXT_NEAR_CCX_CACHE		 2
+#define IBS_DATA_SRC_EXT_DRAM			 3
+#define IBS_DATA_SRC_EXT_FAR_CCX_CACHE		 5
+#define IBS_DATA_SRC_EXT_PMEM			 6
+#define IBS_DATA_SRC_EXT_IO			 7
+#define IBS_DATA_SRC_EXT_EXT_MEM		 8
+#define IBS_DATA_SRC_EXT_PEER_AGENT_MEM		12
+
+/*
+ * IBS Hardware MSRs
+ */
+
+/* MSR 0xc0011030: IBS Fetch Control */
+union ibs_fetch_ctl {
+	__u64 val;
+	struct {
+		__u64	fetch_maxcnt:16,/* 0-15: instruction fetch max. count */
+			fetch_cnt:16,	/* 16-31: instruction fetch count */
+			fetch_lat:16,	/* 32-47: instruction fetch latency */
+			fetch_en:1,	/* 48: instruction fetch enable */
+			fetch_val:1,	/* 49: instruction fetch valid */
+			fetch_comp:1,	/* 50: instruction fetch complete */
+			ic_miss:1,	/* 51: i-cache miss */
+			phy_addr_valid:1,/* 52: physical address valid */
+			l1tlb_pgsz:2,	/* 53-54: i-cache L1TLB page size
+					 *	  (needs IbsPhyAddrValid) */
+			l1tlb_miss:1,	/* 55: i-cache fetch missed in L1TLB */
+			l2tlb_miss:1,	/* 56: i-cache fetch missed in L2TLB */
+			rand_en:1,	/* 57: random tagging enable */
+			fetch_l2_miss:1,/* 58: L2 miss for sampled fetch
+					 *      (needs IbsFetchComp) */
+			l3_miss_only:1,	/* 59: Collect L3 miss samples only */
+			fetch_oc_miss:1,/* 60: Op cache miss for the sampled fetch */
+			fetch_l3_miss:1,/* 61: L3 cache miss for the sampled fetch */
+			reserved:2;	/* 62-63: reserved */
+	};
+};
+
+/* MSR 0xc0011033: IBS Execution Control */
+union ibs_op_ctl {
+	__u64 val;
+	struct {
+		__u64	opmaxcnt:16,	/* 0-15: periodic op max. count */
+			l3_miss_only:1,	/* 16: Collect L3 miss samples only */
+			op_en:1,	/* 17: op sampling enable */
+			op_val:1,	/* 18: op sample valid */
+			cnt_ctl:1,	/* 19: periodic op counter control */
+			opmaxcnt_ext:7,	/* 20-26: upper 7 bits of periodic op maximum count */
+			reserved0:5,	/* 27-31: reserved */
+			opcurcnt:27,	/* 32-58: periodic op counter current count */
+			ldlat_thrsh:4,	/* 59-62: Load Latency threshold */
+			ldlat_en:1;	/* 63: Load Latency enabled */
+	};
+};
+
+/* MSR 0xc0011035: IBS Op Data 1 */
+union ibs_op_data {
+	__u64 val;
+	struct {
+		__u64	comp_to_ret_ctr:16,	/* 0-15: op completion to retire count */
+			tag_to_ret_ctr:16,	/* 15-31: op tag to retire count */
+			reserved1:2,		/* 32-33: reserved */
+			op_return:1,		/* 34: return op */
+			op_brn_taken:1,		/* 35: taken branch op */
+			op_brn_misp:1,		/* 36: mispredicted branch op */
+			op_brn_ret:1,		/* 37: branch op retired */
+			op_rip_invalid:1,	/* 38: RIP is invalid */
+			op_brn_fuse:1,		/* 39: fused branch op */
+			op_microcode:1,		/* 40: microcode op */
+			reserved2:23;		/* 41-63: reserved */
+	};
+};
+
+/* MSR 0xc0011036: IBS Op Data 2 */
+union ibs_op_data2 {
+	__u64 val;
+	struct {
+		__u64	data_src_lo:3,	/* 0-2: data source low */
+			reserved0:1,	/* 3: reserved */
+			rmt_node:1,	/* 4: destination node */
+			cache_hit_st:1,	/* 5: cache hit state */
+			data_src_hi:2,	/* 6-7: data source high */
+			reserved1:56;	/* 8-63: reserved */
+	};
+};
+
+/* MSR 0xc0011037: IBS Op Data 3 */
+union ibs_op_data3 {
+	__u64 val;
+	struct {
+		__u64	ld_op:1,			/* 0: load op */
+			st_op:1,			/* 1: store op */
+			dc_l1tlb_miss:1,		/* 2: data cache L1TLB miss */
+			dc_l2tlb_miss:1,		/* 3: data cache L2TLB hit in 2M page */
+			dc_l1tlb_hit_2m:1,		/* 4: data cache L1TLB hit in 2M page */
+			dc_l1tlb_hit_1g:1,		/* 5: data cache L1TLB hit in 1G page */
+			dc_l2tlb_hit_2m:1,		/* 6: data cache L2TLB hit in 2M page */
+			dc_miss:1,			/* 7: data cache miss */
+			dc_mis_acc:1,			/* 8: misaligned access */
+			reserved:4,			/* 9-12: reserved */
+			dc_wc_mem_acc:1,		/* 13: write combining memory access */
+			dc_uc_mem_acc:1,		/* 14: uncacheable memory access */
+			dc_locked_op:1,			/* 15: locked operation */
+			dc_miss_no_mab_alloc:1,		/* 16: DC miss with no MAB allocated */
+			dc_lin_addr_valid:1,		/* 17: data cache linear address valid */
+			dc_phy_addr_valid:1,		/* 18: data cache physical address valid */
+			dc_l2_tlb_hit_1g:1,		/* 19: data cache L2 hit in 1GB page */
+			l2_miss:1,			/* 20: L2 cache miss */
+			sw_pf:1,			/* 21: software prefetch */
+			op_mem_width:4,			/* 22-25: load/store size in bytes */
+			op_dc_miss_open_mem_reqs:6,	/* 26-31: outstanding mem reqs on DC fill */
+			dc_miss_lat:16,			/* 32-47: data cache miss latency */
+			tlb_refill_lat:16;		/* 48-63: L1 TLB refill latency */
+	};
+};
+
+/* MSR 0xc001103c: IBS Fetch Control Extended */
+union ic_ibs_extd_ctl {
+	__u64 val;
+	struct {
+		__u64	itlb_refill_lat:16,	/* 0-15: ITLB Refill latency for sampled fetch */
+			reserved:48;		/* 16-63: reserved */
+	};
+};
+
+/*
+ * IBS driver related
+ */
+
+struct perf_ibs_data {
+	u32		size;
+	union {
+		u32	data[0];	/* data buffer starts here */
+		u32	caps;
+	};
+	u64		regs[MSR_AMD64_IBS_REG_COUNT_MAX];
+};
+
+#endif /* _ASM_X86_AMD_IBS_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index e9fab20e9330..e1a1fdfa7115 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -186,7 +186,7 @@ done
 # diff with extra ignore lines
 check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memcpy_\(erms\|orig\))" -I"^#include <linux/cfi_types.h>"'
 check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
-check arch/x86/include/asm/amd/ibs.h  '-I "^#include [<\"]\(asm/\)*msr-index.h"'
+check arch/x86/include/asm/amd/ibs.h  '-I "^#include <asm/msr-index.h>" -I "^#include \"\.\./msr-index.h\""'
 check arch/arm64/include/asm/cputype.h '-I "^#include [<\"]\(asm/\)*sysreg.h"'
 check include/linux/unaligned.h '-I "^#include <linux/unaligned/packed_struct.h>" -I "^#include <asm/byteorder.h>" -I "^#pragma GCC diagnostic"'
 check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common\(-tools\)*.h>"'
-- 
2.43.0


