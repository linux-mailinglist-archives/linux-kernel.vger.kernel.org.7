Return-Path: <linux-kernel+bounces-855014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59564BDFF0B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE52B19C2E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEAE3002D3;
	Wed, 15 Oct 2025 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6S6e9ql"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16893002A2
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760550506; cv=none; b=YgHvsXZ6okXYxLqkJkleHWkNzFRUhXTywb/dZHiQihBDspdrflw2cPF4qENFPI0MC3anNG9QW5idxwPDsGXfxgi92QgNACqrpSqBWw4RfV/EpUTFunwxTETygNTmMV0t1fI/KxeMmldBSbjLFeJZGXQYbF0rV4IBuOWAr1yUHjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760550506; c=relaxed/simple;
	bh=HDWLuGv4CmjuQHJ5GYTTZcw60QkiBiN9g1dCY4BSXCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pb9ixJ9+QJNn3gwFLoEtkpyXTOUJrbgffHVxQ8SQpH7SaVW4V2Z4ScWBl0lj99nGAilhZIItSmF45vXXqbE4pDh1pagni0wsz1y7WWj4Ulvc6Cy5PQ7GdlgGeB1AJU1F6CU/Tb9uw1omy8KceTFtzWBP7Wm2YYpsVjvnrnmiLV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6S6e9ql; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b62ed9c3e79so4491106a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760550504; x=1761155304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ub1/0EJ+IrXMXkXpAc4gq80fIvOYtWuOsQME91bwrk8=;
        b=K6S6e9qlw5yK3rp+MMUDnxwqp1wCejUUUE1s9xyeqm9i+PWSOr1Eu6MzprkyGovz/s
         OzLA2WvmKs90mbm+tPc5ebYC6hyE7yZrHB6FpBB2rmII26VAE+UCBuCwEyLrM/mc2OLc
         c36hZrbgcvTSw2L+1pAYF60YpvQR8kruOWb4IOO2RcQsXeUxW4PIAvfgVechR4Ex1k8b
         K7OvYgd2xNk4ACQmxszAILq94H6KYeLWz7z2HwSZflp17B37EH9PWloTJ74KpRFOs0nb
         hf4qyeK6Ofbq5b1/u+3IW0sSxX/lu1kn7jIQo2qKEi5m1BU8Fo2/RhYoJD4gLdadglkm
         QbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760550504; x=1761155304;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ub1/0EJ+IrXMXkXpAc4gq80fIvOYtWuOsQME91bwrk8=;
        b=MZrnc4FsGJMsyxqIIqQ8ry22wcgIlH1CyVAnMyZ7I5JAZqVvkM4r3bEn6aa8q/pwh9
         iICrPxe8IrET+rkhqHCkABU8W/P+7GlVYyeRVhVgnndivKCeTFW7EFXYF4/C0B8ZixM1
         oS9KNMMS5gJCQCfKVzdtR+V+V4UhBfO4stzJ615XXJRmOmtwG3gMUg6AU71esJmHopC6
         yi4Zz0I8d5lBjpUJMP9iwQ5GzePrBYCmwUfqS3OFijMNu6WRILgAShmhqbk9Jeg23YB8
         TIn288Z9DVQox0dnFBsevsCO96wHaVFJeIKI3+WsmCYpkN7ACwkYTUnW+mYdpykhTxFL
         DnYg==
X-Forwarded-Encrypted: i=1; AJvYcCXG9w0al4uQ0tPnxG3r/nLOu3bYsP+BY+bDb9Bq6Vre4WuJw4SKU6wnim2T5XtO66O1HZjT4nB6bHOIGAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZeGBUh/UCXVQkmcB2iYRXpMENfQxwcJ0fmBRmlLFA44Ps7371
	dNHofaZk5Ogg/ZNddpmTaD6ctLuEagEykUN7UuDg0pjBk/D2uHrYO7bj
X-Gm-Gg: ASbGncuvN3MuD19i6uSCA/tLamzSacsnNdfNCy+2nsRZip2FP5kMzrp9zUzGmQ7ulNL
	y5U1sHS8nAn/IErqxbJtl/BcEr/EKNBUyMrJursUF8n4uEREAbyM6McB6Y6sGBX2RV6Kd0N90CK
	9+gWO6vaZqpzkraIUL0z2m4Vf9UuS0hOHeBupt+MAj/p7lxVXlDokNP/pgM240PGJhN16fpgGmk
	e4PajuBJXlGAhEYHG9g2UqqNoxYBlB9pUlt0ST31+5NEFHLUf2X/x/E+OKxMKN1HVxMAXErnoaw
	/bHQ3vcWsAPgEedR0FR8mZvvNgSXyQ8ksmUhD9F+4FMhd/VmIukneXOp9zXgzEIzjqSKo12zaWz
	LWPI//iVOvcApSYHL1MJg0RWP33S1yBVbYhq3Q3IwnfSvQ0THzpQ3Syk9GbbkEAsMbo3RPNtP+N
	j4g7VenHo0G4hB/mpRGITtQp9mObzR1NeOU/k=
X-Google-Smtp-Source: AGHT+IFR+PPnK4JaYIxf4eiAsi+MVSSfImXbxS5Y+Ot8X2S3BFp2V4mZ6Z4tZVeC2/m6780fyH8pHQ==
X-Received: by 2002:a17:903:2d0:b0:25e:78db:4a0d with SMTP id d9443c01a7336-290273eddd5mr361300555ad.36.1760550503521;
        Wed, 15 Oct 2025 10:48:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7b0c8sm2422495ad.62.2025.10.15.10.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 10:48:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <81c865ca-a9d2-413e-b43d-eedd7e4e88a1@roeck-us.net>
Date: Wed, 15 Oct 2025 10:48:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.18-rc1
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Feng Chen <feng.chen@amlogic.com>, Matthew Wilcox <willy@infradead.org>,
 Jeff Layton <jlayton@kernel.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Tao Ren <rentao.bupt@gmail.com>, Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
References: <CAHk-=whPJTtX5u1m47fPUD2g2Dc=Did_6OqCVj6OQPKFgfKn9g@mail.gmail.com>
 <f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net>
 <c45a8502-3af2-4d5c-a660-2922b4e040bb@roeck-us.net>
 <68841c19-c54e-4837-80bf-d180f2c35499@roeck-us.net>
 <3exillpepa4jjxsjkp5vgn4347tsvt7q22m75tp3ncavkyzgl7@juvt3p4h53km>
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
In-Reply-To: <3exillpepa4jjxsjkp5vgn4347tsvt7q22m75tp3ncavkyzgl7@juvt3p4h53km>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/25 10:28, Liam R. Howlett wrote:
> + Cc Vlastimil, as you are indicating the slab merge.
> 
> 
> * Guenter Roeck <linux@roeck-us.net> [251015 06:02]:
>> On Mon, Oct 13, 2025 at 09:46:44PM -0700, Guenter Roeck wrote:
>>> On Mon, Oct 13, 2025 at 10:08:26AM -0700, Guenter Roeck wrote:
>>>> On Sun, Oct 12, 2025 at 02:04:32PM -0700, Linus Torvalds wrote:
>>>>> Two weeks have passed, and 6.18-rc1 has been tagged and pushed out.
>>>>>
>>>>> Things look fairly normal: size-wise this is pretty much right in the
>>>>> middle of the pack, and nothing particular stands out in the shortlog
>>>>> of merges this merge window appended below. About half the diff is
>>>>> drivers, with the res being all over: vfs and filesystems, arch
>>>>> updates (although much of that is actually devicetree stuff, so it's
>>>>> arguably more driver-related), tooling, rust support etc etc.
>>>>>
>>>>> This was one of the good merge windows where I didn't end up having to
>>>>> bisect any particular problem on nay of the machines I was testing.
>>>>> Let's hope that success mostly translates to the bigger picture too.
>>>>>
>>>>
>>>> Test results don't look that good, unfortunately.:
>>>>
>>> ...
>>>> Qemu test results:
>>>> 	total: 609 pass: 581 fail: 28
>>>> Failed tests:
>> ...
>>>> 	sheb:rts7751r2dplus_defconfig:initrd
>>>> 	sheb:rts7751r2dplus_defconfig:ata:ext2
>>>> 	sheb:rts7751r2dplus_defconfig:usb:ext2
>>>> Unit test results:
>>>> 	pass: 655208 fail: 0
>>>>
>>>
>>
>> Update on the sheb (SH4 big endian) failures below.
> 
> What is the qemu line you use and the memory configuration of that qemu,
> or is this real hardware?
> 
qemu. I tried 6.2.0, 10.0.5, and 10.1.1. Sample command line:

qemu-system-sh4eb -M r2d -kernel arch/sh/boot/zImage \
	-append "console=ttySC1,115200 noiotrap" \
	-serial null -serial stdio -monitor null -nographic -no-reboot

initrd or root file system doesn't really matter because qemu exits
almost immediately.

> Are there sh4 configs that pass?
> 

little endian - all
big endian - none

> It's a bit odd it says "fail: 0" here, Is this message about something
> else?

This are unit (KUNIT) test results. All 655208 executed unit tests passed.
Unit tests not executed because the image crashed or because qemu died are not
counted as failed.

...

>>
>> # bad: [ba9dac987319d4f3969691dcf366ef19c9ed8281] Merge tag 'libnvdimm-for-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
>> # good: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
>> git bisect start 'HEAD' 'v6.17'
>> # good: [58809f614e0e3f4e12b489bddf680bfeb31c0a20] Merge tag 'drm-next-2025-10-01' of https://gitlab.freedesktop.org/drm/kernel
>> git bisect good 58809f614e0e3f4e12b489bddf680bfeb31c0a20
>> # bad: [8804d970fab45726b3c7cd7f240b31122aa94219] Merge tag 'mm-stable-2025-10-01-19-00' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>> git bisect bad 8804d970fab45726b3c7cd7f240b31122aa94219
>> # good: [30c3055f9c0d84a67b8fd723bdec9b1b52b3c695] xsk: wrap generic metadata handling onto separate function
>> git bisect good 30c3055f9c0d84a67b8fd723bdec9b1b52b3c695
>> # good: [f79e772258df311c2cb21594ca0996318e720d28] Merge tag 'media/v6.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
>> git bisect good f79e772258df311c2cb21594ca0996318e720d28
>> # good: [f1455695d2d99894b65db233877acac9a0e120b9] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
>> git bisect good f1455695d2d99894b65db233877acac9a0e120b9
>> # good: [a16c46c2402026162111ed9fd1fc28d25223443e] dma-remap: drop nth_page() in dma_common_contiguous_remap()
>> git bisect good a16c46c2402026162111ed9fd1fc28d25223443e
>> # good: [a5883fa94295f1ef2473eadd84cc1e24dab9ae18] selftests/mm: gup_tests: option to GUP all pages in a single call
>> git bisect good a5883fa94295f1ef2473eadd84cc1e24dab9ae18
>> # good: [08498be43ee676d8a5eefb22278266322578a3e0] mm/ksm: get mm_slot by mm_slot_entry() when slot is !NULL
>> git bisect good 08498be43ee676d8a5eefb22278266322578a3e0
>> # good: [719a42e563bb087758500e43e67a57b27f303c4c] maple_tree: Convert forking to use the sheaf interface
>> git bisect good 719a42e563bb087758500e43e67a57b27f303c4c
>> # good: [b9120619246d733a27e5e93c29e86f2e0401cfc5] Merge series "SLUB percpu sheaves"
>> git bisect good b9120619246d733a27e5e93c29e86f2e0401cfc5
>> # bad: [24d9e8b3c9c8a6f72c8b4c196a703e144928d919] Merge tag 'slab-for-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab
>> git bisect bad 24d9e8b3c9c8a6f72c8b4c196a703e144928d919
>> # good: [83382af9ddc3cb0ef43f67d049b461720ad785e6] slab: Make slub local_(try)lock more precise for LOCKDEP
>> git bisect good 83382af9ddc3cb0ef43f67d049b461720ad785e6
>> # good: [af92793e52c3a99b828ed4bdd277fd3e11c18d08] slab: Introduce kmalloc_nolock() and kfree_nolock().
>> git bisect good af92793e52c3a99b828ed4bdd277fd3e11c18d08
>> # good: [ca74b8cadaad4b179f77f1f4dc3d288be9a580f1] Merge series "slab: Re-entrant kmalloc_nolock()"
>> git bisect good ca74b8cadaad4b179f77f1f4dc3d288be9a580f1
>> # good: [07fdad3a93756b872da7b53647715c48d0f4a2d0] Merge tag 'net-next-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
>> git bisect good 07fdad3a93756b872da7b53647715c48d0f4a2d0
>> # first bad commit: [24d9e8b3c9c8a6f72c8b4c196a703e144928d919] Merge tag 'slab-for-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab
>>
>> I had to revert commit 719a42e563bb ("maple_tree: Convert forking to use
>> the sheaf interface") and commit af92793e52c3 ("slab: Introduce
>> kmalloc_nolock() and kfree_nolock()") in the 'slab-for-6.18' branch to fix
>> the problem. The first patch can not be reverted in mainline since other
>> patches depend on it.
> 
> Both 719a42e563bb and af92793e52c3 are listed as good in your bisect
> above.  Why are the two commits you name as the cause listed as 'good'?
> 
> What did you revert to get sh4 to work, and from which git branch?
> 
> What do you mean "can not be reverted in mainline"?  And which is "the
> first patch", I'm assuming the first one you listed (719a42e563bb)?
> 

I checked out a test branch at 24d9e8b3c9c, rebased it on top of
24d9e8b3c9c8a6~1 (07fdad3a93756b8), and ran another bisect. Results:

# bad: [c5e19dc4c1db098456ee6a924e276a26e692f26c] slab: Introduce kmalloc_nolock() and kfree_nolock().
# good: [07fdad3a93756b872da7b53647715c48d0f4a2d0] Merge tag 'net-next-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
git bisect start 'HEAD' '07fdad3a93756b872da7b53647715c48d0f4a2d0'
# good: [10f17a5a3befa328bd9a78ca6b799dd1933f108b] maple_tree: remove redundant __GFP_NOWARN
git bisect good 10f17a5a3befa328bd9a78ca6b799dd1933f108b
# good: [f97515baad5efa6e1963abd37188fad42515edc8] maple_tree: Replace mt_free_one() with kfree()
git bisect good f97515baad5efa6e1963abd37188fad42515edc8
# bad: [4df642aa2128c2c346f9c945bddbae37c59bba82] locking/local_lock: Introduce local_lock_is_locked().
git bisect bad 4df642aa2128c2c346f9c945bddbae37c59bba82
# good: [a20be9b8014abfe68acc2efd81bfb5d2dd4eaf34] maple_tree: Prefilled sheaf conversion and testing
git bisect good a20be9b8014abfe68acc2efd81bfb5d2dd4eaf34
# bad: [40696586bc008ad34db8135c35ec4b459691af3c] maple_tree: Convert forking to use the sheaf interface
git bisect bad 40696586bc008ad34db8135c35ec4b459691af3c
# good: [8387347ae261c5e74e9db3f73b91d47f11f8d6f8] maple_tree: Add single node allocation support to maple state
git bisect good 8387347ae261c5e74e9db3f73b91d47f11f8d6f8
# first bad commit: [40696586bc008ad34db8135c35ec4b459691af3c] maple_tree: Convert forking to use the sheaf interface

Reverting just 40696586bc008 in that branch didn't help. So I reverted "slab: Introduce
kmalloc_nolock() and kfree_nolock()" in that branch as well, and the image started
passing.
In mainline, 719a42e563bb ("maple_tree: Convert forking to use the sheaf interface")
can be reverted, but trying to revert af92793e52c3 results in:

CONFLICT (content): Merge conflict in mm/slub.c

Guenter


