Return-Path: <linux-kernel+bounces-835221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D496BA686C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844B7189577D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5369D2773DE;
	Sun, 28 Sep 2025 05:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cgZ8tCEn"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B130628C874
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 05:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759037857; cv=none; b=TZ1xgv/LbWZ/Ph6WR0QDOKLJJMiAGJZ1O4QSIok1jxFwqstKQBUO78yBJgCDqLdcNjJe9rDeoh1RuFpiuG29jZGeid9pUmTjQ7n4pPVd5QhcHAs7hJYRkZy6kQmTd0zKw8YnhMy7AHPYCQIZfBVLQMZrj9+3IbbHTmWxJ07lBxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759037857; c=relaxed/simple;
	bh=7bjA7esbKLfbNKm7N0blWR/6LMLQp5Zm2JjhopbxQdQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=oWkPI9bs0lo89vllr70TfTzGDom1J4tGEJqtDH3XYAf3sgogy22TljCKyoMq1uookgu/gPh0Hnrtq7zf7C5ig/WqIAPXz74pYmMWYW389N7EXk2u9gmIma0CIk34Pl/934R4EEAs2Hx68CJR3CU9WGtYcMXLt9wWzbmpSN8tJCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cgZ8tCEn; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7811fa91774so1397151b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 22:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759037855; x=1759642655; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbNj4M1kQE90OhLGOYogUCLDjUCje1Z07F5N02X50EY=;
        b=cgZ8tCEnHt4esVz+JPyWh4dmnwYTRyc106vyZZn9lwglcml3ljwX7MR+zohT8Jqe/B
         7SPeZPCYGCZaqPFmbYpJDSBAB/ewmjhfeecixQLtF0P+wlZZToUNS2398V7oglJFhRKt
         +pTjFTUuYSWWHMR7rd/leY+9N4NOSrnfvguEpORjn9lp6ifadUbc0TKEZR0CnbR7Ha8A
         Bi9RZuF6ML9l/pvrb50l1Gqwj+NC+jklaE+lS0tX0amh72+/hFlglNXUW3kapGNIVsBV
         a9SgGHbi68kOq53aKVIiwlBfGL8uPAGoR7+n6c3MvGT9Lk97t+X0qi254O4P6ntITxBT
         iO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759037855; x=1759642655;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbNj4M1kQE90OhLGOYogUCLDjUCje1Z07F5N02X50EY=;
        b=sdIoHMFSN4jdbF+W4tWkMWZyOt/2ycWvxugXpTdVgtwbmdLGm+yL9HxQboi5dQ7UxV
         dRMFwSfuTL4YnbijnjuwzrqcuwiCohcvkAGg9QoJMTdHo7F1o5Dkv5UGU0YgfbFlkCCo
         SF5ji50QtF+Np3Q67xDWSFt2NM2P83AJ8TssAKXIjIuPxLEUW+sga1xgjpBbPqsYWEhv
         KDDVqIIzYDO08yuQIew6LFSxpjkzpdjS+td1nfYOPJCSt5fDEHxE4FTJ2Gv467ILkBhp
         vJ69V5u2LP1i0hSj4bQDzTx9ZXqN9RvKJh9ISUrOVDyx5I6fxyNKsySZak6nW5JZp+s8
         FUAw==
X-Forwarded-Encrypted: i=1; AJvYcCVeIl8POvd6ybUxzTyoSXSbYyVaozBcsvPQKVbVQ02n+zDmUxUBdrQnIjssUszYrTiLqj4prbZ5ICsXJpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdcF599/2rDrkAu3aT2H7PeHyhVVhA+lEiaBhRijC7nkr7qkhk
	o4jHubWLfVtVfNu35HNlHj0uTx+BnbLxjZsoeptZa1tNSBOajo9e6+d2D2yF0eGm/kI=
X-Gm-Gg: ASbGncuIvkl1v8yL+QJzWLsxLfuStWZR1qccvBqWfplAg12t+GrNpP0ydrU9IE3clk3
	cKs0MbG0hlpiS8Guh2/XlEKDxF1mlRedUovJKk8QdHvXpWbOmA9md2ZorL8CQdUi3PEoPTaXP2k
	h1snX4HoJwtZCEqdHEjZJ/DlPDfeDifukEDKi/GfFyJ7gMvUQxUg5SHV/kQWfs7jyvfVaTSMGbo
	SPEd9ZqXP76c3JKrRSETCmeGp5CGNN1wH4ouV3XKh/SP5FsuJleS24JdU3eMZis9keb94qDGQdb
	MFSnUd6eLZ40d/5ehbqHp8rblXQGBXZAfXANyuHInT5TTh/D8WL3pjZiWTvaQJUva6+ARC2UYff
	313DWxA+PqNUGxI/E4HiqvSt2aDNCMM3k7smA1OuyDt+YxdMcXfi5UMCl
X-Google-Smtp-Source: AGHT+IGvLznIbL3Jv9TOfO8LsnXAXyMlehxo0ixhNotX4Er9QmV93PBHdrinkAV7m1NE6PfRgvb82g==
X-Received: by 2002:a05:6a20:3c8e:b0:2ff:3752:8377 with SMTP id adf61e73a8af0-2ff3761c70amr4968168637.59.1759037854607;
        Sat, 27 Sep 2025 22:37:34 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c27d3esm8144214b3a.97.2025.09.27.22.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 22:37:34 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com
Cc: guojinhui.liam@bytedance.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] iommu/amd: Fix pci_segment memleak in alloc_pci_segment()
Date: Sun, 28 Sep 2025 13:36:57 +0800
Message-Id: <20250928053657.1205-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix a memory leak of struct amd_iommu_pci_segment in alloc_pci_segment()
when system memory (or contiguous memory) is insufficient.

Fixes: 04230c119930 ("iommu/amd: Introduce per PCI segment device table")
Fixes: eda797a27795 ("iommu/amd: Introduce per PCI segment rlookup table")
Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table")
Cc: stable@vger.kernel.org
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/iommu/amd/init.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ba9e582a8bbe..77afd5884984 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1608,13 +1608,22 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
 	if (alloc_dev_table(pci_seg))
-		return NULL;
+		goto err_free_pci_seg;
 	if (alloc_alias_table(pci_seg))
-		return NULL;
+		goto err_free_dev_table;
 	if (alloc_rlookup_table(pci_seg))
-		return NULL;
+		goto err_free_alias_table;
 
 	return pci_seg;
+
+err_free_alias_table:
+	free_alias_table(pci_seg);
+err_free_dev_table:
+	free_dev_table(pci_seg);
+err_free_pci_seg:
+	list_del(&pci_seg->list);
+	kfree(pci_seg);
+	return NULL;
 }
 
 static struct amd_iommu_pci_seg *__init get_pci_segment(u16 id,
-- 
2.20.1


