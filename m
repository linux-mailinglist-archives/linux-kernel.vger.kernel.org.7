Return-Path: <linux-kernel+bounces-898245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936D3C54ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E4B3B0B55
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776F52E8882;
	Wed, 12 Nov 2025 22:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cHA0o/fh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D/ToLOzg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE732E719C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984984; cv=none; b=uZpkraC/KNELBTyG2iCz4oWuC5i/GPMxi62ztZRhKaTEudrEQIrB9m67nSyrAzRBzbB9WBoo6IxY5feiNh36xiPVzFHIbVL0Mr+U0E7kCARhXPkJzNwBonJynTflJRQP9xsd5AreMvrElA/E9+fwge+WFRf27p33ryDSNqILaIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984984; c=relaxed/simple;
	bh=RkPfHlmwsqwzHclliKqi/Zquq2J/tXBfOO8ELda2TsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OpUXmpZ/JAdtUMlGdZBcbZKs4NbAPRiccLbmA0HkZtGcIWNAHqK1Kn088uSb/hUcF1OKbBbYeoIzKKEQQSuep/BelHe2TAWEtJQE81DRKFjmaejIO+Q1di4A2RcDlGa4BW/Os4Udmfg5h12OgD+SdtwEEWwFAq+vLf0iATBc34k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cHA0o/fh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D/ToLOzg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACHLD2c908048
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d/nTs8LVBJqSn132QZVwYlosV14mCj856uKAHF6W+UI=; b=cHA0o/fht6HtoqNI
	X2cYYYSs6rD1AE66bCG5GhR0LOm9LtO7Mobjpxoyh3U95AlY29yom5E7WGfeb6kW
	UZhdWXha5de685yIUOUFbiGYTJL1cifGUzOVgzEHA8tMX81I2u1DIhyu3vfXk7gf
	PiNBbBzVjBv5J4JD+tvjbGU+6glXD2zrN+SItouNpSIDY2egKFY2EzgIONn0u2Kv
	bO5ih6SjmiIh8J+TftgLVC8WyCxiZiWrXt6albknM9MMXu8nHASqw5x2mx41WUYB
	H9qA70549eBQUyzq6ZtpLH/hCI98INtheCd15AVSEtGZPZJkZQb/jSRiy0CJ9Fo8
	a31FmQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqura62a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:03:01 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7900f597d08so116297b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762984981; x=1763589781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/nTs8LVBJqSn132QZVwYlosV14mCj856uKAHF6W+UI=;
        b=D/ToLOzgqsszDmPqKKQVijHaRSlooJJ2z2c7mjJoDi12EYgZ3jORx7B/Wmp8G52pUR
         Uslq0O2u4plUybSd12xjydILJvbEqEQZ1sC4z9MmO32EydfkUfR/Q5jwmDYyIMpazKyy
         cqHB0Z+aFs5LPbFOCBpVqaLUkZ8BDw7SdfZ8Kz7w0FJfDVLIM9tKCFLq0dqNt6jtAkF9
         FrekCzZI2QBhdy1PHXiu5WhwjzAy6i6D8BRloFuk6wNuWr8EJZI6yg5ZvxRQ7FAOrBjW
         P9jtY/x80/4zjSIsC6ca0BFhG06XTc0JEk+iOUbtEEz5Bb3S7znbBRcotlUq8lAmVBDK
         YFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762984981; x=1763589781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/nTs8LVBJqSn132QZVwYlosV14mCj856uKAHF6W+UI=;
        b=HBngTX8EQFFJIeyb+RjS92aSeCJrpqdS+gHieOs0584a7YHrkcLoKmVTsJWB8HKuIk
         uXb/XUK7bm/3E+163nfFRQj+0WpYOCC4FowQrD7WghPaPkZKZPuDGTapQaKHDblbqOj3
         tkU8qAtJmu9YkWxZR+skBmZO3ZMtdhr2AoeJXXX98pNoj36/5yqny9a2Jg/pJeZ2benC
         HHVi6bi9X7PstreAB6vYFkJpZr5FqX9CqU67Oao8TphmAxPxJ1h2eV05BIoeW39X3PhO
         qsuy5vur7hkDsHI/iL41JXBN9/+sT3qUxz18Mq6g+WjRj+MG3pVEzCHBIEfn918VHT0I
         5fTA==
X-Forwarded-Encrypted: i=1; AJvYcCUBF0+dtCD4zJs2rtx2D4UbqPeaB8o0jRsIV6r11hpGWSM4hvbQOwRZX1GQSJq1Ziwdxrn3MSj7YVVNRyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV0xyQgpMOFKBWyhb0RrunX2FAmMACsGr/sKrxHXsB/13xaMhz
	He3wSBx7KsaqWf/Q9tJih+TTlSHLRkQDLq6yABOorNROdhXfTY4lEcK/h5E++IbFRtEx8R8zLFo
	Wxsj6U9uWKmgDR/i25/92Z0HEB+MSc/0GPHfrjDKoCJlAu9hu5h3RF+iNY1t+i5yGtdU=
X-Gm-Gg: ASbGncumPUdgV29qb1QDe822oibZ2Hz8UTOCR/pz6e81ZWoMQ7ZfhvAQ8W4DZcXAuKG
	fbB8iaK0Fg1x82Q5a5cRAfSH4D0a8cGPgzdULoDi3h+BZqvXFW5v5fRxyV/YCL4eExeGiB6Siq7
	j15FTrxLK4Zr/NF4D8TPkXCXi3VpDb6pbciktf9aHR4D4gDWvOapiOTyegpbJMXm4cGK5HcGCPk
	sdgPDAhfYzLKVEYeFtym4MMR86LB00F81SnWjF5zd/y5qeckyWP0cx47LZwcb0RdQ4oEVV/E3He
	XftLkiN+AkRkIk93HzVEqcT9FcsjfbYVBjFYb+z7bxRLjCZG7L/ILsk3o5T+57rtS7NgPtmw34p
	9KkGjXcgtqmc4A6Xv63QuMA==
X-Received: by 2002:a05:6a20:a110:b0:306:2a14:d0d4 with SMTP id adf61e73a8af0-3590b514a27mr5686026637.43.1762984980847;
        Wed, 12 Nov 2025 14:03:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn1u1Nzkjc6Q6wIjoT4YUJ/liTOuUsOAfbNf14qAseJxfRuSew1Z6BWUptugvCHiHCrtJQpg==
X-Received: by 2002:a05:6a20:a110:b0:306:2a14:d0d4 with SMTP id adf61e73a8af0-3590b514a27mr5685964637.43.1762984980255;
        Wed, 12 Nov 2025 14:03:00 -0800 (PST)
Received: from [192.168.1.5] ([106.222.234.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250d28c2sm54557b3a.26.2025.11.12.14.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 14:02:59 -0800 (PST)
Message-ID: <12e6f588-e422-4803-ae14-56e5297e564d@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 03:32:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/21] drm/msm/adreno: Move adreno_gpu_func to
 catalogue
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-5-bef18acd5e94@oss.qualcomm.com>
 <28d62905-c191-4c3a-995e-a4146ffce619@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <28d62905-c191-4c3a-995e-a4146ffce619@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE3NyBTYWx0ZWRfX+Bu9AHSByRMb
 M90xT4qZlblXRX2pGQYnYpmbq2OxvgrHxRg6zoOsagbWd0GtDb8cxOhYzZPGAYQn6cI6H8wLJEP
 aPNgVXPcw1nN0sJ+dgFj2MFuYPy+D/2+Bg3exmX1/godtQFBHFNHlHX9kI/g3RVpzzf9yTtCH6k
 GSgDOXFK9goftb4M345SORyippE5LTQpo8/ZrE2UbviROQ+FmGGdrgSwgD5RNYDRv1cDmMS33WK
 UUhmWhKYXqlSz20dpVANPteq8aUM+k4xcOpfEiCg3og/e9mAEEkGFFAgS6OISR1RkRA4ki0KXGG
 hBqqfYzsLCghxCm0YOZmzYRnW03YwG28bz7agyLQnk2drlxJrocUdHDAaQ4gMOpIeRQHBKcwkqx
 3YOaMdAxRw2kvMCiVKyYc4k+ry7fOA==
X-Proofpoint-GUID: vJ-5Cvf2FovOaBGEsc3pQf72RoVFZrmb
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=69150415 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=2IP1oaZ8+KUWsYovLW0HHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=6-R1E5pqECOcxGsB_ukA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: vJ-5Cvf2FovOaBGEsc3pQf72RoVFZrmb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120177

On 11/12/2025 3:52 PM, Konrad Dybcio wrote:
> On 11/10/25 5:37 PM, Akhil P Oommen wrote:
>> In A6x family (which is a pretty big one), there are separate
>> adreno_func definitions for each sub-generations. To streamline the
>> identification of the correct struct for a gpu, move it to the
>> catalogue and move the gpu_init routine to struct adreno_gpu_funcs.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> [...]
> 
> 
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> index 44df6410bce1..9007a0e82a59 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> @@ -683,7 +683,7 @@ static const struct adreno_info a6xx_gpus[] = {
> 
> Somewhere among this diff, a619_holi needs to have gmu_wrapper funcs

Could you point me to the holi's devicetree? Currently I see only a610
(sm6115) and a702 (qcm2290) uses gmu_wrapper.

In the driver, adreno_is_a619_holi() checks for both 619 rev id and the
gmu_wrapper.

-Akhil

> instead
> 
> Konrad

