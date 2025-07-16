Return-Path: <linux-kernel+bounces-733915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7CAB07A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAFB33A65B0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E937C2F5333;
	Wed, 16 Jul 2025 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2zLZRiD"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15B11A238C;
	Wed, 16 Jul 2025 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681917; cv=none; b=D2VOMuSIpAoqTLLRhfYrOJAmK2tDSzR8DF8sOtdtMabyTVZCW/Jr8QOY9MKZvIPjhqm/SsSeIWJaq7RGcKOMaCgNntqUmtMicuVBcmCwzZkZP8X3VJ3jf7v9vMGyG7dYefveziU0g3QWBmNG/pZZVWq2/hkK29nKY8LvILvBIcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681917; c=relaxed/simple;
	bh=G3lPuCUApuGC7TO34cTcefS+Ne/XTuyO/jotSPqhVf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iGkvJtH80Ru63ej+A9cKa5o5B7EfxeMAw1uVWldloerrRADGp7gVGWJBzWKfgKM9R3SM24PbKD0kYrT4nFrjSi+vgbTSS6kGpWwrkRpHMwr+3YV7FkdRe+atiJlc6lxbkgQ5cgDrVXwSwRCKOvLEWHS/D4RPbLkTGofnzIzCTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2zLZRiD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235ef62066eso98053365ad.3;
        Wed, 16 Jul 2025 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752681915; x=1753286715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UVgMRJ+lsyx/5PbwWdT9sHA9aSAXobVSKmVW6fnzwaE=;
        b=e2zLZRiD1O1gDZE2OSeDwOjAQMPvETOtWk5k6GFoaoufkXTefruzNa2XRk0U9NTeXf
         1O4BiskV4U3yIkUzsWfl8wl+RvAKotberJcI7O0ee53FeKjfCb6e9D2le2iI7sj2LqPy
         J7+HRzVq0kYof8EdBt8BRgzk4RPBCHypJVeXhiXJKX3QTDJSiyel8uNSjVDFXxcshrB/
         oeB25m0f3yfFWPPTYt5OqEnpb++WNyBEejeIEkl1v0HEGKK7TJtgUR24sQ6/5gNzJaPI
         bl1IUVkmIo8KeasClM+Cv/YXWi1D09sicSkoyShYK2LzIaJASMrEfqhQuUYxnW2bJcKh
         2Yhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752681915; x=1753286715;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVgMRJ+lsyx/5PbwWdT9sHA9aSAXobVSKmVW6fnzwaE=;
        b=B1yokx8ePrqaJdX/wD5ZnaVUJLyOyopK0oNBragba7BfZvCo0ivAVyNqakWlo4gd30
         4Z04YnJQpsE83YppXcnrOmXWI9BBspbz7ZYDHv8YrG/JW/uc7gOe8CuU8fujWZObzCSj
         /fFd8+rhu+VZoDliSJAen6X28TL/J83WxQ2xlfp1Z8L35d/iaplNoHFp4BjRKUc1ERrg
         NxEKDMZGnC9pN7omjUiluN8M6FY1LwFVOppvveyq+ETnBDgy3nNL0iHKeyyQWfcJfLID
         rqP30GtrKKhJJh6R13O0MhhJmA/rdeU65cgLKWdlDGHDev5mwDF0LpIYboVx9Y23NEGH
         zLYA==
X-Forwarded-Encrypted: i=1; AJvYcCU1cjrY4Ajzb7pCuE9Jb8odLKZgy76YYYTSURWnnteJf0t3qXUgzcXzMfIQq3MSbXnqbEeOYwviNJvC078=@vger.kernel.org, AJvYcCWhkAIzKwztldSGC/o6JqAXZv36VnmcceAeZ3Cv2DHSPW4FdZ+Xz2sM3/CNqdfDc0agvs+gJF1FWgw0@vger.kernel.org, AJvYcCX0MolqF7iYkeJgVoOCVyIxuHaO+dc+cPiL1Emx8NaeRWL75rrfI2RdfVFTtnBLeLpEjvGg/2S5ro9N@vger.kernel.org, AJvYcCXD12rJRHpoZBmGK7YSEuZUPBuuFBw/Ly/tqXTcfrfYxU4UOnFCy7PNVR0glHXr4fwnT9pyaMZCwvcBMY73@vger.kernel.org
X-Gm-Message-State: AOJu0YwAY1ZrkDtp9fGUU82Jk/EY2SJiYo0gSlsFUgQQ7lN30muQcdOM
	gbMtHYucszrR/nPdsCaz88q5iYzJuwwLEwLvITR1ROiWPAkyCpiy9rZna0IVqg==
X-Gm-Gg: ASbGncvL81Kit2AvVvi5PYC2BSj06dce+8Cv9eFBBMxrihxTx20fejxANRxuyIJqURS
	E1ppJgAq4v3iRulHa/B7hSE2gLcCLiWUxGy0dVHjRzSSGMua2UnU9wdbR0A3QNzk92fKSc/lsvT
	Xpg0pYZTVjXBx9qI/gRVtQCDMFALDH1x+euk8xsBdN4i0MeX2ARfatrVFZ6DvN9X7xdlt1WsDH+
	MFN/NlakYcgGHsnNTTmalEXlANmgYRPqB6EEHarb84Hd0yoQsbkbspJGqn+vlYTD786LXdLSGt7
	Ff2xf9jSFaHobczeykXxP2AMldq1mFT3HGiJsQ9N86m0q3XalOTFc/amTFE1rG/Z9jxOvmdXmNV
	53YzuWSF6tdbxgKcO8jgyhEL0PMUvf5eCpFxpbfHs76h7Qejn9iJwU3pw2FiX+28BJ0ObdSo=
X-Google-Smtp-Source: AGHT+IE38TH5BqmUcE1KaBCkXrsa7LbdbYBffiWCQ78LHEVGn4nG6nxZ9B4/8q3QWyrc6uY70QwxIg==
X-Received: by 2002:a17:902:cf0f:b0:234:c5c1:9b84 with SMTP id d9443c01a7336-23e24f5516emr49931035ad.37.1752681915052;
        Wed, 16 Jul 2025 09:05:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4323df7sm127453915ad.134.2025.07.16.09.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 09:05:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e02cda3e-799f-42bc-8651-108a258b3d85@roeck-us.net>
Date: Wed, 16 Jul 2025 09:05:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drivers: hwmon: add EMC2101 driver
To: =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 corbet@lwn.net, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250709164829.3072944-1-noltari@gmail.com>
 <20250709164829.3072944-4-noltari@gmail.com>
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
In-Reply-To: <20250709164829.3072944-4-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/9/25 09:48, Álvaro Fernández Rojas wrote:
> The Microchip EMC2101 is a SMBus 2.0 fan controller with temperature
> monitoring.
> It supports up to 1 fan, 1 internal temperature sensor, 1 external
> temperature sensor and an 8 entry look up table to create a
> programmable temperature response.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

This looks very much like a clone of LM63. Why does it warrant a new driver ?

Guenter


