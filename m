Return-Path: <linux-kernel+bounces-896106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B1DC4FA7C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24DA1887837
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767CF3A79A0;
	Tue, 11 Nov 2025 19:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKSJ+k8f"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C5B2C0276
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762891086; cv=none; b=AIJpXRGAcAYFmOpJVgpsCi7zMSGssfj9ty3MkwGKyau0IMgFu3Udn1p+/RCLU4ljNf3mxovYOQrdYCpWt+UvLnijrD13E9HSxPYYs4XUQ6qNaeusI4hxOEc1PPLSbCkToRcETvbBFay3NxufsYqz43JPZKlyqCcNfA2bs8Ml0TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762891086; c=relaxed/simple;
	bh=62sKlTrI0pxAC8MsCjHaTOLDapsx/YJT2jYwGk/YKdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ofiN8OAUb63uBO3eTvSL1HfL9e8MClEvJBOf0oAppQZryMa8c/CN4dca/HUnIIsUMK7g7+lQ6M+J0pgT6aM2jBg5cfgIdL/qgxTjUbNVqBIrTNAoch3fp/qNZkXK8yqONyxEfyDlq83ieiVLvHDGj0CZakWORAtOLs6b72AK5mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKSJ+k8f; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b2cff817aso11026f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762891083; x=1763495883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GgqlcdicdOlvJS4d4lOKT+0mM+91PtUwo1QhcetW41s=;
        b=hKSJ+k8fZGT096+ddl8ISH5rFKI3ErCDbIvcpLCKdO7UPypquJE4vL0daq2cRzzvju
         BLJaTwVRjWzKOA7yfw6aVilpBJfcUTwLL+M8cpvdpAFO9tl2mxn2VwLrDglGyO68OVNS
         4S43WF9B95pGQxA/JVquRvH7QWKGAPwtmhVI9IS207Veeh776ptyiZHDIBWQgkamTccN
         A8nTVex14gCRwgSXmmBZnfDwVGMbxnwVBCOXx+5JQjYK0fHXarx+ypghdZd4fl93OmMj
         9WBoC9+eaykoMZPkPvnOfHeGkYL3ZyzZonhkScHk9UZNpbdq9jpetjiWLbVVxKEi8v4s
         YfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762891083; x=1763495883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgqlcdicdOlvJS4d4lOKT+0mM+91PtUwo1QhcetW41s=;
        b=PXp8PCHmJAZ78KycyzWS6tLLBtcufh+UHl36e2QkMR6YwLrOCxbKOBzRfOUK2U3851
         Pwa/H+9toicZ5yh3V3TxSH/aC1gH9nZThGi9YaS0KQHRVEUaR7yPBVKxnF0k+J5rc0de
         BdX+kL7JMvUT6We5ySxb84/4PZvx0WjJYfzMeL2e7eDbG5JsLuF1lT7OtrP2oQmI/Lws
         R4/ael0CU8p3KSm9iM5GBVqRK60QcNksE1q1rrb4q0F9vy9O2G6mjyY5/sAZ5G71Fo1s
         lcQDQ2vkeQbxwWRKW3ftBhGeAWg/7Mw/yE0O8oFR1tsy+qcZtmXFIxgigB/Zl3H0fu1u
         Y3EA==
X-Forwarded-Encrypted: i=1; AJvYcCWyQGP5DJWidxr1Df6icXtkI0paQStS1VCrM4i4stliX5nq6A3Rt4zW90CLqxZLw4SaBJdEmuPTv2cJWY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIvCeAlx3E+nUN66lVuRKGU3K/9pOcC9JHjlU1wgX/qlJFWacw
	fTv/3m/Ru2WkQEJouQZBH6kKUffYKa6vDtH2jt+zLMHMe9QHftjC6Nv/
X-Gm-Gg: ASbGnctL5nE6GxiXlpB24/aEC5HRnWToTjkLBv0vw/JgKt+J2ZGSkVunKdSh4sZ0QKR
	rXj06wc+9aQQCEH7DT3lmOwWmXgEbshYi0t1lP+0R+FUN2rg4umK8sKOtaMglEsKpFLYzh9f0rQ
	1tOleRix2LWN5YGU0VRgN4DuBe0Ytdrv8rf5yo+gs6EanQz7ZP1ILnV4zG1ZDQBT9GIcu9zeOML
	FZ56f85r1tdYPBs8ewQR7zVs5odaZV9oihH/wJIqk2WjIdNMWi4yt7vASYWCR6VMw0Y89IAWo4Y
	zy3YNItw8eqVmKBedibuSJUa/ia9KsQOydXVxWEt+M3RqtAZ8421XseLjbq0TP1F4npgcCVpCs2
	mHyYewWpfEa4wFbaKRAqnE1ll3hcadlBIa7EcHJSc56M1pw8nmBI0hWxhGSyNlVf57QSNfFlOel
	8P1aXd0jtUH7F1fjrxcYsfr+OnOgk=
X-Google-Smtp-Source: AGHT+IE21rOv3E/xf61ATIbFY5zukw0tfOg7SCkZGn4ZrAkN7p8psKMVSUEEhKXeXEJZn8Yww8oxyA==
X-Received: by 2002:a05:600c:4f54:b0:477:5b01:7d49 with SMTP id 5b1f17b1804b1-477870c9a70mr2783175e9.4.1762891083060;
        Tue, 11 Nov 2025 11:58:03 -0800 (PST)
Received: from bhk ([196.239.144.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce211d8sm405969865e9.11.2025.11.11.11.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:58:02 -0800 (PST)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: akpm@linux-foundation.org,
	peterx@redhat.com,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH] selftests/mm/uffd: remove static address usage in shmem_allocate_area()
Date: Tue, 11 Nov 2025 21:54:27 +0100
Message-ID: <20251111205739.420009-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current shmem_allocate_area() implementation uses a hardcoded virtual
base address(BASE_PMD_ADDR) as a hint for mmap() when creating shmem-backed
test areas. This approach is fragile and may fail on systems with ASLR or
different virtual memory layouts, where the chosen address is unavailable.

Replace the static base address with a dynamically reserved address range
obtained via mmap(NULL, ..., PROT_NONE). The memfd-backed areas and their
alias are then mapped into that reserved region using MAP_FIXED, preserving
the original layout and aliasing semantics while avoiding collisions with
unrelated mappings.

This change improves robustness and portability of the test suite without
altering its behavior or coverage.

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
Testing:
A diff between running the mm selftests on 6.18-rc5 from before and after
the change show no regression on x86_64 architecture with 32GB DDR5 RAM.
 tools/testing/selftests/mm/uffd-common.c | 25 +++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 994fe8c03923..492b21c960bb 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -6,11 +6,11 @@
  */
 
 #include "uffd-common.h"
+#include "asm-generic/mman-common.h"
 
 uffd_test_ops_t *uffd_test_ops;
 uffd_test_case_ops_t *uffd_test_case_ops;
 
-#define BASE_PMD_ADDR ((void *)(1UL << 30))
 
 /* pthread_mutex_t starts at page offset 0 */
 pthread_mutex_t *area_mutex(char *area, unsigned long nr, uffd_global_test_opts_t *gopts)
@@ -142,30 +142,37 @@ static int shmem_allocate_area(uffd_global_test_opts_t *gopts, void **alloc_area
 	unsigned long offset = is_src ? 0 : bytes;
 	char *p = NULL, *p_alias = NULL;
 	int mem_fd = uffd_mem_fd_create(bytes * 2, false);
+	size_t region_size = bytes * 2 + hpage_size;
 
-	/* TODO: clean this up.  Use a static addr is ugly */
-	p = BASE_PMD_ADDR;
-	if (!is_src)
-		/* src map + alias + interleaved hpages */
-		p += 2 * (bytes + hpage_size);
+	void *reserve = mmap(NULL, region_size, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS,
+			-1, 0);
+	if (reserve == MAP_FAILED) {
+		close(mem_fd);
+		return -errno;
+	}
+
+	p = (char *)reserve;
 	p_alias = p;
 	p_alias += bytes;
 	p_alias += hpage_size;  /* Prevent src/dst VMA merge */
 
-	*alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
+	*alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED,
 			   mem_fd, offset);
 	if (*alloc_area == MAP_FAILED) {
+		munmap(reserve, region_size);
 		*alloc_area = NULL;
+		close(mem_fd);
 		return -errno;
 	}
 	if (*alloc_area != p)
 		err("mmap of memfd failed at %p", p);
 
-	area_alias = mmap(p_alias, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
+	area_alias = mmap(p_alias, bytes, PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED,
 			  mem_fd, offset);
 	if (area_alias == MAP_FAILED) {
-		munmap(*alloc_area, bytes);
+		munmap(reserve, region_size);
 		*alloc_area = NULL;
+		close(mem_fd);
 		return -errno;
 	}
 	if (area_alias != p_alias)
-- 
2.51.2


