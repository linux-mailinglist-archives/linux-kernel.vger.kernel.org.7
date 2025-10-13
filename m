Return-Path: <linux-kernel+bounces-849917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5D5BD1542
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D9A3B2463
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BA4273D6D;
	Mon, 13 Oct 2025 03:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xs0QJcAM"
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297041A8F97
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760326776; cv=none; b=KrG1D2mJqx4pfQdMsFwK35LTxucnyO2OBKkvSGoNMzCEHH3PEDTbIGdiPhtSibRQI0FPVRu5UgJH/l6+Sjnw9/yImTC6etQ4N/a4pFHrGvvEY+n5Uw5NCZSn8G6qwHDMCV7Te2Z7U98E7/5nwnOrU8OR5ujhdktGytIIsc9VZDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760326776; c=relaxed/simple;
	bh=O2YV4ohW9cBru5LgLZtGYiGSWe9rDLR2HftVazMD+ac=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gZjJKYVq5QU1ozbhcWs8mAB9mwwXBG57EAfYZDyI6Zrc0Lw8F631jF+MqabJbaJU/rajU8Hv4lFan7hRegpqWGEYMdpYrArvNWEjUaVNUWYvDLrr2spps8Dr9fruFsGdFsAhan/vCHcAGwBXf+srFVscGbzHCarWBdPgTTHE7Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xs0QJcAM; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wzTCrnXaIrWRzmISflwP0SBUw+W5zP+wxm2ZCkd2RSo=;
	b=xs0QJcAMosm2Eimlc9EiB/+C+H9Cjv8XRaOnA7czp0qrVcn1+8KL1uQBxMJgB8tcAOrfOAPqk
	UxZO7BUPM1W84So+ZY6TymFi4mnirjos4T0VbdhtKR6jvK1046ZSzGSL+TdZAteG7rB6WDlyDo2
	smeFfaD9BrIvUscwMjlx/HM=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4clNNz0F60z1T4Kj;
	Mon, 13 Oct 2025 11:38:43 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 70FD6180064;
	Mon, 13 Oct 2025 11:39:24 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Oct 2025 11:39:24 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Oct 2025 11:39:23 +0800
Subject: Re: [PATCH RFC 1/1] mm/ksm: Add recovery mechanism for memory
 failures
To: Lance Yang <lance.yang@linux.dev>
CC: Longlong Xia <xialonglong2025@163.com>, <nao.horiguchi@gmail.com>,
	<akpm@linux-foundation.org>, <wangkefeng.wang@huawei.com>,
	<xu.xin16@zte.com.cn>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	Longlong Xia <xialonglong@kylinos.cn>, <david@redhat.com>
References: <20251009070045.2011920-1-xialonglong2025@163.com>
 <20251009070045.2011920-2-xialonglong2025@163.com>
 <CABzRoyYfx0QPgGG4WYEYmT8-J10ToRCUStd3tWC0CtT_D8ctiQ@mail.gmail.com>
 <CABzRoyYK38imLh6zN2DZKPRyQrJkKyvpswqJAsWzEeECtOxaMA@mail.gmail.com>
 <55370eb6-9798-0f46-2301-d5f66528411b@huawei.com>
 <077882e3-f69f-44f3-aa74-b325721beb42@linux.dev>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <839b72b8-55dc-4f4e-b1da-6f24ecf9446f@huawei.com>
Date: Mon, 13 Oct 2025 11:39:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <077882e3-f69f-44f3-aa74-b325721beb42@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2025/10/11 17:38, Lance Yang wrote:
> 
> 
> On 2025/10/11 17:23, Miaohe Lin wrote:
>> On 2025/10/11 15:52, Lance Yang wrote:
>>> @Miaohe
>>>
>>> I'd like to raise a concern about a potential hardware failure :)
>>
>> Thanks for your thought.
>>
>>>
>>> My tests show that if the shared zeropage (or huge zeropage) gets marked
>>> with HWpoison, the kernel continues to install it for new mappings.
>>> Surprisingly, it does not kill the accessing process ...
>>
>> Have you investigated the cause? If user space writes to shared zeropage,
>> it will trigger COW and a new page will be installed. After that, reading
>> the newly allocated page won't trigger memory error. In this scene, it does
>> not kill the accessing process.
> 
> Not write just read :)
> 
>>
>>>
>>> The concern is, once the page is no longer zero-filled due to the hardware
>>> failure, what will happen? Would this lead to silent data corruption for
>>> applications that expect to read zeros?
>>
>> IMHO, once the page is no longer zero-filled due to the hardware failure, later
>> any read will trigger memory error and memory_failure should handle that.
> 
> I've only tested injecting an error on the shared zeropage using corrupt-pfn:
> 
> echo $PFN > /sys/kernel/debug/hwpoison/corrupt-pfn
> 
> But no memory error was triggered on a subsequent read ...

It's because corrupt-pfn only provides a software error injection mechanism.
If you want to trigger memory error on read, you need use hardware error injection
mechanism e.g.APEI Error INJection [1].

[1] https://www.kernel.org/doc/html/v5.8/firmware-guide/acpi/apei/einj.html

Thanks.
.


