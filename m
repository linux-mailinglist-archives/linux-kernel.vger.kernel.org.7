Return-Path: <linux-kernel+bounces-854112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC375BDD916
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155D11920959
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EC931984A;
	Wed, 15 Oct 2025 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kMBfnr5Q"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BF02D193B
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518740; cv=none; b=Ah6b+BKe+f/3kgGOzi4+NxzWTCB0Ikigh5cPizlUBc6l6NbL7G8NRbf5+FuRsRu3+08eDT9go2crXs702MPqV0iVri8LiK9ty6iy5EFtcohwC2raKVLTD67ZeC3Cv3emal0tnKjCucGYHudkmD/U8yLXn3+1yqcp2wptzoLR6fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518740; c=relaxed/simple;
	bh=rXqmF5RfVHN9GSb/5QeFBUd7Xwa2BbZ8/4+DXsEm75s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EnsfsOLYCERAyHvj0yv1BsRDzBZBj3xOBemseuDbzf20MUKlVpHRBKftdz3XPS78e6+wWAAKCouVp0knjf0x8VYcpX1DrSNA+F/FB4Pz6w/pXMTeaz0BWvePp4rPCxrWLwNC9of1rpmDNPwDW8T5/U8Bz5HaJ8kSz67PPKfVkiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kMBfnr5Q; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760518735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z6GEbOuJoC554lGHBLYuF53j0sRi/iooljPh8BTRXkY=;
	b=kMBfnr5QlX2wURQI43A8aMSWif7BZDWTzOc+5iLw3k+cb/clwblt1cctZqGsG9itxt9xpZ
	OAo5lmlyi+TQMmCMyKdEAHmgCLjzSwlwGAAh5TtYevD3Klpd+P/dJfnjJSzAIjadQwyGTQ
	Q6KbMjHuxNFqYbgm8KsWkmwe6gG/Hg8=
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/mm: use <stdbool.h> in page_owner_sort.c
Date: Wed, 15 Oct 2025 16:58:41 +0800
Message-ID: <20251015085843.104443-1-ye.liu@linux.dev>
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
 tools/mm/page_owner_sort.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/mm/page_owner_sort.c b/tools/mm/page_owner_sort.c
index 880e36df0c11..cbd195d7b5da 100644
--- a/tools/mm/page_owner_sort.c
+++ b/tools/mm/page_owner_sort.c
@@ -13,6 +13,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -23,9 +24,9 @@
 #include <linux/types.h>
 #include <getopt.h>
 
-#define bool int
-#define true 1
-#define false 0
+//#define bool int
+//#define true 1
+//#define false 0
 #define TASK_COMM_LEN 16
 
 struct block_list {
-- 
2.43.0


