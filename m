Return-Path: <linux-kernel+bounces-895324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E94C4D862
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 929AA500B41
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04113587A3;
	Tue, 11 Nov 2025 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLg+cHnd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E128D357723;
	Tue, 11 Nov 2025 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861348; cv=none; b=B95R7TZxc+MwGXIWYz1xGNwz9+q0ZSF4ANszxL9znKjvhRmaB2s9Js6uqF4E2uERrN1xghu8JGOddOlnXg4HSS0QoP1/D+9gblk9LTdqKzdxx5qEwR1/LatWJ9+ZNG/DXZxYl0Jxy1yEjBkEVzw/d2mc+9ALHq++TbHIlDorsnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861348; c=relaxed/simple;
	bh=+zJSPi0AwET6eHVAxBh7bvY1AhjigGgMo7weSFHv314=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QFumE+CuVmyNHH10bHjoKUBd7jCwBu9kKBjT/CdLQTDb0mLbzbLe0YoJI3M2scyrhONjHwnVXkKjpm4a6QewlTgmQEAYwbjG+H33ppkNQ9aQZoy09VNCgP49dzUSaX4t+Ht0+z6WsWn7s5VL32h2Z8msSexHVO/BiTGoJldiLcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLg+cHnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7408BC4CEF5;
	Tue, 11 Nov 2025 11:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762861347;
	bh=+zJSPi0AwET6eHVAxBh7bvY1AhjigGgMo7weSFHv314=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uLg+cHndxTBODFaMxKM/2NOH/riOFMUgc4qRgBkRlehHZp7ybqezDZR5qStg+L4Y1
	 C2zHDbrLDF6cnNc1ULSamBQl9wtyEFTUAzvqexKQMaELKpbsScgkAklqdORsTeV3U3
	 J+2goTfjTym0KfArM3SkRY/OPtu8eF9Vg1avfm6kWvz0CGxgYHtIxkkkyS+Qb89CH7
	 WznoX1IXEZv0AZcfFtgHy0Rc/5ykyvgpLaRuXaDEZPFpIUKLQUPeYf2kc+6lijiJlu
	 I/qdBHuAhsub0uAm61MJLCtvSkUFcQjFuUFNVJN1SUfRuSjayzKyvXLofjOZDOMtGS
	 sBNrP2Dtie5Vg==
Message-ID: <3f8e50db-9954-4dfa-913d-d3bd599c15fd@kernel.org>
Date: Tue, 11 Nov 2025 05:42:25 -0600
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
 <26032cb1-53c6-46a1-b3eb-e1876142bf1c@kernel.org>
 <CAKY2Ryb60yKh1ooFoF4VSTwSdR2srBVMTvFAy7PwVmxE__+SDg@mail.gmail.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <CAKY2Ryb60yKh1ooFoF4VSTwSdR2srBVMTvFAy7PwVmxE__+SDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/11/25 00:38, Rahul Kumar wrote:
> On Tue, Nov 4, 2025 at 10:15 AM Dinh Nguyen <dinguyen@kernel.org> wrote:
>>
>>
>>
>> On 11/2/25 23:55, Rahul Kumar wrote:
>>> On Wed, Oct 15, 2025 at 3:11 PM Rahul Kumar <rk0006818@gmail.com> wrote:
>>>>
>>>> Replace scnprintf() with sysfs_emit() in sysfs *_show() functions
>>>> in stratix10-rsu.c to follow the kernel's guidelines from
>>>> Documentation/filesystems/sysfs.rst.
>>>>
>>>> This improves consistency, safety, and makes the code easier to
>>>> maintain and update in the future.
>>>>
>>>> Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
>>>> ---
>>>>    drivers/firmware/stratix10-rsu.c | 7 +++----
>>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
>>>> index 1ea39a0a76c7..53c896ceca9a 100644
>>>> --- a/drivers/firmware/stratix10-rsu.c
>>>> +++ b/drivers/firmware/stratix10-rsu.c
>>>> @@ -454,8 +454,7 @@ static ssize_t max_retry_show(struct device *dev,
>>>>           if (!priv)
>>>>                   return -ENODEV;
>>>>
>>>> -       return scnprintf(buf, sizeof(priv->max_retry),
>>>> -                        "0x%08x\n", priv->max_retry);
>>>> +       return sysfs_emit(buf, "0x%08x\n", priv->max_retry);
>>>>    }
>>>>
>>>>    static ssize_t dcmf0_show(struct device *dev,
>>>> @@ -632,7 +631,7 @@ static ssize_t spt0_address_show(struct device *dev,
>>>>           if (priv->spt0_address == INVALID_SPT_ADDRESS)
>>>>                   return -EIO;
>>>>
>>>> -       return scnprintf(buf, PAGE_SIZE, "0x%08lx\n", priv->spt0_address);
>>>> +       return sysfs_emit(buf, "0x%08lx\n", priv->spt0_address);
>>>>    }
>>>>
>>>>    static ssize_t spt1_address_show(struct device *dev,
>>>> @@ -646,7 +645,7 @@ static ssize_t spt1_address_show(struct device *dev,
>>>>           if (priv->spt1_address == INVALID_SPT_ADDRESS)
>>>>                   return -EIO;
>>>>
>>>> -       return scnprintf(buf, PAGE_SIZE, "0x%08lx\n", priv->spt1_address);
>>>> +       return sysfs_emit(buf, "0x%08lx\n", priv->spt1_address);
>>>>    }
>>>>
>>>>    static DEVICE_ATTR_RO(current_image);
>>>> --
>>>> 2.43.0
>>>>
>>>
>>> Hi Dinguyen,
>>>
>>> Just following up to see if you’ve had a chance to review this patch,
>>> or if there’s anything more needed from my side.
>>>
>>> Link to v1:
>>> https://lore.kernel.org/all/20251015094117.535157-1-rk0006818@gmail.com/
>>>
>>> Thanks,
>>> Rahul
>>
>> Sorry about that. I've applied it.
>>
>> Thanks,
>> Dinh
>>
> 
> Hi Dinh,
> 
> Could you please share the commit ID where this patch was applied?
> 

I've applied this to my branch on kernel.org and will send a PR sometime 
this week.

Dinh

