Return-Path: <linux-kernel+bounces-841519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4994BBB792F
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C42C13470F3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F6F2C21F9;
	Fri,  3 Oct 2025 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JGG2VnIR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6DE28136B
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759509396; cv=none; b=A/3RxpEpRY19Vb/B4GH+dTlkDlkxLY9ND4DOaHDBA2mWuyQ+/Pw+ka3mOrRaM9DZBe6RGV4LOSsbd4W7SF6tiWl0V/GBZ/BlOPTwXqKBbNxjsv2oU6oFqSX660zmpZrGc3d/EpznrWnoqBYzDl27tE7vXSwCS65iQSl55KZAihQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759509396; c=relaxed/simple;
	bh=ZaijyCJq8RhriFIQ2yguFRQneneiApnJF7GrOU1k4fY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRLypA2phK/L7PezJOCDrkfb1eu/IFOq9h8kcouMHrBNZ1gUk5p84wjmFnvMjSI7DNdc+Br/lZT0HJ5o13l5WnNhBgUclB+H6cKjJpxJ4AnWF7bbz5SSAD552K39KNY2i0J2D2Dp8Iz8n5E+Ll6LX1/26JMY2Jxfm077X1LFDLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JGG2VnIR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593AjGQL012709
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 16:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QFFx9CZBotui5rMyhpbxkDYfHjf5bD25BY8RnVU5vWA=; b=JGG2VnIR7XTqtlVl
	4IxPMVHIK/X4dPjT47V+B7JtLBInGEUtyQcjwj5PNnwx2Jy3bkfd0UQ6ie7IGu6n
	8NS/Dx2JuD+xZSj+2Wy/vFUsxm9yo2+YnVDsyTE4XmpNN9ipYdcr96Ru9hlDc8wR
	4Mt0q09y1x/4HpJKa8CliFQ1rBTXDPdx2r2WV2Z+8JZtyFbQZumBDRr/bI52wWgj
	Xbi9FsaW4lIZN71RaGgidMcAFXNa3UhDeG7s12PbIkkiK2/QRIgSvvFmz47s5BM7
	Uxw/AW5rAW1fwqsMWeNe6Tt7kwWtm+luOvCQbNPFStewoXpPhpULJiUjuhKVqgJB
	RqqvFA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80u3huf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 16:36:33 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b60992e3b27so2194135a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759509393; x=1760114193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFFx9CZBotui5rMyhpbxkDYfHjf5bD25BY8RnVU5vWA=;
        b=ua0odpxQRY38s0gVZRVIMs7RbHyR8C8kx6S96NkeqwHfF3ja9qvlRfocFOUBVPVlzG
         F9rMJQRXLm9dwNRfmVW43NGiGDnHXj7DmwqvvKppz6FBAAXOvkPR3AVG+6Jl/uT24z51
         fTP+YmJulenl8uheboeHUSiUUDZthDzu01bTYdSKiTCHs8Aq9hkKPu2Tefpy7XjnzAnj
         Q1edDn7rQUw/wI1PxEPyizKEudoBUEEwpLfn/HgrVox8FXOBN2KHvWrFA85iMuJ3GN78
         N4Kl3lmeFNwN5M0B6EYTpymG3XzMpgKzAJPWE0x51h19cubOGuYAbwVhz+b1bRzkRnW6
         u8zw==
X-Forwarded-Encrypted: i=1; AJvYcCUtRQVP9cPaUWGuZx/hy8NoU5vKs+F25KFR16hdT+4Ed7u2t92l/GFi0W3Jl27p/y2kYce3iIQWz0/PmTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY12ah1dX87cWU/QgYq0pH6m3jN961VAg4Q8/DnOjkw0USOTsV
	+O31s63Bxt3fvUsSiJYFXmStZvqHOEz/+XGLkh4cR+oHwGL81VS/w/0DeJWZYKNLFcBEkqOruiC
	WKCAQqxR7UXyCvs6mhxw0qTPf2keIj0huPE4dBqvFYdMqY+BliSYt1ntGcxRIy4AKJns=
X-Gm-Gg: ASbGnctlkUYwsKfOa6YmmVn+dBI0kOnSmv7EhIKgLYNaXtMDRbBzDy5x3g0tlZ+LRrd
	Y1njM6mR6ZAxGpE1AI0Sf+OyJLhHsrHBHUn1/BZSHgIGjzCmGJFVz2SZaIiBq+2V7OtkDycpu3z
	VBFltaUjah4G4WY9jp1Ip17mT+CYjExQMxX/Jdep/dNkKg75wZsYCwTXm3bqL8Ex6lz7VT2JQAC
	3NpQ1YD89aFwO53NG2P8kSTMO49mXu3t4/6x4IFW+VrwdhwdIx+DaEfvOQJbMHs3L98QP1WwfrY
	QfYuT1RcMUZ6CWjpgtfC0skvMzApjF39AC0ccF4V6+L+lTHuseldOTgZ11P7QOSWD4gZvf+0T9H
	k2I4=
X-Received: by 2002:a17:903:1ae8:b0:27d:69bd:cc65 with SMTP id d9443c01a7336-28e9a64897cmr46059355ad.45.1759509392652;
        Fri, 03 Oct 2025 09:36:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJKibX9WYsF7u8gjX03v+K3SueAafEPiiU1G1b/DGIlI/MZLepk+3L3tyJUhRRTfutSX8MKQ==
X-Received: by 2002:a17:903:1ae8:b0:27d:69bd:cc65 with SMTP id d9443c01a7336-28e9a64897cmr46058975ad.45.1759509392120;
        Fri, 03 Oct 2025 09:36:32 -0700 (PDT)
Received: from [192.168.1.3] ([223.230.61.38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b878bsm54868735ad.81.2025.10.03.09.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 09:36:31 -0700 (PDT)
Message-ID: <b1698759-ef46-43c2-9e86-4bfe3736f731@oss.qualcomm.com>
Date: Fri, 3 Oct 2025 22:06:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: lemans-evk: Add OTG support for primary
 USB controller
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <20251002172946.589061-1-krishna.kurapati@oss.qualcomm.com>
 <ee0adfa3-f042-4d2a-adf0-2c5d84d79cd8@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <ee0adfa3-f042-4d2a-adf0-2c5d84d79cd8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfX3BEeoBI/6/Jw
 KvGHlAvGIHgflI6pfmnHPeJWm7cSCvCoETdilGbbU9MYVS9VWSn6xOyYd7f1o16jgauf4qSyFR5
 6nJLniqqTRf9D5M6qQupa/5EF7gIjmiA52kxnL7BCidGNP1x6t96PxooHKdSSp2aoRFvHE14p2P
 I5ujb/lZRZe4ddoHa5TPElKt41aO3+MrLLFQFRAIRoVEYiwrreF4+jr1vgIQF6DSbddJyp7Akiq
 SEFmmMpDQwCvsb3id5o+rYVCd0asl6jyCbag/Zcqvs6xA/4lr7JJpUeLBbV3L/eG3IW8CP6PHWK
 +Oa3yWXU2fDlDpRO3PCqTYSxO3mo9LLiWpmr6MereggdVSb/cRMLv18x8eod/MCf3axZImhn6xS
 YNrSLajaVuUiJEQ0FEYLBImuwxGuug==
X-Proofpoint-GUID: AZJCWNv5mCagUP18q-Dr1VSauAKZwvUS
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68dffb91 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=QA6PZsKgKftjOHn1obVSzQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Hw8d4qyt-kRrifida1AA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: AZJCWNv5mCagUP18q-Dr1VSauAKZwvUS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029



On 10/3/2025 6:57 PM, Konrad Dybcio wrote:
> On 10/2/25 7:29 PM, Krishna Kurapati wrote:
>> Enable OTG support for primary USB controller on EVK Platform. Add
>> HD3SS3220 Type-C port controller present between Type-C port and SoC
>> that provides role switch notifications to controller.
>>
>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>> ---
>> Link to driver and binding changes:
>> https://lore.kernel.org/all/20251002172539.586538-1-krishna.kurapati@oss.qualcomm.com/
>>
>>   arch/arm64/boot/dts/qcom/lemans-evk.dts | 122 +++++++++++++++++++++++-
>>   1 file changed, 121 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
>> index c7dc9b8f4457..0b6d8d2d19d6 100644
>> --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
>> @@ -37,6 +37,32 @@ chosen {
>>   		stdout-path = "serial0:115200n8";
>>   	};
>>   
>> +	connector0 {
>> +		compatible = "usb-c-connector";
>> +		label = "USB0-Type-C";
> 
> Are there other, non-type-C ports labeled USB0 onboard?
> 

There is another Type-C port connected to secondary controller.
There is one Micro USB Port connected to tertiary controller.

>> +		data-role = "dual";
> 
> power-role = "xxx"
> 

ACK. Will add it.

> [...]
> 
>> +	vbus_supply_regulator_0: vbus-supply-regulator-0 {
> 
> the suffix suggests there are going to be more - is that the case?
> 

The second Typec port would have another connector added. So another 
vbus node would be added.

> [...]
> 
>>   &usb_0 {
>> -	dr_mode = "peripheral";
>> +	dr_mode = "otg";
> 
> otg is default, you can probably drop it
> 

ACK.

Regards,
Krishna,

