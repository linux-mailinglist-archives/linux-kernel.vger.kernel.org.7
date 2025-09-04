Return-Path: <linux-kernel+bounces-800748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B27B43B88
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21DB566722
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB1E2EDD5F;
	Thu,  4 Sep 2025 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HnH2Meh/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BD42F0C4B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756988833; cv=none; b=udMh0UEAm7sFaxxQaIdxg+KFLXEtPk8yF8WKvbvJwBCKhBx7J/0zd7Dp1fo/yN0lsPZJF30J3s7Bf+g0zljJxC0KaVRzJAxPSHJQu4rdJx3HfU0bXU8o7tfzsDyZ0Od52hNKHRo7h2EPdqtlxg8zbsrT1mF2L9YYtQtF+UOtWZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756988833; c=relaxed/simple;
	bh=f4BEDTpaIFxgOxQCFGxUUhEky18+3IyRDrYj23UF1v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxBmhmlUbDLpE6DTDgVkq2J9f5ayexRRxzPRqzj3Eb66SBwEfrXtkCbNln3hWrNsDFyyi/eCRGFo0u0iID0QUMe8FT6tO8PN3Dd3p/nhAVzCVK/zRBk/3C7VR08M1027pZ6UMLI4szflu/7eoMm2hqUwLPlP2+04HzqurTI/n+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HnH2Meh/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X98W022174
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 12:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6/8bBRQQfSsfRGQAqYBd7sJUcBVC/hns4We20/YRtIY=; b=HnH2Meh/0Ulpkx62
	sbUWp5L0yXnt6vtFSgMk1l4jfGQy3S9u+q722SZ9shJeGOStOTAoyHNWSIfyw2zd
	qvoTRJKM7DKvBlzOWCNolNzyNU/pALkyt3Jdu31MOJskjtKbnPZLCSIzaukl5Yxo
	5wIR7nh35jbjSD/HSL1/35w09hJ2Vi5018Vj4SteG06IKw1+/3kvT6DzlAoSegDE
	yn3MeJFyCexFNeaYcl4AWIHmRuba7ueWRCPNtcLtG3nTkP32qT5YWGLedGoT/Xj6
	+rffLJP8ScZmmDH1iYc1bc3ntkRzZ03LxXfdAxs2ebLy6ER5b27N8CCSR9xOp68L
	48IZyQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk97a2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 12:27:10 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b32eddd8a6so1732811cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 05:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756988829; x=1757593629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/8bBRQQfSsfRGQAqYBd7sJUcBVC/hns4We20/YRtIY=;
        b=c6WOAch9hegxtAAIgQJtRp6LhpmXmJ5829hGag3G7JYU+EwMzaTAtq6zSHY9LgTgz5
         mSM8imtmsC9sSYB91X1//lSGE+kfq2tZ0VfMaRgtrkGdNlp3SuP2MLPJlZ2RAbRPoxn7
         AWqfr8VpUI/TAINgjRujqe37LBrXNiH41N4Lo2vUg+tO7zVZE6BP02jG4jZqJyQAjOZU
         +HNJN2XagA40EHxmSwbpthRLSbjsl23UMZhMc3+eTChtEhwIFcXBHYFfigAYuLjXC1pY
         nf5zJ8AbUoZoKoQq5qB9zd3NEJxBfZrHAJFvLJkHmLyCAoH7ShTA6Hctr/s+9CnoggIh
         ahrg==
X-Forwarded-Encrypted: i=1; AJvYcCWTAR/o01sndC6xLxO94aS9xgp3zebUrPNq/7EjpzEYBXVwN4/wyjEM2IeE+vMBQ+uFEEItO7GPCuSqecc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFZwhqjNdJB3aP8oF15FN9N0pGBFptlwJSq2UdZ31dCYgVQhtv
	r4JurGwFGPfJcegOtWCFFB6HLwEhp3/byVqiEAqqY5R9/jO5xJA3qVSP+2FSBoAmV8L0aRijdCL
	Ygc2ESz5iSfCBWAvwusSr77rKj3u7W4OoE62PAW/19tm3MguD3gkzcIkbCwSz/c2sGu4=
X-Gm-Gg: ASbGncstHu4P+yXyO49rxhHmBOgjI2jWwcYsiAZSRtCIJlRQuv0BzJYpLOZ6naD/RCD
	D+sO+mwe1R1AXXqFb+T5zYcmsJ3KePIUUZjicTDkdiLxJddZYr4cuO8yD+Q5l8UtZKqefi6cbLK
	mKAHi1scjPMDgokYNjuKN1uqQAxcTQeTmYl2m1apK/+djoDCLP+16La5sQtYhT3o1s7MI5dMUn3
	DyAgSVFcFHhHGiqt+rLaSwxDxy9S933UzR5vELtGWBdqAK/ShpF+b6ZXrtTGWwtBzrKULFotrlp
	NQJoFWZ1qCqVsDVjqcLCe5oZsDwIYpA0ATQFUz92gwOTa3MZnSEklmtwCdYsk5QA0H6d0zSPwyI
	g0iiqBo9u8OCPdLEKHsjefA==
X-Received: by 2002:ac8:5a8d:0:b0:4b4:907a:f4dc with SMTP id d75a77b69052e-4b4907aff6amr44513321cf.8.1756988829054;
        Thu, 04 Sep 2025 05:27:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7fByTNFwWLSt3Qdv4UjF2X7GxBRz0W/fUi7b1qegd+l6kiz0+neLeqvIjx1M7JKz/RF8LlA==
X-Received: by 2002:ac8:5a8d:0:b0:4b4:907a:f4dc with SMTP id d75a77b69052e-4b4907aff6amr44512881cf.8.1756988828400;
        Thu, 04 Sep 2025 05:27:08 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b009ae4f2ddsm1374396066b.82.2025.09.04.05.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 05:27:07 -0700 (PDT)
Message-ID: <d12957f0-f8b5-4b29-967c-576dadd565de@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 14:27:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 4/4] arm64: dts: qcom: sm8550: Add max-sd-hs-hz
 property
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Sarthak Garg <quic_sartgarg@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com
References: <20250903080404.3260135-1-quic_sartgarg@quicinc.com>
 <20250903080404.3260135-5-quic_sartgarg@quicinc.com>
 <6deac56f-e21a-4447-bfa7-a414084676b8@kernel.org>
 <be87fb2f-7036-4039-8ba2-63d54a9ae732@oss.qualcomm.com>
 <23c29fb7-c0a4-4519-9b8d-e68255b83a10@kernel.org>
 <a304ec1c-7364-4926-8763-8c731e461eb9@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <a304ec1c-7364-4926-8763-8c731e461eb9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JuA5JdXm1wAxm75qqU09kaYUC5ERCdKS
X-Proofpoint-ORIG-GUID: JuA5JdXm1wAxm75qqU09kaYUC5ERCdKS
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b9859e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=noZB7YPBI9-alL1Zr8wA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX4EEQqkFJmtYK
 aLKwwkmkLccbUAaHENPjt5PVmaI47ZHDUniRbjG1Qu1uSfkksJyNmVHSrtg3ubA23tr3l2ZLMab
 tM6cCpiTYHhKEPy+zeFCsCpHmsdwKsCsMhJeRKA4pHRbMRZUo6ZIkenOt3SHJF+eOWuazVRv4wt
 Gi4gJ08nJe+oaXF0tPDhsaoJ5DyHmluIG+nwuWRQehTRDUST6HN95MOqiD8iObaGf46Dg31oiqE
 NljKAoj8gIr3FDm0Nk3q7PplTB5xL8cdWXxCDqAFK0vqPfdW/T6TroiuZ+IR+v4AocHDIl9L+NA
 iKle1wSS+AOO7s8yzHRd5HrvpEFCrMzFLVFob4cngn6XxNAZeC7Tf4MobobxZnQLvquky+EHpuc
 jGbnqOpA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

On 9/4/25 12:52 PM, Krzysztof Kozlowski wrote:
> On 04/09/2025 12:51, Krzysztof Kozlowski wrote:
>> On 04/09/2025 10:36, Konrad Dybcio wrote:
>>> On 9/3/25 10:21 AM, 'Krzysztof Kozlowski' via kernel wrote:
>>>> On 03/09/2025 10:04, Sarthak Garg wrote:
>>>>> Due to board-specific hardware constraints particularly related
>>>>> to level shifter in this case the maximum frequency for SD High-Speed
>>>>> (HS) mode must be limited to 37.5 MHz to ensure reliable operation of SD
>>>>> card in HS mode.
>>>>>
>>>>> This is achieved by introducing the `max-sd-hs-hz` property in the
>>>>> device tree, allowing the controller to operate within safe frequency
>>>>> limits for HS mode.
>>>>>
>>>>
>>>> Probably we will now replicate the same discussion... And it will be
>>>> happening every time you send the same and not reflect it in commit msg.
> 
> Just to emphasize this - it will happen EVERY time.
> 
>>>>
>>>> Bindings say board setup, this commit msg says board config, but the
>>>> patch says SoC. This is not correct.
>>>
>>> Both are correct, looking at the problem from two perspectives.
>>>
>>> The bindings description mentions board-specific limitations (e.g. because
>>> "the board's electrical design does not allow one to achieve the full rated
>>> frequency that the SoC can otherwise do, in a stable way")
>>>
>>> Here the author tries to argue that almost all SM8550 boards are broken
>>> in this sense, because the reference design did not feature the required
>>> passive components, making most (derivative) designs sort of "broken by
>>> default" - and only some (if any?) vendors decided to go with the
>>> additional components required to lift this limitation.
>>>
>>> This in turn makes it fair to assume the developer experience would benefit
>>> from having the SD card high speed modes always work (with the slight speed
>>> cap which may not be required for the 1 or 2 designs that took the extra
>>> step) without each board DT creator having to track down this property
>>> separately.
>>
>> And then if you send same v3, I will ask the same. Can the author
> 
> v3 -> v6

So, would you be accepting of this patch if the commit message was:

arm64: dts: qcom: sm8550: Limit max SD HS mode frequency by default

Due to an implementation detail in this SoC, additional passive
electrical components are required to achieve the maximum rated speed
of the SD controller when paired with a High-Speed SD Card. Without them,
the clock frequency must be limited to 37.5 MHz for link stability.

Because the reference design does not contain these components, most
(derivative) boards do not have them either. To accommodate for that,
apply the frequency limit by default and delegate lifting it to the
odd boards that do contain the necessary onboard hardware.

Konrad

