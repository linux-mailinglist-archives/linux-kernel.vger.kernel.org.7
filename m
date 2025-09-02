Return-Path: <linux-kernel+bounces-796019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFF9B3FAFC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D9717DF9A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBA4278158;
	Tue,  2 Sep 2025 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bMAnIhXa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7878B2773C2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806368; cv=none; b=RA8kT0vR6Jp7msjLiDCIWNFTgGsexi5YAwYahuvOXvpJj3LvZQESs93AOnqCHTDudaWnLher+NlNSs9xV+8PrVI51XyZ3QrKcoRe977T9Z7WIvbLTe/hBkVFZ3Qp05XttffXtA01WIZn4qMno+zhPRA2d8TrViIiNq5YxP6qAs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806368; c=relaxed/simple;
	bh=9vZm+CpE5/TzBi01gAUyiY0mPJeQCDJqZEKw0Bh6/Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBD+QHzKh7QWKhBpuG6JoBZbXEM2uKuHz/qG6tN2ZxVJsAgBfXP3eI3HCUE29HrFmVsMgVuD62lF1rYlDrfk9vuouRRXyo3SeBO8K8NXsXVE6QWIeFaseEbaOMfk2Y75KUJWnTjzFfkR/EzID71x9ANPSdDngoCaFICCWGbIR9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bMAnIhXa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S2PF013176
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 09:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kuvcx9dK+4uPO7PcKf2xDvCA
	/wZvMuQBYtW1BRkUMHs=; b=bMAnIhXaL4tjXQoR242+kYg3wyyhu8xAaePglGcF
	rX5tb9HzfAvjws3tmxb8bkdJ2TKxWrbU9xEj43O1eD+HVJjlOMgxj24sZL0ifFU+
	JGPGBe0mkYm8Dsj+TkVgO7vcdqsX9MNKNYXdo3D5wMX1M9l2zdQIjVY4C0q88Xx7
	lMzcCHo8Rmiz/CvGGDJPKCz2s5zlaiBsqoF3uoaaYnV8ss3UkYTgR7tyzqTA00mX
	ub09LEkAnNUF4EsRb9ap87MR16rrRCcYmp8AcAGcvOoqT1mfVTvQl8WwUX5AgobT
	OiQwK0kRTpVrWwJ+HjHHv/LHOz+Celi5n2TutAWVr1VMyA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2ff7nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:46:05 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b335bd70b8so25148831cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756806364; x=1757411164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuvcx9dK+4uPO7PcKf2xDvCA/wZvMuQBYtW1BRkUMHs=;
        b=PveuUvjCx4R/XsYax95lf5HNGL2x5F45rYYKtTaYEqbPmLgNoj4D8q7Jy6VcVzXLOX
         huo83peXHQglZ5vjy/56tXmwQ7xFb0CAZ0UA+mp8Wrwm8MNoU+NM2M1lbFYUAb4JY1ub
         ZDNHvhBgFe3u78wxfz9u/D2gAiDYgud6+Kl+KCqHsheDIr7jQK4cHImHAn1enyns/yow
         z/joxofFAhpYneVW4xnU6IzS6p8xRzgqteBhKvthzjop+pR39ndDeCgI7HXKFYe6PSqM
         V4v85L7t1RQ8tl7gudP/HQWo4Cu1L/qBaTW3grK8zlk2HxLLT92tkvFQKP6gTSY7fP8Z
         WGIg==
X-Forwarded-Encrypted: i=1; AJvYcCXE6mni6iNYYy6rntiAXthaUdj5DCjvFeEZzR6drBEjxscX9/7btm0aPwV4r56poXICxER2u5n49BhS7Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuMHVlbLCs1WPzZwLr1RNb2rAtw0gEGl4M0ltYjHdDDLSQQ/2U
	ysMWtz7ncJInycjGwwvWRvzvmjd96PyhYtaDwiIVQsBWHZPWht64wBYJoezhnErN1wbENv8dsBi
	2Qiq0ybI/UqEs/jeyoBfrSZ16r83n1uMz6SZisd/iSXVuzZ2YGVIfu8HcFD/nk6y0PQg=
X-Gm-Gg: ASbGncu6nzaEfnd3Yfv6JR5xanOtZR5o3R0kg9rTyykkOUU7Kun7mfa5aSfcqAMsyHo
	XmhiXP8H+eBgodjyLwEnTI691ZpucbG+2K+Y0ekjAZBZLJArKEMWEPGXeGH4wiE2+SKnVoiDOb/
	SndazWt0DLj5QqRvLTQ+OU5wDnuW4r1f68JPlzsr6PbQG20ioJtXcj0pEV1sKS/hzV0IlwxyTyt
	fwAf9HIQ6/5g07wrEu6AFzTeoHStDgOG/hOgqN7S8zBdTtS9+C3n6qYoXhlMYBUJm/3wknznaXR
	XAs1AuE2nwBQyv1xr46yYacAPlm/Puet4tv0J9vbh2iyJXq8UoX/C2yoFlWnFhZOtb+l2NAtadE
	g/gUCzGSb38wkOsCmQF8qN3yySZXmpoy2nrt8RFFxhlAb+vCBqUq/
X-Received: by 2002:a05:622a:1898:b0:4af:af49:977f with SMTP id d75a77b69052e-4b31d843106mr110963081cf.30.1756806364135;
        Tue, 02 Sep 2025 02:46:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6+NH9LnUGOobc8Z3ipkGt2tyqr1PSej/+J4YRMh0RhCCuZpIUdsEIhFAtonApsNUh/JxvIw==
X-Received: by 2002:a05:622a:1898:b0:4af:af49:977f with SMTP id d75a77b69052e-4b31d843106mr110962671cf.30.1756806363442;
        Tue, 02 Sep 2025 02:46:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c91d37sm3581281fa.19.2025.09.02.02.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:46:02 -0700 (PDT)
Date: Tue, 2 Sep 2025 12:46:00 +0300
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
Subject: Re: [PATCH v2 3/5] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy:
 Document static lanes mapping
Message-ID: <tl4fskw6yq6rniwwqkrvnulfpgym3jswlt5bmulgquogv7xkct@6bl4boesilsw>
References: <20250902-topic-x1e80100-hdmi-v2-0-f4ccf0ef79ab@linaro.org>
 <20250902-topic-x1e80100-hdmi-v2-3-f4ccf0ef79ab@linaro.org>
 <slgu2d4iv6ef76f43gvwaelcl5ymymsvhokyunalq7z3l2ht3j@t7pko4rtqvgm>
 <bf772209-2420-4794-a52a-1d5932146307@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf772209-2420-4794-a52a-1d5932146307@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfXw4RzFmt4JFg/
 nrr9teAVAiCKPjA39w4RiFtJS/6R8pJ4FIh8temPxEqCQa2TOV6RlevrdWgxvYqz6D8v3zRue7G
 0PUqA+mmMDXeCTAeAOJFFJAqRZVVBMAoOfVonRtWtPKmJZ66uVYmQ4qm42ADOJIj1YRFbFzCqv/
 hCRAUjDYsGKaFNztfhEMTLGfCmwNk0UOyZWrA4KYFBowXybAs1fmjL1bR0zZbO/AKmF1Y3AcUh9
 uAzcx6RtFEvLB5cauMOWuMjmaNVIOF/t7G49nO6+9cL08xW0Qint2V9DR3wGFZRGrya/W/qduOy
 sT75bEwZGhEqIIdXwKBOOTweIvZS/hdpYYC1Yl3EfAkFjhpzbJ4po8xJLttx4ReQAJc9KEifU7U
 NvZqo0F+
X-Proofpoint-ORIG-GUID: Hl-vy4ynlEkM49Rnrz9FP8eua7GG95XS
X-Proofpoint-GUID: Hl-vy4ynlEkM49Rnrz9FP8eua7GG95XS
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b6bcdd cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=SY17gm6z-Ks54HuadOoA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038

On Tue, Sep 02, 2025 at 11:35:25AM +0200, Neil Armstrong wrote:
> On 02/09/2025 11:30, Dmitry Baryshkov wrote:
> > On Tue, Sep 02, 2025 at 11:00:30AM +0200, Neil Armstrong wrote:
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
> > > Nevertheless those QMP Comby PHY can be statically used to
> > > drive a DisplayPort connector, DP->HDMI bridge, USB3 A Connector,
> > > etc... without an USB-C connector and no PD events.
> > > 
> > > Add a property that documents the static lanes mapping to
> > > each underlying PHY to allow supporting boards directly
> > > connecting USB3 and DisplayPort lanes to the QMP Combo
> > > lanes.
> > > 
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > >   .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         | 29 ++++++++++++++++++++++
> > >   1 file changed, 29 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> > > index c8bc512df08b5694c8599f475de78679a4438449..12511a462bc6245e0b82726d053d8605148c5047 100644
> > > --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> > > +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> > > @@ -76,6 +76,35 @@ properties:
> > >     mode-switch: true
> > >     orientation-switch: true
> > > +  qcom,static-lanes-mapping:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +    minItems: 4
> > > +    items:
> > > +      enum:
> > > +        - 0 # Unconnected (PHY_NONE)
> > > +        - 4 # USB3 (PHY_TYPE_USB3)
> > > +        - 6 # DisplayPort (PHY_TYPE_DP)
> > > +    description:
> > > +      Describes the static mapping of the Combo PHY lanes, when not used
> > > +      a in a Type-C dynamic setup using USB-C PD Events to change the mapping.
> > > +      The 4 lanes can either routed to the underlying DP PHY or the USB3 PHY.
> > > +      Only 2 of the lanes can be connected to the USB3 PHY, but the 4 lanes can
> > > +      be connected to the DP PHY.
> > 
> > It feels like this significantly duplicates existing data-lanes
> > definitions. Can we use that property to express the same semantics?
> 
> Well yes it has the same semantics, but not really the same meaning. data-lanes is designed
> to describes the lanes layout/ordering, not the type/mapping.
> 
> Here, we do not describe the ordering, i.e which source lane is connected to which endpoint splot,
> but which lane is supposed to connect to which internal PHY.
> 
> Anyway, I'm open to suggestions.

phy@abcdef {
	ports {
		port@1 {
			endpoint {
				remote-endpoint = <&&usb_1_dwc3_ss>;
				data-lanes = <2 3>;
			};
		};

		port@2 {
			endpoint {
				remote-endpoint = <&mdss_dp0_out>;
				data-lanes = <1>;
			};
		};
	};
};

phy@cafecafe {
	ports {
		port@1 {
			endpoint {
				remote-endpoint = <&&usb_1_dwc3_ss>;
				status = "disabled";
			};
		};

		port@2 {
			endpoint {
				remote-endpoint = <&mdss_dp0_out>;
				data-lanes = <2 3 0 1>;
			};
		};
	};
};


> 
> Neil
> 
> > 
> > 
> > > +      The numbers corresponds to the PHY Type the lanes are connected to.
> > > +      The possible combinations are
> > > +        <0 0 0 0> when none are connected
> > > +        <4 4 0 6> USB3 and DP single lane
> > > +        <4 4 6 6> USB3 and DP
> > > +        <6 6 4 4> DP and USB3
> > > +        <6 0 4 4> DP and USB3 single lane
> > > +        <4 4 0 0> USB3 Only
> > > +        <0 0 4 4> USB3 Only
> > > +        <6 0 0 0> DP single lane
> > > +        <0 0 0 6> DP single lane
> > > +        <6 6 0 0> DP 2 lanes
> > > +        <0 0 6 6> DP 2 lanes
> > > +        <6 6 6 6> DP 4 lanes
> > > +
> > >     ports:
> > >       $ref: /schemas/graph.yaml#/properties/ports
> > >       properties:
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> 

-- 
With best wishes
Dmitry

