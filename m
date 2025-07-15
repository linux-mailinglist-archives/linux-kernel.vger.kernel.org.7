Return-Path: <linux-kernel+bounces-731009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DE5B04D78
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5498A4A002E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB811BD9D3;
	Tue, 15 Jul 2025 01:34:16 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1072E39FD9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 01:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752543256; cv=none; b=NbZlGlFlp6HLgPBbfHXXvbf+y49BnInlLfrBakQl1I3ryvGjjaaCUZsgjqL6qJCyOF5qr9LM7udxM0v0fQ92zkaa1qLbXedDFtrwZs1kC6GHCB+KrhFkv19bXUP0dioOJIrsObrHTnCC+PCQlCVOWLlJ421042rp4zLXN2LUi7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752543256; c=relaxed/simple;
	bh=30J7k6IWs+3pro+46PVghzdZM3Z7GzB9kM9XJLkqpk8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lv8j6VHcSTpgWlrUjCYTlLgaPkXzQRAU4Q7i4SdHgmJRyrTKGONlwmEaah+BZXlfQuVlH+qJ4IKmh1gxknhTkLbpvr5dz6sMRmsad+1C8VgqVhSiMfANQ22FEUQaJd/izphvJrLwtT7uL/SoQ1QEj9HJgO1YfQHXIFPjio9VIIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bh1tq1G29zYQtng
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:34:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E98A51A06D7
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:34:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDnYhMNsHVo35syAQ--.25659S4;
	Tue, 15 Jul 2025 09:34:07 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	lengchao@huawei.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH] nvme: fix misaccounting of nvme-mpath inflight IO
Date: Tue, 15 Jul 2025 09:28:12 +0800
Message-Id: <20250715012812.1135331-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnYhMNsHVo35syAQ--.25659S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4UXry8ur1DZr1rZw4kXrb_yoW8WF17pF
	4kZrW3C3sI9F1kA34xJFW7ua4Yqw4qqa47Cwnak34aqF1DJrW5ur4qgF17Wr47ur4kWay5
	WFs5ur9ruFy7JrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Pprocedures for nvme-mpath IO accounting:

1) Initialize nvme_request and clear flags;
2) Set NVME_MPATH_IO_STATS and increase inflight counter when IO
   started;
3) Check NVME_MPATH_IO_STATS and decrease inflight counter when IO is
   done;

However, for the case nvme_fail_nonready_command(), both step 1) and 2)
are skipped, and if old nvme_request set NVME_MPATH_IO_STATS and then
request is reused, step 3) will still be executed, causing inflight
IO counter to be negative. Fix the problem by clearing nvme_request in
nvme_fail_nonready_command()

Fixes: ea5e5f42cd2c ("nvme-fabrics: avoid double completions in nvmf_fail_nonready_command")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/CAHj4cs_+dauobyYyP805t33WMJVzOWj=7+51p4_j9rA63D9sog@mail.gmail.com/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 92697f98c601..e2233e434e5a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -764,6 +764,10 @@ blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
 	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
 		return BLK_STS_RESOURCE;
+
+	if (!(rq->rq_flags & RQF_DONTPREP))
+		nvme_clear_nvme_request(rq);
+
 	return nvme_host_path_error(rq);
 }
 EXPORT_SYMBOL_GPL(nvme_fail_nonready_command);
-- 
2.39.2


