Return-Path: <linux-kernel+bounces-798177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA31B41A57
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF09562CA9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AAB2E1F06;
	Wed,  3 Sep 2025 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PjbaNc07"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A1D2D543B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892710; cv=none; b=r751K5rWOFZh9xjOK1aNOcQvZSlrHuHNDIGiTkfcp7S2s2jGzOfhCeddd8VHpAZOpSNmPfy2VcbkJvlmR5SdiD4yCfDF9ZH4StE0tcyS+5BkDPHW7r2bsGmaoJDoD+CG7HiPA/cg06qIXvYwE0/Eb3mHMxzU01N08vZB2unjFxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892710; c=relaxed/simple;
	bh=q2v6qcZzixcAqEr1REji/2UUZTWKwLk2qjxlSyh0MnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JgmwPYrztOTki923kgiNf3gfvXKpYhbklZw5sVF29RBDH6DVO9xaA3MuZXcWDyKkL64nXR9CvmKx3LOLTRPUVlbFRWZlqQZvAeRu6PAtT7BHy/Hdk5MqI3vQLrG5R4R1XX4FQNtGTab894BJEfoXo1sVEZhVxbdVzJCSHsP16+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PjbaNc07; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5832BLDU023514
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 09:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m8WRXDLSRnC8XRPAbQ2iesTlZT33OnNC5zDDlBuSNGI=; b=PjbaNc07VLQWPeew
	KfcHi80Y+0EX57nMpBmXgS9/I2NIN0F8iRzvE4GD89CBguJys9SeHUOmTD6n9Xn7
	wgTeGrw/6pyGiSQ71Xb8udoE4PwTzERaBXhAmCSNCQrYD6vrwfmk0dsw5UcPGwbr
	P7xV34myPe0FLGnk1wlydipkRJl55SHSdr2P8U0kC2Pg1nEDjutyTnF+w+txpis3
	zbl3IkXeXUr9jHLnh5x4G2nelojxg5C4z6euavCvgZFKQNhcg5koP8lCxTHcXUYW
	nNWCgtYw9fzla2JX8mXgSsPw83zlES0D0aTsAhmHjmR3vMWvvlm6CW39VMKGhpfd
	BWL+sA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpb8m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:45:07 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b47174c667aso5149673a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 02:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756892706; x=1757497506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m8WRXDLSRnC8XRPAbQ2iesTlZT33OnNC5zDDlBuSNGI=;
        b=Lxd3iuHkF0MsavA8rg5dh+AxJ/chP7bg6KRHhv3axSM3IFLb1GRta0V5cPaUKgun64
         sLVCAKZVOUAvI+c14HtQwV9Q8QMDjk0twahVZR6pwX6ilrZWs237FTJAuwG476AsYSTs
         pVjYhLFRHU0NxCRBBLZGDdgQkYXT2hPmJ4g/eQ+8ooblbMcKJB1xDhxo+K3rG+/zKIVK
         bj10ECzAXjdSyD2JLUYZVnM6iT1vbGJ+HoxKIoPIrZpnH5LjYaxpTa5spPP1IgQ1YXlW
         MGuXT2I+DDjbVwnK8MxFwltfQOHSB/JeJElhjOzAyEjG0oG5UoKPLjYr/Khx+mfxWE4R
         Io5g==
X-Forwarded-Encrypted: i=1; AJvYcCUtjR3gse887ICRrR6ybpy7bkL45OvVcM2JHr7l9YluqLmIXZ23Ngpj5SK6pA/uq6+ciojksIxFvUbu2SA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN35Bnt0wrCuoz3t0iOx427hXZ5t4A14jOmfLNz09UWn/WHF87
	iZCx/0OQD0RNoIepXlUns5oogCSCi4LOlitstqx/9Nvl5qmwhL4EyGz3Zq/9o7K9v6b9yPQcMoO
	3CPfcQBbTwdg+3dakra8nFGwp2MWke+/rHFkVnfSEMdzQvLW6yLDZwl0fkLuTFiO0Fi4=
X-Gm-Gg: ASbGncsEy0AGOnqGmtxMFPKwSTh6U7rxM59X2KQUgmq2yRvFcZBCY0lFz+WFQPlOE0R
	e2xASuQEgtvoW+PQ6Q6AOL1dk+/YI3kXfG2LpQCXjnDiKgDEAyYk6/6fpfnrtq2Tx8av8dygHzS
	gPW7v6GuStY30yL3sIOhgqbo3zNCgxwjZU/ukjgccWNXmbQNb/3WDXUqF7EvPAU/Mcju+zo4S32
	Ia7j7KZf3QWy37w/e0+8Dcj/YWIR1dq4zAlDEv1mZ/At7Es4YypeWSfna/Fb4gpGS38zN5OVAM5
	E4XgVNxczJblBG4hMNx6ldrrsfP1SLtVl0YHp08337lhEXy3Ek2wVaH2/APPuby/oAEKn+rHkQQ
	yqmT44W04SYeJw36Bv7iUSRFIXlsY
X-Received: by 2002:a05:6a20:b925:b0:245:fdeb:d26b with SMTP id adf61e73a8af0-245fdebd5dfmr5431185637.15.1756892706122;
        Wed, 03 Sep 2025 02:45:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhlCR8GZ69GjRWnu7qYDF0wGBonOzAihcPkBljNIdZqZmqvkKzLdcmu02p66LMVveec+jfhQ==
X-Received: by 2002:a05:6a20:b925:b0:245:fdeb:d26b with SMTP id adf61e73a8af0-245fdebd5dfmr5431151637.15.1756892705626;
        Wed, 03 Sep 2025 02:45:05 -0700 (PDT)
Received: from [10.133.33.16] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723f4858e6sm12597072b3a.4.2025.09.03.02.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 02:45:05 -0700 (PDT)
Message-ID: <a4382db3-115a-4d79-924a-08507e6e7b3e@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 17:45:00 +0800
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
        Jie Gan <jie.gan@oss.qualcomm.com>, Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: tingwei.zhang@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250806080931.14322-1-jie.gan@oss.qualcomm.com>
 <2f243b22-d8d3-4352-b226-aaf9ccfe825b@arm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <2f243b22-d8d3-4352-b226-aaf9ccfe825b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dFpwKpa3Z92_sB8aduqCuBYwBXkXWyLI
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b80e23 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=pGLniPwaoQ1pyRlj9UEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: dFpwKpa3Z92_sB8aduqCuBYwBXkXWyLI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX4Vvt46jC6H9n
 4LtDgV62xu9Jda+qT44kM7UfQ4CY6bDIGZF6gDdJ0IGNk5/Pj/e8MHO68JDMSTos1RNX6My8NBm
 rlHBHcvmeVgsa2QXEclZAdF25I0pWE3JHPLaubgsoNomDUY3gt4ing/bxtsnTwWDCOEGmgbznm8
 YHrYidaL+6ZKIx8lQ28EpWOcF5qs3MHQY4XY/1g57lVzdrNsy7KRQtueqkWdezxq6cMQCqTY47S
 4zVQXZlM5+fun8kmsauMEMNQ8XNqbNptQGVtcPii4UE9znndXAtYph0HoAeBSVEAnq/ubLK8AdE
 dhHtmJyo+5xrndd5b9XLa+cszRVk8X5Azhg5E2VmKGILfuVlFPLdg1GIoROs9GWTbCV3YjmQQ7i
 ihIGRfkN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001



On 9/3/2025 4:57 PM, Suzuki K Poulose wrote:
> On 06/08/2025 09:09, Jie Gan wrote:
>> Some TPDM devices support both CMB and DSB datasets, requiring
>> the system to enable the port with both corresponding element sizes.
>>
>> Currently, the logic treats tpdm_read_element_size as successful if
>> the CMB element size is retrieved correctly, regardless of whether
>> the DSB element size is obtained. This behavior causes issues
>> when parsing data from TPDM devices that depend on both element sizes.
>>
>> To address this, the function should explicitly fail if the DSB
>> element size cannot be read correctly.
> 
> But what is the device only has CMB ? Back when this was originally 

We have CMB TPDM, DSB TPDM and CMB&&DSB TPDM.

> merged, we raised this question and the answer was, "Only one is 
> supported, not both." But this sounds like that is wrong.

I think we may not answer the previous question clearly. But it 
definitely has issue here.

> Could we defer the "Warning" to the caller. i.e., Let the caller
> figure out the if the DSB size is found and predicate that on the
> DSB support on the TPDM.

Understood, below codes will be added in the caller to check the error:
if ((tpdm_data->dsb && !drvdata->dsb_esize) ||
     (tpdm_data->cmb && !drvdata->cmb_esize))
	goto err;

Thanks,
Jie

> 
> Suzuki
> 
>>
>> Fixes: e6d7f5252f73 ("coresight-tpda: Add support to configure CMB 
>> element")
>> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpda.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/ 
>> hwtracing/coresight/coresight-tpda.c
>> index 0633f04beb24..333b3cb23685 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>> @@ -71,6 +71,8 @@ static int tpdm_read_element_size(struct 
>> tpda_drvdata *drvdata,
>>       if (tpdm_data->dsb) {
>>           rc = fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
>>                   "qcom,dsb-element-bits", &drvdata->dsb_esize);
>> +        if (rc)
>> +            goto out;
>>       }
>>       if (tpdm_data->cmb) {
>> @@ -78,6 +80,7 @@ static int tpdm_read_element_size(struct 
>> tpda_drvdata *drvdata,
>>                   "qcom,cmb-element-bits", &drvdata->cmb_esize);
>>       }
>> +out:
>>       if (rc)
>>           dev_warn_once(&csdev->dev,
>>               "Failed to read TPDM Element size: %d\n", rc);
> 
> 


