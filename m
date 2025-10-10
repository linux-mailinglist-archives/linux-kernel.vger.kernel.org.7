Return-Path: <linux-kernel+bounces-848573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E37BCE112
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0411885797
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45F4217F55;
	Fri, 10 Oct 2025 17:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="F/IYXQ0w"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EAD1FF5F9
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760116663; cv=none; b=kbw1HffkF7C7JTWjvQsd95CuHGsZNTl+RU6bCes6BkxBY4zizjTxXokHNhJ8oFfIM+lIidMrp8DPpvyHzFo83B5ZMB6zkjMJrkFb1TSv0jCGvCToSVdG9inaUTa9AVk6Y8DrSqoDeycDO1d5zJnTGrbY/1iCtDNl4y1BIDwcLE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760116663; c=relaxed/simple;
	bh=I1Jv1K8pMlHzgbwxs+yw/rgUKNnWjuy0CuTLkQH3qMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+Yo1cGbsviF6fE9TTl1AZN9oRkQi+M0/GzQrx1IFYkUoi7Kclo8Z7OJ/h48skCz8nOjP/f7yIS3PFbE4EfBu39zTtRsIfiM4VkgNmCyU769qD042Wjh3duXyw8e1NKpf3VjLPKc1U6VpEesAPlNSzpfDCRw4MEeZ+d0oOJCON4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=F/IYXQ0w; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-42d857dcf92so8987225ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760116661; x=1760721461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6G/IEc8eQi80LISFTxnAaN67mBaGX3+NUViuwGCrxp8=;
        b=F/IYXQ0wDEkphwVhN9FpeTOmpHkHAESbjdpgzqq7rh4b3JpQy2QqHM99R2dW2rNFsB
         87SY4fOH3evNwOIoscuM2k9FvVNmCe+PKvqMwBoGnto+e03+sznD1QZcKnipoxWoEFN5
         WdCT8np3E3KyOCu1G89JwdGNMN9bieuJTrKPWG6UPTxH3mZO1rPFGDh9j99b7qUoJ+4T
         A4wWRc3SMi3HBt8SF7Env1DzhMxKNk1i39ZmMNHnA+/HFqgXotygCgv0vCNugICgwwvp
         S9EMp29ZrTfgp32Sq0okO56AyDJzpy2rMPCGT+dIR8r7Z1wV0eukAxVYZ4dnt5Bv6DKy
         2utA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760116661; x=1760721461;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6G/IEc8eQi80LISFTxnAaN67mBaGX3+NUViuwGCrxp8=;
        b=t/RWcY4V0raTteqc9TioAfbFpRxbw3+Z4GtUV2KBRn/4W1Xpr/Nwh3WvN4g5ZHhQRg
         TvrUC07OPmrh5naWh+p/z7sGtuSg1kyJanWLOmNB4GHB7kJzZkQBYYItOA0IiO2rpQA/
         BnBxWubzXPE8Q9bF25pwqU2qN5TEQ2cmehgTQpLscuu4I3vBRYiQbHFxoCLLUyOwPHuY
         RBZbgh86ARMFfQuZWmiNKuL61lLM3FoGu7kk87fnnaYkJXXWCFOK/2wzPkUfOnY/xE+Y
         p8o6KaS3UUNqLYoMRGIhxn8wF3iH3DlmornbTEGzDm7eLJ/UwFNEhQEORr7D8KDrZJ10
         Lqzg==
X-Forwarded-Encrypted: i=1; AJvYcCUwsajFZ2TU8L+i1JbHjbUb/usoyowpBpf09mEJiYrj10gEOAIG83Pl0wtRbXUvJkXGGqGxZKqMT2s74Yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkKQF0FSy9XoDodEfPxTri6Z+rLFUoKLfHfocNofZv+mCPUIVZ
	k08SykpFO5DbXq/uLHI+L/Sj7QIVOWGCc71XZIeJ06Oq46GmYTl4xzdwhJdqsvTIGW8=
X-Gm-Gg: ASbGnctf3sMZAikwGrByI3/J7kqPfpYY8YNGEoSRZPqjlN5JlyIw4RRaYqgkXalt6KW
	+/Ox0meXSU67so2ai6lZcLnqOovj77juqX3G1UoCw7DKK8s78SRv/F6xwLco5MRHJrPI9Ar8Qkg
	cJbiUuNRK+lZlrTAB90kPQEybIzmOhSI8G5AvYVPxTq15dhB9TeXaBX6d3WtRY/17GGOqTTvU45
	thKODooR19jAly4n/QaUzl73VVi0YZrFLAn6YDRs1RwpaqL1U1e978FdXg0XtygqjZsQKGF6Op2
	lwlxgdtqK1oMgQap3gNlrrzTPg/b+nLHvYuYWSS4t4OqKLRHTTik+u1AcLce3KEjSlolckvT5IU
	/oweLehE8VRyHJpQaBH+BNIX33SrZA8ztvn5irzb2IOOf73thXiKsDbjn7A==
X-Google-Smtp-Source: AGHT+IFf3Dfk1VAV0Y7S/J8epFVv9DK6aEZ68GWSHSQhqH0ufWaX/0UhdYSoDg68NQQ/vOlVIsMBKA==
X-Received: by 2002:a05:6e02:1a8f:b0:427:b642:235 with SMTP id e9e14a558f8ab-42f87374f3bmr135463955ab.10.1760116660354;
        Fri, 10 Oct 2025 10:17:40 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.207])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f902962fbsm23231445ab.18.2025.10.10.10.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 10:17:39 -0700 (PDT)
Message-ID: <126d2381-c913-4815-bd9f-b6e9fe3cf5d8@sifive.com>
Date: Fri, 10 Oct 2025 12:17:38 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/18] riscv: Memory type control for platforms with
 physical memory aliases
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Conor Dooley <conor@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 David Hildenbrand <david@redhat.com>
References: <20251009015839.3460231-1-samuel.holland@sifive.com>
 <20251009181559.7bfa3dce6cb7265822b2d5c5@linux-foundation.org>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20251009181559.7bfa3dce6cb7265822b2d5c5@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-10-09 8:15 PM, Andrew Morton wrote:
> On Wed,  8 Oct 2025 18:57:36 -0700 Samuel Holland <samuel.holland@sifive.com> wrote:
> 
>> On some RISC-V platforms, including StarFive JH7100 and ESWIN EIC7700,
>> DRAM is mapped to multiple physical address ranges, with each alias
>> having a different set of statically-determined Physical Memory
>> Attributes (PMAs), such as cacheability. Software can alter the PMAs for
>> a page by selecting a PFN from the corresponding physical address range.
>> On these platforms, this is the only way to allocate noncached memory
>> for use with noncoherent DMA.
> 
> Well that's weird.
> 
>> --- a/mm/ptdump.c
>> +++ b/mm/ptdump.c
>> @@ -31,7 +31,7 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
>>  			    unsigned long next, struct mm_walk *walk)
>>  {
>>  	struct ptdump_state *st = walk->private;
>> -	pgd_t val = READ_ONCE(*pgd);
>> +	pgd_t val = pgdp_get(pgd);
>>  
>>  #if CONFIG_PGTABLE_LEVELS > 4 && \
>>  		(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
> 
> OK, but how are we to maintain this?  Will someone be running
> grep/coccinelle/whatever on each kernel release?
> 
> Please give some thought to finding a way to break the build if someone
> uses a plain dereference or a READ_ONCE().  Or add a checkpatch rule. 
> Or something.  Let's not rely upon the whole world knowing about this.

My initial plan was to add a script to scripts/coccinelle so `make coccicheck`
would catch any new instances. This would require some way to avoid false
positives in the few places where these pointers are safe to dereference (like
the ptentp and pmdvalp mentioned in commit message), such as a separate typedef
or a naming convention.

I had also explored using sparse to annotate pte_t and friends as noderef. This
would require changes to the sparse tool to allow noderef to work with a
non-pointer type (and get inherited by any pointers to that type), or else each
pointer parameter/variable would need to be annotated in the source code
(equivalent to __user). Neither seems ideal.

I hadn't considered a checkpatch rule. That's probably the most straightforward
solution, to warn on any instances of "\*(vmf(\.|->))?(pte|p[mu4g]d)p?", along
with a coccinelle script that could be run occasionally.

Regards,
Samuel


