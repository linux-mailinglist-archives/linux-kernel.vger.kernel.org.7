Return-Path: <linux-kernel+bounces-754637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D884B19A51
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 04:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60CB176553
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 02:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A3821C195;
	Mon,  4 Aug 2025 02:58:11 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 1D22A2E371F;
	Mon,  4 Aug 2025 02:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754276291; cv=none; b=EUfjJHERTPtV392jd21TkYGv7JUA4ncUUaOcdx/LP2OdgEr21Fv4WzF2d4JKEK4hREqgnIYfTVYg12zrGzfWd7Sz5nScDJyVezTzww67fXXJ8Bv/a4akHwSJgWhUZo03DGUQdfh+06LmvUU1Wo4UdFvio2Lsi2OeaH+EC8EYoVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754276291; c=relaxed/simple;
	bh=o1QnEsSp+T6ymD88En6qwH1YK+2Y/eNVievk3YbYMWo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aGCf9sq03tUsXzGCkMbbM+LkWC4PkBk4DGpWXwCYS7c1i3zeSPF9XRq3eD7BiTK3A7JZSvGwBpLl+yvEhoDI2Horl5mk8f3Q9vJriosHdZBq6cVdQpyuLxswXHom8Lf0NoG/Q6FBHJsjC62DPTPbInYP7rQMlRQeUkRbUj3DshM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from liqiong-suma.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 648A860109958;
	Mon,  4 Aug 2025 10:58:04 +0800 (CST)
X-MD-Sfrom: liqiong@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Li Qiong <liqiong@nfschina.com>
To: Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Li Qiong <liqiong@nfschina.com>
Subject: [PATCH v6] mm/slub: avoid accessing metadata when pointer is invalid in object_err()
Date: Mon,  4 Aug 2025 10:57:59 +0800
Message-Id: <20250804025759.382343-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

object_err() reports details of an object for further debugging, such as
the freelist pointer, redzone, etc. However, if the pointer is invalid,
attempting to access object metadata can lead to a crash since it does
not point to a valid object.

In case the pointer is NULL or check_valid_pointer() returns false for
the pointer, only print the pointer value and skip accessing metadata.

Fixes: 81819f0fc828 ("SLUB core")
Cc: <stable@vger.kernel.org>
Signed-off-by: Li Qiong <liqiong@nfschina.com>
---
v2:
- rephrase the commit message, add comment for object_err().
v3:
- check object pointer in object_err().
v4:
- restore changes in alloc_consistency_checks().
v5:
- rephrase message, fix code style.
v6:
- add checking 'object' if NULL.
---
 mm/slub.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 31e11ef256f9..972cf2bb2ee6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1104,7 +1104,12 @@ static void object_err(struct kmem_cache *s, struct slab *slab,
 		return;
 
 	slab_bug(s, reason);
-	print_trailer(s, slab, object);
+	if (!object || !check_valid_pointer(s, slab, object)) {
+		print_slab_info(slab);
+		pr_err("Invalid pointer 0x%p\n", object);
+	} else {
+		print_trailer(s, slab, object);
+	}
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 
 	WARN_ON(1);
-- 
2.30.2


