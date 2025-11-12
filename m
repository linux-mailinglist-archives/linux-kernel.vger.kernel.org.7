Return-Path: <linux-kernel+bounces-897362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E40C52B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E668E4A3620
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972BE274FDB;
	Wed, 12 Nov 2025 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hlG5U3To";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LhnpbhDB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEA1241CA2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956861; cv=none; b=NS9RxukibXCKOTorJGvqLDHlj3VeDBRluszuH33sr56GMr6FPzYqTvp7xfFG/pXTRt2wf/sSGDbLiq6U+dl7D//pT5ajkzk+Cu+7uy8rwVUdHQz5dvg4YeYp6orgZS3HSkrH+3d3mnzS1n2urCPH5BnulEuMBcQWmhxjFxspAcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956861; c=relaxed/simple;
	bh=mM9fAjOXXwht9yAdsure33Nqj9S+xcHDp8imOVtYD60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOKw9qiD1XN2/agTLr8DSJ2d94/agKzhQPpj1UTSuJhgdHBjFLfrWhGqw2pmDyjSj3+gJwOkzqDWQcpFe9kaHCkCYLaW0GHDNK4nG0s0Cd3zLAvhrYpy55M+tuvCHrPLYt0D2jTQquc3Ce4RmaKa5yglSFR4OQggdjS6eI6c77A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hlG5U3To; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LhnpbhDB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9Wx6u1001741
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aTbuJi3FxUPkkWHKpmQ79xCiSdbgLHZBGK2oKYcauJw=; b=hlG5U3TohjmX4ClM
	fRmUhB+jeUucmH3r8qCOseKTaySRZtmTOBvAGRJ4JW6aHkxhslDqAh1XYSiSVsFJ
	po5HZYh5AADDR6Z4WO7Axr5BsWoJ2VyhTuSAHY/9YiM+SdG/rmVza0f8IFvAG+bh
	3l0iqhR8p1IxpWG2ZXDKCMp0KvZlpQOzvbUdyg5h0TcKoIF746oQCeM7MPK7aVuh
	+UJdwm2fheTdiC/BuI8kT5Na7lwwmJ0fEVvoZq3XER3k65xnr6iIyjFWuT3peoJr
	CNgR/jZ2qMG/34Ij/Zk0TVSaKhq1legtEY2LqbVeV6oJfFKz4OzDIkfy1zz6R1ET
	6nMgFQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqq20u8v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:14:18 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed861df509so2547301cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762956858; x=1763561658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aTbuJi3FxUPkkWHKpmQ79xCiSdbgLHZBGK2oKYcauJw=;
        b=LhnpbhDBP3wcE/EGj/ZF4kNxJgLT3foJ+EjG9QN/spzO2eJ2tdcLjEyxOj9cPu28WL
         HDtJd7QjvsJNaU8sSPKjGmpbhwE78UZtMMWLTYyY/E4JdIkDne0sHDmNqm3MZzg+ThQI
         9WMAnQGLDo35mpmqNTsuYNkBznjloYo3vdswBYKcWP5gtFPxHrCRyqr4qto6sKdUnEYR
         NfctJj/Y/QSDXJfebVIqlYBHfOAwHpVlA/UHCt28iJp0lrkfcFLdBzgRNSSKpuK+dlv0
         bZzIySOkOsCjTPUmDdPQPjeyVE4u8LB9m5v1ixxOKKTcNcbqTFWV3nhOM8xwkml/rnFq
         dODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762956858; x=1763561658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aTbuJi3FxUPkkWHKpmQ79xCiSdbgLHZBGK2oKYcauJw=;
        b=GH+ZQd+f2S5HKmrA7D+20D3jGGX6h3My0dynoUJ0bWnbkdcGz3btaRsg7U/T3FFzT6
         Ev7IpWIs+TrUdDqOYRUio/wWW8bszl6pT/wK1z+dUpZ7aAh8DuJYNy7PK/lG0FYGnuF3
         ve3/gLuFzCFI8Glbjho/ZwZCfLJjKZeacPae7Sm09fXqsy4voNUIsywpu6OtVy9YwElv
         4SwiLlhNTNpR+05le9iqPNTLj+dOpZpwKLvJF8K7pSOnElaHp/2cjwrAA5WRi138FW+c
         gwWPfBNX5yn4UDVqOy/xHeW7RY40hKNkLkTYA12g4X2lbNyLwE6DYCTIGrJq/xWSyexm
         biiA==
X-Forwarded-Encrypted: i=1; AJvYcCVAoy9J4flEFg2Nkfpnsxm0oxAiZybGghHzEcECv6Nflw3KETJVL+wl9ALrm+CJXVX3f8Wjq0qQPl6JDSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuaU4WDD/9qVhrQmXffp0ALR5RKqIg7NcSIyo3ns6zkbF5hwWl
	jOijXylDZTMS09gR8UgvstzwoPlNVBaJC4iP4cIxx7Qtcw6ZvdLJpYQHA5eGZIVTtVnqpyToErl
	svm1vDaU8ncAopYiFXmHyMI8tq1DZ1OLsZMvocFDDNELdbfgtTGYRD32cnHm2WzbJFt3MIcbf1K
	g=
X-Gm-Gg: ASbGncvy/TpOR2aYzRQ41wzMzowHyIBXVOma6yKbR58MjCfpKLS8yr9lvO3ehGVkSOw
	BEoas/m/8LhPSlWeo9w0bny05fnnVP8sgS6ne+DPV4ub06/hBO/LGWotqdPJyp/ypMnP6U8g7Kw
	wsMrQXjem5ithb3M9W56AhgTBAtCvigkS5GQwoG0YLJdiMzcoUAntsAStTsmBxBvnQqi6DIciLg
	zKK9Wm91YO5/QxAPAk1j2J73U+tl+8dX0q+ceQEtRbyrjJfzcmUGDLqM+BpSGe3UMiJOWruzP+F
	KW4wtPM/yP0xFc1VITF5m3hSNm/wVftN1SBxhNQQ2C7FbtM+eQ0Q5QICV/9rEXgP0PFME+JjW2f
	bULvThjSwSgwnmeNx6NzBGHd/hc6KYpe+RjC7gjzLNTjER3jwDzSzlsxz
X-Received: by 2002:a05:6122:3714:b0:559:ef6d:b3fa with SMTP id 71dfb90a1353d-559ef6dceeemr260923e0c.3.1762956177632;
        Wed, 12 Nov 2025 06:02:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDhrwzbfO9vyPZvREpumsSUOwwsoGszLlpvZhnJmg8bsJRAFxwMnbB6qzgmnQ6CjNSL43L9Q==
X-Received: by 2002:a05:6122:3714:b0:559:ef6d:b3fa with SMTP id 71dfb90a1353d-559ef6dceeemr260791e0c.3.1762956175682;
        Wed, 12 Nov 2025 06:02:55 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86e9d7sm15873200a12.36.2025.11.12.06.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 06:02:54 -0800 (PST)
Message-ID: <02d7c0a9-0d24-4fd8-980a-da9d7307588a@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 15:02:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu: add actlr settings for mdss and fastrpc
To: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        robin.clark@oss.qualcomm.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, dmitry.baryshkov@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bibek.patro@oss.qualcomm.com
References: <20251105075307.1658329-1-charan.kalla@oss.qualcomm.com>
 <eb596f7a-e13b-4edd-8ee7-05424ea3d9e5@oss.qualcomm.com>
 <c4b1df46-e4b6-4d95-971c-7aaf33bd35f1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <c4b1df46-e4b6-4d95-971c-7aaf33bd35f1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EbHFgfmC c=1 sm=1 tr=0 ts=6914963a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COuKgFje69h7aUJomk8A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: YvNYVBQ_3if5GpCI7YmvM4P29LKlEFs1
X-Proofpoint-GUID: YvNYVBQ_3if5GpCI7YmvM4P29LKlEFs1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExNSBTYWx0ZWRfXwdZWdXggrXxw
 6CsRwjvLnvB1IOIJyxjjtSJThnpOlX2RSxOjs/1XgZEeuf3qb65FaaRdoo/dtN9zJbSHxBVLLKG
 TJJZzaJMwR78DgZYFmJdpgLE9YecStI10DOcoPYpuDHx+9ztsvj0O06uDKd2lbp/sgX8fjrCpub
 RYlsGV+4/gson4Dgn/XlB9Wgmxkry+XUe2AAslE/y9YAB5StJkglXNZeD1t2Vz+P/jlwb3Ubohk
 WtmrsCiIreBOdLv9ZCJotphk2plUuRXM4mGZWm99YGO9mxpHEW+1Cg31aka2TroV+Yb6wAwcE3p
 ioo4rwRaR/JwsLL7ql+TvOPJHsQjjnM/DWmCLHK8qNhgLBdcWQphYSMakUJJs0hzXHtZP7D4mfB
 61dT/NFegmV8wPT+FhOCYR/eTlGDwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120115

On 11/11/25 3:02 PM, Charan Teja Kalla wrote:
> 
> 
> On 11/5/2025 2:44 PM, Konrad Dybcio wrote:
>>> +	{ .compatible = "qcom,fastrpc-compute-cb",
>>> +			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>> This will be globally applied to all smmu-v2 targets with fastrpc,
>> starting from MSM8996 ending at Kaanapali and everything inbetween
>>
>> Are these settings always valid?
> Oops, you are correct...this settings are not always applicable it seems.
> 
> Example: lpass compute and cdsp compute node uses the
> "qcom,fastrpc-compute-cb", but it is for the later that ACTLR settings
> are valid.
> 
> Then for these cases, should we be extending the actlr match array with
> additional compatible string and then add them in all the device nodes
> that require actlr setting? example:
> 
> @@ -3119,7 +3119,8 @@ fastrpc {
>       compute-cb@1 {
> -         compatible = "qcom,fastrpc-compute-cb";
> +         compatible = "qcom,fastrpc-compute-cb",
> +                      "qcom,fastrpc-compute-cb-actlr";

dt-bindings (and especially compatible strings) must not be altered solely
to work around a driver being suboptimal

But because you reported that these settings can change both between
platforms and instances of the same devices on these platforms, we could
possibly reconsider adding ACTRL settings to the consumer device nodes
where they stray away from the otherwise seemingly reasonable baseline
we have in the driver so far..

Or we could introduce some more bespoke matching logic.

I would like to know more about the scope of this issue, i.e. the matrix
of (soc, device, actlr_val) that needs special handling.

Konrad

