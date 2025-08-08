Return-Path: <linux-kernel+bounces-760033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E25EDB1E5CD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1AF51AA59C1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2521270EA8;
	Fri,  8 Aug 2025 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KVCdxGB5"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A06E26E70E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754646250; cv=none; b=dc6/EOAbqCSG6oTMzBpH+sYDL359oj0OG6d6/L3FatCW1+/8od9zOkC7lHgE+R2MbtInslXjo4zy8Ex5tLgu4E5I4QWfg9y/sg0FugaJvnWw3eANf5XFzIjf2SW0392EblBNWkl9rIei5DOm7Gzi7EcZqZra0NUx7Flk/aG4gdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754646250; c=relaxed/simple;
	bh=nzbLANNmVBAPUonG7Wxn3kVgCvgdQW9TZkNFQ1L/+8k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=p+NlxtT5rk2t69UuaeokZCkrfUcR77J+P/E5mw/2c4zQOjD5pUWfxMhnH/pGlSSIh+oD8PhwJt3a4jFLpC0swYVG4Rd7t7K2TGKsxZnFlR9doVjMJr0HW8MNCxBm6F2Gd2orYDz80t+Km8RDrpWyk/xPw/ypzEvFHh/3oyx9H/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KVCdxGB5; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=hg/dNySbwBik4yOGXZxNDXDhAmqw7dDjJ6pVF0ShhBY=;
	b=KVCdxGB5VV9GpPQ2Cbv/DJ4IyeE1SYj3iZ8rgB5+GD36WZ2FkHGX+lf+7W/TdR
	ohrA+WdbQChSHji0f3qWpM0otKZBUu2m/tdk9Dotoh2fjGQCRIdVholK3Vhfts0W
	fOb+QgSQFaAG5NcZ0UOLQihNnDuVzyY9KHjmXJO2Pgxzo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDX0473wpVorWBMAA--.9256S2;
	Fri, 08 Aug 2025 17:27:19 +0800 (CST)
From: Qingshuang Fu <fffsqian@163.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org
Cc: david@redhat.com,
	mhocko@kernel.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qingshuang Fu <fuqingshuang@kylinos.cn>
Subject: [PATCH] Fix the data type inconsistency issue of min (tier, MAX_CR_TIERS-1) in read_ctrl_pos
Date: Fri,  8 Aug 2025 17:27:17 +0800
Message-Id: <20250808092717.191444-1-fffsqian@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX0473wpVorWBMAA--.9256S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4rtw43KFWfAr43CFW3Jrb_yoW8Gry3pa
	93G3yqk39xtwn7Gw1qqr4xAw1xWw1vkFW7JrW2qr10ka43GFykta15Krn8t3yjyFWxX3W3
	Za4IkFW3K3WDAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jU6pPUUUUU=
X-CM-SenderInfo: 5iii21xldqqiywtou0bp/xtbBDhqjymiVwnUSpgAAsD

From: Qingshuang Fu <fuqingshuang@kylinos.cn>

Due to the fact that the tier data type in min (tier, MAX_CR_TIERS -1)
is int,but MAX_CR_TIERS is an unsigned type, directly using
the min function for comparison will result in an error:

from mm/vmscan.c:15:
mm/vmscan.c: In function ‘read_ctrl_pos’:
./include/linux/build_bug.h:78:41: error: static assertion failed:
"min(tier, 4U - 1) signedness error, fix types or
consider umin() before min_t()"

Fixes: 37a260870f2c ("mm/mglru: rework type selection")
Signed-off-by: Qingshuang Fu <fuqingshuang@kylinos.cn>
Suggested-by: David Hildenbrand <david@redhat.com>

---
v1 -> v2:
Modified patch descriptio
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7de11524a936..f991196fd8e5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3194,7 +3194,7 @@ static void read_ctrl_pos(struct lruvec *lruvec, int type, int tier, int gain,
 	pos->gain = gain;
 	pos->refaulted = pos->total = 0;
 
-	for (i = tier % MAX_NR_TIERS; i <= min(tier, MAX_NR_TIERS - 1); i++) {
+	for (i = tier % MAX_NR_TIERS; i <= min_t(int, tier, MAX_NR_TIERS - 1); i++) {
 		pos->refaulted += lrugen->avg_refaulted[type][i] +
 				  atomic_long_read(&lrugen->refaulted[hist][type][i]);
 		pos->total += lrugen->avg_total[type][i] +
-- 
2.25.1


