Return-Path: <linux-kernel+bounces-899386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4958C579FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C124A21F1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE30B352942;
	Thu, 13 Nov 2025 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e6t/0V3j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VsvyTmhm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60752352941
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039443; cv=none; b=piPCvQa54GtvivROrDszcWb7ZAKjmCv2U37tF6YXpkVdeOaYor8s7d+2YolLa314SUSOPruEVUj2n0W/tbhi9GoXwqLLHtVDaQCTFy8Tl1f1wQOh4CjEAbyAduGbXy4S7zorY+jfXBXjcz6N0ZCMLw4nNyp6q3aPm/uba5lYa4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039443; c=relaxed/simple;
	bh=8kfWf5AV71bNUbNyq1hAQQ+knwZPGvXuTtRDrcAWJM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iH9aHIAKN69pWTboiZf73PUs8F+/+rCX9/ITbmsmLDbRFOE1D0PaGSHVYtKhMUVP6L40sNgAlxsHUEHtw4JlvKg3TfAXazaszwRDNwk6cKg/hsBg8dMusHKMbES5Hn8AbvU4GMfEgZq1LrnQo+U0q5YgFbQdzp/4oB2bXipBiQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e6t/0V3j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VsvyTmhm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD8xF4t2993483
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CZXY1ifhV8YPSwfeBFCqHJXWN9yVpsAT+ynQZq3WMfE=; b=e6t/0V3jRvOdUIEy
	YRTECo2K6P5WJYru25zm1auvl0mq3RCtZe/UIkecg0hG16qNXrdYsyIY9LZXIhhF
	vuxlvBXs0nZspcbsY/gitVt1xqTuCwzYsB7x6qdYII5p9fHL1LxRn+CSLIGfSXHr
	OOZB4RnyvDTNlxJD5zL0n1RV0NURlFwidrpfiWcPfRh0IEQOae6/u+gNFU/LzFnL
	Nng3Y5QtIikk08st4WV2moVIFE3kPUnp7SMIM73FuvwoDoVkFn1Xok6QB360OOex
	iT7gID2V3UWRd2FoEAxAbgWxHKfXaJ9vLCUs8vlNMj/Ive2zE1miA7cd9U0jnWdo
	0OPRsQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad47jj9qn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:10:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed6a906c52so2312381cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763039440; x=1763644240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZXY1ifhV8YPSwfeBFCqHJXWN9yVpsAT+ynQZq3WMfE=;
        b=VsvyTmhmnMmzIJfhgdrdkwMuZ0HG8bZOSOPbuAgx/Leb7klKGcY+hdh7v5VToGhJut
         MA4oxInxy0o78E5MD7bWNT2JFaPCYEq+P556dAfbAg5FwyTJV2yWgdTCntZxwEDF3jBd
         gf7iSkq8TBcb72pySPcCuAjHKAFnF/AWkGNqWUcx8x5P/GspqI7pscdkdTs2Wcfuygmg
         7KBNNPbIcyf/AC60cjQgEQUDj9c7SxK8WD/79oRE6Z2DjWHQaHm/deFLh9u7wFmRXMSk
         SAFsQaDq6QlBbW3R/pFN4qjwXHhrOi4v+XIb3FSwZ2skGlaqdn6HwIA4x8UsyaS2O+b6
         V6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763039440; x=1763644240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZXY1ifhV8YPSwfeBFCqHJXWN9yVpsAT+ynQZq3WMfE=;
        b=v1FD/CotIFOUwpJ+6ZoL8E4YWqAK5HYmsUCu2ZZuz/QG0oJXICcRkfn5OkQSi7g1Ku
         H8SUNlXJEQLRr93Q+4E0ZFAJJ9xP5vyDZfQdSJQj9MbcP8mgwMBCUfUOty/7TbuEnB2x
         IcnwvhAaJdjucZ2KD8++FU9rD+FCTmzcbyHrd2OLrHT4XaoOKdri1r0Ti1Owh5NChJ4c
         SqRly4GINdXSJvSsJDwnjimhHTioJuJZbPIlRvntTW+89npCyxlkkx7pAyS0l9Ylp2oj
         TkhtwCsHWThNluONvir+UcTbszl39qAXetUaNlVDYNwb9NMW/l22zOgTYJKlxgQDSW92
         9/pg==
X-Forwarded-Encrypted: i=1; AJvYcCXtvBRpTu0kl1aiV7BJHNHffOB9mg6YbD3LRjZbSvOWOdV1pHRAoPjwllek/GQYu21QDKdXjOfDM8+TE1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFYZ8zLegFgmd8+eOCdtLBTU5FUVFrUwYXWF6qUtoqg4vZvYCh
	d7nZ32Up5erFC7LbWHVHr+SD5peK/bCqEUsIJf3/Q4sfRkyO3VrqhxcNP1t+9ktTaFuXQy2mJEO
	9OHoZQgd3sjcyEevztIwckeqMV+u1mASMV6tM17wROi0JwNfPuZHXcw5qOwO2FCgxpUo=
X-Gm-Gg: ASbGncsImfWno5ZS+yCZWYO2wlihWqE469+hvzs4AiIXXHZaXJ4vhuy5suo6QHMJH7x
	Ck5ivhyO0oMeaOPcq1Lxnzci6mjUr2Ofvk5oTePIC6JdTk5dVQEbtO6+g4Eh/OG+yoD9YiMsJRN
	pRHL/CLBR1B4wP1Igi3ShIgAu1dDJ+ftfUqEvyuSVnRAV6VqiR47UDdSESanhPBaR3jKdHaPZtH
	650W/J/Rq0HaU8936k5AOSpGnajS3Rm45E+ocs0Keb4GTu7JlZeDo6cRPQQTS4Wv4hT+41kcuVI
	6RQaOYrKddM0zPODYSTYcCHGeKbO8T6hvne2j2/VfyscFAvtESFoew4VsRmvmhQRZJCBq5pXdGG
	rAs3/90obBlXx/xaDkZwIpgrS+vrL8h+2aDL9cnGzQvSoIBUySXREWWoD
X-Received: by 2002:a05:622a:1316:b0:4ed:b409:ca27 with SMTP id d75a77b69052e-4eddbd65605mr59626131cf.10.1763039440318;
        Thu, 13 Nov 2025 05:10:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESawNQFUeHeMbh5CviAuecEDsSSa2Db0tmz9JN9G7A61f/DAwZOVKGgRG2h1xYO5nZjtsMBA==
X-Received: by 2002:a05:622a:1316:b0:4ed:b409:ca27 with SMTP id d75a77b69052e-4eddbd65605mr59625541cf.10.1763039439747;
        Thu, 13 Nov 2025 05:10:39 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a4b28bbsm1396845a12.28.2025.11.13.05.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 05:10:39 -0800 (PST)
Message-ID: <f7e204ac-28b6-46a7-903d-30b7f31dff8b@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 14:10:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/21] drm/msm/a8xx: Add support for A8x GMU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
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
 <20251110-kaana-gpu-support-v2-10-bef18acd5e94@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-10-bef18acd5e94@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA5OSBTYWx0ZWRfXxBSUIuQKYrFD
 gTXcsLa3KXMpKolnQBvJuMYqa1o5FzrpAhyfuJj2/J9YGY4fbQODWgzWd+kbKFTsb4UtbBXs3E+
 ppx0W69rG/yY+3V8DGBMswb4FjHJD+8Rb4+t7geNFYCQ9XKyyJiXUCsPthPmSnoELCmgDXZCGna
 hLaExzTbelmQM7b29ajA9x/fx/Qodx0fd514t8o0xF0HG4wMiZhvtT3/2h3Ayvt3/2BS6gNblFG
 9FWg1gY4eBONN354Usx0SZcFGhlu1oirfQmFUwNNDRzNCBosfS45L0HyE6M2ch9m9lPzOgf+MZB
 SRJkVNXt14laRoGYpBztRCQOP69BHbd5S46WY6uly9Bhpia3ZLjC8ZR/BzVjCtHThiNO3UQ3vR6
 mKIGPlqQ5pKn4QWhWG2wW3Lpn+Y0Hw==
X-Proofpoint-GUID: MebBvV6T2sZMN-81G5HiKOSSgsGJc4Gv
X-Authority-Analysis: v=2.4 cv=A5Fh/qWG c=1 sm=1 tr=0 ts=6915d8d1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=XMd9o5LtjS6KuIBsTZQA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: MebBvV6T2sZMN-81G5HiKOSSgsGJc4Gv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130099

On 11/10/25 5:37 PM, Akhil P Oommen wrote:
> A8x GMU configuration are very similar to A7x. Unfortunately, there are
> minor shuffling in the register offsets in the GMU CX register region.
> Apart from that, there is a new HFI message support to pass table like
> data. This patch adds support for  perf table using this new HFI
> message.
> 
> Apart from that, there is a minor rework in a6xx_gmu_rpmh_arc_votes_init()
> to simplify handling of MxG to MxA fallback along with the additional
> calculations for the new dependency vote.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

>  	/* Make sure there are no outstanding RPMh votes */
> @@ -990,7 +1022,8 @@ static void a6xx_gmu_rpmh_off(struct a6xx_gmu *gmu)
>  	gmu_poll_timeout_rscc(gmu, REG_A6XX_RSCC_TCS3_DRV0_STATUS + seqmem_off,
>  		val, (val & 1), 100, 1000);
>  
> -	if (!adreno_is_a740_family(adreno_gpu))
> +
> +	if (!adreno_is_a740_family(adreno_gpu) && !adreno_is_a8xx(adreno_gpu))

stray double \n above

[...]

>  	/* Check to see if we are doing a cold or warm boot */
> -	if (adreno_is_a7xx(adreno_gpu)) {
> +	if (adreno_is_a7xx(adreno_gpu) || adreno_is_a8xx(adreno_gpu)) {
>  		status = a6xx_llc_read(a6xx_gpu, REG_A7XX_CX_MISC_TCM_RET_CNTL) == 1 ?

You skipped writing to this register above - can we count on it
always being in the right state?

Do we need to map VRB, or is that a topic for the future?

Konrad

