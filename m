Return-Path: <linux-kernel+bounces-876619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A013CC1BE32
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80DD189E799
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8103491D6;
	Wed, 29 Oct 2025 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kihRZnoc"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8595033A01E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753559; cv=none; b=DRJtjZAUNDTEpc2m8NTpI2P/9nSgug+eAwbskeMX2i2VCmfz09sMX/BDTM6JwDLZlYmQxdC3GDkKngawS1X3+UMITc3NHAHhYb2uoUEk/RGiQG/IScTamlVkBmJAul70oHO94QYD7Y1d+jZ105s8WZ+IFD/LZ1Wfe5JX7c62sj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753559; c=relaxed/simple;
	bh=zJznav8+/tOGs8R4Q/7+iRpOZtTAakwuGpzIz4iTHL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O83H60nrWMZaP+LLbZStDNgYFBLi8yoV7YXk95oA1yvHWni5cxhfkcK+edjTiJ3AUoj4iL4fIHGLFSAShNV9pAt9wO5F9eXmiHlYFkYAWt6PXCg3OUle0YtKAPA9tzkSI0LKQDfKhAkeqPmU1Q3EOdO56EvAxYjwDHJ7uTZVq64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kihRZnoc; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33bbc4e81dfso97122a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753557; x=1762358357; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sAbt8Aq11hD5HKF7vZsq1nYOhoSCTs6kYCBAgTfydA=;
        b=kihRZnoco38POIF6SoHj5zL4x5NrRylcWxbGQBVc5FvciLtEfVO1HEHI+SfG6+J6sS
         AYv1bfR6RjEJvz3L5zfCuRvEnxmIXxN4+nCWdFjjoAUH1CnZEGHF1m+Ib6bm5Ur6hB/E
         WiuPU1hD/8P9Kac9Snq6PejYKcRu+88Ov0VzkNda2uP4z643CiEP1+yQgvBjunoDY58W
         w7gBmQxLeJoF7KbQ6DaEly50wU4b70eOZokIphm+w5v7rtTif4D1mV9FbabUR8mCUjvQ
         zlf8t/88yiOGExQYnx2Z01IOZtCD21eQ85Lk9RVpjuCSWvwVRLnIfPz3QgIBEb1R+kg9
         Qq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753557; x=1762358357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sAbt8Aq11hD5HKF7vZsq1nYOhoSCTs6kYCBAgTfydA=;
        b=gsKsYkZ6WmQ1uWjbZsH2eEFoyGwf8QelWbxER46Dt94NLKyLlliSDy5kNOBSlGTZY4
         Hnlp0NLMATNoqs++t62j6H3XmGNE58jmMxJjpY+kTUp14uoz860cDEFZXDe7Up34Mknj
         kGBLzygAz2dijb+sBhnP/uHWZ9v2Kn5miHXd2lvjBRgVKtHZrKf7Bbz+WIaqWEwFMm1j
         OieNf5+XUk1oldSJCquqICXX8f9nFEo+prE+E7zLUjrT7HLp+CMaCSOuDlV8LXFeGujU
         xMHwM8u1nmdquxzCoFcaU/yv45PpIFeUxerijk3s2rPnzGU5QVuuiedJNAI2W9ncJ9fO
         yBpw==
X-Forwarded-Encrypted: i=1; AJvYcCU5wy5NIwQGn1mLqBsX2Ixz+ougmBdVxvSzLnkxDGx/H3yrmxlZU9nUWwC2g/larFwW9l7kUciVRw+JY04=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrDbbiqHk5W/dJvXm6tkdf9SZCei83y3iWFvGq3kD/HpvzuS1Z
	TCUzfvzadozXtxrTKcFpKDEMdfAKs6ZMBGs7bjGB3NyztF/JY8i6jMww
X-Gm-Gg: ASbGncsws7gfPfGENB3kKNLZd/aih8eiWr/9oqnbPDsqZ1UOXqPP9W6rLVGl6XSKEzX
	S7MU3cOjqC2VBCQQMYm1w6ojgdwBaZZoTtJ4cW5DeIqDau5stCju02otdYJhYrSLLnmIO6g7uUZ
	QWmMqoCQOGM6jonXm6siITpXPzcVjIPMzXM4mZuEGXjEYWbXG1TWrAvt0EdtnlX1gZ0C7sGGVse
	Vk/OLwPRNC43HCLfzmr8MRHUatpwKKPd1G5nK7fd2QUz1U7zY2OiUlCzL9trZ+FZ63B+0MeuNGw
	0fdPWWJ2/bcaO7rQ2WDpDVrAMnxwRaqpwuoisVJs73qQJfYWMMZ6OE80H0goMTacUKxSsOQkIj9
	CEBpQCiSg3cKxsfpYMWqzXuuTMhQsRU1B6RJENmQzFdgBSrLXIND+P8pX+rA0SZ9aeI62zq8YID
	QhJg+n8/tTZ5bIdHNg5i6Q
X-Google-Smtp-Source: AGHT+IFcx/tNH+mGfenFLGtMHSLOQFDVYtyEct3+kZwXnL2FV+gWAZHMp+QdJZXOLxNVix81OWQEkA==
X-Received: by 2002:a17:90b:3c4f:b0:32e:5cba:ae26 with SMTP id 98e67ed59e1d1-3403a282201mr4126488a91.23.1761753556776;
        Wed, 29 Oct 2025 08:59:16 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e95aasm16087366a91.8.2025.10.29.08.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:59:16 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 29 Oct 2025 23:58:30 +0800
Subject: [PATCH 04/19] mm, swap: always try to free swap cache for
 SWP_SYNCHRONOUS_IO devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-swap-table-p2-v1-4-3d43f3b6ec32@tencent.com>
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
In-Reply-To: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Yosry Ahmed <yosry.ahmed@linux.dev>, David Hildenbrand <david@redhat.com>, 
 Youngjun Park <youngjun.park@lge.com>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Huang, Ying" <ying.huang@linux.alibaba.com>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.14.3

From: Kairui Song <kasong@tencent.com>

Now SWP_SYNCHRONOUS_IO devices are also using swap cache. One side
effect is that a folio may stay in swap cache for a longer time due to
lazy freeing (vm_swap_full()). This can help save some CPU / IO if folios
are being swapped out very frequently right after swapin, hence improving
the performance. But the long pinning of swap slots also increases the
fragmentation rate of the swap device significantly, and currently,
all in-tree SWP_SYNCHRONOUS_IO devices are RAM disks, so it also
causes the backing memory to be pinned, increasing the memory pressure.

So drop the swap cache immediately for SWP_SYNCHRONOUS_IO devices
after swapin finishes. Swap cache has served its role as a
synchronization layer to prevent any parallel swapin from wasting
CPU or memory allocation, and the redundant IO is not a major concern
for SWP_SYNCHRONOUS_IO devices.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 9a43d4811781..78457347ae60 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4359,12 +4359,21 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
 	return 0;
 }
 
-static inline bool should_try_to_free_swap(struct folio *folio,
+static inline bool should_try_to_free_swap(struct swap_info_struct *si,
+					   struct folio *folio,
 					   struct vm_area_struct *vma,
 					   unsigned int fault_flags)
 {
 	if (!folio_test_swapcache(folio))
 		return false;
+	/*
+	 * Try to free swap cache for SWP_SYNCHRONOUS_IO devices.
+	 * Redundant IO is unlikely to be an issue for them, but a
+	 * slot being pinned by swap cache may cause more fragmentation
+	 * and delayed freeing of swap metadata.
+	 */
+	if (data_race(si->flags & SWP_SYNCHRONOUS_IO))
+		return true;
 	if (mem_cgroup_swap_full(folio) || (vma->vm_flags & VM_LOCKED) ||
 	    folio_test_mlocked(folio))
 		return true;
@@ -4935,7 +4944,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 * yet.
 	 */
 	swap_free_nr(entry, nr_pages);
-	if (should_try_to_free_swap(folio, vma, vmf->flags))
+	if (should_try_to_free_swap(si, folio, vma, vmf->flags))
 		folio_free_swap(folio);
 
 	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);

-- 
2.51.1


