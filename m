Return-Path: <linux-kernel+bounces-796411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A05B40078
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D7B54748F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292062874E3;
	Tue,  2 Sep 2025 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZSjYulLk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7777E21FF44
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815745; cv=none; b=jWAc8//nR+PyetL5tLzaJcb4B6ZIGR1PAzGt8EcnwtHisNPl1aGIsKTeaY0tVzHwP+f6LoEmSJPD8Yx989CNjlxmzGmYEY44XBhbzNrDrISlJpH0HpKE0NFl4IMI1TG1D+kDZ03Tob7fJXr2wuu07j5AYvqOG99Q8IR3L1hDfqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815745; c=relaxed/simple;
	bh=wKPeNHXB4Gyqjn6nXMBzaGI4olxo6+KqmKqexEoBZVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVM9F+Wrj6zebDqf2v7ubMHn5Zs2ZYM3PZ3q1xSHmEBvjZuQr0PjMi4ZrbuxBGBVEHa0RSOeqabG1NcGzx+4wpd/hwAvqX2jWzVeXbCXWEjnJ65rvEESdvn0skMJfdHYhxi4tEJsdpdr1uHYsdpLZD3xxkcwB5pJgC7t5tnqiBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZSjYulLk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582B6S1Q010488
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 12:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=j5aSO0KmmpUqooUb/3qdW5ye
	cSIIeoQPBPrLpY1Yuvs=; b=ZSjYulLkag+B83fDDBVTT267Lz9GorndmZBiFv0N
	gDtnywdeeKkHLXJHlh2+gnhOPGUT2XHexI0qw4UJTpL8TyzqsCGFUpBLm1NpVXxJ
	qCZ/FyluGGVdm9UxminxiX3xbRCj7Nppao7XTK4ZfcxwZ3GrTmuqA5ZhAGg98JrU
	dY3xOd4evkbtQTofGyOE62AMsEs1Jsll6OmD3dIT3mlIIXVjWXwvrMVSWeZylAkp
	AXvT2Z2Z8JtE5XgYnLRt7vDqmDO0UC3jwve8cdB5Y2UEe6IM9zFrv9wr1And7U8G
	Jrwl8StMb6x77eQNcJ7CZIUGIolOI5YxuQIW70tpP97gtw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjfqqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 12:22:22 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b327a79a30so64819661cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756815741; x=1757420541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5aSO0KmmpUqooUb/3qdW5yecSIIeoQPBPrLpY1Yuvs=;
        b=PSJjUrqIquiU4GIOqQ1XH7WyTWmBYjyAat1xZBo+QtVPMmGowqW9BHu764T+qST2p9
         ocj40RV2KCtVTGqoXUDsXTBRgzKehbrWP0Pl4qVeWQZ0U+5pMG8VPNZdn/L70bx0ZRew
         WAHoERaxPpwpZcrIaF9nSsCSqlzETkDlO2e4+CQMIM6PvwFuarwcOFkyPJxWJzSrR9iK
         RVJATZPzj0YkP34vqevaXA3CXR4kd57F5sFx54KPSAhY+IFYbL3Ans1pkZeMQZI3NLn1
         MO7NKQZVBJTTZGuTuC17UI2GxaNV5xm+//W2m7BzdBpO0INNdEghuaOtnBcOvvVAcaTy
         Jk4w==
X-Forwarded-Encrypted: i=1; AJvYcCULnHUcUVdDjZpwcc5wfUjHP8e3daH9ScCVPURDefMVq9fEOBcpmRgA9k8EKDU+qOy0/dDzN9fh/eTDby4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx9DGmhSqiDsNHjMJ8kK/yimxwyjO2C6WYAPs2B5bylUhwIEVu
	m0xA2KVLETVd4z4gDoUjevpcrDBKLKMq0BrN9PkS2tYpHsQzzk7FUpTdxxCCUwWUkF3YURoJq5g
	+XRRLW3LBP7lUlVyaO3Qej+EAek8pb9p0gRFUClx2PP5NMHQke09m3NDNNS+bvxgktiE=
X-Gm-Gg: ASbGnctjAPOS+ZTdLWLbvPRfEh58b0IYVaSH9uC5AW/3Aojfo9R6UzAMq5wDJV+Q6Ec
	etOVvqi1FTjPPfkWkPHQ5YrlWmylaF253m/ih80OaschT0tOYSXVBTwVBFc5j+t9FckTrT7wslU
	prOJa493A2SQZhAz7UMwb7GklQHdu+rlq/iY+jhheb5X8MA3bGH6Bx3FgXnooKw32AzpvWiykjS
	ctVSX0Aw7UzBOqO13yR43Q93cGNK3KV+fUIs5zP+Eq+vv3skgbBKwGE4RU6oo4FEcSHQ58Uuvr5
	rlhpK3Y2KnE7d3F2WfEq5x5UnmRK41gnXgkfKAeQiy4fvr/ZxrRvunkjzsuFwKbBHAqwtHz4vL0
	uKBR9Ww8FvGkqriRkxQAng9pSDgfVIaQU129HxZvZjCirxUgXsycQ
X-Received: by 2002:ac8:5905:0:b0:4ae:cc75:4703 with SMTP id d75a77b69052e-4b31dcbab88mr120080301cf.58.1756815741274;
        Tue, 02 Sep 2025 05:22:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEujDNuyvL4g7dEIP1Zof253r1rsB9bYFgUlrVvoDVc0jN2XKrDOZk12w7hWmQbuIucQUVHTA==
X-Received: by 2002:ac8:5905:0:b0:4ae:cc75:4703 with SMTP id d75a77b69052e-4b31dcbab88mr120079791cf.58.1756815740501;
        Tue, 02 Sep 2025 05:22:20 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-560826d7f2asm667117e87.43.2025.09.02.05.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:22:19 -0700 (PDT)
Date: Tue, 2 Sep 2025 15:22:17 +0300
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
Message-ID: <oel3t35pxegxaowcfjbrzrxvuw47p7pzcinz7kf2uj2ivcderv@efbttlqpwcc7>
References: <20250902-topic-x1e80100-hdmi-v2-0-f4ccf0ef79ab@linaro.org>
 <20250902-topic-x1e80100-hdmi-v2-3-f4ccf0ef79ab@linaro.org>
 <slgu2d4iv6ef76f43gvwaelcl5ymymsvhokyunalq7z3l2ht3j@t7pko4rtqvgm>
 <bf772209-2420-4794-a52a-1d5932146307@linaro.org>
 <tl4fskw6yq6rniwwqkrvnulfpgym3jswlt5bmulgquogv7xkct@6bl4boesilsw>
 <14f334fc-35de-4f21-8eb1-f6b41ac24704@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14f334fc-35de-4f21-8eb1-f6b41ac24704@linaro.org>
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b6e17e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=HJy97g7PLlcXBZGHDcIA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: o-nN8Uxz3my1BhPlSa7hDvIAGzbu1rEC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX7S7BG9VCwDKO
 obIX+Zuz2vPbvrLdU1qx47cHS+bGYXZhAbfSHscGvhjQK9UKOcnlcVgcjfR1OoViw5ecWx9ao/R
 IiXIvvgKzMRgG8uykmg5KEHLhlnsai0Vu2QEHiOiPW2SNL+CgPHeGZJnOr+HiGJogOzjvY0ll03
 2+Xo6Gk48ftG1iNfDwpcZPJkVqRTUNgyo6B560E0er9/wq5kEt6TSM7JJp4cvOqTMZ5ZSiz0mUT
 jQc1+FiAY2AfOoDalxy7Ljap5ytKPnXoDxOUJmmWgkh0hpmYzj75u+UNrF7oy97+tqNugwm/pNX
 BrHQCTCDMz7IoiuS2AolYAic4BnqHe33Emdgw1bVbs2mmEOEUCkXSvezOgLRI9I38TepfAhfpg0
 2FXdW8NW
X-Proofpoint-ORIG-GUID: o-nN8Uxz3my1BhPlSa7hDvIAGzbu1rEC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

On Tue, Sep 02, 2025 at 12:05:45PM +0200, Neil Armstrong wrote:
> On 02/09/2025 11:46, Dmitry Baryshkov wrote:
> > On Tue, Sep 02, 2025 at 11:35:25AM +0200, Neil Armstrong wrote:
> > > On 02/09/2025 11:30, Dmitry Baryshkov wrote:
> > > > On Tue, Sep 02, 2025 at 11:00:30AM +0200, Neil Armstrong wrote:
> > > > > The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
> > > > > of a combo glue to route either lanes to the 4 shared physical lanes.
> > > > > 
> > > > > The routing of the lanes can be:
> > > > > - 2 DP + 2 USB3
> > > > > - 4 DP
> > > > > - 2 USB3
> > > > > 
> > > > > The layout of the lanes was designed to be mapped and swapped
> > > > > related to the USB-C Power Delivery negociation, so it supports
> > > > > a finite set of mappings inherited by the USB-C Altmode layouts.
> > > > > 
> > > > > Nevertheless those QMP Comby PHY can be statically used to
> > > > > drive a DisplayPort connector, DP->HDMI bridge, USB3 A Connector,
> > > > > etc... without an USB-C connector and no PD events.
> > > > > 
> > > > > Add a property that documents the static lanes mapping to
> > > > > each underlying PHY to allow supporting boards directly
> > > > > connecting USB3 and DisplayPort lanes to the QMP Combo
> > > > > lanes.
> > > > > 
> > > > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > > > ---
> > > > >    .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         | 29 ++++++++++++++++++++++
> > > > >    1 file changed, 29 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> > > > > index c8bc512df08b5694c8599f475de78679a4438449..12511a462bc6245e0b82726d053d8605148c5047 100644
> > > > > --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> > > > > +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> > > > > @@ -76,6 +76,35 @@ properties:
> > > > >      mode-switch: true
> > > > >      orientation-switch: true
> > > > > +  qcom,static-lanes-mapping:
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > > +    minItems: 4
> > > > > +    items:
> > > > > +      enum:
> > > > > +        - 0 # Unconnected (PHY_NONE)
> > > > > +        - 4 # USB3 (PHY_TYPE_USB3)
> > > > > +        - 6 # DisplayPort (PHY_TYPE_DP)
> > > > > +    description:
> > > > > +      Describes the static mapping of the Combo PHY lanes, when not used
> > > > > +      a in a Type-C dynamic setup using USB-C PD Events to change the mapping.
> > > > > +      The 4 lanes can either routed to the underlying DP PHY or the USB3 PHY.
> > > > > +      Only 2 of the lanes can be connected to the USB3 PHY, but the 4 lanes can
> > > > > +      be connected to the DP PHY.
> > > > 
> > > > It feels like this significantly duplicates existing data-lanes
> > > > definitions. Can we use that property to express the same semantics?
> > > 
> > > Well yes it has the same semantics, but not really the same meaning. data-lanes is designed
> > > to describes the lanes layout/ordering, not the type/mapping.
> > > 
> > > Here, we do not describe the ordering, i.e which source lane is connected to which endpoint splot,
> > > but which lane is supposed to connect to which internal PHY.
> > > 
> > > Anyway, I'm open to suggestions.
> > 
> > phy@abcdef {
> > 	ports {
> > 		port@1 {
> > 			endpoint {
> > 				remote-endpoint = <&&usb_1_dwc3_ss>;
> > 				data-lanes = <2 3>;
> > 			};
> > 		};
> > 
> > 		port@2 {
> > 			endpoint {
> > 				remote-endpoint = <&mdss_dp0_out>;
> > 				data-lanes = <1>;
> > 			};
> > 		};
> > 	};
> > };
> > 
> > phy@cafecafe {
> > 	ports {
> > 		port@1 {
> > 			endpoint {
> > 				remote-endpoint = <&&usb_1_dwc3_ss>;
> > 				status = "disabled";
> > 			};
> > 		};
> > 
> > 		port@2 {
> > 			endpoint {
> > 				remote-endpoint = <&mdss_dp0_out>;
> > 				data-lanes = <2 3 0 1>;
> > 			};
> > 		};
> > 	};
> > };
> 
> This is wrong, those are the internal connections to the controllers,
> those are fixed. I'm speaking about the external lanes, but there's only
> a single port.
> 
> So, following your suggestion, we should use the Output port 0, but as it's
> only a single port it would need to have 2 endpoints, one for USB3 and one for
> DP.
> 
> For example:
> 
> \{
> 	dp-connector {
> 		compatible = "dp-connector";
> 		type = "a";
> 
> 		port {
> 			dp_con: endpoint {
> 				remote-endpoint = <&usb_1_ss2_qmpphy_dp_out>;
> 			};
> 		};
> 	};
> 
> 	usb-a-connector {
> 		compatible = "usb-a-connector";
> 
> 		ports {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 
> 			port@0 {
> 				reg = <0>;
>                      		usb_con_hs: endpoint {
>                         		remote-endpoint = <&usb_1_ss2_dwc3_hs>;
>                      		};
>                  	};
> 
>                  	port@1 {
>                      		reg = <1>;
>                     		usb_con_ss: endpoint {
>                          		remote-endpoint = <&usb_1_ss2_qmpphy_usb3_out>;
>                      		};
>                  	};
> 		};
> 	};
> 
> };
> 
> &usb_1_ss2_dwc3_hs {
> 	remote-endpoint = <&usb_1_ss2_dwc3_hs>;
> };
> 
> &usb_1_ss2_qmpphy {
> 	/delete-property/ mode-switch;
> 	/delete-property/ orientation-switch;
> 
> 	ports {
> 		
> 		port@0{
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 
> 			/delete-node/ endpoint;
> 
> 			usb_1_ss2_qmpphy_usb3_out: endpoint@0 {
> 				reg = <0>;
> 				
> 				remote-endpoint = <&usb_con_ss>;
> 
> 				data-lanes = <1 2 0 0>;
> 			};
> 
> 			usb_1_ss2_qmpphy_dp_out: endpoint@1 {
> 				reg = <1>;
> 				
> 				remote-endpoint = <&dp_con>;
> 
> 				data-lanes = <0 0 1 2>;
> 			};
> 		};
> 	};
> };
> 
> So the driver logic would need to look at the port0/endpoint0 and port0/endpoint1
> data-lanes to figure out the mode.
> 
> Is this what you were thinking ?

No, I was really thinking about the data-lanes in the PHY parts, so I
was incorrect there (which is incrrect as you've pointed out).

The endpoints approach looks interesting though.

-- 
With best wishes
Dmitry

