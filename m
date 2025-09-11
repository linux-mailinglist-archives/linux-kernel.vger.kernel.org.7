Return-Path: <linux-kernel+bounces-812470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE9DB5388D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06655188EF53
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B8034F497;
	Thu, 11 Sep 2025 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLK+2vUl"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1720A38DD3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606431; cv=none; b=ByYPkW3GNUdNetbN9ilxRZBtbA9ZWys8ezMSyNsb5hn4jQ2hqPLww/JYyywxc1Cb5pZHgGl7D+rt8f0RUbCOAOUxrLJ0T8hoIqxuMM0NLSIRw9jV66ylGgez86GYdh9w0gKGU66B8PrizNMsDAqFFnnqn/nZBg4ptTMEiyTy9wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606431; c=relaxed/simple;
	bh=PD/FI/pmd9ph95fgxp5hRItvoi/pLpBLehKGW/dS3yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZt1mfyEgYZrFmxTuv/4Wt031Jb0u0c6BeywEDBHfgy26XBeY7oGuwB1Abww78/h7UuyCZbsnybmjFKu/hjbFvXeUTMJfpmMuSkKUOoX5qE1h+JhltEJ8G9wSnf1Lxa+R6MXuVj5FKE5ETY925vMAaCfV2crxLG9Cw4ep21LAYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLK+2vUl; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-723c971b63bso6759496d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757606429; x=1758211229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2V6Ly8wut6TjSsWUqfM+DfRRL6BttFfoiFg8qrKV2gs=;
        b=iLK+2vUl6X5O4b6lzjFhxfonn5O6BmZm/Dz9K3Oseh2ceQc+m68seAUIh0w74BbSYo
         d26g+dT8A1Vj4Pmr6enBs14GrE/rr1RYpMgYNb+UpmAN/G+kAJc7rNl7fkmZYQJ/ogUz
         6cOtQtZDSrLfgEW27j/g6PpNeQgYKDjxnRDfLuOE2w0XUCmNzgYCxtAdW03hWpeD/EMa
         SRr4puN8Nb8bjd16IA7uHzJKxvOgEzwtChRosKarx4lDfBwQfxZAeQEyO5M2RqN1f99K
         a4aaBn0YtyUufF2YGTpIqfUW8UfglO/hU0Tt9XvnFqXPDP4MpXcn69n0n0gMOB5xOT6g
         SBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757606429; x=1758211229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2V6Ly8wut6TjSsWUqfM+DfRRL6BttFfoiFg8qrKV2gs=;
        b=Djoyqp+g7klzJKYeZkMprDhkMzRBrDq3qiusrkSFkQgyc2Kq6epU1mwThtWfXLXJYN
         xoueqa4eV8G9MUh6JBeyhdVBZQS+n8WUEcKbmX59vf3p1Mm6riiv9kaNSV1rlU2ZNYri
         N88/oS8GwYERpFCmGZicPqnhSp1Ks5eFt3ly5Rd0XPIPCGWgmp3BQAnqmp1I7ZW3BqR6
         jLwi8woVZ9hFyuLOFHX8S4doaihZdD2AKWKtswkhONjpdHpz3GRxZd/M8SO+FFixqi+D
         0f3Ut88pVrcg7ddUaCr9P8n/s0fRuW+Rcf2q/SydVWtqZpxb1UyXLh7akT9yxzd5mqt0
         UPmg==
X-Forwarded-Encrypted: i=1; AJvYcCWLGAk2OU0hf8CXsiE78GyZRaAgQmhRSZADb9ghz3dyxtUVSlIAYsfMv4X3hQnMFkWStQXrZyDfKUCU57k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkMllPiLLCOKQNf8zvNSs3see3b++bL2T9Rn1hRHusFha6HM6M
	4VinGpifrNfQ2HItnjH1eiXPQIPm6iOjR0uq1xdsBaZXNU5baWq5cPD0
X-Gm-Gg: ASbGnctc02nAmUpKVfLGaVwR/y/RzvJWcBTraYz1GPgDvP8uxxj9Q/mDvFs7w2L3deh
	GnJ2++BJvjMyPDiLV6sBVTOWQUIGyCZ7YpbG6GowBRXzPfhV0NxbKjusQOa6ZA5f1PVPAkYpJbt
	Ty7o29XzMG5N+Gkyom964DEhIaR3h63vK/NwwtWIzReU8/I7g7RiHc0FIL0C01TVRkJFxoSimEH
	pQ2YPjcj/bFuoHqX6qB5S97nzNBKVv3ilOvAod64leT/mwr0kPzdn5KoA3mGKV5Sd5hsnnGo/G+
	9o/ZLSaMI/OZ4CoaYKLebl2Ju0ST2n/Mb+Pn5T/vOwfeN3R10M2IJ+b6aokJTa7NsG+b6U5FEu7
	eMDzkH+FpHqRKUxd/gsXDVLvv5FhbEwh6R26j3zDZ8pznlbs6HNNiCIF5DLvOM6+73Y8Pbze6s0
	bCYA==
X-Google-Smtp-Source: AGHT+IH92AYdKJB1ynLJH9ZT+vCjzmP7qU2FX7m29cFy2od6zEeX0Ch7ZKM8aLmHgcXgjZIwQiQSxQ==
X-Received: by 2002:ad4:5b8d:0:b0:70f:a42b:1b65 with SMTP id 6a1803df08f44-73943d7d1dfmr226888706d6.66.1757606426756;
        Thu, 11 Sep 2025 09:00:26 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:1456:e851:ddd5:be9f? ([2620:10d:c091:500::1:8948])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763be01498csm12891126d6.48.2025.09.11.09.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 09:00:26 -0700 (PDT)
Message-ID: <902f5f32-2f03-4230-aab0-a886fd8e4793@gmail.com>
Date: Thu, 11 Sep 2025 12:00:23 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
Content-Language: en-GB
To: Yueyang Pan <pyyjason@gmail.com>, David Wang <00107082@163.com>,
 Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz,
 hannes@cmpxchg.org, rientjes@google.com, roman.gushchin@linux.dev,
 harry.yoo@oracle.com, shakeel.butt@linux.dev, pasha.tatashin@soleen.com,
 souravpanda@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250909234942.1104356-1-surenb@google.com>
 <20cafc1c.a658.199394de44e.Coremail.00107082@163.com>
 <aMLvCCZbmpSE/aql@devbig569.cln6.facebook.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <aMLvCCZbmpSE/aql@devbig569.cln6.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/09/2025 16:47, Yueyang Pan wrote:
> On Thu, Sep 11, 2025 at 11:03:50PM +0800, David Wang wrote:
>>
>> At 2025-09-10 07:49:42, "Suren Baghdasaryan" <surenb@google.com> wrote:
>>> While rare, memory allocation profiling can contain inaccurate counters
>>> if slab object extension vector allocation fails. That allocation might
>>> succeed later but prior to that, slab allocations that would have used
>>> that object extension vector will not be accounted for. To indicate
>>> incorrect counters, mark them with an asterisk in the /proc/allocinfo
>>> output.
>>> Bump up /proc/allocinfo version to reflect change in the file format.
>>>
>>> Example output with invalid counters:
>>> allocinfo - version: 2.0
>>>           0        0 arch/x86/kernel/kdebugfs.c:105 func:create_setup_data_nodes
>>>           0        0 arch/x86/kernel/alternative.c:2090 func:alternatives_smp_module_add
>>>          0*       0* arch/x86/kernel/alternative.c:127 func:__its_alloc
>>>           0        0 arch/x86/kernel/fpu/regset.c:160 func:xstateregs_set
>>>           0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fpstate_realloc
>>>           0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:arch_enable_hybrid_capacity_scale
>>>           0        0 arch/x86/kernel/cpu/amd_cache_disable.c:258 func:init_amd_l3_attrs
>>>      49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create
>>>       32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func:mce_gen_pool_create
>>>           0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mce_threshold_create_device
>>>
>>
>> Hi, 
>> The changes may  break some client tools, mine included.... 
>> I don't mind adjusting my tools, but still
>> Is it acceptable  to change 
>>       49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create
>> to
>>       +49152      +48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create*
>>
>> The '+' sign make it still standout when view from a terminal, and client tools, not all of them though, might not need any changes. 
>> And when client want to filter out inaccurate data items, it could be done by checking the tailing '*" of func name.
> 
> I agree with David on this point. We already have monitoring tool built on top 
> of this output across meta fleet. Ideally we would like to keep the format of 
> of size and calls the same, even for future version, because adding a * will 
> change the format from int to str, which leads to change over the regex parser 
> many places.
> 
> I think simply adding * to the end of function name or filename is sufficient 
> as they are already str.
> 

Instead of:

49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create

Could we do something like:

49152      48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create(inaccurate)

This should hopefully not require any changes to the tools that are consuming this file.
I think it might be better to use "(inaccurate)" (without any space after function name) or
some other text instead of "+" or "*" to prevent breaking such tools. I dont think we need
to even increment allocinfo version number as well then?

>>
>> (There would be some corner cases, for example, the '+' sign may not needed when the value reach a negative value if some underflow bug happened)
>>
>>
>> Thanks
>> David.
>>
>>
>>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>> ---
>>
> 
> Thanks
> Pan


