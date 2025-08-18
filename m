Return-Path: <linux-kernel+bounces-772928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D69B29965
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC25B3B4005
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1FD2727EC;
	Mon, 18 Aug 2025 06:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvhgC83U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E9D2727E2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755497346; cv=none; b=efePsFfu/W3at6wYA1o3IU6hMZP/WP22EYAkGnVwsqUxcN03EuhCZLuKi70dud787BudAg1zP36NzEcTTz+cR7gF5cV1OfLyyuZ3aM3Jijgco2Nir++gRdk2zYs8hbeL5AiuihTbyWHKff2+szSOiscHCZNQpKLmoXDPtBcA9+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755497346; c=relaxed/simple;
	bh=ASUNCBw00ZAEwyfo454/M2wUbo6uA4zt9LHCxSxi8b8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYCHeHMUa6jhxf7tmvDhkIZVvOHEAg458fMTbMZQ55hDFoP7BM+vj8w/nVrir0MDHiIiNCI18IEbKRlttGxYqx3T6vUvyAbASGWBUms+U5G1FOs0nZiqzCGHg7zr63XG7pXasU0zF8wwDYimsJAlXCFNVANVG7dQ3Ibck1o3l8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JvhgC83U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755497343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ilfNOSXpmB/eYq3cbXUlvKiZ0NGf6LLnNw90QesFLBE=;
	b=JvhgC83Urqz8WYeVHwTZNtnPWVFVIABvvcsGJrGmmOL5zL3vp1ASn6SVShYUyyKnTFDa9O
	qUCbaKVwLFUXYykm2odCs9egB2nthdzJCQBoBGu3GVoF8QTwi5EjJYuQeSj+gWvc1e6B9w
	hDCISkT9DDXNnh3D4/Z2Kpfz5zF8NFo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-VQvAdGxNP8iKESjvhkAPWA-1; Mon, 18 Aug 2025 02:09:00 -0400
X-MC-Unique: VQvAdGxNP8iKESjvhkAPWA-1
X-Mimecast-MFC-AGG-ID: VQvAdGxNP8iKESjvhkAPWA_1755497339
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109bc103bso110276431cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 23:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755497339; x=1756102139;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ilfNOSXpmB/eYq3cbXUlvKiZ0NGf6LLnNw90QesFLBE=;
        b=rBsAmJOhWDyo1i4hkBLZa404o+84RqUUDJgiCwpWdbCw+A9UmabGbDSpvRKcnCKler
         lLDIojpHXbsP6kBQWI7SxKIZ1O5ZG9ywTMidpJ6GaBpSwEiHQNQWW67fMVJDW9nc7yjR
         QeOzFH5UdaCHN3+jwY0B9Z4mY8bjH6pZYCt+CxJg9TOp3dOFL7p3rSw/SgqSzjXQCrbn
         B4wTnYtc9kCtDqrSQVIt5Sl3IMupTZfBTi9QiJie/YZKvT3MzC8Vgo9QIun+hJ65kQhe
         D3Uio+ieJl9gsfZjwzlgdpDg5DdGPTdyML5KkWbomCE4SY9tqcjBE0tbJ34lWD70R891
         K4Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXA19/B0AMJ2vtn4iaPrIMx2f5Eg4LMRgdQWg+/GgIo2AV2X7jy7M/QBb/93H5gMmaiI9imH60B3i8N4sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCUnUe1bor3SBzBTGpM1XfMyjVbXpu0hf5cdv6mMKhzYP1lbZx
	y00QCtY7RS2nhsYSA6Hwr24515bW9Uc9JNZtr/xqAnwdWA5q3czqxUqvOrXiLnk+uNL6sn51YnX
	2HsXD6vA2QweOsvdng5KveLQkMmlV0idEGJXeSEPBIKghV9dvJgjz/L+Or01XQXtv0g==
X-Gm-Gg: ASbGnct8HBN4a1//cdhnGqB3jW/6I/NqOiwjkkFrDj7+lZJrdLDhpXnnBJTOFSe6PDS
	JkmNEqQ2Yg57Dr56TXzv0tYFSdtL/yoGQw0Hn0L1nD26Sy8TJgSDgA5Xfu35FuoEd0Wm8b2EIzm
	OBBE/+gVxCheIvqBvDppXfO2TYUmkXRb1alKCqpQ1m6/CU0hifR+nrrQO9eTlZXg9wD1i4X1NFs
	jpLI09lfuueS2r4CX7ebR0xdDQci4GWufp6FW0rtm60zYyARlVZggjDhGhx7u2MrQUw2MDnf0yA
	KTgCwAsvtmntgy0+GTGWncKOYx+4l7hwjg7gtXpvbyInk2PmLm5s0UPmblhjBzU1glymTHWBmON
	nENE=
X-Received: by 2002:a05:622a:4d0f:b0:4b0:7439:4578 with SMTP id d75a77b69052e-4b11e2747c9mr137102501cf.33.1755497339479;
        Sun, 17 Aug 2025 23:08:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1I1mVyzHOHlHnpVFQ7/VLzhHJrTwCfwPwbcObGfoLuOQESoX7BOBqeE6GF2iKiWwcfgOk9A==
X-Received: by 2002:a05:622a:4d0f:b0:4b0:7439:4578 with SMTP id d75a77b69052e-4b11e2747c9mr137102301cf.33.1755497339094;
        Sun, 17 Aug 2025 23:08:59 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-113-055.pools.arcor-ip.net. [47.64.113.55])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc1aa56sm47525081cf.7.2025.08.17.23.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 23:08:58 -0700 (PDT)
Message-ID: <d1fe7fdf-b3da-4c53-8a5a-a87acd38d525@redhat.com>
Date: Mon, 18 Aug 2025 08:08:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] riscv: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 header files
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 atish.patra@linux.dev, anup@brainfault.org, linux-kernel@vger.kernel.org
References: <20250606070952.498274-1-thuth@redhat.com>
 <175450055499.2863135.2738368758577957268.git-patchwork-notify@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <175450055499.2863135.2738368758577957268.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/08/2025 19.15, patchwork-bot+linux-riscv@kernel.org wrote:
> Hello:
> 
> This series was applied to riscv/linux.git (for-next)
> by Alexandre Ghiti <alexghiti@rivosinc.com>:

  Hi Alexandre,

I can't see the patches in the for-next branch ... have they been dropped 
again? Was there an issue with the patches?

  Thanks,
   Thomas


> On Fri,  6 Jun 2025 09:09:50 +0200 you wrote:
>> The kernel Makefiles define the __ASSEMBLY__ macro to provide
>> a way to use headers in both, assembly and C source code.
>> However, all the supported versions of the GCC and Clang compilers
>> also define the macro __ASSEMBLER__ automatically already when compiling
>> assembly code, so some kernel headers are using __ASSEMBLER__ instead.
>> With regards to userspace code, this seems also to be constant source
>> of confusion, see for example these links here:
>>
>> [...]
> 
> Here is the summary with links:
>    - [v2,1/2] riscv: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
>      https://git.kernel.org/riscv/c/c47963980ba6
>    - [v2,2/2] riscv: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
>      https://git.kernel.org/riscv/c/b5eb1f12a416
> 
> You are awesome, thank you!


