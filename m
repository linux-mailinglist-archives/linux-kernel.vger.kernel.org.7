Return-Path: <linux-kernel+bounces-789996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E812FB39DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE80189BC50
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B25530F801;
	Thu, 28 Aug 2025 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HnScte/N"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0320E30FC2B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386111; cv=none; b=plbEoEryNXMUUfX0/rlgoXGjQvlYBxhip2OhlUgrg8FTqzaTNHTqIewF5wZZgi3ozanvGGJ0pcXzWcU64D4SsFMoD+d1pKrLwnemasXvKrBL5o+kqCVRXUeMAM3ZGR+ibSupR+Iga2GLHFCtY290R6YF7FUnMgzAEjgQM8C7ekI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386111; c=relaxed/simple;
	bh=JkEwQN7Qqs2DkofIqMEeUie8muwYrzT0MREW+qZ8yfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPYwBhUN8UKDtetT5XrK3CtqHUAROo7LbNtnTW3waNAohLf8vaW3ldTeGLszJqZAGROhx8TXpsVC3mPzQw6XSikFJe3qeMBV/hw4A1og0YxSCw8RoUWns9HyYN5rSPhdp2lwVh6b3silcy6pM/Yi8kEjET5B8n08d+Vggvp81/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HnScte/N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S9mS2i021398
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5CZZ8X3dGi+2A49GmpGXcrIf
	DqXJjy/8a+FZlDsA/mA=; b=HnScte/Nm4g2E1pWdO3edn+PiJgSlJNqP/Hm/qGl
	oE1Ql+ov3n/D3q+StH+uoJ3e4XHuT6EUEd+BCiXFtcnGlBUB+SW8F34Ohl6xY8fU
	SXGy4zAbz1af73frbMsgJqOhDsjYHbK4BMjsktYv8HFiDEg2Nge+UaLD7kIYCL6z
	LaxS6ytGysb6Y0quNN2sQzL4dxJh6shJ+c8K2/gbarlGtlvnjxrvrOBMP3nRbMpM
	RuVaN+0XLaDgU9qHQTRR+dCikydc2Tl0IMvJ5ntZX2c2p/gPcWt6RHSTxxxh6PCW
	vM5Bcmv6uW8vvEGicG4qq0/xKLc4L4l62K6SdJXfoB0uSw==
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5we7yq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:01:48 +0000 (GMT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ecbbe7dc63so9485475ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386107; x=1756990907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CZZ8X3dGi+2A49GmpGXcrIfDqXJjy/8a+FZlDsA/mA=;
        b=LHiiz3hkvplGkyLQx0//QqiWFCbyEvKqvGV2MpT8/+3X7NBKiq0RixnRIeTxo8Qr7f
         PfzeTxXy3hFZXZ0ukCWs4w/eA+0+0i0yjLNlvvKHSTma61xmcrAJjY93MXBmLZ420nNH
         tXGhztQgTynOmWDsKwPrch+o4ldupNMCiVLWqVcN8iDwfKWCK+3uc+PpFBJh7VwkVJ7j
         1872IHVwXa6mIo3inQ8E6FR7kGSZfpZPKnQOBTXsIObj9OtB2FrxH20gUkNfQ1aMR5S6
         qbn7+7PeNGANANdbKZRAKe0qlsyK+0R4do2crs3+VDVW7CJvzGzYGysZrYdFOp/UcH1H
         QAzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs4re8Y4XAoFhglw8UrC4UKNQCACgPXlW4znhjHYr/CwVByfIlQK7XruqZX2DX7JuxQPC+bfz2yuPI6vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjqEwJvB09QN04on9GeSlpJlMRUjAdZkJw33R9gGsT61p7Sb8u
	Iadj7zMRuifAhoTc4zIxX5OFPxksIOQMrnkDmIFIw6o7uC+d2n5plAwYKRZEF0QMkjoNHI+74f9
	8ZUfoIQ9NGiptRhIkMpsoq1hhE6KRcaNLpgL5/J7EG11mI5MVz8rBAgehahbjcRWPHgc=
X-Gm-Gg: ASbGncsd+fyNdcRUSu3dmsf9RjsmuiQRsufxQvCuOakNBuFFdsNL+KEyubZlZhDBn3F
	AydjcIDbTSv/pdic1acnAWmBzEpJe7lZPRYEx+D5KGVIygrKzx+2x/CKeWYhUtg1feujn9fZ4fY
	+OPm4WtSusIaMSVBheS4geGZH0+QMAaM+VXxcoxZ23DntAL2GTmav5hlM6xdBeBqsQHB+ppDuo7
	aFHnVxEsaUaM8jqkgGzass/IGZ/3R++NZOSZLPDK//6K5gbwhAl52wkSATHGzcs4a2TaKUIVMYH
	IuX6Dx8b57jDhqmy0AXU1SoAtlqNkeEV0tGXP7LHkXXKaaw3oHZvWsH32p+gQrnflqTLVxzqjJE
	YZ59433GoIEZNkhzxK4y47t5bCsOOtkHCNpxzokSOGW6HxbTbmTec
X-Received: by 2002:a92:cd84:0:b0:3f2:1184:74c with SMTP id e9e14a558f8ab-3f2118408a6mr9220275ab.1.1756386107159;
        Thu, 28 Aug 2025 06:01:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoWgR1m6SPJJT8N1upZ5xl2y0n4EmbtRhWcPx9TkfaLMRgVUMGH92IrxU2E0pOWKzIMyNT0Q==
X-Received: by 2002:a92:cd84:0:b0:3f2:1184:74c with SMTP id e9e14a558f8ab-3f2118408a6mr9219445ab.1.1756386106532;
        Thu, 28 Aug 2025 06:01:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e20ed53sm33236101fa.4.2025.08.28.06.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:01:44 -0700 (PDT)
Date: Thu, 28 Aug 2025 16:01:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Pet Weng <pet.weng@ite.com.tw>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hermes Wu <hermes.Wu@ite.com.tw>,
        Kenneth Hung <kenneth.Hung@ite.com.tw>,
        Pin-yen Lin <treapking@google.com>
Subject: Re: [PATCH v2 1/3] dt-binding: display: Add ITE IT61620 MIPI DSI to
 HDMI bridge
Message-ID: <w4esyqbwash5izcdbu476xtvi7dom4o7xbj6c5vk7jdpokfsxk@pxnseqmu2rvw>
References: <20250828-it61620-0714-v2-0-586f5934d5f8@ite.com.tw>
 <20250828-it61620-0714-v2-1-586f5934d5f8@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-it61620-0714-v2-1-586f5934d5f8@ite.com.tw>
X-Proofpoint-GUID: dMi4kxkNRzjdZKtweOaGnsqWPqN5wOw_
X-Proofpoint-ORIG-GUID: dMi4kxkNRzjdZKtweOaGnsqWPqN5wOw_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX/ST3FvOzxDwv
 MamvLum3vJwtwI7PHFt+kp8FAGS/f0kbuEIvi/pJZJHb6NMztY916UNdOtciuVehZh2ZTBO8HmC
 Tb9eUcD9HJeJY2z8mCSGbLdAeFtP/EQrLit+AUMnOKEKvUYs/50yl9EkCsVoHRP04TkklOQD392
 elZv8qMBVjORe02N2Zec9Km0IkJrB+hWH11x1nVnfrHwehiirRabZDf+031ZeNW1reA4Z47Ii41
 XhEnrgYOizrDy0sovFEGXHAtmUG6PxnHzHz+2GBnBzeIrfM2Z0MVfAr5cJ7BsDZYGnR6185XJpA
 8a8cuJqRwF5fIjlMZzpjLbKSq+KMNPeavEKHwO6g4cLtfTKC5uKUmgH44t7xxXT+LtmxbT17KHD
 X5k3q6W4
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68b0533c cx=c_pps
 a=5fI0PjkolUL5rJELGcJ+0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=Ns9eNvu6AAAA:8 a=95iR6gA1d2zzZcfHCfgA:9
 a=CjuIK1q_8ugA:10 a=HaQ4K6lYObfyUnnIi04v:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=LZLx1i01EnjtqRv10NxV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033

On Thu, Aug 28, 2025 at 12:01:18PM +0800, Pet Weng wrote:
> This chip receives MIPI DSI input and outputs HDMI, and is commonly
> connected to SoCs via I2C and DSI.
> 
> Signed-off-by: Pet Weng <pet.weng@ite.com.tw>
> ---
>  .../bindings/display/bridge/ite,it61620.yaml       | 143 +++++++++++++++++++++
>  1 file changed, 143 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it61620.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it61620.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..dd8a54a1e0aa9bbbd9d02e68398bb5df65b821a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it61620.yaml
> @@ -0,0 +1,143 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/ite,it61620.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ITE IT61620 MIPI DSI to HDMI Bridge
> +
> +maintainers:
> +  - Pet Weng <pet.weng@ite.com.tw>
> +
> +description: |
> +  The ITE IT61620 is a high-performance, low-power HDMI bridge that converts
> +  MIPI DSI input to HDMI 1.4b TMDS output. It supports up to 4 lanes of MIPI
> +  D-PHY 2.0 input at 2.5Gbps per lane (10Gbps total), compatible with DSI-2 v2.0.
> +
> +  The HDMI transmitter side supports up to 4Kx2K@30Hz resolutions, and is
> +  compliant with HDMI 1.4b and HDCP 1.4.
> +
> +  For audio, the IT61620 supports up to 8-channel LPCM via I2S (multi-line or
> +  TDM mode), with optional S/PDIF or DSD (for SACD). It supports audio
> +  sampling rates up to 192kHz.
> +
> +allOf:
> +  - $ref: /schemas/sound/dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: ite,it61620
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description: interrupt specifier of INT pin
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO specifier of RESET pin
> +
> +  ivdd-supply:
> +    description: core voltage
> +
> +  ovdd-supply:
> +    description: I/O voltage
> +
> +  ovdd1833-supply:
> +    description: flexible I/O votage
> +
> +  pinctrl-names:
> +    items:
> +      - const: default
> +
> +  pinctrl-0:
> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: Input port for MIPI DSI
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              data-lanes: true
> +
> +            required:
> +              - data-lanes
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Output port for HDMI output


No audio port?

> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - reset-gpios
> +  - ivdd-supply
> +  - ovdd-supply
> +  - ovdd1833-supply
> +  - ports
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ite61620@58 {
> +                compatible = "ite,it61620";
> +                reg = <0x58>;
> +                #sound-dai-cells = <0>;
> +                interrupt-parent = <&pio>;
> +                interrupts = <128 IRQ_TYPE_LEVEL_LOW>;
> +                pinctrl-names = "default";
> +                pinctrl-0 = <&it61620_pins>;
> +                reset-gpios = <&pio 127 GPIO_ACTIVE_LOW>;
> +                ivdd-supply = <&pp1000_hdmi_x>;
> +                ovdd-supply = <&pp3300_vio28_x>;
> +                ovdd1833-supply = <&pp1800_vcamio_x>;
> +
> +                ports {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +
> +                        port@0 {
> +                                reg = <0>;
> +                                it61620_dsi_in: endpoint {
> +                                        data-lanes = <0 1 2 3>;
> +                                        remote-endpoint = <&dsi_out>;
> +                                };
> +                        };
> +
> +                        port@1 {
> +                                reg = <1>;
> +                                it61620_hdmi_out: endpoint {
> +                                        remote-endpoint = <&hdmi_connector_in>;
> +                                };
> +                        };
> +                };
> +        };
> +    };
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

