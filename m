Return-Path: <linux-kernel+bounces-843417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841C7BBF242
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 22:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DED3C4152
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 20:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5C12D94A1;
	Mon,  6 Oct 2025 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndopRxne"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8782A2DE1F0
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759780995; cv=none; b=rz1Jze6yrCFNpx+yzOeNR5s3OL6Hq5wGSnUWjfvE5fPIBzGF3DFpsy0UVJtwCJXBvvUbNZYBZbcoGtUflF5Oggt4lDg329yZ+nUZm4u/jB/cSW6jyS42+8qgMxdOlmmPlsunalKL0iH2lJRm8gj6vc81fHifGYi2L7U+mO+JIwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759780995; c=relaxed/simple;
	bh=9q7atItYA1TlcduEE3c+VIaxBOMZXl/TTmoi3n+8OJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D1b7fsFOlZFDadyjMdRikpP1412H5yOeNn/CK9GSEEkp2zfEO24u5xjLcOTLPC50KaMVeKdS94d4oHCXh+SiJEXdmmQcXP2fQkzS9X8rQiCeMKtqxa4JWS7LFkWlKGWQxUBaG85n7uPBO4Z5VaLAVoHmYqDu1vY1gk/Ywt5LrEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndopRxne; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-336b9473529so4998540a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 13:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759780993; x=1760385793; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VextjEGcnlm32GGbyDeUjgrLV8IU5CS7mWQhtH32SsI=;
        b=ndopRxnexzdJTQ85qNNwCSjDhYCIK0cscoxLcsG7TOQb+CR+AolnzX/j+r7IF6uPCj
         0fk64S4rAoYeqcDEQlXNZrNkrN4z2s14QCTv/K+SoiSBVPCqwK+pTh6fZjA9TT2Fh2+N
         VSPvxXEFU4UImIFT5fB80j6YdkSz/B0QaiVnHbZ76k16x3AqbW//ZCc/jnnXRR7hy/fR
         XFTSdrDHlVX0wfi6HcfAj0/k5ZLHtogDnETP0z23YhalD5WEYiOzLKYE9i2A3zLiI+Wh
         6NYvKbJeiQUqju/4ShJscG7Usy+G/j5K8Cxx85lFAPtN9/Oq4Pg6UMvQX94d/NOmMf8B
         BTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759780993; x=1760385793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VextjEGcnlm32GGbyDeUjgrLV8IU5CS7mWQhtH32SsI=;
        b=vj+41mP3idUsbZ27WfKTOj1/N9dG9WO/od7sO+u8+OoW4RzFo+510enGPyR2mvded7
         ae26DRCYvr2gJUsWJZcOX1mR9abDzoeo+3XotnSAHtRvF+nQYr+LTi4WKNM2gbMSIr7y
         MfESg5UneGWgDikRW5/hm8FqVKDmerPwMQBmi+ls1f6JjUxtEff3tsdAPzJgwVg8GyrO
         MusrgxlHOHwPqQCHjvvkykGz8PL29aAexb9Ki7FhxWoGXK/oxTDYNFG4iPy+bcu8TJ25
         SByNKPsoumMU6d5bgLDV9xEHsPU+Wa70qzKPhN7cRf2gM0GT37hp/O1D2LkuqfqV82Tj
         gi1w==
X-Forwarded-Encrypted: i=1; AJvYcCXvquTDVI6H6fA2OeEX8kO8rBflLisIwSFC6kv8GDQAZ+Qpvn8bcBvjlKLH3ga7WTI/U2RshP65ThruncA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmj7rAPew66Ui8PzmD8BLv8ObXckd+1GquyU59jgmxxOnb79K3
	pYod1He++jGCRNPC0HTlhbCF/ZvQUwcTV9kgT8J0mR7rS0Cvytt3B14W
X-Gm-Gg: ASbGncsLfjmbFxFmI9fMPr8F84hwO3cg7HpFPKElPIT4iWFvYYvajNEsTE+fC6TfHzS
	Eo7jv+0iRI7U2MX3yr0zyPDVpvmw7y5ww/R1EY64BlPQ4dyzcn3JKRRsbX2nRErG3sb1QTPXiTy
	EeUeY5JQ0vzATHvYp+RkGol9aG5HutIlkZf/G+AE17A1XR1k47K7vP2tGndkYg9dtVCXU/RxSmg
	S6XeH4ZsLWsFhi6BxjojSWEOMbYm6p/YsSZoE6qStEVqCTQ4spJGg0+DkUiTyB80u7QfhH/SINu
	GhuBYhb9qdzqPPKN2LFp3PK6gEG8Vj6f1FNv4I9hqPiAj8YBxFRn2klbMDYk4VhhWMEVuad0oOW
	PObyESlUAoinvhwi1ZasFz0I+Tzr+oqqhx3SBVdLCW2YPAyMIBAS40D5jnhFzD4E=
X-Google-Smtp-Source: AGHT+IEEC/OlDJjYylUZwXM70t8C4JnPOT0aE/22j79CrAET4Rb6cfD67kwfl+/Yi6S6WmLn1QYf+g==
X-Received: by 2002:a17:90b:58ec:b0:330:a1ee:e119 with SMTP id 98e67ed59e1d1-339edaae564mr1057063a91.9.1759780992601;
        Mon, 06 Oct 2025 13:03:12 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339ee0ba20asm163148a91.4.2025.10.06.13.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 13:03:12 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 07 Oct 2025 04:02:34 +0800
Subject: [PATCH 2/4] mm, swap: rename helper for setup bad slots
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-swap-clean-after-swap-table-p1-v1-2-74860ef8ba74@tencent.com>
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
In-Reply-To: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 David Hildenbrand <david@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Ying Huang <ying.huang@linux.alibaba.com>, Kairui Song <ryncsn@gmail.com>, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3

From: Kairui Song <kasong@tencent.com>

The name inc_cluster_info_page is very confusing, as this helper is only
used during swapon to mark bad slots. Rename it properly and turn the
VM_BUG_ON in it into WARN_ON to expose more potential issues. Swapon is
a cold path, so adding more checks should be a good idea.

No feature change except new WARN_ON.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0d1924f6f495..732e07c70ce9 100644
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


