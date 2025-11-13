Return-Path: <linux-kernel+bounces-899900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8225FC59113
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786743B7D25
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED65377EB4;
	Thu, 13 Nov 2025 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cdG0ebQS"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E6E377E8F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052613; cv=none; b=I153zcAF0phY6Z96BGKdoTCNdRl/0k5tMe7o+GHYZP/yrlBhCY2TYgwCeV7bswisr93U2O1IXblUYxoZ/HQzXVGPYPx8TI5zcZOYUdf6WAgTMzmXlU5e56MroQiTL1PA2X7tfw8hljZmQSergmfjNwhs6P3B3piudE5mDUf4es0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052613; c=relaxed/simple;
	bh=q1IEGmTiexs9Ib6qyK8SgppppMOswulClNlfSmS4lmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqzZrykoRpzzfVJ4sk8xr2DpZdGyH0OaVhvTvNdMoub2J4Py5wBLInxBJxSB4PbPsciqsZ2/K1FkPtw+nW7kbH46xw+a/O04M7E8XxOpisGXnN5lgzBboDdjdVIt+GcD8Mm1FS0S7e/MF+VXu7RKVa5vlNQg/dRn2VEOn5Sr9fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cdG0ebQS; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADEACBt028898;
	Thu, 13 Nov 2025 16:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=l6fvk
	GqlkRFWHMJjPFKdouisSAMlA/D3Tt8Ck13xsB0=; b=cdG0ebQS58QdeI3aRcMc2
	LDF1x/yTFsT7Eyyf8JZ+PvyUl45Sc69GtnFqOGfEwivgWA0qnoqUy6U1pp4dMIR4
	3nN95qRYfSrLsdiDGnGQOq/lavZckdjMgBoqge9QlVCsP6rNfauYZfcJuUsetuNK
	Wvs8Dy0nvNuBmi1LrBj8K9igOlE/ukeoYJV6R4u0yIf8GNZFhkMBGdyO2CZZij0u
	6rjhIjoVAoovxOi1Zj1WconPubDylG710zj3NPJhJuqRe0FRcG8WYAzcgm7ECfYB
	udWtXwbQ58NUwOi2ehCfJ2j1QJIlFKh9CbGj8fP0eVklZiI1GeeMxesmWKhJby5L
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acxpnjb0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:50:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADGE9Wf038600;
	Thu, 13 Nov 2025 16:50:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc45k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:50:01 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnKAX008288;
	Thu, 13 Nov 2025 16:50:01 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-25;
	Thu, 13 Nov 2025 16:50:01 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 24/28] objtool: Function to get the name of a CPU feature
Date: Thu, 13 Nov 2025 17:49:13 +0100
Message-ID: <20251113164917.2563486-25-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251113164917.2563486-1-alexandre.chartre@oracle.com>
References: <20251113164917.2563486-1-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_03,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511130130
X-Authority-Analysis: v=2.4 cv=Criys34D c=1 sm=1 tr=0 ts=69160c3c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=BmP2q_L__UogPSo-:21 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=pMlTRUUgVTb7_b65wjsA:9
X-Proofpoint-GUID: SPjswcxq57Rd10ts7vH0e9Si_IN5tfrW
X-Proofpoint-ORIG-GUID: SPjswcxq57Rd10ts7vH0e9Si_IN5tfrW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0MSBTYWx0ZWRfX7SH9BYiIxjzo
 cgSzCgNz9+e1tFr8swHO1WcE+pEM9gE7R1e9sk0gdbzZ7weXpunSzYvgjiLS45NuZGYrC+kiWoK
 3LBpBhstNfVyiNQnYSEpbiLCBEDTOXxwADANyU77e30b6BWmGhP3mQx13JEfjMeF9ozPa7JETY+
 PAUwMgbataGScOYxzjnknQ4N8d9DDRHwUIy36iIwlsZ1dhBrjo3rmbDH1FERM2Rtg/YEddy+5xN
 ZSDggAUAzGlXHGPrA/ODarCMpXbxQvyCiIvYb6O0qc3JYM6Rca0fLly7449ppnQwoc+77KT+vSh
 ZLOiwH8HC0kqo2jmA7zeJ2T4PrRQmWPFIEnuNsihzk1BjQ2tSTWan1PXH0f2CrzaE7m4gHiJsfV
 mu74EE7KMzCDpmJJovAroRrK9MCPYw==

Add a function to get the name of a CPU feature. The function is
architecture dependent and currently only implemented for x86. The
feature names are automatically generated from the cpufeatures.h
include file.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 .../x86/tools/gen-cpu-feature-names-x86.awk   | 33 +++++++++++++++++++
 tools/objtool/Makefile                        |  1 +
 tools/objtool/arch/loongarch/special.c        |  5 +++
 tools/objtool/arch/powerpc/special.c          |  5 +++
 tools/objtool/arch/x86/Build                  |  8 +++++
 tools/objtool/arch/x86/special.c              | 10 ++++++
 tools/objtool/include/objtool/special.h       |  2 ++
 7 files changed, 64 insertions(+)
 create mode 100644 tools/arch/x86/tools/gen-cpu-feature-names-x86.awk

diff --git a/tools/arch/x86/tools/gen-cpu-feature-names-x86.awk b/tools/arch/x86/tools/gen-cpu-feature-names-x86.awk
new file mode 100644
index 0000000000000..1b1c1d84225c2
--- /dev/null
+++ b/tools/arch/x86/tools/gen-cpu-feature-names-x86.awk
@@ -0,0 +1,33 @@
+#!/bin/awk -f
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2025, Oracle and/or its affiliates.
+#
+# Usage: awk -f gen-cpu-feature-names-x86.awk cpufeatures.h > cpu-feature-names.c
+#
+
+BEGIN {
+	print "/* cpu feature name array generated from cpufeatures.h */"
+	print "/* Do not change this code. */"
+	print
+	print "static const char *cpu_feature_names[(NCAPINTS+NBUGINTS)*32] = {"
+
+	feature_expr = "(X86_FEATURE_[A-Z0-9_]+)\\s+\\(([0-9*+ ]+)\\)"
+	debug_expr = "(X86_BUG_[A-Z0-9_]+)\\s+X86_BUG\\(([0-9*+ ]+)\\)"
+}
+
+/^#define X86_FEATURE_/ {
+	if (match($0, feature_expr, m)) {
+		print "\t[" m[2] "] = \"" m[1] "\","
+	}
+}
+
+/^#define X86_BUG_/ {
+	if (match($0, debug_expr, m)) {
+		print "\t[NCAPINTS*32+(" m[2] ")] = \"" m[1] "\","
+	}
+}
+
+END {
+	print "};"
+}
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 9fb83979ca890..b6df180121589 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -109,6 +109,7 @@ clean: $(LIBSUBCMD)-clean
 	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL)
 	$(Q)find $(OUTPUT) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT)arch/x86/lib/inat-tables.c $(OUTPUT)fixdep
+	$(Q)$(RM) $(OUTPUT)arch/x86/lib/cpu-feature-names.c $(OUTPUT)fixdep
 
 FORCE:
 
diff --git a/tools/objtool/arch/loongarch/special.c b/tools/objtool/arch/loongarch/special.c
index a80b75f7b061f..aba774109437f 100644
--- a/tools/objtool/arch/loongarch/special.c
+++ b/tools/objtool/arch/loongarch/special.c
@@ -194,3 +194,8 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 
 	return rodata_reloc;
 }
+
+const char *arch_cpu_feature_name(int feature_number)
+{
+	return NULL;
+}
diff --git a/tools/objtool/arch/powerpc/special.c b/tools/objtool/arch/powerpc/special.c
index 51610689abf72..8f9bf61ca0899 100644
--- a/tools/objtool/arch/powerpc/special.c
+++ b/tools/objtool/arch/powerpc/special.c
@@ -18,3 +18,8 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 {
 	exit(-1);
 }
+
+const char *arch_cpu_feature_name(int feature_number)
+{
+	return NULL;
+}
diff --git a/tools/objtool/arch/x86/Build b/tools/objtool/arch/x86/Build
index 3dedb2fd8f3a0..1067355361b56 100644
--- a/tools/objtool/arch/x86/Build
+++ b/tools/objtool/arch/x86/Build
@@ -11,4 +11,12 @@ $(OUTPUT)arch/x86/lib/inat-tables.c: $(inat_tables_script) $(inat_tables_maps)
 
 $(OUTPUT)arch/x86/decode.o: $(OUTPUT)arch/x86/lib/inat-tables.c
 
+cpu_features = ../arch/x86/include/asm/cpufeatures.h
+cpu_features_script = ../arch/x86/tools/gen-cpu-feature-names-x86.awk
+
+$(OUTPUT)arch/x86/lib/cpu-feature-names.c: $(cpu_features_script) $(cpu_features)
+	$(Q)$(call echo-cmd,gen)$(AWK) -f $(cpu_features_script) $(cpu_features) > $@
+
+$(OUTPUT)arch/x86/special.o: $(OUTPUT)arch/x86/lib/cpu-feature-names.c
+
 CFLAGS_decode.o += -I$(OUTPUT)arch/x86/lib
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 06ca4a2659a45..720127fd4d025 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -4,6 +4,10 @@
 #include <objtool/special.h>
 #include <objtool/builtin.h>
 #include <objtool/warn.h>
+#include <asm/cpufeatures.h>
+
+/* cpu feature name array generated from cpufeatures.h */
+#include "lib/cpu-feature-names.c"
 
 void arch_handle_alternative(struct special_alt *alt)
 {
@@ -134,3 +138,9 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 	*table_size = 0;
 	return rodata_reloc;
 }
+
+const char *arch_cpu_feature_name(int feature_number)
+{
+	return (feature_number < ARRAY_SIZE(cpu_feature_names)) ?
+		cpu_feature_names[feature_number] : NULL;
+}
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
index b22410745e4a1..121c3761899c1 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -38,4 +38,6 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 struct reloc *arch_find_switch_table(struct objtool_file *file,
 				     struct instruction *insn,
 				     unsigned long *table_size);
+const char *arch_cpu_feature_name(int feature_number);
+
 #endif /* _SPECIAL_H */
-- 
2.43.5


