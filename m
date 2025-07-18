Return-Path: <linux-kernel+bounces-736478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A84CB09D60
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87992A84A83
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1346A220F2B;
	Fri, 18 Jul 2025 08:05:51 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED51D249F9
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825950; cv=none; b=s/cMa6GC+vgSsyVPaF04ADDKS4sftGxckh+KtM4Woy/sH0Wia/ELX2XYOU63yuBC32brGwuVSB2Q6milfiU0uHA1x/v9DM+V7b1qEvhmEiAgUnnB0f2iP6X6Qorb1epvZhrRnUObxG4wZXn78MjrnEbjH6TJLO4vkSVOnlO1Be4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825950; c=relaxed/simple;
	bh=lm9ChqT6RIMtwyUpY09E3vPabin4dyRBw/Pky1EC84Y=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=lNaOgZrjYjg8FuwWAgNJtDISwQJA5ipyil53KXPGx29D8j6/h//iHIU8T6+hUj8REdIR5AjIaTFt9WKDafJ6VcnD0t4D654K5uAp9jAMF+/hcDt54yacpHoYuOnRzaYt64tFaLEqRc3IbMAzP39l3ZzUHudA37iYiUTE7Zl17g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bk2Pk3gpxztSvY;
	Fri, 18 Jul 2025 16:04:26 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 70BF314011F;
	Fri, 18 Jul 2025 16:05:31 +0800 (CST)
Received: from kwepemq100003.china.huawei.com (7.202.195.72) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Jul 2025 16:05:31 +0800
Received: from [10.67.113.98] (10.67.113.98) by kwepemq100003.china.huawei.com
 (7.202.195.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Jul
 2025 16:05:30 +0800
Message-ID: <687A004A.7030905@hisilicon.com>
Date: Fri, 18 Jul 2025 16:05:30 +0800
From: Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Huisong Li <lihuisong@huawei.com>, <xuwei5@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>
Subject: Re: [PATCH] soc: hisilicon: kunpeng_hccs: Fix incorrect log information
References: <20250711063706.3121253-1-lihuisong@huawei.com>
In-Reply-To: <20250711063706.3121253-1-lihuisong@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq100003.china.huawei.com (7.202.195.72)

Hi Huisong,

On 2025/7/11 14:37, Huisong Li wrote:
> The hccs_get_all_spec_port_idle_sta() will tell user which port
> is busy when firmware doesn't allow to decrease HCCS lane number.
> However, the current log prints the index of die and port instead
> of the hardware ID user perceived.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/soc/hisilicon/kunpeng_hccs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
> index 7fc353732d55..65ff45fdcac7 100644
> --- a/drivers/soc/hisilicon/kunpeng_hccs.c
> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
> @@ -1295,11 +1295,11 @@ static int hccs_get_all_spec_port_idle_sta(struct hccs_dev *hdev, u8 port_type,
>  				if (ret) {
>  					dev_err(hdev->dev,
>  						"hccs%u on chip%u/die%u get idle status failed, ret = %d.\n",
> -						k, i, j, ret);
> +						port->port_id, chip->chip_id, die->die_id, ret);
>  					return ret;
>  				} else if (idle == 0) {
>  					dev_info(hdev->dev, "hccs%u on chip%u/die%u is busy.\n",
> -						k, i, j);
> +						 port->port_id, chip->chip_id, die->die_id);
>  					return 0;
>  				}
>  			}
> 

Applied to the Hisilicon driver tree.
Thanks!

Best Regards,
Wei

