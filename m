Return-Path: <linux-kernel+bounces-864765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85344BFB7D3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672D2189A8D1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA62322DD4;
	Wed, 22 Oct 2025 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8rBLIzo"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D69126E71E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130649; cv=none; b=ZsScsccqCK2KGVl+Js4gCAsbm1JpcRgMqheoHc7P2rAjz8zrKcU8RJj7g8iRRFjWzU9klXw+V3bpnlhxzn31ZmTdQBgowt/yQCXjDc/G2tbaqv42puiM1LEhf/2jLCDzGTABwb1QJamUKIRkHEmJ9vSXbaaZEoTAMPYlaBBskxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130649; c=relaxed/simple;
	bh=Bm+cJgJrGpbVpo2k4DHQR58J+3jHfjbzIIQ76OGCebU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FRlg86csYAAFFr+P8SX+bKj6MQ6Fu/Tcw6a3E/2RCh5PEc9/PCBrqOGR1vwr0Y0JaJP/boxEosTTiUh2y2uS22FkJVrDi39cr64cBv3rGdJ5ufl8U94SHbBDYgng7wDEuWwzHefZELpuQGuW97AHJQJMwOIM+aaCtIThmZs/Wkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8rBLIzo; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a26dab3a97so103929b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761130647; x=1761735447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kk2BPiYFNzn3CXG6RkzldSGrwb1ZpVic8o4pFAU0ZkE=;
        b=A8rBLIzoqevJLIFI1ChgF1XZV+SVli+A/0eRmOvhnv5gLj/GyhqXXKFchjPqKteESk
         clh3X4FaO7E+dVPaIkzjuYQ6rWgYCy7TcREMxj9FTtEHVIrBNC7WMi0mRG0xC/OteSdd
         C1/R4QZHF00kkGQgMryvryGiWS362CwqM/AAzrpfnpwSqBS1K6gTk5xatA/MkLA1XlFt
         rk1XZYgoTHO65Z08OlPkfLHOKK1qXdfNoM9BKk13p4mk9tiqikwd55g/A/Er7tyVNzix
         2cgD5RO1f1zeE7i7FrQLJtBpDC3F5lIMEViSu19d4f2ORsGooN/SBGA8cFnJs2h1EA2W
         I1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761130647; x=1761735447;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kk2BPiYFNzn3CXG6RkzldSGrwb1ZpVic8o4pFAU0ZkE=;
        b=BAjo9DCMbMqgZJQPuaQ6kStiHSCsjIeSAdrB+XAAEptzl9Ad1mFQbq8dNTlGoO+2Ce
         gOUXnDAFxFXZy8DzRN7t0Q4JmLDaz/aPoQTmRHInKRWO3dIPQyuTDjwYLos0nnj0xuIf
         Hsm89lzoXpyim5mzcr2ALtB2A1u4RCVs1PLPfRTUquPwjbcqKF5uBIZYTobBurRIaChI
         tUmRgtSQq52fRTUPhES2lLrpCaoopJBX5c4fUmfPjrjm9tFu/urFRq4yp8Ba9oOO72vD
         QkBvMcoD1zBaMG8b4WtMrqNqELK7tkP6h7deJrhI84e7F083A5wI4m8Kc0DA7Fe+N7dL
         J3oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtipRh1SwQDU1zIHGFSSgq2n+JtOc0a/xAe9RmsCXwdFzfKU9Jfr3S7lfJLLcL2PlA4FqiFt1RdJvWvII=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjB6Cn77FXmKhYqT2SyOKb5Vk73aBVIvpO/hQYchnjJr0vqnzB
	zlU/Rey73fdLwU5SyGTkc7Q41l3ERd2G2Am36HWGBIxTKu9Y3PfZnsjC
X-Gm-Gg: ASbGncsdWRlFMmdh7TJr+KCuqJR6ahsxTyd3CtOxvaxVXTgx9ouwiPu5oSsKUojws7s
	zsllTbgwVOI0Bwcmy6hjoN2y1qZllYqtkjSzmK4Q9onymab4XcendvalFtTLGXwiIcvZgI05EJA
	O3egiSmZ1x5RLOu+gwzm6b3+yYdIzuODX9c45dR1E8b0TQTzxnrRS+Nwd546dc88w7627vEF5C9
	IeYjKjK/CMw7rvPzQyNS8jYh1Vx5RgXM5Vs8RtCYGia3NDJfIUY2uap8GcWISZyJjy2+X822acW
	8o0ys7tRj4a1iZiuYo3gaQhjkr3kI/UW6inF9SFf8l2pmsyMbs9STjvnPXPYO5UYNG2T8nFL+dk
	2qz8WYHKA7YJ3WHLUcfz21h4ANHsbowcoTm+4H/GAzEXCSlMv9pQzFdFV6KOYJuCsdHLvNrWnu3
	ftsWB2sK9TLF6IkQ88G3I7hbjI9bJu800=
X-Google-Smtp-Source: AGHT+IFWysXp9eqMZj5Qi90FK5sw1pd9AH0StflzodduEPErD8Q0fn6Hmz60MpZnfpCZjB1sS9bTuA==
X-Received: by 2002:a05:6a20:5483:b0:334:93f3:9b28 with SMTP id adf61e73a8af0-334a8644249mr25233224637.56.1761130647394;
        Wed, 22 Oct 2025 03:57:27 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b35dadsm13346482a12.26.2025.10.22.03.57.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Oct 2025 03:57:26 -0700 (PDT)
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
Subject: [PATCH v2] mm/shmem: fix THP allocation and fallback loop
Date: Wed, 22 Oct 2025 18:57:19 +0800
Message-ID: <20251022105719.18321-1-ryncsn@gmail.com>
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

The order check and fallback loop is updating the index value on
every loop, this will cause the index to be aligned by a larger
value while the loop shrinks the order.

This may result in inserting and returning a folio of the wrong index
and cause data corruption with some userspace workloads [1].

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-mm/CAMgjq7DqgAmj25nDUwwu1U2cSGSn8n4-Hqpgottedy0S6YYeUw@mail.gmail.com/ [1]
Fixes: e7a2ab7b3bb5d ("mm: shmem: add mTHP support for anonymous shmem")
Signed-off-by: Kairui Song <kasong@tencent.com>
---

Changes from V1:
- Link to V1: https://lore.kernel.org/linux-mm/20251021190436.81682-1-ryncsn@gmail.com/
- Remove unnecessary cleanup and simplify the commit message.

 mm/shmem.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b50ce7dbc84a..7559773ebb30 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1895,10 +1895,11 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 		order = highest_order(suitable_orders);
 		while (suitable_orders) {
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
-- 
2.51.0


