Return-Path: <linux-kernel+bounces-897696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA6BC53AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6E9C548BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA9C34DB61;
	Wed, 12 Nov 2025 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HH1xibLm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A7F34D916
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963483; cv=none; b=kE93NVjcYAe+14On1FiZNVYtk5Lx9jGpPhZwDmj0jln+vUcYdYvkeB1AMCqPQH2PB/4aZelNmGLMpZD7tieOx1Ggru5N2+8pXKuRv2+S2iyJWifXZ2fLTy/OdkYmoMqHiCkX1/5pn3gau3hWVmmPYkWvqbX2Na/a5L+5065K/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963483; c=relaxed/simple;
	bh=gyZRXrZXtHHwJud4E/H8c2wggv1DSZKUECRh1zwD+jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUTnl3SaKsS0kD/hq/7h/63SLVIP3F3u989falaS5Ypn02JUZIqh/2oO1FRR5T5+xPWeVdUHPxLgaLIK8+9kiM8g1ajlJkGq57Z1pc6aP8/lljeURsXJff/LkWUzUo9Gy2j1SJ54TBhYl47+7/FwEpTyI10wV7QArbPTqZ1Z49c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HH1xibLm; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACG0XmO008500;
	Wed, 12 Nov 2025 16:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=pUhSs
	bCJ+uF3BC+fsRZXzhHiFeXxezmq6B60CYKgKlA=; b=HH1xibLmUio3rTE3iMYrN
	4ghyww8Fvi4HCSWOvxWftDvf+v9/ycq4TUKoAiPWpNrIh95ACqIRxKIcwddHi5Ko
	3yQP3MUuwO1xqWbhPSfoWtA4lZS4JEspE+jPNGz1r6Qfu/GoCJ9/OyItxdZDWsWN
	h+nJkAdSuPG1fsqz8MgOZKk9sOWrUQzrz5d/X3vWF0XFtBBmPPWYSIHpSa6s90Kk
	5FvwJVMFQuGjAkKtsHLoeZVtWEqUeNYSAMYZOM03fjWJeU/HvxQTfXVU0cx0mxfM
	KqwsXPxFx3kmqJLMzXrvr7o564mVLP+faCdEDuIHqboyJ+NHJdV2Tj7TAkz1cpAM
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acwcg80k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG4oE018707;
	Wed, 12 Nov 2025 16:04:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavqs0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:34 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw48004655;
	Wed, 12 Nov 2025 16:04:34 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-27;
	Wed, 12 Nov 2025 16:04:33 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 26/28] objtool: Get the destination name of a PV call
Date: Wed, 12 Nov 2025 17:03:13 +0100
Message-ID: <20251112160315.2207947-27-alexandre.chartre@oracle.com>
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
X-Proofpoint-GUID: 9rGdJiFWLJ3mP6mscOHvYyoJ5KJ4kxDh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyOSBTYWx0ZWRfX6+LfQH8IyK9l
 QFWdvtYCNv8v7whbS1B/6+POjcUFF4m12ufDHiwGE8RY7uuSKxYhjItmV11C+kgcdlZG477O9GT
 Otr5w3szXdLrJq2ha5xhGqpCCxefokfil5Hr8r9tSDV6KE/j8OWLfJtOuj0CT9u80MvB/FKf0hI
 4rC48Z9kG5H8Qzu6LxE0F6at/7aZ+I1/f0279vcYXa+qjXK0XmnkItBgOmGc1nyFmJfFW1CMLEi
 Mj8XAqkMaC7IP/RP0U8XVNgRUHm7SbdObEcV0v8ccie0UieUc6zQvqIkp96mg0Bjv3nCZhT7fo/
 m8lOPOtx+fScChGitV2J/qTxwRmPaQLFAEWQRvbdaV2CzT6B/oIJ1f5IC2Rnbu8YN+9OPvrHRWe
 I60N5wFGqQGMHOtR70bA6jUmgMp9CA==
X-Proofpoint-ORIG-GUID: 9rGdJiFWLJ3mP6mscOHvYyoJ5KJ4kxDh
X-Authority-Analysis: v=2.4 cv=LewxKzfi c=1 sm=1 tr=0 ts=6914b013 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=JgagiIEfrknqXQomSD8A:9

Add a function to get the destination name of a PV call. The destination
depends on the content of the pv_ops[] array which can dynamically change
at runtime.

However there are cases where we can speculate on the content of pv_ops[]
and provide the function name corresponding to the call. For example,
when an alternative depends on the X86_FEATURE_XENPV feature then we know
that the corresponding code will be using the Xen pv_ops[] values.

If we can't figure out the exact content of pv_ops[] then provide the
function name from the default pv_ops[] array.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/arch/x86/decode.c         |  2 +-
 tools/objtool/check.c                   | 99 ++++++++++++++++++++++---
 tools/objtool/include/objtool/check.h   |  4 +
 tools/objtool/include/objtool/elf.h     |  7 ++
 tools/objtool/include/objtool/objtool.h |  6 +-
 tools/objtool/objtool.c                 | 27 ++++++-
 6 files changed, 129 insertions(+), 16 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index d651d8921ab47..9fef0d94517ca 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -685,7 +685,7 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 				return -1;
 			}
 
-			objtool_pv_add(file, idx, func);
+			objtool_pv_add(file, idx, func, PV_MODE_DEFAULT);
 		}
 
 		break;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1aad636a8d630..7978b3feb0cb2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -538,7 +538,8 @@ static int decode_instructions(struct objtool_file *file)
 /*
  * Read the pv_ops[] .data table to find the static initialized values.
  */
-static int add_pv_ops(struct objtool_file *file, const char *symname)
+static int add_pv_ops(struct objtool_file *file, const char *symname,
+		      enum pv_mode pv_mode)
 {
 	struct symbol *sym, *func;
 	unsigned long off, end;
@@ -568,7 +569,7 @@ static int add_pv_ops(struct objtool_file *file, const char *symname)
 			return -1;
 		}
 
-		if (objtool_pv_add(file, idx, func))
+		if (objtool_pv_add(file, idx, func, pv_mode))
 			return -1;
 
 		off = reloc_offset(reloc) + 1;
@@ -584,24 +585,27 @@ static int add_pv_ops(struct objtool_file *file, const char *symname)
  */
 static int init_pv_ops(struct objtool_file *file)
 {
-	static const char *pv_ops_tables[] = {
-		"pv_ops",
-		"xen_cpu_ops",
-		"xen_irq_ops",
-		"xen_mmu_ops",
-		NULL,
+	static struct {
+		const char *name;
+		enum pv_mode mode;
+	} pv_ops_tables[] = {
+		{ "pv_ops",		PV_MODE_DEFAULT },
+		{ "xen_cpu_ops",	PV_MODE_XENPV },
+		{ "xen_irq_ops",	PV_MODE_XENPV },
+		{ "xen_mmu_ops",	PV_MODE_XENPV },
+		{ NULL },
 	};
 	const char *pv_ops;
 	struct symbol *sym;
 	int idx, nr, ret;
 
-	if (!opts.noinstr)
+	if (!opts.noinstr && !opts.disas)
 		return 0;
 
 	file->pv_ops = NULL;
 
 	sym = find_symbol_by_name(file->elf, "pv_ops");
-	if (!sym)
+	if (!sym || !sym->len)
 		return 0;
 
 	nr = sym->len / sizeof(unsigned long);
@@ -614,8 +618,8 @@ static int init_pv_ops(struct objtool_file *file)
 	for (idx = 0; idx < nr; idx++)
 		INIT_LIST_HEAD(&file->pv_ops[idx].targets);
 
-	for (idx = 0; (pv_ops = pv_ops_tables[idx]); idx++) {
-		ret = add_pv_ops(file, pv_ops);
+	for (idx = 0; (pv_ops = pv_ops_tables[idx].name); idx++) {
+		ret = add_pv_ops(file, pv_ops, pv_ops_tables[idx].mode);
 		if (ret)
 			return ret;
 	}
@@ -3379,6 +3383,77 @@ static bool pv_call_dest(struct objtool_file *file, struct instruction *insn)
 	return file->pv_ops[idx].clean;
 }
 
+/*
+ * Return the name of the destination of a PV call.
+ *
+ * The destination depends on the specified pv_mode. If an exact
+ * destination cannot be found then the name shows the position of
+ * the destination in the pv_ops[] array, and it is followed by
+ * the operation name for the default PV mode. For example:
+ * "pv_ops[61] ~ native_set_pte"
+ *
+ * The destination name can be followed by a '*' character if there
+ * is code that can override the pv_ops[] entry.
+ *
+ * The function returns NULL if there is no call and the operation
+ * is a NOP.
+ */
+const char *pv_call_dest_name(struct objtool_file *file,
+			      struct instruction *insn,
+			      enum pv_mode pv_mode)
+{
+	struct symbol *target_default = NULL;
+	struct symbol *target = NULL;
+	static char pvname[64];
+	const char *note = "";
+	struct reloc *reloc;
+	int idx;
+
+	reloc = insn_reloc(file, insn);
+	if (!reloc || strcmp(reloc->sym->name, "pv_ops"))
+		return NULL;
+
+	idx = (arch_dest_reloc_offset(reloc_addend(reloc)) / sizeof(void *));
+
+	if (file->pv_ops) {
+
+		target_default = file->pv_ops[idx].target_default;
+
+		switch (pv_mode) {
+
+		case PV_MODE_DEFAULT:
+			target = target_default;
+			break;
+
+		case PV_MODE_XENPV:
+			target = file->pv_ops[idx].target_xen;
+			break;
+
+		case PV_MODE_UNKNOWN:
+			break;
+		}
+
+		if (file->pv_ops[idx].target_override > 0)
+			note = " *";
+	}
+
+	if (target) {
+		if (!strcmp(target->name, "nop_func"))
+			return NULL;
+
+		snprintf(pvname, sizeof(pvname), "%s%s", target->name, note);
+
+	} else if (target_default) {
+		snprintf(pvname, sizeof(pvname), "pv_ops[%d] ~ %s%s",
+			 idx, target_default->name, note);
+	} else {
+		snprintf(pvname, sizeof(pvname), "pv_ops[%d]", idx);
+	}
+
+	return pvname;
+}
+
+
 static inline bool noinstr_call_dest(struct objtool_file *file,
 				     struct instruction *insn,
 				     struct symbol *func)
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index c54dd0aae1f60..e352ed64f9edd 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -138,6 +138,10 @@ static inline struct symbol *insn_call_dest(struct instruction *insn)
 	return insn->_call_dest;
 }
 
+const char *pv_call_dest_name(struct objtool_file *file,
+			      struct instruction *insn,
+			      enum pv_mode pv_mode);
+
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset);
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index df8434d3b7440..1d55f5da16932 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -46,6 +46,12 @@ struct section {
 	struct reloc *relocs;
 };
 
+enum pv_mode {
+	PV_MODE_UNKNOWN,
+	PV_MODE_DEFAULT,
+	PV_MODE_XENPV,
+};
+
 struct symbol {
 	struct list_head list;
 	struct rb_node node;
@@ -72,6 +78,7 @@ struct symbol {
 	u8 ignore	     : 1;
 	u8 nocfi             : 1;
 	struct list_head pv_target;
+	enum pv_mode pv_mode;
 	struct reloc *relocs;
 	struct section *group_sec;
 };
diff --git a/tools/objtool/include/objtool/objtool.h b/tools/objtool/include/objtool/objtool.h
index c0dc86a78ff65..cb25bf502f2b2 100644
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -17,6 +17,9 @@
 struct pv_state {
 	bool clean;
 	struct list_head targets;
+	struct symbol *target_default;
+	struct symbol *target_xen;
+	int target_override;
 };
 
 struct objtool_file {
@@ -41,7 +44,8 @@ struct objtool_file {
 
 struct objtool_file *objtool_open_read(const char *_objname);
 
-int objtool_pv_add(struct objtool_file *file, int idx, struct symbol *func);
+int objtool_pv_add(struct objtool_file *file, int idx, struct symbol *func,
+		   enum pv_mode pv_mode);
 
 int check(struct objtool_file *file);
 int orc_dump(const char *objname);
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 5c8b974ad0f9d..95dfef07a530f 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -44,9 +44,10 @@ struct objtool_file *objtool_open_read(const char *filename)
 	return &file;
 }
 
-int objtool_pv_add(struct objtool_file *f, int idx, struct symbol *func)
+int objtool_pv_add(struct objtool_file *f, int idx, struct symbol *func,
+		   enum pv_mode pv_mode)
 {
-	if (!opts.noinstr)
+	if (!opts.noinstr && !opts.disas)
 		return 0;
 
 	if (!f->pv_ops) {
@@ -54,6 +55,28 @@ int objtool_pv_add(struct objtool_file *f, int idx, struct symbol *func)
 		return -1;
 	}
 
+	if (opts.disas) {
+		switch (pv_mode) {
+
+		case PV_MODE_DEFAULT:
+			if (f->pv_ops[idx].target_default)
+				f->pv_ops[idx].target_override++;
+			else
+				f->pv_ops[idx].target_default = func;
+			break;
+
+		case PV_MODE_XENPV:
+			f->pv_ops[idx].target_xen = func;
+			break;
+
+		default:
+			BUG();
+		}
+	}
+
+	if (!opts.noinstr)
+		return 0;
+
 	/*
 	 * These functions will be patched into native code,
 	 * see paravirt_patch().
-- 
2.43.5


