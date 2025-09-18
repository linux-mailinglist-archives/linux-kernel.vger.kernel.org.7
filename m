Return-Path: <linux-kernel+bounces-800322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F39AB43644
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6F816F696
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33572D0615;
	Thu,  4 Sep 2025 08:50:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BAA2264B1;
	Thu,  4 Sep 2025 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975837; cv=none; b=G8FzDENmq/num87HIytfopESbIZX+2Nll1NYgjSK43szGff4DQJSj8x8qNFzg1NOkZvsOskstiYlpbxg0vpF+9gChHVMfzfHVkSfgB7UoRC8MycHK+xg3xEq1XelC+mob6Kmb6KYFHu2ko/Lvwwa8tUnXzNnmruJ6m3qo8aJfMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975837; c=relaxed/simple;
	bh=eTaA6n3zLtqq6jVcDFfU6/plf0Xa3K2sPtxjA8dBorA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuDAIwmALkpuRpEBiI10yZMOHvTPFmrg4AQCRTIEXOfSIAizR1RZ2XZcL6wtJTYMI9tOFWwkvy71izJILP2ChQ2SKLlUvRHDB2+SJ+AvAl89cEe6t9kaiR2xI7N+mIBjsj1GFNZ0chNvHICwHTKPB/u02uEFwoHh/VpVmTeQjsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA6881596;
	Thu,  4 Sep 2025 01:50:25 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0F793F63F;
	Thu,  4 Sep 2025 01:50:32 -0700 (PDT)
Message-ID: <961258a0-3cc6-4935-a305-80bb2c2c0597@arm.com>
Date: Thu, 4 Sep 2025 09:50:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] coresight: tpda: fix the logic to setup the element
 size
To: Jie Gan <jie.gan@oss.qualcomm.com>, Mike Leach <mike.leach@linaro.org>,
 James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Tao Zhang <quic_taozha@quicinc.com>, Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: tingwei.zhang@oss.qualcomm.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20250806080931.14322-1-jie.gan@oss.qualcomm.com>
 <2f243b22-d8d3-4352-b226-aaf9ccfe825b@arm.com>
 <a4382db3-115a-4d79-924a-08507e6e7b3e@oss.qualcomm.com>
 <1cef4224-1f0a-4c51-937d-66823a22dec3@oss.qualcomm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1cef4224-1f0a-4c51-937d-66823a22dec3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/09/2025 02:12, Jie Gan wrote:
> 
> 
> On 9/3/2025 5:45 PM, Jie Gan wrote:
>>
>>
>> On 9/3/2025 4:57 PM, Suzuki K Poulose wrote:
>>> On 06/08/2025 09:09, Jie Gan wrote:
>>>> Some TPDM devices support both CMB and DSB datasets, requiring
>>>> the system to enable the port with both corresponding element sizes.
>>>>
>>>> Currently, the logic treats tpdm_read_element_size as successful if
>>>> the CMB element size is retrieved correctly, regardless of whether
>>>> the DSB element size is obtained. This behavior causes issues
>>>> when parsing data from TPDM devices that depend on both element sizes.
>>>>
>>>> To address this, the function should explicitly fail if the DSB
>>>> element size cannot be read correctly.
>>>
>>> But what is the device only has CMB ? Back when this was originally 
>>
>> We have CMB TPDM, DSB TPDM and CMB&&DSB TPDM.
>>
>>> merged, we raised this question and the answer was, "Only one is 
>>> supported, not both." But this sounds like that is wrong.
>>
>> I think we may not answer the previous question clearly. But it 
>> definitely has issue here.
>>
>>> Could we defer the "Warning" to the caller. i.e., Let the caller
>>> figure out the if the DSB size is found and predicate that on the
>>> DSB support on the TPDM.
>>
>> Understood, below codes will be added in the caller to check the error:
>> if ((tpdm_data->dsb && !drvdata->dsb_esize) ||
>>      (tpdm_data->cmb && !drvdata->cmb_esize))
>>      goto err;
>>
>> Thanks,
>> Jie
>>
> 
> Hi Suzuki,
> 
> I've reviewed the logic here. It's not feasible for the caller to 
> perform the check, since we first retrieve TPDM's drvdata, which adds 
> complexity to the code. I believe it's better to handle this within the 
> function itself.
> 
> We are expecting the element_size for cmb if the condition is true, as 
> well as dsb:
> if (tpdm_data->dsb)
> ...
> should obtain a valid element size for dsb.
> ...
> 
> if (tpdm_data->cmb)
> ...
> should obtain a valid element size for cmb.
> ...
> 

Ok, fair enough. Please resend the patch without the dependency on the 
static TPDM patch. Given this is a fix, this could go in without waiting 
for the new series.

Suzuki



> Thanks,
> Jie
> 
>>>
>>> Suzuki
>>>
>>>>
>>>> Fixes: e6d7f5252f73 ("coresight-tpda: Add support to configure CMB 
>>>> element")
>>>> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
>>>> ---
>>>>   drivers/hwtracing/coresight/coresight-tpda.c | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/ 
>>>> hwtracing/coresight/coresight-tpda.c
>>>> index 0633f04beb24..333b3cb23685 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>>>> @@ -71,6 +71,8 @@ static int tpdm_read_element_size(struct 
>>>> tpda_drvdata *drvdata,
>>>>       if (tpdm_data->dsb) {
>>>>           rc = fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
>>>>                   "qcom,dsb-element-bits", &drvdata->dsb_esize);
>>>> +        if (rc)
>>>> +            goto out;
>>>>       }
>>>>       if (tpdm_data->cmb) {
>>>> @@ -78,6 +80,7 @@ static int tpdm_read_element_size(struct 
>>>> tpda_drvdata *drvdata,
>>>>                   "qcom,cmb-element-bits", &drvdata->cmb_esize);
>>>>       }
>>>> +out:
>>>>       if (rc)
>>>>           dev_warn_once(&csdev->dev,
>>>>               "Failed to read TPDM Element size: %d\n", rc);
>>>
>>>
>>
> 


