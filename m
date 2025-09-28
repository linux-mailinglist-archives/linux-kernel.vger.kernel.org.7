Return-Path: <linux-kernel+bounces-835236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD7FBA68C7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE89189A567
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6622459ED;
	Sun, 28 Sep 2025 06:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6u9QutQK"
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D00572608
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 06:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759040140; cv=none; b=AB0Rmxs/F/QDULW2IgR5R+0AFGMCnjOfwgfJUoJZZqkWvlbbzZjqkRgYxRAwZDKYddxyJxREtNKzxx+lMeFkv3+UNLMitf7g8j/AxZIUg3UGfbXeMOqx2l/BhKXyrhX5+0q/8u2O6EF+HIsTgJWchmo3Vfz8X5IP1Nkq/8nfGDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759040140; c=relaxed/simple;
	bh=3jYCx1MiCETyCsR5jxMesJHBiMhydFMBMyL2OG8Pp/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pxl5nb2tf3zbR1AQ7o5WHOjxREqkX4Ewbt4Eap3vZLU/S7OuxSWg0BVZjwA78EVHSU6V2s2u3KjIWIy96QilMoA7t4vT1AA1Gpx5oyOj1qRf+IQmwVkggzK7URkrpOMRxSxEzSggmPFXvhBsQd4MyJ1yLwbnxNxKmPrMMkZ7kS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6u9QutQK; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from canpmsgout05.his.huawei.com (unknown [172.19.92.145])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cZDTW3KSnzJsYg
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 14:10:55 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kSmmbL14ndwOVr1GdeCLz4P2lr6bK//bwekT0PADraU=;
	b=6u9QutQKPcbCFaG78Qca649K+mNhw3BLpxZNkORk3j0mb0QxNb/nAlk5TPyAV5hk5cjeasMb/
	fGb/kJAiPW/MuSxS8Tj21kC1wtyV2XCtHUfS/RwYtEYPYaNtFjYhqC2RYhOZwcHk1AWCKZRtqGp
	LK7JIBDQSW272BZ8x8QMMCk=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cZDZv6RrDz12LDk;
	Sun, 28 Sep 2025 14:15:35 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 41A9218007F;
	Sun, 28 Sep 2025 14:15:28 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 28 Sep 2025 14:15:27 +0800
Message-ID: <22825b66-1648-4301-855c-cdbdd56bae5e@huawei.com>
Date: Sun, 28 Sep 2025 14:15:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add myself and Barry to dma_map_benchmark
 maintainers
To: Shuah Khan <skhan@linuxfoundation.org>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Barry Song <21cnbao@gmail.com>,
	<shuah@kernel.org>
CC: <robin.murphy@arm.com>, <jonathan.cameron@huawei.com>,
	<prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<yangyicong@huawei.com>
References: <CGME20250917011807eucas1p2dc0c24ef4ad8effcc1a2174d54cf4161@eucas1p2.samsung.com>
 <20250917011759.2228019-1-xiaqinxin@huawei.com>
 <11183850-d6d6-46c9-8079-330bf4c541e3@samsung.com>
 <CAGsJ_4yno_a2vD9OHhruXbNOXuVKg97NcOdFHpe283FJ9hXL7Q@mail.gmail.com>
 <0c59d099-4844-4fb2-80e0-6d3fc0077985@samsung.com>
 <ae8a2c37-74db-4e53-99c1-fc7f86e80253@huawei.com>
 <5900de48-e4a4-45cc-be7d-c906a59ba04a@linuxfoundation.org>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <5900de48-e4a4-45cc-be7d-c906a59ba04a@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2025/9/26 06:09:57, Shuah Khan <skhan@linuxfoundation.org> wrote:
> On 9/25/25 07:11, Qinxin Xia wrote:
>>
>>
>> On 2025/9/22 20:20:39, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>> On 22.09.2025 01:50, Barry Song wrote:
>>>> On Fri, Sep 19, 2025 at 2:17 AM Marek Szyprowski
>>>> <m.szyprowski@samsung.com> wrote:
>>>>> On 17.09.2025 03:17, Qinxin Xia wrote:
>>>>>> Since Chenxiang has left HiSilicon, Barry and I will jointly
>>>>>> maintain this module.
>>>>>>
>>>>>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>>>>> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> Thanks!
>>>> Marek, would you rather merge this into the dma-mapping tree
>>>> instead of ACKing it, or would you prefer it to go through
>>>> a different tree?
>>>
>>> I expected it to be taken by Shuah, as she is responsible for the
>>> tools/testing/selftests/ directory, where the dma tests are still 
>>> placed.
>>>
>>>
>>> Best regards
>>>
>> I'll send V2 in the next version to fix some of the review comments of 
>> V1, and maybe there's some discussion about V2, I think shuah can deal 
>> with the patches of MAINTAINERS first :）
> 
> I can take this patch through my tree. Are you sending v2?
> 
> thanks,
> -- Shuah
Hello Shuah,
Just pull this patch into your tree, as Barry said.
So sorry for the confusion.

