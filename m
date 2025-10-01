Return-Path: <linux-kernel+bounces-839422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F72BB1971
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C7F3BBA97
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161C82FE58C;
	Wed,  1 Oct 2025 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H31OWF3Q"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECCA2D876A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346816; cv=none; b=aKrnaWKSRegp/a917G7Qx+gczV5ruWyhG8isb0jnM274RY33d4SsTU+kX0UUPRMc5U2zY0EINaY7a6DUUOkhKB2Fa1lMKb/Ya0joRLAsG3jDHTkU2jpb5T3l8Ys6bySXxiLoMHB5VJqzglL2as1rQ75D/PElXtSH2YYwX87QHAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346816; c=relaxed/simple;
	bh=5LOLgDuRoV2shXqOUtSYOTm+9rMW+12+m4ljmK1VYqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGRqUHBuSq1pgYpLQUHTLdhVWsnXL7R71j19kUEXoy3H7Kkr6vACqAdV65I1okaEkrIii8kC1rgRxZ2vUtgImbjtJQQfMMyYfBQorkmuf3byowDxCSnhHG9z/7MjgQP1VfUpvaYD0iIZXFAMzW+owQNgDW7qYECK8X2LBzsSOVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H31OWF3Q; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57ea78e0618so243692e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759346813; x=1759951613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuOmVyVQXsumRDN0WySluCU+eClCoeXEAXwSkpYGp4g=;
        b=H31OWF3QACtUraPEv/plAmElYGHQDG9MWSoQGPgZ3RFb7Va5w95RCb033TW64aBW6/
         DzJKRemsKk2Nkf01XH8laV5v440AnTbO283NeDwjarVD2e8XR+L8TcqWsyB66h5028Pd
         4B4V8MiHjtIcOhN+LEqqO8X/QPwH2E2SDOE7nSasAEfDdTITMykNelE6u1y3L8Im5KzC
         Q9I0wd4VDNaj8UFs9C8jbgGueGyJFxIsjh9VaYYkCoaUdxXBiNxM2cwVhO0tuPP5on91
         CTRzBtlAWUCMWuBEAftYL5j4k8HfSFKL6GAkXSG2qIMLfoCzpkMQnyuvQavw7EEm4gOI
         pQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759346813; x=1759951613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuOmVyVQXsumRDN0WySluCU+eClCoeXEAXwSkpYGp4g=;
        b=Q+E7NDof2znYSAYnX9dwYA/y6DOsKn2wStpfZznVSjDwjW1R4pi2k3yHDUUoVE1/K/
         VrbOeHT2vEfcSHNJUMsZRMB3zMBhQvCX+Ry4h2xwc6G3v8g/IrkuJlbHudYjf7/P5P7f
         BayirKOjNRvGx85LJoMfVJJp+xRx5hzoHnwUEjh6IuK2nd0nWjP4Ky/y4Ut4N7BGsXDv
         zL6Txk9e4aUrWWiw98kU2YzzsnLooUUJTN6uLJK0dE7l7LTCmSJhyZ/iZ+R8qxohNX8Y
         y/7M88v62aKuzgwJ+GgMuge4/g//wPPV4tPLDAiulk7iL+DgEJ/X01IJiw488B84HZnM
         IVVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbzC+l2UzjmqxF2PumeWV6ayqkqmny8XNrow703yJYhtv9U6TlCI9/Vr4mWkHUaVc9ErXkh5flerL0QCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YziJWIBItggtVLURIYseRSc8EK4iiqOKuQTKjQy2fm9KhbHyTwG
	zmc9tefcGD8RtY2De+Ab06y/vz8ZlPRWuDELpDtGIvN3hUVShYRJvpnT
X-Gm-Gg: ASbGncu1RnV1k5hN2wc1lFAGHrShnkQ1gQ48fZ/CN6x7EzCDfbtdCaTA0/SzORdgxJi
	d66OUajxXxyhOCTJPmHmc4t5kPuY7cfAZn2mwS1txh4WIViVNKyuQM2quv1fxvjePJlqsLI0Tgi
	s7KZvfc/bGSeWJEeAlW3plM71tBlPLs0RiIRUPW4bK4r/e2XJbTonJAV2ZV8Ysw8z6V4TPyb6KC
	zkJLsWvfpEFrUctgmFWC+Np/EqsmP/8Fedcub+vF24yP5odCk4CTKpvEzjuBuhTRF8ipMCvM4VS
	F0/1GUOZJOIqpRF1rWCu32oJghIjPy6knEF+Uxb+fFC+6ss8W5uvEPY7OXDXvzYBJPBfpyJXu8K
	IsuPxL9eDn9ZFl4bKm3g0CVFU5GXFnFpI9pBN0RalviI0AO08X7E=
X-Google-Smtp-Source: AGHT+IHZQHFJ0S5f1OcQHCfxhezQQXZPltJgxW4zc1dj/mXykewUGOJa1V03DnNOst08ID094gfxBA==
X-Received: by 2002:a05:6512:3e0a:b0:578:ed03:7b70 with SMTP id 2adb3069b0e04-58af9f6afccmr1528057e87.28.1759346812509;
        Wed, 01 Oct 2025 12:26:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0112414fsm136627e87.28.2025.10.01.12.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 12:26:52 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3 04/10] mm/vmalloc: Defer freeing partly initialized vm_struct
Date: Wed,  1 Oct 2025 21:26:40 +0200
Message-ID: <20251001192647.195204-5-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001192647.195204-1-urezki@gmail.com>
References: <20251001192647.195204-1-urezki@gmail.com>
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


