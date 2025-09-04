Return-Path: <linux-kernel+bounces-799656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701D4B42EB7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CDAE5454CA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1F71A23A6;
	Thu,  4 Sep 2025 01:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aPimfGms"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F715B21A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 01:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756948348; cv=none; b=Zxzz4ZVmxt3hseQIg1SaFhwsQqYDtkj6TEgW4gdkgVwP2gcRj2642j9fT8+FoYCLf8bVT3FnvFVJ2H83oao1vQ1Pi5XjRNHhAlITCQ1Uj6wgTOdsCQIjXnK6P9P6PfUTXUeSLcvVBSXkjB5P/gajwlNUdMi7k+Z/FlJh9F37rUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756948348; c=relaxed/simple;
	bh=99CdkSrlewbo0LGOH4D7+p7iVei0kL0ATm/0HpkyhKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uRosrBZreFNeNk7IX6DDJJmjV2uKB0sF1jpDofUCEwdwIVP2Ipib3KacqMa6rNNfawW1odpzFJVvTURfrGgUtebg8LV/eOqhygw9U++L+aUy9igKfwjrMH0Bh2Lha4OtQvx6RAE97hT4jb+o/MfzNt6xbcBdjK40cmPH1+eWDmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aPimfGms; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dx70x008689
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 01:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m4UlpG8f8qlhFUnHW3S/D2my3ldPT+l0SoxGKdP3InE=; b=aPimfGmsnQkejr9f
	ZqlGJ3q2HQBGtf0RXrzSel2OHyKkFC+5GHwFiMDJCbx84oN6T4vIbwzZylut/UEh
	EtI8JX+3ClI/Ka1L0mFQAdOzfGJaTZPfxMkwAh46kwVZgaAkulJWDDhK6J7cngYl
	cJVIF4XR03X7MrD5WcezVT8JWEaO85xtDiCYoOSUCWRe3c7Vwq8CVuhY623hn0VJ
	tlcKC9bOU4qGdbvHqAR8zLqqdeu3K4kxgbxz+S3/oxyou7VyIPm1zQRtjFR1gJa6
	YU+j4VehNKXOBI5jD92T7oebXKKjEjWapSlDZLby4QGHB3L/4dnye+ypyrmL9MXS
	FpkS1A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscv5te0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 01:12:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24b18ad403eso12522245ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 18:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756948344; x=1757553144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m4UlpG8f8qlhFUnHW3S/D2my3ldPT+l0SoxGKdP3InE=;
        b=K2wGb8aWnU0v12hUCM9Quk8/1SEgyOqra0EHckQukPHv2KcHBu1QKS3vW6Jn6O3Pco
         wWr47BjkKDCx5o+bJ9p3GBzO8AWIeza43kvgvNuZlU6PoyyxmeGSb3kfahXITA2IlLxp
         Pt7ChWRWIjVf3MMg+VBhH6/An+O08fYvujnkUeUoj8tSoEtPjdGmnaeTNJLZXOEfGlwF
         5fF68k/A46BZZG27jIes2lKkiV64F6pERdQ1xbtFXF5mP5czGFdRdnOiJW46keI1eknR
         +O+wFq8O38HCBnI3NDyvC6tR/eiKYOX5VHSctfCaK7F6t4924mSbzVWAgWRkf+ewB6k0
         /cSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuIrJIZfO7XH14STpw9GmUNJ2sRdHdvMOcOJlLf3nM1eKPMoODhpUyzKn1VWZ/ycKvlNy0dxZuWCdNilM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOZqVKZ3B1gza7VA8VZ70pzwBShoY0Jl2weqSrVJmPneCqZNsO
	VGpI5p0SxYYC6vTGGSiE7/4ZKc02ozt/qqZpQQP4w8TswKRFhbmiQmd1/D1vHhbwgBPgqppLBjN
	7kqjzCGudlJlfl3DQB+IycX/uyFTzAgysJFo1+AWA+0Zw8/G6WQ4wU8xRfwGDF3HBI98=
X-Gm-Gg: ASbGncuA9Z38yTzp0RyeDrZWwpKAKPv0vEo2SoqfWzVc9cNGpL6/6wMhB9CKYmuPa/P
	Qovkp/+Ia8M8zCO4FW7QIcCDySmPktfathmojAXFvHHx5JMBIttcrX+blBVo7tFdEp4XJ404ia7
	YVTXavOwdjeOI1mMmspOu09u2iEER/27IBNPNBh8Xlj7nbv8okvA3i7Ea+OVVxE6qYJLXhCCYQu
	zDy01fB4uOtohRA9UXvmbbOuQN2a6BTw9STdIBthJp/ZTQcKuOlwxKvbbaCjvX1Tyq6QIyctrZq
	9mI+k7G4uoH7d1XysD8rdLdTJ8NbBhNQYLmwGJEYyrXuiHzgdYZvBmY2StF/4Jcmv7M1qo4RRdD
	4sEfF95/7tqFeKLHYGATlgG9cZGyQ
X-Received: by 2002:a17:903:2f8c:b0:249:37b2:8630 with SMTP id d9443c01a7336-2493ee070bcmr241542365ad.5.1756948344520;
        Wed, 03 Sep 2025 18:12:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9czfEhRl9hye4C8gtNxqDVYJf3M5iT4GyatmB+ImJck7rp2ujuN2+s56plaoGT8AWoaCKRg==
X-Received: by 2002:a17:903:2f8c:b0:249:37b2:8630 with SMTP id d9443c01a7336-2493ee070bcmr241542015ad.5.1756948343958;
        Wed, 03 Sep 2025 18:12:23 -0700 (PDT)
Received: from [10.133.33.16] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9304b7eesm29677115ad.102.2025.09.03.18.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 18:12:23 -0700 (PDT)
Message-ID: <1cef4224-1f0a-4c51-937d-66823a22dec3@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 09:12:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] coresight: tpda: fix the logic to setup the element
 size
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: tingwei.zhang@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250806080931.14322-1-jie.gan@oss.qualcomm.com>
 <2f243b22-d8d3-4352-b226-aaf9ccfe825b@arm.com>
 <a4382db3-115a-4d79-924a-08507e6e7b3e@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <a4382db3-115a-4d79-924a-08507e6e7b3e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX9LB02yx5Dl+2
 4CMUic3EVgns64GAmD0UhdRUT6DRENcC8Qudio2jqMg0UudOuPVdJ3588sQM0XDWXbn5fSx/Dg7
 lquvKtx8Z3+kHGxqdlR3IR3ODPaRW4enYd+biUqy3u1B8HAhMV2/Zf80SyO7J0oUjmrMEb2jr95
 RAz+/vieNx9PKVMtrlrMGuecBC0oYLeURLUTPEUaO2NRvWN9ATtw8HoTCUpvFOlBJpifNnu2ecK
 wKF42UW1GNP5xls4fK71sLhLgSYF9n+ztKgEU5kzL5MghtD5eTdHe6KyNNQuVQ/pi/ZEbHWF0Ai
 cod8LPB2jWMA1XZcA7XfyRpJ9LX2yC7SFmOhmRM/+E6Knnj1/YGUyRegfs+ME236p2oAfzhPaoA
 ZaHfAOlc
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b8e779 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=7yWgPBNy7Zp0T3bZPJgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: kK-Zo84O79Suw5yGhqeBT3aRMUGK0XeM
X-Proofpoint-GUID: kK-Zo84O79Suw5yGhqeBT3aRMUGK0XeM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_11,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031



On 9/3/2025 5:45 PM, Jie Gan wrote:
> 
> 
> On 9/3/2025 4:57 PM, Suzuki K Poulose wrote:
>> On 06/08/2025 09:09, Jie Gan wrote:
>>> Some TPDM devices support both CMB and DSB datasets, requiring
>>> the system to enable the port with both corresponding element sizes.
>>>
>>> Currently, the logic treats tpdm_read_element_size as successful if
>>> the CMB element size is retrieved correctly, regardless of whether
>>> the DSB element size is obtained. This behavior causes issues
>>> when parsing data from TPDM devices that depend on both element sizes.
>>>
>>> To address this, the function should explicitly fail if the DSB
>>> element size cannot be read correctly.
>>
>> But what is the device only has CMB ? Back when this was originally 
> 
> We have CMB TPDM, DSB TPDM and CMB&&DSB TPDM.
> 
>> merged, we raised this question and the answer was, "Only one is 
>> supported, not both." But this sounds like that is wrong.
> 
> I think we may not answer the previous question clearly. But it 
> definitely has issue here.
> 
>> Could we defer the "Warning" to the caller. i.e., Let the caller
>> figure out the if the DSB size is found and predicate that on the
>> DSB support on the TPDM.
> 
> Understood, below codes will be added in the caller to check the error:
> if ((tpdm_data->dsb && !drvdata->dsb_esize) ||
>      (tpdm_data->cmb && !drvdata->cmb_esize))
>      goto err;
> 
> Thanks,
> Jie
> 

Hi Suzuki,

I've reviewed the logic here. It's not feasible for the caller to 
perform the check, since we first retrieve TPDM's drvdata, which adds 
complexity to the code. I believe it's better to handle this within the 
function itself.

We are expecting the element_size for cmb if the condition is true, as 
well as dsb:
if (tpdm_data->dsb)
...
should obtain a valid element size for dsb.
...

if (tpdm_data->cmb)
...
should obtain a valid element size for cmb.
...

Thanks,
Jie

>>
>> Suzuki
>>
>>>
>>> Fixes: e6d7f5252f73 ("coresight-tpda: Add support to configure CMB 
>>> element")
>>> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-tpda.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/ 
>>> hwtracing/coresight/coresight-tpda.c
>>> index 0633f04beb24..333b3cb23685 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>>> @@ -71,6 +71,8 @@ static int tpdm_read_element_size(struct 
>>> tpda_drvdata *drvdata,
>>>       if (tpdm_data->dsb) {
>>>           rc = fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
>>>                   "qcom,dsb-element-bits", &drvdata->dsb_esize);
>>> +        if (rc)
>>> +            goto out;
>>>       }
>>>       if (tpdm_data->cmb) {
>>> @@ -78,6 +80,7 @@ static int tpdm_read_element_size(struct 
>>> tpda_drvdata *drvdata,
>>>                   "qcom,cmb-element-bits", &drvdata->cmb_esize);
>>>       }
>>> +out:
>>>       if (rc)
>>>           dev_warn_once(&csdev->dev,
>>>               "Failed to read TPDM Element size: %d\n", rc);
>>
>>
> 


