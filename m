Return-Path: <linux-kernel+bounces-817071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5DEB57D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 689DA7A2ED6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8A931DDA0;
	Mon, 15 Sep 2025 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Crq4HnnI"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48D131B82B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943651; cv=none; b=cJ7/TPEeWakfKc1xrl0OMb31JHpzgS04Bge0Q07w8Y+1/7i7xSc9QNdy/DaE0tZZto07xwcXlNbsAMaO/KJKgHe2+csQ6PcArQFM2JgCwDXypzRDX76PW8cgQi5TMwXyxbTgXTJxA2/jSW37RNYNHtZj1yh50cFQEse/cdeh8HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943651; c=relaxed/simple;
	bh=Q1/mYOo/jb61VwqzwlaOjMqKjlnR76dztMtJqcf/xAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlAjQdXiyFksI/j8V+goQ9a5NxX6FbtSJsgdGtAhAz5Yql1TEAPG4L9JKjEI5hRAl9WBMRIpcTsEGpUVD1bGDWYwp42QPACf2Nc7Ri2KsggI6iu9BG7V/rCR9BrEalebEactpERDrheKCmI9odSpmK+wtxG1rdsMxMyKek3Yl74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Crq4HnnI; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f753ec672so4662669e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757943648; x=1758548448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jt/2LWtHGT9EgRO0DryBuNasAbNViAyk/FJTAlZaF7w=;
        b=Crq4HnnIoZ9PL8jx7EkSfAGYiEhLqxPPgzDsfLCmS03QHyZoibw97qKi3Wi8xq+Cn5
         wZJPsFNnfBPYlUcYpF05TxrYRlGpWJQSsORc2aZw/YY6hiyIbHjXpcexB9oLOUGgmfXj
         Y5fAXK1hiBWkoJDjYGab46W1Q7iKsl0VoJC+oQ9MbVzWDRYLUN9WrmLzT4TLYFqXFjNm
         SNtsjrVyoK6N/RHC09niF3UjebLW7RmFlxVd10kOQLMN+CeGunZHDQZPSI/GD2VZmxkK
         ywLyuhncT+1tJubANeVZEWWTA40N7DaLIrM86jaYRBdalHFIckJZk1QG8XMKtP2EryYw
         f4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757943648; x=1758548448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jt/2LWtHGT9EgRO0DryBuNasAbNViAyk/FJTAlZaF7w=;
        b=jyCboTr4SQ7OKSebepu9BXsPd1nI7h1EO+DmUVxtPuAxb3toYI7FFhE4IwsiRPWEfW
         5MhTv4bTIv4oZzyxxXHhX/e+/9vE0gmAGxfs4NmPshOKbSu/5fuJdkU7WhG/2s4boIke
         /72/2sDhRro4ZJzzPdmrJCecDo3wumie9GItkwluGWaKSCewy2OvxJPoYgidCGbD9ZL3
         jXlWXs7R2e8lPRuQHUXE4lqk6WZA/Kg3S7BGa+i/MuGqNsek+e3O2DwzFU5aISrZ1lza
         pcv3fRs4Xt7wlas4SuN48b2WFyimB0NXZGbpr7qaRBkypMLDAbJ3xWUuKR8HysySdkBl
         gCYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMRQPwK/HgeaF5S8uw0MAP49XZGAgCkZIZ3G+7XlE45NO9alUONM2CsXB50lcgH87hOjDnaFrHMegMaZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8j5zPdi/tN15/UotN6/M3suu0lVIPaRn829JlJeXVACHaL070
	Y+7hRaAFjc9XyhkZwDl4DdyGdOlj7VvVcS7UzF/zZfaAS3CmeMddD8/o
X-Gm-Gg: ASbGncts619DSqn4XjmivWVO+dDRWqiZpwQ7RF/PzDKwgstxUzZQZw6Oeepno37cpeO
	iVmJkyX+Q7+l+pde8+897qZYJhHTXM8Waisc4dUdpWIMDtRg9KYyHgh6VdWJ+luRXU06XwW7MXb
	+DIOlpsi4txz4sqsebrAVftVLr+wKr684g7Qx/VlV+9p6QozIDe0MODCIGWZWUCbm4EQ3cuc9dj
	7IRumsBs0detxM/BE1pHpkJSL8XALvUXSv+TccpUfrrEeQPd6QAkJGp4ceFCSMatbwb1+ABwqSw
	Ftyf+31zZIGWgWT8MWzurg/nn4I4v+VdrAq5CaakXfE5js5et5w2ZUKbXghVJF830g1/jw3oJqG
	wio8Bx5+sqZ+qiB3vgfVZK4AbCDA=
X-Google-Smtp-Source: AGHT+IFsE9P63lZm6RN6AXK4f+5FSZlBhHgIi0Y9I2WY4Ie/SPWsz/NGfvqkJ+OOyzYdciXpuKcc+g==
X-Received: by 2002:a05:6512:2608:b0:570:8bc4:9545 with SMTP id 2adb3069b0e04-5708bc4a015mr3017588e87.4.1757943647381;
        Mon, 15 Sep 2025 06:40:47 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-573c8330e54sm1150719e87.63.2025.09.15.06.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 06:40:46 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2 05/10] mm/vmalloc: Defer freeing partly initialized vm_struct
Date: Mon, 15 Sep 2025 15:40:35 +0200
Message-ID: <20250915134041.151462-6-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915134041.151462-1-urezki@gmail.com>
References: <20250915134041.151462-1-urezki@gmail.com>
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
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/vmalloc.h |  6 +++++-
 mm/vmalloc.c            | 34 +++++++++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 2759dac6be44..97252078a3dc 100644
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
index b77e8be75f10..e61e62872372 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3686,6 +3686,35 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
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
@@ -3717,8 +3746,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, failed to allocated page array size %lu",
 			nr_small_pages * PAGE_SIZE, array_size);
-		free_vm_area(area);
-		return NULL;
+		goto fail;
 	}
 
 	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
@@ -3795,7 +3823,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	return area->addr;
 
 fail:
-	vfree(area->addr);
+	defer_vm_area_cleanup(area);
 	return NULL;
 }
 
-- 
2.47.3


