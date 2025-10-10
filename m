Return-Path: <linux-kernel+bounces-848182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26387BCCD4F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B861A6352F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE88D28935C;
	Fri, 10 Oct 2025 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VX5s010i"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD1D288CA3
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760098109; cv=none; b=Jz44djFeggsRxGBoU97rAVA0KO4apVMulbFuUhXAUqGeJcZx4BDB+EqlaAz1vIXPwqO4se3Gbiq2LDQ+2heiJKrnsSjDD53oATBYNyUbWjceujhVSFC40580Jx09AWBw4lnTQtS8QoKvEoGKToVIQPJvkMEr2pNE7WuPSX6FuyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760098109; c=relaxed/simple;
	bh=iKJ2fLr2YhVltnzFlk7Qs4rtHNtLbaKkQJ4xtFpKE7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PiuXEkDA/h0I6yQJP80bSeRkrqVpewpuvqzx3nE/0dsmzBrkuPZgEJSzq9r3J6uXyOy1d1g7DFt0fGrzGbuXfk7SCEwe4VtFt7LrB6jQfHex5OQR7uhJtURKL4ZvAp2HVz9SqPwBo8hn8gLIWsfvgTLGuniFLqUvy5xpEPVvnEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VX5s010i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A6WlZF006222
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UHuTCSWufHEK1MDgZ7mZP8+Xj4HqPk/PfO4Tympx3Jg=; b=VX5s010iKdvXCZui
	XVSfN9OAtcSdAIJGH1on+BWZi6E7iD3iWhEBFyIOuLzTk7aRO0OL9akbtqgAIQSS
	dFj+TGpzU4jLL4Tu2+1t2E25aJThlFJEyMVvANkliBG+Zqr4QbagnQhqYbRf5oR9
	kElYb8MDK3oGSA/YVQ17cn7v0FTeJJ9+vSFf9Jt1da/Kd+7fKk2qEwmfXnQJJ9+r
	Iqr0+V2K7P52MmjccTBKQqGwYO/ZZkarweyz0oW8/Eo6zUSaoyGb3BwEFNLircAq
	5GbR/wzy5wCS/stJLs8/UuvpDuu4Vs9CiGtdyYcbysBfHtCGTfER7YG3SjZU6sMu
	VJ+QYQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4sp97q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:08:26 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eb3736080so820273a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 05:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760098105; x=1760702905;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHuTCSWufHEK1MDgZ7mZP8+Xj4HqPk/PfO4Tympx3Jg=;
        b=W1LeGiS5Gy2bC9bdEM4dUdAM7s86LRUrex8eKfXYAu8NkHMjs5C0O20Sq8MuUB5oCX
         W2DH4wTw+6nFUoStDe7pHFi591gOhFWJ/4OTtSmyDA1TiCYZq10ZH3Xs5Uts4TWt16wa
         g5/WM8OAJCKmfiD9FTLhTh/Q7avBXTdXjNK2MLyS2jG+amnJqidbU9uEl0MP8dfaBSIL
         xHXPceSv7UkLFOAZI/7bC8p/C3pebeelOVVGHf6vs7oIgRqocu7U2GE+HkMow0nGI19R
         re40iOVf5wUl+4jIpT6Suu6xdrRTjk/4MXGpewQ2yNTq673NZlfh3eWlrqwxC8dG8cgz
         ExMw==
X-Forwarded-Encrypted: i=1; AJvYcCUW1MiSsN3FPkxO7jqpCgFPfCyr6J/PzIzg1pxR72d0i8s7WcI9OoFCpR1x2tbQm1r+aho2AxzdJ6HeiuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzngKyOk9V/ycoiZ2F0zVOoSBs33MXdZmubXw4DkF5UrLobYDdj
	RrOXvF0S3GPtgd8aPVoQtKGFukTGzq89BWzhV3EmDYbnhezApOTYXgWicKqmb4nSe8R1Pq7198S
	CR3M5myBWoCVgLvn6FuRUSFUciXSGQBEbT2dr4sKmnfnwYzVi8JJMxr94a29gfoNGWBU=
X-Gm-Gg: ASbGnctUYc2pPLiXG7GxI5i21QOOGCVcr9D7Z/RvkmZgeTz90XgaFWRt7LfP692iH3c
	8hwTeIcjtMTx9Z/u8rIPaBPRaula7e8GCvGAG8F/k3/acv6P5nz4DAX9/xE2XKQ/+xfmNZ/xsyR
	3P5kSQEiwtAIEynzhoRyuorboFAhSreMgx2TD9LKxY6t1BkyvKPqGKxSOxrndPoNgXsj4BFbjX5
	Io3FJFIiw6yjYXg5AlX6ylw6Zb9vJOYqxDUV9UuXhtLtGr6Y73Z2DMVvXykATOqVqgAoqxPTFBI
	LhA15kGNiX2JleCBJThRGcWjSVt8DZoExlQ5z+c3OUd05HWJDnn24N0tfT3mg5yx0lDsQ0oidQL
	eFwfzhTWH8WnZUmHOVo6lBtIY99M9QQ==
X-Received: by 2002:a17:90b:1c0d:b0:330:7a07:edb5 with SMTP id 98e67ed59e1d1-33b511172b2mr7589507a91.2.1760098104914;
        Fri, 10 Oct 2025 05:08:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSIwcQ7HEPUZ4YLrwYlWbMFtOKin3a2w2qnn0ShovV6i4HKbxcbOCq6y8QmB3MxfGJbOFMEQ==
X-Received: by 2002:a17:90b:1c0d:b0:330:7a07:edb5 with SMTP id 98e67ed59e1d1-33b511172b2mr7589455a91.2.1760098104120;
        Fri, 10 Oct 2025 05:08:24 -0700 (PDT)
Received: from [10.133.33.85] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2ab3sm2772219b3a.64.2025.10.10.05.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 05:08:23 -0700 (PDT)
Message-ID: <81ac4acb-3e0a-4e4c-a5b9-bcc5a949b8c9@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 20:08:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/24] arm64: dts: qcom: Update the pmh0110.dtsi for
 Glymur
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-14-24b601bbecc0@oss.qualcomm.com>
 <CAJKOXPdQH2jXcEY6ZpkmixvUt26SqdzYgDAiJ3RHMG7xkPyi_A@mail.gmail.com>
 <lcbcjpoazpwbltedkiqlw4l3aomwvi3qsfwvmwghb6uf5wvnme@kh7qdpunfuwr>
 <CAJKOXPcyhDdFW_u4YQLiHYj8gM7wYB-LOmB_PJs+5OOgn8WZFw@mail.gmail.com>
 <mzoctelzfp6h2ezzkc3j7gnghsaf67flxqlvfhtlpdfxtddsvi@zqihmnygvdjk>
 <20251008073123.GA20592@hu-kamalw-hyd.qualcomm.com>
 <6bf19804-7ce2-4cb6-bdbd-dc12c18330df@oss.qualcomm.com>
From: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6bf19804-7ce2-4cb6-bdbd-dc12c18330df@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RKOsCChH2w2YZoFXAm3aj21ilJqdugyi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX8szSiq5nQT3L
 ja1+lOAH85zXH0SlpGPvCM06E9eqfrlMYHQLDK3rhwEukxJ8eUkkjkl1f9+wpSbt5KeL4bO8gpk
 3B6FV9rLJGHlxIDu6LGoUP6sp0TV4wS2vSLtkxG4FmftYxFgL8sEC8ePfutKoJhP6t64T30lQKV
 L3Bfnxdou5ql+iCK/Za9QR9/OC9MUfDZrDU/aawHuP7aWnzqP44+V1/fx8jQYUHb/CwDBBoqfvu
 XunShvN3IoinUFkKctOcJHfMayjtE6ff2T60l7m4bFQxzyTm1x2yeptqBF6j2rGBfKClvxxFrfU
 SLT7z7TfMQzMXIR/QqAsStM4qrd0uapzWbR9PbjdLnza2KnfEzh1w89x0KGjL41xAbg7ZTq8pA1
 PtdFxwxwIudhoZqV6v8y6ph/uQOhJg==
X-Authority-Analysis: v=2.4 cv=SfL6t/Ru c=1 sm=1 tr=0 ts=68e8f73a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=fbgB7Lw66JwkRMScquwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: RKOsCChH2w2YZoFXAm3aj21ilJqdugyi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/8/2025 5:15 PM, Konrad Dybcio wrote:
> On 10/8/25 9:31 AM, Kamal Wadhwa wrote:
>> Hi Krzysztof, Dmitry, Konrad,
>>
>> On Thu, Sep 25, 2025 at 09:57:02PM +0300, Dmitry Baryshkov wrote:
>>> On Thu, Sep 25, 2025 at 10:34:52PM +0900, Krzysztof Kozlowski wrote:
>>>> On Thu, 25 Sept 2025 at 22:14, Dmitry Baryshkov
>>>> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>>>>
>>>>> On Thu, Sep 25, 2025 at 05:08:54PM +0900, Krzysztof Kozlowski wrote:
>>>>>> On Thu, 25 Sept 2025 at 15:34, Pankaj Patil
>>>>>> <pankaj.patil@oss.qualcomm.com> wrote:
>>>>>>>
>>>>>>> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>>>>>>>
>>>>>>> Add multiple instance of PMH0110 DT node, one for each assigned
>>>>>>> SID for this PMIC on the spmi_bus0 and spmi_bus1 on the Glymur
>>>>>>> CRD.
>>>>>>>
>>>>>>> Take care to avoid compilation issue with the existing nodes by
>>>>>>> gaurding each PMH0110 nodes with `#ifdef` for its corresponding
>>>>>>> SID macro. So that only the nodes which have the their SID macro
>>>>>>> defined are the only ones picked for compilation.
>>>>>>>
>>>>>>> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>>>>>>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>>>>>>> ---
>>>>>>>  arch/arm64/boot/dts/qcom/pmh0110.dtsi | 66 ++++++++++++++++++++++++++++++++++-
>>>>>>>  1 file changed, 65 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/pmh0110.dtsi b/arch/arm64/boot/dts/qcom/pmh0110.dtsi
>>>>>>> index b99c33cba8860f1852231db33a127646c08c1e23..4a5c66e5c9fbc35cedb67601f4568844dc41fbea 100644
>>>>>>> --- a/arch/arm64/boot/dts/qcom/pmh0110.dtsi
>>>>>>> +++ b/arch/arm64/boot/dts/qcom/pmh0110.dtsi
>>>>>>> @@ -7,6 +7,8 @@
>>>>>>>  #include <dt-bindings/spmi/spmi.h>
>>>>>>>
>>>>>>>  &spmi_bus0 {
>>>>>>> +
>>>>>>> +#ifdef PMH0110_D_E0_SID
>>>>>>
>>>>>> NAK
>>>>>>
>>>>>> I already explained on IRC in great details why.
>>>>>
>>>>> A short summary or a link to a channel / date would be nice in order to
>>>>> include other people into the discussion.
>>>>>
>>>>
>>>> Of course but:
>>>> 1. You were there so maybe you remember the arguments, and:
>>>> 2. I'm offline, using phone, not having laptop, replying during my
>>>> personal time off just before merge window so any emergency time
>>>> should be spent on important matters instead these two huge patch
>>>> bombs adding such usage I already said: NO, don't do this.
>>>
>>>
>>> Well, If I'm asking, it means I don't rememebr the discussion. And I
>>> defeinitely didn't know that you are spending your personal vacation
>>> time in ML. And if the discussion was with some other people, then
>>> somebody else can drop the response to the question.
>>
>> Just wanted to give some background on this patch.
>> Even though PMH0104 and PMH0110 are common (b/w Kaanapali and Glymur),
>> they don't share the SIDs. So we tried to use status="disabled" to handle
>> this but we observed that because of the node name being common in the
>> two included files, it ends up overwriting the previous node with the
>> same name.
>>
>> eg-
>> #include "pmh0104.dtsi"  // assume contains pmic@4 { ...};
>> #include "pmh0110.dtsi"  // assume contains pmic@4 { status=disabled;};
>>
>> Here intention was to use the pmh0104 on sid-4, but it gets overwritten
>> with the pmh0110 on sid-4 ( with status disabled). This is why we ended
>> up using the `#ifdef`, ensuring that we can control the exact pmic that
>> gets picked by using the PMXXX_SID macro.
>>
>> side note, i did `grep` in the `/arch/arm64/boot/dts/` and i see a lot
>> of instances of `#if...` present in that.  Assuming the concern here is
>> about the use of `#ifdef`.
>>
>> Can you suggest some alternative approach?
>> or comment on below approaches:-
>>
>> 1. Can I use `pmic@pm0104_d_e0` ?
>> This may work but looks like a departure from the current format
>> i.e `pmic@<sid>` used in the arch/arm64/boot/dts/qcom.
>>
>> 2. Create PMIC-ID based pmic dts? `pmh0104_d_e0.dtsi` and likewise add all
>> pmics? But this could mean creating too many pmic files and end up
>> bloating the dts/qcom/ directory.
>>
>> 3. Add the nodes directly inside glymur-pmics.dtsi ( not using #include)?
> 
> This is what we did for x1e after similar conundrums
> 
> It adds up to the maintenance cost in theory, but the alternative was worse

It seems a common scenario for different targets!

Considering that a PMIC chip can be reused across different targets—and
even within a single platform multiple instances of the same PMIC may
exist—it might be beneficial to define separate common DTSI files for
each allocated SID."

When the device tree is another language to interpret the hardware,
shall we change the sentence more easily structured?

For example, kaanapali actually have 4*PMH0110 mounted with SPMI0, and
each PMH0110 have different SID(3, 5, 6, 8) allocated like(pseudocode,
not tested, just for better understanding the ideas):
#define PMH0110_D_E0_SID 3
#include "pmh0110_spmi0".dtsi
#define PMH0110_F_E0_SID 5
#include "pmh0110_spmi0".dtsi
#define PMH0110_G_E0_SID 6
#include "pmh0110_spmi0".dtsi
#define PMH0110_I_E0_SID 8
#include "pmh0110_spmi0".dtsi

Glymur actually have 3*PMH0110 mounted 2 with SPMI0,, and the other one
with SPMI1,  and each PMH0110 have different SID allocated(pseudocode,
not tested, just for better understanding the ideas):
#define PMH0110_SPMI0	0x1
#include "pmh0110_spmi0".dtsi
#define PMH0110_SPMI0	0x7
#include "pmh0110_spmi0".dtsi

#define PMH0110_SPMI1	0x5
#define "pmh0110_spmi1".dtsi

Request a brainstorming here. Welcome the ideas!

> 
> Konrad

-- 
Thx and BRs,
Aiqun(Maria) Yu

