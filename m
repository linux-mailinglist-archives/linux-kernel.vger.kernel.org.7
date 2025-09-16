Return-Path: <linux-kernel+bounces-818643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51135B59489
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BD197AE8C6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E8F2C15BB;
	Tue, 16 Sep 2025 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a59Hb0H1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52EA2C237F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020418; cv=none; b=unXAffpLJujl2R53i3jq1LIZWIC/gcsJrhpOLKQwyLJBnGc0YicJPhJt6jdHNoSra9+aXIV0jOaU9XrCt6oBAVcMr9EeWw+yWJvwAelDClVu2odf3jp8kPHfPDSB0I+RSWaa02pU6EqInVutpgypC7nt/sRhS7XzMEFb0gF2xW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020418; c=relaxed/simple;
	bh=lSiaAwQtmu8l3KrCfNgexYAeTwY8RKqZxR3XprYn4lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4HaTDqR9TlujbarFMci3DH8X7eOslIF0LQ1+J72ZJsHokj7w8EBMbSeuc+tdl4TxTEu03ZfEHCNuqBSjGI19Z8B2zrHHSnPZkSeDfqOe1qsASQaWZkgRDmiRQyvrO0DAoLf1HLljr0A6Yxm/gB4PNIW+yLbi4NKWNKuBik4lo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a59Hb0H1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA16A7019996
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V3Bwbj3qyGvIGNCNZf70GMV21ynU087f+ba7OBsqQnQ=; b=a59Hb0H1co0lARzZ
	iuZu0QYAoh9HLmrBnxToZMG3Dhwf105HrnqhoR+EBBBRYXRkYwkDLGIx7Du3Bx7P
	tEo8qrZmUVWZex6G1y3Uudu7xOiZG0mk8B6hrp5Ms6SVokXAfSdcgsXV4joAX5ju
	mR/8oIZ7U3DQRPQW1PaaNK0Ub6DmuyBbCRi/mNUSAQroyFHwMiBvbYnHA0MkEWEk
	7dtstpC8Wjexnwr03IWqlAx8x1ERzG4ZLR8MIcTRZwv7Q0tIRlFGRi44FDPf+SR5
	pBfGLaqJJCG3Y7w7plq4saiUt0ht1wz5fXYj8TYJLO88KPIVVxNuP1c94297O1g5
	0mYU2A==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496h1sm3va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:00:15 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-726ac3f253dso14711756d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758020415; x=1758625215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3Bwbj3qyGvIGNCNZf70GMV21ynU087f+ba7OBsqQnQ=;
        b=CTE26a70WM1yT78q/tWqDMLYn0+empmTy9eocfWKuWN1D9v4cxPn39kNeM3Bk4bCmr
         7WP4LPd7+lyZOPg6hiODAvZyh+0PQFw22nTJI0lDupx/TT1TcU3Rmb5P27CHSBmk7oha
         zjz3XUfpYhnOURAxgrHi4C2bv6+7pb5ExEtv73v/l7m1NwG61H5MXp9F/Bvwtiv+m2s+
         eZIljvnrSmyWuSt9DDq89t+TzcWSgQVbIi3C7ssYd8dvWQZdliqDORUjWrP5eqtw0zXr
         DFSkU/2/6RYOJfsJAAAZzz23XuVVymb1Yt36Hv3GDeZN3+yEWo7LQ80dpl9FJ3ca23mV
         Lf+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCaa2VbkvqRN4G4GYgvUTe4xe1PPqL11kRmXUQSIWrLPlPV7Ae+hZdMQZjzAj2FaAMIsfZUMtNvw7Eo4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVn7Kw0RoVf53iwSaZ2I6uDce6wU8sgfQwpX0Db7ndF/x65WOp
	HzEeb7IkoDnpSn+x4hhK1LS8UiGpzovndU2N5rnjK4eP2s0Qyfk7tjwmNglpLJOw3Ojt/Rqn0k3
	kiqdSjiOIPtxxmdgeLEraj1dw6GIUry7ez35Qz0dCKLMRFkhjkDhY0DWU+ePxsVw2ASA=
X-Gm-Gg: ASbGnctsDoohRJaNshAJcAjfjui5xVpcnycDEMtVDFh3hh5pKgR3f6M6A+Dx0Xt7ZX2
	CKkCaAu+g74hop5Nok2I4L1qkN6CRa+kQWntHc3mXI2la/XfifvBscGZo95oXn0Yo6ve+1FKl3w
	5n8vKuwct5hTF5IouVnuTTGQgSXg5iAymSPISeDIh0WcKg+jtWh83MYqoBKSUcwm1M2Tztx3hoP
	mU+4JWmW2F788impAclDVYbvQ0vW9YGKIlMe8jSXquZup1QbhO36CMknrQKtfKXYeLhSDh8LZWS
	4U5dpWKpiBmSlXEoiNV7s3KIUq1oDxA4Y1YeT1L1/HqEF/Aka6WLC6udlyTRAsWbJs4eACt3Vo2
	KomcIGpUUbAAfA0FobCKubw==
X-Received: by 2002:a05:622a:834d:b0:4b7:7dbf:9a8a with SMTP id d75a77b69052e-4b77dbf9f29mr110865171cf.6.1758020414677;
        Tue, 16 Sep 2025 04:00:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKU9cobyOEfY+YQm5wRso/r5A+Y7Q8gplBHC/ZGUi55Jhqj/RSggEBomsnCmJzcZ8GLys+ig==
X-Received: by 2002:a05:622a:834d:b0:4b7:7dbf:9a8a with SMTP id d75a77b69052e-4b77dbf9f29mr110864251cf.6.1758020413354;
        Tue, 16 Sep 2025 04:00:13 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f638e576bsm1218127a12.23.2025.09.16.04.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 04:00:12 -0700 (PDT)
Message-ID: <03fe6810-fd37-4883-8fd3-f4919dec1b8d@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 13:00:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/4] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
To: Yingying Tang <quic_yintang@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yingying Tang <yingying.tang@oss.qualcomm.com>,
        Shuai Zhang <shuaz@qti.qualcomm.com>, zhichen@qti.qualcomm.com
References: <20250910-hamoa_initial-v11-0-38ed7f2015f7@oss.qualcomm.com>
 <20250910-hamoa_initial-v11-4-38ed7f2015f7@oss.qualcomm.com>
 <aMPhEm8PuhEofHP7@linaro.org>
 <317ffa87-060c-4f1b-a6bf-61bb27367477@quicinc.com>
 <jimz3qnjrcvemvgrqpwxq4zmywfo6psplsg4jefkvvpiwlffek@fwn3juynr4zx>
 <b3bf54a2-f33b-44d5-a9e4-65ba18ea267d@quicinc.com>
 <ee2d0d92-bff9-4593-a912-7e4b1d66913b@oss.qualcomm.com>
 <17d1e632-31c9-48b2-bf0f-5b57234de113@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <17d1e632-31c9-48b2-bf0f-5b57234de113@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1FXxxdA3uILBS73_6Jvp6oNO5eB5sEzK
X-Authority-Analysis: v=2.4 cv=A/1sP7WG c=1 sm=1 tr=0 ts=68c9433f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=Ojoud9tNSuJXTGgBNUoA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 1FXxxdA3uILBS73_6Jvp6oNO5eB5sEzK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA5OCBTYWx0ZWRfX57LbgYGjiyyi
 vPYkR4nlD7Qx9HHRZ1WKUFwa95Po0PwfyQrs/dkQvYrC4YXIrLot+VztGhJ4qRBcthlAwl29CJs
 qA5ttB/astCQKwT9+keXTgNrb1Urye6J6Jz6hLpqsJQZp1EoSNb5ggYws78XdY/CJZuBQL5bp9a
 xeCiz7iJeM44y6baQVNmuC6l5ClD1sqrNMnoBvTSlmVCZ183u9yeYMq9dGwQtqi74e3NrfWvDcw
 ZDaxh6tZ3NF4ciKfFh2p41KxP0+9e4WKZnTisrkuv/VfUsBoY0Mi8p28+4/SaMdOT5/EXxZsuvr
 3zPAZM3wjp9oHOIr1ut+HPmxYvfzRQCfWyckqplgX7Xs5esaJISh9Z7nTDjDyNyDYPLeQnx/mwo
 fjxLqif1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150098

On 9/16/25 12:39 PM, Yingying Tang wrote:
> 
> 
> On 9/16/2025 6:36 PM, Konrad Dybcio wrote:
>> On 9/16/25 12:29 PM, Yingying Tang wrote:
>>>
>>>
>>> On 9/16/2025 6:14 PM, Dmitry Baryshkov wrote:
>>>> On Tue, Sep 16, 2025 at 09:42:26AM +0800, Yingying Tang wrote:
>>>>>
>>>>>
>>>>> On 9/12/2025 5:00 PM, Stephan Gerhold wrote:
>>>>>> On Wed, Sep 10, 2025 at 05:02:12PM +0800, Yijie Yang wrote:
>>>>>>> The HAMOA-IOT-EVK is an evaluation platform for IoT products, composed of
>>>>>>> the Hamoa IoT SoM and a carrier board. Together, they form a complete
>>>>>>> embedded system capable of booting to UART.
>>>>>>>
>>>>>>> Make the following peripherals on the carrier board enabled:
>>>>>>> - UART
>>>>>>> - On-board regulators
>>>>>>> - USB Type-C mux
>>>>>>> - Pinctrl
>>>>>>> - Embedded USB (EUSB) repeaters
>>>>>>> - NVMe
>>>>>>> - pmic-glink
>>>>>>> - USB DisplayPorts
>>>>>>> - Bluetooth
>>>>>>> - WLAN
>>>>>>> - Audio
>>>>>>>
>>>>>>> Written in collaboration with Quill Qi (Audio) <le.qi@oss.qualcomm.com>,
>>>>>>> Jie Zhang (Graphics) <quic_jiezh@quicinc.com>, Shuai Zhang (Bluetooth)
>>>>>>> <quic_shuaz@quicinc.com>, Yingying Tang (WLAN) <quic_yintang@quicinc.com>,
>>>>>>> and Yongxing Mou (USB DisplayPorts) <quic_yongmou@quicinc.com>.
>>>>>>
>>>>>> This looks like you should have Co-developed-by: tags together with
>>>>>> their Signed-off-by: tags.
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>>>>>>> ---
>>>>>>>  arch/arm64/boot/dts/qcom/Makefile          |    1 +
>>>>>>>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 1221 ++++++++++++++++++++++++++++
>>>>>>>  2 files changed, 1222 insertions(+)
>>>>>>>
>>>>>>> +
>>>>>>> +	vreg_wcn_3p3: regulator-wcn-3p3 {
>>>>>>> +		compatible = "regulator-fixed";
>>>>>>> +
>>>>>>> +		regulator-name = "VREG_WCN_3P3";
>>>>>>> +		regulator-min-microvolt = <3300000>;
>>>>>>> +		regulator-max-microvolt = <3300000>;
>>>>>>> +
>>>>>>> +		gpio = <&tlmm 214 GPIO_ACTIVE_HIGH>;
>>>>>>> +		enable-active-high;
>>>>>>> +
>>>>>>> +		pinctrl-0 = <&wcn_sw_en>;
>>>>>>> +		pinctrl-names = "default";
>>>>>>> +
>>>>>>
>>>>>> regulator-boot-on?
>>>>>
>>>>> It shoulde be regulator-always-on
>>>>
>>>> Why it's not boot-on and always-on?
>>>>
>>> As I described before, connectivity power is voted by UEFI in boot phase.So PCIe link between connetivity card and RC4 is established once RC4 is on.
>>> If we set this node as "regulator-boot-on", connectivity power will be down first then up. That cause PCIe link down and the link can't be trained again unless you reboot board.
>>> So we can't set it to "regulator-boot-on"
>>
>> Surely gpio-regulator.c implements .get_voltage which reads the pin
>> state though? Did you test this, or are you theorycrafting?
>>
> Yes we tested this case many times, "regulator-boot-on" causes PCIe link down. No any issue with "regulator-always-on"

We didn't ask you to remove 'always-on'. That makes sense because
it avoids an extra call to (re-)assert the GPIO if both are
specified

Konrad

