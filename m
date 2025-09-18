Return-Path: <linux-kernel+bounces-757117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC54B1BDEE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 02:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF6F626479
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 00:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEAC7DA66;
	Wed,  6 Aug 2025 00:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gjlQtiz3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB52171C9
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 00:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754440365; cv=none; b=Nd7oek2NJEji0Zf38C+cNP3Bb9+uSaVA3KIZlofPZwO+67h7Tq26CV+sCr46/MDHVQSRGoJHqYZ8X3cHKW90SoDI0p+Fr7PwyxcA/6ID6sRy9ZEOtXT4mvldRr08gs8ZG3JRLzAR4OOnuAmzwqM7V1RvLLIfGkS8x2BvFwaGIOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754440365; c=relaxed/simple;
	bh=z/pkgbDTk4xjPzL4wm6uTA32U5+mI7SVR6rXpU8vsls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NuH9+3KbCOeyIAmfAWCa9gHL8XKWh58nTnpOdtbloPo8wBC699zybpuv7uK9IJEA9GVa67NL8KOhyooqmz9q2ZAwLzeVoApYwoPwv30YNRvWDD/fs8jbTUywymfJdT7vN0k2UgtWFSFmn69qnxx7FivdUgJZeJFR07FkE2DAqrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gjlQtiz3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575I8Qcp000519
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 00:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nCm1tUegqx7mcpc1Z5HobyZbVzfa+XlUJ4BJ6xj5K20=; b=gjlQtiz3V+w3xX4V
	6Qlfa6EC744X3TiAjzDrPMi7Y1X7eva4XAjQcp/4Nq3NXtGs6o7sLLLGs3I2hUbw
	o9wBHNAflOXDalxaM19AtYUnb8/fyu+7Ef6tgni2f9tt9UWmNqoctzoNjpRNnIbg
	tYEOokrh+dMS22M2+G/a8tv30UYEDhpnAc8eh4RcEDOANUDKYHBu8ET3Yy/ESrdS
	AjfQSZjB/TLD3v5QlcZkbhtVgi/8pq8Z7RiVSu/K88OqqVRP+d99Zi4+IkN2vloa
	Lx84ub7o4mKTGcYt5AQwwLWbmJFBHRAyngFCaTHOOdXqmfxziTpGjFBMbXG5bfut
	3oHI3g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpya8ukq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 00:32:42 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23fc5b1c983so4196685ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 17:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754440361; x=1755045161;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCm1tUegqx7mcpc1Z5HobyZbVzfa+XlUJ4BJ6xj5K20=;
        b=CDK2oCzLANiYEDHDoZVFibglkqx3SMbUP1UbtPy7DMjchyjlvs9KJwpZx3h03MWHg2
         zUNZA61jdywVePZAygMpEhKz6iMn9a0rR0SupiPxToPSreVWasHC+NEzWd8zggyqdIqd
         mCZQ/Fu/0QfDmat9UeXwFiKjVyqfJLBrbAxLHquWdFOEJWNnyd0NkLJmwn3IO6d9gp/8
         tlz4A0UKVfYINyHFkNWjLDYXEqk2fbtFQYudqu+AKNgqX3NUnfEKtPMzK3AvVWy8sLCo
         jCJqSl3/bnJMZuy069GQGPilC6u/LsuV3xySFNP3LxPXt1uiCsQ7VWcNiwTbCufQfu1O
         rSLw==
X-Forwarded-Encrypted: i=1; AJvYcCXI3WLBOefzguChy77fETfTRuWLpqtBJUaHt6xeShiZBXhMJ78AaApG8OEM6jpSgKPwb1OL9g8Kx4izh6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsHpV2UkiqbHtk3yRhihaIsaTa+BnXFTkJTeJR0HL6pTDxBZmA
	evuKnU1l4boYaDP4xvEglHVH6wtbEa1DFGduUgVmOhzZUVJdhxE5kA9UOL0AaM5laan4Yzf0irV
	4KjxfScUWO5uHPjrIsv+ePFQhgsDiMfSvfudPNX4lr4dqbwbpaP8lItOYvorq9mvYhxI=
X-Gm-Gg: ASbGnct70ghQdqjX/+CazKyLkFvksY+JqpiCEaYvmUtIZx8k18DovdJUcO+eXhr7l+m
	Et1RR8iAkerCzbu9fTjakIT/NCelxOpBhZOfaWSUes5yzQq4PE9i23BuhyRrtD3blFTICMlyDs5
	vq8FC+HZl/IThFbs5ZeIF5yIi8nwsyPcnJxZXUZyg+nVLiLs0d7j2SOvy+m6cx3LKjuP8zgVvuG
	HJIy7DThc9Mq+pXj4j252r2dIjZ//a8harUp6lrzv8lBb1qxAwNBxUcrbXiM0CN7AfRkQXWumbd
	hrSjx/loGlTzvY3Wl18YibCiGwIYi+/K19+QPnSlxkapE29HCQdmk9bY0ije/K8otlrIV2DHhvr
	IgilfembDldC4bw9eelqIbsLp
X-Received: by 2002:a17:902:e550:b0:240:4d19:8774 with SMTP id d9443c01a7336-2429f98fc5amr10815615ad.24.1754440361518;
        Tue, 05 Aug 2025 17:32:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr1EmLymPDG9f6dSPFvoN/hEjN48sinKuRQr7dOOX0ZYPmD4JaThfNyEnAqIxOJ6qOmxz6bg==
X-Received: by 2002:a17:902:e550:b0:240:4d19:8774 with SMTP id d9443c01a7336-2429f98fc5amr10815335ad.24.1754440361082;
        Tue, 05 Aug 2025 17:32:41 -0700 (PDT)
Received: from [10.133.33.195] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f21be9sm144969375ad.72.2025.08.05.17.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 17:32:40 -0700 (PDT)
Message-ID: <ae3a482b-2b8c-4390-a950-f9612303003d@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 08:32:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] coresight: tmc: add etr_buf_list to store
 allocated etr_buf
To: Mike Leach <mike.leach@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Jinlong Mao <jinlong.mao@oss.qualcomm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Jie Gan <quic_jiegan@quicinc.com>
References: <20250725100806.1157-1-jie.gan@oss.qualcomm.com>
 <20250725100806.1157-4-jie.gan@oss.qualcomm.com>
 <CAJ9a7VijwFKiaZzKsSKPynWapA3ik9d7JLeE+yVNFB0T62iH-Q@mail.gmail.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <CAJ9a7VijwFKiaZzKsSKPynWapA3ik9d7JLeE+yVNFB0T62iH-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oFMUDAoudj63mQJBzQDbp5uO_5cOkJy6
X-Authority-Analysis: v=2.4 cv=MrlS63ae c=1 sm=1 tr=0 ts=6892a2aa cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=U2YxrCIlBwdvewSZISMA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwMCBTYWx0ZWRfX/1ShUEEQsvrx
 TU78TokS35k/7f481mo9/oZpEfqRGm1WB9ISwOsaDc799A2HOfNwv7XxObFC+Cz6YIvfHUNOG9Y
 vkKUrMT46/6zAOQisnoEJDSlGtyrPIiPArGa0tsLC87WOTYoDL2Blcf5qiZPpv8IVHGXQT+H12/
 zpiG6DyF0OBrKT4OwbdLLxcG7JCNeyaTCxB+v799RoGyzbR4PjQbkICDPfpVQ2M8XED0q/fmSeh
 F6f0QcHUVdSI98yuF6q104KeRPDMvQCwSSxSqhWHTp3dgAQlto8DscX7NrdtlwLEBRqGC/6jeMp
 VblQZ2ujDE2AsaqfSZgMBO/fel7Vg7hQsttFkrnOTt/+h2K+JwO4GpeYNOEj+EDKouvyi3l3RL5
 r1PMcqoNgOvmyFwoVisWFLJ8M3A/JDTMalNpg3DIKLUtcQzxJobCFjhGzQ+nHbLeqv4YliMf
X-Proofpoint-GUID: oFMUDAoudj63mQJBzQDbp5uO_5cOkJy6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060000



On 8/5/2025 6:15 PM, Mike Leach wrote:
> Hi
> 
> On Fri, 25 Jul 2025 at 11:08, Jie Gan <jie.gan@oss.qualcomm.com> wrote:
>>
>> Add a list to store allocated etr_buf.
>>
>> The byte-cntr functionality requires two etr_buf to receive trace data.
>> The active etr_buf collects the trace data from source device, while the
>> byte-cntr reading function accesses the deactivated etr_buf after is
>> has been filled and synced, transferring data to the userspace.
>>
>> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
>> ---
>>   .../hwtracing/coresight/coresight-tmc-core.c  |  1 +
>>   drivers/hwtracing/coresight/coresight-tmc.h   | 19 +++++++++++++++++++
>>   2 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> index be964656be93..4d249af93097 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> @@ -830,6 +830,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
>>                  idr_init(&drvdata->idr);
>>                  mutex_init(&drvdata->idr_mutex);
>>                  dev_list = &etr_devs;
>> +               INIT_LIST_HEAD(&drvdata->etr_buf_list);
>>                  break;
>>          case TMC_CONFIG_TYPE_ETF:
>>                  desc.groups = coresight_etf_groups;
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
>> index 6541a27a018e..52ee5f8efe8c 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc.h
>> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
>> @@ -208,6 +208,21 @@ struct tmc_resrv_buf {
>>          s64             len;
>>   };
>>
>> +/**
>> + * @sysfs_buf: Allocated sysfs_buf.
>> + * @is_free:   Indicates whether the buffer is free to choose.
>> + * @reading:   Indicates whether the buffer is reading.
>> + * @pos:       Position of the buffer.
>> + * @node:      Node in etr_buf_list.
>> + */
>> +struct etr_buf_node {
>> +       struct etr_buf          *sysfs_buf;
>> +       bool                    is_free;
>> +       bool                    reading;
>> +       loff_t                  pos;
>> +       struct list_head        node;
>> +};
>> +
>>   /**
>>    * struct tmc_drvdata - specifics associated to an TMC component
>>    * @pclk:      APB clock if present, otherwise NULL
>> @@ -242,6 +257,8 @@ struct tmc_resrv_buf {
>>    *             (after crash) by default.
>>    * @crash_mdata: Reserved memory for storing tmc crash metadata.
>>    *              Used by ETR/ETF.
>> + * @etr_buf_list: List that is used to manage allocated etr_buf.
>> + * @reading_node: Available buffer for byte-cntr reading.
>>    */
>>   struct tmc_drvdata {
>>          struct clk              *pclk;
>> @@ -271,6 +288,8 @@ struct tmc_drvdata {
>>          struct etr_buf          *perf_buf;
>>          struct tmc_resrv_buf    resrv_buf;
>>          struct tmc_resrv_buf    crash_mdata;
>> +       struct list_head        etr_buf_list;
>> +       struct etr_buf_node     *reading_node;
> 
> Potential simplification:-
> do you need both reading_node here and reading in the etr_buf_node?
> reading_node handles the logic for which buffer is being read, while
> is_free handles the empty/full logic - reading seems unneeded?

Yes, you are right. I checked the usage of reading. It can be replaced 
by reading_node in switch function.

I will simplify this patch in next version.

Thanks,
Jie

> 
>>   };
>>
>>   struct etr_buf_operations {
>> --
>> 2.34.1
>>
> 
> regards
> 
> Mike
> 


