Return-Path: <linux-kernel+bounces-832486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CF7B9F723
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5ED188D702
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43C421CC49;
	Thu, 25 Sep 2025 13:11:46 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BB92101AE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805906; cv=none; b=XoYot4n9Vc2wD3rESNzRLH5MPzAVgPj6Yt/koGkVcacfG4E0HcMxDhl0dG0UcS6v8HTOlqh7wxedU9B/0DJwhgCpbVLSzNuIX/nFXg0xqlBYhZ1ZEtuLgyh34b7JCiRtv/wUZItHFuxMX4xXoq1AFgaoUBKd314HgFy9Smsj28c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805906; c=relaxed/simple;
	bh=ItmF8SphJxPlpGzcfXwVjhblANOdhVIYRxO1r7lH6Uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MNBzv6zhxIV1nY27ZhODCs3Ltq7yYAtngkkdhJIzXDIA7FVs2ChyB8+K7uTS+PpMRlh36ufAl3K5qa9OlxLH4mRT+54l1xJkIQj4vgHQDLHZim8/DmGG9zSN9GGcW65LXUNNxAgRvYGQZGeYc4NcIEzjhODuSfhFdd13W3bUf2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cXYxN5gFRztTch;
	Thu, 25 Sep 2025 21:10:48 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 4937A1800B1;
	Thu, 25 Sep 2025 21:11:41 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Sep 2025 21:11:40 +0800
Message-ID: <ae8a2c37-74db-4e53-99c1-fc7f86e80253@huawei.com>
Date: Thu, 25 Sep 2025 21:11:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add myself and Barry to dma_map_benchmark
 maintainers
To: Marek Szyprowski <m.szyprowski@samsung.com>, Barry Song
	<21cnbao@gmail.com>, <shuah@kernel.org>
CC: <robin.murphy@arm.com>, <jonathan.cameron@huawei.com>,
	<prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<yangyicong@huawei.com>
References: <CGME20250917011807eucas1p2dc0c24ef4ad8effcc1a2174d54cf4161@eucas1p2.samsung.com>
 <20250917011759.2228019-1-xiaqinxin@huawei.com>
 <11183850-d6d6-46c9-8079-330bf4c541e3@samsung.com>
 <CAGsJ_4yno_a2vD9OHhruXbNOXuVKg97NcOdFHpe283FJ9hXL7Q@mail.gmail.com>
 <0c59d099-4844-4fb2-80e0-6d3fc0077985@samsung.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <0c59d099-4844-4fb2-80e0-6d3fc0077985@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2025/9/22 20:20:39, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> On 22.09.2025 01:50, Barry Song wrote:
>> On Fri, Sep 19, 2025 at 2:17 AM Marek Szyprowski
>> <m.szyprowski@samsung.com> wrote:
>>> On 17.09.2025 03:17, Qinxin Xia wrote:
>>>> Since Chenxiang has left HiSilicon, Barry and I will jointly
>>>> maintain this module.
>>>>
>>>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>>> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Thanks!
>> Marek, would you rather merge this into the dma-mapping tree
>> instead of ACKing it, or would you prefer it to go through
>> a different tree?
> 
> I expected it to be taken by Shuah, as she is responsible for the
> tools/testing/selftests/ directory, where the dma tests are still placed.
> 
> 
> Best regards
> 
I'll send V2 in the next version to fix some of the review comments of 
V1, and maybe there's some discussion about V2, I think shuah can deal 
with the patches of MAINTAINERS first :）

