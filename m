Return-Path: <linux-kernel+bounces-801486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92314B4459F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49345A00F2F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B079D3112DF;
	Thu,  4 Sep 2025 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pUKuYwzv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03352FDC26
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757011160; cv=none; b=I+cl6CYPOmMT6RLh7ji/2QfP7gn05g2F5slYYErs+aGcUaMEPtlDkbpnQByTBZVCDewsH9kfAM4XrBieH21uhvJ4h4oMLz1zesnUw3pbo7g0i6oi+RI3lv3XQmKdJFmoNkFn6R+WEMChIQEnqfbaEch+9/j3FIhjBepSAV0+hSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757011160; c=relaxed/simple;
	bh=8/MK1xQAeLBWcNZwrwLd8CntYlqvCN0pwOtNjjpT6ZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGyL9If4euXMfyhWgrI0KoM7Ylf7V5vYAfRWR1cPEJx4s4EFCZw4DzANr9/9hMjynNSIIQIteSLn8a25VOHLbui0KhNuv+qFxp6CYeF7/kjB/85PZvHXl2fMgP89xWihbNln4OSt1OrwlqrSZPIeBQSNW5sUyeVs6cOTw9IhxzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pUKuYwzv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X9NI022185
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 18:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nn1s1cmBrSFFysEaJTYBo/i8fM15yQYFa7TnS6bqPa8=; b=pUKuYwzvgy5mPAG1
	g47p4h4g7JfiSoMpdvi8U/i/P8t1Fm2QeKguuxHSm1Ap9c5xRQTOaOTTK2WG/g89
	b6vgaT7PJDl9PQVv4hJV019kB5+94eAF8iWIO59/I6bLKac8RM76rGMPbvupprAe
	xDuRSeTTd4niCrn+FPuwv/sHsXKpxQgf10xgpdFICh90LUF3a+zcBNDTNirem8Yn
	/tL2NfQ8QllvIsjRO5vk7IW/fVzhSeJGA3SJO4j7AWHdQdyeIcK/GoNSJ+LYjHRB
	j+tlH23jH4nbX53XUUAET2u+kG62cjPkcVpU3OMbj9QHqEKyR6xWO3hYQpkOfqqO
	fcKS6Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk98cn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 18:39:16 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24458345f5dso17184345ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 11:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757011156; x=1757615956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nn1s1cmBrSFFysEaJTYBo/i8fM15yQYFa7TnS6bqPa8=;
        b=Nk6Gsa647cSyJ4wr+aofhBoYVy3Mb1fO+ln4jlEMl+wfNZS8SyzXKCPmgU0tp8KVVU
         A8SegmgjvDQqhPq7qx8C9mBZt1m5krorR2HFfvz5i4HM1V8uZiI9EKDM+wEAz44myz4q
         OCnm71HycybioXGUh584YgtAgmDPNkCxtkwIR2emAoJPuy+b7IeXS/UNbhhVs77PrR7y
         qIjR/sx/6C+cjy3R466NGcdR9LSsI9ivX7hoOI8F/sn40ZA0nRvJfuli1MVUo6UX+xtS
         JQ+XfvyeglNDZGoamRUk7g5Hw8ERId6k9ChJWr9gjTKVTH7Du5ppaimebV/5dXclWrmO
         cz/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5U4ZcJdmiSOR1PcHa373F5T5tXpLz/HU+eVKZRpKDMJFfDye52qo3NFj7mOI7wYtKr03yurHAvDfppoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsEkSD66IbKNtjXK8GrSJVoyCHMIu5AUP+4KpOxOexgAOQS7We
	jSR/G2+tw/ie4Adfu9k3jwAQjZJ5YJgoEyOEQdlyMJKvfGMn5IvQsfJiQh7OKi7MZ3jzxYFw0cu
	Ft+LiUdTud6sLPc1DOdctgXnaCjX6+qvRNy9rBjRb47nu+jcBkCrSQ+7IF2gKi9nVbDI=
X-Gm-Gg: ASbGncvsjHjGnLzsJictl80yQtsA5m6eNHJ0wJ1eVKGhaUadS/e3zg8QqfJjWMLMeI5
	C2rMxqhYSi2go2Vgs4+LnKBDZi1u7ChVbIK5n0j+SLK5nMQmB9KnW3v1k/L4KN2C4VD1rXPZXyz
	bY5mQehHFx6HcFsbZSRTMHyVKxz9+Q97R9x51yaz1TCjKCzG+sPuNLn2m4tZ2t5azAG4djaRHmT
	Ew6mTVz2ma7YS5MP8WhlK5fXt7LtpPHjKx9Cwme0uCNls9w7sg+d8EAXaV9jBF8dIhjZDPsEM10
	b8baoQsT6VbMD0t1tRCg1znXmhnlN4NB5WOrRJQ3BQkNgM8W77lXG5ugmBWjhkBVV4/eLq0KYxN
	61/FSqMjTj94THYJNUyY21w==
X-Received: by 2002:a17:903:2343:b0:24c:9c5c:30b7 with SMTP id d9443c01a7336-24c9c5c318amr78060525ad.47.1757011155840;
        Thu, 04 Sep 2025 11:39:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGt8vlrmccO/zKDOpTjvGT8zqU0R03/eoM8Qk0vuGXWCzN2nGB8EZel9xPgSfcY7c/FvHbGw==
X-Received: by 2002:a17:903:2343:b0:24c:9c5c:30b7 with SMTP id d9443c01a7336-24c9c5c318amr78060015ad.47.1757011155125;
        Thu, 04 Sep 2025 11:39:15 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9304b7eesm50520415ad.102.2025.09.04.11.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 11:39:14 -0700 (PDT)
Message-ID: <d312c946-38e1-4ab1-b038-19239d10720a@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 11:39:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/msm/disp: set num_planes to 1 for interleaved
 YUV formats
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250705-dpu-formats-v1-0-40f0bb31b8c8@oss.qualcomm.com>
 <20250705-dpu-formats-v1-1-40f0bb31b8c8@oss.qualcomm.com>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <20250705-dpu-formats-v1-1-40f0bb31b8c8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QRsv8tnVexeN49FWVPjH2ZLsv0_VbEWc
X-Proofpoint-ORIG-GUID: QRsv8tnVexeN49FWVPjH2ZLsv0_VbEWc
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b9dcd4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=k66G2MeTsQAVc7QBSiAA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfXx5BjvW8ELvRA
 KdBBRrsYxQ/AE9itcpzbFDR4bFeOhwfjWRX445wji7MmTczM6+cHeNrorZKBuH8jZeyvcI9GItE
 upMOLIZn3/lXJd3ScnesBahmPo9Tum0sTrkZydYYfNQQTNfkQ7j+xNUxcnIeP2mnFoNXjUUjV7J
 yCY6f2bCOLn//8FduPU9luJfR8ES9HfuhUYuN9BF+bBshSj1BrCCyd1OvltO5PfMDj6sZi0rtY8
 mwYqEtQSoO3PBZtu2Z/Vrylvr09HE/m4YlV4MGwhUsg8DnSchA14rEZt2eGBaMbjq2FqYMLYmGc
 5y6e9xVZ3Iih9hpmHAhaDL0gsqcC5O1IAsCuOzzWktXzsVHdWVaqrmsqIl8PRNuNKe4DgNj6uff
 Csg1sR5i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042



On 7/4/2025 7:47 PM, Dmitry Baryshkov wrote:
> Interleaved YUV formats use only one plane for all pixel data. Specify
> num_planes = 1 for those formats. This was left unnoticed since
> _dpu_format_populate_plane_sizes_linear() overrides layout->num_planes.
> 
> Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>

> ---
>   drivers/gpu/drm/msm/disp/mdp_format.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp_format.c b/drivers/gpu/drm/msm/disp/mdp_format.c
> index 426782d50cb49d57a0db0cff3a4bb50c5a0b3d1a..eebedb1a2636e76996cf82847b7d391cb67b0941 100644
> --- a/drivers/gpu/drm/msm/disp/mdp_format.c
> +++ b/drivers/gpu/drm/msm/disp/mdp_format.c
> @@ -479,25 +479,25 @@ static const struct msm_format mdp_formats[] = {
>   		0, BPC8, BPC8, BPC8,
>   		C2_R_Cr, C0_G_Y, C1_B_Cb, C0_G_Y,
>   		false, CHROMA_H2V1, 4, 2, MSM_FORMAT_FLAG_YUV,
> -		MDP_FETCH_LINEAR, 2),
> +		MDP_FETCH_LINEAR, 1),
>   
>   	INTERLEAVED_YUV_FMT(UYVY,
>   		0, BPC8, BPC8, BPC8,
>   		C1_B_Cb, C0_G_Y, C2_R_Cr, C0_G_Y,
>   		false, CHROMA_H2V1, 4, 2, MSM_FORMAT_FLAG_YUV,
> -		MDP_FETCH_LINEAR, 2),
> +		MDP_FETCH_LINEAR, 1),
>   
>   	INTERLEAVED_YUV_FMT(YUYV,
>   		0, BPC8, BPC8, BPC8,
>   		C0_G_Y, C1_B_Cb, C0_G_Y, C2_R_Cr,
>   		false, CHROMA_H2V1, 4, 2, MSM_FORMAT_FLAG_YUV,
> -		MDP_FETCH_LINEAR, 2),
> +		MDP_FETCH_LINEAR, 1),
>   
>   	INTERLEAVED_YUV_FMT(YVYU,
>   		0, BPC8, BPC8, BPC8,
>   		C0_G_Y, C2_R_Cr, C0_G_Y, C1_B_Cb,
>   		false, CHROMA_H2V1, 4, 2, MSM_FORMAT_FLAG_YUV,
> -		MDP_FETCH_LINEAR, 2),
> +		MDP_FETCH_LINEAR, 1),
>   
>   	/* 3 plane YUV */
>   	PLANAR_YUV_FMT(YUV420,
> 


