Return-Path: <linux-kernel+bounces-777263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC8BB2D78E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E3117C47C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E072DA740;
	Wed, 20 Aug 2025 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QZylzmhq"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585C5296BA8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680863; cv=none; b=YN2Kh5L/n5EvrhoyYbsUBfe/KvsBnp9NlxBSHKf/qln3zo7WuBjXtS4GHeOqXiwRusDmzo9Xp94YNGKxk4MdzUOwk6f9ZZ2jbF4D03UV4OpMtVFX2fy5VETSR5ua4/0iAd74gAxwhNWkg5Uqg3vxswT9JjqOKxg1rSC5WA0fYEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680863; c=relaxed/simple;
	bh=XkuAN/IK+RcGgut3NLuCNGpM4PYJELvfJq41P/X1Kcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwAy9vTN5iqCfldJzDz1jThZjeagrYBT+j4o1KzRe+txf8Jr+o5uPf3wrzz21MFV48eJImVvLRfvx/CCQ88CNcvKtKYC4sFVTYNHHElOHezg4lYZ1HEobOwvEejtZj4XdqObh+mTmwsgYHrDINU0oY+EpSNN8RlE5yJLWxa5EgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QZylzmhq; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755680857; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6PS3i58fU5+0vksauhTWhV82i4mcmoyJ+bQe1x8vgv8=;
	b=QZylzmhqwLE4yxDO92cYr1yNGVvdCdmCOT3x3Jfw79pXUnnREEn1jinfl/M/XZ4Kbeizo8wBAFVkuZRrutcHzEeH6UBn7cLt5TFWNd5ES+W0NhlDzW8c6kEDjzDY/lrmXPTe+XezCFzkpiicYlw/cWGeq0vU3TCgrnEO6roINZ4=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WmBXj5E_1755680856 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Aug 2025 17:07:37 +0800
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
Subject: [RFC PATCH 03/11] mm: khugepaged: add an order check for THP statistics
Date: Wed, 20 Aug 2025 17:07:14 +0800
Message-ID: <7c99eb27cf98615f80f7b14af479a2d1ea56b1f1.1755677674.git.baolin.wang@linux.alibaba.com>
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

In order to support file/shmem mTHP collapse in the following patches, add
an PMD-sized THP order check to avoid PMD-sized THP statistics errors.

No functional changes.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/khugepaged.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e64ed86d28ca..195c26699118 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2411,10 +2411,12 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		xas_lock_irq(&xas);
 	}
 
-	if (is_shmem)
-		__lruvec_stat_mod_folio(new_folio, NR_SHMEM_THPS, HPAGE_PMD_NR);
-	else
-		__lruvec_stat_mod_folio(new_folio, NR_FILE_THPS, HPAGE_PMD_NR);
+	if (order == HPAGE_PMD_ORDER) {
+		if (is_shmem)
+			__lruvec_stat_mod_folio(new_folio, NR_SHMEM_THPS, HPAGE_PMD_NR);
+		else
+			__lruvec_stat_mod_folio(new_folio, NR_FILE_THPS, HPAGE_PMD_NR);
+	}
 
 	if (nr_none) {
 		__lruvec_stat_mod_folio(new_folio, NR_FILE_PAGES, nr_none);
-- 
2.43.5


