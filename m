Return-Path: <linux-kernel+bounces-835267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52440BA69F4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27963BB2F2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DB529AB1D;
	Sun, 28 Sep 2025 07:29:00 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863C421CC58
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759044539; cv=none; b=YuNIC7xVMwttTnFPJLDdmxvx4qoj2ApygAW25SBtXT0uYbViImygJE/1lMJ0OVEfDgdt/R/cPqXV51CF0aapiXP9304P23JsuABLX0EFzMOvzFHblho+VxMMzYCeYxi4GooN7N1HMaVLjiaVsPOrjP6g+l73RyU93jl43ql6ERI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759044539; c=relaxed/simple;
	bh=dWVDRe8zP/mAdG3g3z7QlmupnQz+ckbGjv6Ne6MYHz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W8cqL9pcPrLILPBWlmAbFiuos/1KdghH5ygjO3ocyH+8kZ+5JRzSYHpQkDzsCYUK7ki5KZKEaPdheN8xHCwZbSew8D7NikxzyUqQKkEPNyozoBE5LYZBziDAGn9PHe2N+Zh6SkzB8yns/s1148+3UCKzOIv7LS6b2LvxPu/kZPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cZGCG30JkzKHN8j;
	Sun, 28 Sep 2025 15:28:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9EC881A14B8;
	Sun, 28 Sep 2025 15:28:54 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgAHUhaY49hoiDJLBA--.29596S2;
	Sun, 28 Sep 2025 15:28:54 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next RFC 00/16] cpuset: rework local partition logic
Date: Sun, 28 Sep 2025 07:12:50 +0000
Message-Id: <20250928071306.3797436-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAHUhaY49hoiDJLBA--.29596S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr15CrWxZFWUAr4DJw1DKFg_yoW5Cr18pF
	y3CFWSy34UCr13C3srJan7Aw4fWws7JFyUtrnrWw18Xr12yw1vyFy0y3ykZa4UXr9xAry8
	Z3W7Wr48X3ZFk3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The current local partition implementation consolidates all operations
(enable, disable, invalidate, and update) within the large
update_parent_effective_cpumask() function, which exceeds 300 lines.
This monolithic approach has become increasingly difficult to understand
and maintain. Additionally, partition-related fields are updated in
multiple locations, leading to redundant code and potential corner case
oversights.

This patch series refactors the local partition logic by separating
operations into dedicated functions: local_partition_enable(),
local_partition_disable(), and local_partition_update(), creating
symmetry with the existing remote partition infrastructure.

The series is organized as follows:

1. Infrastructure Preparation (Patches 1-2):
   - Code cleanup and preparation for the refactoring work

2. Core Partition Operations (Patches 3-5):
   - Factor out partition_enable(), partition_disable(), and
     partition_update() functions from remote partition operations

3. Local Partition Implementation (Patches 6-9):
   - Separate update_parent_effective_cpumask() into dedicated functions:
     * local_partition_enable()
     * local_partition_disable()
     * local_partition_invalidate()
     * local_partition_update()

4. Optimization and Cleanup (Patches 10-16):
   - Remove redundant partition-related operations
   - Additional optimizations based on the new architecture

Key improvements:
- Centralized management of partition-related fields (partition_root_state,
  prs_err, nr_subparts, remote_sibling, effective_xcpus) within the
  partition_enable/disable/update functions
- Consistent operation patterns for both local and remote partitions
  with type-specific validation checks
- Fixed bug where isolcpus remained in root partition after isolated
  partition transitioned to root

Chen Ridong (16):
  cpuset: use update_partition_sd_lb in update_cpumasks_hier
  cpuset: generalize validate_partition() interface
  cpuset: factor out partition_enable() function
  cpuset: factor out partition_disable() function
  cpuset: factor out partition_update() function
  cpuset: introduce local_partition_enable()
  cpuset: introduce local_partition_disable()
  cpuset: introduce local_partition_invalidate()
  cpuset: introduce local_partition_update()
  cpuset: remove redundant partition field updates
  cpuset: simplify partition update logic for hotplug tasks
  cpuset: unify local partition disable and invalidate
  cpuset: use partition_disable for compute_partition_effective_cpumask
  cpuset: fix isolcpus stay in root when isolated partition changes to
    root
  cpuset: use partition_disable for update_prstate
  cpuset: remove prs_err clear when notify_partition_change

 kernel/cgroup/cpuset.c | 907 ++++++++++++++++++-----------------------
 1 file changed, 408 insertions(+), 499 deletions(-)

-- 
2.34.1


