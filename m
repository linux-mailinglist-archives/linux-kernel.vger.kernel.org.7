Return-Path: <linux-kernel+bounces-739658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F678B0C945
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79AA1AA7F46
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08832E1723;
	Mon, 21 Jul 2025 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PIGkMBg+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8572E092A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753117996; cv=none; b=sHiUEanhR7M+sxPijcnqiM+dIBmhaCnVERPf2UaU5GfzD30KNm9pGj4hx25B5UDsE8ru9nKnwNX0eFwd8qz2Z7Doc8htdCzptE/UT80mk9c/I7YBd2j8w0voKyTlNd1LC4RAY8A/M+vOvIvyMHZ1rdJk79rCm/roHcvOQ9WGIwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753117996; c=relaxed/simple;
	bh=XfILMrJpqF/tuCduLTWyeK1Shsuk0EcxoJjjw57ON60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rezlOZWL7z1FAuGhElz9jWytnppFGAPGhpHSVObCcNtin1tJiN/7WcvatiDa69/7yJdiR/rF5cmuHFUbWvmkLD77Cl3NfGPjiKj6TbYScKqRj+E9s0iFnvyNNb7Wz2DTsfLacdTWp3I7EWBK+ov62VIPw4LtIChF4wXKSjiE4kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PIGkMBg+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LEf51S012733
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DZ/4PF6N3vG+rQh7F+qrpcJmMG+VX0PeJtiX8Xsn9C4=; b=PIGkMBg+PDrOua3o
	Bf9XtefUwHEa0dPJX+byF9cMvYGIEgfv1u4T0/BhuqIguPzjt1DNaSqDRYoMGitI
	PZ36BouhUWFSYP/rG1uYmqRJLwJ3k7BtoDMQxDvD+emqNTwBluWh/emAZN+Dpv0Y
	hzyYnZVN1aMn5zSZLGoB/PEK/QKV1DAIcO78kPY0C9iqTI+ni1JTgmmExWet9s5P
	hTgmI/k0f7hKLzUjmJnk8RnhR9umCyK87B+Vka2iOOM1X3xDylUG6vMhuv7sutg1
	iV0dkHPKDyyvLEPm1OCvsqaDDDLEk6R23aZJ5D56lpNj3Qbx7ojqFwMMW2fQL7k6
	AwKAcQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6grsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:13:13 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b2fcbd76b61so5189111a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753117992; x=1753722792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZ/4PF6N3vG+rQh7F+qrpcJmMG+VX0PeJtiX8Xsn9C4=;
        b=GW3rwq/2OKTkXSnoa0ZROUcwOemqBvosv5TwzvEx9I1Nim0x0pISbJwuolD6K2EpSZ
         onKbpm8ccIpXvAKZ+WTGwGx8YiOxSj66+cQLy+K8xH7WOL5BRzGtDU/JSMZstUgiMURa
         /Omr4RWV7XOj8RueJAKktpgV4JFaemRSIbw1o5nIr2iF2HLBdsXdpiZqnDXnfeYnbOXD
         bQ5XWIMpTxghesctoN2b7GoCHDncPU15HHkQgH9oUEDYHlxWxvh09N7trT6hbOfvHCzb
         27Gw9442G9O6LqDMfc9Acy5fCa+wmafs3uBbHvxU7NoZ5fkD9Fvynv1TXEBC+fyQdOrM
         Zj2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoCqtDoVJqc4aL2wsa7WbChIUXguDyeOXCEeIj9+5E1c3IiKYWqr0Vjh5pXMLHDHGjOO0SxOG1UsxBYoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPr2HcAol4oPN1mNZOKUQO7penpCMuTnzHP2mGydVyvuuihg6t
	H2KrSjRHPa5ffSrhQEVHp1AreypPaSXlYVKXY1AIQID7ljSEUrD5z/jbwCwV2/f9Ujh7L5b2PNF
	+vqkBy7GL7Rvylu0CdQtWJcuh48xWh3T5Slz8AFQaaymCK1w8zd2q9cCpcvGakAvLtbU=
X-Gm-Gg: ASbGncs1kfc8DiOC4kSv0o/z5xdH1WPr44ti1o7AW+mPItn7ik6cU9LI4ADcVf6d7jO
	QW7hm673u+VVUg4aX6A8+A5tMfZ3Q54eQn7++NR88/bvfMaZqiToCVM82RAm+lwFRbg757E0k5D
	1UzVJVqFcgYoNcOw7wdffJvf+c5wIPxnBLBJQcevVkDqe4OV2zJ54gFETrAyQfxaDZHiPpwpwMm
	W7Qt8bF4BP6lMChaAXfRj0ly4v8N6iGOswzPD354f2268F77YEtxyprL3G71zyOE2tlgvC0rmhE
	4H7rgd/+3H/UJQmR1HuFFqw3l0M8MX3rH3RjwAUjkWUVfGCdM5AUu97Z4dnaSvF1R0me
X-Received: by 2002:a05:6a20:9392:b0:1f5:8a1d:3905 with SMTP id adf61e73a8af0-23810d55d86mr34423456637.7.1753117991868;
        Mon, 21 Jul 2025 10:13:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe2/ShNvywiZ+DxmeZg+ZMZ/GKOcyhXqBS+iKk7LMIrbdvIY81RYqsoTDycOuer7bfi9e1ag==
X-Received: by 2002:a05:6a20:9392:b0:1f5:8a1d:3905 with SMTP id adf61e73a8af0-23810d55d86mr34423411637.7.1753117991359;
        Mon, 21 Jul 2025 10:13:11 -0700 (PDT)
Received: from [192.168.0.195] ([49.204.29.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe659a5sm5633550a12.4.2025.07.21.10.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 10:13:10 -0700 (PDT)
Message-ID: <5b569e5f-066b-4e12-8a05-d77852ce11f6@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 22:43:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] clk: qcom: gcc: Add support for Global Clock
 Controller
To: Bjorn Andersson <andersson@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>, sboyd@kernel.org,
        mturquette@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_rjendra@quicinc.com,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716152017.4070029-1-pankaj.patil@oss.qualcomm.com>
 <20250716152017.4070029-8-pankaj.patil@oss.qualcomm.com>
 <aHjJG2nrJJZvqxSu@linaro.org>
 <40534488-24f6-4958-b032-d45a177dfd80@kernel.org>
 <2f5b5e6e-5041-453e-b3f7-b10b40bc6f57@oss.qualcomm.com>
 <52ytt5ag5l65hdjjmvjft2l7ofvt4rgdn6r3bytcpjvyqia7ry@uzajn7qjng4a>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <52ytt5ag5l65hdjjmvjft2l7ofvt4rgdn6r3bytcpjvyqia7ry@uzajn7qjng4a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=687e7529 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=7nFZtJUvBAfdOgjOLm7NAA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=9SSxU1ZdH87hVqYcdAkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: bhfwR2CncxMyXTsIbAmdF1OhgbO--Ie9
X-Proofpoint-GUID: bhfwR2CncxMyXTsIbAmdF1OhgbO--Ie9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE1MSBTYWx0ZWRfX2UG0wJCy30wb
 jwMTMDTQ3gKe1dCVL06ZTBvJkhiaWiARv+VjYzW79H44pJDlwOyLjLc1wTx3kkFB1rz2xdsum9/
 /G9atrJEik++3oZ84RCNftgEULjiz2bLNGoxwEFnmn1slkJ0L7JbjFzQWLLmli7pM/IanRL7DUj
 UyZLeGhVu0Jl+o/Nny0t5pyK2+G9wJjUunDY2+2wME3ScTW6F3EoDcZsKcw8Rm+f5nrv+jocxij
 geYZI1BnlsOoqW+mr/MYvoUSJpNeLn9qm85qeIgzJs86QbI48jieAcHQL4RCd+tYsZNlNdlvWfy
 WnZwbIUSwzEGFEeYxq9JBol350Jb/zm0FET3MsK8tQwy1Zff5Uy62VoBOGCDcBndoL85R56Du5g
 1hzEL0UIgD/a+Lh7jrOM+VfqiYPX4iw3/Hyv7IgxSUPLWgajV41yPkgYWFs0qZ5H4bSdGcSb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210151



On 7/20/2025 9:30 AM, Bjorn Andersson wrote:
> On Fri, Jul 18, 2025 at 11:07:23PM +0530, Taniya Das wrote:
>>
>>
>> On 7/17/2025 3:38 PM, Krzysztof Kozlowski wrote:
>>> On 17/07/2025 11:57, Abel Vesa wrote:
>>>> On 25-07-16 20:50:17, Pankaj Patil wrote:
>>>>> From: Taniya Das <taniya.das@oss.qualcomm.com>
>>>>>
>>>>> Add support for Global clock controller for Glymur platform.
>>>>>
>>>>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>>>>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>>>>> ---
>>>>>  drivers/clk/qcom/Kconfig      |   10 +
>>>>>  drivers/clk/qcom/Makefile     |    1 +
>>>>>  drivers/clk/qcom/gcc-glymur.c | 8623 +++++++++++++++++++++++++++++++++
>>>>>  3 files changed, 8634 insertions(+)
>>>>>  create mode 100644 drivers/clk/qcom/gcc-glymur.c
>>>>>
>>>>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>>>>> index 051301007aa6..1d9e8c6aeaed 100644
>>>>> --- a/drivers/clk/qcom/Kconfig
>>>>> +++ b/drivers/clk/qcom/Kconfig
>>>>> @@ -645,6 +645,16 @@ config SAR_GPUCC_2130P
>>>>>  	  Say Y if you want to support graphics controller devices and
>>>>>  	  functionality such as 3D graphics.
>>>>>  
>>>>> +config SC_GCC_GLYMUR
>>>>
>>>> Wait, are we going back to this now?
>>>>
>>>> X Elite had CLK_X1E80100_GCC, so maybe this should be CLK_GLYMUR_GCC
>>>> then.
>>>
>>>
>>> Yeah, the SC is meaningless here, unless you call it CLK_SC8480XP_GCC,
>>> so the authors need to decide on one naming. Not mixtures..
>>>
>>>
>> Glymur follows the "SC" naming convention, and historically we've
>> adhered to the format: "SC/SM/SDX/SA_<Clock Controller>_<Target Name or
>> Chipset>". This structure has helped maintain consistency and clarity
>> across platforms.
>>
> 
> The platform isn't named SCGLYMUR - which is where the SC prefix would
> come from.
> 
> I'm not sure there's a benefit to quickly be able to know if a clock
> controller is for a SC, SM, SA, MSM, etc platform. Please let me know if
> I'm missing something.
> 

Bjorn it was more of an alignment for "Compute", "Mobile" and so on and
such was the definition to be used for the clock controllers as well.

>> The case of X1E80100 appears to be an exception—likely influenced by its
>> unique naming convention at the time.
>>
>> That said, I’d prefer to stay aligned with the established convention
>> used for earlier chipsets to preserve continuity. I’d appreciate hearing
>> your thoughts on this as well.
>>
> 
> We're changing the naming model completely, so there is no continuity.
> In fact the Hamoa "exception" would suite us very well for Glymur.
> 
> And look how nicely the CLK_X1E80100_* entries are grouped together in
> the Kconfig.
> 
> Change to CLK_GLYMUR_* please.
> 

Sure, will align, but hope we are all good with the clock driver name
<cc>-<target>.c.

-- 
Thanks,
Taniya Das


