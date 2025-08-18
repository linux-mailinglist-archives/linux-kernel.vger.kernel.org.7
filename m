Return-Path: <linux-kernel+bounces-773066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18014B29B01
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F973BADCC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6063A27F00E;
	Mon, 18 Aug 2025 07:43:21 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A0F27E7F0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503001; cv=none; b=fovL5SxUh7xvOwNygfdOGnw8/WJ3IT5KKOM05gIncXDgOW2EHKpYL33/cDN7XqxAPxbXweQC9l3MrJVcb3nVIAzRF18VhRm4tV5RZjk0loL8N5KhJ6Je9hoBO3D0X1MtWY5Tzi4K9EL/1XFqzZMrtG6k15P/gjbl7VhwU/vj1rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503001; c=relaxed/simple;
	bh=ehffUR3rdXwqk2Ie2NRlqLdtnj8bYDESXiZcgej+o+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kxCaG4gLkxBKgAruvx2bwbKWGgKP2SD4yKrHSA2vExwSNSJqNeSt3xuwVVUNnxX45+nZD1AaJwVgTEKHAzDl88eu0paYso4Z+z0BAxvB1FWLkZIGgIN3LQm9iPgGoeQcqSq/5B4n+Typ3IxBXN3cniEQNzijCRO5pm+J15wapuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c54Rp6bQvzpbcm;
	Mon, 18 Aug 2025 15:42:14 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CB64140158;
	Mon, 18 Aug 2025 15:43:14 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Aug 2025 15:43:13 +0800
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Aug 2025 15:43:13 +0800
Message-ID: <4eaddd73-f724-423f-8bbd-7f48e6d06856@huawei.com>
Date: Mon, 18 Aug 2025 15:43:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 drm-dp 06/11] drm/hisilicon/hibmc: add dp mode valid
 check
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <liangjian010@huawei.com>,
	<chenjianmin@huawei.com>, <fengsheng5@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<shiyongbang@huawei.com>
References: <20250813094238.3722345-1-shiyongbang@huawei.com>
 <20250813094238.3722345-7-shiyongbang@huawei.com>
 <x25nogehjvydrccphxic2qyigu4kvrysti4uai3h7ea3vk2dxu@yxpgqhfmcyen>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <x25nogehjvydrccphxic2qyigu4kvrysti4uai3h7ea3vk2dxu@yxpgqhfmcyen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq100007.china.huawei.com (7.202.195.175)


> On Wed, Aug 13, 2025 at 05:42:33PM +0800, Yongbang Shi wrote:
>> From: Baihan Li <libaihan@huawei.com>
>>
>> If DP is connected, check the DP BW in mode_valid_ctx() to ensure
>> that DP's link rate supports high-resolution data transmission.
>>
>> Fixes: f9698f802e50 ("drm/hisilicon/hibmc: Restructuring the header dp_reg.h")
> Why?

Sorry, it should be 0ab6ea261c1f ("drm/hisilicon/hibmc: add dp module in hibmc").

Thanks，
Baihan Li


>> Signed-off-by: Baihan Li <libaihan@huawei.com>
>> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
>> ---
>> ChangeLog:
>> v3 -> v4:
>>    - Remove the clock check, suggested by Dmitry Baryshkov.
>>    - ( I'll add them in next series after redesigning this part)

