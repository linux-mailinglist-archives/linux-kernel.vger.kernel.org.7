Return-Path: <linux-kernel+bounces-823706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D211B873A7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB707E0F79
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4C12FE077;
	Thu, 18 Sep 2025 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U672b9o3"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084A031B120
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 22:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758234395; cv=none; b=gi7If9GggxuC7bNh0gXoZhiMoLhofNpgeBx9DR655yZszazm5+X5bmqHxYPTUss29rgN9Iqvflz4bXgd54pDRqEwHVb3jwuWbf9D7DrdmJKoImSXQFmIUWOjFqEm1z8ePNZS3/JWx0Pan0k8m65iTUXD5pZu3YOCX2rdxRRUxc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758234395; c=relaxed/simple;
	bh=HXOVkeb/AbxAfsZ9XuWOxMBgSD9X3noGMn+5V1M+aOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BHoBPk6l6G7WTqfY76hQnH9CjHz/x0VBYFMBHVFScr5boS3+IgBS9nLXBQYyeqZCm+6jKhU/9o+vxfYKkPyASZ8egMIsT93qMGICoCkf7e+H3kw+aAx9xhiT/NiPeaUoo9UFv/dKn7Y6Up/3vBDhJ8RYTp3OLobdNTBGZo/YkZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U672b9o3; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77251d7cca6so1566128b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758234393; x=1758839193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwRb7SzhfZg7neWGwUqJxva5Q/Tf1fgxJiUlDnCKY6o=;
        b=U672b9o32A5shV5K2z6M7u20yYB7dFdm6Rr1GcJ1+B+JvEst6DLFzy48PWCE+bEiXc
         tRxyxmJc4DBfdb61d2dknCKW+rbbgLiaeOZ4ylBri/2tZewigUdGzmWFjLzEd4kVe7i+
         wplNL72/p7FdyP8Re6Y9Ciz+FurI5RS0glN4I0Llactfc05dADpU9iQSO5s5hkOp9N4a
         q5Eti9tZjxdYpX+Q3pO51YgljB0+wx7qWnSQdcg37EJz3LNj+NvdrGqMY/qj8sO5I4kw
         viPdKrsMo7XaD0mM+L1i0Y2hQiZoMjMQY70DohOScT7cQjMsJSbgMsqhLgOJEjjQepkb
         +vaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758234393; x=1758839193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwRb7SzhfZg7neWGwUqJxva5Q/Tf1fgxJiUlDnCKY6o=;
        b=eoSL9Cxg7oEpLCsBnhYdp3GE2WPcHaJf12BZFdLcmR0UmjGmVGignq/6ID+OqWMQxV
         3VLzmVB2Nf1sVHQcsi+Yem8Nz/Tig1fSPFWxOm91lzF6yzmpdXpAJK7Hl9AAv6f/iE9F
         ks78g/cfwikPdPwrgQUlOsLJLB+6tumayT3J2c7VR9VApfCfNTBGUYLi4Q6m2vRO68dG
         bU78Pn7XWA8LSub30ILDRKZI58W4gYAiJLQFI5QjgpsKwRZzb6Uk8w/8EdBwgevVieLh
         8/WSzWEpmUdlHKmeuITfIyTFbmCcHi76dDIgK9s2LjzMEAZA6fmrxySjuoi03wk1UFdR
         QJTA==
X-Gm-Message-State: AOJu0Yx8X4dsFHdQmYx4B4AjO2Qf7dAHdj/U9V9ZxvYPQPX4lTTinCZ7
	e4fMkWAT0+UTKUuU4wzyLonWd65Y0swQv2UZVqgHWYG+tQ4vS+SMt0K37xG9pg==
X-Gm-Gg: ASbGncsUXtwLW7aWSgtcY5AIYw+8B5ZP9YuFiTpb/80CKPe+SKEBM2gf1VGqWW0QiuD
	TdfmmQNZkSvhsexmNT137JD/3Rmwdh6SqGAwzKIcclq/BrK0eb0thkSiGrJz2d1AdDktwj8mdhY
	v+zvV/3aRqDstbyi00nwqh2F4dggFo3kMDT18B5pDl0DgqqxL+/N0cn1JXQ4+hnGSGMzL+3uy5n
	3fTs5LMQ13G1Vi9vX312ukVWfWxADzqX8T8UNaXM5+5fW1rcSpo1hhELVi3cayOgB5F9AfeG1WE
	wO6rXRDgRKjUkyrAPW6SZJVsKKZn89l1tWb//7SBiZpoauR4Sdto1kKq/P4/l9SbD8tpCEkfMpE
	ugq9FzWK5EYdMbG8AQYp/b2MkVhQPvfENlRA0HfUPbdgHlSA=
X-Google-Smtp-Source: AGHT+IENSD4FSp5oCJNvN+B+S7Ehm9laSk+STvS8UEs+QD3NwWg6ip8ENfOjlvBCKPM94MRsd6BQ9g==
X-Received: by 2002:a05:6a00:139a:b0:772:7ddd:3fe0 with SMTP id d2e1a72fcca58-77e4d03267emr1101959b3a.2.1758234392993;
        Thu, 18 Sep 2025 15:26:32 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:c5c1:2e33:6cf2:beed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e5fe6de75sm407542b3a.19.2025.09.18.15.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 15:26:32 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch 7/7] kexec: Add /proc/multikernel interface for kimage tracking
Date: Thu, 18 Sep 2025 15:26:06 -0700
Message-Id: <20250918222607.186488-8-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cwang@multikernel.io>

Add a dedicated /proc/multikernel file to provide read-only access to
all loaded kernel images in the system.

The interface displays kernel images in a tabular format showing:
- Type: kexec type (default, crash, multikernel)
- Start Address: entry point in hexadecimal format
- Segments: number of memory segments

A lot more information needs to be added here, for example a unique kernel
ID allocated for each kimage. For now, let's focus on the design first.

This interface is particularly useful for debugging multikernel setups,
system monitoring, and verifying that kernel images are loaded correctly.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 kernel/kexec_core.c | 63 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 4e489a7031e6..8306c10fc337 100644
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
@@ -1224,6 +1226,52 @@ struct kimage *kexec_image;
 struct kimage *kexec_crash_image;
 static int kexec_load_disabled;
 
+/*
+ * Proc interface for /proc/multikernel
+ */
+static int multikernel_proc_show(struct seq_file *m, void *v)
+{
+	struct kimage *image;
+	const char *type_names[] = {
+		[KEXEC_TYPE_DEFAULT] = "default",
+		[KEXEC_TYPE_CRASH] = "crash",
+		[KEXEC_TYPE_MULTIKERNEL] = "multikernel"
+	};
+
+	seq_printf(m, "Type        Start Address   Segments\n");
+	seq_printf(m, "----------  --------------  --------\n");
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
+			seq_printf(m, "%-10s  0x%012lx  %8lu\n",
+				   type_name, image->start, image->nr_segments);
+		}
+	}
+	kimage_list_unlock();
+
+	return 0;
+}
+
+static int multikernel_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, multikernel_proc_show, NULL);
+}
+
+static const struct proc_ops multikernel_proc_ops = {
+	.proc_open	= multikernel_proc_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= single_release,
+};
+
 #ifdef CONFIG_SYSCTL
 static int kexec_limit_handler(const struct ctl_table *table, int write,
 			       void *buffer, size_t *lenp, loff_t *ppos)
@@ -1295,6 +1343,21 @@ static int __init kexec_core_sysctl_init(void)
 late_initcall(kexec_core_sysctl_init);
 #endif
 
+static int __init multikernel_proc_init(void)
+{
+	struct proc_dir_entry *entry;
+
+	entry = proc_create("multikernel", 0444, NULL, &multikernel_proc_ops);
+	if (!entry) {
+		pr_err("Failed to create /proc/multikernel\n");
+		return -ENOMEM;
+	}
+
+	pr_debug("Created /proc/multikernel interface\n");
+	return 0;
+}
+late_initcall(multikernel_proc_init);
+
 bool kexec_load_permitted(int kexec_image_type)
 {
 	struct kexec_load_limit *limit;
-- 
2.34.1


