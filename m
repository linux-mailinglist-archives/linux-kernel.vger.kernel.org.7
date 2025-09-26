Return-Path: <linux-kernel+bounces-833948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF9EBA3641
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C4684E1087
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84AB2F3C04;
	Fri, 26 Sep 2025 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CqpylniP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3083824A3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758883546; cv=none; b=PepmIlvQyQNM6ohGvNnNTxEJ+4vjVDGxrLMpVkDYNqbGyeGeUTlFR2ApDFJ1f+fVHH5QLOkhL14WlutQLdkO7S+o2Nyahhe6Zq6Lf8d4ucvvQ19e7F4H9q+dLegWqq6lsTwUkE+9LoGWxvc7/6HGomDghPaFWHgVRHtEhtOSH4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758883546; c=relaxed/simple;
	bh=J4ZX0MWrY3PhebLrEOpzMhccx9zlOlt69Zt8hECTugA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLEiuqQ7Z3pxx6QI/f6+fCeHQrieTFu6OVVty6c5FdMB3XJ+yqmn2dwUAsVyowoIsAcsvA/W/MIFXivs8NHPkRyjHfAV06gl/sIFhHEDqRfWp6lYKSidwPN2ArCyMQm9PMqMEGZC//8Tm78x8bAPiuh9O+lbCHYq1LD1o1zxb6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CqpylniP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8vs2q010181
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o37iq3utXp9TlBS1thYy8/XMKpWTzL3E3iu0aR8tupo=; b=CqpylniPW51JYdRJ
	fhhXPYGozB/XcacuunHqGv1GywAbV79/1ywg5EkJA5QiZnluIhNyf/ffs4XxrhgQ
	nf1c25Lk1wdmju/+uAlCov4RreeCz0aXY8EhO0gnluTdRd8DbNCAq1nb1+sdzJp4
	tPrN8lODiDf6CeXIJAaozvG7QlXxkqvP7FrH9+XV/JY2cMynlauXjtpHryrLTVpH
	p/zif35uLqz3ZLtCyOnEeL/DcVAbZfe/3mzQB+UonFQSURcQ6JXJVemh4+jwnFRm
	ALAUiICj403sEC6AJ+vx4n9ofIkHQ4oRrVKvZheM6Rk5q6imqdIfjKlzyDBrQju3
	HoQidA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0vtht9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:45:43 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b77ed74e90so2169551cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758883543; x=1759488343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o37iq3utXp9TlBS1thYy8/XMKpWTzL3E3iu0aR8tupo=;
        b=EGzZ5xvQ+DvEg4bPHa/djqe/D9BVi3dnCl2wUYeYT2+09zUB63vQXKqYYUFpgWusfs
         tUJ4Fm+YrknzyUIHfHSDHNv9c4D3p3jFGEAHzPaKSC1tpNeq7vvWkU0ayOYN9BBy8hR3
         Rmj2XoDdogmjmSk4/451h3W8ZrVY/s5OW7lRvQFqAHYHAjcAX36EBC7KpZgkloenLe7P
         iM72OkSrVJlMCPnCR0CM9Vxa6YV+JMOLwpceY1j1uYBlimCmcv/HHzG0dGncpA+0WvGn
         mzGqlylJRZHvd/wZxfMrwg+Dpk0J7BCB/mxkKZmHrGG2WcCmDchGCZZ478k4NZw+plzt
         XL2g==
X-Forwarded-Encrypted: i=1; AJvYcCWAh2qdbfchrhUt7jQnxYaBe0xAI4fB/cghftjOjwZ2Ou4C/cIKHkyAUsM+KOUBPoQSwSNBxa2BFDToRcI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuv8EKUoScMxOCpEBCmr9WID4qczJyOaRsvFezCFBClcQH/BKC
	DGRCUpLMblLklcsr7L2HI9Ue5KVJDExUC7qK9AYMp01SKxTF+x2V9lm+Twi5rRRqqhE1Bg8pKC1
	6QO0F9JlOT6pte4w7m4eVXNOyXQJpO5N1MVUw2pv6MXxALyIXeuM5H2/aYOvI1bWc+gI=
X-Gm-Gg: ASbGncvX0wGRKLPJPn2oDz5TKOXsa9IK7VYrafw74YdgV7m1Z9KFfq1meFl/DMOnSqV
	NGDq9fEd/fFLhKrbfCCfU5UKUGI93gAIqmJZGXIn3pGiYmDVFtfHCkZ1a+LZk1XCfUs9sIN8hWQ
	Y9kaF+O7FZIlE8Fi8Rp2hzJaISQRrw0j5X7XAMV7gg7u+UwrHuSiybP5/3sraxtmx+shm7pbql7
	RDA97XLGNViBHlTvmJ7sj4YalA9TmzCXES6v3mF3cDWijHx+QjA7Sl4Or5VILOoAnNHUxYTHTzQ
	Ia5mnml6i1ONou3R8AlVLByBe9FqQGvyI2MiRCReBsjoVASuNPbRVNp+MrhQH6wA13k5x5Jdl5/
	mW1Z7c3Hut9v+FjcFQQcjxQ==
X-Received: by 2002:ac8:7e81:0:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4da47352360mr54646781cf.2.1758883542587;
        Fri, 26 Sep 2025 03:45:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpeGa04LShy34S3PksjJTcWsnlJiBTWqyL53wHPhVeyfkRWDwxP1iH4cDJtpYjWUnPOQvK7g==
X-Received: by 2002:ac8:7e81:0:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4da47352360mr54646461cf.2.1758883542010;
        Fri, 26 Sep 2025 03:45:42 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5d1671sm352124866b.3.2025.09.26.03.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 03:45:41 -0700 (PDT)
Message-ID: <f685f02d-9faa-4d76-b9ad-35f2fee0ebe1@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 12:45:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: qcs8300: add Display Serial
 Interface device nodes
To: Ayushi Makhija <quic_amakhija@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com, sean@poorly.run,
        marijn.suijten@somainline.org, andersson@kernel.org, robh@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, konradybcio@kernel.org,
        conor+dt@kernel.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, quic_rajeevny@quicinc.com,
        quic_vproddut@quicinc.com, quic_jesszhan@quicinc.com
References: <20250925053602.4105329-1-quic_amakhija@quicinc.com>
 <20250925053602.4105329-3-quic_amakhija@quicinc.com>
 <vsty7sy7gi2eeyifokwcqpoycmarxietkijmlkymwrmzmdsfws@x64f4ulbc6ja>
 <8c248bf8-2f25-443d-a08f-6504c349b72b@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <8c248bf8-2f25-443d-a08f-6504c349b72b@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: q_R7B01Uo7AYW9__bltoeDiv2KOQMU41
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX40ajVGbltOcw
 G6ZKUjS0oKWIGUQ8mFCB9IC3vCoD8aJGX7fcx5aSrOyRbLqYYlXcDi5CafXovIE6JM6c3dDhzhZ
 MO6eif93NsDccuEdRWR03bda3rR6X2qt46JcG+HZy3YlH6RQUBWrvgplk5LRqLF+RDVaEOU8uuB
 WNqKoYUgps6Xbw6VK70TBVZPAyH4/InoNokVwdPGQjwupdCDAiDPVN2JJzuOMuwn6fzXzV0n0IB
 wQ+61Foj9k2bWk+EUf/qG7LE/DuR9EnJftuMQU2ERKgbEtwL1e4/ft6P51lWj2xpMoLgxDotij6
 Yj5/W2BT4xak213ZPw6EoZnxyJZM+S4822inK40D09+HAnx1p8gY33pRjo6nNHWKOTuktRo3kXj
 Yub0wpVE5Ti65UQxWvmUz24aX+5suw==
X-Authority-Analysis: v=2.4 cv=OstCCi/t c=1 sm=1 tr=0 ts=68d66ed7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=ov-OtuGVHHWtkdtd7_0A:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: q_R7B01Uo7AYW9__bltoeDiv2KOQMU41
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_03,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509250171

On 9/26/25 11:25 AM, Ayushi Makhija wrote:
> On 9/26/2025 3:32 AM, Dmitry Baryshkov wrote:
>> On Thu, Sep 25, 2025 at 11:06:01AM +0530, Ayushi Makhija wrote:
>>> Add device tree nodes for the DSI0 controller with their corresponding
>>> PHY found on Qualcomm QCS8300 SoC.
>>>
>>> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
>>> ---

[...]

>>> +			mdss_dsi0_phy: phy@ae94400 {
>>> +				compatible = "qcom,sa8775p-dsi-phy-5nm";
>>
>> Add qcs8300-specific compatible and use sa8775p as a fallback
>>
> 
> Hi Dmitry,
> 
> I have one doubt, even though the ctrl and phy versions for sa8775p(LeMans) and qcs8300(Monaco) are same.
> Why can't we use the same compatible string that we have used for LeMans ctrl and phy ? what is the need to define a separate
> compatible string for monaco ctrl and phy ?

Because they're different SoCs and if it turns out there's e.g.
a silicon bug specific to monaco, we can apply a quirk to just
monaco this way

Konrad

