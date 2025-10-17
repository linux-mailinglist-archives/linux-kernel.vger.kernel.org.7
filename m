Return-Path: <linux-kernel+bounces-857550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93505BE71D7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 522BD503C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590A027B505;
	Fri, 17 Oct 2025 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MtFpMQst"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4ED2773F8
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689042; cv=none; b=vGl2Oyz5W7dFn9H6gRrTle0cnC4E0yK8lLZYBCpjGp0H2KFUeD3winoKkGB02/DhOkuZ9waDal+hyZqaYu0FWaBMOJ2IfAdSAYiMMooRGkuDoJUPUykTyQH85t3kpIRsPLMiOvP+HsUfWM4So5eDR51+cTa2wWfwnIWFilRAZhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689042; c=relaxed/simple;
	bh=yqGQ8OTcXmkgvbvXXIDW3fgtfORClcNs4wdWbHE74dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJcrrjvfT6P/BtmGikUz/Ek+AIYGXS/2oGm4egKRbooiyT7i7z/hmU1cRvfL1m7YNJ7vvOL7oUOYCDMsp+Wha3H/owNVZsrXAHsDgEYrFzF/MinVA5vqbbox1XG3lSIb+ao8cWYSnYZGQNfF/raoP/XETAuCljswnD74zOx9ktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MtFpMQst; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLRv9002098
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lX+jVvJZQYtCmRARp/2G8vlFEUblGOHVeBMwRzmLa5c=; b=MtFpMQstJ6gO9so4
	lghcgYqqw47ulRQaorDPSlC9o51synLQK43V27Q+ahVhydpx5yecl+9PHyqymKpW
	bERG6l5jO/v+326Zk6YIhHj/H3fTVk3V7Z22EWxlhZlDgn3Nz6UTr2yUI4ljbkj5
	1M/9ArjO9RDdHI/aOX+6IP0nW7SUs5qFFj7/dgSiDai+v5aT4E0Hs9A3Imxj2A26
	eascjeoah2571hRDnG/7bWA1EGdn72QiFADLRMSWUyko0b5XOcsHrX0988lcWwdM
	UUSrBDBR+EYHkPlp5COVIjSNGn5wsBISwkx5s/UcT6xJPgAZKkZ0bj5rROAZGEgu
	tfr8Ag==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa8kfhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:17:19 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-883618130f5so72176285a.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760689038; x=1761293838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lX+jVvJZQYtCmRARp/2G8vlFEUblGOHVeBMwRzmLa5c=;
        b=kM6gY7eLDpqqe4VJLEM2Z4sBcEY2d8dRAS1K7I+StMnYJSHq6GJcjN24g214TLBChU
         SZz9hBdRtV2r5IeHS8ZC3UToN3YRbGWY6EId62Yb7NaawyLwhOSn3oCy7VC7nBON1HPC
         9pHMqtH41pc25hmhR4izYGZsB8SsNgOvfvbsE0M/e6HnqFgE2QOADzTVTrHGaYmm83YQ
         3eUaVuiy++FoqsmrAMfKau/b1mLMlW0o2ZR3dSIbTIucv1Hh9QsJEuQS59drjAIiRcoh
         MW95TqRFStIX03Vz/QEqct7uvkvVpLW4uzBMVnLCk0YeG/DNmhX/EYCTi3DrnksoamDU
         LdTg==
X-Forwarded-Encrypted: i=1; AJvYcCXNkrMiF9U3MYAiaiCRMauWEEXFg0CQ/pAaiTsC6oZkbT97zB2gY71S5wX5MfiOkMau287podAZRNZu064=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDnfKmd3Yf0sK6qlJY1OkI4hryCAtFm5tTTsRtb8VdD0idoN8K
	uXAOWrHXHafX8zdfF8gcoYt67NHcRhmHR+IzBAYGcOFJUqIcix6/7fUKSfVy2EmZOGi69h6kqji
	1dLePGEsvn6SNGplXFQbGnvNfaKoxybt5M2R6yru1UumA2NuRYkByEWVVBc8vWN2u1E8=
X-Gm-Gg: ASbGncszXllT9Vu/I2u65unIX40b+KRDNqw7k5uq7WkU6nTQLgap2VgM/3BnPSUqi+I
	Zb1a/upa2vS7SBG//6uVABZBjWeA33spOyTtGggET2e67PeLUQ6P+3qvYCgUqHL/qVdauMJc/ff
	l8UypL8A5APJLBP06TQ8yz532K8+kZ7SNLiJC/zTjNaftuJJPCMJsWY0xIO9h2bYZAZNb0rZRsM
	xkEKggl6Kr8s7anMuinGSZ/6kqaJbN8Jxrp2NURQa7KzcnAf8nCwiROkOLouJH823NIz3emUVpp
	ZymxiUJjqMt/uUZa7zbI35wb7Q3Ey8+wWZA9WWhwZ6rfoYNTOQktgkkKDzjColM86w4ChkRV03u
	3CNC6/4PMoyBlJRj/cuuwDv+dK5OWZVK1UwQxqIfLQkc/AJRuDGz8L4NU
X-Received: by 2002:a05:620a:4405:b0:866:6f75:5928 with SMTP id af79cd13be357-8906fd16ebbmr230159685a.10.1760689038371;
        Fri, 17 Oct 2025 01:17:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyJx5hkQdQS+Y5PkIf/4c+WZ0H7bjNJmypS2nW+qBWl8HiKuB1yK0Gui8Ybc1MRrCpPhTuuA==
X-Received: by 2002:a05:620a:4405:b0:866:6f75:5928 with SMTP id af79cd13be357-8906fd16ebbmr230157985a.10.1760689037913;
        Fri, 17 Oct 2025 01:17:17 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccd1b0287sm760582366b.62.2025.10.17.01.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 01:17:17 -0700 (PDT)
Message-ID: <dfc03399-d4f8-4e52-b097-75fbbfd1c8f7@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 10:17:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: qcom: tzmem: area: fix qcom_tzmem_policy
 kernel-doc
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org
References: <20251017070702.1637092-1-rdunlap@infradead.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251017070702.1637092-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: IgDSG9qN6e5Hc6uE3m8X5ScDNFED8B92
X-Proofpoint-ORIG-GUID: IgDSG9qN6e5Hc6uE3m8X5ScDNFED8B92
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX7dFOTPdtiHAb
 Z4lNvq7x5blTiDyFO+7u2t8JXvrGW/96k/dlWJUwUoSJ4Bt1zFHquGevQBxdtQTNvGpTDBd6lv/
 cfp9fxhIS9tbxV58knQ+lc5chi1PRzgvYm8++eWH6ERv6TVMdooqpAuZtvJ1fByUrZ+7dyTfAgO
 nA+84WI6L6/m7G40n37E7TmzT0mCVXcjGZLT3thc0Yi/uNKFr3JOJZqUqh/Tomq1E7yMF2clTuP
 A0/GJGhnRfRlqvmGYdU+c5Y3YHsnmyxmilRBi/d4EHULYWmuMYdNoEwivhyoD137x3vzI3pXeCe
 h1k8OD9CEXWn2SBIFkKpnqySRKphF7ITmLf4B32yJgNJ0fU1oD7ALZog4L7vSfi3+3QjLFQH/ft
 9N/lhSguwnR/ZCcbApjBg42ZDGOmNA==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68f1fb8f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=3A0cz7Tt2GQjipOb8Q8A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

On 10/17/25 9:07 AM, Randy Dunlap wrote:
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
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konradybcio@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> ---
>  include/linux/firmware/qcom/qcom_tzmem.h |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> --- linux-next-20251016.orig/include/linux/firmware/qcom/qcom_tzmem.h
> +++ linux-next-20251016/include/linux/firmware/qcom/qcom_tzmem.h
> @@ -17,11 +17,17 @@ struct qcom_tzmem_pool;
>   * enum qcom_tzmem_policy - Policy for pool growth.
>   */
>  enum qcom_tzmem_policy {
> -	/**< Static pool, never grow above initial size. */
> +	/**
> +	 * @QCOM_TZMEM_POLICY_STATIC: Static pool,
> +	 * never grow above initial size. */

Didn't know inline '*/' was cool, but if the checkers I'm happy, I'm not
going to complain either

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

