Return-Path: <linux-kernel+bounces-868762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15CBC060CD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC471A60B7B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC3D2FDC21;
	Fri, 24 Oct 2025 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xoxyv3vF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26FB275B16
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761305849; cv=none; b=X9xoMC/a1BkI0fmLLWjfQvpAY+oeUG40O80HYeFDgXAOMYUG/CMY26Ns1gpf9A1PbCBU/J2NZS0BF9T9D2cJkmElgbiKgTd1QphA0n57xykYIUwV7O5ma1ARjXPt2g/qX8Uei4xFr4ixgkAlZA5h59edvILj2yRk4W0LAkXx0cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761305849; c=relaxed/simple;
	bh=AegDV7IseewiNZScqyTokamJL+JGOkRVJ0CsWicKgK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=urwt1xZrwMCz2nHj35R83m6+jzf3hYR7+5ESaJWbeLXBDOCm4/TYmqSh3aDMGVF6QiPpnYglNN0let/a93mTnKue/s9wdqiwpGZDhMFNDg6ve+QTSWkI6CkJx7GYITqmmhkg9UmScW/cUV5kh3qp9qIgh8hcRI3oSRgQjyYjdzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xoxyv3vF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FE7k000371
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dbfGbR0kcMmEjjS0vTIRsRdJzggRoz88OyC/T39B8BY=; b=Xoxyv3vFFcGRreoB
	Jpg4cG2pZknuWhO+R4y+49fe5zhstgEZ1O/Nl4aAQ1SyyynWhuxjWSUEV18+PkdZ
	YS5/0b8fUgUoVwLHGfhW/+eU65abRj85AOeeu4IzFfKaQbhvpLBB4I5Or4qW98MO
	Bdx+sWS9fY+qOJ8wnQ9uP0QRo0+LB8pXvli/BIT7YMRVmsPv6cC28CtAWLO2V2Zl
	mniJZBtycbAyBUN7A2abuMTjxW3WgPLBE8fNV+gNeMRhec6yZk2qm/7j6KDzLlQl
	KMdu6d1XJ8nluVnNutl47kpX3PBrBsxUMloJZqc9QqqLtS4PoaN1Jc8pRFy+er94
	dxDh0g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49ym9j3gpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:37:26 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-792722e4ebeso1735707b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761305846; x=1761910646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbfGbR0kcMmEjjS0vTIRsRdJzggRoz88OyC/T39B8BY=;
        b=vOC2Fcq9wgcMA8qmdsi7hVpYRy2PkGJy1fOCfgMuF3un2XwKlQ21F+TyG777XYwrTw
         XtP7eEm6cJHKpkt/bzGtxkfMi6P3Yt94SU+YNyylLZl66oj3WB/qPj1k+mzKvd5a86+F
         4bvOI8+EX0x8DMK3mZ8ORrEGtHxUltMIC3NoJK5Gi+mblUxytV5S+WduIvGSqGm9XUAW
         RyNtaanglMOesZ/m17RokUQkUgQRhvPy6J8MxJITBplWIl0jm4fos7fJznAzLwJybWLz
         5aW9w+W0Wvmx4n987vPPoILmj7a2SNTbUShkYsdq0JmU04/EnXUGd51uekhCOGzNjI0W
         wdjA==
X-Forwarded-Encrypted: i=1; AJvYcCVsgubsFDUKID0WIc/50Du2WfcN+afo7gMOFe3lmEbcbveZQw68eeAg1TKVCrNKFX+6stLM8gSUm3c+9cM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ok0jh+7DQHSTrz1BnMLp8DaVC9DZX5QU7sjK0hNSMcYQNB5V
	koG/QSUtP5AJb2g8RBwjCrRevpIq3YNqSHrZTk75esyoiSLZFDynY6Nrxu1ERucK+JgkAllmUU9
	Y27PhaG+C4ijoT45YMu8bcgKcOGbGrGOm3rk5tuIuWNGBuqAva6s70U6aK9zl9oUZRHU=
X-Gm-Gg: ASbGnctleNcioiTYc7i0tMHwCAZUdh4ePSSA66jH6FtldEwwqoTZ73+MuM99UZoEVgl
	DKpTfFcvKcWWTRLqpMpT933xfmHWW986uw2n7rK5pdBIrc1dTLuX88ZCm+pANHD3x4zGoc16xdM
	z8gpKhFtnYUJ3Jdu2gnb7ONQyvxsSb0pyfd4/4yF883rRNI1lsOonesH0sKLX+nIRmkJ+34RAds
	81EqScPJa6J0rio6hoWIRrmNKTrZACi2c+kLwqmUTs7t6n2MMaLi8ZVOjr+7a8MRoXpUGcVKQkD
	HHKXaML04H3Bxg5wA2GMdKhGeEj6yhkOiVl9WK9Js8nW9AKfeGVcKXQSDQeTy3M7IOavlENAwcB
	nDkZGd586OOoC6KU6kIU+WQ9xbjUEh1M=
X-Received: by 2002:aa7:9290:0:b0:7a2:6db4:4c7c with SMTP id d2e1a72fcca58-7a26db44dbdmr7396049b3a.30.1761305845892;
        Fri, 24 Oct 2025 04:37:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMJ9ddkiXbFe6TKK3Y2/fvEFeNAy844DzrGqnMtKaMiv58hmthIdtxkrHb9kI/TP2dxoiy9w==
X-Received: by 2002:aa7:9290:0:b0:7a2:6db4:4c7c with SMTP id d2e1a72fcca58-7a26db44dbdmr7396019b3a.30.1761305845379;
        Fri, 24 Oct 2025 04:37:25 -0700 (PDT)
Received: from [10.218.4.221] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274bb0c93sm5573663b3a.59.2025.10.24.04.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 04:37:24 -0700 (PDT)
Message-ID: <f2ea3da2-4582-a2d7-9a90-8050b3e8a27f@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 17:07:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1] arm64: dts: qcom: monaco-evk: Add firmware-name to
 QUPv3 nodes
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com
References: <20250925042605.1388951-1-viken.dadhaniya@oss.qualcomm.com>
 <9b887bc5-eaa4-4271-8770-3458efb528bf@oss.qualcomm.com>
 <f016d47f-919c-2944-ab8f-68e450e5836a@oss.qualcomm.com>
 <be816a6d-c4e6-4cf1-b5dd-fd59515a42ef@oss.qualcomm.com>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <be816a6d-c4e6-4cf1-b5dd-fd59515a42ef@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CLknnBrD c=1 sm=1 tr=0 ts=68fb64f6 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=2qUNLLk1E6tSnZkWjjAA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDExMiBTYWx0ZWRfX5OROilHRwAWa
 NpfM79jp1ehRHCc4jSrlwQwBXUVHzHL5ch6AmNMexkUomWw8YNyT8kqS6b9gKmgZp+2pbrrKKpM
 qfZXwbyNBXFW4Hcq1wMKTfNZUvgygYvo4yyR6gbHeFZNKw8DHD/dwxulLg8TBoPjCcUFsVDkC0U
 qMIRh4cBiNzsOBcz0qFupS4yEtIkUzQ+YxzA5GaBootOxa5s47aK89xkAeNx0WE6+mGrS29tslL
 rG6aZ5vEj6VqeJK9i82403a5rYnQkP/HaFyPgmaELeTHyJBgpxeM8KT/0HhwSj6dwCnXNYm+jus
 w9HYfIGvecH9TFF+OXXQI4KPeM0pM6JPxsyv0wXJauJkrKr63nlXwRGAnISvInoBbOQ1SJpFg/G
 fxF3NDVUK93LD+gBcVDDeqZpk6t+lA==
X-Proofpoint-GUID: Jotw-zKM77wsPeOda94gnjs8AL_1mx25
X-Proofpoint-ORIG-GUID: Jotw-zKM77wsPeOda94gnjs8AL_1mx25
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510230112



On 10/22/2025 10:30 PM, Konrad Dybcio wrote:
> On 9/26/25 8:43 AM, Viken Dadhaniya wrote:
>>
>>
>> On 9/25/2025 2:22 PM, Konrad Dybcio wrote:
>>> On 9/25/25 6:26 AM, Viken Dadhaniya wrote:
>>>> Traditionally, firmware loading for Serial Engines (SE) in the QUP hardware
>>>> of Qualcomm SoCs has been managed by TrustZone (TZ). While this approach
>>>> ensures secure SE assignment and access control, it limits flexibility for
>>>> developers who need to enable various protocols on different SEs.
>>>>
>>>> Add the firmware-name property to QUPv3 nodes in the device tree to enable
>>>> firmware loading from the Linux environment. Handle SE assignments and
>>>> access control permissions directly within Linux, removing the dependency
>>>> on TrustZone.
>>>>
>>>> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>>>> ---
>>>
>>> Viken, you've posted a lot of patches like these lately for
>>> specific boards.
>>>
>>> Should we instead push this to the SoC DTSI, to limit the boilerplate?
>>
>> The firmware load from Linux feature is applicable only to devkit boards
>> (RB3 Gen2 and EVK), and therefore, it is being added exclusively to the
>> board-specific device tree files.
> 
> Do we expect GENI_SE_INVALID_PROTO to ever show up on hardware that
> can't make use of fw loading though?

If TZ (TrustZone) does not load firmware for any SE, the SE protocol status will
remain GENI_SE_INVALID_PROTO. In such cases, Linux can load the firmware to
initialize the SE and set the required protocol.

> 
>>> If I recall correctly, you said these ELFs are not vendor-signed, so
>>> it should be OK to have them be assigned globally
>>>
>>
>> This feature is intended solely for use with the development kit and is not
>> intended for commercialization. Therefore, vendor sign-off is currently not
>> applicable.
> 
> Well you conveniently never really mentioned this in the driver patchset..
> 
> Konrad

