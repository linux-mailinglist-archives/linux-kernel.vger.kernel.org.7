Return-Path: <linux-kernel+bounces-813146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13643B54129
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3CC0A04D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE0A230BE9;
	Fri, 12 Sep 2025 03:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DhWVCziV"
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D8C26CE2E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757648737; cv=none; b=IwFWhPfPJ7dpjgpykXI/xoA8GlRPjXIQtN7JgfGFt63DMcnYDGf6ipzxrLtfNNmFsPHJiFmQySDxDPtvgg14kiRUqj6C9v4e9xB9aZuUbu9m1Qy0wKPHugI+S1MTHEo9r5taWlxjHdK/gwV4xNbpool8b+LJlkK4uR13GEMMG/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757648737; c=relaxed/simple;
	bh=QCFwWjRd69kqrynpb2Qd+zu5+Y3V6vm8lr92YBRQdo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D6559HgrvRJguHFj2y4RkJ4CXIMVw0JLM7xsbq1FGI3hVfgyreSRqhfeeiGu6KtkB244myiV8hV7ZNHV7pXJjcQKk/MaQdNdaMKopuIxRXlV6pZX0KuacB0Fis2NbEFmhcKqopzO11DpTlRUdBBZJxYWQJCcDbUNBZM5321QS+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DhWVCziV; arc=none smtp.client-ip=47.90.199.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757648719; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VhR2dfGJ3MJkrrgv8n7mSFnqfZscAqFtNuOqBN+ob4U=;
	b=DhWVCziVIZLAE1GABMJc4uBJjMTjXDh9OPH09Ts9hb0Af0kIOuzWyDtU5wEPAt718IhsHgmR+zLOoVyVBKEfjerOFIiYcVLUXj3NKxmvGluV6seMh/Kbof8KFsmLR5zvIiELXJi5e0Fk5gDw7I+i6YSgnEvEc7CYaZNoU6mMymA=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wnp5B8A_1757648717 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Sep 2025 11:45:18 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org
Cc: david@redhat.com,
	mhocko@kernel.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com,
	hughd@google.com,
	willy@infradead.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] some cleanups for pageout()
Date: Fri, 12 Sep 2025 11:45:06 +0800
Message-ID: <cover.1757648598.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we no longer attempt to write back filesystem folios in pageout(),
and only tmpfs/shmem folios and anonymous swapcache folios can be written
back, we can remove the redundant folio_test_private() related logic to
simplify the logic of pageout(), as tmpfs/shmem and swapcache folios do
not use the PG_private flag.

Baolin Wang (2):
  mm: vmscan: remove folio_test_private() check in pageout()
  mm: vmscan: simplify the folio refcount check in pageout()

 mm/vmscan.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

-- 
2.43.7


