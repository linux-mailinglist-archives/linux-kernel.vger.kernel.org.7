Return-Path: <linux-kernel+bounces-830883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E90FB9AC84
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06DE2A289E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6993128C9;
	Wed, 24 Sep 2025 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN7U/AVW"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67B11311AC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758729343; cv=none; b=bsnLVFXWxzMmMqMjzvx5ysrEbnEaR7679HTxNVIZbn/MXz1h7yoXuhOlGkTri5sbaI6JNMQJ8waaxnXLVZodzUSEkyUeajFdQkXrI9c0X/Y4zD1Ruvxa12tWkn//mwogcM/PZqWCyc/TqETGvXmhbPcOzJIiX/QOlDdJyDiQ/Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758729343; c=relaxed/simple;
	bh=zJ7d8s1rwiyu/J8jcfkv+3+IBbAvrY+XyNKu2L48AY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEFY/kzTgeGsT252wIK07SR2FXf61I60l+kV+daqLdGxweJHOXlAhMhbPVBABQyiVWQz2rqvq32cTOXcpshWrM5dzWfsMokZcmZ8ZspMGGaBGrQehdF+aB/FJEDn0cVXuLcKfv6LIGJCZ7DexqV/7WMoWb36/jfSCRtKjDeAKFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gN7U/AVW; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b5515eaefceso5482172a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758729341; x=1759334141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MJG+A4b4XGXvAmd5Cy9/fRi1nZfal1btirOi0rjtmwE=;
        b=gN7U/AVW06C95IwAEwISbRHUjlkCMrktpGGlaqX076k7gRZ053ykfpluxH7DdZ2VrV
         WRPFHuYpFe5ACEq+58X7wgqdIT36zj3/D6pUYUbJbSiGL7lKjTrTQa+Mvt+Otfn17Ov8
         AcrqY79ueEDdXEbD6cFLXsWfgsPIhElnZxsOsF8DT+WUCDSizKa2CKTLA0F0IuDlknu2
         Qjcqs25alYoOga0aWJEe8D/T2DP0XJH4kkDEEpEeDUiJizTem5V0fY2dOoOOBO+04p4g
         xREfiqIvF2aEBSlj/slKpU/2vRd0U8UCZNM8PF1b6NJwQgYyNguwTdyE3XN0WvHEc3JO
         j7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758729341; x=1759334141;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJG+A4b4XGXvAmd5Cy9/fRi1nZfal1btirOi0rjtmwE=;
        b=qbDImIRdyv6KRrvrGFVjjyAW1xnssEP/UG3izk7HostjIqJwGysbJZQ+Ou+eWELeWl
         +clT5594AsgMv9Unhh2wLFAZEg65GfeAQ7awiDfywmyp8Zs30CqltH78kJcfnOCf7NV8
         1DyA9XMtqFHFvY41rHUZkX0PYMq6gVKAmhshTlibMYXSuAwjbKZhT836mTmJt/rnryWv
         nvDWV1fe9zwhru7aivhVf37lqYZZweTprlB8EKNgvf/V2fnHrCGQiWZwUAZEOZezNFIP
         VE/dNLHO3c3w7N0bqaY3DGjShP8QKu56uMnAZ4b3ilhgcEbp8k+7pOeEqxfJzGII1Dwb
         LT8A==
X-Forwarded-Encrypted: i=1; AJvYcCUDgWKUeP30oNtfsPZtkoJPkTJtXTOWnj34zzvSfmWxnwHk74x1z1T2/1ZmG6H4uXWh815vyfOrhi1naP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXChMc60+PbBtx0jsPDVLmJ29GkmOA0MW9yYz/P5RfERZcjYyE
	wN8xu0MRkLmnwrIWC/PcDflW6cClh+XkoudT4B7zdip02gWMC7zjUtsH
X-Gm-Gg: ASbGncsNaNPqBhz8PjcN3Yj9FwfDGzMncZeDRLEq/wXcNY8yz10yxftpO16KpdxoADb
	lKCXsSunX63zR8vAwQXSXPcVKOLxEjeet/l51ne9cwNnQcKAjepsswVEYl77ixOaHLqhpSiTZ8r
	yzjsZr1EzGIoFwhHzvvmBTEDc021G0oqBPmAW6VMKkOGkvgbaUYTvdLOwwS+Tdlll3bcqWmfTXB
	Dr6JJ/2mvkg3Syldgoh6u8cE4p7Hc//JXY5DHJNybAlqwfSCFKLFMI9AfrF1rzMb8fxjPw0YddP
	l3J2fAm/Uag6Hw+ij8j5j7GFvvKMqi4VZVnHMJagjt5weSWgS6AyC+ZsTm0ZyJTLIjHctHDOJvU
	jEGRfo5yF3OliGppEeuNvZ5dnkWZ4LHf3LIOtVh8zl32k/QbwLTwO1E1L7SVKCS9fwQgANm+thB
	sxecPwiA==
X-Google-Smtp-Source: AGHT+IHioNe2Al0isElzk/+bpyel9roE9gkAZO5Kg57mbX7Nlk09CM1bUoJw20y8xkQ6QsAIHRC2fQ==
X-Received: by 2002:a17:90b:384d:b0:32e:64ca:e84a with SMTP id 98e67ed59e1d1-3342a2436b8mr312606a91.12.1758729340986;
        Wed, 24 Sep 2025 08:55:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bdd6befsm2778606a91.27.2025.09.24.08.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 08:55:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5162f7ae-b822-40fc-a966-c7684e5c0997@roeck-us.net>
Date: Wed, 24 Sep 2025 08:55:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: tmp102: Add TMP110 and TMP113
 devices
To: Conor Dooley <conor@kernel.org>, Flaviu Nistor <flaviu.nistor@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250915170819.126668-1-flaviu.nistor@gmail.com>
 <20250915-undefined-woozy-15e27ca89a36@spud>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250915-undefined-woozy-15e27ca89a36@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/25 10:18, Conor Dooley wrote:
> On Mon, Sep 15, 2025 at 08:08:18PM +0300, Flaviu Nistor wrote:
>> Add a compatible string for TMP110 and TMP113 devices.
>>
>> Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
>> ---
>>   Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
>> index 96b2e4969f78..840b5306a8cf 100644
>> --- a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
>> @@ -13,6 +13,8 @@ properties:
>>     compatible:
>>       enum:
>>         - ti,tmp102
>> +      - ti,tmp110
>> +      - ti,tmp113
> 
> The driver has no match data and no compatible based decisions added in
> your patch. Why is a fallback to tmp102 not suitable?
> 

That should work for tmp110. However, tmp113 does have additional registers, and it
might be desirable to report the content of those using debugfs. Fallback for that chip
would work for now, but that might have to change later if support for the additional
registers is added to the driver.

Guenter

>>   
>>     interrupts:
>>       maxItems: 1
>> -- 
>> 2.43.0
>>


