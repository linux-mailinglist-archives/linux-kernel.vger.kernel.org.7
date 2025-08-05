Return-Path: <linux-kernel+bounces-756769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4324B1B8FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8898117D769
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD903259CB1;
	Tue,  5 Aug 2025 17:08:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEF91DF258
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754413704; cv=none; b=J0VKDKmK5OZ16QA3X5kSj1xI91wFbMgVfhKtYF9DkwjuMCmPjCW6/d3puOlee35ULsjM9wtkMm2F8PvjPgyNj2k6kB2mQadxy3TvS7gLGr+Zo5xs4Fi/JzzBisMiXdfJGmKu5flKht7LHenQXlgObRlrgSkVVqjI6tnek2JkIac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754413704; c=relaxed/simple;
	bh=c547usMXxkxomnVQYDKHffYIR3hk7d5hpm4J6Cg0/SE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9qUmB6r+i/SKsMa7MTNK5yKzwWhJ6i46VNEE7RYyZIX2Gf44Ilf+DkYc1xgDbURbyS6lZTDeL+qUl8lbGCDG8Lotwl/F/zfmakRuaIdsMcjMwfhcdsi49ZpTLqktWPBvCG/gkKeaXbu94DJYwS1GCPN9UTZ5fg6Sx/RRR4/PAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D1662BC2;
	Tue,  5 Aug 2025 10:08:14 -0700 (PDT)
Received: from [10.1.197.43] (eglon.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15F5B3F673;
	Tue,  5 Aug 2025 10:08:15 -0700 (PDT)
Message-ID: <2a503013-ae89-44a4-9851-2571c7ef6e70@arm.com>
Date: Tue, 5 Aug 2025 18:08:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/36] ACPI / MPAM: Parse the MPAM table
To: Ben Horgan <ben.horgan@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Zeng Heng
 <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-11-james.morse@arm.com>
 <e2d5cc53-b2d5-42d7-97cb-b21180361c1c@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <e2d5cc53-b2d5-42d7-97cb-b21180361c1c@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ben,

On 24/07/2025 11:50, Ben Horgan wrote:
> On 11/07/2025 19:36, James Morse wrote:
>> Add code to parse the arm64 specific MPAM table, looking up the cache
>> level from the PPTT and feeding the end result into the MPAM driver.

>> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
>> new file mode 100644
>> index 000000000000..f4791bac9a2a
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/mpam.c
>> @@ -0,0 +1,365 @@

>> +static int acpi_mpam_parse_resource(struct mpam_msc *msc,
>> +                    struct acpi_mpam_resource_node *res)
>> +{
>> +    int level, nid;
>> +    u32 cache_id;
>> +
>> +    switch (res->locator_type) {
>> +    case ACPI_MPAM_LOCATION_TYPE_PROCESSOR_CACHE:
>> +        cache_id = res->locator.cache_locator.cache_reference;
>> +        level = find_acpi_cache_level_from_id(cache_id);
>> +        if (level < 0) {
>> +            pr_err_once("Bad level (%u) for cache with id %u\n", level, cache_id);
>> +            return -EINVAL;

> Nit: More robust to check for level <= 0.

Sure, that can probably happen!


Thanks,

James

