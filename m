Return-Path: <linux-kernel+bounces-759859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8856B1E3A7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5CD3B6E8A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66F724728C;
	Fri,  8 Aug 2025 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="krfOrPBr"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C4B244698
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754638562; cv=none; b=dPDqalqraGNxqWWd2fjr58+NNBY5qgisPN3BjzEAbh1XlOqUHljJ5NoL1S8qrYydLrU+mtAhbaBZyrD1VPETBQx1p/HTm2I3PtZgaQXu9eTgCCvZNrwX+QMMpUetbuOkWtQiCjGF4PcLJXOwJI9kgApNwwzOzm3yqdT1Mr5PpJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754638562; c=relaxed/simple;
	bh=mhRKdhs7K1/HysXp3loxFDToOPnE440a2ZtA9a0x36E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=W4o0eYfBkG6pgyL3pTj7pHdnC1knh5u5eWJWdV2bTUOPfV7IUfY++iC7GRg4Q5y96ClWa3Ld6tcf+pan2EXn0Br1C4auzVCNP4uAwqrSoWaRUotmFaXQld3/HJbV09XPa4PATOO/vcy+qT18JJVu20vPyptEF94quK5WFNSD7uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=krfOrPBr; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=bWqffEK1j65V+npFFXubrmYzyYXvK3w8H6N6TmUJh1I=;
	b=krfOrPBruaBySPEdh3nNVpS53n9/+fql/Yi5VfqGv5mnq8IEkwSPwJXbPSHBt8
	e6V0UddHh99v8ExRQkKRXs/F/c2faenQ5cabhSTy1oa71BZC9il4wKCWZRYWUYMO
	y7Dnfsju8NDQPM+qHias/SpuC1sFCAo05zm8JDSdDIHQI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgC3P8BzqJVodqFcAQ--.4545S2;
	Fri, 08 Aug 2025 15:34:12 +0800 (CST)
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
Date: Fri,  8 Aug 2025 15:34:08 +0800
Message-Id: <20250808073408.154247-1-fffsqian@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgC3P8BzqJVodqFcAQ--.4545S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4rtw43KFWfAr43CFW3Jrb_yoW8Gr4Dpa
	93C3yqk39xtwn7Kw1qvrWfAw1xWr1vkFW7JFy7KF10k3ZrGFykta1YgwnxKrW2yFWxX3Wa
	v34IkFW3K3WDZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUnYwUUUUU=
X-CM-SenderInfo: 5iii21xldqqiywtou0bp/1tbiMRmjymiVo1GsMAAAsS

From: Qingshuang Fu <fuqingshuang@kylinos.cn>

Due to the fact that the tier data type in min (tier, MAX_CR_TIERS -1)
is int,but MAX_CR_TIERS is an unsigned type, directly using
the min function for comparison will result in an error:
from mm/vmscan.c:15:
mm/vmscan.c: In function ‘read_ctrl_pos’:
./include/linux/build_bug.h:78:41: error: static assertion failed:
"min(tier, 4U - 1) signedness error, fix types or
consider umin() before min_t()"
And MAX_CR_TIERS is a macro definition defined as 4U,
so min_t can be used to convert it to int type before
performing the minimum value operation.

Signed-off-by: Qingshuang Fu <fuqingshuang@kylinos.cn>
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


