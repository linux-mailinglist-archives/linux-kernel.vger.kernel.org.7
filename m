Return-Path: <linux-kernel+bounces-808337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7A8B4FE80
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19238162E81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1B43431E1;
	Tue,  9 Sep 2025 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e3RVKHfI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE1F33A03C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426344; cv=none; b=Hf070wVvXidLFGKIMy/xO0Z8AVWX7xdVpJAV7hVCHQjGc2Rq2QRMPVcMdx1a+Ij6LRZ8OXeS9eKiH9Yhfm+BXLsB2z/fGmJawW2kr+BGZUA/ZDw4b8pr6dsmh71J/Nb2t2Dz6W1ZBWOjlF5gAsnw4xm7BqioACTVucC6lxXoLB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426344; c=relaxed/simple;
	bh=fGoY1rCKFQaava6el/TElRSSYnR2HYwuz4xGqge09P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oc2DOfM08qtADDk3Yfi4//YfoBzsznhP7+97hdG328kCe04U+sjZqu/wFPr9kbm288tH1nvjET3AuSMWrxdF+JDmloCX0AmrMfqO26Md7sItUT7RCfYs/ctxHLBVuN0M/NcblEZnnVsjAJCdxegF4UrVuqxV6OR2rG/zeYiWJmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e3RVKHfI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899Led8030636
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 13:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+e+m2eXxsaETI5+DzIMa5RUB
	HZ/+khiBv1BzAFhU+3c=; b=e3RVKHfIvyKU1oDik0Wo+ZvycmTxqZqJHGYPKKBY
	v1JnjNrQVxXdzu7H8EJwamY+kGanlkNCRKdEik3p5xmIEa9//LUW2xvByoJbPLdp
	rnVsrUMj4utvHOJUivDreQNssmyZ+itk0sIvg5WDL2+kwQYoC6uzhJcTF3AFuaVb
	0E0t09mHBPZdH4weIT0+3iYnyJDO+rzv/Qmu0F4b/GE0ezdGX8/WzERGlUKNqRNB
	5g9zeb/TimgZb0Q4KM2cParKdLhq4L7cj0UK0k5lmENxLF+m/cOVBSHWnG6K+9qn
	b8kxuZzuRLUzlOUB6yfD5qWB2cSYNJlOLe+DVvwzE9wjBQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j8gv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 13:59:00 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-72e83eb8cafso90110596d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 06:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757426340; x=1758031140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+e+m2eXxsaETI5+DzIMa5RUBHZ/+khiBv1BzAFhU+3c=;
        b=jUkLnPetVdrnOcsvym7U6UiJQBD2XhypU8G40KGXaP+MLxJZVd/rVkm8E+lbwp4KXG
         kKjbTBfsmQE3eVoTaR52B6iuAdiLYafPaDpgW2JA0dtd5ScAbNfDHvQZjSnOEfamkeaa
         RZFneBvJokz3oprM5oT5HCSbEBO5nN9ezbTiOPfyq0+SXIPECpF2yV1imHsZBkrEJf70
         1YLfr0KwI5loNRWX3DInMmLPpzwPpB06IbaX3qVPhrLm4HpEbO/fhsGBAe1tFEnjirkx
         l35CwgvWoUmkc+a2oMOMmj6E4IlTwWOpQ8NpU/vluBfoNZBnWynYr9pAWwUX5Jms7pic
         +NnA==
X-Forwarded-Encrypted: i=1; AJvYcCVGBFQa4deKbuowrCyiZbg0HAPMXP8i+XCetgyQXUWJu98LIE5BkQKplPXBqi6gdLjbWUg2trauoJ8KoNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywod0P8SeLJKKnAZxdED9XNrfnVGkHQLsVVmVBG2O4XkJcjh8nQ
	DDc2aIeq5oAopJKRNajwesJ7cgJT5c9arDvQD6oUyTNu/dxVaC/wSWmVU76gob4czcd+POUWKz9
	0EGYxpFUL/QCBrzq87uC9gHGkeKk5Q1vELz+nLP7gBHifctflQ5Ha9SOVB4hm9IowRdQ=
X-Gm-Gg: ASbGncv5YdcqVuTRVVVjRiz43LwhbDKGcdyiKRNvKUizXyByEyPlt7yqtD77zeZoaOG
	MHxHumjJi38SBXQg+lc9zN4NklMV0qeIQU8Xy35QLbfThkEjWk3be6QHydhuRywiGvtbRttyNhA
	VfkTGr1XOJDEFM2NA3aJSwufVLtVNmfznbs2R6nK4OwP6O/VuLDhlin+A6l6XENzhAbqZQRzclX
	ZBfkQSDKfyZchChaF617kool1eHedK/D0dxz5VdIA3hipmih3DEMyXIYF5I+gU1Cb7sgmH5u6Lh
	D1AG+O6/Lo5z+5QYMUoQmYemYU2mU3yeodNyWifhm4IrKO1yBxQXR5gajCPPP1Jm+3U+yMzAz41
	cpIIuPXLyfoirB4ycOY7GwILSfXeJWNHF7rYD3aZN0v1di1xo/YEV
X-Received: by 2002:a05:6214:e6e:b0:72b:f322:6817 with SMTP id 6a1803df08f44-7391f30353dmr118890606d6.10.1757426339773;
        Tue, 09 Sep 2025 06:58:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx+dFgHWJPMSKPSEn7vDY6bmN0vj3HU50MJCOT7V8BOnFjo1dHoOhzTqahq+CmW1jyx6u1HA==
X-Received: by 2002:a05:6214:e6e:b0:72b:f322:6817 with SMTP id 6a1803df08f44-7391f30353dmr118890216d6.10.1757426339166;
        Tue, 09 Sep 2025 06:58:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680c424fb2sm548560e87.11.2025.09.09.06.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 06:58:58 -0700 (PDT)
Date: Tue, 9 Sep 2025 16:58:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
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
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 3/5] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy:
 Document lanes mapping when not using in USB-C complex
Message-ID: <dpidjyofawtrmci5lu72gdnwxxws57sw55cxxedkhsq2dryohm@cdxjwnros57y>
References: <20250908-topic-x1e80100-hdmi-v3-0-c53b0f2bc2fb@linaro.org>
 <20250908-topic-x1e80100-hdmi-v3-3-c53b0f2bc2fb@linaro.org>
 <7dzfcuvr45h4iailtjutqjev7lofoqu7w6ob77gehgmy7mctpk@k7oob4wj3c7a>
 <14d58c6d-ca20-4349-8031-9906a4539fef@linaro.org>
 <c25kbb65aijgolxjzunydvhupt774pfmbcz5lvfvl5f74rrxtr@vboh347gdvdp>
 <da984d8f-85ae-44cf-8de4-208bfc9e292d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da984d8f-85ae-44cf-8de4-208bfc9e292d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX+tbecXkayNhH
 MQljQJOP8DNRjTR3Cd144LH6Zo7InGagdBFI5eFYKCXdAJ/RgF+EQND4KinHymL/iyWY7gKLzT7
 uPeMDyzET/++PxvrV7PYv0bPtlLmy+JZIcZdjeK9soN3ioGGC5ZIvwDA83yxwk9XEv0gNORN6AZ
 0FYd88M7STmkyZS0u7arBym9WucWFXpwgARwWxpWI3K0CatF9ktsRDkJRwlHLUT04m9JqcSQt+X
 uom+lLPSc3aZXwYUf3P6mhi2uF6eYC+ff7FstL6p0Np06Dk1mU+wAIeGm0dwiffIXEXv8HvXVP5
 xNxJ5xrsOrByx25w1N2eKfZRMyyRNcGUK2wzst+lluRiJPDh8ynCghti6xgJxkIbevfX2iPFs2J
 1MiZse7n
X-Proofpoint-ORIG-GUID: RY4nxiPhNYwuPHE38JT5sVb_HelKAdif
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68c032a4 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=r0EWWIcaWpoI38bJcbMA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: RY4nxiPhNYwuPHE38JT5sVb_HelKAdif
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

On Tue, Sep 09, 2025 at 01:21:19PM +0200, Konrad Dybcio wrote:
> On 9/9/25 1:16 PM, Dmitry Baryshkov wrote:
> > On Tue, Sep 09, 2025 at 09:14:49AM +0200, Neil Armstrong wrote:
> >> On 08/09/2025 23:14, Dmitry Baryshkov wrote:
> >>> On Mon, Sep 08, 2025 at 03:04:20PM +0200, Neil Armstrong wrote:
> >>>> The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
> >>>> of a combo glue to route either lanes to the 4 shared physical lanes.
> >>>>
> >>>> The routing of the lanes can be:
> >>>> - 2 DP + 2 USB3
> >>>> - 4 DP
> >>>> - 2 USB3
> >>>>
> >>>> The layout of the lanes was designed to be mapped and swapped
> >>>> related to the USB-C Power Delivery negociation, so it supports
> >>>> a finite set of mappings inherited by the USB-C Altmode layouts.
> >>>>
> >>>> Nevertheless those QMP Comby PHY can be used to drive a DisplayPort
> >>>> connector, DP->HDMI bridge, USB3 A Connector, etc... without
> >>>> an USB-C connector and no PD events.
> >>>>
> >>>> Document the data-lanes on numbered port@0 out endpoints,
> >>>> allowing us to document the lanes mapping to DisplayPort
> >>>> and/or USB3 connectors/peripherals.
> >>>>
> >>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >>>> ---
> >>>>   .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         | 59 +++++++++++++++++++++-
> >>>>   1 file changed, 58 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> >>>> index 5005514d7c3a1e4a8893883497fd204bc04e12be..51e0d0983091af0b8a5170ac34a05ab0acc435a3 100644
> >>>> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> >>>> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> >>>> @@ -81,10 +81,67 @@ properties:
> >>>>     ports:
> >>>>       $ref: /schemas/graph.yaml#/properties/ports
> >>>> +
> >>>>       properties:
> >>>>         port@0:
> >>>> -        $ref: /schemas/graph.yaml#/properties/port
> >>>> +        $ref: /schemas/graph.yaml#/$defs/port-base
> >>>>           description: Output endpoint of the PHY
> >>>> +        unevaluatedProperties: false
> >>>> +
> >>>> +        properties:
> >>>> +          endpoint:
> >>>> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> >>>> +            unevaluatedProperties: false
> >>>> +
> >>>> +          endpoint@0:
> >>>> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> >>>> +            description: Display Port Output lanes of the PHY when used with static mapping
> >>>> +            unevaluatedProperties: false
> >>>> +
> >>>> +            properties:
> >>>> +              data-lanes:
> >>>> +                $ref: /schemas/types.yaml#/definitions/uint32-array
> >>>> +                minItems: 2
> >>>
> >>> Nit: DP can work in a 1-lane mode. Do we nned to support that in the PHY?
> >>
> >> So the PHY already supports 1-lane, but the QMP Combo only supports
> >> mapping 2+2 or 4, but nevetheless we can still decscribe 1 lane in DT
> >> int both in & out endpoint and still should work fine.
> >>
> >> Do you think this should be done now ?
> > 
> > Do we support it in the PHY hardware?
> 
> I don't think the PHY cares if it's 1 or 2 lanes

I think so too. So maybe we shouldn't list 1 lane separately here.

-- 
With best wishes
Dmitry

