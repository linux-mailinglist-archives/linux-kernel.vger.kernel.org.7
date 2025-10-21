Return-Path: <linux-kernel+bounces-863542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59256BF819F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602E21883D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2E034D936;
	Tue, 21 Oct 2025 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="t1jEoHh2"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A775F34D91F
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071774; cv=none; b=EvghMXl4Nwh+aMzkN6F0yCIjY2dpXk5E/exTC6uC5qhzSQkwv4MJcgJTF2AULtAqg6jzpFazFzdl+wlzijmJd6aAYYv8GI2NYjpRW8r9Op//D4MxxLDsavWR/nfaPn0qVmhOufu/lM9MaEiCWO+q3T9cTXjFcIVFoW3TChbdHfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071774; c=relaxed/simple;
	bh=bxJTtK6IR2c6RWv8BKqyxx6jOYHtmF+RyHtk8OzeAA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=JOlgrQbnOvlpfrjtZO9aweMSgEmJz6x9+7EwEBYRZwj+9PJyDESqOvrbf4F7xOBjaKR+KeAJb/g9Al/ujxFtou5t7QXNmhIzHSsWSuhjLa5MPSRX5ZvTjzZgnSuw6A6Zm80BRJDDIPYYrX651VNicHKsnjHViCMYTtw+qxDQeKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=t1jEoHh2; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251021183604euoutp0203772f0bc962eb78b1f192b6f072d0d1~wlXCClVWW0199901999euoutp02M
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:36:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251021183604euoutp0203772f0bc962eb78b1f192b6f072d0d1~wlXCClVWW0199901999euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761071764;
	bh=DJKT2QONZCH3kce1x0l6r7O/vjQeswEDBGtYmqkrZlY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=t1jEoHh2mGultn0vKqMDg4pjoB4gyhpPLw3irgvnbrDmkih1wF3yYeKKQiTfK0DGW
	 qSO9uIGJxwPWPJpI8wyDwqNjlboO3IYD8OOdZRr/68o7hCIIM/uLNEPW26/iq1D8VU
	 89Rpcj9y37qOg+WGhfXUqe372alAX/YZt9qCceos=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251021183604eucas1p128aae1b63df44b4dfd26abe2a3d3cd11~wlXB09V7V0437104371eucas1p17;
	Tue, 21 Oct 2025 18:36:04 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251021183603eusmtip1fd1f79b260b6cc623515b24c5eae6a9e~wlXBTN8bd2983529835eusmtip1y;
	Tue, 21 Oct 2025 18:36:03 +0000 (GMT)
Message-ID: <e8a0782a-4e63-45a6-85c8-e3113b1f391a@samsung.com>
Date: Tue, 21 Oct 2025 20:36:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: th1520: fix clock imbalance on probe failure
To: Johan Hovold <johan@kernel.org>, Drew Fustini <fustini@kernel.org>, Guo
	Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Jassi Brar
	<jassisinghbrar@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20251017055414.7753-1-johan@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251021183604eucas1p128aae1b63df44b4dfd26abe2a3d3cd11
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251017055521eucas1p1344f04a5012eb6981315cf160ffc1ec6
X-EPHeader: CA
X-CMS-RootMailID: 20251017055521eucas1p1344f04a5012eb6981315cf160ffc1ec6
References: <CGME20251017055521eucas1p1344f04a5012eb6981315cf160ffc1ec6@eucas1p1.samsung.com>
	<20251017055414.7753-1-johan@kernel.org>



On 10/17/25 07:54, Johan Hovold wrote:
> The purpose of the devm_add_action_or_reset() helper is to call the
> action function in case adding an action ever fails so drop the clock
> disable from the error path to avoid disabling the clocks twice.
> 
> Fixes: 5d4d263e1c6b ("mailbox: Introduce support for T-head TH1520 Mailbox driver")
> Cc: Michal Wilczynski <m.wilczynski@samsung.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/mailbox/mailbox-th1520.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mailbox/mailbox-th1520.c b/drivers/mailbox/mailbox-th1520.c
> index a6b2aa9ae952..626957c2e435 100644
> --- a/drivers/mailbox/mailbox-th1520.c
> +++ b/drivers/mailbox/mailbox-th1520.c
> @@ -435,10 +435,8 @@ static int th1520_mbox_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = devm_add_action_or_reset(dev, th1520_disable_clk, priv);
> -	if (ret) {
> -		clk_bulk_disable_unprepare(ARRAY_SIZE(priv->clocks), priv->clocks);
> +	if (ret)
>  		return ret;
> -	}
>  
>  	/*
>  	 * The address mappings in the device tree align precisely with those

Hi,
Thanks for your fix. I believe it is correct as devm_add_action_or_reset
will call th1520_disable_clk on failure, like you noticed.

Reviewed-by: Michal Wilczynski <m.wilczynski@samsung.com>

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

