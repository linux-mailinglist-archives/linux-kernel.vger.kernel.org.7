Return-Path: <linux-kernel+bounces-580534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA44A75336
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 00:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341671894EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 23:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA7C1F8908;
	Fri, 28 Mar 2025 23:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HyWgl7ay"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898AB1F560D;
	Fri, 28 Mar 2025 23:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743203691; cv=none; b=sklMW6hbGgNHQjZZEHhn4a/CC8X20r0uqCsYN6H88PrBsNaD528/bQ06F+hWdVK+GA7WyZZcQZDW5o0QCRuhVbVP7a1+p12kA6qztujtEWYQzYQhQ8ikAbVRPm58OUnX3soYcKPPx9KRm10j6GUn4aebtF6CkRTNmU0KnIvwW04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743203691; c=relaxed/simple;
	bh=ApDLH/tyh1hSrlD1DYvA4Lzr2DUUM6DpYu4K3hgs2d8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qGP+/lM1ADu7VZnXw5t/z8AwcHw7npa4sD+eGC33ev96h4gRutqRi0dNzc4m3ruwTBgEl8hFJWnhsFjMzbkID0y3j7xG3T8iIISKi4vjZ3PPHtQ1OoU8zzPpVWi4+MIBNmgHZG7ZZbLcGhDyRZxP18k0C3wOh6jSvFURwB8dNEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HyWgl7ay; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52SKWF39015319;
	Fri, 28 Mar 2025 23:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=WJjVa
	fYIZlHHJRPlm3ITpxTluw6zdrQNa6/Xlw5cCjg=; b=HyWgl7ayK371sZgZ4KyWs
	JklHEXO01S87FuTeIcuunWh5F2Zmkf+4tr5xBzvIIDTlww99SZRFaZcWXWgLgz7F
	dg7gSVS7leFWQIYV+ww4E8M2eZsh6udbkFtsvWYGS/9s8cwoiD3AdBVYgsf9vT3C
	dSMfvFQ5IJTjJuMD4+VHwLR5IFnIAj2lsT6C6ffK0Q96oGSjqXLA+Zc5Hv1bMEpu
	zW8tcuUkY0KSpJS+1uSrxTjHHjpZcLyCrDviO9tDvNfB6ELWAzph+mOGt92ooiK0
	q4hKYe0CtgUZgM44z7FYLLIUkSQUaKVL0WO+icK5Uskw6Z5+ncalGvUF7xTEaRGi
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn877n7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 23:14:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52SLA9js022860;
	Fri, 28 Mar 2025 23:14:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jjcjnnyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 28 Mar 2025 23:14:18 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52SNEHP9007198;
	Fri, 28 Mar 2025 23:14:17 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jjcjnnx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 28 Mar 2025 23:14:17 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux.dev
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v13 18/19] x86: Secure Launch late initcall platform module
Date: Fri, 28 Mar 2025 16:08:13 -0700
Message-Id: <20250328230814.2210230-19-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250328230814.2210230-1-ross.philipson@oracle.com>
References: <20250328230814.2210230-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_11,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503280156
X-Proofpoint-GUID: PGNgMQ3AyeV75K7OhjwVymoTqrfaOaWw
X-Proofpoint-ORIG-GUID: PGNgMQ3AyeV75K7OhjwVymoTqrfaOaWw

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

The Secure Launch platform module is a late init module. During the
init call, the TPM event log is read and measurements taken in the
early boot stub code are located. These measurements are extended
into the TPM PCRs using the mainline TPM kernel driver.

The platform module also registers the securityfs nodes to allow
access to TXT register fields on Intel along with the fetching of
and writing events to the late launch TPM log.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: garnetgrimm <grimmg@ainfosec.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/Makefile   |   1 +
 arch/x86/kernel/slmodule.c | 508 +++++++++++++++++++++++++++++++++++++
 2 files changed, 509 insertions(+)
 create mode 100644 arch/x86/kernel/slmodule.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index a7ca7ca16174..bed87b1c49a2 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_IA32_EMULATION)	+= tls.o
 obj-y				+= step.o
 obj-$(CONFIG_INTEL_TXT)		+= tboot.o
 obj-$(CONFIG_SECURE_LAUNCH)	+= slaunch.o
+obj-$(CONFIG_SECURE_LAUNCH)	+= slmodule.o
 obj-$(CONFIG_ISA_DMA_API)	+= i8237.o
 obj-y				+= stacktrace.o
 obj-y				+= cpu/
diff --git a/arch/x86/kernel/slmodule.c b/arch/x86/kernel/slmodule.c
new file mode 100644
index 000000000000..64010bac038c
--- /dev/null
+++ b/arch/x86/kernel/slmodule.c
@@ -0,0 +1,508 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Secure Launch late validation/setup, securityfs exposure and finalization.
+ *
+ * Copyright (c) 2025 Apertus Solutions, LLC
+ * Copyright (c) 2025 Assured Information Security, Inc.
+ * Copyright (c) 2025, Oracle and/or its affiliates.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/uaccess.h>
+#include <linux/security.h>
+#include <linux/memblock.h>
+#include <linux/tpm.h>
+#include <asm/segment.h>
+#include <asm/sections.h>
+#include <crypto/sha2.h>
+#include <linux/slr_table.h>
+#include <linux/slaunch.h>
+
+/*
+ * The macro DECLARE_TXT_PUB_READ_U is used to read values from the TXT
+ * public registers as unsigned values.
+ */
+#define DECLARE_TXT_PUB_READ_U(size, fmt, msg_size)			\
+static ssize_t txt_pub_read_u##size(unsigned int offset,		\
+		loff_t *read_offset,					\
+		size_t read_len,					\
+		char __user *buf)					\
+{									\
+	char msg_buffer[msg_size];					\
+	u##size reg_value = 0;						\
+	void __iomem *txt;						\
+									\
+	txt = ioremap(TXT_PUB_CONFIG_REGS_BASE,				\
+			TXT_NR_CONFIG_PAGES * PAGE_SIZE);		\
+	if (!txt)							\
+		return -EFAULT;						\
+	memcpy_fromio(&reg_value, txt + offset, sizeof(u##size));	\
+	iounmap(txt);							\
+	snprintf(msg_buffer, msg_size, fmt, reg_value);			\
+	return simple_read_from_buffer(buf, read_len, read_offset,	\
+			&msg_buffer, msg_size);				\
+}
+
+DECLARE_TXT_PUB_READ_U(8, "%#04x\n", 6);
+DECLARE_TXT_PUB_READ_U(32, "%#010x\n", 12);
+DECLARE_TXT_PUB_READ_U(64, "%#018llx\n", 20);
+
+#define DECLARE_TXT_FOPS(reg_name, reg_offset, reg_size)		\
+static ssize_t txt_##reg_name##_read(struct file *flip,			\
+		char __user *buf, size_t read_len, loff_t *read_offset)	\
+{									\
+	return txt_pub_read_u##reg_size(reg_offset, read_offset,	\
+			read_len, buf);					\
+}									\
+static const struct file_operations reg_name##_ops = {			\
+	.read = txt_##reg_name##_read,					\
+}
+
+DECLARE_TXT_FOPS(sts, TXT_CR_STS, 64);
+DECLARE_TXT_FOPS(ests, TXT_CR_ESTS, 8);
+DECLARE_TXT_FOPS(errorcode, TXT_CR_ERRORCODE, 32);
+DECLARE_TXT_FOPS(didvid, TXT_CR_DIDVID, 64);
+DECLARE_TXT_FOPS(e2sts, TXT_CR_E2STS, 64);
+DECLARE_TXT_FOPS(ver_emif, TXT_CR_VER_EMIF, 32);
+DECLARE_TXT_FOPS(scratchpad, TXT_CR_SCRATCHPAD, 64);
+
+/*
+ * Securityfs exposure
+ */
+struct memfile {
+	char *name;
+	void *addr;
+	size_t size;
+};
+
+static struct memfile sl_evtlog = {"eventlog", NULL, 0};
+static void *txt_heap;
+static struct txt_heap_event_log_pointer2_1_element *evtlog21;
+static DEFINE_MUTEX(sl_evt_log_mutex);
+static struct tcg_efi_specid_event_head *efi_head;
+
+static ssize_t sl_evtlog_read(struct file *file, char __user *buf,
+			      size_t count, loff_t *pos)
+{
+	ssize_t size;
+
+	if (!sl_evtlog.addr)
+		return 0;
+
+	mutex_lock(&sl_evt_log_mutex);
+	size = simple_read_from_buffer(buf, count, pos, sl_evtlog.addr,
+				       sl_evtlog.size);
+	mutex_unlock(&sl_evt_log_mutex);
+
+	return size;
+}
+
+static ssize_t sl_evtlog_write(struct file *file, const char __user *buf,
+			       size_t datalen, loff_t *ppos)
+{
+	ssize_t result;
+	char *data;
+
+	if (!sl_evtlog.addr)
+		return 0;
+
+	/* No partial writes. */
+	result = -EINVAL;
+	if (*ppos != 0)
+		goto out;
+
+	data = memdup_user(buf, datalen);
+	if (IS_ERR(data)) {
+		result = PTR_ERR(data);
+		goto out;
+	}
+
+	mutex_lock(&sl_evt_log_mutex);
+	if (evtlog21)
+		result = tpm2_log_event(evtlog21, sl_evtlog.addr,
+					sl_evtlog.size, datalen, data);
+	else
+		result = tpm_log_event(sl_evtlog.addr, sl_evtlog.size,
+				       datalen, data);
+	mutex_unlock(&sl_evt_log_mutex);
+
+	kfree(data);
+out:
+	return result;
+}
+
+static const struct file_operations sl_evtlog_ops = {
+	.read = sl_evtlog_read,
+	.write = sl_evtlog_write,
+	.llseek	= default_llseek,
+};
+
+struct sfs_file {
+	const char *name;
+	const struct file_operations *fops;
+};
+
+#define SL_TXT_ENTRY_COUNT	7
+static const struct sfs_file sl_txt_files[] = {
+	{ "sts", &sts_ops },
+	{ "ests", &ests_ops },
+	{ "errorcode", &errorcode_ops },
+	{ "didvid", &didvid_ops },
+	{ "ver_emif", &ver_emif_ops },
+	{ "scratchpad", &scratchpad_ops },
+	{ "e2sts", &e2sts_ops }
+};
+
+/* sysfs file handles */
+static struct dentry *slaunch_dir;
+static struct dentry *event_file;
+static struct dentry *txt_dir;
+static struct dentry *txt_entries[SL_TXT_ENTRY_COUNT];
+
+static long slaunch_expose_securityfs(void)
+{
+	long ret = 0;
+	int i;
+
+	slaunch_dir = securityfs_create_dir("slaunch", NULL);
+	if (IS_ERR(slaunch_dir))
+		return PTR_ERR(slaunch_dir);
+
+	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
+		txt_dir = securityfs_create_dir("txt", slaunch_dir);
+		if (IS_ERR(txt_dir)) {
+			ret = PTR_ERR(txt_dir);
+			goto remove_slaunch;
+		}
+
+		for (i = 0; i < ARRAY_SIZE(sl_txt_files); i++) {
+			txt_entries[i] = securityfs_create_file(
+						sl_txt_files[i].name, 0440,
+						txt_dir, NULL,
+						sl_txt_files[i].fops);
+			if (IS_ERR(txt_entries[i])) {
+				ret = PTR_ERR(txt_entries[i]);
+				goto remove_files;
+			}
+		}
+	}
+
+	if (sl_evtlog.addr) {
+		event_file = securityfs_create_file(sl_evtlog.name, 0440,
+						    slaunch_dir, NULL,
+						    &sl_evtlog_ops);
+		if (IS_ERR(event_file)) {
+			ret = PTR_ERR(event_file);
+			goto remove_files;
+		}
+	}
+
+	return 0;
+
+remove_files:
+	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
+		while (--i >= 0)
+			securityfs_remove(txt_entries[i]);
+		securityfs_remove(txt_dir);
+	}
+
+remove_slaunch:
+	securityfs_remove(slaunch_dir);
+
+	return ret;
+}
+
+static void slaunch_teardown_securityfs(void)
+{
+	int i;
+
+	securityfs_remove(event_file);
+	if (sl_evtlog.addr) {
+		memunmap(sl_evtlog.addr);
+		sl_evtlog.addr = NULL;
+	}
+	sl_evtlog.size = 0;
+
+	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
+		for (i = 0; i < ARRAY_SIZE(sl_txt_files); i++)
+			securityfs_remove(txt_entries[i]);
+
+		securityfs_remove(txt_dir);
+
+		if (txt_heap) {
+			memunmap(txt_heap);
+			txt_heap = NULL;
+		}
+	}
+
+	securityfs_remove(slaunch_dir);
+}
+
+static void slaunch_intel_evtlog(void __iomem *txt)
+{
+	struct slr_entry_log_info *log_info;
+	struct txt_os_mle_data *params;
+	struct slr_table *slrt;
+	void *os_sinit_data;
+	u64 base, size;
+
+	memcpy_fromio(&base, txt + TXT_CR_HEAP_BASE, sizeof(base));
+	memcpy_fromio(&size, txt + TXT_CR_HEAP_SIZE, sizeof(size));
+
+	/* now map TXT heap */
+	txt_heap = memremap(base, size, MEMREMAP_WB);
+	if (!txt_heap)
+		slaunch_txt_reset(txt, "Error failed to memremap TXT heap\n",
+				  SL_ERROR_HEAP_MAP);
+
+	params = (struct txt_os_mle_data *)txt_os_mle_data_start(txt_heap);
+
+	/* Get the SLRT and remap it */
+	slrt = memremap(params->slrt, sizeof(*slrt), MEMREMAP_WB);
+	if (!slrt)
+		slaunch_txt_reset(txt, "Error failed to memremap SLR Table\n",
+				  SL_ERROR_SLRT_MAP);
+	size = slrt->size;
+	memunmap(slrt);
+
+	slrt = memremap(params->slrt, size, MEMREMAP_WB);
+	if (!slrt)
+		slaunch_txt_reset(txt, "Error failed to memremap SLR Table\n",
+				  SL_ERROR_SLRT_MAP);
+
+	log_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_LOG_INFO);
+	if (!log_info)
+		slaunch_txt_reset(txt, "Error failed to memremap SLR Table\n",
+				  SL_ERROR_SLRT_MISSING_ENTRY);
+
+	sl_evtlog.size = log_info->size;
+	sl_evtlog.addr = memremap(log_info->addr, log_info->size,
+				  MEMREMAP_WB);
+	if (!sl_evtlog.addr)
+		slaunch_txt_reset(txt, "Error failed to memremap TPM event log\n",
+				  SL_ERROR_EVENTLOG_MAP);
+
+	memunmap(slrt);
+
+	/* Determine if this is TPM 1.2 or 2.0 event log */
+	if (memcmp(sl_evtlog.addr + sizeof(struct tcg_pcr_event),
+		    TCG_SPECID_SIG, sizeof(TCG_SPECID_SIG)))
+		return; /* looks like it is not 2.0 */
+
+	/* For TPM 2.0 logs, the extended heap element must be located */
+	os_sinit_data = txt_os_sinit_data_start(txt_heap);
+
+	evtlog21 = tpm2_find_log2_1_element(os_sinit_data);
+
+	/*
+	 * If this fails, things are in really bad shape. Any attempt to write
+	 * events to the log will fail.
+	 */
+	if (!evtlog21)
+		slaunch_txt_reset(txt, "Error failed to find TPM20 event log element\n",
+				  SL_ERROR_TPM_INVALID_LOG20);
+
+	/* Save pointer to the EFI SpecID log header */
+	efi_head = (struct tcg_efi_specid_event_head *)(sl_evtlog.addr + sizeof(struct tcg_pcr_event));
+}
+
+static void slaunch_tpm2_extend_event(struct tpm_chip *tpm, void __iomem *txt,
+				      struct tcg_pcr_event2_head *event)
+{
+	u16 *alg_id_field = (u16 *)((u8 *)event + sizeof(*event));
+	struct tpm_digest *digests;
+	u8 *dptr;
+	int ret;
+	u32 i;
+
+	/*
+	 * Early SL code ensured the TPM algorithm information passed via
+	 * the log is valid. Small sanity check here.
+	 */
+	if (event->count != efi_head->num_algs)
+		slaunch_txt_reset(txt, "Event digest count mismatch with event log\n",
+				  SL_ERROR_TPM_EVENT_COUNT);
+
+	digests = kzalloc(efi_head->num_algs * sizeof(*digests), GFP_KERNEL);
+	if (!digests)
+		slaunch_txt_reset(txt, "Failed to allocate array of digests\n",
+				  SL_ERROR_GENERIC);
+
+	for (i = 0; i < event->count; i++) {
+		dptr = (u8 *)alg_id_field + sizeof(u16);
+
+		/* Setup each digest for the extend */
+		digests[i].alg_id = efi_head->digest_sizes[i].alg_id;
+		memcpy(&digests[i].digest[0], dptr,
+			efi_head->digest_sizes[i].digest_size);
+
+		alg_id_field = (u16 *)((u8 *)alg_id_field + sizeof(u16) +
+				efi_head->digest_sizes[i].digest_size);
+	}
+
+	ret = tpm_pcr_extend(tpm, event->pcr_idx, digests);
+	if (ret) {
+		pr_err("Error extending TPM20 PCR, result: %d\n", ret);
+		slaunch_txt_reset(txt, "Failed to extend TPM20 PCR\n",
+				  SL_ERROR_TPM_EXTEND);
+	}
+
+	kfree(digests);
+}
+
+static void slaunch_tpm2_extend(struct tpm_chip *tpm, void __iomem *txt)
+{
+	struct tcg_pcr_event *event_header;
+	struct tcg_pcr_event2_head *event;
+	int start = 0, end = 0, size;
+
+	event_header = (struct tcg_pcr_event *)(sl_evtlog.addr +
+						evtlog21->first_record_offset);
+
+	/* Skip first TPM 1.2 event to get to first TPM 2.0 event */
+	event = (struct tcg_pcr_event2_head *)((u8 *)event_header + sizeof(*event_header) +
+					       event_header->event_size);
+
+	while ((void  *)event < sl_evtlog.addr + evtlog21->next_record_offset) {
+		size = __calc_tpm2_event_size(event, event_header, false);
+		if (!size)
+			slaunch_txt_reset(txt, "TPM20 invalid event in event log\n",
+					  SL_ERROR_TPM_INVALID_EVENT);
+
+		/*
+		 * Marker events indicate where the Secure Launch early stub
+		 * started and ended adding post launch events. As they are
+		 * encountered, switch the event type to NO_ACTION so they
+		 * ignored in when the event log is processed since they are
+		 * not really measurements.
+		 */
+		if (event->event_type == TXT_EVTYPE_SLAUNCH_END) {
+			event->event_type = NO_ACTION;
+			end = 1;
+			break;
+		} else if (event->event_type == TXT_EVTYPE_SLAUNCH_START) {
+			event->event_type = NO_ACTION;
+			start = 1;
+			goto next;
+		}
+
+		if (start)
+			slaunch_tpm2_extend_event(tpm, txt, event);
+
+next:
+		event = (struct tcg_pcr_event2_head *)((u8 *)event + size);
+	}
+
+	if (!start || !end)
+		slaunch_txt_reset(txt, "Missing start or end events for extending TPM20 PCRs\n",
+				  SL_ERROR_TPM_EXTEND);
+}
+
+static void slaunch_tpm_extend(struct tpm_chip *tpm, void __iomem *txt)
+{
+	struct tpm_event_log_header *event_header;
+	struct tcg_pcr_event *event;
+	struct tpm_digest digest;
+	int start = 0, end = 0;
+	int size, ret;
+
+	event_header = (struct tpm_event_log_header *)sl_evtlog.addr;
+	event = (struct tcg_pcr_event *)((u8 *)event_header +
+				sizeof(*event_header));
+
+	while ((void  *)event < sl_evtlog.addr + event_header->next_event_offset) {
+		size = sizeof(*event) + event->event_size;
+
+		/*
+		 * See comments in slaunch_tpm2_extend() concerning these special
+		 * event types.
+		 */
+		if (event->event_type == TXT_EVTYPE_SLAUNCH_END) {
+			event->event_type = NO_ACTION;
+			end = 1;
+			break;
+		} else if (event->event_type == TXT_EVTYPE_SLAUNCH_START) {
+			event->event_type = NO_ACTION;
+			start = 1;
+			goto next;
+		}
+
+		if (start) {
+			memset(&digest.digest[0], 0, TPM_MAX_DIGEST_SIZE);
+			digest.alg_id = TPM_ALG_SHA1;
+			memcpy(&digest.digest[0], &event->digest[0],
+			       SHA1_DIGEST_SIZE);
+
+			ret = tpm_pcr_extend(tpm, event->pcr_idx, &digest);
+			if (ret) {
+				pr_err("Error extending TPM12 PCR, result: %d\n", ret);
+				slaunch_txt_reset(txt, "Failed to extend TPM12 PCR\n",
+						  SL_ERROR_TPM_EXTEND);
+			}
+		}
+
+next:
+		event = (struct tcg_pcr_event *)((u8 *)event + size);
+	}
+
+	if (!start || !end)
+		slaunch_txt_reset(txt, "Missing start or end events for extending TPM12 PCRs\n",
+				  SL_ERROR_TPM_EXTEND);
+}
+
+static void slaunch_pcr_extend(void __iomem *txt)
+{
+	struct tpm_chip *tpm;
+	int rc;
+
+	tpm = tpm_default_chip();
+	if (!tpm)
+		slaunch_txt_reset(txt, "Could not get default TPM chip\n",
+				  SL_ERROR_TPM_INIT);
+
+	rc = tpm_chip_set_locality(tpm, 2);
+	if (rc)
+		slaunch_txt_reset(txt, "Could not set TPM chip locality 2\n",
+				  SL_ERROR_TPM_INIT);
+
+	if (evtlog21)
+		slaunch_tpm2_extend(tpm, txt);
+	else
+		slaunch_tpm_extend(tpm, txt);
+}
+
+static int __init slaunch_module_init(void)
+{
+	void __iomem *txt;
+
+	/* Check to see if Secure Launch happened */
+	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) !=
+	    (SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT))
+		return 0;
+
+	txt = ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
+		      PAGE_SIZE);
+	if (!txt)
+		panic("Error ioremap of TXT priv registers\n");
+
+	/* Only Intel TXT is supported at this point */
+	slaunch_intel_evtlog(txt);
+	slaunch_pcr_extend(txt);
+	iounmap(txt);
+
+	return slaunch_expose_securityfs();
+}
+
+static void __exit slaunch_module_exit(void)
+{
+	slaunch_teardown_securityfs();
+}
+
+late_initcall(slaunch_module_init);
+__exitcall(slaunch_module_exit);
-- 
2.39.3


