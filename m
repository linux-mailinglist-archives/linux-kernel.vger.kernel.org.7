Return-Path: <linux-kernel+bounces-879616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2726CC23949
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8AD83AA757
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3D2329E47;
	Fri, 31 Oct 2025 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+lRAaPr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694AA17D6
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761896495; cv=none; b=bBO5S/mkjh74mAWjrseCDqdbSizP/V0UJrM7djDNI1yUTGrJN4YvezjNZz5CCO9e7LpD8QLAL5gafijWsWhUyWBfs3wy2Ic8ig89sC4vlDGhMXLPkrWr0dJ9Ntbi9WoU+xmdIn+Us7/cRDjjmhOv3LH9RaUb4yjlJw9lTH0Noiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761896495; c=relaxed/simple;
	bh=1DWKSJF8OEYqjcJrqFR6FrT+o8y4zSzWVVe3d/IbG9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMWHWVStzSqyU/btlIqpMuWcJvP4+6ZxgotBdGPdk/uOElZaItWHX5Xd3HX6WJo/5SdRkzmt6HD2O3zqLhKvZyxlXdxazng4CT0N4nAdFNZ3g+Z8p7pg0GGJ3MBzmE2cWBScuSe6NUcXQldNPNhl7Qasdvoh3nVuzrdD5h+R2uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+lRAaPr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761896492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1U8+0OYOpaOguLvykcf3aLOzyj6wguuzkEUvWSZdG8=;
	b=O+lRAaPrh/jG5S6qSqYbxC8Lf5TtYALWnlaSQU5iK5nrJx+wTgT4DDVxSQpvMpQ2MlR7+R
	D4D9/sJaoFNKf7gvPgv5ordE8701aWtnN1pwPTXCiHlO4SFkwg7tRFAyW1SvmpRmPidYJs
	kFmJ+zNmQ4gosOzcLUIOoyfi/oqKyLI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-s9Y2XShiNeaFJV83Bkq2cA-1; Fri, 31 Oct 2025 03:41:30 -0400
X-MC-Unique: s9Y2XShiNeaFJV83Bkq2cA-1
X-Mimecast-MFC-AGG-ID: s9Y2XShiNeaFJV83Bkq2cA_1761896489
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29520b8e248so7029755ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761896489; x=1762501289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1U8+0OYOpaOguLvykcf3aLOzyj6wguuzkEUvWSZdG8=;
        b=B62WAxv0LnY6Y9ssAx8LFiV9ehYckWQXLxdILIuM8JtsQb1BAob2AhCNh3fLKrfwRk
         pwhP1DHXU2uRX/XdY43uI0JAN6BVC32i9B5hG0So5UOiOZOT4nsRqT6J/1N1ZpNkeZIN
         YVO0KlbYC9JV0sKKS0ijYLl32EauTrcmqVxl1SekPbRW/8KH5sG0VeAK/Welea2nqQIt
         +qmkdl2/St5TeIEsnHuqU7Eoy5vt8PhkkioE6bWpXNLAimrOOk7C3MQDKdyup7M5Woxd
         Tn773f7b6k6hGvvaP4lb8sVIhIgbAwqPWJ5yRpnA4HiBUvOqX30yJDj4XWdTgFQGax4K
         UMOw==
X-Forwarded-Encrypted: i=1; AJvYcCXzNgj9oC3BP+Yd9+sUU2H5XG8I+CfvdWia2msVdm3l3cLU2B7EGXS46ozMFETfodD2zVoJzInlftpo2ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUem5X4+OhzQ+K6woTfckD9QIElO5pCd2waHslz4P6FvLI77x2
	mwOon1cfrSNd07+sOx2OT2hIuFwqVtCJ/xZmGIZXVU7S03iLOHM//e1RiegiYqoJixk7oHYSr/n
	lsGipURbC3a82/knQUCmK1t4abV8nzBbE3lVhXPBYtTL7VxmJAoyxysjxPxJ27FiQ9A==
X-Gm-Gg: ASbGncskCUPiOS5+ZfGNPfw+IaeEvlYFKmjiHkjpBmJCSdSRVMnzWYlvH1bIMmBTz4V
	ZHzQ/i92/gqG82jFUjNWGr7WQHE05eu4gotHfCI7tjd6Zw7MNvmXaR57YRWhf+sjT9oE37vYcEr
	nXk7sZaZ6DAjf8qrdq6Htn57qdfu2gn90UQPbmhH00Uk3DK1Iv2XodhJpGLEB3Nu/RKjoMjHNWV
	s3yktY/9ej6QoQU7JuDoD35j4qf/4P+KtkfnRkuuSHFHDl/8Uc6sOc9CrG5Wl2t3Y+vPBOfzIrt
	XPkKQ8HAJsEYg11VRtmwgOKP93qWP2p2I/vhbaIs3lAXEtL6NBlmRqrBLSkmwmrGIA==
X-Received: by 2002:a17:903:2c7:b0:26c:e270:6dad with SMTP id d9443c01a7336-2951a4fcb51mr32136175ad.60.1761896489182;
        Fri, 31 Oct 2025 00:41:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUvnpn03zGYM9wkLBYIw6ClAfviiBezzYgMRg1RS9G1UI4cgyI/q3aZ1UE8CEnS8k4YLVEmQ==
X-Received: by 2002:a17:903:2c7:b0:26c:e270:6dad with SMTP id d9443c01a7336-2951a4fcb51mr32135925ad.60.1761896488704;
        Fri, 31 Oct 2025 00:41:28 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268b43d7sm13094335ad.35.2025.10.31.00.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 00:41:28 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>
Cc: Karel Srot <ksrot@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-modules@vger.kernel.org (open list:MODULE SUPPORT)
Subject: [PATCH v2] lsm,ima: new LSM hook security_kernel_module_read_file to access decompressed kernel module
Date: Fri, 31 Oct 2025 15:40:15 +0800
Message-ID: <20251031074016.1975356-1-coxu@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250928030358.3873311-1-coxu@redhat.com>
References: <20250928030358.3873311-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when in-kernel module decompression (CONFIG_MODULE_DECOMPRESS)
is enabled, IMA has no way to verify the appended module signature as it
can't decompress the module.

Define a new LSM hook security_kernel_module_read_file which will be
called after kernel module decompression is done so IMA can access the
decompressed kernel module to verify the appended signature.

Since IMA can access both xattr and appended kernel module signature
with the new LSM hook, it no longer uses the security_kernel_post_read_file
LSM hook for kernel module loading.

Before enabling in-kernel module decompression, a kernel module in
initramfs can still be loaded with ima_policy=secure_boot. So adjust the
kernel module rule in secure_boot policy to allow either an IMA
signature OR an appended signature i.e. to use
"appraise func=MODULE_CHECK appraise_type=imasig|modsig".

Reported-by: Karel Srot <ksrot@redhat.com>
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
v1: https://lore.kernel.org/linux-integrity/20250928030358.3873311-1-coxu@redhat.com/

 include/linux/lsm_hook_defs.h       |  2 ++
 include/linux/security.h            |  7 +++++++
 kernel/module/main.c                | 10 +++++++++-
 security/integrity/ima/ima_main.c   | 26 ++++++++++++++++++++++++++
 security/integrity/ima/ima_policy.c |  2 +-
 security/security.c                 | 17 +++++++++++++++++
 6 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 8c42b4bde09c..ced42eb8b618 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -232,6 +232,8 @@ LSM_HOOK(int, 0, kernel_read_file, struct file *file,
 	 enum kernel_read_file_id id, bool contents)
 LSM_HOOK(int, 0, kernel_post_read_file, struct file *file, char *buf,
 	 loff_t size, enum kernel_read_file_id id)
+LSM_HOOK(int, 0, kernel_module_read_file, struct file *file, char *buf,
+	 loff_t size)
 LSM_HOOK(int, 0, task_fix_setuid, struct cred *new, const struct cred *old,
 	 int flags)
 LSM_HOOK(int, 0, task_fix_setgid, struct cred *new, const struct cred * old,
diff --git a/include/linux/security.h b/include/linux/security.h
index 92ac3f27b973..e47951292c73 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -508,6 +508,7 @@ int security_kernel_read_file(struct file *file, enum kernel_read_file_id id,
 			      bool contents);
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id);
+int security_kernel_module_read_file(struct file *file, char *buf, loff_t size);
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags);
 int security_task_fix_setgid(struct cred *new, const struct cred *old,
@@ -1295,6 +1296,12 @@ static inline int security_kernel_post_read_file(struct file *file,
 	return 0;
 }
 
+static inline int security_kernel_module_read_file(struct file *file,
+						   char *buf, loff_t size)
+{
+	return 0;
+}
+
 static inline int security_task_fix_setuid(struct cred *new,
 					   const struct cred *old,
 					   int flags)
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b26184936..40bc86fa7384 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3678,6 +3678,7 @@ static int init_module_from_file(struct file *f, const char __user * uargs, int
 	struct load_info info = { };
 	void *buf = NULL;
 	int len;
+	int err;
 
 	len = kernel_read_file(f, 0, &buf, INT_MAX, NULL, READING_MODULE);
 	if (len < 0) {
@@ -3686,7 +3687,7 @@ static int init_module_from_file(struct file *f, const char __user * uargs, int
 	}
 
 	if (flags & MODULE_INIT_COMPRESSED_FILE) {
-		int err = module_decompress(&info, buf, len);
+		err = module_decompress(&info, buf, len);
 		vfree(buf); /* compressed data is no longer needed */
 		if (err) {
 			mod_stat_inc(&failed_decompress);
@@ -3698,6 +3699,13 @@ static int init_module_from_file(struct file *f, const char __user * uargs, int
 		info.len = len;
 	}
 
+	err = security_kernel_module_read_file(f, (char *)info.hdr, info.len);
+	if (err) {
+		mod_stat_inc(&failed_kreads);
+		free_copy(&info, flags);
+		return err;
+	}
+
 	return load_module(&info, uargs, flags);
 }
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index cdd225f65a62..53d2e90176ea 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -635,6 +635,27 @@ static int ima_file_check(struct file *file, int mask)
 					   MAY_APPEND), FILE_CHECK);
 }
 
+/**
+ * ima_read_kernel_module - collect/appraise/audit measurement
+ * @file: file pointer to the module.
+ * @buf: buffer containing module data (possibly decompressed).
+ * @size: size of the buffer.
+ *
+ * This IMA hook for kernel_module_read_file LSM hook is called after a kernel
+ * module has been read into memory and (if applicable) decompressed. It
+ * measures and/or appraises the module based on the IMA policy.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int ima_read_kernel_module(struct file *file, char *buf, loff_t size)
+{
+	struct lsm_prop prop;
+
+	security_current_getlsmprop_subj(&prop);
+	return process_measurement(file, current_cred(), &prop, buf, size,
+				   MAY_READ, MODULE_CHECK);
+}
+
 static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
 			    size_t buf_size)
 {
@@ -881,6 +902,10 @@ static int ima_post_read_file(struct file *file, char *buf, loff_t size,
 	enum ima_hooks func;
 	struct lsm_prop prop;
 
+	/* kernel module will be addressed in ima_read_kernel_module */
+	if (read_id == READING_MODULE)
+		return 0;
+
 	/* permit signed certs */
 	if (!file && read_id == READING_X509_CERTIFICATE)
 		return 0;
@@ -1250,6 +1275,7 @@ static struct security_hook_list ima_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(kernel_load_data, ima_load_data),
 	LSM_HOOK_INIT(kernel_post_load_data, ima_post_load_data),
 	LSM_HOOK_INIT(kernel_read_file, ima_read_file),
+	LSM_HOOK_INIT(kernel_module_read_file, ima_read_kernel_module),
 	LSM_HOOK_INIT(kernel_post_read_file, ima_post_read_file),
 	LSM_HOOK_INIT(path_post_mknod, ima_post_path_mknod),
 #ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 128fab897930..2c9bdc618ac9 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -241,7 +241,7 @@ static struct ima_rule_entry build_appraise_rules[] __ro_after_init = {
 
 static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
 	{.action = APPRAISE, .func = MODULE_CHECK,
-	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED | IMA_MODSIG_ALLOWED | IMA_CHECK_BLACKLIST},
 	{.action = APPRAISE, .func = FIRMWARE_CHECK,
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
 	{.action = APPRAISE, .func = KEXEC_KERNEL_CHECK,
diff --git a/security/security.c b/security/security.c
index 4d3c03a4524c..311ba63a8889 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3442,6 +3442,23 @@ int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 }
 EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
 
+/**
+ * security_kernel_module_read_file() - Read a kernel module loaded by finit_module
+ * @file: file
+ * @buf: contents of decompressed kernel module
+ * @size: size of decompressed kernel module
+ *
+ * Read a kernel module loaded by the finit_module syscall. Unlike
+ * security_kernel_post_read_file, it has access to the decompressed kernel module.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_kernel_module_read_file(struct file *file, char *buf, loff_t size)
+{
+	return call_int_hook(kernel_module_read_file, file, buf, size);
+}
+EXPORT_SYMBOL_GPL(security_kernel_module_read_file);
+
 /**
  * security_kernel_load_data() - Load data provided by userspace
  * @id: data identifier

base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
-- 
2.51.0


