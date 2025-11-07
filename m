Return-Path: <linux-kernel+bounces-890485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBB0C402BC
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D27E3B007B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1AF2F39A4;
	Fri,  7 Nov 2025 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgloT27L"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D29F2EC579
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523047; cv=none; b=TkApINlv+erN+WnLuEDgWbHQeafYz47IILT+/A9AQMTwDoRFl+5KcxOb1DEkKPXAd4XwPc+J3UeZ+A6sk2WvqjZXUuP407W79MnmNOyHZ7vZt3Rju+yiJUAAoGeNasSTZSUqlPD32StR0cNt6Q+GfX3c2lxZILFQq2Sahs2u1eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523047; c=relaxed/simple;
	bh=Kek2ni9K7tlXAKMV2yxnaJRcPVXhJP6mmBKqRazXcxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLfIuFqZQanUOH/V0dZ4LccYogJr3pjvhW22rUfOurI3vYe/y2lPxDbFQ7cg2yYWwGKkYR79w/kTh164tzbXpECjyn5Kqa0oceQ28iyqzAG5J7H5ffmWPNTqAMKG1AuL77zthzuaDIEV192DE7t5MCVwXgeahjlW44RiiHewLSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgloT27L; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-290aaff555eso6766415ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762523044; x=1763127844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T51sKGmzO5ESwXBqJuoshtIPtbH/U8t3k8P6xn6hgWk=;
        b=fgloT27LOWI0lrnwCSZ+TPo2ysIgzhsaJe7atO6MROOjr8STMdpBxA6hROblRwatJ1
         PzATAik3H8QnSO3I7nLYMRQFZ6OrlP5PHC2LUBqj8YBGPgMu+QSOvUKZkWlDc0eZI+Eu
         yAeXuoKv3zoibimpL6mBZMbOloF6dqLKNFeQCaA6291WUxD4iMe66JiO1XYm6czim2kq
         jTFv4Y7Cx3rBTim5W/GElrvU1eD7hrix7CX+QSSi3T9tyRZSyBgEsSeLXD3q5ESO4Wmx
         5brnhV/GAFs1TUyPJoCzoi0rG+dIt5fMt1FTqsvZRsAURbhYQfFxiKkSx9nhBD5OXhAt
         9lWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762523044; x=1763127844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T51sKGmzO5ESwXBqJuoshtIPtbH/U8t3k8P6xn6hgWk=;
        b=wKcRQxTYY8W0jQw0EbbJK6lTI0Zf+9Z7FI2DUbN6lj31a8HJSijPckKy7gD9oe4BDb
         jt36mIkM+SyiPDpDBCEgMIFhB0JRHQ1hNFvbwkqvG68+DeV01pVuublZKDRsqAJ2JFEt
         R1YHyRuSLvTM906omfV9k8SPMDygnRAVQEVXaU4V57sCAkAOjyr9xZgVY/F/d53x60OZ
         3M8qSMMeTfL1DcDLvBWxVn8RrEOvvv08uBR51Ng+wJSq1sy/Cu6NQfdbchtxE3rPWqCO
         Ebxkgjz55pzA8NrG5si2snHgxM5jo0i5G1bfEgjeGMDGvYOOmM/BpB3lIefOl10PMXjW
         qfgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS4x6DAI9LEFHvF+C89FzUeKERc58OylVFZEYwaojgWyPjaSjRKnDO6Eei6wpISDXvADe3dCqxTQbFBKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT9JMGrXql1vT6TP45Bb4nUrrUgzODb6wTKmh9UxcX0QE1tmQd
	V2CMfvp3Vw534NwEx+QNpgObTK+fCWuGNEc8nTEAdt8HdvQWvwS7O4dN
X-Gm-Gg: ASbGncsPz3s8MR8Y8D7BrC5NIWQUKl03pXs4RuFREnH17SBXxW9hvD4wWieRqZEsJYg
	6zsrjbL2iyWJGTVO33BfI92kf8ls7NR/f4tKYmj/KJlZPXHD5Y44WLnxh2kJZQz3f9s9kmyv7p4
	cz7KT9WrWPkUuOixcx3LpVusjhDpWsPc+2zWqbTJRYiOBFWBSL84Vu+VAQXNQbomedpVXs2t11A
	URrAJVHXgj/P0yFum1q4+uQYkAhoxfgez8ZTwJP+4D06RHmNwfqt9HZHJRGV9vxiPQtFoOII4K0
	Zq8tQgjFJ37B3tOPH9L7Nwcg6M150QrKsIjfYliliwG5s3M/M1vsNeBA5whsf6bLVdG7DeRTNUq
	R1zydZoYtfWRvJMmb0SAhy8A6ph9HxAP4QChSF2OtBzKfgdSNyLqkplSDuQ/YvRRlm/m0YDEppf
	/k/Z7csctcP5eb+HXQfHzeA6y1fp3BBc0i0/DpgTTT2UDswyeInaLCxXZv7V2MAztnVHrYRIVya
	jsNV59w6glcbyD1cCNwGQuRC3K/mc7/HdxKdoQLQpg99UBtlf+kvwCuAFb0LJp2zlieo2TuXYZ8
	H2lRQZNK
X-Google-Smtp-Source: AGHT+IEQTc9ird2Of3/UqLYc19J1u7EOVDH6cqhobpLuQc6M3Vc5JPZ+PlHeMA3ePxLyPNMmC8Ej7w==
X-Received: by 2002:a17:903:287:b0:292:dca8:c140 with SMTP id d9443c01a7336-297c047a762mr40598415ad.44.1762523043769;
        Fri, 07 Nov 2025 05:44:03 -0800 (PST)
Received: from ?IPV6:2402:e280:21d3:2:b586:93ae:6db3:2abb? ([2402:e280:21d3:2:b586:93ae:6db3:2abb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296509683easm61055775ad.15.2025.11.07.05.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 05:44:03 -0800 (PST)
Message-ID: <8ab11fa8-defa-47f5-a9cb-e3e95b5b32ca@gmail.com>
Date: Fri, 7 Nov 2025 19:13:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] MAINTAINERS: Add entry for TI ADS1120 ADC driver
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
 <20251030163411.236672-4-ajithanandhan0406@gmail.com>
 <20251030175510.00005af8@huawei.com>
Content-Language: en-US
From: Ajith Anandhan <ajithanandhan0406@gmail.com>
In-Reply-To: <20251030175510.00005af8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 11:25 PM, Jonathan Cameron wrote:
> On Thu, 30 Oct 2025 22:04:11 +0530
> Ajith Anandhan <ajithanandhan0406@gmail.com> wrote:
>
>> Add a new MAINTAINERS entry for the Texas Instruments ADS1120
>> ADC driver and its device tree binding.
> blank line before tag block.
Noted.
>> Signed-off-by: Ajith Anandhan <ajithanandhan0406@gmail.com>
> Just bring this in along with the code, it doesn't need a separate
> commit.
>
> Thanks,
>
> Jonathan

I will add along with the code.

>> ---
>>   MAINTAINERS | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3da2c26a7..1efe88fc9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -25613,6 +25613,13 @@ S:	Maintained
>>   F:	Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
>>   F:	drivers/iio/adc/ti-ads1119.c
>>   
>> +TI ADS1120 ADC DRIVER
>> +M:	Ajith Anandhan <ajithanandhan0406@gmail.com>
>> +L:	linux-iio@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
>> +F:	drivers/iio/adc/ti-ads1120.c
>> +
>>   TI ADS7924 ADC DRIVER
>>   M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>   L:	linux-iio@vger.kernel.org



