Return-Path: <linux-kernel+bounces-770865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F419B27FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC7777B4E85
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487432FCC0B;
	Fri, 15 Aug 2025 12:12:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60912137E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755259931; cv=none; b=jKBT7bFMnn+z9KbeSpLzHSHNRKdxz4EtUqJDx2XQuXXQuyuNqSpF+ntWL4QAcYBH1MX2FuNBmhXdJD5+3jxDHuHtSAoe4q5dOBvycde9YY7HRbuqxrvcfi8wS6aB9J7kkDkl5vYKTaNQF5K1rSwNgvfWt5xYMfvcG9nCYz72rrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755259931; c=relaxed/simple;
	bh=k7djlgJKB5AbdLDRTA3sa6y8E/p7KUfRcePniXyQOCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWXX2PX4Do0hOI/sq7cu0CTtB9lxmgOlrLu69Z6UghDBLY+CVGVFsL60+Ttm6O/nTcue80fUM59dVk/CFlq3dZ5agfTbNddRBEEPZqOdxWCEmIZfpE+sh8HPfLsAzLKNL3M1xrDy8h5hr8wxgx4hmV9LxJfxIUiqkCVR041tUSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C3731691;
	Fri, 15 Aug 2025 05:12:01 -0700 (PDT)
Received: from [10.57.56.228] (unknown [10.57.56.228])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CD4A3F738;
	Fri, 15 Aug 2025 05:12:06 -0700 (PDT)
Message-ID: <f53dd685-4e05-4fd3-a49d-0074b69a8ce1@arm.com>
Date: Fri, 15 Aug 2025 14:12:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64/mm: Allow __create_pgd_mapping() to propagate
 pgtable_alloc() errors
To: Dev Jain <dev.jain@arm.com>,
 Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Zhenhua Huang <quic_zhenhuah@quicinc.com>
References: <20250813145607.1612234-1-chaitanyas.prakash@arm.com>
 <20250813145607.1612234-2-chaitanyas.prakash@arm.com>
 <683f9f4e-c027-4165-a8aa-b561e304e132@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <683f9f4e-c027-4165-a8aa-b561e304e132@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/08/2025 09:30, Dev Jain wrote:
>
> On 13/08/25 8:26 pm, Chaitanya S Prakash wrote:
>> [-------snip-------------]
>>   -static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>> +static int __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>>                    unsigned long virt, phys_addr_t size,
>>                    pgprot_t prot,
>>                    phys_addr_t (*pgtable_alloc)(enum pgtable_type),
>>                    int flags)
>>   {
>> +    int ret = 0;
>> +
>>       mutex_lock(&fixmap_lock);
>> -    __create_pgd_mapping_locked(pgdir, phys, virt, size, prot,
>> -                    pgtable_alloc, flags);
>> +    ret = __create_pgd_mapping_locked(pgdir, phys, virt, size, prot,
>> +                      pgtable_alloc, flags);
>>       mutex_unlock(&fixmap_lock);
>> +
>> +    return ret;
>> +}
>> +
>> +static void ___create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>> +                  unsigned long virt, phys_addr_t size,
>> +                  pgprot_t prot,
>> +                  phys_addr_t (*pgtable_alloc)(enum pgtable_type),
>> +                  int flags)
>> +{
>> +    int ret = 0;
>> +
>> +    ret = __create_pgd_mapping(pgdir, phys, virt, size, prot,
>> pgtable_alloc,
>> +                   flags);
>> +    BUG_ON(ret);
>>   }
>
> A triple underscore calling a double underscore isn't natural to
> reason about.

Also not the most readable (easy to confuse the two).

> Since this is the function which must succeed, how does
> "must_create_pgd_mapping()"
> sound?

"must" isn't a prefix that is commonly used in that sense, not sure this
is very clear.

Another idea that comes to mind is early_create_pgd_mapping() - the
BUG_ON() being justified by the fact that early errors are not recoverable.

On a related note, it would be possible to return an error from
create_pgd_mapping() and create_mapping_noalloc() as their callers
already have error paths. That would be a bit cleaner but I don't know
if it's worth the hassle.

- Kevin

