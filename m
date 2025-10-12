Return-Path: <linux-kernel+bounces-849401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0F7BD008E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 10:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1EB2634887C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 08:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A73257835;
	Sun, 12 Oct 2025 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZbddNYzX"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7627B79F2;
	Sun, 12 Oct 2025 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760258429; cv=none; b=ZhQRPAp/m/9f3wDZgM4yOdsSEMy5dcu+E8Kir2dVMixzINnnKDUbOg0XFX20xCG9+lunAoWlYfzNW17bgUis+6+2ixdcCAzDckRXzfSdQ5UQN0+TpGnA1ucL7JS35n9Lmjs/LVLxwsbgjz7+7GDnMjtmWWazpeqDm/RURDDGdSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760258429; c=relaxed/simple;
	bh=Jqb59cTQV+C+1BT1Q882TXl01Q52T6wD10sKvxB3OVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ttNm9IWm11NVZ9e19FQ2oLqYEqzKpdHlSKv8OADgiQaiWif7cLsJpzxEAgSP1Xr4J6O50V46vEu++TSovQyd9o4cxwPjtF8nxO6dlCFT+yY1hlnRPD/rZ3vPQFQ7/FlIZyidjJPPGhsr7fcdz5GiZfHs0buPcMtPH10WM/xo9bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZbddNYzX; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ZC
	QZh48Hq1KrwP074ezfu1Hg5jq6qmtAxdjN7qhoNUI=; b=ZbddNYzXk9mSx94rUf
	THyJ9ptjjpfZoKo9o2wFdDFByScE6zE2GK2nsGqxYhvT4BDFsqmFIdFuO6zNwOpH
	60pYlaHeiCwhGk0vb89V+pLE1vbYqdPL7wwNvPcU2AyttlMxr6da1jeYSeqMCrH7
	kJAvxmYwuI0vn/waTc7eGZBmw=
Received: from liubaolin-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3J4xgaetou6fWDg--.27826S2;
	Sun, 12 Oct 2025 16:40:01 +0800 (CST)
From: Baolin Liu <liubaolin12138@163.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: [PATCH v1] NFS: Fix possible NULL pointer dereference in nfs_inode_remove_request()
Date: Sun, 12 Oct 2025 16:39:57 +0800
Message-Id: <20251012083957.532330-1-liubaolin12138@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3J4xgaetou6fWDg--.27826S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr13Ww1rtFW7uw4xZr4ktFb_yoW8Gw18pF
	Z8GF90grs5Xrn8XF4kZan2ya1jqa40g3y8AFyxGw43Z3ZxCrnIg3WUtFyrXFZ8JF4xJFs3
	XF4UAa45ZF4jy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQBMiUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/1tbiUg-kymjrWk--MQAAsr

From: Baolin Liu <liubaolin@kylinos.cn>

nfs_page_to_folio(req->wb_head) may return NULL in certain conditions,
but the function dereferences folio->mapping and calls
folio_end_dropbehind(folio) unconditionally. This may cause a NULL
pointer dereference crash.

Fix this by checking folio before using it or calling
folio_end_dropbehind().

Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
---
 fs/nfs/write.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 0fb6905736d5..e148308c1923 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -739,17 +739,18 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 	nfs_page_group_lock(req);
 	if (nfs_page_group_sync_on_bit_locked(req, PG_REMOVE)) {
 		struct folio *folio = nfs_page_to_folio(req->wb_head);
-		struct address_space *mapping = folio->mapping;
 
-		spin_lock(&mapping->i_private_lock);
 		if (likely(folio)) {
+			struct address_space *mapping = folio->mapping;
+
+			spin_lock(&mapping->i_private_lock);
 			folio->private = NULL;
 			folio_clear_private(folio);
 			clear_bit(PG_MAPPED, &req->wb_head->wb_flags);
-		}
-		spin_unlock(&mapping->i_private_lock);
+			spin_unlock(&mapping->i_private_lock);
 
-		folio_end_dropbehind(folio);
+			folio_end_dropbehind(folio);
+		}
 	}
 	nfs_page_group_unlock(req);
 
-- 
2.39.2


