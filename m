Return-Path: <linux-kernel+bounces-873278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D303C13924
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F5F64E15AA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99C72D739D;
	Tue, 28 Oct 2025 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NHe8njQD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD011277CA4
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761640725; cv=none; b=ZZEg/sEuw0xQDvElpwnJ6XYYHM/UxuTiU2U5vrcAbVGFrkoekxm7sK9lRc7TOqyk4uu6infE2tUbnlj8oNOvHyPsIO6SZRFPZokQbKYOBxwTiS5QAECXHiHf/80cYNvbLIx5mlM6MG3ZY2+T8OjgleZflGi6aAvZr+mJLA+VwBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761640725; c=relaxed/simple;
	bh=CK9O/h9PmMpJaumHuyABmF+wXmXCinpZaff05WA3CIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbCEHprxY0GvtWVIvo97ZUlnJZ5AHVJYmAp39DW3t05nrv5T7ZxA/tSgg45lHnBRBUuOyEJoWYPN25LaIAcENJuI+iGyfZsCPe1Ul3wC1Lwa4YV96fLoZiKsv/3J8YdBhdPFgw0y2Qus9M2rAqn95bgRUrvvoqCPKCHcOILyZTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NHe8njQD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S7dYu61032996
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jr8+i4dieCUMhOFBhZ6AFD4YLUnBtGBf1ti60Ls8B38=; b=NHe8njQDuF3hHAed
	RaAr3nr7k8QfMiwgScJgWkZgbK4Ieo/ZokOyyPGNDJT7zYf2tkDeuNxS9YLtdn0k
	SuBJNMiVT5V2Lv1y02qS82O7UUMePtR7Z+9FNldPu/33BhkAmMZTc50YXv59eq5H
	2QTH/Ho+10u9OgmPWP7HaU0NbURv9uC9zCn1l7qSJ4tixUM6RiQ8P6pc8+uHH7h3
	wYTWEKCELDy+hzZmJ5X73+86hfQJnnBU5sbaSPvKsZqmXGtX8MKbCgMS/oheU+A5
	XltOBSl2rZDsJxiMEK4XcJN6u2ti7YSuYyunpvo/JoLd8uViCsN9i8SEgfUzS3u/
	YyoAZg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2smur623-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:38:42 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-290c2d13a01so42294435ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 01:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761640721; x=1762245521;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jr8+i4dieCUMhOFBhZ6AFD4YLUnBtGBf1ti60Ls8B38=;
        b=birORKkqoCSr71M8v6mC1odC6tzMP7ID2c4onXwXt+pIzDxp5ARQhyGJXZJ4DZsTUc
         Zy7SaDWdOrPFwPeX6pOHyIahAmaebFXsXl0WpO1WKBB02FmvC21OqgzWd2X3LklPcW7f
         jdrsX+HoFs94xA9/LvgshkZsdc89HI4FOaZzIhIdwyJDE18Lp+JpC2Vl2AzANZtoe6qV
         IVpTh+FLb7uQVGNBWqxw4tyjXFlYN7ikwySA0mnzyWJkQfh/tgkCpwtzB40zZZ9qMZvC
         lNtYAjzN8T8iniChdHWbfrxSQlBSxkNqJJ0x3PIjcvN0Xsg8TQnvYJEQ+XmNBlpXubzq
         gUVw==
X-Forwarded-Encrypted: i=1; AJvYcCUi97KMkWJqs6w6Xpu6AAiIGWq1PEAO7rmpS7ZaySOsMYskYH+S6ape32/JVJOUqWvq5O9YI8fv8gMU5go=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg2jtKP29fpeRSZjAqbwKh2Rga/owGy8UiIossLb8lGDZZuFns
	4wrOSARvTSLfzJ3pNWkEuEVdIRZkLa1zo3Ceh2EFnZFHfFOuwDvv1TolccpIEg+alfjnaY5ikV7
	YVULvqo1q10QJ2iL0L4/GGk21+bQuQkcF0owZzoVtFmXK1CKLuKgpjvU8FrJgRJI2K8Y=
X-Gm-Gg: ASbGncuhsQuI44ODVXY2+6r1GP072YWRPEU+W2sEiCiwj+FLcSMA47JEEZ4M7z8EYXY
	j8kQFW8vMYjgR/J0k24/i6MzFltTP1C4uOWAfylpJN7cmSCdcJ3uNDfnj8euQo++Pa77YprlJ0P
	EkdVAdrWl1pOjVao3Nrbk4abDrbAAETvCaOe2o+GcdPfhnBKzdVt1UfO7tHXD2BsDZIjrTzO32+
	jeKEgoQObC0VnQ4s4cHW+/Vk+a220Yuix+v37jqAF16KycNeVPuM3K+GvOMzK6uKGR8ls61K0GO
	ooL4dFnPPDoQYSlaa+4aCwgkysgORUKFc+ABSh8WY5KwQHYnZpFcIT1QxYVZBHgcgJkgWEnantU
	KvduWI5HXx8DFJ9lO9KwPnuL25OHG9a69CqrGe3uSc//22W3Lf81i
X-Received: by 2002:a17:903:1a67:b0:294:9132:75d2 with SMTP id d9443c01a7336-294cc76659cmr25411375ad.25.1761640721261;
        Tue, 28 Oct 2025 01:38:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsiUHXuoFI2lMXRyC2KpD8nA8h3YvJAfAf8TZJLyassjBfe7izxKv57V5xxmVd3TZ5NRK17A==
X-Received: by 2002:a17:903:1a67:b0:294:9132:75d2 with SMTP id d9443c01a7336-294cc76659cmr25411075ad.25.1761640720407;
        Tue, 28 Oct 2025 01:38:40 -0700 (PDT)
Received: from [10.133.33.253] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0996esm107206015ad.28.2025.10.28.01.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 01:38:39 -0700 (PDT)
Message-ID: <6dcf793f-6f1c-4900-82e9-a6b53d45cdf9@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 16:38:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] coresight: tpdm: add static tpdm support
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Tao Zhang <tao.zhang@oss.qualcomm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251013-add-static-tpdm-support-v3-0-a720b73e83db@oss.qualcomm.com>
 <20251013-add-static-tpdm-support-v3-2-a720b73e83db@oss.qualcomm.com>
 <7386e009-2d53-4a0b-8c83-a84f51b4b79a@arm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <7386e009-2d53-4a0b-8c83-a84f51b4b79a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nRAixm2Kaj9Oujnk8twBQ-zd8SE7O3uw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA3MiBTYWx0ZWRfX7Dpku7WQwT1Q
 G/dKfrIBPY/e0r/8hRNl97aAboTrLwm5jOml+AHbiPexo8LF7sB1IR+Eqd6KMU4cnBPRHCtQz6Q
 N7LOvn+CEpG6UIpFEe73hvSbr0Gz4rJYp+iH1bmiGdGlLJcB2nf/aOYEnbAml0oS7JuIrvLr9Bf
 FlrUO5nazkPoes3E27WtVOSIJRlIaXvw8FdSW4MtuEvzXR/qQjoh+7flWDI1NaG2qYvxpURIg5G
 vT/1aRQ7cwzk4ue+Zmp8budkMx0JE96jGOWJ1W+XjJr+mMdArdlAVdpkXPAfAfc/WFR2yLNWO7F
 c7XO96MsOtoYDodEFD2DLhx9/3E1uRwZ2kWFoT/2zgQPf7j5W13qbnureZHChN6HRSphh4AZRF2
 la71afMOy28Uqy6TZ7ucrgWT1+wLHw==
X-Authority-Analysis: v=2.4 cv=IcCKmGqa c=1 sm=1 tr=0 ts=69008112 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=bEI7897pd3NgvWUkXe8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: nRAixm2Kaj9Oujnk8twBQ-zd8SE7O3uw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280072



On 10/27/2025 5:17 PM, Suzuki K Poulose wrote:
> On 13/10/2025 07:11, Jie Gan wrote:
>> The static TPDM function as a dummy source, however, it is essential
>> to enable the port connected to the TPDA and configure the element size.
>> Without this, the TPDA cannot correctly receive trace data from the
>> static TPDM. Since the static TPDM does not require MMIO mapping to
>> access its registers, a clock controller is not mandatory for its
>> operation.
>>
>> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpda.c |   9 ++
>>   drivers/hwtracing/coresight/coresight-tpdm.c | 148 +++++++++++++++++ 
>> ++++------
>>   drivers/hwtracing/coresight/coresight-tpdm.h |   8 ++
>>   3 files changed, 131 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/ 
>> hwtracing/coresight/coresight-tpda.c
>> index 333b3cb23685..4e93fa5bace4 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>> @@ -68,6 +68,15 @@ static int tpdm_read_element_size(struct 
>> tpda_drvdata *drvdata,
>>       int rc = -EINVAL;
>>       struct tpdm_drvdata *tpdm_data = dev_get_drvdata(csdev- 
>> >dev.parent);
>> +    if (coresight_is_static_tpdm(csdev)) {
>> +        rc = fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
>> +                          "qcom,dsb-element-bits", &drvdata->dsb_esize);
>> +        rc &= fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
>> +                           "qcom,cmb-element-bits", &drvdata- 
>> >cmb_esize);
>> +
> 
> This doesn't match the "dynamic" tpdm case ? We mandate that static
> TPDMs have DSB and CMB. I would rather set the appropriate flags in
> 
> tpdm_drvdata->dsb/cmb in the TPDM driver for static tpdms and not
> let the "static" vs "dynamic" creep into the TPDA and other users.
> 
> e.g., in TPDM driver:
> 
> if (static_tpdm()) {
>    tpdm_data->dsb = has_dsb_element_bits_property;
>    tpdm_data->cmb = has_cmb_element_bits_property;
> }

Well noted, will fix in next version.

> 
> 
>> +        goto out;
>> +    }
>> +
>>       if (tpdm_data->dsb) {
>>           rc = fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
>>                   "qcom,dsb-element-bits", &drvdata->dsb_esize);
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/ 
>> hwtracing/coresight/coresight-tpdm.c
>> index 7214e65097ec..1766b0182819 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -495,7 +495,9 @@ static int tpdm_enable(struct coresight_device 
>> *csdev, struct perf_event *event,
>>           return -EBUSY;
>>       }
>> -    __tpdm_enable(drvdata);
>> +    if (!coresight_is_static_tpdm(csdev))
>> +        __tpdm_enable(drvdata);
>> +
>>       drvdata->enable = true;
>>       spin_unlock(&drvdata->spinlock);
>> @@ -551,7 +553,9 @@ static void tpdm_disable(struct coresight_device 
>> *csdev,
>>           return;
>>       }
>> -    __tpdm_disable(drvdata);
>> +    if (!coresight_is_static_tpdm(csdev))
>> +        __tpdm_disable(drvdata);
> 
> minor nit: It is much safer to do this check in __tpdm_xxable() and
> return early.
> 

well noted, will fix it in next version.

>> +
>>       coresight_set_mode(csdev, CS_MODE_DISABLED);
>>       drvdata->enable = false;
>>       spin_unlock(&drvdata->spinlock);
>> @@ -1342,10 +1346,9 @@ static const struct attribute_group 
>> *tpdm_attr_grps[] = {
>>       NULL,
>>   };
>> -static int tpdm_probe(struct amba_device *adev, const struct amba_id 
>> *id)
>> +static int tpdm_probe(struct device *dev, struct resource *res)
>>   {
>>       void __iomem *base;
>> -    struct device *dev = &adev->dev;
>>       struct coresight_platform_data *pdata;
>>       struct tpdm_drvdata *drvdata;
>>       struct coresight_desc desc = { 0 };
>> @@ -1354,32 +1357,33 @@ static int tpdm_probe(struct amba_device 
>> *adev, const struct amba_id *id)
>>       pdata = coresight_get_platform_data(dev);
>>       if (IS_ERR(pdata))
>>           return PTR_ERR(pdata);
>> -    adev->dev.platform_data = pdata;
>> +    dev->platform_data = pdata;
>>       /* driver data*/
>>       drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>>       if (!drvdata)
>>           return -ENOMEM;
>> -    drvdata->dev = &adev->dev;
>> +    drvdata->dev = dev;
>>       dev_set_drvdata(dev, drvdata);
>> -    base = devm_ioremap_resource(dev, &adev->res);
>> -    if (IS_ERR(base))
>> -        return PTR_ERR(base);
>> +    if (res) {
>> +        base = devm_ioremap_resource(dev, res);
>> +        if (IS_ERR(base))
>> +            return PTR_ERR(base);
>> -    drvdata->base = base;
>> +        drvdata->base = base;
>> +        ret = tpdm_datasets_setup(drvdata);
>> +        if (ret)
>> +            return ret;
>> -    ret = tpdm_datasets_setup(drvdata);
>> -    if (ret)
>> -        return ret;
>> +        if (drvdata && tpdm_has_dsb_dataset(drvdata))
>> +            of_property_read_u32(drvdata->dev->of_node,
>> +                         "qcom,dsb-msrs-num", &drvdata->dsb_msr_num);
>> -    if (drvdata && tpdm_has_dsb_dataset(drvdata))
>> -        of_property_read_u32(drvdata->dev->of_node,
>> -               "qcom,dsb-msrs-num", &drvdata->dsb_msr_num);
>> -
>> -    if (drvdata && tpdm_has_cmb_dataset(drvdata))
>> -        of_property_read_u32(drvdata->dev->of_node,
>> -               "qcom,cmb-msrs-num", &drvdata->cmb_msr_num);
>> +        if (drvdata && tpdm_has_cmb_dataset(drvdata))
>> +            of_property_read_u32(drvdata->dev->of_node,
>> +                         "qcom,cmb-msrs-num", &drvdata->cmb_msr_num);
>> +    }
>>       /* Set up coresight component description */
>>       desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
>> @@ -1388,34 +1392,51 @@ static int tpdm_probe(struct amba_device 
>> *adev, const struct amba_id *id)
>>       desc.type = CORESIGHT_DEV_TYPE_SOURCE;
>>       desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM;
>>       desc.ops = &tpdm_cs_ops;
>> -    desc.pdata = adev->dev.platform_data;
>> -    desc.dev = &adev->dev;
>> +    desc.pdata = dev->platform_data;
>> +    desc.dev = dev;
>>       desc.access = CSDEV_ACCESS_IOMEM(base);
>> -    desc.groups = tpdm_attr_grps;
>> +    if (res)
>> +        desc.groups = tpdm_attr_grps;
>>       drvdata->csdev = coresight_register(&desc);
>>       if (IS_ERR(drvdata->csdev))
>>           return PTR_ERR(drvdata->csdev);
>>       spin_lock_init(&drvdata->spinlock);
>> -    /* Decrease pm refcount when probe is done.*/
>> -    pm_runtime_put(&adev->dev);
>> -
>>       return 0;
>>   }
>> -static void tpdm_remove(struct amba_device *adev)
>> +static int tpdm_remove(struct device *dev)
>>   {
>> -    struct tpdm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev);
>>       coresight_unregister(drvdata->csdev);
>> +
>> +    return 0;
>> +}
>> +
>> +static int dynamic_tpdm_probe(struct amba_device *adev,
>> +                  const struct amba_id *id)
>> +{
>> +    int ret;
>> +
>> +    ret = tpdm_probe(&adev->dev, &adev->res);
>> +    if (!ret)
>> +        pm_runtime_put(&adev->dev);
>> +
>> +    return ret;
>> +}
>> +
>> +static void dynamic_tpdm_remove(struct amba_device *adev)
>> +{
>> +    tpdm_remove(&adev->dev);
>>   }
>>   /*
>>    * Different TPDM has different periph id.
>>    * The difference is 0-7 bits' value. So ignore 0-7 bits.
>>    */
>> -static const struct amba_id tpdm_ids[] = {
>> +static const struct amba_id dynamic_tpdm_ids[] = {
>>       {
>>           .id    = 0x001f0e00,
>>           .mask    = 0x00ffff00,
>> @@ -1423,17 +1444,76 @@ static const struct amba_id tpdm_ids[] = {
>>       { 0, 0, NULL },
>>   };
>> -static struct amba_driver tpdm_driver = {
>> +MODULE_DEVICE_TABLE(amba, dynamic_tpdm_ids);
>> +
>> +static struct amba_driver dynamic_tpdm_driver = {
>>       .drv = {
>>           .name   = "coresight-tpdm",
>>           .suppress_bind_attrs = true,
>>       },
>> -    .probe          = tpdm_probe,
>> -    .id_table    = tpdm_ids,
>> -    .remove        = tpdm_remove,
>> +    .probe          = dynamic_tpdm_probe,
>> +    .id_table    = dynamic_tpdm_ids,
>> +    .remove        = dynamic_tpdm_remove,
>>   };
>> -module_amba_driver(tpdm_driver);
>> +static int tpdm_platform_probe(struct platform_device *pdev)
>> +{
>> +    struct resource *res = platform_get_resource(pdev, 
>> IORESOURCE_MEM, 0);
>> +    int ret;
>> +
>> +    pm_runtime_get_noresume(&pdev->dev);
>> +    pm_runtime_set_active(&pdev->dev);
>> +    pm_runtime_enable(&pdev->dev);
>> +
>> +    ret = tpdm_probe(&pdev->dev, res);
>> +    pm_runtime_put(&pdev->dev);
>> +    if (ret)
>> +        pm_runtime_disable(&pdev->dev);
>> +
>> +    return ret;
>> +}
>> +
>> +static void tpdm_platform_remove(struct platform_device *pdev)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
>> +
>> +    if (WARN_ON(!drvdata))
>> +        return;
>> +
>> +    tpdm_remove(&pdev->dev);
>> +    pm_runtime_disable(&pdev->dev);
>> +}
>> +
>> +static const struct of_device_id static_tpdm_match[] = {
>> +    {.compatible = "qcom,coresight-static-tpdm"},
>> +    {}
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, static_tpdm_match);
>> +
>> +static struct platform_driver static_tpdm_driver = {
>> +    .probe        = tpdm_platform_probe,
>> +    .remove        = tpdm_platform_remove,
>> +    .driver        = {
>> +        .name    = "coresight-static-tpdm",
>> +        .of_match_table = static_tpdm_match,
>> +        .suppress_bind_attrs = true,
>> +    },
>> +};
>> +
>> +static int __init tpdm_init(void)
>> +{
>> +    return coresight_init_driver("tpdm", &dynamic_tpdm_driver, 
>> &static_tpdm_driver,
>> +                     THIS_MODULE);
>> +}
>> +
>> +static void __exit tpdm_exit(void)
>> +{
>> +    coresight_remove_driver(&dynamic_tpdm_driver, &static_tpdm_driver);
>> +}
>> +
>> +module_init(tpdm_init);
>> +module_exit(tpdm_exit);
>>   MODULE_LICENSE("GPL");
>>   MODULE_DESCRIPTION("Trace, Profiling & Diagnostic Monitor driver");
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/ 
>> hwtracing/coresight/coresight-tpdm.h
>> index b11754389734..9f52c88ce5c1 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
>> @@ -343,4 +343,12 @@ struct tpdm_dataset_attribute {
>>       enum dataset_mem mem;
>>       u32 idx;
>>   };
>> +
>> +static inline bool coresight_is_static_tpdm(struct coresight_device 
>> *csdev)
>> +{
>> +    struct device_node *node = csdev->dev.parent->of_node;
>> +
>> +    return (csdev &&
>> +        of_device_is_compatible(node, "qcom,coresight-static-tpdm"));
> 
> Why do we have to go check the firmware table all the time ? Could we 
> not cache this in drvdata ? Or even better, we can use the csdev->access
> 
> by using :  coresight_device_is_tpdm()
> 
> return (coresight_device_is_tpdm(csdev) && !csdev->access->base);

That's much better than mine, will fix it in next version.

Thanks,
Jie

> 
> Suzuki


