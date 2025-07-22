Return-Path: <linux-kernel+bounces-740584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D67B0D610
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F641AA124B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA312DCBFA;
	Tue, 22 Jul 2025 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SNaDaZlF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1963C2DCC1A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177080; cv=none; b=s3vK3sEimSzOSZ5fbURKh+OYuMguUyecy42/6iOrf2xXeI/bRRLpsGuxqlHydL5Kp1CEM5VlbtSWcIHPzdl9mGEZxUeCREOluIwuxte0VATXtcGF87mLqp00uHEza3DF9gBc6AaLmcWrnL6gBsDABuQ2XiEaogO71bflEPxLkI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177080; c=relaxed/simple;
	bh=ay7GBZH0XoTFRCFOySLUQ4uf7+hP8fYkuRqYZGwMoRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Boae1h6tMaLeddWFu3YNUrd0cyuDj3qB0dauLf37PsaNz4xgzhU3LXnY5p46kQ4nCIvNl3RRRmPzO1oj+vzDandQU+EMK1PliHrlqyURahwZ60AJyQPjsnP/LOVhMmEXV9/3mYpx8dbrjep5DYsOjzOxB4FuokQDcRHUNpX+Z1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SNaDaZlF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M2iHUg005664
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	akWLR5np0O8srsxKP+5qpNfRtwnATXLcGoSJVQnX9ww=; b=SNaDaZlF2db9r+m+
	XLw7GDec1CAEnENrHZaBniAJap30ELbr+pbiVF1gortB7CE6Q7OVqwRTSCvjkj7/
	LgDDqmT54Vq+Xyi00q9SPggAdjDuWvo/piPk8w/huGBSTCirlwXGS4eHMfo8yk7T
	EAfzoMGtVVlb059KhDSz4QVE1G8RBmCXtabjHrn7G8GxSTUUE/CrTw/avPVdWReo
	iLLoVPZTbv+X1iRTbmtsu0/Dc+RXuzRgdZuZCtFwNvRoXjTKaQgYD9h/CyZ3B38+
	YoMAYZ5k/JKpVFlbVtmcHOMhXM1vJ1gSLRmcDgCPRWTS4NptavoZoivg1Ek2fLa8
	SGHA2A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047q90bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:37:55 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-754f57d3259so7711307b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 02:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753177074; x=1753781874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akWLR5np0O8srsxKP+5qpNfRtwnATXLcGoSJVQnX9ww=;
        b=idWnml6rDxZlaqiySsBEcHnkStHg/26jkwP6xmNKBrcuyWi31K7Pl1IlZ/xunqPg9p
         iSzGt+TUBsedxAizLIHYNrBY3MmQ3UitFNJPSogiTzkxAiJ7UfWqFRPz2x7/mkW9HaD0
         SgSixAft0joZVsM8or/7fIDceOQlQLdQ43iJbpy+mtLlvwLSpQZtuXRaHRluZZDv0ZUf
         Zb48Hc8AwvvzTOJ+X2Q+XBtWJRY0UWiJ8PMYZJR9Zc/ks//7xaYbj/xxN1MzBpmLg9h8
         DGJAz3Lvy9zSL8GnYc/IdF5r9ac6wDwNZkmaf+i8m4vtf1wr8B6DqVPYEEdbVZMz+UvV
         POAw==
X-Forwarded-Encrypted: i=1; AJvYcCUDWhb3HukeKe14Ew9uF93kAs9IQYvyplo3JIWrIcb1bjUiO148Tkcw0f6a3krBEC0adazVrE8l15IRqGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYO2W9qvHCW833CJxv5W7yo3ve9FMc4KU7DbJ+acUcXkktrpJV
	lMsLlnGhCO4QioROXuC3NC+37f3S86P+k8161ffgdSqRRcr3xwvxZovgIVHU3Z0VtUHe9SrHGtz
	56BvuyH0dpUnVP4++5hLgSDXqqnhNNsJ40UVlkk6jqNZ4mZrvzwxi0dxV/+JZl4ORHG4=
X-Gm-Gg: ASbGncv3ShXxApet8r9CiKCBLIJ0a/m46wOmlYR9zN36wUofDrkhhbgTtI2dh3kiakf
	4yASQCPk0NLdoDiGr7T0FoPmQ394zlkK/2GmjYrgWSw21km9+oQyBYKq9A41PebCCynweeKoWol
	345nLORE5sFdeutG6hzpT4xIRQ7dFqCEkqixppmO+2f5X9CNVTgmxWxe7WpX9Rkljqj+1xzzcrc
	HtMcPU+N6zgB6j7zGm4/G0M8QFdC8pM9L1u0jvPvqFi3TeP5SYJsXTeVAOsdYLQ8eOEDo4MNUcj
	MmrL7S1yp1KHjr8ITH1qvaimmzoxzogD2YeNkTq8XwRSO5QKVqwfg60ure66p6nxcUe+b3m1HUl
	QqRi32MpiksefvYwoQHDq15w0jDDMRd9XNmIA4u0bE3aa0d3fxz5W
X-Received: by 2002:a05:6a00:18a7:b0:748:fcfa:8be2 with SMTP id d2e1a72fcca58-75848c188b1mr27268413b3a.2.1753177074486;
        Tue, 22 Jul 2025 02:37:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnbrJIlPlS2ld1hHgKGm1W2SISx9Scg+A/kRt3BSJ2+CPL57THLlhTzUmEbaf7M61thzAyLw==
X-Received: by 2002:a05:6a00:18a7:b0:748:fcfa:8be2 with SMTP id d2e1a72fcca58-75848c188b1mr27268375b3a.2.1753177073914;
        Tue, 22 Jul 2025 02:37:53 -0700 (PDT)
Received: from [10.50.52.170] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb1575f0sm7127431b3a.75.2025.07.22.02.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 02:37:53 -0700 (PDT)
Message-ID: <594ffaa5-4120-44bf-a3db-c1f61bb12940@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 15:07:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: qcom: Add Glymur pinctrl
 bindings
To: Rob Herring <robh@kernel.org>
Cc: andersson@kernel.org, linus.walleij@linaro.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_rjendra@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250721163221.310746-1-pankaj.patil@oss.qualcomm.com>
 <20250721163221.310746-2-pankaj.patil@oss.qualcomm.com>
 <20250721195624.GA1160054-robh@kernel.org>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <20250721195624.GA1160054-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA3OSBTYWx0ZWRfX4J19MDSywMvy
 kitHAmhfLJERYsWq7x+9EjtAebljyytT4MjuQpis/jpK0QK5BPOj22EYphKf7rAdeeJ1YXL8sAi
 iUbkYiTeOkKz+2rcOGvOGRVGaZ/Tu0M8c47e96efVCu7UPnRwbgM685pGkMTQHYUMPKTj5Rq/t2
 038Q24UkUz6DfM2DEcXDAi+h6EX3S1M4NyloIsG48D/1aVnVwoBfKcs8q5G04na6+Np/Oe1ky4K
 LeYP0TLrbMOPG5K6y+0kP89DjWH70l9NQGsLTgcpc/YMp0PuEovC7z6WS+2FmA3vuPWjEA4qaBb
 MRnHXY5RyBTT1rQJmUiwiE5EbF0xcjaoWesPooxXv6YLwpj+znIwxhs7NcUJIRaD0QNfOZz1oHC
 cNZNDFLtrT0rF3CFf1FNeeYXUXVxHk53ol/9IXzAEV6QuHsxLjqSTTu1VoN/zQcvm6p1NVal
X-Proofpoint-ORIG-GUID: CDHdCMEsE_OfX1gB87ZH7b9gHgbr6p7j
X-Proofpoint-GUID: CDHdCMEsE_OfX1gB87ZH7b9gHgbr6p7j
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=687f5bf3 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=XFrnbPTz3ZSepkxgYsgA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220079

On 7/22/2025 1:26 AM, Rob Herring wrote:
> On Mon, Jul 21, 2025 at 10:02:20PM +0530, Pankaj Patil wrote:
>> Add DeviceTree binding for Glymur SoC TLMM block
>>
>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>> ---
>> Changes in v3:
>> Fixed indentation for example tlmm node
>>
>> Changes in v2:
>> Updated gpio-line-names maxItems to 250
>> Fixed example node reg property
>>
>> .../bindings/pinctrl/qcom,glymur-tlmm.yaml    | 128 ++++++++++++++++++
>>  1 file changed, 128 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,glymur-tlmm.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,glymur-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,glymur-tlmm.yaml
>> new file mode 100644
>> index 000000000000..25ec99bde59d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,glymur-tlmm.yaml
>> @@ -0,0 +1,128 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pinctrl/qcom,glymur-tlmm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies, Inc. Glymur TLMM block
>> +
>> +maintainers:
>> +  - Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
>> +
>> +description:
>> +  Top Level Mode Multiplexer pin controller in Qualcomm Glymur SoC.
>> +
>> +allOf:
>> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,glymur-tlmm
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  gpio-reserved-ranges:
>> +    minItems: 1
>> +    maxItems: 119
>> +
>> +  gpio-line-names:
>> +    maxItems: 250
>> +
>> +patternProperties:
>> +  "-state$":
>> +    oneOf:
>> +      - $ref: "#/$defs/qcom-glymur-tlmm-state"
>> +      - patternProperties:
>> +          "-pins$":
>> +            $ref: "#/$defs/qcom-glymur-tlmm-state"
>> +        additionalProperties: false
>> +
>> +$defs:
>> +  qcom-glymur-tlmm-state:
>> +    type: object
>> +    description:
>> +      Pinctrl node's client devices use subnodes for desired pin configuration.
>> +      Client device subnodes use below standard properties.
>> +    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
>> +    unevaluatedProperties: false
>> +
>> +    properties:
>> +      pins:
>> +        description:
>> +          List of gpio pins affected by the properties specified in this
>> +          subnode.
>> +        items:
>> +          oneOf:
>> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9])$"
>> +            - enum: [ ufs_reset, sdc2_clk, sdc2_cmd, sdc2_data ]
>> +        minItems: 1
>> +        maxItems: 36
>> +
>> +      function:
>> +        description:
>> +          Specify the alternative function to be configured for the specified
>> +          pins.
>> +        enum: [ gpio, RESOUT_GPIO_N, aoss_cti, asc_cci, atest_char, atest_usb, audio_ext_mclk0,
>> +                audio_ext_mclk1, audio_ref_clk, cam_asc_mclk4, cam_mclk, cci_async_in, cci_i2c_scl,
>> +                cci_i2c_sda, cci_timer, cmu_rng, cri_trng, dbg_out_clk, ddr_bist_complete,
>> +                ddr_bist_fail, ddr_bist_start, ddr_bist_stop, ddr_pxi, edp0_hot, edp0_lcd,
>> +                edp1_lcd, egpio, eusb0_ac_en, eusb1_ac_en, eusb2_ac_en, eusb3_ac_en, eusb5_ac_en,
>> +                eusb6_ac_en, gcc_gp1, gcc_gp2, gcc_gp3, host2wlan_sol, i2c0_s_scl, i2c0_s_sda,
>> +                i2s0_data, i2s0_sck, i2s0_ws, i2s1_data, i2s1_sck, i2s1_ws, ibi_i3c, jitter_bist,
>> +                mdp_vsync_out, mdp_vsync_e, mdp_vsync_p, mdp_vsync_s, pcie3a_clk, pcie3a_rst_n,
>> +                pcie3b_clk, pcie4_clk_req_n, pcie5_clk_req_n, pcie6_clk_req_n, phase_flag,
>> +                pll_bist_sync, pll_clk_aux, pmc_oca_n, pmc_uva_n, prng_rosc, qdss_cti, qdss_gpio,
>> +                qspi, qup0_se0, qup0_se1, qup0_se2, qup0_se3_l0, qup0_se3, qup0_se4, qup0_se5,
>> +                qup0_se6, qup0_se7, qup1_se0, qup1_se1, qup1_se2, qup1_se3, qup1_se4, qup1_se5,
>> +                qup1_se6, qup1_se7, qup2_se0, qup2_se1, qup2_se2, qup2_se3, qup2_se4, qup2_se5,
>> +                qup2_se6, qup2_se7, qup3_se0, qup3_se1, sd_write_protect, sdc4_clk,
>> +                sdc4_cmd, sdc4_data, smb_acok_n, sys_throttle, tb_trig_sdc2, tb_trig_sdc4,
>> +                tmess_prng, tsense_pwm, tsense_therm, usb0_dp, usb0_phy_ps, usb0_sbrx, usb0_sbtx,
>> +                usb0_tmu, usb1_dbg, usb1_dp, usb1_phy_ps, usb1_sbrx, usb1_sbtx, usb1_tmu, usb2_dp,
>> +                usb2_phy_ps, usb2_sbrx, usb2_sbtx, usb2_tmu, vsense_trigger_mirnat, wcn_sw,
>> +                wcn_sw_ctrl ]
> Wrap lines at 80 char.
>
>> +
>> +    required:
>> +      - pins
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    tlmm: pinctrl@f100000 {
>> +        compatible = "qcom,glymur-tlmm";
>> +        reg = <0x0f100000 0xf00000>;
>> +        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>> +        gpio-controller;
>> +        #gpio-cells = <2>;
>> +        interrupt-controller;
>> +        #interrupt-cells = <2>;
>> +        gpio-ranges = <&tlmm 0 0 249>;
>> +        wakeup-parent = <&pdc>;
>> +        gpio-reserved-ranges = <4 4>, <10 2>, <33 3>, <44 4>;
>> +        qup_uart21_default: qup-uart21-default-state {
>> +            tx-pins {
>> +                pins = "gpio86";
>> +                function = "qup2_se5";
>> +                drive-strength = <2>;
>> +                bias-disable;
>> +            };
>> +
>> +            rx-pins {
>> +                pins = "gpio87";
>> +                function = "qup2_se5";
>> +                drive-strength = <2>;
>> +                bias-disable;
>> +            };
>> +        };
>> +    };
>> +...
>> -- 
>> 2.34.1
>>
Checkpatch.pl checks for 100 char by default,
for bindings should the length fixed to 80?

Will update in next revision.

