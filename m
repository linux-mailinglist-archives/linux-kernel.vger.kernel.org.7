Return-Path: <linux-kernel+bounces-802807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C3CB45731
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D459A16DF7F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F406334A337;
	Fri,  5 Sep 2025 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GBoN9RpM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A722DCF62
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073896; cv=none; b=cfiFiZsMUaIya3W37RWOImvYaYT3gRHm2EGE3f5lFCY1Qwxqgd5aqB25AXlX+93qFLsGuXxEg4MbCN6XKKErHH49U4bg6pChBzQPwdgTxHDcAX93TBrHLuG4rcvwREWoo4msrb9rmu2YUL1vP1UDrixTGutyVDWO4Ji3pbDZayg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073896; c=relaxed/simple;
	bh=CKJR1UXErJMqU7CHSnOAY8gQQIgTBqYaQgB/aD+Ka9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pu2FNLpyXZN6o0pwh0Q6c3zGwZD+Rd0BW1l5/dSdExqZiWcHFy8JTUUp3WRQqDKqkiDIZoGYLdGrQAAiS6NB4mZdSFOdIFc7vta2APeTTiNSbdb/Z4HJlG8zJPrD2iBU0mqxyolmT/rW1Zyq618iuhTX7KNypKHEEuBNWnG/wOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GBoN9RpM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5856ekmg022145
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 12:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7V6g3pF18kS88E7syRdBPWgAVN+Oj7kxFaYlpmHqpUA=; b=GBoN9RpMfO+hNpxR
	LrOMhXgWgLdwvnQKotq/Nyvhxz3rnN0KBBFO+k8901ZupA3s3dyHJhW8zbzkFGZ1
	l81PjdatDe2e2iYdjlvxN8cSG1xDEC2Dd4gUnZJczVudQ60g1syVh2VgYkeCqPLS
	83IJHdgRX5Hw6bZS5TxBgx3mYAt0RCl0IwFVDQ2HE4y+1EnlZkrZvALocQB2jGNS
	p0rpSfS8X+BZiFlVAWyl/ZG80+Da4hKJguX02ffnyuVL5IGWwQVIEp/7Z1JdMyIk
	qKqkJijN5/u13fK9up7kph88hxf9zmGRLJXfHa35NkiZUcyV9TEDq8iqEYmVIoNl
	Bb5sqQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk9awhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:04:53 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-52db72e4157so152902137.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 05:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757073892; x=1757678692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7V6g3pF18kS88E7syRdBPWgAVN+Oj7kxFaYlpmHqpUA=;
        b=YDNKPDt7IRHUZIYulNnSXW1za94drBmlGWQQBQkAyPwEcT86S4/7ZO/zn3nU498K2P
         DV3w7CphxhTXOgNxjVTWfZD7ODw6Y8ypBkQKNG8IJVryAUSR14xlqXlX1QXKlIW7xPlj
         dZby9hWqsid7RPNyMzJeH+CGmMltfKRZv/dVEAIuaY3w8X64bQyptF420tWzbH9MhPCM
         rirjrKD8jeOQz9l6GAKIgNRaLnTA+EkbQALKn4TAi3SGa7Hs6A017bnkUtruZ5hNI+QA
         bzZTs0tIcHLH2VFlKicGawb9NtDr3/J4u/UhPgh9h4s+d7Md2b3G6Y1d9CXJHP1zszYl
         SWEA==
X-Forwarded-Encrypted: i=1; AJvYcCUjBnUS0xkumUkLoFBtir/wBU9kv3o61uGISvY/aUf8uL8nxc1TLAyH0ttr/gKrRjcgxGJwtVUSdMUNEzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUs2EM1Od9IZZH7euv0AP7BvH2i5DFEpIieR4y8LRPwBC9/0+S
	7DqeKYw0TPsjAHgL8IaXkUVuh1NlqCTJhcNPznKE79J1e6SaWGATAruGqsv7lqvS2TNy4FTpg96
	JhOGSbeVp9lXiz+x6cII1thL3kb5FobKdyi5OX9cvIj5MpwArvItPraIxHIA/q0BeF+I=
X-Gm-Gg: ASbGnct5SVqwpXsNTCiTXS9SfWK9BMcreBj42jsJ8KA0H59uTv0pu8gJpJXt9VBHRHn
	PQ3iNCRRv4Ijfa8IYLc4EeIf102Sfji17O4HwjOqYfod31mynxe+B/mCIedscJuVPv0qflYW2On
	0cxLbR4ZX/YLvpDbnP2od6JFkirdO5EBob/jgcPxM2WG3dSyqV9y/rKsq+PZTEI9x8KclaFgcPB
	GdiX2DgnE3u3v0bFwzPyszp6HFl/S50c26n4DsyRdc6AxZ1B2HKHZCF4bLLSl3trj4RVy4U+Bzz
	2n7AQrYOU4YmWJl8yNtDHuPjAI1WUnRC2tVrwGQ+qXg/ezqOBndNGDe1GbcdTXrf/26dV9luyOM
	fdVnaFVYCVFzae0lRPc8r+g==
X-Received: by 2002:a05:6122:630b:20b0:53b:104c:8ef with SMTP id 71dfb90a1353d-544958f1256mr2482513e0c.2.1757073892308;
        Fri, 05 Sep 2025 05:04:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYH6Gpw2ODnZPU7Gl4si6T8PTWLun5b6ZfDzHmiq7n2fFtXqLoZORHaroZpIDTDGTs7mnc1Q==
X-Received: by 2002:a05:6122:630b:20b0:53b:104c:8ef with SMTP id 71dfb90a1353d-544958f1256mr2482490e0c.2.1757073891752;
        Fri, 05 Sep 2025 05:04:51 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc52ae40sm16176794a12.44.2025.09.05.05.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:04:50 -0700 (PDT)
Message-ID: <53aac104-76fb-42b8-9e0d-0e8a3f59b2da@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:04:47 +0200
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
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-2-08016e0d3ce5@oss.qualcomm.com>
 <rxd4js6hb5ccejge2i2fp2syqlzdghqs75hb5ufqrhvpwubjyz@zwumzc7wphjx>
 <c82d44af-d107-4e84-b5ae-eeb624bc03af@oss.qualcomm.com>
 <aLhssUQa7tvUfu2j@hu-wasimn-hyd.qualcomm.com>
 <tqm4sxoya3hue7mof3uqo4nu2b77ionmxi65ewfxtjouvn5xlt@d6ala2j2msbn>
 <3b691f3a-633c-4a7f-bc38-a9c464d83fe1@oss.qualcomm.com>
 <zofmya5h3yrz7wfcl4gozsmfjdeaixoir3zrk5kqpymbz5mkha@qxhj26jow5eh>
 <57ae28ea-85fd-4f8b-8e74-1efba33f0cd2@oss.qualcomm.com>
 <xausmwmh6ze5374eukv6pcmwe3lv4qun73pcszd3aqgjwm75u6@h3exsqf4dsfv>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <xausmwmh6ze5374eukv6pcmwe3lv4qun73pcszd3aqgjwm75u6@h3exsqf4dsfv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ky_x0rmI42edtQewnJDjD1MfISx2mp8K
X-Proofpoint-ORIG-GUID: ky_x0rmI42edtQewnJDjD1MfISx2mp8K
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68bad1e5 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=GsIQqm9gGXrf3KcGJ_IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX8NDVuJTqX7d3
 Qy2igAu5U9jC+rlfjbBul6mT2v6cKlriNI/N+ZhAqUYMEozxRoAA5aEY7xRQU56cr2GHsX6JqoU
 0SucXiVckGlvrBUS3ACl7Blspg3dxETHOwJ1PpQu3o66h1y5p2ICloHrp/Do4BgpBfAEdgNwi1H
 wGq7k4NPXNCLnqN3h+W5pOHRQYfBjz4N3bnl+OPNcomlHB5PaLOnwYSgUJIX/uEGKRvdRIclcNA
 lU9tOgIB0Tp/exqmWyPLox+ESYiLklp3J3+aGqNanCxcMs39Pnh80sxeOis4h1ZTZlMYHAsFID9
 f39Io6gFkfSySmloiBk7DIo3oXh64R4QhhEzfh04tjkda8Th1ia5d67attE2y3Qdox+Et9vF7k4
 Urkj9ll5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

On 9/5/25 1:45 PM, Dmitry Baryshkov wrote:
> On Fri, Sep 05, 2025 at 01:14:29PM +0200, Konrad Dybcio wrote:
>> On 9/4/25 7:32 PM, Dmitry Baryshkov wrote:
>>> On Thu, Sep 04, 2025 at 04:34:05PM +0200, Konrad Dybcio wrote:
>>>> On 9/4/25 3:35 PM, Dmitry Baryshkov wrote:
>>>>> On Wed, Sep 03, 2025 at 09:58:33PM +0530, Wasim Nazir wrote:
>>>>>> On Wed, Sep 03, 2025 at 06:12:59PM +0200, Konrad Dybcio wrote:
>>>>>>> On 8/27/25 3:20 AM, Dmitry Baryshkov wrote:
>>>>>>>> On Tue, Aug 26, 2025 at 11:51:01PM +0530, Wasim Nazir wrote:
>>>>>>>>> From: Monish Chunara <quic_mchunara@quicinc.com>
>>>>>>>>>
>>>>>>>>> Introduce the SDHC v5 controller node for the Lemans platform.
>>>>>>>>> This controller supports either eMMC or SD-card, but only one
>>>>>>>>> can be active at a time. SD-card is the preferred configuration
>>>>>>>>> on Lemans targets, so describe this controller.
>>>>>>>>>
>>>>>>>>> Define the SDC interface pins including clk, cmd, and data lines
>>>>>>>>> to enable proper communication with the SDHC controller.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
>>>>>>>>> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>>>>>>>>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>>>>>>>>> ---
>>>>>>>>>  arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
>>>>>>>>>  1 file changed, 70 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>>>>>> index 99a566b42ef2..a5a3cdba47f3 100644
>>>>>>>>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>>>>>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>>>>>> @@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
>>>>>>>>>  			};
>>>>>>>>>  		};
>>>>>>>>>  
>>>>>>>>> +		sdhc: mmc@87c4000 {
>>>>>>>>> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
>>>>>>>>> +			reg = <0x0 0x087c4000 0x0 0x1000>;
>>>>>>>>> +
>>>>>>>>> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
>>>>>>>>> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
>>>>>>>>> +			interrupt-names = "hc_irq", "pwr_irq";
>>>>>>>>> +
>>>>>>>>> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>>>>>>>>> +				 <&gcc GCC_SDCC1_APPS_CLK>;
>>>>>>>>> +			clock-names = "iface", "core";
>>>>>>>>> +
>>>>>>>>> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
>>>>>>>>> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
>>>>>>>>> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
>>>>>>>>> +
>>>>>>>>> +			iommus = <&apps_smmu 0x0 0x0>;
>>>>>>>>> +			dma-coherent;
>>>>>>>>> +
>>>>>>>>> +			resets = <&gcc GCC_SDCC1_BCR>;
>>>>>>>>> +
>>>>>>>>> +			no-sdio;
>>>>>>>>> +			no-mmc;
>>>>>>>>> +			bus-width = <4>;
>>>>>>>>
>>>>>>>> This is the board configuration, it should be defined in the EVK DTS.
>>>>>>>
>>>>>>> Unless the controller is actually incapable of doing non-SDCards
>>>>>>>
>>>>>>> But from the limited information I can find, this one should be able
>>>>>>> to do both
>>>>>>>
>>>>>>
>>>>>> It’s doable, but the bus width differs when this controller is used for
>>>>>> eMMC, which is supported on the Mezz board. So, it’s cleaner to define
>>>>>> only what’s needed for each specific usecase on the board.
>>>>>
>>>>> `git grep no-sdio arch/arm64/boot/dts/qcom/` shows that we have those
>>>>> properties inside the board DT. I don't see a reason to deviate.
>>>>
>>>> Just to make sure we're clear
>>>>
>>>> I want the author to keep bus-width in SoC dt and move the other
>>>> properties to the board dt
>>>
>>> I think bus-width is also a property of the board. In the end, it's a
>>> question of schematics whether we route 1 wire or all 4 wires. git-log
>>> shows that bus-width is being sent in both files (and probalby we should
>>> sort that out).
>>
>> Actually this is the controller capability, so if it can do 8, it should
>> be 8 and the MMC core will do whatever it pleases (the not-super-sure
>> docs that I have say 8 for this platform)
> 
> Isn't it a physical width of the bus between the controller and the slot
> or eMMC chip?

No, that's matched against reported (sd/mmc) card capabilities IIUC

Konrad

