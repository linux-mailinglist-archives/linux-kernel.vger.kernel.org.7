Return-Path: <linux-kernel+bounces-800333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDB5B43668
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 716C37B753C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3A32D238A;
	Thu,  4 Sep 2025 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p1QR0R6F"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8917124167F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976362; cv=none; b=EvWfuFWAwzNCLBzB5JaDl6oBj+sP28QS6d8JFufCsAZj/tSK7b08fm5z9NSeYUkIXyCSxAbDrNr3i5h0TLEsvBKFG5qFwkYqWOcJ/WjufAnfwXJhtcIIxeScaRenweappV7fvMVmSOAkmuCsoxKyckHCRNBlOw77XjQDVHeTnTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976362; c=relaxed/simple;
	bh=KD7ktfeuQPKUZSNiJGcYWicZkMGhAXrv+wnTlCPpiCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSWnQkO75s4VAdL2cLwiLzCW+WpXCUC/0Et3SgVsghrBY15c4u9tnuWz2cLXfDJdZp/qMeaa4mcTHezOzts6fEG8sqJOUTV3rDWHUsJrhoDzf2vb/P/lEUXPYqhX/QP3BfcDY40+0DSFmlXYkZqgarLNpZvL+ooX+EmvHW1f+E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p1QR0R6F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584113tJ008906
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 08:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S6SmD/lRJtpl+jt1dK1UZV6pTcf74vgfYRGz8fZ0E+A=; b=p1QR0R6FqrKgJvqz
	mH00+D1s/Cm6/E1qDhkfOnY7o/3dFYQBm73kQMw/Y6BVC5Sp7bcq+xo1jXmgz95x
	oCfcGPOS6YNJpAcUQIGIP4l9kmrARXRUQ1qOtUmrZAtc5WWBC5TyBgzpbPjJRipl
	+SyvQnZnaDP7Cv7SOYdTL2Ks/xPmhCSoSIMr/MJqJNpS4OPlV/0IV/mQcc6ViQXx
	8BPzYVGcRDsKwjHN7wwkbN5E2m0TCsT568h4u6RgnHoC7LMdaZeon48q395f2Oq+
	DOG/sbwFmDVQ9112RtUSfVaK3eiBSbfqeXbMb2wtP17qRNitoHvGLhQ8X6SbBldO
	1QbjkA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wyase9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 08:59:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24c9304b7bcso9646095ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 01:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756976358; x=1757581158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6SmD/lRJtpl+jt1dK1UZV6pTcf74vgfYRGz8fZ0E+A=;
        b=h+7l4KuLQd6kuu8BwAhPt5vpK2XbxJAXANsp6cy9QZ1V8TpK9g/oP8rBM1S1UvocCE
         MJ6v9ZPooMqLp5TCUAAWUK2YNSo8TbdQNYUFeaTUk/9AZgcW9unUlGEfsIN/JRAZ1vxY
         Cis9T+0iSnIw9FRPvxP/gu6u6jx6+62XsGD2Jy/HgF8/tA2Mp+P8IshHLCi51NLWUYGT
         dEX73wHOe5XWzB5jRDhcX9ywyNObkRjiHPwXA8YVEQRXDl8xd34jGVex45aIPDQFL3fw
         6foQVfP9A13W0li8ikUNryPeFHPiTaTyTmRc+K5GEV98gdS0NPSArFTBexoVwavPxymP
         mOuw==
X-Forwarded-Encrypted: i=1; AJvYcCWRDDvdZgjV1w0dBK+1sfUccvBTmpH3xeRQTEjcIDBLaMm1zsZ2XSh/Wpmh4d1OsE86v4LE1Bo8f53b8Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzneLCkYGCFN49oudwf7qvhLVVTH/i1/KCsymT5ST4SqdT5lMlT
	OcgtYhF7cxdmKPJt830OQG0m83MY6Sld/rnBbk+7THapKDYnboUuMMURY613vZFoSgPWXhYjSxY
	CDd6lE8gaVTCMSIjZ+meTS9ULAgzc2LzafWoH6SsYkkiHQBMCUHgekre+/m0VosAaAYsVAINuCh
	1Mtg==
X-Gm-Gg: ASbGncvxdO9xIWVPgh2TDlICBn245EGXqI23Ile146xBaTcToZduf207r2LiAu6CeZK
	SWNwJomFRJxlroGBv1EHD0shbWSsAtQUXrqnVfQYmtwjaVmnhccfP+ngGgYCWjBPXaJCjvolCJ/
	bnpuqdNK+mm1Gr4ycQMfRBGLkoKCxWXzENRruDx1HcgMu1w/l8M1Hn0xCn+JOa+kD3c6qv8iiTI
	ea4/9aW6e4twcYY218MJjbg3wsV64awt01DU+JxmcPoS+bJn2uuAkuriSr0ON1E2Zhk9Bn9XQir
	9LDiw9KglXHEGM+otcp4cKJ737Xgz3BfuDoJmWli+DcRvxc5OzuenON1+pBLCWycMXTpLX9FwvO
	PIBenv1ehIuk1Jhx7kBXK7Zn9IDqC
X-Received: by 2002:a17:903:2309:b0:248:96f3:408c with SMTP id d9443c01a7336-24944b1cb74mr283245715ad.31.1756976357831;
        Thu, 04 Sep 2025 01:59:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxWuT4vPU835vv5tJ8tYhEIyfyj+itB0O3M9+Ms4yaueqkNroOnRQHh70sZZFhz9A9lgG84w==
X-Received: by 2002:a17:903:2309:b0:248:96f3:408c with SMTP id d9443c01a7336-24944b1cb74mr283245125ad.31.1756976357320;
        Thu, 04 Sep 2025 01:59:17 -0700 (PDT)
Received: from [10.133.33.16] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b020a7cb5sm79081045ad.115.2025.09.04.01.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 01:59:16 -0700 (PDT)
Message-ID: <a2e3bcf2-80c9-4c8b-ad88-bd91c33137b5@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 16:59:11 +0800
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
 <a4382db3-115a-4d79-924a-08507e6e7b3e@oss.qualcomm.com>
 <1cef4224-1f0a-4c51-937d-66823a22dec3@oss.qualcomm.com>
 <961258a0-3cc6-4935-a305-80bb2c2c0597@arm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <961258a0-3cc6-4935-a305-80bb2c2c0597@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b954e7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=pVyM_Y0qywZFV96uxSUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: eQvP_Vjbi2jHZLru5jT0fYu80VG0nAzI
X-Proofpoint-ORIG-GUID: eQvP_Vjbi2jHZLru5jT0fYu80VG0nAzI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX4vuiFB8jZa+v
 LnwQQ76xyC5C14/8/knwNpOi2NNVm3UU5vRYHjiTNTiGovgIkUsfbu2KyJgfs8GizSaX4dBI2OF
 cbq8wlG1Ut6hcyDfgfqxsr7WWKxYGJdtooISqI4YQs8Nttgu5aLgMYPhkTLNVIzM7PU1g5zBJRL
 RZleWSJiLgYhAWiErMMZ2ob/y1PYp8NPjkBrSZECdhQvUiNTrF4qHQBxfZX6szr5NyBnShZ6Ind
 4d3I4V68sosHcmDnCme5FMLJdImsE9jS3Eyw0J/sP+xmf1w7ruCTLqGCZplbe0HAYO/i1Dmqp4b
 b0dvsAFO/z7uP9ICGgVLRaVW/20ubBhBzmKf7ao/5VMRVDftaBbbh4MXSM2xk4MKFp7ADvHdf4E
 Qt1CMIqr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101



On 9/4/2025 4:50 PM, Suzuki K Poulose wrote:
> On 04/09/2025 02:12, Jie Gan wrote:
>>
>>
>> On 9/3/2025 5:45 PM, Jie Gan wrote:
>>>
>>>
>>> On 9/3/2025 4:57 PM, Suzuki K Poulose wrote:
>>>> On 06/08/2025 09:09, Jie Gan wrote:
>>>>> Some TPDM devices support both CMB and DSB datasets, requiring
>>>>> the system to enable the port with both corresponding element sizes.
>>>>>
>>>>> Currently, the logic treats tpdm_read_element_size as successful if
>>>>> the CMB element size is retrieved correctly, regardless of whether
>>>>> the DSB element size is obtained. This behavior causes issues
>>>>> when parsing data from TPDM devices that depend on both element sizes.
>>>>>
>>>>> To address this, the function should explicitly fail if the DSB
>>>>> element size cannot be read correctly.
>>>>
>>>> But what is the device only has CMB ? Back when this was originally 
>>>
>>> We have CMB TPDM, DSB TPDM and CMB&&DSB TPDM.
>>>
>>>> merged, we raised this question and the answer was, "Only one is 
>>>> supported, not both." But this sounds like that is wrong.
>>>
>>> I think we may not answer the previous question clearly. But it 
>>> definitely has issue here.
>>>
>>>> Could we defer the "Warning" to the caller. i.e., Let the caller
>>>> figure out the if the DSB size is found and predicate that on the
>>>> DSB support on the TPDM.
>>>
>>> Understood, below codes will be added in the caller to check the error:
>>> if ((tpdm_data->dsb && !drvdata->dsb_esize) ||
>>>      (tpdm_data->cmb && !drvdata->cmb_esize))
>>>      goto err;
>>>
>>> Thanks,
>>> Jie
>>>
>>
>> Hi Suzuki,
>>
>> I've reviewed the logic here. It's not feasible for the caller to 
>> perform the check, since we first retrieve TPDM's drvdata, which adds 
>> complexity to the code. I believe it's better to handle this within 
>> the function itself.
>>
>> We are expecting the element_size for cmb if the condition is true, as 
>> well as dsb:
>> if (tpdm_data->dsb)
>> ...
>> should obtain a valid element size for dsb.
>> ...
>>
>> if (tpdm_data->cmb)
>> ...
>> should obtain a valid element size for cmb.
>> ...
>>
> 
> Ok, fair enough. Please resend the patch without the dependency on the 
> static TPDM patch. Given this is a fix, this could go in without waiting 
> for the new series.
> 

Hi Suzuki,

This patch has not dependency with the static TPDM patch series.

Actually, the static TPDM patch series depends on this fix patch because 
both modified same code snippet in function tpdm_read_element_size.

Thanks,
Jie

> Suzuki
> 
> 
> 
>> Thanks,
>> Jie
>>
>>>>
>>>> Suzuki
>>>>
>>>>>
>>>>> Fixes: e6d7f5252f73 ("coresight-tpda: Add support to configure CMB 
>>>>> element")
>>>>> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
>>>>> ---
>>>>>   drivers/hwtracing/coresight/coresight-tpda.c | 3 +++
>>>>>   1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/ 
>>>>> drivers/ hwtracing/coresight/coresight-tpda.c
>>>>> index 0633f04beb24..333b3cb23685 100644
>>>>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>>>>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>>>>> @@ -71,6 +71,8 @@ static int tpdm_read_element_size(struct 
>>>>> tpda_drvdata *drvdata,
>>>>>       if (tpdm_data->dsb) {
>>>>>           rc = fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
>>>>>                   "qcom,dsb-element-bits", &drvdata->dsb_esize);
>>>>> +        if (rc)
>>>>> +            goto out;
>>>>>       }
>>>>>       if (tpdm_data->cmb) {
>>>>> @@ -78,6 +80,7 @@ static int tpdm_read_element_size(struct 
>>>>> tpda_drvdata *drvdata,
>>>>>                   "qcom,cmb-element-bits", &drvdata->cmb_esize);
>>>>>       }
>>>>> +out:
>>>>>       if (rc)
>>>>>           dev_warn_once(&csdev->dev,
>>>>>               "Failed to read TPDM Element size: %d\n", rc);
>>>>
>>>>
>>>
>>
> 
> 


