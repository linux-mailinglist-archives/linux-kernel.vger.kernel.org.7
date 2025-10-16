Return-Path: <linux-kernel+bounces-855539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A7FBE1914
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4F719C68D9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A44243367;
	Thu, 16 Oct 2025 05:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F8SavXB8"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0514F524F
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760593783; cv=none; b=HsKWBQUJ2KWDf14y9eNPNr3ymqo8gR+DUd7SPcOHyZwyaw14E2WlGT/TCuf7USuIfTw9nERgnbeEXtDX1ZyWItMn0/ksNGe1xaL+G5MBaqGENvNaacQ7QFFo4RxIG8X6O1nL+NfYQemz0WvcANykutRMbWaR0XWr7tAs7yX8224=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760593783; c=relaxed/simple;
	bh=FeH2ILsi8RigrWTKi4rZwraUZRbqydO1TN/E4Wsb1NM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MhimC+3CF/tw19NaLRPceMuHHbO2yaC+lY5hSR/oViJ7YjtKzPPWOY7kpZFK6oc0if8gBPg90O/ML02GLBLUDbIgWIYrgKv5wNGug3QDuUHntQvuUMVqxwqNpteU5SJjNgDiChCz7kEfq4UIMdHx3NEC+p2XcvJ8xsejZDHHlAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F8SavXB8; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760593774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EFi/2T+JfX3yrnVTv+ZbY4H4bdONoS55M7+1hOejhnA=;
	b=F8SavXB8nlOB2ONHaUbOYK3T3TF0cql2RjsVnXIRw44j0XDXkxtkV1gbyE3R1E3PxK2U7I
	0XWV/LSCy3sl3yl+YNGMbRFkfyqhzl6qkO9wgvWPyIGDi16IUcaSR21zuqD83N/IjDn031
	ed2sPRArgdY/G0EnKe7R135bMGaGNgs=
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/mm/page_owner_sort: add help option support
Date: Thu, 16 Oct 2025 13:49:25 +0800
Message-ID: <20251016054927.138510-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

Add -h/--help option to display usage information and improve code style.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
---
 tools/mm/page_owner_sort.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/mm/page_owner_sort.c b/tools/mm/page_owner_sort.c
index 880e36df0c11..202eafed66a9 100644
--- a/tools/mm/page_owner_sort.c
+++ b/tools/mm/page_owner_sort.c
@@ -669,14 +669,15 @@ int main(int argc, char **argv)
 		{ "pid", required_argument, NULL, 1 },
 		{ "tgid", required_argument, NULL, 2 },
 		{ "name", required_argument, NULL, 3 },
-		{ "cull",  required_argument, NULL, 4 },
-		{ "sort",  required_argument, NULL, 5 },
+		{ "cull", required_argument, NULL, 4 },
+		{ "sort", required_argument, NULL, 5 },
+		{ "help", no_argument, NULL, 'h' },
 		{ 0, 0, 0, 0},
 	};
 
 	compare_flag = COMP_NO_FLAG;
 
-	while ((opt = getopt_long(argc, argv, "admnpstP", longopts, NULL)) != -1)
+	while ((opt = getopt_long(argc, argv, "admnpstPh", longopts, NULL)) != -1)
 		switch (opt) {
 		case 'a':
 			compare_flag |= COMP_ALLOC;
@@ -702,6 +703,9 @@ int main(int argc, char **argv)
 		case 'n':
 			compare_flag |= COMP_COMM;
 			break;
+		case 'h':
+			usage();
+			exit(0);
 		case 1:
 			filter = filter | FILTER_PID;
 			fc.pids = parse_nums_list(optarg, &fc.pids_size);
-- 
2.43.0


