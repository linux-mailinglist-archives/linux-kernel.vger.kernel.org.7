Return-Path: <linux-kernel+bounces-752130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27599B17192
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18383A81E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592B02C08D4;
	Thu, 31 Jul 2025 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/IY73U0"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5DD1E50E;
	Thu, 31 Jul 2025 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753966439; cv=none; b=gkk4mrwNcL9ccBfRFOPmXHprU9BVI34p0KAetU0z8w0/T/2ay6jDvGT1pKO4rzjmMSVv6EIaVa0Xxf8l+ScCNSFiNnyWA2uoHa5U3PaGrza574uLSLEaqioiEhFcRwFdJyGJ2haGj1AMDhyr1MNXCNXIi0WjA/ejbZgT1OfvMrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753966439; c=relaxed/simple;
	bh=7aXWAT7rQkXajWXwVRLeSTFpKLGU5JzqwY7ReVGiZHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLjFbhwRfgEA6NMKosUiup1roy5u2XvZSvTgnCQ93EneuBM4S1X/OGEMHNKhIERkiESiA33o0hQHkyXZYfh67Y/+y6dAVviqSSzxOlv4rdjPJCBBCJmBLpQL8BFdrHYxPt4XAGkhq5zo2HfetQH6DLVopWpCk9towV4OiVHUpkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/IY73U0; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso751981b3a.0;
        Thu, 31 Jul 2025 05:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753966437; x=1754571237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Dn5Lwte6H7TyG8Q0qTy73zpbidukaid/l+ZS8OTsom0=;
        b=E/IY73U0Z2jbLrIjc0MV5A1iCTiQo19R8q7BgMOy2e3csSlxyskxJLbI0QL1kmzLUz
         13GpfQlBs/5ZjUXJtj8TbuYQS8HPMqaWoehE1bt8doLCN6fk6RgkizHyqAls/td5SdIu
         +HPZEqNpxN9DdJP89lseAJ6eLdQ98NkPBmAR+lwAM4A254E7wtjhUUBxpBb3d6kD0cN8
         ok5Y4Q7TOHzG3U0f1t9CJ/w8qME9VG6OCAaidcwxt/GMekHvWo/nsINfSuc3/tsVtzUD
         QNg5+7mdvQK9T9qph07GU2YGj4k9pqfAM0pv29WGxvJliLdWq4tFhLvxwI0baUNsjV+2
         9h9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753966437; x=1754571237;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dn5Lwte6H7TyG8Q0qTy73zpbidukaid/l+ZS8OTsom0=;
        b=FJZhNSrf2ARG+VjXadwCIvNo35Sp17AQHDsMDnqF2BnD5+SAxZm0LY/8gXTVCKqoTh
         ZYDqj3M5BHEbHWwWO1C5q+nHwW1LDfVu+i9jqFeJuIsHIFI+3qFG4omKh0NVhzI7sYGe
         VJyQQ8FUhrzxsxF5Q6QjwGF1ZJ6pXfG4dXMtbakIEvBsrN26pbUIWX84CfdbaSDDL8Qk
         zzlKskfJsYTBIiOgolX84py61p/zQZ5+/to+rkaaUArNGgH0ByhGDnfwck/Ue7TOQoQI
         f9sQ5r3VVaOjodPuI1upPEkTjOKUJAkIct0JTLWmMIZmGOUe+2dylQm77dO5kfIH5O1v
         br9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSlE+l6iK9sybF6Q5Ua/lMq0ybwYhYTzWMQnGVKXVc2XJJmUgxDCj5FgJTddJYV9d7d2n1ItMjEzVGB+g=@vger.kernel.org, AJvYcCUfplPimcUbtXrHZ4KYSmS7QHEHvNlWYqhEcTQrD7WYKuZ4VdfvJ4WtvlwwUsGyyoqlAUKw+I0EH/s=@vger.kernel.org, AJvYcCXbr0AnEfIOghj2IaZiPdzDcBTvbPSkH5FsH7pDLExhA6WGv8/YjZkseXLvh4zSyB1A38tbddCx+P43xSF0@vger.kernel.org
X-Gm-Message-State: AOJu0YxqhgbZiyQeymhJmqEMxovzV1ew0uIJxG3XBsUbDqiY38zWfhAN
	zd7nAlU46P+fjNWoTXH96+rUK0MLwT7zcoy6HplB7gU8mztCeJsKCPCU
X-Gm-Gg: ASbGncuQXmUovrk+oP/6eOXmHy328nohbZa1XiSGd/FxAQ6AQV9fwdQx/+peEuQhReE
	vqNhv5q8vbdhBYhfPOhPoehArYSvEx510fAOSMGfrp9jSyJMTqoL1E2uGAArTTZsylr4IN3nded
	5kk6rOx5crgcL/v8RCz2cFTfn4cVQf90EFOakR7Mlwg42KKMxeorft59IwSzDHT4zCbEATXz/kV
	Nq4bY/SzSFpWzm6xDfK5pyjofvJvcOAQBYqLAmIIbWqj0Kn3aogmQPAVAzyMT5vcvzq6WiWnDHe
	AODjhVlhidTQPbe1MkVZoHWhfKvMZZmji+2o1Zk4A8iUohxxV8qxu9sAV4MtO1FctA/u+sHHrdL
	CpbVW35demQx/LaD7OCsNzTwBPaet/Yv5bU6gZTdW5bW7UPSp1OKZA1W30oWnT33RjZvKkmBAyi
	MjtyXmjg==
X-Google-Smtp-Source: AGHT+IG3Y+nl84TkVSnB6RRZ2m3AdecVRsNV4nibojfysudORjk4Lbsi7ormo+11RhbR7TAGUkBu0g==
X-Received: by 2002:a05:6a00:b88:b0:74e:a9c0:9b5c with SMTP id d2e1a72fcca58-76ab293839fmr11517260b3a.13.1753966436941;
        Thu, 31 Jul 2025 05:53:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfed320sm1566680b3a.132.2025.07.31.05.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 05:53:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <05539224-6207-4dfa-a4e2-99947ec1fc62@roeck-us.net>
Date: Thu, 31 Jul 2025 05:53:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] hwmon: add GPD devices sensor driver
To: Antheas Kapenekakis <lkml@antheas.dev>,
 Cryolitia PukNgae <liziyao@uniontech.com>
Cc: Cryolitia@gmail.com, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 Celeste Liu <CoelacanthusHex@gmail.com>, Yao Zi <ziyao@disroot.org>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>,
 someone5678 <someone5678.dev@gmail.com>,
 Justin Weiss <justin@justinweiss.com>, command_block <mtf@ik.me>
References: <20250314-gpd_fan-v6-0-1dc992050e42@gmail.com>
 <20250314-gpd_fan-v6-1-1dc992050e42@gmail.com>
 <CAGwozwENLOOS5q1Bs5SEh3FFJAY-=kcVimf5U+tWzy6HaiGd=g@mail.gmail.com>
 <bb57fe1d-fde9-45f8-9f5c-0836a6e557ff@roeck-us.net>
 <CAGwozwGdZ5tzHg7_TF5d_AWVDmypP987XS-x_GWqrSF81PiG2Q@mail.gmail.com>
 <B751D49737DD10DC+00a0ff95-476a-4d0a-9bc6-40e77012a554@uniontech.com>
 <d4b6932f-fe95-4502-b7c9-650a61ab565d@roeck-us.net>
 <4CFDED845BBB7FFB+10019dea-8229-4681-9beb-5f351eb8faf4@uniontech.com>
 <CAGwozwG13swYjCB6_Wm2h8a2CdHxam+2y=g1m42pynkKqqdDLg@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAGwozwG13swYjCB6_Wm2h8a2CdHxam+2y=g1m42pynkKqqdDLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/25 01:13, Antheas Kapenekakis wrote:
> On Thu, 31 Jul 2025 at 05:30, Cryolitia PukNgae <liziyao@uniontech.com> wrote:
>>
>> Personally, I'd prefer to maintain this small driver in the hwmon
>> subsystem until we need to write drivers for the same EC with more
>> diverse subsystem functionality. We can then discuss and learn how to
>> evolve it. I personally don't think that's going to happen in the near
>> future.
>>
>> So, could we continue reviewing the current patch series? Where are we
>> stuck?
> 
> Either is fine by me. The move is simply a rename anyway. My reasoning
> was it will take a bit of back and forth to get approved and charge
> limiting is a standard feature now on all manufacturers except GPD, so
> I expect them to add it soon. But since it is a rename, it is not a
> blocker for reviewing in any case.
> 

It is moving code from one maintainer domain to another. That is like moving
from one country to another. It is not "just" a rename.

Guenter


