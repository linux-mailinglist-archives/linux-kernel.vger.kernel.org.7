Return-Path: <linux-kernel+bounces-761858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6CCB1FF5A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611AE189AB07
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E657F299AA3;
	Mon, 11 Aug 2025 06:26:21 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A4C2472A5;
	Mon, 11 Aug 2025 06:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754893581; cv=none; b=Y8NDO9QkLphJFSJLwao45Ffy/V5Dq8G3y2krTAMzsFpN2u5F2IliejzSiL7uoJ6PbFdn0bwR8Rc+DBBIGUVlNPzZOiXhsho/vHFQ9cwnFnq2VWqW5DPxrgAa3gLICUrxhhXjnP/Or9JfjBJjZNpChwk1mCgAV0ajzEtxfBamMTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754893581; c=relaxed/simple;
	bh=PdUO6c/4PO0IFVwJ3l9c3pww0IxYR3yCySqdFNXTSAI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k96Bal1+QZ4059b0LZZHYtOeOd7ECuGjyll+jAAXKjI0FVNV17BBIm0RtsmSOoJNdp1AD/Iby9wjX3gz/aZ2eNsQCv6OmHfW18XUN1UQ48htMcHMw1aryZ1dNFzBemsvoVloIZr2Nu378/AWBXGRYWQUjl6OQfgW83nK43xQ6xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
CC: <dennis.dalessandro@cornelisnetworks.com>, <jgg@ziepe.ca>,
	<leon@kernel.org>, Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH] IB/hfi1: Use for_each_online_cpu() instead of for_each_cpu()
Date: Mon, 11 Aug 2025 14:25:34 +0800
Message-ID: <20250811062534.1041-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc11.internal.baidu.com (172.31.51.11) To
 bjhj-exc17.internal.baidu.com (172.31.4.15)
X-FEAS-Client-IP: 172.31.4.15
X-FE-Policy-ID: 52:10:53:SYSTEM

Replace the opencoded for_each_cpu(cpu, cpu_online_mask) loop with the
more readable and equivalent for_each_online_cpu(cpu) macro.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 drivers/infiniband/hw/hfi1/sdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 719b7c34e238..5cfa4f8fbf3d 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -990,7 +990,7 @@ ssize_t sdma_set_cpu_to_sde_map(struct sdma_engine *sde, const char *buf,
 	}
 
 	/* Clean up old mappings */
-	for_each_cpu(cpu, cpu_online_mask) {
+	for_each_online_cpu(cpu) {
 		struct sdma_rht_node *rht_node;
 
 		/* Don't cleanup sdes that are set in the new mask */
-- 
2.36.1


