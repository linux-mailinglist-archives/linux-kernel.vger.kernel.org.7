Return-Path: <linux-kernel+bounces-804465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06828B4777F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 23:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8CE65A0D18
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 21:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA38B2773F6;
	Sat,  6 Sep 2025 21:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e5ftPaC8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBC32135AD
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 21:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757194473; cv=none; b=X5Ht4Sn5M3xanXRXvHVv03aXewNnuhlGcZAI6ZARXSZr65saKRUZAf5ly/jCqOE596ycd2UHmNQytEZTwVmu621kXFdCTlrl3G5I5iAMStbfRo69aWsgLDqDPW1KJyE1UALP8ch+F+Ku104PVwVmMMcQJjWaszyr8BG9dTSMn8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757194473; c=relaxed/simple;
	bh=5M5JdaEQb5DHIXpup7czBSf59P5xVbBZRg/xs3gDwzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2WgcaRQEbtasoHrG/rZJTcTU9iF/b2nSq+HxQ9w+04eOlhKj1TxdRav2oQcbd35kCfF1INZPSWwrgBEgpzR3KKTY84Eh6VU4P0j55Yxnreyd1VtFlN3cs1g/Pq84xBX5QeeQkr9x5Lw4DD/n9FE7lwcTIXiEG4zWGVE+z6OAlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e5ftPaC8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 586L83GG015005
	for <linux-kernel@vger.kernel.org>; Sat, 6 Sep 2025 21:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=AV0ygjr/WMrb8ByJbVimXXrP
	CDYMyTfWtuK1PizEYI0=; b=e5ftPaC8Rae41bTW+MlzdXR6ClMTga5gCFXeCVFi
	HWm1K9lRZWDV0QHiDHnxVKgCnArBRq4B6ve6xP23yvCoCFMWC3Omk6PNjqxHru2b
	DXkrh0+IKZHpsHoDGcKK3jr2V2pjh37CFNJUW5ahceNvW8Gcuf3/gNqKjKR2s7cA
	J4axbBpSUkSmZ8AuBcqNAT8obSTH9xRWR27gVr6IzOoQxNfIvwsEK2OnTwBMSQoQ
	6CkbS+LbtNbKMhFo3Y3y4CcOXaGjvZV6ZvkpzVELfxs6VNXc/LITbw2iDDmMUO3E
	TBqQBsjyuSF+tq4Mll0x67Y8oDZwWIaV8sSKdCte6hCEdA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4ks468-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 21:34:30 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-71fe8dd89c6so71378006d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 14:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757194469; x=1757799269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AV0ygjr/WMrb8ByJbVimXXrPCDYMyTfWtuK1PizEYI0=;
        b=e4Ffc8d3WPS9f/zi2EL+BYrVuOD7LD8xwPYOgBLIJP+/jnM3WA/8V5jNSHKA0+1kEV
         LqyLdwYvCjf2v7ioKWpXTuzo2fgrnCqQT9tCWm46gZ3h67nlx0r+QjQlwli/Edu4EtHX
         +CRo8rchLA4hePKgkSEwtsxDTvYzSQa6KJlR5RLaKoVw1iRGKDezDepYyVvSBCEBg9AD
         wC6JPlAc5bEmozv+nNJu4N/B3zdU6fNo3oF8HU//WKLsijz2fxSkwKXZaf+ABliv/m2j
         Kpaqvk1M6beM1hgdS48gdubpkmyaBscNawaeziPGy4vzH85fvFU4RD1jzZDJcWdcvrYn
         +P5A==
X-Forwarded-Encrypted: i=1; AJvYcCWXE950MhyzdC2oOJvrRDGh3EX2Bk4iOGpzTrcJ2VTd1NplQkcUSf7Ud2nTCM7wRmWOE8inqiTmtBU0nSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWrCZNRe2GVeEeKPqPdqYQmeoJyQ79UffjI/+twZPRirTgOp5X
	vZfwk7zvFPKa4ZgrYBb29iwPfkky/0Dkfvzc5nWEwSq/GDgKPMe9DPM3Izp877Q2eP5zzPJJ3nD
	AWNgP1DKE1xsDmdqVT8b8i7kSwSJL2ba9JEpRYQLHhTRMiskSz/u8fKKRVu1qZbGN9aA=
X-Gm-Gg: ASbGnct9QBHH5E73s9WDnhzSUP/jHVcFvAtPtWglBhJzu9pt0MAyScedI/WwucZz5eL
	lhuPgQhW6AdM4ay5Oo810uMcMIBhsmfcExTR93Fo2N45eJ+DYvY6gbM/h3rDqlcdItCiieBOpbk
	cW1vsx5Z6vuiKc3Guh154NIC06W3FJkFA3spE+SlOdZ9afDeOm98FvhDWlbGc5qyKtSZg+aG+dR
	OgRcZO7S+oM+Fu0m3ZqTl4w2D49Cba+RsuENqVhs09JCgJZO0hlRl/k3+D2AdrMw7dbqSKvC+2h
	bQNf0VjK3qyVqF45cE6AfT8Rabq2se0Hv+sR5o8QGetHhueYk4RBqYxvpYMh+Rt8TftcY3rco81
	5GQGmym708Tfh6RFFxHS7Y5+40wvIF2yckPIQlSN1YP0QpSuovc8f
X-Received: by 2002:ad4:574c:0:b0:70d:def5:9574 with SMTP id 6a1803df08f44-7392305d770mr37428606d6.2.1757194469340;
        Sat, 06 Sep 2025 14:34:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJg5k1T8IvlFvM9U9wTF9PMcT8HtFQ5QIZb8nStHiYwoUNP1ozeojLz9R0BS5x5zF6EmmDBw==
X-Received: by 2002:ad4:574c:0:b0:70d:def5:9574 with SMTP id 6a1803df08f44-7392305d770mr37428376d6.2.1757194468817;
        Sat, 06 Sep 2025 14:34:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3381cff2f63sm10262891fa.48.2025.09.06.14.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 14:34:27 -0700 (PDT)
Date: Sun, 7 Sep 2025 00:34:24 +0300
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
Message-ID: <aLyo4N59o4CIYm-6@umbar.lan>
References: <20250904-rock5b-dp-alt-mode-v1-0-23df726b31ce@collabora.com>
 <20250904-rock5b-dp-alt-mode-v1-1-23df726b31ce@collabora.com>
 <aLyKhngeksG2SKdq@umbar.lan>
 <jzooq6qg3y7nee2nz6lujustdf4z7vtn6t2slikw43dann5sbk@2telraae26tl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jzooq6qg3y7nee2nz6lujustdf4z7vtn6t2slikw43dann5sbk@2telraae26tl>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfXzRZUDV2NZSLx
 w9Xs0SWN88tOzSLGsvOlo/FonW2ynYAeipyltaN5zXvj03UMeARNQ7dM5a5L5HCZ2rSVHNgh6Xw
 cyMj/a0rTx90AnX2kQ/qckPo6ZEyBhEAVk2zCIKvnUybKzFEzvR7EQxw3PIR1Ys3o0MjE4o0S2i
 gg+0UQIBfrtpuxq9o5WswpVaiuzFuDtX0k6VX1jUO18iGQTywbqJvc1j/+LWVcVSPpph4iqLlex
 g2ChmhcfssvU8oz73ynHaMgvVSHn0RaXYszYu2r5K9y/12iHjX2CvKAKrwa++bGxwNS4jBmgNUm
 Ii29K1PSK4fhDlUnxJxESqAHFWCZLneZgXHC1hWMlRLY3m/W5N2KvDEsoWfN0KUR26b3FQhiufI
 OiaI3ZpX
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68bca8e6 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=JfrnYn6hAAAA:8 a=QX4gbG5DAAAA:8 a=cojAzSgMqaLAs1qlVxgA:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: JK7eNYLkPq0siPPcLvrWj6bjP_MAFF__
X-Proofpoint-ORIG-GUID: JK7eNYLkPq0siPPcLvrWj6bjP_MAFF__
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-06_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

On Sat, Sep 06, 2025 at 10:42:22PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Sat, Sep 06, 2025 at 10:24:54PM +0300, Dmitry Baryshkov wrote:
> > On Thu, Sep 04, 2025 at 08:26:02PM +0200, Sebastian Reichel wrote:
> > > Currently the Rockchip USBDP PHY as a very simply port scheme: It just
> > > offers a single port, which is supposed to point towards the connector.
> > > Usually with 2 endpoints, one for the USB-C superspeed port and one for
> > > the USB-C SBU port.
> > > 
> > > This scheme is not good enough to properly handle DP AltMode, so add
> > > a new scheme, which has separate ports for everything. This has been
> > > modelled after the Qualcomm QMP USB4-USB3-DP PHY controller binding
> > > with a slight difference that there is an additional port for the
> > > USB-C SBU port as the Rockchip USB-DP PHY also contains the mux.
> > > 
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > ---
> > >  .../bindings/phy/phy-rockchip-usbdp.yaml           | 23 ++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> > > index 8b7059d5b1826fdec5170cf78d6e27f2bd6766bb..f728acf057e4046a4d254ee687af3451f17bcd01 100644
> > > --- a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> > > +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> > > @@ -114,6 +114,29 @@ properties:
> > >        A port node to link the PHY to a TypeC controller for the purpose of
> > >        handling orientation switching.
> > >  
> > > +  ports:
> > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > +    properties:
> > > +      port@0:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description:
> > > +          Output endpoint of the PHY for USB (or DP when configured into 4 lane
> > > +          mode), which should point to the superspeed port of a USB connector.
> > 
> > What abourt USB+DP mode, where each one gets 2 lanes?
> 
> Right, I guess we would need one port more and have one port for
> lane 0 + 1 and one port for 1 + 2. For USB-C both ports are
> connected to the USB-C superspeed port. For DP 4-lane mode the
> same is done for the input port of the connector. Last but not
> least for 2 lanes USB + 2 lanes DP, one port can be connected
> to the USB connector and one port can be connected to the DP
> connector.

Hmm. I'm not sure what do you mean here. Basically, it should be:

- Normal USB-C case with DP AltMode:
  + port@0 routed to connector's port@1 (through mux or retimer if any)
  + port@4 routed to connector's port@2 (through mux or retimer if any)

- Actual DP or mini-DP connector:
  + port@0 routed to connector's sole port (most likely direcrly)
  + port@4 most likely unconnected (at least for now, dp-connector
    doesn't have AUX lines described)

- Weird mode of having both USB-A or -C and actual DisplayPort
  + port@0 should get two endpoints, each having data-lines properties,
    one endpoint being connected to the USB port, another endpoint being
    connected to DP connector.
  + port@4 unconnected (yep, we should extend DP properties, maybe I'll
    send a patch)

I'd say, the first two options are the most important ones. Unless you
have actual hardware that uses the USB + separate DP, I'd say, we can
ignore that part.

> 
> > > +      port@1:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description: Incoming endpoint from the USB controller
> > > +
> > > +      port@2:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description: Incoming endpoint from the DisplayPort controller
> > > +
> > > +      port@3:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description:
> > > +          Output endpoint of the PHY for DP, which should either point to the
> > > +          SBU port of a USB-C connector or a DisplayPort connector input port.
> > 
> > I would suggest describing this port as 'DisplayPort AUX signals to be
> > connected to the SBU port of a USB-C connector (maybe through the
> > additinal mux, switch or retimer)'. It should not be confused with the
> > actual DisplayPort signals (as those go through the port@0).
> > 
> > In the Qualcomm world we currently do not describe this link from the
> > PHY to the gpio-mux or retimer, but I think we will have to do that
> > soon.
> 
> It does looks like no upstream platform does a proper description of
> USB-C setups :(
> 
> Thanks for having a look,
> 
> -- Sebastian



> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


-- 
With best wishes
Dmitry

