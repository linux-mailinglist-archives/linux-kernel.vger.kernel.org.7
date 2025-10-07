Return-Path: <linux-kernel+bounces-844235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 728D9BC15A6
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59080188FEBD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097912DF71B;
	Tue,  7 Oct 2025 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT8SX+4n"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CAF2DECB9
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839647; cv=none; b=XV+z72eqVwF+ZKBbQHGGdC+XSL+IlulmfbnBNLdrgtNumiJ3AMWjgUKw1Kk2EsmynhwZv+QcZKaQPodhciN9gt/aMw9HYQSA1BWwwnW+7SLlqkep4sh4n9pdm2KiVFOp6SvwAQkDDXMtP90mmxcwbFoz3yWxcctIAsJREDJAHbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839647; c=relaxed/simple;
	bh=5LOLgDuRoV2shXqOUtSYOTm+9rMW+12+m4ljmK1VYqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/Fh9M0kONXONaWa/dvZJfhsv3qzGAQWJL+WKU9QRrHCZGhSDW/qK/QuxhP5VoLgLshDgHYLUwF4JU58Pqm/TW8QjfKMwZ2YD5ENIfeo181jRA/kjmMo2WunVsW6y4GCWfI/78RlIHrne2ykXZJquWIurKnE2OpATQmURqrQLBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cT8SX+4n; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57b35e176dbso7996395e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759839643; x=1760444443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuOmVyVQXsumRDN0WySluCU+eClCoeXEAXwSkpYGp4g=;
        b=cT8SX+4nUbI3lpOdc7fYDhNE/G2nS2u8hIGgnpgfdXqPMRdTit/deAl62fcsQ1ODdF
         BFQJICLfSsdUN9H6jCBCR0BxJZZUkn+7icRp130XT0/zsFIsThM86vEqSrQK+HqzJeoQ
         GjqEO4RrHv17zfRThW+ZdEcQ+l6vLc2umt2HvdTN/ROsqVv6b0/ndISVeMvgB/x+h8ly
         droVWO8SQsJwHT6rKG8tjvzRO8Q64jmXXFB3XZeUbsbdFY3q1/HrHGGzcMLtlhd5U0/k
         ng94pIDmrX8i6EZYm33tnvnuU4HrgifqQBQ3WiE3jw+OU9ufVQ2m/5xWUg7cPi98YD7t
         zoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759839643; x=1760444443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuOmVyVQXsumRDN0WySluCU+eClCoeXEAXwSkpYGp4g=;
        b=k1j6cAFkU4VduzNJpEQbDiIx5Zs2IkaQF6VDtOT9btyFuFyktyKmTg0rw+h+V75kzA
         oJQlThsaJlQNO1MaQ82TJT3PfBNp4lfWp8a5DmwtW5nl7iwoKg0SOkJfvlvH0nWlHhy3
         A21LPHG/k5MIlMmWQ7fksAzB38DS/8eHAnSdd1kQpSbWmYgP5el126uiZYZjZpeA1cZ+
         cj28Sc4j5uOUSTVKKfufxvaNDCBGr/f+fZbROui5LnyVTMICmO1dm8NQmIjyABDCz9h5
         ZkucF/FL2LoLqLe5dlRgp8tS8WMs87n9R8+fmnyVBaKPOaCqjMDVjDb2HWNPX2qkKBxY
         5Xww==
X-Forwarded-Encrypted: i=1; AJvYcCVcI762VAOhd4xgncfKqmYM31Vnf6DSEfcxVUVtKaq1UPjxNHMa34VLCo6VfkOfUN5DWD2i1nDvITu8D2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUKyByaPBGiCENlnJ061dzyVKsxhpMmHXxhTucns87IcInhcKS
	mI7i7WvTUx/PPtc5S8AwJWI0QB/0uuiYQYDMiTO7e8VpTXkVWXzp97My
X-Gm-Gg: ASbGncv/AAGNszwlP3PF2Vv5PVQ2MmLVCVm5v7IMPyGkb9LGv+/dSpjeRqJkfwF9AEu
	PCUQ4iyNag5M/fsn3g3mYV7tc4a0REtLLEOgO26p+HosFB8YSfJgLJN9TMNgEbnMoCxv5Z4BBWe
	3Lvm2KWYJp0vqqE/HoWzEsOAh5eXFN7/txnSg5jiqGjDYqvDg52i9EWmlBtumXXV2OjY9wLBwMh
	ltuoXD9jVmwI+s+y5Vh+gmdFCPKPYSqimf1QMIUE5Bp80yUuNK9koji/w6X/Yxd9WoFszpYB6ip
	7XjJRPcNJH708y3sdOYKGR3k3uxsVUPyex3LMmSuRuyx6EY3JtYWMakMbnVbFu8dSgQaor98nJE
	RTCrntytiX5DN0Kh0b5YVKu6P00jXgKAH+WUo+60tfse7SV7UMYU=
X-Google-Smtp-Source: AGHT+IEpTqLVUr842ienvFDBkvqxbi9T9sFNMNYe1H+RhBIvslkgbvZ0jDXtV54NnONs2RrzHQv/4A==
X-Received: by 2002:ac2:4e16:0:b0:586:83e2:2295 with SMTP id 2adb3069b0e04-58cbb816b78mr4499915e87.45.1759839643348;
        Tue, 07 Oct 2025 05:20:43 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01141151sm6061947e87.59.2025.10.07.05.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:20:42 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v4 04/10] mm/vmalloc: Defer freeing partly initialized vm_struct
Date: Tue,  7 Oct 2025 14:20:29 +0200
Message-ID: <20251007122035.56347-5-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007122035.56347-1-urezki@gmail.com>
References: <20251007122035.56347-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__vmalloc_area_node() may call free_vmap_area() or vfree() on
error paths, both of which can sleep. This becomes problematic
if the function is invoked from an atomic context, such as when
GFP_ATOMIC or GFP_NOWAIT is passed via gfp_mask.

To fix this, unify error paths and defer the cleanup of partly
initialized vm_struct objects to a workqueue. This ensures that
freeing happens in a process context and avoids invalid sleeps
in atomic regions.

Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/vmalloc.h |  6 +++++-
 mm/vmalloc.c            | 34 +++++++++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index eb54b7b3202f..1e43181369f1 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -50,7 +50,11 @@ struct iov_iter;		/* in uio.h */
 #endif
 
 struct vm_struct {
-	struct vm_struct	*next;
+	union {
+		struct vm_struct *next;	  /* Early registration of vm_areas. */
+		struct llist_node llnode; /* Asynchronous freeing on error paths. */
+	};
+
 	void			*addr;
 	unsigned long		size;
 	unsigned long		flags;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d83c01caaabe..9e29dd767c41 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3687,6 +3687,35 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	return nr_allocated;
 }
 
+static LLIST_HEAD(pending_vm_area_cleanup);
+static void cleanup_vm_area_work(struct work_struct *work)
+{
+	struct vm_struct *area, *tmp;
+	struct llist_node *head;
+
+	head = llist_del_all(&pending_vm_area_cleanup);
+	if (!head)
+		return;
+
+	llist_for_each_entry_safe(area, tmp, head, llnode) {
+		if (!area->pages)
+			free_vm_area(area);
+		else
+			vfree(area->addr);
+	}
+}
+
+/*
+ * Helper for __vmalloc_area_node() to defer cleanup
+ * of partially initialized vm_struct in error paths.
+ */
+static DECLARE_WORK(cleanup_vm_area, cleanup_vm_area_work);
+static void defer_vm_area_cleanup(struct vm_struct *area)
+{
+	if (llist_add(&area->llnode, &pending_vm_area_cleanup))
+		schedule_work(&cleanup_vm_area);
+}
+
 static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 				 pgprot_t prot, unsigned int page_shift,
 				 int node)
@@ -3718,8 +3747,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, failed to allocated page array size %lu",
 			nr_small_pages * PAGE_SIZE, array_size);
-		free_vm_area(area);
-		return NULL;
+		goto fail;
 	}
 
 	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
@@ -3796,7 +3824,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	return area->addr;
 
 fail:
-	vfree(area->addr);
+	defer_vm_area_cleanup(area);
 	return NULL;
 }
 
-- 
2.47.3


