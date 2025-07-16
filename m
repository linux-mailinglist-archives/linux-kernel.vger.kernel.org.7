Return-Path: <linux-kernel+bounces-733263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 533ADB07254
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F73B500590
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3130A2F2362;
	Wed, 16 Jul 2025 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TD7TaINl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A7B2F0E5C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752659913; cv=none; b=kc77HO3imJvP0QEbYEB8jM85WhD/1HtiU+d+U5jxNP0BCn+827jX1dKxK6QA9AJTiuz7ggDTjNZkXA8iLysBn8j6kJQKMtZJlOcfoWDLqDl1jBEPpPDHcQ24BC/qSd/oCcPVOR1pJUBqFLjHEgUtYANkeztCZXuF2RC4IiTCds8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752659913; c=relaxed/simple;
	bh=uCPi2EzrNB692xy9We9a/N/3HeKk+7QZjy0Feteaw+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pJQYU4Y6KrkUjuqj0TByz2nu2VeKZ2AbjMWoyFGzN1PTcir5/JcmA51Vaw4BkYGr8PNMoOcNEv/9v9Lfc5mL6vHSsGrwCcD/gXG4MjhCYnpuM9KrErYWafVeg4/SggiCXzyfG2fGg9iDk+pFcwAd4YGmC0PDY7uCoMBPSBGLcE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TD7TaINl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G61Bvc031862
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uCPi2EzrNB692xy9We9a/N/3HeKk+7QZjy0Feteaw+Y=; b=TD7TaINlKPIASE36
	u/IbN+GDCE0I8aXSUbZMgWJU5NLyxC3OiBPrp/w94eJ2CIRTzCtvErpjFnPBsIKY
	dEoPnit2bh26v+QbjDsA08VXCjUStPFtRonIes9qDcEcSPf1Rckx0ks9IgGr0Ulp
	/ZFd1CGsPFstiDMvrOhiTJ+CgMKmcQIGvXWRag6QCDVN7AqIXuLa09ElQm2W61WD
	uKJ0GCCuX6oqQhJhFdSaFr/LcQGPVOUHdiQvg7iD+itE+anVeK9B1Pra+Nj5ePtF
	RlFj1INTotKb96Um/t3VD+YR/PYkYlsdtQMWFKJERhJXZMf9bOiynuOEB3PG8/no
	JoW32Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufutbaf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:58:30 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fac0b29789so19140366d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752659909; x=1753264709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCPi2EzrNB692xy9We9a/N/3HeKk+7QZjy0Feteaw+Y=;
        b=C0TH9pX3k2aOQT07VgE/C8yE+5Rw7IwoNYNzalEvEAZTuYJDSPt7cWWcm0CFhfJlM2
         wNm44KRJh4vPDy4Ytz9z+E7q4h6ZPrB90vOTF7bTZeMG/oudkTlSsifaNKLwEWY3fhGC
         fSeDNXbzMTUKGFxkd+VC1Giv4JEGQB1GaKdmFxqUegY5+6tRE+PaIvAPMSEdxntDYsen
         uxbgBMcl5IsJQlEVrKtZFfwoBrNS3xqgaM/5QHBamppQhBpqMgN93jQXEuzVF/WYXZR4
         g4U3qvWVukaJEU6m91dvhWWDt4yjkS7X8ysrExw7V3ggpRoLmHVFJGWl26VHZ/7fwYz8
         OrBg==
X-Forwarded-Encrypted: i=1; AJvYcCXXXycyma8/Vz/OQqeGkQ1+H3Xg4jdmg4MxTeVGm3V9aWj9U5ai7El3zGhspKNRq/kpeFKDyCKkye3GCQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzYEjBRYNTsfJ+Sf24e47jVjrNPaUpjShZsxToMzqZLGU14KwZ
	80JVriZO6zDDttM3LJZeIQOo2n+aZgUGvzZYKbaU8bHKVZLSK5Osz2tHh9/zXwf05m6j2WqVsJV
	xeuXbG9m9j0ROWPwWgUOq1qjUtsaXSOU9pnVHUxz5/Smw4cTD/T5qUqWaYs6pFZtQDco=
X-Gm-Gg: ASbGncs42CGUlujuDWTTaPc8O/291juv2M1CSwcRbFviRZvhTzY4lbt11NmAaP5I/H7
	lX9Kqw+SYI3qgd3DrQGjYJHYoAJT9Q7Rm9UObwnGZh/uD9tgN9ontn7XSq05Sj6vuZJRwNg0igr
	/yoIEbVtnwka8bgjmvNJSxyAWbWiDqIWgvGXGNk8FN3xPvpVK0DlviB95GOhrtJzAk+F7MH24zv
	LqqaYDao8O0YUqDQexU/ih40P8h7pf2/djWpRIsalxADXlD1ncn5wX6GgjKLBFXXW+WB1vdSOjw
	yAJWoPNPD/o0mtauwozauURJcuCTxuYGSaMyHHA4XkG8JFGJDXU11GOTnP2s9DAFop1tbPO7SF7
	1vD7iwkqI4zSzYY29kZMx
X-Received: by 2002:a05:620a:28c1:b0:7e3:297d:ec32 with SMTP id af79cd13be357-7e342b37074mr137701085a.10.1752659909175;
        Wed, 16 Jul 2025 02:58:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpnCpN/dC4tnBcVCDR8doy3/WCq6HZeBLkingkmeSVXbTv0Ng7Hs+rCJV4fx9aFN6b/RA0hQ==
X-Received: by 2002:a05:620a:28c1:b0:7e3:297d:ec32 with SMTP id af79cd13be357-7e342b37074mr137699885a.10.1752659908851;
        Wed, 16 Jul 2025 02:58:28 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df2efsm1166796766b.151.2025.07.16.02.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 02:58:28 -0700 (PDT)
Message-ID: <ad1afd1b-9cad-47d1-8dc9-0d62b25f502a@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 11:58:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/kms: move snapshot init earlier in KMS init
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250715-msm-move-snapshot-init-v1-1-f39c396192ab@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250715-msm-move-snapshot-init-v1-1-f39c396192ab@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=e7gGSbp/ c=1 sm=1 tr=0 ts=687777c6 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=qnTbvVf9oJKgxClKmkgA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: Way2h9gkymyy6B2z-nFlJimsbQ1Gpq7G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA4OSBTYWx0ZWRfX4p4KqTH0On8C
 43rCKfxXbgZ0g75o+T8gZ0/EifDHBSw7MUPGMfE+kDgk5Jocmq5l6aw21GwvIC7Sl2HbQc14s/0
 TxU5LBtekVDsjAjTMz0UzXmDhXmv+HBmV4DHlPhq1mt2BClxrILkT7AhA6ZpCrnd8v6GNywG8mn
 RXOWWyohDjZcXj8JyLWhHk9PPRG862eOqse5qFEWCoxLk1+ySnmvlBnnh5dsW/RQW6/P8xer6os
 i4DKDiNp7YmO8eQ6GodE8iUyAEd3qHfSPNi1ejQ5PrV+iNoDyuiqiN/YemRqvOlbhKBLiwzlIA9
 naNZ7rgLJxVq84TrL+YbWAA6M3o/ks1DGs+5F/hKLC0XQvKLI/qq904H2e+BMYDCQQlVTxHtsAR
 g6Q58lOx6IxrxGwTKAXd0UYsYelQCmzPp9zKLkKu0qgwlJMGuDFZIt5WYbkCw8tefcqj5QuX
X-Proofpoint-ORIG-GUID: Way2h9gkymyy6B2z-nFlJimsbQ1Gpq7G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=966 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160089

On 7/15/25 5:50 PM, Dmitry Baryshkov wrote:
> Various parts of the display driver can be triggering the display
> snapshot (including the IOMMU fault handlers). Move the call to
> msm_disp_snapshot_init() before KMS initialization, otherwise it is
> possible to ocassionally trigger the kernel fault during init:

[...]

> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Fixes: 98659487b845 ("drm/msm: add support to take dpu snapshot")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

