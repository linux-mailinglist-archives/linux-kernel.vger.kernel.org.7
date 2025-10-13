Return-Path: <linux-kernel+bounces-851237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 214BBBD5E17
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF3AB4EBC33
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25FA2D7DCC;
	Mon, 13 Oct 2025 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDl/rvlB"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4882C2375
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760382498; cv=none; b=RUNrnAr86LvPfdqZv69+L9m7rliZXNuljmbFYw9JAg7CUEaQxMKu9i4t3LEhFWt4FJ3MBD/ifojLJczbGOtmPehIXPsoonz4bNdU7JIZ5Z5FbrGoFbzRq3FMOjz8T5nwfw7pMOlqmRkXQ6BDdGBEnmLS6Z+bvgYtnblAmlIw0xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760382498; c=relaxed/simple;
	bh=dBI3eakdPMRsK/c3A94rS1c38Jy4VOMXm5ScJs1zjkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qV70kB+3Pt0pDJzHQpZAqo1us5EV2/aL01yXbw2AgnkeOx5WXs/N3vGr/d6678MAyPb6Yf87MAUh9+lKApK8IofGpxvs+d8VPSFMbScED4N/YhEubmaNfq5Ow6BucnvazCHyuDF1jvEudW1uKL2LUm6kxiZVvtA1fB9rLxfBySI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDl/rvlB; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d71bcab69so41713197b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760382496; x=1760987296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4PWcq4M+uwGRj6srPkRX14QChgWCsKUHbcguMBrius=;
        b=mDl/rvlBCf0QmlRuVp8U+4T3clB2ACWFv2F1IdutYPtipW1HY2Xx2IP2RmN+NpJM62
         r8EbzcVzW3nN4K8psuGAPxJMEsazTh91aAJ8kftFv0eBhQz6oOCN5nNAV6nHmPXc2coq
         CMmBMaObiL/c3s9GL+hqvuZfn12iFDUSeUuMpl1hd/QmFQmdqUyMwX94M+4oOxgIdvjR
         mO8ISZtQrwS1kKb07KgE3Oee21kJ0RnNSGz0nuNJmyD9jsCJs8ImXLA9syeGeQTx5CmB
         SsWCCijiSCchnZb9UEtVq1wtHMCCFU+9de9WVGTm05MKunR8QiNNPuVzLSJnUmJQ5MXd
         vGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760382496; x=1760987296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4PWcq4M+uwGRj6srPkRX14QChgWCsKUHbcguMBrius=;
        b=wjofBZy8AuiDEF/3DljvOFxaVhDVQoVWLXR+kayTWih/csdJpDO5nsvXz0YnXZ2Zel
         zLBDIJQNsRehD/GB7X86hJ3gshZDhzoZXOh9GrA8NMllVoFrRw4q35CRCvpeWVKY+uvA
         uauTWcc+/JAw0/d4prjjUKCs5pNKzqwcWe1QkStot4oc6M7pKs6HZiteIewkFd6UJKEz
         2cY75ENU8NrOsn9iWVV/YTog3Ve6RC5UKN2eozv1ws4xF0sqrsn0Lvkc046yPbavY05R
         SyPpBao50gd+GLScyqIGR1Q1eg2DayaHP4/+vygzkJsro7mOteu8pHIh0bdmbwL5Ve1D
         HHBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo08l+44pnjlz4dQkr8yuT5s5rwgXGB5mRtFL6HaZy4kHkHPHutsv82XzSCu8GLvstj/mUNBOBa7G6DTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjkDD/ckVZqQES00hojrr6XuD1pyZHg9MnAO6gxYcgirIRNzks
	1I9qhR8q2j2tf2rHdRI8m6HK2lIrn2i6fSHMtXeLK6v1HkYXkF5uuU4nDgfAaQ==
X-Gm-Gg: ASbGncuMUGwfpdZmT1e3IrZzs3WvisIDME6QeP4cxkCxEm/iMDRwQFujcGiKee6SpW1
	tukISpe7EXvOlkdZddmNwQ+A4tkb62Jk8uPK9w0VlEYau/UA/XwY9zcMM0nn0AecvEDv23/8vJk
	nKT7xGdzVAzaij6Stwqn6CHLWAmv7tYGH4DXowHmVaBBGtG3/0QHd1XKhOuJeUoHrguvjDs0RDg
	uGf7KEhPGBoP7THQa6WWxir4rJEznlQ1Rwes7bkdVrCKK9ihebJN6apTrGOIcJ0otQFEBh7UdzA
	F+XVEgKRgeGnV88gNR4a4zQbHyAdcfDg/rgMAZ1eJ/uiysv3hsvLzG/aIaoYeK58ihQxYevJb6N
	k4Eu8Wa1qnHLqwsmbMsZgUMuMhnOyFrwRWMBeFl3MAzoTkzD0kP6FpbUbCOfbD1h2G1fNh6q7gf
	gSMSFb94sYqK2HA+hlag==
X-Google-Smtp-Source: AGHT+IEwc6kNppGrUkzHR7CUmSJb11RqLXjiocSwItNawnwmXymiBVgb+9hi7J3cnFP0Eq2Igk3xkA==
X-Received: by 2002:a05:690e:18e:b0:635:4ed0:572b with SMTP id 956f58d0204a3-63ccb92c021mr16046558d50.47.1760382495682;
        Mon, 13 Oct 2025 12:08:15 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63cdec375bcsm3853594d50.17.2025.10.13.12.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 12:08:15 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v4 2/3] mm/page_alloc: Batch page freeing in decay_pcp_high
Date: Mon, 13 Oct 2025 12:08:10 -0700
Message-ID: <20251013190812.787205-3-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251013190812.787205-1-joshua.hahnjy@gmail.com>
References: <20251013190812.787205-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible for pcp->count - pcp->high to exceed pcp->batch by a lot.
When this happens, we should perform batching to ensure that
free_pcppages_bulk isn't called with too many pages to free at once and
starve out other threads that need the pcp or zone lock.

Since we are still only freeing the difference between the initial
pcp->count and pcp->high values, there should be no change to how many
pages are freed.

Suggested-by: Chris Mason <clm@fb.com>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Co-developed-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/page_alloc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bbc3282fdffc..8ecd48be8bdd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2559,7 +2559,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
  */
 bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 {
-	int high_min, to_drain, batch;
+	int high_min, to_drain, to_drain_batched, batch;
 	bool todo = false;
 
 	high_min = READ_ONCE(pcp->high_min);
@@ -2577,11 +2577,14 @@ bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 	}
 
 	to_drain = pcp->count - pcp->high;
-	if (to_drain > 0) {
+	while (to_drain > 0) {
+		to_drain_batched = min(to_drain, batch);
 		spin_lock(&pcp->lock);
-		free_pcppages_bulk(zone, to_drain, pcp, 0);
+		free_pcppages_bulk(zone, to_drain_batched, pcp, 0);
 		spin_unlock(&pcp->lock);
 		todo = true;
+
+		to_drain -= to_drain_batched;
 	}
 
 	return todo;
-- 
2.47.3

