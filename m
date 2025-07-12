Return-Path: <linux-kernel+bounces-728485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E35ECB028D3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A17E54664D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EFD149C64;
	Sat, 12 Jul 2025 01:22:59 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC8A17F7
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 01:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752283379; cv=none; b=s3+G1o8uR9Tuj4VQsm8eOKcxghJy6ve+fLpstdEXt7pW7zKJ4wMTHXSBsMhZ/RxZX3VGZJ7/n5k9UusxcUOXYK8gDInrHIssYXBGIXBkiJUWXGJwJwIHHyKHGO9kJUc9Iv6sB+kaCXtP89zRmmI9x4AfwdldS5tSj9NtPnSlrv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752283379; c=relaxed/simple;
	bh=5I+JVArl9D6qIZ5wqwz60wr95rbiYViXQm83wLba8m0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KDGHQMig6u1zcoOyEz0/CfZrobJDbHVw0mXOqLJHpeVjxHhekyRwfqyW0+zf1pX1Q+KH4CaMAXIDY2wCC25L/WDM1H9i3Ms90mQf9RUSKcHNVY+kXm5PpPq5cf4Mhoqta2nfRSXw4PPOTTeV/qpewBwTfPiRDofwAs26uZn55BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bf9ln5zHKztSfD;
	Sat, 12 Jul 2025 09:21:41 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id E1E18140132;
	Sat, 12 Jul 2025 09:22:47 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 12 Jul 2025 09:22:47 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 12 Jul
 2025 09:22:47 +0800
Message-ID: <3c031732-9090-454c-b52a-a5c01135f466@huawei.com>
Date: Sat, 12 Jul 2025 09:22:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: hisilicon: kunpeng_hccs: Fix incorrect log
 information
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <linuxarm@huawei.com>
CC: <xuwei5@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <zhanjie9@hisilicon.com>
References: <20250711063706.3121253-1-lihuisong@huawei.com>
 <20250711113816.00003403@huawei.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250711113816.00003403@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/7/11 18:38, Jonathan Cameron 写道:
> On Fri, 11 Jul 2025 14:37:06 +0800
> Huisong Li <lihuisong@huawei.com> wrote:
>
>> The hccs_get_all_spec_port_idle_sta() will tell user which port
>> is busy when firmware doesn't allow to decrease HCCS lane number.
>> However, the current log prints the index of die and port instead
>> of the hardware ID user perceived.
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>
> Maybe adding an example of a wrong print and how it is fixed to this
> patch description would make the problem even more obvious?
Yes.
The problem and modification are very simple, and this description is 
also enough.
> Not worth respin for that though!
ok, thanks for your review.
>
>> ---
>>   drivers/soc/hisilicon/kunpeng_hccs.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
>> index 7fc353732d55..65ff45fdcac7 100644
>> --- a/drivers/soc/hisilicon/kunpeng_hccs.c
>> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
>> @@ -1295,11 +1295,11 @@ static int hccs_get_all_spec_port_idle_sta(struct hccs_dev *hdev, u8 port_type,
>>   				if (ret) {
>>   					dev_err(hdev->dev,
>>   						"hccs%u on chip%u/die%u get idle status failed, ret = %d.\n",
>> -						k, i, j, ret);
>> +						port->port_id, chip->chip_id, die->die_id, ret);
>>   					return ret;
>>   				} else if (idle == 0) {
>>   					dev_info(hdev->dev, "hccs%u on chip%u/die%u is busy.\n",
>> -						k, i, j);
>> +						 port->port_id, chip->chip_id, die->die_id);
>>   					return 0;
>>   				}
>>   			}

