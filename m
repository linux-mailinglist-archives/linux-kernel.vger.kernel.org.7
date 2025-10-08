Return-Path: <linux-kernel+bounces-845245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F52BC422F
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 11:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 95E36350D8E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 09:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20452F5332;
	Wed,  8 Oct 2025 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UsZjaD2W"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E7E1E25F9
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914960; cv=none; b=bgmBd2ptBkbPP40Q2E6p+3w4vsEsr+0NgjrSePIot5ylr8NTALvRZWy+XfMalvU6Wy3lb920YgdYamnA3mzrdk8n6V0BhW5bWcn682DiVPEqDVQtxVrHvi8ua/X9JNEfLoxdM0x/6SfGbT1ydQK4gTFWp+uYKFEVPHZi+RALQV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914960; c=relaxed/simple;
	bh=gE/na0o/3DU0Cg3xnj3SOkBK1lPmQB2SuR3l7twGvZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDZQ5YFSuYsK7D95KsdD/PRzERIpSLpd+VyA8LNWVO/lkZkMk8JzBVpqgbp45Qi6/8Hcb3tgELaiMnVjkDJjQ92/qqchhJgrnOcRThcdtmSL2bSOetQYfTRaqyUA//rbQjF6ZnI1pmlsVdoY3Z0tIDp653pQtdNTlWXF+RMgmdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UsZjaD2W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890TAJ022773
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 09:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B13xsgXidAiGMBhSrn9hTFl4S+HjFwRcA3NUCn4JISY=; b=UsZjaD2Wo3wdMZp4
	L+KwgioLW+b3LHMCCkTCS5gcS8Ok4cQWzuqwvbGjQTrbBOfPEGGx/FZOwujZpa43
	dB6jv5CoMy/BH+g+SPDF/uIjpY+h6vFB3ms5zOQUxmEh7ZeZNsJjSphvnQYWPLza
	56l6OjmKG3NgNdzUwriJzig7/Jm8o720eiBtgLyu/oAYvpu4aO2bX2+E+jwZY81x
	BP1xzLSRGvEolDbPHIdncYyhNCKt32kxd6MPJM9CvyEOKBvtBK0nV6AQdWZlf1ax
	KEZ/SgFhgNfBY0c4857jZRknsiBRiYhmHGu0MfD3rUR1/MdIYcMyfXb3sqn7EYFj
	LpQsWg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49n4wktcer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:15:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-85db8cb38ccso213504885a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 02:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759914957; x=1760519757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B13xsgXidAiGMBhSrn9hTFl4S+HjFwRcA3NUCn4JISY=;
        b=PMaLYMa8uHpqgU/volxfVh2pc5DB0jPmuZoJljeZ+JNzy2+aOm3abBciFEaEwTCyA9
         jTEHAqO4CIfU58J0fOA+MABc8hVgCWod/QoxrwfUp+TY0rpBJLfULx6h4tKJfxacJuuj
         EiJZedYvRxQWIIHFFNO5/KbxBlRYCgCXavcYWyBSMt7PQC0P2ZvO5Pf0iFXLqHbct2Zm
         f/RbrA/HCfjX/DGJa8Xlyyk9s7z+r//0QXfFERZpZ6WusxAs6M88yfQf4bY3OIHzo+A9
         uC5ACrh8QLeHsgE1W1p6QybPiPEzMXpPJmOGwA/DB190pWWYT5GTMiapiDvZjAXveV6/
         wGyw==
X-Forwarded-Encrypted: i=1; AJvYcCXgeDNr2F+TKVIDQAkqUij4JoAKVM2+FeOPfTDHnYghef8rrXfmijWgJM+fBTqINJ6tmeciP2xMfRhjgLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTfgQ5EZgJ0fyXiuviJrzRHenUvIJFC3EveKVWKwDxXgOarR6v
	Mi9+1Fiq5IGHkBgzmbxV0cwnnLc4mAdxG026QBg0XVj1Z1Kp4F9kCPQTJKxPWLMC4H7lFLztdcY
	V8hY5tu7gZrxZPcIU4SSD11Wb61IEFH0kKyfPg9YyYz0UH1waot4xcbJXxMIyhALoJp8=
X-Gm-Gg: ASbGncsCxO6OY2hf73GfmDzAEkPuHKXtyB7MP7Z6NJcZjEBunARCHdlisQPifDGnHGD
	KbIq83M7PTWXE0XT3QGKivZ//Uq3Hk6UfaCHym5PehS/2Fk/NMqksk6DqcBJrhcyINzX8BBgK2H
	Wu+I9kXvzEG2swHC5wCH+LkDBBaZyp0P168ZnFf/kaPe5F83+jawCbZ3mqv3tt689fQFrKUbsLF
	8ipYIoLliNIs76qEN0lxOlPE32e9AZ2BHX1tiIHDNodaiENy1oWkmLGuXXSpVKfsU4IIYN8iFKS
	x0WsyPwHbrwZwJ+/ssJnOVjPKmAKLMN1DP3AIa1O5IJXe3nh7KoYU2HoJXOayAO9ekXP+rQApHA
	u9PZ+zYiW1eXd9QEicq8tjrroh5U=
X-Received: by 2002:a05:622a:20e:b0:4b7:9ae7:4cdd with SMTP id d75a77b69052e-4e6ead2167bmr25580821cf.8.1759914957006;
        Wed, 08 Oct 2025 02:15:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+GKe6R+cofVCrqHwrMzQGHEaGQEFaUvAiW9xFEoSSNmyrEqPN2eRNkVjXi5xs4IVC7Eq04g==
X-Received: by 2002:a05:622a:20e:b0:4b7:9ae7:4cdd with SMTP id d75a77b69052e-4e6ead2167bmr25580661cf.8.1759914956475;
        Wed, 08 Oct 2025 02:15:56 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486a174a6dsm1615541866b.90.2025.10.08.02.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 02:15:55 -0700 (PDT)
Message-ID: <6bf19804-7ce2-4cb6-bdbd-dc12c18330df@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 11:15:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/24] arm64: dts: qcom: Update the pmh0110.dtsi for
 Glymur
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251008073123.GA20592@hu-kamalw-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDExNyBTYWx0ZWRfX3E5juG5M2GjR
 JttQdg++2VOkae1eYi+nyhniw+QNDzyRU74Rvc7am91TJEQ8RmSyxxXIelHP00Aa4dYbtFg9M5K
 a7FsJze4mHlOGI3bnXuNOihaieiPJvCxWMmkZcVWbA8iz0X0LeaRJusyNmR6CRZ+bj4lGj/+TjE
 N2dH30do2uTkAOCHCkoQhhLihCPj5rYfWLUNeqJz//LVQH+hrsw0WaSBNOiPAV4MXZf4gyx90O7
 GN9zS97UJTKVzjf6dd4+4sVRho8q2RkrroPWwX1AhPgcTKtpBb7CWKimMCLLznEaMxfB8xEEfrW
 nX/bpPTpMMrz2I8ERMYY30QHaniKUC2bjs0V9T4tiutCPp9gGxJ2UI85TyIvGQBdVQVx5ZbAAOM
 LDrNNyvYFyNZLyrHJkebv0TR1SHXBQ==
X-Authority-Analysis: v=2.4 cv=BP2+bVQG c=1 sm=1 tr=0 ts=68e62bce cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=fzdbulJE_Bc8If_y_50A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: xYCN4g6SUVeLEUoWXgJX8ETK7iZV-eTN
X-Proofpoint-ORIG-GUID: xYCN4g6SUVeLEUoWXgJX8ETK7iZV-eTN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510070117

On 10/8/25 9:31 AM, Kamal Wadhwa wrote:
> Hi Krzysztof, Dmitry, Konrad,
> 
> On Thu, Sep 25, 2025 at 09:57:02PM +0300, Dmitry Baryshkov wrote:
>> On Thu, Sep 25, 2025 at 10:34:52PM +0900, Krzysztof Kozlowski wrote:
>>> On Thu, 25 Sept 2025 at 22:14, Dmitry Baryshkov
>>> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>>>
>>>> On Thu, Sep 25, 2025 at 05:08:54PM +0900, Krzysztof Kozlowski wrote:
>>>>> On Thu, 25 Sept 2025 at 15:34, Pankaj Patil
>>>>> <pankaj.patil@oss.qualcomm.com> wrote:
>>>>>>
>>>>>> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>>>>>>
>>>>>> Add multiple instance of PMH0110 DT node, one for each assigned
>>>>>> SID for this PMIC on the spmi_bus0 and spmi_bus1 on the Glymur
>>>>>> CRD.
>>>>>>
>>>>>> Take care to avoid compilation issue with the existing nodes by
>>>>>> gaurding each PMH0110 nodes with `#ifdef` for its corresponding
>>>>>> SID macro. So that only the nodes which have the their SID macro
>>>>>> defined are the only ones picked for compilation.
>>>>>>
>>>>>> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>>>>>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>>>>>> ---
>>>>>>  arch/arm64/boot/dts/qcom/pmh0110.dtsi | 66 ++++++++++++++++++++++++++++++++++-
>>>>>>  1 file changed, 65 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/pmh0110.dtsi b/arch/arm64/boot/dts/qcom/pmh0110.dtsi
>>>>>> index b99c33cba8860f1852231db33a127646c08c1e23..4a5c66e5c9fbc35cedb67601f4568844dc41fbea 100644
>>>>>> --- a/arch/arm64/boot/dts/qcom/pmh0110.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/qcom/pmh0110.dtsi
>>>>>> @@ -7,6 +7,8 @@
>>>>>>  #include <dt-bindings/spmi/spmi.h>
>>>>>>
>>>>>>  &spmi_bus0 {
>>>>>> +
>>>>>> +#ifdef PMH0110_D_E0_SID
>>>>>
>>>>> NAK
>>>>>
>>>>> I already explained on IRC in great details why.
>>>>
>>>> A short summary or a link to a channel / date would be nice in order to
>>>> include other people into the discussion.
>>>>
>>>
>>> Of course but:
>>> 1. You were there so maybe you remember the arguments, and:
>>> 2. I'm offline, using phone, not having laptop, replying during my
>>> personal time off just before merge window so any emergency time
>>> should be spent on important matters instead these two huge patch
>>> bombs adding such usage I already said: NO, don't do this.
>>
>>
>> Well, If I'm asking, it means I don't rememebr the discussion. And I
>> defeinitely didn't know that you are spending your personal vacation
>> time in ML. And if the discussion was with some other people, then
>> somebody else can drop the response to the question.
> 
> Just wanted to give some background on this patch.
> Even though PMH0104 and PMH0110 are common (b/w Kaanapali and Glymur),
> they don't share the SIDs. So we tried to use status="disabled" to handle
> this but we observed that because of the node name being common in the
> two included files, it ends up overwriting the previous node with the
> same name.
> 
> eg-
> #include "pmh0104.dtsi"  // assume contains pmic@4 { ...};
> #include "pmh0110.dtsi"  // assume contains pmic@4 { status=disabled;};
> 
> Here intention was to use the pmh0104 on sid-4, but it gets overwritten
> with the pmh0110 on sid-4 ( with status disabled). This is why we ended
> up using the `#ifdef`, ensuring that we can control the exact pmic that
> gets picked by using the PMXXX_SID macro.
> 
> side note, i did `grep` in the `/arch/arm64/boot/dts/` and i see a lot
> of instances of `#if...` present in that.  Assuming the concern here is
> about the use of `#ifdef`.
> 
> Can you suggest some alternative approach?
> or comment on below approaches:-
> 
> 1. Can I use `pmic@pm0104_d_e0` ?
> This may work but looks like a departure from the current format
> i.e `pmic@<sid>` used in the arch/arm64/boot/dts/qcom.
> 
> 2. Create PMIC-ID based pmic dts? `pmh0104_d_e0.dtsi` and likewise add all
> pmics? But this could mean creating too many pmic files and end up
> bloating the dts/qcom/ directory.
> 
> 3. Add the nodes directly inside glymur-pmics.dtsi ( not using #include)?

This is what we did for x1e after similar conundrums

It adds up to the maintenance cost in theory, but the alternative was worse

Konrad

