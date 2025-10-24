Return-Path: <linux-kernel+bounces-868000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 763CEC041DB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5064D1AA471E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7F2242D63;
	Fri, 24 Oct 2025 02:29:16 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21392288CB;
	Fri, 24 Oct 2025 02:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761272955; cv=none; b=ED2E/l/nsDj4EwePjES/HEFyGbqzq/46dxP/OjHFTis5A9fxzpifSi5QWGf5rP8TsAGZ0asvKo6PuM2mOtiaWz2yOIKO19VMuNhBAFYU1MAOgUi/i9IFM4pSVqnp3XmZIYYXsk40V6qhbCq16/ol7BjNCPVq2Y/YDVJHxfpbDjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761272955; c=relaxed/simple;
	bh=oB/wXapqWLj7Bp5kmlG6+rgKm1/NpjYznJeuvkRv/Rk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nQuKb4tcm9z4mnTUayuWYFlxRHnS90OPCqX8Z4RJGDToK/pdFyoQI13MaY99gCn4bLzYpH3p5GUhXrDXQix+CP2EpMybT9wjsaKJ/TybF0/EaPqeo5JHzUf2lly+id8dNfIASTG4Tv3ul0KAXVVzGIQchFXKoykG4bNsTD+EYOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ct6Fj63V3z1R9G1;
	Fri, 24 Oct 2025 10:25:45 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 446ED14022E;
	Fri, 24 Oct 2025 10:29:08 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 24 Oct
 2025 10:29:07 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <xmei5@asu.edu>,
	<yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net/sched: Remove unused typedef psched_tdiff_t
Date: Fri, 24 Oct 2025 10:51:45 +0800
Message-ID: <20251024025145.4069583-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Since commit 051d44209842 ("net/sched: Retire CBQ qdisc")
this is not used anymore.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/pkt_sched.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index c660ac871083..4678db45832a 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -43,7 +43,6 @@ struct qdisc_walker {
  */
 
 typedef u64	psched_time_t;
-typedef long	psched_tdiff_t;
 
 /* Avoid doing 64 bit divide */
 #define PSCHED_SHIFT			6
-- 
2.34.1


