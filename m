Return-Path: <linux-kernel+bounces-883883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83146C2EA69
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 01:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26D7188B058
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 00:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97F41F4168;
	Tue,  4 Nov 2025 00:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6T8Bx66"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BA328DB3
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 00:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762216796; cv=none; b=G89Fgix+a9fJHEHikLYmA1ZpL0Ja/Uc2jnquW4qZFQ2a1ymsyLrQV5v9taux6TqbAabowHaQy++bsuRQJd4B+qyMz5yyCfeDrrZ/btGvwDGlovRVi6p3LVrS2mxjGJnhyRj/Nq6fdfWYGJSrgH9h+p4jL8/5Hq0tQLnhrssGYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762216796; c=relaxed/simple;
	bh=iW93nzX0z9zZaTNYKnzw3iwZ7cMIZimkgtTMI3k4PDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JvDOc6EyWdDjZnoLmtuGywCYKkCjNplV6IRe+oabVSiORTrqxcOHDfxtbgGNY0MtEtqHJDb6t/3+GT2aiXWPsE1+5ozdJsG9AAtmt52vkkcC5yk6LEzfd1z6+hjrRbqXJ7UdCR0pb3lZI4tev5/tTUzlFnIn/xwyzoUFWHe87O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6T8Bx66; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so5030251b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 16:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762216794; x=1762821594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iam28yxbxtTcQIZpnqIWn4zgf5SETAhbeipE7iPuLHg=;
        b=B6T8Bx66YAf7UEFd4y1SLti4GZEEgNMtaB+qQ14iayZoXimw+/s1/tPicRSCrzC/KH
         tVpWQgYTZ9xy1v8BdePglAxrOFl0ey1TdQBCNnXvkqw6JkaVYuJGCIbxARvYVUeQn2cc
         +Y9bQVkhefKVGslc/xLFgBOMbKjLxcbBN0Kdpvv2eA2jEG47eRGpjZRkynWz75GMZPCi
         4d+//s3c8o/WhggT91M5FmHCFe4y6BRNbdfyVTp67BtWRyiLK/3y8ibPuVl1qCaRsgSB
         zmA8INzIBGQR2N8Pj9dH5H5RxcF49nrLLh2PRJSJ/Lcz2WLeggJ+j75DTlMIyOmHDzt8
         yPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762216794; x=1762821594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iam28yxbxtTcQIZpnqIWn4zgf5SETAhbeipE7iPuLHg=;
        b=YLnTpLCdKxVDT5aZCGU415EkZq4LGI8D7aFcqfhcJaCpY8QKI1E6tNB9vX7KmPkECS
         nq8WRD++azOhQDhY4EE4rwbVPfLoNVvuA8i2RT2J1FYEgRIAQjk7WNvjfV0JGMJupiyI
         qOhl5s12IiSasIIxndOPVEvSJWE7bq08VP8Rzl4zrY4JslArxpL7gXxJIWsUt6V7vJS/
         ZEK9ZBZFpXSM3xClF4bw7KlviSNPdIPIyk9hLssg3Oa8xEo8NrbD+wIuEm/By8ubzXHl
         ea1XosydLUEqX6OchU55alca5cN+Wm+3YvExJgGyytdC8hxD97oHqiIv9wN0Z88zTHqg
         rdcA==
X-Forwarded-Encrypted: i=1; AJvYcCUo9Xs6SfQeHcswj3j4RegHtsMdv/2CSQV33s1xmBebI8RO7pej7f8TN4/VOCMv/0W7GfO7Ilq3iRfxKdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YziRHgUJE7zOeuV+8YyZ3RrQqLLT3IN8HdbxMmm3om+Hqz4oYzf
	8zzeNSxfickfY3LrKDj5053vWGi7WsgT7t4yU12xDvP3GyeanzSCMQla
X-Gm-Gg: ASbGnctvpo4gWUvE3ZhBtnsIDwjgLj46l0UWDmfZhgXz4nnRkipQ8PHF/DU7ap8nKqm
	4Yn//HcQeCqqhYEgO/wZwoleMAP2XSAOkJwKG8l9p0pzdKPtTZd/1VLcCCXY3Ugvr4aC4fjdNT8
	Y/X4qKSSC7u2a8KWTVe2SZ/EiovsAxw5bVjUobAid8K3i3NF7Pkyjn3Gf9XOmzzh0JiPALhdEyU
	twb5/zhR3Y6EOOzdhazLqS1vuD7zpU28pJnSXgPXVLOQ+QmkohfsQLWWBt7KJZeKOCCx9MK8r+v
	aLSzh0C6umuEizg2NCjZ3S23qgXM7JuBqH9RiIksVwg2cyB1vlMvZnLMqNPnKEE7Bx++yXNmup+
	6ITjjoH/4ApLcT/rwVdpZVx7wHcXvOt3oFVjjm5JHDwakxipr9cDCSerDEIk6bo7EzL/TIfxf7Y
	4A8feLvTDM0JlWmBsF7ts1wH9jaw==
X-Google-Smtp-Source: AGHT+IFJbftbMdXgKxfl5nxnplvx3Z6+G0scrRMZ2oVSB3QoWsoHMMWseKqIUdRWNIb6rfsyQvsVRA==
X-Received: by 2002:a05:6a21:6d8d:b0:2cb:519b:33fe with SMTP id adf61e73a8af0-34e2a1a60bemr1475870637.21.1762216793733;
        Mon, 03 Nov 2025 16:39:53 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:30f4:78b7:7acf:47d9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd634081dsm666661b3a.58.2025.11.03.16.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 16:39:52 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: akinobu.mita@gmail.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	rppt@kernel.org
Subject: [PATCH] memblock: fix memblock_estimated_nr_free_pages() for soft-reserved memory
Date: Tue,  4 Nov 2025 09:39:21 +0900
Message-ID: <20251104003921.9707-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memblock_estimated_nr_free_pages() returns the difference between the total
size of the "memory" memblock type and the "reserved" memblock type.

The "soft-reserved" memory regions are added to the "reserved" memblock
type, but not to the "memory" memblock type. Therefore,
memblock_estimated_nr_free_pages() may return a smaller value than
expected, or if it underflows, an extremely large value.

/proc/sys/kernel/threads-max is determined by the value of
memblock_estimated_nr_free_pages().  This issue was discovered on machines
with CXL memory because kernel.threads-max was either smaller than expected
or extremely large for the installed DRAM size.

This fixes the issue by improving the accuracy of
memblock_estimated_nr_free_pages() by subtracting only the overlapping size
of regions with "memory" and "reserved" memblock types.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 mm/memblock.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index e23e16618e9b..af014fa10a44 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1812,6 +1812,22 @@ phys_addr_t __init_memblock memblock_reserved_kern_size(phys_addr_t limit, int n
 	return total;
 }
 
+static phys_addr_t __init memblock_addrs_overlap_size(phys_addr_t base1, phys_addr_t size1,
+		phys_addr_t base2, phys_addr_t size2)
+{
+	phys_addr_t start, end;
+
+	if (!memblock_addrs_overlap(base1, size1, base2, size2))
+		return 0;
+
+	memblock_cap_size(base1, &size1);
+	memblock_cap_size(base2, &size2);
+	start = max(base1, base2);
+	end = min(base1 + size1, base2 + size2);
+
+	return end - start;
+}
+
 /**
  * memblock_estimated_nr_free_pages - return estimated number of free pages
  * from memblock point of view
@@ -1826,7 +1842,22 @@ phys_addr_t __init_memblock memblock_reserved_kern_size(phys_addr_t limit, int n
  */
 unsigned long __init memblock_estimated_nr_free_pages(void)
 {
-	return PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
+	int memory_idx, reserved_idx;
+	struct memblock_type *memory_type = &memblock.memory;
+	struct memblock_type *reserved_type = &memblock.reserved;
+	struct memblock_region *memory_region, *reserved_region;
+	phys_addr_t phys_mem_size = 0;
+
+	for_each_memblock_type(memory_idx, memory_type, memory_region) {
+		phys_mem_size += memory_region->size;
+		for_each_memblock_type(reserved_idx, reserved_type, reserved_region) {
+			phys_mem_size -= memblock_addrs_overlap_size(memory_region->base,
+					memory_region->size, reserved_region->base,
+					reserved_region->size);
+		}
+	}
+
+	return PHYS_PFN(phys_mem_size);
 }
 
 /* lowest address */
-- 
2.43.0


