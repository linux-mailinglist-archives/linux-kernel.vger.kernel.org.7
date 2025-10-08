Return-Path: <linux-kernel+bounces-845203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ACEBC3DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09373A3C9C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A16C2EC576;
	Wed,  8 Oct 2025 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W8yr1+Ma"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D2D13D521
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759912448; cv=none; b=Cjq+W2byKslQr08R905DSz7ZokiuSktGJd2kW9eKqYrqZt26QvtDcCdiYSX+VIJfVYJgGoWixVU7oND3gGXoVnB4kQF+2nNxm+vbVw7Pxr6eda1lLZBPN9hT54vVu5jW3UsfqgCtcg+JkAVwAjTAOQKIX1mYFGtQnOWOc753rQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759912448; c=relaxed/simple;
	bh=oLH4gL3sKlBNp2czL6jTG0vNHuT7xrp294jl0Tqqsms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EEbYnSVDrSPrWQTgq2iRAtmHQyarveer+RakYAmmJ3aAFMbiRcvClk5n95O/FJtSIOoBVKCi85xidbc513yaJkGOttQJnYpJVCjbijusR2JX+qtht+f7WzUgsLTAAHuvPpKP9VwzjAGUWLMHJOtxk1n/JYb+a0v7szvJHBDsxj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W8yr1+Ma; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5987b6R1025609
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 08:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	96qvYt9PH2+8Esd4lI6EIlwJhfA3GfEiTtlpLaXBruI=; b=W8yr1+MacjgEdqSK
	l+PcG4AoE7zDkaffnYmhAbiLYLE/Tno4c28R1AsW8nPUjpI4UkXyQ8HVMHizBlTD
	FffdqEzBuN3SSYZALcoFhGZdh1+aLIRhnsAIBKqe9dKAhuexCD49SOZGmWnvU8ud
	fQISVl09dj1ADqX3m9qKM3WRJ5M0mkh2bPmB4Kxcz6mV+4oVfMNCQPuM06QTlb1P
	kkNjUoSllWQ3OrQij2BPYCt4lf4B22+UiI5wE8sgvLCLrbvKkIglo5fgEk5Mi74D
	zrCJHZxbb1w3iGxzDf3VuTrzVE+MY/iQLvPffsmClWEmiaVtnwCWWkKPoil7unr9
	eQeQTQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49n4wkt94u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:34:06 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-850553dfef2so19745636d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759912445; x=1760517245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96qvYt9PH2+8Esd4lI6EIlwJhfA3GfEiTtlpLaXBruI=;
        b=YZp7nPEWqCio/q61mz29LDhfmYQBWCGImyYsnoowhexWVBgg6EqiSdzv4Bifq3jPSA
         mU6GtoGvywFdRUdEZfuze0kg8KHmrPzvXmficlcdAjIN5gNo5bXWyDHbDgbb7Cn9R9bA
         7YH29ShCr4fVkA+X8QQgFAmF6zJ1tCKPwWwigVwxfHL4uUg2dsddBfMRiKZbfnvTAmQj
         FeG1/WayCEewYB72+73MPII42ho7+KV6J7mU33dEuRjUwdN45SeNSzUyrcHIvVa/QuzT
         BaJZVYYqzC/xcuiApN94TXFhIBUyXvd+MaFxyk3fyxcWYFhRcDH4rTAM9LslWwHX+N9f
         7n/g==
X-Forwarded-Encrypted: i=1; AJvYcCV3zSX1EBAmNIuMa+YaZ4wX05PlQiZIU8tpdkRhr8A2sIPc9fG84rRS23/SwL2p7UyKHN0QDLsG6uZ/Gww=@vger.kernel.org
X-Gm-Message-State: AOJu0YymPr0GefYGTIbbOY6rUUMQPR3MTod9TQEvIeqifrT01210ZfyS
	pXFG3sJJWasYrsmIf0IyES99AjPV9/DvmYxOtT5jA19Dn5MLfefGiJRXUr+4eeLYnW/wX5Fi47T
	0tL2K+uxFJg63J3Ou6lL5D0KQgNCxVDoBM7bVEj/nQhqZDBFeWfzUpraKe5+k4rITHfU=
X-Gm-Gg: ASbGncv3DbU6WgAqCnVpijYwsjD2Y/MOuWlAuQpycj4Je0hqqzT99PExcA0I7nFmAl5
	pBrtDlEabruLcTq1/rwrkMfUXxKgL9veV9TYFnSZl44CgUrTzyeNLzrrrR6pnG3csheGLT5hJaf
	S+7RrUwA0ti1jQEDXkLtOHk8x0uNyZnpv35SCdcEprrRZUS+BtTh5GycZMXUeZRnqJXbiNQJqr4
	PMo1l93nsyg7SrnjB1pls/mOpcLI1mi277SRuaQJG+Nv3XBeHjgDBBIomwEyzgLsRPRgdvOyGSt
	Qh0EaIvH/YnhtfJZNpSwLBPsk6RzyIFsB7uTOauoyheMU8OjMCKiO/8G576xI2KV4UrvPnn0spR
	jO7ollYwAe/RMggH6yJ7LFLxxvtA=
X-Received: by 2002:ac8:7c4e:0:b0:4d9:5ce:374e with SMTP id d75a77b69052e-4e6ead2c524mr23170641cf.8.1759912444830;
        Wed, 08 Oct 2025 01:34:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnBHdB/VM2af2NJjNuVbyejWL9PETbDr/MrcW1c2vYD+dYad+sKWfv4fFHmFxNwUckGnx2NA==
X-Received: by 2002:ac8:7c4e:0:b0:4d9:5ce:374e with SMTP id d75a77b69052e-4e6ead2c524mr23170341cf.8.1759912444217;
        Wed, 08 Oct 2025 01:34:04 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486606bd5csm1609320066b.44.2025.10.08.01.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 01:34:03 -0700 (PDT)
Message-ID: <823af9ee-df4e-40de-bf30-084442bb1d2c@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 10:34:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: qcom: r0q: enable max77705 PMIC
To: =?UTF-8?Q?Eric_Gon=C3=A7alves?= <ghatto404@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250920014637.38175-1-ghatto404@gmail.com>
 <20250920014637.38175-4-ghatto404@gmail.com>
 <53b1a622-3afc-4fd9-98b1-3c166f563ad0@oss.qualcomm.com>
 <BB4E3024-F897-452B-9D3F-250ED2D52195@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <BB4E3024-F897-452B-9D3F-250ED2D52195@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDExNyBTYWx0ZWRfX6aRjHvQi4MNx
 rrK5BwHpbo7utmeAHnUC7GIPfrIS7os/6VNrf+c93kqyAGqdJqaAW8vu6m7x72kcKikbJ0UqGzY
 d/9+lBEjg4tcgd/P0AnNBGy3Vc79esv5P9GvKbpzZrWgY/GiCV3OIF1x3G6Xbw8jjAMhoXt8gFh
 IH7j/xatpmq8ZFAMuvvkHKub+mzmuJm08vFYqwsyAJdXZc0deQF84fJ5nQaeG1RXOhUg3CiZHwS
 k6c5wVCyMk1yx0G46re1S7ddSU708OG7a/JyCSqXLTYZGk1ULcYEMlSyGlMjBMY6/9G2JeDuHGD
 leSdg9ysYjLgOv2OVJpiWA/1CKLxO7XLEA/pIOSfrAK5eEzrDsDZBu9WWMg+UOgGNsxS580v5nJ
 l7Z0bl8zSUCdOlhwqgtOMhLy1eVScw==
X-Authority-Analysis: v=2.4 cv=BP2+bVQG c=1 sm=1 tr=0 ts=68e621fe cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=HA2ILUQYlQLclBA0Y7MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: qF8T4F9ViMS7iKm2X76qDWz7Ayckw4hc
X-Proofpoint-ORIG-GUID: qF8T4F9ViMS7iKm2X76qDWz7Ayckw4hc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510070117

On 9/26/25 4:19 AM, Eric Gonçalves wrote:
> 
> 
> On September 25, 2025 10:06:53 AM GMT-03:00, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
>> On 9/20/25 3:46 AM, Eric Gonçalves wrote:
>>> The Samsung Galaxy S22 uses max77705 as its charger, fuelgauge and haptic
>>> PMIC, enable the fuelgauge and charger for now.
>>>
>>> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
>>> ---
>>
>> [...]
>>
>>> +&i2c5 {
>>> +	status = "okay";
>>> +
>>> +	max77705_charger: charger@69 {
>>> +	    compatible = "maxim,max77705-charger";
>>> +	    reg = <0x69>;
>>
>> Please use tabs consistently
> Sure
>>
>>> +	    monitored-battery = <&battery>;
>>> +	    interrupt-parent = <&tlmm>;
>>> +	    interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
>>
>> interrupts-extended = <&tlmm 5 IRQ...>, here and below
> why extended?
>>
>>> +	};
>>> +
>>> +	fuel-gauge@36 {
>>> +		reg = <0x36>;
>>
>> sorting by unit address is welcome
> Sure
>>
>>> +		compatible = "maxim,max77705-battery";
>>> +		power-supplies = <&max77705_charger>;
>>> +		interrupt-parent = <&tlmm>;
>>> +		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
>>> +	};
>>
>> These nodes should be children of "maxim,max77705"
>> (see drivers/mfd/max77705.c)
> What do you mean by this? I looked at the driver, 
> should I add the pmic@66 node and put
> the units inside of it? Because starqltechn doesn't do that and
> places them outside. Also, by adding the
> pmic@66
> node it expects to have led/haptics nodes as well.

Well, the chip comes as a single package, so this only makes sense
and the bindings (mfd/maxim,max77705.yaml) corroborate that.

Just looking at the YAML, you should be able to omit the LED part
if it's not connected anywhere

Konrad

