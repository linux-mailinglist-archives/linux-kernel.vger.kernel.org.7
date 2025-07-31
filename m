Return-Path: <linux-kernel+bounces-751770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2BBB16D37
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7392188D3B7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955ED25F787;
	Thu, 31 Jul 2025 08:09:35 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA2E215F72
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753949375; cv=none; b=DRSJr9tMEqGyjMOtzSWDgR9aUNvzk6ATFAQPkjS9HcA0OGkAU6oeC1kqvOCHVf2tdR3Lf8FauuElS+5NwSSDHI+8OpWu+TC7Zs/kqBlgMURDxkreHaalEe9fA7iNXWIznWQ6/zEj1gKJscYOrUN0zHx/vShLbGfUigGodoSJ754=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753949375; c=relaxed/simple;
	bh=9YfBz5jdT9csgCTG03bDWrMgytNzZZHLHXvLclfgJhM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MNdpSGfyPjY+1W0gENWAgufkopgmouCJFB7MnUcVjZHTVN2ImqI7VqiG+0YR5JtyM43HfYSFoEQxit0z6LMxU/22zV2ZTtdE5oXXIyaIctykYwkWZqCPYI0NIvPmfJcOYrr1LiVakZGnOaVpXdlh2wW1h6g6hvOE1xUN445Yfyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <dhowells@redhat.com>, <marc.dionne@auristor.com>,
	<linux-afs@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] afs: Remove erroneous seq |= 1 in volume lookup loop
Date: Thu, 31 Jul 2025 16:08:49 +0800
Message-ID: <20250731080849.3401-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc14.internal.baidu.com (172.31.51.14) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

The seq |= 1 operation is incorrect here because seq has been
increased at start, it will be odd in next iteration and cause
lock operation

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 fs/afs/callback.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 69e1dd5..2c0d274 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -140,7 +140,6 @@ static struct afs_volume *afs_lookup_volume_rcu(struct afs_cell *cell,
 			break;
 		if (!need_seqretry(&cell->volume_lock, seq))
 			break;
-		seq |= 1; /* Want a lock next time */
 	}
 
 	done_seqretry(&cell->volume_lock, seq);
-- 
2.9.4


