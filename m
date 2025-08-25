Return-Path: <linux-kernel+bounces-785020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8786CB344CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0088189B374
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE2D2FB998;
	Mon, 25 Aug 2025 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O8mYL8LX"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C252FE567
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133878; cv=none; b=dKHfpJkJPzsUrYNSZ08UzZhAD05mCCdbdUgKiKiiZR3NAk3N//PsMSW/Fhk0CNvN2r6f/JDFyYP1gZAo10n4BfweLAK9CMY4/WFnGJ8izg7kNYfi0lWZRakKUObYjJ3JNXCR/fdGhd9jTAHTNNDCP7ni90a5g36f2oOvqKlvj/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133878; c=relaxed/simple;
	bh=yEaGdYH4e/wFbvvvHuP3fH2igWfLZ3eT3LgaOFr8VUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f4IOcN2srHebmHe7qggU8y1v0OXUjs9szXkw1Y+xd6G0Pie03rdDk4E4fkyBeKsNWXGXkpnIQYxeF91S61NM8VapxKYu93/LKH7bxTeAbiBAavzNy//OvTecx6vSme47Bnozb9jPCwF9Vb/iPLuO1BGjkXniTgdDtEUVFz9nzB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=O8mYL8LX; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-76e434a0118so5252445b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133877; x=1756738677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oaQVHpJSfD6iISTq4Fs9qiBmXO38S9TJM+RHgKSb1U=;
        b=O8mYL8LXqFRkWKWbKlTiI4uC7j012+kxI5MYK2n3fWeH7BrsszVx8mbnx8/v8/IIJg
         GpP4rqaogSPOPvrWyXC4w/bKMLr3HgMQrr9B2iDp/RQemYjEttII2TkiObWRHUXKbg8C
         efGO7H4eMv9PPwLGviIb+gIRnD0pDRmpQmm5CJh+vKHbZtSUI23/3QMzUQ8D7Akc7rSP
         Rp01VJ89RArskAg7c3wjvd0ME9lmGr8rN5LajFX0NLqajnYoPe6ktAcXEi1F4CQkkI+d
         MTpgsjH4B3ndq43xOFEiSzkjNuGIWxEjadWRrMleYjZjTR7O2pArlHNnu+HfJdjfPLp7
         mMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133877; x=1756738677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oaQVHpJSfD6iISTq4Fs9qiBmXO38S9TJM+RHgKSb1U=;
        b=XjSIo0Buqj/CStLEvgnodO0CKaPQt3LhpXULLhBiJOUbU3eBsnDES9t6RSyyIRPZQC
         mXZn81Wt6olTK4x3U7twyUy8HnpRwzDqNxZ+e9M/hhCD/EvLeELZyITrkEbilT4gyOFH
         V9TdmkPAlBAWVqs0ToB2U9VDShTAyBUdFS2G+J/3lKeWZs7u/CGsHveTDLhM0TPnKzE3
         J3tqWWoDe/1S3Z/5KgAbMGLuVk2fMJ+Vvy4/rhCePgPwRYipACDI9kXnWKvvmfKL2pqd
         cGkfqFP/1+oHp+NxgXhtGprLHJ6U1gONx3ZDizX3hQvF94NsoteNoInN5+FHrEJhC/Dz
         I2eA==
X-Gm-Message-State: AOJu0YzCuOsp5p0/63c0zkW3W9+3C8fp28FHCaj1rbcJq2ni+rpxhN2u
	kRvpP4NqzsEOI1tejFYCTUQj8A9coA+yn5Ywy2r1+8leDXzpuSK01I3vM7oEjnyrEcg=
X-Gm-Gg: ASbGncttse8yL7daDTCYAbp5Avz5Zee1su3KoebRDBNVovZ8whp9wcuCIEF+COx0r02
	RT5o3VfyF4y2shY3YhJigMHENvwSsXKgSo3lLTNPECzmGUpYck1kW/p0xiDSKwqX70qFLFxteMB
	TD+jnVGM6SJ3cAySMkCW2zggw4agTwtiGihzd4m/rHLgq3ei3sneZgNbjzDsvqhWTcudQDqFTS2
	rwKTT9IMMT/bdVmuf/KxiujlEDkcHcrWS3yAwQau08ODTts724SMmDd8cRNFGxQXyvUUb5HlYAh
	1DW535M8hZadxY/ffh+HW79qix5jAFh6+VEAmrHtAaooXOZiEi4GJfoCvr6/V9l87gV2gnEwwEB
	3E/IgnNIT1pSd4ezrYy9PAVxFZcvjTouZwXKTtPawuTUjo6EIbGQYazwiXtMj
X-Google-Smtp-Source: AGHT+IEJgruw8paBQDNIopG839sPtxHYbVWhGydUTRYfwwhqmDIT8wYlFvzCj4LXmvnvNxNKmNvDrA==
X-Received: by 2002:a05:6a00:3d96:b0:770:3d67:82b1 with SMTP id d2e1a72fcca58-7703d678890mr13756054b3a.32.1756133876538;
        Mon, 25 Aug 2025 07:57:56 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.57.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:57:56 -0700 (PDT)
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
Date: Mon, 25 Aug 2025 22:57:10 +0800
Message-Id: <20250825145719.29455-8-linyongting@bytedance.com>
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


