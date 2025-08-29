Return-Path: <linux-kernel+bounces-792093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64522B3C015
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95FA03B5CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E843277BB;
	Fri, 29 Aug 2025 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I25D4wTa"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E46101DE;
	Fri, 29 Aug 2025 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482977; cv=none; b=mOvjfGqKzc0+ePm5+2IkWgMyD4i2Ke9wMCEenxL9/g4YmeUOUH/MaZhuJvlm4YXLYykkkkNz54+nr8k5be9uxrDQTgwLRLEKmm/boRGqcA6Xree6P+dlPKGCBwDowShlfx8KCGPbRPlma/3A7kiFbHmp6GUR39/4o9KgRXzIsFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482977; c=relaxed/simple;
	bh=UeD7ReQb0W9N/g6IuxErMIqx1tqjVA2jllJBy229d24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nA2s97Y3X3SAUxICwN4K1QjiZS4NyGxxVn9x5Izy4jWjJqkcpvzPLJNRInHZZjIZqLzaMhAaO9/yXhu9P+tv2s7iKJkTO0p3swYgtsYhMA/102JPOfbA0BbuDB8k3R6jsUS2Mjaydd2YpBXLECH+DNM8J97tA1zdgh/IWzgSWzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I25D4wTa; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-248ff4403b9so13167315ad.0;
        Fri, 29 Aug 2025 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756482974; x=1757087774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=XVVxgA5rIGXNBp8g4IW3gS/YXo5OdUFnlgiejplS6xc=;
        b=I25D4wTatjZxISxUgOOMnZYvxhv2FwKzRsRTxoU3e+kfSs/1DrcX7QRqnrEv6+q96I
         lpBpp11/+2Lnzt7+qS5fzpJWJoFof23Q7bm5D5orlSNVilBt2Ajar0qgDsELRH+7SpTq
         xtSHp7JQhWcCdYjxVMa4Piw3R1GtS9Ds4KLOUt+DmFo46OK0IwmozF0ABJmtuBUihkEm
         4VYLtDemH+SIe7t2l+LeCEXWQjAYnSlnQyFoCoL57VnMYxBWK59bPjV7wOUW00ze+66T
         QxWQjQF0jp7mB4ihGPwPtIxjOy0EBuAHoQxHp90q3P9bk+mHNpLv7hof4PzaP5nPICgo
         f+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756482974; x=1757087774;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVVxgA5rIGXNBp8g4IW3gS/YXo5OdUFnlgiejplS6xc=;
        b=v509mK0PSpU/d/6A5gQoFt2f87OYFrlfvSX9tmkDMBQwQ3QwqFYxiGnEnyZRQzkNtu
         foj4HQuzfV6JMthLOqUSAty9m4shhleUOWa3x59wfXUx/LmCDjjMramAzPKuKziQozSB
         3GF0LryUpXXsHFzLHogr4r0YyO/tyqt2x1G6DCoa/Y7B1zXQzTLO753eycfjgZGMZebj
         oE6Pf4yy7HGM8Z9vO28p8O+iShnS/ikPtp0nJBgYA1ElCtEAm2Yebo6D6XyYGsBYcOwW
         IBlN7O6Ws+a0suRRxgkh5yFuhK6+tUJA9M2S22D9oEY0XJPf12ikr+duSP+7n/HJDeIn
         FmCg==
X-Forwarded-Encrypted: i=1; AJvYcCUEMZXBCN8BmDWVRzTIjE51nEVw0HVJzNPS33LFW8Y853ZowPrlvVMus4eqmKkL3GRHGP7K/NPzHVjl3z1R@vger.kernel.org, AJvYcCUUe5cglxlrUHeH149LIMzGYnHvrPBS/i/Z70y6Hwo53GzPva0/Dmaq4jZPw025GPRbPBFhTOObh4ct@vger.kernel.org, AJvYcCW1e0adBoW8K+OdySGj9fMkj6NwHRrH+dqZivLNfUYHRr72RU44iE58OmzilSC/hEfXF1C16yIiEKjs@vger.kernel.org
X-Gm-Message-State: AOJu0YyjsQcnxv2OJCDcHCIHogxDx6mDyFuRhbvuZMEy4EU3fX4zgH0r
	bVNXPHdUP8pD7xGvBU8lwCbqmcrPRuqMV8ceCLpFQP7/TxwLe7BR20i9
X-Gm-Gg: ASbGncuoMJeHHbbwb/QrbhFydHbgWFvgC/LNwPoZ8GOTcMwgcqDOMKvdwX4NOMwt8yA
	Ef1kF+QMDB7BGr8qD5c98+76QIRdcyJavHgBynw0iBLgEaYh8JPGBGrFhCUqGnRZBcD02q1AqIl
	e81wMYvRsQ91rUcyVdUq1KTnjOFZGOgAF7LYWhxCP/v51b+fE/VyP9t33lRohxj4n9c1n6sk2WA
	3N1V/aq0w4v/MIBAEWE5lgPVz5By7fxbKh53ALdOv5XM/7S1XdEevdz8PHjx3OG/QB+0X1rl+Re
	3tjMTXiiK7V8lx80eYx1O95M1ywPsF74zCcB0KGSahB3MefVsygmQgCm+u4OOV92C1pj3LTuSFr
	6Gzwb6NsG0TrNuBKVrMMVioKr1sSu5TBM7ZdirHrrtZkapzqDInYPRy2/47UKydjTdVYW8rPdFr
	0lBiJrzQ==
X-Google-Smtp-Source: AGHT+IGhlQ3tT1HYni9MBhmSKd1VE0DAcYBwoVo6VBVt2USCm0uittvO/LraA97A3+qSUW4u+gsOkg==
X-Received: by 2002:a17:902:ce0b:b0:248:9c98:2cf4 with SMTP id d9443c01a7336-2489c982ed7mr154814485ad.46.1756482974084;
        Fri, 29 Aug 2025 08:56:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249063915c7sm28835905ad.102.2025.08.29.08.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 08:56:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a3131832-414a-47c8-8dd3-93af7283c516@roeck-us.net>
Date: Fri, 29 Aug 2025 08:56:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] hwmon: (ina238) Add ina238_config fields
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, jdelvare@suse.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
 wenliang202407@163.com, jre@pengutronix.de
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250829030512.1179998-1-chris.packham@alliedtelesis.co.nz>
 <20250829030512.1179998-4-chris.packham@alliedtelesis.co.nz>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250829030512.1179998-4-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/25 20:05, Chris Packham wrote:
> In preparation for adding INA780 support add some required fields to
> ina238_config and set the appropriate values for the existing chips.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>      Changes in v3:
>      - New. Split config struct changes from main patch
> 

We should have fields for curent_lsb, power_lsb, and energy_lsb in both
struct ina238_config and struct ina238_data, and pre-calculate the values
for chips where it is dynamic. I started writing that code, but while
writing unit test code I found that the driver has more problems similar
to the one you fixed with an earlier patch of this series. We'll have to
address that first. I hope I can find and fix those issues over the weekend.

Guenter


