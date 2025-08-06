Return-Path: <linux-kernel+bounces-757297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5730B1C070
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B663B6567
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 06:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777A2207A20;
	Wed,  6 Aug 2025 06:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O3uz2cyX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9637346F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 06:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754461813; cv=none; b=D6DUtkXhgl5lG6k8wBMRDUs2xrrsKLCNNXuTOlCcYF+x+bVwi20CtpPG3u+Tqmj5djF6Ci2XLcl655Gf85aeaIXl/Vkenu7csJWIytA7puZ7UDVDGiW3WOfLDz83ZIFt21Mz4d9OPvCwYhII/0J/oclmNbjEGYC2Al4YkfH4JOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754461813; c=relaxed/simple;
	bh=CgooJ/jB093nYS3wRfCZw5jiPQzBfc+yd3WzwPS1Eso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHLNr72q4JeUGcivcoz/L7eL2z27/XlNJk0YYSe3v0MboL+QvAPjEyXO6DNlHOO+6za+hgmEDYjMIxu5fFf1AuQkY2ZazVIxpDC+ty2Ur4P/u+DUJ536oAuWFQZ4dA22sVhFLHZ7CXHyG1TeoFZl+zGK6599TlGSWYeWPJYOPTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O3uz2cyX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766RTc2019692
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 06:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tJtqmRjoumc2ISMrT27MKjQkUzD5+VvQigPSswUASss=; b=O3uz2cyXuhDQmSYI
	K2B18aK3qg+AYb5RUumOXeQX8TlyEMv4wrP5kqlkmPqdxPu4ZV6yh2ra+opLHoP/
	PzstktAU/jK0CevuBWUc3ota6WEgTD0n3vHoXfnsilhbNee//np2ZBxwQftiRNWF
	EI4aPbyNknCq/ytOGbZFrgY345vD80R9yeDPG5FRdGOWRPYVqcgpGMgEnhtvD8lj
	UA3MsrFpLicOEdGixkbSYKhMLtRbwoTSFKvtOxEMkQUUcckJHXpP7Vu0X3bFaJDK
	rVolGXECH+LC1uQM70gS/GcVlSfEmACGwah6E4GuLT+cPhSMEu+pT6OsgXBxlRR/
	Hi3zwg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy6sk5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 06:30:11 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31eb41391f3so5855326a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 23:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754461810; x=1755066610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJtqmRjoumc2ISMrT27MKjQkUzD5+VvQigPSswUASss=;
        b=wg+EpgkKkjkWd0Vubg7Xcfhn5zsp9stAAE50bbIJhy6kUOcdXPVgPnnRVTRGPApV9v
         yB2VGLIILR33Jcei7Uf1KFOg3hi5VzM49KriOCu3SKhKAkVUIOyGY1m+KPtCN5Ok+/07
         kbs8rat1XJJvVvDWkQmiQ1IiNswJtgTHVKmOPvLEiybDw36lnnjq9VPjQuD2lmNNq7T8
         Qayq+Xh1tZ6A/5nyKKr6nlZtZw3uEc6/UbeGkxXn1wQdSzpOAlPMTvS8Ht9JzthB96ur
         2vYoHOhMv5rwq4EmNaK1+7aiPjpfi9I11PjAgWoRZF9JMCOjuAlYiOvj61dme17F2Vhh
         aQBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmkAABmC04PmqqK/xOLj/6vmjvSXMrNiqIp6wpDcPD1Bmh1xRfu9BFpiSi3Oii2tf/7TxH8yaUCY/AUHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRlG/fKrzMExZ2nyqfv/Sx6ouhoLIvR1Ss+b41lYuKcVZID0Iv
	7kjf7RDLqUUKYr14rg30RE+1hH+TcbhojsB8Z5I/rFSwY9lYKH+o91tJpfvaid3/fziqs0HsoKJ
	dxsBoLM/Na5nKL52KGGWC9mHP1RoJUl5F6AgrwgmX2IoBalIjxYM0CTa00dNbVyI87Ug=
X-Gm-Gg: ASbGnctXxcu319rv5ZpY9v3ur03Uxg7zsMjHE2CiRUm9fk0/GSjM0fcK4OIRNDIeXcu
	7zRXBbxBNAjfC5AvRoG8NvsltrxC6jtXr+F2IWbzfdOsdM2s4W9jQqXX+ssQNP2FY9tnq3FMCBJ
	6aamhfQpUUlII2deNxnEiOoT+UTh46ItUkXfefdIaty+1jgEkQXbH04/f43bRbndEkRfUNrU2NL
	2qtJ+5/alz6ce4Aso9wArbogJ07kKC+4QaTAQYyPWSLKqyOHW1XIXRn3CjdEAEKTEB1fKaHZ8KC
	VSgY3n2itgQ9/M2uJH6B9i8zgGAMbGgh7kvYTp+YbzTEXiFbBADCYdaYFUjH2GegSXC55vktQxl
	P8HPSgY1vUn6PVbP4EDuIPk2M
X-Received: by 2002:a17:90b:5706:b0:31f:6d95:8f76 with SMTP id 98e67ed59e1d1-32166cca3e0mr1947013a91.29.1754461810378;
        Tue, 05 Aug 2025 23:30:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQzfZEJLHL6MCbJYYh45x632/2CHYTmprEp0TtYcsp2qKJGyhNfr/FhP3PJd1HyC3SEDMGfw==
X-Received: by 2002:a17:90b:5706:b0:31f:6d95:8f76 with SMTP id 98e67ed59e1d1-32166cca3e0mr1946971a91.29.1754461809894;
        Tue, 05 Aug 2025 23:30:09 -0700 (PDT)
Received: from [10.133.33.195] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7d86f7sm12649913a12.24.2025.08.05.23.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 23:30:09 -0700 (PDT)
Message-ID: <70bf0c0c-4a78-4caa-ab86-76a2c99c113a@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 14:30:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] coresight: tmc: Introduce tmc_read_ops to wrap
 read operations
To: Mike Leach <mike.leach@linaro.org>, Jie Gan <jie.gan@oss.qualcomm.com>
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
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250725100806.1157-1-jie.gan@oss.qualcomm.com>
 <20250725100806.1157-6-jie.gan@oss.qualcomm.com>
 <CAJ9a7VgYTUsBn8=qtfwmkoS6Lib-8LgESLBDxXrRVqLnScLKZA@mail.gmail.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <CAJ9a7VgYTUsBn8=qtfwmkoS6Lib-8LgESLBDxXrRVqLnScLKZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: mgRpzkfMdiaCF1HVPnEHSKO4CGs5yuf0
X-Proofpoint-GUID: mgRpzkfMdiaCF1HVPnEHSKO4CGs5yuf0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX3hplUXIMh73i
 bdMcsf/BHt7VQ10BxQY9KBqVz5ChZKiaNWZpD0qqng39+Y1tAfvChdKfP2eeMhNYZw6c0H1Cxil
 XXKC+Fx/lDdDHtE4pNFDspz5RdF/cu8d4HNMtlUzus1a9aOofCLdUxTJNeaKZ4iwgTf4+Yz35de
 zDpTf305f1D23Nz8rI1Yzh0hWT2yGA2RUJX95d38knwBYHi9S56V8SGhBrFTzW3HMrhSmSofQHz
 IT4bW4vMfyUcqPBYfk0s2A3guNPH+LNpJRjIl4zKTnncnMSqGvAmGqTh8S+U9WJDLBcyMtPmYUA
 hllHaceyZQf3N+ldQNv12y+KxslZpxRHBaQFMgUn857P0rI8eF5IoX08NCaNi8M14o6ixD0nAdB
 pu4oKvFQ
X-Authority-Analysis: v=2.4 cv=LNVmQIW9 c=1 sm=1 tr=0 ts=6892f673 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=eQTT6voJP-nWTqyz9zoA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_01,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060009



On 8/5/2025 6:55 PM, Mike Leach wrote:
> Hi
> 
> On Fri, 25 Jul 2025 at 11:08, Jie Gan <jie.gan@oss.qualcomm.com> wrote:
>>
>> Introduce tmc_read_ops as a wrapper, wrap read operations, for reading
>> trace data from the TMC buffer.
>>
>> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
>> ---
>>   .../hwtracing/coresight/coresight-tmc-core.c  | 50 +++++++++----------
>>   drivers/hwtracing/coresight/coresight-tmc.h   | 17 +++++++
>>   2 files changed, 40 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> index 4d249af93097..f668047c5df4 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> @@ -232,17 +232,10 @@ static int tmc_read_prepare(struct tmc_drvdata *drvdata)
>>   {
>>          int ret = 0;
>>
>> -       switch (drvdata->config_type) {
>> -       case TMC_CONFIG_TYPE_ETB:
>> -       case TMC_CONFIG_TYPE_ETF:
>> -               ret = tmc_read_prepare_etb(drvdata);
>> -               break;
>> -       case TMC_CONFIG_TYPE_ETR:
>> -               ret = tmc_read_prepare_etr(drvdata);
>> -               break;
>> -       default:
>> +       if (drvdata->read_ops)
>> +               ret = drvdata->read_ops->read_prepare(drvdata);
>> +       else
>>                  ret = -EINVAL;
>> -       }
>>
>>          if (!ret)
>>                  dev_dbg(&drvdata->csdev->dev, "TMC read start\n");
>> @@ -254,17 +247,10 @@ static int tmc_read_unprepare(struct tmc_drvdata *drvdata)
>>   {
>>          int ret = 0;
>>
>> -       switch (drvdata->config_type) {
>> -       case TMC_CONFIG_TYPE_ETB:
>> -       case TMC_CONFIG_TYPE_ETF:
>> -               ret = tmc_read_unprepare_etb(drvdata);
>> -               break;
>> -       case TMC_CONFIG_TYPE_ETR:
>> -               ret = tmc_read_unprepare_etr(drvdata);
>> -               break;
>> -       default:
>> +       if (drvdata->read_ops)
>> +               ret = drvdata->read_ops->read_unprepare(drvdata);
>> +       else
>>                  ret = -EINVAL;
>> -       }
>>
>>          if (!ret)
>>                  dev_dbg(&drvdata->csdev->dev, "TMC read end\n");
>> @@ -291,13 +277,8 @@ static int tmc_open(struct inode *inode, struct file *file)
>>   static ssize_t tmc_get_sysfs_trace(struct tmc_drvdata *drvdata, loff_t pos, size_t len,
>>                                     char **bufpp)
>>   {
>> -       switch (drvdata->config_type) {
>> -       case TMC_CONFIG_TYPE_ETB:
>> -       case TMC_CONFIG_TYPE_ETF:
>> -               return tmc_etb_get_sysfs_trace(drvdata, pos, len, bufpp);
>> -       case TMC_CONFIG_TYPE_ETR:
>> -               return tmc_etr_get_sysfs_trace(drvdata, pos, len, bufpp);
>> -       }
>> +       if (drvdata->read_ops)
>> +               return drvdata->read_ops->get_trace_data(drvdata, pos, len, bufpp);
>>
>>          return -EINVAL;
>>   }
>> @@ -769,6 +750,18 @@ static void register_crash_dev_interface(struct tmc_drvdata *drvdata,
>>                          "Valid crash tracedata found\n");
>>   }
>>
>> +static const struct tmc_read_ops tmc_etb_read_ops = {
>> +       .read_prepare   = tmc_read_prepare_etb,
>> +       .read_unprepare = tmc_read_unprepare_etb,
>> +       .get_trace_data = tmc_etb_get_sysfs_trace,
>> +};
>> +
>> +static const struct tmc_read_ops tmc_etr_read_ops = {
>> +       .read_prepare   = tmc_read_prepare_etr,
>> +       .read_unprepare = tmc_read_unprepare_etr,
>> +       .get_trace_data = tmc_etr_get_sysfs_trace,
>> +};
>> +
>>   static int __tmc_probe(struct device *dev, struct resource *res)
>>   {
>>          int ret = 0;
>> @@ -818,6 +811,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
>>                  desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
>>                  desc.ops = &tmc_etb_cs_ops;
>>                  dev_list = &etb_devs;
>> +               drvdata->read_ops = &tmc_etb_read_ops;
>>                  break;
>>          case TMC_CONFIG_TYPE_ETR:
>>                  desc.groups = coresight_etr_groups;
>> @@ -831,6 +825,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
>>                  mutex_init(&drvdata->idr_mutex);
>>                  dev_list = &etr_devs;
>>                  INIT_LIST_HEAD(&drvdata->etr_buf_list);
>> +               drvdata->read_ops = &tmc_etr_read_ops;
>>                  break;
>>          case TMC_CONFIG_TYPE_ETF:
>>                  desc.groups = coresight_etf_groups;
>> @@ -839,6 +834,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
>>                  desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_FIFO;
>>                  desc.ops = &tmc_etf_cs_ops;
>>                  dev_list = &etf_devs;
>> +               drvdata->read_ops = &tmc_etb_read_ops;
>>                  break;
>>          default:
>>                  pr_err("%s: Unsupported TMC config\n", desc.name);
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
>> index 3cb8ba9f88f5..2ad8e288c94b 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc.h
>> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
>> @@ -223,6 +223,8 @@ struct etr_buf_node {
>>          struct list_head        node;
>>   };
>>
>> +struct tmc_read_ops;
>> +
> 
> declare the entire structure here rather than later.

There is an issue of declare the entire structure here because the 
function pointer needs use the struct tmc_drvdata which is not defined 
at this point and it will cause a compile error.

Thanks,
Jie

> 
>>   /**
>>    * struct tmc_drvdata - specifics associated to an TMC component
>>    * @pclk:      APB clock if present, otherwise NULL
>> @@ -259,6 +261,7 @@ struct etr_buf_node {
>>    *              Used by ETR/ETF.
>>    * @etr_buf_list: List that is used to manage allocated etr_buf.
>>    * @reading_node: Available buffer for byte-cntr reading.
>> + * @tmc_read_ops: Read operations for TMC device.
>>    */
>>   struct tmc_drvdata {
>>          struct clk              *pclk;
>> @@ -290,6 +293,20 @@ struct tmc_drvdata {
>>          struct tmc_resrv_buf    crash_mdata;
>>          struct list_head        etr_buf_list;
>>          struct etr_buf_node     *reading_node;
>> +       const struct tmc_read_ops       *read_ops;
> 
> probably should be named sysfs_read_ops to be consistent with the
> perf/sysfs differentiation within the rest of the structure
> 
>> +};
>> +
>> +/**
>> + * struct tmc_read_ops - read operations for TMC and its helper devices
>> + * @read_prepare:      prepare operation.
>> + * @read_unprepare:    unprepare operation.
>> + * @get_trace_data:    read operation.
>> + */
>> +struct tmc_read_ops {
>> +       int (*read_prepare)(struct tmc_drvdata *drvdata);
>> +       int (*read_unprepare)(struct tmc_drvdata *drvdata);
>> +       ssize_t (*get_trace_data)(struct tmc_drvdata *drvdata, loff_t pos,
>> +                                 size_t len, char **bufpp);
>>   };
>>
>>   struct etr_buf_operations {
>> --
>> 2.34.1
>>
> 
> with the above changes:-
> 
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> 


