Return-Path: <linux-kernel+bounces-786171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 622F3B35619
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990302079B3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F202F60B4;
	Tue, 26 Aug 2025 07:50:40 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614FC3D984
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756194639; cv=none; b=sJcvXDdtJoyg3ArffcagiOiu8YjZa/oy1cGeByQgMm0IXr5I9lqlKtfy/MonHxJt89fDgPhgdH+o/bl3k6Su3cJFI+yfWIoX6iNDyZBYppIwc3iPyKb5rftuAqsT4mkGzybIQ8e7+TXLQxUOF86Tfd6Rb7nbwln64TXzJtyvL4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756194639; c=relaxed/simple;
	bh=k2nvBVJPiJMz0ZIEeQuCIQRCFyr14A7//5DD8wD5s6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pj3ay4NF1FsdFufTF1AOt8jXQ6ELKPZCx0eDp87fakOIWQUxPqZL3LSGevfOPAFVkKh3ej4MJ/g7zWKGFhEUqowG+JUCZRWJ4lBCKy260zdWW3GoevjiTTMB/cfttaNfKjHWHFdK4cUggLJFcVlnYJV4pmoZiILpqYnfj7511q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cB0Fk70JjzKHNC6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:50:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 94FFF1A0E4A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:50:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDnMY5IZ61oTGJbAQ--.24858S4;
	Tue, 26 Aug 2025 15:50:34 +0800 (CST)
From: Zheng Qixing <zhengqixing@huaweicloud.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	axboe@kernel.dk,
	ming.lei@redhat.com
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	zhengqixing@huawei.com
Subject: [PATCH-next 0/2] dm: fix quiesce asymmetry and null pointer in suspend/load race
Date: Tue, 26 Aug 2025 15:42:02 +0800
Message-Id: <20250826074204.390111-1-zhengqixing@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnMY5IZ61oTGJbAQ--.24858S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4xZw4xZrWfury7tFWkWFg_yoWkWrgEg3
	yrGrZrJw1UWrWjqF43Ca1fZr95CryrWFyxXF4Ut3sF9ry5XrsrGryqy34rXan7AFWxtrn8
	JF17Kr1fArsrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UAwIDUUUUU=
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/

From: Zheng Qixing <zhengqixing@huawei.com>

Hello,

During reliability testing of the dm module, we discovered two bugs when
performing create/remove and suspend/resume operations at high frequency.

Analysis revealed that race conditions between suspend and table load
operations cause asymmetric handling of q->quiesce_depth and null pointer
dereference issues with q->tag_set.

To address the q->tag_set null pointer issue, patch 2 determines whether
to perform certain suspend actions for request-based devices based on the
existence of the table (map).

For detailed information, please refer to the patch commits.

Additionally, since modern Linux kernels have indeed transitioned to
multi-queue as the default (and single-queue is largely deprecated),
is using queue_is_mq() to determine dm_request_based() obsolete?

Zheng Qixing (2):
  dm: fix queue start/stop imbalance under suspend/load/resume races
  dm: fix NULL pointer dereference in __dm_suspend()

 drivers/md/dm-core.h |  1 +
 drivers/md/dm.c      | 13 ++++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.39.2


