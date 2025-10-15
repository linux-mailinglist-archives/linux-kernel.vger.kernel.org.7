Return-Path: <linux-kernel+bounces-854204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B12C9BDDD0D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702F13BF014
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DF631B107;
	Wed, 15 Oct 2025 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j6rxyh97"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2DD3176EB
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521165; cv=none; b=hgkaHxeVxXREWejH6/NhV9rBu69vml14kRMHFkPEX9ySmaw13YBFpra9rHkTu1EUttWR7me/jayUd7rxBXeG+Srq3iGmZ6xwjRrQcLPN59jld96FCz9O02bq/PJ2WD55UsJL7yv7mqpi4sB/lmXER4IDyjUfOq4o732El5m2HYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521165; c=relaxed/simple;
	bh=hiwCsErQ+PIfgA08m7VjkmglXdrmoBkKbiG0AgiTCu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=np56mr9XcgN1pgnFI4V0RW0G9gQcvplgdx5l+9sKUB0o/Bk2tei2Gr2PDmGVyIDPK68qm5VUR3uvqubf24qtp5TOcmSdjoEOGNBn79qAf/XtWpohGStUxxdiITfQ8rMC3Xdn5Zkj+uu/jvf25ocM5we4eC7RmzY3+bgt9eE3gFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j6rxyh97; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760521160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ur1d4sLkDam2tvoH0vVKlEKqUTS0tNi3WqMUYtOXl7U=;
	b=j6rxyh97ml79IjAgqiQnQzHMMd/EofCDZYKUXuggEKW0nvK/nE6EdKR1Ejhb4cm1frKw3d
	WEmu6iCqO3/hLtVpu9L4uJoQCnopALzM1CltFYyxinEFljti5uaX4R91XUqKzWZAZXOLCB
	jW/9/bfehQT63Lb8EIfKRregnhPVdnA=
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tools/mm: use <stdbool.h> in page_owner_sort.c
Date: Wed, 15 Oct 2025 17:38:50 +0800
Message-ID: <20251015093851.109663-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

Use standard <stdbool.h> instead of manually defining bool, true and false.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
---
 tools/mm/page_owner_sort.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/mm/page_owner_sort.c b/tools/mm/page_owner_sort.c
index 880e36df0c11..894a765652ac 100644
--- a/tools/mm/page_owner_sort.c
+++ b/tools/mm/page_owner_sort.c
@@ -13,6 +13,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -23,9 +24,6 @@
 #include <linux/types.h>
 #include <getopt.h>
 
-#define bool int
-#define true 1
-#define false 0
 #define TASK_COMM_LEN 16
 
 struct block_list {
-- 
2.43.0


