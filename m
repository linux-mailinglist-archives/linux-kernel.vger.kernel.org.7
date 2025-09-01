Return-Path: <linux-kernel+bounces-794523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EF3B3E2DD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDF417AF549
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2E734167F;
	Mon,  1 Sep 2025 12:26:26 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E48341650;
	Mon,  1 Sep 2025 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729585; cv=none; b=RxcVwUDZzpycvKXq7Xvvm/RBVdH8woA9+ODRO5VZovHVP9aqF6yD9yKfnFzSGYHVdotcT1VFdMudWB/KWpQeJMNjj0OhHOC/JdcI1bWC6pudLLp2mUoUP9q9go53q+wuaW0Or7evMrms8cxwbKdTWhqYmfh7TiUgkPeAVli45BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729585; c=relaxed/simple;
	bh=NnciR5EbBfTgt2KLS8vc1dAmERLN0FyIiGO9TCy81Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UzV2XiaJlHfzVi/mjoa0dHyYe0Awe9fkKDMzN40juVozfDO7GccCf19okopbKY1NZsFcn/VnckqEGbmDtTZh20iAFD5nJRuDaGIhBCCKiO56ljW3yS+VWHAX40uogzPu1y7Iklafp+MQ+7C5ESwPc0dEDUnwlqtIR4NwCoh/G10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cFp1c5Rpcz24hsH;
	Mon,  1 Sep 2025 20:23:16 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id D890C1A016C;
	Mon,  1 Sep 2025 20:26:20 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Sep 2025 20:26:20 +0800
Message-ID: <10a29e1a-fc48-45e6-940e-e5b3bc60b43b@huawei.com>
Date: Mon, 1 Sep 2025 20:26:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 0/2] ipv6: improve rpl_seg_enabled sysctl
 handling
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<kuniyu@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250901123726.1972881-1-yuehaibing@huawei.com>
Content-Language: en-US
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <20250901123726.1972881-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/9/1 20:37, Yue Haibing wrote:
> First commit annotate data-races around it and second one add sanity check that
> prevents unintentional misconfiguration.
> 
I forget to mention the revision history

v3: split v2 into two separate ones and drop Fixes tag.
v2: add extra1/2 check

> Yue Haibing (2):
>   ipv6: annotate data-races around devconf->rpl_seg_enabled
>   ipv6: Add sanity checks on ipv6_devconf.rpl_seg_enabled
> 
>  net/ipv6/addrconf.c | 4 +++-
>  net/ipv6/exthdrs.c  | 6 ++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 

