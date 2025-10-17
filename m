Return-Path: <linux-kernel+bounces-857837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F09ABE809E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD191AA17CF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE3C30F804;
	Fri, 17 Oct 2025 10:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="uOygw44X"
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB82D24DFF9;
	Fri, 17 Oct 2025 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760696521; cv=none; b=p6fO4q4u98LlSTAempyjrC9n2Gz+Q2ThAnwlpfXXxkGdeM+NpcpeB4s96GN2Bzm4jRyNAqHdNrAawxw4jcknLSGHsxpwHQhpQL8QTXwHpF99pzddjguIAGWok7NUbZ0dbMTlPJ8ZP4kZ6T0nGROh6pl1fjAvsncVrfXIxhSWSFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760696521; c=relaxed/simple;
	bh=9lKqgtRVwmN4wR69S2KF45kjA7haIPFqMX7NWjzzsSw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=aQZ6M89fEJZp0FoH8oyLyfawqnPEV3/AsW+dOEruv05t0p6HQRNhwKwPih66j6rt7EcwE8lc5lPlfmACumH7S+tq5VRtcs5I8EBaHASb+XlTKCLWnh82dPM4Zx5i/ynQrOUqemB03znR1Ult0v5Id/Q0wbmDt5p1e58ybxw29ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=uOygw44X; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EJOhlXGAy3sYnoMiaEvd/2Fl9Dnh+kBxPY6pTICsGqI=;
	b=uOygw44XgbQhwDjzsw3hvCsN0gtkZwUUivaPTTrFSYI2Jzo4rVupUyNoEdquuuQYTc4KFc3AZ
	X/ktEAjodwdABdG5xipW3sAaZc5RX2blhUTePl29sZm9BXjFVHfxDGzEA4JfTcFfBKLAHATrfDW
	JRj0xtDJgVIba2CBX/9BtJM=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4cp17s1tTzz1cyQ9;
	Fri, 17 Oct 2025 18:21:29 +0800 (CST)
Received: from kwepemk100009.china.huawei.com (unknown [7.202.194.57])
	by mail.maildlp.com (Postfix) with ESMTPS id BFF49140120;
	Fri, 17 Oct 2025 18:21:50 +0800 (CST)
Received: from [10.174.186.187] (10.174.186.187) by
 kwepemk100009.china.huawei.com (7.202.194.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Oct 2025 18:21:50 +0800
Message-ID: <fe693f4d-80c7-4d1f-9430-3ab9c8165df0@huawei.com>
Date: Fri, 17 Oct 2025 18:21:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "longwei (I)" <longwei27@huawei.com>
Subject: [PATCH] kho: debugfs: Fix finalize interface documentation
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: "hewenliang (C)" <hewenliang4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100009.china.huawei.com (7.202.194.57)

From 91c2b24855d55fef0e8919b2d39216d5c9aad558 Mon Sep 17 00:00:00 2001
From: Long Wei <longwei27@huawei.com>
Date: Wed, 15 Oct 2025 19:58:39 +0800
Subject: [PATCH]kho: debugfs: Fix finalize interface documentation

Correct the error in the KHO documentation: 
when removing the KHO finalization phase, it is necessary 
to execute echo 0 > /sys/kernel/debug/kho/out/finalize
instead of echo 0 > /sys/kernel/debug/kho/out/active.
Fix it.

Signed-off-by: Long Wei <longwei27@huawei.com>
---
 Documentation/admin-guide/mm/kho.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/kho.rst b/Documentation/admin-guide/mm/kho.rst
index 6dc18ed4b..2eda33865 100644
--- a/Documentation/admin-guide/mm/kho.rst
+++ b/Documentation/admin-guide/mm/kho.rst
@@ -57,7 +57,7 @@ Abort a KHO exec
 
 You can move the system out of KHO finalization phase again by calling ::
 
-  $ echo 0 > /sys/kernel/debug/kho/out/active
+  $ echo 0 > /sys/kernel/debug/kho/out/finalize
 
 After this command, the KHO FDT is no longer available in
 ``/sys/kernel/debug/kho/out/fdt``.
-- 
2.43.0



