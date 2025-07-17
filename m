Return-Path: <linux-kernel+bounces-735934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE16B0957D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07CF717600C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEE22248B0;
	Thu, 17 Jul 2025 20:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yvs+WD0v"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9960D22370A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752783015; cv=none; b=RXQOwURY0/9jPlqMIRUNA7oeaQsCOMr0YHbkTsQSCH8UIrDmr+1+qQlQxBe36y2vWXmx1tfie+J8CDg3UocUKUn2JhmeoUyKuQzA+0hvN3vcYCdm9saApNrYPdyw1K0sLgmTriTE/+hGzSIrMpBPY3xpcdOKnbqBla25t+gqYtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752783015; c=relaxed/simple;
	bh=EKPy52oDvGVZSqhCAVKk47J2X7s3CsyNooGD7tK/m/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F24osoFsob8oYDVGoQH5aiA32wOmQFliXN8HpsISMB3fQq0x7SnAQEbNuzke3b6sjXW1jEzNcQx8KdOOnrpoAix540RMDURipYR4gRVigNuD7luG3MsDwPVjMt8p5xlk75nxc7le0ulijhU1UH13QSJ/ya/iP5x1tpzXXXK1oHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yvs+WD0v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HJjgqL000567
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cYmO1GfNb8ToOrGv1oJJtmJMYTy9sY9g5g+UCjbEQSU=; b=Yvs+WD0v1Vs9fhxP
	s7ASfobm5K0SuvMJSVGkgoYSVHCxiLbwnbtxNcg7zfXi0TS8fHRn/GDgRO+CZlUE
	mOaFAMkkY3nSor2LSpwysqq15d8SpeOSUQX9KFjijN0o6qe8dZdjefshrEFhJko2
	cYhumOKdSSdlneojGuYX4/c9lg++JgogmhXp9s4U9GnOPNftpnlkHw15RgFBWAbu
	tohdak3Ttze7/EtERgpE3AlbMA+xWLuRVw0ck906PA4Ueri55u5MDt8cSgqDLd37
	RifYOUr8S/GAIParP+ZSaMUMubdmxyRFP6A3X+6CsF5LfojaElqWUkVNXC4pIf40
	1SSRZQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5drv4a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:10:12 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fabbaa1937so4225806d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752783011; x=1753387811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cYmO1GfNb8ToOrGv1oJJtmJMYTy9sY9g5g+UCjbEQSU=;
        b=BX58g8oWMiFcwDK+y54dkwogaVQqi9TyqrH0gZ/lBQEBFUj/csGM1XexRIFQNbmzoY
         NI3xlSoKKtLlkxA4fP4G7FGGoHdFxk1RHKJuw2BgCLJHGkU/KIOfBCr7MqWTK0CsAkPO
         1dX4m0hhwCShw4sq1TXs18diineAzWpOS4Mnf/qS8T25wRrsmcDP3hvxJKAAbZ75p3jH
         bMgao5Wv4okCWj1OCbuIxSWRfVmTpeKc2380y/vm6jVvmv4FwsdC4WqPjrQDraTwiApm
         hndcNHcniBblkgY/HRdeBttVS8FRUL6i1e+0N/GMCW36XPjNP8duHnkEkwZvyZC/hhw7
         6sKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT/YX5BjF2fzVRQffhSw+LKp5St0ueGbb/TQvYuNovMJyZGNYOt65BPTaYlW/Edb0QkPPmSoPymDW/5hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKLYQj7Jr65JPdJPCwURdVIQVNZiaOpw+doD4udH+ONsV8C9g3
	9rvYaH1+e9f5Y923v3AWndM1BBoP3KaSWs8GAWaBPfmjhZ5VaCVOvc0nJgWjD0twkRLTeEA/mcu
	SVTsGsrlNJ20zcmA1mBkwS/fLdSZjCYFktmdAyyDHp/1MkIbvdgqFlDJeh5KsNVVt9uI=
X-Gm-Gg: ASbGncu/7h/DDZ5d3IklL/2ucxAE21QLmhXQMneilNlZCzPx1juXSa1250ptsDC1sHh
	DzrADFRxZZk8UFdHH8q0OVLO5TAjduUTOKxwke0wEAs9mk0BAz9i55TIMciU+TLijZZj8TKTb1A
	uT5IsC+4cWCo7HkGsUmBQxngu65ShyR9TXiLjmRMm5EDtJ8XtV0dcoP6BNXHLqqnZ/7OBrOwNyQ
	pCZ1PABlkrr5DrwxO+oZjoL26BZik4SYeu5EevijNp4w05xaVWc1ZvJp6AA0FMR6HyOXwdTKnlt
	n0PCidsxX2R7YgG/FnUrWoQXuuXeaF57c/DxySq3r7sutrfVbTLSdStV7sQznUSmxHPwqABwdHh
	sF1JBjO3SDcVbjzzvwVN0
X-Received: by 2002:a05:620a:172a:b0:7c0:b3cd:9be0 with SMTP id af79cd13be357-7e342b416b3mr491272685a.10.1752783011006;
        Thu, 17 Jul 2025 13:10:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOAfee9N81jpOmhQ5PZ3hk1t3eQcHZyJcOmJC48exwPfVSuJeo/nSdRV/0obqjOo192WJTNA==
X-Received: by 2002:a05:620a:172a:b0:7c0:b3cd:9be0 with SMTP id af79cd13be357-7e342b416b3mr491269985a.10.1752783010505;
        Thu, 17 Jul 2025 13:10:10 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7c09dfdsm1407562266b.0.2025.07.17.13.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 13:10:09 -0700 (PDT)
Message-ID: <3a381014-cfe4-4b3c-a3c7-df688c1e87cc@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 22:10:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: Add HAMOA-IOT-SOM platform
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Yijie Yang <yijie.yang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716-hamoa_initial-v1-0-f6f5d0f9a163@oss.qualcomm.com>
 <20250716-hamoa_initial-v1-3-f6f5d0f9a163@oss.qualcomm.com>
 <aHkhcUVBnrwadKfa@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aHkhcUVBnrwadKfa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tlFez2dIMI_dkzP8VgrxFJBnXy0qs_Ln
X-Authority-Analysis: v=2.4 cv=D4xHKuRj c=1 sm=1 tr=0 ts=687958a4 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=DGOirDVRF9kFrzJQLnUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: tlFez2dIMI_dkzP8VgrxFJBnXy0qs_Ln
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE3OCBTYWx0ZWRfXwTvIyHODTFHZ
 k4Hvg++mejQfDPPFrjq6NXLldnsO/I4NP2ZiTypY+WKu5tyVkIuSOBjTF/CqDVMZNn2bXRJ0Ve2
 GiOqrG5HP9taHmweoOyoFUdAh/hnWfHvyVyR3xoZHcTQpPfhQ1xpbe33Gz1yVq5vKeVxZ27/rlQ
 G/2/L+BwEf7qojHjbq8WwLlwHtPEA4Q8Nm0CwO4gfR0dtPGYc0E9RUkLPjiDvDfZPFg830p3keM
 1hhqvd6r0jubSo4vSryCMizJrsSeMzpeqCVXBKmxSv6yxtzZaBMIN0WkNwDRtpgICR9NPLRoTE/
 9FFFHHyK3VHNSmgMFd2/BiPlkUUNlWrNU3kqin62Ejh2ElnzW2RU4MdXUXmQ3dgu6WDfgzVzz6m
 S1thkGwnrEswx2uo1Am2HbHyaAuU15AxsN8NCrRCfsseiPv6u4c2C/sB07KhiQP3mszx/mxf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170178

On 7/17/25 6:14 PM, Stephan Gerhold wrote:
> On Wed, Jul 16, 2025 at 05:08:41PM +0800, Yijie Yang wrote:
>> The HAMOA-IOT-SOM is a compact computing module that integrates a System
>> on Chip (SoC) — specifically the x1e80100 — along with essential
>> components optimized for IoT applications. It is designed to be mounted on
>> carrier boards, enabling the development of complete embedded systems.
>>
>> This change enables and overlays the following components:
>> - Regulators on the SOM
>> - Reserved memory regions
>> - PCIe6a and its PHY
>> - PCIe4 and its PHY
>> - USB0 through USB6 and their PHYs
>> - ADSP, CDSP
>> - WLAN, Bluetooth (M.2 interface)

[...]

>> +&usb_mp_hsphy0 {
>> +	vdd-supply = <&vreg_l2e_0p8>;
>> +	vdda12-supply = <&vreg_l3e_1p2>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_mp_hsphy1 {
>> +	vdd-supply = <&vreg_l2e_0p8>;
>> +	vdda12-supply = <&vreg_l3e_1p2>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_mp_qmpphy0 {
>> +	vdda-phy-supply = <&vreg_l3e_1p2>;
>> +	vdda-pll-supply = <&vreg_l3c_0p8>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_mp_qmpphy1 {
>> +	vdda-phy-supply = <&vreg_l3e_1p2>;
>> +	vdda-pll-supply = <&vreg_l3c_0p8>;
>> +
>> +	status = "okay";
>> +};
>>
> 
> Assuming the USB ports are located on the carrier board and not the
> SoM(?):
> 
> Are carrier boards required to make use of all these USB
> ports/interfaces? In my experience it's not unusual that embedded
> carrier boards use only the functionality that they need. Maybe this
> should just set the common properties and enabling individual ports for
> PCIe and USB should be up to the carrier boards.

The PHYs are on the SoC and if the kernel is told they're "disabled",
they may possibly be left dangling from the bootloader

Konrad

