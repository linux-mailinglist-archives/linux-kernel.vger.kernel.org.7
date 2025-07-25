Return-Path: <linux-kernel+bounces-746028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9DAB12211
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9BC17FF30
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8D72E5B2F;
	Fri, 25 Jul 2025 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCQJsurQ"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB534A3C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753461223; cv=none; b=CeArKlQujpKe18jRuhtortMdya7Al/Y2Gwp7Qz1EKaIjST5defbcAZHG4rle6Wz8XP7AnpVE7jG6gO4u/lxHKn1N0AgT5PlATAUcsBYXEt/YaADJv/nJtPUJFJDdKHe7wDOO+MM7FRlxcn+DXZfLHFC0mRZg5TpnpHiuSoZFJfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753461223; c=relaxed/simple;
	bh=qz36GnD2yxRt9mAPG+aYKKHmn7X5RPXWQd5xMtzkOCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPsfkWOL7aSPxA0+ep4UmjyWOHXpQDozMi3IuXQQ3RRsgP4Kz4pOGRvcaH4yIKz8G+gMhcnyZ8mbBeksW5yVnxe3r2QZNqIojeKn8+t9W7kh8uBIUxY1O7/hPTbz1TQMBY+UG4ysKirHHHJPnqzEbBWIBkeHOutUY87Wto2Li50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCQJsurQ; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e8db917573dso1839319276.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753461220; x=1754066020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CuSVB39VTwFvp064jrtVS3lbNZPZ0LiRX/EnLFvU1t0=;
        b=SCQJsurQd2/5fOx/f+bWacN29D2KvRJgCOqNiTutJNo4RHfYLn5na0A7dihdOTl1wY
         j0nTkCQ3SGulj5R+yCPrem+YUZ5b4sv/lmA7NVOCx51zDhA+lQ0ruNdwIBkInz3y9DWn
         EcdrTKtkLrtUViueu7lJDfa7wjlX5YqDD2RZhwAde3yV0KMcZPA1C0Nw+uRfs7/+OonH
         H7DOC2gVFSM0YZwrp25qQPt7XZXhD5/EJrBEcd7WVvLWrmnOW8ciT17gHpQY6XuM8Yd8
         APno6Xx2TKvGO08GrA6AvwyctE1qviphMO6fLYBFL+Sr2iMt85AoKz0Q1WpoIOkaqXgb
         bPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753461220; x=1754066020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuSVB39VTwFvp064jrtVS3lbNZPZ0LiRX/EnLFvU1t0=;
        b=DF6pPqSVhOTUuTyo6fqTSi0xXVauVCFtEkmsbyLD22SKbbC1wN0hMjI/2xLRbhZS/I
         cyOS9T6idv8Q+DWv4QkwIzjr2vIo9OZ2kjBqxkhW/N6OLLSIhA2l20sGE4rB1aG28GK1
         Cxpii6voo+kKIGdB8wy9LiJ89PTIeIh7bNAlO6bYW9qMUj5qrNGGd2CAkNIyQbNh3f2D
         FdQ5VSiqQHzsLUq4vygPthMGn7xjRhmbEylNbimgEaL6/UpIRY6oNlkQ7j2g2uu5CW9T
         WwLgplNfkCmNV03AySBJtH6389w5psXf+FC7cyOKnXe5qIsoF5CIP60F5ka5I/v/Vrj7
         343Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYEhZX3aUQgG5lzdL4F5svIQn1wyMletF7086FJmUwhGNxHZNYNBsnpf02fzHbVpwqHvb/WEavEImKIxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA8B+lnS/DzvxeeoG4UUuLDqGGjMZFAQKbDRbFKQSHdci8xDlk
	ner52e/t1C/Q90NnXAKoad4WETUWTHu4p0WeGzo0M9LKQtH22oGGcPws
X-Gm-Gg: ASbGnctolnAYcSySK38ptVmI6/hWmXx/A50uI6O1sw63hHl1oBPbh/5owFy8YyPo32U
	fFjSopBt7AByqP1OyNoR/DlMK5wQalJLqu3q43oKCQy2mmvSLPIIKNOiPfzggD0t35xL0SVX1Ts
	EKlOxk2JPGIg8mUNXDKUeoGa3UNBuJPW7sRHW9dEfO8ruE9EwxqL9RXkwU0Jm27Xb27qfMEYV21
	Nt4Au1eNDo1bbdB4xhl65+DePR1tcQjyrCBunp0itXxdYFSicVM43EyVm+WlBHY/l9yDzMwB6uH
	jxbbFEXZ8C1CTiG194s5rLdaoSKbLP3TyRWps8KSY3yeIe0/jXeln87P1RpvQwADOdRsNB7W7OC
	I8LA4knd58YddNZT5ElHJYwwVKQXfZSWZfH6ScEM+
X-Google-Smtp-Source: AGHT+IFw23rb4EOn1f5E1CRR6PboLxC0Lq7jWPQhC13bhKmS3MQg6viTQTk7iAO7B221UWGTNUczSg==
X-Received: by 2002:a05:6902:2013:b0:e8b:4455:787d with SMTP id 3f1490d57ef6-e8df1228357mr2550580276.42.1753461220113;
        Fri, 25 Jul 2025 09:33:40 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:79b4:320c:b28d:62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8df86ea200sm106376276.35.2025.07.25.09.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:33:39 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: [PATCH] mm/damon/vaddr: Skip isolating folios already in destination nid
Date: Fri, 25 Jul 2025 11:33:00 -0500
Message-ID: <20250725163300.4602-1-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

damos_va_migrate_dests_add() determines the node a folio should be in
based on the struct damos_migrate_dests associated with the migration
scheme and adds the folio to the linked list corresponding to that node
so it can be migrated later. Currently, folios are isolated and added to
the list even if they are already in the node they should be in.

In using damon weighted interleave more, I've found that the overhead of
needlessly adding these folios to the migration lists can be quite
high. The overhead comes from isolating folios and placing them in the
migration lists inside of damos_va_migrate_dests_add(), as well as the
cost of handling those folios in damon_migrate_pages(). This patch
eliminates that overhead by simply avoiding the addition of folios that
are already in their intended location to the migration list.

To show the benefit of this patch, we start the test workload and start
a DAMON instance attached to that workload with a migrate_hot scheme
that has one dest field sending data to the local node. This way, we are
only measuring the overheads of the scheme, and not the cost of migrating
pages, since data will be allocated to the local node by default.
I tested with two workloads: the embedding reduction workload used in [1]
and a microbenchmark that allocates 20GB of data then sleeps, which is
similar to the memory usage of the embedding reduction workload.

The time taken in damos_va_migrate_dests_add() and damon_migrate_pages()
each aggregation interval is shown below.

Before this patch:
                       damos_va_migrate_dests_add damon_migrate_pages
microbenchmark                   ~2ms                      ~3ms
embedding reduction              ~1s                       ~3s

After this patch:
                       damos_va_migrate_dests_add damon_migrate_pages
microbenchmark                    0us                      ~40us
embedding reduction               0us                      ~100us

I did not do an in depth analysis for why things are much slower in the
embedding reduction workload than the microbenchmark. However, I assume
it's because the embedding reduction workload oversaturates the
bandwidth of the local memory node, increasing the memory access
latency, and in turn making the pointer chasing involved in iterating
through a linked list much slower.
Regardless of that, this patch results in a significant speedup.

[1] https://lore.kernel.org/damon/20250709005952.17776-1-bijan311@gmail.com/

Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
Sorry I missed this in the original patchset!

 mm/damon/vaddr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 7f5dc9c221a0..4404c2ab0583 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -711,6 +711,10 @@ static void damos_va_migrate_dests_add(struct folio *folio,
 		target -= dests->weight_arr[i];
 	}
 
+	/* If the folio is already in the right node, don't do anything */
+	if (folio_nid(folio) == dests->node_id_arr[i])
+		return;
+
 isolate:
 	if (!folio_isolate_lru(folio))
 		return;
-- 
2.43.5


