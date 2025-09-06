Return-Path: <linux-kernel+bounces-804116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E63BB46A28
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 10:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BDBEA07217
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 08:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A302D0612;
	Sat,  6 Sep 2025 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I8RDQYrQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102D02C2377
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757147335; cv=none; b=C07A1jtsRFOQeWHubYTlWpjz7bPO7Upd0oNJCAKzjvgRVrm8CGz2yE8QzF3x2Wh6BWYhXrgLt9bJP+rGSRojycPJ0CpyB0UtyHkzywaSpUnwiKjGqVit4lZv8qx8T5grYwH9DgAHWFD8rldyGJPqZ7aAe54E+MP2RutzpYyoK3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757147335; c=relaxed/simple;
	bh=n3YYbeyql2yL1SH/t8tDGUT7N9M3cy6l+tco6F3vxpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fdV8YoW9+XteWxDN4TYyXbKz94lTRuHtudbFhwaERPHkDbwuepqNkMz86kGSrIvrIxOhCrwUZ37xKxd3h2Kk2mDhSATjpfZAjr8FjOIoLcMxYrBskRnkqQopfnha982kHDhWhvK7WPIJl4MVo9eDCAC4EnwtIfSgprhCOhYwGBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I8RDQYrQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5863jjRU010717
	for <linux-kernel@vger.kernel.org>; Sat, 6 Sep 2025 08:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qKdwIMsuOs8hXrBNQvvXPiZ2vNFLXyJWMTWiOB3kSMs=; b=I8RDQYrQJI5XWMYG
	CVEND3u+va15bk5ulW5EfdlM4vvd5k1tM1eUxBQixl3x5b0aeLEuMhVx8ujbbwmO
	dqvUa93y5Nkxmvb5HExqDppVers2XyHafDjkEbjrjQXBwFFsQz9AxP/A/jECRWQc
	J2H3Ldb3tlf8ocMeOF5MrRR1dqsqwz+T8odDroQw1p9O2KqzCfgd5rVZ2x1L4nsH
	20fQbDThEhMx6RH9Z0U0NenbDUVy4rZMbfpLwXWS122i1WcrGqZtXpKjp52uyhwX
	EA8keiXZ2YXIDlWxxReqhXc7n0cnJv/yuEtrrNYsSQaXkl6k5FAzS5LSgnvDLn8Q
	LMHDzA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db88ben-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 08:28:52 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b32216a52cso8372391cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 01:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757147332; x=1757752132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qKdwIMsuOs8hXrBNQvvXPiZ2vNFLXyJWMTWiOB3kSMs=;
        b=M+BcnuPrnrZH19J9NZOE8HKs8SnCgKFoxla0ANrRxKXy2ixs61lrYuYjHUiX4syMYr
         DqSsfIAty/dcPxswGEfRXI9hMbG9UFir+eeU5iTgGxeqEDytVDdDa60RE6O0QtAYk3OI
         FPY9m+M3XK+flGva9vjDBUsoNZCI14EN7PeDkKp2F64xxvRW5PdaMwT3syVCWSARhPj4
         5y24+lNTBE7YvwhQgrBfwEyyBHrZHFGngf2wE7aZdKxDcbZ/20pnwD/Dh1ki+7OagOlm
         5HuUzBRZvZXoRx3FwU70sWNUrUim2Ss7H6hPZej67zTSxbY6XecsEG0TIH0N+l1ML/KE
         KvCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTnq7oF0/cODMOb907Up6+bI7D35PyztV5SmUiM67UA/oeKjfhRGaIxWBbl4IpdjnMzq72aEZjfVHMCAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMsZJ8hDre1qgXwJ6oGSv1Y/T7pUNF/Ud5stwCtcedwGgX1OhJ
	XrnJgALtdfL8sCLvPOCyUFf/feeDxc88fJCy3wFBp04nHAIOH1Lhxj3CrNj8XMm0LMcd9xsxzqU
	cZQDvGuZZ2pW2z7A7v2F7l/vzxh9b+OiT9/AQtKkrw07gYdHfVYUcewEmyeVXpuKbZ7o=
X-Gm-Gg: ASbGncuIbYAp39ub6ej9IXA2xEDIrhrUIk4ZP25O4AWONNycm2ye7bpBbJoNtFERh1m
	yI7koPkrX512rQMjDR7CsTwMeAIsV6STf54CtVnj08tuEhoNMqwaOKgYzULueE6dsxEl1OUXiwn
	RXnmHncvy3nE1c0EXZq26Yw/EqPysg5IxPGvSOmrVuSXAILqQN+WojuxYzpFJKe584RDkRl0Y+q
	hbnXTOciAFHTVmulWI16nhUP6/b9G4Yflkk192igmLfIZNRmqLhO46bpCLW2sei3yIelPAg8THX
	jBOdVD/DDU6g3jYF4nZhqToVg3G4gMO9CVnpctqpBmphgqyaTe9Nfi/mDJVfAMjiQ90t71BzF54
	FWffjoPiWd/DvqK3yyzSCoA==
X-Received: by 2002:ac8:5a82:0:b0:4b5:eb76:3c6a with SMTP id d75a77b69052e-4b5f8464b47mr9538871cf.12.1757147331729;
        Sat, 06 Sep 2025 01:28:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3y3GSyZNNkgjIVF+qqXTkBKrkNGyGUS1amXxGqYrBzXr417aU+8RqZGf0t3Sfd6GltOwwIA==
X-Received: by 2002:ac8:5a82:0:b0:4b5:eb76:3c6a with SMTP id d75a77b69052e-4b5f8464b47mr9538561cf.12.1757147330963;
        Sat, 06 Sep 2025 01:28:50 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b041800e89esm1548972366b.30.2025.09.06.01.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 01:28:50 -0700 (PDT)
Message-ID: <d3e96be4-8c78-4938-8072-abdb0f0e8f05@oss.qualcomm.com>
Date: Sat, 6 Sep 2025 10:28:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: qcom: lemans: Add SDHC controller and SDC
 pin configuration
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
References: <20250826-lemans-evk-bu-v1-2-08016e0d3ce5@oss.qualcomm.com>
 <rxd4js6hb5ccejge2i2fp2syqlzdghqs75hb5ufqrhvpwubjyz@zwumzc7wphjx>
 <c82d44af-d107-4e84-b5ae-eeb624bc03af@oss.qualcomm.com>
 <aLhssUQa7tvUfu2j@hu-wasimn-hyd.qualcomm.com>
 <tqm4sxoya3hue7mof3uqo4nu2b77ionmxi65ewfxtjouvn5xlt@d6ala2j2msbn>
 <3b691f3a-633c-4a7f-bc38-a9c464d83fe1@oss.qualcomm.com>
 <zofmya5h3yrz7wfcl4gozsmfjdeaixoir3zrk5kqpymbz5mkha@qxhj26jow5eh>
 <57ae28ea-85fd-4f8b-8e74-1efba33f0cd2@oss.qualcomm.com>
 <xausmwmh6ze5374eukv6pcmwe3lv4qun73pcszd3aqgjwm75u6@h3exsqf4dsfv>
 <53aac104-76fb-42b8-9e0d-0e8a3f59b2da@oss.qualcomm.com>
 <zw6o6nxczrzz3dkreq2nuxalbrlv7jmra2hs3pljew7xnbuepo@b6rs47vnnctx>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <zw6o6nxczrzz3dkreq2nuxalbrlv7jmra2hs3pljew7xnbuepo@b6rs47vnnctx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX6eW1cj639XBB
 hYtCHkw9rKjoCFLPPwQeoxVPo5VYrQEM+RYPyJajSj/0k1h1U4CkYaSPI1GtHUyKg7xJQsEPPLt
 9KLWu1JhWaol48F2nRVF6M8nFE7B1O/cX4hSbrbceYguNdAAxJuhmPAGBLlGMLjViC8PNWw0EnL
 7ucmHQwz1mWc1XtdLGmxU1s1i60R7NuHz7MNAED2qnq7Wo5xsvrBONPDSTrt+L8E7ua07reyf1H
 LydUtJmyw0gXDyQfnjfH0qZeKBmpWGtCuRbWhmfBAeyXTHrK1FHv2LyjduJtvKouZk4GSwzKFGl
 hZsK3DniQnuFGfAwO0nIm11LWWTnmcwk42x04NnF5gOLuE+P4TLKTevXvHJa41xCDzqqGJeMSOg
 xoMDW2hh
X-Proofpoint-ORIG-GUID: ufaH2j8sgidCHJeSslGdjkNeMNnt2ZUf
X-Proofpoint-GUID: ufaH2j8sgidCHJeSslGdjkNeMNnt2ZUf
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68bbf0c4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=pmlacQdDjGSF83KW4JAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-06_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

On 9/5/25 3:44 PM, Dmitry Baryshkov wrote:
> On Fri, Sep 05, 2025 at 02:04:47PM +0200, Konrad Dybcio wrote:
>> On 9/5/25 1:45 PM, Dmitry Baryshkov wrote:
>>> On Fri, Sep 05, 2025 at 01:14:29PM +0200, Konrad Dybcio wrote:
>>>> On 9/4/25 7:32 PM, Dmitry Baryshkov wrote:
>>>>> On Thu, Sep 04, 2025 at 04:34:05PM +0200, Konrad Dybcio wrote:
>>>>>> On 9/4/25 3:35 PM, Dmitry Baryshkov wrote:
>>>>>>> On Wed, Sep 03, 2025 at 09:58:33PM +0530, Wasim Nazir wrote:
>>>>>>>> On Wed, Sep 03, 2025 at 06:12:59PM +0200, Konrad Dybcio wrote:
>>>>>>>>> On 8/27/25 3:20 AM, Dmitry Baryshkov wrote:
>>>>>>>>>> On Tue, Aug 26, 2025 at 11:51:01PM +0530, Wasim Nazir wrote:
>>>>>>>>>>> From: Monish Chunara <quic_mchunara@quicinc.com>
>>>>>>>>>>>
>>>>>>>>>>> Introduce the SDHC v5 controller node for the Lemans platform.
>>>>>>>>>>> This controller supports either eMMC or SD-card, but only one
>>>>>>>>>>> can be active at a time. SD-card is the preferred configuration
>>>>>>>>>>> on Lemans targets, so describe this controller.
>>>>>>>>>>>
>>>>>>>>>>> Define the SDC interface pins including clk, cmd, and data lines
>>>>>>>>>>> to enable proper communication with the SDHC controller.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
>>>>>>>>>>> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>>>>>>>>>>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>>>>>>>>>>> ---
>>>>>>>>>>>  arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
>>>>>>>>>>>  1 file changed, 70 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>>>>>>>> index 99a566b42ef2..a5a3cdba47f3 100644
>>>>>>>>>>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>>>>>>>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>>>>>>>> @@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
>>>>>>>>>>>  			};
>>>>>>>>>>>  		};
>>>>>>>>>>>  
>>>>>>>>>>> +		sdhc: mmc@87c4000 {
>>>>>>>>>>> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
>>>>>>>>>>> +			reg = <0x0 0x087c4000 0x0 0x1000>;
>>>>>>>>>>> +
>>>>>>>>>>> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
>>>>>>>>>>> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
>>>>>>>>>>> +			interrupt-names = "hc_irq", "pwr_irq";
>>>>>>>>>>> +
>>>>>>>>>>> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>>>>>>>>>>> +				 <&gcc GCC_SDCC1_APPS_CLK>;
>>>>>>>>>>> +			clock-names = "iface", "core";
>>>>>>>>>>> +
>>>>>>>>>>> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
>>>>>>>>>>> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
>>>>>>>>>>> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
>>>>>>>>>>> +
>>>>>>>>>>> +			iommus = <&apps_smmu 0x0 0x0>;
>>>>>>>>>>> +			dma-coherent;
>>>>>>>>>>> +
>>>>>>>>>>> +			resets = <&gcc GCC_SDCC1_BCR>;
>>>>>>>>>>> +
>>>>>>>>>>> +			no-sdio;
>>>>>>>>>>> +			no-mmc;
>>>>>>>>>>> +			bus-width = <4>;
>>>>>>>>>>
>>>>>>>>>> This is the board configuration, it should be defined in the EVK DTS.
>>>>>>>>>
>>>>>>>>> Unless the controller is actually incapable of doing non-SDCards
>>>>>>>>>
>>>>>>>>> But from the limited information I can find, this one should be able
>>>>>>>>> to do both
>>>>>>>>>
>>>>>>>>
>>>>>>>> It’s doable, but the bus width differs when this controller is used for
>>>>>>>> eMMC, which is supported on the Mezz board. So, it’s cleaner to define
>>>>>>>> only what’s needed for each specific usecase on the board.
>>>>>>>
>>>>>>> `git grep no-sdio arch/arm64/boot/dts/qcom/` shows that we have those
>>>>>>> properties inside the board DT. I don't see a reason to deviate.
>>>>>>
>>>>>> Just to make sure we're clear
>>>>>>
>>>>>> I want the author to keep bus-width in SoC dt and move the other
>>>>>> properties to the board dt
>>>>>
>>>>> I think bus-width is also a property of the board. In the end, it's a
>>>>> question of schematics whether we route 1 wire or all 4 wires. git-log
>>>>> shows that bus-width is being sent in both files (and probalby we should
>>>>> sort that out).
>>>>
>>>> Actually this is the controller capability, so if it can do 8, it should
>>>> be 8 and the MMC core will do whatever it pleases (the not-super-sure
>>>> docs that I have say 8 for this platform)
>>>
>>> Isn't it a physical width of the bus between the controller and the slot
>>> or eMMC chip?
>>
>> No, that's matched against reported (sd/mmc) card capabilities IIUC
> 
> What if both host and the card support 4 bits bus (normal SD card), but
> board has only one data wire?

Ohhh, touche.. I assumed it's "smart" like PCIe, but it's (probably)
not.

Sorry for the trouble, Wasim. Let's keep 4 for now and get this patch
merged.

Konrad> 

