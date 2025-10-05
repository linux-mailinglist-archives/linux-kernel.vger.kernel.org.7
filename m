Return-Path: <linux-kernel+bounces-842480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7FBBBCCD9
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 00:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D03F4348589
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 22:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9586B23D7DF;
	Sun,  5 Oct 2025 22:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lF6Cdduc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A01A9FA8
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 22:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759701735; cv=none; b=lwuIlJyKOdhOUnRIcb0+h59DIrBiw4kBsVTSKq83/xD3vxeq0r4uelgEZPsUAbfU6y7hfGP63WoHRV/qdeD3XvyU7ZZt1q4EcBkITlbT6+3UnDgUtztSP1U+RTB66lAX/romOHZ9cCtvol9yC9jwuXEzN0Nc8nYmMmokiRqt2as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759701735; c=relaxed/simple;
	bh=YgLo6dEzUPmKG0n4v0UvXEdOJ/Qo5qEUw/SfGkaorUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5VVW7bYywZfetPr69wLO55tNPZ/Jmwhpj5qxEPw27UN+jZpvcjaYKbXmAMLKV67LovYFC3gciul/TPPFVPAc/adJiGenQ0LNdHfsTy9groUJC2S2XaMzUSlk+qhrfZj0EUbLzG7HJYNvAwxLxdNLEpWDl3Je7pgI8YsuuuVPe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lF6Cdduc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595FS5r9016469
	for <linux-kernel@vger.kernel.org>; Sun, 5 Oct 2025 22:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=N256hlAuYoC5VZZOOilDZ2b/
	UfNCJGDfOP6dgO8ecLc=; b=lF6CdducMpVUxg7v5KV2xvLDDr/WMRHAUalgLEZ7
	kLNEId6NLIuWAfWhK047h0e2/E0TQO5xAMTh8+awSmuUS37KuZSQ/MyJEKnp7PZn
	K0/MIrNdK0xbz9X4rt5bA2v1BQmG2hrxZKckDOiUEfCoZoGMKrjRdMJHdbrvcTiS
	wAW5ZGsnrRQAtQve6pOyQTX7Zqs1iGsyxYdFcP19g4LnNi110y3zaKvW91gQThcY
	rojAaBssKiLTLp3HImNDdKOoy5KuBIwQoooOcFqJ4vc5g/7l6+PDfUoo31QGmoAP
	QgsjbfQ68z1fZyNnSwpoTdPFjw5mGc877HnZN968KnS7jQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jrxn2srr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 22:02:12 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-28973df6a90so40050455ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 15:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759701732; x=1760306532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N256hlAuYoC5VZZOOilDZ2b/UfNCJGDfOP6dgO8ecLc=;
        b=uKMyWcetyv8yNOlc3ZvTEjzN34McuNao/M3jASctwK1CXcvydDFC8A3e8hXyqHVzw+
         lpknScyCaWp6A0xjTeJA7w/4s8EgkJHiXBKCPJDAw6uFCZs64Z97PV6A2oYhvcsVgu86
         onjQi4GnuokRIe7arEA8y+Claqc+Nv6Iq9C5SQYk+l9mOf4B6B6NOc7iwUDHpzcTujJL
         8GZTnowEyBTsRVcJ++ICZUjLSvW2UXIdqbeyQeesCA/Kzm8tkNrtg1HCvxLifiwISZYI
         17IOQ1cmIhcONKsQxC2UydgJC1AjIN2V/Hd/qQr6jvYfTtdeZUYkA0nsXJ0Rtm5oIyF5
         nN8g==
X-Forwarded-Encrypted: i=1; AJvYcCW5ixR2CLdSORH3c8m3DYhrxa68mltVyRv8kpEPib1uIH01Y7dUrijunMqKYc5SZ2zeBN4bhHL+aJyk6DA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2X+weHGRe5gS7znqa8xGh/F1iTymUXNvJo/cdpyhDBxH2r94Q
	vxaadxK8czQW7BIHFNRIJNttTJu+P5U71qGDIol8iYHa5zKKGj1dXbdEKV7zB1hLMqMhcGu8FZB
	h3dAIq7PRciYkbnJ/XXHDFT1rPTzNP5oSpq6wgyziDYzg1gE8nmvM/Sh7oAD2acAW9TV8kN41M2
	ZAnFoyOfyPApsgjQwPgHgId3tiW01+9n3EPdPerJfKiQ==
X-Gm-Gg: ASbGncsRmmn33hitKiSPpQsyJ+bGVJzVapsrnzDwm3FSE3hVhITknR+qyiybjqRAhkc
	e3SobvlHKYt45zNihqnhzQ14qrxLYwukeH3lTOSizm7QdcHPaDogh4qXKBcz8M5nrZY3vAj05TI
	9TBu0YfTleGY0uhSUNTtItl7ql36YyC84RVbX5IYq+aV+GZmPhY0vc8s9zhg==
X-Received: by 2002:a17:902:db0b:b0:269:b2a5:8827 with SMTP id d9443c01a7336-28e9a5441d2mr123489865ad.16.1759701731635;
        Sun, 05 Oct 2025 15:02:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEw5H3bnClwmyFijTzPlTIdJv/FoUFtpaPkBeTmanH+Kmn1x1n5CJdxzZudHkd+BA4S2ApQpqFUagP05oAcE14=
X-Received: by 2002:a17:902:db0b:b0:269:b2a5:8827 with SMTP id
 d9443c01a7336-28e9a5441d2mr123489405ad.16.1759701731098; Sun, 05 Oct 2025
 15:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925053602.4105329-1-quic_amakhija@quicinc.com>
 <20250925053602.4105329-3-quic_amakhija@quicinc.com> <vsty7sy7gi2eeyifokwcqpoycmarxietkijmlkymwrmzmdsfws@x64f4ulbc6ja>
 <aaa9f760-70aa-4bee-b6ab-d6fb02ea3c78@quicinc.com>
In-Reply-To: <aaa9f760-70aa-4bee-b6ab-d6fb02ea3c78@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 01:01:59 +0300
X-Gm-Features: AS18NWCM1r74v1bXxfrsrgftusyMHXRCg5iM3xO5_k0pu2EPz6imHWWBkRHsRFA
Message-ID: <CAO9ioeWHJSj74VBR=2kHJDe_p1oG9Ngs6q9+s=CySGD3KY6sPQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: qcs8300: add Display Serial
 Interface device nodes
To: Ayushi Makhija <quic_amakhija@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com, sean@poorly.run,
        marijn.suijten@somainline.org, andersson@kernel.org, robh@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, konradybcio@kernel.org,
        conor+dt@kernel.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, quic_rajeevny@quicinc.com,
        quic_vproddut@quicinc.com, quic_jesszhan@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwMSBTYWx0ZWRfX9Kz4vnKl5kXp
 o4BKQd7eTZ92brj8LSq6OC2zwsSvmSaxGQ30A2W6ikgCcfYOni4gSUOLrhaWIJ/YRNGnTB0qqjB
 DX1DVfV/8vFzzwstwV2Lsjk0Y7AaDUMUejhK6DoKmn4IYtW6bzAfsU8pXC7PBNoCQqZxdXyzSt9
 4fWXTg8dGU+i71DwFGly3LyYtLMN/2ANBJC9Y8LqONbQQSVmJ3cEYL5ZNAhI4++G78BRTjkqslb
 Val1IAr7pI4COWBx2z6WqZ4ScU18rSU+UtL2x9eAWzIaqOvlpZ5U6cq5HbdhkpFV5zrM4QrTDrg
 0JsUo08Q1Lnawd2auqBwjD/AKb/+8aQVJt9m+op3VA3y/Oji8uhxChY39EiI9Oy9GlMCGh4LaRL
 kOypo1u7aP3wElyn4wMmALk4MZiQZQ==
X-Proofpoint-GUID: szU6wyKPCsyr0gD8FcTabzU9e4C2xJ79
X-Proofpoint-ORIG-GUID: szU6wyKPCsyr0gD8FcTabzU9e4C2xJ79
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e2eae5 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=gEfo2CItAAAA:8 a=COk6AnOGAAAA:8 a=0nM2LEvACttjMDtNBYMA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-05_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040001

On Sun, 5 Oct 2025 at 19:49, Ayushi Makhija <quic_amakhija@quicinc.com> wrote:
>
> On 9/26/2025 3:32 AM, Dmitry Baryshkov wrote:
> > On Thu, Sep 25, 2025 at 11:06:01AM +0530, Ayushi Makhija wrote:
> >> Add device tree nodes for the DSI0 controller with their corresponding
> >> PHY found on Qualcomm QCS8300 SoC.
> >>
> >> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
> >> ---
> >>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 95 ++++++++++++++++++++++++++-
> >>  1 file changed, 94 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> >> index e0e1f63fc45b..834ae0522f2f 100644
> >> --- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> >> @@ -3,6 +3,7 @@
> >>   * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> >>   */
> >>
> >> +#include <dt-bindings/clock/qcom,dsi-phy-28nm.h>
> >>  #include <dt-bindings/clock/qcom,qcs8300-gcc.h>
> >>  #include <dt-bindings/clock/qcom,rpmh.h>
> >>  #include <dt-bindings/clock/qcom,sa8775p-camcc.h>
> >> @@ -4854,6 +4855,13 @@ dpu_intf0_out: endpoint {
> >>                                                      remote-endpoint = <&mdss_dp0_in>;
> >>                                              };
> >>                                      };
> >> +
> >> +                                    port@1 {
> >> +                                            reg = <1>;
> >> +                                            dpu_intf1_out: endpoint {
> >> +                                                    remote-endpoint = <&mdss_dsi0_in>;
> >> +                                            };
> >> +                                    };
> >>                              };
> >>
> >>                              mdp_opp_table: opp-table {
> >> @@ -4881,6 +4889,89 @@ opp-650000000 {
> >>                              };
> >>                      };
> >>
> >> +                    mdss_dsi0: dsi@ae94000 {
> >> +                            compatible =  "qcom,sa8775p-dsi-ctrl","qcom,mdss-dsi-ctrl";
> >
> > qcom,qcs8300-dsi-ctrl. You might use three compatibles (qcs8300, sa8775p
> > and the generic one), but there should be qcs8300 one.
> >
>
> Hi Dmitry,
>
> If I am adding three compatible string for ctrl,
>
> compatible = "qcom,qcs8300-dsi-ctrl",
>              "qcom,sa8775p-dsi-ctrl",
>              "qcom,mdss-dsi-ctrl";
>
> while validating dt-binding and dtsi against dt-schema. I am getting below errors
>
>
> /local/mnt/workspace/amakhija/linux_next/linux/arch/arm64/boot/dts/qcom/qcs8300-ride.dtb: dsi@ae94000: compatible: 'oneOf' conditional failed, one must be fixed:
>         ['qcom,qcs8300-dsi-ctrl', 'qcom,sa8775p-dsi-ctrl', 'qcom,mdss-dsi-ctrl'] is too long
>         'qcom,qcs8300-dsi-ctrl' is not one of ['qcom,dsi-ctrl-6g-qcm2290', 'qcom,mdss-dsi-ctrl']
>         'qcom,mdss-dsi-ctrl' was expected
>         from schema $id: http://devicetree.org/schemas/display/msm/dsi-controller-main.yaml#
>
> According to the dsi-controller-main.yaml schema only two strings are allowed one is the SOC specific and other one is generic "qcom,mdss-dsi-ctrl".
>
> Shall I keep only two strings qcom,qcs8300-mdss.yaml and the generic one "qcom,mdss-dsi-ctrl" or if we want to support 3 strings in compatible sting we need to modify the dsi-controller-main.yaml ?

Of course.

> Similarly, I am getting error for dsi_phy compatible string only one SOC specific compatible string is allow.

So, what's the question? You are adding support for the platform. So
yes, you need to modify the schema.

-- 
With best wishes
Dmitry

