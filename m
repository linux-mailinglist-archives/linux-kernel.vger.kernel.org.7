Return-Path: <linux-kernel+bounces-830918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76799B9AE60
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D74E323CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1113313D71;
	Wed, 24 Sep 2025 16:42:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15653043B0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758732158; cv=none; b=o9PyNhbWcqgfrR1OofOX4k0gJdge5dJHsF5Ax/9GEnO6qxrJwmCHdOPJ5w3IGJPGfBJCJc3DETslKvqknMvDpypwl/0MJOirgwlNNv8TD767gztE/lhKtREYPYz9J441cvTLmv8Gi8B7Cq73VWvoMwf2OkHC/I98Iz61KSpjIcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758732158; c=relaxed/simple;
	bh=jv+QekritNyGndSBeIWppxT97tUoqwcpjxgc2nVSse8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=al2IdbYQmi7zmP5lxMamnTd0Yef8ItHZHdhXFdMwmLz2lLPdj7ruRk7OdxZtOQHndwySg3FHmaDcFOJnqxpW03qEzN+IwIEYSrQhWJNK3JJyABzq8lFmXCdkVIFQpj6h2RZ4WLXPhYFNd3UPAPN4NhozhkaEsmGtQrilYgRPPww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62A9C16A3;
	Wed, 24 Sep 2025 09:42:26 -0700 (PDT)
Received: from [10.57.1.72] (unknown [10.57.1.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 581953F66E;
	Wed, 24 Sep 2025 09:42:33 -0700 (PDT)
Message-ID: <3b16607f-8995-46b1-aecf-c6aa79f66f9d@arm.com>
Date: Wed, 24 Sep 2025 17:42:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] coresight: tmc: add the handle of the event to
 the path
Content-Language: en-GB
To: Mike Leach <mike.leach@linaro.org>, Jie Gan <jie.gan@oss.qualcomm.com>
Cc: Carl Worth <carl@os.amperecomputing.com>,
 James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250922-fix_helper_data-v1-0-905e8115a24e@oss.qualcomm.com>
 <20250922-fix_helper_data-v1-1-905e8115a24e@oss.qualcomm.com>
 <874isuo0m2.fsf@rasp.cworth.amperemail.amperecomputing.com>
 <f7be3833-9b33-4935-b821-a2e0000a2557@oss.qualcomm.com>
 <CAJ9a7VjaUE+iy=FFwPhCdfXgoGR3rP9WSx-ZkKYeCHhqJ2yzMg@mail.gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CAJ9a7VjaUE+iy=FFwPhCdfXgoGR3rP9WSx-ZkKYeCHhqJ2yzMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/09/2025 11:21, Mike Leach wrote:
> Hi,
> 
> On Tue, 23 Sept 2025 at 02:49, Jie Gan <jie.gan@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 9/23/2025 1:31 AM, Carl Worth wrote:
>>> Jie Gan <jie.gan@oss.qualcomm.com> writes:
>>>> From: Carl Worth <carl@os.amperecomputing.com>
>>>>
>>>> The handle is essential for retrieving the AUX_EVENT of each CPU and is
>>>> required in perf mode. It has been added to the coresight_path so that
>>>> dependent devices can access it from the path when needed.
>>>
>>> I'd still like to have the original command I used to trigger the bug in
>>> the commit message. I really like having reproduction steps captured in
>>> commit messages when I look back at commits in the future. So, that was:
>>>
>>>         perf record -e cs_etm//k -C 0-9 dd if=/dev/zero of=/dev/null
>>>
>>
>> Sure, I’ll include your commit message in the formal patch series, I
>> think it's V3 since you have submitted two versions, if you're okay with
>> me sending it out.
>>
>>>>    /**
>>>>     * struct coresight_path - data needed by enable/disable path
>>>> - * @path_list:              path from source to sink.
>>>> - * @trace_id:          trace_id of the whole path.
>>>> + * @path_list:                      path from source to sink.
>>>> + * @trace_id:                       trace_id of the whole path.
>>>> + * struct perf_output_handle:       handle of the aux_event.
>>>>     */
>>>
>>> Fixing to "@handle" was mentioned in another comment already.
>>>
>>> Something about the above still feels a little off to me. It feels like
>>> we're throwing new data into a structure just because it happens to be
>>> conveniently at hand for the code paths we're needing, and not because
>>> it really _belongs_ there.
>>>
>>
> This data is perf specific - not path generic; so I agree that this
> structure should go elsewhere.
> 
> I would suggest in the csdev (coresight_device) structure itself. We
> already have some sink specific data in here e.g. perf_sink_id_map.
> 
> This could then be set/clear in the functions coresight-etm-perf.c
> file, where there is a significant amount of code dealing with the
> perf handle and ensuring it is valid and in scope.
> 
> This can then be set only when appropriate - for source / sink devices
> and only when in perf mode, and avoid the need to pass the handle
> around as API call parameters.

I think this data is specific to the session we are enabling the
device(s) in. e.g., we keep the trace-id in the path.
So, I don't mind having this in the path structure.
Instead of modifying csdev with additional locking from "etm-perf"
it is always cleaner to handle this in the path.


Suzuki


> 
> Regards
> 
> Mike.
> 
> 
> 
> 
>> The core idea behind coresight_path is that it can hold all the data
>> potentially needed by any device along the path.
>>
>> For example with the path ETM->Link->ETR->CATU:
>>
>> All the mentioned devices operate by forming a path, for which the
>> system constructs a coresight_path. This 'path' is then passed to each
>> device along the route, allowing any device to directly access the
>> required data from coresight_path instead of receiving it as a separate
>> argument.
>>
>> Imagine a device that requires more than two or three arguments, and you
>> want to pass them through coresight_enable_path or similar functions...
>>
>> For certain coresight_path instances, we may not need the handle or
>> other parameters. Since these values are initialized, it's acceptable to
>> leave them as NULL or 0.
>>
>>
>>> Or, maybe it's the right place for it, and the cause of my concern is
>>> that "path" is an overly-narrow name in struct coresight_path?
>>>
>>
>> It defines the direction of data flow—serving as the path for trace data.
>>
>> Thanks,
>> Jie
>>
>>> But if a renaming of this structure would improve the code, I'd also be
>>> fine with that happening in a subsequent commit, so I won't try to hold
>>> up the current series based on that.
>>>
>>> -Carl
>>
> 
> 
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK


