Return-Path: <linux-kernel+bounces-783969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6C1B334D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 05:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264AD201718
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8232264C9;
	Mon, 25 Aug 2025 03:54:35 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E8511CA9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756094075; cv=none; b=LioCjIo/WV07KCMA35DQQO0+h9gsAqxyk5VdEXkQgb0WPgaCkAXYG5MQEGt7gSlfyI65EPmN7DPZR9RJXgprli8L8wG59XLYOLe9UIfwiJasUvOcdA8y6ALNXLzj+3Vl9NftfJfEWYVf5IUd8kZp8wWThh0a5+rqtp59Zu5PvbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756094075; c=relaxed/simple;
	bh=f7wczhcNJqCwv68Cy85kw827Q19Qwa2Jsu5xwZxDrog=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OD/Q4ai/IPzLA8tY8R9ppetwOrLjNmk/Vr3bmDH7f+i/rs8rDzQlf8FJ2GwsnV2AGXP3aYvIeto4sV6aWvwPbDaLLuexPNGvOHiJLsTBR8aLAEp0g+iJZcX6SM4OjJ+4AQe02e6YZBmxiJ6YaQQpP29Y80Peswuqo2ASStStX1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c9GzY0NZ2z13NG3;
	Mon, 25 Aug 2025 11:50:49 +0800 (CST)
Received: from kwepemk200017.china.huawei.com (unknown [7.202.194.83])
	by mail.maildlp.com (Postfix) with ESMTPS id 6DD6C180B58;
	Mon, 25 Aug 2025 11:54:28 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemk200017.china.huawei.com (7.202.194.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 Aug 2025 11:54:27 +0800
Subject: Re: [PATCH v2 2/3] irqchip/gic-v5: Fix forever loop in
 gicv5_its_create_itt_two_level() error handling
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Timothy Hayes <timothy.hayes@arm.com>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <cover.1752777667.git.dan.carpenter@linaro.org>
 <a6dd885a-5a1b-41b5-9673-0d42f7fa929d@sabinyo.mountain>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <e360d42c-bd83-0cb9-7298-86e197668508@huawei.com>
Date: Mon, 25 Aug 2025 11:54:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a6dd885a-5a1b-41b5-9673-0d42f7fa929d@sabinyo.mountain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk200017.china.huawei.com (7.202.194.83)

On 2025/7/18 2:45, Dan Carpenter wrote:
> The "i" variable needs to be signed otherwise there is a forever loop
> in the cleanup code.
> 
> Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: no change
> 
>  drivers/irqchip/irq-gic-v5-its.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

