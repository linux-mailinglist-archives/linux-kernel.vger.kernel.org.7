Return-Path: <linux-kernel+bounces-803643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B846CB46350
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23897AA0EA3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B58F22C32D;
	Fri,  5 Sep 2025 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZyifgjr"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE932777F9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099657; cv=none; b=Pl130S7l53Q3E5Z2OFSXQcPUtYMKb9K6NZWms2CQ3jchh+ZJ9OIK8gvfKrwdQC+yBW9F9ezMtZgrw9ngXFtil3x3CNeVFbJSfuhyA4wpuDPG6s7NZgVqee5c1LPlPr5cEqSyiKBoB7M8KosVGXNeVYD8rT4NLG/sxpkm83x9Ofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099657; c=relaxed/simple;
	bh=r2PiSmvp7lENt4UzDGlEHexJO+ZJZ3uQ82kgLLOsfyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r80UmQbaeN011DVewH2TxzxT+aZHVGkIjO7MNL0Ad5DkicyhOLq3V+Tt4nsPidHcb457xH+HI7F/k2NyU/6LQlAGD3qtsDlx1wh8uFSW4ahjWUpzKEMBD6k2EE9syZ462WAS1wOQ5Nrd6iBsXgLvtudm0FB1LJXT6WfSLSaqz6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZyifgjr; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-329b76008c6so1995316a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757099655; x=1757704455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mDUEHfmrXgAZbUz97jq88NraGjuVdKEjUr0PaaBBO7Q=;
        b=BZyifgjr1nFAe4mng897L94Ubo+zjSre4oZpgwdKENlERcI3o54Qal/sQQ9MtEzJtd
         582Dek+k+gqYKzy/JjlgjB9T8YYk8Mzg25yMAJZ2oC3SULPly05XivS6mA7pJrvO4aEw
         zcv8hTIFvyzFWm15GR8+NOOoDJAENDMW43Vk0AEmQOmTRGMaay4wwwrcB3GFC6opP7H+
         am0scKMHVEByEtx0K7ZBho4KpaSx+0keH5YzbGzOZOxzwTi+rxovn4R20PWny42CkIXx
         0ze7l2/4xgvRD3q4HfeYNCHxwfo50cfd0sPPcdWDOVun4uz4LuvXeveNEbAU0BP34ZaR
         qquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099655; x=1757704455;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mDUEHfmrXgAZbUz97jq88NraGjuVdKEjUr0PaaBBO7Q=;
        b=X+VnGGAJFRYPGa1oX8E02YRnFyVil2ZPfaMQL6mO+kG8E7+0hl09RzbXm2grYsIdSt
         2PfGkMogzkQNiv0UX/xck45em+KD/j5ZWNMqzOwSBh2wPGnmQI5hTVtMvHplaLJ+OCY+
         hNqT1rYOPK/ps7hZj0P/uBMSFzrAnO9nQpwl5GiSnrWoJfYya0dj/euSyNrxbb9b/HIU
         K7kMgegNG94FtGblAzL+SVUmkRS2xkQ+7q6HwT/F0jrr19J97jfDwM6o29V08vvkYiLY
         Mcr9wXkWFIpQ53BsSvMfjPMo8CvGIRSVfWPcuCX3mCAxg5kZV6QZcLesL+VFZQyhXy38
         nIaA==
X-Forwarded-Encrypted: i=1; AJvYcCXR+RDpyYNhENayEG+lJ2xkEwHHuJDnx+CinjifceoPMAy4lFhuOvDiA3kjH+kuhb4/GTxrf4IJ/th5KO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBWfnpUw2XR8UGYM8vTFgTTBV4T5BS9f1J+0PFzzK6Kl5xfYLG
	m5snOAb0k7fBd/TK/uf7fiIOuBbrBHxbN1lKpgT4ysUYka4a8soBR57N
X-Gm-Gg: ASbGncuQzKEQNo6rNTT390nGT+KBF8jL7nyfdwQmp2wgILNmd0DknVYIx7gColA6MxD
	9EFfvc7nlVAML8m1biqzNneINEvWx1doGFS2HOqT3LbLPlr85OLd6Ws3gMniNOR+3cc7qmOAudO
	9FA9bJDttj+I+VcmZx06zU9AiMd1fx2Cf5AWrqAYBugoW9FSM1W1tWIEdxlJQNWgEd9tJaFpqWG
	HlxPsrgHl3IkczfIUfFhGcxztQoSu3aQEDwEP5T9IfxCGEExeDOFxvwj1tsu7GVDILECRQJ+EGW
	P5WKbjZXF63FCJ0t4Y4UfjwdZMqE4CbarSFrCZ7XoJhI9jWQHWu6ZBcgSSWNO3bq1LzLEg49trr
	J8Nmpt0Y6vkQfSB4kF6mMEJX9tmAEP1UO2i14dye5N+atAt+9Ll3Fs8ts3Q==
X-Google-Smtp-Source: AGHT+IFPaS/I+N/+xz/fo7KOHBQ+1G56h6y7Mrud0IexC4riD+dfbvjDQQ24r7ZekKYjTXvTtyxS7A==
X-Received: by 2002:a17:90a:c2c7:b0:32b:dbf1:31b7 with SMTP id 98e67ed59e1d1-32d43f03db6mr11645a91.2.1757099655135;
        Fri, 05 Sep 2025 12:14:15 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77256a0f916sm15871442b3a.63.2025.09.05.12.14.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 Sep 2025 12:14:14 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 01/15] docs/mm: add document for swap table
Date: Sat,  6 Sep 2025 03:13:43 +0800
Message-ID: <20250905191357.78298-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905191357.78298-1-ryncsn@gmail.com>
References: <20250905191357.78298-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

From: Chris Li <chrisl@kernel.org>

Swap table is the new swap cache.

Signed-off-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 Documentation/mm/swap-table.rst | 72 +++++++++++++++++++++++++++++++++
 MAINTAINERS                     |  1 +
 2 files changed, 73 insertions(+)
 create mode 100644 Documentation/mm/swap-table.rst

diff --git a/Documentation/mm/swap-table.rst b/Documentation/mm/swap-table.rst
new file mode 100644
index 000000000000..929cd91aa984
--- /dev/null
+++ b/Documentation/mm/swap-table.rst
@@ -0,0 +1,72 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+:Author: Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>
+
+==========
+Swap Table
+==========
+
+Swap table implements swap cache as a per-cluster swap cache value array.
+
+Swap Entry
+----------
+
+A swap entry contains the information required to serve the anonymous page
+fault.
+
+Swap entry is encoded as two parts: swap type and swap offset.
+
+The swap type indicates which swap device to use.
+The swap offset is the offset of the swap file to read the page data from.
+
+Swap Cache
+----------
+
+Swap cache is a map to look up folios using swap entry as the key. The result
+value can have three possible types depending on which stage of this swap entry
+was in.
+
+1. NULL: This swap entry is not used.
+
+2. folio: A folio has been allocated and bound to this swap entry. This is
+   the transient state of swap out or swap in. The folio data can be in
+   the folio or swap file, or both.
+
+3. shadow: The shadow contains the working set information of the swap
+   outed folio. This is the normal state for a swap outed page.
+
+Swap Table
+----------
+
+The previous swap cache is implemented by XAray. The XArray is a tree
+structure. Each lookup will go through multiple nodes. Can we do better?
+
+Notice that most of the time when we look up the swap cache, we are either
+in a swap in or swap out path. We should already have the swap cluster,
+which contains the swap entry.
+
+If we have a per-cluster array to store swap cache value in the cluster.
+Swap cache lookup within the cluster can be a very simple array lookup.
+
+We give such a per-cluster swap cache value array a name: the swap table.
+
+Each swap cluster contains 512 entries, so a swap table stores one cluster
+worth of swap cache values, which is exactly one page. This is not
+coincidental because the cluster size is determined by the huge page size.
+The swap table is holding an array of pointers. The pointer has the same
+size as the PTE. The size of the swap table should match to the second
+last level of the page table page, exactly one page.
+
+With swap table, swap cache lookup can achieve great locality, simpler,
+and faster.
+
+Locking
+-------
+
+Swap table modification requires taking the cluster lock. If a folio
+is being added to or removed from the swap table, the folio must be
+locked prior to the cluster lock. After adding or removing is done, the
+folio shall be unlocked.
+
+Swap table lookup is protected by RCU and atomic read. If the lookup
+returns a folio, the user must lock the folio before use.
diff --git a/MAINTAINERS b/MAINTAINERS
index ec19be6c9917..1c8292c0318d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16219,6 +16219,7 @@ R:	Barry Song <baohua@kernel.org>
 R:	Chris Li <chrisl@kernel.org>
 L:	linux-mm@kvack.org
 S:	Maintained
+F:	Documentation/mm/swap-table.rst
 F:	include/linux/swap.h
 F:	include/linux/swapfile.h
 F:	include/linux/swapops.h
-- 
2.51.0


