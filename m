Return-Path: <linux-kernel+bounces-862567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A3DBF59D3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 782E834E073
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499DE32B9B7;
	Tue, 21 Oct 2025 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QCS9WO1R"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A173732BF55
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040070; cv=none; b=mer37wi1MDjnVo7bES9JOJ4taf48gBp82xk31luvMa9FOfQ/NUgaNjE2ckmQHyxs0O113G//HrXvNE/bW3gRaVpGTKKdb3aV6OHrIqlkYswUavzzGGe/bgr2oq0zOjJa4DHJ//kLDcFaZY9VkDLNPfTM9Scdum+uBxOZZ9T+2fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040070; c=relaxed/simple;
	bh=LWUSgs+ntXMLNrWNlpepE0odeSrrzoevlr+4MiZjHNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCal+g27NLyDmXT/9SUKlMOk5Rrv3CDhYPauJMfeYt5Rm0VXdBTOfnGZ8nlsr0+tCBpmOWTnppgKcgP7Ff8S9CWvUn7KzkqFHIybx2iBGcOlVWtax/DecY0HZAi/A9FkeillF+AxhGxYj3H9zTCNmi9fizvAQwKgKOxPuaObb0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QCS9WO1R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8QZlR025245
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A5Yfri4rZctc2WzJB/Dz4Ckun09407Nsj2ZILirxlFc=; b=QCS9WO1RKabpMbvm
	D8Jk99WmZ4BnPvq4/b5MbVO0qRmbxhUHq0bcxzRwHGDAEKBjxp+YU12o3tne3q4N
	oHtXkdI9wFg9jTNXVUipuyWveVQFzkoeNtmJnZdRy5iGN26M0h3hDWuU8rS422/y
	HZqHZWzWNuQvGFnMep3U+FfMRvWFWNU3vROqfQ5pu/F34HMlX7HLw814yLxSK4+Y
	DqRWfceRUvgum819OoO/DnmXOJiNwM+bxCRuPfcEklHbFCxuLYPbebSf5Md1+6Ku
	q/dnITCtOWDQnu7oDEo9S7snScK3dCpxT3RMWgGjhVFqCXXwd9G+BAOyJyqK5w9y
	dnwJKA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w8095j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:47:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8906754b823so190760485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761040067; x=1761644867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5Yfri4rZctc2WzJB/Dz4Ckun09407Nsj2ZILirxlFc=;
        b=gT2eKhd9uknJAElJTzqBCQHxFL1KWcroYimwL0ci/pthWxPV8J8tJhoJo1SKep65ok
         EbWQKCMNRiigvkyZpK9zX76rC5w7aRvUOKWRBCebyji7ugDkU+a1l8CxjO8fY4dx+SUM
         eFK1P1VDCpAv89M35+rV1yG2Nxm8LRfOOkxk4hJFsYBLPcf28Ipxoh0XUOha1mcqdFrS
         gDea1NNHLTgcf87eh5Pq8mGjWOHVMCL41MeJIcuHNyyWHJomgeTpvbmSQcIG0z0rbjTL
         3El3ixvtKkvWygx84KeZR77PF2ulfWXfX9c94nF0rkwEVGJKLvTx/LlsaJ1RjNxExrAf
         AdyA==
X-Forwarded-Encrypted: i=1; AJvYcCUFrk7NNBRFjX26ni7cFq6ZrCh2QqFgA4mNHsPVAEKlnZfVdT9efKuc6S0fBg7kvRE6vd22128kXcltnvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/k54RIgve3twcetnFr7gGrZJuniftiNmGVHHuO5MIeoqcrjb+
	V9UpStzx6SNTrzxOVrbV2qJfRGNyqFOdY5AkxLb/OsdZmbjCG/GDY9SMLclDcx82gtRqCY0YJUV
	2MDGrEm9MUDlxMswid4KQcdbL4ktl70xXBDjjM9xe9VXENNBIuDm3Lzs2RYR4aVP/i2A=
X-Gm-Gg: ASbGncsAZ6pgcD1sRTpuMZNJQfF9SbRoOkJZNqWurpQ+ARoNKqnsIAWFj4mULVY+hr+
	LXMnrL7lvFrwO8+t6mALMCMXWYvwlus0Hy2usqJVPZfD5NnFTrqGna4ec0Nw//+AhcTfh0tchGJ
	Hof64Yyh+S0k4dHTzDN16+88DueGLjWShc2br/ph6TeKCDDmklYY6CdT9cuXn0ylI4ydN84/rio
	aqZ5n3TQXW/U3I32uEB1TFebTE6aBrDFiqt0ZCbIL8kKFAiSOmYgrQP63Yb/G2Nt3JIR1snz2Ar
	N8LzuM2+TyXK+unJ2v03lBQ179CwB+8jaUpg2o7k8dMww4ZI2WexcSx4zTFGOZkIDOFHus/eWbw
	FofqYMRxUToNNA9rNwm3939BGBtnwGGNecpg/pPE0WL523j0EvZgsfcJW
X-Received: by 2002:a05:622a:1ba0:b0:4e8:966b:459b with SMTP id d75a77b69052e-4ea116a557dmr18313221cf.5.1761040066633;
        Tue, 21 Oct 2025 02:47:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzeSwT4NYOPDSj7jE+oqcdo1BkVBK0JHZ61OGnrTRCQKhTR1Q5b2mB6h6qybPWjeA3f0K5vA==
X-Received: by 2002:a05:622a:1ba0:b0:4e8:966b:459b with SMTP id d75a77b69052e-4ea116a557dmr18313091cf.5.1761040066061;
        Tue, 21 Oct 2025 02:47:46 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb725f3fsm1027485566b.68.2025.10.21.02.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 02:47:45 -0700 (PDT)
Message-ID: <297c10fc-9b36-4eae-8a56-7556cc14b8c6@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 11:47:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: hamoa-iot-evk: enable pwm rgb leds
To: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: kernel@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>
References: <20251017-add-rgb-led-for-hamoa-iot-evk-v1-1-6df8c109da57@oss.qualcomm.com>
 <cb973808-005e-4920-a35b-3f02a402a78b@oss.qualcomm.com>
 <ada950ed-7b51-4e62-93ff-550c427a73fa@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ada950ed-7b51-4e62-93ff-550c427a73fa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfX7CTZvolt7bZG
 7cSDrgJj4bKTWYRwWYqg2y+jbdSnpi5GxYGWHwIr27+C06tSvWTlLHNZQ4a9FSKE+/VPkCjsDNh
 nIW8IXrhCcoOPh5B4GTLzVZ02nSBr1hJQ8TAiTuR3oRuUAad9lGSdSFRHZ4O0H7cLKCkAR4ZB1c
 Krin1mDqdFR5tShY5oQmsYN1GnO1dVW+0AUUhsBiFlMEzUjLoyzjWLaqY4AVUIF3XESBzC7NL2C
 W97rgvmzI7zC4k8W39yZMFIcOThhq1G+VRfQg0IlC4iMLZBatSZ3qEr+qfpkUG4eAW6acfIveia
 slqaselohv/rTEQFpABblUwmr9Fl7H1mFp0H42l/QabPQUo1LoC6hl6fJwIXVE5/ierVVUtY6Zv
 PnLXs3veq+5Zrksx8hd+ECmPohe7MA==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68f756c3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=tnXrPiAtB4-9hrzugQcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: zi30o5iuYkQmXAbMT52MfenHG3aC-j-x
X-Proofpoint-ORIG-GUID: zi30o5iuYkQmXAbMT52MfenHG3aC-j-x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

On 10/21/25 8:29 AM, Tingguo Cheng wrote:
> 
> On 10/17/2025 4:09 PM, Konrad Dybcio wrote:
>> On 10/17/25 10:06 AM, Tingguo Cheng wrote:
>>> Add red, green and blue LED channels for the RGB device connected to
>>> PMC8380C PWM-LED pins.
>>>
>>> Signed-off-by: Tingguo Cheng<tingguo.cheng@oss.qualcomm.com>
>>> ---
>> Just to make sure, is this a "multicolor LED" consisting of 3 ones,
>> and *not* three LEDs that are supposed to communicate different
>> functions (i.e. network, power, disk i/o)?
> Yes, it's a multicolor LED composed of three individual LEDs within a single package—not three separate LEDs for different functions like network, power, or disk I/O.
> However, there's one exception worth mentioning:
> The blue channel is connected to two sourcing signals—the EDL indicator and the PMIC PWM-RGB blue LED—via two resistors. These resistors allow selection between the two sources.
> By default, the board is configured with the resistor soldered to connect the blue LED to the EDL indicator.
> To support software control, I’ve added the blue channel in the DTS, enabling the capability to light the blue LED from the software side.
> Some developers may choose to re-solder the resistor to connect the blue LED to the PMIC PWM-RGB output instead, depending on their hardware setup.

Ehhh didn't know we had to save money on onboard LEDs..

This is really inconvenient to handle in software, because if e.g.
userspace configures RGB=0/0/255 to signal a notification, Linux
may program the light pulse generator, but the user will never
receive it. On the flip side, not describing it here will not let
anyone use it.. I'm not sure which way is worse

Konrad

