Return-Path: <linux-kernel+bounces-885794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD452C33EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 05:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D83F3AAE9A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 04:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EA521D5B3;
	Wed,  5 Nov 2025 04:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="onTdruhM"
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D682C2FB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 04:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762317123; cv=none; b=jSyJkJihwWF0+IFG/l9qWgnBIGe2SzfBTcGnXrcWIKKmSx4Ch4/IgIOQtt1OQ7/zeSfgpDiOsoYQFCzBVM81DNJHuv3ZbuEZCKmJ/fXjZM0c+eGeBKMznrbKN/+fmnvmLZvvjG2+d6GTPMr8Czm+MllUEXAY7m+sVqZL0GDvc9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762317123; c=relaxed/simple;
	bh=qYvMpkRzv/z4O8f8MJE2fb8Sq5IeQtkUSmDqGE087QQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=E5HlADm0oX/EmfMSXAxtrgRZCXhbvurULaX5U3KPkOwadsr5dCgM86sRjkhitBunOptsjaZMjRADttJ7/vPsCqyZuuH1UdQ9/KUA9PIaUJ1f2HD7eifW8ag/oQ3HF83QKDSCL4O3mOPRiYX2qN34R87VXsrnK75RJd3s4WvOPRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=onTdruhM; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762317064;
	bh=mJ58wxkUp3QPDHQZyMF0q4nEx7f3gcDEWgs42azNwv4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=onTdruhMlw5iPpYED7i0Drw+s5KfcnflcCoLRzr2nbijNY7Gke+rBa4ywdov/GFrz
	 A0C7aXoCN7nJhktapBuApjA4krZX956YYiOVjv/XUEts3d864G40gEj1Ty+QadeZnf
	 d2/9g6E2IZcR6nusIHUlmMt6oZnye4XMMvvM5cPY=
X-QQ-mid: zesmtpgz3t1762317061tf373d11d
X-QQ-Originating-IP: LqdixfTpbZBUVo+Ea7w7yN8rPbRjEJ7emqHxABhoIn8=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Nov 2025 12:31:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8064024665032217773
Message-ID: <C1D5AF8ADDDB53F3+623309e9-4fc9-4186-8f07-04cd6f5d5612@uniontech.com>
Date: Wed, 5 Nov 2025 12:31:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] kexec_file: Fix the issue of mismatch between loop
 variable types
From: Qiang Ma <maqianga@uniontech.com>
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251103063440.1681657-1-maqianga@uniontech.com>
 <20251103063440.1681657-5-maqianga@uniontech.com>
 <aQq/CHi10ihT8/sn@MiWiFi-R3L-srv>
 <c669d240-1ee8-4897-a30d-3efefe161085@uniontech.com>
Content-Language: en-US
In-Reply-To: <c669d240-1ee8-4897-a30d-3efefe161085@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: M58CI+QHpTsklVtnHl0PfrWs7Jlc4iKmKu+ho6D9VUo+fgA8IjGwtizG
	weDUFU9SAJK37CUi9V8c+9mAfaCK6elmyArCc5r2rbzy3jMoItKKHswShO+/G6cFH+65pfp
	TydH6F4x7JKZHamoWJKyZOPpSUvf/b5XLmpII5Jm8ZiZGQxG4U0zRxUrL/TNmxnmdyZT6eJ
	HgjhBQf+287mGERgv8JPPa+3RrMfM3g8bsQLkMw3rXYLxsUIsjIOm8/MVK94zrsR4WQQC95
	MIBZk4dOfZCvSFTXutNJrxdTywJSIAvR+yFdHHkMKtj6CJMCx2f48mqojSrae30TSdCxiQU
	dtcMopqjj+VESf0X5nd+8G3Hg90USBF8Ee+JEgIzFCnuoXAoygjh9AxBey57UtNJezIuybn
	IH/M1z5hlKjn+Ihol/VTXYe+6DerWsrfPIlfkf28Wbdph9y6ZcKsws298R+UyhpNj6wfr3O
	xyr78MdlP6Bvn4uVmVNuZ+XO/k3bsT4DPjKF+qMgGvWwXDYBXOJc9wxIcW71DiR4RCZ7F2M
	qUYfaxxK10+VXozLdQhMjvXDp+Qu/6hnuDvAw5dHwMeh8in+jMTObKpVe65aX9O63p/yOS1
	D4uZ1fDUOW1dkoiCz+wchU8LrvwB4+ZwQjy6m4MtVSY426y1aLEz03Lmgu8dLrv8gzy0+bd
	aqnyf+MXkJ8i+XKyKyBsNxx32ieDTlG0bAd9KgXMxzILuRhC7sIAWTqwx5GrOcpmrrridY8
	gfpkpjB9hvp0bqS67aXfbKcoAhRgrsvRkFxqvsXVOIg8gtBIieHNulnkm78Cic2dKYxgjOG
	u6kEV0GeGhZbSoYzUgQ10yqwml6sidVMHLMU/5eKPp1LSj9KA1XLn3631oXdBDKgfUs4sxu
	0jONnuy2A/g8AsZMkpTntObWVeK6XO0a1xbcicEueaz7WaBNMvWkjRh96VQan5TJbyDB86u
	IdpC5kLFmsvXpOrOviU7yQPgcNSFaqe0CAxZpRk8EZj+JYi08v4OGOnorSkxGHVC2VqgQU7
	Om/hMXO7w76s0aRe0hwDpmXQDyrN7X9Jz/5ZzSCY9R2tVWGRoZDZp+jooAE3o=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0


在 2025/11/5 11:47, Qiang Ma 写道:
>
> 在 2025/11/5 11:05, Baoquan He 写道:
>> On 11/03/25 at 02:34pm, Qiang Ma wrote:
>>> The type of the struct kimage member variable nr_segments is 
>>> unsigned long.
>>> Correct the loop variable i and the print format specifier type.
>> I can't see what's meaningful with this change. nr_segments is unsigned
>> long, but it's the range 'i' will loop. If so, we need change all for
>> loop of the int iterator.
> If image->nr_segments is large enough, 'i' overflow causes an infinite 
> loop.
Meanwhile, the do_kexec_load() was checked and also defined as 'unsigned 
long i'.
>>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>>> ---
>>>   kernel/kexec_file.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>>> index 4a24aadbad02..7afdaa0efc50 100644
>>> --- a/kernel/kexec_file.c
>>> +++ b/kernel/kexec_file.c
>>> @@ -366,7 +366,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, 
>>> int, initrd_fd,
>>>       int image_type = (flags & KEXEC_FILE_ON_CRASH) ?
>>>                KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
>>>       struct kimage **dest_image, *image;
>>> -    int ret = 0, i;
>>> +    int ret = 0;
>>> +    unsigned long i;
>>>         /* We only trust the superuser with rebooting the system. */
>>>       if (!kexec_load_permitted(image_type))
>>> @@ -432,7 +433,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, 
>>> int, initrd_fd,
>>>           struct kexec_segment *ksegment;
>>>             ksegment = &image->segment[i];
>>> -        kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx 
>>> memsz=0x%zx\n",
>>> +        kexec_dprintk("segment[%lu]: buf=0x%p bufsz=0x%zx mem=0x%lx 
>>> memsz=0x%zx\n",
>>>                     i, ksegment->buf, ksegment->bufsz, ksegment->mem,
>>>                     ksegment->memsz);
>>>   --
>>> 2.20.1
>>>
>>

