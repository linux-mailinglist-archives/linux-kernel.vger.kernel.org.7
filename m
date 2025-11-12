Return-Path: <linux-kernel+bounces-896573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A85C50B40
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 008284ED130
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EDF2DCC04;
	Wed, 12 Nov 2025 06:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZGlDYzIa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XgkMT9e8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560772DC78C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762928854; cv=none; b=oHHgsBWSzuGQ33ZCED/jjXYv1v7VMyEv0sYN+CZK3A8N01dlwuqHWUcsqvxxbT7n8GqS7YtUK8EqTV/PHWAQQ1vEv970L9nk3DHhDeAwrVacnLoCYPBZ7KDkbD/2oTDFy42GUf9lFfFyRKxNVSfpAm/WewUFV31eQFEMo85RJnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762928854; c=relaxed/simple;
	bh=6E3kbuqpWLhQAHpZzj+RKwY9DdwfA7KfczvhOXOREvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oE+0FiGDkgVmC4QZ2dVG4XOHIMQSVuaGH7I0CV4CUObOFd0yw2ypzo6cGr5jGmodcQ3GKmDj9CfxLIqTguVCveRfqPFLqdyCodTcxBV57QgixqN5ZrhevjF36o/7EDTj5Vaou3I2iuT4RojlMbnw816P/pzK0pp3IrlVpdKYVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZGlDYzIa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XgkMT9e8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC1HZXe3683710
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qBcU+bKowUpDK1UWnPZAN4aZ7FmvwfESIYHI+SdKi7c=; b=ZGlDYzIan21ghi3C
	a1Lo40AxQ3cCORugWdcJBGyYcuhsuxfDchjai3mkMBZgGWsuTrQXP3ikHw3baPz8
	Ymlp/GE7A3LuIiuWUwkEi05p7H/KK5iDMRxcm1OSHK+g2EbyL4o44liW4w/HQtEB
	SKs5IKUe7rBjT3cn1m0Q6em8HJZkFVpIX2wLZUn+rwv7NUvTH/kCyNAiIQAX99U9
	mhmyXyLvEbGr0MEIvSCWW9x1XGfscesaI7SexywLsOYX5ihVz/4BsCJDKcfc7ky6
	WOKCrb84wpOEjNGZjZjsC7AGf/NFEbJ1Qnt1ANZCgtR3dXSCWUukM0+3xXe3ssYZ
	zQqRUg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acgeu0s5f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:27:32 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7abb04253faso105555b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762928852; x=1763533652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qBcU+bKowUpDK1UWnPZAN4aZ7FmvwfESIYHI+SdKi7c=;
        b=XgkMT9e8X2fbQqkQMRwKH3v5oCW60L4Vvf/RsJbmGqpvAYuINq0yuwMYT9SKBpD0Go
         v8UBE1O246TECR5MTrTw3IRd0fsItMEsSN4kusw2wEKoOr5vcGPGpg0LiBRxM2c95cyv
         9yOOkDpcCyCUILtONbmCMM3IWnvwQLJHWwnZj1ZQWGq0STn3FQvjqgLFBWMpc7W7djnU
         PMY8Kg4Q36gV8fNlePt5eDfI2+F26/iuiA+Q2gTDEeyTKyoUXn5iCi9lV+CrZW9q+WzU
         d1zHnoww6B3xqUUF9xylTUe4W0oyaZL9tMm6ewJMcWFOYyaHPQM+LsasHQ0ImvhIcFDz
         3Vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762928852; x=1763533652;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBcU+bKowUpDK1UWnPZAN4aZ7FmvwfESIYHI+SdKi7c=;
        b=WYQK6VczDnb54mQS7lVM33bvvNQRYiPNmZ70dnT9RmvQMdOx6yPbJhZm76RxidUeJk
         7UQQ6v3KU6VlAawZ9Nm5BpFWlftPpGnhXdhB610K1Nd8l5O9sApH1zBp++4XxlCagnBQ
         3t/QLlJEbrvrCNjlPII4j32VCeXXpLLl/zJf8L9KBmJJh0092X87njKrQjXKPht2Xodk
         2cQHgPKHSe8Odw5LVbctgcQFy+9SFA0ITZBqfpDlUlrBd3tx1QzKWUT5kF8Dw4Am+Dmt
         iyvL1DTD+/Cr5zyqysLRKIH+M6o6S00vY00aA4tgIqzSHu9It8ATV8zV6CxCt3Vvtfzl
         uGPw==
X-Forwarded-Encrypted: i=1; AJvYcCVzoZluMit9oTi+lS3lvMmrrSDv2MRt5YfYlbz68ue9sXw76PreK4iHR5kmd+BHQnywqzaqFDFQTM50gPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGhJ9Oa27yBJXigJfEBqXn1Uqf0Tt5WVthF8PvZ4nFC8v4dp3Y
	1ki+4uCvI2dXkpOTyTx/la76XXQK95Bvs2sbiYRYUccvHYp/ZPOguDHQysU1bSq9L/5GmV9mhSD
	nobLTBSS8+7aGrvygPuqDo2IFYDyyjvUk/r1A7u7zCGfdge0SX0uWVflA9KPjA1MyHw==
X-Gm-Gg: ASbGnctcnPf/82W5RJGLBQs3Ip2Fdx2WYphm5CW3xO1nLcSUI2/3cJmFvatuISilI7a
	xpIMKHx586vgxX9N7RZniRtAtPmSrD1NCOSqPu/P2PUS/riv4Tjzdlx3EX74Bhlm/rlkxZ3X4TS
	xtMWvzJI5gp/RRxd6x3EHRI6T/v3afUqjYVPcxdIStTBwmerSt7kxKg+nzzAGWdyU6VUy/53to/
	0shEe5dDQjoq6Y84ToSZEwYV67oZKCV0jsPbpv2mWzQfCJ8VUj4H5Nm3pYZV94NB/264EA9Xs0t
	1Bvdu4UFiUaRVwS3DdNr6n+dxyeJ7kw+FPuU6SXsi/jyrslMZnuQjmu2SQHT/XIThD8wIdsKEqp
	5c8ATFUIxwqpc+D7/5sf1GGljRFeb
X-Received: by 2002:a05:6a00:12e3:b0:77f:1a6a:e72b with SMTP id d2e1a72fcca58-7b7a52ca460mr1024001b3a.5.1762928851906;
        Tue, 11 Nov 2025 22:27:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8s95IVwQDFsnt3lcydXVwXi5aszhstkYZPnVfa45JBYvAr6D58rc+WOD2b+WVitwKA3EoAw==
X-Received: by 2002:a05:6a00:12e3:b0:77f:1a6a:e72b with SMTP id d2e1a72fcca58-7b7a52ca460mr1023977b3a.5.1762928851387;
        Tue, 11 Nov 2025 22:27:31 -0800 (PST)
Received: from [10.217.216.168] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9634f56sm17647131b3a.4.2025.11.11.22.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 22:27:30 -0800 (PST)
Message-ID: <efd1b2af-8beb-4d4c-91db-e622b09f3d40@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 11:57:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/3] arm64: dts: qcom: sm8750: Add SDC2 nodes for
 sm8750 soc
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
References: <20251110085013.802976-1-sarthak.garg@oss.qualcomm.com>
 <20251110085013.802976-2-sarthak.garg@oss.qualcomm.com>
 <35e8ef89-3fbc-48ac-9b2b-10c2e95ab024@kernel.org>
 <268122d1-d629-4d8c-b88c-2999c77a1a18@oss.qualcomm.com>
 <77898b11-e039-4c62-b651-219c971a3be0@oss.qualcomm.com>
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
In-Reply-To: <77898b11-e039-4c62-b651-219c971a3be0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA0OSBTYWx0ZWRfX+guMMfMRQu4n
 sEF97W4LHzKzD4lryiYCLTDttYQ/Fpsx62ZpPBZPYiZ1dVwOFLr3qvu5a36fEvi7+PiQRj9WElT
 WxWHie38YhO0XN+oAqDFSzAFlyheAeI02EPldKf4KRXWPrdy/0FsGUzqnptl4N36Q31TUSWh5ym
 z+4tLUqI1p1b0ehmNq7NVTFd3N0Cn0/tPrWbnejyIimRpOkXj5CDD+T0Cd3fms5w7H5pQ/h1Qih
 10zN1OlmIEzy0/w0UhMLNBRFWKEzL/DQa0syUPTZBcbiT+7KLKZY3BqATjZKykLGNbj2nZnZyIl
 v/JPdHL5mg/AsIyqNM0UJS1GTmZ0vTI2VIaxXgV05tX9hwgcEr8+L11CfAEHscGxJw9r/r508LY
 VSkuMW4BM4wf1zsxkxow1Ay7wBQDxA==
X-Proofpoint-ORIG-GUID: Q8_k8urOI798GdKU8kfFfASzMoFuy6Kf
X-Proofpoint-GUID: Q8_k8urOI798GdKU8kfFfASzMoFuy6Kf
X-Authority-Analysis: v=2.4 cv=SvudKfO0 c=1 sm=1 tr=0 ts=691428d4 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=HSYfenSZfbn2dgnvCVMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_02,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120049


On 11/10/2025 4:38 PM, Konrad Dybcio wrote:
> On 11/10/25 10:25 AM, Sarthak Garg wrote:
>> On 11/10/2025 2:43 PM, Krzysztof Kozlowski wrote:
>>> On 10/11/2025 09:50, Sarthak Garg wrote:
>>>> Add SD Card host controller for sm8750 soc.
>>>>
>>>> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/sm8750.dtsi | 54 ++++++++++++++++++++++++++++
>>>>    1 file changed, 54 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
>>>> index a82d9867c7cb..95b210fbfead 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
>>>> @@ -3482,6 +3482,60 @@ pcie0_phy: phy@1c06000 {
>>>>                status = "disabled";
>>>>            };
>>>>    +        sdhc_2: mmc@8804000 {
>>> Nothing improved.
>>>
>>> Best regards,
>>> Krzysztof
>>
>> I moved the sdhc_2 node to follow alphanumeric ordering and used hex in reg.
>> What extra is needed ?
> Nodes with a unit address (numbers after @) are supposed to be sorted
> by that register, just like any other register map
>
> Konrad


Thanks for pointing out. Will update in V5.


Regards,
Sarthak



