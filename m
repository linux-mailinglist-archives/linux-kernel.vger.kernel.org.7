Return-Path: <linux-kernel+bounces-859550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4716BEDF07
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC4924EBFC1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 06:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4DD2264B8;
	Sun, 19 Oct 2025 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyScUyoD"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E0823A995
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 06:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760854636; cv=none; b=jFp5cqMRhWKznyh53uJYioCl7GK/ja3CxSq0cm+3Uj7vqjJEg70MXwtPkoGnioSO654jCaipKWSPA0WBL0vRWg/gehtaKCcYjnAo8D4z5uUkHr4RV6xEeaJPoApCzJJcUIO6fPGbE5R0hOiV5EeNuHo/xvGTJt4vcAs+DgsGUKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760854636; c=relaxed/simple;
	bh=AcYeXfCYBxN5PnHX4zoqm4aCf4KaAZkCLga1VweQ4FU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ASp8dTyq1r0qBT0FNDiOJkI/h5mER0SgdreLuGLyrksjdQ7JmwQw4VM3et4TrcYJmqXm5aeb/2hBGUpm0gfY/rJL9+qc7b2skofYYds3PbktIvO4nn+VcdMCHpxpSwnvdqFNVasRkSGsidyzMXordxj6KB7vFY0hc0rDMre9/SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyScUyoD; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-339e71ccf48so4657546a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 23:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854633; x=1761459433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pa/MsfNPB6bG2GsTxSNKTLsrafwlRF2VsAPzt2eBf8E=;
        b=CyScUyoDISUqYl7YVmpCyC0UuCFoGaQgZQvdPDtMxJpSdSs2dd5u1qEPHAoEX9+fx2
         4UzMSnNbClWwVIMKMGWdYn5bYyH6ysR3T1yx5dk1QH9Qj0/8y2iBpjJpwQPmATGNCFhy
         Q5l/c931DSCX7R5bO7Uhypen3JDRMRYzXXWp0mJ63FAuUNJXMDp2FYyDz/0pHhExydVo
         W5mHrrKPvuwHM1fsuZl28neKn4CBd4KA5sb1zahIUpzKyoSlC4HFvLSwroViu+5f0DCq
         dVWJfgaICiS8MUZi1BrbpeqXnFUHsjMV7FArc8XW63rUstVKuRmofosJGR7COL+bNmrS
         WJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854633; x=1761459433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pa/MsfNPB6bG2GsTxSNKTLsrafwlRF2VsAPzt2eBf8E=;
        b=SRT5ILoaSqc/oojJ8GiNnYJhs4e2OxXGB3+ETOYr1LPndWwU1ZiZd2vAEgC6qUJz5v
         3vygTGJHSrL3iISULA2LZ9Pd7hQ0NRa1vhJ/RltPJNmYd6p06+pJY4oYQL2h7KLgEVoP
         p7doy6Y/ws4hoCtBjgL0MpMVKaw5ocTpcDBbkeMMixUZUHU7AdJpqeb5xeFNkx7DFVta
         bhHgZod+luXHE15bcoWO9bkscCUsVyI/VNdM2rMxI+WngDgd0UOCTEcLoIJqPT53uPzq
         Ct6mpDgBNMLWwd7lAd530G42IJopZLcnQ6rHJmysr1BJKWHcStXL6v/OEZGiJknk7tKq
         dK8A==
X-Gm-Message-State: AOJu0YzQ8vAtMCWn/xT+FpdxsVqJv24+tPZ+Vi/kENfZWpGz1USLW+Q1
	spsPwhXrkRQGxjMbGfOHkajS6GTXHLsUNebhdz/eh2vvLsio4XngJTTOEgCdaA==
X-Gm-Gg: ASbGnctTUQxQKfCULCbNhclnQ3h85jo+9OV01uIVKhYRHPlJLA+F+CZvZDaVj1wb/aI
	khKBtIXr4DE2wLA91vhu78pNM3Hsc4yJmtvShy4BU5ps+PcxL4F/4dluYlzBcGE5g1ZKOxz6PSG
	wxAlKqj8XIa8BSiZtYZKN3tKXkJiVlraKyWQa4x5kNRqOIt8eSYIo9sC/aaq3/GbGCLHyr0wRhN
	t7Ypq0esUCGLLSbGKseqvCjUUD+lR9FS2uV6/TUC5AqFsL185Ne3V/2tEXmzfS/RqnKTOCcnm61
	gDryD55VgllCnPSBgMm/wQUXTX0J0Iw3b5mGPun3oHkN8D6VB5xJTjvt89MkgaGhZRLWcP46Zbh
	n7Y0i8mxC1NZ/oV78isDIUI/Ss0cA5xMnR1goF5VzeHNDT/6AKHsdIfncFxD9zeKUJUfL3IkTJR
	lP4HEeSPBs3tsizmA=
X-Google-Smtp-Source: AGHT+IEcU9YEdbUoIaZ58UmrsaoQiSd0FUGy1FLPQQWXoQbBycgCM+6raP4xZnOBinCzMBaBjeximQ==
X-Received: by 2002:a17:90b:2ec7:b0:33b:6650:57c3 with SMTP id 98e67ed59e1d1-33bcf8ec60dmr11689870a91.21.1760854632902;
        Sat, 18 Oct 2025 23:17:12 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:17:12 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: jiri@resnulli.us,
	stefanha@redhat.com,
	multikernel@lists.linux.dev,
	pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch v2 11/16] kexec: Add /proc/kimage interface for kimage tracking
Date: Sat, 18 Oct 2025 23:16:25 -0700
Message-Id: <20251019061631.2235405-12-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
References: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cwang@multikernel.io>

Add a dedicated /proc/kimage file to provide read-only access to
all loaded kernel images in the system, for both regular kexec kernel
images and multikernel images.

The interface displays kernel images in a tabular format showing:
- Type: kexec type (default, crash, multikernel)
- Start Address: entry point in hexadecimal format
- Segments: number of memory segments

This interface is particularly useful for inspecting kimages, debugging
kexec, and verifying that kernel images are loaded correctly.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 kernel/kexec_core.c | 63 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index ed5c97b4531e..7db755e64dd6 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -13,6 +13,8 @@
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/kexec.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/highmem.h>
@@ -1214,6 +1216,52 @@ struct kimage *kexec_image;
 struct kimage *kexec_crash_image;
 static int kexec_load_disabled;
 
+/*
+ * Proc interface for /proc/kimage
+ */
+static int kimage_proc_show(struct seq_file *m, void *v)
+{
+	struct kimage *image;
+	const char *type_names[] = {
+		[KEXEC_TYPE_DEFAULT] = "default",
+		[KEXEC_TYPE_CRASH] = "crash",
+		[KEXEC_TYPE_MULTIKERNEL] = "multikernel"
+	};
+
+	seq_printf(m, "MK_ID  Type        Start Address   Segments\n");
+	seq_printf(m, "-----  ----------  --------------  --------\n");
+
+	kimage_list_lock();
+	if (list_empty(&kexec_image_list)) {
+		seq_printf(m, "No kimages loaded\n");
+	} else {
+		list_for_each_entry(image, &kexec_image_list, list) {
+			const char *type_name = "unknown";
+
+			if (image->type < ARRAY_SIZE(type_names) && type_names[image->type])
+				type_name = type_names[image->type];
+
+			seq_printf(m, "%5d  %-10s  0x%012lx  %8lu\n",
+				   image->mk_id, type_name, image->start, image->nr_segments);
+		}
+	}
+	kimage_list_unlock();
+
+	return 0;
+}
+
+static int kimage_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, kimage_proc_show, NULL);
+}
+
+static const struct proc_ops kimage_proc_ops = {
+	.proc_open	= kimage_proc_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= single_release,
+};
+
 #ifdef CONFIG_SYSCTL
 static int kexec_limit_handler(const struct ctl_table *table, int write,
 			       void *buffer, size_t *lenp, loff_t *ppos)
@@ -1285,6 +1333,21 @@ static int __init kexec_core_sysctl_init(void)
 late_initcall(kexec_core_sysctl_init);
 #endif
 
+static int __init kimage_proc_init(void)
+{
+	struct proc_dir_entry *entry;
+
+	entry = proc_create("kimage", 0444, NULL, &kimage_proc_ops);
+	if (!entry) {
+		pr_err("Failed to create /proc/kimage\n");
+		return -ENOMEM;
+	}
+
+	pr_debug("Created /proc/kimage interface\n");
+	return 0;
+}
+late_initcall(kimage_proc_init);
+
 bool kexec_load_permitted(int kexec_image_type)
 {
 	struct kexec_load_limit *limit;
-- 
2.34.1


