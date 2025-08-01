Return-Path: <linux-kernel+bounces-753031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C44F8B17DF0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC451897DAE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2396C218584;
	Fri,  1 Aug 2025 08:00:15 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40411F91C5
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754035214; cv=none; b=WZXIgPzBSQg6KDuY3JN2q4SsmhcFlLMLMiCpHp0NRNVzRR8ujVnVUNxz35tMcBm86pVIoAfdthNirHY2hJDCkCNTDgYCokvkX1SiE9pyMW6/G3mH+xUGnO264zzFr4N+Akalj1X408dSGry4r3ymJ6w/aL5hdJPpz9CMFbniOiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754035214; c=relaxed/simple;
	bh=RAjCt9uKDFbe+vPGvhUKJl5YUkwXiJb7/mDYpjF1tOI=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=G2mSM2BYv/JKfWAKHERUF39oSdOAeKhgO3UkqzXj75x/hurzHOgMUxf2QFiakH0c1sa9pnlob9N8Sm8XvhR6eSK/OrW8iQz93UV/d9ytBH8MXy5zBIIr2e71g2pvgPqNMo0bE+SLppa/FADYUsHt9HxM/SMIm5C1g443CrkX9UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4btdbX1sV8z2RVy4;
	Fri,  1 Aug 2025 15:57:44 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E48514027A;
	Fri,  1 Aug 2025 16:00:09 +0800 (CST)
Received: from [10.67.121.183] (10.67.121.183) by
 dggpemf500013.china.huawei.com (7.185.36.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Aug 2025 16:00:08 +0800
Message-ID: <c7bc0979-3721-49ba-89bd-ebcaa5ce70d9@huawei.com>
Date: Fri, 1 Aug 2025 16:00:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <maz@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: Zhou Wang <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>,
	Luchunhua <luchunhua@huawei.com>, liuyonglong <liuyonglong@huawei.com>,
	"xuwei (O)" <xuwei5@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>
From: Jinqian Yang <yangjinqian1@huawei.com>
Subject: Regarding the Issue of vNMI Not Supporting Live Migration
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500013.china.huawei.com (7.185.36.188)

Hi，marc

https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=arm64/nmi

During the testing of this set of vNMI patches, it was discovered that 
vNMI do not support live
migration. The reason is that GICD_INMIR/GICR_INMIR0 have not been 
migrated, causing
irq->nmi to reset to 0 after migration. Therefore, to resolve this 
issue, we need to complete the
migration of GICD_INMIR/GICR_INMIR0. This set of patches does not seem 
to have been uploaded
to the mainline. I was wondering if these are scheduled for upload to 
the mainline?


Thanks,
Jinqian



