Return-Path: <linux-kernel+bounces-740222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8996CB0D18D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566C21C21CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0E028C87F;
	Tue, 22 Jul 2025 05:58:39 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A211228C2BE;
	Tue, 22 Jul 2025 05:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753163919; cv=none; b=PVeRvWw2kALF9MsVa7E0RXfAY24qxgZyMgeSwEO/TuF/Dv92LGkCcY8IQZj+oe4BD53QRl0Hho+AZCr8iguYdoJDJWIVHNB1WKvqLWk+pVg77G9jqPBiQyNdjZa6LMSoZ8tqIqNdxr6ckOi1/7XDYQVulWeWg4GY2SFJexaaQQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753163919; c=relaxed/simple;
	bh=mAxHHo8NZs56gxX6+/EV/wwesWiikwUj9nOqTjGCjI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ntQ7mb8OYttxF+Dcl6vRHoWmz+0ozuS7ejcUS+qJfQYgcwnazyIxyl/8DxmFAKrHm/9V6pwP8AfnwoKim3nkEKx8KsrI34SDMCstAQBo2/MDu2uwM6kRI7JScinmsxVbK9uGa6uKRA7EHEmZNyJLlDyWhjpydFzW/8wQUqEf1v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bmRMC733wz13MhC;
	Tue, 22 Jul 2025 13:55:35 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 79895180B64;
	Tue, 22 Jul 2025 13:58:31 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 22 Jul
 2025 13:58:30 +0800
Message-ID: <9520a958-aeda-43a0-b72f-6ab0e05b20c9@huawei.com>
Date: Tue, 22 Jul 2025 13:58:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/17] ext4: convert free groups order lists to xarrays
Content-Language: en-GB
To: Theodore Ts'o <tytso@mit.edu>
CC: Jan Kara <jack@suse.cz>, <linux-ext4@vger.kernel.org>,
	<adilger.kernel@dilger.ca>, <linux-kernel@vger.kernel.org>,
	<ojaswin@linux.ibm.com>, <julia.lawall@inria.fr>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <libaokun@huaweicloud.com>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-16-libaokun1@huawei.com>
 <iulwol5ygqv7fry543vuoawhn7fjzlz7hmai5stjxqkkvvz6pc@wukeepjempwn>
 <47e62021-fd2c-44ba-be34-e12b2a486efb@huawei.com>
 <4b5a7a7a-a4db-4d4d-8931-c57ffd231006@huawei.com>
 <20250721180134.GB1415603@mit.edu>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250721180134.GB1415603@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 7/22/2025 2:01 AM, Theodore Ts'o wrote:
> Thanks, Baokun!  I've updated the ext4 dev branch with the spelling
> fixes integrated into "ext4: convert free groups order lists to
> xarrays".
>
> 						- Ted
>
Thanks for updating the code!


Regards,
Baokun


