Return-Path: <linux-kernel+bounces-818605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD41B593E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C837E3A4072
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEA5237707;
	Tue, 16 Sep 2025 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LQhnWGUc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6783928AAEE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018969; cv=none; b=Ul3WRRewRAfSKj39IVYqf/DyjnD3RWQYoY16piFdlfFtEESTVyISVU8NdTB1tldT4ZQ6QBh2USAPYU8DqpMk0GysNIINMFViaBudxoFn6xuzqGofKkDcv8Nad2ok8sTr7bBaPJI1w187KoRiwUT1SQd4sNQsR3hrWBIFwYlyrhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018969; c=relaxed/simple;
	bh=Qz30nJSo3zoddLNFeFML3WJ7DaicVwANWR/rFS4kCnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1TqOWkpjrmqJolRDxZd/YfqE5fBFIfIE2058SuoGe9lqz/BJ8q4Qw1tOC06JYbJ2su6+w5suVsHnryjlhfKtlo34d6Jyf3qdlWUGe8R9olUuck2PwNJLBbWgmn+zIPydTnc+iemzem/BYu0W2E52x6iRsIsw9Z9eCTh+eApq+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LQhnWGUc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAGQdC012287
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I1oGxXNARfYkquajFMgBv86g7mkjud9gt3fZRcuQCEM=; b=LQhnWGUc7YZjveKJ
	lF+jfrzT3KP6KJ4EclPgeGbGUuMO9hbZpVcdhf5aVr7NeQrSfWr131T6Di58H8sB
	eEklXGWVkMOP5vyWdH210Dm5ozCglSB+jnALjAhElE9jSLTSB23K1WkhYSn4XiIT
	/q7wKRG4Lx9T6GkdefXhhS5i1JuGAxQ7A7kQvAiQzvYOb4JvVyQgQpDlQKriNLD1
	GTM6n3Y7/gW7WHNF6m+kAW1PZDxMg3CRTIdJdMiAZxQT+WUOTyCzeXa68qA2TBKl
	mBOTOfl9TqrOUBbH2TMe8Fa3xyjlbux9oQfx0V1YxpstpaFg7+sox7Nv/RVgeqQF
	6VQSdw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496g12m6fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:36:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-80d884c99e2so69513785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758018966; x=1758623766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1oGxXNARfYkquajFMgBv86g7mkjud9gt3fZRcuQCEM=;
        b=hniExs36sVD/xrpr6iznXJ1Zff4DP0hg/9MlEjIja6G9QPdtrqqiuyaMSyba/vibXl
         vVzE2ODP3mBhozVtoX3hjUqsGu9IfaQ5KdMkWr8qvQfoEja3rrgJUX6TcpwowAj5UT00
         llPztMbchxcH9NOClO3QpWJBoIIQ+SMpleTsN9snpQhWHKuM7J13RzfVFlBngPhPs0XV
         OT5o8CZrgdVL5/we4jWerF1u8O2ssw+h59St/xBl9Gz/9O8LkcEnX+Wk/3kJ9JPz1UgD
         LEk1VWBEQZn1pUEMKxt9F56MxyhjQb6hWTTkDsDPoTqslmo9xkK1BClS2brP8HWpstzR
         nl7g==
X-Forwarded-Encrypted: i=1; AJvYcCUDLZEWpU3Mjlu1UPUS9a/VhrL9Rl0PkIZQMootToj3Kj18XKqmkc3Z1htm1kB3VE5vUDubBmM0FaHKG8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL80kXcL4enwJMCqzBoUpizlr7AlUK7QRPKmw1fqQgqDZVulWj
	jcJdD0tdMRtpJZwtS1lfFN3vP4wwYMIfEoH8VoCDBsFtl0AAJctYzSq0Iaqk9h5liz7+YGr+hz1
	imHXQettMXOMVhBuAqLgZMb1WjifPDbQKtlchQodsBCAeDKWYP2RguBfF7RJfA2w8+po=
X-Gm-Gg: ASbGncsvbKX5ngCQuk8d4orxyBYHLGXdSoGBroLzrVfVPVP3K7k4xvyXQ8XwbFpYRHy
	SAjfJcqjfRLKLZcXWpHAAu72zqrqhcvLBVhRkbiEYIYqzM5Gi1EzIEjFvyuFYTcUapDfMhAgP/F
	bu/K24uMnsD8ZnrKuBkx54cyqf0raCBZ29/V615bFl8IPr4FUxq3iGGaLxvU6LMRYAjqkqF1yeU
	itiY/YgM8wmP8kxelhgh3NBPwbDoSKOR1b3J5rKk08gV1F18DWNQuFLus+GIhErtV6SukxNq6mU
	64cygONEMNZeeL0Yb3VAWhCAudDYMdOw7F8At5xc4InY5WTy/3i2SQ9zrb19IPlBWl9CHjzRkTV
	mXwFQ4IwifGoerePn7rBwEQ==
X-Received: by 2002:a05:620a:19a1:b0:81f:ebae:fae2 with SMTP id af79cd13be357-8240084e22emr1063116885a.11.1758018966149;
        Tue, 16 Sep 2025 03:36:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtrsP4OgHOvZ+jFOe5+SIsQT9/nGz1c5nMb0t2aETsobB1lXRz1cf6sYYhrLoapwJPuNwg2g==
X-Received: by 2002:a05:620a:19a1:b0:81f:ebae:fae2 with SMTP id af79cd13be357-8240084e22emr1063114985a.11.1758018965433;
        Tue, 16 Sep 2025 03:36:05 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3128a5csm1123661666b.37.2025.09.16.03.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 03:36:04 -0700 (PDT)
Message-ID: <ee2d0d92-bff9-4593-a912-7e4b1d66913b@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 12:36:02 +0200
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
        Shuai Zhang <shuaz@qti.qualcomm.com>
References: <20250910-hamoa_initial-v11-0-38ed7f2015f7@oss.qualcomm.com>
 <20250910-hamoa_initial-v11-4-38ed7f2015f7@oss.qualcomm.com>
 <aMPhEm8PuhEofHP7@linaro.org>
 <317ffa87-060c-4f1b-a6bf-61bb27367477@quicinc.com>
 <jimz3qnjrcvemvgrqpwxq4zmywfo6psplsg4jefkvvpiwlffek@fwn3juynr4zx>
 <b3bf54a2-f33b-44d5-a9e4-65ba18ea267d@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <b3bf54a2-f33b-44d5-a9e4-65ba18ea267d@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: DqAWq-EYZNmv_9V7qMZu_zG1_xGq2EaV
X-Proofpoint-GUID: DqAWq-EYZNmv_9V7qMZu_zG1_xGq2EaV
X-Authority-Analysis: v=2.4 cv=E5PNpbdl c=1 sm=1 tr=0 ts=68c93d97 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=Sfr1CVDFLF9upuNpyUYA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NiBTYWx0ZWRfX0xx1ynQ7ALz9
 DQ+rntSTGuKv9p36MC1R7E9vcdScsiMr/RSeqLhmkLb5i+2xON5jWGgnTY+IFhBd0FnGNJTAzKn
 CmVUeIRfbNGtYzXoxu3oX7Xq+0RFCibFRkRUsdIsZGS0YHkYMw8niMV2AramVy+wcwvglqvE+lx
 nTf6/1PlNNVVHuyZRc4Oauy7AYHgNB+s1SZwwj34neUuMfJ9RWAoexxyxYftXS/6pUatytgbCOu
 ERracnDgmm9DvkUjjlzmYM3OWCD2UtvN5TYEQp6CqsGK5keMez5pNKSlvw+shxdPPfq27oOGg6G
 RE042Udkps5PO3GCBDHx3hzFFyHqcvPXIZbxIw+zqiuTfpk6iY3AOxbBW16bPoCREUHiMaLV5lP
 h9DKDoo9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150086

On 9/16/25 12:29 PM, Yingying Tang wrote:
> 
> 
> On 9/16/2025 6:14 PM, Dmitry Baryshkov wrote:
>> On Tue, Sep 16, 2025 at 09:42:26AM +0800, Yingying Tang wrote:
>>>
>>>
>>> On 9/12/2025 5:00 PM, Stephan Gerhold wrote:
>>>> On Wed, Sep 10, 2025 at 05:02:12PM +0800, Yijie Yang wrote:
>>>>> The HAMOA-IOT-EVK is an evaluation platform for IoT products, composed of
>>>>> the Hamoa IoT SoM and a carrier board. Together, they form a complete
>>>>> embedded system capable of booting to UART.
>>>>>
>>>>> Make the following peripherals on the carrier board enabled:
>>>>> - UART
>>>>> - On-board regulators
>>>>> - USB Type-C mux
>>>>> - Pinctrl
>>>>> - Embedded USB (EUSB) repeaters
>>>>> - NVMe
>>>>> - pmic-glink
>>>>> - USB DisplayPorts
>>>>> - Bluetooth
>>>>> - WLAN
>>>>> - Audio
>>>>>
>>>>> Written in collaboration with Quill Qi (Audio) <le.qi@oss.qualcomm.com>,
>>>>> Jie Zhang (Graphics) <quic_jiezh@quicinc.com>, Shuai Zhang (Bluetooth)
>>>>> <quic_shuaz@quicinc.com>, Yingying Tang (WLAN) <quic_yintang@quicinc.com>,
>>>>> and Yongxing Mou (USB DisplayPorts) <quic_yongmou@quicinc.com>.
>>>>
>>>> This looks like you should have Co-developed-by: tags together with
>>>> their Signed-off-by: tags.
>>>>
>>>>>
>>>>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>>>>> ---
>>>>>  arch/arm64/boot/dts/qcom/Makefile          |    1 +
>>>>>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 1221 ++++++++++++++++++++++++++++
>>>>>  2 files changed, 1222 insertions(+)
>>>>>
>>>>> +
>>>>> +	vreg_wcn_3p3: regulator-wcn-3p3 {
>>>>> +		compatible = "regulator-fixed";
>>>>> +
>>>>> +		regulator-name = "VREG_WCN_3P3";
>>>>> +		regulator-min-microvolt = <3300000>;
>>>>> +		regulator-max-microvolt = <3300000>;
>>>>> +
>>>>> +		gpio = <&tlmm 214 GPIO_ACTIVE_HIGH>;
>>>>> +		enable-active-high;
>>>>> +
>>>>> +		pinctrl-0 = <&wcn_sw_en>;
>>>>> +		pinctrl-names = "default";
>>>>> +
>>>>
>>>> regulator-boot-on?
>>>
>>> It shoulde be regulator-always-on
>>
>> Why it's not boot-on and always-on?
>>
> As I described before, connectivity power is voted by UEFI in boot phase.So PCIe link between connetivity card and RC4 is established once RC4 is on.
> If we set this node as "regulator-boot-on", connectivity power will be down first then up. That cause PCIe link down and the link can't be trained again unless you reboot board.
> So we can't set it to "regulator-boot-on"

Surely gpio-regulator.c implements .get_voltage which reads the pin
state though? Did you test this, or are you theorycrafting?

Konrad


