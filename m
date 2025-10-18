Return-Path: <linux-kernel+bounces-859321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 892B1BED4BD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148685E73C7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AAD264FB5;
	Sat, 18 Oct 2025 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="TfmjLqBp"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D2A25EF81
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807890; cv=none; b=PXMUDhxnajwhe1wRKYYGr6MOecvZnYjB+cYnU94SQsqiFUEUuFKmi0Ul5uSlgsMOuIg6OVHWwsDFf3Y4fa1GjijtCRegz1cWApOwIK3yez/Z8Q3gtVsX0Yl29+r+f9lKLbu75O43m2h0Od5vkiLX3tBxIX2/vGvtfBQFslhBL1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807890; c=relaxed/simple;
	bh=BgJDaSS37AfTWmdC+Ced4iT0wmfV6rKUobcozTNQ4QM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7CkOwedjZ66dvwb3eu3fVAyaoL96Hqhi+fI5zFVbX9+YF0xhXI8av/SP0PYor6eFhHjOKCiPQespKtWEgLJwvF4wKK9JJqcbMdQa3PBGkFsMqtvX8w9KUUoKjkFWCGVWEqGycoUsEBsAPq9k55yuoTmvu72JKGOJRmAVsAeVHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=TfmjLqBp; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-78e4056623fso38714896d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760807887; x=1761412687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2rPu3rJk61NsUDORe6hfrEPNayKm6hvJ8nWbKNdE/g=;
        b=TfmjLqBpedvNsbuDQW857+8qakFh01u3qpDjNE64rIPulwsCwZZTf/jcBNpxNtZP+R
         6YSophr+QGwMrkl1etOf7CWGimqtmB75hf8i71riI1Eo4Medjb/cdxNYiGOeMv00Dro9
         O960OH942J3z+HwPPFfQRqsyIyWDIX1WZdgB9V+dJC/tebuSpGmm7U3OvP5/FGoAkAlQ
         lkwz1eBULSwdtLJ/8cJXDFOR6yWKwlMBGw/kAyb7Ew4mpVPMgIyNG9vDqMTq3ODGpMsA
         nC7MS7yri3b2nz3EEH5rasEWPs6lE/3jhpHweehnzbLsUZvo6f/h2P9r9KWZkII9I/q6
         dyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760807887; x=1761412687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2rPu3rJk61NsUDORe6hfrEPNayKm6hvJ8nWbKNdE/g=;
        b=UYwQlIronUcsKP915mqOh1Ywc87nmLmdmPEe9rJbbWnxhkBsMP8uPe+IStyGjkNEH4
         mYL2l9Lre4OlwrekKW11yNDDVOvdxsC9fCZGz3GYnd+rWo9+qsgJ5QeDT6J5NChOlgTk
         U4Npt/LNTRn6fYZIWqK/gx21w/yVtXGeQ1nUN0jP210549Vp47WCZwwzbUcxVvKEylki
         jY9PGmwI3p3kfe2zu2979OgkHE9sa0xxYdS6Dza+EmZjIIu6sbIYh5wBmhzOSWBtEsw/
         E1VIlxd/BkIe8a61PTnWYgq8aK4radwOSxPuv+Y/P7KxOlWMvQs9X9XBSzxI6EeD9EaB
         Z6Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUmLGD+iTT5e0aAPj4WYCthK/5GVZKtCoh/WJO2QsyZB0UrsjG7X1A9EW9ObKCCJdLUXn7me+uJXKq27lE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySOvHrVT+sJCkpf6w+DOIu5Ef2PH+dAtMQkYHfrWOEwGRKeNM4
	wf1wlPQSv/cQn9AvRnuqZ69c2QQUHlDOc85e6F4hgv3x3+oC6N/g7am+wBjyVcmTG0w=
X-Gm-Gg: ASbGncvEwIH2r8LqUtoZ51Uhi3gfdkMO2IXg5DSUnVaN5qZcm3Wzmah7KqRFm9Ktg/7
	SikAqoB4BXUoe85hJzbtIdF4Hig2WilkGFtvz0ayq/bnAB48SbUeNJNyxWu+msq4LUSfF+MR10Q
	d2N+QruR+zzoU8hmexDitFDPIxF2qG8G2FC74Xj9uBoZG3z9uLCuSB5IKJi/6Gr78tEeMkheTnW
	KIfg30pLT+q2JUkvpNJ7WYqVwz7A508YrTYGJxZnHU6fmjHMEevYPUHvQiuwESbtRtrMD6bbhvR
	FlzSG3LBXsYUlwM+O8t/s9XJ1C1ALUajYUWmZNiiIiAUMAxb0pj7CpA2xG25cDs2HDAJXa8mmZN
	fF0UDmnOOcujFnN0NY61ts1t4HyBAaOwDhjzQAbWyzRaHOpJvMGKuZffzjQymekn3Jo0O2sNzKu
	cdxOyt642+SV9CMXJflFio0Eyms2JrNTYa4BR94AkWbH50pHI3FeoGwitNf3UHxVZRUhvJ7jvtu
	Qv6mRzJ5jDixzhjg/Ge1LrmsIzC/xn+
X-Google-Smtp-Source: AGHT+IFVF7YTAGmDUxpNHm20v159jaCZkyWRtFxoFzlU1BR8eeX69kBkAQ/hkjYMJqzT0Bo97bEDpg==
X-Received: by 2002:a05:622a:1a18:b0:4e8:b889:5c3c with SMTP id d75a77b69052e-4e8b8895f08mr10843041cf.33.1760807887246;
        Sat, 18 Oct 2025 10:18:07 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02d8e909sm18478116d6.62.2025.10.18.10.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:18:06 -0700 (PDT)
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
	tj@kernel.org,
	jasonmiu@google.com,
	dmatlack@google.com,
	skhawaja@google.com
Subject: [PATCH v6 07/10] kho: move kho debugfs directory to liveupdate
Date: Sat, 18 Oct 2025 13:17:53 -0400
Message-ID: <20251018171756.1724191-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
In-Reply-To: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
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
 kernel/liveupdate/kexec_handover_debugfs.c  | 10 +++++-----
 kernel/liveupdate/kexec_handover_internal.h |  2 ++
 tools/testing/selftests/kho/init.c          |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
index 6ddcd17fac3c..63447564dbe8 100644
--- a/kernel/liveupdate/kexec_handover_debugfs.c
+++ b/kernel/liveupdate/kexec_handover_debugfs.c
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
2.51.0.915.g61a8936c21-goog


