Return-Path: <linux-kernel+bounces-790786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B38CB3ACF6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF0416567A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601F128153A;
	Thu, 28 Aug 2025 21:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yg8Z3r3r"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4289E23ABBD;
	Thu, 28 Aug 2025 21:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756417660; cv=none; b=sINGm/R4r/h14/L+yCMKUREn9PMHlCYkLSsF/ZeZ4BmCQBpzSP8viOot27zTwoy/tJIrzLMyTJndxV2XNndX7U6QlfWVeH8XQG9ZZGPakO/ejgmbOkxxmFSqwrKGeMjsELUJhpqVDHLv/rdof/azgLC+EtDcskS4hvttZGrhhaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756417660; c=relaxed/simple;
	bh=XCqEFUPhxIXSY0w2z2gqk7qtqk83mOS4LDd5uHQVOM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFwr+OoCTbAanvPyfN/BBx2elWcsygdWgfhSHBoX0DvfkJ85wUnYNMNz043iZId75fXr10zSfZrTz38UyMVBzsHxwcK5pt01Ljbl0E3pZ47S9GvhLYYMtNsFYd+9Ce4fk8CuVNkAKSjx/QPu9ullPcyXS99S0lofhNo7m4Fg+vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yg8Z3r3r; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24458272c00so15289445ad.3;
        Thu, 28 Aug 2025 14:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756417658; x=1757022458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=SBt0SWN2sGdm0+2GHHL3p8vdTDJCkKDj9ClL86gi+rQ=;
        b=Yg8Z3r3rYy/ikdPRkvSwrAN/cQZYz3b3qN6Q98kfOUiQY87R8h/2vKpACTcRBptsoX
         tnN1Ae19A7fksCkWTNnr07o6+auZo1RsVfm0WEdi1TGMsQoyZ+sqxdhx8TQv/46T8YbY
         5YqbpacFmf+yKunrw83i1XU61mVxGU+tkxLOCsXYSNItneYTxJYENLtFLHhuWOpQf0Wd
         W4f8iRSGO8VmHhexzLxSDWkxu7o2ZKZIJKwM5QJJPHu29Y9CjEpNBWK1Z2wya8jat3+K
         g44MenHrRWf6nIpRjoXoI/x2hE+vffxk7hVQVu1BOJ9tN1ElHS89sjgSCsrRnQAhHElW
         aEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756417658; x=1757022458;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBt0SWN2sGdm0+2GHHL3p8vdTDJCkKDj9ClL86gi+rQ=;
        b=NH2Tz/TrUCJ9t7eANrkmy6mK6eT2b3zXWJp67kyG1tr8OWRnVRwD+eXMxSvygNhmE3
         qFn99ABy4R71xTXAboOiONzZT2jlo3eoHOijMjJmDrMHtSINYexfbX+ZS/6q/4FJSENU
         QtSu7TziCBgggldsdBIjB2RtHDndgMEW4/P4Feox0S7dDRfoGzIy56pSEEwEfkE18pOY
         iGWTypUF2GZiRmZrZ6wS/MSbwHSOlr23hLKwpGPlqXA/NDZdOUTC6um/Zv9s07XQWP1s
         f4prI+EIjB00TCT44v3XG+UjCLz1E7V9A+/8oULM2GgVLZCLv3Fp2nFpymssFmw8OpL8
         hqkg==
X-Forwarded-Encrypted: i=1; AJvYcCU8CMM9eSYEkrms7m5DY+M93NC/QIxQdprkuL8w5zBCAeug5Eect590/Exgf8mZ5QgtJ3/F+ghTzhIPQXOD@vger.kernel.org, AJvYcCVyj5RAUbzLiJQwo3gQqB4IETLYKgkYiDqkjEz4/9GoKP64q+1M9nGSaBOXUJV+wfGmuwV0083ZckNWFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJvVZTtsspGotgbJzA/uZxeuw6f0rKw6sJG4xET9b4FT3EC+88
	2eCVLv+Pt7HIO5d5z2lqJLXRRGJTWjPb7k522JZNRtcn+NRHA87tMM06
X-Gm-Gg: ASbGnct4hgjeRrJ91RYnrm6kr/O2n0JluwQLjfs/jvfcDfe7a/z/OFyTpBn3DAt93nU
	pdUupoA6QHntJpxpo09TCk43MGdl3g0wEGwMHDO2lPm7shOY7trqhQcp9Dv1TtcWwk/7btKSLM/
	7lq3bH7xdd7UUeY0XtvI7z6wc4+Lsfv9+KRAwCP0+e51N3SJ3ws5LXONb1kDJxurWYYs7VxBveN
	i/68pjorphXeYa/iLGps1rFnVWZlxylOL1LDV4V0QTF1QV3ZQ+HD8lMJP2gJ5rQ/BI26dpHwA/W
	60ldTIlFpotrcjBYuS1fOOCgrPWfI0/CRTHCgFE3RyqAbM71TNrwbcrShXa3hCeQhO+8qU9U5Am
	4vHubGBbQa8LcOH821O6wQ49v9qqmCc4Rb1vdbWtxRESq/0VyYF6qkOZvkR1qhFUzj+N0ErlFlh
	fyIA8uOQ==
X-Google-Smtp-Source: AGHT+IHzSf6p9dv7Da929XQm6dZ8DcnV0dV5K3I/6LiLov2AmKupbbxLFqnbha4kQouH4eTopKGY0A==
X-Received: by 2002:a17:903:1a24:b0:246:4d93:78a8 with SMTP id d9443c01a7336-2464d937c89mr370767815ad.6.1756417658512;
        Thu, 28 Aug 2025 14:47:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903703bb0sm5317765ad.2.2025.08.28.14.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 14:47:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c68f0cc1-f84b-4458-bdb4-e017443c2125@roeck-us.net>
Date: Thu, 28 Aug 2025 14:47:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hwmon: (coretemp) Replace x86_model checks with VFM
 ones
To: Dave Hansen <dave.hansen@intel.com>, Sohil Mehta <sohil.mehta@intel.com>,
 Jean Delvare <jdelvare@suse.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-hwmon@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
References: <20250828201729.1145420-1-sohil.mehta@intel.com>
 <16286fa2-3949-4aca-bc52-4090eb96d305@intel.com>
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
In-Reply-To: <16286fa2-3949-4aca-bc52-4090eb96d305@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/25 14:18, Dave Hansen wrote:
> On 8/28/25 13:17, Sohil Mehta wrote:
>>
>> Add a code comment to reflect that none of the CPUs in Family 5 or
>> Family 15 set X86_FEATURE_DTHERM. The VFM checks do not impact these
>> CPUs since the driver does not load on them.
>>
>> Missing-signoff: Dave Hansen <dave.hansen@linux.intel.com>
>> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> 
> Thanks for picking this back up from whatever dark hole I left it in! ;)
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> 
> I assume the hwmon folks will pick this up. If not, it's certainly
> x86-ish enough for it to go through tip.
> 
Already done, but if you want to take it through some other branch
let me know and I'll drop it.

> Oh, and do we want to cc:stable@ on this? Could this end up biting
> anybody running an old kernel on the model 18/19 hardware?

It doesn't really bite, it will just not instantiate the driver.
I have no idea if those old kernels would run with the new hardware
in the first place. You tell me...

Personally I'd rather wait until someone complains.

Guenter


