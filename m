Return-Path: <linux-kernel+bounces-753227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AECB1804B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810DE56184C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67082367A8;
	Fri,  1 Aug 2025 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AG1X3p0S"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A26822688C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754044756; cv=none; b=Lgw+eMy7i6BaHE8T3+69Jq/zgu4GehSYLGUunVTyQZsfbmj7x/NF517MkBR6h3gm4gUOitvnm8WssNe3QqFQW5oCv1k9JNxreaXoUm2NlI5Trw0QtMBDi3/7shQwjSy+YTxifvyLePS5UfXspMsiZsA9g3hurteIEJ+NKD4gFj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754044756; c=relaxed/simple;
	bh=uCpKWTkJ/fCfH3mMaq/yojngcvWuCjSopHeTtL9FI9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Srunoq7Trl2bp5jVGxRwajqjKfM/s/LbkpVUMhuQen5DRw6XH3T1mkUIqEvGqJ7iHLPMzXjZ8tbTBhSXDI0tM76HmtLLfusIm3fM9zkoTJaG+5Otni8wiqkXxZBYqVdyxtJ+F+/CqHOXAnGWuDrsFIt+4DCtx6HBX3w5xQ0r7B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AG1X3p0S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5718wulp018990
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 10:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tM+hqRsJl8WAV8VmhYfaNUgPW/yNR+t0v3xVXl2HDbI=; b=AG1X3p0SwJE9rZAh
	HHt2JuXkfs5kEhFv/CoMJXKdZOd+6fXVT/bk93l8xNw/s5+d4XzYLLCxE8x6S7J9
	J4VnaYb+syphgZRtOx4daLMrkhba1I/YS52CwnWjpR14pAVUhMt5JbW3FBbQ0nca
	rrJQMCMVF2Vl26EZq6UiJjm0LQN6XlCvCw1+mdaN81NdiCWdOHOy5ArXvXIHNQ1j
	36jI6yrLeX2YvYeXiyG1FuiggMMWQcM9pXTDMGOf37JkoPGWrD8+Fz5V1eZKV1qS
	NHnHCZDI8enYXW/+LCXV0OWYL8MOLianlI1K9ZAu+jynkVuPqM/gLkPmc9JwSpnY
	oSV7IQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qdabdmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 10:39:13 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4aef8afd26bso3813501cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 03:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754044753; x=1754649553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tM+hqRsJl8WAV8VmhYfaNUgPW/yNR+t0v3xVXl2HDbI=;
        b=u0mMdeRUpG1sfJYp5eiU4Y21kXSumH+cEvecKSEIsQVPtc2itZOLgmHTD7qzviAr2U
         /U6DohdQpoUKMCNsiCSK6ED3EcRMQMFUfCG2Vjr5fanlQwRXRnZu4sWfDKdd9h3vF8zS
         3uEvx441dNJnt79GEX2/HooXm/0+kPOyUKpUAEcwHrMEj52Dyuhx1pk0z5TB9n/7aA23
         JqZxw4/LRZkdsI7QapXQ9WDI3S7r2sPpIR+XU+ogwKRuImUFN3wxsMqXP3gjA3jMk0Iq
         AJgBUGvhsxPQpJjVpktEZAtshIZNd/hO8SPaMjppVutPq4SWouYTFoB6BX+k8scL26Fh
         uhlA==
X-Forwarded-Encrypted: i=1; AJvYcCXcAq7nZ5yWfvgKJ82oUHFarxP+bNxZ1xfCQlA5bG1PnttKHdXDFw1J1oMQkqJmM1j8gDztfE3HIjW14SY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi8MEZhgJ1tqOiTsZ17FqVh5gRBDyeKd1gZVVlKuLdOLARjUm+
	nc1Dd5YKuihaXUKdS7MgQOQdn8kMdyZICeySNt56yu/jKhrnpMNHGCz/CuiFsjFybl6OQNepadr
	xZHLGVHy16/KxJHQCiM2iypngCT0py9WyO3DpvJO82XG0HC9cryFX0yQI4FG/vvedp2U=
X-Gm-Gg: ASbGnctxqN+G4reV+JFAPq6c/8/8fmGbKMkpsHzEzDgzNWQUheof90oVh4K+zxC2YqX
	CUDtSRwWtxg4TiPDWdMErerWeRU6TxRfLcLlyvwtBC45pUzD3GDHlXc9Tp37BuAniT4mM8r/GR2
	X2KEAFBwjS9JopJBzqyhmJRVdFpsn4Y5c/R85vATZ1+ZWWvfTnGBlcEEPGN3xKq60noYSTSjKyk
	GHmJOP5r0IL10kpCv0HPiiEELUGv1KI4QSC82bMUwSp5DFBbwLaW4QTY9ukDL9kFcyxqO1T0HsK
	2MDv8ZrTFork3VbEj0KIxbU9MWknZ6z/Ay+A+htEO/jxxw9JM55s5bZyQe3nDUnPbY2XZDxZ+3Z
	DgH+7tPjkAHq0hgRUlg==
X-Received: by 2002:ac8:58cc:0:b0:472:1d00:1fc3 with SMTP id d75a77b69052e-4aedbbee59amr76614791cf.8.1754044753139;
        Fri, 01 Aug 2025 03:39:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBWsaTEnVzC9m8P/J4xr7Gfw6eN0GOoTSrRxAhA4lBR7AdcM7tIKRAjy6Jyh1sk9oa5POInw==
X-Received: by 2002:ac8:58cc:0:b0:472:1d00:1fc3 with SMTP id d75a77b69052e-4aedbbee59amr76614661cf.8.1754044752576;
        Fri, 01 Aug 2025 03:39:12 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e6cecsm268757966b.70.2025.08.01.03.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 03:39:12 -0700 (PDT)
Message-ID: <afd9e24f-b432-494c-8ea6-dbfe4c51e048@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 12:39:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
To: Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250729-hamoa_initial-v3-0-806e092789dc@oss.qualcomm.com>
 <20250729-hamoa_initial-v3-4-806e092789dc@oss.qualcomm.com>
 <pbvyog477v32s4lu72z52dhsond5yud5w3nxmcouvr6ljlndlh@ws46dncy35c6>
 <b4a3f568-f41f-4141-b421-8b158973f810@oss.qualcomm.com>
 <cawg456ucsvssm2ngbcjvpprxke7s3sfqf4fzoj5dtfj2flnzw@2e3h5ojgn4s5>
 <391b8214-37f2-460d-94d0-3bd0daa00066@oss.qualcomm.com>
 <mlbutlxudl5i32zrqegxiefaa2sbkntriwdftn7hxo4khidtf2@oiljtmtktovu>
 <31b03c1b-513a-4eae-9233-568aab12e0c8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <31b03c1b-513a-4eae-9233-568aab12e0c8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: eehXDL1Lu_NM4TxOajZiFkn_Eyou2N8b
X-Authority-Analysis: v=2.4 cv=Pfv/hjhd c=1 sm=1 tr=0 ts=688c9952 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=zJ5sFbfWOGX_-7L8bd8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: eehXDL1Lu_NM4TxOajZiFkn_Eyou2N8b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA3NyBTYWx0ZWRfX80bJa/bsnFTu
 uCEat9fdvu6yxUFhOmX0/Mw+jbLm6OtcGpSCG/aHhsHwEhtZhgU7oJnRqYjcWFaSiiQbc3rNEWG
 YdkCWwvXefAtRGUPTifLsqEIez7ezVGAvVaMX6yvDpCYDAWfNp6qhxBd5idHEGqoeVyeRYqJePl
 IKxxTn0C8HWspWho01P+KDWC+TviZ+U/iC0OWeIZXAUOK4oFweZ8PRZJu8XbiTJd9/by6sEaxQX
 6jDuvZFtjk87Gv6EjGVXruaZqmm43MrCyqU4wnV8ekWJhxbnW6p5lNUof9teCmFJ9OPedO9WYhH
 rwhM/Vdl8ds/zzYHzYT+pG9TD06OsVbJ8tggMyO/ec8DjWyFozEhOntcKCUyi3uSIUw3ES0L7TN
 FieKY14IWhLXfMzO9QP21p4IR8mTYxo0xcDLz15XCNE8KJw71TsByBW2vGm9bo1Z+0LLBIAp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010077

On 8/1/25 3:48 AM, Yijie Yang wrote:
> 
> 
> On 2025-08-01 04:22, Dmitry Baryshkov wrote:
>> On Thu, Jul 31, 2025 at 04:45:33PM +0800, Yijie Yang wrote:
>>>
>>>
>>> On 2025-07-31 02:42, Dmitry Baryshkov wrote:
>>>> On Wed, Jul 30, 2025 at 02:28:25PM +0800, Yijie Yang wrote:
>>>>>
>>>>>
>>>>> On 2025-07-29 18:37, Dmitry Baryshkov wrote:
>>>>>> On Tue, Jul 29, 2025 at 09:32:00AM +0800, Yijie Yang wrote:
>>>>>>> The HAMOA-IOT-EVK is an evaluation platform for IoT products, composed of
>>>>>>> the Hamoa IoT SoM and a carrier board. Together, they form a complete
>>>>>>> embedded system capable of booting to UART.
>>>>>>>
>>>>>>> This change enables and overlays the following peripherals on the carrier
>>>>>>> board:
>>>>>>> - UART
>>>>>>> - On-board regulators
>>>>>>> - USB Type-C mux
>>>>>>> - Pinctrl
>>>>>>> - Embedded USB (EUSB) repeaters
>>>>>>> - NVMe
>>>>>>> - pmic-glink
>>>>>>> - USB DisplayPorts
>>>>>>>
>>>>
>>>>
>>>>>>> +    vreg_rtmr0_1p15: regulator-rtmr0-1p15 {
>>>>>>
>>>>>> Hmm, so there are regulators for the retimer, but they are not used.
>>>>>> Could you please point out, why?
>>>>>
>>>>> According to the schematic, there is a regulator and a retimer (PS8830).
>>>>> However, as mentioned above, the retimer is not connected to USB 0 and is
>>>>> therefore not used in the EVK. As a result, the regulator is left unused in
>>>>> this context.
>>>>
>>>> What is connected to the retimer then?
>>>
>>> All data lines are broken, except for some power lines.
>>
>> Ok. please add a comment. If the retimer is connected to I2C bus, please
>> define it too.
> 
> It’s not connected to I2C. I will add a comment here.
> 
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>> +        compatible = "regulator-fixed";
>>>>>>> +
>>>>
>>>> [...]
>>>>
>>>>>>> +
>>>>>>> +    usb_1_ss0_sbu_default: usb-1-ss0-sbu-state {
>>>>>>> +        mode-pins {
>>>>>>> +            pins = "gpio166";
>>>>>>> +            function = "gpio";
>>>>>>> +            bias-disable;
>>>>>>> +            drive-strength = <2>;
>>>>>>> +            output-high;
>>>>>>
>>>>>> What does this pin do? It's not recommended to set GPIO values through
>>>>>> pinctrl.
>>>>>
>>>>> It is used to switch data lines between USB Type-C orientation detection and
>>>>> DisplayPort AUX channels.
>>>>
>>>> I don't think I follow it here. Which data lines? Type-C orientation
>>>> detection uses CC1 / CC2, DP AUX use SBU lines.
>>>
>>> I made a mistake here — this pin switches between two data sources: one is
>>> DP AUX, and the other is a GPIO pair configured with the function
>>> usb0_sbrx/usb0_sbtx. Both data sources originate from the SoC and are routed
>>> to the USB0_SBU1 and USB0_SBU2 lines of the USB Type-C connector.
>>
>> So, it's some USB4 stuff. Ideally it should be described via the
>> gpio-sbu-mux, but I don't think we can do that for now. I'd let Bjorn,
>> Konrad or Abel comment on this.
> 
> Sure.

There is no DT representation of USB4 hardware at the moment, feel
free to pretend it doesn't exist for now.

If we wanted to be hyper-correct, the way USB(3) is plugged into the
bigger picture isn't quite pristine either, but that's a story for
another day - need some puzzle pieces to come together first

Konrad

