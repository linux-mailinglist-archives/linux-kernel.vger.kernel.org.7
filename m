Return-Path: <linux-kernel+bounces-896098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40499C4FA43
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39F7E4EC65F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0D636B049;
	Tue, 11 Nov 2025 19:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="ZVAnmryA"
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com [209.85.166.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97063559EE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890433; cv=none; b=AsahytnG62TocDZheXSxtKInRqjXUyc7NqvTOstn9IcNsrrTXNX6M0DGd2uFKBmKd4y9iqU/IXmuJhmQNzmYgILFZxLLBqIQER8u8xPJ7JAA/Divo8EDRVgON2KgNEaHnitqWxicD3XtBrEjYZ/iicYd6iZDnVCG1ZsYQJrKEbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890433; c=relaxed/simple;
	bh=ZrW+cL6/6u+Ohf+JzfSVkT6ZAGlURKmwD1lBTmPGJbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJP/EfspYqIQnNXrCFAkfShauYoNydt/MofuMocxPQg8aLAo7JkQOVj4HR8QrI01EbiFogR4DJ2iNMKIVb7HRC0yzEZMpDVBvFWH/fj5Ro6rr+e29MfPFgiDu+WrqMD9wJUU4NDHkngIdeUCnKzbaJU5D4JctmtFRqRga8wXLgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=ZVAnmryA; arc=none smtp.client-ip=209.85.166.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-il1-f196.google.com with SMTP id e9e14a558f8ab-433100c59dcso261705ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1762890431; x=1763495231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZvmJ8eLa//4NsRGRjplCnKOxzOcbE/faHx1blTowx+I=;
        b=ZVAnmryA8lNKlA8piHWG8uDrFckx9DeiFss3vLKMZ/OSY7zND0NdeCa+tounEqB2Nl
         E7G39J1nY8HnKmUEZGJfi4XvIuhbVDQJ4HVjz1ac8T/VwQeJ2aQg6h1+eR8a1MJeyjLd
         PLH16pIVZUodd3NX7pXzHs0tueAzKCoCocKsE1Tlpj3JrBnAzrkvZYJV2Col48cTDq5H
         YZ+P2bndrkdf2EMlLa253ETE6Zv9l/gDCV5pfwGaMhgM90yTPYLtNfagbLWCoPhVahD+
         2A/ZxVApqxZXjnYu+tuQCJmm9+p5U4uDhbee/wFLvqZn0hkkl40mLIgjX+xi/o8DH/mb
         +aKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890431; x=1763495231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZvmJ8eLa//4NsRGRjplCnKOxzOcbE/faHx1blTowx+I=;
        b=VLlOI6PKweomNOIS8TUa8yqjpnhuvdl/OkCX3ycL1VscPF3n2xyu7PprC7qHSuQIYM
         TiAWWr4efDhOzkwyLVgJrDZBgcQUCS32SY1qf9TWWBUVsymLQN8QsDJORBS4DmOL+GWg
         J1cQPg9BJpyae8fJug5qSJI9Gay9fts4ea1YbKcnyE8l109beExyVaId6KU6T8A90n/f
         N4LM2h3LBn6yPe40/2bI0yaI1e/zI/kYqd1hX2urDnL7ZEKf6/PDYisn7F6w/k4MQPv6
         r7Mhhdy/L6udWfyMQvFI0s86dlfqR2EIzAojS8p33EdUoDVyqsXUsGCFhY0QzDP9rFt0
         L9NA==
X-Forwarded-Encrypted: i=1; AJvYcCUEdf9eM5rCQDm/Rkc6UzU+knM5q4yk552k9EAzm6P30p+xs0i0SsHrQKXGQBzTZ7kmkqyScsNd12Cr2eA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGhFiFPqio//3B11EVGs1Is5NCkf6ox2InZvjZtDpYhzI/ePDD
	bWiL2eBJ8PfijaOuNKk6IM1gahjay3pBESKDQIq17dBSiWO32UXBNaK//Sa4Tnn5R5c=
X-Gm-Gg: ASbGncvy7z25FXKVwAnjPl7EEadqxZBgUUNxAebGI0DEibJKGAbG15oazafnyCU4KhF
	Yyxqf8+MdQIAlat0utJx6mx5R+jeixUTEBHzeqjsUP1/7MRepubRfZ1RALYjHkX26P2eoB5r6KO
	IPs8DtkC7ZJiZcEmVaBMctFSyUhgtipllR/CGemQ+0e9avs/MRLGAkeMZwoTHjR4wBI7oXNn1o4
	uPbQs0KBt7X/anozzVy029OXBVjXkM6mhSfiD2hoXHrCaUDHS4Dzg/bgxvOOyFH3tNelZXM128+
	TiwiX8HUQdkfDHQEk2KRB/ScO+pWS5fqi63Zuw+sp0ehz0mgd7gwttj2/ukVmn5gKfQYqD80IOJ
	+qsKSxROiTEv+9Kkd1qcx2JfMOjEhp7iZL7cF8IDtRmzFGjwU6HvnjRhhW/1f8HyfBZq3PG+N/a
	A2XRY0+mXzg5A3fjI=
X-Google-Smtp-Source: AGHT+IEFzUXrbqx24P+kXe5zMwKwFMHqOAgKW6mk9ecTAQgOVV1SJVteL9W3Xh6SnyVk+zsjwHpNnQ==
X-Received: by 2002:a05:6e02:304a:b0:433:551d:5f2c with SMTP id e9e14a558f8ab-43473db30f7mr5000705ab.29.1762890431000;
        Tue, 11 Nov 2025 11:47:11 -0800 (PST)
Received: from [192.168.5.95] ([174.97.1.113])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4347338d54esm2244295ab.22.2025.11.11.11.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 11:47:09 -0800 (PST)
Message-ID: <07d63659-72b1-43d0-9139-2a0b6d73edd4@sladewatkins.com>
Date: Tue, 11 Nov 2025 14:47:06 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/565] 6.12.58-rc1 review
To: Shuah Khan <skhan@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251111004526.816196597@linuxfoundation.org>
 <641427c7-0069-4bee-8e6a-53347654a926@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <sr@sladewatkins.com>
In-Reply-To: <641427c7-0069-4bee-8e6a-53347654a926@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/2025 1:00 PM, Shuah Khan wrote:
> I am seeing a build failure on my system - the following
> commit could be the reason.
> 
>>
>> Heiner Kallweit <hkallweit1@gmail.com>
>>      net: phy: fix phy_disable_eee
>>

Hey Shuah,

Just to save you some time, this patch was already dropped from 
6.12.58-rc2! :)

rc2: 
https://lore.kernel.org/stable/20251111012348.571643096@linuxfoundation.org/

> drivers/net/phy/phy_device.c: In function ‘phy_disable_eee’:
> drivers/net/phy/phy_device.c:3061:29: error: passing argument 1 of 
> ‘linkmode_fill’ makes pointer from integer without a cast [-Wint- 
> conversion]
>   3061 |         linkmode_fill(phydev->eee_broken_modes);
>        |                       ~~~~~~^~~~~~~~~~~~~~~~~~
>        |                             |
>        |                             u32 {aka unsigned int}
> 
> I will go build it without this and update you.
> 
> thanks,
> -- Shuah
> 

Best,
Slade

