Return-Path: <linux-kernel+bounces-775059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F61B2BAD0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1041BC148C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7792848A2;
	Tue, 19 Aug 2025 07:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZSx45hiT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5D62848B9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588702; cv=none; b=m9PZFKE5/ZdoD0pcaNGpAnKbz2YBf+7RIVRSP1SGOKV/PCqv2vujBAzSxynp+qDT1PD3xZE2erICUZPxao1J+eipBPvgDqAYZDLDtRacsFdqNwYELT506Uq4ihe4oIFxujjlOHpq5ogSAMykldLfagRIFK3++icSKVLZjQuT+/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588702; c=relaxed/simple;
	bh=pzUSDZlkNaxG71LP8uKMzRzJb6tgeaCZfWSzTDyI3Bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ypx01oNZHkAVjpiuuWNs61A0DdIRII65zClu0LVt+pAAKWulqCQwK8CW1lkvRX7UN7CeOC2URVDMb5zFvtCNtt/ARnHMhY2N1yG75dpzSLRczERkD4Wbzb74mw8k64bsiBOkJ93AKMUcJlOGnOyUaYDHosOsMUByr3nVpsbH5YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZSx45hiT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J2ddno015694
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E/5t8BuizRagaIaJmirkWNDHgWBpxUxE/MXsx3vZo/w=; b=ZSx45hiTEp53shwW
	4GGT8kbPMkKdH/UzM1W49QYD3xFH9q1Vze3BxZ4druZ/S5TI9w8+Pyp0mfLRBK9Z
	bLRIGcThdtgjmlrk78fh3G3gmaYlevXPj+NZ3TjseiNzyZRxyjNMCXbmAezpzOT4
	nyHgcgGPaVoclYYwRz+jtXTKlkB34j+6ZzLbHOh7/QpO4lwB/03RGBGn0SedzcOT
	Wjr/L+E92CI2T9zfAVh+CqRBxEdQPJYg3YF/PF7BpKr+CJpV1WJH4ilhbINK7uK8
	++EoZ98pCgjZiFuZWQCsRBHC7lVUYUaagG/N0HE4efYh49gWinCMJ2X2EaOF8jly
	LUq6SA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhagyk8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:31:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24457f440f0so55277125ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755588698; x=1756193498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/5t8BuizRagaIaJmirkWNDHgWBpxUxE/MXsx3vZo/w=;
        b=MGQFY4vUSPvzuq2WguQ2q322CTaMxkkg7PC+g5K3vS+NlxJ4nbP21d+zwvHXZRgMsf
         nn0buAG6BHLz4D6eF/CJeTYPv2q5iS+sTOfX6Z8g1oEO6t+6DskVWhMnmIBxApP3A08F
         fDT0Vs/0XcL7unnFNuRfuRa+iexYBC9h26cc98Enrv6jXiQSBAgfl0asxeIx7ktsOWuw
         GyMW7OdZkKcDOPLvRaq+pY9KxePAEZOhhpwZRZsJvQi+rZYWofPr7UMAnpISgGWPcYGy
         zY3VEDBKAtzcwOMydwmotUUiPPTIw1FReFBPVV2yJgeWsRPxxh6RHGoXIrxrgjOO0/Mf
         IYiA==
X-Forwarded-Encrypted: i=1; AJvYcCUVPr3hzjwg9rHa3+SDHjmkgwpFqUAOcOs+o0lCrPMnz0X4b7r5EAHvqCIM+GMJcHVezBDPY0srYmCHN1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy93AVA7BPqpoqtrNFR4J0zmEE44uq0iUYAbF9ZuLQ1IvnJIgRc
	UVOxoZFuOTTahrNbSTW6aOXVCaiVWnUZ3J5TCzukPlawWh54PkVlMGWyH6IBK7I+3bmwzJRvZkP
	yc6M67XLVCSFeGDQ0TmCqQYwAVWPCGMZVRWDLixEteHH7yRcNVF/EX6aSauoNe21cL2w=
X-Gm-Gg: ASbGncsHY8a736d94K3tI7LxkkoT7ZEdR46m0vgKTRySmbW5r74sDonUcm9IZ/l1kWD
	RkHzHjGt/twgUer/kiWh/Uu5pAyFBJ5HxJAjT1+gGg21Bi8APeSl/F8HOsGNiQnC0X8tcc5E+wy
	lCA397PXD/+HHf6eLt+L5m8ytFqgABlJ2XJee/xoiy79YbxxE76EfrbvdKR0KC0Wc0Okc6QEJRX
	1DiQByjE6vHGAHG2F2ogaEmlQfqUuzAoU2YfjlrdwzRT7yTu0GyAi3YJrq3JuAfByYEaqBHCDj0
	uLF+Yf/mqcFLpYdWmA7dNufO/B3gzkJu8prwCcrV8bzaQ8w3Tjg3KOWl0rT2eA4VGzZhsSee8h9
	TvwkSknydD/TIK9MLLhBXUub1LCtin2le
X-Received: by 2002:a17:902:f542:b0:23f:d47a:c9d3 with SMTP id d9443c01a7336-245e02e6404mr21339905ad.15.1755588698011;
        Tue, 19 Aug 2025 00:31:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUC59usn5BICBgrQVO6S4T7O4TqzqEE4hnv1ocermgR8WZzZPykg1VxbPyswM9WQXAHiLH9Q==
X-Received: by 2002:a17:902:f542:b0:23f:d47a:c9d3 with SMTP id d9443c01a7336-245e02e6404mr21339015ad.15.1755588696978;
        Tue, 19 Aug 2025 00:31:36 -0700 (PDT)
Received: from [10.133.33.73] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d510774sm100620245ad.88.2025.08.19.00.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 00:31:36 -0700 (PDT)
Message-ID: <51f2c3fa-ea6c-42a7-95eb-7737e75ef6db@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 15:31:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] coresight-tnoc: add platform driver to support
 Interconnect TNOC
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250815-itnoc-v1-0-62c8e4f7ad32@oss.qualcomm.com>
 <20250815-itnoc-v1-2-62c8e4f7ad32@oss.qualcomm.com>
 <20250818142759.GA8071@e132581.arm.com>
Content-Language: en-US
From: yuanfang zhang <yuanfang.zhang@oss.qualcomm.com>
In-Reply-To: <20250818142759.GA8071@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=D9xHKuRj c=1 sm=1 tr=0 ts=68a4285b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=3YXEkSkIQhp2_XkERTwA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: _bU_qIvhXW5_exFR0k1zRq-sISf5Dgq9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNCBTYWx0ZWRfX8qydUiQq0RWp
 CVybAamv4w8Nj4AbFpkNswr2JKRAV8iqOwKkUjlx9Nq5AoN9Ov8jj/5ozWG4EkMpAHBTZ7Wtoc9
 9qb1zettWooBSUlt2/7SeoCXC+xiis8E8pLRaUE4aLeoNeVcTU4SN6HzkMWsNCYzju3rXGwBtT7
 8qf/k+9/gX/2NC082x2y3q7u9QpOVmoB7s2F4urLJnqp7WPNcCbAPFcrBfOTSQWeCXm7BBxod+o
 +ARb7DLKz2aZE2apxrlcO9l0n26UBmRN70v5Ydf5eNArIUK3fz4qB6RawsU6zVNPsESCYSrAzHq
 5scW6pPM2L2ERX15Poif6q+2HbEB4oNdSnEqpa7dQAlPN88BVDH/1zNRf0XbkJB0UjJiP2pixKZ
 ZA9rQsgP
X-Proofpoint-GUID: _bU_qIvhXW5_exFR0k1zRq-sISf5Dgq9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160024



On 8/18/2025 10:27 PM, Leo Yan wrote:
> On Fri, Aug 15, 2025 at 06:18:13AM -0700, Yuanfang Zhang wrote:
>> This patch adds platform driver support for the CoreSight Interconnect
>> TNOC, Interconnect TNOC is a CoreSight link that forwards trace data
>> from a subsystem to the Aggregator TNOC. Compared to Aggregator TNOC,
>> it does not have aggregation and ATID functionality.
> 
> Such kind of driver is not complex, it would be fine to had sent driver
> in one go for support both AMBA and platform devices.
> 
>> Key changes:
>> - Add platform driver `coresight-itnoc` with device tree match support.
>> - Refactor probe logic into a common `_tnoc_probe()` function.
>> - Conditionally initialize ATID only for AMBA-based TNOC blocks.
> 
> An AMBA or platform device is only about device probing; it is not
> necessarily bound to a device feature.
> 
> So I am suspicious of the conclusion that an AMBA-based TNOC always
> supports ATID, while a platform device never supports it.
> 
> Otherwise, you might need to consider using a DT property to indicate
> whether ATID is present or not.
> 

Unlike the AMBA-based design, ITNOC not only lacks ATID support but also does not
include PID registers. This is why a separate platform driver is required to support it.

>> Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
>> ---
>>  drivers/hwtracing/coresight/coresight-tnoc.c | 153 +++++++++++++++++++--------
>>  1 file changed, 106 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tnoc.c b/drivers/hwtracing/coresight/coresight-tnoc.c
>> index d542df46ea39314605290311f683010337bfd4bd..aa6f48d838c00d71eff22c18e34e00b93755fd82 100644
>> --- a/drivers/hwtracing/coresight/coresight-tnoc.c
>> +++ b/drivers/hwtracing/coresight/coresight-tnoc.c
>> @@ -34,6 +34,7 @@
>>   * @base:      memory mapped base address for this component.
>>   * @dev:       device node for trace_noc_drvdata.
>>   * @csdev:     component vitals needed by the framework.
>> + * @pclk:	APB clock if present, otherwise NULL
>>   * @spinlock:  serialize enable/disable operation.
>>   * @atid:      id for the trace packet.
>>   */
>> @@ -41,6 +42,7 @@ struct trace_noc_drvdata {
>>  	void __iomem		*base;
>>  	struct device		*dev;
>>  	struct coresight_device	*csdev;
>> +	struct clk		*pclk;
>>  	spinlock_t		spinlock;
>>  	u32			atid;
>>  };
>> @@ -51,25 +53,27 @@ static void trace_noc_enable_hw(struct trace_noc_drvdata *drvdata)
>>  {
>>  	u32 val;
>>  
>> -	/* Set ATID */
>> -	writel_relaxed(drvdata->atid, drvdata->base + TRACE_NOC_XLD);
>> -
>> -	/* Set the data word count between 'SYNC' packets */
>> -	writel_relaxed(TRACE_NOC_SYNC_INTERVAL, drvdata->base + TRACE_NOC_SYNCR);
>> -
>> -	/* Set the Control register:
>> -	 * - Set the FLAG packets to 'FLAG' packets
>> -	 * - Set the FREQ packets to 'FREQ_TS' packets
>> -	 * - Enable generation of output ATB traffic
>> -	 */
>> -
>> -	val = readl_relaxed(drvdata->base + TRACE_NOC_CTRL);
>> -
>> -	val &= ~TRACE_NOC_CTRL_FLAGTYPE;
>> -	val |= TRACE_NOC_CTRL_FREQTYPE;
>> -	val |= TRACE_NOC_CTRL_PORTEN;
>> -
>> -	writel(val, drvdata->base + TRACE_NOC_CTRL);
>> +	if (drvdata->atid) {
>> +		/* Set ATID */
>> +		writel_relaxed(drvdata->atid, drvdata->base + TRACE_NOC_XLD);
>> +
>> +		/* Set the data word count between 'SYNC' packets */
>> +		writel_relaxed(TRACE_NOC_SYNC_INTERVAL, drvdata->base + TRACE_NOC_SYNCR);
>> +		/* Set the Control register:
>> +		 * - Set the FLAG packets to 'FLAG' packets
>> +		 * - Set the FREQ packets to 'FREQ_TS' packets
>> +		 * - Enable generation of output ATB traffic
>> +		 */
>> +
>> +		val = readl_relaxed(drvdata->base + TRACE_NOC_CTRL);
>> +
>> +		val &= ~TRACE_NOC_CTRL_FLAGTYPE;
>> +		val |= TRACE_NOC_CTRL_FREQTYPE;
>> +		val |= TRACE_NOC_CTRL_PORTEN;
>> +		writel(val, drvdata->base + TRACE_NOC_CTRL);
>> +	} else {
>> +		writel(0x1, drvdata->base + TRACE_NOC_CTRL);
>> +	}
> 
> Change "atid" type from u32 to int, then you could set it as
> "-EOPNOTSUPP" for non-AMBA device. Here:
> 
>     /* No valid ATID, simply enable the unit */
>     if (drvdata->atid == -EOPNOTSUPP) {
>         writel(TRACE_NOC_CTRL_PORTEN, drvdata->base + TRACE_NOC_CTRL);
>         return;
>     }

sure, will update.
> 
>>  }
>>  
>>  static int trace_noc_enable(struct coresight_device *csdev, struct coresight_connection *inport,
>> @@ -120,19 +124,6 @@ static const struct coresight_ops trace_noc_cs_ops = {
>>  	.link_ops	= &trace_noc_link_ops,
>>  };
>>  
>> -static int trace_noc_init_default_data(struct trace_noc_drvdata *drvdata)
>> -{
>> -	int atid;
>> -
> 
> Don't need to remove this function. Just check AMBA device case:
> 
>     /* ATID is not supported for interconnect TNOC */
>     if (!dev_is_amba(drvdata->dev)) {
>         drvdata->atid = -EOPNOTSUPP;
>         return 0;
>     }
> 
sure, will update.
>> -	atid = coresight_trace_id_get_system_id();
>> -	if (atid < 0)
>> -		return atid;
>> -
>> -	drvdata->atid = atid;
>> -
>> -	return 0;
>> -}
>> -
>>  static ssize_t traceid_show(struct device *dev,
>>  			    struct device_attribute *attr, char *buf)
>>  {
>> @@ -158,13 +149,12 @@ static const struct attribute_group *coresight_tnoc_groups[] = {
>>  	NULL,
>>  };
>>  
>> -static int trace_noc_probe(struct amba_device *adev, const struct amba_id *id)
>> +static int _tnoc_probe(struct device *dev, struct resource *res, bool has_id)
> 
> As a result, no need the parameter "has_id".
> 
sure, will update.
>>  {
>> -	struct device *dev = &adev->dev;
>>  	struct coresight_platform_data *pdata;
>>  	struct trace_noc_drvdata *drvdata;
>>  	struct coresight_desc desc = { 0 };
>> -	int ret;
>> +	int ret, atid = 0;
>>  
>>  	desc.name = coresight_alloc_device_name(&trace_noc_devs, dev);
>>  	if (!desc.name)
>> @@ -173,42 +163,61 @@ static int trace_noc_probe(struct amba_device *adev, const struct amba_id *id)
>>  	pdata = coresight_get_platform_data(dev);
>>  	if (IS_ERR(pdata))
>>  		return PTR_ERR(pdata);
>> -	adev->dev.platform_data = pdata;
>> +	dev->platform_data = pdata;
>>  
>>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>>  	if (!drvdata)
>>  		return -ENOMEM;
>>  
>> -	drvdata->dev = &adev->dev;
>> +	drvdata->dev = dev;
>>  	dev_set_drvdata(dev, drvdata);
>>  
>> -	drvdata->base = devm_ioremap_resource(dev, &adev->res);
>> +	ret = coresight_get_enable_clocks(dev, &drvdata->pclk, NULL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	drvdata->base = devm_ioremap_resource(dev, res);
>>  	if (IS_ERR(drvdata->base))
>>  		return PTR_ERR(drvdata->base);
>>  
>>  	spin_lock_init(&drvdata->spinlock);
>>  
>> -	ret = trace_noc_init_default_data(drvdata);
>> -	if (ret)
>> -		return ret;
>> +	if (has_id) {
>> +		atid = coresight_trace_id_get_system_id();
>> +		if (atid < 0)
>> +			return atid;
>> +	}
>> +
>> +	drvdata->atid = atid;
> 
> Drop this change and simply keep the code for invoking
> trace_noc_init_default_data().
> 
sure, will update.
>>  	desc.ops = &trace_noc_cs_ops;
>>  	desc.type = CORESIGHT_DEV_TYPE_LINK;
>>  	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_MERG;
>> -	desc.pdata = adev->dev.platform_data;
>> -	desc.dev = &adev->dev;
>> +	desc.pdata = pdata;
>> +	desc.dev = dev;
>>  	desc.access = CSDEV_ACCESS_IOMEM(drvdata->base);
>> -	desc.groups = coresight_tnoc_groups;
>> +	if (has_id)
>> +		desc.groups = coresight_tnoc_groups;
> 
> No need to change for groups.
> 
> Just return "-EOPNOTSUPP" in traceid_show() if drvdata->atid is negative.
> Or, you could use the .is_visible() callback to decide if the "trace_id"
> node appears or not.
> 
sure, will updata.
>>  	drvdata->csdev = coresight_register(&desc);
>> -	if (IS_ERR(drvdata->csdev)) {
>> +	if (IS_ERR(drvdata->csdev) && has_id) {
>>  		coresight_trace_id_put_system_id(drvdata->atid);
>>  		return PTR_ERR(drvdata->csdev);
>>  	}
>> -	pm_runtime_put(&adev->dev);
>>  
>>  	return 0;
>>  }
>>  
>> +static int trace_noc_probe(struct amba_device *adev, const struct amba_id *id)
>> +{
>> +	int ret;
>> +
>> +	ret = _tnoc_probe(&adev->dev, &adev->res, true);
>> +	if (!ret)
>> +		pm_runtime_put(&adev->dev);
>> +
>> +	return ret;
>> +}
>> +
>>  static void trace_noc_remove(struct amba_device *adev)
>>  {
>>  	struct trace_noc_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>> @@ -236,7 +245,57 @@ static struct amba_driver trace_noc_driver = {
>>  	.id_table	= trace_noc_ids,
>>  };
>>  
>> -module_amba_driver(trace_noc_driver);
>> +static int itnoc_probe(struct platform_device *pdev)
>> +{
>> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	int ret;
>> +
>> +	pm_runtime_get_noresume(&pdev->dev);
>> +	pm_runtime_set_active(&pdev->dev);
>> +	pm_runtime_enable(&pdev->dev);
>> +
>> +	ret = _tnoc_probe(&pdev->dev, res, false);
>> +	pm_runtime_put(&pdev->dev);
>> +	if (ret)
>> +		pm_runtime_disable(&pdev->dev);
>> +
>> +	return ret;
>> +}
>> +
>> +static void itnoc_remove(struct platform_device *pdev)
>> +{
>> +	struct trace_noc_drvdata *drvdata = platform_get_drvdata(pdev);
>> +
>> +	coresight_unregister(drvdata->csdev);
>> +	pm_runtime_disable(&pdev->dev);
>> +}
>> +
>> +static const struct of_device_id itnoc_of_match[] = {
>> +	{ .compatible = "qcom,coresight-itnoc" },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, itnoc_of_match);
>> +
>> +static struct platform_driver itnoc_driver = {
>> +	.probe = itnoc_probe,
>> +	.remove = itnoc_remove,
>> +	.driver = {
>> +		.name = "coresight-itnoc",
>> +		.of_match_table = itnoc_of_match,
> 
> You might need to set:
> 
>     .suppress_bind_attrs = true,
> 
sure, will update.
> Thanks,
> Leo
> 
>> +	},
>> +};
>> +
>> +static int __init tnoc_init(void)
>> +{
>> +	return coresight_init_driver("tnoc", &trace_noc_driver, &itnoc_driver, THIS_MODULE);
>> +}
>> +
>> +static void __exit tnoc_exit(void)
>> +{
>> +	coresight_remove_driver(&trace_noc_driver, &itnoc_driver);
>> +}
>> +module_init(tnoc_init);
>> +module_exit(tnoc_exit);
>>  
>>  MODULE_LICENSE("GPL");
>>  MODULE_DESCRIPTION("Trace NOC driver");
>>
>> -- 
>> 2.34.1
>>
>> _______________________________________________
>> CoreSight mailing list -- coresight@lists.linaro.org
>> To unsubscribe send an email to coresight-leave@lists.linaro.org


