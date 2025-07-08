Return-Path: <linux-kernel+bounces-722026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303B0AFD284
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2B13ACC3C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2382E0910;
	Tue,  8 Jul 2025 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cZv5I+E2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16D22DD5EF
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993052; cv=none; b=WTo/GJ9FojY6qJ1ouEWX78jRzcZTVaZ09VoMbXG58HnuULsmU9tgyFUSl76plCYOdeX+UxwX0y9WTjVFvT9gK/TDOyk5uIpbtS8BNqMa8ODlTD16p2BlKsYn3ofe2gtlUdMx1AxhGfUsuIzCVCID4yVED9QGL+sKEzltHiCgsJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993052; c=relaxed/simple;
	bh=ukiXSSeFVFMhOkjxWVniUgNWUQsnFXBIgcndaWPz2Dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Di94WYSerE/CzEL6/X1k1q0hfyKtMdNnRJSFY3pUbm8O3BX/CAQB6V7v5CtGV6R1wX84xO9kr8AW7/oBIUkGS/ice1XFMLaD+Brpv9jNFMpRRweS2Pv0u7dDk4HFJ0mXOvpuLiRay1GFWwggdpFtLcpLi+miJ1njpsuu0LbiuS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cZv5I+E2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568EbLHd014517
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 16:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3VZKuAlxi75Rn12eGDb5b2eYwjOnft3owwU85zuZnE4=; b=cZv5I+E26G1+HoVo
	V5uqZyC4u4+erCE9R00CfrGbacdXRIwMX7LEXm8Y86dOlrd2A9VF+fKPywJlvPmA
	7Rn4gviyW/OpblntXarNb0kxXr1GYr+t6ZnD8yF3cS+Hr1M5fFze7/HXE3/mnMXA
	aDbFc0X+/W2NjMCGVg/s0qwY+cq3kcnwlicDlNtzQ/RYpPOrJyyfS1Pi72PZf4Is
	xNjEb3c9CQWgNO3f+kdOiU7W0VDhU8reyRLKfmzX2plp5s3LQvo6Whz+kJ34JHLW
	Q9dtihlATF5n90jV3xuBKxebSlpo90oE80+X3rdLT4ceFpTmexCmML5rwtaKyWG3
	jIL+iQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucn08kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 16:44:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d0a9d20c2eso55250085a.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 09:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751993049; x=1752597849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3VZKuAlxi75Rn12eGDb5b2eYwjOnft3owwU85zuZnE4=;
        b=ZdkHhgUqb8SCTGGNzyePchbltHJ3RpmN8V8S19IGK4Jzo9j4YPtpZroWaaZoi2dmb3
         unlPgTqY9Do3Mr1ileVfYR1XQFXvHpyu0fUhBQA4oj3u086Y9B4uWYsPAGprR3TkU2dk
         Zp6HYyJjluXMmB2DVc9uGCgpC1jj3jmLfOJi2JOXDReLq3L6wj0Dk6F5OswNTAwo6Dn/
         Ga5fvcAU2j2fMXsm8jt9P0XjUT6Jm1hKwd0DqORTo1fuwq2usQ8itCTy49yToBVQMEDA
         3jmqFbFoBL+0K+pTGBtQ4S2JjW1lSylVP6mt2Q5lk8oTUe+7pMF6AH+oDURZ4gOLd+By
         TxHg==
X-Forwarded-Encrypted: i=1; AJvYcCXdq5Bh23fc1BRjPVm+uhSJ6iTA808E7StPMmqu5qH1xzLnGl1V+7vNniQxWNR3M1h7WBTUlo7KlnZhVts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYMsi4TKxW6OLSr6cnWO2iwQWnyGs58j2hrKvVBV6p0iTtPqsD
	BlngiIqTnGIfXD2DcR4tH9Udi0PNDLJtCCoeBL1I+QguP8A0UhFvNVNAm1fvAZKxhAWUkUTkmdt
	ZEQIh4wBRyl5HEerroIqXi+GyZ/CBwLdqopEtkD5mi7+eVUIEnXfY7UPL7zQPUniWBxSI9R29PR
	E=
X-Gm-Gg: ASbGncuu+Hm+908GDHv2bZA3WOiYynSC8yZi01h3+nPQdA0swIDs1GhrVCaAXY3q/6V
	PFg8bfiLbu/87HK9lAgGlPvekP4PFaQ2zHvqRL27xSAINYeYAdJvdJ2iAawSwYIqSy+VTDaJxFx
	JEmkzERPoi7uM6MJpcZeuOvVs2mcce8MY9PHiVIt6zbFgnGLe4d19Sy8CWXiysJxduMNg60sgx8
	x05BLq6hWFdALvCdvJM2jhbz36LcDUcUe+uE+tBILNkmPgTWfzX950v6UC1pFitqSnQRRZD0IqS
	bEoOHnHLx38E64Gw0XG+UrNsFs2QXltYhgP3E8h+jfw0b2aR8jKt88QRZazLvJUiecF2Xvv6iky
	8ujY=
X-Received: by 2002:a05:620a:2944:b0:7c5:9ab7:3012 with SMTP id af79cd13be357-7d5ddc50daemr801621785a.11.1751993048895;
        Tue, 08 Jul 2025 09:44:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMwGjIfNhpihUDcfvAlJkrfYY5TjG6OzWzgm3+25npy8cmSQsjF2jpVNr98fOmzv2zvx9/VA==
X-Received: by 2002:a05:620a:2944:b0:7c5:9ab7:3012 with SMTP id af79cd13be357-7d5ddc50daemr801620485a.11.1751993048528;
        Tue, 08 Jul 2025 09:44:08 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca696480sm7566674a12.27.2025.07.08.09.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 09:44:08 -0700 (PDT)
Message-ID: <cef8c989-4a0a-44dd-b0b6-15454f98193e@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 18:44:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/28] interconnect: qcom: icc-rpmh: drop support for
 non-dynamic IDS
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
 <20250704-rework-icc-v2-28-875fac996ef5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250704-rework-icc-v2-28-875fac996ef5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=686d4ad9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=SOFPeg2F_ukm4-QWM7gA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: ShuGubLbM-h1_E_mT6kKy3zfn9QjQWwg
X-Proofpoint-ORIG-GUID: ShuGubLbM-h1_E_mT6kKy3zfn9QjQWwg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE0MSBTYWx0ZWRfX9AwsKMKlQ70b
 I1wB9jALZUzgurInsKCDTR5f7ugb1L/7LmcPeqPOXn209R8YQ4v8k4PblZrEfvhf9AS6o3s3aGH
 cC9d+zIqAA/9A/GOSTqzHIh9uTB2k+1OCdfb0kD5yt3AvzWdd9HQOu3PPdBJmEJQ8+0iTz6S6Y7
 uivC14gbMlH9yMZPhIeR7KWdAGpbrwticgvh79gMZw1OATa7pEqanrBFFu+iW9xbg3k5YT3/ltj
 N+1GomkT5gCA7zdR3mLIF8Gl4oRtQEWK/BT9cl4SyVl63622Rq5bsN+shgHK+r2qPtWGLMrWfa1
 pCY4Fon7AiTpOtkFk3bC06wDEIulNYUt5KykZz7nXBVshhG/EiO5jbjbK42CddvJwEQsXoVvci+
 iA6X/OkiE42tK/5j0U5ZAQeGPtHiZ7iNAvQD56LG88tmGteqM3HqSJkltU3WW/8y8alBj5ob
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080141

On 7/4/25 6:35 PM, Dmitry Baryshkov wrote:
> Now as all RPMh interconnect drivers were converted to using the dynamic
> IDs, drop support for non-dynamic ID allocation.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

[...]

> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index 941692cbaf208c66a27dda2e6902b2f26f605840..796fba9fb316cf58ae2eb77af1607d6d00c38438 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -280,14 +280,10 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>  		if (!qn)
>  			continue;
>  
> -		if (desc->alloc_dyn_id) {
> -			if (!qn->node)
> -				qn->node = icc_node_create_dyn();
> -			node = qn->node;
> -		} else {
> -			node = icc_node_create(qn->id);
> -		}
> +		if (!qn->node)
> +			qn->node = icc_node_create_dyn();
>  
> +		node = qn->node;

we can drop the 'node' binding now, I think

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

