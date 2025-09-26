Return-Path: <linux-kernel+bounces-834108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 130DEBA3E39
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315FD1C01C80
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029B92F5482;
	Fri, 26 Sep 2025 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QLPBysvb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C879F272E67
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758893252; cv=none; b=dCApsGdHiW1816aUzRwbf3RaTQL9hHGR5nWev7zEgzUsNtCMLnArMnxqzSBUp/AXyvJBtrhJIncgeJm76/OipTvEK9MRVtuSYAmzgx54UmOIw+LhdXRNcGo5sHACmmhDnIXtCPzicA1jzjbQbKGrmehFQsCvrdxp7jCmSq3p0I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758893252; c=relaxed/simple;
	bh=MClL6ZOoCXuxx1RDtmqkqa6SczgkMum98AA3U884PbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WnneK/ZhSP/EoIxkZliWLwm6tnRXHo66jz3N4OBZTfVBtPOT8rMnYji8/X6sMxuUD2QgN6Tra9w1EzVRIrU3dgRCcivhWdgIdo2RD1Hi9FpdCti+GTTwJXQeuEry90nePG4tA/tgJrZnUHRhr5JBp8D7E2JkKg1h2lpoQR8Um0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QLPBysvb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QBAjgb019597
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t8/ksjeEymK8HBnfUn37iS94Fkf2ZpcygrXIiyllIqg=; b=QLPBysvbkIh6XVAG
	1e9ABxb/Z/SgKaLC/DtdqOZdp7TmINkuhqAGhKINOdLy8fIgUBtc6V64uLFweBop
	QsdZW/rJ7lUdVaFftl9VksxEzoGIX17yG+AUCI9ng4HkWn/rwl49oHdyw/L+NoA5
	4GHzrBy/uH3FERLDvCOSR9lhJsVgumHx1y3jaujTSKkhCNJyZiQWEKBau/WEIN7d
	oi13XKKbGnk203whalEDx19Vl1K7xzkI+t9U2gYjFKcLsHAU8NkANAoGl8tNXDVK
	pemVK2yayROUNRkcenAdAWpJpDBZJXhcXCOtQIuYXLcjvMcI26faNEzabJrDyY5w
	SSVklA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49dsqrgb9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:27:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8171dc0dd7aso49657085a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758893249; x=1759498049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8/ksjeEymK8HBnfUn37iS94Fkf2ZpcygrXIiyllIqg=;
        b=EQ80hVIn2L63jzs/MBH0KTZ2Ne5ZaiLD65Q4CXWPt9KRrWWIxkiP7gNGZEzaF34Xj6
         MVmi0cEAUDM5ybdS92CyLah4PfSkd5LKZRUz3d34T7LB6puTs8hY7b9BRDspFsJ0zoDC
         94ozt0Wv3uhDkFXYYuhx/TtL1/qRdW49pdh+p0PZpyxnh3OGO1zzfTvcq/2TbehgxRFk
         MjrrwmW0bGzuKIbXtQsp3WjA7OV/q3PoSrUBqLPz/jjE2UVbg/Cx8xHtJpZX2oILPp/2
         syZQsxvvtXrxrKDObHwL4bfU1Cn1pr1Vzr0RgDqm6YeySvjx5SRB46VZVO1xaqIzQ0kJ
         SKsw==
X-Forwarded-Encrypted: i=1; AJvYcCXggdLW7Yf5RBN+RvhGwXTOMX949c7eERMXm6lAhiiB/zJ2KfFZnEs33vSHi5O3tRJUz6aFoyv3Ah4Rh6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS6r/Z6ne6ytvPTx2CZgr+bY+A2yso6cMOtkqTF3nyDJUf7RB2
	S4YBOODbjJyvIokBD0S7sCDTOaFwuvE9HgnY6mz8oobFvz7aBJn6DUq5/uDVH1PqpbP4jU/6RXI
	fb6tgpnXDVEAwZGiLq2kBwc7elExxS27MJ4gIEPqhfdt86adVihUluBYAdO5X07ti6VU=
X-Gm-Gg: ASbGncttu8wEzRi0gI9vRGNUZQJ2H0g9uon78DL8+kG0438i4z3Jd/uar+HM//vMzN0
	nxoQ9j8wWo+SbX1LTdI0JtqUfvTs36yJ9zmewe0of0fx4dVHyFFzmtk21MyOCJLfAPukvTq7TxW
	C/rbJDwKI+zHat4OgimHul5z+bGqA0CYpDwjyhaOXHr8eAVX8gIbVlK46lPd0cPwOVuED3V+xxs
	WiVVjDGT+s5G3S8/ygAxaIGl8IA96S74GuJ73ptIgBVNbKhivHzSbPdE1OxaLyX8zgnCSB8yDBZ
	v6YSdbAnxzS+0Ca5/46QNUzskZn9qzo+x3tbmPI8vdkjWqtyG8BoA8KZuImn55iZ2zkNkQMwNtw
	38Z0Uj7xRDlv4Sd6/c9d1Mg==
X-Received: by 2002:a05:620a:568c:b0:85b:27dd:84cc with SMTP id af79cd13be357-85b27eccea2mr478562885a.5.1758893248614;
        Fri, 26 Sep 2025 06:27:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFz0ZOL7APzcqCaK7Mg+0jgxlw42jENUTuNml2I098P+orgcmCXHakc2Xh3/amKGZ80bY+MQ==
X-Received: by 2002:a05:620a:568c:b0:85b:27dd:84cc with SMTP id af79cd13be357-85b27eccea2mr478558785a.5.1758893247939;
        Fri, 26 Sep 2025 06:27:27 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5d1671sm374952666b.3.2025.09.26.06.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 06:27:27 -0700 (PDT)
Message-ID: <4d815ed8-18db-462b-80d9-9768b51a9788@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 15:27:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] arm64: dts: qcom: sm6350: add refgen regulator and
 use it for DSI
To: Luca Weiss <luca.weiss@fairphone.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20250921-refgen-v1-0-9d93e64133ea@oss.qualcomm.com>
 <20250921-refgen-v1-9-9d93e64133ea@oss.qualcomm.com>
 <DCZZV93PMWRZ.1J9IZBZYP5RGM@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DCZZV93PMWRZ.1J9IZBZYP5RGM@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2cIJ_L6nxZMO2s35ncdcIeEJrHqxX-mk
X-Authority-Analysis: v=2.4 cv=d8n4CBjE c=1 sm=1 tr=0 ts=68d694c2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=qxRITnKSTm-n5raOyfwA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 2cIJ_L6nxZMO2s35ncdcIeEJrHqxX-mk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDEwMyBTYWx0ZWRfX24Xfq5NMY6EW
 xlIfYsYKY2hS8QmCo7F/K4PT9nHbLz32X1VZf6T7LjKNY4wiMydAjTun4QpuJkp2/UBHilvNjJF
 qAioRy3Di63x6aDXzc4qzfSCgBeGZtIA15stl9vRqbebGoJK1ooTfMHHAND0uJcTE/3tGnQofYg
 8JL8PJ+eSbhIKOHrSyt/7MFfLrODhDxQUEe0U5TuprL77GVbZdOxC2MhJX9MEuL3nJRabz8xJT1
 58GI985WZa9ltOu9W6NW4yufufucfrGBmHhD/+tj8BMkmCq80IzakjPkiZRV6rMe2+HcvYOjB8f
 ZPbHvd9ncMgKYsWfzi2eEkaZZcaKLkH9TGICzL12+hcGNkNBnlia8bSIebwwpgd8w03MgL/XFvF
 REI3rGbRfyitjmVm2B6YUDeCS8H/gw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509260103

On 9/23/25 9:17 AM, Luca Weiss wrote:
> Hi Dmitry,
> 
> On Sun Sep 21, 2025 at 9:09 AM CEST, Dmitry Baryshkov wrote:
>> Add the refgen regulator block and use it for the DSI controller.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
>> index 8459b27cacc72a4827a2e289e669163ad6250059..dd009569a6683a25f13b068e3e0bd8746b2ac501 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
>> @@ -1768,6 +1768,12 @@ usb_1_hsphy: phy@88e3000 {
>>  			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
>>  		};
>>  
>> +		refgen: regulator@88e7000 {
>> +			compatible = "qcom,sm6350-refgen-regulator",
>> +				     "qcom,sm8250-refgen-regulator";
>> +			reg = <0x0 0x088e7000 0x0 0x84>;
> 
> Are you sure the size is 0x84? Downstream and hwio_bitra_V1.cmm would
> suggest size to be 0x60.
> 
> For sc7280, hwio_kodiak_E5.0.cmm does say 0x84 for refgen.

0x60

moreover, I see that there are two refgen regulators..

Konrad

