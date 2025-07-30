Return-Path: <linux-kernel+bounces-750814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7148CB16158
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07D71AA17C7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23D8299AA0;
	Wed, 30 Jul 2025 13:21:23 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E291413B284
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881683; cv=none; b=f4xtDk/2vz+qBMYO3m27hpcjrqFlkp3u6BJIYuFrdKDlWEZoBzswb7ksamjbvOEPEs+sHG2f8AxYMThPlN1PgceQ0dTLPhKVDnicukDyE6uBuQksa27cFDP33fp+rAdn4O27mNJXxJHrQQyab0ns3QLSsvkxnQ4RpOg3RF6ZkXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881683; c=relaxed/simple;
	bh=ur9DU62uLbaRr3z05vT3quPJrqVhXl1UXwDJwHpdNDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VyUHFntqqoZ2HSbx8cWayYnNFBRBKh+wxTd3rN+XTGofjXns/asrBRq5RvlTk8F2X0QIjtO6RE0Xr4jGPa4Zwlc0w8mWTnhWkmfKtHFI477V1Io2aHlmVionyrFOuXD+vIU+hfW/dOanFqCA5X7rb//dd5G+t41k8u0+nRIqDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bsXmv2Gc2zdc6T;
	Wed, 30 Jul 2025 21:17:03 +0800 (CST)
Received: from dggpemf100017.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id E7A48180485;
	Wed, 30 Jul 2025 21:21:16 +0800 (CST)
Received: from [10.67.111.186] (10.67.111.186) by
 dggpemf100017.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Jul 2025 21:21:16 +0800
Message-ID: <f3809f8b-693e-1d6e-7adf-12757f43a20b@huawei.com>
Date: Wed, 30 Jul 2025 21:21:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] sched/clock: Init generic clock with
 CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
To: <tglx@linutronix.de>, <frederic@kernel.org>, <anna-maria@linutronix.de>,
	<jstultz@google.com>, <peterz@infradead.org>, <namcao@linutronix.de>
CC: <linux-kernel@vger.kernel.org>, <yuanlulu4@huawei.com>,
	<tanghui20@huawei.com>
References: <20250723020326.622368-1-zhangqiao22@huawei.com>
From: Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <20250723020326.622368-1-zhangqiao22@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf100017.china.huawei.com (7.185.36.74)

ping...

在 2025/7/23 10:03, Zhang Qiao 写道:
> The sched_clock_timer is used to prevent the sched clock wrapped, this
> timer is initialized in generic_sched_clock_init();
> 
> When CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y, generic_sched_clock_init() is
> not called and sched_clock_timer is not initialized, causing the
> sched clock to wrap.
> 
> To fix this issue, call generic_sched_clock_init() in sched_clock_init()
> to initialize the sched_clock_timer.
> 
> Fixes: 5d2a4e91a541 ("sched/clock: Move sched clock initialization and merge with generic clock")
> Reported-by: yuanlulu <yuanlulu4@huawei.com>
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> ---
>  kernel/sched/clock.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> index a09655b481402..13e76cfb59f23 100644
> --- a/kernel/sched/clock.c
> +++ b/kernel/sched/clock.c
> @@ -213,6 +213,7 @@ void __init sched_clock_init(void)
>  	 */
>  	local_irq_disable();
>  	__sched_clock_gtod_offset();
> +	generic_sched_clock_init();
>  	local_irq_enable();
>  
>  	static_branch_inc(&sched_clock_running);
> 

