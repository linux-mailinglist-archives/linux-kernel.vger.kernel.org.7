Return-Path: <linux-kernel+bounces-806769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F85B49BA9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D241893DBC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB872DE6FA;
	Mon,  8 Sep 2025 21:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IV5j6zDZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A5627E04C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757366089; cv=none; b=J6WP+xsxaORG3zcna49JrB2IVyD7uCQu1jU09jLmvOGSDmO7/KJeLNElYJPvmq9zEz1W7MOgmt6A8jfgxKbf/5HbHvIAmUqSldiLJKnOPmlmit5ThwuA9UQxUyFJymnvQB9SyM6hNVgGgJ+PwH2GdVXlfSezFQg7H9tb3x4nC0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757366089; c=relaxed/simple;
	bh=eyHFAXkOFSW+uE2pWPw4vFvU0c+ccqmS8MDc33JMG+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmLc+JZ7RC6u8mrGPO/pUdUhk7FXzlhXUXynWsaTpG6NR1/LSogR0l9KN2+ed4wixbh70IZmKyGH3PvkpiAas0U1Eh2O5cRmdYWCSwdG79Ro9UyE+qofborfPMooKylU0J5Q+0Xhc/x0pE8pdvw5nWg+0d0P/CpxkVQ0P5WnFNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IV5j6zDZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588GIKu9008832
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 21:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gGFqDPUT3FFdS1GHQLN/aMib
	+ITPMyd8yB8R5vRfLy0=; b=IV5j6zDZg1Tozh4mtrTUk91Pr/3XOjeFLYI+/c8Y
	e1unaMz5dXDEKp3qW7SNnu/cKVsjZXDvgBP8bX3fFsY1DqwHkqeQIDlw8vLlBmf/
	cuiRawgBccD+zL5fU+XDbI/StBHngxyzHRvsWZXkwC5gO1ciYoYBnYgPJESBh6rR
	mlOD28sM6WzFV3EQfZXkTcqhZB1fmR0VALWrEdK0ZUddzLU5m7cBUJI8Ix4Izt07
	EXD/FpK31o/TTI8oriCpoLbaAPCFOQ97nenKfrhZNT5kvsJXg34/3bWgkU+02vbK
	9vdN0s8Lgr+4wUDa18ZNBeuj6sLQ3OaoPs/7tgeOz743Ww==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0ny64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 21:14:45 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5f4e4fe41so128373541cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 14:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757366084; x=1757970884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGFqDPUT3FFdS1GHQLN/aMib+ITPMyd8yB8R5vRfLy0=;
        b=jefFr5lVOFPD4KaEoyCNU/Sri7PaDP2AVtI6xxPK2xn7DsbGXK1S/IlBOCrHT2bqj0
         Lr2eI+n/bStFrMBDLQQF/eU4CJNDNrsxeT5iMyoaKnuVNKEseAY/BUnS+5S1+x+e3KE2
         K5Qs//mv16gE/J9Y1fpc8NMpkqFuXum7SA8GYtVvScbVrRL5gOEPEXXqP7HtfQrbB7pQ
         QSRckYAGsY47i+Avj1C1h4m+m8W6JQR+xUWgzVRm6o854uElLWpcEtzl5aAipa6wO6nb
         AAPTeuWUdQfX3uoPP8Azve7O2mIhkNB7Zy7gCj+pAUrkVHSjdu66DtChZB+dQtssYh80
         o+SQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/aoTx/dkvwK/gBmOarY8jXgB327vp0tNjbJ8aFhDv/tYtTLgEaLrGBo1NxIQHIywgSIEfLSU6mmlQzAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxk2Xz150fj+8+8vaOSxu2XmD0ubsM122+CjPB5Ha33yitrzlo
	vKhFm9wPwFAkQyngI1s8L292ufQEfQpY7ls5f0OJQkkLotgHEg61P5ArmO/IJyv098y+DnGsZZT
	ZRg1Aj+P7LyeqLSDqOM5FZmx5rGSmkXYxf5mYHTABdV3jw0/8PnKYxa9+W/q0BIGPqMM=
X-Gm-Gg: ASbGncsrGefgLadkuhSRedYXIgVeD8wGGJTppRx+hiO5HCiIwhZnEvU2XyxUNrxtyUX
	X489+RxIB2UBmGUHJUQiiTcuCwqTK0/GZ5Lo5ub6de3+mUjhOyja9VLU+iqlubmIqYfSvDflf+T
	vvykeKgX54Ojdj+mWpnHn/g96I8hRu8uvBYoili93otVBw9bzx6Cp0rnh9wkEjfNtQcnuUx+E6B
	lNcnN2uqCJ9FgwQCVrYice4vCcDtFevcAkByuFC5UZ3knxjh2MbV3BzOiAY0x4EU57ai0Uh4CLC
	GGYzch//Hw7sQcJiivO25pwJB0fqZXN8RepqWn/CMTzoDr2GNRHcH6b7nns35hEzbB1BbxLqisV
	9BQO/68rAw/rE4RfyfmImOt1MyFmYhFuZvZe7gnW7bNjoBFGcmRny
X-Received: by 2002:a05:622a:48a:b0:4b3:552:27a9 with SMTP id d75a77b69052e-4b5f84650aemr96693311cf.58.1757366084160;
        Mon, 08 Sep 2025 14:14:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0oVHFI5EIDxHYHpoWD6bO+otPWX2dmEW+dVE7ydmDEbNxbxrGRzABsbieuc3+w78vdOnHmg==
X-Received: by 2002:a05:622a:48a:b0:4b3:552:27a9 with SMTP id d75a77b69052e-4b5f84650aemr96693011cf.58.1757366083658;
        Mon, 08 Sep 2025 14:14:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5681795da99sm21668e87.76.2025.09.08.14.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 14:14:42 -0700 (PDT)
Date: Tue, 9 Sep 2025 00:14:40 +0300
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
Message-ID: <7dzfcuvr45h4iailtjutqjev7lofoqu7w6ob77gehgmy7mctpk@k7oob4wj3c7a>
References: <20250908-topic-x1e80100-hdmi-v3-0-c53b0f2bc2fb@linaro.org>
 <20250908-topic-x1e80100-hdmi-v3-3-c53b0f2bc2fb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-topic-x1e80100-hdmi-v3-3-c53b0f2bc2fb@linaro.org>
X-Proofpoint-ORIG-GUID: VdaGWz_i7V09-S5AXj11PGs_CkpG3DuC
X-Proofpoint-GUID: VdaGWz_i7V09-S5AXj11PGs_CkpG3DuC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX2kiGEUG8h87K
 KTYGca0//9WpZZIuTj4kncvYQSv2TBslSL+tpZz3MY1GTxKQbelgwti4NtDlTetJLCIQ0NQIn0/
 jEIpRDmao7skWPl5Ny2kRG0wg3UYaiPHpKa2+79vBm9f//5bv5BamusEqGyhsyboN88xJ2EOtLG
 1sefFCOgU2KrywsifbgdBtRgXxd6qDQrBYqCtX+x69NgoI/5k6d8WjiG4cid1Mi7sUIWxpIC7VY
 eITHM/2lVrXk4SVueXWzetlldXd99W3WKTwTMO5/EOzgGnoP9DBN73lGwg/b8Ojuwke5Y3Jutfq
 a40AbdfaIB47m+/Z3HsWbOeE2S+vSelXgW5UXUlgVeLa6Y6Swh/vHpS6DidTOtg7Mw8EIsU9bP0
 lCHKcc+y
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68bf4745 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=MealuuOmK2OQarRwPrkA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

On Mon, Sep 08, 2025 at 03:04:20PM +0200, Neil Armstrong wrote:
> The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
> of a combo glue to route either lanes to the 4 shared physical lanes.
> 
> The routing of the lanes can be:
> - 2 DP + 2 USB3
> - 4 DP
> - 2 USB3
> 
> The layout of the lanes was designed to be mapped and swapped
> related to the USB-C Power Delivery negociation, so it supports
> a finite set of mappings inherited by the USB-C Altmode layouts.
> 
> Nevertheless those QMP Comby PHY can be used to drive a DisplayPort
> connector, DP->HDMI bridge, USB3 A Connector, etc... without
> an USB-C connector and no PD events.
> 
> Document the data-lanes on numbered port@0 out endpoints,
> allowing us to document the lanes mapping to DisplayPort
> and/or USB3 connectors/peripherals.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         | 59 +++++++++++++++++++++-
>  1 file changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> index 5005514d7c3a1e4a8893883497fd204bc04e12be..51e0d0983091af0b8a5170ac34a05ab0acc435a3 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> @@ -81,10 +81,67 @@ properties:
>  
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
> +
>      properties:
>        port@0:
> -        $ref: /schemas/graph.yaml#/properties/port
> +        $ref: /schemas/graph.yaml#/$defs/port-base
>          description: Output endpoint of the PHY
> +        unevaluatedProperties: false
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            unevaluatedProperties: false
> +
> +          endpoint@0:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            description: Display Port Output lanes of the PHY when used with static mapping
> +            unevaluatedProperties: false
> +
> +            properties:
> +              data-lanes:
> +                $ref: /schemas/types.yaml#/definitions/uint32-array
> +                minItems: 2

Nit: DP can work in a 1-lane mode. Do we nned to support that in the PHY?

> +                maxItems: 4
> +                oneOf:
> +                  - items: # DisplayPort 2 lanes, normal orientation
> +                      - const: 0
> +                      - const: 1
> +                  - items: # DisplayPort 2 lanes, flipped orientation
> +                      - const: 3
> +                      - const: 2
> +                  - items: # DisplayPort 4 lanes, normal orientation
> +                      - const: 0
> +                      - const: 1
> +                      - const: 2
> +                      - const: 3
> +                  - items: # DisplayPort 4 lanes, flipped orientation
> +                      - const: 3
> +                      - const: 2
> +                      - const: 1
> +                      - const: 0
> +            required:
> +              - data-lanes
> +
> +          endpoint@1:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            description: USB Output lanes of the PHY when used with static mapping
> +            unevaluatedProperties: false
> +
> +            properties:
> +              data-lanes:
> +                $ref: /schemas/types.yaml#/definitions/uint32-array
> +                minItems: 2
> +                oneOf:
> +                  - items: # USB3, normal orientation
> +                      - const: 1
> +                      - const: 0
> +                  - items: # USB3, flipped orientation
> +                      - const: 2
> +                      - const: 3
> +
> +            required:
> +              - data-lanes
>  
>        port@1:
>          $ref: /schemas/graph.yaml#/properties/port
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

