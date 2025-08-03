Return-Path: <linux-kernel+bounces-754407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFDDB193F5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 14:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617201740DE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 12:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A27256C76;
	Sun,  3 Aug 2025 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UoAwCYqN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691841C2334
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 12:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754222562; cv=none; b=OL8ii9WwEKNGCpwaq68oWYYjHoULr8D/cZAxESJpTsIQa1ZMGnaM2Sg+6A5cPR44OHibIPqgbdc7Rfz0Qq9vONeSfXVpGvhaCTGUmqIZEchCBPCQQbDnp5cJfnUyN2odEECwVbid4sStTpaK33nTQiLJ/GEvOyo9KjXvijAtS0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754222562; c=relaxed/simple;
	bh=rIIsdZo9bx84ccBW5XwB+HawBjCbdC2KsnxHuXVbbTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxzxkMWAIUWd7P4RXd9c11NkrZPwGl0OKDpVuErHbc13Hq2LzYpumz3kdJQZMOnS9PBj4PulUIowQI8VS7RAdQYv7O87NZVbQKB5C/edQjSxNfCTFPafldcgycugf5d7a5iX5aHOchVRW5KDn2SQ01d2sxUsk+56YvttV0UrRT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UoAwCYqN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573BlMfS019608
	for <linux-kernel@vger.kernel.org>; Sun, 3 Aug 2025 12:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OAIGfqwm1o5Mxl29tN5H4C7B
	Htx7NSCXZqC99JGU7eI=; b=UoAwCYqNVz+9KHfbgfwKHh+zOOj9uO5Yj+TBBC4x
	jp2ILH++Xeh95sGJ/+pPmfjOj5hmt37MLz1AqybQfAtmEKaypcLMIbEwMCDoVoJv
	TC892PjvlGXBTcgh8QFmboJdsqfj1VWW+1MySIPs4Jz9uR7IkoUPgRMsZhMIL0GR
	cgLPEpo+jmgkOjEoaXUmbXe4u6NcUXVKWDrKcHT6SlJdpjreeU7xMUfgsVxoIAFi
	vZoRfRHAVLbw4RowLrsw/w9eGDZAU56S0LZW0t7PSX5ZJUubWw0mb2bezyz+pGtk
	OVZyNZ8BjmAxD98fywj8cbPZ+LMqbsDK0OrMjDLhzhdoHg==
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489byc259c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 12:02:40 +0000 (GMT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e410d87893so21658175ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 05:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754222559; x=1754827359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAIGfqwm1o5Mxl29tN5H4C7BHtx7NSCXZqC99JGU7eI=;
        b=HRLVAiolwLfXjwABf25kheDsIdmYGgzGMp6PYKsb4ZgAY6IdLaImFwS5DOW3A2kAGw
         nfto2wtHWu0BujFn9s/fmFqPl6gaCf05DYk0di/EtP6EgujBp2XEqSyv7XDmDM0QAvdr
         EJG1u1NWxWcbjcvvauLjXI0MNoWaTFN3ce6WoTV4NcDJZjoyA3UIa0TTicF7MHlKxXLk
         z8XIzyzIBjluJLFDoVxc6oQwV85moz1nHXVD12o/YAlR73LHUuTZt0Lkdt5/Cwi9bEuu
         VJK7Vr/yKqTziN879ldHL/5/fHiheky0ZMzTxGCF9k5krpV9G1OVc/odhbZGFKMEdESo
         nE4g==
X-Forwarded-Encrypted: i=1; AJvYcCULOuLhEC8p29/iM9S9Y81b2hjBm/6avA6xucGrZzGHDilWVuWNwlY1pekJmIF5bt/2L5lIkyXkq5pBvn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7p8nMjqJzhrp8mGUmtL+1OzpnDPsFEz7t4oqq5tqAcjOrkFCd
	Yh+Boht0yRilefw9wK68aPIsj2tbsSkU/1g49USepSpu1a+BGTMvPFp2prQ2vzYSz488ABHpYC/
	txj35mTZj8nZUx/VtexhpcX+JJu3cASJwczLMMRK4zQf1xnTCdAiX02r5S6SeWecI1m4=
X-Gm-Gg: ASbGncsiKwKhDtQjyjTC7jnIRWD0i1+HLkghDnmEvrQAJsHyuIUSWw1FFfFjhUalxx7
	81tEmJffKohEUCTPTpr+dw8vcllMPUiFCLT08CmE/cDMyO198O3AvkL8i/wIemrVAMxf0dDqpzw
	T/E15MMu4zeAir8xeDMLpqituuNA1eoSWj6mtjepQ0ABjjFc3OzQsyEBQQF7R2VJ/sJ3MEyRv0a
	S1Fd9rxy0RJuMzrqBYWIj99raT0jKpENv5fjNBVJOpc1d/+KDeP2WNCHEjbPWQlULMEaTHax1GF
	qeNZZUu3+69b8+E3QbjXFg7h6twwYX+kRj9Nu5d6w9sUlCnMraqFvzAJ3a1yrDsnP0JYUHOpjgp
	ewbws93EHjviWChy2NsfwsSGvwslowwIWIVu8z0RWPk73eHFwPR2C
X-Received: by 2002:a92:cda6:0:b0:3e2:a8d7:cbc0 with SMTP id e9e14a558f8ab-3e41610d612mr112393445ab.2.1754222559505;
        Sun, 03 Aug 2025 05:02:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYUIi9fxAQlndkvIQvqoHMofxn9K2oksFY/TXCUKLTtpvW3PxnZKP0cFdXI+rxl6CDCEMupg==
X-Received: by 2002:a92:cda6:0:b0:3e2:a8d7:cbc0 with SMTP id e9e14a558f8ab-3e41610d612mr112392925ab.2.1754222559083;
        Sun, 03 Aug 2025 05:02:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898beb4sm1288955e87.30.2025.08.03.05.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 05:02:38 -0700 (PDT)
Date: Sun, 3 Aug 2025 15:02:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: display: panel: document Synaptics
 TDDI panel
Message-ID: <7rk5cgjiublkrczl6khkjepixppbatee25w6gc5utfvrcl45o7@6oouraafet2f>
References: <20250720-panel-synaptics-tddi-v3-0-43a5957f4b24@disroot.org>
 <20250720-panel-synaptics-tddi-v3-1-43a5957f4b24@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720-panel-synaptics-tddi-v3-1-43a5957f4b24@disroot.org>
X-Proofpoint-ORIG-GUID: D1Z-FG1ybUjRrwZiFb20BaK6bWDno-3I
X-Authority-Analysis: v=2.4 cv=Y6D4sgeN c=1 sm=1 tr=0 ts=688f4fe0 cx=c_pps
 a=i7ujPs/ZFudY1OxzqguLDw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=LpNgXrTXAAAA:8 a=ui9BxCMBW18_jymSI_0A:9
 a=CjuIK1q_8ugA:10 a=Ti5FldxQo0BAkOmdeC3H:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=LqOpv0_-CX5VL_7kjZO3:22
X-Proofpoint-GUID: D1Z-FG1ybUjRrwZiFb20BaK6bWDno-3I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAzMDA4MiBTYWx0ZWRfX/JePdADQGf3U
 2y2TZXMERzXM5yoK3twvlTO3t2dAeDaKhpJdkLbQvFfQYn2cF/rbyEUbpvDyy/V1UrRuiBozlrg
 PSrT+ljPJTwMndcUmxrGoi3e6K/xVcCfzyhXXfv4Ois6jva9PlaX0SHPI6g8VWKGhL2ycZ+6PNY
 sZg8QRk4Lh/ciTnvaVGAXcfnIg1eyv+ClmQz1ttPjvRSLRZvii9TqYPljf478UaKsZjRJ6qW+Lb
 8pWFul4x73ORD50zOfl9vHcfgNcKvjZPx8DRn3F9p9rjwpM6MWMIGcdK+9JoglnyhR+mv1VkHde
 wVjVpd+Vh3Z5Aq5l8qOxdoeOKSaTDHp0utZs0FSo1DYP8cfs6/0zEHnX2Y10RpZIU/4w6PhJS1Z
 r4aW1X4bP1heGgZO1exJ2rcjTASdRoYDKP8UapqOZy5d9HkwQMBpqR7MxWD4HzRgtxPbk9zn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-03_03,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508030082

On Sun, Jul 20, 2025 at 05:31:54PM +0530, Kaustabh Chakraborty wrote:
> Document the Synaptics TDDI (Touch/Display Integration) panel hardware.
> Along with the MIPI-DSI panel, these devices also have an in-built LED
> backlight device and a touchscreen, all packed together in a single chip.
> 
> Also, add compatibles for supported panels - TD4101 and TD4300. Both
> have the '-panel' suffix so as to remove any ambiguity between the panel
> and touchscreen chips.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  .../display/panel/synaptics,td4300-panel.yaml      | 89 ++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/synaptics,td4300-panel.yaml b/Documentation/devicetree/bindings/display/panel/synaptics,td4300-panel.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..152d94367130e9d80a885fe87a2da53db88e3393
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/synaptics,td4300-panel.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/synaptics,td4300-panel.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synaptics TDDI Display Panel Controller
> +
> +maintainers:
> +  - Kaustabh Chakraborty <kauschluss@disroot.org>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - syna,td4101-panel
> +      - syna,td4300-panel
> +
> +  reg:
> +    maxItems: 1
> +
> +  vio-supply:
> +    description: core I/O voltage supply
> +
> +  vsn-supply:
> +    description: negative voltage supply for analog circuits
> +
> +  vsp-supply:
> +    description: positive voltage supply for analog circuits
> +
> +  backlight-gpios:
> +    maxItems: 1
> +    description: backlight enable GPIO
> +
> +  reset-gpios: true
> +  width-mm: true
> +  height-mm: true
> +  panel-timing: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - width-mm
> +  - height-mm
> +  - panel-timing
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "syna,td4300-panel";
> +            reg = <0>;
> +
> +            vio-supply = <&panel_vio_reg>;
> +            vsn-supply = <&panel_vsn_reg>;
> +            vsp-supply = <&panel_vsp_reg>;
> +
> +            backlight-gpios = <&gpd3 5 GPIO_ACTIVE_LOW>;
> +            reset-gpios = <&gpd3 4 GPIO_ACTIVE_LOW>;
> +
> +            width-mm = <68>;
> +            height-mm = <121>;
> +
> +            panel-timing {

Are the timings defined by the 'TD4300' name or might there be different
panels with the same name but different timings?

> +                clock-frequency = <144389520>;
> +
> +                hactive = <1080>;
> +                hsync-len = <4>;
> +                hfront-porch = <120>;
> +                hback-porch = <32>;
> +
> +                vactive = <1920>;
> +                vsync-len = <2>;
> +                vfront-porch = <21>;
> +                vback-porch = <4>;
> +            };
> +        };
> +    };
> +
> +...
> 
> -- 
> 2.50.0
> 

-- 
With best wishes
Dmitry

