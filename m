Return-Path: <linux-kernel+bounces-789193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3C4B3921C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02487464C05
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 03:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C9D261B98;
	Thu, 28 Aug 2025 03:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="T1CkEoB7"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1A31A23B1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756350722; cv=none; b=P8bSpRudVzgJDA3lIKvIeEC8iIuXP9MW3qFzwguW1JCIJ6lIUjLRNcLl8SP0IPESua8JOOPBEmgjK7aoI2AUKfqsyhPmpsr6d5mtZRdlvGjeAFnN00T0NGsjLGCuHnGwLAEqf9ci6QKgfre7wRw1zcy/dUQSc3ZgcRhl58GuKoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756350722; c=relaxed/simple;
	bh=oHyApmx4rG3Qu9f9Hwg3ARzl+oYvRW+2+I5zjN5Yh44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lMkEF/tnleclWmemGt+tAOLG1cy6WC21nHe/lhWz8BTUy/beIfKwQYMVIhGKs6z6XHO4Je42pBvWsPnU7p/kX9qrKIf4cWrmO1ujzaG4MLd2fIAlicrCyfgKb1JcNQewYxxfq3DOXM9Ztk2rSdbBod7vl7PZ1dTrKgMiS4fl8hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=T1CkEoB7; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756350716; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zdy1vHL8hoYAu219m92JWTOObDeLeFpLwc8gGqb8B2M=;
	b=T1CkEoB7KrhFJXF+J/4AbRj1G+0q7er568e38h7uJipn8GPhHf8yr9Zo0Y7+8F+ntHWwOUrq784/oHBnI6oyrAM0FU/kFymNhlrOZdbVUpuLVvOlNtseuF5z2A9JNodq3GjGf9rDXFdma7Q3/HhpRzeL/Lu3Brm9DiHdI8gsEn4=
Received: from localhost.localdomain(mailfrom:tongweilin@linux.alibaba.com fp:SMTPD_---0WmlD1C-_1756350383 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Aug 2025 11:06:38 +0800
From: Weilin Tong <tongweilin@linux.alibaba.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: vbabka@suse.cz,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	linux-kernel@vger.kernel.org,
	baolin.wang@linux.alibaba.com,
	tongweilin@linux.alibaba.com
Subject: [PATCH RFC] mm: Use pr_warn_once() for min_free_kbytes warning
Date: Thu, 28 Aug 2025 11:06:02 +0800
Message-ID: <20250828030602.204332-1-tongweilin@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When min_free_kbytes is user-configured, increasing system memory via memory
hotplug may trigger multiple recalculations of min_free_kbytes. This results
in excessive warning messages flooding the kernel log if several memory blocks
are added in a short period.

Sample dmesg output before optimization:
...
[ 1303.897214] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
[ 1303.960498] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
[ 1303.970116] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
[ 1303.979709] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
[ 1303.989254] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
[ 1303.999122] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
[ 1304.008644] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
[ 1304.018537] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
[ 1304.028054] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
[ 1304.037615] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
...

Replace pr_warn() with pr_warn_once() to ensure only one warning is printed,
preventing large volumes of repeated log entries and improving log readability.

Signed-off-by: Weilin Tong <tongweilin@linux.alibaba.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index baead29b3e67..774723150e5b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6412,7 +6412,7 @@ void calculate_min_free_kbytes(void)
 	if (new_min_free_kbytes > user_min_free_kbytes)
 		min_free_kbytes = clamp(new_min_free_kbytes, 128, 262144);
 	else
-		pr_warn("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
+		pr_warn_once("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
 				new_min_free_kbytes, user_min_free_kbytes);
 
 }
-- 
2.43.7


