Return-Path: <linux-kernel+bounces-885031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2986BC31CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 983FB3B10B9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06A02F6189;
	Tue,  4 Nov 2025 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mhhJnO12";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W/PlGB5p"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E319246BB0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762269247; cv=none; b=oEi9mvv35CAkIGP7Saq6CBEgK+VP5k86sSz+2sOOUjfI4fddKHF6c0qRIcM4wy497lfJbvTHXFdD+2w75lSJ8GISX3retXsKTtyo9Q8svFiU3/B4Dt6wxjiuG2mKeWPjCfN+Tk8fIeucDR9HqQDK2DLeSaiedZ/auF6bAbzF5G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762269247; c=relaxed/simple;
	bh=8/+4zJmDtFF9bT+rtQzn9tR2/HcDeEdWb4dsnkPrGyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtRj4siDP2ETTNGjbrD82V/ZLTqLBWO85e33jfa4cIIli5MIs6dDUlYRETo/xXeqW8LU8FA2GcQt/oHQXwW7apk6uzHJzpcE0ougfa9lG+8eFVgTX932EuAgMv+AIzAA36kjbiZ6Q/Abn84ZgmT8hbtKDK6YgnEfSb1JHvgQS50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mhhJnO12; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W/PlGB5p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4CfbEk1936262
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 15:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pFfSUva9xbxdI+THCAG86f0fEgl35AU4ouWpOAxcGvk=; b=mhhJnO1280BsNBW/
	FiwreYgmwQG62+VU8iLU0gcoPQa6SK7nliNT3kUPVX9GSGxIDUS4L3SNoIAEIkCQ
	jpwvSKd5VqgaV/WCPULmD7kwaWOmqZZjaLqmfqkRdttmfb7bRJWYNoaBmKw0gciz
	od4u74Cd4xVG1FzN16NEOgmqh8Z7Ka4gMan0y38HasvcCTRiCjbSqGN6wVehZamz
	mreXe2hElpj7veNuEFGa8VA2IemWcdesd2CbmPV7dhLWql3G7pxz5oRLo9CT8RwZ
	NyZJQRStO2GEqI327kwIve76lNmDVuRaCyb5gV5EkM5oU0d1l3O2kUwsJmou8Kfm
	Fw4XBw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70fhub1x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 15:14:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed6317be8cso2652991cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 07:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762269244; x=1762874044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pFfSUva9xbxdI+THCAG86f0fEgl35AU4ouWpOAxcGvk=;
        b=W/PlGB5pQanmxM3Z/OJRsdC/8BoJquBMQ0icYann7LiVifgK8IE5gD8JVsUBD29tHY
         ZYTWU/BN4BLZzbsoA814jz8zpc4MdPLpUblSUI/kbMhdp5cgA+9ZhML/qiJeWekVIEQO
         DqqtBStt1MEWmgNBijiv/Y+2wl5QTPlbbz/xftxt663MjNS1ugXw6mtZL/w2Dn3UVPaj
         ZRadrnVkfIbKOIvtd98iUGksQfli2n1rVXrtj8zvx/lIWc4NBpP3DNSNr1PWUWzALaPs
         H5ky9CUz7Vfw9rx0T0t+wo+QSSk2Gtx0gHBvJbcm6REc40qlaXaPCURZMOrpylTc9Oui
         U9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762269244; x=1762874044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pFfSUva9xbxdI+THCAG86f0fEgl35AU4ouWpOAxcGvk=;
        b=VIawdftvbMnbuMJVma3YKyqWXDozTgRCtl7C54+wLjQlojQbH10JOf8Oordrl+2RjS
         wv0f/y7+ADSE9itYO764oXVosVKli/wxyxAcOEpoz2BuhY5rYS+rhRdNpSCs2Sy9OmXg
         ypiKEyqE2wwNJ/3mE9EI8D7t6FAiFZhEeTIIoCSuwvoAJDc7Mf+HQ/pG8CmU/asW3+VR
         TG+QjxAp4vdZ1m420/MS/VlB0aAl+U7C/H9sJBk+IaUR9U7NLW2W+cwYLtcZ6Ro770lZ
         lWca9O1+ji2CQPINkM32KbbYtdhM12ygI8Dx9FsNVkgJTtKL0O+c9mSQiZgJ1M5HhICl
         Ofaw==
X-Forwarded-Encrypted: i=1; AJvYcCVhwZ9smG94Ks4UkOGGVtciVZdqdi3bRT4uVgpzu18e2pRKLTgf8dXjAbUy4kbvE3ZnNzCLxxznDkHpbE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZxcuUrlVl0+Ix/jiNldX+HOQm3cIbEy2uTf000rBhBDMpgqYf
	PUw0iR1L35yKMMX0f8Dp1qLcYcaKovWm7C4/TwY2+DQwQ5wN0ICVrnNuFMtCB2JuCShna23FLEM
	cVadaFvB75/TFP2ZGzPlABYkAPIidacdaCdScPngFR3OiWtLe/WdUeeYDLCDdTcimJuQ=
X-Gm-Gg: ASbGncs+N/yNHY1rQPbyFPKD597EKQJ3ZWFhGR8Oy8i9IHr4dx5+3wWvIlaL6r2TSXt
	/X71iCGa7KrMbkBgERVgZv7QuwnmY5WRkKDqQbqcQvblOzSC3strl7RMXS3nTKJxbk/DZ0sDTJz
	lDoFupou+9coV22mIxY4rwDfacTrj5I7ujTwkt5K0soEhpxbNqPHWjb4AdaYCiNHC5XB5QIWaIl
	V1RIwGsjqspRbFzPVBLEGhQJy90RTJPByRdJu0FnCPJbRKTHjpl4cIEDvK4sW2Ydxnhlg6Xu407
	PPXJ5+ToS/mhvY+9fdUTEYnrUqgvvIcl8r7GQJyfU+tCsHmG+FQA7sNRfCCy1t2hmZcPHaealdR
	qe9sUCafnGvr+GQ7B4pZ+S3f/2Q9uXCVbIcOQdoVhGi+nM23/S9iSq+Mp
X-Received: by 2002:ac8:5ad4:0:b0:4db:1bd:c21c with SMTP id d75a77b69052e-4ed30fb956amr153721461cf.12.1762269244345;
        Tue, 04 Nov 2025 07:14:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHS0W/9yZas4NJ6FISFyMnKcUwGX/o1nwH27AD6GkQ+BsHg9y7hfmGSpNpT9iUIwkO/o2V+tw==
X-Received: by 2002:ac8:5ad4:0:b0:4db:1bd:c21c with SMTP id d75a77b69052e-4ed30fb956amr153720741cf.12.1762269243638;
        Tue, 04 Nov 2025 07:14:03 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723da0f43dsm230821766b.30.2025.11.04.07.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 07:14:03 -0800 (PST)
Message-ID: <e08c4768-85d2-4acd-973c-7b2fdfe4a8aa@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 16:14:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: soc: qcom: Add qcom,kaanapali-imem
 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251102-knp-soc-binding-v3-0-11255ec4a535@oss.qualcomm.com>
 <20251102-knp-soc-binding-v3-1-11255ec4a535@oss.qualcomm.com>
 <20251104-glaring-rebel-pillbug-a467ca@kuoka>
 <790ca394-cee2-412b-97d8-c6416b843010@oss.qualcomm.com>
 <b6717831-1840-4b9a-aade-ab2248e3f75d@kernel.org>
 <9ee07db9-508e-4c08-8f79-6ccfd9b646ab@oss.qualcomm.com>
 <6af33c1b-5b95-4efc-b429-5bfb9ee7caeb@kernel.org>
 <8cf870a8-706d-4514-a87a-a69b64521ab5@oss.qualcomm.com>
 <f539b21b-cfe8-4055-9620-4d5d8d108098@kernel.org>
 <9d80b581-5d3f-4b95-91e7-c73c113b0976@oss.qualcomm.com>
 <8f6189b0-24ac-4e24-9db5-c6f4d1bfb26a@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <8f6189b0-24ac-4e24-9db5-c6f4d1bfb26a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEyNyBTYWx0ZWRfX0cNiijPXoced
 KEQWzvDzVh7V2XtwvyPyE8DdZo4Er1ha8IGpdmcg30DxZFJqrY+zHrGflXAeLwZBQ6ovyyCADkt
 BJOLZ6gZqd5L+iuI2CT7Fa7mpFzpFi2WHWsp9lFYxTwn0xwx3SjJbVQP4q+9c90ioVyDAo6jTgJ
 akLGixFs7AzkZJ89heuiCGB43FK/LXX3/m/x++DI4VBYlXyFB4vK+tK0Xk/AP36G8E5Rm7G8b+q
 GqB47zqM4T/l0NFtnaIPV+tnCE7KmD8UZtAfbrcfzriRujNWKXttnNuhvd40G1QJ3ovn8w2t1Q3
 Kl6V6uyKAH1YoAfJT9R8RM13eotZFSwPjvwmN9Ya4RS6e00YIhYO0DzyVSoCfqjFeTNL6v5mbS7
 hpYdDPQV+/6ChaEn8ptl3+nkvW7XlQ==
X-Proofpoint-ORIG-GUID: 1tvk0PAuLjFyq4Xlnh8kD33oB4hss-U2
X-Authority-Analysis: v=2.4 cv=CbsFJbrl c=1 sm=1 tr=0 ts=690a183d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OHlQOMkkIfFZTL2-Co4A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 1tvk0PAuLjFyq4Xlnh8kD33oB4hss-U2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040127

On 11/4/25 4:02 PM, Krzysztof Kozlowski wrote:
> On 04/11/2025 15:58, Konrad Dybcio wrote:
>> On 11/4/25 3:52 PM, Krzysztof Kozlowski wrote:
>>> On 04/11/2025 15:38, Konrad Dybcio wrote:
>>>> On 11/4/25 3:37 PM, Krzysztof Kozlowski wrote:
>>>>> On 04/11/2025 15:35, Konrad Dybcio wrote:
>>>>>> On 11/4/25 3:26 PM, Krzysztof Kozlowski wrote:
>>>>>>> This I got, but nothing here explains why you need generic compatible.
>>>>>>> To re-iterate: there was no generic compatible before, now there is.
>>>>>>> Writing bindings and numerous reviews from DT maintainers ask not to use
>>>>>>> generic compatibles.
>>>>>>
>>>>>> OK so let's not worry about a generic compatible. IMEM exists since
>>>>>> MSM8974 and it only had major hw updates with SM8550. They don't
>>>>>> impact the software interface though, so qcom,msm8974-imem is OK.
>>>>>>
>>>>>> There's a separate control/status register address space for each
>>>>>> instance of this IP (usually far apart from the actual SRAM pool),
>>>>>> which Linux doesn't have to care about.
>>>>>
>>>>> Just use qcom,kaanapali-imem - that's the first device here without syscons.
>>>>
>>>> So we don't want to move the existing ones over?
>>>
>>> This was never discussed and this patch did not do it. You cannot move
>>> them, that's ABI.
>>
>> I see, I implicitly assumed this would be a sweeping change.
>>
>> So should the Kaanapali submitters simply send a version of this
>> patch with:
>>
>> - oneOf:
>>   - const: qcom,kaanapali-imem
>>   - items:
>>     # existing big list
>>
>> ?
>>
>> I'm not a huge fan of using kaanapali as the fallback-going-forward
>> since it's literally the newest platform on the shelves (or perhaps
>> not even on the shelves yet..) so it's going to look funny when
>> someone comes up with support for another 2013 soc.. but perhaps
>> that's just how things are supposed to be
> 
> 
> Yes. Feel free to choose other fully compatible device as the fallback,
> like you mentioned in previous email, I proposed Kaanapali as the easiest.

Ehhh it's not super convenient given the available list

I see that msm8994 isn't described yet. If we don't need to care about
the pre-/post 8550 split (which we would only for the aforementioned control
register space which is NOT what this binding describes), let's go with that
as the fallback.

Konrad

