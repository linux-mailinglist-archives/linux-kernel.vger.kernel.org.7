Return-Path: <linux-kernel+bounces-810095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F17BBB515C7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A769C166331
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691E528469C;
	Wed, 10 Sep 2025 11:32:49 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C6E2797B5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503969; cv=none; b=Id2u5gxodBCneMKmI9BHKQe3RR6syjMU9JJY5r+8X7L43O7URfrDT2mVdMlZki6fDafkBVbG+7JtsajeAkkVJkntnRuNi/pIXslOmOeYvESFo39DM7pRFK8E3e5BERuxhXyojAUyJb+EG5cum5PBD8ZGdtcljVW2Cy5n0GRB2z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503969; c=relaxed/simple;
	bh=dIf0l04h+jedLysAhyX7XSuqhxEohD1YSsj0Z0jEG+M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O5ojvl6oC8red4vtqehquNfSDOeTixzz/Pxefobl4WmRQS+6aWcKYp1jaLWk3U7ihuFvZE+tzfkaQawSOqVn09N5VhbaOch51cfHoP+XV0TkhkCEabidckKhUKuXzsqNO87v3NAIWM/iHcjCQglWEjSRYJ2RW67ZAYKiYN7Ui2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cMJSn2Mh3z14MjD;
	Wed, 10 Sep 2025 19:32:25 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 99BF31402EA;
	Wed, 10 Sep 2025 19:32:38 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 10 Sep
 2025 19:32:37 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [PATCH 0/2] mm/damon: add addr_unit for DAMON_LRU_SORT and DAMON_RECLAIM
Date: Wed, 10 Sep 2025 19:32:19 +0800
Message-ID: <20250910113221.1065764-1-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf200018.china.huawei.com (7.185.36.31)

In DAMON_LRU_SORT and DAMON_RECLAIM, damon_ctx is independent
of the core. Add addr_unit to these modules to support systems
like ARM32 with LPAE.

Quanmin Yan (2):
  mm/damon/lru_sort: support addr_unit for DAMON_LRU_SORT
  mm/damon/reclaim: support addr_unit for DAMON_RECLAIM

 mm/damon/lru_sort.c | 40 ++++++++++++++++++++++++++++++++++++++++
 mm/damon/reclaim.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

-- 
2.43.0


