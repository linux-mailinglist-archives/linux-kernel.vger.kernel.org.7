Return-Path: <linux-kernel+bounces-751491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E56CB16A43
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37FB1AA2B0E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 01:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D47B1865EB;
	Thu, 31 Jul 2025 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TJovK3Wk"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CE717CA17
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753926842; cv=none; b=MwdIQAw4V7B7BxKFdF6CPYrVIG5rDmKhDPCndQ27dmxjvaF5HnDjGFm84mMyvE/tr2EeCm1/UAtvGihwsYQhK8zyuUiM4h5+8UGo69DlXyoouf5fAHzlyRKi7QmNB/YItEeP540YfA46ramH86Gvm7eiFmbkUH+cII9VvOKcnZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753926842; c=relaxed/simple;
	bh=5pxmsZhcPbm7r8AQRVFVnUWbrSGgKde+RUbAfCLQ/Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o7M9GfPT5OLw3HqEKwVk3DEDkXKXoFoDBmWOnnqQWNVfXOT23TL5Pu+hQIJ1FluglCJDfOjs1Yza7TGTV1stUoADtTIA1utD4p+Gda6aZPNSpST2E3WuZCt0IR7ylXxUZWWccou6jhLmPYy3i0YYIM6m5gJ+tkjEqfzKohG9+mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TJovK3Wk; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753926836; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=9gSsqsMNfh6LJcBnky2k2FWl7tW2t0BIGDVockm4ir8=;
	b=TJovK3WkuO5dOfCiDLur8dXzs6cSz98yhhZXm+TM3Bv0dN5IIHJdRRzCf1H8qFK54Rr0xy6WX3kP1aoGIdHgxCnqoziX48qF+6+ue+SabZxpIR+oI8lCnJxgdArslN6vfoOAB+wktXmYPoLtz22C2dAWpV+jrKxu/CjiAGqtA68=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WkWNcvl_1753926835 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Jul 2025 09:53:55 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: patryk@kowalczyk.ws,
	ville.syrjala@linux.intel.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: shmem: fix the shmem large folio allocation for the i915 driver
Date: Thu, 31 Jul 2025 09:53:43 +0800
Message-ID: <f7e64e99a3a87a8144cc6b2f1dddf7a89c12ce44.1753926601.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs"),
we extend the 'huge=' option to allow any sized large folios for tmpfs,
which means tmpfs will allow getting a highest order hint based on the size
of write() and fallocate() paths, and then will try each allowable large order.

However, when the i915 driver allocates shmem memory, it doesn't provide hint
information about the size of the large folio to be allocated, resulting in
the inability to allocate PMD-sized shmem, which in turn affects GPU performance.

Patryk added:

: In my tests, the performance drop ranges from a few percent up to 13%
: in Unigine Superposition under heavy memory usage on the CPU Core Ultra
: 155H with the Xe 128 EU GPU.  Other users have reported performance
: impact up to 30% on certain workloads.  Please find more in the
: regressions reports:
: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14645
: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/13845
:
: I believe the change should be backported to all active kernel branches
: after version 6.12.

To fix this issue, we can use the inode's size as a write size hint in
shmem_read_folio_gfp() to help allocate PMD-sized large folios.

Fixes: acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
Reported-by: Patryk Kowalczyk <patryk@kowalczyk.ws>
Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Tested-by: Patryk Kowalczyk <patryk@kowalczyk.ws>
Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Changes from v1:
 - Use inode size as the write size hint, per Hugh.
---
 mm/shmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 41eb4aa60be5..e1e5d5f7f58d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5989,8 +5989,8 @@ struct folio *shmem_read_folio_gfp(struct address_space *mapping,
 	struct folio *folio;
 	int error;
 
-	error = shmem_get_folio_gfp(inode, index, 0, &folio, SGP_CACHE,
-				    gfp, NULL, NULL);
+	error = shmem_get_folio_gfp(inode, index, i_size_read(inode),
+				    &folio, SGP_CACHE, gfp, NULL, NULL);
 	if (error)
 		return ERR_PTR(error);
 
-- 
2.43.5


