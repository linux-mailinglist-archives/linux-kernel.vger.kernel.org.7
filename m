Return-Path: <linux-kernel+bounces-817076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEE3B57DA6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163EF17A45D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B25329F05;
	Mon, 15 Sep 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIcG8Wf0"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E387321F4D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943655; cv=none; b=G4gdRuMyJXku9AdyGGb19FFpkMkMLyi09KmxMA6RKncJDM+6qUv6wqYaLkpClqXGfUwpzy8Fwv60VBRoY1fQIeDmEOIWWOngfCEacW9JSzx3hdyhxTYfweJYogaH9LVV3RYBC/1F0cBRAL3acxIVx2DLAOjJAzA28PQA2TEJLec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943655; c=relaxed/simple;
	bh=L3ZBiwWYGkSbo6k6JluWr04FWKH+sUKJeig/ryo0U3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrTV3o7pNC1NP62boQSIWwx4nGxJXSXg+ktXelwoSxtog6MF5IhEEIZl1/zGzNuE0FbkFuwBnQErSHlxkYWcAw6a+NFqe983fuV4444IxASaREzlH4wiPuCLaBg8rISP7jyBn5A4VakNgP6WfAa16MlGUxj1rZKALr+w4Xi5sg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIcG8Wf0; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5720a18b137so1962929e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757943652; x=1758548452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cGnhxqw7K3FLu3AtNhDK+aUKQwK3uD8HExSuo45tTA=;
        b=bIcG8Wf0BPBy4+XqF6QmzTrYcz5u/j7J0BSnQgry91juN5sB3unBjhkGSS5T9TWoSR
         ExRCQAy3k+U7YO7rvP5PumQ0g4doRN4Afok6oN7SacudJFWO7COTRs1jkcR2plmT08py
         YH2/EjkvvtCyeuteVzxHxeYC+aWsZrX8bK78g0h+2MqxgzSjbo0SXjTEAZxxZGj86sps
         F0TPY8JSdRSvyRmR958jhhyckPvqMEYwv1eHsUPs/I0AII0pSDo7QUe8Be/DX58vpIX1
         2TCPlLvoLmChc9sdF/22jNk8VuSb/tN8Fuq+8bKpnMWbNe4mFueJ4M79w/sn1swBEcZ0
         EV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757943652; x=1758548452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cGnhxqw7K3FLu3AtNhDK+aUKQwK3uD8HExSuo45tTA=;
        b=TcAJE/qhO2qpJ49sHi9DDRwxqwR57Iwcf+N32AYLMF8Nk1JRKtsRtQzHWMmopAtVa6
         TsWaV7C957ZBEDWRvFkpmzj/9cDaGpK089vaM2JTsJRctNiQ1xA7o9fX0HjcHHvCDZlS
         jVBQlhfu9QP0qOvfbQQ+MeMUAP+UYTFYEHXebLMUW5G2GM0A6BpVuapg3C7tGOqjDpUv
         gaoJg15Phas/1P/NyGNw8ShDziQHocAGaXGINCUWXpZJqFStGzvDGDoavCuJqbx9Idfh
         5eDYc4Z4/lrdG0R+YYOEaiSQ6PXICoKvGeVD2ZopcCYvaUUAFK5QUqjeo4GK1ZMt4h9j
         T+Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWrvkVI5+0sX4kpirUYOOaUSPfw9uu2BuOv+qW9X57pg1BWGlcvPJcLZnZYoLwJlTlmfCU/gczGIRMKPQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE5FV4MhQbdwgcS/L9dKtFXjKMj3rDHy8B3L4j+Rrw0LiG3FVs
	mHNb0TmND/gQJlTZpDJ9+A4zS0TRparA62de5KqsyZ3xBjkxffW0jFpp
X-Gm-Gg: ASbGncv/EYEQCpYNpu5kUvy2RwfsvghARaaBouEdufdZ9ObBmA843ekV3pUuS9iMeNF
	tyFCV0XxCsdhrsJKag1lA7QJN0DGbh/GgWe6MgqNmSPFacqvRpfaHq3FnCUCC6As1B4CeMZ3uPc
	Xa+2FS2Em2M6sGmuhA5a8wf3YBfz9SDw+6gHcazIZ88Eaokx0xzLpU3r7TujQBsaswNdWyLtnfH
	XswvcBmFZ2qwneRLyKWe4OtY7/lR87tsIljexcKfCHp4x7SQFj6SGUC1SOhMl4AS0iyFUpsy52U
	pBrRvHTG1QkAYuSOeNDfvTC5yYY9uXqfUIyPLL2Lgy0yKgsfiOoZ6kxXYQv7K0b1C9hYxWF9MH3
	hqj8dEKSQgE8FEU+9XeTmkWRQULk=
X-Google-Smtp-Source: AGHT+IHKa7vjk8urMi0MJsQZzlSJv6bCL5W2V3cj7dJf0fQ0uTCa5kr5MJF0Y73xS+PSGi4QMIZRnQ==
X-Received: by 2002:a05:6512:661b:b0:55f:4107:ac46 with SMTP id 2adb3069b0e04-5704ad8173cmr2175163e87.25.1757943651896;
        Mon, 15 Sep 2025 06:40:51 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-573c8330e54sm1150719e87.63.2025.09.15.06.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 06:40:51 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH v2 10/10] mm/vmalloc: Update __vmalloc_node_range() documentation
Date: Mon, 15 Sep 2025 15:40:40 +0200
Message-ID: <20250915134041.151462-11-urezki@gmail.com>
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

__vmalloc() function now supports non-blocking flags such as
GFP_ATOMIC and GFP_NOWAIT. Update the documentation accordingly.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 2d4e22dd04f7..e56d576b46c8 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3880,19 +3880,20 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
  * @caller:		  caller's return address
  *
  * Allocate enough pages to cover @size from the page level
- * allocator with @gfp_mask flags. Please note that the full set of gfp
- * flags are not supported. GFP_KERNEL, GFP_NOFS and GFP_NOIO are all
- * supported.
- * Zone modifiers are not supported. From the reclaim modifiers
- * __GFP_DIRECT_RECLAIM is required (aka GFP_NOWAIT is not supported)
- * and only __GFP_NOFAIL is supported (i.e. __GFP_NORETRY and
- * __GFP_RETRY_MAYFAIL are not supported).
+ * allocator with @gfp_mask flags and map them into contiguous
+ * virtual range with protection @prot.
  *
- * __GFP_NOWARN can be used to suppress failures messages.
+ * Supported GFP classes: %GFP_KERNEL, %GFP_ATOMIC, %GFP_NOWAIT,
+ * %GFP_NOFS and %GFP_NOIO. Zone modifiers are not supported.
+ * Please note %GFP_ATOMIC and %GFP_NOWAIT are supported only
+ * by __vmalloc().
+
+ * Retry modifiers: only %__GFP_NOFAIL is supported; %__GFP_NORETRY
+ * and %__GFP_RETRY_MAYFAIL are not supported.
  *
- * Map them into contiguous kernel virtual space, using a pagetable
- * protection of @prot.
+ * %__GFP_NOWARN can be used to suppress failure messages.
  *
+ * Can not be called from interrupt nor NMI contexts.
  * Return: the address of the area or %NULL on failure
  */
 void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
-- 
2.47.3


