Return-Path: <linux-kernel+bounces-860287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96299BEFBF9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6F93E0EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6C32E1F13;
	Mon, 20 Oct 2025 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QdoNfdUp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89CB2D7D2E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946917; cv=none; b=LvreRSFQVc2I8YccvNrqFlLUffoJonT+VdySAPVXnXOjCLiFF3CRdRoMYBdwChynL4AB2t7/kr0nKvDbX46oi4bgmQMX/LKLCg2KP35dvwxs95fW9xpQJiubX6ktEZpNmj1QvF+rDP0+M3Hk6AbJ7N9fWO4MTUTLLX1wCy+MR2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946917; c=relaxed/simple;
	bh=h4HiajxzA1CmxWNt4SKng6oupQWXzBhNBClD4/b9L4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQ/qZOKUeFMtjoLGjrCZXCBJsZ0zrNz7l93CmmLY1zaTTqfygtaeSYu3bLXuuiBHwQxl6X/05owUcE1FcJlFVBgERvGsvodUDDsXZiiCN8dMcuO+NrR0swzhETcph0BZWWp1ejEGm6PyQm0Se1HRAdl5pQLTt9lHCB5Nm+mJl7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QdoNfdUp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JMLHou014502
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B0MqLkW+f4N4oFjZMeCRTrse82lpLs+0SyfGYBzgcts=; b=QdoNfdUp8mCI7a/s
	PR1yg584DCplcVlcnIxV4DrsQLp5KYLWKOtyK3nfWFgNhBI9fyxaI5M6rMeAUdNC
	xFXX4WkxjASM5N96WEZc8boNcuR5qTeTjW9tTPbJnXYNmPXcwSUehJxf0CfQrsYT
	TnPifrHFnupWY+GHIv4Ja0hVETGb3MaSN7UviDPe4Hs/0Vfx2HC7nmGLFaJjr4NJ
	byll4eguPY9+jNGWQ2G8bjvFgCgNqiamps13mrc5WeU8n0jLWRiu+o0lR4yYhriR
	eI7o3bINW0TqaHIOu2ljyHQeOjz6G1DNffSWYX+meKipLXE9QsKtq62qXsfl/2+W
	fT07ww==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v469bx79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:55:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-88fcb38d0d9so207042685a.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 00:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760946909; x=1761551709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0MqLkW+f4N4oFjZMeCRTrse82lpLs+0SyfGYBzgcts=;
        b=gsu82t4EhU4wYURZeads7FPcOOZOw2KDD236x68DlFiBUHCyahBHNWuejXZRo8Pf7g
         JFTp/AA11PipqMjhoaFYyS7Bf5NYuGPm5XF2sBUzNVEl/HtgaSkzMgJ1lygpnoy4K5uJ
         Fv0YePDiVcsTD/yWNOBO45SW2nzO94UHMnRBFaXMF38+KqNoeV1WdpOOdKoUmF4fFMLs
         7pvigwaqThJYCj2s6utAdSJ8sSRbozcU0to8+KFXnEdNEiZlwYjThRTL3RE0ryfHu42j
         VSvJmij3x0HgRMBLCUDJLNa/SR+JfjKwneBd4IMRrKqRSwL1CSS30VppHXyZq4slGgJR
         PjDw==
X-Forwarded-Encrypted: i=1; AJvYcCU8qX4fF0RZFDlMSEtVBIU65C4H75OoRJ5tcVitxgGA6yWk4WL2upe8819U06sV1aAr8soIjUbL4R9trm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIVp1my1qZBfr36nRjGtjAKQsbyzvEaa5WAAKrzrGUznRMa9DJ
	kJoWLd8u0WHaeKbNRE1QQx280PHIV39+QSERUPRauhAsyGNmD19LqFWLxWFV2ahNWipfrQj8+WR
	p/xJ3btGdeU8a07Sud7+GU5FuwAWts0NGteiDA5lWNOFDHstBfYRF1IyW0+FciqKJzug=
X-Gm-Gg: ASbGncuRPmnVS+zXYbinB4PChBcjDFTzCCW+s8ngMcbeUyCEbv6i80kPxGRy7VGTiq2
	grnJ2/hB035qEmhHIy7OmnqQMZJus0wU9OBHDhQzxejAfrHNlfs4N1jaUDdExc/XVq3p+kEdR37
	ym+Xr07w9mOcBxNOH841bkf492PmXiRfweqLKAF39RZ/BEUcrA6/PD0WPleF2B29yC1kIm/UV0y
	eJEW+8mzHv/BK+os7uyZBGeOxe23KYRFPBrtkK4pAGGQ+wT7tBr0lMmkCBj6WVHlgRQTSV2Lr92
	hww3627l4Ft5Vj2IRvgMVSWywC8zCfJyA4wxPwukPHIips+9nIu9xCE8bFh4EzwNuwMnSkvny7H
	0pk9bwSHmJN5uFUfcHEncEMCu+vgb6RxFHPg0hf4Pz7gnCi/WC53Z9rFx
X-Received: by 2002:a05:620a:190e:b0:85a:4bc8:3d2d with SMTP id af79cd13be357-890706fe6admr1086222385a.8.1760946908790;
        Mon, 20 Oct 2025 00:55:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnqwQmG7J94vQWIA2FUvtne3ArVMs4rBsBb9NG0DgZ3XvsR7GgvmNul8r75lm+yVlBgyfpFw==
X-Received: by 2002:a05:620a:190e:b0:85a:4bc8:3d2d with SMTP id af79cd13be357-890706fe6admr1086221585a.8.1760946908328;
        Mon, 20 Oct 2025 00:55:08 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83976afsm712000266b.34.2025.10.20.00.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 00:55:07 -0700 (PDT)
Message-ID: <f2f1b46c-1c1f-427b-879c-7fa0bbb783c3@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 09:55:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] firmware: qcom: tzmem: fix qcom_tzmem_policy
 kernel-doc
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org
References: <20251017191323.1820167-1-rdunlap@infradead.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251017191323.1820167-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3XoLiBOOUZs4fu54uphxcz_sG8d89njK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfXwkke8xRfQhcI
 xNCZA7hpUPqB4EsMceLCf3OTVtlZ4ZYo4BQ1OzS0vzEZx+WKpb4WwT9sS6OjyNGK4TOb+vQx7hL
 hGSyxZZ8YTzOjrAzIwk8f4M8PxhOgf3fm8ahSraqIHszAdVxu3ryGo2pJb56GmNIW0/TmaYtdXw
 EDO89quv9VQLdGObiXpWqUxY/D59hEW3C90fSpLO1tYlHjqR5Lh4yrA/2n5QEaQUP7O1eYDY1ct
 7H6wcYzcLH+GQrDsxjCSmeCtnBut/X5QFQg9SHz6ByW7VoFIeEZIyKVflmilPJhox1RAO4ocUmx
 12moHQBB1OzmFAoiJB9z3wzhDAFek2J+2YCxGASmTQxYRcNY8THKePhLrppsl6pW35ljlVlft7F
 Q9yz6L9V4oRQ8fpW01hPFafnaPiiKw==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f5eae3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=anZyeu-lZFNz4K4B6V0A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 3XoLiBOOUZs4fu54uphxcz_sG8d89njK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032

On 10/17/25 9:13 PM, Randy Dunlap wrote:
> Fix kernel-doc warnings by using correct kernel-doc syntax and
> formatting to prevent warnings:
> 
> Warning: include/linux/firmware/qcom/qcom_tzmem.h:25 Enum value
>  'QCOM_TZMEM_POLICY_STATIC' not described in enum 'qcom_tzmem_policy'
> Warning: ../include/linux/firmware/qcom/qcom_tzmem.h:25 Enum value
>  'QCOM_TZMEM_POLICY_MULTIPLIER' not described in enum 'qcom_tzmem_policy'
> Warning: ../include/linux/firmware/qcom/qcom_tzmem.h:25 Enum value
>  'QCOM_TZMEM_POLICY_ON_DEMAND' not described in enum 'qcom_tzmem_policy'
> 
> Fixes: 84f5a7b67b61 ("firmware: qcom: add a dedicated TrustZone buffer allocator")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v2: drop "area:" from Subject.
>     Fix kernel-doc comments to have the ending "*/" on a separate line
>     by itself. Otherwise scripts/kernel-doc becomes confused and skips
>     the enum and the following struct!

this is fun!

> 
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konradybcio@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> ---
>  include/linux/firmware/qcom/qcom_tzmem.h |   15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> --- linux-next-20251016.orig/include/linux/firmware/qcom/qcom_tzmem.h
> +++ linux-next-20251016/include/linux/firmware/qcom/qcom_tzmem.h
> @@ -17,11 +17,20 @@ struct qcom_tzmem_pool;
>   * enum qcom_tzmem_policy - Policy for pool growth.
>   */
>  enum qcom_tzmem_policy {
> -	/**< Static pool, never grow above initial size. */
> +	/**
> +	 * @QCOM_TZMEM_POLICY_STATIC: Static pool,
> +	 * never grow above initial size.
> +	 */
>  	QCOM_TZMEM_POLICY_STATIC = 1,
> -	/**< When out of memory, add increment * current size of memory. */
> +	/**
> +	 * @QCOM_TZMEM_POLICY_MULTIPLIER: When out of memory,
> +	 * add increment * current size of memory.
> +	 */
>  	QCOM_TZMEM_POLICY_MULTIPLIER,
> -	/**< When out of memory add as much as is needed until max_size. */
> +	/**
> +	 * @QCOM_TZMEM_POLICY_ON_DEMAND: When out of memory
> +	 * add as much as is needed until max_size.
> +	 */
>  	QCOM_TZMEM_POLICY_ON_DEMAND,

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

