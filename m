Return-Path: <linux-kernel+bounces-807974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9268EB4AB77
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C07188C292
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A26032252A;
	Tue,  9 Sep 2025 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xl2FMTZj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947182D5C95
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416573; cv=none; b=P2O30rpN7cFBrMuDYYDeosfOHwhZnI2/WJZOvlAELto51pq30IOYZu2qhgqLuPmB0O4uX58APN9pq/SFfdUlC30iKK5FEp0tJhHlVSPXc5dUehWxRSJMwwQN5E+vFxDZz6oyyQ91jC6TpjaqSdYpISGrsQXgMr7g6XH7vevaphY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416573; c=relaxed/simple;
	bh=47QxSfwF18TUccVBLQZOVylN093Xt6+9xaWLwQDIE9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXnGyBJvUHg6BMx0xLq9Ml2lX6svhls1wMADL/rsszlugEMrOm7lOiBHQ6UpfmCWJ7DNOLVUXn+v25x0kItrdQ6NvNUGcc7bmrDh3C7VMFVRBtsZb3IMvxh3H6kc4QI1dwVT35cRMhstkG97tq8gil5r3VrKeUYDwn7QFEigEg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xl2FMTZj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LmVE024975
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 11:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vyy6UuL4wRzAkGNDFXbY0fdg
	2ceTtxqY7qR0Dof66IU=; b=Xl2FMTZjfPIoZoUT3ZV/L/GYQV5HRjk1ixzGkyUw
	ht/7vZwdNMLyCBbZ/9d6Ab3y8qlh8+GCYdFItSiipkxwJvSA81nuy+4eRDEuVwRy
	iVV8Tcp360raq7haaloVG5zzFn2FbaOHcOEiVmIjn1S1hnvYCr3+2HTiZpEaBVlr
	DddqT4nl6otzuLXOf7U0wV8p3B9oQv0WVBz+BmYrB1nk58rE7u4sbh3fs8WH/XyZ
	sUbZ5GBbLZv++YAEgvPaz3hOSSV7iBRzI2vqXt46KUcIGGsM76/3qVa94iO3XLJM
	M62IjwR92msjwIEac9CRgdU0730+RhGmFwKg76DPMj6+aQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490by901ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 11:16:10 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70fa9206690so110326096d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 04:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757416570; x=1758021370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyy6UuL4wRzAkGNDFXbY0fdg2ceTtxqY7qR0Dof66IU=;
        b=RrskwHsC+1r0moI6Y32Ijwn7jnPt8mPrium+WOWBOSfJefUZtTNodpFg09e5rMmLMD
         xJ77D7cRNUJT38HwloosC4aamPqQ2Z/l85An8KhPjEqDae5sRgckLOVRl3MhjocXn094
         cOSigy37zhk7EBtRcBmxNm+P6/tDG/0l0cFdeU05ovqAYaw4iS+xilxD1WcXB/082958
         WmoeMzcoc08B2+PMdHs81e8P7A3gyhZ1v67HijbmLLaEhNq71qwxsZT0lpasdQKGj5gl
         pplvEN6wLyYIEezzl3KbxZJMVxjgurIV7usMB5g0/VwDRtJAJfY1fFJHiy4dQ5QeimxM
         uvZA==
X-Forwarded-Encrypted: i=1; AJvYcCVgfPmTj+/Xi90yJQCHPbeBOngavPi0TGsvAxiAtINT/xEMXTMJy2R/3Wv1JQkVD5ppMCbRSVnHnBMvij4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNk4JXyTpIzB4Fu/ok3ycIh0y+OlzZTlNwaSViPM2IFcEEaKof
	6te4+2YjukVhOFtiStNPaGcPu1tOAGaD+R7IQAYZCG7ygHfkp1Aw3o4jNSDpIqhUYZskd0nlqKX
	rccTTCPtH5LBTdEWGkCX0gDaBkrGnXVdMLlo92tmngEhwgXnRw8XW3gBOjnsigXY50Q4=
X-Gm-Gg: ASbGnctDJYwvi1amA2W0ggECpSFEZNZF69rDJ1hiVvtAGmdkZf10SGYQKLfPFroBjnW
	T3AKk07WSEMPgrIWDdA/HPLbzbLv9/4w7phNsXmHdlVCJIN3RDmykph8DVZeT4O89XNXLgt3rcN
	zPeHBweG95IVAuZCdM2eNHL1Icxqkh8SWcG42TIvPqbZY25tIU54Fs4it6ivJOLwYHr0SeqFk42
	P6MDTVQAkU+WiSXc0Qs/oHwmEt7xUCkwf3tii+9ibpxBVMO+PbwUW/ONd3/BczKROZ37HbRHKdc
	wXesR/ilr810RJlL09SF1JVE4J5CLJmNvFvnHZZSJU3R187/0Yz+SGosA7PokEvEHEem+PheJfm
	SExHuB1HK45TgIEh9NQmKXyq2PSORNhsEZXP8mMdif2lOyxi1WqSj
X-Received: by 2002:a05:6214:489:b0:72a:87e6:f8d9 with SMTP id 6a1803df08f44-72bbef339e8mr151682386d6.8.1757416569473;
        Tue, 09 Sep 2025 04:16:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY1tTjvV8h2NSrNoZ1Pf5XTkOvg9H6zYxJVAlIs8vECDwJ1Ls71vAHDYTRO2mKRmYsJzgvZQ==
X-Received: by 2002:a05:6214:489:b0:72a:87e6:f8d9 with SMTP id 6a1803df08f44-72bbef339e8mr151682146d6.8.1757416569008;
        Tue, 09 Sep 2025 04:16:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5681795d482sm442455e87.75.2025.09.09.04.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 04:16:08 -0700 (PDT)
Date: Tue, 9 Sep 2025 14:16:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 3/5] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy:
 Document lanes mapping when not using in USB-C complex
Message-ID: <c25kbb65aijgolxjzunydvhupt774pfmbcz5lvfvl5f74rrxtr@vboh347gdvdp>
References: <20250908-topic-x1e80100-hdmi-v3-0-c53b0f2bc2fb@linaro.org>
 <20250908-topic-x1e80100-hdmi-v3-3-c53b0f2bc2fb@linaro.org>
 <7dzfcuvr45h4iailtjutqjev7lofoqu7w6ob77gehgmy7mctpk@k7oob4wj3c7a>
 <14d58c6d-ca20-4349-8031-9906a4539fef@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14d58c6d-ca20-4349-8031-9906a4539fef@linaro.org>
X-Authority-Analysis: v=2.4 cv=Yv8PR5YX c=1 sm=1 tr=0 ts=68c00c7a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=Ywig2pavXv6aIl8GUcoA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: SGVNEiPgOwUWemFeG3V1C4qXb9jVGBdt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX51xH3wPor8kZ
 pazic3OEF1m4u+v9GUtOJG1gc9stz9bW8ePFbmVPJptCH8PSNAX1ac1LGG9Dnetu0sH423MI49b
 9qwF2apYfAH2bidBOzFvywWMKOFg5EUOpdcVZbaI+sPFZCHI/Sx7/l4Qfeh80lRM0Yor4EGXca3
 PDjbtWj1uPeYrot7adzxnNi1EtEMZwRTrMFQ8sYSr24K+Ckbz5HAwaCBlJf+NJwx+yD5j42UsYA
 KVN8ssZDQRU+0z7pCWT6HAzI+9E7aKuC/KAoMYTsZ2nrT71iN21N/9SO4/JuYIh42a9+oJyxtmu
 B1WZxMBkiUrmoFg1R2/Ml30J3xjtobqIhFuexKlR/fZJiJGXNWzWsAlsGzotSeDjOkl5r56xNYf
 kZGmThxN
X-Proofpoint-ORIG-GUID: SGVNEiPgOwUWemFeG3V1C4qXb9jVGBdt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

On Tue, Sep 09, 2025 at 09:14:49AM +0200, Neil Armstrong wrote:
> On 08/09/2025 23:14, Dmitry Baryshkov wrote:
> > On Mon, Sep 08, 2025 at 03:04:20PM +0200, Neil Armstrong wrote:
> > > The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
> > > of a combo glue to route either lanes to the 4 shared physical lanes.
> > > 
> > > The routing of the lanes can be:
> > > - 2 DP + 2 USB3
> > > - 4 DP
> > > - 2 USB3
> > > 
> > > The layout of the lanes was designed to be mapped and swapped
> > > related to the USB-C Power Delivery negociation, so it supports
> > > a finite set of mappings inherited by the USB-C Altmode layouts.
> > > 
> > > Nevertheless those QMP Comby PHY can be used to drive a DisplayPort
> > > connector, DP->HDMI bridge, USB3 A Connector, etc... without
> > > an USB-C connector and no PD events.
> > > 
> > > Document the data-lanes on numbered port@0 out endpoints,
> > > allowing us to document the lanes mapping to DisplayPort
> > > and/or USB3 connectors/peripherals.
> > > 
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > >   .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         | 59 +++++++++++++++++++++-
> > >   1 file changed, 58 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> > > index 5005514d7c3a1e4a8893883497fd204bc04e12be..51e0d0983091af0b8a5170ac34a05ab0acc435a3 100644
> > > --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> > > +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> > > @@ -81,10 +81,67 @@ properties:
> > >     ports:
> > >       $ref: /schemas/graph.yaml#/properties/ports
> > > +
> > >       properties:
> > >         port@0:
> > > -        $ref: /schemas/graph.yaml#/properties/port
> > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > >           description: Output endpoint of the PHY
> > > +        unevaluatedProperties: false
> > > +
> > > +        properties:
> > > +          endpoint:
> > > +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> > > +            unevaluatedProperties: false
> > > +
> > > +          endpoint@0:
> > > +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> > > +            description: Display Port Output lanes of the PHY when used with static mapping
> > > +            unevaluatedProperties: false
> > > +
> > > +            properties:
> > > +              data-lanes:
> > > +                $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +                minItems: 2
> > 
> > Nit: DP can work in a 1-lane mode. Do we nned to support that in the PHY?
> 
> So the PHY already supports 1-lane, but the QMP Combo only supports
> mapping 2+2 or 4, but nevetheless we can still decscribe 1 lane in DT
> int both in & out endpoint and still should work fine.
> 
> Do you think this should be done now ?

Do we support it in the PHY hardware?

> 
> Neil
> 
> > 
> > > +                maxItems: 4
> > > +                oneOf:
> > > +                  - items: # DisplayPort 2 lanes, normal orientation
> > > +                      - const: 0
> > > +                      - const: 1
> > > +                  - items: # DisplayPort 2 lanes, flipped orientation
> > > +                      - const: 3
> > > +                      - const: 2
> > > +                  - items: # DisplayPort 4 lanes, normal orientation
> > > +                      - const: 0
> > > +                      - const: 1
> > > +                      - const: 2
> > > +                      - const: 3
> > > +                  - items: # DisplayPort 4 lanes, flipped orientation
> > > +                      - const: 3
> > > +                      - const: 2
> > > +                      - const: 1
> > > +                      - const: 0
> > > +            required:
> > > +              - data-lanes
> > > +
> > > +          endpoint@1:
> > > +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> > > +            description: USB Output lanes of the PHY when used with static mapping
> > > +            unevaluatedProperties: false
> > > +
> > > +            properties:
> > > +              data-lanes:
> > > +                $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +                minItems: 2
> > > +                oneOf:
> > > +                  - items: # USB3, normal orientation
> > > +                      - const: 1
> > > +                      - const: 0
> > > +                  - items: # USB3, flipped orientation
> > > +                      - const: 2
> > > +                      - const: 3
> > > +
> > > +            required:
> > > +              - data-lanes
> > >         port@1:
> > >           $ref: /schemas/graph.yaml#/properties/port
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> 

-- 
With best wishes
Dmitry

