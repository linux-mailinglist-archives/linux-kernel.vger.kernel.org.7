Return-Path: <linux-kernel+bounces-806392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D6CB49617
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F83A163D7A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E62305946;
	Mon,  8 Sep 2025 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OWoo2BWm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF36A131E2D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350163; cv=none; b=atDbwPWaLTnIatIeqdr1ibEgvuoWbjASeHyFu9zGH3SwFsgI1dSJkOxDpqrrl5PWUpR9i62Rsj+L9jQzHjr8wUUHL6+3+0U9QuLTlRXZ54QzBtgILbyqSskj5bStdyM29PJYTWChw3qRF9sa9oiTfN5WsP4L8qtK9003hldnxzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350163; c=relaxed/simple;
	bh=c03Lsp9g+s3ZUQfrxI50tf7mrulwncy6J8ERz/IJdF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axcQS3YLyWDds8jDSyg96ROPE49MryANw22c061idF5hIEIp7z6VtRb9JaZirEaL774ujqCjrHe2v8wlg4s1WO9mK+Tdn1vHLelT30GCvXMN3faiHHnZmrSOaYEtfDl0slOH6Iyi8TzGo0dNA5hXfynEbBJV6X90t8FFpkE2se8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OWoo2BWm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588GGONf022660
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 16:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TOMlKuJgvjAl2wbNgrUtIbyGV3gXkbep4YDrso3Os/g=; b=OWoo2BWmjx+yIUc3
	MO5SzcHPNtwZdQIA8PCIKO31LNgsMDkQ1hdhc78d0xge96cYO4rpl5obdVFtZkAW
	tkeicnfjZetwGtMsSCHOGYPADaK07E3uVm4olike16TqV6tDnmwb8Z0H29+ioEeU
	uoWRbO20+wV2U4243ZCYAVaqgVQBvcJaQlKENVRioPNRJUD49vixeQ5ITQlLZXdv
	F72Mq4WYV3ZIi2vMZqZV7EDF287CTKcqIWpni+jE+vzrdyFxQdi33i2tFLy+M+tC
	b5sxGIy2Rytfr0cIVI/Sp2G6oxTlv1yeVcdX+VDYLnlMSc8dQXF/XqtKjLNA6Z0O
	zUEeQQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc21apc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 16:49:20 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77278d3789cso10119093b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757350159; x=1757954959;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOMlKuJgvjAl2wbNgrUtIbyGV3gXkbep4YDrso3Os/g=;
        b=iiJZhhCrdfp526BbqQXYRswERg6jy60JssWh+i0Q9M0/IRXNuG7lxeIRSjFcJP6172
         5CzCrRbljGG40y9lTPhYzZt1uR1WI8K0fchZBNavJSz2t+9B68qGTzUpNawxaBohMSt0
         IuhVam1bkq1PGsiTreF1Wg1FcsIHLjv2qa/6FVdQtoYrcT5DcF3Wxu2K7QINupzB2Kii
         JMVVNes7f+Xj/j17e3FWL5ObCsvCiFGMy748Bi27/P4nwrwEszKpyFFOrmvno+0IOXgS
         wFePXXkzGP4nhgBAsfJx6PkUcLBSou5dK3WK69KkCwamsdH1+rbWf6luuYyuW7Th+aFC
         qK2w==
X-Forwarded-Encrypted: i=1; AJvYcCVyNtdUgcOCrHFakqfM/jZpKjAnp3yzHRb/s56pK9UPJeVf2K0BEbIOnULFCA8ROqvPqiXVCqfKXVqfdaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyeZxdfju56O6MEDUTl4maKuzAEO0WLyDEdRFSUhyz5F/4P8ci
	ICXnEV77HN45K1IWn1feqzeUOKwh2zfkFeHNGnGSNHkFjXf6mbbwj07SQjywCtuxmot3nXxsStk
	XljARqmcUp6NSa9j8p6Q75hKpGZv+83qbpVDjunZU2G1Q2GJyMS5fiq1gj6CA6rHwzXA=
X-Gm-Gg: ASbGncuqcYAS//hA7dI0KgCxDnjLCAOJb7bZyDd2gUkyFFoaWvnQLB4ATHZYAQmqBj8
	rvduu2Ec6beW/0UgFbNjUAtWr+kZII+7jTrpRFNoAdcHX4wj7hkuEjcL05VpEWjjEdz0yoH2eXJ
	Z1BcZKDkxf+XODckS9g8aHg47AcoGE7s0ul8f5VeuwtBgBEqfcpWtsNSRIUx/D0m2hbSDuz/DV8
	pGNNswXFZ72ZHWmQwMqeLDqkxJTSY29I6hZGG713Wqz4vl2A8vfRtVOIG7c8KONpBcLSnIazl8l
	q7sMZH508GJzeSOL7Zi57Lfod6ya5ZRzI6/ydNmGt33o+KahjH9cVZ9/dxWvOA==
X-Received: by 2002:a05:6a20:72a2:b0:243:d1bd:fbbb with SMTP id adf61e73a8af0-2534775a1e6mr13236800637.59.1757350159289;
        Mon, 08 Sep 2025 09:49:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1It0dv5BR9m68fGngu0EK/yeg+C603sZAq9ZhSJtilPcPbfpfhlLXJ7uaZ1TlMyG2wUj1rw==
X-Received: by 2002:a05:6a20:72a2:b0:243:d1bd:fbbb with SMTP id adf61e73a8af0-2534775a1e6mr13236761637.59.1757350158859;
        Mon, 08 Sep 2025 09:49:18 -0700 (PDT)
Received: from [10.91.118.43] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e5b44sm29578565b3a.88.2025.09.08.09.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 09:49:18 -0700 (PDT)
Message-ID: <dc2ce606-52e3-4ffa-87f3-ce4c42b055c4@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 22:19:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] drm/msm/a6xx: Poll additional DRV status
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250908-ifpc-support-v2-0-631b1080bf91@oss.qualcomm.com>
 <20250908-ifpc-support-v2-3-631b1080bf91@oss.qualcomm.com>
 <77cfd9d7-c3f1-4e0b-8cf4-8567611c3a9d@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <77cfd9d7-c3f1-4e0b-8cf4-8567611c3a9d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68bf0910 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=MmCsC9iFmiawHEAYgzAA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: o5YN_apS84RIQZXfPSmPsx7NZ5XRQiZb
X-Proofpoint-GUID: o5YN_apS84RIQZXfPSmPsx7NZ5XRQiZb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfXzRfNAc+Tw4y1
 NICVRkz8cDBr2sSIWk8TmPkAvjMcwDyc5tyAfGzzhBgEVFzydlRt1YJTZXdR2zHuGiBjorgct8+
 90PWm4NUnwcTeS5WzcT04XcqXXv7o3LTTUe6oZzqwBu9erMBwhQmJfWoYhPJL9uyf5YmPR1MrzC
 jMdbGluW2pdxZAw2rVcoZgSzgsaYlheMzN1Q0GcG0Pl2Bk+IouNHmi490/7OzRox2lXAa388xD7
 Ao7Cl3Oi/yQzpyLhuO+wn7Hc4ysLrMh2+dksdCGo3N3cQrdMF7Bryh7sZWn1CElqFYLrCkJUj9o
 lyc8R2wkwp6KXxgWc3+RywhHgBC7ffeLiRZ9ZGBW0EClCscUIGqGd1+xRGvMN3mH6EsVQLnoPpa
 v/bbmdTu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094

On 9/8/2025 8:48 PM, Konrad Dybcio wrote:
> On 9/8/25 10:26 AM, Akhil P Oommen wrote:
>> A7XX_GEN2 generation has additional TCS slots. Poll the respective
>> DRV status registers before pm suspend.
>>
>> Fixes: 1f8c29e80066 ("drm/msm/a6xx: Add A740 support")
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> index bb30b11175737e04d4bfd6bfa5470d6365c520fa..06870f6596a7cb045deecaff3c95fba32ee84d52 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> @@ -987,6 +987,22 @@ static void a6xx_gmu_rpmh_off(struct a6xx_gmu *gmu)
>>  		val, (val & 1), 100, 10000);
>>  	gmu_poll_timeout_rscc(gmu, REG_A6XX_RSCC_TCS3_DRV0_STATUS + seqmem_off,
>>  		val, (val & 1), 100, 1000);
>> +
>> +	if (!adreno_is_a740_family(adreno_gpu))
>> +		return;
>> +
>> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS4_DRV0_STATUS + seqmem_off,
>> +		val, (val & 1), 100, 10000);
>> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS5_DRV0_STATUS + seqmem_off,
>> +		val, (val & 1), 100, 10000);
>> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS6_DRV0_STATUS + seqmem_off,
>> +		val, (val & 1), 100, 10000);
>> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS7_DRV0_STATUS + seqmem_off,
>> +		val, (val & 1), 100, 1000);
>> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS8_DRV0_STATUS + seqmem_off,
>> +		val, (val & 1), 100, 10000);
>> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS9_DRV0_STATUS + seqmem_off,
>> +		val, (val & 1), 100, 1000);
> 
> https://lore.kernel.org/linux-arm-msm/002eb889-87cb-4b8c-98fb-6826c6977868@oss.qualcomm.com/

I missed the timeout value update. It is not bad since we already have
the same value for TCS3 above. Will fix them all separately.

-Akhil.

> 
> Konrad


