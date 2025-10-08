Return-Path: <linux-kernel+bounces-845160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B08BC3BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 09:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F37B341E2C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 07:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5222F1FEF;
	Wed,  8 Oct 2025 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="EjJ/IoJ9"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467A821CC55
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 07:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759910012; cv=none; b=nr0YNDrpvvtfTT6OX7EmIxN3jviunZRoDMCtPIBnbsswrq91a807d+sGUJkOoEqpefxnrcmhICYxKNKzDDs2B1zGpeCV3nAIhmYh6eDmTjCOmmUv0svDf9coSub48HVxRQ6jTAalqJ2iA6q/QptS32b6gDJHnzu1iotZ8TM/wTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759910012; c=relaxed/simple;
	bh=J0vin9G4M7B3OG2kiAsyEa99zFFAtW6G2CoPlAm8g04=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=nYePH4TwMLNRmOJupkEjXXm1Ibm5vt/diRKUa926gt4mmrSxSJhRlVM0Wxgz0jhtYhVNgWZZ3GOc3IRo8YPliNs9w1IBtAlWcstbc2oAQOjyiMf2fpJ0nNduGmu7iMrTf8yMGRk5yE/0BMAtu22mXkB+YQXB9BxEA/Ze/cVZFbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=EjJ/IoJ9; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1759909990; bh=P7IvDczGiyfEhMXQssu7tGF5fwkZRWsiDziHUa3DUmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EjJ/IoJ9UAyI1OY/PMJfxmPOwpZujAA1MIhVmcu6syCCy+QI9B1Jq3Q7u4jA6qDWG
	 gqBOMKOqXsSkxxTtRkxbSyQMPr+nbB6rqS4FQk5dPKbOgzrEt4E6s27tMja+PvxBpz
	 NUnz9LYWYCOnlG8OKzHCVtK/79/hERgJUvTM9+9k=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszb20-1.qq.com (NewEsmtp) with SMTP
	id D46A284A; Wed, 08 Oct 2025 15:53:06 +0800
X-QQ-mid: xmsmtpt1759909986t1jgwmg6v
Message-ID: <tencent_E46183A88440D77C977DA6CBD37DC362A905@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIeAg4IKih4f886w/ZvHqayDqcqGD5QSFnRrcO1knjmCq7Yc0nhfQ
	 qCyKcnQdYpG7zLDX6FGAVeYqg9/FBeCfKiqowu6oyhwmkYYuknOM2GOgJe+ez46NlG9XXoit3ngR
	 k8zll7UfE8sxeA9QZ+dyH2fes93J/IN+vNxZdB6kXj33p9dWxzph8fzkIjh6LYrSmT0xcmD+7nsd
	 RvKAk1YLrNUBlJZTeKEmQsglgtlrrdEE0x/JUN2V+2NxJ7Cv7eIchyJ2RHtQqFIyPtwIzlhZQTnb
	 5EOon0YOOZGR/QdxOAJO6s9L9HiP/w1AuH6b8oWIWyma6BQB7jKzt071olJQ/LvjqbFL69JB6Sqs
	 Tlw5x/vXkyNbdTtLWoL8oIjOcm7kpqLyQEq1Mcety9jNK4W9K0XUtc02rTKs1Yefi69UHk8QCmRE
	 udK1KKQaqsiMsyWWAlOPIMz2SZCKzgj6EsvRNmt/j1db1Ghd7W+o0wGvYs2RjulreOD6yVslppmj
	 ViUyUd7GePZpRTOEMfCChvYFEoYOqVIsJWeF2ryUKywzwLutcZMKnAX6F/vS9EUdqSaKF/yQ4bRN
	 VFp8yR+fbaSZ1LVJG7XlV0Q7uXqDnV72l9q7CCfZjVkGNY+bptuXcSWhddssdc5wItOFimjwz0t4
	 uepbBYWz9obTGWz8udCGLyXhEo+/ZEcswTVVe+XiNBMh237SDzYk/g/T+eTp8noCgoz78UYbnTBJ
	 MA6AzCZVl3C4zo5eGoXlAHX9WpMN+mU1BFZXoPP2wuzGfL3WI3QoHGwXl+rMn+bpHzcqgQSXq0su
	 xZnLNoplBsZAy+D2jVoc9BFC+owdHii4GWwj6XOidxcRPj4E9NHn2MFD8+ZR31ZsrQEC/vpilGrH
	 NNwOpYBHr3ilEbGR9L61Ghff6rLjomBsVwp+oNkbAc70u+Ey95NjlbVH6SkxidUM8bRgzIPhXWfC
	 /SlfI/FXHWvIPkX35PDSQx5Yb4D3xOgq60194rZ1wSpqYP0lEloA==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+093a8a8b859472e6c257@syzkaller.appspotmail.com
Cc: iommu@lists.linux.dev,
	jgg@ziepe.ca,
	joro@8bytes.org,
	kevin.tian@intel.com,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	syzkaller-bugs@googlegroups.com,
	will@kernel.org
Subject: [PATCH] iommufd: Prevent the use of nil data
Date: Wed,  8 Oct 2025 15:53:07 +0800
X-OQ-MSGID: <20251008075306.1443836-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68e5a30d.050a0220.256323.002e.GAE@google.com>
References: <68e5a30d.050a0220.256323.002e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The division exception occurs because:
The denominator bitmap->bitmap is 0, which is derived from the nil value
of bitmap->data passed in by the reproducer.

Before calling iova_bitmap_alloc() to allocate iter, add a check for a
null value in data to avoid the division exception.

syzbot reported:
divide error in iova_bitmap_alloc

Call Trace:
 <TASK>
 iommu_read_and_clear_dirty drivers/iommu/iommufd/io_pagetable.c:543 [inline]
 iopt_read_and_clear_dirty_data+0x271/0x4c0 drivers/iommu/iommufd/io_pagetable.c:603
 iommufd_hwpt_get_dirty_bitmap+0x1c3/0x340 drivers/iommu/iommufd/hw_pagetable.c:485

Reported-by: syzbot+093a8a8b859472e6c257@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=093a8a8b859472e6c257
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index c0360c450880..9ddaed95e79f 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -540,6 +540,9 @@ iommu_read_and_clear_dirty(struct iommu_domain *domain,
 	if (!ops || !ops->read_and_clear_dirty)
 		return -EOPNOTSUPP;
 
+	if (!bitmap->data)
+		return -EINVAL;
+
 	iter = iova_bitmap_alloc(bitmap->iova, bitmap->length,
 				 bitmap->page_size,
 				 u64_to_user_ptr(bitmap->data));
-- 
2.43.0


