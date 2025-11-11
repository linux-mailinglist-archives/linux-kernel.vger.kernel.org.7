Return-Path: <linux-kernel+bounces-895399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C4AC4DA91
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A1C3B3999
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBB92DA757;
	Tue, 11 Nov 2025 12:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="L+Uok/U3"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7D5334C27
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863812; cv=none; b=evYGN6EskKjC3109AaRheaQ206lCeCcqm9iLMXj3Lxkopd0hpCiGAXL8OVC88JvQXncP98F0rWFg00l0FxeAqVcNdoWsjAWqHrj47r6RKYF7rfFiHE7fbr0Ir6W85C/NpFetXrL/YEz3+5ZGwg8oPXeiwHERlNrODTkxuTKrXZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863812; c=relaxed/simple;
	bh=kEhFo3gqc6X0+xqt3xF53G+Rrx+RsAWCAae5T9JJZzI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TefVB1RlqUeTztNXBnjN38xhB8ZpXv2qytakmQmiipBa1bFJNPD847K23X3EWMHB0xETZIpBkJ+KyHZ7dr0rusd5eIEjeUop9F3M0HyawB3rCGjPhF6BbQy8KmMWxuhIU+EF1rZdJXke7hyqr5TQDGcB5r5Pnui4Xh+TWwtQ3VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=L+Uok/U3; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Py
	iYxn8lL/DlnyD5mwmLoz2n8Dhjad+J4FY48YwfKxc=; b=L+Uok/U3xP4tFRHyB/
	MQP3IVxlcWwswIm1QTvI/6ooruHjXapLNpH5rpN/8l0IYlPLKHNOwsWWmZXK/l/L
	2UTuDJ7hyDkIpeiFv1e2nJF4tO0iGNbFeCu+pbZ0EEyz8VcxgUyU0EtbINMUqTDP
	JF0fIarI9I9nY8OqvurAr8aW0=
Received: from liubaolin-VMware-Virtual-Platform.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAHGcRvKhNptqpXDQ--.34713S2;
	Tue, 11 Nov 2025 20:22:09 +0800 (CST)
From: Baolin Liu <liubaolin12138@163.com>
To: vbabka@suse.cz,
	akpm@linux-foundation.org,
	cl@gentwo.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	harry.yoo@oracle.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: [PATCH v1] mm: simplify list initialization in barn_shrink()
Date: Tue, 11 Nov 2025 20:22:05 +0800
Message-Id: <20251111122205.29940-1-liubaolin12138@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgAHGcRvKhNptqpXDQ--.34713S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFWfWFyUXF1UZFyDAr1DWrg_yoWfKFc_Zr
	yjvr4kCr15J3s7Cr1kuFn2gwsY9r1vg34xKrZ29ayrtryUCan8uFWDZw42krZ8WrWft345
	A395AasFyFn7GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjEdgtUUUUU==
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/1tbiUh8DymkTI7SnDgAAsA

From: Baolin Liu <liubaolin@kylinos.cn>

In barn_shrink(),use LIST_HEAD() to declare and initialize
the list_head in one step instead of using INIT_LIST_HEAD() separately.

No functional change.

Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
---
 mm/slub.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index f1a5373eee7b..0ab5d87305af 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3011,14 +3011,11 @@ static void barn_init(struct node_barn *barn)
 
 static void barn_shrink(struct kmem_cache *s, struct node_barn *barn)
 {
-	struct list_head empty_list;
-	struct list_head full_list;
+	LIST_HEAD(empty_list);
+	LIST_HEAD(full_list);
 	struct slab_sheaf *sheaf, *sheaf2;
 	unsigned long flags;
 
-	INIT_LIST_HEAD(&empty_list);
-	INIT_LIST_HEAD(&full_list);
-
 	spin_lock_irqsave(&barn->lock, flags);
 
 	list_splice_init(&barn->sheaves_full, &full_list);
-- 
2.39.2


