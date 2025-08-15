Return-Path: <linux-kernel+bounces-769974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C80BFB27586
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A971C2364C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093E1293C65;
	Fri, 15 Aug 2025 02:15:41 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41A1F4FA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224140; cv=none; b=ccSC5pvOJ+GOH6RlywxNu4fXpiw3/dhJWQnnX3Y8CWwf8DngUjvDiHbsdKb5Ut9twXCS4AztRPPRRmot/lGClgyuFYBhc7Q7COTpoxNdMIrTz5sOpGBKQkwi3YsIXJe1X5vVZq+6eGdYO0t/f5tdKkv8aYVKabH6WqTxivqmv4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224140; c=relaxed/simple;
	bh=uYVjjafGIwMBYrnlSSjN88PwMoWPn8KY45MR+Rz2xp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gV2WnXJpW5A2tux0cErPdZ0YijndrKIl2h0rRmM+qASBuWv1IL0GAgoE6v4JsndCjP6aX//EGtl6deBPWqb9imv2LVke5nU4M+nPnih46e+YGyehir+AoJ6/YOht43egqeZQTcYAx6vZUJOhO0SWLiYBWb/62KwknxrA9o+QNLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c35LF4NQgzvWyP;
	Fri, 15 Aug 2025 10:15:33 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AB52180B54;
	Fri, 15 Aug 2025 10:15:35 +0800 (CST)
Received: from kwepemq200012.china.huawei.com (7.202.194.183) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 10:15:34 +0800
Received: from [10.174.178.57] (10.174.178.57) by
 kwepemq200012.china.huawei.com (7.202.194.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 10:15:34 +0800
Message-ID: <cba05a2e-3121-4732-9e2f-73892e8047ab@huawei.com>
Date: Fri, 15 Aug 2025 10:15:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] irqchip/mbigen: Use fw_devlink_relax_consumers()
 helper
To: Saravana Kannan <saravanak@google.com>, Greg KH
	<gregkh@linuxfoundation.org>
CC: <rafael@kernel.org>, <dakr@kernel.org>, <tglx@linutronix.de>,
	<robh@kernel.org>, <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
	<chenjun102@huawei.com>
References: <20250814111023.2693-1-wangwensheng4@huawei.com>
 <20250814111023.2693-4-wangwensheng4@huawei.com>
 <2025081405-automatic-perkiness-7145@gregkh>
 <CAGETcx-92+zN3YivUoEU-U68=GUnGs-68+g8rM7LnLXBRH=xyQ@mail.gmail.com>
From: "wangwensheng (C)" <wangwensheng4@huawei.com>
In-Reply-To: <CAGETcx-92+zN3YivUoEU-U68=GUnGs-68+g8rM7LnLXBRH=xyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq200012.china.huawei.com (7.202.194.183)



在 2025/8/15 2:05, Saravana Kannan 写道:
> On Thu, Aug 14, 2025 at 4:39 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Thu, Aug 14, 2025 at 07:10:23PM +0800, Wang Wensheng wrote:
>>> Use this to prevernt the consumer devices of mbigen to be probed too
>>> later.
>>>
>>> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
>>> ---
>>>   drivers/irqchip/irq-mbigen.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
>>> index 6f69f4e5dbac..4e96eb9b6a6a 100644
>>> --- a/drivers/irqchip/irq-mbigen.c
>>> +++ b/drivers/irqchip/irq-mbigen.c
>>> @@ -252,6 +252,8 @@ static int mbigen_of_create_domain(struct platform_device *pdev,
>>>
>>>                if (!mbigen_create_device_domain(&child->dev, num_pins, mgn_chip))
>>>                        return -ENOMEM;
>>> +
>>> +             fw_devlink_relax_consumers(&child->dev);
>>
>> Ick, no, individual drivers should not be doing this.  Saravana, any
>> ideas?
> 
> Yeah, I responded to patch 2/3.
> 
> To give a more specific answer, this driver is just adding platform
> devices to the platform bus that it never probes. They should create a
> class for these and add these devices to their own class. fw_devlink
> is smart enough about not waiting on class devices to probe. If for
> whatever reason, switching it to a class is impossible, then they
> should write a stub driver to probe these devices.
> 
> -Saravana

Thanks for your suggestion. I will try this way later.


