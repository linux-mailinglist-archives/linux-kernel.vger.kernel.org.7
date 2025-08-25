Return-Path: <linux-kernel+bounces-783970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A294B334D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 05:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5C13B6A56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091B322A1E1;
	Mon, 25 Aug 2025 03:55:03 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCDD200112
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756094102; cv=none; b=MvYayecB+1f3e7EWnbFtAfzT16HiymRqYXUyqanJmZqljvNog5/5viO1IZwsUQhCk6uABBUSbbZdFk07N9DtVB9ZHXV8lRhvT5xKAxAfNkOrYI/Yzugv/VDtNFJn4KrgxjYKatpNN9OTFB3o7XjNEzAsnDkS6OlHCo4VNrQEatU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756094102; c=relaxed/simple;
	bh=28ADaYiyzUt/zv9IvBbFh9bFQMVxj9dGmD0qszY3I5M=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=M+J/xdOUyXuJfVfAl9kVln7SADHhlVb5YbmcLhA52bl9e+emjFqwE/iW8uKSgEmksDMmchoWNi3PepsPhZr1MSW8g4RWu0oavjvmmQ6+/9/M+yqQuf8bJ3FOR1e0ZRPOJAKPOr+O1Y/iC/wBDKFVEACr7BHl1ZyAJDkazoL++YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c9H0y53Pnz2VRQl;
	Mon, 25 Aug 2025 11:52:02 +0800 (CST)
Received: from kwepemk200017.china.huawei.com (unknown [7.202.194.83])
	by mail.maildlp.com (Postfix) with ESMTPS id D8980140276;
	Mon, 25 Aug 2025 11:54:57 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemk200017.china.huawei.com (7.202.194.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 Aug 2025 11:54:57 +0800
Subject: Re: [PATCH v2 3/3] irqchip/gic-v5: Fix error handling in
 gicv5_its_irq_domain_alloc()
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Sascha Bischoff
	<sascha.bischoff@arm.com>, Timothy Hayes <timothy.hayes@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <cover.1752777667.git.dan.carpenter@linaro.org>
 <c9ee3799-8b70-4109-aa13-2febaff9973c@sabinyo.mountain>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <d04c798e-cce4-6e08-2632-0255d48b0564@huawei.com>
Date: Mon, 25 Aug 2025 11:54:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c9ee3799-8b70-4109-aa13-2febaff9973c@sabinyo.mountain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk200017.china.huawei.com (7.202.194.83)

On 2025/7/18 2:45, Dan Carpenter wrote:
> There are two issues to fix in this code:
> 1) If gicv5_alloc_lpi() fails the original code was checking the wrong
> variable.  Fix the mixup between "ret" and "lpi".
> 2) Clean up from all the previous iterations and not just the current
> iteration.
> 
> Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: In v1 I had the wrong goto if gicv5_alloc_lpi() failed.  Also change
> the label name from out_free_lpi to out_free_irqs.
> 
>  drivers/irqchip/irq-gic-v5-its.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

