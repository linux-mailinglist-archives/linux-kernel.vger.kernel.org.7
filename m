Return-Path: <linux-kernel+bounces-857952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A86BCBE852C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2DF934B85E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AE8343D6D;
	Fri, 17 Oct 2025 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JAGY2tnw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FA83128AF
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700482; cv=none; b=fw5ynL1mTvWEKiGUuooDwDV0PBxhjwqaYun41XXqqa/uNLiAHqVetbI9dTXuFbtBXj1cWmg+9Gz0VG/MUvNS7k8UaUxBIuk7ROh3jS4tGhI9rPhwmW+IgEM8OOc/pZtw9INYVfGMTtLV+8vDmAIr4PZ9qwUvSQMoUWzSCjWUQsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700482; c=relaxed/simple;
	bh=kgBl8a0kCckWI8aKDofLzcUZxyOfjZE0zQsu0tHmUBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+NuQcEjhEGr58eaKy+venn1yC5r5hmXb6AbAR2v3vBGlAi+3TwNo0+8eiARlyubYI3KWkuev9J95tmNOdNdzFXWaPiYeGVzImRyHT63eBr47dfiPEhaAZU26KBXOrZKT7EnWB1tGjRg501ZN15nlgz6C3wjq5wVFEoVlNct1t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JAGY2tnw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H80kn1022163
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MO5yMJK0yFYcV1Jdm5K+ratgjKv8CSI3SXjH6E3HP98=; b=JAGY2tnwgKBfOduF
	HG6xOc9AC1c51yQJissWfLx5Rc9B0foY9NJKx5JLuP0pB+0/uK+nnsqI50ndwu1L
	0Y1i/exNRdhcEtNPkbIdrel0i/dHgbukJd4IyQOF88MK1xCy3bufF4IUsC7i46Nv
	BJBzah5MXT0NcaKdLR9NEjzGyRD14yAMEnFEdTLSXcVVmkj2VKPGLFrJzl8nU8Dk
	AvYTWKiYQgxjuSV3KgQebgFTLYm6MZ8c7oKocQTj4VmG19sD/xx5RLdmQ/H8yuu9
	Sa2NA3p4/9w8T2DCNuV++DFmpSAoGfOjTr2KA1CzcfORyz1jqynX3PLeeI4rp9du
	sM1ezA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrth0mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:27:59 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8910b0fb780so81679985a.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760700479; x=1761305279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MO5yMJK0yFYcV1Jdm5K+ratgjKv8CSI3SXjH6E3HP98=;
        b=Yy2w1zVT+bOGzKLd2msnrnzCrte4hwRUCiXWYs9NMWM5Z/PrMAtGyw+WI4Qu8Mjl4c
         jf3CljsuKkOwpZZdJHohVRxb3f3A1AoXpSO9+6i3XpvWP94ogTDXe7UMcBNwb2QPb3dD
         nXeK3j/OjJww1ieAvUqK0yanwPPaK+jE3p+eIj/tvo/5UWC82wvAEyttAA+598XkCwYe
         LIlwHMYepBedkOCFIjYNPCTIeM4ikPdDCGslaQrF7SnE4sG86PL0DqWYMNzBUXgRQfTM
         xJLgTW7kIsfSvWeF7Ue13WFxKTl0sLIf9v/YwcZt+p+kd5lvESnBxhufX0kokc6Otzah
         L5tw==
X-Forwarded-Encrypted: i=1; AJvYcCWOfApChErr/4AzMbtB+S6umCKeY64oiRVMjnVWZR/J7cHHFftVg8koOnA6+CdkOXlIPa6p6f3vxqql/jE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHLdd8AZl46vWv1b40uPqTz9dDJ2QCR3uZvnqB4Gm5EPgq/iu6
	cbscS6SMrdlTLSOPhL/AMuIT+UjDqxKt8Klzd8yL5Gmh9cuTP4RBwNeLtm7TYDf9bD+RugxWxgB
	yqRFhIrv4wbXP0jW9lgI7sCpDgBftHgZcgF0Eq8SfWygFgbeoCnFaNt6iW2NfBIlGZZc=
X-Gm-Gg: ASbGncs6niD598UYOT1RH6LHdwrflLbDwc0LAHJ1fwPBSmKBx5EaS0IMUQb168s2O4M
	7mERTEJT0TmI03/rFkesuREDaUGPbhceb+aMWKNEGZ3jploFlt2EtS7D/mV3dzDalzvQ2D69MEI
	hGdCJ7pAE1vAQuNhW/K4N3Ew4hfvMGyeQ0gFzHGWrRDYkuiuSh/kEDMOwzC3lDZHc7+FTjvRTnF
	jVxFNdR4yzBEZTbT+FL3hKtpALE9toFO7BsEWJoIxxq+PblgVz5xI7i6awuMZXbn1rZSMBjGvye
	taEPshcp0ZohO+hH3nBlhlqjEdFttcC8B9T8t5ZQRrSlX4HG+TnK3Jz5aofAZOz7DtHMxYz1p9z
	+1gJYslva0eT6pnlY8JaO4QcGAg==
X-Received: by 2002:ac8:7f41:0:b0:4d9:5ce:374a with SMTP id d75a77b69052e-4e89d35c6b2mr42058151cf.53.1760700478977;
        Fri, 17 Oct 2025 04:27:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDIffwZXUxQwetzttdf8IHIykBBw7PC3C1BL7U7ffezRNN/D8uA16UnjK/MXp5jsm3ACZpXg==
X-Received: by 2002:ac8:7f41:0:b0:4d9:5ce:374a with SMTP id d75a77b69052e-4e89d35c6b2mr42057911cf.53.1760700478410;
        Fri, 17 Oct 2025 04:27:58 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-426ff65596csm8996956f8f.24.2025.10.17.04.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 04:27:57 -0700 (PDT)
Message-ID: <695ff482-ad53-45fc-9ab0-ad69d8bc89d5@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 12:27:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: sound: qcom,sm8250: add QRB2210 and RB1
 soundcards
To: Alexey Klimov <alexey.klimov@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251007-qrb2210-qcm2290-sndcard-v1-0-8222141bca79@linaro.org>
 <20251007-qrb2210-qcm2290-sndcard-v1-1-8222141bca79@linaro.org>
 <b0d9cec5-1162-476b-8438-8239e1458927@oss.qualcomm.com>
 <CAO9ioeVcqT_Yhvz-RMCucLtcpa4xCLrA+srM8Vy_ZZ-650ZQnw@mail.gmail.com>
 <DDKF9YV37ETZ.3DXIDZA4ZU6I3@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <DDKF9YV37ETZ.3DXIDZA4ZU6I3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -67mL-yQzbQQPk4hVVUAmtzvdoHEJQCZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX3bEgLLLfFr20
 2nHV7qQNOr929rW43nuBsvKx/wjizDMdtoOWnXn7ufg5eT8nBnUMPSyYXYTeuQe15JfA0oEvRNt
 Bi6rcYxcG2p584LO7bwcqhHOnFsNJ/F1nqpYxWgrNKZK+8mCUbHPW0bk3ASZFFc9sO/WwwKJUGY
 Q4MBNo20Z35GpVwL3SXk2T6B0atX34/FF/GBnxPHb9ZkeZ4zhEouaboAJ/NCcVlXJ3H/kRBpn/Y
 Y9AYzc7gLMOn16bMWq21YoM99lpPS+Y4BnSdP+tqCDb3TL78PRMSWpmmwuZCKO1RIqSK6S8N/XN
 M7QqXWYdJAkgSzFmR6bYIHXMyq0/4g4zf360OAa/mMKlfOWWG03D/1tvqbW34eWg19MP9ioZ/rt
 sK6Gdguc9hnS1JjP8qvnAGokunxFMA==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68f2283f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=lrA9asLDxIyQxDedMN0A:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -67mL-yQzbQQPk4hVVUAmtzvdoHEJQCZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022

On 10/17/25 8:35 AM, Alexey Klimov wrote:
> On Thu Oct 16, 2025 at 8:46 PM BST, Dmitry Baryshkov wrote:
>> On Thu, 16 Oct 2025 at 18:08, Srinivas Kandagatla
>> <srinivas.kandagatla@oss.qualcomm.com> wrote:
>>>
>>>
>>>
>>> On 10/7/25 2:26 AM, Alexey Klimov wrote:
>>>> Add soundcard compatible for QRB2210 (QCM2290) platforms.
>>>> While at this, also add QRB2210 RB1 entry which is set to be
>>>> compatible with QRB2210 soundcard.
>>>>
>>>> Cc: Srinivas Kandagatla <srini@kernel.org>
>>>> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
>>>> ---
>>>>  Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>>>> index 8ac91625dce5ccba5c5f31748c36296b12fac1a6..c29e59d0e8043fe2617b969be216525b493458c4 100644
>>>> --- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>>>> +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>>>> @@ -21,6 +21,10 @@ properties:
>>>>                - lenovo,yoga-c630-sndcard
>>>>                - qcom,db845c-sndcard
>>>>            - const: qcom,sdm845-sndcard
>>>> +      - items:
>>>> +          - enum:
>>>> +              - qcom,qrb2210-rb1-sndcard
>>> I don't think you need rb1 specific compatible here, unless there this
>>> is totally different to what the base compatible can provide.
>>
>> Why do we need to deviate from other platforms which declare
>> board-specific compat too?
> 
> There seems to be now a few incompatible suggestions for rb1 sndcard:
> - make it compatible/fallback to qcom,sm8250-sndcard (1);
> - make it compatible/fallback to qcom,qrb4210-rb2-sndcard (2);
> - add separate compatible/enum for rb1 sndcard as qcom,qrb2210-rb1-sndcard (3);
> - add base compatible as qcom,qrb2210-sndcard and fallback
> rb1 sndcard compatible to it.
> 
> The latter one is ruled out because base compatible should be used and
> it is not going to.
> 
> As far as I can see the last addition went simply with (3).
> Which one finally you all want?

Am fine with either "qcom,sm8250-sndcard" or "qcom,qrb4210-rb1-sndcard"
as long as we reflect that correct driver name in machine driver.

traditionally we have SoC level compatible which works fine for 99% of
the boards for that SoC, expectation was that if there is any deviation
or board specific changes required, this can be accommodate using model
information. am fine with board specific compatible too, however am not
okay with both "qcom,sm8250-sndcard" and "qcom,qrb4210-rb1-sndcard"  or
falling back to another board compatible for various reason one being ucm.

So 1 and 2 re *NOK*

I hope this provides some clarity here.

thanks,
Srini>
> Best regards,
> Alexey
> 


