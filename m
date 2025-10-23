Return-Path: <linux-kernel+bounces-866312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A18DBFF70F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A345818936A2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AEF2BDC1B;
	Thu, 23 Oct 2025 06:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVGXZ3Xe"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB49285CB8
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761202763; cv=none; b=C5f/een3+dFimhQG2j+B0COXd/CPGPKGAOeFjI6rFe+VavC1Je1pGYKoSC8e/5OYQ5fyeygmfHWzWAS0PGJqEMeMiySq9UIIEQaUn5Odp2/ZqdpIvPW+v+6BSI8WDenm6iEB++uNqjZq3kB/WdNDxZvRbfuG5HBsULlTAyh9x8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761202763; c=relaxed/simple;
	bh=jv3RRiQeAxRj+yS1gIR9ygnBb8z/VVm8giUZt1eG3P0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mVVHc9gRsGPWEFcGE0sk0XQ2BGgkSfSBwYE9ZDca1RnKBqakn9avbTCwudhwwYaRS7jjxRT0jFz1MK/YHF3ppLPGqgOS/1y5se/PjGGxiCvNFVYF4K6u6PHux/sYq04IcWK9LDk05Nto9KQ9nZZEI2q1wR+XUZsWdmZ4NlSwgM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVGXZ3Xe; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33bafd5d2adso478857a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 23:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761202761; x=1761807561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rv8wkF7zXzO22qUjEduk8QMkq+ulYIyp393gGAAnjeA=;
        b=PVGXZ3Xe2ueNZRV4NcXS0RxIZYo6klu4qou5aLo+QN3kCfDUYU/6/7b/sErcAIGJA7
         dX+o1EHbquax9OV3euJvpISoPQNtq0hfAdw6J5sahdOUnoCYtUQ+TDrs/sWHpetjSDE2
         w9893JySCFztXCTMllf5rRPpL7HXOm0qPaKzxbciyjYHaabYJ5/tT7EeGyrzzLKvi/RU
         5S+DSjOOuhOb1/HuOR+LJGvjLow4kycrFgd3tLG3X+dleKh8PMqNVyGCqWBMN9yZdtPZ
         6/K4I36co15nwkry3LYId+DOqyDpwObi77gFmxcOdhHoTU0VxzOWJGT5Pk9bsNkFS0nY
         YsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761202761; x=1761807561;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rv8wkF7zXzO22qUjEduk8QMkq+ulYIyp393gGAAnjeA=;
        b=GzqBN63awZf8j6fayrG6rXjW7OB4b6aO73U8XjrKpdIkLdmVBuLsELqMJvyZWflBYd
         82Nro6X1vT9ecnlwpsmXp4rTGl8YMpbx3rCSVCim6mbVPwyP2keCTaowWuX4qP/HRyvu
         +UZdn/Gwk3faVJp4ldKFotqlV1kjxNo3IBix59svHKH/BbVwh5GOOZTj/G/Y1uc2JTqg
         lRuH0fuzuMUZ4RR+kWjQykB0gnm4ye/1ZjpD+/VXXq1zkMtMLBwXovlp9INPm+/S9Ccp
         QACwKvFjxQdvq+wZnZCOn+bumWK5rDOzMBIagoGxJzVoObdiZyt74Cbavx5PQOYFbny8
         ttQA==
X-Forwarded-Encrypted: i=1; AJvYcCXLD7RMUJUZGbpAdtxnGhnzC53HQNQVJdMkGcR2Asz7zjTVLoxhkwiWqY94QhQZdNvk9w0CG5izlGoje1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywwpl2DqTpeyK5OyjSY1mle+qlwG6DMHdvL+Kpl7HTOiepXB9V
	Es23KLeYSxr6Ytyg4RRJEyk/IQBc0titgiBNlSsRLE4f7gYYwWbFDrP+
X-Gm-Gg: ASbGncs9cBVOQM0sgNKmyEx9qYHYZwV+ARtve0zV2stV7o4eZCHA7oQDb+BzyIdsVjU
	q77ITmiMfo+IDaiwNwbxnISlH6NSlRfyP4icMGoIEBIcdzKeWL60sdJLCWv50vY8K5mkdOu0htK
	phTSJWcjHkqO6xRBw/c75TbiHAD4t7fjFTGP5nhft8kssSXM370FGBfApJqzECylstb/nh9GUEc
	TsQRtgUH34LEUzDdxdxTcj6UqKtx6RjM7/R49zIn2tFbJAmGRjYoCu/nS73LyyQLz1NKg8v4nbS
	f7GNLnWKfrUOh7LoZiVIQqN9TvV7W3TF1Eyr4g/n+QELUh4KdR3uZPWbyXWC+10CDIq3qTveTxg
	ac21Hl+ogwC3RVg9UxlElcbV4cuEU0vqzSV6qkF4k50156yz8CD8+tcQuca68N1XesunrJ/CAQW
	QFvYrJtcXewYpqPQ==
X-Google-Smtp-Source: AGHT+IGY9vl7Ys2QrXyChnMJJ8Hm15T8p66vefo6gmsF42VNf8SOd0Wf86nEbGrndI9aN+e5mM9IXw==
X-Received: by 2002:a17:90b:1dc4:b0:33b:ade7:51d3 with SMTP id 98e67ed59e1d1-33bcf8f78c4mr32616407a91.20.1761202760650;
        Wed, 22 Oct 2025 23:59:20 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fb016f83fsm1351963a91.12.2025.10.22.23.59.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Oct 2025 23:59:19 -0700 (PDT)
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
Subject: [PATCH v3] mm/shmem: fix THP allocation and fallback loop
Date: Thu, 23 Oct 2025 14:59:13 +0800
Message-ID: <20251023065913.36925-1-ryncsn@gmail.com>
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

The order check and fallback loop is updating the index value on every
loop, this will cause the index to be wrongly aligned by a larger value
while the loop shrinks the order.

This may result in inserting and returning a folio of the wrong index
and cause data corruption with some userspace workloads [1].

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-mm/CAMgjq7DqgAmj25nDUwwu1U2cSGSn8n4-Hqpgottedy0S6YYeUw@mail.gmail.com/ [1]
Fixes: e7a2ab7b3bb5d ("mm: shmem: add mTHP support for anonymous shmem")
Signed-off-by: Kairui Song <kasong@tencent.com>

---

Changes from V2:
- Introduce a temporary variable to improve code,
  no behavior change, generated code is identical.
- Link to V2: https://lore.kernel.org/linux-mm/20251022105719.18321-1-ryncsn@gmail.com/

Changes from V1:
- Remove unnecessary cleanup and simplify the commit message.
- Link to V1: https://lore.kernel.org/linux-mm/20251021190436.81682-1-ryncsn@gmail.com/

---
 mm/shmem.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b50ce7dbc84a..e1dc2d8e939c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1882,6 +1882,7 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	unsigned long suitable_orders = 0;
 	struct folio *folio = NULL;
+	pgoff_t aligned_index;
 	long pages;
 	int error, order;
 
@@ -1895,10 +1896,12 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 		order = highest_order(suitable_orders);
 		while (suitable_orders) {
 			pages = 1UL << order;
-			index = round_down(index, pages);
-			folio = shmem_alloc_folio(gfp, order, info, index);
-			if (folio)
+			aligned_index = round_down(index, pages);
+			folio = shmem_alloc_folio(gfp, order, info, aligned_index);
+			if (folio) {
+				index = aligned_index;
 				goto allocated;
+			}
 
 			if (pages == HPAGE_PMD_NR)
 				count_vm_event(THP_FILE_FALLBACK);
-- 
2.51.0


