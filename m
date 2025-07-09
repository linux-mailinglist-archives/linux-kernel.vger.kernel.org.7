Return-Path: <linux-kernel+bounces-723320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0ADAFE5C7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA801C233E1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5C2258CEF;
	Wed,  9 Jul 2025 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="zc+FHnde"
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE14E2580F2;
	Wed,  9 Jul 2025 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057216; cv=none; b=NGBZng0jOp/1bOTN+lHhWECAJMM7Q8IYpMs8mQtU5JP8Bm1+JheVQ9F2nk+JYHjmFKmqVbfL82djPxBFMe/vhDbIvpqIhoQZ/NcA+t+ZoPCz4KJPMbayJWFNVa5yRu1tobiIGljhfaL1hE2MIaI0PtgHjOfkuLCvFCwjxuhiSwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057216; c=relaxed/simple;
	bh=3IsF1ew7kqgNm8XLHiLMvMYnA2sRgtdsC+g8eGCdlxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+/KN0LtzeeLr9GG2XorEXrtMaEvhzQe6X5gaJKnLNMUH0Ctx65gxtjEkQUHkci61R2Du3NxxFc60NN/ok8d12J2L4Pp8G3kIbwukoN3W923oCp10UYhwbrbfXmGh12f+LUYKUechPD9lK17H/i/k1XAr00mHWM9SH2cvj1It54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=zc+FHnde; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1752056903; bh=cDzmZYAyC65zNQjN8HAkBF8tiGbPpVDTVh8/DtsyA/U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=zc+FHndel9DecQ8doMwid4wYzvhGF/92mMmo912tT67s6TNSch5Xe2Nwu1y+gswfP
	 aSLlv3BGfIUZjLZPJtV6y7wCvuVfUBTFfTycYTpdX+k/+WHHnQRme58TjgqkYczM5u
	 qchlaS8l+9N2kp3UAHi7wujHdH6qKZLDN10WqJZE=
Received: from [30.20.172.11] ([119.147.10.163])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 58D2DC6B; Wed, 09 Jul 2025 18:22:13 +0800
X-QQ-mid: xmsmtpt1752056533tdq6vsbgx
Message-ID: <tencent_7181918110AAD331E6775691326AD1000408@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NoOhVH6De7JzWdBoDZ7i87tiBEi+WPetjo/JaGfY5RMN1wVnl13B
	 ZrLONvetIaF0R/aRfHnSbmiU11UrsfcPYmu8OvFLQrWCz1pOMIiUBv3hNnCFsCajtTrcSqYVea5x
	 qlKQxElSqU3r+q7tWI4Au5HhRw+CDPGTUK8DPM12OT9abFCLDdpkaDJRRvsK91Dxqeu4Oh4rSMlb
	 w2XMqUMW2kKIbXI0DxeYC7yo/KXXDmxkypD1V3KDKf/0QHmL4A61Lj3M5IRvp8yQ0yVpTWGpyWva
	 7RzcABXtZDp0mg3qnDk5xDg/atj2ZZhQKFROk7YG7BiCyMbUmeBid/BntvnswMsxJOAC0lTOkpGV
	 9yQQl4Bsjny5ThYGZOKsw4qx3886+vOV6i0gmFw9IQ/1evcoiDpQt+ia4QABjO5U6wAOsPTTd6/n
	 veeQLZLw75IFG1H5qeDefZrLv4FUWNpW1aEkc6qZ64MiD04Tdn5TpXEWxpgsLJkMzdVNC/ZoGGwM
	 GVXgv43S1pji7jWfzgG95GxiMPRibs27eeHPO8aObaYW6jQfvUG5SCbq3HrcPeIW3f4xE97yt+cF
	 DkjIBvQzVwHaQKgdpSrgoErg71p5QKJxSK4Ofp8jWwWSalQ6U/EkGEPlnnXkhKP+ZcarfpcLWLXE
	 CFwa2k4hXTVq5m53iiCRdQZDIaY7+V6W7aogi4PvF5x2YhLFc439IvMzSp/7c3JEkfyanSbPFtkU
	 NwgioTWMdQBCo84zNgBmo4biUuXthJItP+tiY3AByq1F0DKJbh/te6f0EzUxTurdc/Hn5fgOP9fY
	 lITer4wKHOOHWUgWyczQwm0n2/4s6CwWJArVoZSD2PAwPrgDEZ8MCvUWaaNrQ0udceTFRseF2Z0C
	 f6D4Ho9sEQ8AKLsCKZYu7gxPUXdxQZ5LsyEITOH0WrNvqExD8SF9M2sc2a1BuqUnxoJGNO7Qboql
	 K/GuUW2KAsUb0tG9LJbHaMWPoZ0IE2Ay89E9pyDKKdMIbepFeT4sUOND/PMqX5eiBxPM5YUWS7yz
	 apz/37Zi9qk2wd2vkoey6EETYnvOFDMkvvrTyqUA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-OQ-MSGID: <dd7cd6ea-4c6e-4a00-b461-6888f2009ca8@qq.com>
Date: Wed, 9 Jul 2025 18:22:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: configfs: Fix OOB read on empty string write
To: Sergey Shtylyov <sergei.shtylyov@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 katieeliu@tencent.com, security@tencent.com
References: <tencent_B1C9481688D0E95E7362AB2E999DE8048207@qq.com>
 <e1ef050c-9679-4571-a4dc-581bf005dab7@gmail.com>
From: Xinyu Liu <1171169449@qq.com>
In-Reply-To: <e1ef050c-9679-4571-a4dc-581bf005dab7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sergey,

Thanks for your review.

You are right, removing the blank line is inappropriate. I’ve 
double-checked the original code and confirmed there are no invisible 
spaces or tabs, yet checkpatch.pl still reports "ERROR: trailing 
whitespace" on these lines. I removed the empty line here, and it 
resolved the error.

Thanks for pointing this out!

Best regards,
Xinyu Liu

在 2025/7/9 16:48, Sergey Shtylyov 写道:
> On 7/9/25 6:55 AM, Xinyu Liu wrote:
>
>> When writing an empty string to either 'qw_sign' or 'landingPage'
>> sysfs attributes, the store functions attempt to access page[l - 1]
>> before validating that the length 'l' is greater than zero.
>>
>> This patch fixes the vulnerability by adding a check at the beginning
>> of os_desc_qw_sign_store() and webusb_landingPage_store() to handle
>> the zero-length input case gracefully by returning immediately.
>>
>> Signed-off-by: Xinyu Liu <katieeliu@tencent.com>
>> ---
>>   drivers/usb/gadget/configfs.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
>> index fba2a56dae97..1bb32d6be9b3 100644
>> --- a/drivers/usb/gadget/configfs.c
>> +++ b/drivers/usb/gadget/configfs.c
>> @@ -1064,7 +1064,8 @@ static ssize_t webusb_landingPage_store(struct config_item *item, const char *pa
>>   	struct gadget_info *gi = webusb_item_to_gadget_info(item);
>>   	unsigned int bytes_to_strip = 0;
>>   	int l = len;
>> -
>     Why are you removing empty line here?
>
>> +	if (!len)
>> +		return len;
>>   	if (page[l - 1] == '\n') {
>>   		--l;
>>   		++bytes_to_strip;
>> @@ -1187,7 +1188,8 @@ static ssize_t os_desc_qw_sign_store(struct config_item *item, const char *page,
>>   {
>>   	struct gadget_info *gi = os_desc_item_to_gadget_info(item);
>>   	int res, l;
>> -
>     And here?
>
>> +	if (!len)
>> +		return len;
>>   	l = min_t(int, len, OS_STRING_QW_SIGN_LEN >> 1);
>>   	if (page[l - 1] == '\n')
>>   		--l;
> MBR, Sergey


