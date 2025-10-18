Return-Path: <linux-kernel+bounces-859270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B534BED30A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3AF24E285B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C1123CEF9;
	Sat, 18 Oct 2025 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGBL6jAC"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BF51494A8
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760802732; cv=none; b=K79mvhNolov93ZFNdS7pkDhTxA+VJ/hnWWhN+fNJQobRv2eagelGpnAMYXNbvY1fLK3EobqeaX87Zmicrn38h5e/APz8nBuHC+lg8Lj1G+/q6RcSysdtYo6p0pPHx3uK7NEr1K7HgFc8Zj4T9pEXBlbEIUEZFhsPIe1tIys2a1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760802732; c=relaxed/simple;
	bh=jkKNTWqA+dunjGtKp9ONacoSeruZQel4vRKBXYFAQuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHsRWBGmyChsYsd9lKN0Bc2dlGj/cXHsVUu56yj45BwU5cJreNhwnEn868HoyaQ/RD+G7t5ThZZa0tOvQjad+9/yUcgxuqoDsRbW8UO7EnE+wPLGmS8upg2bh8LaJJwqCd7nkIiaWHELU31UxyelLWmujL+/mFtJdJz5z+J3Pb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGBL6jAC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4710653ac03so1545375e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760802729; x=1761407529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/+d6bg7Je6LSfnCh0eUcN2Abtn61/XzTPi6xEkMU+k=;
        b=DGBL6jACLgwl494DQhe5JY1zLDo65W2tgEsuSYD/3g75/Z+BnTF2lMF3JtlyuxeTqe
         wtA4jfXY5R9wrBQJNIA12qwmpZu4janhl0Rk0zCFmXeuobia4Kj8OJ6VEOOTe3Aoar86
         vctO0l1aR+DuMJ2qzcl6/poLgm0AehkPv3MIu8jHBLqOKlGIQObKtdpmqUBw2KYuEUOh
         Bzf6VEBJjDdyQWO3UBfPQySe1XJdNJe1OB/kpeGnxR4q7KmhZu5zJEO4Kbux4MZ1BJ5I
         u8BsS5i/KpfW928PwU9mcP6g9ZuXw//fDm7vmHBj9p+WUTSTze1+sQQH+lVPwKM1NZpC
         CSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760802729; x=1761407529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/+d6bg7Je6LSfnCh0eUcN2Abtn61/XzTPi6xEkMU+k=;
        b=sZPgkxkuO/kBhoqNjKR+CgK0UQvup8lQRLYk6aqh8q3bTrqNI8mQ9wYjzZ0GS5OXKt
         d6kmjvPBIi2mvl1/Fka7OG1WvmjO2iSaUXJAaqWvaSz8GgrRx1zDbp6/Ur796Nk3ADv9
         fcEnbmSG5J/MuoWLufKXliek3P1pJzy2ZgtvpJnZVTvi3rgzxiiRLtKZkB2CQ0p6zzlm
         ECZ1bLI+db1uRpG1+SD6+Axq6aRbuYutwUvphPlhP8g6u/Ich9Ve4l6Yw3SJLx/Taoor
         T+tMhYH1cf5HD7KL/Bttzpm18IeUMCQuJZqiiIesZM6v8pxtoIyzNkbwm1QkVAQXID9d
         m3BQ==
X-Gm-Message-State: AOJu0Ywh54Ss+E+LUz5NT5ibBYMg6nC5iokp7duNFCUz3Fy4VKrfhWDw
	+g7FN/o9ob+E/Nb/loCFhVRYuUrxv3NXInUoU6ykrzfQoMWM709LKKmj
X-Gm-Gg: ASbGncsZepmHD5ddjOHLKVMQFkp4Y8gJ/qPMtaIVry6Q/ocxF+64Z/K6VERFD6KINcC
	dBafefAGZq9LYQr0kb4+xoptxQL38ipdUjyUkNMi4tZbJw1WsKj0DxGzCDWKDDHQORFu13ibepK
	6AEDASlDd0iOk2xhwpB6yUAwj5lEtYEtU2UwmXzTn7rTV8jup8sG2HHGTIWJJRn9fkDhR31TAN5
	MUUl96pArRKOSduUk4Mte8QZLGxKLWCcJvwXL4ssTzrrp0+ckvVU7U1opjj80asZ34kdS4KecRi
	KgJ0lxrrybZCoe9TBTPD8CBgZH94LxmZVmjwb66yhpqzQ1hmjs6sdbcRc5hRTbuRbBbv9QG5oBs
	IH3O8INjRYdSSiI4cJwa7cdtQq9WkY1IBJroo3vcEYpaUc4YAe7rL/hh6gDvR8avUyEQ723mW3x
	A/YdYLe1VWxQKW2aYOgMyl
X-Google-Smtp-Source: AGHT+IFbTEDd0tDgCWfpUzX7d3KQYCRA8fou8NjdDwmZRR71rY4raU6CKiilA4b8HyfDtmg5bF09sQ==
X-Received: by 2002:a05:600c:4e86:b0:45d:da49:c47d with SMTP id 5b1f17b1804b1-471177c245bmr32622905e9.0.1760802728516;
        Sat, 18 Oct 2025 08:52:08 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.121.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715520d747sm58135015e9.14.2025.10.18.08.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 08:52:08 -0700 (PDT)
Message-ID: <1263c092-d4bc-4d8f-8ef8-2706d337f4c2@gmail.com>
Date: Sat, 18 Oct 2025 17:52:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: cpu_rmap.c Refactor allocation size calculation in
 kzalloc()
To: Shuah Khan <skhan@linuxfoundation.org>, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org, khalid@kernel.org
References: <20250930092327.27848-1-mehdi.benhadjkhelifa@gmail.com>
 <10082c41-4302-4cb3-a2bf-788e59bad0c8@linuxfoundation.org>
 <84bf5902-b3e5-4d58-a2a7-f01e15cfe143@gmail.com>
 <bd60a8e5-f4df-4743-8b56-3d6127906ff2@linuxfoundation.org>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <bd60a8e5-f4df-4743-8b56-3d6127906ff2@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/25 6:00 PM, Shuah Khan wrote:
> On 10/9/25 09:16, Mehdi Ben Hadj Khelifa wrote:
>> On 10/7/25 11:23 PM, Shuah Khan wrote:
>>
>>>
>>> How did you find this problem and how did you test this change?
> 
> Bummer - you trimmed the code entirely from the thread. Next time
> leave it in for context for the discussion.
> 
Ah, I saw in other LKMLs that some do delete the code so I thought it 
was okay. We'll do next time.>> For the first part of your 
question,After simply referring to
>> deprecated documentation[1] which states the following:
> 
> Looks you forgot to add link to the deprecated documentation[1].
> It sounds like this is a potential problem without a reproducer.
> These types of problems made to a critical piece of code require
> substantial testing.
> 

Ack, This is the doc that I was referencing: 
https://docs.kernel.org/process/deprecated.html
I'm not sure what is exactly demanded in substantial testing.My guess 
was to do normal testing as I mentionned and add some fault injection to 
test the change in case of failure and also compare dmesg outputs.I have 
run selftests for the net subsystem too since my last mail with no sign 
of regression.Any suggestions on what testing for this case should look 
like instead or on top of what I did?>> 'For other calculations, please 
compose the use of the size_mul(),
>> size_add(), and size_sub() helpers'
>> Which is about dynamic calculations made inside of kzalloc() and 
>> kmalloc(). Specifically, the quoted part is talking about calculations 
>> which can't be simply divided into two parameters referring to the 
>> number of elements and size per element and in cases where we can't 
>> use struct_size() too.After that it was a matter of finding code where 
>> that could be the problem which is the case of the changed code.
>>
>> For the second part, As per any patch,I make a copy of all dmesg 
>> warnings errors critical messages,then I compile install and boot the 
>> new kernel then check if there is any change or regression in dmesg.
> 
> This is a basic boot test which isn't sufficient in this case.
> 
>> For this particular change, since it doesn't have any selftests 
>> because it's in utility library which in my case cpu_rmap is used in 
>> the networking subsystem, I did some fault injection with a custom 
>> module to test if in case of overflow it fails safely reporting the 
>> issue in dmesg which is catched by the __alloc_frozen_pages_noprof() 
>> function in mm/page_alloc.c and also return a NULL for rmap instead of 
>> wrapping to a smaller size.
> 
> Custom module testing doesn't test this change in a wider scope
> which is necessary when you are making changes such as these
> without a reproducer and a way to reproduce. How do you know
> this change doesn't introduce regressions?
> 
My custom module testing specifically tested the change in case of 
failure which is what the change is for in the first place.The change 
which deems to be simple in the documentation since we are just wrapping 
calculations instead of using operators,is just to safe guard 
calculations that are made inside of kzalloc() so that no unwanted 
behavior is produced i.e in case of overflow.As I mentionned above,I 
tested regressions by running selftests for net subsystem with it 
showing no regressions on top of fault injection mentionned.
I would like to have more guidance as to what I could do to have more 
robust testing in this case.> thanks,
> -- Shuah

Regards,
Mehdi Ben Hadj Khelifa

