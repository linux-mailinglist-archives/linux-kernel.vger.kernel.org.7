Return-Path: <linux-kernel+bounces-735184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EC9B08BDF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641A81AA35FA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6B029ACEC;
	Thu, 17 Jul 2025 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VoozCwnj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26DC1F9F73
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752752659; cv=none; b=uf9/czFZUq4WGd/RBs/4ONZNNmH7MvGPbogyDKSwGjAtgTTJAu4iW76SASdxYLj3LidHZKfvhGKE9R2EnCs6Oj1I3sPlCFmyzHWyagT2rMsXUbiKKvFe2V4GMu6iZ34snxjnCLio+U3cQiAF9UKJKqq5YOVakckJD9X/tqGEGSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752752659; c=relaxed/simple;
	bh=ZRXGNluVXv3zZ4clOLaq1Ndil6J/AuQBuOFSUtnqaUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSkanJz3rhfp0zPC4zrdaQz1ZO2UFOvyWTZMwDPxowFZnYC2Vzrs1xsqG+PgcbbKzBHUqgaOXQn1Uu3hmo+xYEHJnFi4dfYTzdqnJOmnB/u/JnV+6ZGbKtsySBFkGBIO9Ujz13pY8SZkVoGAhbkpT4P1mxeWqu64A3vbjEoI6a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VoozCwnj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752752656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9WU5UWcIBWif5znmowNFh28ppk/v4mj1iGxdt2Apq5w=;
	b=VoozCwnj6lHbmW+4nQjVrRZ7cTnJjHHZ3w7t8S6ZvZVL4c2SCcr31hP4UBs7zBZxY7WiHM
	wHp9vRPb4k4Y3pN+FmPHaCHwfx7rSy4GbXk8qTzh3gjnE9NJxDjHHGWWbebsKiMSO1FnV7
	yzCe5JaHnqGVy2L/JGUjMImOxqh95N8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-9wPDUfauPCykbhkOXL4Llw-1; Thu, 17 Jul 2025 07:44:15 -0400
X-MC-Unique: 9wPDUfauPCykbhkOXL4Llw-1
X-Mimecast-MFC-AGG-ID: 9wPDUfauPCykbhkOXL4Llw_1752752654
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-455eda09c57so5320125e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752752654; x=1753357454;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9WU5UWcIBWif5znmowNFh28ppk/v4mj1iGxdt2Apq5w=;
        b=tI+4MAnaNf7sUrg6VyBK7amRZaFhVRodi5uWw9QknCiNbcLSqyPbkbF/BwLDnntuzR
         XwNrsWztH+vaukw46EFfC4H/vDZgIUlcP6zABKc6Vjyvde3aF9pN9zvnblZCHjq+/PcL
         PXHEgOtddEIxNbf4sqaHwivLyAlZeeF/4X3/yXcjVSaXEOfEVLyx1q+QxihtTXdZmi7m
         XA+eiGxUdvaPoWLM3PjyxJRQee0vmNJwdt5VILdsFyCJP8qOqhiwVbeNHM/EU0kuY3fr
         /1jS8z6k02oOmCDvSNLUi8SbRK8XQEtvKc9EJP3a6GaxpQoHx9XoewWq3vfwawq6KGMD
         Ddjw==
X-Forwarded-Encrypted: i=1; AJvYcCV0g4mOWMA1LPueAdhWAWUoJaf0tg+hO2Z3OSoFSMiTBc9eFUfQtxWd5K1hxxHuAiepU9DVRX3pyRdvMUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJpHl2cZ7aA6cYPGkaUiDG08KjfS/ZqgIzuAZdj7fTqdDjNg0s
	LCBo935IgM/aIfpf0AyP6DmMmHsumKmPSasnSX334u+c9SqUf9zyjHZ6dJMRN0fgMRbNg5BSqAU
	EsMfzoZnAs91rhNQHe3ZLhAc+9J/P40gLJganZ8jlDxK7kdm0B1v7eR/T95EMNw1rHg==
X-Gm-Gg: ASbGncs2Z/h6aXXqZJCpbwkkIqbwKd2C4AG80AZ2GpYxLjCxru3qkMJCZP8OMvYaw0q
	GpmG34eb3hlxp5DQ9qmUHE7FNPmMyNyUm0qOH4gcR+4F8UliXX4k1GUgEneNKFffA9lIvdg3Wh7
	nEjFwKeNyLBJrDlWkPCDU8BKhWP7VQNhYKRt4K5pKbKRxKQKQNJN/ykGPvTaRq7/OT12Ib38rio
	nRR7HyaqKK/YhVTUOe1WnnZUCBxZN1+GAv/VR3OEYsHlvFpshmsqwKMZ6FZkhzbIvBcRS8qYFM/
	HIZydxh5jLsKGT/u821IhlNZn8gKEf+pvLw2SHnJAb+7nDLG+NEchzrBdCqEz1QGXPk8Rl/XQVK
	4QbFiA58oxFUgFPFrRNVAEijxv5CGtsXgT8z0bol6seUCRfCQzW/IqO5eQSMcmKnv
X-Received: by 2002:a05:600c:3d96:b0:456:c48:491f with SMTP id 5b1f17b1804b1-4562e3548f0mr74184495e9.10.1752752654217;
        Thu, 17 Jul 2025 04:44:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+YkRslUaUKSYWlT2QF2X4TYmoTTKMAomOHcnx7rkseDkuAEJ7oII61TD6hxz3G6a7Dh8AqA==
X-Received: by 2002:a05:600c:3d96:b0:456:c48:491f with SMTP id 5b1f17b1804b1-4562e3548f0mr74184085e9.10.1752752653773;
        Thu, 17 Jul 2025 04:44:13 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7? (p200300d82f1f36000dc826ee9aa9fdc7.dip0.t-ipconnect.de. [2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e8018a4sm48479605e9.9.2025.07.17.04.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:44:13 -0700 (PDT)
Message-ID: <2fdacd57-2314-47c7-9eeb-6928221ce516@redhat.com>
Date: Thu, 17 Jul 2025 13:44:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/mm: refactor common code and improve test
 skipping in guard_region
To: wang lian <lianux.mm@gmail.com>, akpm@linux-foundation.org,
 broonie@kernel.org, lorenzo.stoakes@oracle.com, sj@kernel.org,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: brauner@kernel.org, gkwang@linx-info.com, jannh@google.com,
 Liam.Howlett@oracle.com, ludovico.zy.wu@gmail.com, p1ucky0923@gmail.com,
 richard.weiyang@gmail.com, ryncsn@gmail.com, shuah@kernel.org,
 vbabka@suse.cz, zijing.zhang@proton.me
References: <20250717112407.13507-1-lianux.mm@gmail.com>
 <20250717112407.13507-2-lianux.mm@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAmgsLPQFCRvGjuMACgkQTd4Q
 9wD/g1o0bxAAqYC7gTyGj5rZwvy1VesF6YoQncH0yI79lvXUYOX+Nngko4v4dTlOQvrd/vhb
 02e9FtpA1CxgwdgIPFKIuXvdSyXAp0xXuIuRPQYbgNriQFkaBlHe9mSf8O09J3SCVa/5ezKM
 OLW/OONSV/Fr2VI1wxAYj3/Rb+U6rpzqIQ3Uh/5Rjmla6pTl7Z9/o1zKlVOX1SxVGSrlXhqt
 kwdbjdj/csSzoAbUF/duDuhyEl11/xStm/lBMzVuf3ZhV5SSgLAflLBo4l6mR5RolpPv5wad
 GpYS/hm7HsmEA0PBAPNb5DvZQ7vNaX23FlgylSXyv72UVsObHsu6pT4sfoxvJ5nJxvzGi69U
 s1uryvlAfS6E+D5ULrV35taTwSpcBAh0/RqRbV0mTc57vvAoXofBDcs3Z30IReFS34QSpjvl
 Hxbe7itHGuuhEVM1qmq2U72ezOQ7MzADbwCtn+yGeISQqeFn9QMAZVAkXsc9Wp0SW/WQKb76
 FkSRalBZcc2vXM0VqhFVzTb6iNqYXqVKyuPKwhBunhTt6XnIfhpRgqveCPNIasSX05VQR6/a
 OBHZX3seTikp7A1z9iZIsdtJxB88dGkpeMj6qJ5RLzUsPUVPodEcz1B5aTEbYK6428H8MeLq
 NFPwmknOlDzQNC6RND8Ez7YEhzqvw7263MojcmmPcLelYbfOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCaCwtJQUJG8aPFAAKCRBN3hD3AP+DWlDnD/4k2TW+HyOOOePVm23F5HOhNNd7nNv3
 Vq2cLcW1DteHUdxMO0X+zqrKDHI5hgnE/E2QH9jyV8mB8l/ndElobciaJcbl1cM43vVzPIWn
 01vW62oxUNtEvzLLxGLPTrnMxWdZgxr7ACCWKUnMGE2E8eca0cT2pnIJoQRz242xqe/nYxBB
 /BAK+dsxHIfcQzl88G83oaO7vb7s/cWMYRKOg+WIgp0MJ8DO2IU5JmUtyJB+V3YzzM4cMic3
 bNn8nHjTWw/9+QQ5vg3TXHZ5XMu9mtfw2La3bHJ6AybL0DvEkdGxk6YHqJVEukciLMWDWqQQ
 RtbBhqcprgUxipNvdn9KwNpGciM+hNtM9kf9gt0fjv79l/FiSw6KbCPX9b636GzgNy0Ev2UV
 m00EtcpRXXMlEpbP4V947ufWVK2Mz7RFUfU4+ETDd1scMQDHzrXItryHLZWhopPI4Z+ps0rB
 CQHfSpl+wG4XbJJu1D8/Ww3FsO42TMFrNr2/cmqwuUZ0a0uxrpkNYrsGjkEu7a+9MheyTzcm
 vyU2knz5/stkTN2LKz5REqOe24oRnypjpAfaoxRYXs+F8wml519InWlwCra49IUSxD1hXPxO
 WBe5lqcozu9LpNDH/brVSzHCSb7vjNGvvSVESDuoiHK8gNlf0v+epy5WYd7CGAgODPvDShGN
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250717112407.13507-2-lianux.mm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.07.25 13:24, wang lian wrote:
> Move the generic `FORCE_READ` macro from `guard-regions.c` to the shared
> `vm_util.h` header to promote code reuse.
> 
> In `guard-regions.c`, replace `ksft_exit_skip()` with the `SKIP()` macro
> to ensure only the current test is skipped on permission failure, instead
> of terminating the entire test binary.
> 
> Signed-off-by: wang lian <lianux.mm@gmail.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   tools/testing/selftests/mm/guard-regions.c | 9 +--------
>   tools/testing/selftests/mm/vm_util.h       | 7 +++++++
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
> index 93af3d3760f9..b0d42eb04e3a 100644
> --- a/tools/testing/selftests/mm/guard-regions.c
> +++ b/tools/testing/selftests/mm/guard-regions.c
> @@ -35,13 +35,6 @@
>   static volatile sig_atomic_t signal_jump_set;
>   static sigjmp_buf signal_jmp_buf;
>   
> -/*
> - * Ignore the checkpatch warning, we must read from x but don't want to do
> - * anything with it in order to trigger a read page fault. We therefore must use
> - * volatile to stop the compiler from optimising this away.
> - */
> -#define FORCE_READ(x) (*(volatile typeof(x) *)x)
> -
>   /*
>    * How is the test backing the mapping being tested?
>    */
> @@ -582,7 +575,7 @@ TEST_F(guard_regions, process_madvise)
>   
>   	/* OK we don't have permission to do this, skip. */
>   	if (count == -1 && errno == EPERM)
> -		ksft_exit_skip("No process_madvise() permissions, try running as root.\n");
> +		SKIP(return, "No process_madvise() permissions, try running as root.\n");
>   
>   	/* Returns the number of bytes advised. */
>   	ASSERT_EQ(count, 6 * page_size);
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index 2b154c287591..c20298ae98ea 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -18,6 +18,13 @@
>   #define PM_SWAP                       BIT_ULL(62)
>   #define PM_PRESENT                    BIT_ULL(63)
>   
> +/*
> + * Ignore the checkpatch warning, we must read from x but don't want to do
> + * anything with it in order to trigger a read page fault. We therefore must use
> + * volatile to stop the compiler from optimising this away.
> + */
> +#define FORCE_READ(x) (*(volatile typeof(x) *)x)
> +
>   extern unsigned int __page_size;
>   extern unsigned int __page_shift;
>   

The FORCE_READ() stuff belongs into patch #2.

-- 
Cheers,

David / dhildenb


