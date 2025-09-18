Return-Path: <linux-kernel+bounces-823238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013E0B85E0B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90FF4464EAC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C59831329A;
	Thu, 18 Sep 2025 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="eIqDrv8I"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5583112DD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211123; cv=none; b=KGO2A8fqGgktsaYPS5d6DlEnNyC9L7NjT3ZugAj95VbYxVoF4dM9L1OZaxc0ahpHRxmwGv5HJORNUOMf4ni2fbt1ohMuTSyxjGslYlxnxDR1kBUFGeuvZ4m/oYOdziwv5i2PWMBM2nlg/QpycsNi2msCHgYilnnE9PfCLCwFD1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211123; c=relaxed/simple;
	bh=mBOMOV2UEaBJS1bN98PWLw1Tk1D7AqCi+UV4js6u0C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NsNQu0GQLTvS8KD92YJF0+Hed2APoTr0tMP3a9IUmZcVI69zvCuMKv76R89NhIKv6Tvgv1M2HFBD2gdQuoo2UODfkWJ0BV8w61GdgTw1/iRiZpnJXS0oBsFNZz+iY4rj1KWq+5/jsN9qzDCq7lGYxpXcSuVPQ0Q2f9s8kNhjNX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=eIqDrv8I; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-8a936b682b3so43969939f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758211121; x=1758815921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RWwPXk3+CMDIY3Ii9TMDH0aQbdb6ssOVOtszqmINL5E=;
        b=eIqDrv8IlQnhhhur3TiOpM6K5hTCjACBRPi8UeXGHdC0YshE1hZ3YQODdHtE63tgtO
         HuSYevpRg3f4cJVzJN3Gs9ZQTAS8YaCaPC591wj61SjBVXCIqUxc1bOmryjbXwiDLFiM
         fJjYeWM1iY2g3jWecCD26TRvYeTjegxCDWqJ/4fZTzG8M/OikNkhTsF44OvudjfOZ1dC
         zaTcFX+LQ7GM5pd6+yFYbBeNh5JCydjwZiyT/Vd9L37zKhtykeDqcrEcidzWBWnC8CHp
         BuoKdKf+gl65xhgmCAb7bYS9o1KIP/T8zG1DTdZP0vaN3C5sDO3Dqe8evzCSV3/w54ya
         KAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211121; x=1758815921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RWwPXk3+CMDIY3Ii9TMDH0aQbdb6ssOVOtszqmINL5E=;
        b=QeS049ht7QTmCE55XcAzUje5MDQBLEZi/nDOU4UY9Aw6cRO7EyLiv1O4ZBwKmnyHAg
         CUec6nQvc5QG+j2lwCXkeCUcs5xBvne8G/6nX+Rn3QgfaeLWoQCNHzZ2A9fQx8mGTx7c
         yLBu6IBki7C0xmEXqinA84WeCAtRZIqQcGKGGo48YBoAT8zAa7YerUN55bNohVHNBGB4
         z8PL39vhp8QA4V9fewKJNW1iKezZN+832PGNvsvT9Y1YJHGvLnp0B6EvkrztbHqGvPV/
         M2WwTvPFIbJnVdFN+L0bI4JADwV+MF7v4V0hTZOjG07KUg12FvQWNUZ+gB4w3m9Yy6Sn
         8EPA==
X-Forwarded-Encrypted: i=1; AJvYcCWeIu0m8a4mfJMphSmkqKlb89k73NjfISvNjLlC2edoMBsRlP18bb94CTZ+QjaTBaxV/KG+ffNtjVK+bYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGfWNGivusc/vQpN8H0mO5aqol5pGt/7Dbc6jBgjw8SPVqTl+5
	aFUuFnBn/KteARhSGw3RyI3YjygID3VVdXqLlqtf8RsY7Y1nvRxCKD1sv8NtKKUTTYY=
X-Gm-Gg: ASbGnct5lMgdYbwZhgdUofndD6FX8Ov0w5C3cCU/bCmjD7ZNAVaIKwtDwnuJWbj1eiC
	41w080ZKWd26iPy7iIFJ4Ga148nCQQtYqY27X0122hoJ8vVcXPV4tCxfJs2/L3GvQGtSoTw+k09
	yAdLbxrO2Avt9MSTAFHGjTpAOEJuIF1F0UkgVw8pJxQmoqtV9+oKX76dM/0/5e1OTTDekrQMtdw
	Wjtv/VuzERJ/j8UaasA5jMGKHqDRwlTdv8WyZ/rOXa7+hQxv7B2tA2fWfAU37I1kr4kWqVSEmH8
	ThiVyg5Yxbfo/pCArVbcfFVA7QOfjs5mjbjExmi89kUdFkXWLAG/ccKj+sWXKfOPOc0A6XKCi9V
	tbTlYCr6LyCjYenTQ1sj7HKc+5vk50GKqt7kce3lJxQuVYqYX1xXSBoc4Rc/Djw/CIGgKkdZvDa
	MQZb+H5Xkr1yyth0su
X-Google-Smtp-Source: AGHT+IF7L6Nzhpq00zRjUOtUlsvmOyj8YvPWYBfqvWW1/q2pHZGHXZWCIyaJ4bn8yb0d408EYIgLfQ==
X-Received: by 2002:a05:6e02:b48:b0:41f:8265:4100 with SMTP id e9e14a558f8ab-4248199c677mr962075ab.18.1758211113083;
        Thu, 18 Sep 2025 08:58:33 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d3a591637sm1058871173.15.2025.09.18.08.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 08:58:32 -0700 (PDT)
Message-ID: <000a41ee-a099-4944-8ef5-eed768f905cb@riscstar.com>
Date: Thu, 18 Sep 2025 10:58:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] spi: spacemit: introduce SpacemiT K1 SPI controller
 driver
To: Yixun Lan <dlan@gentoo.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-3-elder@riscstar.com>
 <20250918124120-GYA1273705@gentoo.org>
 <034cecd3-c168-4c8d-9ad5-10cc1853894b@riscstar.com>
 <20250918143928-GYB1274501@gentoo.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250918143928-GYB1274501@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/25 9:39 AM, Yixun Lan wrote:
>>>> +	virt = drv_data->ioaddr + SSP_TOP_CTRL;
>>>> +	val = readl(virt);
>>>> +	val |= TOP_TRAIL;	/* Trailing bytes handled by DMA */
>>>> +	writel(val, virt);
>>> I'd prefer to do like this, it's more easy for people to grep..
>>> 	val = readl(drv_data->ioaddr + SSP_TOP_CTRL) | TOP_TRAIL;
>>> 	writel(val, drv_data->ioaddr + SSP_TOP_CTRL);
>> This is an idiom I use to make it very clear that:
>> - The address being read is exactly the same as what's being
>>     written
>> - The value read is being updated with bits/values
>>
>> I find that putting the "| TOP_TRAIL" on the same line as the
>> readl() call obscures things a bit.  Like my eye doesn't notice
>> it as readiliy somehow...
> fair, let's put it into another line
> 
>> Yours is a pure coding style comment.  There are two pieces, and
>> I'd like you to tell me how strongly you feel about them:
>> - Using virt to grab the address being written and read (versus
>>     just using drv_data->ioaddr + SSP_TOP_CTRL twice)
>> - Put the "| TOP_TRAIL" on the same line as the readl() (versus
>>     having that be assigned on a separate line).
>> To me, the second one is more important than the first.
>>
>> Let me know how strongly you feel about these and I'll update
>> my convention througout.
>>
> I'd strongly prefer not to introduce 'virt', so be something like this:
>   	val = readl(drv_data->ioaddr + SSP_TOP_CTRL);
>   	val |= TOP_TRAIL;
>   	writel(val, drv_data->ioaddr + SSP_TOP_CTRL);
> 

OK.  I'll do it this way throughout the driver in the
next version.

					-Alex

