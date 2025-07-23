Return-Path: <linux-kernel+bounces-742246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55042B0EF1E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E5777ADC7B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7276E28E607;
	Wed, 23 Jul 2025 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="do/DoECD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CE228EC1C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264874; cv=none; b=foAI9I/oqe8M/GTgK6E3bHLn86NbIFYAHW+FW8KmszM+z9EPPRav+mJv/dPLrrNuX1Lzk1V7zvYbXM0cL/kUDxXtn/AwjEJveJ51mSofcsn1ZcXMggp9n9nimvaNNhtzRf7EKZRLZAlriwQvb+VtSy+1L1AmwtakssRYQBdRdho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264874; c=relaxed/simple;
	bh=UGP7plI1e6RwgsK0AHdr/vFkp8nIE0bKVNJ9KqHkh7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+qIjwxQVWeLBDkQAZh6wbxy2ushlAw/+kbbL/PUafeMhMhLnfLV+5T/phF3as7CGZW948Wj4mS5mO6R0xMaYwjz8z2GY3K62OS/NXGlNChYdGDh16r5ExnIMqJb8G77+LeYi1KP5NZuvxuWDdMgyF2pTwLKG/qeyO6UE1z4eyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=do/DoECD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N97svt009438
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	02eNwnQSdZOrbqRzgnYfd2i6lrz8eYPVvEuITuHkMEA=; b=do/DoECDOeN90vpB
	KzWf4ibiN6N8XYYoDuyxMYCU5SUsmJVZcS3mPpqQsslsJjjplu5j8q7IRQBnT60P
	KOYIIKqpdpGL6d2hg71FmLCmxC7463Sstr1BHNgmXoQHZlfGLW3Rxf1KZ2ophO+2
	47olr6vATftjGZWXDIsUtTNNCu+qknvwkxbfm6YLpY1aEAjJkbX7mLhjp4DtDUZR
	mTKz2f96lME6KjCHSlkO+Yi7OqICekdFpbhIR2GlcvHPllDazIOBNM4zkCM9Hx1w
	2UZg9XUSGubuX1zWLjrykqkdTf9Z3cYBZHbNNTS7BEUs6XlCFuKBo3+6bUs9/q8O
	mwCCuw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804na33xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:01:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7deca3ef277so26075385a.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753264870; x=1753869670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02eNwnQSdZOrbqRzgnYfd2i6lrz8eYPVvEuITuHkMEA=;
        b=u8bjm8v58Vrf41jidKAnF8cI2Eg2E2fOF9P9pd4QJerLJG8M5qsqBrAtWbU418AUdQ
         BIVAyxe6EP4VevR5ch0wmGxnkxA8GE3uXnW+fE40Rpwm7lzGYX5UEApDG+Eq1Z3XR7+d
         bV315eAkQ858Orc7g/cjq3tDnyTuxD6Y4Dsz/t9jF3BW1wKhMEQFoW9WXTx+Rlea6gmJ
         eEheVnjs7puvChBFIvOBP9AEfF7jiX4S2ewGPYC90SF0kUdOjtxVfQweVGbh7Ao6p+SD
         JicRHAl3IK9oL8/Y0LAYbTMl4UGUgGVMDqz+sRug/q60TFmuCJIVkLY94WxsgZnLIIWS
         Fwvg==
X-Forwarded-Encrypted: i=1; AJvYcCXie6Z29RXFlxiy2kthQiESvPRD7ODdG/QYH2jhmCyYWsdZt3AiBy7fZRhYZDSxa0vvqUF/rynBIFJyB/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Er09zKzE4EcnbQKn/wCSEwtvAzfEEV+Ep3ueV9RHx+7/23Gp
	lin5VkcBp1mnJ4NCoaMs3+w23NibPaRM9wGkVIGlIzZO8zrP7BLEY598fYZIZl2kurULTXr5hbH
	ZTPYCbesaDnmxn/BeWR3jOXFpcx4rCFr18pwGAVqDFzIOuZ9KPtR9OXI0xCT5atigsTE=
X-Gm-Gg: ASbGncueeihKiMhPrLydB7dRw+NuF1i8MgGJFv9Jjg7aGcNj415a5zDvrV36agj9rLp
	Q0xKGZwJTVbKhnhfa3TIExQ2oXfNADoGvlwX4GhjtaDz/Sa7f4Fc4CoZLVz7zylSIE3pZJQYnjq
	LTVKJec8W+YkxtGsAzH1rQtJLSkzjhKngwbCIOJJFCcyeXoQjze5nWqJ085kX49fac2zT0YapUp
	DVyqr7GeqgqN42QKLL/6RoYxJAPrJxlwh0LmACkpH0Tw2VwQW32EWJPsWr0qr0jrvrfVNcklUdC
	1jfVxBOxrTWWaReCmDx4N2fvjCbWFVNKqjyyoYV6oPYMd/Z7t8/b91NGi2/AZT9zuB7hfzKk+Di
	hoBnIiqndHwgpZ+TQlQ==
X-Received: by 2002:a05:620a:9633:b0:7e3:3029:44c with SMTP id af79cd13be357-7e62a112c00mr102519985a.7.1753264869960;
        Wed, 23 Jul 2025 03:01:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpCoJV9xj9Gc/I7a8P3qXIdiRSdG1vduKGp1cHjyO1PBWiyVBdxvbjxKAxdAdhWKfRMhgQ7A==
X-Received: by 2002:a05:620a:9633:b0:7e3:3029:44c with SMTP id af79cd13be357-7e62a112c00mr102517085a.7.1753264869322;
        Wed, 23 Jul 2025 03:01:09 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca3005bsm1020602266b.88.2025.07.23.03.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 03:01:08 -0700 (PDT)
Message-ID: <9778efad-e9a8-4934-9b70-b0429bcfe63e@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 12:01:06 +0200
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250720-ifpc-support-v1-4-9347aa5bcbd6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HWWPFQnGp-nBCsye_Fh5_CmjEkbgawKr
X-Proofpoint-ORIG-GUID: HWWPFQnGp-nBCsye_Fh5_CmjEkbgawKr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA4NCBTYWx0ZWRfX0G911oklSP6g
 j/TOM8uoNzvzph2KtBiCpx7Oi7ouDzSo9ufo76/yTgeRjttr+xDolrSvWGHocg6nQr3/HJYrftO
 rhSA+0DOXRPPwgMqUGixlJDPY3FcMTy54tX43OTpCw3xzXoyt6lfjDE+do4fEzS37abuWt75Tgx
 3eChNJa3aouwX0hdOQ1T7l4wEwVacwPrZcTOVAnBGjF1hqkGg7vg+pYCdP2/ZpuqTtbSdN9hyt5
 ZewCWchA1LOZBjX6ecS5SQhNhDYWGcdaiJdbh0pH4U0j9+iMDwI2/E+bcfZlS0Ta9zDzVQUgsI6
 HAimKDwtCMwggbbZSXiziPCSW2Cb3dw7oWCp3IGAnD39Wne67WKgjgcFmrTWiCNhVMHEq1KmUbt
 Bj3qb8fpGm5gx0C2Zyn35hGo9GF4rrWv+O7cnoojODDz4mFinEB2ffvE2rwzNm3UvpsdXZT+
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=6880b2e7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=45tQodLAf9T1fsO_g0QA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230084

On 7/20/25 2:16 PM, Akhil P Oommen wrote:
> A7XX_GEN2 generation has additional TCS slots. Poll the respective
> DRV status registers before pm suspend.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 790ef2f94a0b0cd40433d7edb6a89e4f04408bf5..3bebb6dd7059782ceca29f2efd2acee24d3fc930 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -987,6 +987,22 @@ static void a6xx_gmu_rpmh_off(struct a6xx_gmu *gmu)
>  		val, (val & 1), 100, 10000);
>  	gmu_poll_timeout_rscc(gmu, REG_A6XX_RSCC_TCS3_DRV0_STATUS + seqmem_off,
>  		val, (val & 1), 100, 1000);
> +
> +	if (!adreno_is_a740_family(adreno_gpu))
> +		return;
> +
> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS4_DRV0_STATUS + seqmem_off,
> +		val, (val & 1), 100, 10000);
> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS5_DRV0_STATUS + seqmem_off,
> +		val, (val & 1), 100, 10000);
> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS6_DRV0_STATUS + seqmem_off,
> +		val, (val & 1), 100, 10000);
> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS7_DRV0_STATUS + seqmem_off,
> +		val, (val & 1), 100, 1000);
> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS8_DRV0_STATUS + seqmem_off,
> +		val, (val & 1), 100, 10000);
> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS9_DRV0_STATUS + seqmem_off,
> +		val, (val & 1), 100, 1000);

FWIW there are places downstream where it polls for 1 ms
(gen7_gmu_pwrctrl_suspend) / 2 ms (gen7_gmu_power_off) ms (as opposed
to 1 or 10 ms here), but the timeouts are all the same across registers
(unlike TCS3 and TCS9 above)

Ultimately it's a timeout, so a value too big shouldn't matter, but
let's make sure the other threshold is ok

Konrad

