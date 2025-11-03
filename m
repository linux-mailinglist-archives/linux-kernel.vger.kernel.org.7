Return-Path: <linux-kernel+bounces-883301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03525C2CFE2
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6383A4E48C2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E373019D6;
	Mon,  3 Nov 2025 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZ1YhI+0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="imMrcZHC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632F728750A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185953; cv=none; b=Wq7yfhBtLYVT1WQhPoKQlP6JR1XsM9sGXDMlvQDnQQLiRaW5+fKYxeg91YKkAvEs2MvoYyIL/JvTBCjmlaXvKtHeyt1b/wQVpBGcAbwCtlcYQDzZFyW6/rUu1XewZbnn7aVkgXfaMogA7AvNhrVsfLIzKahgBt4TAZ6I/KyNAhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185953; c=relaxed/simple;
	bh=JLZsTfOQxbmf1yQ6RbEFbJ/4JPPfHYrqTcg1BYiIM1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bFrogqIXaWws6gd/Hcb8kxdbq+NR4EqzNtws/ECQJGX2YxXc+40YugBepvHB+hkXdNpAP2qQWAWLB5uH21igyZNpsFF+JGZx0KVb+Sq/zNukZV0IQ2jJhEmYKjb328F1cY2WblNCwHCmZkTmnPSvFyYoIy5ZWCuQwOT4BNYpszc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZ1YhI+0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=imMrcZHC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762185951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h7zqPFP4se4OIaFzLrGpOU2VTLQJoOSY+ZZS4O5etWY=;
	b=GZ1YhI+0vheznP97r8VVrzWD/XaZaaakFGBt+o2PsIecgnOrNwAWioddfNdA/VcQQ8L1vl
	Qk0mjyCAcgL4RiMUmDWieVRmz4gjDwX0ULMnpw+TLXRMIZxIZALdFNZ8ba2RLjl5y3hnmD
	W1MxUGl5yoLtd5VwKSjJGZW9puOKBAo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-mXom1hUqP4eBBmvetOTHOg-1; Mon, 03 Nov 2025 11:05:49 -0500
X-MC-Unique: mXom1hUqP4eBBmvetOTHOg-1
X-Mimecast-MFC-AGG-ID: mXom1hUqP4eBBmvetOTHOg_1762185949
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429ca3e7245so1246295f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762185948; x=1762790748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h7zqPFP4se4OIaFzLrGpOU2VTLQJoOSY+ZZS4O5etWY=;
        b=imMrcZHCA6Btw4YtN9m+TYOm1hDK8Gf33dG0sOCYaY6QRBAeGt84qGJgdqGkj2dQVV
         /cWLL+HEgfxGiPosiO0xp1jIMDQxMArq3TOjNE1ZBoAY1Lu2LYtKoq67gUEsX3FmvPSF
         EmARqfywCz0KI9KiPAaMiw4T65UymXzmiEkkCdkkWDgfB+BDP44uyJbeWs0SggG6nnxN
         git6IiSBaVDbvfO7IIx4gmBH3ZMtjrldTJgSNv69BS4jn2ZAO+5oxnVInDG7b3UNnk6o
         IatQtRxtxhd4nAZi7HbI0LyFhMzXdrGYW7A9RJKUzw1hT7A4ge30NWwstt0J0x4sK7SH
         sM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762185948; x=1762790748;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7zqPFP4se4OIaFzLrGpOU2VTLQJoOSY+ZZS4O5etWY=;
        b=WpbNQKjYVXuUPd5FueSD0fW3C2wAjhJP3jc98ToHQ2SeyOjjznxlYa8MwCdBtHE2wq
         /i5so66zPjqOrsINyy0B8PQEOUzfwq+sAUpUqJHs/2iPApTyR0pxSD2yO5DFMXPfsx0D
         reun9E3/5mRPPtLpDOEhD1/dJwoTXK7nWiGvNJViwSO4Oaii2rj3fmVyhkHEYc8QLAiN
         r6kaQaDkEVVzM6cCZ2VMDbqQJq2Eka7je9NzfzHIBwwvMuCmI+ubIqJ/SMQdl7rE5la8
         W5lR6afo7DpJJd1CY83jzPrmdjX9AA8t+vv6RY7Bg2FudQoK8khOllOGOd2GSz5YSuRW
         WRSg==
X-Gm-Message-State: AOJu0YznFbGQ0ioIYDKk04Nlc68j6gxFBSF9eXNLj/NAYpwkv4UrN7kU
	s9Rrh/kV4pYSTSUpoAAK3cISR7gnqrHhgfhvpDQClcZtx4iXbYWy9mgQd9q8ESV7rgzYXwFQy2O
	tCqDpiwtOKpxTdo48EOmgm4xcvJD8xPwFBw9gAGpYyaGPR9l+UuUEC/w4EpoV7T8JaoWgpDAdzg
	==
X-Gm-Gg: ASbGncv+DJUnLXEbe2Wus76hq8LRmL5VwyxBUK2SRKC52PCkc6HgI0jPBjtkxq5Guwz
	Svy/FEYIiDGQVpjI6OMNZsu9ATo7lEl2ubs2PQ6dbmFor+YkeWCWfsIn++dXyofg9oyjznRxlUK
	TrtOKQ69x4xMEwKpqCvlQb6a9+Ti/wkDtmZJX7XY3gZ+QQpovmRzsmKsqs/1xVVtf8Tzk2smp7p
	24LlX5SLmBudSkhyEIeFLdiNKzQ1qE6PmbCwfh6UZdwKC2kJi+J2FTxiBUY8TwOPbgU0Tkg8dqL
	MzHV8NX29TEpaHFxFIxEDuzPkdNrgo+Z6eggJJGBRr+vLozEkl01TuIcKd1DyMiHD1dESHy/blC
	0vJM5nBKrwOdNplaoxXDDdiP0tC56+2a4USDZcHzbHY/gvjyT+JPpkDxl1eYDe79aZdWPhBe+SK
	AcaBAx13YBQuPH0rnp80nABxAgYvk=
X-Received: by 2002:a05:6000:2411:b0:427:928:789e with SMTP id ffacd0b85a97d-429bd6d583dmr11477140f8f.61.1762185948256;
        Mon, 03 Nov 2025 08:05:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFc7QNXPV2goDccZBoudQ7Gvk8PWg7e8ZaWNXwQcsQ4X2jdmxCnoJTtoWX7k3mSPaCwOvUqEA==
X-Received: by 2002:a05:6000:2411:b0:427:928:789e with SMTP id ffacd0b85a97d-429bd6d583dmr11477100f8f.61.1762185947708;
        Mon, 03 Nov 2025 08:05:47 -0800 (PST)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c102dfd2sm21748638f8f.0.2025.11.03.08.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:05:46 -0800 (PST)
Message-ID: <05e2062c-1689-44e7-9cc6-697646ca075d@redhat.com>
Date: Mon, 3 Nov 2025 17:05:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/12] powerpc/mm: replace batch->active with
 in_lazy_mmu_mode()
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
 Juergen Gross <jgross@suse.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251029100909.3381140-1-kevin.brodsky@arm.com>
 <20251029100909.3381140-10-kevin.brodsky@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251029100909.3381140-10-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.10.25 11:09, Kevin Brodsky wrote:
> A per-CPU batch struct is activated when entering lazy MMU mode; its
> lifetime is the same as the lazy MMU section (it is deactivated when
> leaving the mode). Preemption is disabled in that interval to ensure
> that the per-CPU reference remains valid.
> 
> The generic lazy_mmu layer now tracks whether a task is in lazy MMU
> mode. We can therefore use the generic helper in_lazy_mmu_mode()
> to tell whether a batch struct is active instead of tracking it
> explicitly.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---

I suspect you were not able to test this on real HW. Some help from the 
ppc folks would be appreciated.

LGTM, but the interaction with pause/resume adds a bit of complication 
on top.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David


