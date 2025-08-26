Return-Path: <linux-kernel+bounces-785887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1B7B35231
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38DC2425E0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0842D29D9;
	Tue, 26 Aug 2025 03:18:40 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60582D23A6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 03:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756178320; cv=none; b=uHBCVIls3pu9h2kRiLveHsrrQa53KO4gwNf2lYJ06cDf9i20+HUcVIA7b8sjIvl0qCVW4anljWauMMTLM9+J8YAIiCw313uV80iuZQ2ftqNSnUBtFQUtnht+FPbvj8AasAzJMwyCL7lHAlWVcBhmdLBvk5okvWdVEBBw0IjksgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756178320; c=relaxed/simple;
	bh=Vcs3+tE9S/qxRlM9YydRuNlG4ymxRprgBjmTX7rKPTA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KngpdP0+20xOl19aswDfcRv/HJVYve91/ZxDxUxCutRy+XskKK+2SQj1skHwgS8VIvHSN/0lmr0TgXwdOv+6L480rLkGQ8D0pa0RDChQV8897ON4recLPKGWVUAwCziAQYiRZZ89UZVBKUjeuXxPRBjzj/dXpw/IDq7mS+7AITE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c9t6n4rfGz2CgVm;
	Tue, 26 Aug 2025 11:14:09 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 040011A0190;
	Tue, 26 Aug 2025 11:18:35 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 Aug 2025 11:18:34 +0800
Received: from huawei.com (10.173.125.236) by kwepemq500010.china.huawei.com
 (7.202.194.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 Aug
 2025 11:18:34 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <muchun.song@linux.dev>, <osalvador@suse.de>,
	<david@redhat.com>
CC: <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] Revert "hugetlb: make hugetlb depends on SYSFS or SYSCTL"
Date: Tue, 26 Aug 2025 11:09:55 +0800
Message-ID: <20250826030955.2898709-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq500010.china.huawei.com (7.202.194.235)

Commit f8142cf94d47 ("hugetlb: make hugetlb depends on SYSFS or SYSCTL")
added dependency on SYSFS or SYSCTL but hugetlb can be used without SYSFS
or SYSCTL. So this dependency is wrong and should be removed.

This reverts commit f8142cf94d4737ea0c3baffb3b9bad8addcb9b6b.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508222032.bwJsQPZ1-lkp@intel.com/
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index c654a3642897..187a75440aca 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -250,7 +250,6 @@ config ARCH_SUPPORTS_HUGETLBFS
 menuconfig HUGETLBFS
 	bool "HugeTLB file system support"
 	depends on ARCH_SUPPORTS_HUGETLBFS
-	depends on (SYSFS || SYSCTL)
 	select MEMFD_CREATE
 	select PADATA if SMP
 	help
-- 
2.33.0


