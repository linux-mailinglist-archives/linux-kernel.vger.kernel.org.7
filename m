Return-Path: <linux-kernel+bounces-745469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE30B11A69
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0571CC5822
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC68253B5C;
	Fri, 25 Jul 2025 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D1l8Qljp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35FC253358
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753434072; cv=none; b=HrrndsRVKiIIEATCtf0+0wz1QucX6yhChAkoOHPbaZPuZhKJFMVBoXGOyeVWzsgq/LYsdwNLvv1iuT+K4Y3Fnfzks8VXNb4UtqbbsFq1YC4aZ7Tt84w2kMd5SpQpjbkcRmuAMY8sAwif081mkxwrT+IlPt4jpMLut428HamGVt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753434072; c=relaxed/simple;
	bh=eHBVrcv60amFq3ruB8uTKQNWHu+oGg7Vj8gM9d/IemM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R11yXcb0uySpqeRMB7KpXsC2V4vFHsHkJCWNtPX7HcJNcjgE9tKyXkr2JhH8hJauYJjdI5jo+UCzaU1vmDOlAku/XpM3Jj7B62b/f5pSicmsPND6aGXQ8vE07iPaQCiTDGHc0HA6Mp+5yErBLwykmXtxlu2Ckq43tUTlcIkwmlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D1l8Qljp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLn4YZ025897
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kCHehafS9SInAWecplAWILdgUxDGSl+sM8DQpqxSmEQ=; b=D1l8QljpjdxzqSsH
	U9U0gukpncxus63HVU5vHZavqRfw1JK6TTg2GPolMbrRWr113UkyufM9Gl0W0SyO
	Zm/GVDk6Wwh7olQSIwJt/cdfD9dW79cxBVT9fiQnVCSJqJiY5oNS/BoyHqAG5LP/
	Wy/buMB1OiV67CNIMcBti7LCIuZ2m+CudByuXFm0el01OLzVPjsyB/2Th2hkcfoi
	ms6I0KqRbXfmMqOLpslTaj/PVjs1sG9mK6uYGzEhq93wozEF419jRHhNjf3JXKP0
	tha14Y0yf9UgWD8Fk3cfSS0wH1LCdcYuTkaldxHgtX+UjG7V0JAyN0z/DLWsdbm1
	rjS7RA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w30sf97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:01:09 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74b29ee4f8bso1842405b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753434068; x=1754038868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kCHehafS9SInAWecplAWILdgUxDGSl+sM8DQpqxSmEQ=;
        b=bR2/tebUSja7e26U3+iQ02jeONyND2RO5pa4pIipBwDfLkRAkRsLhqmAQCSnHcJnBg
         CzFltJX76AnuVxgJmCymPjLPFxbBouGxkYB9puLFlPQntqoOIdcREEvfAY7VjGqueiND
         DXxulm73hQ0gePczg7IxlP86/wCj7/XfBTHmkAmYK+JsCesSjCSYEEq8ir1S6yn2ltc7
         uTE0DuSAXZjPO7bGhmpPiaRgqm7PaMXwK2/pZtuJnU5Uc+kUXw0K8rFZ3VAy3i2AHDBm
         +Vb2Dvh0OSM5/sFDV3O0Ch5+ccUED6QUTqkJ3Y+I5vjFbQK0BmILUPySug/Ju9MTq6tW
         VSyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUngyncJr2GlbSj1Fzses5NobPgMGnoqri6ArsH0tE8hmI7XMT4XtN+6MrJJ2mEshWMzuAD1BZ4gYXk7N0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKBnjr6dS5JlUEV20V1TPr7I+fS9rC2QtInkDtyAvl0mDSMyvX
	10vbTl5Hp+R19DUCWh05oljyv5YY0YT6gOGyqi8IazwxbHOlLMTYFEQsGigbUl4fqQ0FwZ6cefh
	Ed7HqXG8sS4bgG/mZnKGDqXyqM/D9G2aBSC/qKE2SOx/BcNZKtfPtFbOuOpknfrTUEbQ=
X-Gm-Gg: ASbGncuB8GsH7BOPjBeeODUwAnMx9fEykV3fYVslVi7DpOPFFqgdGDoze9zh0MtDBb/
	iwUmdM5h2et2vzoinryk+IPdWJCZQroCASR4RGJ08i8tQdZ4fHkCKIJkgXfRqbXnQoNncgbb6cD
	T/5hwnE+dg25nhLJRpMkziGjKLcI4ldSX7Fv5I+Id1oxgJRmUftHKSaOmvVWQa/R1OygKu6fwEO
	YUE/6rA+o3khb70909OPRyWfeoXklQbmikR5j8WuVgmRfCpz1NT2x3hodJ8N4InDYUj/xJIh7AD
	13d2HJAZb1jtYbpCypP2oCo58YNt54KjItSqueEUfdotCjepxMA6AA3xe7d7REGK7vjIB1TiHuO
	S5ZX87Z4ggnd2sWUFZuu9C9ARIME=
X-Received: by 2002:a05:6a00:3c8e:b0:740:afda:a742 with SMTP id d2e1a72fcca58-763312e3376mr1899665b3a.0.1753434068278;
        Fri, 25 Jul 2025 02:01:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxSG1ckDqeSKw0txrjXjcpLKjYBali81JfWT/ss5/ZGXRkuSSCKWeakEwYGytl4nEu3b0qcg==
X-Received: by 2002:a05:6a00:3c8e:b0:740:afda:a742 with SMTP id d2e1a72fcca58-763312e3376mr1899618b3a.0.1753434067723;
        Fri, 25 Jul 2025 02:01:07 -0700 (PDT)
Received: from [10.133.33.89] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761adc70799sm3417240b3a.12.2025.07.25.02.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 02:01:07 -0700 (PDT)
Message-ID: <cf84a8ef-9f4e-4f13-b41e-9525e21a913b@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 17:01:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250724-hamoa_initial-v2-0-91b00c882d11@oss.qualcomm.com>
 <20250724-hamoa_initial-v2-4-91b00c882d11@oss.qualcomm.com>
 <d55f79ed-0bec-4045-8bc6-9005d19f865d@kernel.org>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <d55f79ed-0bec-4045-8bc6-9005d19f865d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WtArMcfv c=1 sm=1 tr=0 ts=688347d5 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=r3APlHBmsgh8zSLRT1wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 0Kye_57WZVgwr1cMpNTlzHYvXJAqMH0k
X-Proofpoint-ORIG-GUID: 0Kye_57WZVgwr1cMpNTlzHYvXJAqMH0k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA3NiBTYWx0ZWRfXz5oiOnvfdhbR
 Dy5/de5g6Qt/fZiiTZIv6oAs8H47Ov+xDnbhH+6N5yX68fhTJ9DoY6y1P1b6MzjEk/bAcsoZf/G
 +nCok44U468SEWllK7WXfLL65V8f0+caJxBwgx74jGHSwP+kSRhyjqvosfRnozxBtJBidWMQIHc
 XbTevP1cAuEm/ptZY67SbPE2FidE5BhX9RoT3d5Sujr2FpCtIyv646QRLXpT46hNXRl8iq651vA
 GUVt5rg0RsrguBchsXtFoEwiZrhXqk1HzhMjqV7zmOGA2ETaxLF96z2n77rohIBQmxgd2Ls6KUv
 r399wrny2ZLcu5AqsghYl9wL/2F6SAyyh180I/KqDVTf0BIwoPLInHhoszC14Cro6f5Da5X25+i
 MzPr34OYhlk1kXe3cqS1fskv7/zthslWcArd8ZAsLZPg0ixG68idQel5UwKiYQ+sp/s9x3t1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 malwarescore=0
 spamscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250076



On 2025-07-25 14:51, Krzysztof Kozlowski wrote:
> On 24/07/2025 10:15, Yijie Yang wrote:
>> The HAMOA-IOT-EVK is an evaluation platform for IoT products, composed of
>> the Hamoa IoT SoM and a carrier board. Together, they form a complete
>> embedded system capable of booting to UART.
>>
>> This change enables and overlays the following peripherals on the carrier
>> board:
>> - UART
>> - On-board regulators
>> - USB Type-C mux
>> - Pinctrl
>> - Embedded USB (EUSB) repeaters
>> - NVMe
>> - pmic-glink
>> - USB DisplayPorts
>>
>> Written with contributions from Shuai Zhang (added Bluetooth) and Yongxing
>> Mou (added USB DisplayPorts).
>>
>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>> ---
> 
> This still wasn't tested. Use the automated tools instead of community
> reviewers... Your internal guideline documents how to do it.

Thanks for pointing that out. I’ll update the node name from 
wcn_usb_sw_n_state to wcn-usb-sw-n-state to align with the schema 
pattern and eliminate unevaluated property warnings.

Regarding the regulator properties for wcn7850-pmu, as discussed in the 
previous version, the required supplies are already configured via UEFI. 
Therefore, redefining them in the device tree would be redundant. To 
satisfy schema validation without introducing unnecessary definitions, I 
plan to use a dummy regulator as a placeholder.

Here’s the pseudocode I intend to use:

dummy_reg: regulator-dummy {
     compatible = "regulator-dummy";
};

wcn7850_pmu: wcn7850-pmu@xxxx {
     compatible = "qcom,wcn7850-pmu";
     reg = <0x...>;
     vdd-supply = <&dummy_reg>;
     vddaon-supply = <&dummy_reg>;
     vdddig-supply = <&dummy_reg>;
     vddrfa1p2-supply = <&dummy_reg>;
     vddrfa1p8-supply = <&dummy_reg>;
};
This approach ensures the DTB passes schema checks while keeping the 
implementation clean and consistent with the actual platform setup. Do 
you think this is appropriate?

> 
> Best regards,
> Krzysztof

-- 
Best Regards,
Yijie


