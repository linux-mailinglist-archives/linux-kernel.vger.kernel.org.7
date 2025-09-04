Return-Path: <linux-kernel+bounces-799744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BDAB42FB6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88AB2188C7BB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD3D1EEA3C;
	Thu,  4 Sep 2025 02:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XxpUJ52f"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6BC1E2614
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952524; cv=none; b=D6qYW1OvYz091qn2p5BtyhQOtAZv+zLjIVwCl9dBhgb0xtAqHhqHe/yaz2BgIhZwtklQzTkBDDytwHGJzmvPTPT7yx/cBNXlUi2rVIRZt9+3i76F/yps/60CCbs5sBU0GND716x4ucCu6WlFJqGiVSYzTcv1F951WrZn5+BzC60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952524; c=relaxed/simple;
	bh=3plnOV/tQZr+r/U+s46fToEDbwaCSdIaXgEr35yJ0d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2tPhwrtp7dIihAVhtioXSL2vC+6m3ydExrHxr71FySqN5rrPh1RJGgjVhzywTe3CKLSV31HOI0he6ezEZjifPwiLvt21/IIuE1M0nr1rH/EQUR2mJ3I4QpOCspoddBFQ6scQFyJugVjcwmJgVue5sOkXuAQH7U+CZbWOLs27VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XxpUJ52f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5841dDFW003604
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 02:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UqDA79vMuQ4DioUE8hancjBP
	t/X6lnrlS8udMgPwyC4=; b=XxpUJ52fovBMOcvGzxoFCaL4Ohs8e6Fe5+id3dKW
	86M1mZdhiZPYEak4mTHcUmJDAnr/5Ja48YnpdAjqlxO927h/MyuNmhU2ZA0TuhQc
	Uf63oew1YSVi84L+sJ1BhpygvuYIM25U+a9Grj/ZchhrwahYPh9Ac665IaK12Ian
	9UOcpCybB8mnqo/gNgUSi8B6oJQJgJhVWqm215j3dx6h8E7Lc0gMwfa/V5tVtGan
	HOrzAf/ZQFeblPUjGDaUhbPX41G3X/bxP5twah3x6tB2MfF4WwIPzbGUa2R3KhaI
	SU9sIXSNHQVkj511Ognmwfy3qxO+krWzAQs/tAzQMZD5vw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8wrj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 02:22:01 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b4980c96c3so18270201cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756952521; x=1757557321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqDA79vMuQ4DioUE8hancjBPt/X6lnrlS8udMgPwyC4=;
        b=SD35NB0MVJCJ/hQb/llBr0Bbo+Yl47Rtm/ZPCZm9hGEJqgpeAEW6tocpm2pPgcJtLW
         LWcblmC9zNjntIP58UcassBdaUeLvzI3eaxn8bHXCmgiLKWyvj7TNi8yaD7syMxU8TaH
         P/+vSxI1yr2BmsvVZJ1DkXapUMzB44udawPlZIK3IIEecRtPar8/r4edjVYa3qmeiRuq
         SS8cVGLcz0oK9Q9d2FOnX7MNn8RuyIxJcgS/9HEYjTz6MSeX5TGiZvHi6DQiUP2bYrc7
         zcGcxCYIOx0pICJK9Q9K6fV/8e/l4Z5A0d9Yr/0H9SkN5mXmwniyInHa/PCQRdTm9tL/
         6Y8w==
X-Forwarded-Encrypted: i=1; AJvYcCXimvS8KyZzxGWq1B71s+K//P6xsAJTGkQf8Rnhom3JgwuSR28kWwr3lwGLm2+cvWUasAM/Y1nZEJohtVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHmKP6K27YvI+VQl9bgvcZgBWSKS/YKt/aGjkTtjFothi2fvZS
	LURzd2pwD7C2/ZVPWyjBDEwh7SQgXi/GnuhbX0lgYVItDKSFWpU3Qu27KbP6+dFu9PJJgQQ922A
	a9fAGsMxI6G8ACWGABq8Vjw6dh6fkncAEpt4eraNZFYOJg4fJkahFoKICIz4vMy/GVVM=
X-Gm-Gg: ASbGncvtDu0ubxQo8JXXFdIx5NI+feWtkEFSh25bHbTw/vebGoC0RvoqOVzKoyeqWSJ
	IgmTi8+HJv67w/8sZfPgYgBI8UR5hQRLNF25rcL2Psx8EWaSx2wqUCFYvfo2w+svFPDcHOLLQCF
	2BeYravjjruomG8KlJaarRYLTVY2P7aSqOFHkzmZmuGLcW3QXM9qV5uRpgMeGQo1enEWnbYQ7zA
	Hg/DSTlrBY5K0eRf/4rl7rQs7XGqEyQsWzydfUrWt0eI8GKEoNnCgsCn0JYAo8SIMdOUD0iLEwz
	9OZYQwmiRHhYVJlYTnZG5B5oHGCi7hjMIa9BsOw7Wm43+Y37K9nvVOwnalYgHwUDLKfFAmhX6Cv
	UWAk2w5RyYFMCWl+BlE8HuP3jCgrpG0wsB7tZHEvC191Wn8Je8SPA
X-Received: by 2002:a05:622a:8c9:b0:4b2:8ac5:27c4 with SMTP id d75a77b69052e-4b31dd7ab57mr235391611cf.79.1756952520691;
        Wed, 03 Sep 2025 19:22:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTGQK4o8JOfJXm8YdRgThRFbgc3hvhYcbAu5TkwFenQldv2fSoa+WwUY/vg70G3SHonyTuLw==
X-Received: by 2002:a05:622a:8c9:b0:4b2:8ac5:27c4 with SMTP id d75a77b69052e-4b31dd7ab57mr235391361cf.79.1756952520189;
        Wed, 03 Sep 2025 19:22:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad5027esm880943e87.149.2025.09.03.19.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 19:21:59 -0700 (PDT)
Date: Thu, 4 Sep 2025 05:21:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: syyang <syyang@lontium.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        yangsunyun1993@gmail.com
Subject: Re: [PATCH v1 1/2] This patch adds a new device tree binding
 documentation.
Message-ID: <lcyori44rm5p35wykk2rb54zbrrpft5c7uibi376jihemkb67w@px3nj72a5hx4>
References: <20250903123825.1721443-1-syyang@lontium.com>
 <20250903123825.1721443-2-syyang@lontium.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903123825.1721443-2-syyang@lontium.com>
X-Proofpoint-ORIG-GUID: UONJ_OgPWwsM4zTZazy8jQKlzBwtsE6X
X-Proofpoint-GUID: UONJ_OgPWwsM4zTZazy8jQKlzBwtsE6X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX3oBFZI+EcDYe
 2QbHNEQP8/2Eo2q2fmJxnqqf0YKh8NddCniRMM618FpXrojFMxM9J1zNHa1Z56ViUWSwSIeA6a8
 yYnzqJLSRHFlnYlmTYZwDa9uY6U0bLnIsQ+ryhGG+KNbeic5GnGJ/Ls/Cy0+2YRxSOMrT9w+uAF
 y0Mqb/xpsIPkalvm1NrJGEgMguLKyCiOJf1gwUuwlZX0Isa5/oMIaU84S1iXkU2azTHkkO+F77o
 3yuMIW684ma8pEM0cK6BjR0BwuOeV7rMDw5gviLUtPD45hcJ1k5aSTJ63SOgpCdjpp8dul6Nz+0
 Al3D2M+/bLGud4G3WQab9nTIJx9Yvz9ICXIbFFkMvgy7WDXm4Vd+FyJKUp2l+EziBbkigBemj4x
 USh8P3jX
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b8f7c9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=gEfo2CItAAAA:8 a=Kz8-B0t5AAAA:8 a=VwQbUJbxAAAA:8
 a=zoi4mhQgz1elOlvs71MA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

On Wed, Sep 03, 2025 at 05:38:24AM -0700, syyang wrote:
> - New device tree binding documentation at
>   Documentation/devicetree/bindings/display/bridge/lontium,lt9611c.yaml
> 
> Signed-off-by: syyang <syyang@lontium.com>

Please fix your Git setup and use your full name in SoB tag and author
metadata.

> ---
>  .../display/bridge/lontium,lt9611c.yaml       | 123 ++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt9611c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611c.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611c.yaml
> new file mode 100644
> index 000000000000..e8f204c71a95
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611c.yaml
> @@ -0,0 +1,123 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/lontium,lt9611.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lontium LT9611C 2 Port MIPI to HDMI Bridge
> +
> +maintainers:
> +  - Rob Herring <robh@kernel.org>

Are you sure?

> +
> +description: |
> +  The LT9611C are bridge devices which convert DSI to HDMI

Can't you extend the existing lontium,lt9611.yaml?

> +
> +properties:
> +  compatible:
> +    enum:
> +      - lontium,lt9611c
> +      - lontium,lt9611uxd



> +
> +  reg:
> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO connected to active high RESET pin.
> +
> +  vdd-supply:
> +    description: Regulator for 1.2V MIPI phy power.
> +
> +  vcc-supply:
> +    description: Regulator for 3.3V IO power.
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Primary MIPI port-1 for MIPI input
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Additional MIPI port-2 for MIPI input, used in combination
> +          with primary MIPI port-1 to drive higher resolution displays
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          HDMI port for HDMI output
> +
> +    required:
> +      - port@0
> +      - port@2

All of this totally looks like lontium,lt9611.yaml, except the
vdd-supply voltage difference.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - vdd-supply
> +  - vcc-supply
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c10 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      hdmi-bridge@41 {
> +        compatible = "lontium,lt9611c";
> +        reg = <0x41>;
> +        #sound-dai-cells = <0>;
> +        interrupts-extended = <&pio 128 GPIO_ACTIVE_HIGH>;
> +        reset-gpios = <&pio 127 GPIO_ACTIVE_HIGH>;
> +        vdd-supply = <&lt9611_1v2>;
> +        vcc-supply = <&lt9611_3v3>;
> +        dsi-lanes = <4>;
> +        status = "okay";
> +
> +        ports {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          port@0 {
> +            reg = <0>;
> +            lt9611_a: endpoint {
> +              remote-endpoint = <&dsi0_out>;
> +            };
> +          };
> +
> +          port@1 {
> +            reg = <1>;
> +            lt9611_b: endpoint {
> +              remote-endpoint = <&dsi1_out>;
> +            };
> +          };
> +
> +          port@2 {
> +            reg = <2>;
> +            lt9611_out: endpoint {
> +              remote-endpoint = <&hdmi_con>;
> +            };
> +          };
> +        };
> +      };
> +    };
> +
> +...
> +
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

