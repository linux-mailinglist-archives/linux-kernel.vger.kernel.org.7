Return-Path: <linux-kernel+bounces-831570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84546B9D0A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5261B26085
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563D62DE1E3;
	Thu, 25 Sep 2025 01:38:24 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3625E55A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758764304; cv=none; b=ifDDUB2irHcEF9KgadhiF9TOzLyzAX3jkN12JLfuQ0zJMVSShUXIu9L0RWA9byX5Wj9eiRxx2DLWDFSE0fyfCuuwhY2tbBePbvcnbU7SSt5kfhIt30NJn3H6r0PFAr7T68xycqVOb/xEkWsqCeM/VuDRqe/QDg0EuNKzJS6dFBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758764304; c=relaxed/simple;
	bh=vGp3S5xVRuUVKM2nKRFoCtdzrw1K/W/z+YsdoLfko4U=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GJgN4kxXOrW1+xjmXK0yZEw1vqjavgEzKuwfqaR6huzYwWkkDmIhF67vfHJxQvdrLSLIksy1VhqMypkMr4GifghxS1Qg13K29FSqE0B4O+uUoJ2tyaK5U/sInoRxU3g21l3EwS5B6d0vMYJ4GPO9PSmLkdZAcPUMYRtzd+83IVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cXGVj07Q5z1R97M;
	Thu, 25 Sep 2025 09:35:09 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 36E321A016C;
	Thu, 25 Sep 2025 09:38:18 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Sep 2025 09:38:18 +0800
Received: from [10.173.125.236] (10.173.125.236) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Sep 2025 09:38:17 +0800
Subject: Re: [PATCH] mm/memory-failure: not select MEMORY_ISOLATION
To: Xie Yuanbin <xieyuanbin1@huawei.com>
CC: <will@kernel.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<nao.horiguchi@gmail.com>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>
References: <20250922143618.48640-1-xieyuanbin1@huawei.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <76680374-de67-0227-c553-7ef57178c165@huawei.com>
Date: Thu, 25 Sep 2025 09:38:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250922143618.48640-1-xieyuanbin1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2025/9/22 22:36, Xie Yuanbin wrote:
> We added that "select MEMORY_ISOLATION" in commit ee6f509c3274 ("mm:
> factor out memory isolate functions").
> However, in commit add05cecef80 ("mm: soft-offline: don't free target
> page in successful page migration") we remove the need for it,
> where we removed the calls to set_migratetype_isolate() etc.
> 
> What CONFIG_MEMORY_FAILURE soft-offline support wants is migrate_pages()
> support. But that comes with CONFIG_MIGRATION.
> And isolate_folio_to_list() has nothing to do with CONFIG_MEMORY_ISOLATION.
> 
> Therefore, we can remove "select MEMORY_ISOLATION" of MEMORY_FAILURE.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>

Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.

