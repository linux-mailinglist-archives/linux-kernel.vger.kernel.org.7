Return-Path: <linux-kernel+bounces-768394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 422B3B260A6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074861B6245A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2072E613D;
	Thu, 14 Aug 2025 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fF53YECK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9126D2E9EDC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162923; cv=none; b=kFmh8smZ5wcbiea0EzW5kcFMI+Xc3mZznFmjO6Mua5js2Sbpfn2Meeuu/bnHJSMZ6tO0hf4goIXZWWmax2RTfiA0hG3oVZyo2jV7thIssBguUmMUfEmTz1hgjm1lumuoA6ya1enKSMahMpfPUPPSxVkssk1k+fKvSi6IUKAz164=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162923; c=relaxed/simple;
	bh=XhEhDZQsgMiczoesYFyeTv5mQBvZtLNYROcgClmCwOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUIuDoRGzT5tKd2mBgZDZWnA6OSsORtRiuzruorCPby7fn1oLgEmFGP4dj6BmpY7xcmt0FvA6K2Nn36axk0VeGTvi5w5zuQtNeJvjE5jOIx77n0ViPMA45jKOzg+ugxwj7vDw86w4KvDYywZRyyA11gu3tjv+Wi2X2dWVYcTiRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fF53YECK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DMYkxZ025691
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JXECCtiDhY+FWYo/Y2DbBqY/PXD9a7G7J6neCt3E7iU=; b=fF53YECKPEpR0cg2
	VwKZMznx3OdK06LL4V00GTK7XF7m7O9Oc+xjaniO3m8nGem5KeT7rJyPcRHQ5yZd
	e2KkheFATa41mjVAAbqJwSE+mk9dsoF0ubvLylZtys7cMvbR8m3eFbpqxb+LBEKr
	TFSweUjxiGj0S0kUpdm1EaaF/ywK3kKKtoywAHsHarK2Kika3Ihu7nv8l7ioJc5p
	JQRaFO8W2wELAON6cAoGg5GMx9z2QudnF9AeQAxC8T51R4s4Qih//aFoNUcKcWRT
	fsIoLTuwMHS3Y9EGkObTcQD7t6giIx8Mu1corNqIUPi5/lMJYAaF3WaoUjzGZxAv
	lZM5mg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3gf12g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:15:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e87068f8b0so19737085a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755162912; x=1755767712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXECCtiDhY+FWYo/Y2DbBqY/PXD9a7G7J6neCt3E7iU=;
        b=bSFMlb75GbpM1ioAlrFTKOlCv1cDs9TFKuYb9Z21fkCBIZIMzi+QpidJsSoFJIHUzm
         HXkqsoX8zTdlFttZAryXjHcfwbGRbU+JtPkwRijjfxbv++qIPt4NDDNmHH4mbWWetKtW
         5tARNb6ffs7f6amYvBKsHsIrQcsKsVZwyMyh1/nKOA+Hd534zZbkYo4Rrozv7en1W6AH
         wuFJk6exw1588wAiLCkuni8tEvUD9sHCBoP9P1WRMZehaaFHnGfTTO78eU+E1cXoJgS3
         sQzM1E1/b5L71u6QuNrxhaC//R0E+8TuukNAMgtEiu4C+/FNZbbkxWsiC4AA5A0iUdUZ
         AOdA==
X-Forwarded-Encrypted: i=1; AJvYcCVMVmRTm6OvrqO/WkJkSIyKo0h2nt+e3we/eOgFlqmdQtuNIXXk5y6C+Vdb+x/2PPOG8ydjmE6T3lea3Og=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl7bshcvO9E0KlFD597sZwSChvfdlybU/HRpRvTfwCvN/KD6nN
	zy0v2v3Rmd4XKpEdgoN3pA3I+JZ/tg/a0v3DHtzYBVKhpTUJvQYpd9RvS9Ta3YdOVEbweXeOZo/
	1piZ26rMV5EiSYoJNKnwO6XKcRMyym9SmcYf54IegrfE5kRnYlu9HLPhgORhp4cLVgtZajqzyGQ
	A=
X-Gm-Gg: ASbGnct2erWUKrUSNb8tXALcNI9ICVAj6B+/sFw39a+MCXLWTrLEMBQqRyRFtDBnxSu
	aISgqohAXMQIeb/iRsz1afP8k+Uq7/1r4uW2VbmVQcZa35Ri6n95Vdtz4VJWZDRabn/0RiRiYf5
	q02LVQGtjtYLH2BAqzYJ2Tj3W8XM/ZCBWQyJmie59vG++baukWuxyV485uSYIfRW2aEcpVZF3wW
	ADFRDbEOnGhofIbsLap7TMby4CQYvfJly6C1xQ8vJSbc8WvoT5yhPKJnl+0r107ZmxGLl3RWk8y
	MZbIfMOHrouhfFYSTaoKEUly7n6XUfJ1YWbm4epDbNz7C4T+vZ1YdK4KRaAvDGVMVOHgoCj7OvA
	VScZDv5zIUdJBtQ03tA==
X-Received: by 2002:a05:620a:2801:b0:7e8:1594:c1d2 with SMTP id af79cd13be357-7e870445097mr153925185a.10.1755162911944;
        Thu, 14 Aug 2025 02:15:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG700skgv8n/LYxojP/q5UsrZ8ZDa7F90OYLMOTMtJbcl0KhlRKJm0m+VOoW1I+d9LOuGyLbA==
X-Received: by 2002:a05:620a:2801:b0:7e8:1594:c1d2 with SMTP id af79cd13be357-7e870445097mr153923785a.10.1755162911409;
        Thu, 14 Aug 2025 02:15:11 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0757b7sm2547884966b.19.2025.08.14.02.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 02:15:10 -0700 (PDT)
Message-ID: <e35ca54c-252f-45c4-bfdf-fd943f833bc4@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 11:15:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: icc-bwmon: Fix handling dev_pm_opp_find_bw_*()
 errors
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20250814063256.10281-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250814063256.10281-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689da928 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=oxqizksRuSS1_KsISTYA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfXyculblKEdCLV
 zpw599A8w39oCQG5vBadJ0zov6dMAOahr37T7rAm/dvZocJhV6ivwh1O7TEyv50Kadw+D+b1Q11
 rYMsvKIKvpgrTYET2Y1G0MpMrNOdcpAiYAynucCR046ib1odyQ24fCFub5FTk/Kb1OxseDcz+6B
 2nXnpwemXA/IpfiiMqJL1egwHmPWezUuv3N8Zj9wVWxFC9eEx5fJlYFOUe/J2QXmhInWs9O/C2c
 O/KcKLPHkHYWmUsycVJHCMyLFduo2yOvPqZrx9vASEPy3k0zDNmAnVKwa4wJvefdQumLKQ0ghbm
 jGuWavy7Nv0s/cYEYFcoO+yZMkVt7DRHoewCVJvzBVI/kyyJjgie7tzYxDrqBht0TqWnvk4Fbak
 VbHKf2TN
X-Proofpoint-GUID: QUf4aLNhGp8mCOk4qiDKR4KX4F4qNMZe
X-Proofpoint-ORIG-GUID: QUf4aLNhGp8mCOk4qiDKR4KX4F4qNMZe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

On 8/14/25 8:32 AM, Krzysztof Kozlowski wrote:
> The ISR calls dev_pm_opp_find_bw_ceil(), which can return EINVAL, ERANGE
> or ENODEV, and if that one fails with ERANGE, then it tries again with
> floor dev_pm_opp_find_bw_floor().
> 
> Code misses error checks for two cases:
> 1. First dev_pm_opp_find_bw_ceil() failed with error different than
>    ERANGE,
> 2. Any error from second dev_pm_opp_find_bw_floor().
> 
> In an unlikely case these error happened, the code would further
> dereference the ERR pointer.  Close that possibility and make the code
> more obvious that all errors are correctly handled.
> 
> Reported by Smatch:
>   icc-bwmon.c:693 bwmon_intr_thread() error: 'target_opp' dereferencing possible ERR_PTR()
> 
> Fixes: b9c2ae6cac40 ("soc: qcom: icc-bwmon: Add bandwidth monitoring driver")
> Cc: <stable@vger.kernel.org>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/aJTNEQsRFjrFknG9@stanley.mountain/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Some unreleased smatch, though, because I cannot reproduce the warning,
> but I imagine Dan keeps the tastiests reports for later. :)
> ---
>  drivers/soc/qcom/icc-bwmon.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
> index 3dfa448bf8cf..597f9025e422 100644
> --- a/drivers/soc/qcom/icc-bwmon.c
> +++ b/drivers/soc/qcom/icc-bwmon.c
> @@ -656,6 +656,9 @@ static irqreturn_t bwmon_intr_thread(int irq, void *dev_id)
>  	if (IS_ERR(target_opp) && PTR_ERR(target_opp) == -ERANGE)
>  		target_opp = dev_pm_opp_find_bw_floor(bwmon->dev, &bw_kbps, 0);
>  
> +	if (IS_ERR(target_opp))
> +		return IRQ_HANDLED;

So the thunk above checks for a ceil freq relative to bw_kbps and then
if it doesn't exist, for a floor one

Meaning essentially if we fall into this branch, there's no OPPs in the
table, which would have been caught in probe

Konrad

