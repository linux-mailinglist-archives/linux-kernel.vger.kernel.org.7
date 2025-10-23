Return-Path: <linux-kernel+bounces-866241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD5ABFF45A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29D83A804B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 05:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCD81DE4DC;
	Thu, 23 Oct 2025 05:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="do5rqrOb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5481B1F5EA
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761198523; cv=none; b=OcMMaxzhK7tpEmvCHDXUiNCOFeXO9PtIL+JOc2KM+/qex8D+483LK6XzZ1H+QGDEJOxhvKb/lSOSGCT4UqE7lrtgKarMW+e5GmqLywJfZEQ0eh+r8TXs4m9EPHlGaLRKDt782Jqve2ue6GVSid8uZ2+LS1dL2Vfi8P0+dN4avBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761198523; c=relaxed/simple;
	bh=fFdc6396YV3qp8gHpYWiJRpX9oEEQS3+ZskvtYbqz7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIjEKHb+PTiRNu20MciY+e/TAkG1jGf1X0j9eqO9mc62HFDoB0U/U4jqzmRypXYBJ8cia7+t7zz+MAwGM+Jp2erDUm0jL3MtYN7Kme+0R/3kR8duZQjdm2gAc7Gt4NB+wr3D7hxEH0hUWi/W4u1BWz96m8H64Gc4Bb/bEKPuD8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=do5rqrOb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MIenkN025826
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JrAbvaR3kj71zFeYFeuk9mY4FfPnNJxO9jJ+OKKpEqg=; b=do5rqrOb1CS/5n9q
	KO2H2BnBuoSrvBwZSUxJ2vPi9PauQbZWra4+6/gsZ+zzB9Np+AbVJX2mmWMT8Qbg
	yU1EH+hhndsqLIlIFBFT0tjgUcE1asBe4Wd+QOgEHt6tG9Ww8oTUSHJS2YtaepEE
	2gskGzi37hajMK2p+cxbfWGWFSu8XYT3CkIb+ZqbuZ3zdLpunWuFciL/HudJvFd5
	3OWrj4o/vXIGSZDGnrQj77rOm9MMuHUc+lTn1Kdp8wQ/rir6SCEocAbgrJFmdIZL
	2YrGu+UbRskIQnd8Qty1nJTia66MLd/DhqaYoVBHrY1LebIhT4u+o+NvNJEGwCFb
	YTUYkg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42kf09c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:48:40 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2909e6471a9so3374655ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761198520; x=1761803320;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JrAbvaR3kj71zFeYFeuk9mY4FfPnNJxO9jJ+OKKpEqg=;
        b=lFqrFBnCMhbIHhXIN5OePZhQ8sZq+HBDiizqy/LSAOj6nVaFbfumetHt1d3/0Fjl0H
         HM3gexFWMCmeFfZjf+w9NujxZdzaq/CtGKwBJ5BHBsWIMZf72tM1LLB6pYLRQQghOF7J
         PsuXizanv+nZ1dbpkapj96Kx8pgjJQoXHAKF3eRkdEL3Xn6B9cmE5ePZQhwJc96A5HDA
         fXprisIPHkWkQ/S7PIPwheD2bwEBhtLGo+LKvegUCniEcfm/cXQ5CNQupM0+32mpa8pE
         izRdHN1YGA22V+rfjWNf+ZLczKN7MaXWV74c2qOFEsgSCPOfyz8TPFAGgXKJycSSSks/
         4HPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxWdInW/NCZ8XZo9VX5YnaJ2qGLg14K6Nsoaa0/hK7L68rjSO/mvEGPUv9hYBsJlV2pYbok7jV8qc+EaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSkLQMxAdI37/4FXHVDfumQzkBDRk6DAafbvyoJueWCMZEIY1L
	KVzs8kglkgv2U/RnTdrYscb1PhgyUHaYf6qCy7UdSDbE+ym4Erju5xKzwZ9pVq0syax3hn5dmU/
	P/Dj+PI2p8Bal5BXp9I+yXriQ0MWinhgDWh5vguHFyGNFOBMiK+RV/w0FOea9HbEx2/w=
X-Gm-Gg: ASbGncuWpWPYLYclm5mn09LIoUvbeZFBL5HdZcnNadZC2SsVuXdVbf+p42OgSLCyLz+
	X6lQaxTgwFZUVuJBJP710VX41lUN3pzMetRKVcj2Q1a9JgJlryYPcVZDaMnfiKFHcAL8+yhlbwd
	W9w9Ra8Ipu4PWw+dARXTCM6ymYtUAxO45WTkAyBuWRl+R1wrGZL2YSO4W3j2NR71kA8MPkJH3Eo
	2tlnTTFD1U8OU7uWU7WAfqObW7Iv7Txwp/oSUi3XryIRajT0rlyNpvqTAB20zIKoxbBy16G4fUR
	c79lqfVYjRmjIWWa8ZdUdZnemUPgCiK/WRH9A9jeFY3ZlP5NGBvoC7CnWmVHexXvQ7xnHFL+cIX
	+wcY1aP5hrsXq3v83yYJKPkILG+mrf5bnaxE=
X-Received: by 2002:a17:902:dac3:b0:293:b97:c335 with SMTP id d9443c01a7336-2930b97f30amr49641575ad.10.1761198519487;
        Wed, 22 Oct 2025 22:48:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE414ZuQeAjj1s8ukfHJGq4S1BByXgimfEW6LV09f/2szbaSY63uZ7cYGo3JUB6Biku9QiOkA==
X-Received: by 2002:a17:902:dac3:b0:293:b97:c335 with SMTP id d9443c01a7336-2930b97f30amr49641305ad.10.1761198519003;
        Wed, 22 Oct 2025 22:48:39 -0700 (PDT)
Received: from [192.168.1.3] ([136.185.198.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e1106d8sm10657515ad.92.2025.10.22.22.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 22:48:38 -0700 (PDT)
Message-ID: <64b3c6e8-b21d-46ff-a3ef-add249b99751@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 11:18:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] arm64: dts: qcom: sm8750: Add USB support to
 SM8750 SoCs
To: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20251022084052.218043-1-krishna.kurapati@oss.qualcomm.com>
 <20251022084052.218043-2-krishna.kurapati@oss.qualcomm.com>
 <pr64zyppjyk7zpfsscx2dt6weuskoxyot2ldkhnzkaxrbzgo64@ptvc627f5l5c>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <pr64zyppjyk7zpfsscx2dt6weuskoxyot2ldkhnzkaxrbzgo64@ptvc627f5l5c>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1uQMk2BTqHm7sIlOSD_bw7lFptLUhSEz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfX3juoAeaKpjIc
 5yC0B6o8gHke6gM8inj36NelIeccLEN7t9HTOxMnMP3aEGxVFw61FMDUuFoHZN330derMA9xHtR
 V+cguv/+jXYzgeQJ+3w+ZypQFsBO1jEDVP+NVd5nkkdp1GUsonw5DwqKh+49d/fnQCRwm3RUJGS
 PG+Ec3gG91RVQi/2CBohJbQWzVtlYZeBoup7Q+HFtONZW9QS2W+ne+lNLOEFLimKvDhnRa5PYaa
 DPh+E3sPckVQtFWYCHYgrBRnfPj3yAQe4v2OgqqeC/vcXH5IY4Xfg9J8eQomlvJbOO135HILHWn
 iswWJycv5meO8Vyq8cMquI43xd6ojsn8xB6Mbsp0+fZx7xiwvK3blCI1RUaD6FFy08UPjusFCTE
 OPbGPZR6sSGMAPOMPH9g/053ITHCHA==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68f9c1b8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=sRLNwhOJ/yCBC+ZuepprkA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=g-qGA7akq0XnR0fS_kUA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 1uQMk2BTqHm7sIlOSD_bw7lFptLUhSEz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031



On 10/23/2025 2:03 AM, Bjorn Andersson wrote:
> On Wed, Oct 22, 2025 at 02:10:50PM +0530, Krishna Kurapati wrote:
>> From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>>
>> Add the base USB devicetree definitions for SM8750 platforms.  The overall
> 
> Please start your commit message with the problem description and leave
> the description of the "solution" to later.
> 
> If you replace "overall" with "SM8750" the second sentence is a good
> start.
> 
>> chipset contains a single DWC3 USB3 controller (rev. 200a), SS QMP PHY
>> (rev. v8) and M31 eUSB2 PHY.  The major difference for SM8750 is the
> 
> "The major difference from previous SoCs is the..."
> 
>> transition to using the M31 eUSB2 PHY compared to previous SoCs.
>>
>> Enable USB support on SM8750 MTP and QRD variants. SM8750 has a QMP combo
>> PHY for the SSUSB path, and a M31 eUSB2 PHY for the HSUSB path.
>>
>> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>> Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> This means "Konrad suggested that I implement this patch".
> 
>> [Konrad: Suggestion to flatten DT]
> 
> This syntax is for "patch was originally authored by above, but "name"
> changed it in so-and-so way".
> 
> In other words, while the gesture of giving Konrad credit for his
> suggestion during review is nice, you should omit the Suggested-by and
> you should cover bigger things you changed since Wesley wrote the patch,
> i.e. say:
> 
> [krishna: Flattened dwc3 node]
> 

My bad.

Actually Wesley implemented the original patch.
Konrad provided a diff to flatten it.
I sent it.

Let me rephrase the [] block as follows:
[Konrad: Flattened the dwc3 node]

Hope that would be clear.

>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8750.dtsi | 158 +++++++++++++++++++++++++++
>>   1 file changed, 158 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
>> index a82d9867c7cb..d933c378bd8d 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
>> @@ -12,6 +12,7 @@
>>   #include <dt-bindings/interconnect/qcom,sm8750-rpmh.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/mailbox/qcom-ipcc.h>
>> +#include <dt-bindings/phy/phy-qcom-qmp.h>
>>   #include <dt-bindings/power/qcom,rpmhpd.h>
>>   #include <dt-bindings/power/qcom-rpmpd.h>
>>   #include <dt-bindings/soc/qcom,gpr.h>
>> @@ -2581,6 +2582,163 @@ data-pins {
>>   			};
>>   		};
>>   
>> +		usb_1_hsphy: phy@88e3000 {
>> +			compatible = "qcom,sm8750-m31-eusb2-phy";
>> +			reg = <0x0 0x88e3000 0x0 0x29c>;
>> +
>> +			clocks = <&tcsrcc TCSR_USB2_CLKREF_EN>;
>> +			clock-names = "ref";
>> +
>> +			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
>> +
>> +			#phy-cells = <0>;
>> +
>> +			status = "disabled";
>> +		};
>> +
>> +		usb_dp_qmpphy: phy@88e8000 {
>> +			compatible = "qcom,sm8750-qmp-usb3-dp-phy";
>> +			reg = <0x0 0x088e8000 0x0 0x4000>;
>> +
>> +			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
>> +				 <&tcsrcc TCSR_USB3_CLKREF_EN>,
>> +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
>> +				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
>> +			clock-names = "aux",
>> +				      "ref",
>> +				      "com_aux",
>> +				      "usb3_pipe";
>> +
>> +			resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
>> +				 <&gcc GCC_USB3_DP_PHY_PRIM_BCR>;
>> +			reset-names = "phy",
>> +				      "common";
>> +
>> +			power-domains = <&gcc GCC_USB3_PHY_GDSC>;
>> +
>> +			#clock-cells = <1>;
>> +			#phy-cells = <1>;
>> +
>> +			orientation-switch;
>> +
>> +			status = "disabled";
>> +
>> +			ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@0 {
>> +					reg = <0>;
>> +
>> +					usb_dp_qmpphy_out: endpoint {
>> +					};
>> +				};
>> +
>> +				port@1 {
>> +					reg = <1>;
>> +
>> +					usb_dp_qmpphy_usb_ss_in: endpoint {
>> +						remote-endpoint = <&usb_1_dwc3_ss>;
>> +					};
>> +				};
>> +
>> +				port@2 {
>> +					reg = <2>;
>> +
>> +					usb_dp_qmpphy_dp_in: endpoint {
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		usb_1: usb@a600000 {
> 
> Commit message says there's a single USB controller, so why does it need
> a _1 suffix? (Same with usb_1_hsphy above)
> 

ACK.
Will use just "usb" as node name.

Regards,
Krishna,

