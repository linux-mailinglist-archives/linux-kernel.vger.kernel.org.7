Return-Path: <linux-kernel+bounces-737355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CE4B0AB46
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 23:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A401D3BD792
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B89B21C9F4;
	Fri, 18 Jul 2025 21:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N+tn9SBV"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D155921A436
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752873037; cv=none; b=P7qCMLRk3r7nBnl95dOBswR8Ost6lsZ3xuno76dGrAtTuzPT0u4618tP7XXbPfiPEh7OagzwVwQkWJrpJdTg+PkiL5fSZTn2a6dHH2pKmXILQPUlQiOC+pZjE6QuqaJ/HcsKZCmRLgNowe4QaW6PX/YMXwyBRVutfK/0bc7vFvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752873037; c=relaxed/simple;
	bh=eoeq2lfkKQQfblu8s5uJwmmDlVAzN3yXJqVPP+2D0MY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVjr8n9ryrPNeViqm/z6w1l17QZY9q74T0MFnVA3Zrbd+7dbGrvQGQbdk4EWCIDGNjX5bgjhz/8Pp8B0BlwgSdjyFwIH9zmB6vlDmzt/U9CYLW0kX1RBYTO9pesk0sBcZd2C7CuhHpTqd+Y6Wa5Wt9VqGfq8E+U8RhSV65iI1/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N+tn9SBV; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e25355160dso8647525ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752873035; x=1753477835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZGhXZyOJNCmIt8fGNKAY+r1NcPVJKPwyIQ57/sp4SqQ=;
        b=N+tn9SBV1LyRRQV23UL8H17kdtO6fGArP0dFg//ZCO0gwi2IZfv9r7o0rO7e4NowiJ
         l3gNVpbGeRRkRXDRAcLO0vuCz1MNVXdOQa85UGLw3i51INycRHpERSlQ3vTG5DYSEK4U
         UyHOX/n44SKEx/QzRZR7+qIuB+SxLQ2KOGp24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752873035; x=1753477835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGhXZyOJNCmIt8fGNKAY+r1NcPVJKPwyIQ57/sp4SqQ=;
        b=NQFxFdg+owvNiqSGcErvrO+fTjYiC1Hi2HS0h5rTeFrNsTD+dhobWfm3WxO3uUU1G6
         BPuaWb7SHDE9HXi8bOmSyE2Xgu3XnDRFN9/N3sxhyNZeni01J6L35BlSfVYqqaAq2B4l
         KzyJQA3bByBjQoVWExOXdZb+Zjnz6WFQjmmZu/m8nLnSzwEpKHOx7qbfEcus7Cs66fix
         uy9++aBnEpCkmLU7M1nlbwjVKQQjyWnMJhgFksKzSePINJ2NRUMQfB8hWAEM0kE3c9Rt
         I2jYmupx0u2dY770cgpJPEE0y7tmXByEUxOBwvVQ2a5g8bjmTLlGwXlVl/6JSAxg1WvZ
         eOmw==
X-Forwarded-Encrypted: i=1; AJvYcCWOwn/O/amfHku3u58KvlV0CnRGV5VNywSTlm7SUf8ks+dYt+LEL/nEmQpwxyQUKLJ1dVPVOGumcJ2zHSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+BCYp3UExAQ8XyW1ncHxygIih1yL9gyL556nrHjOw3ZpJS4Pd
	Q7yc4xgvDtCDccUlIhppuUPkVIUQB7AI1gO7rShyrAYbPGXOHKSppbzkjj7d8d8LmYQ=
X-Gm-Gg: ASbGncuDL/s8OQPcZvdYYdsA818K1pQBysyKjDR8IlU8ZD6hNTMaVjK01NwBa0lSrTl
	QTIz1Bubl6Jjdb4pt/Mxsk2qCXf1CVFJzMHjp1AtGv9+2EPxTdwcWoXtpjLPWDzfAtHeg36pxP+
	7ozxUGKN0PWry1/956EA7jqvUIQ6u8KukaugfBjXahnRfVkB4E2fn33QGCXEcJ9hXeqJCfcX2vl
	jc7vEATLFeGblJshWNsl7letLKsnfKWXrQyQYCqnE7pyhX4wRFas58VYHY9UKZbKh9tymCNrxf5
	6e0iOiPYVVlWZ83fDemrlDifqPK+dbkhipdUO4hH1JIZlTVqEHYkOI5WgpSbwUoT5m21YOgrRtX
	8qSgQE4TNeC7MOuSQNemOaO6azkJsrkkGEw==
X-Google-Smtp-Source: AGHT+IEzr9jrK3MqEFYKMgLIWYTjssE2U6iSeHK3JVv5WiuQYDYPp5VXlS4Rx6IaMtKrDNjdUXWfqA==
X-Received: by 2002:a05:6e02:4506:10b0:3e2:8e44:8240 with SMTP id e9e14a558f8ab-3e28e448353mr59141415ab.11.1752873034702;
        Fri, 18 Jul 2025 14:10:34 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084c7bce49sm520209173.28.2025.07.18.14.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 14:10:33 -0700 (PDT)
Message-ID: <c6dca956-d0ea-4c63-a48f-d02f21d38b9d@linuxfoundation.org>
Date: Fri, 18 Jul 2025 15:10:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] selftests/pidfd: align stack to fix SP alignment
 exception
To: Shuai Xue <xueshuai@linux.alibaba.com>, brauner@kernel.org,
 shuah@kernel.org, will@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: baolin.wang@linux.alibaba.com, tianruidong@linux.alibaba.com,
 catalin.marinas@arm.com, mark.rutland@arm.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250616050648.58716-1-xueshuai@linux.alibaba.com>
 <ee095fdd-b3c1-4c41-9b06-a8e3695c1863@linuxfoundation.org>
 <0a8d5fdb-28b9-41f5-a601-cf36641bddbf@linux.alibaba.com>
 <821acc51-1429-4625-bae5-daa67bddc7bc@linux.alibaba.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <821acc51-1429-4625-bae5-daa67bddc7bc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/16/25 01:00, Shuai Xue wrote:
> 
> 
> 在 2025/6/19 10:26, Shuai Xue 写道:
>>
>>
>> 在 2025/6/19 05:36, Shuah Khan 写道:
>>> On 6/15/25 23:06, Shuai Xue wrote:
>>>> The pidfd_test fails on the ARM64 platform with the following error:
>>>>
>>>>      Bail out! pidfd_poll check for premature notification on child thread exec test: Failed
>>>>
>>>> When exception-trace is enabled, the kernel logs the details:
>>>>
>>>>      #echo 1 > /proc/sys/debug/exception-trace
>>>>      #dmesg | tail -n 20
>>>>      [48628.713023] pidfd_test[1082142]: unhandled exception: SP Alignment, ESR 0x000000009a000000, SP/PC alignment exception in pidfd_test[400000+4000]
>>>>      [48628.713049] CPU: 21 PID: 1082142 Comm: pidfd_test Kdump: loaded Tainted: G        W   E      6.6.71-3_rc1.al8.aarch64 #1
>>>>      [48628.713051] Hardware name: AlibabaCloud AliServer-Xuanwu2.0AM-1UC1P-5B/AS1111MG1, BIOS 1.2.M1.AL.P.157.00 07/29/2023
>>>>      [48628.713053] pstate: 60001800 (nZCv daif -PAN -UAO -TCO -DIT +SSBS BTYPE=-c)
>>>>      [48628.713055] pc : 0000000000402100
>>>>      [48628.713056] lr : 0000ffff98288f9c
>>>>      [48628.713056] sp : 0000ffffde49daa8
>>>>      [48628.713057] x29: 0000000000000000 x28: 0000000000000000 x27: 0000000000000000
>>>>      [48628.713060] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
>>>>      [48628.713062] x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000400e80
>>>>      [48628.713065] x20: 0000000000000000 x19: 0000000000402650 x18: 0000000000000000
>>>>      [48628.713067] x17: 00000000004200d8 x16: 0000ffff98288f40 x15: 0000ffffde49b92c
>>>>      [48628.713070] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>>>>      [48628.713072] x11: 0000000000001011 x10: 0000000000402100 x9 : 0000000000000010
>>>>      [48628.713074] x8 : 00000000000000dc x7 : 3861616239346564 x6 : 000000000000000a
>>>>      [48628.713077] x5 : 0000ffffde49daa8 x4 : 000000000000000a x3 : 0000ffffde49daa8
>>>>      [48628.713079] x2 : 0000ffffde49dadc x1 : 0000ffffde49daa8 x0 : 0000000000000000
>>>>
>>>> According to ARM ARM D1.3.10.2 SP alignment checking:
>>>>
>>>>> When the SP is used as the base address of a calculation, regardless of
>>>>> any offset applied by the instruction, if bits [3:0] of the SP are not
>>>>> 0b0000, there is a misaligned SP.
>>>>
>>>> To fix it, align the stack with 16 bytes.
>>>>
>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>>> ---
>>>
>>> Assuming this is going through Christian's tree.
>>>
>>> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
>>>
>>> Let me know if you would like me to pick it up.
>>>
>>> thanks,
>>> -- Shuah
>>
>> Hi, Shuah
>>
>> Thanks for your review.
>>
>> I send this fix in Mar, but it missed last linux version.
>> I think I need your help to pick it up.
>>
>> Thanks.
>> Shuai
>>
> 
> Hi, Shuah,
> 
> Gentle ping,
> 
> Thanks.
> Shuai
> 

Will, Christian,

Can you take a look at this and let me know if this change looks
good to you both.

I can take this through my tree after your reviews.

thanks,
-- Shuah

