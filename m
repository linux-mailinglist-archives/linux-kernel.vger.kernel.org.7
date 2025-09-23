Return-Path: <linux-kernel+bounces-828156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38049B94123
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A68918A7683
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB9324468B;
	Tue, 23 Sep 2025 03:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MSgoTh8i"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC6B1DDA09
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758596976; cv=none; b=i0dx2DQ0AhShr5cF10/Rz4IBdEhdGi+eofp21F85E42eLu6a4EbnmVIcqQb3gmgI64w3OOa7b+YbZyBrZHK7WTtdwvSj1SnBkCsVag4dPVk0aI/sXQ21uyn+EhoLxPmgbdeEeFa6PhdpFHg1Ls5ynei5gj7+4rt5bcfEu0JN3E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758596976; c=relaxed/simple;
	bh=Z2DCQEJ4DdoWC2wHXSi4cNQE/HH1OnONKo3i8XF4zII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FDwBY+NhJn1Y8r4Ow/16/1b/bZhJkDuevinNzCs+UKAeiuu+yMwuv6+/KFtwklZx5v7d6zGsnTRL+H62wP5FonWAjGFF5bo4bvRqxyHmoQ6ubqjdS4XVV4DVnWA5avNoE7DdgFqP9PeoyMfOeOcdNEG9wWwG9QeassUUJ0IbPP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MSgoTh8i; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758596971; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MSn+Vhnjxo+BI+izC8hXxxMDoNBqF0GPCzYe9ExyK10=;
	b=MSgoTh8ivzIQjKDyNMNEJ+zRSoQ1W2+jLauxYwffztFgRq2S5cjrihDlrAMMnm62mLsMHjH9CXEEWD6/LmywXb6OjQwwopy63oK6bkOdDs91YrbrS+ZLCw8MKActIj/vx2Xcl7giHUIu5JAG++5CNAMc5LcDNUzvGXagTBB9HAs=
Received: from 30.221.131.45(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WodN09V_1758596970 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Sep 2025 11:09:30 +0800
Message-ID: <3e67c596-6002-4497-b8a5-70fba7c69e9d@linux.alibaba.com>
Date: Tue, 23 Sep 2025 11:09:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] erofs: Add support for FS_IOC_GETFSLABEL
To: Chao Yu <chao@kernel.org>, Bo Liu <liubo03@inspur.com>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250922092937.2055-1-liubo03@inspur.com>
 <906f54dd-5c7d-47b3-b591-50197786cf33@kernel.org>
 <85be6910-3aa2-4e88-ac16-989fde00c38e@linux.alibaba.com>
 <221cc0ee-60a7-4672-987b-cd80a5b13590@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <221cc0ee-60a7-4672-987b-cd80a5b13590@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/23 10:59, Chao Yu wrote:
> On 9/23/25 10:34, Gao Xiang wrote:
>> Hi Chao,
>>
>> On 2025/9/23 10:23, Chao Yu wrote:
>>> On 9/22/25 17:29, Bo Liu wrote:
>>>> From: Bo Liu (OpenAnolis) <liubo03@inspur.com>
>>>>
>>>> Add support for reading to the erofs volume label from the
>>>> FS_IOC_GETFSLABEL ioctls.
>>>>
>>>> Signed-off-by: Bo Liu (OpenAnolis) <liubo03@inspur.com>
>>>> ---
>>
>> ...
>>
>>>>    +long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
>>>
>>> #ifdef CONFIG_COMPAT
>>>
>>>> +long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
>>>> +            unsigned long arg);
>>
>> Since it's a function declaration, when CONFIG_COMPAT is not defined,
>> there is no user to use erofs_compat_ioctl(), so I think it is fine
>> to just leave the declaration here?
> 
> Xiang,
> 
> Sure, it won't affect compile and link, we can leave it as it is since it's trivial.

Yeah, my preference is to avoid unnecessary #ifdef if possible,
anyway (since unused function declarations won't affect anything..)

Thanks,
Gao Xiang

> 
> Thanks,
> 
>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>> #endif
>>>
>>> Thanks,
>>>
>>>> +
>>>
>>
>>


