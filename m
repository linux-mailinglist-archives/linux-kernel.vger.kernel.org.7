Return-Path: <linux-kernel+bounces-727384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4962B0196C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92F4F7A7E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8146B27FD4E;
	Fri, 11 Jul 2025 10:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="afLMHyl2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619F227F758
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752228679; cv=none; b=Li/gHmG413aYo3bCLen1dOigrYeW9m5QZxGEqYtzyvxY+4MFx6buQK9qwc3kRqYDwvWIabtgb6/ky6Nt4chWWtw4gKfPoN1+nxLeRy6C1O1/X5tO4E3f7YjdKBejAzsngBm9pqdpoAUJmJDRPXHFAvWPHapgjM2z9rsg2m0HZ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752228679; c=relaxed/simple;
	bh=wBu2kuicSP07Hyt6dvhkX9kDy7X6ECDDeaxMMhiwL3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWCkjC/I0ytWC8s80IgDNEWYkEm09RC4x5wBOjRMhgsxD98QFuCy4LTvlI7JSQnT5UPVfH3Qw4zVkhIHBg+OIaTdzRV3vH+9OoFio2FRTCYqsKB/bMX3n8MTCBh4wcsjiqvvYk1Uin/p6G9lzbPNCuTnnUh6gQlMPeL5ym+aKpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=afLMHyl2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1XiBv018272
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1bizVoZMRBk4iRzzp5t9dmlYcMmYl8Jc6R1Yyti/9Fs=; b=afLMHyl22C7wf6hi
	WvEgP/otA55jZsJkja05AtLYcx/p5lu/MFAQmRPLODPfhtF+K4f/GdgkBFp4dTnA
	epo0Oq0m/OPERWkK1tva9D0kWqcL+2IG3Nz+yC+99mGqAUbshmHM7aZLhRMFhUg2
	B/2zqVa6vGN/Gg0FHCBuBdimer0VEqEbqXdhBTjkQ5UTXwny+7YUY/KXQv1bGW23
	+JQQ/FCts/Y3iK0PVPH5oTKKXsWdmxWPvu/2finOudIhPnZpnQljMCVCFVHaH/Tq
	g4lhfn7nbEWiU7ccUqM8IUnSyrateYk90hgiHVX0c/cW2E2yPhsw03vatj5O/sgS
	OKDuVg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smap867g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:11:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d3eeb07a05so30015985a.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 03:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752228676; x=1752833476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1bizVoZMRBk4iRzzp5t9dmlYcMmYl8Jc6R1Yyti/9Fs=;
        b=YqB8QEd7pJcF53vvhR0CmGQgM7bwMn1KHyH+g0l3pElYQkg7YdXDzlBHEYi+6ZFXD/
         yrMIlpEMdiTKCfu16nB3IZt6KL7vaX2UtQUjOfx6TsSaxVvnunGDa7P9RLsMgN/Qj6m3
         QdjBJdG1+4+MeNbj04ge7h9oJj2BFXnu3QeOfw7GyXFaRFeAfHtcrV0ebpfFpgLPv8jl
         POaIWgXA4PlGiHJ5tLEf0ZXRlBIcBfjlcADhr3R7ttErSqLTR3bbMUq0SE0VIIF5qXfs
         AHNCbVpZW3Mpqo3E4bXFCfBMygyopmfjY9Z8cUBeqZXXiC/U59Xk73rbEygsh9xaqInz
         RRJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXS2aEVcnDKRa2NGdhJBiF60yUVbD5GYBD8dQa2QXSx94/15AfSY28vjyWPlQFSEIgEo/MJ+Oafwq5Ct8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Axzx343ZABygKWJi73cRaxaTvFQ4DQAEst2ZVWeKmlwka6hS
	OeIAtYKNhO5LCVL054aeXbqoLbE1/q5vhqBn99s3egdVe+H+neSPJW1Rzk7mTLOjt/KPKLM5/hN
	5wsOaHWKr+xz7sIdBFQZ6CdLvzsdx834EwbbNvYatxZiVZteU3N3uIpa4It6tkf3mRUg=
X-Gm-Gg: ASbGnct6WAQ10ZYSEMdxNFkRVSSpZvcIo/zX6Igx6GwoXF90s6nBRyqE4o1ChfEpAjT
	Lp4nE6u2ZNKv8QhA7wCXn8MtVWIqbx0Qo46NYYclnnLgOodePB9tY15RjODVEL+ZIwP3TAt+lDc
	tB1KtK/g9IL8BXhsJRgQ3rUhZRUmSzwfIn2vWoSY2l7z3cqPtGcSDKRXe3kMbuGEe6Vn43zOXrd
	jqLNyeR+01fxBnhy4U8m2+CiHD+T47TplDbMsD9sh/jsq3X9oIX1pGZblpM5rxcuBwqX1PZcKlr
	96w6eulVaD04J3Ze6Bb0HCMWXNqQBI3YmnKyyryvyiXBdv+2dPnTuwr5itRe6iAcXDb0FIagv+M
	5ZiDmlJeH8avqaZip805v
X-Received: by 2002:a05:622a:4815:b0:47a:e81b:cca6 with SMTP id d75a77b69052e-4aa35e97ad9mr11950301cf.10.1752228676333;
        Fri, 11 Jul 2025 03:11:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+yFGrRyih5NM5B6WfEaKNkJoTbFkt+BimwHv7L8hV/2ji1McRuQtC7efF6UfATIdIB1yjOQ==
X-Received: by 2002:a05:622a:4815:b0:47a:e81b:cca6 with SMTP id d75a77b69052e-4aa35e97ad9mr11950071cf.10.1752228675710;
        Fri, 11 Jul 2025 03:11:15 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611ed4c1830sm602759a12.69.2025.07.11.03.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 03:11:15 -0700 (PDT)
Message-ID: <7335064d-60ee-4045-a119-082daf89464f@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 12:11:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] dt-bindings: arm: Add CoreSight QMI component
 description
To: Jinlong Mao <quic_jinlmao@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250424115854.2328190-1-quic_jinlmao@quicinc.com>
 <20250424115854.2328190-2-quic_jinlmao@quicinc.com>
 <6b286132-1c56-43c1-a61e-0e067a73b615@oss.qualcomm.com>
 <aae21139-a4cd-4c5d-8147-56c2352ae195@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aae21139-a4cd-4c5d-8147-56c2352ae195@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ar7u3P9P c=1 sm=1 tr=0 ts=6870e345 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=COk6AnOGAAAA:8
 a=tkMjx__ORyt4N1e9db8A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: heb2cY9HDOcN5FYlL94mX_TVx8sw1TG5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MiBTYWx0ZWRfXzlS/9nfpbwGM
 mwUrhZevspRBDOlzc+RJQGZLpxmTVOjeyPeL/iOaO+EiS/pAjYXoeXF6OlAagU//tEFHaq2mfKo
 sjegpQFAns6suJU6vNKwU65mWPHB9i+WM4xwHFcyLLWVC+Eg6NBlavhxb+69zMpupTxDK4QeesD
 8lXKuSo7+oiphDbfjeOWpTO64gJtWnS76pGkxSnAu7cHhWQbJcbeOb5kZaNEY8BCs7FeMZyfENo
 r1VfJv02dFgwm4zLuVKE4ed5R+PW1Ztzec6ILPH8zd6ND2su9dmiYqQcJcre+9EUShtlGUuvvIM
 kEg2KYisp63kUO4ATt/y+/8zfIV7lHhgbstvkvrAh2QTKnkRiKrmJ4VFFh3oKbb2hIzhk0DxNt0
 mte1x35YVVE0W3HK2zoX/qKB66nkAZX2qQ3qOPIEQFBzH80wWHd9tZPoUrCiw7Xv+hrGVgaO
X-Proofpoint-GUID: heb2cY9HDOcN5FYlL94mX_TVx8sw1TG5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110072

On 7/10/25 1:03 PM, Jinlong Mao wrote:
> 
> 
> On 2025/4/25 4:30, Konrad Dybcio wrote:
>> On 4/24/25 1:58 PM, Mao Jinlong wrote:
>>> Add new coresight-qmi.yaml file describing the bindings required
>>> to define qmi node in the device trees.
>>>
>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>> ---
>>
>> Is the service-id hardcoded/well-known? If so, we can drop
>> this devicetree node and create a new platform device (& probe the
>> related driver) based on the presence of qcom,qmi-id that you add
>> in patch 3
>>
>> Konrad
> 
> service-id is not hardcoded. Different qmi connections will have
> different service ids.

FWIW the OSS qrtr-lookup utility only lists the one you included in
the example.. I'm not saying this list is exhaustive, but I'd like
you to provide a counter-example.

https://github.com/linux-msm/qrtr/blob/master/src/lookup.c#L71

Konrad

