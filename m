Return-Path: <linux-kernel+bounces-832434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48304B9F4E3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9E13847B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EFF1A8401;
	Thu, 25 Sep 2025 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U3fPaKv+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0886B1A76B1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804060; cv=none; b=KiOvaAgQkQXyW9G5K3xad1MCiipF23pWRJDrLgsz11Dn0t5Yh6zhL1SE1RYiG4oUfAQgGENATCYX8XJ0vDIOJkafCSeqxXs8kpGqJX/jFEu8VVIVIiKEYUHDsEn9SlgVwdwtmIyOZ2XYirFjaNVyt5H00PMyP5IpHbbDXFF+Jrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804060; c=relaxed/simple;
	bh=/OW6lUzbxwLTin4WGTyiZmS+jyErbQBXnuGUK9x0WhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fW8hNUE/llxgbNjcholoJWX5Rs+QIQAnWoVf3ISc6hxtDdlxD3T7REgCEeMc/gv2P0/wiAkV/nUqCNDuXPFpPVqbG8nfFgKh7unAvTt/E+FbRagCQisVCnvBUkSvJCR+sJ0BtTMr46iqn6XxZDyhXQMxxpmTj99o3SZ3e9d8CmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U3fPaKv+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P4aWdP027688
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dX+D1iEBGYVg/0mxMRj6tDbZ+sqLumaACcaW1rJwVnE=; b=U3fPaKv+C8fOIdnw
	t5i1BryuxendNApb3lk/owoc6A5CE4t0vAa3NI8mDAAC3qHAVtaBhSFTLGqNz3EB
	tP5g8V2xNQetfm3aA3RrP9O8h3w0TkDYST0iHxwNh9AXOGN6FDgv0BI9KAF4OvMp
	TGTdXl//VhIgrh4BNBU8JjdVMq5s80ErxArZOVk6paM2Ds+3JSbCQTWTEHQWR0oI
	0M++lemmEHjGYwkgjbKZuB6E8HyGadPzrIM3kJ4RKFY7E6NxkIsdzOc0lrEPdxO1
	DweyXwInQwxYE6A80i99eY93gkQFMz9ioplLTHPapeY3OJd6mpR3N0K3+zEOtyqa
	W5jaKg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49cxup1a9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:40:58 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7f4bca2f925so2118726d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758804057; x=1759408857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dX+D1iEBGYVg/0mxMRj6tDbZ+sqLumaACcaW1rJwVnE=;
        b=Goe78FOsOhCuXRo4D8gnGpQH7T/uf3/qDsveVvjHPXTQD/Px17QNEH3iFMpYJEI1vm
         mH2pL3Hchyj5dQGqHQnWty/mXBESpZ0xInAo6yutnZuLVF3wOqSZBdnz8SvLoBzLlwWo
         p/arLu2oI7kcXwVxeAz2Ve5zbl7ryXTP3WPJZcr5/Ut7RD+rau2snjeWsCInt7NC3L1L
         PfhDzcxHp/L+KqANHGKiWo5c2jGWqGBA33dA16S3PYwzwOT2X6jBWlWarVz2sCiUmdCS
         2WUJpV8jKwnv9FlAY5eSap6pVh4jBdlq0cpMpP2vMM48cYPXcR0pXKLvcYcy3Lfl2u4T
         4Bfg==
X-Forwarded-Encrypted: i=1; AJvYcCXFIdhu54p0bld8NDQv3TadSXP8sKthIRNRGo+ZbKHjD3YFTFwqTSvNn66YCpI9CYYWWvJgG3JDSqJUWHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU5I6/Y0ZJxmcbinryLCJSjy24NhNRiCb9YPxP/QB1dOk6NpQW
	dB0EumgzF5sa/thWWiJZOIbj3WwktpFjkp0QLg4jHoGQw3gITwYfrysOI2+MRZwN1N7j/ys5U1K
	u3f5tmGfsuppKfeHOaQXwvQfiPmuQ4F2fMXGZWLTooiMm/pfP8e1l1q0Ube+Ald/IuF0=
X-Gm-Gg: ASbGnct7XVvVXiqv9Hswdi3XB9PjdVgIBAE3RIgN8hCRl6f5FSgz7qa2+Q0G6u5Uykg
	+oxivQ1kyYh1C84AbSMXCEZs0U2Q322+M/jIetqrJ/ydsCjFZ+dj6d2ZAifSRkpk7z6s2sasWn7
	ZiQoB0jjrVi+8piJfq2qaUh7DkybdaohXU1kn/lfk2Bdb0ckQpzZ+3TposBxkzGfk29koUPVHQ+
	ef3f9p6J9r87RZ1RjUxidIGnEx+K6H3Y9fV+X4mILETEKXh5Y9iw/o0YahZWBzlAMXfRJB+ypWM
	wFIEiuEblh2o8oh4RwYKW2O9mS6uF+jJkAls/LV9g3/bwvbCcxr3SD9QdD0f8MtpvZmeKCqIXwE
	sX1xOo5dPCNSFQbKe4EcgNw==
X-Received: by 2002:a05:6214:ccd:b0:78d:5496:9c37 with SMTP id 6a1803df08f44-7fc4517a623mr30484346d6.3.1758804056886;
        Thu, 25 Sep 2025 05:40:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXVJM0xECADX1ZAwjsmy3/RHWCnfUiY4Eb/4L8Ww/2YsN/Z1WGetVGzxOOKsKP6XRMousjmw==
X-Received: by 2002:a05:6214:ccd:b0:78d:5496:9c37 with SMTP id 6a1803df08f44-7fc4517a623mr30483966d6.3.1758804056184;
        Thu, 25 Sep 2025 05:40:56 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3af4cccsm1148079a12.37.2025.09.25.05.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 05:40:55 -0700 (PDT)
Message-ID: <f4e7a388-54fd-42a7-8960-be6a3de7ec6a@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 14:40:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Kaanapali SoC
To: Eugen Hristev <eugen.hristev@linaro.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Georgi Djakov
 <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-interconnect-v1-0-4c822a72141c@oss.qualcomm.com>
 <20250924-knp-interconnect-v1-1-4c822a72141c@oss.qualcomm.com>
 <ea291acc-bfdc-4a04-ba60-fc59a55ada28@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ea291acc-bfdc-4a04-ba60-fc59a55ada28@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=B4a50PtM c=1 sm=1 tr=0 ts=68d5385a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=o1Okg1vRPMB1M1hlrKAA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDA0MiBTYWx0ZWRfXz/vzC4wQEa1q
 oMrJDZkAyqXnDy4VRXzy56To9g/1AcDuznL78rAXrSgP7PhQmQR2GXjNLn2d8/3ZaMO8AXSJVkF
 vvyss3hHvkGV42szINaXKqOyQY1tgl+00B+z3fGJB2u5dnIrU5rvos8vOhwgA8tM4qhOjGtVDzE
 uPohm7jOsA2sXyr/LHxCLV6McFecA8aAxWp224/rjaFsIvz9gSTh6p+K5gURubvnTHXUEdq7yog
 8iHBcMr4GTMc4eZIFC81NEVql/d38In8fFzRJJSQd5dUFWdLI0U6z6bqScF4ZjQICkvVzSSlPBA
 QDPBAioI89Z4Tdnk+7KR8weDjBJ2gLpbUoSP7pvK8oGHpVySef8VVBveoV1QJKeveLU3ZXIpx46
 KQtYTy92
X-Proofpoint-GUID: 5dvQT6mokcAzXDY4q3MERxE2zopDus_X
X-Proofpoint-ORIG-GUID: 5dvQT6mokcAzXDY4q3MERxE2zopDus_X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509250042

On 9/25/25 10:57 AM, Eugen Hristev wrote:
> 
> 
> On 9/25/25 02:02, Jingyi Wang wrote:
>> From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>>
>> Document the RPMh Network-On-Chip Interconnect of the Kaanapali platform.
>>
>> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---

[...]

>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,kaanapali-aggre-noc
> 
> Hi,
> 
> Does Kaanapali have a single aggre node, or there are several ?
> On previous SoC, I see there are two (aggre1 and aggre2).
> Also in your driver (second patch), I notice aggre1_noc and aggre2_noc .
> It would make sense to accurately describe here the hardware.

They're physically separate

Konrad

