Return-Path: <linux-kernel+bounces-821130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BB0B80833
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA12621476
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF053397EF;
	Wed, 17 Sep 2025 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AmYGJNOg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF9B3397DF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122707; cv=none; b=ScQsILqmEz+Be96t6Atp58k3gU9GbDZmm5zIbv5HNOmFd8sTQGGh/hDJBdceDmskRZrFw/YbQw8r15ySbnUmq17fJ7u6TgANAKqaWM1URh/1RGRoPAXRRgjo6wDW1Afqj4CGUumHuJNXwcgavMrF80yxExZbFHmqkQZl8iJkGcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122707; c=relaxed/simple;
	bh=gwgIsDRVRYX2HhF1a8Tduga7fOLhZSoXaPH0ZHLIBKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uwYDepaQZhEmNv9H9Vi4UAXQySE7WtODth8MSQhzpIRDBI0E+LLcgt2knyTwGxaJAx7Ea/FDxradM1AfZgSjsPjvlVkrIxMDJn6h3gi2pSxu1voBCln3937S4nqqetBqilPZlL4tzGnRrcXIlrdwNkrhf5XkS3wq9ItUnPYPqWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AmYGJNOg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HBLfww028290
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HL0iIHuhrw0+QPXTAS58J7uV9gkk1dnDKaysIWMxgeI=; b=AmYGJNOg7ZI9mNqf
	ohNuYKzbBoNUXLEe1XfqGDT4QPC1lDgzm60HYvILfn8U4Nb2JNLHsmA5N4FM/Gob
	ve1MgvnBFB/mDsoUTMlag1zyMHHND41OJ4NYgFi8UOty8+wxv8JXM1Do4h40WBAv
	gSu5FehDq+UXNv7Ek9dbdUO/rGo/9PBhhIl5qxCIhOMUFTKxV8xKZJnZRtmGDKOZ
	9qOki9ZUjt6ML7mu4WCIiaepLLxHqltbO2n8xiA29SU/hzHmGwcaDd5Pk/Qxa/8z
	GzQT676WCBNS2ho43eiSvKFqtoylv1Tg+uzRd/98I9Nj2fWNvBVZVym7us9PczmG
	eCNGtA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497v1j8sc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:25:05 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2659a7488a2so71275855ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758122704; x=1758727504;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HL0iIHuhrw0+QPXTAS58J7uV9gkk1dnDKaysIWMxgeI=;
        b=KVLViry1Q1RlYRgZd6FJAICWLlrQBZAGvIk5/luaHYOXpqqZU5mUl2jyAQo7oZK4T3
         6qOFKhgCIt/sQMuuIhT07U2TqWFBObbCucrRaLSRwaJDeqTJkacVWU4UFLOYRJPbQ8CB
         T1G8ezcrO4mDK3bNJTQZ8KmyErah/35FT7OnN/198WueLpxX49l5RUt9bvBQyO3yiOsA
         pxJdyhejefDG+qAXUfmh/86qw51D4UEPQpOm1gDT7AgEDDuEFcEvJeiMLhpNulgXCedR
         +HVgp5EEpUlSmNW8zsZCwKwLfY+9XlwIY7wBIIKsU03nK2HrYJ0KxAQaGqM14LailxP9
         VUVw==
X-Forwarded-Encrypted: i=1; AJvYcCXup9ryIyifVzbykcAFmRCfkOKH4wYAVMyDnlogO9z/uChjFyXa9nWP1NFy4uCrmA/+O+IvHYbnVvrTljM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaqiJxDNI3kgyFWmCtSz0fy65kj8TbBDHX9/7stXF+jxoEYIk6
	LvvkrZ07zI2LgcXMHh7wGGrH242NX9mhuwtf2w579E46mWjgCGZ07Bly+2XVoxxvq6VEq3LzV+M
	Xl+s8EVzX6v+Ng3bDtCYvpzSaSDEolQYxcyGqCbCw1M8ixSK3sDilXpNe9J2SiVA1YM0=
X-Gm-Gg: ASbGncs6viuRILlkbYsvFtETDHhpn2GEoPV8tFtHfaNnV+RL4uNggFPxRvJLT9a6bNn
	u6kMtCWWuiBwDkx33PFFaOkIat8CDVLFYO51vokrypjKxiYz3mAQ8IZae1BY8fyl64rEUX9qhqq
	4H/AsO2gxCbDv11zoyfhBnkWV/nhH2JX7zeZzEm5EpxwZnfOiq9SYhLhiCYryZK9LD2bJkgYEwu
	NPYKYgSZ9UtNn+qJVXuEYa3i49tTsDb3lFlsg5Cobx5bPVNVFk8wIcWnJoDAEyhzRm/nlCWDVhX
	SN0hzU+bm/m1NBrVTOTunKE78x8Q9TMVTxncy6/tnzhZCvLTtKjYzAjgeaTDqg==
X-Received: by 2002:a17:903:234b:b0:24b:1d30:5b09 with SMTP id d9443c01a7336-26811ba45b9mr26940275ad.13.1758122703750;
        Wed, 17 Sep 2025 08:25:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmORI6sNcePUHDL1ea7LBwUjWJDxDDKVUaaJcRzC/M+TlpMhiORpT2SoIF305qk9daBSB9Zw==
X-Received: by 2002:a17:903:234b:b0:24b:1d30:5b09 with SMTP id d9443c01a7336-26811ba45b9mr26940035ad.13.1758122703239;
        Wed, 17 Sep 2025 08:25:03 -0700 (PDT)
Received: from [10.91.118.43] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a80asm193499715ad.90.2025.09.17.08.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 08:25:02 -0700 (PDT)
Message-ID: <16701111-9e8c-42d6-8fac-2f4b9a5e5e5d@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 20:54:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/msm/registers: Sync GPU registers from mesa
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250911-preemption_aware_hangcheck-v1-0-974819876819@gmail.com>
 <20250911-preemption_aware_hangcheck-v1-1-974819876819@gmail.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250911-preemption_aware_hangcheck-v1-1-974819876819@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ZKOH9Tg_TniCQPfa09nvNy8AK9J0r87O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDExMCBTYWx0ZWRfX3/2H7xfDV1bP
 qDtKN8CLAdMg4jqJidx3L0NY+8z68k4oAPaT+yxIuFaC53wwX9mZ4O54OZi2qR68bMOs4TQSKD5
 CECUOC1qrDzrAU59HQB5MvY2qNbY7gKq5M1qkIozAWTvZcl9TL2brN5pZnQ/C6LF7121JEFIWy4
 olQtH+bgWlNFJe6OGnCqzKlfErEnSBG2M+N8fYJptm+aT+p/jlySYFk6/ATnZVkrpCVBrBKY/2G
 PUXamRB23sTQUXo6edLg72DijEjRtkAXo85ko5j1TSxEBejY8BZ4QYshzcYHaucml69RTAWK2NK
 h51ODWwBZNJD9x77nKLLmSDHs2JJYdMkG++86AoYWwCf4juF9HJKVqPrrUbQgYqzVxOTDvWDlgg
 2RUsTNtP
X-Authority-Analysis: v=2.4 cv=AeqxH2XG c=1 sm=1 tr=0 ts=68cad2d1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=wfxb_XhhgxZQwQkhXVMA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: ZKOH9Tg_TniCQPfa09nvNy8AK9J0r87O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170110

On 9/11/2025 10:31 PM, Anna Maniscalco wrote:
> In particular bring in `CP_ALWAYS_ON_CONTEXT`
> 
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> ---
>  drivers/gpu/drm/msm/registers/adreno/a6xx.xml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
> index 9459b603821711a1a7ed44f0f1a567cf989b749b..6ea5479670970cc610ca25e71aa41af5f328f560 100644
> --- a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
> +++ b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
> @@ -254,6 +254,7 @@ by a particular renderpass/blit.
>  		<bitfield name="CONTEXT" low="4" high="5"/>
>  	</bitset>
>  	<reg64 offset="0x0980" name="CP_ALWAYS_ON_COUNTER"/>
> +	<reg64 offset="0x0982" name="CP_ALWAYS_ON_CONTEXT"/>
>  	<reg32 offset="0x098D" name="CP_AHB_CNTL"/>
>  	<reg32 offset="0x0A00" name="CP_APERTURE_CNTL_HOST" variants="A6XX"/>
>  	<reg32 offset="0x0A00" name="CP_APERTURE_CNTL_HOST" type="a7xx_aperture_cntl" variants="A7XX-"/>
> 

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil


