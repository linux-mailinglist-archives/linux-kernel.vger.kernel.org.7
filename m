Return-Path: <linux-kernel+bounces-736313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C325DB09B68
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C25E5A4D8D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E49A2063F3;
	Fri, 18 Jul 2025 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fY4oQ06L"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01FB2040AB
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820051; cv=none; b=pvtAvRRfU0XEjKuAGnPFG+H0wTbaF0tYMrheSeaFKGwVU03IuPQzSOeSEhJ96tJMtCtSOXvmKAn6JQOM+6xzvQkQFUz6PqhTMpKJinJ+0kJF0fV5kpRhew4wLG1kcNDTj/IEaFwfrRi/2COv69LnuEn2EJmZMATltQWCqLIgihk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820051; c=relaxed/simple;
	bh=9hL1zx1j23wNCk0a9VlmL2GLY+gI6oyOMSQlvRXuMUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5CB6d8cY9m47lAUyCjbw3BKjOi36tyJCk44v27SmxBtCP6/baphlAvaMhGTvE0TY1tHRWg36CcGO+/z0pUMCLUGp34kctGE65WiPF5efsvJ1W0KzxuMLawtJp2SEZXA+XlDAOcLaX4AKef8jgV4i9zPzKKq5uJEjTNIgb3rQsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fY4oQ06L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I64mCF022220
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CV2J5D+tUIXwCqu3D9939loQYQxkrGWg+4USJePO5A0=; b=fY4oQ06LbMgxX8Dl
	6RwWq/ilFfvZ5Z9rawF31X14tcq5PqLgoXFhqgGdM6lPks/5K0B6y+wPlxyHa7BI
	9WSOF9HM2jw/bCdj1DZRKDdwUFRepMdpeVdyf70xboCUwDmpKNl99YX0GOCSzcvR
	dBcMIjIZndyVLP0AbCDJ4Qkp2jbb6z+QOhmIH5aHjWx1PSPHaNxKDGEiNpHhrFV6
	Ed1CS/8y7vnSvQTy97Zl1nY8GXh5KGDZnW2MaWWf2mYd3TrxHf5EyXcxt7j29WUG
	nbZ/qRpaoA/0PZo3W8N/m+SjxgEvUTGLFjiXZaufBI9VK4joaJsMCcYl3k7y04rN
	/6OgHA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsyacmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:27:28 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-75494e5417bso1716602b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752820048; x=1753424848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CV2J5D+tUIXwCqu3D9939loQYQxkrGWg+4USJePO5A0=;
        b=FccqqsKhUGFNe3IwM0zEzu8c6n63+8FkDvUFSZ6NSywkpA/3XsxMrCen5LLPeYhwSJ
         Q54UWZQO93M+9h1YIYXZiL4oeSPBPvp5Q/l8NqyFQnBNnD26OcBQu+BUE0rp7a21KO26
         /l0weKPfGNEQhZD22E/mUGrg+Jz2C3ZKM+HYwwrWpABnOfcweX8NuJUJnTblDhJx8Usl
         /NLSPCLaCqbMo16j1o2WH2H2fwbuYTOsNkhyQCmjIuPXHJ1v8vbcIE2dY3WYw1q0geWW
         zwgjbee7zdI/Jvnd+YI4aCT60XiIxQhr0C6gwDx4MIkj/vgrqI7B4mjAPHLRJZp/j193
         TJqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzl68r2UU3sXEyv5aR4hanf+z7ThniEMTmNVqLlYYNVk8Yz7drYCQAs+6ok/2q0iba6TQMUto/2EjS0bU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEFN8ipOpYPvgGRWjQ9llOOd2UDNou74LDL2d+NR3Qh2DbNxA4
	00m0Z/9NznaGotiAz5nqUCizuQvbfNa5Fj9aXBHwdC6i3iVbr54bcyH39JY7wE2gTR/ZL2Vky1F
	Vjb4GoRfPh9RXvOUQAEsZUZwu4XfQtlF3bJAfaexRjAG7daapfjwWBZgjWyJSMVKtWeE=
X-Gm-Gg: ASbGncstRsF2JVw/5UZnJjHkbdFZy0aJ//TjjLj/HgrZNOiYYLf3vT9SnuZeoo+WJ9/
	x1RodPf0xVH4c8sBco3d/ZyQY9FfcIXtl4QC+QPlRUshlbGuY4Shupuj0wAwG7DJu3qtCmKTMRY
	ac4CxNheS1Lo4Zt9wV92rHVssz7gjpFLjUN1YHf2wT8whaU2+WygXnJDVNlIZAegaVqr+eWM33H
	gvOLdcEdlt4S7AaHVsex6rZefja6yqHdO4zUNSL6mfL+XY3xDQclobwFkRlZWEoJ0ir9KSw0huH
	yPWw3FPiZhC5qS5+cXUvqWfxL3rrw7DU4ujXszo/M6qGwhEsjmKjagoIUq3dpPefA1lSb3At/PH
	26umYOXLqiA/4/6voX6h6uqn7W+M=
X-Received: by 2002:a05:6a00:1796:b0:742:ae7e:7da1 with SMTP id d2e1a72fcca58-758340a524emr8183143b3a.0.1752820047803;
        Thu, 17 Jul 2025 23:27:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUwgXwhUXpxMdcXwlrwuKBFaoUaEn7qEtN9ajCneEEO/1eNfCr3plTn2HBVr7/ZGUhkm1GTg==
X-Received: by 2002:a05:6a00:1796:b0:742:ae7e:7da1 with SMTP id d2e1a72fcca58-758340a524emr8183097b3a.0.1752820047187;
        Thu, 17 Jul 2025 23:27:27 -0700 (PDT)
Received: from [10.133.33.15] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e2727sm561340b3a.33.2025.07.17.23.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 23:27:26 -0700 (PDT)
Message-ID: <e68fb386-854b-4ac1-88c6-b5148289878e@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 14:27:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: Add HAMOA-IOT-SOM platform
To: Stephan Gerhold <stephan.gerhold@linaro.org>
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
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <aHkhcUVBnrwadKfa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA0OSBTYWx0ZWRfX5U8UQnZUCy59
 g7ibXDqNwE9GkX++iqkwzskfxsSYlvGyT5EHOyUJSY5+geyHlKyBXQED/4gg5tFZ02JQ5ZKYjU8
 dE3V+L39BVJ1yhrsQFkn8bQRbYcYXcO32EynV4cVxWfrfVpAPYr/JW51Ss8upicEPCJlQa1NQ9B
 gEABj84NtffBewdCAQe8tiOrTHMzsxLN57qfsvFvXWlR3ECEvt3JKJ7dOmaNXeLNgJuCA56GlYi
 QVfKv5wNXCOpCI34f40UHgATaP9vPG7xCK+VYD3Uz9QdPi5e8HRTS6obJUVUxhnaIOUzf98NpgJ
 1CyS+idta58QEgPMo8j3FCYsYUGYyvnsunleCMwkDSEo/ht9ewa3sC63uJGrQHskRfowyeISsL8
 bitzI65vYH60bclddF+e0u7W7SiKQtWAfyezBvrktWIR4nM2zrFTxxy6BwchfzF0Ftw68kK+
X-Proofpoint-GUID: JgQzrEDb_nnOwpKKo0O6TtvMO78mzZhW
X-Proofpoint-ORIG-GUID: JgQzrEDb_nnOwpKKo0O6TtvMO78mzZhW
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=6879e950 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=FHlHFmSbb6gL1abVproA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180049



On 2025-07-18 00:14, Stephan Gerhold wrote:
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
> 
> There is no WLAN in here, it's part of PATCH 4/4 as far as I can tell.
> Move it to changelog of PATCH 4/4?

There is no WLAN node defined in either the DTS or DTSI files, as its 
power is managed by UEFI. Once PCIe4 was enabled, WLAN was enabled as 
well. So I think it’s better to leave it here, right?

> 
>>
>> Written with contributions from Yingying Tang (added PCIe4 and its PHY to
>> enable WLAN).
>>
>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 607 ++++++++++++++++++++++++++++
>>   1 file changed, 607 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..dad24a6a49ad370aee48a9fd8f4a46f64c2b6348
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
>> @@ -0,0 +1,607 @@
>> [...]
>> +&remoteproc_adsp {
>> +	firmware-name = "qcom/hamoa-iot/adsp.mbn",
>> +			"qcom/hamoa-iot/adsp_dtb.mbn";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&remoteproc_cdsp {
>> +	firmware-name = "qcom/hamoa-iot/cdsp.mbn",
>> +			"qcom/hamoa-iot/cdsp_dtb.mbn";
> 
> You say this SoM can be used to build "complete embedded systems", are
> you sure they will all use the same firwmare signatures?
> 
> If not, this should be in the device-specific DT (i.e. the carrier board
> in your case).

You’re right. I just double-checked, and each board has its own specific 
firmware. I’ll remove it from the carrier board and update the path 
accordingly.

> 
>> [...]
>> +&usb_1_ss0 {
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_ss0_dwc3 {
>> +	dr_mode = "otg";
>> +	usb-role-switch;
>> +};
>> +
>> +&usb_1_ss0_hsphy {
>> +	vdd-supply = <&vreg_l3j_0p8>;
>> +	vdda12-supply = <&vreg_l2j_1p2>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_ss0_qmpphy {
>> +	vdda-phy-supply = <&vreg_l2j_1p2>;
>> +	vdda-pll-supply = <&vreg_l1j_0p8>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_ss1 {
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_ss1_dwc3 {
>> +	dr_mode = "otg";
>> +	usb-role-switch;
>> +};
>> +
>> +&usb_1_ss1_hsphy {
>> +	vdd-supply = <&vreg_l3j_0p8>;
>> +	vdda12-supply = <&vreg_l2j_1p2>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_ss1_qmpphy {
>> +	vdda-phy-supply = <&vreg_l2j_1p2>;
>> +	vdda-pll-supply = <&vreg_l2d_0p9>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_ss2 {
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_ss2_dwc3 {
>> +	dr_mode = "otg";
>> +	usb-role-switch;
>> +};
>> +
>> +&usb_1_ss2_hsphy {
>> +	vdd-supply = <&vreg_l3j_0p8>;
>> +	vdda12-supply = <&vreg_l2j_1p2>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_ss2_qmpphy {
>> +	vdda-phy-supply = <&vreg_l2j_1p2>;
>> +	vdda-pll-supply = <&vreg_l2d_0p9>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_2 {
>> +	status = "okay";
>> +};
>> +
>> +&usb_2_dwc3 {
>> +	dr_mode = "host";
>> +};
>> +
>> +&usb_2_hsphy {
>> +	vdd-supply = <&vreg_l2e_0p8>;
>> +	vdda12-supply = <&vreg_l3e_1p2>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_mp {
>> +	status = "okay";
>> +};
>> +
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
> 
> Thanks,
> Stephan

-- 
Best Regards,
Yijie


