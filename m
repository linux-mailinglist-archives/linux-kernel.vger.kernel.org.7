Return-Path: <linux-kernel+bounces-845293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD0ABC44B4
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7AB401486
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365FF2F5A19;
	Wed,  8 Oct 2025 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="awYUZIYV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A482F1FC3
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759918933; cv=none; b=n7oC7Le9rSrjuQm/THJpUBHjdWIVSVM0H/SxkMwtjeuIvbsN8wfgb+3IJZmyBHRr7FfpvGEuSOvi6LVUm69dRUv4XPtvPlVv1U1cDMMfQQvOQkyhZ1xBnLo5TyBEsqpTLCb3FAXN8pEu+pC0Qcl1DQp7Z0IQu1OgycHqP4xpbks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759918933; c=relaxed/simple;
	bh=Lr09AlCI9tmALrlNWWYo2diNjyAqc2PL1Wfv06g5EdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ls966UrmnhOPEty2VpXACT/AKRswPkN2bR4aEHUsg82PmcAWaojQIa50LE5Z7WtwobhjanXCumQHnFrI7pg8xmSQk85dlu2qonwfT0MGYcOxeVH+nUdcyJCJmhcZnukRMbdkK4msoOHiI7ktEd9ewQ7gAPDqWXUjjKnLze4wW4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=awYUZIYV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890R6T028917
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 10:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	skZej2QK7qLiwq43MFOuoC8Kz7XZV3jwiPvyq5Yz+/c=; b=awYUZIYVTtP/+Wao
	LuedFDi4C6eKkeNOcwsTNqwwe4ePXsEsMNXUTLSkBSvO5m99Gk7XxZun3Oi9k5Fs
	E0JJim/UKCHV5IDbKK7q1CWJnG3a5xMb4BhSigDOR6R65VHaWjanRiXbbcgkRjDR
	ZwhgVmY10fU3JKbV+QQPnKzIK2mmETCrSqu8eHRBpJxF3DJAgzi2ccsl2LrDgo0j
	5kHSXEl1ojq3XiSal91JA2Q0cPHxf4SGOGFgi1qm4ly1ImxaPOFJqKAG2HPANnp6
	7ze41TZqwJ4aHZvRWh2y20wWMkirfAx51DiyftoeMpFfmdgYEfCVhIVAXfdqBkE3
	5YT94A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtwgt42e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 10:22:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8649a8dbff8so126092585a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 03:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759918847; x=1760523647;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=skZej2QK7qLiwq43MFOuoC8Kz7XZV3jwiPvyq5Yz+/c=;
        b=kPQtxj5kvHp/VZGVuTTNIrT49fgo74RkBTRLmS99Xteg1dVzITYYZ0VNRCTu7uA8B5
         BPcF4Ko3MvcDkNfDHVdCiE2W8V/XJ/GdpWf79f9wH1GT4cvPleHHfUnrYFu7Vp2HaVMe
         Dm4NMdhLsFLSX2n8g2rl06pEvGlp+PutJq9jYgrIiwyuQ07UWZplTJAT7lz84Ka5PURy
         LjjbJ0vXwLlSHKwh7NkWrLc38Dcf/toewctPTg3GbeOW4g3uG69kwHIwgqX0ASp1a+WQ
         LPaBn74CfNbuxlR1FKQ2eXG1mrUnmhHHcOAXsoTj8EWe3TB9v/vA3cDjVjJdsrrXzFYG
         WxRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWDrQ7nzGSrrP0qbzCAoPFk+qs/20c8Bq6ZkEYaFQcdP2jUM3mU8sY1MK5xMo7j4MnhrDWNmLBN1bQoQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya8kqDlv8fHidJsxQFN7ABOuX1XwPISqFbx0IPvYjNMAtt1yTP
	qfBMtFUAnlPqk5mNm56L/UCN1i36jyME3d8+E2J6ISqGPrh4RCY1QtU7Zt6mC4Yv3ObGAa1tZ95
	dOOXTRTi9aYNayAbtQAzcjVO342xO5XTAVdVvHf33WpVy0+ZAv4cLuMUPePKQ6ZshPZc=
X-Gm-Gg: ASbGncvq4GbV24wjDoDvdDu+PPlwGmpYbGuAaPoDipUq+wH5qmWFQuAHHU31E0hmsPq
	HJ4PLjkn3gnmFjDjg2z9l60QynnxdxfcGHkbdxh81C0faDW7OxE6RSJShRkaglQi51fDOVfkybP
	8YztBF4IHBPAYsKm5L3hFk8HN7gATU3caS5SxnPKdcBI0lOhmaPA/159Fw8jldq+ZHCGsOBlxW/
	59GO/rCW6vUGsX71bG8RxK04YLUFZCfkEKJ7xHQE6lxjBNg2kPpdf8uAxPKEE+WEqOsRUOXuxab
	OFNZn1Tp9mTG6jpoiKcnNm3Yw7IiwO57JQTLp0y1e55XZabmnzTxNFxjyfCFKdlhGhbexAZ+tZr
	Q4ef/XMeATL+hWLNTBFmt01fKFOo=
X-Received: by 2002:a05:620a:3905:b0:878:7b3e:7bbf with SMTP id af79cd13be357-883527ca0b4mr298299585a.3.1759918846870;
        Wed, 08 Oct 2025 03:20:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLHDjHHvjj8j9dLTGHWXGfTR4aJjre+aHMWNbl/tFlpXmEHkL+rMhFOApHFHL+DL/d9ZVLIg==
X-Received: by 2002:a05:620a:3905:b0:878:7b3e:7bbf with SMTP id af79cd13be357-883527ca0b4mr298295885a.3.1759918846201;
        Wed, 08 Oct 2025 03:20:46 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4f94asm1619475866b.79.2025.10.08.03.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 03:20:45 -0700 (PDT)
Message-ID: <392d2e9a-dc31-4916-ab8a-680b2ec4dca5@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 12:20:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/20] arm64: dts: qcom: kaanapali-mtp: Add audio support
 (WSA8845, WCD9395, DMIC)
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-18-3fdbc4b9e1b1@oss.qualcomm.com>
 <CAJKOXPfY-CpE_aKd910PQ2+u9ux2EvuVEt9ArzhdVCJcTQJUQQ@mail.gmail.com>
 <51637d37-aa5e-492a-851c-e5d6bfbe421e@oss.qualcomm.com>
 <43ba93bd-0dba-415b-8a7e-cdc4d954f79d@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <43ba93bd-0dba-415b-8a7e-cdc4d954f79d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOSBTYWx0ZWRfX3JwH+6OZSM8X
 T6CjcPfyvY0ITlHH/M7Y+CAXHE+MqAkpbZUPZaCA7o2fnSsxXZEY7oXKOxjhKlpotUb3X9M/Fad
 IJrdZK6+xVWIUOwg2wnoLsSNrWbSMzEoQxhl+PsevCKOh2yTZGyeyON5D1g8rZR3dnNVY7Z931/
 M9BS2Er3aZp5nnp+JugHZ6Lue9PyZWj7bXmGrCreTGBhbONgWtmSPT+abM4plUXnWBAC9Ju2WOX
 LoPDPGlxUHl56NFMaXHa/kjgG95fjLPewPjAnyKYLVO34PTQUnz+I3YrBfuihqJwOIyPhY0XCBn
 r5UXCezGnSELxw0QQlxeC7+ffJoUO/8WGs2PjcA23G3W3/Gg9rW+pQ5OH5jMB5wpcOhl/uu+5mj
 CSVU7LtCjpXVDgXLAhp0Oh3ekKu3nQ==
X-Authority-Analysis: v=2.4 cv=B6O0EetM c=1 sm=1 tr=0 ts=68e63b52 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=CoZnzqn1Vmb4SI8PR-kA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: x8soYtrdBYkZ3qit6AEv33zQIQe9tcsa
X-Proofpoint-ORIG-GUID: x8soYtrdBYkZ3qit6AEv33zQIQe9tcsa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040019

On 10/6/25 10:48 AM, Krzysztof Kozlowski wrote:
> On 30/09/2025 21:06, Prasad Kumpatla wrote:
>>
>> On 9/25/2025 6:56 PM, Krzysztof Kozlowski wrote:
>>> On Thu, 25 Sept 2025 at 09:18, Jingyi Wang <jingyi.wang@oss.qualcomm.com> wrote:
>>>> From: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
>>>>
>>>> Add support for audio on the Kaanapali MTP platform by introducing device
>>>> tree nodes for WSA8845 smart speaker amplifier for playback, DMIC
>>>> microphone for capture, and sound card routing. The WCD9395 codec is add
>>>> to supply MIC-BIAS, for enabling onboard microphone capture.
>>>>
>>>> Signed-off-by: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
>>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>>> ---
>>>>   arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 226 +++++++++++++++++++++++++++++
>>>>   1 file changed, 226 insertions(+)
>>>>
>>> Audio is not a separate feature from USB.
>>
>> I didn't understand this, Could you please help me to provide more 
>> context on it?
>> Is this regarding Audio over Type-c?
> 
> USB depends on ADSP, so your split of patches into separate audio commit
> is just incorrect.

No, this is no longer the case on Kaanapali.

PMIC_GLINK is now served by the SoCCP rproc

Konrad

