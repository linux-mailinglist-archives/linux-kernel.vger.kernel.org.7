Return-Path: <linux-kernel+bounces-853704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9DEBDC5EF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D989318A0D65
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638F12C1589;
	Wed, 15 Oct 2025 03:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5It1908"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF082BE058
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760499699; cv=none; b=I0fwJg1hEyULMtFPz3JDX3WM2p2QTO5tzoP9N3XgRvOs2Z6sgQrOTdY/2JwmJTD2DM2BjCUZ/FkOTMaS27Vj/ZYA2nIggIBtXiaQsikjce0U7g1zlKlZ6ON9lk6fcItWRjYIx84mbNUPzjWXYISn61OEYhfMV65t3rjHGsKDqWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760499699; c=relaxed/simple;
	bh=TrAh6XXzubQKGx2ry27K63dQXap0M8qsrq298w0KoU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJzWcXvdaXSvJ0UiZk1YMC2Nljfx22UO20nwf6nwHvJe87z0YrAdDbD1Tfq6rE4mN/KuNu4t6WeQJ9w9Gu2OZ74J/E2xhzotOkilRxNC/k7b3EMlT5zD1uNu0PnWgzpmpjvJTLvdWpITa/vAim12MzYed70S+jsTViueicUyuoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5It1908; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-781997d195aso4364851b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760499697; x=1761104497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8Nztukcp1v3hHssSP+lOA5gx/9eDa/BVjXlVhsEljyY=;
        b=C5It1908ehru6BU8ZgTj8PM6tTNqH5yOBg1/S1139CMjhXTLbOw+NyKIV4gE7yTsiM
         GiXSZHROEOMgw9Z0l4P9RQ9mYr4cZyITtOhVOeYnXyDAWxJ9bKznM+Pv8WfgfFqdceE5
         VGKMJr2+5MNF1UhAGaeEVa92W4E+Tr6dl/rh3K9PTk/OWLOqCTIALF/npV8yCXH1vXe2
         MiCmouu+cef4csh98u50+vDvhuDY41hVZGpc026P4KaEDbnycHBfjLdSxIaGr9kRHDGT
         Mt1u55Fo2Ov53Ooh5yha1WVwpQoyg+9CeR4wJmcNyYpHn3gIaZkrT0hz9i8UE4jE5pDH
         mSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760499697; x=1761104497;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Nztukcp1v3hHssSP+lOA5gx/9eDa/BVjXlVhsEljyY=;
        b=hpNVXaoj1l4kJqTmSJc/dGVB2fZZDjG/Nh+02q5Uo7rPLijDlr5Iy20Oe6B7RsFDNR
         dTWPk2KJgMdFtbfVaBjoUw0+KL2IRNGOGZBfhORVlCJ8kMTikjgiqDs7CoScNWtig64o
         Dl/Sgf2+VL9AefOSuNqpkKOF+FXpr4YwCtnv9NOMeWckXjdW1rdU5DDuxCnjhkXPgrCx
         IioyEkgXTn0JBemInNjKfBq9b4mx2CSQ86XKwAA6EIkKDjMFTMIVYZTn1YtC0cz0jFP3
         LCTlw412yBDC9qqlYgkL5UA0LUa+XtUORXco8pHLAVZgLmo9Lxg/NQJafloG105fjZbn
         qLOg==
X-Gm-Message-State: AOJu0YzmyHhQ8YYYm3jb7sKN6YNvZyi6Jz9q6bwb6xIHw6YhSBa1bI5J
	KCWsAWL0gv2tJn8gIG0K3biAgrz+Av2KnLETaiBgveAzJLnIcD0W5aoGXtUBrQ==
X-Gm-Gg: ASbGnctyse3zvDBTGOaNfsm+G8dK1Szt9T6CWNMNQe58mafwaZGws+bKh7OCTcmhiuB
	4+jDDcfflWhNETre2CfhG+XY2gMsemySTyGe8zN6ACUCCkX7QeMtx4v9iVWkMSvGwzHtyeBpVdn
	ft5GYVwv7YxmYz65TB7owHa3LdG+dU+MaPQaPH6iFP6Xnt5Vi/GQ8Y609SyoBFq///GergTUb6l
	YFKlG+3vO9Ga6iX/e5Xr+zERBGEGAhQ+fa1dXo+WzimQAGxO1V2Z5SmFleovxW3+FZJ0Iv5NMqu
	UDCeLk0jAP8CKA19L4tVbstahKsw5f3iVAWVf+oygL/LVvVHvMzBZ3dkCk+rbHKlVENp74SWvui
	u8f8pbgNZ+zpVT4ha9i/m/tcWK21165Q0/rTgvAT7IJ23T1jqVzvmQ7AIhARguEJlyA9apdknUP
	3eQNCvuv69OudxGQ==
X-Google-Smtp-Source: AGHT+IGoflWMNeJm/XP+K4xWlSxtwBt7sPUurd75qJvU8jTpNGVuc7OBRTVjz2MXHR1Wj2R3Hhx5cA==
X-Received: by 2002:a05:6a20:939e:b0:319:75fe:783 with SMTP id adf61e73a8af0-32da81f2adbmr32543611637.27.1760499696677;
        Tue, 14 Oct 2025 20:41:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bc13674sm16803201b3a.36.2025.10.14.20.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 20:41:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7952e8d5-173c-45bf-9aae-9a0d54ace912@roeck-us.net>
Date: Tue, 14 Oct 2025 20:41:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Use CONFIG_EXT4_FS instead of CONFIG_EXT3_FS in all of
 the defconfigs
To: Theodore Ts'o <tytso@mit.edu>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Developers List <linux-kernel@vger.kernel.org>
References: <20251014020604.684591-1-tytso@mit.edu>
 <CAHk-=wi52OZ642dxY=zdW+-nAY_KWtjsFs0mkAzzq74f65Da7w@mail.gmail.com>
 <20251015013643.GC721110@mit.edu>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAmgrMyQFCSbODQkACgkQyx8mb86fmYGcWRAA
 oRwrk7V8fULqnGGpBIjp7pvR187Yzx+lhMGUHuM5H56TFEqeVwCMLWB2x1YRolYbY4MEFlQg
 VUFcfeW0OknSr1s6wtrtQm0gdkolM8OcCL9ptTHOg1mmXa4YpW8QJiL0AVtbpE9BroeWGl9v
 2TGILPm9mVp+GmMQgkNeCS7Jonq5f5pDUGumAMguWzMFEg+Imt9wr2YA7aGen7KPSqJeQPpj
 onPKhu7O/KJKkuC50ylxizHzmGx+IUSmOZxN950pZUFvVZH9CwhAAl+NYUtcF5ry/uSYG2U7
 DCvpzqOryJRemKN63qt1bjF6cltsXwxjKOw6CvdjJYA3n6xCWLuJ6yk6CAy1Ukh545NhgBAs
 rGGVkl6TUBi0ixL3EF3RWLa9IMDcHN32r7OBhw6vbul8HqyTFZWY2ksTvlTl+qG3zV6AJuzT
 WdXmbcKN+TdhO5XlxVlbZoCm7ViBj1+PvIFQZCnLAhqSd/DJlhaq8fFXx1dCUPgQDcD+wo65
 qulV/NijfU8bzFfEPgYP/3LP+BSAyFs33y/mdP8kbMxSCjnLEhimQMrSSo/To1Gxp5C97fw5
 3m1CaMILGKCmfI1B8iA8zd8ib7t1Rg0qCwcAnvsM36SkrID32GfFbv873bNskJCHAISK3Xkz
 qo7IYZmjk/IJGbsiGzxUhvicwkgKE9r7a1rOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAmgrMyQFCSbODQkACgkQyx8mb86fmYHlgg/9
 H5JeDmB4jsreE9Bn621wZk7NMzxy9STxiVKSh8Mq4pb+IDu1RU2iLyetCY1TiJlcxnE362kj
 njrfAdqyPteHM+LU59NtEbGwrfcXdQoh4XdMuPA5ADetPLma3YiRa3VsVkLwpnR7ilgwQw6u
 dycEaOxQ7LUXCs0JaGVVP25Z2hMkHBwx6BlW6EZLNgzGI2rswSZ7SKcsBd1IRHVf0miwIFYy
 j/UEfAFNW+tbtKPNn3xZTLs3quQN7GdYLh+J0XxITpBZaFOpwEKV+VS36pSLnNl0T5wm0E/y
 scPJ0OVY7ly5Vm1nnoH4licaU5Y1nSkFR/j2douI5P7Cj687WuNMC6CcFd6j72kRfxklOqXw
 zvy+2NEcXyziiLXp84130yxAKXfluax9sZhhrhKT6VrD45S6N3HxJpXQ/RY/EX35neH2/F7B
 RgSloce2+zWfpELyS1qRkCUTt1tlGV2p+y2BPfXzrHn2vxvbhEn1QpQ6t+85FKN8YEhJEygJ
 F0WaMvQMNrk9UAUziVcUkLU52NS9SXqpVg8vgrO0JKx97IXFPcNh0DWsSj/0Y8HO/RDkGXYn
 FDMj7fZSPKyPQPmEHg+W/KzxSSfdgWIHF2QaQ0b2q1wOSec4Rti52ohmNSY+KNIW/zODhugJ
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251015013643.GC721110@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/25 18:36, Theodore Ts'o wrote:
> On Tue, Oct 14, 2025 at 02:37:36PM -0700, Linus Torvalds wrote:
>> On Mon, 13 Oct 2025 at 19:06, Theodore Ts'o <tytso@mit.edu> wrote:
>>>
>>> Commit d6ace46c82fd ("ext4: remove obsolete EXT3 config options")
>>> removed the obsolete EXT3_CONFIG options, since it had been over a
>>> decade since fs/ext3 had been removed.
>>
>> Just checking: did you expect me to apply this directly, or was this
>> more of a "FYI" and it's in your tree and I should be expecting it as
>> a pull request?
> 
> It's an FYI, and so Guenter could unbreak his defconfig testing.  I
> was waiting for my regression tests to complete before sending you a
> pull request.  Those have come back green, so I'll be sending you a
> pull request shortly.
> 

I don't actually need the fix myself - from my perspective this was
more informational for others who might be affected by the problem.
I now updated my test configuration to set CONFIG_EXT4_FS unconditionally
for all tests requiring EXT2/3/4 support. But in some sense it was good
to get the heads up this way because some configurations at work still
do set EXT3 options.

Guenter


