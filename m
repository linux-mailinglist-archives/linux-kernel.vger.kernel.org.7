Return-Path: <linux-kernel+bounces-726101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D60B0082E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2424B1892E7D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5F12EF9DA;
	Thu, 10 Jul 2025 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oICxTjVT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24322EE99D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163695; cv=none; b=h74UaDWxE+NOMglv1O9olp057uo388X9EqFRI4XCRRQtrvO0ixKlxzsNJGDPPppyxbcSviweCm/zHbaOCGwZHun7X2PI2Bx/Qm1m6Kp+byhuFkaFtN8X1XOBM31WCSR0La8dlI733DgyJ1ZefFXOr814GrmAyar7KMqfsORb0rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163695; c=relaxed/simple;
	bh=AVD1kMYGIExMzyPsfxDrCf9QKtVSrXXMN1oDchn4Ths=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bs+V9OND4HPpz06wjTv7o8ti0SUNPXZx0cz91v093ctC9wKawaFpDtFqJhgpwaw5tGryjoreIKj7k7JfgQ3lgjPOqs5TRo3y1gl6prHgmyv7MwbA1znvDTojm4pOkyobhOyvRcmMcXwAK7SeEGVzp+Xd4B+0bztuxHUNACeFjL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oICxTjVT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ADseeB022782
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NmMTiOE75i7FjR8nyzZQYmPjnfwLoajGbC1p8IPyPcc=; b=oICxTjVTTYLH+iWr
	6+w7QmCLd7z4BG+4ChHHt8sMtOzGpBGwqtV+QOZw6LlQtFPTQ6lSOboFUnr9PD05
	ckcyb2f5EfWeknq0dqKOewrVVdEB/vu7MO/LwpHdp9SlJo2qkfsQRlZ4i6sEGReF
	OZEUlI31/IIR4WshBdrB3gpYgAl+gPMNkiT1moiFtuaf0Q2ynEt2AA9uBCBmxIZv
	ES8T6Pv0fKHyYFJRn2Mz1LyN0IjflmGkQCRqeFc9TMJQVBSnZMUaOjS46jEml0kl
	hlTFxKU0W2xWVB1f6bDH50vqwKDUg4+1SMETLX7PqVYBf1Uw6L+mo+5QQULKppCG
	QaVFog==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47t83u1ur9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:08:12 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d3eeb07a05so12253085a.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163691; x=1752768491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NmMTiOE75i7FjR8nyzZQYmPjnfwLoajGbC1p8IPyPcc=;
        b=AbMFogpo3ahCU00ILXSirIrS3DuPYrIYa5aRrHmryGnMEwODUhyYo5OhcKhwZ5lGtq
         gYiGxDhuk99r1Cwh/FDmVBenmrsP++O7MjrdSRc8zhJ3PKNnu70IJBZeqU/7R1nVLXeE
         9HuLKd/sPeVMRyg0HdsHkgi4/g4YuORtObdHHmKyODocmt+S3Ufq+vuQDiY/2QFaY356
         3Yzj1Cli7DWNBm4hJ8+Uh282/htyeFFjYu/0+8j4vGXy4wXR3cEhP+lZ6oVnpWY9Plfo
         xqjpm/IZDpQF0SCA2tZsp6tAjiibKOkYpA0Lhi+AKSGETjU3HJ1FcuFT2gQU9c0hWPaW
         5xRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy8lZMcTx+U3Tc9srAM3Ht8qjI80bs4luvJFPI+NrcmC6AXAfRBI+ywCjVg7XXFaIJbKXabuQe5XfS6lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypEbWJBk/tTKwns5wTnk5KlnYTF4xNLHj66vqdklukhRdmOceK
	IxiQzTu53ph6BQUWO/g3Q/8ytNXnGflnsU31WCbPX55A/Y4A2SRiwxLd/BMtN5Xs+G1GmjaWEGY
	gslA5DhReAho6fnU6ckFo+aBPmCiuhDpA+TbSqoih15n8+MKs+K6l7oh7mJmRdJAcrmw=
X-Gm-Gg: ASbGncvVqVZH21H64pVLCwiPutF9q9qIVlxOUwlzn4W5PVGv+m/7rdgnnkYQ9edPxWH
	2xmD00/nEntIAZO8zMI2XmJnSEP13xzHj6fSAAeH+rCD374cweUPh9knOXpWqHTSLRXNHbKB6Ii
	3Y+s+FWjBw6h9uDDaPdUbKta5RMDbal/JZ59vb3R3BwYSXScZLrwBAGSABx10qrKYts22QPzT95
	+TXGP683XCdHxIgth9qAoaVAF11HVS2MFt6aq2ed3NrPyLQPyp+FqWGq//3O7FlXVWncgc8dfnL
	CXCg0jRgabsGFKWalus9a8FSdG5PfaPGqbne7y2dT43TP1WMs1jxKZlX5xnCuKhQ1c9Mzg3MqZX
	S2XU=
X-Received: by 2002:a05:620a:2099:b0:7c3:bae4:2339 with SMTP id af79cd13be357-7dded2e75bemr2036285a.11.1752163691087;
        Thu, 10 Jul 2025 09:08:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHISGQpxtE/AyJnavWSuFhqb8t726eVkNgkSU/hbrzf+VDGUVaz0Z0DftzVP24+mMp8ybyoZQ==
X-Received: by 2002:a05:620a:2099:b0:7c3:bae4:2339 with SMTP id af79cd13be357-7dded2e75bemr2033385a.11.1752163690359;
        Thu, 10 Jul 2025 09:08:10 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82645dbsm154521866b.93.2025.07.10.09.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 09:08:07 -0700 (PDT)
Message-ID: <c57e130c-38a7-491d-945c-7d5530d4fb46@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 18:08:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] regulator: qcom-rpmh: add support for pm7550
 regulators
To: Luca Weiss <luca.weiss@fairphone.com>,
        Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20250625-pm7550-pmr735b-rpmh-regs-v1-0-cab8ef2e5c92@fairphone.com>
 <20250625-pm7550-pmr735b-rpmh-regs-v1-4-cab8ef2e5c92@fairphone.com>
 <bc27209a-e0f8-40bf-979f-3d747c501ae8@oss.qualcomm.com>
 <23ae6ddb-682a-4c4a-bd63-f0a1adb6f4f8@oss.qualcomm.com>
 <DB7I7D3P01FF.3T5WRSTJIWLVK@fairphone.com>
 <c1a48230-c4f5-4c04-a53a-449bd90b1fd8@oss.qualcomm.com>
 <DB8FM0YYS9UL.JP6OVNZAXWBP@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DB8FM0YYS9UL.JP6OVNZAXWBP@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0kCtLRosasDmXiSm3PGO-sZsvF-2ijT3
X-Authority-Analysis: v=2.4 cv=OotPyz/t c=1 sm=1 tr=0 ts=686fe56c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=6H0WHjuAAAAA:8 a=1rhfSWexEic9pWZXMcsA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzNyBTYWx0ZWRfXzZP1a4lE+3Ps
 Oshq/a3TNKIb/bBou0CmNSEVrGoob+ba2ngkB8ZY3alR4aOr4CCLLRlAW/kVPgk0VZVL7bAxzry
 eACNrbBQD+dF41ybiIp0U0s315PQQizf2C6OG35r9t3a4I3hjW2Onx9aq/qsaHtJm/PO6HLNui4
 ovHKQhObE/Ig0pE9aCnDiFCsebuDFW/ZGlSPwRD2z3Dgrg6I36QxM8o0W5p10ky7e82PekIokyB
 uaiqwlFuL98t6azZIPLIgPXtj+5WuNmv4Hwp4OzotMLM1i9doHbS7b2l1mjVXDoI2CN9bS4MOhb
 0NESWYUUq5j0wDWQPz4rJN4jrmXxWjUvwmXOAVKMgeHILIwDJaX3lBFCW63V/Abkia7HWmgh2HP
 VuR7IaALxxTVH7Hjl+R1DTgwZC8Xb8E9g9mMUwvNlzbahZy4cNZ7JcFpiN4rvExKJQPiCsPE
X-Proofpoint-GUID: 0kCtLRosasDmXiSm3PGO-sZsvF-2ijT3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100137

On 7/10/25 4:06 PM, Luca Weiss wrote:
> On Thu Jul 10, 2025 at 3:03 PM CEST, Konrad Dybcio wrote:
>> On 7/9/25 1:56 PM, Luca Weiss wrote:
>>> On Wed Jun 25, 2025 at 4:20 PM CEST, Konrad Dybcio wrote:
>>>> On 6/25/25 4:10 PM, Konrad Dybcio wrote:
>>>>> On 6/25/25 11:18 AM, Luca Weiss wrote:
>>>>>> Add RPMH regulators exposed by Qualcomm Technologies, Inc. PM7550 PMIC.
>>>>>> It has 6 FTS525 (FT-SMPS) and 23 LDOs with 3 different types.
>>>>>> L1-L11 are LDO515 LV NMOS, L12-L13 are LDO515 MV PMOS, L14-L23 are
>>>>>> LDO512 MV PMOS.
>>>>>>
>>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>>>> ---
>>>>>
>>>>> FWIW everything you said in the commit message is correct, but I'm not
>>>>> 100% sure how to map these LDO types to the existing definitions
>>>>
>>>> OK so found another page (also made sure that the supply maps are
>>>> indeed OK)
>>>>
>>>> SMPS is OK
>>>> L1-L11 is OK
>>>> L14-23 is OK
>>>>
>>>> L12/13 -> pmic5_pldo515_mv
>>>
>>> Based on what are you saying that?
>>>
>>> Based on 80-62408-1 Rev. AG for the LDO515, the Output voltage range for
>>> MV PMOS is "programmable range 1.504-3.544" which matches "pmic5_pldo".
>>>
>>> But yes, in the table next to it, it's saying 1.8-3.3V, which matches
>>> "pmic5_pldo515_mv".
>>>
>>> If you're sure, I can update it but the datasheet is a bit confusing.
>>> Let me know!
>>
>> I was looking at the same datasheet as you and took into account both
>> the LDO type from e.g. Table 3-12 and the output ranges from Table 3-24
> 
> But why, looking at table 3-24, is there a mismatch between that text
> "programmable range 1.504-3.544" and the table on the right saying
> min 1.8 and max 3.3V?
> 
> Programmable range sounds more like what we'd want? No clue...

>>> (3.544 - 1.504) * 1_000_000 / 8_000
255.0

I would asssume there's an 8-bit register that holds the value,
hence the >>>programmable<<< range may be larger

Konrad

