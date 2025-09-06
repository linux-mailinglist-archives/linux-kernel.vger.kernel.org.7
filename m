Return-Path: <linux-kernel+bounces-804436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAF5B476E2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 21:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB15C585E8E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 19:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91637288525;
	Sat,  6 Sep 2025 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DdPwKsIY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6B21A76B1
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757186701; cv=none; b=beEhHDr8pjAb86iAxngSt9To8cESuWnv97AOocvh8qdXWDKYXu0+STspQt+IdBWGCln1o5QCNeo7g5gU6fQ5WSW9MpvQV2XjgANi6pn+noXFYoW60LQXVlNEsbyxcx2wUOAtimcVPoARMGC2AoeCt1RAto+dDQ0U2qimMUl2ni8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757186701; c=relaxed/simple;
	bh=TO9sUdIq0PpuxZrYE9cAwhgg0k63LhZG8aXeiXUCBZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABEBnjtatzYYgQQ53Fpz3C16DGKne51zu5d67WS2lY4ywUlVJV5MZg8S1/nTYcfGQK30Mw2dCiYubZjEq8FVKQMQszeF9dyGhgHJSwImsUBIlmZwsNFhcC+RAXjlw2LFzcEJQEOvUKAqLckKBihZZs5/B70mVxB7sOU9YM5Retk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DdPwKsIY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 586HPPOd016843
	for <linux-kernel@vger.kernel.org>; Sat, 6 Sep 2025 19:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MTEK0pkDHJjciIVxHN9OmhQI
	NcjLjs9n3rxGq729tTE=; b=DdPwKsIYMWvg8x8N76/OFmxu4st7+i6Xm7nNHoSw
	xxhOS07Bd2FmXKrePMmNQYdbHYKjQoPCG3umm6WMnxbKVxSwvf75vSmEh/gnQgDt
	cGcN5iQf5KAl/fIsxs+Bt54Nv5Fn4wB/CCns3U9e7jfMq1WvIsOOADJz1WBk6T+a
	tdm3OwCm3rhaL1SMvkjAEhPrSdyXbEsmgn/ug47MTLMBZ4magi4oHWuETK7yLL4k
	uibp/5MTko3mD+NBYFBhLiONtePX0VgTV/nrDBHST/kZ4USRH1LLyJoutVDJe97V
	HrcemKRKeA56msJcbfWqZ4SC6mdRryL5cWZJr+AOOnkc5Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db892vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 19:24:58 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-72631c2c2f7so69400086d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 12:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757186698; x=1757791498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTEK0pkDHJjciIVxHN9OmhQINcjLjs9n3rxGq729tTE=;
        b=I25lKvwctkYv/X9Te0e2MK4FkCWJZ1sC5XVf25NyQHLhscd7jTCyqmjn0prtxEO4e5
         Jqq8QcI/4bRSM/1RSFrzQQMKHDYkB/RTVVbeN8Wfqz651cP7vv49xopJo/TAa9BxmpBx
         nySKgFJ//D3OaFllZ0J8SOP5FVoc4uBtfUr//LbaZ5/x3W706BQDNduFhdEeQCDd/J3H
         B2chlLInov4WpJPP3/5l59ylFrxVioMloBAbN/gS5vaLChQ9qExo4AXK3QC4Di5Bx7ue
         jPnOw1lulgBVxrEUWcjWFaGzlBoYrAQDfFNs+Pz7D0TcvI8esN6xnmlR0Z7uXehqG+lu
         OSzg==
X-Forwarded-Encrypted: i=1; AJvYcCVXTNXxSHYLVgQyB6ZaRuZTgi4eVKJ0Ze0XcjfR6EHDgAVG9vOBWm+IH3HwOzXsOZhhrXF0e/addhWqQRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6X0/33bOn/i1UAuXuu8Ksfb6DuBqhdJZrmtp+bCGDynCHqkvp
	c2SoOQxMg/CzlSPjjhn1jCzOx2lpLQRFdjkkYS0dgCASz6AinscyuZHZSkYnRi1X3QiI9dTgNwa
	d+lJTzj8fmr3CnO0aOjLsJ/0lPNWVuinFAJwa9EzRR9FRSVr2sc86vpr7pCCmxHCgldQ=
X-Gm-Gg: ASbGncuHjaZsF3XVmyumMjImMHkIJ/hzAp90EtORjNd8hYhcnN7Jcz9LvubXmMv0Nx3
	u+UhTvolCoEJBrxZ7GWrMnWGxOnOPSy51qgEY/hGDe2tpjk6Ox4M+D3qZndmRzWASAR3r4XP5Vx
	v/8MLHjRfTBTWH0T31cPwVcSdWhCrOoufJNdb2B1VUnHWn8BZzYpQa32XW2vMGVGF/dtJqFdaBy
	k0PuEuF9/umTCUpAyDGb2d3WIp8ffp7SCHeGn6EqB+mcm6d3zRkwBw1fO0/GZVQub9KbQBfy6IL
	yu5rG74bVf9tGC2bkJYtqYzSALOj1sXaCwcVvax5FbPBNxvcZNIW/2cUNEadyenJSLnLmTmOQuA
	R3IK+IKk1WReF6exW/mvoduRyHY8kXqUOdpbQbTamnIrAQN0R4/7e
X-Received: by 2002:ad4:5f07:0:b0:728:4af1:e4f9 with SMTP id 6a1803df08f44-739435cf288mr38553336d6.47.1757186698197;
        Sat, 06 Sep 2025 12:24:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrz7N2428ImzsvEUQElMBkqhCweROuKesIV1+3pYGl1R0oId7O3XdYr9aAYzNEBMgDXflUUA==
X-Received: by 2002:ad4:5f07:0:b0:728:4af1:e4f9 with SMTP id 6a1803df08f44-739435cf288mr38553016d6.47.1757186697694;
        Sat, 06 Sep 2025 12:24:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfd2ffsm2500187e87.107.2025.09.06.12.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 12:24:56 -0700 (PDT)
Date: Sat, 6 Sep 2025 22:24:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Frank Wang <frank.wang@rock-chips.com>,
        Zhang Yubing <yubing.zhang@rock-chips.com>,
        Andy Yan <andyshrk@163.com>,
        Maud Spierings <maud_spierings@hotmail.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] dt-bindings: phy: rockchip-usbdp: add improved
 ports scheme
Message-ID: <aLyKhngeksG2SKdq@umbar.lan>
References: <20250904-rock5b-dp-alt-mode-v1-0-23df726b31ce@collabora.com>
 <20250904-rock5b-dp-alt-mode-v1-1-23df726b31ce@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-rock5b-dp-alt-mode-v1-1-23df726b31ce@collabora.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX0lNwL6Z0DyN4
 3UlJE3PF93qx6PtZetHA0vyRagV5dDjFEudVEYHbc7LsMHHZI/cx/zuHyBzVXi2CpW5sF0q6phQ
 XFhvG/5edjwack8EusIl+YwJPZMMBbTEU3OCMWKhTZxQRCMp4FlFGTV+lK4lHZxD4DLhlapl7B2
 HJtL5dmAhahax02UuUd1Z65/OT66f81sKhX4Y+zgW9CGVcbgeEb+VVztVZf9r94aJMEXA3vhK52
 VkiGCdFauRibYj85I4dPyQ4I4N918qPHBD16S2hPOBy4nG5KNUkDzfOCdW+l0TeU38T93NLt7KM
 A0786zIM+9BTwztQ8TTYrwmA4gZ3T84d+RullZpampf3yGNXtrOvBnTWKKC9y/a4IwQrQojYqWU
 zec8Zuvi
X-Proofpoint-ORIG-GUID: 0cejpn5SObRV5_A-oVY3ies9vCpplP0n
X-Proofpoint-GUID: 0cejpn5SObRV5_A-oVY3ies9vCpplP0n
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68bc8a8a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=JfrnYn6hAAAA:8 a=QX4gbG5DAAAA:8 a=OfM26ny4dbP1suOavW4A:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-06_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

On Thu, Sep 04, 2025 at 08:26:02PM +0200, Sebastian Reichel wrote:
> Currently the Rockchip USBDP PHY as a very simply port scheme: It just
> offers a single port, which is supposed to point towards the connector.
> Usually with 2 endpoints, one for the USB-C superspeed port and one for
> the USB-C SBU port.
> 
> This scheme is not good enough to properly handle DP AltMode, so add
> a new scheme, which has separate ports for everything. This has been
> modelled after the Qualcomm QMP USB4-USB3-DP PHY controller binding
> with a slight difference that there is an additional port for the
> USB-C SBU port as the Rockchip USB-DP PHY also contains the mux.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/phy/phy-rockchip-usbdp.yaml           | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> index 8b7059d5b1826fdec5170cf78d6e27f2bd6766bb..f728acf057e4046a4d254ee687af3451f17bcd01 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> @@ -114,6 +114,29 @@ properties:
>        A port node to link the PHY to a TypeC controller for the purpose of
>        handling orientation switching.
>  
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Output endpoint of the PHY for USB (or DP when configured into 4 lane
> +          mode), which should point to the superspeed port of a USB connector.

What abourt USB+DP mode, where each one gets 2 lanes?

> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Incoming endpoint from the USB controller
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Incoming endpoint from the DisplayPort controller
> +
> +      port@3:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Output endpoint of the PHY for DP, which should either point to the
> +          SBU port of a USB-C connector or a DisplayPort connector input port.

I would suggest describing this port as 'DisplayPort AUX signals to be
connected to the SBU port of a USB-C connector (maybe through the
additinal mux, switch or retimer)'. It should not be confused with the
actual DisplayPort signals (as those go through the port@0).

In the Qualcomm world we currently do not describe this link from the
PHY to the gpio-mux or retimer, but I think we will have to do that
soon.

> +
>  required:
>    - compatible
>    - reg
> 
> -- 
> 2.50.1
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

-- 
With best wishes
Dmitry

