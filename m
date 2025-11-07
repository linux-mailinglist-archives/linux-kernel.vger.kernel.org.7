Return-Path: <linux-kernel+bounces-890845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB417C41296
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 18:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D88A4E7EEC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 17:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F99C337688;
	Fri,  7 Nov 2025 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XwBhbLT6"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DD03358D2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762538069; cv=none; b=FnQlUMXjsd9PnUr2rXQQ751GwjxYZBKVUWitJV7/+SqhRaqn2bL59s/5DzuD2sqPJCeGkQmwp2sR4Tr47W5n8bLLomv5DMWIFegkNrGWGHan6pAGqzqng7JowpCPhbVK656nlE9uTCBrevSe2HNGeBQyNq71+maiHQ+/7f7dv7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762538069; c=relaxed/simple;
	bh=dIlUqtzLyQeoLWra58iVWTQ8+nwBRh5dtagRaNZsUEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZcQ51zjEYPidUq4B7dr0rfHF9bTCAjqNABCwLejeuCRNRlNTFpXF+n09ILWX+Bw+3VPDi4jNPqTybGkL5uF5N9Mn7eHEDy9JwQWFmLpXbQmX3hQwCGAlwxh7nkIOZtEq2p8LEtX0iIBOT542NwETWLCqDWF91Ne9wcIEXRab4a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XwBhbLT6; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-4332b4368ecso7204045ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 09:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762538067; x=1763142867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FU3/MuagL6B3vYQIaeUguOWrDr12VN/IdKPR191w65w=;
        b=XwBhbLT6AynyygfsTjPYppVn5gp8pUM6XzrBWrXoLVMBsMOqrRcFSbUInIg7FuLxk0
         7SBjz/WDN4yeYMpgzSb7WoMl9GkFJATXjYVX74qPGv6aldgkQ54MKFC3Bv8840uH5gxS
         OK29KtE38gaxuUJ2CDvQOqLWIsoLuXsLrTwiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762538067; x=1763142867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FU3/MuagL6B3vYQIaeUguOWrDr12VN/IdKPR191w65w=;
        b=wenNNDqH1VpvA2rAqTqBT75cO3A0EV52LqB/p4G6YuWdsfo6RpWaE0MwXdvLo6IozY
         RXOWSj+iEwbiBZjLzeYOGsByUuH+pLZEicHARecPiVjw7pJSpIddxBwOlblNtGwhEY7x
         Bk/gZkrADhU/YNMdQS338vEG0GKO2MVZsgd8b8R3ry4MhpdEWQvdl2BI3crdlH4BeQYb
         9czQL+9Q0Nn6M+ra+N9MoHQgJSvp+aI9IHWiuj1VSH+yCCsvP7bHw9AR1TdF5O5KwnV/
         l670NCV1LR0LLelOwqVYe7s/3KcLlwGSs6dEu4cn+uzS0KtJb+0rbqTfw7UJKxuXN8Bs
         6jlg==
X-Forwarded-Encrypted: i=1; AJvYcCWOOs+Dd76AeQBqIBhiN034SKFZzGzu30dBr0TdqQu0ms4OBX5xBZyCzVEV5jIMhBtDdlqvBPa7utEGV54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdbwqzcrtuIaF/ye13rS8dkAcjza1yckyehllZMg3tPyeQmDy0
	JbtVWDoTUO6ITk4arFN2LQYeV3CApdCV/YT4vd87d6K6AsBlgsy9IUMDDZ0KjNoOPR8=
X-Gm-Gg: ASbGncvg65XTVlIWF39GQCrWIyNbDak5b2b58jZB2eSTJItansY+4GxSMKpF2cRrhEs
	lmnErKUO1phruoQrKJGMa6I95Y5kxgnDv1uumOsGQ6wgigdBDm1jR/ciDQ48udi6wH4bAzPpD/E
	oIYiEVOsCOj7uTgdJMzxOynZsLFafpEP1l8YkDPryy+w3Ubf5oqOj9ZJHLw/SPdLjjK12S4A156
	Pc1+yGgdtgUWShgBoyK19T3XEKwHey3dsX++G5GAyiU1a7dOWj6MYn950hEBWKzyccmx70I+9YR
	RnqAwuamEvy0VXtq674KDjkMu5NR2lvrOlfbCNKhZHFs/OG9DFbtiMER2IYVk1jE7ycT7F75y35
	tuxuzfQgTi9dScsL9qoZhnB84mTPdBr5m1ox+8X7gspSt45NVb9qL0P5P/ujJRYsSVV4bdHEAvf
	JbIYeMWoWToJnj/l3mVu4Uk38=
X-Google-Smtp-Source: AGHT+IFKp4dE65PiBOFxRJN/woRBeSQ9orDQvbl++M1O5M6uLi0c6Zrpx9SmAbu7RjKzh9d0tCzeOw==
X-Received: by 2002:a05:6e02:1a2c:b0:433:4c96:48b8 with SMTP id e9e14a558f8ab-43367e7a04dmr5317795ab.32.1762538066733;
        Fri, 07 Nov 2025 09:54:26 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4334f4e77b7sm24550145ab.29.2025.11.07.09.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 09:54:26 -0800 (PST)
Message-ID: <e45ac35b-8cb3-42c0-b5dc-d4c718ee0d9d@linuxfoundation.org>
Date: Fri, 7 Nov 2025 10:54:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: core: Initialize new header to zero in
 pskb_expand_head
To: Jakub Kicinski <kuba@kernel.org>,
 Prithvi Tambewagh <activprithvi@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, alexanderduyck@fb.com, chuck.lever@oracle.com,
 linyunsheng@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
 khalid@kernel.org, linux-kernel-mentees@lists.linux.dev,
 syzbot+4b8a1e4690e64b018227@syzkaller.appspotmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251106192423.412977-1-activprithvi@gmail.com>
 <20251106165732.6ea6bd87@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251106165732.6ea6bd87@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/25 17:57, Jakub Kicinski wrote:
> On Fri,  7 Nov 2025 00:54:23 +0530 Prithvi Tambewagh wrote:
>> KMSAN reports uninitialized value in can_receive(). The crash trace shows
>> the uninitialized value was created in pskb_expand_head(). This function
>> expands header of a socket buffer using kmalloc_reserve() which doesn't
>> zero-initialize the memory. When old packet data is copied to the new
>> buffer at an offset of data+nhead, new header area (first nhead bytes of
>> the new buffer) are left uninitialized. This is fixed by using memset()
>> to zero-initialize this header of the new buffer.
> 
> It's caller's responsibility to initialize the skb data, please leave
> the core alone..
> 
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index 6841e61a6bd0..3486271260ac 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -2282,6 +2282,8 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
>>   	 */
>>   	memcpy(data + nhead, skb->head, skb_tail_pointer(skb) - skb->head);
>>   
>> +	memset(data, 0, size);
> 
> We just copied the data in there, and now you're zeroing it.

Prithvi,

This type of careless coding introduces serious problems. Don't
make changes to the code without understanding it. memcpy()
is right above where you added memset() which is hard to miss.

thanks,
-- Shuah

