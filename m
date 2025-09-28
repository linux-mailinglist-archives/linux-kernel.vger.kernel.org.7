Return-Path: <linux-kernel+bounces-835204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB85BA67F3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5083D1897A90
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 04:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D104E2222C4;
	Sun, 28 Sep 2025 04:49:25 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A429F221DAE
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 04:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759034965; cv=none; b=C3erqtmIh6jmZFsPe+CnCjek3rnxSWCJ20bIorH9u3l4htFEuQYvg6Lu2XG/w6UP6a4Pj8+ej0Zz8KuanhjKqB9rhcrgkHaD0ry9SxvZ6rMmJHJAT7Bo2O2cOYjHud24L/yc6ydpzLN01GXhdtwFT/t4B1gH92BBzA+kKe9aOFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759034965; c=relaxed/simple;
	bh=3JXHdTFd0Do4NsJQmtnD90PGDnc76HJueRPgFM3FauY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NqUJcUaR2TGFj7F4fIyZkCySQVuGAeniBL4e6THzMOXfbK3dynV0DhbFNhEDDlk+b+TkAglsgX/8wy1wDQbtv0PCkRs2ukCn0c5xV71fEKRTg72QKFKtYCLIYmPYls+KnvqWgg7nkz/MG6Rfq0RHv3NgeMj0NllIQx2jfNOaA/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so2933693f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 21:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759034961; x=1759639761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DyUaaqdWAgLg9ININm7xedY+UnymRaRfwlVA8p6wolQ=;
        b=PupmkHR2N+Iuej99WUtanF/H7Ql0OeW4mQzLEiuf+1Z+qgnsbIKRQ7aL4uTE2ERyU6
         fwAn4+thq7aHj5668/vaLk3RXOUQNAnDiRikRZE7br53AmYQd0D+FwdVAR7uIM/jYJI3
         Xevg97Hr5UruLkwXaN83wAIoEiFM61HxNBB2yGTqoFYGZeaAX7ZJBXKfUZOtvpd8B13J
         cFyDrT67eFeJveR1qI7UzxU5BWrda9LBrQa3+rkwnmcY9U3DGGnfqvZHmEyi71sfXizZ
         UUsFezMWH7eIR/wGAafWwSw5OPJqME0iu5ZoOak3Dj2fHWnUxpW6f1xexWYFcCzQxtVG
         ZUgA==
X-Forwarded-Encrypted: i=1; AJvYcCUAlQwoJ+vbyd+H5171Wq+O0Ll2bVtdCFgm6m3EMD9ION0Umx5BbcKgAzvKGdmaFQjcuI1z/GEsbHSzZz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqn+ieR15Y3bRHEUp6EIOn4/aCKZwk+J2kqnFcUnaxkyRxnWtY
	rCOqQIkmXvdLsaMsLAikn+EbfRyRTLB96iBL0mynFbwKunZjpijw15t4
X-Gm-Gg: ASbGncsCe+DVq5qLU5U2SJAL2xmsYLKAriNB10RX+/70jqWpE3yD2/v+VSbqDG4wgO9
	oqEkmgUiWl107/fU4sGbKbl9Pj5MVCs62Q/jM6DDfQ7lxXpRLqld7JvcOa4pOfftxme99r5dlWG
	UHPundBPLl6P0kOuX3ApaaSlQkVsQ9dmkPKMLYyipIzCww3PGrMg1QC4DmuscI4/sfmSE9B8qyb
	/YlW8/J07FKLROXMP3ZzvSMlx4WFiZl07auTsBQmmchOVJR5Pt4v+0gyrPdEK6AmqhgHOPPfDyC
	5lhbtuGqvto1tllIQa3lHEglAuu9TEZFjtbJKVNuvv+sYPDo+lMkwgZ/zIzyywgzDvoZM2x1xPq
	UNVh5wQs910J/DuTTyLkaHODIZDZBxYOYSg==
X-Google-Smtp-Source: AGHT+IFtXLQOdcvQ7Xjrg3v0c2+UOl4vx5bR+h7AWQ6ssWZLLcWyTpq2xRAkUoQVnuyBrbH3ylk2aQ==
X-Received: by 2002:a05:6000:2dc9:b0:3ec:ce37:3a6a with SMTP id ffacd0b85a97d-40e4458ce65mr11243196f8f.22.1759034960758;
        Sat, 27 Sep 2025 21:49:20 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a09:0:1:2::302c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb8811946sm13119628f8f.18.2025.09.27.21.49.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 27 Sep 2025 21:49:20 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	npache@redhat.com,
	riel@surriel.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	harry.yoo@oracle.com,
	jannh@google.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	usamaarif642@gmail.com,
	yuzhao@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ioworker0@gmail.com,
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH 1/1] mm/rmap: fix soft-dirty bit loss when remapping zero-filled mTHP subpage to shared zeropage
Date: Sun, 28 Sep 2025 12:48:55 +0800
Message-ID: <20250928044855.76359-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

When splitting an mTHP and replacing a zero-filled subpage with the shared
zeropage, try_to_map_unused_to_zeropage() currently drops the soft-dirty
bit.

For userspace tools like CRIU, which rely on the soft-dirty mechanism for
incremental snapshots, losing this bit means modified pages are missed,
leading to inconsistent memory state after restore.

Preserve the soft-dirty bit from the old PTE when creating the zeropage
mapping to ensure modified pages are correctly tracked.

Cc: <stable@vger.kernel.org>
Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/migrate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index ce83c2c3c287..bf364ba07a3f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -322,6 +322,10 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 
 	newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
 					pvmw->vma->vm_page_prot));
+
+	if (pte_swp_soft_dirty(ptep_get(pvmw->pte)))
+		newpte = pte_mksoft_dirty(newpte);
+
 	set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
 
 	dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
-- 
2.49.0


