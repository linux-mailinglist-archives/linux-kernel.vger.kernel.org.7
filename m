Return-Path: <linux-kernel+bounces-734628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A81B0841D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C315F7B1BFF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF232116F4;
	Thu, 17 Jul 2025 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AmR6Xe6J"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFDE201006
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752726937; cv=none; b=Et8iiU1XAEz7UhCATe0fh29L8JglKx+CQwmE5BgpnAx3tOP81sAmRmEb9PS0IdVvJ7vJ9OXbm7Pw5u2rEYYdxyiYDrzqbc65Ym3Y9FImMyA1zAZlRPB1Bp9kAGY3aOdwjG/08hYr9rxrEYvTo/d3Cte8ZLrjmhW8S+3SGIXgmLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752726937; c=relaxed/simple;
	bh=aelM1514d0Il9ZnK5gacSNZ68N+sPx+gXSHJJp8LkhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYnGkBiBvOS7fN1zQH6tNTmMcQCuqlPMqiXjATrxUBhSLTfJfaKLyfKKmu+75kxwfoh3FUxCVkeNxvePLexH/tDEZPW2ycL2QM5prg8jv9h1fSN/XHYismkDjr+/uftFHeTz+fyUtxLm2HDVWyYVxzs8pkduqcO06AkCBBH5rDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AmR6Xe6J; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so492308f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 21:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752726932; x=1753331732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/syFIMIDJp8+dFLun2WnZdWFKbMc/fjNZ/VhcnZpJ40=;
        b=AmR6Xe6JMnbVOUkPtL48wp4/RGUlwZvgI4UeJc9MnTPsFiNGC3501TE4kz9P9rdjw5
         H5srJ9vrCmviQ5lVCodQNhMvkeP4R1oZd0cSgnzch9/47ytxe2krfSTNZya1pkUE0Sse
         RAQD/f9qDKLCakNOubFcro8ZKa7XbyKw1btpi8oUhnTGUXKYG4i1WfDlyGCouA6Xi3qN
         wTRYnG2j5U+aQzbxJ7BtSwOth+N67m/sUMSKMYEOTqEdMLR0FmzgV1pgVbtHSJ/XXtC3
         rvvzMx/qSswLPRG6V+VvABxu7wZvGtDmQbEAJlRY/F44g+9HqAI5nEnx7lgDgiK4xWXO
         RU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752726932; x=1753331732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/syFIMIDJp8+dFLun2WnZdWFKbMc/fjNZ/VhcnZpJ40=;
        b=CO6ncwWuPOpfw4xSl3Wp+8sT0bFU4KmOHK+H2+XrUCoe25IZI4YiDP6r08kDQwJd/c
         loGCV3Y7XrtdufQPLH2bfaBwrT4Khpwtocm5yTX8AdA9vaDQBlJN7DK12/wDljEJIX3r
         N7+FFUjFLJIxLkJoG4iOew4Mnp8bbf11tsoEzgiuhjDGOE3kS6eukN8w6y2Iqo1lYggB
         JV3IBVZC3uXzPIQ+UF2HZLfeST3Qbs4cW1abLLnn1rzr8apWgV4fLRMyoLvqQnZVjybL
         ObVjkYG3rxKo2NONGmyaOUVmFaCwBhxv9cTivhy6L7NQer4oQJL8CexVY3VHFoXai2Pu
         Ir2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWX3ol4nEmkHrdPh7A3oNTZQBh5HlTAnmORqrE47Y7sufuYXDfQyJfQ3S0vTaJVKaQiIZwC5Y6/p7Yj8Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdl7s5iiBBpMjrhqYf4NPyn/C2uU6SEGWw6G579PvPoxDpIjt4
	ZD/RPq2/LzvUjuoZW8+DQc2N387ADdha6Olnraz4Y2SaETIjTefArEsmaEh7ADbH8FMXkbba9N/
	HJ2FbOFG0Wg==
X-Gm-Gg: ASbGncsbCLxypc+la6R4Jd35uUou3i2+c6oe68N499haZTvuMntE5eBt8CXd6OdJW9w
	JJJK+igrZtnvMd5wFNw7btTfG7RB4WMUi65vuhCadhkJp5OgCtpe3lh2ZmGql5EjkIIwOAkamLb
	Yez5cnXy7afdchet3q9Bzav2vl9oDrAU5/LJcQcB8snOCfT2r5NH8eaaDRvSVGwr83Mai/xMJF3
	gK7Ouuf5zcg0wO0/6gOOwK2hy2fXUxug76iJ9AlnQFzu5sfcy1IJnait1T1govuWaoM86DDWCMM
	wrvD2Yb3TYF6demGSGdqsxedPjyZsPntnQT7SZtpzDkvazPMdVCAVdPuaXnzlY9V1VbUbWdsKo/
	41YZr5JWn6GG2kBesbs8=
X-Google-Smtp-Source: AGHT+IGDAqjGelisO+E0EKGcohm9ngbXtJos+/pqh8EZDacWo7esN8vkiU/i1QVMc2HayIr8Fxdn+A==
X-Received: by 2002:a05:6000:290b:b0:3a4:e56a:48c1 with SMTP id ffacd0b85a97d-3b60dd887c5mr4684660f8f.55.1752726932341;
        Wed, 16 Jul 2025 21:35:32 -0700 (PDT)
Received: from [10.211.55.30] ([103.172.41.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428b8a0sm137194335ad.8.2025.07.16.21.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 21:35:31 -0700 (PDT)
Message-ID: <a62a89ae-dc91-412e-85a5-f92064d4a79e@suse.com>
Date: Thu, 17 Jul 2025 10:07:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: mempool: fix wake-up edge case bug for zero-minimum
 pools
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <8c0cdb71-8d21-497e-b793-c43ce3a16345@suse.com>
 <20250716141931.273ca3effdbc0f442523eac8@linux-foundation.org>
Content-Language: en-US
From: Yadan Fan <ydfan@suse.com>
In-Reply-To: <20250716141931.273ca3effdbc0f442523eac8@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andrew,

On 7/17/25 05:19, Andrew Morton wrote:
> On Wed, 16 Jul 2025 23:37:30 +0800 Yadan Fan <ydfan@suse.com> wrote:
> 
>> The mempool wake-up mechanism has a edge case bug that affects pools
>> created with min_nr=0. When a thread blocks waiting for memory from an
>> empty pool (curr_nr == 0), subsequent mempool_free() calls fail to wake
>> the waiting thread because the condition "curr_nr < min_nr" evaluates
>> to "0 < 0" which is false, this causes threads to sleep indefinitely.
>>
>> There is at least 2 places where the mempool created with min_nr=0:
>>
>> 1. lib/btree.c:191: mempool_create(0, btree_alloc, btree_free, NULL)
>> 2. drivers/md/dm-verity-fec.c:791:
>>     mempool_init_slab_pool(&f->extra_pool, 0, f->cache)
> 
> This is very old code.  Can you suggest why this has taken so long to
> surface?
> 
> Which is a roundabout way of asking "should this be backported into
> -stable kernels".  For that we'd need to know how this issue is
> affecting our users.

There is no real issue yet, I just reviewed the codes here and found this,
I thought it may needs to fix so that I sent this patch.

> 
>> Add an explicit check in mempool_free() to handle the min_nr=0 case:
>> when the pool has zero minimum reserves, is currently empty, and has
>> active waiters, wake them up. The wq_has_sleeper() avoids unnecessary
>> wake-ups when no threads are waiting.
> 
> Do we need the separate test?  What's wrong with the obvious approach
> of replacing the "<" with "<=" in the preceding test?

Simply changing to "<=" has problem since add_element() has 
"BUG_ON(pool->curr_nr >= pool->min_nr);".

> 
> And would the previous (ie, existing) test benefit from the
> wq_has_sleeper() check?

I think it could have benefit for the existing test, wq_has_sleeper() is 
cost cheaper than wake_up().

I will submit a new patch containing it.

> 
>> --- a/mm/mempool.c
>> +++ b/mm/mempool.c
>> @@ -545,6 +545,22 @@ void mempool_free(void *element, mempool_t *pool)
>>                  }
>>                  spin_unlock_irqrestore(&pool->lock, flags);
>>          }
>> +       /*
>> +        * Handle the min_nr = 0 edge case:
>> +        * For zero-minimum pools, curr_nr < min_nr (0 < 0) never succeeds,
>> +        * so waiters sleeping on pool->wait would never be woken by the
>> +        * normal wake-up path. This explicit check ensures that when
>> +        * pool->min_nr == 0 and pool->curr_nr == 0, any active waiters
>> +        * are properly awakened.
>> +        * The wq_has_sleeper() avoids unnecessary wake-ups when no
>> +        * threads are waiting.
>> +        */
>> +       if (unlikely(pool->min_nr == 0 &&
>> +                    READ_ONCE(pool->curr_nr) == 0 &&
>> +                    wq_has_sleeper(&pool->wait))) {
>> +               wake_up(&pool->wait);
>> +       }
>> +
> 
> Something strange is happening with the whitespace here.  I pretty much
> retyped the patch.  Please have a chat with your email client ;)
> 

Sorry for this, I may just messed up somehow my client configuration, will fix it.

Thanks,
Yadan

