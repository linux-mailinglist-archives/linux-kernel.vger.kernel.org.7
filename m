Return-Path: <linux-kernel+bounces-835234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3878EBA68BB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578631899EB0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225EE296BBE;
	Sun, 28 Sep 2025 06:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2C2NKtAe"
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7EA1DC9B5
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 06:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759039886; cv=none; b=Y06dCCQ/b2Adgo4rS71keDXbbwkmtGh4DiCqROZRu5KmY1lJlkwwHEWigKu63SZGPAq71jAkhRcxHI0QIlcDtJ/ao+bnePn8tMqUfIWRn4V7N2UP6fNpiOJU6/Qnz2W3uM53yKCcXq+5U9WmcYj5HzpjfSOjz9uVOUNMlU8VCl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759039886; c=relaxed/simple;
	bh=5C/xmVLP7eepmMoja7aYCQ+lGdIxCnNESZHp8X52GI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LdpJ6JpHwoxSLc56IWuV3RXF/C1ulDvM8YSGL+fl48GYgvVugwpb8fx/ldGuQM2h+VKJ+ioVZGWUlu1bfUvOThDpzl1hmEwak1MkAGmqURuFAVz3vCBCcivgkJtztrYUgsObpIbG2dQ+SHEqa91xB/0owaoBv8ZPcW/I9zQCb48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2C2NKtAe; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KMTQBHC+x6efVAwKq5VoPVUM/GH7pbjWkjp5ywqzP0Q=;
	b=2C2NKtAeQpmR1NsxKXyN4D+MpxBnS1kvJltdNHjI7kF3ur5DEyxjGzbBuALPxAGmbIvxdoGuN
	mmVcd9qK4vncMSkgdhy9Ru1ud679Rwrloh6iOMam79vOfFk6YLCP6zyd4mb459nSD7huurSagSU
	8dTx8oOS4Dj0TqFDm4LAzkI=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4cZDTl56CWzmV71;
	Sun, 28 Sep 2025 14:11:07 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 739A918001B;
	Sun, 28 Sep 2025 14:11:17 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 28 Sep 2025 14:11:16 +0800
Message-ID: <8f4c0670-97a8-4d43-aab8-937231755bed@huawei.com>
Date: Sun, 28 Sep 2025 14:11:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add myself and Barry to dma_map_benchmark
 maintainers
To: Barry Song <21cnbao@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
CC: Marek Szyprowski <m.szyprowski@samsung.com>, <shuah@kernel.org>,
	<robin.murphy@arm.com>, <jonathan.cameron@huawei.com>,
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
 <CAGsJ_4yrm_3ZftZtYZ==YsEt14OR+t1FkVNzLzYjPxqXNdeURA@mail.gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4yrm_3ZftZtYZ==YsEt14OR+t1FkVNzLzYjPxqXNdeURA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2025/9/26 14:59:36, Barry Song <21cnbao@gmail.com> wrote:
> On Fri, Sep 26, 2025 at 6:09 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 9/25/25 07:11, Qinxin Xia wrote:
>>>
>>>
>>> On 2025/9/22 20:20:39, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>>> On 22.09.2025 01:50, Barry Song wrote:
>>>>> On Fri, Sep 19, 2025 at 2:17 AM Marek Szyprowski
>>>>> <m.szyprowski@samsung.com> wrote:
>>>>>> On 17.09.2025 03:17, Qinxin Xia wrote:
>>>>>>> Since Chenxiang has left HiSilicon, Barry and I will jointly
>>>>>>> maintain this module.
>>>>>>>
>>>>>>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>>>>>> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>>> Thanks!
>>>>> Marek, would you rather merge this into the dma-mapping tree
>>>>> instead of ACKing it, or would you prefer it to go through
>>>>> a different tree?
>>>>
>>>> I expected it to be taken by Shuah, as she is responsible for the
>>>> tools/testing/selftests/ directory, where the dma tests are still placed.
>>>>
>>>>
>>>> Best regards
>>>>
>>> I'll send V2 in the next version to fix some of the review comments of V1, and maybe there's some discussion about V2, I think shuah can deal with the patches of MAINTAINERS first :）
>>
>> I can take this patch through my tree. Are you sending v2?
> 
> Qinxin mentioned a v2 for the tools/dma modification[1], but there’s
> no need for a v2 of the maintainer patch. Could you please pull this
> one into your tree? Thanks!
> 
> Qinxin, could you please avoid mixing topics, as it can be
> quite confusing?
> 
> [1] https://lore.kernel.org/lkml/20250814133527.2679261-2-xiaqinxin@huawei.com/
> 
> Thanks
> Barry
Hello Barry,
I'm so sorry for the confusion.
The reason is that the movement in the tools/dma modification involves
modifications to the MAINTAINERS and decisions about which tree to pull
into. So, my original intention was to sync up with both you and Marek
on this: first update the MAINTAINERS file, and then proceed with
uploading the changes to tools/dma. Maybe I should mention this in the
last version of tools/dma modification.

Thank you so much for your understanding.

