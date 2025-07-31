Return-Path: <linux-kernel+bounces-752430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4F0B17580
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE3AA824C3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF2724BC09;
	Thu, 31 Jul 2025 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WX50MObl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45B123E33D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753982035; cv=none; b=NvcjFMa6aPnliEEhGVkGXoY+17LLodjVl7hoXKiWf3IznUQt4bYJc9RoSxOu/T+4XAwfZLwjek5IYL5W1ohnBsb5udakSz86GBNGccv20BQXiNz/o34Sx1NISfb6jjtry6VObAeG1FLdpcSTNgkJjQuYZZtItZ3zybtnS/BTqsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753982035; c=relaxed/simple;
	bh=a+1MxP7PV6NBX20myqQzV9CxQLsJH6x27V4zi00BF3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N38ixzhNfAA67fCcde4rqTklBtx+kvSqc2bMPSd3br/9lF5Iyam0XRKxmU+tRRN8m0RQfJDSh/pcHPuY/lgHvZgYafJ5jvOHqS4JGcG3Z8hq+/hSnDBueyqcOKXQqor+MBiVoAADqPx9hFQgXnKPTW+HYgPMR6G2x12/gWYMJrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WX50MObl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VDfcsJ010214
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 17:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ofCj3+DeUV/y5WrDcns9NIGKwdDXCv8HNiS6UfKisRo=; b=WX50MObla3mMccxm
	ttNOLrjiWUwAoWZTPwT3Xm72rI/wWRFztiSINDhCfV6JHIRCl3nw2WezEn0CFkdS
	E5PT3RTxlkhUBTGnaCFvvWKTXTY62EomlWlz8LvGu+98SKu7Xe2iC9bKh82+VLF8
	m3pC2BYM4lpNU4tPE8ZDEuo3s30YUZyJpwtY/CxKGak/1KZSd96kHEE9ZraMuWP7
	doiTPmL/J7FkQ1+f/+PfhnsZEZ7UKRXcX4j73mnpQSZ0grapCtxkj9gfV9lzeeLN
	oB2qciirDcHaZqxLDTYWmblraG5PKBoUP3zG5CvzVh3NCPf4whRh2zwzi+vSc5I1
	jGpXNA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4860ep6430-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 17:13:50 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-53921a0efc0so1133176e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753982029; x=1754586829;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ofCj3+DeUV/y5WrDcns9NIGKwdDXCv8HNiS6UfKisRo=;
        b=p4q7fMda7dQx3N8KlRgbfoh3IVlskDJsoBIdCUiLecu/h7TYK6fh7jwhrmsPAiDfaV
         pjmwVFCIfqexBLOv8TKub8nR/c+LSAlCXY/UnKB8deW/SvIS0WF7rcVt/SVnyv6PehbR
         sdhTsDNoleYvOQdtb9maV2Pr2f0POR1B7WMVfndrhtY3+vIpZW1qIG7AKR99OKm6ODVB
         cVMoIHIAz5rYiLPVulzbqbP8HxQAP18FGzCPg/LiWG6U2pdakDmILGOHAuVT+lmllgtv
         VN+ZEVh5tX1Hy3NII67IwD+IAY+4KeA+jMYsn6OHx6lEwOE1Z6bGGa/1gmChqqijoTcK
         FMIg==
X-Forwarded-Encrypted: i=1; AJvYcCV6PnDh6SxG7gAvSW31k1brbom3ipj0OTBA7bY5WD+F3DJakiBvmpOBCdrGqQUvcUaCU8I9lJs6/o0jrck=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXl6obhqKhlMAnN/7aRYJfK1HYTwl8UMZws+l9qS1xumH0GQUb
	ZTt8JjFoJs7yX266dSv5RIUSQHRvTtBuzG2cBpORWRJV+vro6pxJQjFTRnfOie7C0TcsBZkqx17
	p3NbQgqm1yst6596UgZ0h+amx/VgzPq0crM4XHB04bCSLXTTteHPwKH7kYQOdshSRUNk=
X-Gm-Gg: ASbGncu0GRbKBgVnV57FrV4lSyB6EybGo/VrENuRpqk1hphw2wIqeZ6XyHgljfkYZNc
	mTi0BFQPNDzR4mFya7ceLwbH0jz6dgB19Uz42te6CNGb9ww0KiZ90IY7DSWTNYziuUMx84ROLDs
	JtYjYqAjYQ/xWAog3wUVPt0MMaTzvbn5705YKiZidUY/ArVeyISK3qIGf0bTmlBaDYTTdMumQIS
	lr49HJEiIFvsfxMtQeXI4B0Q0aASBx8SaRpwsQSDT2cdft48HaYdqiS/uiW6KzAtNS6uQs9XOs4
	IEdnULIaa8DOv0XZISomylsdbc7s8Qi7oDIIapwHUNrUEURHvlpiZGyDCkgXm2nxCUZFniKEQ9Q
	Tn5PgfP1GWUFsbA==
X-Received: by 2002:a05:6122:62ca:b0:538:e454:ea8e with SMTP id 71dfb90a1353d-53938905a99mr1857770e0c.7.1753982029387;
        Thu, 31 Jul 2025 10:13:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF52dzZur4u5mVprmHH1cNIiS5IST4nNlWgeTkq324s1h1QrAG/Kd+PfkF4M7ViNxObk+iijw==
X-Received: by 2002:a05:6122:62ca:b0:538:e454:ea8e with SMTP id 71dfb90a1353d-53938905a99mr1857741e0c.7.1753982028845;
        Thu, 31 Jul 2025 10:13:48 -0700 (PDT)
Received: from [10.148.43.238] (87-95-32-33.bb.dnainternet.fi. [87.95.32.33])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238272963sm2983111fa.14.2025.07.31.10.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 10:13:47 -0700 (PDT)
Message-ID: <ad4f53eb-2f4b-4e62-a162-461de431e3de@oss.qualcomm.com>
Date: Thu, 31 Jul 2025 20:13:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] dt-bindings: phy: Add binding for QCS615
 standalone QMP DP PHY
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        konrad.dybcio@oss.qualcomm.com, fange.zhang@oss.qualcomm.com,
        quic_lliu6@quicinc.com, quic_yongmou@quicinc.com
References: <20250722-add-displayport-support-for-qcs615-platform-v2-0-42b4037171f8@oss.qualcomm.com>
 <20250722-add-displayport-support-for-qcs615-platform-v2-2-42b4037171f8@oss.qualcomm.com>
 <jemfu5sy7k4a2iar55im5bhyhxzlrwpftmpqmps3b2tco7r6a2@oodls7gi45yy>
 <e673a3a3-6924-49db-9040-e34b82199a43@oss.qualcomm.com>
 <w3rwao5wbmstdyics6qhp7beulbbp5ludqkwpfsmevgqmzz3d6@u2e533zlitkr>
 <e5a3f05f-9775-4e3d-ae7d-ebbca14b4df5@oss.qualcomm.com>
 <ffdvzupefzhqq7fqtloycc3xzu57i55ths73xcjftor2cifuzr@5vhq2hfmkvda>
 <bd8f8643-a8c8-43d7-b293-acdba5ff798a@oss.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <bd8f8643-a8c8-43d7-b293-acdba5ff798a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xFuR0hoWBzpou4YCchBxO3c7kVzKFAQ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDExOCBTYWx0ZWRfX6MnpjzksJuYT
 vSUTbwiBOa0UGen1m5NNY2UUaT10kQYw0yuJAPUNX57BluFsT6TrpP2QS9k3mt1APSEy8jLgYme
 KQLONcJWlxN3IABNVVWlrgeVnQISWe1Z+EsEkMa2Y+hQL+M3pPTcewPArAEpZ6riLHCkRtT6eIg
 xmuZrgDhbZZXjVr6c0hrBUP/5iYuq4w7lh4yTmITNG7wpyfZeklUJu7kHuJMeP55h3SoMkzcwtQ
 gSTEeZMbnbqrGLpl9t83WOsT6/jRQ3vbESj1Ld1VHSnj9STva91ZTyB8G/YXRhT0F7NHhrTEWwg
 WJnOGgKtlDAQ2tpdw2p4vkmoJfexJTZDJwwawDubW3UvwDU1qGuWFq8+VrQhhx461cgNhWN8XAg
 8AM9Ca3ou1G70nyLma0Uhq9x+s39U+Eii41g9QDnMov+dejOkMDcgw1Mb/BaSIIAdCCixBtg
X-Authority-Analysis: v=2.4 cv=DIWP4zNb c=1 sm=1 tr=0 ts=688ba44f cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=H8T8cKqSsIHj2cBiWKmgXw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Oh2cFVv5AAAA:8 a=EUspDBNiAAAA:8
 a=74qhCITlYKpdjXRJ2hIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22 a=7KeoIwV6GZqOttXkcoxL:22
X-Proofpoint-ORIG-GUID: xFuR0hoWBzpou4YCchBxO3c7kVzKFAQ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507310118

On 31/07/2025 08:06, Xiangxu Yin wrote:
> 
> On 7/31/2025 2:35 AM, Dmitry Baryshkov wrote:
>> On Wed, Jul 30, 2025 at 04:53:16PM +0800, Xiangxu Yin wrote:
>>> On 7/22/2025 8:41 PM, Dmitry Baryshkov wrote:
>>>> On Tue, Jul 22, 2025 at 08:05:06PM +0800, Xiangxu Yin wrote:
>>>>> On 7/22/2025 4:38 PM, Dmitry Baryshkov wrote:
>>>>>> On Tue, Jul 22, 2025 at 03:22:03PM +0800, Xiangxu Yin wrote:
>>>>>>> Introduce device tree binding documentation for the Qualcomm QMP DP PHY
>>>>>>> on QCS615 SoCs. This PHY supports DisplayPort functionality and is
>>>>>>> designed to operate independently from the USB3 PHY.
>>>>>>>
>>>>>>> Unlike combo PHYs found on other platforms, the QCS615 DP PHY is
>>>>>>> standalone and does not support USB/DP multiplexing. The binding
>>>>>>> describes the required clocks, resets, TCSR configuration, and clock/PHY
>>>>>>> cells for proper integration.
>>>>>> Simply put: no, this is not correct. Even if you go to the SM6150 block
>>>>>> diagram, it points out that DP uses the USB3 PHY, not a separate DP PHY.
>>>>>>
>>>>>> I thought that we have discussed it beforehand.
>>>>>>
>>>>>> I can quote my comment from the previous thread:
>>>>>>
>>>>>>>> No. It means replacing extending existing entries with bigger reg and
>>>>>>>> #phy-cells = <1>. The driver must keep working with old node definitions
>>>>>>>> as is to ensure backwards compatibility. New nodes should make it
>>>>>>>> register two PHYs (USB3 and DP). On the driver side modify generic code
>>>>>>>> paths, all platforms supported by the driver should be able to support
>>>>>>>> USB3+DP combination.
>>>>>> Looking at the hardware memory maps:
>>>>>>
>>>>>> MSM8998: USB3 PHY regs at 0xc010000, DP PHY regs at 0xc011000
>>>>>> SDM660: USB3 PHY regs at 0xc010000, DP PHY regs at 0xc011000
>>>>>> QCM2290: USB3 PHY regs at 0x1615000, DP PHY regs at 0x1616000
>>>>>> SM6115: USB3 PHY regs at 0x1615000, DP PHY regs at 0x1616000
>>>>>>
>>>>>> Now:
>>>>>> SM6150: USB3 PHY regs at 0x88e6000
>>>>>>          USB3 PHY regs at 0x88e8000, DP PHY regs at 0x88e9000
>>>>>>
>>>>>> I do not know, why msm-4.14 didn't describe second USB3 PHY. Maybe you
>>>>>> can comment on it.
>>>>>>
>>>>>> But based on that list, the only special case that we need to handle is
>>>>>> the first USB3 PHY, which doesn't have a corresponding DP PHY block. But
>>>>>> it will be handled anyway by the code that implements support for the
>>>>>> existing DT entries. All other hardware blocks are combo USB+DP PHYs.
>>>>>>
>>>>>> Having all of that in mind, please, for v3 patchset implement USB+DP
>>>>>> support in the phy-qcom-qmp-usbc driver and add the following logic
>>>>>> that also was requested in v1 review:
>>>>>>
>>>>>>>> Not quite. Both USB3 and DP drivers should be calling power_on / _off.
>>>>>>>> If USB3 is on, powering on DP PHY should fail. Vice versa, if DP is on,
>>>>>>>> powering on USB should fail.
>>>>>> I think our understanding might not be fully aligned.
>>>> I did not write this. Please fix your mailer to quote messages properly.
>>>> As you are using Thunderbird, I'm not sure where the issue comes from.
>>>>
>>>> Also please fix it to wrap your responses somwhere logically.
>>>>
>>>>>> Perhaps this is because I didn’t accurately update the mutual exclusion relationships and test results for the different PHYs.
>>>>>> Let me clarify my latest findings and explain why I believe these are separate PHYs that require mutual exclusion via TCSR.
>>>>>>
>>>>>> 1. About the TCSR DP_PHYMODE Registers
>>>>>>
>>>>>> MSM8998/SDM660:
>>>>>> 	Only one TCSR_USB3_DP_PHYMODE register at 0x1FCB248.
>>>>>> QCM2290/SM6115:
>>>>>> 	TCSR_USB3_0_DP_PHYMODE at 0x3CB248
>>>>>> 	TCSR_USB3_1_DP_PHYMODE at 0x3CB24C
>>>>>> SM6150:
>>>>>> 	TCSR_USB3_0_DP_PHYMODE at 0x1FCB248
>>>>>> 	TCSR_USB3_1_DP_PHYMODE at 0x1FCB24C
>>>> SM6150 has two different sets of output pins, so the first register
>>>> covers first set of SS lanes (which are routed to the documented SS
>>>> PHY), the second register covers the second set of SS lanes (which are
>>>> routed to the DP and secondary USB PHY).
>>>>
>>>> I can only assume that the same configuration was supposed to be
>>>> applicable to QCM2290 / SM6115, but was later removed / disabled, while
>>>> the registers were kept in the TCSR block.
>>>>
>>>>>> Even though MSM8998, SDM660, QCM2290, and SM6115 all have one USB3 PHY and one DP PHY, the TCSR DP_PHYMODE register configuration is different on each platform.
>>>>>>
>>>>>> Additionally, I found some interesting register documentation for QCM2290/SM6115:
>>>>>> 	TCSR_USB3_0_DP_PHYMODE: “In kamorta this one is for mobile usb. DP not supported.”
>>>>>> 	TCSR_USB3_1_DP_PHYMODE: “DP mode supported for Auto usb in kamorta.”
>>>>>> I think the reason for having two different TCSR registers is to allow both the USB3.0 and DP PHYs to be useds at the same time in certain product configurations.
>>>> Sure. One for the first PHY (USB), one for the second PHY (USB+DP).
>>>> If you check the memory map, you will find the second VLS CLAMP register
>>>> for the second USB PHY.
>>>>
>>>>>> 2. SM6150 Test Results
>>>>>> When TCSR_DP_PHYMODE_0 is switched to DP, the USB3 primary PHY cannot work, and the DP PHY is also not functional (possibly due to clock lack or other configuration mismatch with this TCSR setting).
>>>>>> When TCSR_DP_PHYMODE_1 is switched to DP, both the USB3 primary PHY and the DP PHY work normally.
>>>>>> I think "why msm-4.14 didn't describe second USB3 PHY", because TCSR_DP_PHYMODE_1 always works in DP mode.
>>>>>> https://android.googlesource.com/kernel/msm/+/af03eef7d4c3cbd1fe26c67d4f1915b05d0c1488/drivers/gpu/drm/msm/dp/dp_catalog_v200.c
>>>> Here it still programs the TCSR register.
>>>>
>>>>>> Based on these info, I believe these are separate PHYs, and only the
>>>>>> TCSR DP_PHYMODE registers determine which USB3/DP PHYs are paired or
>>>>>> mutually exclusive. This is why I have maintained separate private
>>>>>> data for each PHY and implemented Power on mutex control via TCSR,
>>>>>> rather than using a qmp_combo-like structure.
>>>> Still, no. Check the block diagram of SM6150.
>>>>
>>>>>> Given the above, do you think we still need to force USB and DP to be strictly bound together like a combo PHY?
>>>> Yes.
>>> I checked the related PHY series and block diagrams again.
>>>
>>> PRI and SEC go to different nodes based on the SoC design, and there are two types of configurations: USB3-only and USB3+DP pairing.
>>>
>>> Before proceed the v3 patchset, I’d like to double-confirm whether the following structure is what you expect:
>>>
>>> usb_qmpphy_1: phy@88e6000 {
>>>      compatible = "qcom,sm6150-qmp-usb3-prim-phy"; <== rename to PRIM
>> No, we already have a compatible name and DT schema for this device.
> Then current compatible name is "qcom,qcs615-qmp-usb3-phy" and shall we need update to "qcom,sm6150-qmp-usb3-phy"?

Why? You _already_ have a compatible string. You don't need to change it 
just to follow the SoC name.

>>
>>>      ...
>>>      qcom,tcsr-reg = <&tcsr 0xb244>, <&tcsr 0xb248>;
>>>      qcom,tcsr-names = "vls_clamp", "dp_phy_mode";
>> No need for qcom,tcsr-names. Second TCSR register should be optional in
>> the driver.
> Ok.
>>
>>>      
>>>      #clock-cells = <1>;
>>>      #phy-cells = <1>;
>> #clock-cells = <0>;
>> #phy-cells = <0>;
>>
>>>      ...
>>> };
>>>
>>> usb_qmpphy_2: phy@88e8000 {
>>>      compatible = "qcom,sm6150-qmp-usb3dp-sec-phy"; <== SEC SS, use usb3dp to indicate DP capability
>> qcom,sm6150-qmp-usb3-dp-phy
> Ok, but for this part, shall we update dt-binding in "qcom,msm8998-qmp-usb3-phy.yaml" or create a new one?

I think (I might be wrong here) new ones is a better fit. We'll migrate 
the rest of PHYs to new bindings later on.

>>
>>>      reg = <0x0 0x088e8000 0x0 0x2000>; <== SS2 base address and offset define in driver config
>>>
>>>      clocks = <&gcc GCC_AHB2PHY_WEST_CLK>,
>>>              <&gcc GCC_USB3_SEC_CLKREF_CLK>; <== This SoC has no USB3.0 SEC SS clk
>>>      clock-names = "cfg_ahb",
>>>                  "ref";
>>>      clock-output-names = "dp_phy_link_clk",
>>>                      "dp_phy_vco_div_clk";
>> No need to, the driver can generate names on its own.
> Ok.
>>
>>>                      
>>>      resets = <&gcc GCC_USB3PHY_PHY_SEC_BCR >,
>>>           <&gcc GCC_USB3_DP_PHY_SEC_BCR>;
>>>      reset-names = "phy", "phy_phy";
>> "phy_phy", "dp_phy". Is there no GCC_USB3_PHY_SEC_BCR?
> There are only GCC_USB2_PHY_SEC_BCR and GCC_USB3PHY_PHY_SEC_BCR, no GCC_USB3_PHY_SEC_BCR.

Ack.

>>>      qcom,tcsr-reg = <&tcsr 0xbff0>, <&tcsr 0xb24c>;
>>>      qcom,tcsr-names = "vls_clamp", "dp_phy_mode"; <== added for backward compatibility with legacy configs that only had vls_clamp
>> No need for qcom,tcsr-names, correct otherwise.
>>
>>>      #clock-cells = <1>;
>>>      #phy-cells = <1>;
>>>
>>>      status = "disabled";
>>> };
>>>
>>>>>>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>>>>>> ---
>>>>>>>   .../bindings/phy/qcom,qcs615-qmp-dp-phy.yaml       | 111 +++++++++++++++++++++
>>>>>>>   1 file changed, 111 insertions(+)
>>>>>>>


-- 
With best wishes
Dmitry

