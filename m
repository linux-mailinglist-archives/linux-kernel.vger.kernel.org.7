Return-Path: <linux-kernel+bounces-841165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6561EBB663D
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BDC3B572D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44137283C97;
	Fri,  3 Oct 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ce/yHVoC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0603626E153
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759484383; cv=none; b=XRAvb+WpwqDQ4kXHx8/o5N9FDhzvOTDYuxjuhOCkvAHf2Hkpc63BVSod/qW30Ti5b/7GDsntkJcHwIaat2MnvMol0TW+wDyObhi/QE1CVrFDLKZN5xi0GoVxYrF3jI0EAoXGKluGpH2qzihu7JScZPYTJaqtQW4drH0VMTRBh3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759484383; c=relaxed/simple;
	bh=SmXYDokhFwrv+zy33WxsUhFm40t/pKJa2ltf9BoIugU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4TH2RvwqaPtFHPppDIN1sBTkmODmxmHmHwjto+zEM49VbZ2ZnyUGQ4eEZMLgTPhssxKn8X4eKIktgzlE9q2J5PoTcyP0SidmmoMFsl9WREDuBOv8EePbUulgYkvqkrLJdCq6/G+jcynBIXUsDdTVQ1KoNpe2615I5L7XSuB7N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ce/yHVoC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5939SMKV024838
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 09:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	04eJkInxO2ENPO6VxJdXgTlBaS7nX00s6IyWW9hvzsU=; b=ce/yHVoCO8wPuS8T
	S/A0T+mXL6oelPbL5oOvKYBJ4LPlPW20wRtsw/kZnGBGjUobOrLW/QGhtQuqCN79
	lZrKFNM58DEVb3tmnJPEfd3FLu0izJhf1V2Zl+HAYbKmwpP4lioVERpgNnsvSFS8
	vd6AofobY8FPkYjne+ByoAZxbdi+61HPGbfdOydfy3ZQ/j/Pd06iG6ja2felx95l
	Gx0BrFQVk3qKy6CrRIDCZd1YOQ/zyL4TpP4ET2aYrLIhzwoVl1IYYqrseLg7bT91
	EAZHQRJcQQKbwtKkqcyfJoR3XQMGubzfHmBO8TELK4+734aUJoxbyiih12j/FOSz
	adwqNQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e97827kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:39:41 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-277f0ea6fc6so45115945ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759484380; x=1760089180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04eJkInxO2ENPO6VxJdXgTlBaS7nX00s6IyWW9hvzsU=;
        b=Agl+KOduDZ/3xH6Z6kKpTGXIXkiTVF59pyS8aTFB0Mwc6ZsAkUi9ONjthA/RfRaWiq
         83xyO3PzmgQJFuoMW3d/Uveo+TISpn4fvJyYAW43oyEiYLk4z8zoTaDq8MgYR3bKU37q
         v7DdDzDNouvY5AHKz0oi1QUT0ziAdVDCR8ABSBIeTRgPh8VmgRt9neF3V3kk0KmBOomS
         lYUMKo39paFcPjhfAUJWYbdWyZMfowmccZLRAe4m880C4UC8n1dDhETJEZJsjk+4ySqB
         iV0NpWH0tcxJKEdLtRlmwyzwlGJ3jpLEb9yMhc++PuzDfv7nM/3baWxlzcO2/HGvERRl
         cJHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFwsAUE8cupUmQoYoXVCBWMof0vyP6N5yDp0hPKZTh5wXPvVWi1DijBBqqsQJtEB52J2GPYxWe59vLvXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjSor9xlsb7sPJ0nZhVZ4gXH+4MtvGRSinj4Cr9CVygymgH03W
	co3r6bIOMfEa4F2vvqLHIDzASmNR4v9Fv0ZnpLVh/Pl5jlnGxwUg6mHyfA2BBWYKjgQOG4aNk58
	vTv1gyG13HEHA1B4op5wLXIJLyS0qqKr/ZnkNZJG4WHNPSvOiJn6eEVrfuCWnTR8RZfw=
X-Gm-Gg: ASbGncsdJ1UbPM4PjeJVnoHD9cbJ4CqOhQha9jbisSZl7RcTR/cIHb26HDl2i6T6kyD
	12y9/DWrXCm/xdSBZjNRkuugf3811BEDgXfIotapXPObqryj4pcGoGbyzMBbe4dGV5yb3KD74BB
	cK0BXQ7s4OjcUM18IYgeVsMI640VV5/iH9LSLL1kNpnGaXDPAJSfbGhakMlRrI8JP6YHne4CQxN
	+2iXXAKWM56fcszRZexCiBSRqF5s3t2mKCGayWdTqMz6tWF/M86xYoZmMWaITupuOAWVH5yeRBp
	2deh4D5E2ScOzNr/Gnr7zlAAnMgr794+Ehhf/eQGGt6m+ZmuIkBc7N0VcR2l8gfX26kTCINjETZ
	iZ8AomGb9EQzWvQ==
X-Received: by 2002:a17:903:1b03:b0:269:9a7a:9a43 with SMTP id d9443c01a7336-28e9a5bd5edmr27720965ad.10.1759484380327;
        Fri, 03 Oct 2025 02:39:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1F+ny00A4izU2Vmt4qqieA1wCTH034JmDPn6Ou6qFqpyQ/6nCQyCk6gspjRmbunlDp0O00w==
X-Received: by 2002:a17:903:1b03:b0:269:9a7a:9a43 with SMTP id d9443c01a7336-28e9a5bd5edmr27720775ad.10.1759484379904;
        Fri, 03 Oct 2025 02:39:39 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1f19ddsm44936695ad.127.2025.10.03.02.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 02:39:39 -0700 (PDT)
Message-ID: <8cc1428c-dd23-4b20-8c79-5d6e7768d4b7@oss.qualcomm.com>
Date: Fri, 3 Oct 2025 15:09:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/9] Add PWM support for IPQ chipsets
To: George Moussalem <george.moussalem@outlook.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Devi Priya <quic_devipriy@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Baruch Siach <baruch.siach@siklu.com>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
 <3cb50330-effc-4089-b80c-d454bccc63f3@oss.qualcomm.com>
 <DS7PR19MB8883BDB4C3147C86F062A4B29DE4A@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <DS7PR19MB8883BDB4C3147C86F062A4B29DE4A@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cmVw4ad4X0S4jbKr-FmSteQtiNehc_7P
X-Proofpoint-ORIG-GUID: cmVw4ad4X0S4jbKr-FmSteQtiNehc_7P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MyBTYWx0ZWRfX4Vfr3xFsoMwb
 12C9meD2v7k84lCLDQ6+tx63tYxQGgaatNsyuSQphKd28Z1viUo4QOjaWFgF1XCs1ryffTNsUa3
 AdAtm7YvFIoJn56fFIO3ufXWiQOn2WLc3CEnTt24KDDUL7UOeljBe0DdCvwH49ADV/wjxjxf19o
 ldarxBPPMqzRA1WY8y/tTW4ZEaovkSQtE3nEAP8QT7COjvq23FdgXJWTMl2dMDhObe9xI5eOVvs
 s1t0UEA7L2c9byibNOT6hlE43RdJgIVIeVbj8m6vd+bM9KZVS3rUiqLRKFs6Sx+32srJBsydIIm
 hIqbeHGUV/skC9s2vIlVD6HMOZ3qOJ2GjOtGocNF04N/g7LnTrI+R2qKHydrJhVJYPXHhFMHrnb
 B1dc9DNW8Ie+W9HX0UdwUhxtfEzjzg==
X-Authority-Analysis: v=2.4 cv=Sf36t/Ru c=1 sm=1 tr=0 ts=68df99dd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=LDzoOPf9sO3yNRZ_Fi0A:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_02,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270043


On 10/3/2025 3:00 PM, George Moussalem wrote:
> Hi Kathiravan,
>
> On 10/3/25 13:04, Kathiravan Thirumoorthy wrote:
>> On 10/1/2025 7:34 PM, George Moussalem via B4 Relay wrote:
>>> Add PWM driver and binding support for IPQ chipsets.
>>> Also, add nodes to add support for pwm in ipq6018, ipq5018, ipq5332, and
>>> ipq9574.
>>>
>>> I've picked up work based on Devi's last submission (v15) which dates
>>> back to 05 October 2023 as below SoCs are still active.
>>>
>>> V16:
>>>
>>>     Removed reg description in bindings as the offset is not relative to
>>>     the TCSR region anymore since simple-mfd support was dropped and PWM
>>>     nodes defined as their own nodes, not child nodes. Updated the example
>>>     too.
>>>
>>>     Dropped patch to add simple-mfd support to the qcom,tcsr bindings
>> George, thanks for taking up this series.
>>
>> Can you elaborate on why the qcom,tcsr binding change is dropped and
>> made the PWM as an independent node? IIUC, it should be child of TCSR
>> node. In V15, I see the qcom,tcsr binding is applied and *dropped only*
>> due to dependencies / lack of information on the "pwm-cells" property.
> Please see below patch where it was decided to drop simple-mfd as TCSR
> is configuration only and any child devices should be defined outside of it:
> https://lore.kernel.org/all/20220909091056.128949-1-krzysztof.kozlowski@linaro.org/


Hmm... Sorry I missed to check this one. Thanks for pointing it out.


>
>
>> Thanks,
>>
>> Kathiravan T.
>>
> Best regards,
> George

