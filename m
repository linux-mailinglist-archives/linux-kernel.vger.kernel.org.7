Return-Path: <linux-kernel+bounces-878070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB2AC1FB3D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB506424605
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991412DE718;
	Thu, 30 Oct 2025 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OObCSrmA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RD05/k4N"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CBE2C2340
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822272; cv=none; b=PAIZx3+buTm0ku1DkkB4bFP0LWcMzrrDd7JV2FVm1uJ6/UVFc2AB3VL3vyXdzSRIMnoePo9P4+DwF9flLl3ACDt9fIw/EhoteFDYDz9G0mtErzoOLaiRnQGT531S//+kCe2aKVh/sW7fjTCPmbHJDxMW2bNAWXxLEqougTJS/R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822272; c=relaxed/simple;
	bh=UNww3ygyeX71eQOpY9Y3q226oPQNNYee0k0JvCUw9MY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rw2ZJJwnRMcpL7MKEM/enPDMl8rKwo3p3mnXuYzQuXoksAz2a2b590+3aFaG0Si6JlyE7PfgWA8eIRqJNlGQic7rdHAZ7Ezkbvp/aW/QW56OoF/z9UB4L5ZmTAIdkArBDSzMMN4qkgJ8N2ysXTa+6z53gAwhE5gUU6S1lzgYXzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OObCSrmA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RD05/k4N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7tjiB1693583
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VzFg8UbB6EUgeft2R47u8fMbiAli+RP+Tb+HZKyVwRA=; b=OObCSrmA4jJmqJyV
	hFOBygQYTAhXJVBcXd4BwgIPJX8NthFA8DdxTipC6G1ysw9MRqiqWM8Nms8Z0HAB
	2vSLRf5rK0APCfhx+zKV/AzmetQGhuy42KobethA9DqnDl+/x1jC78LkPSaTlwl/
	OdMC882WitswjuUcdn2sFAqovtZ2s2xd6+nNuK7PeE+PBy5v4RZVMvUqsYVNxPje
	YYETjjIYFE3/hnvB5rE52QaBt6XUFg51rghAopXLbRjGdcTB32tW87a+0B1sJyvb
	HLORF/7lSqhxsuyWpJYb47G0Ma5cNr/8ckz0APuRHD4j+XzBY22xU9Ltxx7eomcH
	gfxFYg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3trv22h8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:04:30 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8801e695903so1326396d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761822270; x=1762427070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VzFg8UbB6EUgeft2R47u8fMbiAli+RP+Tb+HZKyVwRA=;
        b=RD05/k4NZPhDll2JM8gOkkKc4GHIVGEouQe9LjCYTCrSJHFuI0eUGRqYKAqZBCya4j
         gWK+qiiXUSfP9FMfianCpYYPk9AsiCHJFxs/QJMAMWhj1qCMuAr5iFhLQ5N+Pp0h7dl0
         8DxMx8F2I477tbZe15/l64gRsLHfJz17R49bXo8J1pOGaCAowrF/n2ZNYdNkqJsL3s29
         TKwKYbwL5Sv1pD8XR9wJJPIDlrvEc+PS6SiJF0tKjMwZJkmsHNMnhielON9EuU+K2uT3
         9RD3c2JKTED0YxTg8YXOt/pOaAX5qrZ/cCTnWJORiNR3p4a3Kklwc3O71SlolgZRwcsQ
         QWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761822270; x=1762427070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VzFg8UbB6EUgeft2R47u8fMbiAli+RP+Tb+HZKyVwRA=;
        b=fSbciOaYihnGMDSy99Iw/+H2I88dfJXPykm7Qq6MbTmBPubrFlpjB8YHIauS2Dvj+t
         87kXAVOhBPqdnxDDYJ47gnCTnThRa5xZa1inGzKV9zEh+fsQ6uWFrw//dWXmFW1AzthF
         vxFUCSxNAIPkmOjHa6VdSZZD/5tm901muCUQsN7W8f/Tg7KPsOa/Hk1NGWA2uNqb5qoE
         Ga5Ujr5L2mXoCxdpUmRaBAQA6mVrqzR9CjsKo+Rc87dORB49Wu9XqeejRIx4EgPdFtdq
         qZW3lcwkPe62RLkGLcUeLSLQ85VZh1kE3xHq2fX0ezrWtivsHsDEfNbm12qiIrbAAm+G
         7OIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMbRlFbe82N15oazkxJjPPz0RILI8mhMjR/vyuvebAesAQ3+Tv01zjwesl4skPhS9oTei5XN95kjf2k/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqoNieSWzOK8wo/KEvnEIhkoGYTZn5O9JiuJ+BjroMF4kx+t9q
	s0P1w8ZRyVBoarAADNJPaF7RqHhs/Mw0ByYcBLx6W5uRRAFX7stxkiduD8SVU3E9jmLIgGbvM+F
	5d+Q6rCddWqpeqyI9eLtxmB4pUjWWvf/UJkJafhxhGWeBxhI3rXgx4O2Wj6FW4qFsJEk=
X-Gm-Gg: ASbGnctZRDVAWI/uh16PSwFXvzn0UUSX8OE0zIMdvfHzljoTi7KThrxj7jRrqKgfdj+
	ph73Y9Q9EsykQ4Ke05cSeTF9wXYKDIP7P+20ioDOlAxYzEAXri30M9veF6lpbq+ZD3aK1VeliOR
	9MJgyC55DZqZjh7hjCWZ27dk/RvXDphf+iBrnBK6MLlQlltNaSpegpo+20U+5STUowb9w9R1I8I
	EiYAkcV7J1NhVBwmK2vihdW7KNiL0i+ZhGwMkdGc+A8KmM+v3T8GW1rHz3st2twLXch187YGjxQ
	cgANA8O0BAmkiflPfndEwd4HtRKeZv6A+gFUGMjHwOwQkCXi5bvW3F/OEm5w9Gc8u5WF0l2BJFg
	t+CRvSSfxTHohsQU9HX4s0QhleXRZ8pYB7mSaneN+qDxsRGjTk2rT5QyG
X-Received: by 2002:ad4:4eeb:0:b0:81f:3abf:dc1f with SMTP id 6a1803df08f44-88009c1dcc8mr51973596d6.8.1761822269982;
        Thu, 30 Oct 2025 04:04:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj05MubBtygtqeTR6KibEHOmmH0Vqi1S90+C2VimB73/rb0UVkgKNAaSdUTuerVM8yOCSXMw==
X-Received: by 2002:ad4:4eeb:0:b0:81f:3abf:dc1f with SMTP id 6a1803df08f44-88009c1dcc8mr51973356d6.8.1761822269232;
        Thu, 30 Oct 2025 04:04:29 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef6e777sm14245241a12.6.2025.10.30.04.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 04:04:28 -0700 (PDT)
Message-ID: <5df2f0ad-1514-4a8e-9203-fe2b72141102@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 12:04:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] arm64: dts: qcom: cleanup GPU's zap-shader node
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251028-dt-zap-shader-v1-0-7eccb823b986@oss.qualcomm.com>
 <c83079bd-ebd2-49fc-ab62-1fba08276cc4@oss.qualcomm.com>
 <51f10d4e-3962-4c20-9d5f-afd0ac3f598e@oss.qualcomm.com>
 <289d000a-b142-46cf-ad15-07ab8ed377c9@oss.qualcomm.com>
 <dnup7gntevuioadecmslch42ye7j7ioamoqq2www2ytmz4ymws@tvka6m2e3js6>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <dnup7gntevuioadecmslch42ye7j7ioamoqq2www2ytmz4ymws@tvka6m2e3js6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4Njow6Z1um_JVuG-NX06iqJrZEr1EClM
X-Authority-Analysis: v=2.4 cv=D+ZK6/Rj c=1 sm=1 tr=0 ts=6903463f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=beMPh-m-NBtQyn-zy7EA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: 4Njow6Z1um_JVuG-NX06iqJrZEr1EClM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA5MCBTYWx0ZWRfX9j81bmCfbolk
 mIapGUdBVL2HTbIydA4E4pn7YEJ6c4Ikz0SEzq9XLKzI7qsx7kf8obQ4WsYkdbarOm/CMfkjGXC
 6mMR4ghJGxoY2FFXem22nOTCx3ZBU/GtPiicydls2dVFurWzhtKTuCaQIl9JlZJXnDa6LNgB2r3
 AvGBY6Rj0BY70vYAlL9+HzpZWWCY1KPDCLhbwMHPsX6Lb5cIeAd8D2l8+9cfA78D5TZk11jfgHV
 agqgtCK+I7kqta7UCjmMxEGSt+7wBKi0vagaCQclAX/Ktlu11qu+Gnhw08ke0+SEz/VnlQafqZw
 w18HJGrqz+39JEqNTTwIpXnqjJBPN/npJNCyinmyIkDm9rTSieAyQdPgNK4mgfntRno+ONYyrXt
 ERsDM70zzbeEC+OIc+TR7P6YToPrGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300090

On 10/29/25 1:35 PM, Dmitry Baryshkov wrote:
> On Wed, Oct 29, 2025 at 10:36:45AM +0100, Konrad Dybcio wrote:
>> On 10/29/25 10:35 AM, Dmitry Baryshkov wrote:
>>> On 29/10/2025 11:33, Konrad Dybcio wrote:
>>>> On 10/28/25 9:59 PM, Dmitry Baryshkov wrote:
>>>>> Historically all devices manually defined GPU zap-shader node in their
>>>>> board DT files. This practice is frowned upon. Add the zap-shader node
>>>>> on all platforms, define a label for it and use the label in order to
>>>>> patch the node with the firmware name.
>>>>
>>>> I'm not sure this is much of an improvement, since at the end of the
>>>> series, boards still have a &gpu { zap-shader {} } section, with the
>>>> inner one not being referred to through a label, which reduces
>>>> duplication in the single LoC used to assign memory-region, but
>>>> doesn't e.g. prevent typos in the zap-shader node name
>>>
>>> By the end of the series the boards don't have zap-shader{}. They use &gpu_zap_shader { firmware-name = "something" ; };
>>
>> /me wipes glasses
>>
>> You're right, I skipped over the last patch
> 
> R-B ?

rb!

Konrad

