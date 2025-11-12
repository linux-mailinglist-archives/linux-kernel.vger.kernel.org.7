Return-Path: <linux-kernel+bounces-898224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 032CBC54A14
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E39A84E26B9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B04027D782;
	Wed, 12 Nov 2025 21:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fqcUSt9o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D7V9ILAr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4942D94A3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762983293; cv=none; b=GaG9oKg9224djpuJnkpIg+9NSvXcYmj62hzpvh9BDRxDmp3AMYJN6qESI3vAz98iqKU/2fTqFQYIlvPCf2pj/7iLlkIcKULZXPcv5IIB9QTROWwH07TXpke35oUBXZuz1jdM3eug2U+dyesyVCe75yFWtIdn9vls+czw4xqOtq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762983293; c=relaxed/simple;
	bh=+ejs/xhDjzWOqg5kRwl9a02Jk7D+Klk0GOZH05UkMbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hmQSbYpYTEgYPH6KDTIVwcEYvOH5MUQ6IjjhvEtZNf9Y10va3eZPj0rrJLRyZ3jw792TnmsEiplV7Yf5w9SHguZMCX0Q7uEwd63LmOsmwQQiFiHNPiDgzOUmsSI6WBwAZi7NtX0V9oLhWZ8j81kEx6ZR9WwgO/I8Qgv0mZYihu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fqcUSt9o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D7V9ILAr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACH2BBC721887
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	akUL7PFUD7ZtgXkGMHVEnif1hzpe+FepoSGWQH2GuzU=; b=fqcUSt9okdwq+O/A
	nofu1KSHZH1rUmDP8mvBPhnE2B/5LEJnP2vLLPI9vEF/iNvu0DyLGh50G+KEI+WM
	LRHkj9REyt/WxYPE3lDn3Gcg3uNjO3bXMOB/nc16urhbV5yAEMZ4PYdGSioWaVpn
	RKSBZosefZPp8G9k91rMLS/e9/liDN5xCLcAL/fL/ZO2TvjCCZBgtjG6wCi7Jw8k
	mH4dBfMQlPOG4+0g+SISllVJzHNXK45YBd+Tdo6YrRwfmQZhK5DJCjkN4WtZpi1F
	c4S6aYUEWrMmN/sG5crNNt1IZj94DAJcmmXVmfMTyIL7ygrj+IlEi9zKe8wbWieJ
	ANYvcg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqu1t6jf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:34:51 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b89c1ce9cfso73718b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762983290; x=1763588090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=akUL7PFUD7ZtgXkGMHVEnif1hzpe+FepoSGWQH2GuzU=;
        b=D7V9ILArMg6xGILtcRqa4NV27jR3YI7CI/3n1E3MnPcxssPW/r07gNy40gamFN0HBd
         V08arfo/XuuQQRYVJRDU7xd8lJ2LOuhp6ylk7k7jQSFBdOQfZOH3BDv2XkIkNOoJBRmm
         cjgd1KYbbtydd+45mt8vSqBxbNfMf2vfWGccz8Oegz4pExoODKwulFGqRIMD13uP40X9
         PdWoBFoRWTpfEzAltJjUHuRnNMGUMrPNapCnmp4/tV87N+JfixSdlGvPbFHy3SQcgHIl
         +suNq//OU7F9O0cwK9cZtAOt9kDLAIp7krsG9d7R5EQsCKRRf3sRR5AFb/vytAuUZjMM
         hu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762983290; x=1763588090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akUL7PFUD7ZtgXkGMHVEnif1hzpe+FepoSGWQH2GuzU=;
        b=lY576HD70RKxVb60DhLCbOVy0dWHlJ7PuitziaH4vPjFOl4/aXnPwH3b/yp9u1m7x/
         Jpe8b/56ye0H7bNgc0Emqx782s4yq973KcWtNw/nL3PlhrpwIWEB9MsNQxgkCwiqOEMD
         G0l2t7/7iBlv8Z2IYETtOAYwprPff8fjSxsQd9cDsp+VWXqtInMGwAgfn/Yo1uD60xMp
         XxOaBad5OcDnuZ3Iid9hoJEFzoECxQxcWwIywTA60optYa08B15zCZ4nPcEojB1GPrjZ
         /CEYvm7FpiRrPcNNhsm9QAkF9P3NFspMPHTQh238ACYb/XAg6pOmD7RVXQmBOtNo3lPV
         yTlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrLUlgcmS+WDSSBiHaqAMCFQddt94gKidSf63RjVyMTXlkM1eAfqCkmMddvyo6wMqMv0J9I6sIKm1B4uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLakpVwgdOP8iqD5Bf6foKOixDl0niucFkbmn6nZ0vs1iwsQ3A
	4cAJnanvZL4qTPt2PihCGff1lg4ScVQ1nWuS2Kgne5lpeYRoDrI1oc5APq8Kd7gvrkYrk5OqgOO
	VXBO/9mHFBZIG8EIrlYOsZO9rANgtahPIg8/KpdGt82K0sSBXmXfp8wGUUU1IxRkLAbE=
X-Gm-Gg: ASbGncvKL/8pqnBkSk9B9rNpdYZePt7PuqnAkR9LdIcevI31cufSsdc9BLfXL+PcRqc
	AAiXktoz3FjYTV6ELyo0f47IODRT7mnbrn3xhG25P6bnmjiSL7w8DGWijCn4MMJ2PTVvedNO/uE
	/2j3k0czmylsya/o64ePUKstj9CjgCgAuupbGgAZMznyNS0m/I7YL9+apAWu3xX3XFm9NGIBBrY
	WgCI+RL8ghG36Up+iFIH2LPrFSl/jlVEg5YLuI8OiVdh5nxjEgDslJUcvlkuYPe+/7HPsb7XwnD
	2ODBAGmkiPneUY4WjSlsQsprr074DjMsD8lUm8WUojGW2Xoy3QW9ze00kr+HP/w90mDONKVa4Mw
	fD9k/Q59/jMwF4e/ClceBXw==
X-Received: by 2002:a05:6a20:7f8a:b0:340:db9b:cff7 with SMTP id adf61e73a8af0-359090967d7mr5549507637.5.1762983290331;
        Wed, 12 Nov 2025 13:34:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGex9yMVhli943u5iSx/utgvoPxPJzj5p0bexquPM0bky2PiZDhb0Iyz19ikO+MPy/f/zNHCw==
X-Received: by 2002:a05:6a20:7f8a:b0:340:db9b:cff7 with SMTP id adf61e73a8af0-359090967d7mr5549466637.5.1762983289783;
        Wed, 12 Nov 2025 13:34:49 -0800 (PST)
Received: from [192.168.1.5] ([106.222.234.47])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc37818885fsm46671a12.38.2025.11.12.13.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 13:34:49 -0800 (PST)
Message-ID: <13c39ab6-f054-4552-a033-819906af29d5@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 03:04:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/21] drm/msm/adreno: Do CX GBIF config before GMU
 start
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
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
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-16-bef18acd5e94@oss.qualcomm.com>
 <ae21a963-696a-48f3-af91-ee72aef4b60d@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <ae21a963-696a-48f3-af91-ee72aef4b60d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SDMskedBATA_e5IUOAyKI48GoHvqkvXf
X-Authority-Analysis: v=2.4 cv=Hpl72kTS c=1 sm=1 tr=0 ts=6914fd7b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=2IP1oaZ8+KUWsYovLW0HHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=9a4g6yj39E2whjoMmyEA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: SDMskedBATA_e5IUOAyKI48GoHvqkvXf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE3MyBTYWx0ZWRfX33i+W5Dr/X52
 yYqy6ABIIjQOAfwx9rfbKBjZAPiQeyY9LEa3KLJP7Zr3D39nKo+7Hffd12E2AHF0g3kRQnSCAmJ
 OhX15IzppucPA9FJpbc26XxTzC37wQEtDfLzKYZOoeq8pbDiE0r8PNGzS+p5/5ODN5F3q3KAjUe
 uA9SMd2Pzj4f3zv7yMhAkIe3c9L6CoTZx5lwso6yCiQxpl3z2s5uvqNTK8pAdzJMXpswV9NtiNP
 uax6/MBYDLN9eMKqP7Mtpbof0o6XMTzw9QR/sN2qTuNGxt3z/+ptPwDh1fJ5NdE9AWaTFeQzKcG
 jMDoHb/Bb1VAli9Sd87KoLIaOITfKEeZuZsKhAVR/gdQ3VdXmkMc0wsxfTfA7p67zAHyka4gb/d
 LEfonPecMB0FvzBkxxZGwPKupNqzsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120173

On 11/12/2025 4:07 PM, Konrad Dybcio wrote:
> On 11/10/25 5:37 PM, Akhil P Oommen wrote:
>> GMU lies on the CX domain and accesses CX GBIF. So do CX GBIF
>> configurations before GMU wakes up. This was not a problem so far, but
>> A840 GPU is very sensitive to this requirement. Also, move these
>> registers to the catalog.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +	/* For A7x and newer, do the CX GBIF configurations before GMU wake up */
>> +	for (int i = 0; (gbif_cx && gbif_cx[i].offset); i++)
>> +		gpu_write(gpu, gbif_cx[i].offset, gbif_cx[i].value);
> 
> We haven't been doing this a lot in the GPU driver, but adding a
> .num_entries-like field is both more memory efficient and less error-prone

Gbif config array is reused a lot. So this is more memory efficient in
this particular case. But generally I agree, we should stick to one
scheme. We can revisit this later.

> 
>> +
>> +	/* For A7x and newer, do the CX GBIF configurations before GMU wake up */
> 
> duplicate comment
> 
>> +	if (adreno_is_a8xx(adreno_gpu)) {
>> +		gpu_write(gpu, REG_A8XX_GBIF_CX_CONFIG, 0x20023000);
>> +		gmu_write(gmu, REG_A6XX_GMU_MRC_GBIF_QOS_CTRL, 0x33);
> 
> Either set this prio value here, or in a8xx_gpu.c

We should remove the other one.

> 
>> +	}
>> +
>>  	/* Set up the lowest idle level on the GMU */
>>  	a6xx_gmu_power_config(gmu);
>>  
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index 029f7bd25baf..66771958edb2 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -1265,17 +1265,20 @@ static int hw_init(struct msm_gpu *gpu)
>>  	/* enable hardware clockgating */
>>  	a6xx_set_hwcg(gpu, true);
>>  
>> -	/* VBIF/GBIF start*/
>> -	if (adreno_is_a610_family(adreno_gpu) ||
>> -	    adreno_is_a640_family(adreno_gpu) ||
>> -	    adreno_is_a650_family(adreno_gpu) ||
>> -	    adreno_is_a7xx(adreno_gpu)) {
>> +	/* For gmuwrapper implementations, do the VBIF/GBIF CX configuration here */
>> +	if (adreno_is_a610_family(adreno_gpu)) {
>>  		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE0, 0x00071620);
> 
> a640/650 family GPUs didn't receive a .gbif_cx addition in the catalog to match>

Oops, I missed that. Will fix this. Thanks.

>>  		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE1, 0x00071620);
>>  		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE2, 0x00071620);
>>  		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE3, 0x00071620);
>> -		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL,
>> -			  adreno_is_a7xx(adreno_gpu) ? 0x2120212 : 0x3);
>> +	}
>> +
>> +	if (adreno_is_a610_family(adreno_gpu) ||
>> +	    adreno_is_a640_family(adreno_gpu) ||
>> +	    adreno_is_a650_family(adreno_gpu)) {
>> +		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x3);
>> +	} else if (adreno_is_a7xx(adreno_gpu)) {
>> +		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x2120212);
>>  	} else {
>>  		gpu_write(gpu, REG_A6XX_RBBM_VBIF_CLIENT_QOS_CNTL, 0x3);
> 
> Downstream seems to set QOS_CNTL at the same time as QSB_SIDEn for
> these targets

This register is under GX power domain, so we can't configure this
early. This should be okay.

> 
> 
>>  	}
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> index 031ca0e4b689..cf700f7de09b 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> @@ -46,6 +46,7 @@ struct a6xx_info {
>>  	const struct adreno_protect *protect;
>>  	const struct adreno_reglist_list *pwrup_reglist;
>>  	const struct adreno_reglist_list *ifpc_reglist;
>> +	const struct adreno_reglist *gbif_cx;
>>  	const struct adreno_reglist_pipe *nonctxt_reglist;
>>  	u32 gmu_chipid;
>>  	u32 gmu_cgc_mode;
>> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>> index 2ef69161f1d0..ad140b0d641d 100644
>> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>> @@ -500,6 +500,9 @@ static int hw_init(struct msm_gpu *gpu)
>>  
>>  	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
>>  
>> +	/* Increase priority of GMU traffic over GPU traffic */
>> +	gmu_write(gmu, REG_A6XX_GMU_MRC_GBIF_QOS_CTRL, 0x33);
> 
> Kgsl (later) added this for A740 too - would it be beneficial to enable
> unconditionally on gen7+?
These are actually recommendations coming from HW designers for each
chipset. So we should just stick to that. I will check separately about
a740.

-Akhil.
> 
> Konrad



