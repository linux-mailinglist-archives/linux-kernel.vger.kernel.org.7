Return-Path: <linux-kernel+bounces-867526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 461DFC02D57
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A87904F0605
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B388934C822;
	Thu, 23 Oct 2025 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvBAuVJg"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE9434C13A
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242513; cv=none; b=P3H1yR0jHYuK8lPIPT8gdbgBC5g5bkbwVDyqfVmtnMrYZ0xBq5dxxmzc7loBrvyLTBlXkhGsj2wmALrpLigLL/XY+5XbtmHFf0BSV60K0rALdDogiTOOvSsykgZsn2NFKx+U5HR20CXOvQ0IXjSpX14h6DJ2yVg01wdkXeOJzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242513; c=relaxed/simple;
	bh=Cs1vrg9ttQD1JeVHtClk4QAodQ6uuPn1gT9PNh5Uapw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MlVuAjpeYnMWJAUfEE7e6TQ/tRKYds9SoFV9Y0jPhY0GA+TTvMsq2LxHTHjYupxRlRbTSCQOcu+Ys1I/q3gtsCg4PvBSvJEsx3dNjj9hBTfFwX1oq3Qeog3eM06/HaKKgXbr1mSepI66/vY1SWeAsrbQSG5jF7B0pnvD5ZLwPD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvBAuVJg; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7810289cd4bso1120907b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761242509; x=1761847309; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rli7uhqVcojZxMXbHTMs9kk/hCHNAWNyDYe99kJqQ4g=;
        b=mvBAuVJghLTWDU43lFpbXtEFah1SvETeXJOU55prlJYvXUs3Z31ysvI5c/oWxURcrN
         XrKqqxY61l+onomlOk1V0IPN7hqcV/V9opRlEKHDTXOZNHeQHWLY6Dlo2U4UmGTxmB2M
         bYTaCzZourDMFXsgio3bxyyJ7TDkkTg3UrRCq2U0K49CfflioUpb7WisChzYIrkrr3i8
         YE1WJQFYjNB60mMAZ/BXP66OzjXwJSVon3FvrDWYMVLWTtXBgs0pv8HXAFtPkCnWKrfs
         Cdu7OpdJ8PrwrLpU0PLHGhSIhY4OVBPQ3neYOvOeaudym3+XBM2EVQEmvT5fvPUcGdl8
         ATiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242509; x=1761847309;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rli7uhqVcojZxMXbHTMs9kk/hCHNAWNyDYe99kJqQ4g=;
        b=LRvhxHkILhcFIaX52QANhSVHYhBAtHE5jDXzxwLkFej+U0E3VC+9S38XOUUqXcnOGu
         ZLXTglkUx0vR7NwFqPN9PS1eYa/iJkGp0o+ce8BsvemM1QlF0O4tikKKlj+PuUjN2mhW
         XArC+ewsDbJYIuq6uEpYOsVhbz9WrExGRfJmCOiqEKYm9Z8qIlnI30BC24sSRUofjls1
         zScEuigJdCNH2ggvz37zWKF3gUGRmsNGCnRwuF0XYLyruK6kIE9ZyytW/uRTwScsopbI
         gTy0UBdZGPB+biGHuWl8eiymPbea2ZZ8AAqxhb1NL7ubFEk6JWWhUtblQdPF3JyzPIOt
         NYRA==
X-Forwarded-Encrypted: i=1; AJvYcCWBo5d1YLt1GgJQo2E0+WUlp60pliB4rEjjrp5uyU3c5MbwAmQHPK9bE32iiMV3LUnBcjnwQSlV6IjELjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSKaxnIyL7iaGo7Df5yLH3YGDDlZy3QM+P8AatoHB+zu1mINLf
	2XNX00Elk1dkTPoIfBur/bOEasDzn0FdoSZLlAG5HIAO16QHCU2qrv1X
X-Gm-Gg: ASbGncs1fGVzTt71yrL9dQGE8zVqRF/w33VYqvzQ6HZFu40YuabV3kmiNgIk3I9dQOa
	moNHyF1ZVw/LMt9crF4DzIMMMVfPUUVW/GRtCi8qjJ0UUAzjBZz2lmVgaEuGE0rXqNqMWFp9MWI
	vuNiiYqA79CQ0upJrTENlgcqLb2xKyIrLrYU/KpugQn4hQli7GUjuqr9etZ4oIFnSSyhoQ+l5vc
	rR2nUmhv1ekig0rvKXzXU+w3ZqQzwJtvXe9E3RRYZwvVptSifqcEM8LS7KSureiEKOYixtmQDtR
	M7nRkot3jrYe1f7IY4SoPIb3w4074lTIIDZtxzzxGDYeNAp6sZTr+0Tuc4O0vbHyTExUAK9/JT9
	jA8FnCvVWF2Iax8DaDky0h3LTm+rsXq35alQKt+WdhKMfKj9DIb0iFCQlAPQIo2T0i+g/MwvP+A
	v4DP2KIA==
X-Google-Smtp-Source: AGHT+IG6uTG9VHUgkfPXj2XEVa9LczRPQpiJM9vHmjW5NJQW2nrH3Se7qga1hxc30sJPG3cs6umW5A==
X-Received: by 2002:a05:6a20:1588:b0:334:a710:14a with SMTP id adf61e73a8af0-334a8630420mr36491423637.42.1761242508512;
        Thu, 23 Oct 2025 11:01:48 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c4d83dsm2734532a12.18.2025.10.23.11.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:01:47 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 24 Oct 2025 02:00:40 +0800
Subject: [PATCH v2 2/5] mm, swap: rename helper for setup bad slots
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-swap-clean-after-swap-table-p1-v2-2-a709469052e7@tencent.com>
References: <20251024-swap-clean-after-swap-table-p1-v2-0-a709469052e7@tencent.com>
In-Reply-To: <20251024-swap-clean-after-swap-table-p1-v2-0-a709469052e7@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 David Hildenbrand <david@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 YoungJun Park <youngjun.park@lge.com>, Kairui Song <ryncsn@gmail.com>, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3

From: Kairui Song <kasong@tencent.com>

The name inc_cluster_info_page is very confusing, as this helper is only
used during swapon to mark bad slots. Rename it properly and turn the
VM_BUG_ON in it into WARN_ON to expose more potential issues. Swapon is
a cold path, so adding more checks should be a good idea.

No feature change except new WARN_ON.

Acked-by: Chris Li <chrisl@kernel.org>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 35038a0871e1..781a70dfcff1 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -751,14 +751,14 @@ static void relocate_cluster(struct swap_info_struct *si,
 }
 
 /*
- * The cluster corresponding to page_nr will be used. The cluster will not be
- * added to free cluster list and its usage counter will be increased by 1.
- * Only used for initialization.
+ * The cluster corresponding to @offset will be accounted as having one bad
+ * slot. The cluster will not be added to the free cluster list, and its
+ * usage counter will be increased by 1. Only used for initialization.
  */
-static int inc_cluster_info_page(struct swap_info_struct *si,
-	struct swap_cluster_info *cluster_info, unsigned long page_nr)
+static int swap_cluster_setup_bad_slot(struct swap_cluster_info *cluster_info,
+				       unsigned long offset)
 {
-	unsigned long idx = page_nr / SWAPFILE_CLUSTER;
+	unsigned long idx = offset / SWAPFILE_CLUSTER;
 	struct swap_table *table;
 	struct swap_cluster_info *ci;
 
@@ -772,8 +772,8 @@ static int inc_cluster_info_page(struct swap_info_struct *si,
 
 	ci->count++;
 
-	VM_BUG_ON(ci->count > SWAPFILE_CLUSTER);
-	VM_BUG_ON(ci->flags);
+	WARN_ON(ci->count > SWAPFILE_CLUSTER);
+	WARN_ON(ci->flags);
 
 	return 0;
 }
@@ -3396,7 +3396,7 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 	 * See setup_swap_map(): header page, bad pages,
 	 * and the EOF part of the last cluster.
 	 */
-	err = inc_cluster_info_page(si, cluster_info, 0);
+	err = swap_cluster_setup_bad_slot(cluster_info, 0);
 	if (err)
 		goto err;
 	for (i = 0; i < swap_header->info.nr_badpages; i++) {
@@ -3404,12 +3404,12 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 
 		if (page_nr >= maxpages)
 			continue;
-		err = inc_cluster_info_page(si, cluster_info, page_nr);
+		err = swap_cluster_setup_bad_slot(cluster_info, page_nr);
 		if (err)
 			goto err;
 	}
 	for (i = maxpages; i < round_up(maxpages, SWAPFILE_CLUSTER); i++) {
-		err = inc_cluster_info_page(si, cluster_info, i);
+		err = swap_cluster_setup_bad_slot(cluster_info, i);
 		if (err)
 			goto err;
 	}

-- 
2.51.0


