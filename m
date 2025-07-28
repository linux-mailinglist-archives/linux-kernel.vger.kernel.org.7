Return-Path: <linux-kernel+bounces-747738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0E0B1377C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D1A17893C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DEB2327A3;
	Mon, 28 Jul 2025 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/LFRk28"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B189722D780
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753694876; cv=none; b=eSixjLVzsfEiukrmZwmhgNcqv6c2cdoc+c3fr/3XqBZp8rpHKJc9CEqea3qW5Wmm0ypY0eHrZBz7r9IMM16+KB/FRIJ5ISN7RJCoT8Sr/YChWaBf37iEFlUWP0BT4TzMmT1Mv//UaHDh/6GVt/X2+V+EzgtCANiOlzktq0BMYPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753694876; c=relaxed/simple;
	bh=CnEpXC+2QXf/jygLciJCL2thcMWcQnXIrzxy7ZNifts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnagM31BAVMyvysyhz8OTFw/tUipjrFikbIHnyeh5oiQLCM8pVTU5NOMnD5YJdSVccuSupcWVdbDLI45/pdyaFGolj7UMS06faaHM69hl5hZNjknhtgbueLZfwXkYF1vcDKSy8JE7eK+IIwzcfd83bkFlljATcLcqHva1uPArK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/LFRk28; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753694873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Qd3ho0xhkRaUlk8qZ/1JG/g5MmKxyU61DPHZaLA/WVo=;
	b=K/LFRk28Rl+4xVXAgZ+X0YAeuIU5YpuIn3GGhPVcDqhCrMlQSa5WKcKR+Vc++TFLoW7njE
	mpI3bgKKmcnil58y9x6lsdsbcvHxRF472qA6W6vbjanOG4bCW4w9eYP3cG3Z0ISjcV3ce2
	h6+j+2VbfsFORg4QzYWqgCcXCZsVHvM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-iTAOtuzUPNa2mFpa1CobeA-1; Mon, 28 Jul 2025 05:27:51 -0400
X-MC-Unique: iTAOtuzUPNa2mFpa1CobeA-1
X-Mimecast-MFC-AGG-ID: iTAOtuzUPNa2mFpa1CobeA_1753694871
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45626532e27so23455545e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753694871; x=1754299671;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qd3ho0xhkRaUlk8qZ/1JG/g5MmKxyU61DPHZaLA/WVo=;
        b=gi8LKyWfhfllCE1r2dRjTWVVtV63vOVuohiUGxC70TyNwwOp+NUoL2aRDCH7E02nuf
         Jak5JrHRh28ImUbiKcLsOxtvCSeqcHHcFQqICb1Tz9cSkFNtdsW7tyFrCiVW/2qAIV2m
         KqXJQK5aqv1U2/xiqDBUorfrAmMql9wM0Gb5DJ8xsb0yGbbvDier8GWRmcExgmfxceFJ
         fxZMtEQisJcmirEtYBSF0KuKQAjHhqTj/KbCyG57+WW0SlIIskxXbjX79md44/zpXQh+
         sPybH+SGMrIN6YG07Qu2kC/9/gcz3d/+RgkWzKkV1Or1btJ+2oQm4WmLnbCiaY16TLNa
         jRIg==
X-Forwarded-Encrypted: i=1; AJvYcCUprwIeGxAt+hn3wXNegVt38YubHvmO11gFWOy57u+AmAg3OZOMirBEe+kQW/zYUUT4pJdkIik9CI0twCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8VTSRr6kOSvJhbUjDYwzWHjX3eXtJcI7RiVm6OWYh1ZSQ9t5C
	E/jds6xczlBjoTep25auoMxMBTHPjcdJuMO2DRNnGurQAj7ntUXq+nIhbtNWb56dh5a8ngtDk4k
	bosXvPoHNkr9/QqT4kLNlHcxapyuuo3Zm8frBqq2qzBGy7DEOXl52dBWSiSmZxpgh4w==
X-Gm-Gg: ASbGncuVUIudCBdhLbprUvCrpHyBGz4QUNWBsHji706vLPHqiCQN0uqV3P555Rx7LzF
	VoVID1kmDQmg2GeNEImWrQylVpjdvJifMIf62UtcNMbA9fU6DPAo1Bt2Qcd7iwKdOx81+5UdbXJ
	y9qFvACBPfbv23haESYWRQxNxTbAhlfst6ksEOk+2GAGrtGJXQAHtzvcdzdgEtcbYXAhkRuiR/i
	WcQ59+54bdes+T0t/SfZ40QKO75ZEoIl2TW6BHzOXGYw15Q/dmJMjw788OEzklVnIlXOMaHaoPo
	meIPir0TCn8PQ0F54qXMfYUbVbwWN8Bxn0Z04DUigRwnKHTTgtp//0Yky+9BZLXujpbR/sMEyPb
	geGQQIFiuwv1shxHNaXCN6ZvxjVWHv2EiXFGeMNR4JN1jmnpS3UFt8XzjtuzoPwF2k14=
X-Received: by 2002:a05:600c:518d:b0:456:24aa:9586 with SMTP id 5b1f17b1804b1-45876449ee6mr68876555e9.21.1753694870613;
        Mon, 28 Jul 2025 02:27:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyu1Dt7Uo9UIyvbtz+W91+r3HRJvRcKffDbi2nS/vhSlU8gS1YZVF3+zzKrnNrFQcmWmVuHQ==
X-Received: by 2002:a05:600c:518d:b0:456:24aa:9586 with SMTP id 5b1f17b1804b1-45876449ee6mr68876375e9.21.1753694870107;
        Mon, 28 Jul 2025 02:27:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:2b00:c5f3:4053:2918:d17c? (p200300d82f472b00c5f340532918d17c.dip0.t-ipconnect.de. [2003:d8:2f47:2b00:c5f3:4053:2918:d17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586f88ce71sm119424165e9.0.2025.07.28.02.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 02:27:49 -0700 (PDT)
Message-ID: <9afd157a-296d-4f4d-9d65-07b89ab3906f@redhat.com>
Date: Mon, 28 Jul 2025 11:27:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
To: Vlastimil Babka <vbabka@suse.cz>, Sasha Levin <sashal@kernel.org>,
 corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org
Cc: josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org
References: <20250727195802.2222764-1-sashal@kernel.org>
 <75d86e96-cb18-4996-998c-da7ac0e97468@suse.cz>
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
In-Reply-To: <75d86e96-cb18-4996-998c-da7ac0e97468@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.07.25 09:58, Vlastimil Babka wrote:
> On 7/27/25 21:57, Sasha Levin wrote:
>> This patch series adds unified configuration and documentation for coding
>> agents working with the Linux kernel codebase. As coding agents
>> become increasingly common in software development, it's important to
>> establish clear guidelines for their use in kernel development.
> 
> Hi,
> 
> this series seems to me somewhat premature. I think we first need a clear
> policy wrt LLM usage for the *humans* to follow. It seemed this thread [1]
> was going into that direction wrt usage disclosure. BTW I was quite shocked
> by Steven's reply there [2] that he learned from the LWN coverage of a
> conference talk that he had received a patch fully written by LLM without
> any such indication. Now I'm not naive to believe that it's not been
> happening already from e.g. first-time contributors, but if that coverage
> was accurate, the patch came from a very seasoned kernel contributor and I
> really wouldn't expect that to happen.
> 
> Also I don't know e.g. the copyright and licensing implications of LLM usage
> beyond, say, a smarter automplete are clear? (again, such as writing the
> full patch?) The thread [1] touched on it somewhat but not completely. If
> that's clear already (IANAL), I'd hope that to be also part of such policy.
> 
> I know that your series has patch 4, but that seems to be part of what the
> LLM is supposed to include for its prompt (does it make sense to call it
> "legal requirements" then?). If it fails to e.g. add the "Co-developed-by:"
> there seems to be nothing saying the human should check these things in the
> output.

Exactly that.

I want to have it clearly spelled out that if you're submitting AI 
generated code that you don't fully understand and have reviewed in 
detail, then you are going to have a real bad time around here.

I don't have time to talk to an AI chatbot through mail when reviewing 
patches, because the submitter doesn't understand what he is doing and 
blindly copy-pastes my replies to the AI.

This must not be the new mechanism to DoS kernel maintainers with AI slop.

I'll point at the approach qemu[1] has taken, which is probably a bit 
too strict, but raises some key points regarding DCO, copyright etc.

[1] 
https://github.com/qemu/qemu/commit/3d40db0efc22520fa6c399cf73960dced423b048

-- 
Cheers,

David / dhildenb


