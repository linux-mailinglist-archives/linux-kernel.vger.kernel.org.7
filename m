Return-Path: <linux-kernel+bounces-785034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C34B344F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F015017A6C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD6B303C81;
	Mon, 25 Aug 2025 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ejlUEnDp"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5F12FDC2F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133909; cv=none; b=Q5Q/cxvx22uP1bGyZsakCBQYyu033sTdZpi+Z+6XOqohI3bA6k+rzj9iBwNIal/WqWhTPTN9uvvXVz0q/5crK8Wc9DRCiYlwGtp7FhgsQfCMDL6JDrWp0m5BtIlWbXcxXD5yRynUmPx+9Ilj9kNWZRuDPg4bm9OhV3n42Ew+3x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133909; c=relaxed/simple;
	bh=yEaGdYH4e/wFbvvvHuP3fH2igWfLZ3eT3LgaOFr8VUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I6KNt/TMWZiDsKynX36ERQ2S/uE9OXVdt5y9xLSuuIZy4UhifHvis0YIV7dm/y9PPO99FPAOfgUuI9S5fM+t27aOzVW+7Jd0uGCygUVHkN8oAvH/sAhxQbi1+leJHM9Aw0O4sR2DymtjYVF/LjYeSyDhsLE7Q0sfGyesYR/vZ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ejlUEnDp; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso1289535b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133907; x=1756738707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oaQVHpJSfD6iISTq4Fs9qiBmXO38S9TJM+RHgKSb1U=;
        b=ejlUEnDpGvKxqkLi6jsY+aejI9mL9LBsFOmljmYXEGPjQiJv7gwjcU7CdepHMq7S1F
         OBfLCMcsXN2k3BKuTkJaXqK7RuWO8IR8WZ8mlAbTcTwhh9TBGC14KqQECfKgqV/0MfQA
         V8w/y7VgKW3LIc8XNeyLV2ac+777HhhuVbdewGin00zqRl71dwE/9B11GADUrKwAP/B8
         KiBYCFSd9LLen3zSDW3VK1kT4V4BTX7lSBOnGdJE/9kZnmAJL/B/n26Tg3yoSB0N/3dK
         vGgnluev39z5q3cAVRAk1rdyvVwwAtZbXiA4hHYmK3xR6T+LJ5gH51OISNrml70S+usB
         f10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133907; x=1756738707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oaQVHpJSfD6iISTq4Fs9qiBmXO38S9TJM+RHgKSb1U=;
        b=Cz5gRFKtfBMEgJ7ivrhPtGxPjciZgJYUr3+FQfKyRewkow+1Fybw/TM5qYaBIWKned
         4Md9Ok2yK+8PWWJBEkR/94KeUzOAtWQo0KL8UnGPLT4ez3mKBe6CHy5qGzIIrubn8D3t
         PYNNtO8pJZjyaazpZkhWwMpVGx0jxupROQYlNY6aQiRoc1K9/2frCHYVGZDF4Bg1bMsU
         o2GL6+TY56vO+pu42jNwW4YnvrXmb1QXDxqBoB1sqaZkar6bDzYdTi8iHV6NmV/J0Nio
         JnH+j/HoqAN63Pp2iSlS21d8DxOEmZBWrc+N+PnSTdAPLmqGTU4KjVfgecUvVIPlI3dh
         ljWA==
X-Gm-Message-State: AOJu0Yx8A02L0xu4LIplXZ7it1rp9QCaKg486DibOFsZYqJHl2Ph5LV5
	nK0NsfgHGOUJbR+K444eCZCUnTjlPo2Xeghgv0tUAWcmocl50RLBx/tRghUJ7V0x9wXbtOL8YGf
	E6hPhRjAi/w==
X-Gm-Gg: ASbGncuoIHqP3MP6Bhrb2tuPEOOzOEf2lD9heITOWPlBYPkiPpo0VqwhnWV0Bs4bV1O
	Y5ndpBNj7v0XMRYd66vVfdYD8fPxCEyv1JHotH9zRFVRNzO201NNfi13x4uRc8EPEs0h9TNzLau
	YdEnYii876pr+tyQ1ihXJV/iz6RS2F78+nOlwzX6c7DerH/Y40wDYoeSwS4TYC+BFAswKwSf51n
	u/WYMm07ykg9pAs5Uwj57tmBJcr4Wb8Qy66knjT0eAe6piY9cKSGpA0ACX6n1PkPU6i9QsNyexk
	fWEV8ReBtwD0dtDuu/EY8XVrcnGrrRzf9aFTiBTNqxo6suLQywXY4DvXd11szDtJPy6yhKboxtC
	Wd7EoICMs2EIGLF3o+gXD+MwJXPr/lTAfU5CO7F4voh4IgKMUL950asYG5+5L
X-Google-Smtp-Source: AGHT+IHxsFJR0AtpeGh+fp7Byt8A1eU4CZaqq20uybUbJisFaBFvzm4Vv3lYQ+kX08WwI2ansJPWUw==
X-Received: by 2002:a05:6a00:1399:b0:770:5544:dc0c with SMTP id d2e1a72fcca58-77055544aabmr8161529b3a.32.1756133907310;
        Mon, 25 Aug 2025 07:58:27 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.58.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:58:26 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org,
	linyongting@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [PATCH 7/8] mshare: selftests: Add test case to demostrate the swaping of mshare memory
Date: Mon, 25 Aug 2025 22:57:18 +0800
Message-Id: <20250825145719.29455-16-linyongting@bytedance.com>
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

This case is quit simple by using madvise(MADV_PAGEOUT), but for verifying
the memory size of being swaped, we need to setup the memcg and attach test
process to this memcg before perform the test.

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/Makefile |  2 +-
 tools/testing/selftests/mshare/memory.c | 71 +++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/mshare/memory.c

diff --git a/tools/testing/selftests/mshare/Makefile b/tools/testing/selftests/mshare/Makefile
index 651658d091c5..b0418b8c30f2 100644
--- a/tools/testing/selftests/mshare/Makefile
+++ b/tools/testing/selftests/mshare/Makefile
@@ -2,6 +2,6 @@
 
 CFLAGS = $(KHDR_INCLUDES) -Wall -g -O2
 
-TEST_GEN_PROGS := basic
+TEST_GEN_PROGS := basic memory
 
 include ../lib.mk
diff --git a/tools/testing/selftests/mshare/memory.c b/tools/testing/selftests/mshare/memory.c
new file mode 100644
index 000000000000..7754c0e33506
--- /dev/null
+++ b/tools/testing/selftests/mshare/memory.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/mman.h>
+
+#include "../kselftest_harness.h"
+#include "util.c"
+
+#define GB(x) ((x) * (1UL << 30))
+
+FIXTURE(memory)
+{
+	char filename[128];
+	int fd;
+
+	char cgroup[128];
+
+	void *addr;
+	size_t allocate_size;
+};
+
+FIXTURE_SETUP(memory)
+{
+	ASSERT_NE(create_mshare_test_cgroup(self->cgroup, sizeof(self->cgroup)), -1);
+
+	attach_to_cgroup(self->cgroup);
+
+	self->allocate_size = mshare_get_info();
+	self->fd = create_mshare_file(self->filename, sizeof(self->filename));
+	ASSERT_NE(self->fd, -1);
+	ASSERT_NE(ftruncate(self->fd, self->allocate_size), -1);
+
+	ASSERT_NE(mshare_ioctl_mapping(self->fd, self->allocate_size,
+				MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED),
+			-1);
+	self->addr = mmap(NULL, self->allocate_size, PROT_READ | PROT_WRITE,
+						MAP_SHARED, self->fd, 0);
+	ASSERT_NE(self->addr, MAP_FAILED);
+}
+
+FIXTURE_TEARDOWN(memory)
+{
+	ASSERT_NE(munmap(self->addr, self->allocate_size), -1);
+	close(self->fd);
+
+	ASSERT_NE(unlink(self->filename), -1);
+	dettach_from_cgroup(self->cgroup);
+
+	ASSERT_NE(remove_cgroup(self->cgroup), -1);
+}
+
+TEST_F(memory, swap)
+{
+	size_t swap_size;
+
+	/* touch 1G memory */
+	memset(self->addr, 0x01, GB(1));
+
+	/* force to reclaim the memory of mshare */
+	ASSERT_NE(madvise(self->addr, GB(1), MADV_PAGEOUT), -1);
+
+	swap_size = read_swap_from_cgroup(self->cgroup);
+	ASSERT_NE(swap_size, -1);
+
+	/* convert to bytes */
+	swap_size *= 4096;
+
+	/* allow an error of 10% */
+	ASSERT_GT(swap_size, GB(1) * 9 / 10);
+}
+
+TEST_HARNESS_MAIN
-- 
2.20.1


