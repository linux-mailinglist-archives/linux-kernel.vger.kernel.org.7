Return-Path: <linux-kernel+bounces-794569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C47B3E363
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09EF31883E47
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4483218D5;
	Mon,  1 Sep 2025 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WkV3fYSI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE312D7DC9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730348; cv=none; b=i9egsrVNhiybzN8xgKTxHC47D98we7EbUTrlHGPubDGX8Tk5UQV3br8JgOtxvLLPaAfaVSxSnp2QK4QeDDNeQUTqDea7t/+U3GK4ElKdw4fFLHCFG0dS/SLbhBJGXFkl35uIeaTikYrB9+pDg955NBqCSRXJaEOpE0eMgbg3Wgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730348; c=relaxed/simple;
	bh=66ZL2zRlf98eYrB1UdArAINhd9+RZABLfPnFY9v3/lY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFgonXIrSiEJC7Ogo+y2NzrfXaII8v9oWQQRFF1NFoG4nrAA0c8GNVEuHFVohUc+Cz3hDg0b6IrGrL2ZIu3SK66DCUosAC/0/zbsIEM4T5Huto/moO/ca34RVaz3slqrO4ZYCPwSmYIYLFRe18afY8WnKuX5bRl5/E/UR1vlSVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WkV3fYSI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 581B4G0V007229
	for <linux-kernel@vger.kernel.org>; Mon, 1 Sep 2025 12:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ag+uc2sfSISlJdM0Nw82xpwB7MNtUR0GdzbeqIRcIGA=; b=WkV3fYSIlVrcFM2Q
	IZe+oZy7wvsT7uLcQpkSKNJpdIfj5VXYmI5Bf4jwrwSjZHOZLvxx283DBy8YoJ5Z
	o5N0LHt97jEiriRn8qt/G/apE6Bxg5XEHB2DXDp83U/EM6jhzeDSDyB+9+AIww6X
	Db0gDmfkYh7DR1QWBFvD3iOrTmLTzBbYWHKBB9eDNFilJcur074t5jsncIa4Pf8g
	17uq7FUtQ4KvRqMv/9TJUvWwW6DlcVAmFcQl1zWcoCpCVRvlQrzmapq2D7zhD4j+
	e1S5WXiIubJsugnSCXjw7PiipAnBrcEIzuFIW3gTi1+x7NrByEIeRTscDdb5JcPq
	SqPptQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk8vpbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 12:39:05 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244580538c3so11582475ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756730345; x=1757335145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ag+uc2sfSISlJdM0Nw82xpwB7MNtUR0GdzbeqIRcIGA=;
        b=m+Ys17MbBgac/urpS0n/a7cDJhEHCG8LGmkrMVZKNVOG01VbyAx8wdFnlxxyFhObN6
         eyQfAqkUOVxu7AyevrfQCfHyfpNWTWeeRGESmUsGZaDS2EkFOuHcYBUQ6nW6txETDO/y
         B0y4jbE4wj9y2HAm9wrHYAkoYRxT73zrLHREIqmJCrtvVvvDrMAUt5WJQh0GjOFLVw6U
         TEyCObgCgU/3cGz/6cQmxVeaE3YFvVQSlvdn+jZVhBYktmU25Yrsi+p+CFfjuv//1DLk
         DvXj31yMppebqwDqxms+ipNaON1tumvIQWm+5mO3rHvgcUruKEPIUv549bXhb9UBfUXh
         1HIw==
X-Forwarded-Encrypted: i=1; AJvYcCVroum4+QupM/s5n4dHRnDQz2ruwX//HxbUrhVgSASJPPY7pVnpX1HLtH6jA5pC00C+wxkyTp/F8U/9dhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF6oNM39WOKamj+TRTD8ZTc/cmNkeT+Iclytk/uYvXOZVa7tW3
	8E8S8TdqPPHnF2PvXu+aJczBQWTq4aa152wFxfa+sBDwTR7qphwyx563iOROwluUp7ppQNlcCSX
	p79jIwc/U5uTDny/hXnklYiP/NlbObfb2Li8p9BoAFSuHKNZAF0mNOkQQpjrgWjR0gh8=
X-Gm-Gg: ASbGncuDyJk3ZGtojkbNMTrZvRoH7Og9MwGjQuO6Zu/dz6MArOJzbDpqVFMdsskV0Zf
	QUSJq5FCkXNeulQoJQ1MDwot4hKSgG9p4xc8biZ/R1lf6YmzmHHSFENUPubHZxAb91Lf3yUX6BB
	53aslHEUXriT45tBm0ZmvB1B7cDnq6BeGJZjAS5xa2B+9LhM3Ja31nqUdphCSLRG4Jhp5BhnKEM
	Ed0msZ1ZFZckPMTpEQsobY/ybHHuYOIfWq3/e7/ysSgOlfmHou9XMMkqAJ8X1VUKhFwD0OEvDkw
	47FjjwAaJMo3l3HJakBinTRUsjEwSOuG2znP+WiNXqxcVKm+I+dVwisKUxvfvgy4ig1qv6JQKQ4
	mSoV0c7U5s27V0zcWUlCEYcHaf07D1w==
X-Received: by 2002:a17:902:d488:b0:248:ff48:8779 with SMTP id d9443c01a7336-2491e1ed5d2mr67831125ad.2.1756730345027;
        Mon, 01 Sep 2025 05:39:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGenErKxO5/yYfNFbGUt4G6q+mh/TfyItFjo8JNUx5mpoIN5ZQtB3b2C6jXNrrW8UUGRc9ZyA==
X-Received: by 2002:a17:902:d488:b0:248:ff48:8779 with SMTP id d9443c01a7336-2491e1ed5d2mr67830675ad.2.1756730344486;
        Mon, 01 Sep 2025 05:39:04 -0700 (PDT)
Received: from [10.133.33.251] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490658999fsm101472765ad.112.2025.09.01.05.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 05:39:04 -0700 (PDT)
Message-ID: <04549ce5-fa14-440d-b5b9-f8ff059f632a@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 20:38:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] dt-bindings: phy: Add QMP USB3+DP PHY for QCS615
To: Rob Herring <robh@kernel.org>
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
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-2-a43bd25ec39c@oss.qualcomm.com>
 <20250822142230.GA3591699-robh@kernel.org>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <20250822142230.GA3591699-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: w_bf26nVQL7bD5uFd3bnVztJW7Kn-Knb
X-Proofpoint-ORIG-GUID: w_bf26nVQL7bD5uFd3bnVztJW7Kn-Knb
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b593ea cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=mavVfetI76m9BAqSKQsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX3ZWYiQok+a7N
 w4kVerMryXm1dwIRA6pYHJFBOJUNp7v0W4Te1LUUHtKmH1dR8P0jTJ8GGekDj0l26n6h8oVSpPO
 9CROUx8DC92o9z0+UnznFaGne+A5xF14OVezIhZuuq0UeN9VoL2Zcgp6kceLBPVcvKUzdNaMGKY
 YILS9/U18WFiFFftzeAgvf2U8gELNXlkAVseZ52MVud9NgFRMS/14rTUuaR2bpMwflfVLfr3yZK
 EwItWfueeGT8nd2VY2mxx0ExT/f4u2sVQTv6c+q7YwX3Xw3F7r+T6SZN6+KbprFcUj7/bms2Eq/
 pnw82cZYVJBpYDZYuJn0cXBn2wgX7PNb+7j3hvH/kQt6XO9+qZbSJwjcp0T7wKFDQptRN6jZECi
 aT8Nn4Ee
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042


On 8/22/2025 10:22 PM, Rob Herring wrote:
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
> No, this should be someone who has the h/w.


I have discussed with Bjorn offline. In the next version, I’ll update myself as
the maintainer for this dt-binding.


>> +
>> +description:
>> +  The QMP PHY controller supports physical layer functionality for both
>> +  USB3 and DisplayPort over USB-C. While it enables mode switching
>> +  between USB3 and DisplayPort, but does not support combo mode.
> Wrap at 80 chars.


Ok, will update next patch.


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
> phy_phy?
>
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

