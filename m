Return-Path: <linux-kernel+bounces-884439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B860C302E1
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE485188CDDA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67F22BEC52;
	Tue,  4 Nov 2025 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BveNSdo3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bAIfoEvz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2E672605
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247090; cv=none; b=crMMsBY0NX3BtjCiEUr9gMX9b0Uv9nIUdcJezyTXyf7SoLccQwsoaps7DsMDvQcBznJ8bn/xkpmbHaOIpVxpaLritb+Iu+jE4ML9QRQkJADiIG1DgweYpTF2c0JSbxWyyHKQLeqBgVVJVJC2hDWdZO1r/CI7wUM9CtuJGOst03M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247090; c=relaxed/simple;
	bh=M5h8wGHqottmVbN7MO9Ckr4DSLpliKv6IRVS1pyJv1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fq63EPslztFpY6DN5Y6RBeJgVHm2ZKWXV0YAzRmQv5Cd7D6buAUvjUTOskvVfNIrmA/Wurrh39L/TzIcmoXBD1VZvvLbksfHVR5yHBFjAeMBFzP10no+55MlafLS7jBFWPiHLmBEdGchbdV8j4RYjC7WrYQXPifQZdhq4iCXTXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BveNSdo3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bAIfoEvz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A48fjn01488895
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 09:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s9xPLj5OuQTlTyOHnok3W+6HBQLXo5qtNB6Mr1AveDg=; b=BveNSdo3vKcraLbv
	D5W/FrYHC++1d4Y1SenP5D7o/PMLDT7tlrPdHWqQaSbNJKEfUr6vdPweRKI2Ln5D
	feF0F3+ZdO7xoQM1ebGGoLXXOIpM+b9QEC3z27dHYFc3F4iv4cYCrpFIFfhkL2Ml
	rgJEA7PCe+W2qn5OwTdGbpfhSIVMhz1fXHdX21hXwopAnWoOpaISY700LwkZH4NH
	UVKilc361QCE3VHGFiTKQPfYZPv8roEDbFwGr2lf/oTzux2CrD0CHNhReiwjF12a
	VT0ogiiikNgileUuE6quZk7oH7aof+HCHnP0syjmvyvCbOERdlXqA80OcPnMQb+X
	UDTuYQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7c7jgf13-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:04:48 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b95d06db747so2260422a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762247087; x=1762851887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9xPLj5OuQTlTyOHnok3W+6HBQLXo5qtNB6Mr1AveDg=;
        b=bAIfoEvz2QZnz1VjprnRMRvrqkuKbxGhz/fz9ii76Q4nZPijKTo1cnZ2Z9rTX+0RJu
         JPCc3KBzJH2PaYBp/UzZOvmyc0qb2tC7Hu22RFOl0TZjcKkYcSIYZdK5iygUk8Z3KGlV
         xTYTqLd7DvVDp4jKLzFPfI25x3TQYJd7WzGvTrvgm46PIDvBmXPvoAx/pC6pLWZbGnBb
         E20OSGeBULWkWsshz57iKRGXwFBwsqqoX33Y2gdmU4BY6fgIMMr7q7kLI0BjIVQKJ0QB
         x+YYirLElXJ2Dy3V9RmMmQd1vCrkD6c+TyjY2tYYvO4MAloxieqr9iBVOjKN7XeSaR9v
         ocZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247087; x=1762851887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9xPLj5OuQTlTyOHnok3W+6HBQLXo5qtNB6Mr1AveDg=;
        b=cvW9HUvUCh5rNC/8OUykND/sQW6+mrQTSUUprHCJSC3XPWn/3DpOMJ6LuFRdJ49ZTX
         qjb3gEi4zTRai1uD2IDWP3iQC5UJWzGmmGc+CZZldLuvFsB2swvg6vqGRZoamt/8aHDF
         FRz36PcboFWv2yhbUr5w4JGO4P7LXj1AsmPp8Nap1b0srkEjO+RUCRkUZ8bvMLuO/MUr
         TGSMFk3zofHU54a+bfUXdK4ZiQjhMKFFAJy6jtUeFKZTdre8ehFkwVOlw+A7E1H0jdby
         O1g/o0d7PlqkzFgyYTUl040LvzUOSwQLk5TzEmVplpob8ALC/XfXuojE+zIQWOCrQySt
         Myfw==
X-Forwarded-Encrypted: i=1; AJvYcCWICO1MajZiD/gEhEFv/wlmsLsFVHVnZdlMJwfz146PNLgUZrTGScqR6DVKAiS8TZisTz+hx3VgdI+rdQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBmjpREEx+vWtIKCMa8zjjrQuvPDeoN/hKaL2fO+rUI+U37Evz
	ivFDGFcPWQZ1EnBXurctf4MPWrtbnjblWf5Rikmo2l6IIgNQVRsXYwthZ5UVfRKyqHGR8QUs5T7
	/plkd2fiSeft7Nk55vdYjnfK4rhLgQr+cGCmzdaVmC54znEGPkzAnA7xqGAIr0WWoaqw=
X-Gm-Gg: ASbGncugASZuXDFLGAY6lTu07fib7MPEDE2FnbasTj6zXlbFasl9AJU01CEN/1RTpDB
	gYBeLTn1UJlCmU2Csc4v4ybKYnemoAYBZ2if0JsjKuww3rWVn/I0QbKiCphORFj/I9WgOON4UuU
	hidCyLLwTfl8+Dp6glCARC11dG/B2gpPpiCw0LHTGUMDJRH5C1HZkwiU9PRu/flmykRF6NjXHu3
	eIot9nsn5zFZCJbTcbj/ifWiMBPFbV74+KD8W6ZZ8dTmn/dMHOwQ7tg/WL9VvFqxvll+dME3s/m
	xZTEJr3H75AUKNJG8b/IlG6HWjwyR7lrsQcnM//IOgq3SwE5d/cYQQrpK2BtzYM8HMDkRH1NTuM
	gOMWHKFiYp0sLRAsw1LXsHdlHlHMuWMEY/Drf/tXirQbxg7bkmDr6wo51XXQvVUXceSntLA==
X-Received: by 2002:a17:90b:3c49:b0:33b:6bff:35fe with SMTP id 98e67ed59e1d1-341718b2361mr3097139a91.16.1762247087252;
        Tue, 04 Nov 2025 01:04:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJApJqx3lrXFfpDcrgrSMCEpUiaPyHMY1h3YbxI1Rwfo2sneImhYdBZuyhjjp1R6yRMH6THw==
X-Received: by 2002:a17:90b:3c49:b0:33b:6bff:35fe with SMTP id 98e67ed59e1d1-341718b2361mr3097078a91.16.1762247086692;
        Tue, 04 Nov 2025 01:04:46 -0800 (PST)
Received: from [10.133.33.122] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3417d1fab3csm897778a91.11.2025.11.04.01.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 01:04:46 -0800 (PST)
Message-ID: <7fc6ab09-44c9-434c-ab19-764c74b1176b@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 17:04:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] arm64: dts: qcom: Introduce Kaanapali SoC
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Tengfei Fan <tengfei.fan@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-2-3fdbc4b9e1b1@oss.qualcomm.com>
 <36fcea98-06a6-4ca7-a378-77b44b196a9d@oss.qualcomm.com>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <36fcea98-06a6-4ca7-a378-77b44b196a9d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA3NCBTYWx0ZWRfX3ThwT1YO3smy
 Zr6O8VvI01m9TUUonlbJrSonJAIHAHDpcoTuiFGUwDbdPjoAQWCqYb5AMb+/jZ7tqW/F4LOczVS
 PPNtczWMrFURBBSCYde9j9jDD/k5b7LzlI0b4z1SfEyYPpNGVt4cb3kcrMLpJr6fH0t7dww8u4m
 OAgmyRzrtY6u3iPBSPUPZTvYTEP/KbB0sf7idwJDZ3Aqi/VC+xDLJjb42gxFglWAukK7D7LaPyF
 Zr6cB1EMU7+o7svnFXBBSNfIxJhpTwME3Tggx4lBlBjll6NwOSiV3B/J9DPtLaBdXrRPbAUMlxO
 r9RybCzsSB+N4kDZokbiL2zMlAihaP5LaxeMifew0cgsmNh/YTGS4wzBFGuk1oI0Dt04q8YRwgI
 YM/Mk9z/s7GzKEfQ9vqbQsHDBcvb8Q==
X-Proofpoint-ORIG-GUID: sHBqRafqK9tgZ7FnL1Dr-JRw9BzUn4fg
X-Proofpoint-GUID: sHBqRafqK9tgZ7FnL1Dr-JRw9BzUn4fg
X-Authority-Analysis: v=2.4 cv=DvNbOW/+ c=1 sm=1 tr=0 ts=6909c1b0 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=x9Fsha1zsCYNIy44pjYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040074



On 10/14/2025 7:46 PM, Akhil P Oommen wrote:
> 
> 
> On 9/25/2025 5:47 AM, Jingyi Wang wrote:
>> Kaanapali is Snapdragon SoC from Qualcomm.
>>
<...>
>> +
>> +    reserved-memory {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        ranges;
>> +
> 
> This is missing a bunch of reserved regions which causes device crash when you stress memory allocation.
> 
> -Akhil.
> 

Hi Akhil,

We will not add all the reserved-memory in dts, other regions are designed to
be added in bootloader.

Thanks,
Jingyi

>> +        pdp_mem: pdp_region@81300000 {
>> +            reg = <0x0 0x81300000 0x0 0x100000>;
>> +            no-map;
>> +        };
>> +
<...>
> 


