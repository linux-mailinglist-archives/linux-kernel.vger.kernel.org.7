Return-Path: <linux-kernel+bounces-838575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC0BBAF994
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0841940F95
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01168283C9D;
	Wed,  1 Oct 2025 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UDwGIaN4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90AE27F4E7
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759307060; cv=none; b=CQqqExP7GKrSQB/igXytxOiRGwd6mfM3Mlhu4wjX3joWY5j84V/nOwSiomm06j1c1NZJ41WdHEjyacHOvPQyOVDyM1ZbV17oe0D1l10oPGCLn5xYL1vK413mMML9Zb4hH5z0ULnVPwzd8K38EpzGMluD9s3GmLIGCZbzAAqu5iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759307060; c=relaxed/simple;
	bh=2C9amxCrD4gmuZzRHFFROYAejnvb5hn0iAbtlaA/Ujw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+v/o7oCrXSmT4hgAgTASD5PWCzcSfOq6eB1bR03ceJxZwRFBCrZcNLsfQve4gZ3wc4k1AjUIK9pKwxaHEImCo1iEpt+61EeFrUmHP0z1JNxscb0P6hq6cBXxWY/BHbsV/pqCD/EiO8Q3oxgW9Tyl+tbkYIs42zRhSiiNUD/nqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UDwGIaN4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UMJRhS016878
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 08:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jo9b/6mPaEeK5PkbErgGIXrd32k0mUaxbolG0MoaK5s=; b=UDwGIaN4ksh9PcZk
	GXfb2oEcQ333hHiy4GgLWyZSIVW/irxtve1zYmAo+fdXDWic0m/jI8PlrmNroZFg
	miuJrsaTzjVgFo2b4JGjqEHIBanHjhyQc+FAsNB9PHfx8pqQ9qBaUXG3uE2oPURJ
	5e8idrwC9x+WFc2UN1K1ALTuKMaY0N1FVXu1RWrN7M1VSghlnUUBqISONRO1pHxA
	PYcjd8JiPzYh0XHSSQESCFj1TP6nPVdQtyLbXFH31dtpb08Vyk0dn7KqFmVLQSl6
	jo2/xvQnIcpQVbEej/+GA4nv1fdyeUCLaZ0d5QvxW0kMsHNWAdEFxxNqqDTudw8g
	4xPogQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hkjdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 08:24:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ded29823ebso12771871cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759307057; x=1759911857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jo9b/6mPaEeK5PkbErgGIXrd32k0mUaxbolG0MoaK5s=;
        b=wcHonh3S3vqnRv2kBr9ARwZ6/TrqxppqFTNvBT503r0Dh+rWu3yy/OxoI5wMJxEFMV
         /4eb4a+q4jOISG3T+5/AJrV84o6jiCfCNHp01TH7FEK2V50slM1k0sc92n3DmthH40vF
         dF8PUFofM37EfZo6+VghL6F3OTkahpPg7XfoueaPgge4U/MgIdYuxIpAtxYWU+oncrse
         jZIPD+vTzwNEuPKUqRXNsv4DHN8NT55eYdfztY3aKk8Jnuq2MYjAKAratPJmH+dfeqgE
         pNW4+REgYRnxxWasqbtRbahESuLvqglEH0+O5JoXj4eP8NvVDu3H1+Ow7ZZmjsJk7oUA
         58uA==
X-Forwarded-Encrypted: i=1; AJvYcCWaGY9m5a13YaZWa/Ye71jx3W9kYl6Oc9jI2Zr8rSzOHKZJ0ubYgElH6cJ1idRuEW5piPBw8+X0gqFk3sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE5hWWH3drkJvVhMDrVXn587Ml9Q28CDfyM2HPNga72BT4CNzu
	lqvSU9Xiw3gJeFyHYmG1z9wapuKHx8N4KTFt/WcON3e3JshWmwgiK94bJAEGeJSEo7fgiJHTNQT
	X7FWkg/qyGIkd54VF2fea5ZWqGsSei6PkNS9bSf+djzQIoLzlhxZhefPAJUzpAfosazM=
X-Gm-Gg: ASbGncvE8Cm9q/Sc01k6dQJV83xMFUthOZx6ZVW4ueaSpEn28SZaHdncPpLHaF6FzEj
	0YkQLjvoiEurLa+z2LZcEL1/BM9qHaMB44t7YkoBXj5sLjKBsZ7jx2FtzILqqVF/CffE6ycqSLS
	Cz4hVWQTYXXQAIduIojp0idpv4XfeeGjjFKoqlQccxg0VCFY7V0tjP1mX2xBjrne/C0nRjc1+Fa
	HiX1C7z1RU1OXkrk3WUuWF2Ce22s0LPorWaqmjzcOWc9S/nRUYR1z/6rSQRAzFhvRchbXhDmXgL
	8l6Nn6PPVFMgv5OlxRgjEGkwS4DvCB7WAZNGGw56rZNYVzZmdSemMYPkYMHXgDTcO9i65R26UTV
	JnnS0S1592uGjniT5pXmReX0iZhg=
X-Received: by 2002:a05:622a:1a0c:b0:4ce:8b2e:feaa with SMTP id d75a77b69052e-4e41c5470ebmr20268221cf.6.1759307056664;
        Wed, 01 Oct 2025 01:24:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4EwFukVUgInauIpgABmEZOY8yZJgYyBZcTIW1ccuqqRJmcHUXlbWU9gHnVB6KeRteTgKJ3A==
X-Received: by 2002:a05:622a:1a0c:b0:4ce:8b2e:feaa with SMTP id d75a77b69052e-4e41c5470ebmr20268001cf.6.1759307056025;
        Wed, 01 Oct 2025 01:24:16 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353f772528sm1320320266b.37.2025.10.01.01.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 01:24:15 -0700 (PDT)
Message-ID: <0d799aa3-20ea-435d-9c56-150fea07aa49@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 10:24:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] arm64: dts: qcom: qcm6490-shift-otter: Fix sorting
 and indentation
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Alexander Martinz <amartinz@shiftphones.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250930-otter-further-bringup-v1-0-7fe66f653900@fairphone.com>
 <20250930-otter-further-bringup-v1-1-7fe66f653900@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250930-otter-further-bringup-v1-1-7fe66f653900@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfXz+P4rqaLKGZ5
 /ag9pTFi9tHO7vu4B9pYccYqshrJdcLA/Nkd5JIhLlwlrXcnFZY0HnXvut+baYeCuqLeNbtut4c
 8++N3E2d99qvhlC30UBs62orbToUuy8iJ48CLUyg0BOwgRmbRu9zK27Uln25kRhR0gE0FwCMJuk
 2ZEwgvivKWN0H2pYLe+wu4rteWSDUEFgWEbhQ9aDnUtTLL3trDfKyApbkmIJfpPOHZRNVDU4Nih
 +O3I7jMtfzbafuGFNPhOKT+NOrBBK8ofOvZz5yUn3OcaecCuJyZP6akY74Z9B5mTi1gPkyeU87t
 A4SOy1TrXXK5TeDkCWqLIfSZUcH5N3rYcccGYkOKqBaX9bdWI4mcbLUtQhUPtQKoQqkdIlwBWTZ
 izwntyFfejSq4IG+NSaW4MDj8y/Zjw==
X-Proofpoint-GUID: d4QbDfmEdVtchnUB6URg0JFVwzA3Dphm
X-Proofpoint-ORIG-GUID: d4QbDfmEdVtchnUB6URg0JFVwzA3Dphm
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68dce532 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7Ovdx5uLAAAA:8 a=6H0WHjuAAAAA:8
 a=EUspDBNiAAAA:8 a=Q9X1YL7jsAXwpJAzmCoA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TQZWkJv5rNK5-PaLMsrg:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041

On 9/30/25 4:32 PM, Luca Weiss wrote:
> From: Alexander Martinz <amartinz@shiftphones.com>
> 
> Make sure the nodes are sorted correctly, and the indentation is
> correct.
> 
> Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

