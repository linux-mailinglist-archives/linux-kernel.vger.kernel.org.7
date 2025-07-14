Return-Path: <linux-kernel+bounces-729378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B83FB035C3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD1657AB5C8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 05:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380441FE444;
	Mon, 14 Jul 2025 05:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ijC3E3Sc"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA7C2E371B;
	Mon, 14 Jul 2025 05:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752471115; cv=none; b=MXLnP2QRrdITAezlln7PWdR+nqaaoJkzxQ0c6pXX6bsYRVJhAy9yUoSpimavOQ76Q454gtl79Bt+w0tV0SD2Qh4mRNjK/WRnYq9ctioYCD+FmMY9kp8Sgx3uSGgRBtbRz5qcc8GIbFKABnI4eHFFh3kOYfjaed78H6bMzLoxyrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752471115; c=relaxed/simple;
	bh=RKD94B+QWXQNYVOHOTUGGlC4g3407ZsCdyyOMxsAU6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATON8cViIGcJcN6yUVG/6XkWxReaz2KJxS9PLrkAAtMEojhKKFuO1hHLPBzEOuNR3GsWzJjadmVTPe3WHIFlQv6rmkTc1KUd/dKVW9xs5SW6vZChmfdczWz+4fOvaYWu0+79e74/YYDdyWZG9wrGvpH7iykA2QjSDNnJsbteEgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ijC3E3Sc; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=7sVqofoybSXxVgyLZdz7/MBMprR3UjCEaizhghRGTBE=;
	b=ijC3E3ScaQJZVVcSTkG/NWEDB/nLQQZRQMOmEr1JIQIdlGv8zM5milQrrTBDuO
	mDosgFINIUrbezyfw1s4luSO7QWfcDBjjGZHkKIdWx/KECvI38SzBQYUlbpnbmnn
	hX3jQI8exSeWrClNpCWZkJnEMfs6+pDXvPX4S/BXXyR9k=
Received: from [10.42.12.155] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBniD8mlnRoPjo_AA--.8357S2;
	Mon, 14 Jul 2025 13:31:19 +0800 (CST)
Message-ID: <847b7ea4-07c6-4e9c-b20e-c1c2be4dceb6@163.com>
Date: Mon, 14 Jul 2025 13:31:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usbip: convert to use faux_device
To: Shuah Khan <skhan@linuxfoundation.org>,
 Alan Stern <stern@rowland.harvard.edu>, Greg KH <gregkh@linuxfoundation.org>
Cc: shuah@kernel.org, valentina.manea.m@gmail.com, i@zenithal.me,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 zhouzongmin@kylinos.cn
References: <fac026d8-12c8-4c1f-96a7-264ced8391f1@linuxfoundation.org>
 <a29703bd-08b7-489b-8fb0-15838a1245ab@163.com>
 <1a13cf53-ffed-4521-917e-9c2856a5e348@linuxfoundation.org>
 <4fc877f0-b55b-4fa3-8df4-2de4ba1ac51b@163.com>
 <2a901b8a-9052-41d9-a70d-76508ebd819b@linuxfoundation.org>
 <4759911b-8c35-4ca9-bc34-09dd41b14582@163.com>
 <2025070949-activist-mammal-b806@gregkh>
 <dd3659dd-7e45-479d-ab65-9f5c1bab26a0@rowland.harvard.edu>
 <ce96291b-c0b2-41cf-a71c-c13bd8d0f139@linuxfoundation.org>
 <4478924b-fbd7-4a5a-ad0d-4fe0569b4971@linuxfoundation.org>
 <a735f877-e13b-498f-9eee-53ebefa8ebc9@rowland.harvard.edu>
 <9be8b1dc-9af2-4135-9a0f-db2eb7d10f06@linuxfoundation.org>
Content-Language: en-US
From: Zongmin Zhou <min_halo@163.com>
In-Reply-To: <9be8b1dc-9af2-4135-9a0f-db2eb7d10f06@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBniD8mlnRoPjo_AA--.8357S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF1fAr1rWF4kKr17tr43ZFb_yoW5Xw1rpF
	WYqFWjga1kGanFva1vvrn5Xw1Fy3yFk3y5Xr98Jr15uwsIvr1rKF1Dtr4Y9F1qyr1furnF
	vr1jqay3u34UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U1pBhUUUUU=
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/1tbixxeJq2hz8WPuYQABs1


On 2025/7/11 04:33, Shuah Khan wrote:
> On 7/10/25 08:06, Alan Stern wrote:
>> On Wed, Jul 09, 2025 at 03:57:35PM -0600, Shuah Khan wrote:
>>> On 7/9/25 15:49, Shuah Khan wrote:
>>>> Right. We have a few too many moving pieces here:
>>>>
>>>> usbipd (user-space)
>>>> vhci_hcd and the usb devices it creates
>>>>
>>>> usbip_host, stub driver that proxies between the device
>>>> on the server and vhci_client.
>>>>
>>>> PM can be complex and it has to do lot more than it currently
>>>> does on both server and client end to support seamlessly.
>>>>
>>>> The current suspend took the approach of refusing suspend
>>>> which doesn't work since usb devices underneath hang in
>>>> usb_dev_resume(). Looks like this usb device is treated like
>>>> a real device bu usb core. Is there a way to have usb core
>>>> PM (suspend and resume) handle them as virtual? Would it
>>>> help to use "supports_autosuspend" to disable suspend and
>>>> resume?
>>>
>>> Would it work if usb_disable_autosuspend() on the devices
>>> that hang off its vitual bus?
>>
>> You have to consider PM on both the host and client.  And you have to
>> consider both runtime PM and system PM (that is, suspend to RAM,
>> hibernate, etc.).
>
> This would be as a fix for the existing suspend hang issue.
>
>>
>> On the server, any sort of suspend will interrupt the connection.
>> usb_disable_autosuspend() will prevent runtime suspends, but you
>> shouldn't try to prevent system suspends.  Instead, the usbip driver on
>> the server should have its suspend routine close the connection to the
>> client (rather as if the server's user had unplugged the device).
>>
>> On the client, you've got a choice for how to handle runtime PM.  You
>> can leave it enabled, and when the client decides to suspend the device,
>> tell the server's driver.  The server driver can then attempt to do a
>> runtime suspend on the physical device.  (You might need to add a new
>> type of message to the USBIP protocol to accomplish this; I don't know
>> the details.)  Alternatively, you can forbid runtime suspend on the
>> client entirely, although it would be nice if you could avoid this.
>>
>> System PM on the client can be handled more less the same as runtime PM.
>
> Correct. This has to be a complete solution that syncs up server and 
> client
> side. I am going to look into implementing this - it might be possible to
> do this in user-space. Either way this will require changes to the 
> protocol
> very likely.
>
> Greg, Zongmin Zhou, let's hold off on this conversion yo faux bus for 
> now.
> I will spend time looking at if we can find PM solution that works end 
> to end
> for server and client.
Sorry for the late reply.
Ok,I got it. it is necessary to tackle the
PM standby issue first before considering next steps.
>
> thanks,
> -- Shuah


