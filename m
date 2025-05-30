Return-Path: <linux-kernel+bounces-667867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB70AAC8AD4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 11:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3774E416B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 09:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB782236F3;
	Fri, 30 May 2025 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WB6z6OIw"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B96222562
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597400; cv=none; b=cSDtoDO1RgGBhmB1lKshupq1FuNLViznCtclqM0+R+ZmYfcTnlCEw475PB7gCkjCRju4UayXz3QKaXDUDzsYazT7AYWDmSptRFueU/XSJobi9TxffU4DfhSdqd8vWDN/h/sL1exidYJT+blFTP0qtuZM5m/gAML1dLTlPFUnRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597400; c=relaxed/simple;
	bh=VIZG5AiWC/s7En/XmKPIO2DjZgsCQ6G5W9Jx/My9WHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fvpkuSnPGtfbg/BAhDejjUOM2QLUZMMUAWAwlgDG9HvjY3wtshiUP1dlk0gyF+r0X3FaZrONnIMmTp9sU1LDkj57SQQuUfhH691/kWXU+YqgBMz4J9ni1Q1uRDOj2WWf27v0ru2VgMCIDluEbQ26/M5FmZm21VNPOD+JXwW65cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WB6z6OIw; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-312116d75a6so1581828a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 02:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597398; x=1749202198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxNHqqJshuS1h1cgjJgJ0ZrC1Xqsxa5tk/BB5ji3hvs=;
        b=WB6z6OIw5FMSobnxLBt+fPmPsX/NsOiTiisAYiUGKxuhRaLdy/ylTQVQVyf4Dg6kI/
         Jx/wkwLFji+l2wZ7nS6xPiWQDqHH5Bv23q2M8bNC3MBIMq22NYwZcwzGKug2VkHWcFW5
         Yhlmw5c+XWobbD+qMo7S/YQs4FZrJy3B/FQACXZ8HebyhjqZ8bH3u4Hlqs7/jglQejc4
         rZiaNVK4g5bik6IOs5wiJQ13/WYUNFY3iiMIF1wvviEcKkIjVt8CnlhFQGEy0Vx3Bc6L
         yTpm9aJ+BemoU+Pg6tleE3oHLwOY6LW4/wjv7hEosq+BxU+lCwMCi+6B0l+CcjM6f3Yh
         GJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597398; x=1749202198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxNHqqJshuS1h1cgjJgJ0ZrC1Xqsxa5tk/BB5ji3hvs=;
        b=odk1AsfM+CdUV8Q/gaRkfOt4zCVOTLMOYxxcAbwjAX7VhLNZEnJHhPsBzOTjCnlWRG
         6ROU8oVugf556Chi/4BW2W5O0MWGMESMVHy/lAl7+pL+uA86rEqZUsBzVFnntxm6qKM1
         CI8nwcIo0r9S9B0uY2OJN0r0MlIG+zgkiCMMXWfh11GonrdBh/ppHDOMkeU7b2ibmKhd
         MTs2D6b0iiUYFRz5vCEHGj/Z5WFgfak3KATv8JozYXpwVMhLKSgETCY0t6qTsV+FIDAS
         IceQQnopLoodIWUrMdIUc6jOUhCCujSQYn6uFUzWzMJt5nhNi7HvPEeOzBrtCwq6rQeD
         F4aA==
X-Forwarded-Encrypted: i=1; AJvYcCW44j5GxawEuxTUQEOHAsPhBE7Fpfek1ZDonAVQ6XMp7XtacNv4jNgP1IkwK42ZUsrwJhhBCUQ9DHe6NPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG2+za+waH3z2qZCRBLNOzTs2t5cR+ap7czTadw4k7iQ8eYx3W
	a8etKc6riXAfvxEDeqEgwDpQc0dO0jGxUU4uMSZx/CdkMhqlW13/Pinne+inGr8jRGI=
X-Gm-Gg: ASbGncs0IPDWF8MNewPKfnBua2jsQPW9lTEeX0LVFopSj51OFjaf5/sVlDuVqcMMwse
	NvFOukxdCJuY3+g2EvB1/sPtyH6bM5/V315F6ZR6Sr1qDH5zLy49pVNTbUhWRa73t4a/GK7co/Z
	uGlIaLpqey5uRjddl5p2c++xl7kgCAVrYNckjza+NkXk631bmwBSwOIXCMpewUpgP9YuG/ddqWu
	zkjDKnx6i/v49krkbdsW9k7cSnhf+a/mVh4zKZQ738psoILKQcqBsPjRBGnoiPVWP7nSDwmAH0V
	i8pmle4nDBfvfE33nUTJMskZjpnaEZ3ytu2lwlrWIRYGYJdondbHeAIgsci6Ce1i+eGd6qQBwfj
	iKy6kiFhCww==
X-Google-Smtp-Source: AGHT+IGBCG8Y5BoAzUhA//fCiLwTsxIymub8I3vmhNOr1M4fJfMNuuh617dJ5r3jIttsydinbIXPuQ==
X-Received: by 2002:a17:90b:39c5:b0:311:b5ac:6f5d with SMTP id 98e67ed59e1d1-31241e975d6mr4419282a91.29.1748597398101;
        Fri, 30 May 2025 02:29:58 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.29.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:29:57 -0700 (PDT)
From: Bo Li <libo.gcs85@bytedance.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	kees@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	riel@surriel.com,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	duanxiongchun@bytedance.com,
	yinhongbo@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	songmuchun@bytedance.com,
	yuanzhu@bytedance.com,
	chengguozhu@bytedance.com,
	sunjiadong.lff@bytedance.com,
	Bo Li <libo.gcs85@bytedance.com>
Subject: [RFC v2 06/35] RPAL: add user interface
Date: Fri, 30 May 2025 17:27:34 +0800
Message-Id: <de89b7dbd8277f809c61b1220cdca29875863fd6.1748594840.git.libo.gcs85@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the userspace interface of RPAL. The interface makes use of /proc
files. Compared with adding syscalls, /proc files provide more interfaces,
such as mmap, poll, etc. These interfaces can facilitate RPAL to implement
more complex kernel-space/user-space interaction functions in the future.

This patch implements the ioctl interface, The interfaces initially
implemented include obtaining the RPAL version, and retrieving the key and
ID of the RPAL service.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/rpal/Makefile   |  2 +-
 arch/x86/rpal/core.c     |  3 ++
 arch/x86/rpal/internal.h |  3 ++
 arch/x86/rpal/proc.c     | 71 ++++++++++++++++++++++++++++++++++++++++
 include/linux/rpal.h     | 34 +++++++++++++++++++
 5 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/rpal/proc.c

diff --git a/arch/x86/rpal/Makefile b/arch/x86/rpal/Makefile
index 2c858a8d7b9e..a5926fc19334 100644
--- a/arch/x86/rpal/Makefile
+++ b/arch/x86/rpal/Makefile
@@ -2,4 +2,4 @@
 
 obj-$(CONFIG_RPAL)		+= rpal.o
 
-rpal-y := service.o core.o mm.o
+rpal-y := service.o core.o mm.o proc.o
diff --git a/arch/x86/rpal/core.c b/arch/x86/rpal/core.c
index 495dbc1b1536..61f5d40b0157 100644
--- a/arch/x86/rpal/core.c
+++ b/arch/x86/rpal/core.c
@@ -13,11 +13,14 @@
 int __init rpal_init(void);
 
 bool rpal_inited;
+unsigned long rpal_cap;
 
 int __init rpal_init(void)
 {
 	int ret = 0;
 
+	rpal_cap = 0;
+
 	ret = rpal_service_init();
 	if (ret)
 		goto fail;
diff --git a/arch/x86/rpal/internal.h b/arch/x86/rpal/internal.h
index e44e6fc79677..c102a4c50515 100644
--- a/arch/x86/rpal/internal.h
+++ b/arch/x86/rpal/internal.h
@@ -6,6 +6,9 @@
  *     Author: Jiadong Sun <sunjiadong.lff@bytedance.com>
  */
 
+#define RPAL_COMPAT_VERSION 1
+#define RPAL_API_VERSION 1
+
 extern bool rpal_inited;
 
 /* service.c */
diff --git a/arch/x86/rpal/proc.c b/arch/x86/rpal/proc.c
new file mode 100644
index 000000000000..1ced30e25c15
--- /dev/null
+++ b/arch/x86/rpal/proc.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * RPAL service level operations
+ * Copyright (c) 2025, ByteDance. All rights reserved.
+ *
+ *     Author: Jiadong Sun <sunjiadong.lff@bytedance.com>
+ */
+
+#include <linux/rpal.h>
+#include <linux/proc_fs.h>
+
+#include "internal.h"
+
+static int rpal_open(struct inode *inode,
+			     struct file *file)
+{
+	return 0;
+}
+
+static int rpal_get_api_version_and_cap(void __user *p)
+{
+	struct rpal_version_info rvi;
+	int ret;
+
+	rvi.compat_version = RPAL_COMPAT_VERSION;
+	rvi.api_version = RPAL_API_VERSION;
+	rvi.cap = rpal_cap;
+
+	ret = copy_to_user(p, &rvi, sizeof(rvi));
+	if (ret)
+		return -EFAULT;
+
+	return 0;
+}
+
+static long rpal_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct rpal_service *cur = rpal_current_service();
+	int ret = 0;
+
+	if (!cur)
+		return -EINVAL;
+
+	switch (cmd) {
+	case RPAL_IOCTL_GET_API_VERSION_AND_CAP:
+		ret = rpal_get_api_version_and_cap((void __user *)arg);
+		break;
+	case RPAL_IOCTL_GET_SERVICE_KEY:
+		ret = put_user(cur->key, (u64 __user *)arg);
+		break;
+	case RPAL_IOCTL_GET_SERVICE_ID:
+		ret = put_user(cur->id, (int __user *)arg);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+const struct proc_ops proc_rpal_operations = {
+	.proc_open = rpal_open,
+	.proc_ioctl = rpal_ioctl,
+};
+
+static int __init proc_rpal_init(void)
+{
+	proc_create("rpal", 0644, NULL, &proc_rpal_operations);
+	return 0;
+}
+fs_initcall(proc_rpal_init);
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index f7c0de747f55..3bc2a2a44265 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -77,6 +77,8 @@
 #define RPAL_ADDRESS_SPACE_LOW  ((0UL) + RPAL_ADDR_SPACE_SIZE)
 #define RPAL_ADDRESS_SPACE_HIGH ((0UL) + RPAL_NR_ADDR_SPACE * RPAL_ADDR_SPACE_SIZE)
 
+extern unsigned long rpal_cap;
+
 /*
  * Each RPAL process (a.k.a RPAL service) should have a pointer to
  * struct rpal_service in all its tasks' task_struct.
@@ -118,6 +120,38 @@ struct rpal_service {
 	atomic_t refcnt;
 };
 
+/*
+ * Following structures should have the same memory layout with user.
+ * It seems nothing being different between kernel and user structure
+ * padding by different C compilers on x86_64, so we need to do nothing
+ * special here.
+ */
+/* Begin */
+struct rpal_version_info {
+	int compat_version;
+	int api_version;
+	unsigned long cap;
+};
+
+/* End */
+
+enum rpal_command_type {
+	RPAL_CMD_GET_API_VERSION_AND_CAP,
+	RPAL_CMD_GET_SERVICE_KEY,
+	RPAL_CMD_GET_SERVICE_ID,
+	RPAL_NR_CMD,
+};
+
+/* RPAL ioctl macro */
+#define RPAL_IOCTL_MAGIC 0x33
+#define RPAL_IOCTL_GET_API_VERSION_AND_CAP                        \
+	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_GET_API_VERSION_AND_CAP, \
+	      struct rpal_version_info *)
+#define RPAL_IOCTL_GET_SERVICE_KEY \
+	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_GET_SERVICE_KEY, u64 *)
+#define RPAL_IOCTL_GET_SERVICE_ID \
+	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_GET_SERVICE_ID, int *)
+
 /**
  * @brief get new reference to a rpal service, a corresponding
  *  rpal_put_service() should be called later by the caller.
-- 
2.20.1


