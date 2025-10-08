Return-Path: <linux-kernel+bounces-845826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DFCBC63C0
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDA6A4ED427
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267852BEFFA;
	Wed,  8 Oct 2025 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WOd7W58k"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0561F34BA3B
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759946609; cv=none; b=Daf2VoJ1zWnBlpoJ1jw1AwI3Sh1VYC8kllt+LJpZrf7s8i7pYwoxKXfBZFCyrCmLveros0rAFGF2mHihrtQAOxHSxo0UFed0tqCZxWlfYOaaWfh7DZ8k3mPLqxvKmhSJ1gFlFbvgR6JXaZy+TXsdVcD27IafXBR7yksp8PmWQDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759946609; c=relaxed/simple;
	bh=QykquTIZ2jLmxb0VLUnWWhmZGhsfGC7/GqGvSPSjgiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wk5qR+ptkcEWEgdZtuAXELc6fvYYiObrj05EP96s3OSxflp9ipKfhpDuaYHr6zwKyJaQpiaCMlRbodpyHZnGzfXPArE7z0fYeSxXHNR3yxFOUe+nMUugDSJivdH4oFUhz0BAXGdN6gjdMG01et8uFAREzdLLcqU63vqUa7xfIA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WOd7W58k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HAjES027091
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 18:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VAZrOlnHPn14DgXDTf4mZHirlOOxow8QFnRlxfGqzt0=; b=WOd7W58kmitYxgJI
	4ol1S5dJq1genoJT8IdDlnApjClOC/FxAtqwBoyr4TVMlWAOpiRcWd94+zV8PIs4
	fVzme273AoVqRFBYatJUkG0h8dSjWLFbbwZeVUDDDl2b0iqQsEWc5nrm8wLy9zB+
	oTec+hf4zUGf3x2F68fht/EO2TYcy/m3ftCncTRMEUOwazqQqu0iyupAnEj2bZZQ
	BZY9+7IW6F5z07uxiNF500j7lUo3JfYsKbAWGnD95qvY5ToVaFjgFUNdSPHVCOHD
	LH9IuEYAZF5T4l+4R13YeIXPp/BroSCnEJQAibtJptvFXNjLv6pOLerpU3KkmXWK
	//TVqQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4j05ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:03:26 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2699ed6d43dso1199875ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759946606; x=1760551406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VAZrOlnHPn14DgXDTf4mZHirlOOxow8QFnRlxfGqzt0=;
        b=tdXZ2c383229KSrxB/kmSYHPcpOBsgkszvBFGzmYaW/AOqptYqQQ3yGefGeZiA2eQ2
         T8/vJSG3je4eFVhLvGNdJe88VChOGMpx7V24Db0j4KRTIoFOsaTMYTM9VGLKig+l+uoj
         1Zs2nP2Z8OzPH0VVkGximXHL1wYUDSrsg+uSKJOsa4e7BJF0Boxa7kRRljPWs8gIHElL
         AG+kOYUtGuKla/+jeZO0/wTjrVFYWNdFGglZqqxp1TqwYx/zDPf0IyZbaU1i+sAhLTc8
         pbd9EZTAkKy5DNH/Npe7hv2zx4huRCBFQ1XhUyxfmdH4ACdVNicZsyYOu19Y51eg1vEe
         GmtA==
X-Forwarded-Encrypted: i=1; AJvYcCW6A7Vh8O+NkN3SFENB8ArylHWpws1JaArWhi9a917e0UeqjM4AGuEOM3H6JdpRh6SNtJQwaUHLgP65xMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwljKgsE68t/r1XX/xssUB6JkVHDJH1RUyZIm8E9nz2mCJBxBJX
	PXy7Vj1Ut+XhuqXC/zBq1A/JK9JJs5yjvP+ISS/JQFFCZ7MHaxAdWhI3Ak4WQJZDRRmKsNbKRZh
	8i5LhDbZgNdm5dharQCFeh58IQO8LyLC503a0y6PKuXEcM/MpegH062tiqkyLwMgqj+c=
X-Gm-Gg: ASbGncudeXTbmF+qaHuA4JAi0+0clcM4GjX0dfJ7cV1jJmR3a+tiaCKtDpXcVEG9ywj
	hSd0tMowowImcjx1qkTq5h8fES0tCtTKEK37a8+KNkBmbbI2d1/Ds0b06StfzmcXq32/wJOXFSQ
	LZOPXYIanrLVwDYbHRI+/agWcqVHzkFOm7AooMjPC4OykTJC09J0LYZfJvay4MuLHroNnz65l/a
	u7Rd1zaZzUlP+bdYysA+xoJz9LaVR6DG+W5LoJANVJFBP5vDGR+AF7Ocdo6Zjf+e//5+MhUEqLy
	FD2XSfuEK53RwvApeFAXyRRDA+Ex6dym+YHrIrETWvukxB2QcsRN7xMNRs6bCvzCbvZubiUpq80
	T
X-Received: by 2002:a17:903:fa6:b0:27e:ea82:5ce8 with SMTP id d9443c01a7336-290273748e4mr55866365ad.14.1759946605873;
        Wed, 08 Oct 2025 11:03:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwH3bBMKa9ZlQO/2aapjl36/O5H4D7oAkI+cnOYUVZeGt5Ph5Cd3mta1vBN4JAMeEsyEvGaA==
X-Received: by 2002:a17:903:fa6:b0:27e:ea82:5ce8 with SMTP id d9443c01a7336-290273748e4mr55865825ad.14.1759946605263;
        Wed, 08 Oct 2025 11:03:25 -0700 (PDT)
Received: from [192.168.1.6] ([122.181.205.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36929sm3463065ad.95.2025.10.08.11.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 11:03:24 -0700 (PDT)
Message-ID: <1516f21e-aee3-42cf-b75e-61142dc9578d@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 23:33:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Introduce "non-pixel" sub node within iris video
 node
To: Bryan O'Donoghue <bod@kernel.org>, Bryan O'Donoghue <bod.linux@nxsw.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <7b6db4fa-2f73-376d-4eb3-64c1c7e6cda3@quicinc.com>
 <4f38058d-a2f1-4ac5-b234-228cfb2e85ff@kernel.org>
 <1ad2ca1e-1d57-4ad8-a057-ab0d804f1d49@oss.qualcomm.com>
 <7da769b4-88e9-401f-bb21-0ff123818b9c@kernel.org>
 <6840d462-8269-4359-a6e5-d154842b62db@oss.qualcomm.com>
 <af0da28c-3ca0-41dc-aaa4-572723ea74bf@linaro.org>
 <klhvgzizub33f46buqsog54wqksqp24a5tijwyv355l2ao2imo@wdkojfebc6s2>
 <e1a6e75a-2a5d-44a2-8bbc-140eb86d1806@linaro.org>
 <2hh3zkdwgqbdurpr4tibr3gjat6arwl3dd3gxakdaagafwjdrm@aj5em4tbsjen>
 <Ujyoj3HGLVFhS2b0XzcYAMjSiCAuO-lSJ8PMEQLOaaX83tk_0D5zjrL0VDyZAmD3i4zLB3ElKSZBltISb5jJHA==@protonmail.internalid>
 <4a32bbec-2baf-4210-a7c1-1ddcd45d30c8@oss.qualcomm.com>
 <SuwJuCIcLVJwN3YeN1il6tB9wO9OH6bYcnbRpxpuI9Dl7piYLN-hVdnyv0Mal6N-W5pi2aCZI8MxHZDEkoE63A==@protonmail.internalid>
 <4d87d1ca-55b2-426e-aa73-e3fd8c6fe7bd@kernel.org>
 <10a8ccda-4e27-4b06-9a0e-608d6ade5354@nxsw.ie>
 <4cb4a92d-2f20-47c7-881e-aadcc6f83aa0@kernel.org>
Content-Language: en-US
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
In-Reply-To: <4cb4a92d-2f20-47c7-881e-aadcc6f83aa0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Fo8ZmJ5LkZy30MIfgudo5s9zKR1I-Gc5
X-Proofpoint-ORIG-GUID: Fo8ZmJ5LkZy30MIfgudo5s9zKR1I-Gc5
X-Authority-Analysis: v=2.4 cv=f91FxeyM c=1 sm=1 tr=0 ts=68e6a76f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=6JKELlXEPSgWT0DDZg8VgQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=pGLkceISAAAA:8 a=fHmCkQyIX7tJ2GRZnMsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX0bdKz09Bdr3X
 0hkhOHQs6karkEdvR8u8gk3F4xhUYk2H3PNjdzN6rTFGx4OBB80O32MF4TG+Q/Rmfl8uygJF+Vb
 X7gxIq6bQa3xELNeNWq3CjtDnEgQqV0oP2sqn3qFo2itRPsackG53jc+aFqhzB+JW0kQyCTGP6w
 PDGte2EVrNBfAK006OmQaBgWr+MCiG097P6fIxeYiuPJff60ZPfYqulv56Nlq09o9EzKTWLA/tb
 AB9hzfOe/YBhkt5VQh9A03RL2c0UYUPbM4+VQlX25yUwTjrrkVt/LZ0NsKyYa7rzLxYC3h88nOL
 eFu3yM6dN6LZlwtDtRUVZO/Y99hqO1B8ZHZ5dHgiVFMEHwZU3lnO0wtdSOzDIvgWZFWUfzdDbRf
 L5jimdNk+ewkpDX/cydGXQUlOtw8Nw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121


On 10/7/2025 8:14 PM, Bryan O'Donoghue wrote:
> On 07/10/2025 15:29, Bryan O'Donoghue wrote:
>> On 07/10/2025 15:25, Bryan O'Donoghue wrote:
>>> Rob suggested using an implicit index for function id
>>>
>>> https://lore.kernel.org/all/CAL_JsqK9waZK=i+ov0jV-
>>> PonWSfddwHvE94Q+pks4zAEtKc+yg@mail.gmail.com/
>>>
>>> Couldn't we list the entire set of iommus - then detach - subsequently
>>> re-attaching in our platform code with FUNCTION_IDs we keep listed in
>>> our drivers ?
>>>

TMK, there is no api exist to detach a device once it is attached to
smmu. We used to have one but removed[1], not sure how well it will be
received to introduce it again.

There is other problem exist attaching the entire set of iommus in the
first place: Usually writes to SMR registers are protected through
emulation by hyp. Thus adding the sids of protected/non-protected
usecases in the same iommu set will not allowed by the
hypervisors(eg:gunyah), as all will end up in using the same context
bank, thus there can be failure to attach to smmu in the first place.


[1]
https://lore.kernel.org/all/20230110025408.667767-1-baolu.lu@linux.intel.com/

>>> That way the DT is complete and correct, we have a compliant upstream DT
>>> but we also find a way to make the FUNCTION_ID specific setup we need.
>>
>> i.e. you can keep the FUNCTION_ID "metadata" in the driver and
>> associate specific iommu indexes with the FUNCTION_ID you want in there.
>>
>> That way you could have multiple FUNCTION_ID smmu entries in the DT
>> and just associate the DT indexes locally in drivers/platform/qcom/
>> iris_metadata_goes_here.c
>>
>> ---
>> bod
> 
> Actually why can't we specify FUNCTION_ID in the iommus = <entries>
> 
> Surely we could do
> 
>     #iommu-cells = <4>;
>     iommus = <&apps_smmu 0x420 0x2 FUNCTION_ID>;
> 
> and encode the real data we need directly in the iommus list...
> 

Since it is the smmu device property , this suggestion expects all the
devices, not just video, to define additional argument. Does this look
valid?

> ---
> bod


