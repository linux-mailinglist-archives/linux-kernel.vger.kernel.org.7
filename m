Return-Path: <linux-kernel+bounces-899403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF82C579F3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93688355318
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EC9351FC1;
	Thu, 13 Nov 2025 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlT8q6JQ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1E62FF14F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040073; cv=none; b=FE8g8LOS+JTbp2PH5lsLZJxUw73f3ilOHM3T9lu0zPvRXs9kURPw8tejXJyxDSnDbxjOJr9kx49QfFZn0rLUIlOHgmRqKNz7Nym57QxPphPlsZ/fzYQcNOW3cqndsYqzsdapZ/+BEHKW7JW3Be+ih3ELVfGI2Nyj5VL1Ia/S9dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040073; c=relaxed/simple;
	bh=ad7GeFeZXAyLHvG5YscINIYo8bPB2uMyzmi9KQWWdsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q6rP/MBazveRxPX/8JKZPMUl684oNOr0LoMPJfEcV2odn/83Y9S+lt3JM5I+Ipzo0qjmd8sVSFeP5cAdfcoPR65lhIkGoj9BuZqVDcUX1dYp13nFB41QXvm9Ns/x9CNUDYT0P5hG44QWji0WDRQPOQWcCcZjyH885TxQt9G4bH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlT8q6JQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47777e78ff7so556335e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763040070; x=1763644870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nGN2ZFcnSRaiVO+YExpr2QgITSsJwYh/DPnXCfgL80o=;
        b=ZlT8q6JQVApdYEH+4OiWcq7K8k6naV6Ij5yhUc6Oyzw0k3ZYIXW8/WSJqYQvNPYDHv
         14flxvvU5J5VWB+OsTzsX9sgPwHFw0jpW5BQ4WeU+CMgtHLIzZ8J8LxkhPBR/hFdR2n8
         QFdRqKhKvAaOs9sHjY5/M0wJvw3s1Utn1W22S0Smdighviss1B9g7S8/IWdO6/J/0INL
         NvndztwTrr7PSIlgheVwJ1qRs1UXHDSEQ5sOIxKObpkJWk3zUqTKZQvyYZcNwuBMEQIM
         vHQ11Xu3nJ4d76LXF5ksXMBD7xakRmaYlrAu1ajSYAbPQiciDyyDOeHq49JwmnCTr2w9
         iVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763040070; x=1763644870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGN2ZFcnSRaiVO+YExpr2QgITSsJwYh/DPnXCfgL80o=;
        b=hEnJhVR2fBK/i2aTfI8JxwWSpoNEBodqGdIKDD+M6WwW0NKTQD/DclG/6+6jdiQ7Bz
         Tqz0jam9ZcAcoNosAhcBkZ/300wwXL/ih9LmjYcSoSK8HpzdorGvPXFaF3GAkErcgh3p
         +F18rErWKSLJ55YjpM7g3uNq/23cPx5puQIBut5AH5bDEBrHkNr88KVIqdFodPxzzf6u
         SIjRqC07SNvClHvQFTgMMYl95QdVkpTabk9OxFyloM4XXEw7uJBcv8BWnH+MMHgQgY+E
         eIADVJfvZwRLbSDhVyFwZ8tC5i+I/qB6+rAjFj4fQuutTFuQzoNm+fpBHLXLno4vX5zq
         xydQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2H2SSGhdjQD0Q4hN2Md24XBtLnmv7+eC4lvTiL/yXfbjDG7HdISeVcQsDjTJtRFsPSOILNJ0zHRVqSSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV0BHV0SATrDBQ8hvrhzD3sxWCg/Ba29xntLNz5ueGBolyyZld
	PFHiyycEZBIXMBKqVk40gvCYIJzEHDSZaUQrcDLtsTriQEMknp5gf4hl
X-Gm-Gg: ASbGnctEpT+mRoHEGSMMU5EQVzTNJKFG9L/M4JUJb900jb3sqSf4SNPh9L6gWJ85ZQx
	ef4MqBr4Xg78Di582JSdMChQCTAH7WjsczkBlt/69vIq28ZlL/1DFocsOHK/c8/ll5BMPfSg0Ie
	gzpyOHu+NdCRlkTb0PmMTibeX5Ok5gCiOmvdAPwgIe1r7RzRbRGmOEPPiuOe8sXpde3dZoXXnOA
	8AQXyctWS75OYt8k74OMzdbAZljHrW3ZX7qCjtcBc6RIze8xAOWzhBF52cTBOOAHPCrZtbM1Beb
	g9ixg7/xL+y9jCwGZJR9ab7d3Tj/K92RTSKIlR63FwdAxbMWjan70rhAA9O2zbs54mZCWjHgJ6X
	yL2dfd4cIucF0D6ph4RqVfPxa4FDfJ+hjWrMHEJXFFVV/JiCzD2NkQfFDgmJHhjk1w+GQpglJe/
	SWTSqS9Q==
X-Google-Smtp-Source: AGHT+IHlXVk7YngFwj47tCWravVebZ/U0ARUveuTel5lnc94KY28fXvMntNp7EdpGNvXfNWhmY9jAg==
X-Received: by 2002:a05:600c:3105:b0:477:7a78:3000 with SMTP id 5b1f17b1804b1-477871f4030mr35118405e9.6.1763040069752;
        Thu, 13 Nov 2025 05:21:09 -0800 (PST)
Received: from bhk ([196.239.132.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bcfc687sm19745305e9.10.2025.11.13.05.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 05:21:09 -0800 (PST)
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
Subject: [PATCH v2] selftests/mm/uffd: remove static address usage in shmem_allocate_area()
Date: Thu, 13 Nov 2025 15:20:33 +0100
Message-ID: <20251113142050.108638-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current shmem_allocate_area() implementation uses a hardcoded virtual
base address (BASE_PMD_ADDR) as a hint for mmap() when creating shmem-backed
test areas. This approach is fragile and may fail on systems with ASLR or
different virtual memory layouts, where the chosen address is unavailable.

Replace the static base address with a dynamically reserved address range
obtained via mmap(NULL, ..., PROT_NONE). The memfd-backed areas and their
alias are then mapped into that reserved region using MAP_FIXED, preserving
the original layout and aliasing semantics while avoiding collisions with
unrelated mappings.

This change improves robustness and portability of the test suite without
altering its behavior or coverage.

Suggested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
Testing(Retested):
A diff between running the mm selftests on 6.18-rc5 from before and after
the change show no regression on x86_64 architecture with 32GB DDR5 RAM.

ChangeLog:

Changes from v1:

-Implemented Mike's suggestions to make cleanup code more clear.

Link:https://lore.kernel.org/all/20251111205739.420009-1-mehdi.benhadjkhelifa@gmail.com/

 tools/testing/selftests/mm/uffd-common.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 994fe8c03923..edd02328f77b 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -10,7 +10,6 @@
 uffd_test_ops_t *uffd_test_ops;
 uffd_test_case_ops_t *uffd_test_case_ops;
 
-#define BASE_PMD_ADDR ((void *)(1UL << 30))
 
 /* pthread_mutex_t starts at page offset 0 */
 pthread_mutex_t *area_mutex(char *area, unsigned long nr, uffd_global_test_opts_t *gopts)
@@ -142,30 +141,37 @@ static int shmem_allocate_area(uffd_global_test_opts_t *gopts, void **alloc_area
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
+	p = reserve;
 	p_alias = p;
 	p_alias += bytes;
 	p_alias += hpage_size;  /* Prevent src/dst VMA merge */
 
-	*alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
+	*alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED,
 			   mem_fd, offset);
 	if (*alloc_area == MAP_FAILED) {
 		*alloc_area = NULL;
+		munmap(reserve, region_size);
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
 		*alloc_area = NULL;
+		munmap(reserve, region_size);
+		close(mem_fd);
 		return -errno;
 	}
 	if (area_alias != p_alias)
-- 
2.51.2


