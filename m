Return-Path: <linux-kernel+bounces-754855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ACFB19D8D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47BB3170121
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6360A24167F;
	Mon,  4 Aug 2025 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xg4Ab3r2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDCA241668
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295960; cv=none; b=YnEfnNcCnMNNFF0vK6szK30QsoETiyl07jUQ9diT6vuhRVLVfhXSQdA+gKlms0M6SqMqlAYOpglgIrSWw3pw/ZWS3B0qGkm+dsgPdY55Aw6zdNAPNv0kXnYTG9hSMedNEOTk+0Qx5ku4quXehP+E4auF8ppKhWUCly76JubELqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295960; c=relaxed/simple;
	bh=54mq18CDCFm4MZxwX/8v/9zlf+8hqTtcpk74yoc4DXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AB7MGHs0LQeP3/dGEo+S7vHvzNTyNwIsMQi15rVt40EwgFy/SqEhS79FKnNt4ncN/eCITnfVcep578RwqRS7DSvVOO3GixshUHva+byCujwm7y4USO+0A1BNHWMu+jhHaGk4ajTmCPXQsLnkhlfUKCl++Sj1gHUSOhKCpjXvpWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xg4Ab3r2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754295958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YadyPmR0dQe/epD1NUXfvpXcI1CVozsoweeY4VWaFzU=;
	b=Xg4Ab3r27ApEdtp0mXy3wYX/sGNhIVsYw8p/NmgoJh4Tp8TIkDvT/1yWEFZxCDFTlRTab1
	Ad57L7tI2E4wqc30bkgkOtrlWg4pzw1DtKHKVe3sKL+g1IEWhHdHGVicBL0FmMrzRUJDoP
	O0sulhfLh206DLwNnW34wrGV4wHpFI0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-6AyS_ue-NDaWxzBY3x3xZQ-1; Mon, 04 Aug 2025 04:25:56 -0400
X-MC-Unique: 6AyS_ue-NDaWxzBY3x3xZQ-1
X-Mimecast-MFC-AGG-ID: 6AyS_ue-NDaWxzBY3x3xZQ_1754295955
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-458bb0e68c6so8780105e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 01:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754295955; x=1754900755;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YadyPmR0dQe/epD1NUXfvpXcI1CVozsoweeY4VWaFzU=;
        b=VJXM1BLfjchY5p7iv+TC5wJs8pJLKewYIX/txFBGGYpuW1ioHzGSmHvVD7f+W390+F
         XnpTJgJ3bE9QcX/oEt1d9R5kOO3J8bzVmogQSxw+CMpecvsLudGZZI+Aq1Wxk4+MU9SV
         rcvY7zEZbQor2RwWA6JntgHI0DB5YSGwKNaSvxinrsWaxGw5f5pyzzCPHiqbklr7NhLv
         rX/dI7TvMx3xOXNAyCADQ4NEFGyQ1Rb/RcTnQeFeN53ATwCX3HEa/6TL3sZ0boA59YrJ
         KArLdHt857F8lyYuMrsAFw5TyYJ5yw5XFleWpz7aeHrH8+Wc4vp/azD0vzaqCaJTdMnq
         WgCg==
X-Forwarded-Encrypted: i=1; AJvYcCVnqZTUA9z3VjkGTKunrbLY/6L/emoYZE4lQOgLzhl8n7k15w3Nnnk8pRxIvplAzyrCvrn3VSvIQ82xQ1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+P5ZgmmHHTHXqcd4o4Q9Y085p5cDr4w3EH5eDR6N5lHuoiLV1
	twfNui9BprIj+uNU0wN9lUSNOa6KDL2QsnWX6lychQxHSicmlY75/MJpL4hw9he/RSW+8fYlf/8
	hVTK2AbLLdcU6TOPc1NKas9FVVLKb6Tf0mMca/kCWhoy5cyANecUt/+XZryYyG33ZKw==
X-Gm-Gg: ASbGncsxcC2R9hwu8qdrBvcJlA0dbEerM6r8tkfkiAJdg0kCcjXakqXIPVZ9JHTBK4s
	rH6LNtlKnPI4BFBGdg2ZfcZxlKXzmWvTD9KxRBtdFUqplFc745I2VVQEgsR8/dyLrIiPTpb7kDH
	4GqIQRc8A0JMITwbkMbi8GBsTSXhchkBvt/zpwgsk26gIt7JEmLJOCLAEwmoZmsUcNuzEb3Qwy0
	4XSJD5SeKGPQBtIBE61Gg+7PJJno7UsN10SRBg/p78f7qu+FeWemInAMSLP+8omExjUjzftSeKX
	1tEgNuHZW0Jm5Ap8pGKb+Mf5CE6P9KeoFVSPgHN9eOB02WH/fpYTweBaI5yxBr9PL34KHu+VYBz
	ZlF1XlDZ6pWBXhgDWaxrzmcr4rDWCSGeAh9tM2eFVUuSExUYq8eizlzHBUzISoQcbtrw=
X-Received: by 2002:a05:600c:1554:b0:458:7005:2ac3 with SMTP id 5b1f17b1804b1-458b6b34cb7mr62843965e9.21.1754295954884;
        Mon, 04 Aug 2025 01:25:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVo07/GjP+xQ7W9mHtwrvAbGwAzbvjOvrLEMx90aOibW103VrfdK7vNJDbsTMBmrNMWhDZLg==
X-Received: by 2002:a05:600c:1554:b0:458:7005:2ac3 with SMTP id 5b1f17b1804b1-458b6b34cb7mr62843705e9.21.1754295954411;
        Mon, 04 Aug 2025 01:25:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9? (p200300d82f0e2c00d6bb8859fbbcb8a9.dip0.t-ipconnect.de. [2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458b501f22dsm64751025e9.0.2025.08.04.01.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 01:25:53 -0700 (PDT)
Message-ID: <8c609741-c2b8-426c-8f83-8a79022b67d7@redhat.com>
Date: Mon, 4 Aug 2025 10:25:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/mm: pass filename as input param to
 VM_PFNMAP tests
To: Sudarsan Mahendran <sudarsanm@google.com>, linux-kselftest@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, trivial@kernel.org
References: <20250801234559.1178521-1-sudarsanm@google.com>
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
In-Reply-To: <20250801234559.1178521-1-sudarsanm@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.08.25 01:45, Sudarsan Mahendran wrote:
> Enable these tests to be run on other pfnmap'ed memory like
> NVIDIA's EGM.
> 
> Add '--' as a separator to pass in file path. This allows
> passing of cmd line arguments to kselftest_harness.
> Use '/dev/mem' as default filename.
> 
> Existing test passes:
> 	pfnmap
> 	TAP version 13
> 	1..6
> 	# Starting 6 tests from 1 test cases.
> 	# PASSED: 6 / 6 tests passed.
> 	# Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Pass params to kselftest_harness:
> 	pfnmap -r pfnmap:mremap_fixed
> 	TAP version 13
> 	1..1
> 	# Starting 1 tests from 1 test cases.
> 	#  RUN           pfnmap.mremap_fixed ...
> 	#            OK  pfnmap.mremap_fixed
> 	ok 1 pfnmap.mremap_fixed
> 	# PASSED: 1 / 1 tests passed.
> 	# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Pass non-existent file name as input:
> 	pfnmap -- /dev/blah
> 	TAP version 13
> 	1..6
> 	# Starting 6 tests from 1 test cases.
> 	#  RUN           pfnmap.madvise_disallowed ...
> 	#      SKIP      Cannot open '/dev/blah'
> 
> Pass non pfnmap'ed file as input:
> 	pfnmap -r pfnmap.madvise_disallowed -- randfile
> 	TAP version 13
> 	1..1
> 	# Starting 1 tests from 1 test cases.
> 	#  RUN           pfnmap.madvise_disallowed ...
> 	#      SKIP      Invalid file: 'randfile'. Not pfnmap'ed
> 
> Signed-off-by: Sudarsan Mahendran <sudarsanm@google.com>
> ---
> 
> v1 -> v2:
> * Add verify_pfnmap func to sanity check the input param
> * mmap with zero offset if filename != '/dev/mem'
> 
> ---
>   tools/testing/selftests/mm/pfnmap.c | 62 ++++++++++++++++++++++++-----
>   1 file changed, 53 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/pfnmap.c b/tools/testing/selftests/mm/pfnmap.c
> index 866ac023baf5..e078b961c333 100644
> --- a/tools/testing/selftests/mm/pfnmap.c
> +++ b/tools/testing/selftests/mm/pfnmap.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
> - * Basic VM_PFNMAP tests relying on mmap() of '/dev/mem'
> + * Basic VM_PFNMAP tests relying on mmap() of input file provided.
> + * Use '/dev/mem' as default.
>    *
>    * Copyright 2025, Red Hat, Inc.
>    *
> @@ -25,6 +26,7 @@
>   #include "vm_util.h"
>   
>   static sigjmp_buf sigjmp_buf_env;
> +static char *file = "/dev/mem";
>   
>   static void signal_handler(int sig)
>   {
> @@ -98,6 +100,30 @@ static int find_ram_target(off_t *phys_addr,
>   	return -ENOENT;
>   }
>   
> +static int verify_pfnmap(void)

You really want to pass in the address, and verify that that very 
mapping is a PFNMAP. (not something unrelated, like the vdso or 
something odd like that)

We have a helper in vm_util.c that might be useful: __get_smap_entry()

We also have a check_vmflag_io() in there. So likely you want to add a 
helper check_vmflag_pfnmap().


Nothing else jumped at me, except that phys_addr might be better called 
something like "offset" now.

-- 
Cheers,

David / dhildenb


