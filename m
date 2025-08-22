Return-Path: <linux-kernel+bounces-781228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EEFB30F80
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02489188E2C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC362E371A;
	Fri, 22 Aug 2025 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mKgQV9n1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7310023B607
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845321; cv=none; b=Y88oBbc587B5QQHJKrmBxipDVtPdJy+ceBmgyvqJ7PDu1e4zIeF10aB99gDi50CdUd239geqD39NJgoUKDO+My0yZsMG1fq22nD4pKDi6GoqmY969ur9DoXElux2lD6FZFVq3pzRyh6efsriHmrv+lj1q4RCIYTKfVjFAmoQ5/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845321; c=relaxed/simple;
	bh=EtDO50NiQ2FngCb6HjMX2xjHCi6gNyKrhyCrOT7cMFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+Q/EzewKN3WWFfx/RPdS0+BXVoAqiol2aEE1XvO6vDk+jLOQT3BG6/vQ2Fr6LXQrmEoHnRpf0lDnMfa+8wHAqIuz2XiLIpDsRps1r7abEhI1h0y3fgXz0wTidyghZKouxzY8YLqw1dTgHvAxdpeAfZplILe7CHsjZnz+aPNoe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mKgQV9n1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M6MZHQ022785
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wt7rxN5hrf2QPuy6mxcJXvWkksap7MeXMIyW8r0g2eE=; b=mKgQV9n1vTRZQ6/l
	ZmTEHvaDDWuplAmg+x+xQzrZWj7Q23cyJFazU3pCcvmYGX3IWW6xyIVNx2OKHBGb
	jWBWFhvfckHXnOrvurHn4GQ7DbqrMgwYADmJKhhAo+dvBvhD5tN6S5Dcme12cG1y
	QADsZ0sb66OXBbG923zTVl10ni7Jx7Fb+S4J8ezHu0hPd9FY3gOGcOmWJDhAprrq
	9WAY9zYCrTC8DPW2Pv7lLhDwEqVA7Mqj9nCcP/NmTZ1w9nr+rvyYO2r9dx4NeHzf
	CLum0i0zw+iX+nSY99LC2lg/gYa+TSC+OrgR2xy0pqXn6Hd/cNP2UA0gGT1uNzn5
	7w0iYQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52ag5dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:48:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-245fbdc2546so5593625ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 23:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755845319; x=1756450119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wt7rxN5hrf2QPuy6mxcJXvWkksap7MeXMIyW8r0g2eE=;
        b=az0GS7lTBiY3xem7icAG6zJWAKzK0BKYLliazuI0lPXtB67a69Yk7NRqMj0vyYmAAg
         RO9J9x74Uwd+xwuGWAM12vlGSgc4UsRJcqQFDCcT3EOA38Qd98tVEnxdoe+/fyZPn1DQ
         vrsV9OGNlY8icnSznhMbx/WmLWuXJwNhxl6V2N8qijrDGXSZDLeUW+mumlpDelqnnYGI
         kW/pkyJyq9BJukLpSl0TPNQdLfjJyQfz58dJ9yOEeY+fNquS53agn1KHzf4G4DBl1YvR
         VV8psXpA/EzZAhcJhn3iQ43WOPGHCCoTpImKHXVTHMsc7B1sZzjh5HOqSkB6H4On4r3i
         G34g==
X-Forwarded-Encrypted: i=1; AJvYcCXI8Epz32f3pqhPOhaWhQqEYk1T1ZoKjsqEJTqJV+Dp0dNc/xI4UhAltLb4f7aHxL7Vc8vlDtTozUGRkqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGeRt8awdyPxA0NQOfMnf6SYZLhMVL7jtOseU8VCsYwsrs0DSl
	mKbOoxBH8XJiPtst0A4q91YDGq83VAV2UtrlZn1cdezlPdjYJs8f2YokQxTxCbtAVhbKc8AamGu
	da10AS1e3vCZ8PQIQERnRdIXbm+71oAZIBJbN6n3TW7pCp/mCX6SR1ER0/T0CSMEV2/Q=
X-Gm-Gg: ASbGnctCC+ov9+eSZ7M3S8UbZaTh2UZAtMTlRYNFczlJT5xyM+qDup0HkmAVqPZewuK
	SYa2KeUegIRZ2rvIDNOrTVDIUKDgpcBDJNh5FCY9BVyHj0rf2cw1g+eln50MFwsPq/DUD6fnXsE
	nu7XlAjPA0x4oPm9+50nRbAGhel+unMg2kEwV0VObENNwGgU0ukLGVJzdUsHkDpJGz2+IRKXGgR
	0r8d46B9jeI9vFdRkESZkwrsl0MuU29oNoSzSBlaTYJpFxjLK7BynsTa5K3KlpUm/QMfG/6kvZF
	vvOH/JYr/yURgQzRX7dhVcadX/6uf//Tj4g57McMF6FPJsZ7RLUEWWUUMZsA8j8HwmRRQndzcbK
	ag5iiqpslLztN8hxR1qtMMCQLmbCq9w==
X-Received: by 2002:a17:903:189:b0:242:d237:e20b with SMTP id d9443c01a7336-2462ee3033amr16554265ad.4.1755845318718;
        Thu, 21 Aug 2025 23:48:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH61Dg+R7H0dG6DmZ19hrTFC03VFv8xBO0r6XYbjTLMp1iwo0A+Wvhyyylwysjt+0wtsntd1w==
X-Received: by 2002:a17:903:189:b0:242:d237:e20b with SMTP id d9443c01a7336-2462ee3033amr16553585ad.4.1755845316681;
        Thu, 21 Aug 2025 23:48:36 -0700 (PDT)
Received: from [10.133.33.119] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed51c027sm74231315ad.148.2025.08.21.23.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 23:48:36 -0700 (PDT)
Message-ID: <dd3c9cc4-3b4a-4321-88ab-933909b6da87@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 14:48:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] dt-bindings: phy: Add QMP USB3+DP PHY for QCS615
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-2-a43bd25ec39c@oss.qualcomm.com>
 <tlilctwavwqw6oy46l5fote2pa6f4hdy2im6meo56cjaawba3a@a42bwbbfnsuw>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <tlilctwavwqw6oy46l5fote2pa6f4hdy2im6meo56cjaawba3a@a42bwbbfnsuw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Zg5Oh_KWGGDo108cO9gwpqQhLeUw8YRZ
X-Authority-Analysis: v=2.4 cv=B83gEOtM c=1 sm=1 tr=0 ts=68a812c7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=bGlgfQEnYdfhEoguRucA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: Zg5Oh_KWGGDo108cO9gwpqQhLeUw8YRZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX9/4ZPty+EmR4
 GQj6y5FmK+9O2mWXop1SuxiF/2zQUiW+W0JnbssGV4ubxiTKAhYGAHQzMpaHmWl56qFC89zyV/6
 k+mElFf1vcSNWWAza8TJi6rch1g85gbsCOMwRf3uN7SD3kWGaZmRRZwnnSi8Vil0ugsCtZma8kC
 onA4E7SqbND/Nc1EqFjBmCQ9S9CpzFtzKS7VXIg6Cr9sIN8Pds3im1q2wcVN3w2xE9/hS8jix4o
 ldJe4SoCG8C/0TBF1dF7RaTtRZcX2YudCpFWk7s0ZudwQHwEP7XivseT+Yt8tSiwF15c2y1GLlJ
 pLIbH890prK6AkT0nCem7oZvmFlLONjq7PMYGI9xSIgvlW3oF1q2bP0Mrpc4YP5jvLTLp98n7jD
 kiuZwvrmJVN+wk15Yz+4NaP5zDgjMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013


On 8/20/2025 7:37 PM, Dmitry Baryshkov wrote:
> On Wed, Aug 20, 2025 at 05:34:44PM +0800, Xiangxu Yin wrote:
>> Add device tree binding documentation for the Qualcomm QMP USB3+DP PHY
>> on QCS615 Platform. This PHY supports both USB3 and DP functionality
>> over USB-C, with PHY mode switching capability. It does not support
>> combo mode.
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  .../bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml   | 108 +++++++++++++++++++++
>>  1 file changed, 108 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..c2b1fbab2930f0653f4ddb95f7b54d8fe994f92d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml
>> @@ -0,0 +1,108 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/qcom,qcs615-qmp-usb3dp-phy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm QMP USB3-DP PHY controller (DP, QCS615)
>> +
>> +maintainers:
>> +  - Vinod Koul <vkoul@kernel.org>
>> +
>> +description:
>> +  The QMP PHY controller supports physical layer functionality for both
>> +  USB3 and DisplayPort over USB-C. While it enables mode switching
>> +  between USB3 and DisplayPort, but does not support combo mode.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,qcs615-qmp-usb3-dp-phy
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 2
> Missing GCC_USB2_SEC_PHY_AUX_CLK and GCC_USB2_SEC_PHY_PIPE_CLK


Ok, will fix in next patch.


>> +
>> +  clock-names:
>> +    items:
>> +      - const: cfg_ahb
>> +      - const: ref
>> +
>> +  resets:
>> +    maxItems: 2
>> +
>> +  reset-names:
>> +    items:
>> +      - const: phy_phy
>> +      - const: dp_phy
>> +
>> +  vdda-phy-supply: true
>> +
>> +  vdda-pll-supply: true
>> +
>> +  "#clock-cells":
>> +    const: 1
>> +    description:
>> +      See include/dt-bindings/phy/phy-qcom-qmp.h
>> +
>> +  "#phy-cells":
>> +    const: 1
>> +    description:
>> +      See include/dt-bindings/phy/phy-qcom-qmp.h
>> +
>> +  qcom,tcsr-reg:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    items:
>> +      - items:
>> +          - description: phandle to TCSR hardware block
>> +          - description: offset of the VLS CLAMP register
>> +      - items:
>> +          - description: phandle to TCSR hardware block
>> +          - description: offset of the DP PHY mode register
>> +    description: Clamp and PHY mode register present in the TCSR
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - reset-names
>> +  - vdda-phy-supply
>> +  - vdda-pll-supply
>> +  - "#clock-cells"
>> +  - "#phy-cells"
>> +  - qcom,tcsr-reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,qcs615-gcc.h>
>> +    #include <dt-bindings/clock/qcom,rpmh.h>
>> +
>> +    phy@88e8000 {
>> +      compatible = "qcom,qcs615-qmp-usb3-dp-phy";
>> +      reg = <0x88e8000 0x2000>;
>> +
>> +      clocks = <&gcc GCC_AHB2PHY_WEST_CLK>,
>> +               <&gcc GCC_USB3_SEC_CLKREF_CLK>;
>> +      clock-names = "cfg_ahb",
>> +                    "ref";
>> +
>> +      resets = <&gcc GCC_USB3PHY_PHY_SEC_BCR >,
>> +               <&gcc GCC_USB3_DP_PHY_SEC_BCR>;
>> +      reset-names = "phy_phy",
>> +                    "dp_phy";
>> +
>> +      vdda-phy-supply = <&vreg_l11a>;
>> +      vdda-pll-supply = <&vreg_l5a>;
>> +
>> +      #clock-cells = <1>;
>> +      #phy-cells = <1>;
>> +
>> +      qcom,tcsr-reg = <&tcsr 0xbff0>,
>> +                      <&tcsr 0xb24c>;
>> +    };
>>
>> -- 
>> 2.34.1
>>

