Return-Path: <linux-kernel+bounces-746060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 499C7B122AE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C52A3A8829
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593762EF9DE;
	Fri, 25 Jul 2025 17:06:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24052EF9D5
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753463163; cv=none; b=WV0xcpeqYDzOmBnQZJWZSV0l05oWLpgTjUxBsfSL1C6zMiao8Hfz1kmbdkX2TKIDn0/uimt7RFwuDVwz4EUVxRIvDfezaCaPVZC2QwcwgdSdXhKaiz+cUVhKD0+K1jlflu/3w7zVVbEuPQFCxI3ZI+fiSyGK+m69Le46pqDha34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753463163; c=relaxed/simple;
	bh=u/bhy8xxIZ0ARS/nMRQKUMG+kwfHMUzFQ72YHJNJbHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2NjTGkavsHFCONf7hbSyigJpGFdUfw4Z7m/Fh8d6tJl9Oo2cQKteUs/H5KHbb1A+h3tMtZRSzmxYDSdGQf+QnMn+bcUFXeKz0Qt76ocjTQOQ/lyOYZehTMj27VdL8ZP6iTsZQ093CvYwjOAPBfCRrZo8iZ9OtlK1rdvguil7wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 556171A00;
	Fri, 25 Jul 2025 10:05:53 -0700 (PDT)
Received: from [10.1.197.43] (eglon.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17E913F66E;
	Fri, 25 Jul 2025 10:05:55 -0700 (PDT)
Message-ID: <1422ff0e-6aa3-42de-ba12-4dff32e7505d@arm.com>
Date: Fri, 25 Jul 2025 18:05:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/36] ACPI / PPTT: Stop acpi_count_levels() expecting
 callers to clear levels
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>,
 Rohit Mathew <rohit.mathew@arm.com>,
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
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Sudeep Holla <sudeep.holla@arm.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-7-james.morse@arm.com>
 <20250716165142.00002c46@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250716165142.00002c46@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 16/07/2025 16:51, Jonathan Cameron wrote:
> On Fri, 11 Jul 2025 18:36:18 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> acpi_count_levels() passes the number of levels back via a pointer argument.
>> It also passes this to acpi_find_cache_level() as the starting_level, and
>> preserves this value as it walks up the cpu_node tree counting the levels.
>>
>> The only caller acpi_get_cache_info() happens to have already initialised
>> levels to zero, which acpi_count_levels() depends on to get the correct
>> result.
>>
>> Explicitly zero the levels variable, so the count always starts at zero.
>> This saves any additional callers having to work out they need to do this.

> This is all a bit fiddly as we now end up with that initialized in various
> different places.

I've debugged this one a few times, (turns out I'm forgetful) ... I figured doing this
was better than adding a comment to warn others.
As its static, I figured it was something the compiler can optimise out if there is a
duplicate. (I couldn't find any initialisation I could remove because of this)


> Perhaps simpler to have acpi_count_levels() return the
> number of levels rather than void. Then return number of levels rather
> than 0 on success from acpi_get_cache_info(). Negative error codes used
> for failure just like now.
> 
> That would leave only a local variable in acpi_count_levels being
> initialized to 0 and passed to acpi_find_cache_level() before being
> returned when the loop terminates.
> 
> I think that sequence then makes it such that we can't fail to
> initialize it at without the compiler noticing and screaming.
> 
> Requires a few changes from if (ret) to if (ret < 0) at callers
> of acpi_get_cache_info() but looks simple (says the person who
> hasn't actually coded it!)

Breaking the symmetry between levels and split_levels is an argument against this.

I think within pptt.c this is fine, because 'level's is used internally as
'starting_level', and this expectation it was initialised to zero is a nasty surprise.

But exposing that from acpi_get_cache_info() looks stranger - and would need to touch
users in cacheinfo, arm64, riscv.

I've updated acpi_count_levels() to look as you describe - that at least makes it harder
to miss this in future. (not sure whether it saves anything)


>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index 13619b1b821b..13ca2eee3b98 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -183,7 +183,7 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
>>   * @cpu_node: processor node we wish to count caches for
>>   * @levels: Number of levels if success.
>>   * @split_levels:	Number of split cache levels (data/instruction) if
>> - *			success. Can by NULL.
>> + *			success. Can be NULL.
> 
> Grumpy reviewer hat.  Unrelated cleanup up - good to have but not in this patch where
> it's a distraction.

I was hoping diff would keep it as one hunk. Happy to leave it tyopd!


Thanks,

James

