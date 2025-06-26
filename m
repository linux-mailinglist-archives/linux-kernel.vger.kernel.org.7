Return-Path: <linux-kernel+bounces-703598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27AFAE926D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 01:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544393B9BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 23:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCCC2E5404;
	Wed, 25 Jun 2025 23:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="fZcXEyXH"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53EB2E1C41
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 23:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893560; cv=none; b=Z+AX38MwqKFeaoaB4xkl8qrSRSEdkQNf/kMk4JUpyRsajUifE6zqVC875pd6bVUjfM6Wm1guew30CqZU93ITukFLQX4Uk2rH6azNIii2s2BQmwJ837UNKZUwjD+OB2VvS6hXlCdp/iguBew7qpoBGjw2mBmibB/DyDQwwcB+nQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893560; c=relaxed/simple;
	bh=0K/tRVmbaZ0VX6fH8M8cdhr3USMmOz4iPh58HsL+dDs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyzOM3PaLTI/2URjfWhB4QJLIsV3rRghZyYYyL8u1YBri6mxwl184oQvFPDh/rpl4UcSOfLmaXcbwsLrgz+n/D+6z1Q7kvdDRNh4RDHti1Hxg/67402CbK0AHCEa4hxg9+XPXRD/Re82XbBKoH3r//RaQd89Fo68I099SPhKvro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=fZcXEyXH; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70e4b1acf41so3714097b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 16:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893558; x=1751498358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZJDnzlkjFdal2Rjq5d+u9z1RQAbXbOPFvsyuVPVQrw=;
        b=fZcXEyXHF9NuvYm8Whls0JQk1JDl8m27PgnvY39aUbeV1Euuq9WgtTgh/xHZLi//YI
         BTaACvoBu5k510wQinRTpKUvGIIavm0n1sF1qxpz2c6delQeR6D5+fEoacCdF9bF570a
         xdIQ+RiSkCeTmcTZVapDE4eJptI3OLfLlf9sINNuYP8EeoR4+DN+i7lQOHu+eM0kFG36
         hZiTLNjYhdgIuqOQtQakDtOzQ8MC3pfCK+EgXumz98J8VrRo+cpBTWcsU7cL1Ot5LpW+
         GgWqy0q3zg1l8H8HIGy5PfBcgllc17jXLogviZhhNkswaIKuImunvyLFCdhbd3umzyX2
         iOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893558; x=1751498358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZJDnzlkjFdal2Rjq5d+u9z1RQAbXbOPFvsyuVPVQrw=;
        b=w8bAmQ2RKxVqPutUCAdScBAR/tvP6co5PWtXzWlHllerhVJxYsnpkc9NJRbsnd0bNf
         7RHhDATm+h2lQYkrs/FzVDKw/cRRvMCZonpzphFvstNDADslvqfPPoT4qj6d5WFLgA2i
         TOP7vO7mFhumKt8HrZEnnZYunZMY2mf9dbrjKZELUM1ltGHMTfdryBYl+k6s60tfgRrl
         sCXEKZkSRUMsNXYE+VxmEnrGWCNK1Y7L0P0oUzzXhCr6JagX33rCcMeRFpB5234zbBQF
         XUslkFRkXAl04lbr7MOuoT6Wi4tHkRF/KmdndjPkB9ezR4iJnqJZzaA7ZwqsVLqhwk3R
         Eflw==
X-Forwarded-Encrypted: i=1; AJvYcCUB8noz9D3YGoTGjdlzcYe7ErBVjai8gcOrY9ZHDjeKRUleBc8F/GITS+Z+G/Js+uXNJB/p21nsXBirsxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVP5FiuRfLCS5f/XYMSh18DOJVtKrzDNXzmC0rK9ZuPF4fTMbm
	CxWHCRu76u3wFSh7W8eaMKsGOQStMLNz99ZWeZLKN7XgCB8SQHZv3GIlBp8onQk6TzI=
X-Gm-Gg: ASbGncuuq8vFLCvP/XYVO56v+VYDnx2haRLG76jHYviluoympwvBD3/1QVS1lS4kQ+u
	E7RI0jyAd0VHbjar/6tO6dKHLGzAoLPeUpPwoBMpwpDLebWP+38hrXat4iUPMQZxAuKQzhsisK4
	/6HcbbE8RMItuX0DVI/upFbKC1dqaXkEYku2wcK5kS93wuR1ykmUT8ZTQRmEMxpxYap5LSWw+gI
	Z5zbi/XUjmFenmbKyxHlTNtbjRPOUpML2YoC0yt2UCtLNLNwsx9y+VrNIvwTDjPmvh2hhog0rx4
	tq9b949o9OB1C+1uVkvtkzFKwGpx9MfMcZ5EOUhdKcV9xle1pnufYScZ4xUroDOy+sw1ZwcSk1v
	S90otM1JIA0xceW5W2hxdh8duka579SES0i7j+lRwwxi4l0EbQMrb
X-Google-Smtp-Source: AGHT+IEy6gDp+TLxoQz7i8XJK92N1YqMToyOrPaa/RNISf+e+ji+erXXV1um4VBOajJ98t+L3IMAZw==
X-Received: by 2002:a05:690c:6089:b0:70e:1474:63f2 with SMTP id 00721157ae682-71406c7cfb8mr66969267b3.7.1750893557847;
        Wed, 25 Jun 2025 16:19:17 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:19:17 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 20/32] kho: move kho debugfs directory to liveupdate
Date: Wed, 25 Jun 2025 23:18:07 +0000
Message-ID: <20250625231838.1897085-21-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
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

Also, export the liveupdate_debufs_root, so LUO selftests could use
it as well.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover_debug.c | 11 ++++++-----
 kernel/liveupdate/luo_internal.h         |  4 ++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover_debug.c b/kernel/liveupdate/kexec_handover_debug.c
index af4bad225630..f06d6cdfeab3 100644
--- a/kernel/liveupdate/kexec_handover_debug.c
+++ b/kernel/liveupdate/kexec_handover_debug.c
@@ -14,8 +14,9 @@
 #include <linux/libfdt.h>
 #include <linux/mm.h>
 #include "kexec_handover_internal.h"
+#include "luo_internal.h"
 
-static struct dentry *debugfs_root;
+struct dentry *liveupdate_debugfs_root;
 
 struct fdt_debugfs {
 	struct list_head list;
@@ -120,7 +121,7 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 
 	INIT_LIST_HEAD(&dbg->fdt_list);
 
-	dir = debugfs_create_dir("in", debugfs_root);
+	dir = debugfs_create_dir("in", liveupdate_debugfs_root);
 	if (IS_ERR(dir)) {
 		err = PTR_ERR(dir);
 		goto err_out;
@@ -180,7 +181,7 @@ __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 
 	INIT_LIST_HEAD(&dbg->fdt_list);
 
-	dir = debugfs_create_dir("out", debugfs_root);
+	dir = debugfs_create_dir("out", liveupdate_debugfs_root);
 	if (IS_ERR(dir))
 		return -ENOMEM;
 
@@ -214,8 +215,8 @@ __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 
 __init int kho_debugfs_init(void)
 {
-	debugfs_root = debugfs_create_dir("kho", NULL);
-	if (IS_ERR(debugfs_root))
+	liveupdate_debugfs_root = debugfs_create_dir("liveupdate", NULL);
+	if (IS_ERR(liveupdate_debugfs_root))
 		return -ENOENT;
 	return 0;
 }
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 8fef414e7e3e..fbb9c6642d19 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -40,4 +40,8 @@ void luo_sysfs_notify(void);
 static inline void luo_sysfs_notify(void) {}
 #endif
 
+#ifdef CONFIG_KEXEC_HANDOVER_DEBUG
+extern struct dentry *liveupdate_debugfs_root;
+#endif
+
 #endif /* _LINUX_LUO_INTERNAL_H */
-- 
2.50.0.727.gbf7dc18ff4-goog


