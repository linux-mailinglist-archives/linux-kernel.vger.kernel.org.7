Return-Path: <linux-kernel+bounces-876341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002ABC1B677
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5B5587B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C509A27B353;
	Wed, 29 Oct 2025 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kebDlKBc"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A75279334
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747935; cv=none; b=BXWikvLNfhysoiKEOTt4S5xYS71uVH9pKnXgW+HgaJShH4z5wdb6ScYESeJxwrXsjkdBGNFIjgLDJ98/+3WBNQ97vuteYegOqVwXUZ3F/T2EGb974E/7Yrq0UsheNiH/Itj2H/4QA8/KdKLaoThNFabWPQN6WGpGgqYQKDvohF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747935; c=relaxed/simple;
	bh=B3sbwwzs9MVfr35/M8il/tVRzvFFJqtugA8SprPW4hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lUJULh4JWg3ibm6SLDNB8QmSEW91ivUdaTQCfzEI/UC8LCcDDuVJJpppX9+Lwk5XlB2t26XkBV20MwAYdUN54szy9DDMxX/vqZas/r3JPdwgt5SNFMzxKJ8e8S6u0iohNFRY7louKqhPAwIum7MOLezgBQSp/7bFSLqmc5odD+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kebDlKBc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290b48e09a7so88731215ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761747933; x=1762352733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jgmOn0xD60/w5G8Z/yTkMy8yyYEwegN/YbrThWd8B78=;
        b=kebDlKBcJvjZeyiTxXS8ac4h8BsOrhZB2ucZEx0S7q7jfRESZEnsT9LxJup5xZkLke
         1bqBjiYCfZ9/riT3WV3e9TIgTbh+aY+4RfJP8PdtrT3vn+K+PXOi3K6hFjXHvJNMoGV8
         rOgIGfMblLa60xSPkLWhf8LkjNiCTLgxM4eTbgLZ/8+ahlDlJRzZPMfslqh7MCypoIzH
         r9UbTpHhe7G+gaD58so3KDcQA2myKuPaPttBTa/yBByxzekONl6M9cDkS1WCDodG96w1
         GqOKBmLzPdh528E0uYBzmsXWCK/seMDzGfO2dcDCtTa5auDp7leloE8fkVECvuFbfIfB
         W4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761747933; x=1762352733;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgmOn0xD60/w5G8Z/yTkMy8yyYEwegN/YbrThWd8B78=;
        b=jBKByw39j8eQgwBZVGdz+spdCK4but4TDlOaGrG0XFEs/nKWDJvy/8X44Iw9K6bcO9
         N1qJudDOnmciWlqZqa2ZnvkSJBEl/0vt96tV5BLPwCjqCyeoYr+h4d5wj5lw6Q8YBK8b
         uGjuihQ7vZhxYVaSEMPuJXlFlctyGYOc9tHzHOBxJfSbsz9gPlQk+A1LJKunaKhOZAIs
         Ibuain7qm4yVH7fEw8B3Hqb2YQeWh42e0XuQCcOeTVtZOPnRAgu2sMinVtpJMVJ0y4pt
         kyWCGe52d9vSHO99tGrWHb5WvjHaN9gGn0mFYanab83IxUDQRfPGFTaD35EhQJRcWp8y
         T4eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnNytv2tdFCBCbkM/7Hcjyu1sEOQT4W0NGQFj6PNC26RHxWOXNheiVX45caqpPW/tbOAdXBrGVAcV9/20=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBr0G+VXPs72WuGHiGYzGZmhyBPScyfS8Bz986cHv257icEFL/
	LypeFF1HaKEBnr5HzMCC1huhAcqr9tLhsHFwu4aS3uj1FM3SoW5h4VTY
X-Gm-Gg: ASbGncsMVb3iD0nWZH8Al7wOQTAdkmDuWqEN7i2ENT6Zb4UV5ezPc7NcrjHtg8eJVD4
	F4IPkb+lvXWWEquuWcvrg3P1GaAUC+rp0L8v7wiZcR8CbXVgxM7jUjhRgHGDiBXNaW85b70d9PD
	GMNRsYQj/jqwReL2ZY/KEL5b381w/Q+uT9CT/c7d7rYOmj+YdtPTzS3UVck3n0fZX+HRDgNCpfH
	4xvbTKkP7AnZPs+Pd0nCn9D4RNzhqcc32CI6N8XbiPAn1huBb8M2PyUqNjhjNkT7e63zzSSY3aE
	GTAQJtl/HS/rniQyDpyGR7RTexS5STzh/cG0rEdfKTkV2FWeW/OBV2Ceql7gaZ1NFbSqg/HWTFO
	V7zN4ELHh0EgBpIeniqfbUYU2qzzbWIHa9nI6jmnGnEkngwJ7eT2+lk+5Jpa3vqDdCsZ6MhNA6j
	DhANYDVArZ42/Fg24Ukv9Y4+6e4qWLWL77qxeECegO94BIy95W0/OAJUPYQDo=
X-Google-Smtp-Source: AGHT+IEf6e/foomFLq4K1E13/Aa2eew3MijpE1P9QpJa0LgPblSEKfui2B1DkJrn/sO8+ZxJSQ/jdw==
X-Received: by 2002:a17:902:dac1:b0:294:ccc6:cd07 with SMTP id d9443c01a7336-294dedd524bmr38472425ad.1.1761747932364;
        Wed, 29 Oct 2025 07:25:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed70645fsm15935049a91.3.2025.10.29.07.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:25:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <52268b57-30ce-4864-b9e7-7076c6bc4418@roeck-us.net>
Date: Wed, 29 Oct 2025 07:25:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] platform/x86: ayaneo-ec: Add suspend hook
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>
References: <20251015084414.1391595-1-lkml@antheas.dev>
 <20251015084414.1391595-7-lkml@antheas.dev>
 <38a49942-58d3-49cf-90d7-1af570918ae5@kernel.org>
 <CAGwozwEmjms0H=GPbevuOjJfed6x69wmg8E9begBhUKbF8B2AQ@mail.gmail.com>
 <000cd38e-7052-4987-b5bc-b8de176363cf@kernel.org>
 <CAGwozwFDsn0xm_mG4ypEym=K8c81qqi=qtJL=06nP6SzdFaFoQ@mail.gmail.com>
 <b98a8486-e90a-4bd5-b3a7-3b2ba1b16398@kernel.org>
 <CAGwozwHa3GSNGyRRp4=bR+Wsy2VLgwAbSmcdWb2=5rEyi7jdQw@mail.gmail.com>
 <8f7c2544-2b9d-4997-942a-5bd3ea72e3a3@roeck-us.net>
 <CAGwozwFNMC+g00LhR+tPsLWPLOiYh0NA0p9yawcunVaMKsNXXw@mail.gmail.com>
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
In-Reply-To: <CAGwozwFNMC+g00LhR+tPsLWPLOiYh0NA0p9yawcunVaMKsNXXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/25 03:49, Antheas Kapenekakis wrote:
...
> Speaking of which, what is the policy for hwmon when it comes to
> settings after hibernation. I am being asked to add a restore hook for
> hwmon settings here, but other relevant drivers do not have it
> (asuswmi, gpdfan, oxpec), is a new requirement for hwmon?
> 

Your driver is in platform/x86. I do not dictate or control requirements
in that subsystem. I only get involved at all if I catch a flagrant violation
of hwmon's API/ABI. I found that people implementing hwmon drivers outside
hwmon often do it to avoid maintainer scrutiny, and I am tired of arguing
with people claiming that they know the hwmon subsystem better than me.

For drivers/hwmon, there is no mandate to implement suspend/restore support,
but if implemented if _should_ be complete. I understand that this is not
always the case. I don't reject code because of it because it is sometimes
all but impossible to implement. My philosophy is that anyone interested
in a perfect implementation of suspend/restore support is invited to submit
patch(es) implementing it.

Long story short, there is no such requirement for hwmon drivers in
drivers/hwmon/, but I can not speak for requirement in drivers/platform/.
That is for the respective maintainers to determine and decide.

Guenter


