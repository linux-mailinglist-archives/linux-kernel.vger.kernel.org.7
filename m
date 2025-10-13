Return-Path: <linux-kernel+bounces-850781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F03CBD3ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6A618A0109
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29149309F17;
	Mon, 13 Oct 2025 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVwmz/PI"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3C82727E2
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366834; cv=none; b=K8q29Q5K87bntpaXh0EpOjHADJmBcPnWZHmxt/73pe7RDu0LlLJW0+KBKHFJQfnj9rYCTpuotg/yhBK0mX4L9q3G+H9PjMueNmZfZ39K2kIxPW2IW7ClOcKBTuBB9e2yfAhqCtoCOBoXO2Hcz9c5vAB4DsfejBK2JmgCR0DufoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366834; c=relaxed/simple;
	bh=HGnrC3Y56b3intNHIfOuk135OVxYsXA8hRsU+xpw0as=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuJsZeG8s1tS/0zUN7ZkeccON9RA0lj5rKZ4yUCxFC8bA9OMhltVnxVYRkuxuqsfBNYed1zoAxBlBlF8UbumHAZGMYDF8pMipXP5G2+AP1csGqumoXVojwMRLRiLw7uGrcbg9pdpyYELlP/no4Ixokqq1E+jn0GAcD0sLcFv+Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVwmz/PI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-78125ed4052so5106123b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760366832; x=1760971632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iM5/e4UJAfJvXPy0LZcn9NuDbnYMTsJJoi6JFRNlh9k=;
        b=OVwmz/PIscX80IXYNsaJkVtqIyZRNdqL81N0mCCvryk9L0rCePoiPjmeUie11Gy6Z7
         g2sf6gjPFdbSbzcejc4jcVUdiWaHOkmMqT7XTG/q90m9cchzJqYDAjtUnp3pOlbqGLOs
         Wwp/LPpUKLXZGPiHVbr2XxYrwzRcLDNHhv884z0+Es6pkyD0k0py7IXDgy0cDeGkWNtj
         5kK805X13BFxoQVzCsMdJbkrXwVdlBrT3hmTrC6vx7A5HkTHikEJLOjiz8iH9G6ywVJm
         2OEZjFlqnc40QogLTkHUE4ySuNv4evX+ARZNrNDNOITABHOiCppFJODs8mCVhVFOaGCv
         MShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760366832; x=1760971632;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iM5/e4UJAfJvXPy0LZcn9NuDbnYMTsJJoi6JFRNlh9k=;
        b=aYADq41K1E9450ZS1g6rU1tLnDZLj1VM/vzLlGtB5nkJXaOf9vhT7yGCngu1yGdqMU
         4iDWFmcURJpQj91+7WHbqIMoZNm8H9jMHNAA73Drf+QKZWf1rHVEDJ6RhgDyTbYb6uYm
         0wBOjT5igclwcRlFZGxRgQ8gPVm5jKwXaTm0ppQv2MPO1COHuDs1STmzQKlDpYSXUU//
         0ULFCk3AuCoZwRGEMD3yTLRY9z/dCDFogfuVM48LPMtyv8XNZuwJa8K8wY3TYs0DxOvB
         +zo3ohTWlG4QuIT+yCez3FrbzxxngGZkuklLvLR17cmytDUwiKzCzbHDmaCY9sbPZNrG
         8ALw==
X-Forwarded-Encrypted: i=1; AJvYcCVhYbkpivRinag9USJwAGaKvSx5+3xeiXMD4IasCfVdrmGAN8fE+dbAc9RdD1F1yV9l8I6PWoWwi9TBIaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSp1HoSqBPXrg1ltJwPJov55J5o0DHqPp0s/RlXMUUBwQuZvdT
	ZCa9G3ljKD5VY7UcwH434CKXqk5sGvWZoxxNSSzmriOxUy5fWHa+unES
X-Gm-Gg: ASbGnct3VPmTPBGTdypjymLfpzoSBeeEJdpL7C66KQ6WwxNORr8ovbJZJE5NUNA+Lu3
	5d13EWIDjeZ7ugK1zBxNNjaDQVW03Gq12j8a+0EcuPc/XQLoEAThP2IWaIAfTm2KAooSvMcfdp5
	CUzznjH8xdxwqjN37V7DxesMDP5iRuulENli9omfax1LhCqF19P7bHa55PJ7lu5S4PZeNnJE/GX
	CuXjZksb5eqdbjBOM1Po9GPAcN7lcIINuUi4QXGMbh6ZTS5AjoLhluXZHUXA+EeZ6irzPzxL1vD
	C5iTtDgC2LmFJAZiGEhOxu8k+OF52rJoyq45nqBRiJMXUJcwY/AKUoBSmhEPP9XNnxatx3VBCHO
	TtXE7wcz1J+TuIPlgLRRybAGWbBCmvGa9fkrfBvDNS+i3QULhUD76Z9gq9oTYXKS4Hp33GbJTkj
	tHPTCPLKeJmC6jhx8mPNJxg1R4
X-Google-Smtp-Source: AGHT+IHPU/97MoKvW8vBm9Jrran+thU7TIazvVrMY0e9wgshgLyIvIk5asZAEFCjkaqXX2avBELD4Q==
X-Received: by 2002:a05:6a20:7fa3:b0:331:e662:c97e with SMTP id adf61e73a8af0-331e662cccbmr6834583637.37.1760366831737;
        Mon, 13 Oct 2025 07:47:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d09ace5sm11950521b3a.53.2025.10.13.07.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 07:47:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f1f5362b-16ef-4699-bec5-986de2116d83@roeck-us.net>
Date: Mon, 13 Oct 2025 07:47:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hwmon: (peci/dimmtemp) add Intel Emerald Rapids
 platform support
To: Ivan Mikhaylov <fr0st61te@gmail.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Iwona Winiarska <iwona.winiarska@intel.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20251006215321.5036-1-fr0st61te@gmail.com>
 <20251006215321.5036-3-fr0st61te@gmail.com>
 <0ede72a9-4555-4e4d-959d-3a505b6598ee@molgen.mpg.de>
 <9badd4e53ddb6166d0aa196da978bd70f61642de.camel@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <9badd4e53ddb6166d0aa196da978bd70f61642de.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 04:44, Ivan Mikhaylov wrote:
> On Tue, 2025-10-07 at 10:26 +0200, Paul Menzel wrote:
>> Dear Ivan,
>>
>>
>> Thank you for your patch.
>>
>> Am 06.10.25 um 23:53 schrieb Ivan Mikhaylov:
>>> Extend the functionality of hwmon (peci/dimmtemp) for Emerald
>>> Rapids
>>> platform.
>>>
>>> The patch has been tested on a 5S system with 16 DIMMs installed.
>>
>> What is 5S? 5 sockets? (Probably not.)
> 
> Paul, thank your for review and sorry for late reply.
> 5S - Intel 5 Series/5th Gen
> 
>>
>>> Verified read of DIMM temperature thresholds & temperature.
>>
>> Also paste the output?
>>
...
> Guenter, I saw that you already applied other two patches, need I
> resubmit series with updated info of commit for this one or just this
> one?

No. While that information is valuable as comment, I don't see value
of having it in the commit log.

Guenter


