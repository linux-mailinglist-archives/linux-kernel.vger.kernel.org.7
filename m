Return-Path: <linux-kernel+bounces-824157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC998B88424
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11EB3B63D10
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20D02C1581;
	Fri, 19 Sep 2025 07:44:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46042D23A3
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267842; cv=none; b=FWargvMMy5TFFte5YnoyHtwdp52bpVO8rarN0g0Qam+2v3v6VdOFCH+Krp+kj9kgu5CnnVwdKlRipQ8W9tgwQhrxEjIycjZgNp4pRFd3k0DUJNxFk6MCABUO2JMKlwjmoEV6XPr61/lJbmqwCxW0greTtMkfA/zdLJTgSzmJxyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267842; c=relaxed/simple;
	bh=8sOMXnli39x/QjU+WFjvi+/RPmZICg62eJ+QtmaPicE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2OQ7/F1yvci4+KiESTMg4hxjovGUj9jeP+9O5rsD9iuWLdwEL85UJX6lbBrB/3s8Z30m+bnbqdc4QV1fOHSDx3M9KC8IziSqHKOZSDQX6IBodh/J/uC6DA0xI6A+JQLEpHl8Jeyi/ffc/rAiWaqeIvLaW3JPUMYHFv4igaCGik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D02CD1692;
	Fri, 19 Sep 2025 00:43:50 -0700 (PDT)
Received: from [10.57.7.92] (unknown [10.57.7.92])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBD573F66E;
	Fri, 19 Sep 2025 00:43:57 -0700 (PDT)
Message-ID: <9d8f3a84-8c89-48a8-9996-4602bbabd446@arm.com>
Date: Fri, 19 Sep 2025 08:43:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: Fix data argument to coresight_enable_helpers
Content-Language: en-GB
To: Jie Gan <jie.gan@oss.qualcomm.com>,
 Carl Worth <carl@os.amperecomputing.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Sabrina Dubroca <sd@queasysnail.net>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250916224441.3008824-1-carl@os.amperecomputing.com>
 <a331eceb-ec49-4396-a61d-78a75789b090@oss.qualcomm.com>
 <87frcj8kw7.fsf@rasp.cworth.amperemail.amperecomputing.com>
 <e1a2ee99-07bc-40f3-8742-a0cb1c273350@oss.qualcomm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <e1a2ee99-07bc-40f3-8742-a0cb1c273350@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/09/2025 02:20, Jie Gan wrote:
> 
> 
> On 9/19/2025 6:18 AM, Carl Worth wrote:
>> Jie Gan <jie.gan@oss.qualcomm.com> writes:
>>> I dont think we can change back to sink_data since we introduced
>>> coresight_path to wrap 'data' which is needed by the path.
>>>
>>> I suggest you to add the struct perf_output_handle to the
>>> coresight_path, then retrieving it with data->perf_handle in
>>> tmc_etr_get_buffer.
>> ...
>>> We can assign the perf_output_handle to the coresight_path after we
>>> constructed the coresight_path in perf mode.
>>
>> Thanks. That much makes sense to me, and I'll put together a patch along
>> those lines.
>>
>> But, further: with core coresight code assembling into the path all the
>> data that is necessary, is there any reason to be using void* in these
>> enable/disable functions?
> 
> In my opinion, yes, we can change void * to coresight_path * for 
> helper's enable/disable functions since we have everything in path so 
> the cast is not necessary now.
> 
>>
>> Could we also change these functions to accept a coresight_path* and
>> actually get some compiler help at finding mistakes like the one we're
>> fixing here?
> 


Yes, please. I was going to suggest that. May be we could do that as
a separate patch after fixing the problem here first (so that it
can be back ported).

This was initially a perf_handle only used for the perf mode, and
it didn't make sens to have a "perf" argument to "enable" which
could be used for both sysfs and perf. Now that the path
is a generic data structure, it makes sense to move everything
to accept the path.

Suzuki


> That's the only benefit in my mind so far.
> 
> Thanks,
> Jie
> 
>>
>> -Carl
> 


