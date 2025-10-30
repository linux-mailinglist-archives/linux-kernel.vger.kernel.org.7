Return-Path: <linux-kernel+bounces-878039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE97C1F9F9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C25C3BB4A0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B8C3446A5;
	Thu, 30 Oct 2025 10:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BzW+ctH5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iwLP20R0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E32343D69
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821092; cv=none; b=hhG5C7/hkqYTak4245VehsuomhNvoHyX7l2VcjqouTCFmBUjMcJS1sHGKtQEcyV+XE3r3zsZJqnbp3x1i4fV1rG87SwzNCSRi3iHrYZqaZcy488n9T5/g7j1qEsQMkGiCfaBtFRsKRYnq5BrVyN1/Ba3hJMpjcpy9buuOQwmVok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821092; c=relaxed/simple;
	bh=NJ1SdBKZD17TzJiAYpxl3MwaFIw8Xn8sYW5G6pKGV/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDvDlaGD/DxKnE+VrFnJSzVqrIj8suNyibeSxeH0/4fP/CNkKdt52x+3oiHewYJxl8hIMpXUgKcRZYcShOEQndn5OWLOXunctnc4jWZl1o5LIeQWpdlw0u1GbCK92mtMIfBaH2eum9ZYSKPueFWExADT+dl2DXGUm10yBJ0hxYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BzW+ctH5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iwLP20R0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UAPKtS3281432
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hXIhpZNNzHDQ4WMOLENQxvtShf8hegEE13tUdSoj2XI=; b=BzW+ctH5iJtGdIbl
	A1bOVuk93E8W10adkencLcN4SzPfVjsS75jMcntyMjfEiKAokU50eBC8U2YuEkrB
	16B/fTx2KBirVdKJMOo4Xx8bowPNtTOFSqVwpPItfPYCnpY8VAhkVzyOXxjYc6Yy
	hWUf7zu/PZxP6c8DZsc3QeIxDgFvG2KOIoLcSmeXDvFA0bIkDXlPlL6S1CinpWJv
	4TG/Lg/68U1zDlGS7ha9ruCsWXLM6CO/VXO8R0SKdP8Fu/Z86RrALcsnFdHhtBGH
	lFq1Ssh0IcwPoQ6WDux3Su7Zh1/Br2ax3uNEuYaE5XMsRZmHsFuf9EeU/XvkcFZj
	U7jMNg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a468kg1fj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:44:49 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a27ade1e73so845862b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761821089; x=1762425889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hXIhpZNNzHDQ4WMOLENQxvtShf8hegEE13tUdSoj2XI=;
        b=iwLP20R0QptD6WLqH4+HBiw13dpd9Kn3a1U3AE70dU3sgTdsSAenGtoIljMJruMyeT
         3WYrcfrPHUVPQ4+mHIVbwfMXLm3mdiMygY91SrnlHyypn3NbtsDdOtrXjmd0w+hywX/w
         lnwSo4mHBmKFZPp+ywvePGfzih6JlkLMqSqDS3u4X8gYB3r7cXGfd7Kv+6QmfAaYPJ82
         haYo/Dw07x0AHwfHLoPo2X/ipHxfML+OP0CeJ1ujIsligzrAmWfkIPCz6B1KTIgrT/cs
         arrVd7ja4wR3HXivHv8sd1WTbhrT1mdkfbn1YyoJ7E0hTU0SU1Flh1V+N9AXet2zFN/M
         oiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761821089; x=1762425889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hXIhpZNNzHDQ4WMOLENQxvtShf8hegEE13tUdSoj2XI=;
        b=tKbuOSzp775SAnDB023gbpdLTrgQriF6RPwv/L+IB1y9AgdZ0toXwDDQmL3neyY93y
         H5uYj1y6Od2zErLLkWNSxjcJore4V0RxvnBWbaLbwazI442aj/uRjEDYePHmiId5fp1o
         DwLkwTktXj5JGDh57T7Q4jfWUYgMIEsNvTuI3nlmImEg4KrIs55IeK894ti9NLxQI0RW
         kLSeWWPjs7GR22oy8rlfwOvqaNMC8Xg+Qw6jcxf4kKO40GCBFvJx3QrNs/ohBTo9kxur
         dE8ilTVcOAN/oxGMUjbPcEf9kYRo6xJjLxV7CVmaIwPnzR0zZ8TbyqZjj4v7xgwZM5Gz
         X4XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMmsKG4kd5w1Kj92kuX4npHy4vsgozjVGzLtWoOKX5cwhjWZWA4V1nx5ZD3qH65+UBIMxLkKM7dnG2vBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6CG80W3oQGx1UTvrBlyI9jta4lwqMXmKuUdCIc9vwJiRFC4BZ
	HH1cA1QcAw4DOpI2EIBZAPZM0Yl2RI8+TmpVN5xlAt9S/bNcvX5vBmERuVCL6WNKPgIb8+f6L9l
	fJgirFKVG9mmtaocn30AoFQ65MOsLzU0ZW2rn7Ch4xIxMTHWgLbxY8AvIgr1a5Yb3BRk=
X-Gm-Gg: ASbGncu5GD5mstaiuenD5l2bB52N28/N0CkoM/bLQXY4JE6zShoQkINsKyOAlNvRkF0
	ZMIdJW79fqHIHnWzjVPGKMg7klu/BjhnctzTipvWiWXaSwOY0eVyc63lTUtuOywQdWnVNso5qaM
	x1Q2oAqRmLyKuy7rJstLWLdOTtlx5hNhawGgwEQHTNxX4s54qE3+Ksbwk14Gk/oB/T1lW7KBzwm
	3lbEPVNiG6qLEgYmoAGBBscbyIZafn/3Njj4fsx58UMMpOxZraZ8NkC/xyjHyaQB7HQJp2Gsxl2
	OU4fMaSzqZqD/XV486wBRuS3S88zfk7DxSsjs6x2OZIHeB/Nkhq/7UuTVzookIhCUmGrvB0oMIl
	oavK4if/ZAeShmO6Iwumlbe7G7Ys=
X-Received: by 2002:a05:6a21:2d05:b0:347:8414:da90 with SMTP id adf61e73a8af0-3478414dac4mr3238189637.0.1761821088739;
        Thu, 30 Oct 2025 03:44:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7ZUbP1cNloe4SPPg3Fub3BgyfPmfkn49K9yBfTrZy1O62kWKmDpe2ebpcLzeLbVJEXw4OTw==
X-Received: by 2002:a05:6a21:2d05:b0:347:8414:da90 with SMTP id adf61e73a8af0-3478414dac4mr3238155637.0.1761821088211;
        Thu, 30 Oct 2025 03:44:48 -0700 (PDT)
Received: from [10.217.217.147] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7128885251sm16213400a12.17.2025.10.30.03.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 03:44:47 -0700 (PDT)
Message-ID: <a52ff3b6-c5f3-48a8-a8d7-812026b0d87e@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 16:14:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/24] arm64: dts: qcom: Introduce Glymur base dtsi and
 CRD dts
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-3-24b601bbecc0@oss.qualcomm.com>
 <2960a6fc-106b-4280-b4d4-9c1a3a449454@oss.qualcomm.com>
 <0a47016c-1d7e-4026-92bb-a13ac2ce169b@oss.qualcomm.com>
 <gg7srymb2dspk4jeycc5su5gjl434ymgzapqqyqw7yq2marzue@ql27qx2ptuo6>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <gg7srymb2dspk4jeycc5su5gjl434ymgzapqqyqw7yq2marzue@ql27qx2ptuo6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA4NyBTYWx0ZWRfX0TQqpPssGJY3
 4pA0dWt+P6dSR8euST2kzbMm+QmI+UKEi1tNyDUSkLp+/7x+D+7+5rzCCm7B5Y6CEHeIZOk//lI
 N/uBzN85ubBRB1tO/KuywLOwOYpLIyhOrJdFFcmYS5jSZE6AG+nQfwea9sb1UNuHDgF+5yQZFKa
 AUny4zHmuafnp4h7ecw4myDThKSOGOYe35vcQAByOUkgqB72PvIDccf+ueCxpRiFcRMGBE9cKch
 x0cznIHAf8dJLAS91ZiyfN6qHDmTtrVFBBx7WlBq6gsD8I3LAGBHHXBj3z9ELqxy+XHyw62g6a+
 SB0yc9AQSG15fCpuSueilFZxTpPh2Vqp/aMNqFtnpR8Fl7qqveKLWhn4PwpK74mBSjVk+CUDgOu
 aT8SjWaLvmzPTeD1QLWv2Y+acNTyVg==
X-Proofpoint-ORIG-GUID: flLwq6HcDBdcwuX3Fueu3BN2Q_Hb8kBM
X-Authority-Analysis: v=2.4 cv=LoWfC3dc c=1 sm=1 tr=0 ts=690341a1 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z2WFzCv5d8wuYGPiYnEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: flLwq6HcDBdcwuX3Fueu3BN2Q_Hb8kBM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300087



On 10/29/2025 4:06 PM, Dmitry Baryshkov wrote:
> On Wed, Oct 29, 2025 at 03:30:54PM +0530, Taniya Das wrote:
>>
>>
>> On 9/25/2025 3:46 PM, Konrad Dybcio wrote:
>>>> +		tcsrcc: clock-controller@1fd5044 {
>>>> +			compatible = "qcom,glymur-tcsr";
>>>> +			reg = <0x0 0x1fd5044 0x0 0x48>;
>>> We can map 0x1fd5000 - 0x1fd5094 inclusive, as that seems like a
>>> logical subblock (this would require adjusting the driver)
>>>
>>
>> Konrad, we encountered issues when trying to map regions beyond just the
>> clock reference registers. Normally, we map the entire address range of
>> a clock controller (CC) module in the device tree. However, for TCSRCC
>> where CLKREF_EN registers are located within shared modules like TCSR or
>> TLMM—we don't own the whole address space, and mapping the full range
>> can overlap with other devices.
>> To avoid this, we propose defining the base address as the first
>> register actually used, and the size to only include up to the last
>> register we use. This ensures we only map the relevant subblock,
>> preventing conflicts with other device nodes.
> 
> Then you need to behave slightly differently: map the full range at the
> basic device (TLMM, TCSR, etc.) and then create TCSRCC as a child device
> to that node (and use paren't regmap to access the registers).
> 

Dmitry, I agree that this approach is ideal. However, the current
hardware implementation isn’t consistent across multiple SoCs, which
means the driver design also needs to adapt. Given these differences, we
decided to strictly map only the range of hardware registers that are
actually used for clocks, rather than the entire module.

>>
>> So want to keep the mapping same from the start of clockref clocks.
>>
>>> There's also a laaaarge pool of various TCSR_ registers between
>>> the previous node and this one.. but we can leave that in case we
>>> need to describe it in a specific way some day
>>>> +			#clock-cells = <1>;
>>>> +			#reset-cells = <1>;
>>>> +		};
>>>> +
>>
>> -- 
>> Thanks,
>> Taniya Das
>>
> 

-- 
Thanks,
Taniya Das


