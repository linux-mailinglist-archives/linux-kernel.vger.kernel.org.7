Return-Path: <linux-kernel+bounces-862169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E009BF495E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 06:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E18F18C4F20
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 04:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E59244669;
	Tue, 21 Oct 2025 04:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNrO+JFQ"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E268C33F3
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 04:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761020449; cv=none; b=bSATB89Ukr2IAeTRkYe8ryPF6htqNG88cUQ7rm7VLlvK3QFZ/p6KTrAOQBGa0NCV+azU7QDS+1pUlTiH+xDaGrX5/5YLxXqlI01RLTxhbx2tKBlnfiLc8CGC10OgAqbtZ56lXEMnghVoc/uLNt/RcbuvbSXIshMRl9HkmTPKdcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761020449; c=relaxed/simple;
	bh=54IdDzBB1F8JHTZwkrbY0+nkyH6X9WaOpkcrR10tcBY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KkX7BRT01EBFSP8n7wtUnn7dj74KcK94wUvqez+YG3kvdhAKhCB4osnwv66+CtZCVWFfr1JpzbctdvbL2CAaSuGmi8HmEbBRpQs2aWvBzXuudHEFQiSjx19kTCR5WUGDWpBf9Hss5M+aH5ALg+Dyyc5DhJ6abT+MLT4sXzOW6Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNrO+JFQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-26a0a694ea8so37099275ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761020447; x=1761625247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SRLdP4GmC8TAaehpYwLWmY0fXaXzRogSZM1ApFlMens=;
        b=aNrO+JFQJwug/LAS2SNfun1J0Oo0tsKhiEwpr+O2q/EBir7fDU95d6XxUiGFMDFKpd
         JlOeEWFYBfHtjDCp/vNaXAVgV8m8E9iJUrU382p2A19e98/SpIVZHusN/TT5m3qmmc7p
         yoPnq6V6yZr0aWQi4B/st3B4nRlmIVrIdo5uEp1mdZB0+b5pBDdzffOoM3/gvje9btHV
         snjMvoM0vYUZ6r2dK9GUyZk0zYGwFvaeWCYuDLBxoi726pfK7r0ZAsohijVKdhGhQtDM
         xTrTY5Wf8Fb94VThqLOYgNZkI4atjQfnv+Qc63bkexzNUHxVkkQ+wyKbSMD/SNCC2MOZ
         ethA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761020447; x=1761625247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SRLdP4GmC8TAaehpYwLWmY0fXaXzRogSZM1ApFlMens=;
        b=cJP6NcPACviuKqaWcJ1OLCnHn9CrIsqcLNxsQURgNU9WS8DblT/CZoAgZLL3hFlNoJ
         1s3U+RKTc1lKn+3o+N4noDOZwkl3Rc+ySuFhZhz5+jG5usLKHk2KlxwGLJgP3dqSJSER
         94RgrSn5UKjFroeICqW8U3bmnv4W2PhDREjVDRxmhBCZtjLm9upnUpNYmsdbpoEUNiZ7
         7Y7vNQgv77tM+OAHK874a72YamzdqBApWbw6uRu5aI1WIEeFFxBqMV9DIsqG1avdl8Hi
         9yuhpMXGSue/uMg/bY9mqwCDraDWRt8kvs+HIxpZOC/vfpiKngHJQ/NZH4mB4xINH1qd
         gleg==
X-Forwarded-Encrypted: i=1; AJvYcCVrWSSHvHXzxFgWjDEpStqlKrimRaaemtnBxQFkK4JHV95NhVojpfINeevaAfilFUigy84I5pvB7LgJvCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjCsAQmmkIbV0sYaVFiDmB9FNUV6DzCr9ON0qAyIF0DAXpefH0
	Ri67VRU4X8rzHltFquGZjEFfghN+GBtikyfzcx3JkD0/lJhybtCpcbdB
X-Gm-Gg: ASbGncv8lGBf8DYFi37bVC2jVgXauTkG/epMBDZijICSIlbJCRNMI1Z162lueqn8X5J
	3SHWMPUCyYTPO3nu5OG9hsEcWCVFwvbIgx7ZKml0SfMKb//f6qASkDgUDE6owiiajEISgCdMSrZ
	6sWdfe17LClAMnuSIo4XGXJHSNSuhWQRHEjtE4JlXbuL4vjREphay+7bTc7STs2Z5aYBWDe0Etl
	s0tMS0b1qtuuMvzR3DXGG46d/205YZVOc8pl7nnZMw6id5fRL0YOQfa8Fzn0CyG21w58EyA0GnN
	jc1HGA75FCOUGAx3HO7C5mwHKpalGlxtBtttE2Y3TGoLNr/cwTR0NaV+ypd9cog44EZ5gmI551Q
	5bf7/rBZPjjjTWTtQJAHALGY2pcnH5iYk0g6IRz7dY1HWsVXKUx6jiDgBHvIJVxgVKhNyskULBj
	kKRf/v3RzHQM7NzHQQSPLErVApKFZfhowTKiCG2gt283g=
X-Google-Smtp-Source: AGHT+IGuMYHt7WIQD1fK0EiihxrlnrbJ5cDcN1SmyPvVx87IncetjCE6sVwVUYILV4vleroj1LiXDQ==
X-Received: by 2002:a17:902:ce12:b0:27e:ec72:f62 with SMTP id d9443c01a7336-290c9c89b06mr180684945ad.6.1761020446906;
        Mon, 20 Oct 2025 21:20:46 -0700 (PDT)
Received: from Barrys-MBP.hub ([47.72.128.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fde15sm96162725ad.84.2025.10.20.21.20.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Oct 2025 21:20:46 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	sumit.semwal@linaro.org
Cc: 21cnbao@gmail.com,
	Brian.Starkey@arm.com,
	benjamin.gaignard@collabora.com,
	christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	jstultz@google.com,
	tjmercier@google.com,
	v-songbaohua@oppo.com,
	zhengtangquan@oppo.com
Subject: [PATCH v2] dma-buf: system_heap: use larger contiguous mappings instead of per-page mmap
Date: Tue, 21 Oct 2025 17:20:22 +1300
Message-Id: <20251021042022.47919-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

We can allocate high-order pages, but mapping them one by
one is inefficient. This patch changes the code to map
as large a chunk as possible. The code looks somewhat
complicated mainly because supporting mmap with a
non-zero offset is a bit tricky.

Using the micro-benchmark below, we see that mmap becomes
3.5X faster:

  #include <stdio.h>
  #include <fcntl.h>
  #include <linux/dma-heap.h>
  #include <sys/ioctl.h>
  #include <sys/mman.h>
  #include <time.h>
  #include <unistd.h>
  #include <stdlib.h>

  #define SIZE   (512UL * 1024 * 1024)
  #define PAGE   4096
  #define STRIDE (PAGE/sizeof(int))
  #define PAGES  (SIZE/PAGE)

  int main(void) {
      int heap = open("/dev/dma_heap/system", O_RDONLY);
      struct dma_heap_allocation_data d =
            { .len = SIZE, .fd_flags = O_RDWR|O_CLOEXEC };
      ioctl(heap, DMA_HEAP_IOCTL_ALLOC, &d);

      struct timespec t0, t1;
      clock_gettime(CLOCK_MONOTONIC, &t0);
      int *p = mmap(NULL, SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, d.fd, 0);
      clock_gettime(CLOCK_MONOTONIC, &t1);

      for (int i = 0; i < PAGES; i++) p[i*STRIDE] = i;
      for (int i = 0; i < PAGES; i++)
          if (p[i*STRIDE] != i) {
              fprintf(stderr, "mismatch at page %d\n", i);
              exit(1);
          }

      long ns = (t1.tv_sec-t0.tv_sec)*1000000000L +
                (t1.tv_nsec-t0.tv_nsec);
      printf("mmap 512MB took %.3f us, verify OK\n", ns/1000.0);
      return 0;
  }

W/ patch:

~ # ./a.out
mmap 512MB took 200266.000 us, verify OK
~ # ./a.out
mmap 512MB took 198151.000 us, verify OK
~ # ./a.out
mmap 512MB took 197069.000 us, verify OK
~ # ./a.out
mmap 512MB took 196781.000 us, verify OK
~ # ./a.out
mmap 512MB took 198102.000 us, verify OK
~ # ./a.out
mmap 512MB took 195552.000 us, verify OK

W/o patch:

~ # ./a.out
mmap 512MB took 6987470.000 us, verify OK
~ # ./a.out
mmap 512MB took 6970739.000 us, verify OK
~ # ./a.out
mmap 512MB took 6984383.000 us, verify OK
~ # ./a.out
mmap 512MB took 6971311.000 us, verify OK
~ # ./a.out
mmap 512MB took 6991680.000 us, verify OK

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Acked-by: John Stultz <jstultz@google.com>
---
 -v2: collect John's ack. thanks!

 drivers/dma-buf/heaps/system_heap.c | 33 +++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index bbe7881f1360..4c782fe33fd4 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -186,20 +186,35 @@ static int system_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
 	struct system_heap_buffer *buffer = dmabuf->priv;
 	struct sg_table *table = &buffer->sg_table;
 	unsigned long addr = vma->vm_start;
-	struct sg_page_iter piter;
-	int ret;
+	unsigned long pgoff = vma->vm_pgoff;
+	struct scatterlist *sg;
+	int i, ret;
+
+	for_each_sgtable_sg(table, sg, i) {
+		unsigned long n = sg->length >> PAGE_SHIFT;
 
-	for_each_sgtable_page(table, &piter, vma->vm_pgoff) {
-		struct page *page = sg_page_iter_page(&piter);
+		if (pgoff < n)
+			break;
+		pgoff -= n;
+	}
+
+	for (; sg && addr < vma->vm_end; sg = sg_next(sg)) {
+		unsigned long n = (sg->length >> PAGE_SHIFT) - pgoff;
+		struct page *page = sg_page(sg) + pgoff;
+		unsigned long size = n << PAGE_SHIFT;
+
+		if (addr + size > vma->vm_end)
+			size = vma->vm_end - addr;
 
-		ret = remap_pfn_range(vma, addr, page_to_pfn(page), PAGE_SIZE,
-				      vma->vm_page_prot);
+		ret = remap_pfn_range(vma, addr, page_to_pfn(page),
+				size, vma->vm_page_prot);
 		if (ret)
 			return ret;
-		addr += PAGE_SIZE;
-		if (addr >= vma->vm_end)
-			return 0;
+
+		addr += size;
+		pgoff = 0;
 	}
+
 	return 0;
 }
 
-- 
2.39.3 (Apple Git-146)


