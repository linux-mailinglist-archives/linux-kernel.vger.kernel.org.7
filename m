Return-Path: <linux-kernel+bounces-755226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E032B1A341
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB98189E0F2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20DD26A1B5;
	Mon,  4 Aug 2025 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aV10/xFW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AB42046A9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314254; cv=none; b=CU423iXswNrwZoUUdICRT7iESs2YX/FtBGu/d3oCRULeuwlKZk7hRpf1EShlPN2wBmra9uoRP6axwlNa+UL4ahDPuer8si1gV+3THvOkTB0dyPiWwBTcDzz/rZ/iwcS0ScT8miXk0rTGIugqbVaFpw3FWgl5UYIntsPO5JY9ZN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314254; c=relaxed/simple;
	bh=KsKPSW5uLatRDrMoZ8WQxGb4v5Zw42HcxGCX7UoZyA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p27nnNZSMPZ0B1rUVtk1SMmJ+Qqo11C4w7KpKRkeggxhytuoe4brUBrj16boifxyWCjkC5ms7aAXImlv0cKW5JM8WH7SHtOg8alU5QlbrMy8wdxGO+CeJGM7gZYfOw5/xaMRRiiE1eiMKuS8J0yYCFUHHaXBGuoYZMWcUNXX5mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aV10/xFW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754314250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Vvhpej7zDRDY5Vkw5faz8KiFpnwTv2FvUntY/b2AYdQ=;
	b=aV10/xFW3t/AMFXR5Vq+M0WCesr321ZFa1XWEellJv94ydc0nw+8kPpjaTMHTHCrHhw6WY
	SF24IqxBIsK/I1GUS9fGnArJSawfWOoKFsYqCzf+KKfrsrOX9rc8TwW9s4VvCbARwMGUhp
	qdR6NH7jbgR1p6WhpiRryHE1nSbl0J8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-p9hrOlR8OXWsjfPPvNxFow-1; Mon, 04 Aug 2025 09:30:49 -0400
X-MC-Unique: p9hrOlR8OXWsjfPPvNxFow-1
X-Mimecast-MFC-AGG-ID: p9hrOlR8OXWsjfPPvNxFow_1754314248
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-458a31421a3so16058705e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 06:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754314248; x=1754919048;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vvhpej7zDRDY5Vkw5faz8KiFpnwTv2FvUntY/b2AYdQ=;
        b=nPLYyq8MrAQtQsqwyDb5vhFyLY5bSDPB2UCkYNC9Ub8aHOdxwfw3clgzYrySef81CQ
         pTBHCPTrhqK5caDbv6f3rzAssa+Z1Q24sIruxux3CEU82R/yPyD5WwEXbih3FSKoHE0A
         xQfzrHHvYzZ5KdjfxjcKubc56T5GWep6xoh9fR31SmRrMp+/DSJb3gvvKMbiq+Xo4Kk/
         Tg+8SpDL/+jJe8cR7OXPgTgVMB62RWrwrCyxPy3pd0DW7FoG9tPB3T1hoZYWxT4/CQSt
         i0uypkzovVSEF+IQoXIYODX2AiCwVbvrYA1H74qdl4/lxyWElB/BVJTmtYmgrpPp7Ds4
         Ib2A==
X-Forwarded-Encrypted: i=1; AJvYcCWJYCm+NgDfncqNbw9e6A5Zs2XGDxxlli7rJF6KbFFy+cLs8VPqMnZkCvw4d+gn7deFNCBIWqZ27KUYtBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzobuR9NEEy+Dc6YdYIwxH3W2S476zm0wR7bdy70mQ2HCTwOvke
	2H8+AfYpybFzt2+BA+nb7N5w1QXAw5YnBXZqnF2oxB0XwEH4ZbVsuCUMlSLDmNEhoWWZc2fA+6c
	ESjKMZR5YAnV1F90STxcLfAA3/QFecXbUq+L226TnmA5FXMsRNzOw5AtCpNpNho3XxQ==
X-Gm-Gg: ASbGncvZukCu81AfqNA+UMLyqMiOkLBIOFe9cvHmAzCnVHHqVPUaADMi6WD2hkk/vfx
	2nL8Pr/gAV1r9C/bDfQ35EVU7VBy376T71Mr0wNch+Txwf1I2GP0PiuIHXeRjIfzgmeWb/9td2w
	CCYRtQAH5mn5uIHBQwqzxNBdJfHwUEV1QXJEHZyjLtd7hL3/7R9vrUh6yn4zu2fACwWHsxUC/kv
	tndTsFclkAhBKjpmMwqqGMTFyegCIEyg6O4DzAjTn3iEY65asqIgKOnUelOc8OYOo9gEhe0tF0P
	WF1uM7Su7ge7WQwQF37mHYChpAAgQWRfeIlYv3AUeTlF5zHWB5GbgOlvq78TFVRN+pksa0yV48B
	ut0ySpoom14XuSpFasEj684k8eneFxvS1WQ0ctdwrIJERKssob614weE5r2PcuBWtPGI=
X-Received: by 2002:a05:600c:4b83:b0:458:b7d1:99f9 with SMTP id 5b1f17b1804b1-458b7d19b72mr46605135e9.11.1754314248398;
        Mon, 04 Aug 2025 06:30:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzuOY12ZPySBcdjFiF+290XjA8R4/34W8j6JzHtkny0pl9OyWI1HNApFH1U96JzLuL64DQRA==
X-Received: by 2002:a05:600c:4b83:b0:458:b7d1:99f9 with SMTP id 5b1f17b1804b1-458b7d19b72mr46604595e9.11.1754314247170;
        Mon, 04 Aug 2025 06:30:47 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9? (p200300d82f0e2c00d6bb8859fbbcb8a9.dip0.t-ipconnect.de. [2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4533f1sm15800765f8f.42.2025.08.04.06.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 06:30:46 -0700 (PDT)
Message-ID: <74580442-2a9a-4055-b92d-23f5e5664878@redhat.com>
Date: Mon, 4 Aug 2025 15:30:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: memory: Force-inline PTE/PMD zapping functions for
 performance
To: Nadav Amit <nadav.amit@gmail.com>
Cc: Li Qiang <liqiang01@kylinos.cn>, Andrew Morton
 <akpm@linux-foundation.org>, "open list:MEMORY MANAGEMENT"
 <linux-mm@kvack.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 lorenzo.stoakes@oracle.com, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasarya <surenb@google.com>, Michal Hocko <mhocko@suse.com>
References: <20250804123923.296230-1-liqiang01@kylinos.cn>
 <c441e6ee-3118-4603-8c77-c5b2ef40982b@redhat.com>
 <9D248293-2456-4642-9F18-8075F0596EC2@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <9D248293-2456-4642-9F18-8075F0596EC2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.08.25 15:01, Nadav Amit wrote:
> 
> 
>> On 4 Aug 2025, at 15:51, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 04.08.25 14:39, Li Qiang wrote:
>>> This change converts several critical page table zapping functions from
>>> `inline` to `__always_inline`, resulting in measurable performance
>>> improvements in process spawning workloads.
>>> Performance Impact (Intel Xeon Gold 6430 2.1GHz):
>>> - UnixBench 'context1' test shows ~6% improvement (single-core)
>>> - UnixBench  shows ~0.6% improvement (single-core)
>>> - mm/memory.o size reduced by 2.49% (70190 -> 68445 bytes)
>>> - Net code reduction of 1745 bytes (add/remove: 211/166)
>>> The modified functions form a hot path during process teardown:
>>> 1. zap_present_ptes()
>>> 2. do_zap_pte_range()
>>> 3. zap_pte_range()
>>> 4. zap_pmd_range()
>>> Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
>>> ---
>>
>> What's the object file size change?
> 
> I think that Li wrote that the size is reduced by 2.49% .

Ah, missed it after the performance numbers. As Vlastimil mentioned, I 
would have expected a bloat-o-meter output.

> 
> My 2 cents is that usually it may be better to understand why it is
> not inlined and address that (e.g., likely() hints or something else)
> instead of blindly putting __always_inline. The __always_inline might
> stay there for no reason after some code changes and therefore become
> a maintenance burden. Concretely, in this case, where there is a single
> caller, one can expect the compiler to really prefer to inline the
> callees.

Agreed, although the compiler is sometimes hard to convince to do the 
right thing when dealing with rather large+complicated code in my 
experience.

-- 
Cheers,

David / dhildenb


