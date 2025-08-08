Return-Path: <linux-kernel+bounces-759825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93D9B1E33B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68955162AF5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265F9261595;
	Fri,  8 Aug 2025 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="A/LmYE1L"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C01230D0D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637723; cv=none; b=L2CCR+zWTee/g+Q/igRr+l2WFjcVwfvhEeIJyn9btfUNULIK/E/I+uX87hygyOOhMxIQ8f2QtuAeW58HKkn216H+oiC2aaIc+zEjyTsO04kpq9slDki/SEWBINvoWpZ02F9gb1ywOIP4WEqsu/TLs9bNYEcuW0v1KwseFAql9lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637723; c=relaxed/simple;
	bh=mhRKdhs7K1/HysXp3loxFDToOPnE440a2ZtA9a0x36E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Tvb7kSiiIdB2SA6Zo4qsY1K7J+XyCyRodPlP92SaLJs6sxP62J+K9ghaYFduz/kwE9cNJyGx9g3WMkQY8Az7vGKXzsaA/cGttGL2xv//8FmCEW7LOnXwVtgOghRmVmDmHM8ocw2OL3TPXmtMJAMrZ4lDMN2mZQklqc4dGWY+ETk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=A/LmYE1L; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=bWqffEK1j65V+npFFXubrmYzyYXvK3w8H6N6TmUJh1I=;
	b=A/LmYE1Lr2AH/EPbHWBzPuUJBPAXBA2e2qlaL5dWvk4nk+awljuVwXmnecXeo/
	rfpWREg7fjgJv0dq9ZfRVOXJuXHepgiphXDko21Fpw87IKOctVLLXK545orIEsc0
	rjEtJrOA9rLkh1Bn2AQICjAW+F0XMbuG06omDyO0WUzh0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3_9NlpZVoS4MlAg--.6902S2;
	Fri, 08 Aug 2025 15:21:10 +0800 (CST)
From: Qingshuang Fu <fffsqian@163.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org
Cc: david@redhat.com,
	mhocko@kernel.org,
	zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qingshuang Fu <fuqingshuang@kylinos.cn>
Subject: [PATCH] Fix the data type inconsistency issue of min (tier, MAX_CR_TIERS-1) in read_ctrl_pos
Date: Fri,  8 Aug 2025 15:21:06 +0800
Message-Id: <20250808072106.153449-1-fffsqian@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_9NlpZVoS4MlAg--.6902S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4rtw43KFWfAr43CFW3Jrb_yoW8Gr4Dpa
	93C3yqk39xtwn7Kw1qvrWfAw1xWr1vkFW7JFy7KF10k3ZrGFykta1YgwnxKrW2yFWxX3Wa
	v34IkFW3K3WDZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUeOJUUUUU=
X-CM-SenderInfo: 5iii21xldqqiywtou0bp/1tbiORSjymiVozZI1wAAsz

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


