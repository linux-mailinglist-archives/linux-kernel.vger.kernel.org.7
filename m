Return-Path: <linux-kernel+bounces-864463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F169BFAD84
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F20C05055BE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E862797B5;
	Wed, 22 Oct 2025 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Z16pKLDT"
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBF2350A3F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120993; cv=none; b=prbbHDibeDgtOlegCTHVmd79hv1W34guWy+nWfslVVKFzsBVmNCBJ0AuS19IXSwxHoEvo4URY8hydoWcMomJWLqZ3ZeqKf4FyEa0SLKsNJYxsMGN2OIk9m/m8y91Wf9l/EXMmP44U10hUZ2fbcpo4LHlsDZaG9b4LvQAcVyTJgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120993; c=relaxed/simple;
	bh=BYF1GMDxxAJRHd7d3IaXHOw7D0r0HswaWfqX7v8CUWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jGCwK+7ZgrhvsYgTPJelbhCxHyNEoKdeQFvy/D87rvDU6dCbl14dAUY3VhMcj1qc+xiCQ4Uf1usundJHcWykogGA0BHuWIy8F47bYqSj9TCNFslYdGvm5yTRfB8KemEEgf2Q4o5fMNH9SzOmxuoReNpLsZt5Lyqg7ztarbCmk+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Z16pKLDT; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oIbwoVBWmsqkVdYkTXJeUGJb7ld4Fb9Pov175Je2hUA=;
	b=Z16pKLDTJIJ8OAROdAZYo4/KH3mhN3IKj6thgPTyjk0EZSWodg85RzvltQpgFenMFLOtiFS3E
	IyYtZrjdA+gKME8ulfaB47EGw/ZiH8lJtOikUZiundBipc6gnYVWBTXIxImeFR3Xw7pNjZhXNxU
	GgCcabzS4+9mFeeimZR2Ano=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cs26W6bG0z12LJs;
	Wed, 22 Oct 2025 16:15:47 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 214931401F4;
	Wed, 22 Oct 2025 16:16:29 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Oct 2025 16:16:28 +0800
Message-ID: <04ac708f-922e-4aca-80ea-e1217da89ce2@huawei.com>
Date: Wed, 22 Oct 2025 16:16:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tools/dma: move dma_map_benchmark from selftests to
 tools/dma
To: Barry Song <21cnbao@gmail.com>
CC: <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<wangzhou1@hisilicon.com>
References: <20251022035528.1981892-1-xiaqinxin@huawei.com>
 <CAGsJ_4wMtWZUTWRePK9_90LrbANUo7RcVkBRbQJ4aBEypWwtLQ@mail.gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4wMtWZUTWRePK9_90LrbANUo7RcVkBRbQJ4aBEypWwtLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2025/10/22 12:23:04, Barry Song <21cnbao@gmail.com> wrote:
>>
>>   #define DMA_MAP_BENCHMARK       _IOWR('d', 1, struct map_benchmark)
>>   #define DMA_MAP_MAX_THREADS     1024
>> @@ -27,5 +29,7 @@ struct map_benchmark {
>>          __u32 dma_dir; /* DMA data direction */
>>          __u32 dma_trans_ns; /* time for DMA transmission in ns */
>>          __u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
>> +       __u8 expansion[76]; /* For future use */
>>   };
> 
> I didn’t realize you were hiding a bugfix within the code cleanup.
> 
> We agreed this is a hotfix that should be merged promptly[1]. Before sending
> v5, please submit the hotfix first using the existing folder (without moving
> the code from selftest to tools). Once it is merged, resend v5 based on it.
> 
> [1] https://lore.kernel.org/lkml/f8c0cbdc-9c68-46bb-8dad-1d7c80f3f741@samsung.com/
> 
> Thanks
> Barry

Hello Barry:
For the previous patch has not merged, I have carefully considered this.
(I didn't include this in v1. You can see it in the 'Changes')

Previously, struct map_benchmark is defined in map_benchmark.h. The
header file in include/linux/ generally does not guarantee stable uABI.
(Although it does get used in userspace, I thought that's because we
include the kernel header in userspace.Referencing kernel headers in
userspace programs is inherently risky)

This patch moves map_benchmark.h from include/linux to include/uapi
/linux. I think maybe it's reasonable to restore that here...

I'm sure you have more experience in this area, and if you still insist
on separation, I will prepare v5 based on merged version.

Thanks,
Qinxin

