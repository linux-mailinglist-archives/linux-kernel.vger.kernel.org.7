Return-Path: <linux-kernel+bounces-744201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4049BB10962
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FEA17D114
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B15F283C93;
	Thu, 24 Jul 2025 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="btqezY8p"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7CA2741CF
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753357173; cv=none; b=OKkf67VFfDFik/VDRf5hNAutPN69d8bw/Mcs6c7MtJTAp6t4M4oNN/7R308OaLmU5+NgVKmoGCGBgo/5DRPo/lyRDGvzlutR27en/5pjWqlQxDZ1n6ynoZpDBtqwpolJ7iMuBYhzsGtsXYICUee2cDbBjYZ62UVsx7aEkbaCbcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753357173; c=relaxed/simple;
	bh=CucY8CClJThC160kd0K167/37SBD1Bmj+AaitNmYoq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTezg0lRbVkM16DYBRriL+vqKQyGOXApRX4/ESfEjVvlvzLxMbowsaCb2boC3TvLgz+489vswtPyPCACJzhREGPhlQtcgL1VQTlTN0yHvYm/ryFCXIdvBDuoPuCnhfKIczFMDtgEY+xP87OYaF3FeUI+kpTSjp06bV7daOY4cE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=btqezY8p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9XFbu012641
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oqSerAH08mV+bu18I/AJbmlNy8XOCWAaqntFX3ows/0=; b=btqezY8pJgbADaRU
	scEYcRojeNpyXK+P8q8dFPu5gGoh7D/jOaR/MtgR4VpicfK4BCZ85M2rrImgK7kJ
	Ec0Q+znmi4C1uN7BzyrhTSFx6VauxEkKxHhRSRnm+fHeM90yyQ4Ve2rho90VofRK
	xly/1DSOsAqhafmpoRD67mxKDypFGkhs0pHWwlnU/WzLPtErI6oBYNJnQ0YT71SB
	tb9lYpdHBgEXRBoD8nCAI3gHQKZwzqXcDNGzlMAC2j1OfzXBym1EmEA3Fyy0f+yC
	omV67354n7tPn5p3Uf7SgMxm/NE8hF+SVx6Lgaj3fo2FEzROiTNZkLJLVYmMzqnS
	XigT7w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482d3hxjqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:39:30 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab3f1d1571so1209441cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 04:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753357169; x=1753961969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oqSerAH08mV+bu18I/AJbmlNy8XOCWAaqntFX3ows/0=;
        b=PewfBjUGvR5VV7vCGfW3HhI2uZ6mlCKEUTkR0z+mhpA3Xeb4C37fy6eK2l8bqKUiFa
         ZarN6UsH//M5Ap52SW5eJHH3Af+aZN0f5POJzIkrbg8ECZ5HG/jPkZZmkud0niS7ps5S
         MMJztukbr8wfiPiYzWtwGsVs6jzcpiEDN6Akm1RJYXxW1iKLmGMiCL7Mtl93bBhPxpRJ
         4l9j5idOEs/ndRagn0lCGNfdldlDb28O+/T8u+LR0Kirxd0fufn4awGHRRqIeDbH0wVs
         9HRnTFkRL76YLQo/Rs5EKUMEyVDgtKxawu9yvUIE18xj7fSvLaMnzj+P70sLUCJ05o47
         OtaA==
X-Forwarded-Encrypted: i=1; AJvYcCVsHufk7tdyahJwGckYj0ucZ31sAHM5G4kvAO2YU0jpSZ5jLO867B5xtpFKxGqs4M/YM115TcRi7jIebk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEhkTBNTinAPSSE+scH8agnS1ra5/cxO4ph0aJBb6GDD2Jas+E
	AgLjG7TCJcfviFhUe85GRdalV4ZcM7eurxyLqP1vx1u7ZUO7GyLYWCoIyC+OPRJsh9DE1vSr1Kd
	4lgPZRy1qYZyXEDCWGxWcqCTEHsNJ3vNwOXPSxgsfmNoia5QuinSsZ2+4Km6CX/Nz39Rcscj374
	Y=
X-Gm-Gg: ASbGncsarnmtOdq6XWazYt/sJszDy/8BIjRbuv/iGhm4096H2/84zgVJ+ksKmVroUpi
	ripu31wbJTX7cq8SAmu60T2TsVQlHG6H/IXu3iBG7e6kWBBUrfY5KPvRDv6lXN+2vTG5FAwDN2A
	0/6DxCFX7c9S2bccaThsm7OYsW/m2L77OMou6fRcKI8Z3HFF1S5g7Wt8ZBrDNupTn0hQZDokGMK
	xVQW39S3V9iQLav/7ga93tBz3d/JaJBl1hIgIjc0lHoS36g0Sl3MAXIGz2EixZ5QHKf2OAJsN0s
	37ZiqdIIZxCE/XAAM8Sp5qpseEe0raUQyGmduT8EjsBszcHVfUzNLv77oRDIO+hik/W7or3dsUY
	DjQUOuMdxb2rgUx45ng==
X-Received: by 2002:a05:620a:1010:b0:7e2:ee89:2059 with SMTP id af79cd13be357-7e62a161c98mr301780685a.4.1753357169375;
        Thu, 24 Jul 2025 04:39:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrXXj7nS41J4tzvt5vYVWROB7LrrdrXAgkyDwKGD/CaWyzImC+WopFcS+OfvIBt6ZwiO1KzA==
X-Received: by 2002:a05:620a:1010:b0:7e2:ee89:2059 with SMTP id af79cd13be357-7e62a161c98mr301778885a.4.1753357168938;
        Thu, 24 Jul 2025 04:39:28 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614cd31ac41sm703041a12.54.2025.07.24.04.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 04:39:28 -0700 (PDT)
Message-ID: <ae143353-b979-452a-be29-0c64fd90dfd0@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 13:39:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] drm/msm/a6xx: Poll additional DRV status
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-4-9347aa5bcbd6@oss.qualcomm.com>
 <9778efad-e9a8-4934-9b70-b0429bcfe63e@oss.qualcomm.com>
 <002eb889-87cb-4b8c-98fb-6826c6977868@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <002eb889-87cb-4b8c-98fb-6826c6977868@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G8UcE8k5 c=1 sm=1 tr=0 ts=68821b72 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=0a86huQbBvxycGr4qhYA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA4NyBTYWx0ZWRfX4KBhla2ZJHfx
 pr26HHqmkb9fxtaqkDuNAVKdKHoBB31sGYKbHEHJK3KAhqS1bUwFMJcDyVjgx+hOabnVYl0RYAR
 WZr1TOoFdN6FGh8DAtqUMGdWFwLTUaQWkhwPTPpbCXUpbcFNnAQLp3DXoXs3g+9vHeeTIK0T45f
 A4H+ua+aWeMiFe9wC0mkC7qRcYk1VSsAAVR+tiH6/Zb5H6+5W1JbrMd6vLHcQxMfp2A4o4pvj5v
 p9nSwxtxW5y9qTd2i6BZYo0vuAwpap3PIhJ/QplKiMr22BdSPxWmiJC4K5AhLMZMuxA40k/pPEu
 UD3YEMdGadJicEe+cygjWZVtVWX3z6/VJ+gF4Q6cyy7No8S337K2uTZ4wqrmyH5XITj5q1PLQYA
 x4ZV91PjJ0HEGROhiAN6ePTBxirT9LqGUaKpKyOW5zybOCyNmFa/WjceAZzPOQ7ZroXUS+IX
X-Proofpoint-GUID: bxCTIuSLmanzEMjvU8l5Uc21M6ag6DUL
X-Proofpoint-ORIG-GUID: bxCTIuSLmanzEMjvU8l5Uc21M6ag6DUL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240087

On 7/23/25 9:28 PM, Akhil P Oommen wrote:
> On 7/23/2025 3:31 PM, Konrad Dybcio wrote:
>> On 7/20/25 2:16 PM, Akhil P Oommen wrote:
>>> A7XX_GEN2 generation has additional TCS slots. Poll the respective
>>> DRV status registers before pm suspend.
>>>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---
>>>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>>> index 790ef2f94a0b0cd40433d7edb6a89e4f04408bf5..3bebb6dd7059782ceca29f2efd2acee24d3fc930 100644
>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>>> @@ -987,6 +987,22 @@ static void a6xx_gmu_rpmh_off(struct a6xx_gmu *gmu)
>>>  		val, (val & 1), 100, 10000);
>>>  	gmu_poll_timeout_rscc(gmu, REG_A6XX_RSCC_TCS3_DRV0_STATUS + seqmem_off,
>>>  		val, (val & 1), 100, 1000);
> 
> 1000us here is a typo and I copied the same mistake below. I will update
> all of these timeout values to a common 10000us in the next revision.
> 
>>> +
>>> +	if (!adreno_is_a740_family(adreno_gpu))
>>> +		return;
>>> +
>>> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS4_DRV0_STATUS + seqmem_off,
>>> +		val, (val & 1), 100, 10000);
>>> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS5_DRV0_STATUS + seqmem_off,
>>> +		val, (val & 1), 100, 10000);
>>> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS6_DRV0_STATUS + seqmem_off,
>>> +		val, (val & 1), 100, 10000);
>>> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS7_DRV0_STATUS + seqmem_off,
>>> +		val, (val & 1), 100, 1000);
>>> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS8_DRV0_STATUS + seqmem_off,
>>> +		val, (val & 1), 100, 10000);
>>> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS9_DRV0_STATUS + seqmem_off,
>>> +		val, (val & 1), 100, 1000);
>>
>> FWIW there are places downstream where it polls for 1 ms
>> (gen7_gmu_pwrctrl_suspend) / 2 ms (gen7_gmu_power_off) ms (as opposed
>> to 1 or 10 ms here), but the timeouts are all the same across registers
>> (unlike TCS3 and TCS9 above)
>>
>> Ultimately it's a timeout, so a value too big shouldn't matter, but
>> let's make sure the other threshold is ok
> 
> They are fine. We can try to reduce the timeout 2ms in a separate patch
> outside of this series.

Great, thanks for confirming!

Konrad

