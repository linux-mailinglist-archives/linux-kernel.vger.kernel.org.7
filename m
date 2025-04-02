Return-Path: <linux-kernel+bounces-585146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1327A79025
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 15:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BCD716FFEC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 13:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A1523A9B7;
	Wed,  2 Apr 2025 13:45:10 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBFA23A989
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743601510; cv=none; b=Gj8pFUNAMGYM9Fbw/ANTJvVTA6KJErV2jxUXe9jPe5k+z8ZP+K6+vhZ4Y9iknC0Q4TN4aJC0UIK1zNzXqr8bWG7uiYKLNNewxR8CWV90neV1sMAzaELxD3fBw4IhYeVs4tHZTOy6kNLSukDliN87U54Xd0meYdPZ95j87Jy3Pw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743601510; c=relaxed/simple;
	bh=sTRLlDut0NE0rxGw8O3zmmuspwpenBHKz76wLbnjUYM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RpzAtX2IfzCA7ncxrV26/HixWeGPw5I+5oZeWkI9OGkmQk1fUTPSz+HUeGxTZG2z7SMfEsP8ZVW/PgwCSfQ0EX4tPq3sECyRc7A4Xzx8laqcpUpfN6uwffx6BvquzQUZlg0YtfAjI6Sl3nHM/8ezKB2UJTGwD5HSD2DxiUo+oEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZSQxx275yz6M4lj;
	Wed,  2 Apr 2025 21:41:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C6391406AD;
	Wed,  2 Apr 2025 21:45:04 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.48.153.182) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Apr 2025 15:44:59 +0200
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <kvmarm@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<oliver.upton@linux.dev>
CC: <maz@kernel.org>, <mark.rutland@arm.com>, <lpieralisi@kernel.org>,
	<sudeep.holla@arm.com>, <catalin.marinas@arm.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] smccc/kvm_guest: Remove the accidental semicolon
Date: Wed, 2 Apr 2025 14:44:01 +0100
Message-ID: <20250402134401.146156-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500008.china.huawei.com (7.182.85.71)

Fixes cocci reported warning:Unneeded semicolon

Fixes: 86edf6bdcf05 ("smccc/kvm_guest: Enable errata based on implementation CPUs")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504020941.VEeL6nVJ-lkp@intel.com/
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/firmware/smccc/kvm_guest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/smccc/kvm_guest.c b/drivers/firmware/smccc/kvm_guest.c
index 5767aed25cdc..ffe9f3c013df 100644
--- a/drivers/firmware/smccc/kvm_guest.c
+++ b/drivers/firmware/smccc/kvm_guest.c
@@ -103,7 +103,7 @@ void  __init kvm_arm_target_impl_cpu_init(void)
 		target[i].midr = res.a1;
 		target[i].revidr = res.a2;
 		target[i].aidr = res.a3;
-	};
+	}
 
 	if (!cpu_errata_set_target_impl(max_cpus, target)) {
 		pr_warn("Failed to set target implementation CPUs\n");
-- 
2.47.0


