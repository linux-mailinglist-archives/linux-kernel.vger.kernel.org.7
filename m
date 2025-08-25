Return-Path: <linux-kernel+bounces-785028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DB9B344E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5FEC20329B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D04301464;
	Mon, 25 Aug 2025 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PP6Oil4z"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2F12FD7AA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133894; cv=none; b=nKb825XB2Dl0C9DKzB5kTgBI/272PTl5Nl2BmMOuBlRj065CMLBdJhxnjtXzh61UeF6xttLZ+c2C3NrrfC0bfQAmjzk298Zxt7NOdgpIt5j+6FTDKwU7c9xzekqg0tv7hAIAAcmFV7tRQfJiq4UDSworQ1sZThb8kfcpRvN7yCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133894; c=relaxed/simple;
	bh=Bmr1lemeGceCOOCpFzJX8MKVUDGl1j63D1/ZGEXinik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eb0HnpEsrs/w/IZma6CGzDaIJH1AX/bOgc+UMC8TUe/lMpEAB0LEoPDzmOob1W3cQMwfALdkzIMxsFTg5qlnweENdbMZjFm2+BHynXyM4ucFQNb1pewEaxom676QnRWvQyHBtf0SXdaPO4hDVwO3PQFixzMD3jKnAlS8a3XO9MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PP6Oil4z; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-771e987b4e6so632616b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133892; x=1756738692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPfCdUbCeDFsUsPpoXasJyGte3SUGn6gCviPu/g9Nmk=;
        b=PP6Oil4zIqysVocqfrtBRegOgW7bqAGScXZ39WdNSleRSGQT5j1rVyDUG6h3I5w6GU
         V+hvB9y7OjZ6TG6QHRZDDq4qE8rZIFErtnWzObDG7HwVb7v3s1W52xk+YBRe9JO+ItfH
         e+DNOiMB2s8I1YKLzIAJBdQyKaxaxymkxjngrRKpWVRv2wMrsAGBbCl5w3iX+RgseuEx
         Ya4v9igjCMrUZRGLYcXl/FgVf3bSFJB6RqdJWRRcpEgbFaq5O0jzN0ISZtumiv0fhNrr
         gu61mMVm/w5dlpP7JXZKEV9r/rrHj57w+xCyUC2g+p+7XA1twKtv0wCgvktv09i+59Yx
         pTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133892; x=1756738692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPfCdUbCeDFsUsPpoXasJyGte3SUGn6gCviPu/g9Nmk=;
        b=MT8r1xfDTCVl7zF5urvxOBE83qaqaqWVdG/FCHMw6I0f2H9EYz0f+C/s23vw4QD7iX
         eBAtfWnL/iboCbON54xRiSuU6XsddSe4lA+lWgEhsP6/ij6WMccdZ7gpEfljv0STcl7y
         L++yCtAqnwgV/NnO0fPkeePMmosKAUlsmZxrFJMTSEIp8+p67tLwGlb/rMIybXrqzWGE
         zdKahWl2V+eH2k7MZ0qHHY4f2WyjzNvHoBdoRMmCju08dDaH0ZPIWF7qv05nHdg6rQzG
         VuaH8YGZdoRdfyuo+kuULa6WQ8LfOm5dOYWF552CFLB95cuUcKFthxNKd0tFu4MTJEuh
         MZFA==
X-Gm-Message-State: AOJu0YzwO+h294hAqcRDs6k9IaxilcJaetznWwljQnfbyjuPs08AVqNa
	/e1kxdmcgAosWENgiYVi3aXpGH6TLSPahHnVreYEvY0mgBtFWyuy187k/H/e+QGjtNI=
X-Gm-Gg: ASbGnctl3pcgfvEToAIU44NydQxhVfA6/SGzQwgwd2SUzAWBhwWJvJW3PPIoIUtB7+B
	lTGj0n0R9zXceUz5FkiZjteCQP9mh9tQ0zZAt4APR6bEmBlm8VxMlsGpMcaHo4nwOuQotWGsfZT
	8i0eDhKv2E8s8w8bN2WVy62yf2mAFKqZJupXtbb8HftG7oY92TA409ZA98mpRRKMzy+l4xtiz3a
	dZ3dwljwywBcOFQnQFTlJIz/p32QnlbYR6zodWkT+i+P5EwLkoFhnBMDbyGWQD8W60M1K80K+mB
	f/IfRwx9wWimPQT6XkzKnGpw1rF/9D+fB5Xwg+pmW2RkzcZKdZlslkcWGy91uidTYedgco6630C
	2GcrkBK0Th9EM+pTSrjeM+zPldW/RmCzA3oQARy9SzhhWrMDP1vAFzI3Ef6ppPGNTNRQeRXE=
X-Google-Smtp-Source: AGHT+IGf78VLrhzAmAq66Bf02kLMtH0Tbf7x+AP9+PSfFDcxdQBxs5I/UoUt+CpNFiVAJcIVaIt3dg==
X-Received: by 2002:a05:6a00:13aa:b0:771:edda:1b9c with SMTP id d2e1a72fcca58-771edda1de7mr1932159b3a.14.1756133891940;
        Mon, 25 Aug 2025 07:58:11 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.58.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:58:11 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org,
	linyongting@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [PATCH 3/8] mshare: selftests: Add some helper function for mshare filesystem
Date: Mon, 25 Aug 2025 22:57:14 +0800
Message-Id: <20250825145719.29455-12-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250825145719.29455-1-linyongting@bytedance.com>
References: <20250825145719.29455-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before create basic test cases, we need to have some helper functions
to help setup the tests.

These helper functions consist of:
  Mount and unmount the mshare filesystem
  Create a temporary file which be performed test on it later
  Map and unmap mshare region via the ioctl syscall

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/basic.c |   1 +
 tools/testing/selftests/mshare/util.c  | 123 +++++++++++++++++++++++++
 2 files changed, 124 insertions(+)
 create mode 100644 tools/testing/selftests/mshare/util.c

diff --git a/tools/testing/selftests/mshare/basic.c b/tools/testing/selftests/mshare/basic.c
index 482af948878d..35739b1133f7 100644
--- a/tools/testing/selftests/mshare/basic.c
+++ b/tools/testing/selftests/mshare/basic.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include "../kselftest_harness.h"
+#include "util.c"
 
 TEST(basic)
 {
diff --git a/tools/testing/selftests/mshare/util.c b/tools/testing/selftests/mshare/util.c
new file mode 100644
index 000000000000..75f6ff25aa2c
--- /dev/null
+++ b/tools/testing/selftests/mshare/util.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/msharefs.h>
+#include <stdio.h>
+#include <mntent.h>
+#include <sys/mount.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+/*
+ *  Helper functions for mounting msharefs
+ */
+
+#define MOUNT_POINT "/sys/fs/mshare"
+#define FS_TYPE     "msharefs"
+
+bool is_msharefs_mounted(void)
+{
+	FILE *fp;
+	struct mntent *ent;
+	bool found = false;
+
+	fp = setmntent("/proc/mounts", "r");
+	if (!fp) {
+		perror("setmntent");
+		exit(1);
+	}
+
+	while ((ent = getmntent(fp)) != NULL) {
+		if (strcmp(ent->mnt_dir, MOUNT_POINT) == 0 &&
+			strcmp(ent->mnt_type, FS_TYPE) == 0) {
+			found = true;
+			break;
+		}
+	}
+
+	endmntent(fp);
+	return found;
+}
+
+bool msharefs_premounted;
+
+__attribute__((constructor))
+void mount_sharefs(void)
+{
+	msharefs_premounted = is_msharefs_mounted();
+	if (msharefs_premounted)
+		return;
+
+	if (mount(FS_TYPE, MOUNT_POINT, FS_TYPE, 0, NULL) != 0) {
+		perror("mount");
+		exit(1);
+	}
+}
+
+__attribute__((destructor))
+void umount_sharefs(void)
+{
+	if (!msharefs_premounted && umount(MOUNT_POINT) != 0) {
+		perror("umount");
+		exit(1);
+	}
+}
+
+/*
+ *  Helper functions for mshare files
+ */
+
+#define MSHARE_INFO MOUNT_POINT "/mshare_info"
+#define MSHARE_TEST MOUNT_POINT "/mshare-test-XXXXXX"
+
+size_t mshare_get_info(void)
+{
+	char req[128];
+	size_t size;
+	int fd;
+
+	fd = open(MSHARE_INFO, O_RDONLY);
+	if (fd == -1)
+		return -1;
+
+	read(fd, req, sizeof(req));
+	size = atoll(req);
+	close(fd);
+
+	return size;
+}
+
+int create_mshare_file(char *filename, size_t len)
+{
+	int fd;
+
+	strncpy(filename, MSHARE_TEST, len - 1);
+	fd = mkstemp(filename);
+
+	return fd;
+}
+
+
+int mshare_ioctl_mapping(int fd, size_t size, int flags)
+{
+	struct mshare_create mcreate;
+
+	mcreate.region_offset = 0;
+	mcreate.size = size;
+	mcreate.offset = 0;
+	mcreate.prot = PROT_READ | PROT_WRITE;
+	mcreate.flags = flags;
+	mcreate.fd = -1;
+
+	return ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate);
+}
+
+int mshare_ioctl_munmap(int fd, size_t size)
+{
+	struct mshare_unmap munmap;
+
+	munmap.region_offset = 0;
+	munmap.size = size;
+
+	return ioctl(fd, MSHAREFS_UNMAP, &munmap);
+}
-- 
2.20.1


