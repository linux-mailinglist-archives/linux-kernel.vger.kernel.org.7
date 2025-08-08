Return-Path: <linux-kernel+bounces-760052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6930B1E603
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC87F583717
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315AB270ED4;
	Fri,  8 Aug 2025 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ASCMsHJm"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA6325DB07
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754646945; cv=none; b=PgyPH+y0O9gFOqgP/8R+WUY6bO6qtSouJI5GDDurjMvAPywi3jendvx5jp7B2qkcxQQv6mL1o1kR5nxEDpx11tgxl88qpfVSI29Dp4gFzNYn9YzoERyJzm0Ad6Pp62Ilynk3PTVwCn0dg9Q6vcDXHXcyTTB16D+AOPohIkSFojI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754646945; c=relaxed/simple;
	bh=GvvkJ2v8pRO8+u/GJb91DZY1Bziuc5B1n2Kl8sTuSD0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RlfpdDitGj2P/YV9QfHDZ3JPzIENke6WG54Fq9CRmkQ8N4r/5TJ2DksI4e68BlYXdbMvQMoEQvYSmC1jnH1itZIJIE4LQJe3lUpkmZmWWnqcdZhNYUshzvoHnHBHyTrWW+Lxws223amcThA7vYl7AxG9xjv/wltFagFMQ8rzUzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ASCMsHJm; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=fgEIQccnW8nT0HbsPC5z944AQr0c2fBSMFL9YRUiOcs=;
	b=ASCMsHJmopXVtSvZ2tFEgta7XFidR2shjoHZAPJMZOcrneXecKGH3PCjXj2/Wi
	DXywyhE6I2luQA1qdzSPuYl4nLc9Cas9mVO51D0o1uTKf0404fsD5td2HpbMqyPM
	IUXgUQNZO1Jq458BpgYcfL571Gfuc2bBdqSQczqED3bRE=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDHD5FKyZVoRUzkBw--.6054S2;
	Fri, 08 Aug 2025 17:54:18 +0800 (CST)
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
Subject: [PATCH v2] Fix the data type inconsistency issue of min (tier, MAX_CR_TIERS-1) in read_ctrl_pos
Date: Fri,  8 Aug 2025 17:54:16 +0800
Message-Id: <20250808095416.208289-1-fffsqian@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDHD5FKyZVoRUzkBw--.6054S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4rtw43KFWfAr43CFW3Jrb_yoW8Jw4rpa
	93G3yqk39xtwn7Kr1qqr4fAw1xWw1vkFWxJrW7tr10kasxGFyktF45Kwn8t3y2yayxX3W3
	Z34IkFW3K3WDAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUnYwUUUUU=
X-CM-SenderInfo: 5iii21xldqqiywtou0bp/xtbBDg+jymiVwnVE-wACsb

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
Suggested-by: David Hildenbrand <david@redhat.com>
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


