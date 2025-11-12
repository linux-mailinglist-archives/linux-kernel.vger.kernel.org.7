Return-Path: <linux-kernel+bounces-897671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 614E2C5359D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F2A5548627
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BF327E7EC;
	Wed, 12 Nov 2025 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bYGCguLR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548D02D9ED1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963449; cv=none; b=Y6cMn0ztfqwS+jrpUfuv4DiOxMCB8QiwOUQXL9+qGgp5rhKLJldHxPpLYc/oAimENqU46wnhD/jjcQsFga8p+lrzDzbD+Me01SvgjA78TWXntQz+8BMdSGtdHdjKrIGezR9cgQ7KYKfgH80+Dm3iB6Lfl5OtfhwbNmXzEi3ls1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963449; c=relaxed/simple;
	bh=YMbw6/nENvpM45mmzHzORWdsMnSBo77/yZqJf9BU/I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXrsGdktXKPGrJs0Q0W7D7h9NnwCm6u6nJwnoAAfW4D8cwKwokpPYpAFvr7cMedCjQDYCgttijRPAyeRa/P8BPxNdAiOJKcylM8e7XvRRLFSLvA96Oqbfny32ouFnPtAeKZLxfi5FautNee4CA8SNpekdrE67y/0OqemuRu6iPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bYGCguLR; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFWJh0012803;
	Wed, 12 Nov 2025 16:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Dfx1t
	7Iz5C+Oq8EsuENpgoY4JktmC9uWXKMsptLUWF4=; b=bYGCguLR12C9JYDgPgiPA
	41S8w+lqoPcqbyCpkVq/tzfCw8t6kc7n+qd7CnRB6tBnIY4opPSyXS3KnizffwVY
	a7hAPMaiGHeTKFgnzYpSFxGlD4Icap11gtsroPZO/BsaBA4Ajga8FeZLGEroq2hh
	SQj5dQEzzQT4hw38MLwjPll8t13vptlgI28jIvcUc/6hISTsQPzlECvSbPN//XOb
	QG83gDoKrEpx/r177cNYyOXX4203Tmtzt4TVni+4Ane4e1NJ2MKU2DIApGZpi/3S
	LiD7q5o5Jbfxlipz3WEzk7Z3NfCLksLX5bXYcFY1J/41ZI7I6BfNKAsvFu5rSyuA
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acv97r6cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:03:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACG3g0F018703;
	Wed, 12 Nov 2025 16:03:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavpww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:03:54 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw3M004655;
	Wed, 12 Nov 2025 16:03:53 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-4;
	Wed, 12 Nov 2025 16:03:53 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 03/28] objtool: Disassemble code with libopcodes instead of running objdump
Date: Wed, 12 Nov 2025 17:02:50 +0100
Message-ID: <20251112160315.2207947-4-alexandre.chartre@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=Cseys34D c=1 sm=1 tr=0 ts=6914afeb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=qB_9k6UZtangfgbWIO8A:9
X-Proofpoint-ORIG-GUID: 49bPFJC2_arvh2xBbIPTSjiVDGen9-Y-
X-Proofpoint-GUID: 49bPFJC2_arvh2xBbIPTSjiVDGen9-Y-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOSBTYWx0ZWRfX5/v6E2ZB3TkG
 UMj9j1P0Rb7HpyYRZOmFq3A+6Ov+AsCW4YzjtFLN7rDp+ci+xe724hLDi+EhVQ/nHJQ3UbFgCRi
 BLQL4XGIJOn8Lavnz0dezotJEWKGHwf+TCY/P9N9DpdKk1DPJIN46ZzUNopOH4N5SbxmyPDCJ3G
 5h/X2YegKyDYA621u2i9U19vF6o/umiD7NecsEDy8gnz6M7nbdSDIya/zwW/DaF8cailbuW0X4h
 ZvHIC49D0oL08iencw12ke8PmOPaxcu8wKv5c5YJrcG2JtP9gMhcLgTjyTMO4QN/BjxBsnJI1Jn
 eoXv9qYv7Q5sSvNndW9zCU00FIlRAcR+U9TnTM/LJ8RlEHeT3Nr+O4WHkow7gDwmh5zIin8RRzP
 YYWJ3Kwm/gqSdrMXLi+iy+qfihcUMg==

objtool executes the objdump command to disassemble code. Use libopcodes
instead to have more control about the disassembly scope and output.
If libopcodes is not present then objtool is built without disassembly
support.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/Build                   |   3 +-
 tools/objtool/Makefile                |  22 +++
 tools/objtool/arch/loongarch/decode.c |  12 ++
 tools/objtool/arch/powerpc/decode.c   |  12 ++
 tools/objtool/arch/x86/decode.c       |  12 ++
 tools/objtool/check.c                 |  10 +-
 tools/objtool/disas.c                 | 187 +++++++++++++++++---------
 tools/objtool/include/objtool/arch.h  |   9 ++
 tools/objtool/include/objtool/check.h |   5 +
 tools/objtool/include/objtool/disas.h |  29 ++++
 10 files changed, 230 insertions(+), 71 deletions(-)

diff --git a/tools/objtool/Build b/tools/objtool/Build
index 677bf9148cba1..ee04fba8c9d16 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -7,7 +7,8 @@ objtool-y += special.o
 objtool-y += builtin-check.o
 objtool-y += elf.o
 objtool-y += objtool.o
-objtool-y += disas.o
+
+objtool-$(BUILD_DISAS) += disas.o
 
 objtool-$(BUILD_ORC) += orc_gen.o
 objtool-$(BUILD_ORC) += orc_dump.o
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 8c20361dd100e..9fb83979ca890 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -7,6 +7,15 @@ srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif
 
+#
+# To support disassembly, objtool needs libopcodes which is provided
+# with libbdf (binutils-dev or binutils-devel package).
+#
+FEATURE_USER = .objtool
+FEATURE_TESTS = libbfd disassembler-init-styled
+FEATURE_DISPLAY =
+include $(srctree)/tools/build/Makefile.feature
+
 LIBSUBCMD_DIR = $(srctree)/tools/lib/subcmd/
 ifneq ($(OUTPUT),)
   LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
@@ -40,6 +49,18 @@ OBJTOOL_LDFLAGS := $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
 elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(HOSTCC) $(OBJTOOL_CFLAGS) -x c -E - 2>/dev/null | grep elf_getshdr)
 OBJTOOL_CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
 
+ifeq ($(feature-disassembler-init-styled), 1)
+	OBJTOOL_CFLAGS += -DDISASM_INIT_STYLED
+endif
+
+BUILD_DISAS := n
+
+ifeq ($(feature-libbfd),1)
+	BUILD_DISAS := y
+	OBJTOOL_CFLAGS += -DDISAS
+	OBJTOOL_LDFLAGS += -lopcodes
+endif
+
 # Always want host compilation.
 HOST_OVERRIDES := CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)"
 
@@ -56,6 +77,7 @@ ifeq ($(SRCARCH),loongarch)
 	BUILD_ORC := y
 endif
 
+export BUILD_DISAS
 export BUILD_ORC
 export srctree OUTPUT CFLAGS SRCARCH AWK
 include $(srctree)/tools/build/Makefile.include
diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
index 2e555c4060c5e..9fd88431e8f48 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include <string.h>
 #include <objtool/check.h>
+#include <objtool/disas.h>
 #include <objtool/warn.h>
 #include <asm/inst.h>
 #include <asm/orc_types.h>
@@ -414,3 +415,14 @@ unsigned long arch_jump_table_sym_offset(struct reloc *reloc, struct reloc *tabl
 		return reloc->sym->offset + reloc_addend(reloc);
 	}
 }
+
+#ifdef DISAS
+
+int arch_disas_info_init(struct disassemble_info *dinfo)
+{
+	return disas_info_init(dinfo, bfd_arch_loongarch,
+			       bfd_mach_loongarch32, bfd_mach_loongarch64,
+			       NULL);
+}
+
+#endif /* DISAS */
diff --git a/tools/objtool/arch/powerpc/decode.c b/tools/objtool/arch/powerpc/decode.c
index c851c51d4bd35..3c6fced37bcca 100644
--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -3,6 +3,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <objtool/check.h>
+#include <objtool/disas.h>
 #include <objtool/elf.h>
 #include <objtool/arch.h>
 #include <objtool/warn.h>
@@ -128,3 +129,14 @@ unsigned int arch_reloc_size(struct reloc *reloc)
 		return 8;
 	}
 }
+
+#ifdef DISAS
+
+int arch_disas_info_init(struct disassemble_info *dinfo)
+{
+	return disas_info_init(dinfo, bfd_arch_powerpc,
+			       bfd_mach_ppc, bfd_mach_ppc64,
+			       NULL);
+}
+
+#endif /* DISAS */
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 0ad5cc70ecbe7..2f7045e1accc0 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -16,6 +16,7 @@
 
 #include <asm/orc_types.h>
 #include <objtool/check.h>
+#include <objtool/disas.h>
 #include <objtool/elf.h>
 #include <objtool/arch.h>
 #include <objtool/warn.h>
@@ -892,3 +893,14 @@ bool arch_absolute_reloc(struct elf *elf, struct reloc *reloc)
 		return false;
 	}
 }
+
+#ifdef DISAS
+
+int arch_disas_info_init(struct disassemble_info *dinfo)
+{
+	return disas_info_init(dinfo, bfd_arch_i386,
+			       bfd_mach_i386_i386, bfd_mach_x86_64,
+			       "att");
+}
+
+#endif /* DISAS */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7b6fa1e3e9aac..86cd5385a14a0 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4786,8 +4786,6 @@ int check(struct objtool_file *file)
 			goto out;
 	}
 
-	free_insns(file);
-
 	if (opts.stats) {
 		printf("nr_insns_visited: %ld\n", nr_insns_visited);
 		printf("nr_cfi: %ld\n", nr_cfi);
@@ -4807,9 +4805,13 @@ int check(struct objtool_file *file)
 			WARN("%d warning(s) upgraded to errors", warnings);
 		print_args();
 		disas_ctx = disas_context_create(file);
-		disas_warned_funcs(disas_ctx);
-		disas_context_destroy(disas_ctx);
+		if (disas_ctx) {
+			disas_warned_funcs(disas_ctx);
+			disas_context_destroy(disas_ctx);
+		}
 	}
 
+	free_insns(file);
+
 	return ret;
 }
diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 8c751f3394865..e9e7cb21b2a4b 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -4,18 +4,56 @@
  */
 
 #include <objtool/arch.h>
+#include <objtool/check.h>
 #include <objtool/disas.h>
 #include <objtool/warn.h>
 
+#include <bfd.h>
 #include <linux/string.h>
+#include <tools/dis-asm-compat.h>
 
 struct disas_context {
 	struct objtool_file *file;
+	disassembler_ftype disassembler;
+	struct disassemble_info info;
 };
 
+#define DINFO_FPRINTF(dinfo, ...)	\
+	((*(dinfo)->fprintf_func)((dinfo)->stream, __VA_ARGS__))
+
+/*
+ * Initialize disassemble info arch, mach (32 or 64-bit) and options.
+ */
+int disas_info_init(struct disassemble_info *dinfo,
+		    int arch, int mach32, int mach64,
+		    const char *options)
+{
+	struct disas_context *dctx = dinfo->application_data;
+	struct objtool_file *file = dctx->file;
+
+	dinfo->arch = arch;
+
+	switch (file->elf->ehdr.e_ident[EI_CLASS]) {
+	case ELFCLASS32:
+		dinfo->mach = mach32;
+		break;
+	case ELFCLASS64:
+		dinfo->mach = mach64;
+		break;
+	default:
+		return -1;
+	}
+
+	dinfo->disassembler_options = options;
+
+	return 0;
+}
+
 struct disas_context *disas_context_create(struct objtool_file *file)
 {
 	struct disas_context *dctx;
+	struct disassemble_info *dinfo;
+	int err;
 
 	dctx = malloc(sizeof(*dctx));
 	if (!dctx) {
@@ -24,8 +62,49 @@ struct disas_context *disas_context_create(struct objtool_file *file)
 	}
 
 	dctx->file = file;
+	dinfo = &dctx->info;
+
+	init_disassemble_info_compat(dinfo, stdout,
+				     (fprintf_ftype)fprintf,
+				     fprintf_styled);
+
+	dinfo->read_memory_func = buffer_read_memory;
+	dinfo->application_data = dctx;
+
+	/*
+	 * bfd_openr() is not used to avoid doing ELF data processing
+	 * and caching that has already being done. Here, we just need
+	 * to identify the target file so we call an arch specific
+	 * function to fill some disassemble info (arch, mach).
+	 */
+
+	dinfo->arch = bfd_arch_unknown;
+	dinfo->mach = 0;
+
+	err = arch_disas_info_init(dinfo);
+	if (err || dinfo->arch == bfd_arch_unknown || dinfo->mach == 0) {
+		WARN("failed to init disassembly arch");
+		goto error;
+	}
+
+	dinfo->endian = (file->elf->ehdr.e_ident[EI_DATA] == ELFDATA2MSB) ?
+		BFD_ENDIAN_BIG : BFD_ENDIAN_LITTLE;
+
+	disassemble_init_for_target(dinfo);
+
+	dctx->disassembler = disassembler(dinfo->arch,
+					  dinfo->endian == BFD_ENDIAN_BIG,
+					  dinfo->mach, NULL);
+	if (!dctx->disassembler) {
+		WARN("failed to create disassembler function");
+		goto error;
+	}
 
 	return dctx;
+
+error:
+	free(dctx);
+	return NULL;
 }
 
 void disas_context_destroy(struct disas_context *dctx)
@@ -33,86 +112,62 @@ void disas_context_destroy(struct disas_context *dctx)
 	free(dctx);
 }
 
-/* 'funcs' is a space-separated list of function names */
-static void disas_funcs(const char *funcs)
+/*
+ * Disassemble a single instruction. Return the size of the instruction.
+ */
+static size_t disas_insn(struct disas_context *dctx,
+			 struct instruction *insn)
 {
-	const char *objdump_str, *cross_compile;
-	int size, ret;
-	char *cmd;
-
-	cross_compile = getenv("CROSS_COMPILE");
-	if (!cross_compile)
-		cross_compile = "";
-
-	objdump_str = "%sobjdump -wdr %s | gawk -M -v _funcs='%s' '"
-			"BEGIN { split(_funcs, funcs); }"
-			"/^$/ { func_match = 0; }"
-			"/<.*>:/ { "
-				"f = gensub(/.*<(.*)>:/, \"\\\\1\", 1);"
-				"for (i in funcs) {"
-					"if (funcs[i] == f) {"
-						"func_match = 1;"
-						"base = strtonum(\"0x\" $1);"
-						"break;"
-					"}"
-				"}"
-			"}"
-			"{"
-				"if (func_match) {"
-					"addr = strtonum(\"0x\" $1);"
-					"printf(\"%%04x \", addr - base);"
-					"print;"
-				"}"
-			"}' 1>&2";
-
-	/* fake snprintf() to calculate the size */
-	size = snprintf(NULL, 0, objdump_str, cross_compile, objname, funcs) + 1;
-	if (size <= 0) {
-		WARN("objdump string size calculation failed");
-		return;
+	disassembler_ftype disasm = dctx->disassembler;
+	struct disassemble_info *dinfo = &dctx->info;
+
+	if (insn->type == INSN_NOP) {
+		DINFO_FPRINTF(dinfo, "NOP%d", insn->len);
+		return insn->len;
 	}
 
-	cmd = malloc(size);
+	/*
+	 * Set the disassembler buffer to read data from the section
+	 * containing the instruction to disassemble.
+	 */
+	dinfo->buffer = insn->sec->data->d_buf;
+	dinfo->buffer_vma = 0;
+	dinfo->buffer_length = insn->sec->sh.sh_size;
 
-	/* real snprintf() */
-	snprintf(cmd, size, objdump_str, cross_compile, objname, funcs);
-	ret = system(cmd);
-	if (ret) {
-		WARN("disassembly failed: %d", ret);
-		return;
+	return disasm(insn->offset, &dctx->info);
+}
+
+/*
+ * Disassemble a function.
+ */
+static void disas_func(struct disas_context *dctx, struct symbol *func)
+{
+	struct instruction *insn;
+	size_t addr;
+
+	printf("%s:\n", func->name);
+	sym_for_each_insn(dctx->file, func, insn) {
+		addr = insn->offset;
+		printf(" %6lx:  %s+0x%-6lx      ",
+		       addr, func->name, addr - func->offset);
+		disas_insn(dctx, insn);
+		printf("\n");
 	}
+	printf("\n");
 }
 
+/*
+ * Disassemble all warned functions.
+ */
 void disas_warned_funcs(struct disas_context *dctx)
 {
 	struct symbol *sym;
-	char *funcs = NULL, *tmp;
 
 	if (!dctx)
 		return;
 
 	for_each_sym(dctx->file, sym) {
-		if (sym->warned) {
-			if (!funcs) {
-				funcs = malloc(strlen(sym->name) + 1);
-				if (!funcs) {
-					ERROR_GLIBC("malloc");
-					return;
-				}
-				strcpy(funcs, sym->name);
-			} else {
-				tmp = malloc(strlen(funcs) + strlen(sym->name) + 2);
-				if (!tmp) {
-					ERROR_GLIBC("malloc");
-					return;
-				}
-				sprintf(tmp, "%s %s", funcs, sym->name);
-				free(funcs);
-				funcs = tmp;
-			}
-		}
+		if (sym->warned)
+			disas_func(dctx, sym);
 	}
-
-	if (funcs)
-		disas_funcs(funcs);
 }
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index be33c7b43180a..02e6e385f174b 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -102,4 +102,13 @@ bool arch_absolute_reloc(struct elf *elf, struct reloc *reloc);
 unsigned int arch_reloc_size(struct reloc *reloc);
 unsigned long arch_jump_table_sym_offset(struct reloc *reloc, struct reloc *table);
 
+#ifdef DISAS
+
+#include <bfd.h>
+#include <dis-asm.h>
+
+int arch_disas_info_init(struct disassemble_info *dinfo);
+
+#endif /* DISAS */
+
 #endif /* _ARCH_H */
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index 00fb745e72339..5290ac1ebbc1f 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -125,4 +125,9 @@ struct instruction *next_insn_same_sec(struct objtool_file *file, struct instruc
 	     insn && insn->sec == _sec;					\
 	     insn = next_insn_same_sec(file, insn))
 
+#define sym_for_each_insn(file, sym, insn)				\
+	for (insn = find_insn(file, sym->sec, sym->offset);		\
+	     insn && insn->offset < sym->offset + sym->len;		\
+	     insn = next_insn_same_sec(file, insn))
+
 #endif /* _CHECK_H */
diff --git a/tools/objtool/include/objtool/disas.h b/tools/objtool/include/objtool/disas.h
index 5c543b69fc612..3ec3ce2e4e6f0 100644
--- a/tools/objtool/include/objtool/disas.h
+++ b/tools/objtool/include/objtool/disas.h
@@ -7,8 +7,37 @@
 #define _DISAS_H
 
 struct disas_context;
+struct disassemble_info;
+
+#ifdef DISAS
+
 struct disas_context *disas_context_create(struct objtool_file *file);
 void disas_context_destroy(struct disas_context *dctx);
 void disas_warned_funcs(struct disas_context *dctx);
+int disas_info_init(struct disassemble_info *dinfo,
+		    int arch, int mach32, int mach64,
+		    const char *options);
+
+#else /* DISAS */
+
+#include <objtool/warn.h>
+
+static inline struct disas_context *disas_context_create(struct objtool_file *file)
+{
+	WARN("Rebuild with libopcodes for disassembly support");
+	return NULL;
+}
+
+static inline void disas_context_destroy(struct disas_context *dctx) {}
+static inline void disas_warned_funcs(struct disas_context *dctx) {}
+
+static inline int disas_info_init(struct disassemble_info *dinfo,
+				  int arch, int mach32, int mach64,
+				  const char *options)
+{
+	return -1;
+}
+
+#endif /* DISAS */
 
 #endif /* _DISAS_H */
-- 
2.43.5


