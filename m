Return-Path: <linux-kernel+bounces-863570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99A1BF830C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D5A4276E8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3A7264612;
	Tue, 21 Oct 2025 19:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqebElYu"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238292586C8
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761073492; cv=none; b=f7ZW3f4Hi/nVV+BZcGlKk/mA3vrrtFgVqDH7nykkfnk1MwTs7zMSR1B1GDvd3PC2SvYFSz628IOO5JbdrpyALBBMSpuEw/oJFj4c/TPudrFf2PKpNbZ31hJJB7fbMHHqvyDtwPXaiJVj6fLU32q09R1UsKZFfwEB20GjazmMqAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761073492; c=relaxed/simple;
	bh=q11VqPhISxAq83SdAd0VRiD2EuJuQ7IvglCXKCEFYKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a91Yq3pRSEiNEVnTxRe836amu8HHBG/mRG6hfhbVHTkzPcbmPgsYIG62QVEMDK+CyZOBBynP3C8bN7nW8k5WENi1alqSeZODp5M7M++FWSLrfhGlhZ/M4YwVGNVY8wzTH4nWo9J3Zwvtb0o4bnwYVeVQqxSpwE4l0yaG5atNg+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqebElYu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290ac2ef203so59202855ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761073490; x=1761678290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ISZWYz7jwfSXd9tq4inzuqOWmGJUHyHpKimpAOEt6OY=;
        b=kqebElYuOlYJNumYFTw1asnsmq8yZDSltsM6ONFo+C6Gm72w7xccRCkXQ9dLcUKecC
         m+57wsUYiBYNOCm/626ue3KMLeSNfcJ1mas+VzcwuB3uwYpPKiSJOPLy4UwS21d7OQ1E
         Khzxh6ZDVIxADvRb2BojG5aH1BN94DN4aC4o1CIv0Y7o8mba6wqM1xZi5hvMwlIXnL4J
         t1DMNYPNOvadyeMRf/GIHGU8A6mRottlgJfkZRTvUSEQghoCsFrRq8oeeO1untZtGTNw
         w5tlMvoKWBiFIRcFaaLPRtIiXtYJmexE6FkFqAca4aloixqFLVSku1i9N5wsF60Q8wje
         g2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761073490; x=1761678290;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISZWYz7jwfSXd9tq4inzuqOWmGJUHyHpKimpAOEt6OY=;
        b=WaPGtFYQpJJZertoz7JVGHrNZf28+TvA9FypwUKTwnjTeLjDyvyF6NOA55PJV8mcTF
         KLm14z1tE0GAYYqKDBEYcnEpSR2H7Xsf34dDhqVlohuSwBb8iqPpdYIWUwrK7OWts8Sg
         OJ6euV7hfM5ugEt1oiHpk3oC66BnIrW5rPGUAFviXhfaZQvJUe6X5yATT+hKrTcwCKgw
         BfpRra84APZxLknYXJMjEwUbK1ElLzJNiI8ZBvuoQ2VkO1UO/5SDJYflkulEZODoqRAe
         ecHfK5DjOJ2xi8rlDQ850j2zfH0c6JbtPajXF4mqvO26vLJYry8WWCrXJHVGovDSTvqj
         fjLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSVVkDq66NHV0f4h4AA9Fk/iIsHalN93+Okcz0daEs8cygoJ8ZnC5UCdh1JHXCdAkuvpgkXwyFjysHkUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ7glyFbOyC+ckj4YEST9hj21Q/RMV3iSX95p5dSO+eOA+bI0J
	25YeFsMRTRzirrmKe1msFMwDf8qDfQeR8CtCX/uR56MhN3VtMMOpGd8M
X-Gm-Gg: ASbGnctqYsNZ7uCyK+mTUZOSKfK3UPCn2twjxBAk2OhFZ7m5SbSTweUcCYfe48ZTllL
	8P1ypUTuHJ/M4VsbIEZAWyAq1WuraSEVpugnij0GEeRTZia3w89bShxuOElSuaLAolrhkUulMrh
	bQmIIQw/iRvZiqCanhA0+6jE2YNo918yO5DSq6rAWynlB5yn1yWoQNwr9CjxxaUQhnd+5sjCWtO
	/uUofxA75OX4GrHNa18VsUdsVFT8Lijll8mP3qpuXo5DmOE72PDxw53LmgRUwVMBbgCUMGbtjW7
	sVhS4/M8Go2uncbtZpnNNW+rY4NiYkXn/PAUgs5OPY0nMjJaJkyy5V64BF9Rmh8hcxhvP+vQaCa
	Rhxos1Qq5dOEr07gMKzM+dYMihdnUKzdfzUXsucC3il/Xr1/YoIYRAws/s13w0wLwItG5wei00c
	SkCxHmeIFULROe5W/UG5rVEzmfYj/X/64=
X-Google-Smtp-Source: AGHT+IHkT8UoFnBBi1CBq+2YccEgjqBI+DLZKtcKn0a9UNxsMkVcsdd6kuH2vJPgljjD95mJq5TuRg==
X-Received: by 2002:a17:902:fc8e:b0:27e:ef96:c153 with SMTP id d9443c01a7336-290c9ca73a0mr247432075ad.19.1761073490421;
        Tue, 21 Oct 2025 12:04:50 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebca5csm117664615ad.19.2025.10.21.12.04.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Oct 2025 12:04:49 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Hugh Dickins <hughd@google.com>,
	Dev Jain <dev.jain@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mariano Pache <npache@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/shmem: fix THP allocation size check and fallback
Date: Wed, 22 Oct 2025 03:04:36 +0800
Message-ID: <20251021190436.81682-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
Reply-To: Kairui Song <ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

There are some problems with the code implementations of THP fallback.
suitable_orders could be zero, and calling highest_order on a zero value
returns an overflowed size. And the order check loop is updating the
index value on every loop which may cause the index to be aligned by a
larger value while the loop shrinks the order. And it forgot to try order
0 after the final loop.

This is usually fine because shmem_add_to_page_cache ensures the shmem
mapping is still sane, but it might cause many potential issues like
allocating random folios into the random position in the map or return
-ENOMEM by accident. This triggered some strange userspace errors [1],
and shouldn't have happened in the first place.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-mm/CAMgjq7DqgAmj25nDUwwu1U2cSGSn8n4-Hqpgottedy0S6YYeUw@mail.gmail.com/ [1]
Fixes: e7a2ab7b3bb5d ("mm: shmem: add mTHP support for anonymous shmem")
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/shmem.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b50ce7dbc84a..25303711f123 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1824,6 +1824,9 @@ static unsigned long shmem_suitable_orders(struct inode *inode, struct vm_fault
 	unsigned long pages;
 	int order;
 
+	if (!orders)
+		return 0;
+
 	if (vma) {
 		orders = thp_vma_suitable_orders(vma, vmf->address, orders);
 		if (!orders)
@@ -1888,27 +1891,28 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		orders = 0;
 
-	if (orders > 0) {
-		suitable_orders = shmem_suitable_orders(inode, vmf,
-							mapping, index, orders);
+	suitable_orders = shmem_suitable_orders(inode, vmf,
+						mapping, index, orders);
 
+	if (suitable_orders) {
 		order = highest_order(suitable_orders);
-		while (suitable_orders) {
+		do {
 			pages = 1UL << order;
-			index = round_down(index, pages);
-			folio = shmem_alloc_folio(gfp, order, info, index);
-			if (folio)
+			folio = shmem_alloc_folio(gfp, order, info, round_down(index, pages));
+			if (folio) {
+				index = round_down(index, pages);
 				goto allocated;
+			}
 
 			if (pages == HPAGE_PMD_NR)
 				count_vm_event(THP_FILE_FALLBACK);
 			count_mthp_stat(order, MTHP_STAT_SHMEM_FALLBACK);
 			order = next_order(&suitable_orders, order);
-		}
-	} else {
-		pages = 1;
-		folio = shmem_alloc_folio(gfp, 0, info, index);
+		} while (suitable_orders);
 	}
+
+	pages = 1;
+	folio = shmem_alloc_folio(gfp, 0, info, index);
 	if (!folio)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.51.0


