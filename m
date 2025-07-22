Return-Path: <linux-kernel+bounces-741468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D50DB0E47A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8231C27E70
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F4F285041;
	Tue, 22 Jul 2025 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OKqie+tW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B384B221297
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753214166; cv=none; b=FXbTOJ7qYnD8jniM9ef8v3x/pW/Wy+oIpaoVzHgAr6IVE9r5mXFjCuc1QR+7Rgb75e0nSZiJiU3jwDVcUfbIij1sHN3qBrdwNhAGkcnUgoHaM9TYGS5vd6kzSVTowDHz6Qiau0zFaRnwJzDYJspNc8scFe1upXF+9FHb3L5e+go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753214166; c=relaxed/simple;
	bh=PCihER/NBi1sl3yVYVgy3pgJILf9z9adFm0ghGHjbkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMAwyiMPmTJMAuHO7DZ4VfpN7U4346jry3kvGRJwSuI8yVgtLOAe8WuajaLsc2swHFRU/AWVEqXxemnE1yUNb3DxQmNAG0QHVw2bCvgGQzpT3yvaPzngFjMmSmOCqyXTkmTlNR7bigTuIoPE+CYT95BUIHZnYfJkpsprFb1PfzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OKqie+tW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MF1rVp010707
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GjTWvnObvG/UeJuKXHL9K9+ApIca33uxx+7EN7uxT/4=; b=OKqie+tWt99ZKEf8
	mAm/cX/RY8ADiZ3d49ZZhhZ5C76BICLa+fxEe2uT9OC6zM0Lm2Po8S8BxqByx7kS
	b780q1o0HyQBv5ayhLBW47cTHVXGkt4dXh0ZTTWmpS4u4H7FXmW5I2zolHBIWoZM
	X9LWlos02N+xOaumOQlS1BbYiBvI2mVxfhQfLC8fYn1FHaVW1A/guRX7VgX7cUoT
	1fU2PIgSKIoyaOBG+X1ygtz8YMV0ErNXxLNj8Oz+twJshpKBI+T6AatLG190oGdm
	9l1Acc4talfp7qKRwld2uG2GQ5WJf6lHRM+SjzTl7sXLILfTAaMs68dY2XE/x+UQ
	QDlToQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1a2rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:56:03 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74913385dd8so8358138b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753214162; x=1753818962;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GjTWvnObvG/UeJuKXHL9K9+ApIca33uxx+7EN7uxT/4=;
        b=UIury/iDx5tM4wd+YrUOOx2LD4qu3VRMOX+OWurBYKsJO+KNAU9UF0BgvIL8hT6Ui1
         /fdtJ7j/Yu1BBJ1DxOnP5NkO/bbsBCQq1vgeBq38O4J6HJgSFnABB4Y2F1k2fLC1xjtC
         KaVJArjIdihZdTQVZxB6gNx5PbA9Q0Uy01070eOZz+sRYoBKsa/5WxWSNxdzCvxEaXhG
         aTBI9FHoEhG4Y+m9ix/l4GTzgf/bbTHPQ4SqkBcdSEZw6PzxjoZVCfbWEYVr0bicVFZh
         n/nhxkMBYJAu5HFUmZzViEXzLKzN91QLcUdqBu0usr0ZWISEzRsZajn4CRAOaFYz7eWE
         GS6A==
X-Forwarded-Encrypted: i=1; AJvYcCVVYy4X3kN48VcQ7CQR18Gqx0b3P173nJa93yIfC1BVAE8AAi8tQtSY7+0Q9aB4RQVlLOs3hW/IuC2vwlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7bcoi37wlQEWM0c5BZt1lXhBBo1TQuVWghGmW0+W9UA8SUZwv
	6/tW9ucnLICJ8gZmlZy7tp3rvPkKr4Go88xUxcTgWRk2z1Vu7CIUi6GoQQmb8h0T06xPfbzU6m8
	fqT40d5cM6EfVG3AyxTIMM9zJEdDJkdvo1aKs4nXHwneKM9DHl1UfiM4M/VzSCw5WfWs=
X-Gm-Gg: ASbGncvJyrrrcELRXd2XIxFdxG16By1+NjLC2qPNHkmeTALJ3Rp8MmgAhaG1DYC5rlj
	Z36D8bbOsYe3pmN09HheeX0oCgj1t0Qlw405DyLDRb6LQGmOOOeZKMRw1UK7DSp8qfksGsnXclw
	n7uxiEFFHhnjFUdLgodu2SDUeLenO+9trQxCLjSqwi7sOF2d34rBSgnDSAscM9zvcOqpxTZ3W6U
	egVL5YCv26GCpnJLkGJosD1t7yCVctJDDWHMr3fuvIrwVoSq5L7CwfJXFQEAC+XUpXT5KCVEsom
	wPbYRuqqXVm0ztjbzAuz9lg5Cwg5L9p/3ntvPM6O6Blr6W0UVqzNnyYwWbVWjJI8
X-Received: by 2002:a05:6a00:92a7:b0:736:31cf:2590 with SMTP id d2e1a72fcca58-760353f2759mr687681b3a.16.1753214162216;
        Tue, 22 Jul 2025 12:56:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJK019g6DqECaNDbpD0Yvmal8JjGmdWP1kCx05y6YQEB+NqSgr5xgmvBvu9sxGV/5wQFRvhg==
X-Received: by 2002:a05:6a00:92a7:b0:736:31cf:2590 with SMTP id d2e1a72fcca58-760353f2759mr687654b3a.16.1753214161634;
        Tue, 22 Jul 2025 12:56:01 -0700 (PDT)
Received: from [192.168.1.4] ([106.222.235.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbc680absm8266052b3a.144.2025.07.22.12.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 12:56:01 -0700 (PDT)
Message-ID: <1b7817eb-6d54-4ed0-9ab3-d5b521d5bf6d@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 01:25:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] drm/msm/a6xx: Poll additional DRV status
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-4-9347aa5bcbd6@oss.qualcomm.com>
 <shq6rnj5qrw52xvtcnu3bbvxuxjuddzajugawcojdyrm74fpp6@abeztbbmtqnr>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <shq6rnj5qrw52xvtcnu3bbvxuxjuddzajugawcojdyrm74fpp6@abeztbbmtqnr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4NMhMI7EUHq47BVRVrfTqcvqqhGAvbNR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE3MCBTYWx0ZWRfX404krhkJ5fWV
 DDuBaCmdTgO2znv5ib36hDpg/wGqXsDt6vuEqB7AAkD/NFCzgnqvLL+NTSbNuABE15fRxxLM98E
 JSS2TpP1KYj2SKFpurweURR5nOls1U4Cc4aEXHQ3AXGHJm/fwyBn2/LWFhZYNzeV6aPWI435/g0
 MXyGsqEZUgdcFuOPZK9fKoT7Wu1RQV2smX9sb6NTKmEYuIMRJ0d4U1OzHV4l+JJ2yF1SUYaJaAE
 bp8HnJLJrp+0n51mHhW5MhyH1M86YCYeIdWTkzWPRI9nuC5iILKp+xAiCy0AxP0Xcrc4HYXVPhQ
 q5WKnDW1CvS8b1OvFN9xg6R/Dctq+0B7tr5ZH57HziMcvE4tTbUjflYYoyMX/57DoHRjiaZflNn
 /sk2Rk832sREjJ0yU0Uvz+HVQRuhaFyoxyqyFHnok72COmVr2pOw0dQ4M/+x3TOoJ+O2CKDO
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=687fecd3 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=4dphQItTPUswyQvINXrzgA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=TSBj-XRfAaQ4HSZEJ1QA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: 4NMhMI7EUHq47BVRVrfTqcvqqhGAvbNR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220170

On 7/22/2025 7:01 PM, Dmitry Baryshkov wrote:
> On Sun, Jul 20, 2025 at 05:46:05PM +0530, Akhil P Oommen wrote:
>> A7XX_GEN2 generation has additional TCS slots. Poll the respective
>> DRV status registers before pm suspend.
>>
> 
> Fixes?

Ack. Will add the tag. It is good to ensure there are no outstanding votes.

-Akhil

> 
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> index 790ef2f94a0b0cd40433d7edb6a89e4f04408bf5..3bebb6dd7059782ceca29f2efd2acee24d3fc930 100644
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
>>  }
>>  
>>  /* Force the GMU off in case it isn't responsive */
>>
>> -- 
>> 2.50.1
>>
> 


