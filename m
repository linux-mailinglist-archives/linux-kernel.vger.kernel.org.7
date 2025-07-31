Return-Path: <linux-kernel+bounces-751921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75694B16F58
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DDC1783A1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030421F4616;
	Thu, 31 Jul 2025 10:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ptXNcbtm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5141746E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957181; cv=none; b=k245wXnBig7gbKguii0/7yPFQzUzrBhJRj/jQAmlLghqx6UUGsM/GYhVBUdOHXjVMl936HTLweoxMVs0fPpXmYdbpVhCU1vFrpTTlh+omHyTpqWlnFNvzsASa3eFa8ZvqWwB/7jgCtgjgcCaxZ9+9GKa/Hzc9kwEieBa+qK1Iqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957181; c=relaxed/simple;
	bh=dPZxHGiDDmJP2O5n4FEVepPTjbuvw2bfy82v/XA4SBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lwqhVgrp6tjwatlTMTMvbMsK7WkJiz7oIZrK5tdRZqjYHHoQJ/ZaxzJGxe4JDiWV+X6ESvm3a0RW/vanAoz0A3jOdZQlZ9p6fw3eyNkxj86R2dnGp3Pgo7nge7d0jCfr5JbqAUhBz5LUCqFM20FkzW4guK0lDjCpXCXvjkYBamw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ptXNcbtm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V9fQ4K008519
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gqP/D2mc8RmNlu9TpE5LUCbh7vx3tqZxEc4lxFUC8fM=; b=ptXNcbtm+uFqCgIr
	KbwxU6cwl7758BB/NFhsiopEmc1Tl8rGk3fQDYNV3ifl+UskRiMaJDv/i9nCmrUH
	rWmYZungI+4tH7ewQmuw3+ZHfsG9VxGjJsXWDkJ6SqhG/QyPJALZANk3ueBQwFqW
	Hjo4pfYOkMtEcIX6oOYSI2jlBUZdppqlhk00o3UlJVSqyZ7zwmx+UV1mQwMa7DrE
	8ihsj0DXQ1QuQ7tPEAaW3gVQwBJSZVn9CcH4+ARBxaNCP6mGWkW5khE58h1u3ln2
	h4WZsd88a88L6WL4wGSNEeHrNmoq/boYX+0VLCROGlMfEiH42uZFo27iTeBFnqoU
	mpPxmg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pbm76br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:19:38 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e686981baaso2836385a.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753957178; x=1754561978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gqP/D2mc8RmNlu9TpE5LUCbh7vx3tqZxEc4lxFUC8fM=;
        b=HJe0dW9+rTIKVfHMuW5y/BokhXnMp5dFhOR/nRyTt6apAII5tyKGibXsmpbDTLT+vl
         KgHe5bZkAwJyH4XgP0+CQc6pSfexfpH8h6A28wx3lpC64iAfkoUWiDUoA/pLlhM6B2Z0
         pijSCY04WXw7rtAHdMFJMZztSELoOwraOZUXCL5tkxaEYFHMkPC9xC9xLHQSWQMPvq1I
         UhQtuYl6OUOeiuxPTXgMqdvzvrSc4gtD79PGUsb+bWRPU7EoHB3SICSTR/3X4YhHrefD
         03nBxiPtJYsgtCQbUO5Y9jxeWoL50ovajQU8YJF0P603FzBlZ45cBf9NO3Z3JZ++9YMH
         WsaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWuWaDXPPXz30poddpmS71pN3vQnclynSSbCe5Q9+5oEWr8wlwoU5vo10k06x8Xe8P4j6jvulp59v7foc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4k8mya5CQoX5AWQkyHq9bJwJ1l57TxFusR6ZbLzFwRhq58urH
	FTeMyDCLiNK+OvmP1J/v5UowCzLOY7jnVv0nim7WBjZHhaRIWdsuGRSvFoOT+VhXJH+XgyvTJj+
	X40+vN+xi1aBD2pluKRzA6hZtcXOowaFKBZW7uAKOzxC41HyXfH0lmDPMeuYzxSHCGbU=
X-Gm-Gg: ASbGnctA1IYpcOinfr5ZYGQ0G+M/kisQNGJtpZ0Z7Ukf7RB+Pc55HoiFtckoxdsE8sQ
	ZO1ADqT+fdLxUojlv6PKel12XWXv0621NRQDR088ZV44cEMWu0xx5FJrZnoDwZEfQ4tIVINMQMX
	+HCRImZw/00WQXe7bDw9YxHpk6nh9VrR1sBte7UcY7bT7cjzJbOsUGY7q5xu3IudXbgs+Jwt1to
	ERLfi31LAplq5tIgsk7yUesFCDWCn3BjkhSZ2IL31UdXMS25Dk8dYSuWFjqaPW/X3N1LOCRL8ME
	JsJg5fSWz9F0X1opR2oah52s9cU+XuICh1ZTAXeOvnfcaZpryvothaSHK9GRqFfqroM/3JH7ctg
	GkdMGo+GWkOhLd0VUfg==
X-Received: by 2002:a05:620a:3908:b0:7d4:5cdc:81e2 with SMTP id af79cd13be357-7e66f372189mr499710685a.13.1753957177814;
        Thu, 31 Jul 2025 03:19:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxnVmrpW4543srRHthGrkNrWHw3gNj9WsEk2mKRTDtWtwh5cLKN5XiE5eDu2MaiRmkZuh3Fw==
X-Received: by 2002:a05:620a:3908:b0:7d4:5cdc:81e2 with SMTP id af79cd13be357-7e66f372189mr499707385a.13.1753957177212;
        Thu, 31 Jul 2025 03:19:37 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a2436c2sm84867466b.141.2025.07.31.03.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 03:19:36 -0700 (PDT)
Message-ID: <e7ddfe18-d2c7-4201-a271-81be7c814011@oss.qualcomm.com>
Date: Thu, 31 Jul 2025 12:19:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm: adreno: a6xx: enable GMU bandwidth voting for
 x1e80100 GPU
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250725-topic-x1e80100-gpu-bwvote-v2-1-58d2fbb6a127@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250725-topic-x1e80100-gpu-bwvote-v2-1-58d2fbb6a127@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LsaSymdc c=1 sm=1 tr=0 ts=688b433a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=1B6o04Z4kyHWbw-D5gsA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA2OSBTYWx0ZWRfXyw+RU9woQOWD
 dbQq5437A+ePbtOSCneUJedHpg7ArvyVxrkukSMLe3Hr05QI7G1b2K0/HPG4KIU7VfIzuqQgqJe
 pF3Nl3T6F0ZZ7+yZZwoWHCRJhXHaAkRobxjJUP9Y2rbNAjZBURqfFG8VOnjAOyew3eTT3d9JmcH
 +BSHjjkAhj375AOQikFG7gpP+GfXZfSvssInoFblV9NS4+ma56b976pMMKBhjAHKjLW9WWkuudn
 lRzrept0go5B5DtdiZzvJEG95x4lOcZVtDZlkJelN4VEnLGQ82p/r6sTU3fduraO9V+MytXRPjF
 kRHIy9pfiXoZs6jY90K/Mtst9WXbEL95Nna3itmJT9TkvuFFfroOVtTjdNNqqP5rTrgg4MT0Ch6
 /dcc7CN9dTDmpyMRckVQRf3aYmYPZjbNz9+xLXy34qJVboqdBLy9W9PQA7i1bIQXpormXKmI
X-Proofpoint-ORIG-GUID: l25zgVjal8-XGQsrZBakwX8HDCgkJwOG
X-Proofpoint-GUID: l25zgVjal8-XGQsrZBakwX8HDCgkJwOG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507310069

On 7/25/25 10:35 AM, Neil Armstrong wrote:
> The Adreno GPU Management Unit (GMU) can also scale DDR Bandwidth along
> the Frequency and Power Domain level, but by default we leave the
> OPP core scale the interconnect ddr path.
> 
> Declare the Bus Control Modules (BCMs) and the corresponding parameters
> in the GPU info struct to allow the GMU to vote for the bandwidth.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v2:
> - Used proper ACV perfmode bit/freq
> - Link to v1: https://lore.kernel.org/r/20250721-topic-x1e80100-gpu-bwvote-v1-1-946619b0f73a@linaro.org
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 00e1afd46b81546eec03e22cda9e9a604f6f3b60..892f98b1f2ae582268adebd758437ff60456cdd5 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -1440,6 +1440,17 @@ static const struct adreno_info a7xx_gpus[] = {
>  			.pwrup_reglist = &a7xx_pwrup_reglist,
>  			.gmu_chipid = 0x7050001,
>  			.gmu_cgc_mode = 0x00020202,
> +			.bcms = (const struct a6xx_bcm[]) {
> +				{ .name = "SH0", .buswidth = 16 },
> +				{ .name = "MC0", .buswidth = 4 },
> +				{
> +					.name = "ACV",
> +					.fixed = true,
> +					.perfmode = BIT(3),
> +					.perfmode_bw = 16500000,

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

