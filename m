Return-Path: <linux-kernel+bounces-869174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCDDC0736C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809F440565A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD4F33C530;
	Fri, 24 Oct 2025 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="VR+DuFIE"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D8A3385A3
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322215; cv=none; b=DNGtghR9krAz0kWkF6fkC8eNyAohrAKOdb8tmptboUinLoAo4G6zP3cESAqrEPYwIUTGP7HBaGmVPUH3C3/XmKflQ+wif1u3StnOhdtF2zg/GlJJ0bqqX2h14Ev+blP2WWUWSILf71QOVx5MYT+NZqNVgefr34gfnGD4ZE0tsgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322215; c=relaxed/simple;
	bh=47nCxyU4kXn+xfRtbLcXpCvIUy2KTrw5bnGeJZgJkWw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3D6dkdTZesRfX42hDOa72c2bKNbjSeZwuIWCrAWdyXrzCacjOsiNVR5ECY+Ls+YqsnKg9fq71pVVy5PH4PE9uVa92tQ5MQOMl8Ieu9wV8113txL1IWvyppP7MpiHlrrPntHcvToftEfoXMs6PuXVfpcPqrwmRtUdn6qPlTLy6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=VR+DuFIE; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-783fa3af3bdso26857127b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761322212; x=1761927012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0Chij7I5YmPbNPLJtF290sPw75eaI56z9Bpyk1lLtA=;
        b=VR+DuFIE80cOY2YsniD2DX3xG0XoFuioW9AwWzsYivw9JAoDE4e3fVnhyoBIiUAMV7
         kkX6qhuSX1cepInZRg4SbmWEc5605xT51vXKlfHIYygBreCXF8JwcjEyCuGYTeND7zy2
         jBBzCulxBiZZ3q0mLTsk5lnlYQDORdKXG7pOBp+Ba9OmPwQwpvtwA2VPkjJPPHXZZz10
         ARnAqSY67HL7/pDZhKLTKIY2AZm0pvYlYtEpruUQA7eTDeP7ngX5SzB5u/OgbpxyNRGP
         LVRpmGm/tFU3E/Q8HuflZYPTkhsZ3BIxGfT4I3zx9fylgLXKROBVe6b1a1HdwgXh6Jez
         wLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761322212; x=1761927012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0Chij7I5YmPbNPLJtF290sPw75eaI56z9Bpyk1lLtA=;
        b=v78FPud0J90fMCMf7v4UFOc1eAuXC4bRiIlgsMDcj4/hQLbi/8b1QXIiGahzsvIhYs
         hU1i0hc2JnH/AkxMDtCgTjjxY/MgfstWlbqPS0SXjUN+Rqpy/0r7E2+c3/qn4oWT99rv
         JulPw+ZGHSsZX/6ueUN2T5CGNmsG4jmRmzu2oI/wR+47QkjxtcRcx9NNkxhtYmXlxM70
         hnVR2t55PdGaiMXDrP6JweMAhM6pqOAWObheUsg0XmN3599yyIH2oMrZrsi9dxSrEfHH
         CtGgGZRAHT1JphskhVQj8NvlLIlSLE4Twx8stcdD7KEg7g4pPLEeYmXpleaTf666XYj2
         Ttnw==
X-Forwarded-Encrypted: i=1; AJvYcCXiuAG5AgGu+hfwLmQynYHlH03lYYT/b6dN1WlGmn8u6ZVuRoQElgniITP2rVlf+xgpYQ0dQfyt2Yhkz4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/qU/6r4oU8AHy40uBP3eAIHIRzYcvBjdyyPYVRxQjHtM8AaST
	KiVHU98vvCnK5yhD5UY2uzpuAUQrkTiOPCrY/HnpSB0Ozt5Q2v9212nttzFSV7Eg5CU=
X-Gm-Gg: ASbGncsYsTrtKPNX9TIA6/Tdg1wM2UTtBBkupsVGAPGDbl4UU8W5MdQC64B8W01gMFQ
	EGbAqjGvng8lqilCMo2I7XY5zEJex6AoGjSV3/ME8RcfWeVaT9Uu4EJXjDcJ3UytdWdt7FxtYr0
	zHI/7cRziBrUsAMC3QZLYvC1fslOeqQN41w5ZISox4IsCXUoVjeBLe1Iyt9Y0RXVwkPPC5DaNYq
	7qEJrU3VTKcSVVmKZtgUxJ044Tu/Lm16TfZzwo93bX5IcPiyPdMrOfAmHGSDZ+e8Iw5HC9Xkwfw
	5EAONC2Q+hA9qx8PSMISdcT7dpBGUuTENepVAxGBTzVYpCHwRB3djYbJPqymNK4cJfb4UVHQbYN
	WjUvRlh/rcPGQgXW9FQrFObitoSkIQ4/SUL+uOy/dNwYKejPrVixiaR8Mjux4g5ojTlMvKreeHM
	cDNdICpnKEu/izlxD9yehZXiKrXfeXOC2XnmhM9CYeN2qCIbi4a/jw4kAovV+P6ZL0nxcbvXvJD
	RpKn2wNeVJ7RgXL2VUx4E0=
X-Google-Smtp-Source: AGHT+IGrHktoB2+zSyNVNIoeQp5HcQOC7JtCZnm9h30tzfcmrjcwbTqgqHhgYQabiysiaKaamJl5yw==
X-Received: by 2002:a05:690c:dd3:b0:780:fe72:934b with SMTP id 00721157ae682-785e0231474mr22622787b3.48.1761322211974;
        Fri, 24 Oct 2025 09:10:11 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd6edd87sm14099197b3.51.2025.10.24.09.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 09:10:11 -0700 (PDT)
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
Subject: [PATCH v8 7/8] liveupdate: kho: move kho debugfs directory to liveupdate
Date: Fri, 24 Oct 2025 12:10:01 -0400
Message-ID: <20251024161002.747372-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
In-Reply-To: <20251024161002.747372-1-pasha.tatashin@soleen.com>
References: <20251024161002.747372-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, that LUO and KHO both live under kernel/liveupdate, it makes
sense to also move the kho debugfs files to liveupdate/ in order to
keep current and upcoming LUO/KHO features organized.

The old names:
/sys/kernel/debug/kho/out/
/sys/kernel/debug/kho/in/

The new names:
/sys/kernel/debug/liveupdate/kho_out/
/sys/kernel/debug/liveupdate/kho_in/

Also, export the liveupdate_debufs_root, so future LUO selftests,
kexec telemtry, and other users could use it as well.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover_debugfs.c  | 10 +++++-----
 kernel/liveupdate/kexec_handover_internal.h |  2 ++
 tools/testing/selftests/kho/init.c          |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
index 46e9e6c0791f..454b7d34ddc3 100644
--- a/kernel/liveupdate/kexec_handover_debugfs.c
+++ b/kernel/liveupdate/kexec_handover_debugfs.c
@@ -15,7 +15,7 @@
 #include <linux/mm.h>
 #include "kexec_handover_internal.h"
 
-static struct dentry *debugfs_root;
+struct dentry *liveupdate_debugfs_root;
 
 struct fdt_debugfs {
 	struct list_head list;
@@ -118,7 +118,7 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 
 	INIT_LIST_HEAD(&dbg->fdt_list);
 
-	dir = debugfs_create_dir("in", debugfs_root);
+	dir = debugfs_create_dir("kho_in", liveupdate_debugfs_root);
 	if (IS_ERR(dir)) {
 		err = PTR_ERR(dir);
 		goto err_out;
@@ -178,7 +178,7 @@ __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 
 	INIT_LIST_HEAD(&dbg->fdt_list);
 
-	dir = debugfs_create_dir("out", debugfs_root);
+	dir = debugfs_create_dir("kho_out", liveupdate_debugfs_root);
 	if (IS_ERR(dir))
 		return -ENOMEM;
 
@@ -212,8 +212,8 @@ __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 
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
index 17ae101dc6ae..92798346fa5a 100644
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
2.51.1.821.gb6fe4d2222-goog


