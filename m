Return-Path: <linux-kernel+bounces-777266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6EBB2D797
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CE41C252D9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C5D2DC34E;
	Wed, 20 Aug 2025 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YZBXdtmb"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386D52D94AC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680866; cv=none; b=bt2OJRWm7UZnoNCakPrJvpHQcMMlC9SkQmOhiGLQq1T295uAjr2SEiyywGcyhhUrA76lypLJOiHtgknTXf/aeayigUuoRJPZh9+H09ozLEeySP2qoN+zWfahFgm7H+Rd8+y11IR8DR3/6L3VcOyFHSR3KOsXQFa9OYNW7TYfLpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680866; c=relaxed/simple;
	bh=mCTblTkWY/P/L2IRDLbm+6ThRwSwTwsbNqN1g3D8a5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecO1CLb/NQjVh3QgsSs9U3c6Ju3aW1ZUt05iRIApgtnDKVw7nYAoCoi7oWPFZ4fzpHq3nb0zcc/MEV5LlcTrmFDCap71POJc/CCcaq8+REuHnyXH5LsfeH/wba0Qpn0YfwXGatKh6dhojAzg2a1YoYewpgiMEIrnjG9tfwFhRgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YZBXdtmb; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755680854; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yzdqgUo48S+1eTljuJiSw1fVT7iNeD7IfBQzpt10nJg=;
	b=YZBXdtmblAJH1wxXxOsOBaKsfY6H7RkX8x4IbJNFyxQsutySbICgwULl0BznFT/Y/+CypznHd3sT+irOHRV0sHRJ0ptWu2YFMMdsD8/tH8EVeQEOLMVJ2sM8K3Fg/OsLP7BA2dNPxNV8LSdwnJNRsO/DMFEBJnSIb3z1ZcGo0uk=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WmBYTxE_1755680853 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Aug 2025 17:07:34 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 01/11] mm: khugepaged: add khugepaged_max_ptes_none check in collapse_file()
Date: Wed, 20 Aug 2025 17:07:12 +0800
Message-ID: <aa2db6af6bb2124ef59ad5665951e47806c00a6e.1755677674.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1755677674.git.baolin.wang@linux.alibaba.com>
References: <cover.1755677674.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to the anonymous folios collapse, we should also check the 'khugepaged_max_ptes_none'
when trying to collapse shmem/file folios.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/khugepaged.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 5a3386043f39..5d4493b77f3c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2125,6 +2125,13 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 					}
 				}
 				nr_none++;
+
+				if (cc->is_khugepaged && nr_none > khugepaged_max_ptes_none) {
+					result = SCAN_EXCEED_NONE_PTE;
+					count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
+					goto xa_locked;
+				}
+
 				index++;
 				continue;
 			}
-- 
2.43.5


