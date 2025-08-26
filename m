Return-Path: <linux-kernel+bounces-786391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4B0B3592C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4EA2A69FC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B147131280B;
	Tue, 26 Aug 2025 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tGBMBlMg"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F320285061
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756201010; cv=none; b=BKm1ia8GhRbeuQAOWNFtXptu77IQdHvM9kXU2NqWpQh7U0c1akD3G1U6iZJkFK6nxYMABGgILs20cRno0Kv34gOWM4EIt9EjEY47se5vEuee1TR9v0gyyoAjgTVXZZ9jGe1sv70CtovNgk4t6nkyNsZBRKQNqaNCfw6HDBoFVdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756201010; c=relaxed/simple;
	bh=NgcErHESnGkY3eJOfWjZEGqUxJTqkbxdyn0ulGqtxDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YE0dKKmE0PZjcTdaAHo8iFag+JNvYqlek0nVG7ZNiSzVpKH3QFW9FtfIAzF9ZswQA1+NgXgMhtN+BSxkQ96FEDeSV8iK5aUaMhuXYbn4lRqs/BnONE0c2Cs6ykOsCNhCMI9WzNKKLW5KBx0R+oGAkFIqvOXsHRxIeNRn719EJoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tGBMBlMg; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756200998; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=DC7TigxQIJI88XZibBjtJx3Fwr28TQ6z5OzWaFAMjtk=;
	b=tGBMBlMgwggUISSw5srscRWjmcHXG7v0Ls4mYSf1xJkCaJCNeAY5BJDPMiH/adpsTvKkBEkbVvFJ9U2V0OwDAVsedxa541CmirxTHCxByueiQMiGJvQUWGm3Pe3a46gXw7azpT9UWAqms/aUlF4un0xHK13fgVSwXGan19ufSgY=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WmeLDsQ_1756200997 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 Aug 2025 17:36:38 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: shmem: use 'folio' for shmem_partial_swap_usage()
Date: Tue, 26 Aug 2025 17:35:54 +0800
Message-ID: <a2d39608d99cba1130cacd9cffbafc6949193c08.1756200587.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It is more straightforward to use the term ‘folio’. No functional changes.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index a360738ab732..b3c6de84dd27 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1006,15 +1006,15 @@ unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 						pgoff_t start, pgoff_t end)
 {
 	XA_STATE(xas, &mapping->i_pages, start);
-	struct page *page;
+	struct folio *folio;
 	unsigned long swapped = 0;
 	unsigned long max = end - 1;
 
 	rcu_read_lock();
-	xas_for_each(&xas, page, max) {
-		if (xas_retry(&xas, page))
+	xas_for_each(&xas, folio, max) {
+		if (xas_retry(&xas, folio))
 			continue;
-		if (xa_is_value(page))
+		if (xa_is_value(folio))
 			swapped += 1 << xas_get_order(&xas);
 		if (xas.xa_index == max)
 			break;
-- 
2.43.5


