Return-Path: <linux-kernel+bounces-758791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DB3B1D3D9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0332A584454
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DAD2475E3;
	Thu,  7 Aug 2025 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcU2P26K"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5313F25392C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553503; cv=none; b=ktpowefek+gKbr7QGlYzqRNHL2U5IOzvbBWOUge14yWgNalqkfPS0N/p0sCF6JTpZeVnbJ28FDTGL6YpcGGF3gNe1z1txufAObRPQqnWwEtJBoSpRup7pfaaBtklMhH167MPiRUmUBn+0fyXbw4+tM68mmoqTdRqpIuELeCIsn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553503; c=relaxed/simple;
	bh=apRRXYeiplBE93jYUg7Xf9XYU4cqTKkRaOgo6c15xfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oif+GGsAoweQImLJerj4OWfX4TJ6IMxxHTtZ5FtobM1ZQ+d4N/cFS3NLucLLyHIypEaliEcY1xvQSrqdyayHpVZEj6nrOLItq2SZoS+GtN1WKwkbH5WudwS33JUCSgDIQhciL40oLP1u0ZAlMmPw1JpWrHTcJlMQdK0aML43rWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcU2P26K; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55b96b154bdso727771e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 00:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754553498; x=1755158298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92v33CSv8r4kGkVW+JHdelKw2kmK/6H34ueeVfUhm64=;
        b=YcU2P26K239RVthxctz3v7n6rVVWOgyzf8r2OECMPNf/zsNreNwdBDK5uClY+1xC7A
         QGo5SaQQrP24+pdUU8qdnIJMhuBi6XVAQcfNqY07Uhc5PKinPYYXDFhGyzXqi9TaQF77
         nUlAX3ElA6V/Y7FUkPzsBImjh2loWPABkuL708eAGLEifTudplI0QM3uzhHMqwOfmsE0
         k8jjj1+XxlJx0PisbKPh5gAYlBQ3X2/7NjBlAbxhL3DCI6JEDaq7czUt0YiNIlvDAiJN
         FkUGsHHenbCSByw2ub5n8URXEjp7ynCh8i+1rF83VtCOgqGK+7NNVqa/U3PxOkOQ+lsk
         T9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754553498; x=1755158298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92v33CSv8r4kGkVW+JHdelKw2kmK/6H34ueeVfUhm64=;
        b=qDoATHOragy8gT7dqsMRrR7DETUekYBRodX6JDvZ5NbfRwU5NE2b+8DI8akeS2xtW5
         7CdUmagV6in97wRWp71lyhRdmuKHfy/CtTRC64+HdkS6oYaaRykdrgJH17OxiJmU/BgJ
         XG0V5urBgrXSctU90BOLhxw+40D2ZGCXkRJSk+Eb2wGYknjBGWOw82htD9gipcBrhw0a
         bwFCgCGp70l+lwu4mYs/NXw6Rta0Cf9IAf6SBWACF7XegqkYoHPz5plAR+jLjeND/10x
         BbzveP8Cb+L5X/fKZ1DHvfHSTUme7t6EZA2aBrxyyP793DjN1q1LEZdwgsjFvI2dd1T0
         ckqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVWc8z8t0q4wnJWXbZIUG1Qg8hw358VbE3EsPlamSl2gVBREUGV68QsZqgB7O/Pe3ER+hVykLCzxXWl3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGPpn5GLmFoI7yRGKmQ73vKkwUpjFD+tQgzDuJWwOQiQ0UbVvl
	v+1FlE0zWYDCEw3a57fjHbxWdcZTXtHaoopdQdn4n55l92135UKFudgk
X-Gm-Gg: ASbGncsksR8E981F1x67HoprvvKHUHd/887qQc9IQTkekmKbFnzkWsnILv4tTWS9zMy
	i2PmcWRihS9n/TTFdmey7nLsQ7LsAhAYbvylq/IqEjIMA2sEXpmGtZo+tKx/ryzTaHs0xivzR+P
	IWTbI25lCWyqEsuSiUwkYDXjhfJ9hfuoNBmGB/e7e58dWxE2vLIwzzzKdl7DO5V9VaKyz7F21Aw
	PlA2L1p5mEXQ82hRfxgh1jqjKRGxOz8cixpWShxWeEswz5HVMSu2VcCuc/fCCfM9SomLTDqyuBR
	pi0Df5g1eXVV4+B+VyhYT87D+FaDYPtuDYPdft1Xn/bT0h9/hfAdPb4gY/QzSmMupuuglGWcYqn
	xYV7sXPfKNINUepRoq35/6MjOJH1P
X-Google-Smtp-Source: AGHT+IHUJ3cTDOCPrqigsEQiSm6trPQffBeNpREX4rEWPP15KbdVteh5zNUFssZk/aYam+sMxXY/jw==
X-Received: by 2002:a05:6512:2306:b0:55b:75f0:1b78 with SMTP id 2adb3069b0e04-55caf3dfce9mr1937761e87.41.1754553497729;
        Thu, 07 Aug 2025 00:58:17 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c9b1fesm2501995e87.96.2025.08.07.00.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 00:58:17 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH 6/8] mm/vmalloc: Defer freeing partly initialized vm_struct
Date: Thu,  7 Aug 2025 09:58:08 +0200
Message-Id: <20250807075810.358714-7-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807075810.358714-1-urezki@gmail.com>
References: <20250807075810.358714-1-urezki@gmail.com>
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

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/vmalloc.h |  6 +++++-
 mm/vmalloc.c            | 34 +++++++++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index fdc9aeb74a44..b1425fae8cbf 100644
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
index 7f48a54ec108..2424f80d524a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3680,6 +3680,35 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
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
@@ -3711,8 +3740,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, failed to allocated page array size %lu",
 			nr_small_pages * PAGE_SIZE, array_size);
-		free_vm_area(area);
-		return NULL;
+		goto fail;
 	}
 
 	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
@@ -3789,7 +3817,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	return area->addr;
 
 fail:
-	vfree(area->addr);
+	defer_vm_area_cleanup(area);
 	return NULL;
 }
 
-- 
2.39.5


