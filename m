Return-Path: <linux-kernel+bounces-805155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A815B484A4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A8C189E5CF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C362E2DD8;
	Mon,  8 Sep 2025 07:00:59 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856C01C54AF;
	Mon,  8 Sep 2025 07:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314859; cv=none; b=m7nJGZB2s/SD7C12ZfDzN9rvJpvQU0uYcMK9sMwNk2TAvMiBftIyHrkJm5Xh/BBVxBjjhQziQz0LuEZCFdfGuFnde+nY8ijbCA52XZv3ydxPLXvF0FEYpKKlADYXlPbmsoCrYuEUeR8vS0Hq/DImeZaJq+DnGSqbMnQytvH0Klk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314859; c=relaxed/simple;
	bh=SJDQlr8kYnUVXlqjG3XTlvRhDl2Ax+wgpIYELK54IoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jtr02osE4TQgbudir7qOwSDwLrdUT3s7Prcpf8YWIshN3X5l74jo23KrL9TAsMuJ1Q6KvbFXSSjQsOc42CRiVXmD/xlR2UACs44uuBi5wVc4j2+uOudWWOQgZRx48LZoIjlKn58Y06wL5JmWtjT1StBw1ErY3OL31DpnFmiQd5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cKxky12KNzKHN4Q;
	Mon,  8 Sep 2025 14:24:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3BDA41A10EC;
	Mon,  8 Sep 2025 14:24:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3QY6xdr5oCGEjBw--.62066S14;
	Mon, 08 Sep 2025 14:24:58 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: nilay@linux.ibm.com,
	ming.lei@redhat.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH for-6.18/block 10/10] blk-mq: fix stale nr_requests documentation
Date: Mon,  8 Sep 2025 14:15:33 +0800
Message-Id: <20250908061533.3062917-11-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3QY6xdr5oCGEjBw--.62066S14
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWDCryfKr15Zw1xKFWfZrb_yoW8Xw1Dp3
	yft39Fgwn5Zw18Wr10yay8tF13Aa95Aw43Jr4DKF1rtr98Awn29Fs2qr1rXF4xZrZ7AFWU
	urZ29r98Aa1qva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUQFxUUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

The nr_requests documentation is still the removed single queue, remove
it and update to current blk-mq.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 Documentation/ABI/stable/sysfs-block | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 0ddffc9133d0..0ed10aeff86b 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -603,16 +603,10 @@ Date:		July 2003
 Contact:	linux-block@vger.kernel.org
 Description:
 		[RW] This controls how many requests may be allocated in the
-		block layer for read or write requests. Note that the total
-		allocated number may be twice this amount, since it applies only
-		to reads or writes (not the accumulated sum).
-
-		To avoid priority inversion through request starvation, a
-		request queue maintains a separate request pool per each cgroup
-		when CONFIG_BLK_CGROUP is enabled, and this parameter applies to
-		each such per-block-cgroup request pool.  IOW, if there are N
-		block cgroups, each request queue may have up to N request
-		pools, each independently regulated by nr_requests.
+		block layer. Noted this value only represents the quantity for a
+		single blk_mq_tags instance. The actual number for the entire
+		device depends on the hardware queue count, whether elevator is
+		enabled, and whether tags are shared.
 
 
 What:		/sys/block/<disk>/queue/nr_zones
-- 
2.39.2


