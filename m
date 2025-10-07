Return-Path: <linux-kernel+bounces-843732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7F9BC019E
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 05:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0703C4C86
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 03:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27DC2253F2;
	Tue,  7 Oct 2025 03:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="I3Ny6C9G"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DD02222AC
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 03:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759807879; cv=none; b=Go01B38Se+0+Y7gKO4b+SEzMf91ijqaDvmts5VTUPOlEPjth+TFK9W/ODsJOcpfRC3XNRWUQFaHva7i3wcg6fu2PqkeFVJ1cLtrwhtFahYAPZnx3wmWfwm10HeKdk4ITtqKQXTl5nzLLLVYsSi2aidZSp+dfhouyAwNVl3Xlbp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759807879; c=relaxed/simple;
	bh=/drT+47PUHF+YSiTzIpGKzopMpsKtV8QOoOnRRft+BU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7rZ9DdkUSq/T4pEaxWVdtTWMDneiNfEfEqABhb+2mNOK6KXSFm2dyEHykYqPqor9GmFOgxoEvUM5O87z4wBwUj7sqWc0YfIVeuljjuTIICyMSVzEYUmJrckNYRf+b073e+sbbBQ1YmDTsv8EiaMWX7cBTO9wKynxl9kzTGmwLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=I3Ny6C9G; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-54a81bf36ebso845252e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 20:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759807875; x=1760412675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VBEGNGPrHJLgeZc8OwSpyVwglko2eCUcGTlg3MZ+0E=;
        b=I3Ny6C9GAT7H9+IIQk958hQxvMob44/CThPUWbMSYbFTUhb0Z+ylVI59lJ6VgBY161
         6xtYxs5qS0mM0q8L+05vkrmGP+cridOwC6GYmTPQkgh0RWBcdvdnqT28xTyo+0sx2r1g
         5Slf6k5moAw4wGDKEwRgVz1nTaU8nbJUX0Rb35N0WV48eRLeJtgKd1s0U4WVXxx3OYiG
         AAoTzr6sQNfVs3+poRCXU8vwlrplDxIITFxwfP/Vfxm4TFeR0BLn/9ZkA0RY8ns6rvEA
         pEXdPCKMS5P+neIfNPA8RuSIBUgO0s0orGvG5MbAaMbZQ8jiOjiXV74PotKKXi5K43zJ
         1btQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759807875; x=1760412675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VBEGNGPrHJLgeZc8OwSpyVwglko2eCUcGTlg3MZ+0E=;
        b=gmsvV7cp1szl3JvU0B9xo9dFIF3VlalH73IPew1+Az5cdpksCDjm148xRoVijsaVuI
         nQsFujaLhpT4UvRYipQC2rUBcIgLDGvqKMtSA/jJBnUAkbh9tAuD0Zci8Nbr/WNocY5f
         gGkevOMTFWcYAJyZ72RnlO0zC4ajcPUWJzVYibnckrgcLA30RcBUanvjLSHvRbDc8+sX
         Zn3XjP9pNUwGySkLXdgfo7qsl5TDGyeJqJpfq1F67a2sqRoaw+Ud7O31G5IC4/9qel86
         HBcOAVCM7aODbnY3i+Q/vf3bqx2NYAsNQPiz6AJjuy7ed1l4mrSxmbyfcaPZlWd7COgL
         weEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzB6yVs3hdxuXhxWm54dqYiWDQxlskvTsmpDXwALfcHXeE2SbtE0092VYCIqSEzc5LrzwQtwhQjpDM/t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiCiRYUxYaazIo+7eCtDbAR7ybv0foIubTFGEzZYktu3xVF6tW
	pNDgnLeORMhQNxh4J5oB7vUyK+0gr9IqkuJ5DTA7dh+jmB9EkXJRYOpkhQkaCjchfKE=
X-Gm-Gg: ASbGncur2lm+NZgsIVR01qzrfKaz+lTvCjcgK6IA9zW5j2juBymlXpnkeiKItYrWeR1
	QAiscOu+VBDhCYayupAo9DJITc/oc4YnHXmJyWfhNYLlbKJnQYqkE68VDJjZUx0K9podp0x/C9Q
	/qENYorgMb8aSwXZq1y6HfdgEHKn6rV9ujHBdcF9zR0JP5EnoMawLPEsb5U3pafyQFQkqxEBnVQ
	06F7oSfMQEGfAD9Octyka/xTawuiZ+IoY6LvtOLdNhsyweKbw4wwEufGbu/ZpFIRu79napCQ+sS
	YKwcSwFMZ4hUDJdbk32Dki6uSYUF/aorSFxznmNRhJByFP5a4JHLHSnFEEg4FwQZTeqEI/1hRn2
	+P48U9aZG6vmhrP6GpmHJjJcVoccTvVdQyXM2PjAMFXtisLrKcmj5Xp3GPNH+JZzMF4m42+ZY1e
	mhMUsMXGtpCBox4AjySsgN0WAfR0uwzRCEOveS6KRJWA==
X-Google-Smtp-Source: AGHT+IEm4J6yFD10/rZ/XdNA9W6YeHZUIRIn81vHOvDBC4QHa+8Eq0vvy55tHiaoLOJh8X8oN4bNLg==
X-Received: by 2002:a05:6122:1781:b0:54a:9e47:7624 with SMTP id 71dfb90a1353d-5524ea910damr5388462e0c.14.1759807875038;
        Mon, 06 Oct 2025 20:31:15 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-552ea335f07sm2446030e0c.15.2025.10.06.20.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 20:31:14 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org
Subject: [PATCH v5 7/7] kho: move kho debugfs directory to liveupdate
Date: Tue,  7 Oct 2025 03:31:00 +0000
Message-ID: <20251007033100.836886-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
In-Reply-To: <20251007033100.836886-1-pasha.tatashin@soleen.com>
References: <20251007033100.836886-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, that LUO and KHO both live under kernel/liveupdate, it makes
sense to also move the kho debugfs files to liveupdate/

The old names:
/sys/kernel/debug/kho/out/
/sys/kernel/debug/kho/in/

The new names:
/sys/kernel/debug/liveupdate/kho_out/
/sys/kernel/debug/liveupdate/kho_in/

Also, export the liveupdate_debufs_root, so future LUO selftests could
use it as well.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover_debug.c    | 10 +++++-----
 kernel/liveupdate/kexec_handover_internal.h |  2 ++
 tools/testing/selftests/kho/init.c          |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover_debug.c b/kernel/liveupdate/kexec_handover_debug.c
index d4ac78d53a39..eb47f000887d 100644
--- a/kernel/liveupdate/kexec_handover_debug.c
+++ b/kernel/liveupdate/kexec_handover_debug.c
@@ -15,7 +15,7 @@
 #include <linux/mm.h>
 #include "kexec_handover_internal.h"
 
-static struct dentry *debugfs_root;
+struct dentry *liveupdate_debugfs_root;
 
 struct fdt_debugfs {
 	struct list_head list;
@@ -115,7 +115,7 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 
 	INIT_LIST_HEAD(&dbg->fdt_list);
 
-	dir = debugfs_create_dir("in", debugfs_root);
+	dir = debugfs_create_dir("kho_in", liveupdate_debugfs_root);
 	if (IS_ERR(dir)) {
 		err = PTR_ERR(dir);
 		goto err_out;
@@ -175,7 +175,7 @@ __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 
 	INIT_LIST_HEAD(&dbg->fdt_list);
 
-	dir = debugfs_create_dir("out", debugfs_root);
+	dir = debugfs_create_dir("kho_out", liveupdate_debugfs_root);
 	if (IS_ERR(dir))
 		return -ENOMEM;
 
@@ -209,8 +209,8 @@ __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 
 __init int kho_debugfs_init(void)
 {
-	debugfs_root = debugfs_create_dir("kho", NULL);
-	if (IS_ERR(debugfs_root))
+	liveupdate_debugfs_root = debugfs_create_dir("liveupdate", NULL);
+	if (IS_ERR(liveupdate_debugfs_root))
 		return -ENOENT;
 	return 0;
 }
diff --git a/kernel/liveupdate/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
index de90a678274d..b3fc1957affa 100644
--- a/kernel/liveupdate/kexec_handover_internal.h
+++ b/kernel/liveupdate/kexec_handover_internal.h
@@ -15,6 +15,8 @@ struct kho_debugfs {
 	struct list_head fdt_list;
 };
 
+extern struct dentry *liveupdate_debugfs_root;
+
 #else
 struct kho_debugfs {};
 #endif
diff --git a/tools/testing/selftests/kho/init.c b/tools/testing/selftests/kho/init.c
index 6d9e91d55d68..f0136a30ce8b 100644
--- a/tools/testing/selftests/kho/init.c
+++ b/tools/testing/selftests/kho/init.c
@@ -11,7 +11,7 @@
 /* from arch/x86/include/asm/setup.h */
 #define COMMAND_LINE_SIZE	2048
 
-#define KHO_FINALIZE "/debugfs/kho/out/finalize"
+#define KHO_FINALIZE "/debugfs/liveupdate/kho_out/finalize"
 #define KERNEL_IMAGE "/kernel"
 
 static int mount_filesystems(void)
-- 
2.51.0.618.g983fd99d29-goog


