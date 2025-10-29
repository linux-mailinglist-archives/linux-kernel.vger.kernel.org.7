Return-Path: <linux-kernel+bounces-875604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED358C1964F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A3319C054D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6F9331A4E;
	Wed, 29 Oct 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NXQxtgEu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OXAwO+gX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8199E330316
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730584; cv=none; b=TJOjVJyfRgbtzUrARBaTD5NEt1Iwht7xhtX4zh486Kmza8eXLfbFRnWa1S25vG3wMpdJRRX+tZP8pxmLiGV+xeYds6gjcGal0GYyN+JGeD0ELCDlUjG9auNW5TiGDeSERlWppBGGpYWXNrLiOHrnkku1TDbL7UlMURH798nKkbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730584; c=relaxed/simple;
	bh=UYOmzoEHWhM/Otm311kQJGPAd/1YtZ3vgLD1sFOSUIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mz1mraaZdwmtF0g/lXwtxnJ8AJqRaF7CZL5Wz84DU11FYoBEw+0OiwUL6AWpJZqHuh29Pa5ZwKMojDwQ7+HFYgKvjKgbk330EkW709nlF2tSblnLy4JEFZ7wkVbqaODOmiZJF12WSh+2etqnbbHwnvolgSWhA3B7ucL8hfueW+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NXQxtgEu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OXAwO+gX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4v26A3757831
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Szi2+cyDT/bu54EIm6JxagNcyiRunVCmfhWlPvCyOsY=; b=NXQxtgEuOPVwAhnJ
	sCPDqiyK5mAtMPvgvFpBPRehK8wesfZklA2d3HGoP51+u+Qf0LHwyuBfoEW7n04d
	HDuq9XVwxhXrvyrG/48EWHNqyy59OFM8FYe2dYBppmTYwZRwrVgXjQ8sHWP024vr
	vXVbckiAoiEDIqere+0qj8ysB/Pyk7TXrdaGYxMGeH8FeEW1oXh+tmWg/dnyg1V6
	smLNlkKnmCT4CFk9521epOET1jV2oXy49m3rA4e3RIdQNDhzRx7z2RlJ1r8Zngm3
	s/qx5kOq+WTHkxUMiRcVqoQ/4EFHDIvpdrmn2FNRugIy5oU4Fr/lPylX6D0/mimW
	E+Ck8A==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a349y20yd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:36:21 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87ff7511178so6388716d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761730581; x=1762335381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Szi2+cyDT/bu54EIm6JxagNcyiRunVCmfhWlPvCyOsY=;
        b=OXAwO+gXGqRyZrJfGaRMTMUao+FOl3zfr5HCwDq0hPqIZUWFwYyDKoFnT9O2X3TGOp
         yF7aGwvLtBVzB9ebLeTLfMb8EF1zuItHaQcC8tgNbc5kyMclNaplbYgffLn3laG3YgbH
         fh9p91XwgG/nT7lp+YL93NiWhmER5+e6wGKFX/CYjK1Mw+/PkZ88X7q4GMA0EECTF93W
         wgwjReGlYaXcyp8RvqmvIqF60/3HN23PZfVaj92M3QseQ6NLPAXhm6TWk3svp5/0WgnR
         rALSlAxRhgB/j9mzew79JyHmzjf76g8LQW0RsuvhjfWoMz6RhbE1uVCinOv1NfUM10mh
         1wXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761730581; x=1762335381;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Szi2+cyDT/bu54EIm6JxagNcyiRunVCmfhWlPvCyOsY=;
        b=FTAcnJrFck+39RdZLOZPO9sly3Jqf5SRcFEsT6nm4gRZEwARe3kXkptth6oll1pybJ
         fkOMtO/Hb1pms3JtD1QbmCBmMON4CdsGjoGdtYr6quJFLqLkOGMhN0YXZNL9nLKzJ4lk
         5Xntm0oo6y+AO07C1jCSep/+a/0mfvbHu30yWMwJFvcw8N2vnnc8nrKa641d02ecwHFs
         BGzmP5mDEUzSYR0C8GsFqb3cgSmJ+MwU2aF8zeycUFsFtTdHY82pzWOiPAhif2rfjtJg
         nMWFwAPNh2hE5GL9Mo7/6I7HJH/qsGxpjOtozJJxEqY8YL/+ggXIikWxt9yiP3nUpzyM
         PT2w==
X-Forwarded-Encrypted: i=1; AJvYcCVsPaazHjwj8cTFyfxVRjCXXZQSYi+RpzkEwe9Ull1YE4x9WGyXs7YR8+SBV8ck+t9fp/xDlLTz70mUtZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfx4En5Kqs8UzYPsfetlIjHMA3oXbEKHdnrzIpyJzMXmgb+Uaq
	svQM7PSI3wTQk4J7Slf5Iyk0iMxpkYyarxCAc1+UbH0YGUc49rp7FUJlAsA0YMAq/7RMC6NyimH
	8Tk2ASRmJ/jPxtZKDkOy/w+FFmsYHJQhY/afnVlZNWHDPs3TpBC530Pg9AlstVdMHrvE=
X-Gm-Gg: ASbGnctDZ0eOfW5G2AmXpNjQDnobuh9R+TrCZZ2wsmfdY/ZwlmJxB/w1tG9oCjL/n8i
	GH9Cc1sXOCK6ovK59o/ryjDUlQfjzAM4zaMHWGh/bsxFWdFQZ5JPo6LF+/a9BhiXmUUX5fWyOuk
	4qzm8JquEAmHqzwxNANi3rDhJmKSx8sNOmR5qhInHwUR2/XPuPuiyURnCX50FOWxvmc+no4CLM4
	eZ3IysVEtLeWR6vQlfFNjx7b0rWEoactJq5nCvzdSr80wa9Vyh03Rmyz0xY98dYWtyoduHg/7ha
	cirUduOsK1ActMaXxYsDr8ZkO+U2U5GxF+4mB4ACjO3VRljK3bU/IEtO6/+uNda2DDN5DpDU4TA
	oTGK24GsVSk5tq/AlDCgM3Kg06XFyCcuoXDxaZCvByuUb5C85dlgqci8I
X-Received: by 2002:ad4:576e:0:b0:797:1974:b824 with SMTP id 6a1803df08f44-88009aea9e1mr19331866d6.2.1761730580524;
        Wed, 29 Oct 2025 02:36:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVuBZ79c/NpWKonHc+yAUyHN6rjH0o+ROWWB/bbjjDrm6RsW0dRTfHljcr+dZhDp7GdwfXwA==
X-Received: by 2002:ad4:576e:0:b0:797:1974:b824 with SMTP id 6a1803df08f44-88009aea9e1mr19331646d6.2.1761730579704;
        Wed, 29 Oct 2025 02:36:19 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef82f2esm11257378a12.14.2025.10.29.02.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:36:19 -0700 (PDT)
Message-ID: <48a217db-b85a-411c-81f2-3106b60da86f@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 10:36:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: i2c: qcom-cci: Document msm8953
 compatible
To: Luca Weiss <luca@lucaweiss.eu>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251028-msm8953-cci-v2-0-b5f9f7135326@lucaweiss.eu>
 <20251028-msm8953-cci-v2-1-b5f9f7135326@lucaweiss.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251028-msm8953-cci-v2-1-b5f9f7135326@lucaweiss.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=D8RK6/Rj c=1 sm=1 tr=0 ts=6901e015 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=dlmhaOwlAAAA:8 a=4uUCe_y4pbrLrGQpmhYA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=y4cfut4LVr_MrANMpYTh:22
X-Proofpoint-GUID: r-RG7j3AgzXlCv1bNteacBeVt1uhrzqp
X-Proofpoint-ORIG-GUID: r-RG7j3AgzXlCv1bNteacBeVt1uhrzqp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA3MSBTYWx0ZWRfX1qbj+b8y5vMl
 8EXtlRef+GNjlDcL8wRK3AQ/l2XKR0hroQEAwjR5EnE8o+/HMSMBTxXgB6U0WKas4lyeW2vsOR8
 lrpv7dA3ZTktBm9inejeSudr6Dai9M0VyIwZHoZ2Bph3AWA8zLRLazxvrU2bo4KIxbk4SgoENzs
 fO8yWFyzLK2UZ+z1APMecoXlrZcAFqER8LN3XOctphmdIyIP0/yKUtvXhg4zZ+bqlhBjk4Z+EuV
 hrCH2jFIUOnPruiiv1R5UmPknpy8lCUq1tlHHOTbjrTrX0ks7EXHTqE6EWLJO5X8nHqx0W5Un/E
 RGQYSKkvOoVsdOLXko+vewBLx4TgQcivxwQ9Hrwxjac+Ex88JkBbNfifc28W6ehWFcqItxjgSEF
 LZmMOldQlGoSk+l3Wr71aFPhCI48LQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510290071

On 10/28/25 5:40 PM, Luca Weiss wrote:
> Add the msm8953 CCI device string compatible.
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> ---
>  Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> index 9bc99d736343..ef8f5fe3a8e1 100644
> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> @@ -15,6 +15,7 @@ properties:
>      oneOf:
>        - enum:
>            - qcom,msm8226-cci
> +          - qcom,msm8953-cci
>            - qcom,msm8974-cci
>            - qcom,msm8996-cci
>  
> @@ -146,6 +147,7 @@ allOf:
>              - contains:
>                  enum:
>                    - qcom,msm8916-cci
> +                  - qcom,msm8953-cci
>  
>              - const: qcom,msm8996-cci

Sorry for only bringing it up now - could you check whether
all the clocks that you defined are actually necessary?

It may be that you can do without CAMSS_AHB_CLK and/or
TOP_AHB_CLK

Konrad

