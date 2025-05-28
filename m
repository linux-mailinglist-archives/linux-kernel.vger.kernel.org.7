Return-Path: <linux-kernel+bounces-666034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC517AC71BF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 21:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1291A9E3C90
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 19:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6034021FF5B;
	Wed, 28 May 2025 19:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwyxeheJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EE621CC55
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748461972; cv=none; b=FBfpF4489GZYieD4C/pi3nivFYAcl+z797ssPfukT7N+6Jc7TizcridNUSUiPb15QmQ6OCt4jHowGUWUELc2PKGYnkj/pwaSbB9KVbgM9LL0h0JEfst59QEp4WNK5VoewyH9UOVZVht/eBtuaNci9uQwaQqvC8pvAoFVwxHZgdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748461972; c=relaxed/simple;
	bh=31R4xKWKmitjG5RnBTZ6fLS+lQ/xEclC30oq87oWNSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lbq0Lt+pgc6aX8WVSsldTIPbNcPSf27L6AirjWxpConGjtgSrpeevJCT7ULOnXJxFfhHlDaY5ihqjtpunrErOQlvsG8RU9iCJv23R4qlmhjF/yxcAWQDPlWN4mZIqJcXiDxQEvG0Abv0cV9W9q/EiGN7Q+EVs9/oueMEQMOYVG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwyxeheJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748461969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g+3zZ1K31xkV4VckIAeGyggNzsEYBYLzL0Y5N0v1H1Q=;
	b=fwyxeheJQMA0EaOy17upH1oo6MCK5F+yQwEH10psXL75vqClFM/l7R6gITP5G9MmVwinaZ
	VBBrRWHzAltUVd0+1fGPeO46miYSSvJyxq/lHCu8PfhbedrdqV+zvAdGsNuR53hGRqUKJr
	xlfmdCjkTnDK9NxWnGeih6BrQWaCmEI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-oTMprtAgOO-RWPQ_8Dr_tg-1; Wed, 28 May 2025 15:52:47 -0400
X-MC-Unique: oTMprtAgOO-RWPQ_8Dr_tg-1
X-Mimecast-MFC-AGG-ID: oTMprtAgOO-RWPQ_8Dr_tg_1748461966
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so958835e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 12:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748461966; x=1749066766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+3zZ1K31xkV4VckIAeGyggNzsEYBYLzL0Y5N0v1H1Q=;
        b=YMUgetG3TCH8z4eJpoTWvi2+OCTg8c56ZY3cdV+T25D8xgMsHAWrOYi6liQ6sbRL0j
         /3WONtQ1mKqg/Rpj9mGnLZNaPpD/sDMdPWiwkqs15gbqWMftcqzbMdHsZ4CvZsgf6Dwi
         WcXeVMo3lqWvprejQc+HA8qyBl3RG7q/XvhcnGkCatkUZR8mWKAYRsx7t7+HX2aeT7Od
         7yGABE6bCWx6iuBzIFJLJRTJ4aMa00csmsfrn/SK55LnQNekGAUTqXUnK1je7HCLgetj
         p21WrSyxezoHhlY54lcxzVlq+6/An3Mc6bxAKSuPkPPPgJcYd0jOlZ2m/2NG99MlsPXx
         XSSg==
X-Gm-Message-State: AOJu0Yy5cShdK6hyK/iNSuYP1N/Kwva2fnNfpa3jlJRMoHjcXgklLOCD
	X4SPtcODsH7m8Rt0G5GvwP+C7aEulsZtVvPJcegvpJTSSWmVLr7N/io1+dmP1uLskjaUFFHF+jt
	S3rrNAMMa9s6yinA3EfB6DRgLfhm97pP64l2sRTSzy9YJ7/2RuosUd4tfrhEZghcp4YJAciEcat
	M/F3Ob3y49n4O6D6Bl6SCk4YH0dScIguouOABXGd28k6eJHM0K
X-Gm-Gg: ASbGncssgFFsOE07OVnGhARgor1glMfwQm8LIJGYaaKGAy8USaPfjWnIfWIWhsnim/F
	BblQ9FDLFCqNwc1F5dKfQDK7GfsWtAzrzRjDw/GWUVuu2zdVQfqzlZtJhGIY7WsLuK3hc3D2I1x
	1F1s82VI3q89fDtj71eOk09i7p2sV6owTclcIERSaxknMT22RQYUPx4cdkTzeC+8w12UWc9hqxZ
	/FPzG+NaTklZ5gaTKUaCJP/2yI52y76nBgg2xKYjnh3k3u8BDV+1XG8W07Vt5hf8rCfel/Nj2vy
	Huoes0wFNGLhbgqocNzSoMTK6t20BZM0/R0T4g==
X-Received: by 2002:a05:600c:64c6:b0:442:ffa6:d07e with SMTP id 5b1f17b1804b1-44c9141d996mr142856585e9.1.1748461966196;
        Wed, 28 May 2025 12:52:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgw89HXpBys9AtsSs/u0lppq8iYMgrEKAe3lvjHHrT75X3gsbzLMb8QzLWDC7F41Sro+0ENQ==
X-Received: by 2002:a05:600c:64c6:b0:442:ffa6:d07e with SMTP id 5b1f17b1804b1-44c9141d996mr142856365e9.1.1748461965729;
        Wed, 28 May 2025 12:52:45 -0700 (PDT)
Received: from localhost (p57a1aa11.dip0.t-ipconnect.de. [87.161.170.17])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a4eac89d98sm2283367f8f.42.2025.05.28.12.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 12:52:45 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Aishwarya TCV <aishwarya.tcv@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v1] selftests/mm: two fixes for the pfnmap test
Date: Wed, 28 May 2025 21:52:44 +0200
Message-ID: <20250528195244.1182810-1-david@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When unregistering the signal handler, we have to pass SIG_DFL, and
blindly reading from PFN 0 and PFN 1 seems to be problematic on !x86
systems. In particularly, on arm64 tx2 machines where noting resides
at these physical memory locations, we can generate RAS errors.

Let's fix it by scanning /proc/iomem for actual "System RAM".

Reported-by: Ryan Roberts <ryan.roberts@arm.com>
Closes: https://lore.kernel.org/all/232960c2-81db-47ca-a337-38c4bce5f997@arm.com/T/#u
Fixes: 2616b370323a ("selftests/mm: add simple VM_PFNMAP tests based on mmap'ing /dev/mem")
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Tested-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/mm/pfnmap.c | 61 +++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/pfnmap.c b/tools/testing/selftests/mm/pfnmap.c
index 8a9d19b6020c7..866ac023baf5c 100644
--- a/tools/testing/selftests/mm/pfnmap.c
+++ b/tools/testing/selftests/mm/pfnmap.c
@@ -12,6 +12,8 @@
 #include <stdint.h>
 #include <unistd.h>
 #include <errno.h>
+#include <stdio.h>
+#include <ctype.h>
 #include <fcntl.h>
 #include <signal.h>
 #include <setjmp.h>
@@ -43,14 +45,62 @@ static int test_read_access(char *addr, size_t size, size_t pagesize)
 			/* Force a read that the compiler cannot optimize out. */
 			*((volatile char *)(addr + offs));
 	}
-	if (signal(SIGSEGV, signal_handler) == SIG_ERR)
+	if (signal(SIGSEGV, SIG_DFL) == SIG_ERR)
 		return -EINVAL;
 
 	return ret;
 }
 
+static int find_ram_target(off_t *phys_addr,
+		unsigned long long pagesize)
+{
+	unsigned long long start, end;
+	char line[80], *end_ptr;
+	FILE *file;
+
+	/* Search /proc/iomem for the first suitable "System RAM" range. */
+	file = fopen("/proc/iomem", "r");
+	if (!file)
+		return -errno;
+
+	while (fgets(line, sizeof(line), file)) {
+		/* Ignore any child nodes. */
+		if (!isalnum(line[0]))
+			continue;
+
+		if (!strstr(line, "System RAM\n"))
+			continue;
+
+		start = strtoull(line, &end_ptr, 16);
+		/* Skip over the "-" */
+		end_ptr++;
+		/* Make end "exclusive". */
+		end = strtoull(end_ptr, NULL, 16) + 1;
+
+		/* Actual addresses are not exported */
+		if (!start && !end)
+			break;
+
+		/* We need full pages. */
+		start = (start + pagesize - 1) & ~(pagesize - 1);
+		end &= ~(pagesize - 1);
+
+		if (start != (off_t)start)
+			break;
+
+		/* We need two pages. */
+		if (end > start + 2 * pagesize) {
+			fclose(file);
+			*phys_addr = start;
+			return 0;
+		}
+	}
+	return -ENOENT;
+}
+
 FIXTURE(pfnmap)
 {
+	off_t phys_addr;
 	size_t pagesize;
 	int dev_mem_fd;
 	char *addr1;
@@ -63,14 +113,17 @@ FIXTURE_SETUP(pfnmap)
 {
 	self->pagesize = getpagesize();
 
+	/* We'll require two physical pages throughout our tests ... */
+	if (find_ram_target(&self->phys_addr, self->pagesize))
+		SKIP(return, "Cannot find ram target in '/proc/iomem'\n");
+
 	self->dev_mem_fd = open("/dev/mem", O_RDONLY);
 	if (self->dev_mem_fd < 0)
 		SKIP(return, "Cannot open '/dev/mem'\n");
 
-	/* We'll require the first two pages throughout our tests ... */
 	self->size1 = self->pagesize * 2;
 	self->addr1 = mmap(NULL, self->size1, PROT_READ, MAP_SHARED,
-			   self->dev_mem_fd, 0);
+			   self->dev_mem_fd, self->phys_addr);
 	if (self->addr1 == MAP_FAILED)
 		SKIP(return, "Cannot mmap '/dev/mem'\n");
 
@@ -129,7 +182,7 @@ TEST_F(pfnmap, munmap_split)
 	 */
 	self->size2 = self->pagesize;
 	self->addr2 = mmap(NULL, self->pagesize, PROT_READ, MAP_SHARED,
-			   self->dev_mem_fd, 0);
+			   self->dev_mem_fd, self->phys_addr);
 	ASSERT_NE(self->addr2, MAP_FAILED);
 }
 
-- 
2.49.0


