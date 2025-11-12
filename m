Return-Path: <linux-kernel+bounces-897694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EC2C53792
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03649507316
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B599253F11;
	Wed, 12 Nov 2025 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nz1GCaaR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D318734CFDE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963481; cv=none; b=jtk2mtaTIk6gWp68QoczOk3N8/6QfjbGjwOegBjiRrgAku89kFJDryqAwqG22gySEZNvtpvgNvhi9V8ZWo2NyDjuoNtE6kR479cb7bqBF/vmRGEK3HQ6iM9sktqwvCP7R+pM49dBWBj31oiYsvbQJesKdnehHHm8G3u6l1K4JYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963481; c=relaxed/simple;
	bh=q1IEGmTiexs9Ib6qyK8SgppppMOswulClNlfSmS4lmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSyMOYgvbBLbsCp3qysXJ2t3eP6CFbz3N92dviACQLNr69QsQg80OzKtSswOmbo1Qd3c9tllHLAXAso0L6zd3toH+1Er9XDtAgX70ceJSxmOGqxQaoft6shLjuvgPwFSX6ZroVo/+0blrT3nZK5iflZAE3Z09mFfJZ6ua9T0ARo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nz1GCaaR; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFWJh5012803;
	Wed, 12 Nov 2025 16:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=l6fvk
	GqlkRFWHMJjPFKdouisSAMlA/D3Tt8Ck13xsB0=; b=nz1GCaaR61zT2GtKlXNQk
	MmoGBpQ9lwaTUybZ91xa3eyu6XVHQVccMeyvOWbN7pIqh+657q2XjAe/mUAMPdyz
	QIR2q2+nL34AJMlr49k4rGJANT0K+MBtXWmuxmAG9OPxr9eCpJmU+oNPX+bkSNMd
	/AVFCTEnHmQmO/wEAqXgUw20cMZnLzI5vFR2v2zpyTfkjqDbnZvvA83OWG+4ji2C
	yULj/dPi9NMlefhpeq0xoGYE8NH7zzzRjjf5naPpsyLbfWxSsKojIPamq2TqbKkZ
	UGqOQDbH7zab91ya3ZwNw4H2NoJgNVqpeeBIcfTKwbn8GFdsaqlgT4c43Aa/y0Sn
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acv97r6e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG2QO018581;
	Wed, 12 Nov 2025 16:04:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavqqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:31 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw44004655;
	Wed, 12 Nov 2025 16:04:30 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-25;
	Wed, 12 Nov 2025 16:04:30 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 24/28] objtool: Function to get the name of a CPU feature
Date: Wed, 12 Nov 2025 17:03:11 +0100
Message-ID: <20251112160315.2207947-25-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251112160315.2207947-1-alexandre.chartre@oracle.com>
References: <20251112160315.2207947-1-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511120130
X-Authority-Analysis: v=2.4 cv=Cseys34D c=1 sm=1 tr=0 ts=6914b010 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=BmP2q_L__UogPSo-:21 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=pMlTRUUgVTb7_b65wjsA:9
X-Proofpoint-ORIG-GUID: j617Vnm3WrcdUjovh55_dhzV2N-q74Hi
X-Proofpoint-GUID: j617Vnm3WrcdUjovh55_dhzV2N-q74Hi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOSBTYWx0ZWRfX5//vc4PG7dY0
 89R7+8PH39lz0d9oVqdFQN8PpECDlHFC1YVASTUJn08m9WCfZSizbICo/h5Iay+WpeDV6Eg75x/
 6KLN29hv9OVg7VTSkJHGBbLmnj4nNyhlmjcsN+RxPTxYDx82NmkSUo58wUDtVlLMyqGA6KWyoAf
 sw7b8gxkfbhsn8vygs7MiNwa3UoQzv7WPxaVCevkkNOnJj9FyBXmB4wrtdYVWEn7mgrtwqWOFB9
 lJfr8vz102c0mTAIjWa2Z4ZNfGFh6UAtkiNy4nGZJGSs9GaDb/BRyRgR6UpOfyMN0i56JswLvBm
 QnVn4w3Lff9lQz13FIjvo86Pvnxh8+Vv6uAZXaTKWZ8ZFW1QQAD1PQGk2n3A0vdPOZ79TNwLCdP
 fq1uQSnHnWWAUmt3nr/79U2x2xE0Uw==

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


