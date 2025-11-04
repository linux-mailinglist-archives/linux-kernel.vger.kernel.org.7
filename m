Return-Path: <linux-kernel+bounces-884078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CB3C2F4FF
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 05:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B42C189C735
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 04:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B87201033;
	Tue,  4 Nov 2025 04:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npRaykkX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04E127F75F;
	Tue,  4 Nov 2025 04:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762231507; cv=none; b=X3wBjA4Jrci0LOsyIs5+uoaPu2n08T/JzkmXpVSWk/CnYwipWuwh3H6LgNe24e1ys3iA71NnsikFTRfJbAeAhsBDDWChQB460chhKHJVa9fZJbbbVQ9oTv6Gl8P1yuVRN0sVuNR1YDOqwr9Sah0xWSnP1RFHEYl3MYAZKZsndfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762231507; c=relaxed/simple;
	bh=DtgY2L2MA8mI2K5aJ4+/wkPMW/2KWL/QLDnuO8QRDio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pk0Ae9S4rlaRl5+LvRFkEhFjQSeM5fWxy+F8Hlj1J/c0Rmz39ij6Gd1PUTMhl+AuyRkLR8C5u+n+F9n85ZbG0ZySS90gZK0NtL9qC1sS0LvG2Yp5nNPRVSoiXHmwXvSGyTtPOCyGOX72KQA6nNePPzuKp121P0ALHl0/lrAQXH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npRaykkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E54C4CEF8;
	Tue,  4 Nov 2025 04:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762231506;
	bh=DtgY2L2MA8mI2K5aJ4+/wkPMW/2KWL/QLDnuO8QRDio=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=npRaykkX9YdZW14RHGTHOW8GtI3polROpJ/3iT+/+Bcu5Dshoyc6KtZYvZWoEOynu
	 sdg0uT0jOn9S+Dh8Hio26CwK9fRpRzKqSp4rXNseQZ/5qppqYgaqQUU4jaTL505UMK
	 PIf5CzfvGKXgCLqTzwYmOOpuSu3exESQkajsWG7v9ggmL+1LmB2XKiTSjGASYNaK/s
	 /sYsL6UryKn8eNGi8iBCRYdyNtCb4PLeq5mbhGVVtpXlZav8QUfxT539sjVsqf3hug
	 P76uX6g8BURxxmsqgTTir+QfBAYxrBly9MHwQ9gtPb0JR7m4UO0JoNLBzjiDCyf7pw
	 8wvLJ0Txt/8rg==
Message-ID: <26032cb1-53c6-46a1-b3eb-e1876142bf1c@kernel.org>
Date: Mon, 3 Nov 2025 22:45:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: stratix10-rsu: replace scnprintf() with
 sysfs_emit() in *_show() functions
To: Rahul Kumar <rk0006818@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 skhan@linuxfoundation.org
References: <20251015094117.535157-1-rk0006818@gmail.com>
 <CAKY2RybBidcyMtUY8mwyT=F2e5f=HT9HR6JXmgz+UyU6_S3kUQ@mail.gmail.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <CAKY2RybBidcyMtUY8mwyT=F2e5f=HT9HR6JXmgz+UyU6_S3kUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/2/25 23:55, Rahul Kumar wrote:
> On Wed, Oct 15, 2025 at 3:11 PM Rahul Kumar <rk0006818@gmail.com> wrote:
>>
>> Replace scnprintf() with sysfs_emit() in sysfs *_show() functions
>> in stratix10-rsu.c to follow the kernel's guidelines from
>> Documentation/filesystems/sysfs.rst.
>>
>> This improves consistency, safety, and makes the code easier to
>> maintain and update in the future.
>>
>> Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
>> ---
>>   drivers/firmware/stratix10-rsu.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
>> index 1ea39a0a76c7..53c896ceca9a 100644
>> --- a/drivers/firmware/stratix10-rsu.c
>> +++ b/drivers/firmware/stratix10-rsu.c
>> @@ -454,8 +454,7 @@ static ssize_t max_retry_show(struct device *dev,
>>          if (!priv)
>>                  return -ENODEV;
>>
>> -       return scnprintf(buf, sizeof(priv->max_retry),
>> -                        "0x%08x\n", priv->max_retry);
>> +       return sysfs_emit(buf, "0x%08x\n", priv->max_retry);
>>   }
>>
>>   static ssize_t dcmf0_show(struct device *dev,
>> @@ -632,7 +631,7 @@ static ssize_t spt0_address_show(struct device *dev,
>>          if (priv->spt0_address == INVALID_SPT_ADDRESS)
>>                  return -EIO;
>>
>> -       return scnprintf(buf, PAGE_SIZE, "0x%08lx\n", priv->spt0_address);
>> +       return sysfs_emit(buf, "0x%08lx\n", priv->spt0_address);
>>   }
>>
>>   static ssize_t spt1_address_show(struct device *dev,
>> @@ -646,7 +645,7 @@ static ssize_t spt1_address_show(struct device *dev,
>>          if (priv->spt1_address == INVALID_SPT_ADDRESS)
>>                  return -EIO;
>>
>> -       return scnprintf(buf, PAGE_SIZE, "0x%08lx\n", priv->spt1_address);
>> +       return sysfs_emit(buf, "0x%08lx\n", priv->spt1_address);
>>   }
>>
>>   static DEVICE_ATTR_RO(current_image);
>> --
>> 2.43.0
>>
> 
> Hi Dinguyen,
> 
> Just following up to see if you’ve had a chance to review this patch,
> or if there’s anything more needed from my side.
> 
> Link to v1:
> https://lore.kernel.org/all/20251015094117.535157-1-rk0006818@gmail.com/
> 
> Thanks,
> Rahul

Sorry about that. I've applied it.

Thanks,
Dinh


