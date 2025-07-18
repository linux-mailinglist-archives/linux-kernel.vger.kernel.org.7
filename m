Return-Path: <linux-kernel+bounces-736641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A588B09FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E28E167433
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC8F298CB0;
	Fri, 18 Jul 2025 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OOpgf8ho"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576E4296150
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752831405; cv=none; b=ppoW1UzdtkPTzO5Ls0l3bS4rkE1tetwCPRruUHTz4QKT9QOuPkXm2USZqBWzClgOkNDMkAkgnua0yNLMzCpQcUDMnuHXq8jRk1PNZCb347Nv72jeIK6J6IUBnSqtlE2i7MIBbNe1wt4Y7ggEmlvg1ShdiArgrfpcMgLfIuERcMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752831405; c=relaxed/simple;
	bh=qEFZ5DH2AG+giULJkp/4FDX1QNcmSbW+QRxBkpWw1p0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKHEF192vi9nt0ZXfFbOXcTn+Fb3tXWsJrkAI6KK+VJya532fp1bFvdJ9eaAzl/dMAyskG20s+xKPSof5Jaq2QnUp0ovlkGMt9ttg+TgAjK+VNxTIy5ADvTNXRNTHTAZAk7ckRwUp58abBNjez8E0upYp5/DyfEQ46teQ5rIEcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OOpgf8ho; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8NQaI028159
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	72fuRZDHA2C4w80oHJ+JOeIuL4vnW4n3bjADol5r4EQ=; b=OOpgf8hoD7V37vAx
	B2k1F++oE8DrbU5e9psagCXnTfbdUG664WOHtYv5bXYTWSZYWUNVbXFOTKF+VkTE
	TXrVjMF0uzp9pzSoumW8oAW0JzeYMw3u78Uq4vO+tA2Vo/oRw4kmLFp6KbLdJP1K
	z+UBkzh8jHVpRKXM462OwntkvVH1VQRzmwnLzNSAVMI2vj2apa9WVuOQlMILUhBH
	x6VDwpiZ79+qs9zOGAo+M5i/fIlsNJlSbOIdAzRQYIhLE0RnIBDGh35ZZ5SMtaPU
	7iRu1qFz+yqEuuAEvTLCIOXQuZ6rlIPZTGqOvXBeYKRwdjsUzoJF6wzs6JfWbc1J
	Zqaleg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh637qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:36:42 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2382607509fso13560545ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752831402; x=1753436202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72fuRZDHA2C4w80oHJ+JOeIuL4vnW4n3bjADol5r4EQ=;
        b=Frwb0scXPbyoRDIwWiZRpaqJsX6yi7bnHtSMwluiBN/KFgi2sFYMxE9t+VtM/ty1gj
         N/HeVdMzgCuBqthjvTyG0QlspdBbjadMppCBaxBCGAQmjrdazye5RQkOogCnHUIVImRz
         B3IeMjSe2NeC4S59Q3KuN4PJAhSDPlLHdhkreSZKP6aOL8DIH1yO5WX0hDZMbLTsw+i4
         fR0vuFimvjXk72dExeenANKpjPrfPpE27WtSpjkfEVbSGw+/P9rHXi+aTGes45+I9qys
         kBX6m8Pf+CwTw/PxX5lmOedqhI2kUC+wYHQd+YQytkcj5mJVpNyhEYsOrhAYJw9aZE6i
         PCIg==
X-Forwarded-Encrypted: i=1; AJvYcCXYeONQoJsbV73yospKw0R2kBF0L4I7ZKKQSmdE8cal6htDw9zKlI02LxqX1aia44AfWgQt7VLMMRXAA84=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDfxp0GQ3Jp4M0PYZq0xLJVDxHaTXhwkdAYJWoMhyWvysF2vmg
	yccqLy+At6ifs+9yNMbgoCHHRVnIjjVhfsf+Y38GASmbHzT0Y9fXYk5tt0ohZTWZK6G6uxpi4Ob
	4iFF4LStHf3rf4Tnw9mhmB+N1ari1jVZvdHltTs7+rQ63YvD2KwE1mlApqlCJ4nODaUY=
X-Gm-Gg: ASbGncv37BFfSCZm+L9qC9kB4gk7QR/JlW7T9Rze9bHdQiXO7Wup6Sp8PcHXLkrpqWS
	Ih0Lg5GyQl0gvIPjAryJlg1L748sAopeEq7l0wFYYUhi6WbjmrS0+j4Wq7Xvj0b5gMfVO7GdWgV
	Wh2h88uMUkX4xPR77AuRjLwakOZYtUJk9w1svl80J0yetW58ClnxeZzr1PPYLKU8gynwjsMPl9A
	PGhFnzWsZVc8tojbg3P55J5CLU71xyOTA/La3sxmg6Xs2JzkTRtZZYWi5KWasw5HQ94XVXAf/Vm
	RKUWoLKXq2lmR74eAf895Hvj40apGbv5CPEutzFG/8kXoVLteYc3WUAd7pjlmPmXAT+DkZzhHBV
	R0fEH1LuuXaPG2vWMBbg8Xm4=
X-Received: by 2002:a17:902:c943:b0:234:ba37:87a5 with SMTP id d9443c01a7336-23e24f4a7c9mr130870315ad.25.1752831401594;
        Fri, 18 Jul 2025 02:36:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp4sFfqHaGHRuWJ/EeS/AGLmlnSykkRcmXhCvLfBNJz2Ba7o/Pxq0DoSFqc2RPSb3hpiQ0Kw==
X-Received: by 2002:a17:902:c943:b0:234:ba37:87a5 with SMTP id d9443c01a7336-23e24f4a7c9mr130869955ad.25.1752831401127;
        Fri, 18 Jul 2025 02:36:41 -0700 (PDT)
Received: from [10.133.33.13] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d2a82sm9687825ad.156.2025.07.18.02.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 02:36:40 -0700 (PDT)
Message-ID: <da49f445-7365-4863-bb41-f7a55150c4dd@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 17:36:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 RESEND 02/10] coresight: core: add a new API to
 retrieve the helper device
To: Mike Leach <mike.leach@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Jie Gan <quic_jiegan@quicinc.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250714063109.591-1-jie.gan@oss.qualcomm.com>
 <20250714063109.591-3-jie.gan@oss.qualcomm.com>
 <CAJ9a7VikU9UktC-fpLfR5EdpGupHHor2GaDGAujBnQJky=W17w@mail.gmail.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <CAJ9a7VikU9UktC-fpLfR5EdpGupHHor2GaDGAujBnQJky=W17w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=687a15aa cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=4z_qIjeFvS-qpd6pgFUA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: OhtVmxVFS7twyoh4D79WtfxA_I0D9mS-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA3NSBTYWx0ZWRfXwqBsfTmNd11s
 5paC8lMbjMo9lNqsTG7G0LYJUdqAc2RlatLEOYGL9lDgSbtxnaRc7iPxkyToyoBIg94zW6b9uxQ
 y56Kyx9zdP9hVTiOc7dH7uv7QCrqWdxU2OgUN+BdCJ5YSG5D+aEy0Zazs4LE54IvG0JszkJNKV+
 3kZQ+Cz5KdgwKmzZheAe5hHHpZSFyLV2gxgXFk9D3cdfcES2DI4f19mpCIkuUUWDfG0RcGfijCS
 m86v7kLs/w/Kf5wHK1NGD5i/zfuIJQuUVppMWLELcRnR/AYh2wu8UljblPnUotJzxBfhWk7uj4J
 cCzsgVot7aAjR9pKcz9/dzLbD7uPoXC5OGgQj2trulX+79yf0hToV2a0IPlIeItWbdBlc/hAFhW
 aOx8Q2s4b075YuRCtCvabSbtJv/sDOOodnmRY7PpKtDi74WtaxOt3yOScbaEwnzEsOW4aEAT
X-Proofpoint-ORIG-GUID: OhtVmxVFS7twyoh4D79WtfxA_I0D9mS-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180075



On 7/18/2025 4:37 PM, Mike Leach wrote:
> Hi,
> 
> On Mon, 14 Jul 2025 at 07:31, Jie Gan <jie.gan@oss.qualcomm.com> wrote:
>>
>> Retrieving the helper device of the specific coresight device based on
>> its helper_subtype because a single coresight device may has multiple types
>> of the helper devices.
>>
>> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-core.c | 30 ++++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-priv.h |  2 ++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
>> index 5297a5ff7921..76e10c36a8a1 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -580,6 +580,36 @@ struct coresight_device *coresight_get_sink(struct coresight_path *path)
>>   }
>>   EXPORT_SYMBOL_GPL(coresight_get_sink);
>>
>> +/**
>> + * coresight_get_helper: find the helper device of the assigned csdev.
>> + *
>> + * @csdev: The csdev the helper device is conntected to.
>> + * @type:  helper_subtype of the expected helper device.
>> + *
>> + * Retrieve the helper device for the specific csdev based on its
>> + * helper_subtype.
>> + *
>> + * Return: the helper's csdev upon success or NULL for fail.
>> + */
>> +struct coresight_device *coresight_get_helper(struct coresight_device *csdev,
>> +                                             int type)
>> +{
>> +       int i;
>> +       struct coresight_device *helper;
>> +
>> +       for (i = 0; i < csdev->pdata->nr_outconns; ++i) {
>> +               helper = csdev->pdata->out_conns[i]->dest_dev;
>> +               if (!helper || !coresight_is_helper(helper))
>> +                       continue;
>> +
> 
> Manipulating the connections list almost certainly requires some
> locking. See other functions in this file
> 

Thanks for pointing out. I will fix it in next version.

Thanks,
Jie

> Mike
> 
> 
>> +               if (helper->subtype.helper_subtype == type)
>> +                       return helper;
>> +       }
>> +
>> +       return NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(coresight_get_helper);
>> +
>>   /**
>>    * coresight_get_port_helper: get the in-port number of the helper device
>>    * that is connected to the csdev.
>> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
>> index 07a5f03de81d..5b912eb60401 100644
>> --- a/drivers/hwtracing/coresight/coresight-priv.h
>> +++ b/drivers/hwtracing/coresight/coresight-priv.h
>> @@ -158,6 +158,8 @@ void coresight_path_assign_trace_id(struct coresight_path *path,
>>                                     enum cs_mode mode);
>>   int coresight_get_port_helper(struct coresight_device *csdev,
>>                                struct coresight_device *helper);
>> +struct coresight_device *coresight_get_helper(struct coresight_device *csdev,
>> +                                             int type);
>>
>>   #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM3X)
>>   int etm_readl_cp14(u32 off, unsigned int *val);
>> --
>> 2.34.1
>>
> 
> 


