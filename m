Return-Path: <linux-kernel+bounces-889826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90713C3E9FB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 07:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F3564EB100
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 06:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FD6296BBB;
	Fri,  7 Nov 2025 06:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="I4tqWfFs"
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528B121C16A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 06:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762497193; cv=none; b=LgLm5Ag3QQfsz8QZkPAKLVicvSfiJ9e/YpFqixAmLe7WVe3AIO5nBT8xUb2gNkvgszXkpIHBUNoTACDKqOzIjpYSsl+yKhSkcuMFYMwJmVVR/wFc7hnyhIES0gG9dI2Lh+HD4DFTyeyZ13F9kzPtZ8ECKJygrYSimKhkQSPBmfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762497193; c=relaxed/simple;
	bh=Ne+BbKWZ2Q5ZZLxnS2ngDemgyo4kOjNxdhr72DCE0/Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rfpl6jyCN7dLJIQtD5F7kCj5wkabQchcaY/IjEi69JiknVKrR/SmVCoYNYNvfZ6Am0hP8RqmNla2DWwQt2uYnnalwBCcCB6V0Qi9Dl5qaopNmv6jjgh/j2sGnXtn2ZlGwhVncqglZij7tuEL64z1UUha5fTwbLtOmkF3H9Cs3cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=I4tqWfFs; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9bfoe/jx3hBglO6tc2XYZrJYhwjJ6xEZSorNfn9J118=;
	b=I4tqWfFsImrDtzJzBEWWRT+otRiiDRYaCh2BbbZo0UDLOlZDFLsLz9UoTmcF8BbyDb7pdWQjS
	YaNFjvJ19huVM69ukuWhR6GqUh9AYTF4YQquc7Pkkb0abbteKkOOTtbX2vJE4r9OPTIDEt7QdZX
	BKj3kQiO5ZRqmJ1nANkBlvc=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4d2q2q0j7Mz12LDp;
	Fri,  7 Nov 2025 14:31:31 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 77837180495;
	Fri,  7 Nov 2025 14:33:05 +0800 (CST)
Received: from huawei.com (10.50.87.109) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 7 Nov
 2025 14:33:04 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <james.morse@arm.com>, <Dave.Martin@arm.com>, <ben.horgan@arm.com>
CC: <sunnanyong@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <zengheng4@huawei.com>,
	<jonathan.cameron@huawei.com>
Subject: [PATCH mpam mpam/snapshot+extras/v6.17-rc2 0/2] fs/resctrl: Fix the iommu_group parsing process
Date: Fri, 7 Nov 2025 14:32:58 +0800
Message-ID: <20251107063300.1580046-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100008.china.huawei.com (7.202.181.222)

Zeng Heng (2):
  fs/resctrl: Fix the iommu_group parsing process
  fs/resctrl: Migrate iommu_groups back when deleting the group

 fs/resctrl/rdtgroup.c | 91 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 73 insertions(+), 18 deletions(-)

--
2.25.1


